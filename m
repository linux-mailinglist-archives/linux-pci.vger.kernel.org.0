Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53365AD479
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2019 10:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbfIIINh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Sep 2019 04:13:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:56767 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388757AbfIIINh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Sep 2019 04:13:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x898DT4h013347;
        Mon, 9 Sep 2019 03:13:30 -0500
Message-ID: <d13c8d6b6bebba12331199200431fa407c5c1e1b.camel@kernel.crashing.org>
Subject: Re: [bug report] PCI: Protect pci_reassign_bridge_resources()
 against addition/removal
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pci@vger.kernel.org
Date:   Mon, 09 Sep 2019 09:13:28 +0100
In-Reply-To: <20190904100303.GD7007@mwanda>
References: <20190904100303.GD7007@mwanda>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-09-04 at 13:03 +0300, Dan Carpenter wrote:
> Hello Benjamin Herrenschmidt,
> 
> The patch 540f62d26f02: "PCI: Protect pci_reassign_bridge_resources()
> against addition/removal" from Jun 24, 2019, leads to the following
> static checker warning:
> 
> 	drivers/pci/setup-bus.c:2158 pci_reassign_bridge_resources()
> 	warn: inconsistent returns 'read_sem:&pci_bus_sem'.

Thanks, I missed that. I'll try to send something but from Plumbers
might be difficult...

Cheers
Ben.

> drivers/pci/setup-bus.c
>   2066          unsigned int i;
>   2067          int ret;
>   2068  
>   2069          down_read(&pci_bus_sem);
> 
> We added some new locking here.
> 
>   2070  
>   2071          /* Walk to the root hub, releasing bridge BARs when
> possible */
>   2072          next = bridge;
>   2073          do {
>   2074                  bridge = next;
>   2075                  for (i = PCI_BRIDGE_RESOURCES; i <
> PCI_BRIDGE_RESOURCE_END;
>   2076                       i++) {
>   2077                          struct resource *res = &bridge-
> >resource[i];
>   2078  
>   2079                          if ((res->flags ^ type) &
> PCI_RES_TYPE_MASK)
>   2080                                  continue;
>   2081  
>   2082                          /* Ignore BARs which are still in use
> */
>   2083                          if (res->child)
>   2084                                  continue;
>   2085  
>   2086                          ret = add_to_list(&saved, bridge,
> res, 0, 0);
>   2087                          if (ret)
>   2088                                  goto cleanup;
>   2089  
>   2090                          pci_info(bridge, "BAR %d: releasing
> %pR\n",
>   2091                                   i, res);
>   2092  
>   2093                          if (res->parent)
>   2094                                  release_resource(res);
>   2095                          res->start = 0;
>   2096                          res->end = 0;
>   2097                          break;
>   2098                  }
>   2099                  if (i == PCI_BRIDGE_RESOURCE_END)
>   2100                          break;
>   2101  
>   2102                  next = bridge->bus ? bridge->bus->self :
> NULL;
>   2103          } while (next);
>   2104  
>   2105          if (list_empty(&saved))
>   2106                  return -ENOENT;
> 
> This needs an unlock.  It's not clear to me if any other clean up is
> required, but possibly it's worth looking at.
> 
>   2107  
>   2108          __pci_bus_size_bridges(bridge->subordinate, &added);
>   2109          __pci_bridge_assign_resources(bridge, &added,
> &failed);
> 
> regards,
> dan carpenter

