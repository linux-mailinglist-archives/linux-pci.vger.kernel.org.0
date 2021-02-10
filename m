Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9237E3173DB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 00:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhBJXCj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 18:02:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232957AbhBJXCi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 18:02:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E621D60238;
        Wed, 10 Feb 2021 23:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612998118;
        bh=WAT9Vc+3BbSFER4EVAMITw3yy65wafkgWsT3nhGg3qo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lmE0JdNXrA4Ai52xi1Nv3YU9y6zdlm3Nm4oCnURoWOSubmOsJe8KdkMMxvGbwPGS+
         5jqAcEajPu43OSWDcVObntrxdSeYhfND3glTV6Nss8h1JqRpWIqOURCAEPQ0jQ2A37
         ws0x8GQzDjq/YUcZt2aPKqezAgP8mwcccbokeyAUuusq++BqSRmTbNS0BqmO/VCLN7
         arKnus/HA8dPXCU1YauXFBFqp08Jr11I9rIC2uZKz2rnfdvb4DVQZZRI6AsXW2Ox/H
         lYj/FYrj+fqxcW+NF/ZtlVzPcIov5Mm8ZNLYtA7SKEZ7zAwNG1zBUqhLOSffE326Pa
         53uv6mPYZsdyA==
Date:   Wed, 10 Feb 2021 17:01:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PCI: Remove WARN_ON(in_interrupt()).
Message-ID: <20210210230156.GA617538@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208194400.384003-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 08, 2021 at 08:44:00PM +0100, Sebastian Andrzej Siewior wrote:
> WARN_ON(in_interrupt()) is used for historic reasons to ensure proper
> usage of down_read() and predates might_sleep() and lockdep.
> 
> down_read() has might_sleep() which also catches users from preemption
> disabled regions while in_interrupt() does not.
> 
> Remove WARN_ON(in_interrupt()) because there is better debugging
> facility.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to pci/misc for v5.12, thanks!

> ---
>  drivers/pci/search.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 2061672954ee3..b4c138a6ec025 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -168,7 +168,6 @@ struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
>  	struct list_head *n;
>  	struct pci_bus *b = NULL;
>  
> -	WARN_ON(in_interrupt());
>  	down_read(&pci_bus_sem);
>  	n = from ? from->node.next : pci_root_buses.next;
>  	if (n != &pci_root_buses)
> @@ -196,7 +195,6 @@ struct pci_dev *pci_get_slot(struct pci_bus *bus, unsigned int devfn)
>  {
>  	struct pci_dev *dev;
>  
> -	WARN_ON(in_interrupt());
>  	down_read(&pci_bus_sem);
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> @@ -274,7 +272,6 @@ static struct pci_dev *pci_get_dev_by_id(const struct pci_device_id *id,
>  	struct device *dev_start = NULL;
>  	struct pci_dev *pdev = NULL;
>  
> -	WARN_ON(in_interrupt());
>  	if (from)
>  		dev_start = &from->dev;
>  	dev = bus_find_device(&pci_bus_type, dev_start, (void *)id,
> @@ -381,7 +378,6 @@ int pci_dev_present(const struct pci_device_id *ids)
>  {
>  	struct pci_dev *found = NULL;
>  
> -	WARN_ON(in_interrupt());
>  	while (ids->vendor || ids->subvendor || ids->class_mask) {
>  		found = pci_get_dev_by_id(ids, NULL);
>  		if (found) {
> -- 
> 2.30.0
> 
