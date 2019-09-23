Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B640BBE20
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2019 23:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390605AbfIWVu6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Sep 2019 17:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbfIWVu5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Sep 2019 17:50:57 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67BB1207FD;
        Mon, 23 Sep 2019 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569275456;
        bh=RfEazsydYXwieGVxuyWGcQk/WNwh9QBQW6FctAKAHGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTmj9KuXjQp9ifrZEJQRm+yqZveUAJ7VTxyaQM+IEno2qtnoXlZbS7lAwkptjuhud
         LZwGp7aunZcmCJ2velrj+wCiMU/pjbzsYfu4ZZSuErqaw352qOFbObszbozCsAkUe4
         apPTT3MAmzA+zIuwlhzyRogWTP/bG117SZWMr0SU=
Date:   Mon, 23 Sep 2019 16:50:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: Protect pci_reassign_bridge_resources()
 against addition/removal
Message-ID: <20190923215055.GB11938@google.com>
References: <20190904100303.GD7007@mwanda>
 <d13c8d6b6bebba12331199200431fa407c5c1e1b.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d13c8d6b6bebba12331199200431fa407c5c1e1b.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 09, 2019 at 09:13:28AM +0100, Benjamin Herrenschmidt wrote:
> On Wed, 2019-09-04 at 13:03 +0300, Dan Carpenter wrote:
> > Hello Benjamin Herrenschmidt,
> > 
> > The patch 540f62d26f02: "PCI: Protect pci_reassign_bridge_resources()
> > against addition/removal" from Jun 24, 2019, leads to the following
> > static checker warning:
> > 
> > 	drivers/pci/setup-bus.c:2158 pci_reassign_bridge_resources()
> > 	warn: inconsistent returns 'read_sem:&pci_bus_sem'.
> 
> Thanks, I missed that. I'll try to send something but from Plumbers
> might be difficult...

I dropped this for now.

> > drivers/pci/setup-bus.c
> >   2066          unsigned int i;
> >   2067          int ret;
> >   2068  
> >   2069          down_read(&pci_bus_sem);
> > 
> > We added some new locking here.
> > 
> >   2070  
> >   2071          /* Walk to the root hub, releasing bridge BARs when
> > possible */
> >   2072          next = bridge;
> >   2073          do {
> >   2074                  bridge = next;
> >   2075                  for (i = PCI_BRIDGE_RESOURCES; i <
> > PCI_BRIDGE_RESOURCE_END;
> >   2076                       i++) {
> >   2077                          struct resource *res = &bridge-
> > >resource[i];
> >   2078  
> >   2079                          if ((res->flags ^ type) &
> > PCI_RES_TYPE_MASK)
> >   2080                                  continue;
> >   2081  
> >   2082                          /* Ignore BARs which are still in use
> > */
> >   2083                          if (res->child)
> >   2084                                  continue;
> >   2085  
> >   2086                          ret = add_to_list(&saved, bridge,
> > res, 0, 0);
> >   2087                          if (ret)
> >   2088                                  goto cleanup;
> >   2089  
> >   2090                          pci_info(bridge, "BAR %d: releasing
> > %pR\n",
> >   2091                                   i, res);
> >   2092  
> >   2093                          if (res->parent)
> >   2094                                  release_resource(res);
> >   2095                          res->start = 0;
> >   2096                          res->end = 0;
> >   2097                          break;
> >   2098                  }
> >   2099                  if (i == PCI_BRIDGE_RESOURCE_END)
> >   2100                          break;
> >   2101  
> >   2102                  next = bridge->bus ? bridge->bus->self :
> > NULL;
> >   2103          } while (next);
> >   2104  
> >   2105          if (list_empty(&saved))
> >   2106                  return -ENOENT;
> > 
> > This needs an unlock.  It's not clear to me if any other clean up is
> > required, but possibly it's worth looking at.
> > 
> >   2107  
> >   2108          __pci_bus_size_bridges(bridge->subordinate, &added);
> >   2109          __pci_bridge_assign_resources(bridge, &added,
> > &failed);
> > 
> > regards,
> > dan carpenter
> 
