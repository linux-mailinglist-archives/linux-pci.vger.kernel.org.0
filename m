Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB121BF04
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 23:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgGJVJ1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 17:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgGJVJ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 17:09:27 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D5520748;
        Fri, 10 Jul 2020 21:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594415366;
        bh=3G98qnEaA/R516BEiJIDzuUxC5EndF3JHX2eXGymybA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=z0+GTNPn0bhj5UyUdVoFvb7htf9qSPKOOnb3HqyG7uLdhnEOEAVcdTA5nmrLV06Pj
         4/X3u/LMZbHP/M28Qj5MvEfjixgagHB6RamRQ6TewsNBpCVVJnvtV1S1mOarCv5qg4
         aQOwuzESUBqh550N2mDLnLbjHtnjT5zdY0BbOCb8=
Date:   Fri, 10 Jul 2020 16:09:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI: Disable not requested resource types in pci_enable_resources
Message-ID: <20200710210924.GA80868@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18bb3264-9901-135d-8b40-1ee98dd672f1@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 28, 2020 at 08:47:12PM +0200, Heiner Kallweit wrote:
> Currently, if both resource types are enabled before the call, the mask
> value doesn't matter. Means as of today I wouldn't be able to e.g.
> disable PCI_COMMAND_IO. At least my interpretation is that mask defines
> which resource types are enabled after the call. Therefore change the
> behavior to disable not requested resource types.
> 
> At least on my x86 devices this change doesn't have side effects.

Does this have a practical benefit?  If it fixes a bug or if there's
something useful we can do because of this patch, I'll push it higher
up the priority list.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/setup-res.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index d21fa04fa..6ef458c10 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -459,8 +459,8 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
>  	int i;
>  	struct resource *r;
>  
> -	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -	old_cmd = cmd;
> +	pci_read_config_word(dev, PCI_COMMAND, &old_cmd);
> +	cmd = old_cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
>  
>  	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>  		if (!(mask & (1 << i)))
> -- 
> 2.26.2
> 
