Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6BA094FD5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 23:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfHSVXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 17:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbfHSVXU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 17:23:20 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2C9922CE8;
        Mon, 19 Aug 2019 21:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566249799;
        bh=3Wg6NFHKKpBSbK1JQfpV0Z+KzBTBs501plCy+K3XQBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFM/RQBD3NheayW2hoVztJW9PKN5YydTgSEs0J4apIjMwxmAFdhpMSDDx84SYHHeN
         LCAEWiDHsWe8huixtSjEhqxlohwG5CiqRnmRJ4DCCf2iIzXYkytT6UhlSOlfuQ4ioH
         6n84pUKllbGMl0XFxx5cXRd8T4j2FsRxFMuBlQ3M=
Date:   Mon, 19 Aug 2019 16:23:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / PCI: fix a memory leak bug
Message-ID: <20190819212317.GU253360@google.com>
References: <1565930002-5524-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565930002-5524-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The subject line should give a clue about where the leak is, e.g.,

  ACPI / PCI: fix acpi_pci_irq_enable() memory leak

On Thu, Aug 15, 2019 at 11:33:22PM -0500, Wenwen Wang wrote:
> In acpi_pci_irq_enable(), 'entry' is allocated by invoking
> acpi_pci_irq_lookup(). However, it is not deallocated if
> acpi_pci_irq_valid() returns false, leading to a memory leak. To fix this
> issue, free 'entry' before returning 0.

I think the corresponding kzalloc() is the one in
acpi_pci_irq_check_entry().

> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/acpi/pci_irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index d2549ae..dea8a60 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -449,8 +449,10 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>  		 * No IRQ known to the ACPI subsystem - maybe the BIOS /
>  		 * driver reported one, then use it. Exit in any case.
>  		 */
> -		if (!acpi_pci_irq_valid(dev, pin))
> +		if (!acpi_pci_irq_valid(dev, pin)) {
> +			kfree(entry);
>  			return 0;
> +		}

Looks like we missed this when e237a5518425 ("x86/ACPI/PCI: Recognize
that Interrupt Line 255 means "not connected"") was merged.

You could add:

Fixes: e237a5518425 ("x86/ACPI/PCI: Recognize that Interrupt Line 255 means "not connected"")

>  		if (acpi_isa_register_gsi(dev))
>  			dev_warn(&dev->dev, "PCI INT %c: no GSI\n",
> -- 
> 2.7.4
> 
