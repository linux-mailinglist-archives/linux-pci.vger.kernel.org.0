Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E15258DDD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Sep 2020 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgIAMFr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Sep 2020 08:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgIAMFk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Sep 2020 08:05:40 -0400
Received: from localhost (113.sub-72-107-119.myvzw.com [72.107.119.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66E2206EF;
        Tue,  1 Sep 2020 12:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598961939;
        bh=hpiRDxFNSuM140rNlx/hew3AIlo+RXir/ERfGQDQ+Bs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NtXgRJnc+wleApvL9doGAxoVqA9sJX9LhMqlxI7jxEIOACWgPpVQAoBIJV7+wZwjL
         BC9a8N8z3YxIyHVzQCjbMoq5nZRo5DcuU5ZyRJ+Qc/FxaqUNu64p9nI66RvUErxOVO
         s2SCYGvyYjdX6Jo/bK0ruGPEp7WxhAoAYNEkZTnQ=
Date:   Tue, 1 Sep 2020 07:05:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, ulf.hansson@linaro.org,
        bhelgaas@google.com, rui_feng@realsil.com.cn,
        vailbhavgupta40@gamail.com, linux-pci@vger.kernel.org,
        puranjay12@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] misc: rtsx: add power saving function and bios guide
 options
Message-ID: <20200901120536.GA151590@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901095118.4949-1-ricky_wu@realtek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 01, 2020 at 05:51:18PM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> v2 v3:
> fixed build WARNING
> 
> v1:
> Added rts5227 rts5249 rts5260 rts5228 power saving functions,
> added BIOS guide MMC funciton and U_d3_en register support and
> fixed rts5260 driving parameter
> 
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

I'm attaching the same response I sent you yesterday, since it doesn't
look like you read any of it (except adding to the cc list).

From helgaas@kernel.org Mon Aug 31 16:21:53 2020
Date: Mon, 31 Aug 2020 16:21:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ricky Wu <ricky_wu@realtek.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, ricky_wu@realtek.com,
	ulf.hansson@linaro.org, bhelgaas@google.com,
	rui_feng@realsil.com.cn, Puranjay Mohan <puranjay12@gmail.com>,
	Vaibhav Gupta <vaibhavgupta40@gmail.com>
Subject: Re: Fwd: [PATCH] misc: rtsx: add power saving function and bios
 guide options
Message-ID: <20200831212151.GA92532@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAErSpo5io2bh6Q56bHBo=jH=22mib-nJ9a2PaeZPpXpfC=5Ytw@mail.gmail.com>
Status: RO
Content-Length: 24763
Lines: 641

[+cc Puranjay, Vaibhav]

I think you forgot to cc the mailing lists.  Looks like
linux-kernel@vger.kernel.org is the only one
"scripts/get_maintainer.pl -f drivers/misc/cardreader/rts*"
suggests.

I would add linux-pci@vger.kernel.org because this also adds some
ASPM-related stuff that we would like to support better in the PCI
core to reduce the amount of this code in the driver.

Also cc: Puranjay Mohan <puranjay12@gmail.com>, who is working on LTR
in the PCI core, and Vaibhav Gupta <vaibhavgupta40@gmail.com>, who is
working on PCI legacy suspend/resume.

> From: <ricky_wu@realtek.com>
> Date: Mon, Aug 31, 2020 at 3:24 AM
> Subject: [PATCH] misc: rtsx: add power saving function and bios guide
> options
> To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <ricky_wu@realtek.com>, <
> ulf.hansson@linaro.org>, <bhelgaas@google.com>, <rui_feng@realsil.com.cn>
> 
> 
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> Added rts5227 rts5249 rts5260 rts5228 power saving functions,
> added BIOS guide MMC funciton and U_d3_en register support and
> fixed rts5260 driving parameter

This should be split into small logical pieces.  I can't really tell
what those would be, but just based on the commit message, it could
be:

  1) Add rts5227 rts5249 rts5260 rts5228 power saving functions

  2) Add BIOS guide MMC function and U_d3_en register support

  3) Fix rts5260 driving parameter

s/funciton/function/

It looks like 1) *might* be just this:

  rts*_force_power_down()
  {
    ...
    rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, D3_DELINK_MODE_EN,
			    D3_DELINK_MODE_EN);

That should be a single patch by itself so it's obvious that it's
doing the same thing to several drivers.

Explain what "BIOS guide MMC function" means.  Mention the name of the
function this adds so we can connect the patch with the commit log.

Explain what "U_d3_en" is; that doesn't even appear in the patch.

More comments below, including what looks like a real bug.

Bjorn

> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rts5227.c  | 115 +++++++++++++++++++++-
>  drivers/misc/cardreader/rts5228.c  |   5 +-
>  drivers/misc/cardreader/rts5249.c  | 147 ++++++++++++++++++++++++++++-
>  drivers/misc/cardreader/rts5260.c  |  33 ++++---
>  drivers/misc/cardreader/rtsx_pcr.h |  18 ++++
>  5 files changed, 289 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rts5227.c
> b/drivers/misc/cardreader/rts5227.c
> index f5f392ddf3d6..314037eff17d 100644
> --- a/drivers/misc/cardreader/rts5227.c
> +++ b/drivers/misc/cardreader/rts5227.c
> @@ -72,6 +72,8 @@ static void rts5227_fetch_vendor_settings(struct rtsx_pcr
> *pcr)
> 
>         pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
>         pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
> +       if (rtsx_check_mmc_support(reg))
> +               pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
>         pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
>         if (rtsx_reg_check_reverse_socket(reg))
>                 pcr->flags |= PCR_REVERSE_SOCKET;
> @@ -84,16 +86,78 @@ static void rts5227_force_power_down(struct rtsx_pcr
> *pcr, u8 pm_state)
>         rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, 0xFF, 0);
>         rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3, 0x01, 0);
> 
> -       if (pm_state == HOST_ENTER_S3)
> -               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x10);
> +       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x10);

Why doesn't this use D3_DELINK_MODE_EN, like 5228, 5249, 5260 do?

Why did you not make a similar change to rts5261_force_power_down(),
which also contains this code?

  if (pm_state == HOST_ENTER_S3)
    rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, D3_DELINK_MODE_EN,
			    D3_DELINK_MODE_EN);

>         rtsx_pci_write_register(pcr, FPDCTL, 0x03, 0x03);
>  }
> 
> +static void rts5227_init_from_cfg(struct rtsx_pcr *pcr)
> +{
> +       struct pci_dev *pdev = pcr->pci;
> +       int l1ss;
> +       u32 lval;
> +       struct rtsx_cr_option *option = &pcr->option;
> +
> +       l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
> +       if (!l1ss)
> +               return;
> +
> +       pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
> +
> +       if (CHK_PCI_PID(pcr, 0x522A)) {
> +               if (0 == (lval & 0x0F))

Should use PCI_L1SS_CTL1_L1SS_MASK, I think.

I would write this as:

  if (lval & PCI_L1SS_CTL1_L1SS_MASK)
    rtsx_pci_disable_oobs_polling(pcr);
  else
    rtsx_pci_enable_oobs_polling(pcr);

> +                       rtsx_pci_enable_oobs_polling(pcr);
> +               else
> +                       rtsx_pci_disable_oobs_polling(pcr);
> +       }
> +
> +       if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
> +               rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
> +       else
> +               rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
> +
> +       if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
> +               rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
> +       else
> +               rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
> +
> +       if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
> +               rtsx_set_dev_flag(pcr, PM_L1_1_EN);
> +       else
> +               rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
> +
> +       if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
> +               rtsx_set_dev_flag(pcr, PM_L1_2_EN);
> +       else
> +               rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
> +
> +       if (option->ltr_en) {
> +               u16 val;
> +
> +               pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
> +               if (val & PCI_EXP_DEVCTL2_LTR_EN) {
> +                       option->ltr_enabled = true;
> +                       option->ltr_active = true;
> +                       rtsx_set_ltr_latency(pcr,
> option->ltr_active_latency);
> +               } else {
> +                       option->ltr_enabled = false;
> +               }
> +       }
> +
> +       if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
> +                               | PM_L1_1_EN | PM_L1_2_EN))
> +               option->force_clkreq_0 = false;
> +       else
> +               option->force_clkreq_0 = true;
> +
> +}
> +
>  static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
>  {
>         u16 cap;
> +       struct rtsx_cr_option *option = &pcr->option;
> 
> +       rts5227_init_from_cfg(pcr);
>         rtsx_pci_init_cmd(pcr);
> 
>         /* Configure GPIO as output */
> @@ -115,9 +179,17 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
>         rts5227_fill_driving(pcr, OUTPUT_3V3);
>         /* Configure force_clock_req */
>         if (pcr->flags & PCR_REVERSE_SOCKET)
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0xB8, 0xB8);
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x30);
>         else
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0xB8, 0x88);
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x00);
> +
> +       if (option->force_clkreq_0)
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
> +                               FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
> +       else
> +               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
> +                               FORCE_CLKREQ_DELINK_MASK,
> FORCE_CLKREQ_HIGH);
> +
>         rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, pcr->reg_pm_ctrl3, 0x10, 0x00);
> 
>         return rtsx_pci_send_cmd(pcr, 100);
> @@ -373,6 +445,27 @@ static int rts522a_switch_output_voltage(struct
> rtsx_pcr *pcr, u8 voltage)
>         return rtsx_pci_send_cmd(pcr, 100);
>  }
> 
> +static void rts522a_set_l1off_cfg_sub_d0(struct rtsx_pcr *pcr, int active)
> +{
> +       struct rtsx_cr_option *option = &pcr->option;
> +       int aspm_L1_1, aspm_L1_2;
> +       u8 val = 0;
> +
> +       aspm_L1_1 = rtsx_check_dev_flag(pcr, ASPM_L1_1_EN);
> +       aspm_L1_2 = rtsx_check_dev_flag(pcr, ASPM_L1_2_EN);
> +
> +       if (active) {
> +               /* run, latency: 60us */
> +               if (aspm_L1_1)
> +                       val = option->ltr_l1off_snooze_sspwrgate;
> +       } else {
> +               /* l1off, latency: 300us */
> +               if (aspm_L1_2)
> +                       val = option->ltr_l1off_sspwrgate;
> +       }
> +
> +       rtsx_set_l1off_sub(pcr, val);
> +}
> 
>  /* rts522a operations mainly derived from rts5227, except phy/hw init
> setting.
>   */
> @@ -390,15 +483,29 @@ static const struct pcr_ops rts522a_pcr_ops = {
>         .cd_deglitch = NULL,
>         .conv_clk_and_div_n = NULL,
>         .force_power_down = rts5227_force_power_down,
> +       .set_l1off_cfg_sub_d0 = rts522a_set_l1off_cfg_sub_d0,
>  };
> 
>  void rts522a_init_params(struct rtsx_pcr *pcr)
>  {
> +       struct rtsx_cr_option *option = &pcr->option;
> +
>         rts5227_init_params(pcr);
>         pcr->ops = &rts522a_pcr_ops;
>         pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 20, 11);
>         pcr->reg_pm_ctrl3 = RTS522A_PM_CTRL3;
> 
> +       option->dev_flags = LTR_L1SS_PWR_GATE_EN;
> +       option->ltr_en = true;
> +
> +       /* init latency of active, idle, L1OFF to 60us, 300us, 3ms */
> +       option->ltr_active_latency = LTR_ACTIVE_LATENCY_DEF;
> +       option->ltr_idle_latency = LTR_IDLE_LATENCY_DEF;
> +       option->ltr_l1off_latency = LTR_L1OFF_LATENCY_DEF;
> +       option->l1_snooze_delay = L1_SNOOZE_DELAY_DEF;
> +       option->ltr_l1off_sspwrgate = 0x7F;
> +       option->ltr_l1off_snooze_sspwrgate = 0x78;
> +
>         pcr->option.ocp_en = 1;
>         if (pcr->option.ocp_en)
>                 pcr->hw_param.interrupt_en |= SD_OC_INT_EN;
> diff --git a/drivers/misc/cardreader/rts5228.c
> b/drivers/misc/cardreader/rts5228.c
> index 28feab1449ab..781a86def59a 100644
> --- a/drivers/misc/cardreader/rts5228.c
> +++ b/drivers/misc/cardreader/rts5228.c
> @@ -99,9 +99,8 @@ static void rts5228_force_power_down(struct rtsx_pcr
> *pcr, u8 pm_state)
>         rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
>                                 RELINK_TIME_MASK, 0);
> 
> -       if (pm_state == HOST_ENTER_S3)
> -               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> -                                       D3_DELINK_MODE_EN,
> D3_DELINK_MODE_EN);
> +       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> +                       D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
> 
>         rtsx_pci_write_register(pcr, FPDCTL,
>                 SSC_POWER_DOWN, SSC_POWER_DOWN);
> diff --git a/drivers/misc/cardreader/rts5249.c
> b/drivers/misc/cardreader/rts5249.c
> index 941b3d77f1e9..2659415c175f 100644
> --- a/drivers/misc/cardreader/rts5249.c
> +++ b/drivers/misc/cardreader/rts5249.c
> @@ -73,6 +73,8 @@ static void rtsx_base_fetch_vendor_settings(struct
> rtsx_pcr *pcr)
> 
>         pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
>         pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
> +       if (rtsx_check_mmc_support(reg))
> +               pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
>         pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
>         if (rtsx_reg_check_reverse_socket(reg))
>                 pcr->flags |= PCR_REVERSE_SOCKET;
> @@ -85,8 +87,7 @@ static void rtsx_base_force_power_down(struct rtsx_pcr
> *pcr, u8 pm_state)
>         rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, 0xFF, 0);
>         rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3, 0x01, 0);
> 
> -       if (pm_state == HOST_ENTER_S3)
> -               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> +       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
>                         D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
> 
>         rtsx_pci_write_register(pcr, FPDCTL, 0x03, 0x03);
> @@ -105,6 +106,13 @@ static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
> 
>         pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
> 
> +       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
> +               if (0 == (lval & 0x0F))
> +                       rtsx_pci_enable_oobs_polling(pcr);
> +               else
> +                       rtsx_pci_disable_oobs_polling(pcr);
> +       }
> +
>         if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
>                 rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
> 
> @@ -144,6 +152,113 @@ static int rts5249_init_from_hw(struct rtsx_pcr *pcr)
>         return 0;
>  }
> 
> +static void rts52xa_save_content_from_efuse(struct rtsx_pcr *pcr)
> +{
> +       u8 cnt, sv, cv;
> +       u8 j = 0;

Unnecessary initialization.  u8 is too small to hold 1024 (the loop
limit).  Did you test this?

> +       u8 tmp;
> +       u8 val;
> +       int i;
> +
> +       rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL,
> +                               REG_EFUSE_BYPASS | REG_EFUSE_POR,
> REG_EFUSE_POR);
> +       udelay(1);
> +
> +       pcr_dbg(pcr, "Enable efuse por!");
> +       pcr_dbg(pcr, "save efuse to autoload");
> +
> +       rtsx_pci_write_register(pcr, RTS525A_EFUSE_ADD, REG_EFUSE_ADD_MASK,
> 0x00);
> +       rtsx_pci_write_register(pcr, RTS525A_EFUSE_CTL,
> +                               REG_EFUSE_ENABLE | REG_EFUSE_MODE,
> REG_EFUSE_ENABLE);
> +       /* Wait transfer end */
> +       for (j = 0; j < 1024; j++) {
> +               rtsx_pci_read_register(pcr, RTS525A_EFUSE_CTL, &tmp);
> +               if ((tmp & 0x80) == 0)
> +                       break;
> +       }
> +       rtsx_pci_read_register(pcr, RTS525A_EFUSE_DATA, &val);
> +       cnt = val & 0x0F;
> +       sv = val & 0x10;
> +       cv = val & 0x20;

"cv" is unused; just remove it.

> +       if (sv) {
> +               for (i = 0; i < 4; i++) {
> +                       rtsx_pci_write_register(pcr, RTS525A_EFUSE_ADD,
> +                               REG_EFUSE_ADD_MASK, 0x04 + i);
> +                       rtsx_pci_write_register(pcr, RTS525A_EFUSE_CTL,
> +                               REG_EFUSE_ENABLE | REG_EFUSE_MODE,
> REG_EFUSE_ENABLE);
> +                       /* Wait transfer end */
> +                       for (j = 0; j < 1024; j++) {
> +                               rtsx_pci_read_register(pcr,
> RTS525A_EFUSE_CTL, &tmp);
> +                               if ((tmp & 0x80) == 0)
> +                                       break;
> +                       }
> +                       rtsx_pci_read_register(pcr, RTS525A_EFUSE_DATA,
> &val);
> +                       rtsx_pci_write_register(pcr, 0xFF04 + i, 0xFF, val);
> +               }
> +       } else {
> +               rtsx_pci_write_register(pcr, 0xFF04, 0xFF,
> (u8)PCI_VID(pcr));
> +               rtsx_pci_write_register(pcr, 0xFF05, 0xFF,
> (u8)(PCI_VID(pcr) >> 8));
> +               rtsx_pci_write_register(pcr, 0xFF06, 0xFF,
> (u8)PCI_PID(pcr));
> +               rtsx_pci_write_register(pcr, 0xFF07, 0xFF,
> (u8)(PCI_PID(pcr) >> 8));
> +       }
> +
> +       for (i = 0; i < cnt * 4; i++) {
> +               if (sv)
> +                       rtsx_pci_write_register(pcr, RTS525A_EFUSE_ADD,
> +                               REG_EFUSE_ADD_MASK, 0x08 + i);
> +               else
> +                       rtsx_pci_write_register(pcr, RTS525A_EFUSE_ADD,
> +                               REG_EFUSE_ADD_MASK, 0x04 + i);
> +               rtsx_pci_write_register(pcr, RTS525A_EFUSE_CTL,
> +                               REG_EFUSE_ENABLE | REG_EFUSE_MODE,
> REG_EFUSE_ENABLE);
> +               /* Wait transfer end */
> +               for (j = 0; j < 1024; j++) {
> +                       rtsx_pci_read_register(pcr, RTS525A_EFUSE_CTL,
> &tmp);
> +                       if ((tmp & 0x80) == 0)
> +                               break;
> +               }
> +               rtsx_pci_read_register(pcr, RTS525A_EFUSE_DATA, &val);
> +               rtsx_pci_write_register(pcr, 0xFF08 + i, 0xFF, val);
> +       }
> +       rtsx_pci_write_register(pcr, 0xFF00, 0xFF, (cnt & 0x7F) | 0x80);
> +       rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL,
> +               REG_EFUSE_BYPASS | REG_EFUSE_POR, REG_EFUSE_BYPASS);
> +       pcr_dbg(pcr, "Disable efuse por!");
> +}
> +
> +static void rts52xa_save_content_to_autoload_space(struct rtsx_pcr *pcr)
> +{
> +       u8 val;
> +
> +       rtsx_pci_read_register(pcr, RESET_LOAD_REG, &val);
> +       if (val & 0x02) {
> +               rtsx_pci_read_register(pcr, RTS525A_BIOS_CFG, &val);
> +               if (val & RTS525A_LOAD_BIOS_FLAG) {
> +                       rtsx_pci_write_register(pcr, RTS525A_BIOS_CFG,
> +                               RTS525A_LOAD_BIOS_FLAG,
> RTS525A_CLEAR_BIOS_FLAG);
> +
> +                       rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL,
> +                               REG_EFUSE_POWER_MASK, REG_EFUSE_POWERON);
> +
> +                       pcr_dbg(pcr, "Power ON efuse!");
> +                       mdelay(1);
> +                       rts52xa_save_content_from_efuse(pcr);
> +               } else {
> +                       rtsx_pci_read_register(pcr, RTS524A_PME_FORCE_CTL,
> &val);
> +                       if (!(val & 0x08))
> +                               rts52xa_save_content_from_efuse(pcr);
> +               }
> +       } else {
> +               pcr_dbg(pcr, "Load from autoload");
> +               rtsx_pci_write_register(pcr, 0xFF00, 0xFF, 0x80);
> +               rtsx_pci_write_register(pcr, 0xFF04, 0xFF,
> (u8)PCI_VID(pcr));
> +               rtsx_pci_write_register(pcr, 0xFF05, 0xFF,
> (u8)(PCI_VID(pcr) >> 8));
> +               rtsx_pci_write_register(pcr, 0xFF06, 0xFF,
> (u8)PCI_PID(pcr));
> +               rtsx_pci_write_register(pcr, 0xFF07, 0xFF,
> (u8)(PCI_PID(pcr) >> 8));
> +       }
> +}
> +
>  static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
>  {
>         struct rtsx_cr_option *option = &(pcr->option);
> @@ -153,6 +268,9 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
> 
>         rtsx_pci_init_cmd(pcr);
> 
> +       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
> +               rts52xa_save_content_to_autoload_space(pcr);
> +
>         /* Rest L1SUB Config */
>         rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, L1SUB_CONFIG3, 0xFF, 0x00);
>         /* Configure GPIO as output */
> @@ -171,18 +289,35 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
>         else
>                 rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0xB0, 0x80);
> 
> +       rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
> +
> +       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
> +               rtsx_pci_write_register(pcr, REG_VREF, PWD_SUSPND_EN,
> PWD_SUSPND_EN);
> +               rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x00);
> +               rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30,
> 0x20);
> +       } else {
> +               rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x30);
> +               rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x00);
> +       }
>         /*
>          * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
>          * to drive low, and we forcibly request clock.
>          */
>         if (option->force_clkreq_0)
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
> +               rtsx_pci_write_register(pcr, PETXCFG,
>                         FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
>         else
> -               rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
> +               rtsx_pci_write_register(pcr, PETXCFG,
>                         FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
> 
> -       return rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
> +       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
> +       if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
> +               rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL,
> +                               REG_EFUSE_POWER_MASK, REG_EFUSE_POWEROFF);
> +               pcr_dbg(pcr, "Power OFF efuse!");
> +       }
> +
> +       return 0;
>  }
> 
>  static int rts5249_optimize_phy(struct rtsx_pcr *pcr)
> @@ -668,6 +803,8 @@ static int rts525a_extra_init_hw(struct rtsx_pcr *pcr)
>  {
>         rts5249_extra_init_hw(pcr);
> 
> +       rtsx_pci_write_register(pcr, RTS5250_CLK_CFG3, RTS525A_CFG_MEM_PD,
> RTS525A_CFG_MEM_PD);
> +
>         rtsx_pci_write_register(pcr, PCLK_CTL, PCLK_MODE_SEL,
> PCLK_MODE_SEL);
>         if (is_version(pcr, 0x525A, IC_VER_A)) {
>                 rtsx_pci_write_register(pcr, L1SUB_CONFIG2,
> diff --git a/drivers/misc/cardreader/rts5260.c
> b/drivers/misc/cardreader/rts5260.c
> index b9f66b1384a6..0c3e26c79ccb 100644
> --- a/drivers/misc/cardreader/rts5260.c
> +++ b/drivers/misc/cardreader/rts5260.c
> @@ -26,21 +26,17 @@ static u8 rts5260_get_ic_version(struct rtsx_pcr *pcr)
> 
>  static void rts5260_fill_driving(struct rtsx_pcr *pcr, u8 voltage)
>  {
> -       u8 driving_3v3[6][3] = {
> -               {0x94, 0x94, 0x94},
> -               {0x11, 0x11, 0x18},
> -               {0x55, 0x55, 0x5C},
> -               {0x94, 0x94, 0x94},
> -               {0x94, 0x94, 0x94},
> -               {0xFF, 0xFF, 0xFF},
> +       u8 driving_3v3[4][3] = {
> +               {0x11, 0x11, 0x11},
> +               {0x22, 0x22, 0x22},
> +               {0x55, 0x55, 0x55},
> +               {0x33, 0x33, 0x33},
>         };
> -       u8 driving_1v8[6][3] = {
> -               {0x9A, 0x89, 0x89},
> -               {0xC4, 0xC4, 0xC4},
> -               {0x3C, 0x3C, 0x3C},
> +       u8 driving_1v8[4][3] = {
> +               {0x35, 0x33, 0x33},
> +               {0x8A, 0x88, 0x88},
> +               {0xBD, 0xBB, 0xBB},
>                 {0x9B, 0x99, 0x99},
> -               {0x9A, 0x89, 0x89},
> -               {0xFE, 0xFE, 0xFE},
>         };
>         u8 (*driving)[3], drive_sel;
> 
> @@ -58,7 +54,7 @@ static void rts5260_fill_driving(struct rtsx_pcr *pcr, u8
> voltage)
>         rtsx_pci_write_register(pcr, SD30_CMD_DRIVE_SEL,
>                          0xFF, driving[drive_sel][1]);
> 
> -       rtsx_pci_write_register(pcr, SD30_CMD_DRIVE_SEL,
> +       rtsx_pci_write_register(pcr, SD30_DAT_DRIVE_SEL,
>                          0xFF, driving[drive_sel][2]);
>  }
> 
> @@ -82,6 +78,8 @@ static void rtsx_base_fetch_vendor_settings(struct
> rtsx_pcr *pcr)
> 
>         pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
>         pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
> +       if (rtsx_check_mmc_support(reg))
> +               pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
>         pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
>         if (rtsx_reg_check_reverse_socket(reg))
>                 pcr->flags |= PCR_REVERSE_SOCKET;
> @@ -95,9 +93,8 @@ static void rtsx_base_force_power_down(struct rtsx_pcr
> *pcr, u8 pm_state)
>         rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
>                                 RELINK_TIME_MASK, 0);
> 
> -       if (pm_state == HOST_ENTER_S3)
> -               rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> -                                       D3_DELINK_MODE_EN,
> D3_DELINK_MODE_EN);
> +       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> +                       D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
> 
>         rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN,
> ALL_POWER_DOWN);
>  }
> @@ -574,6 +571,8 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
>                 rtsx_pci_write_register(pcr, PETXCFG,
>                                  FORCE_CLKREQ_DELINK_MASK,
> FORCE_CLKREQ_HIGH);
> 
> +       rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
> +
>         return 0;
>  }
> 
> diff --git a/drivers/misc/cardreader/rtsx_pcr.h
> b/drivers/misc/cardreader/rtsx_pcr.h
> index 6b322db8738e..f39c22ceb679 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.h
> +++ b/drivers/misc/cardreader/rtsx_pcr.h
> @@ -18,7 +18,25 @@
>  #define RTS522A_PM_CTRL3               0xFF7E
> 
>  #define RTS524A_PME_FORCE_CTL          0xFF78
> +#define REG_EFUSE_BYPASS               0x08
> +#define REG_EFUSE_POR                  0x04
> +#define REG_EFUSE_POWER_MASK           0x03
> +#define REG_EFUSE_POWERON              0x03
> +#define REG_EFUSE_POWEROFF             0x00
> +#define RTS5250_CLK_CFG3               0xFF79
> +#define RTS525A_CFG_MEM_PD             0xF0
>  #define RTS524A_PM_CTRL3               0xFF7E
> +#define RTS525A_BIOS_CFG               0xFF2D
> +#define RTS525A_LOAD_BIOS_FLAG 0x01
> +#define RTS525A_CLEAR_BIOS_FLAG        0x00
> +
> +#define RTS525A_EFUSE_CTL              0xFC32
> +#define REG_EFUSE_ENABLE               0x80
> +#define REG_EFUSE_MODE                 0x40
> +#define RTS525A_EFUSE_ADD              0xFC33
> +#define REG_EFUSE_ADD_MASK             0x3F
> +#define RTS525A_EFUSE_DATA             0xFC35
> +
> 
>  #define LTR_ACTIVE_LATENCY_DEF         0x883C
>  #define LTR_IDLE_LATENCY_DEF           0x892C
> -- 
> 2.17.1

