Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91847151F
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 18:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhLKRyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 12:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhLKRyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Dec 2021 12:54:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0770C061714;
        Sat, 11 Dec 2021 09:54:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64C71B80B3A;
        Sat, 11 Dec 2021 17:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49D5C004DD;
        Sat, 11 Dec 2021 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639245292;
        bh=Jo5vuURk4kAxgHfUfbWfY4wl1/saPxtBexHyy82NpVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i5MBNOa7UbMhaF8Qi1kXozP9kU+uRRnv8rt5PGCSwloZN+Hq+sGPClErbZ02FmHQz
         FZqg0HfwnxjaYSpBTuvuKodKN86pHyZRcv0fTf7EaBYbc7hzj36ozg3PAguJWJCa0c
         VwZnPCExI2LewKGyuDW+sOqh2fH0kkZKTRJ7idKUMI/QOzhOh1/dqjHdBJOgvikrwY
         KUOzLpel2aBXN/K0XJ/5tgiwOikXuteZidjxfLjIxJi1BQulM+Xv8ii6ARNgqM2YVG
         hbBNhQax507aYsOaniPlWMPmd+TtMTOZLfJ4LCJ8XIZleu1Lq/4205NLz1IjYTk+nd
         Kihn5fOrnHkZQ==
Date:   Sat, 11 Dec 2021 11:54:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] PCI/AER: potential dereference of null pointer
Message-ID: <20211211175450.GA398271@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209094556.2085357-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rajat, author of aer_stats:
db89ccbe52c7 ("PCI/AER: Define aer_stats structure for AER capable devices"
81aa5206f9a7 ("PCI/AER: Add sysfs attributes to provide AER stats and breakdown"]

On Thu, Dec 09, 2021 at 05:45:56PM +0800, Jiasheng Jiang wrote:
> he return value of kzalloc() needs to be checked.
> To avoid use of null pointer in case of the failure of alloc.
> 
> Fixes: db89ccbe52c7 ("PCI/AER: Define aer_stats structure for AER capable devices")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/pci/pcie/aer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ec943cee5ecc..d04303edf468 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -376,6 +376,8 @@ void pci_aer_init(struct pci_dev *dev)
>  		return;
>  
>  	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
> +	if (!dev->aer_stats)
> +		return;

Did you actually trip over a null pointer dereference, and if so,
where was it?

I think the intent here was that aer_stats is a non-essential feature,
and if we can't allocate space to keep the statistics, we can still
use the device without the stats.

I *think* all the users of dev->aer_stats check for NULL before
dereferencing it, but if you found a case that doesn't do that, we
should definitely fix it.

In a few cases (aer_stats_dev_attr, aer_stats_rootport_attr), the
check isn't obvious -- it happens in aer_stats_attrs_are_visible().
If aer_stats_attrs_are_visible() finds that aer_stats is NULL, those
sysfs attributes should not be visible, and the corresponding *_show()
functions should never be called.

>  	/*
>  	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
> -- 
> 2.25.1
> 
