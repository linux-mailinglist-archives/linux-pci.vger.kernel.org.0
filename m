Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F287C394778
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 21:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhE1TUs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 15:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhE1TUs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 15:20:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A4C6610CC;
        Fri, 28 May 2021 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622229553;
        bh=BZkQ/omNVva7HnRyViONIRUb6tia+mnHLlok7Rfi0bU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HIBeknZ9WLRmOsCgJdrkh9Lc8ELHEoOq1G/DNPJvdFd/QBbizcgwZWDsiR7QnXE46
         nT1KyWeLfXJYmQug5sVg2WOREvuAu0G7V/G5ilN8lwwlC/Xg9tgKyK0h+4QE467bOg
         ym7rnUGJd84lRgg8wg6AXZFs5wLKUAJskqnVTM48ljNZAr4a/XKFqC3sdVH54q5r/y
         muihllxsjIDtvNr2gioaheRwKaz52Es2kZZAgcy9S5XAaFopitOvxOY5W9NrFHMMaf
         P29bxl72gVBBl0TgFzZV05yrzSpnoSFxp3sRuvh61u0/CgvANsTk/jzKeUYLZAlF52
         NkK1LnTyEbOAg==
Date:   Fri, 28 May 2021 14:19:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, kernel test robot <lkp@intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add const type for comparison function parameter
Message-ID: <20210528191911.GA1513016@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528170242.1564038-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 29, 2021 at 01:02:42AM +0800, Kai-Heng Feng wrote:
> Commit 4f0f586bf0c8 ("treewide: Change list_sort to use const pointers")
> added const on parameter "struct list_head *".
> 
> So add const to match the type.
> 
> Fixes: 276b15de5287 ("PCI: Coalesce host bridge contiguous apertures")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Squashed into "PCI: Coalesce host bridge contiguous apertures",
thanks!

> ---
>  drivers/pci/probe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bf58e5dd1d82..bd862b612633 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -875,7 +875,8 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>  	dev_set_msi_domain(&bus->dev, d);
>  }
>  
> -static int res_cmp(void *priv, struct list_head *a, struct list_head *b)
> +static int res_cmp(void *priv, const struct list_head *a,
> +		   const struct list_head *b)
>  {
>  	struct resource_entry *entry1, *entry2;
>  
> -- 
> 2.31.1
> 
