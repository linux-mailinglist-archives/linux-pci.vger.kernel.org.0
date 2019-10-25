Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637E5E4B88
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 14:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504490AbfJYMvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 08:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501908AbfJYMvv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Oct 2019 08:51:51 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B01C21929;
        Fri, 25 Oct 2019 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572007910;
        bh=DkytY8BjiI5AuxDb93s0p3G3TrO2dW16u+ibmJS95to=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cKqUEzicNGW8uGkWlTJhD41jYzBXgSndhzFJO8s5hVkCjJH+p7csxTgoldhgESkto
         CwPvmDbaBr4i0FPA0CFbbXfDjWoq0mwEbZgB1Vmsm5/dJlJhO2m9xfEWQ36PTg7Ux7
         KjYUsQo19Momi8Pg+L06D68WwnGiK9E7T/vcGaBw=
Date:   Fri, 25 Oct 2019 07:51:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@kernel.org,
        peterz@infradead.org, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, paul.burton@mips.com
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
Message-ID: <20191025125147.GA124662@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a33e01bd-3054-a2c4-c206-f893e7373e65@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 24, 2019 at 11:16:41AM +0100, Robin Murphy wrote:
> On 2019-10-23 6:10 pm, Bjorn Helgaas wrote:

> >      PCI: Warn if no host bridge NUMA node info
> >      In pci_call_probe(), we try to run driver probe functions on the node where
> >      the device is attached.  If we don't know which node the device is attached
> >      to, the driver will likely run on the wrong node.  This will still work,
> >      but performance will not be as good as it could be.
> 
> Is it guaranteed to be purely a performance issue? In other words, is there
> definitely no way a physical node could be disabled via idle/hotplug/etc.
> such that unattributed devices can silently disappear while still in use?

I think so.  At least, if it's more than a performance issue, I have
no idea what sort of problem might happen or how to deal with it.

> > @@ -897,6 +897,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >   	else
> >   		pr_info("PCI host bridge to bus %s\n", name);
> > +	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
> > +		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
> 
> I think this still deserves the FW_BUG prefix.

Putting the warning here in pci_register_host_bridge() is convenient
for now but doesn't seem like the ideal place.

I'd rather have the warning at the point where we get the node number,
e.g., in pci_acpi_root_get_node() or of_node_to_nid(), where we would
know what's actually required by spec and we could point to the
specific ACPI device or DT device node that's broken.  Then I think
we'd have a better case for using FW_BUG.

I'm a little hesitant to use FW_BUG here in pci_register_host_bridge()
because we don't know where the node number was supposed to come from,
so we can't reliably determine that the lack of one is a bug.

Bjorn
