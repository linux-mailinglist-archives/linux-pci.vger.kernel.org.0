Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6332622A2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 00:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIHW2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 18:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgIHW2g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 18:28:36 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667282067C;
        Tue,  8 Sep 2020 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599604115;
        bh=OWTZzwKbuN+Q8smRxJY5Lw0FfgwqauJp+tl8QCciMlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IXf8Pa749+DmukeWbknmY9tb9FX6uOS6PK8b6H1MTdVaYUIOA3l6NcgbtvxG0/pA6
         HyxX5TOiH0zmAMbC72Y7H9KwEe77Agiwd6mTbLne0o7z8oPqatUX1eKjVxdBy9gHaY
         R1F/lOlq0s1a90+A/XirnHM9rFEDprftdwnS2M1s=
Date:   Tue, 8 Sep 2020 17:28:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, bhelgaas@google.com,
        ulf.hansson@linaro.org, rui_feng@realsil.com.cn,
        linux-kernel@vger.kernel.org, puranjay12@gmail.com,
        linux-pci@vger.kernel.org, vailbhavgupta40@gamail.com
Subject: Re: [PATCH v5 2/2] misc: rtsx: Add power saving functions and fix
 driving parameter
Message-ID: <20200908222834.GA646416@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907100731.7722-1-ricky_wu@realtek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 06:07:31PM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> v4:
> split power down flow and power saving function to two patch
> 
> v5:
> fix up modified change under the --- line

Hehe, this came out *above* the "---" line :)

> Add rts522a L1 sub-state support
> Save more power on rts5227 rts5249 rts525a rts5260
> Fix rts5260 driving parameter
> 
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rts5227.c  | 112 +++++++++++++++++++++-
>  drivers/misc/cardreader/rts5249.c  | 145 ++++++++++++++++++++++++++++-
>  drivers/misc/cardreader/rts5260.c  |  28 +++---
>  drivers/misc/cardreader/rtsx_pcr.h |  17 ++++
>  4 files changed, 283 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
> index 747391e3fb5d..8859011672cb 100644
> --- a/drivers/misc/cardreader/rts5227.c
> +++ b/drivers/misc/cardreader/rts5227.c
> @@ -72,15 +72,80 @@ static void rts5227_fetch_vendor_settings(struct rtsx_pcr *pcr)
>  
>  	pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
>  	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
> +	if (rtsx_check_mmc_support(reg))
> +		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
>  	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
>  	if (rtsx_reg_check_reverse_socket(reg))
>  		pcr->flags |= PCR_REVERSE_SOCKET;
>  }
>  
> +static void rts5227_init_from_cfg(struct rtsx_pcr *pcr)
> +{
> +	struct pci_dev *pdev = pcr->pci;
> +	int l1ss;
> +	u32 lval;
> +	struct rtsx_cr_option *option = &pcr->option;
> +
> +	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
> +	if (!l1ss)
> +		return;
> +
> +	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);

This looks a little problematic.  PCI_L1SS_CTL1 is an architected
register in the ASPM L1 PM Substates capability, and its value may
change at runtime because drivers/pci/pcie/aspm.c manages it.

It looks like the code below does device-specific configuration based
on the current PCI_L1SS_CTL1 value.  But what happens if aspm.c
changes PCI_L1SS_CTL1 later?

> +	if (CHK_PCI_PID(pcr, 0x522A)) {
> +		if (0 == (lval & 0x0F))
> +			rtsx_pci_enable_oobs_polling(pcr);
> +		else
> +			rtsx_pci_disable_oobs_polling(pcr);
> +	}
> +
> +	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
> +		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
> +	else
> +		rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
> +
> +	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
> +		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
> +	else
> +		rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
> +
> +	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
> +		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
> +	else
> +		rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
> +
> +	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
> +		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
> +	else
> +		rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
> +
> +	if (option->ltr_en) {
> +		u16 val;
> +
> +		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);

Same thing here.  I don't think the PCI core currently changes
PCI_EXP_DEVCTL2 after boot, but it's not a good idea to assume it's
going to be constant.

> +		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
> +			option->ltr_enabled = true;
> +			option->ltr_active = true;
> +			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
> +		} else {
> +			option->ltr_enabled = false;
> +		}
> +	}
> +
> +	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
> +				| PM_L1_1_EN | PM_L1_2_EN))
> +		option->force_clkreq_0 = false;
> +	else
> +		option->force_clkreq_0 = true;
> +
> +}
