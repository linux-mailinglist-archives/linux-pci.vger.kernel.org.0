Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE43C262288
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 00:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgIHWTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 18:19:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgIHWTk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 18:19:40 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942F02087D;
        Tue,  8 Sep 2020 22:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599603578;
        bh=WSx1iUKGD6bsRY1emyiSlN3VJSdwi6R0XqFLz5EUkSQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aKIeHt+H2pE8g3rK9+J8FhOsCjI0qvqBdFnfBO38f/0g4XU5jhNRQBqRhu+x12if8
         lJOhJVVXdarJcV95h2x62GY2ZvsWDoZ+58dKKREa3PcxXXv68qgpZqjCchOvc/c6kd
         QEmgkcBpPnyafGL0guct6OBZs7SetfNVNyJ58geQ=
Date:   Tue, 8 Sep 2020 17:19:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, bhelgaas@google.com,
        ulf.hansson@linaro.org, rui_feng@realsil.com.cn,
        linux-kernel@vger.kernel.org, puranjay12@gmail.com,
        linux-pci@vger.kernel.org, vailbhavgupta40@gamail.com
Subject: Re: [PATCH v5 1/2] misc: rtsx: Fix power down flow
Message-ID: <20200908221937.GA646017@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907100718.7672-1-ricky_wu@realtek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 06:07:18PM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> Fix and sort out rtsx driver power down flow

It would be nice to say what's changing here, but it's a great
improvement to have this split out.

For example, this drops the "pm_state == HOST_ENTER_S3" check, but
there's no explanation.

Minor comments below.

> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/misc/cardreader/rts5227.c  | 15 ---------------
>  drivers/misc/cardreader/rts5228.c  |  5 ++---
>  drivers/misc/cardreader/rts5249.c  | 17 -----------------
>  drivers/misc/cardreader/rts5260.c  | 16 ----------------
>  drivers/misc/cardreader/rtsx_pcr.c | 16 ++++++++++++++++
>  5 files changed, 18 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
> index f5f392ddf3d6..747391e3fb5d 100644
> --- a/drivers/misc/cardreader/rts5227.c
> +++ b/drivers/misc/cardreader/rts5227.c
> @@ -77,19 +77,6 @@ static void rts5227_fetch_vendor_settings(struct rtsx_pcr *pcr)
>  		pcr->flags |= PCR_REVERSE_SOCKET;
>  }
>  
> -static void rts5227_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
> -{
> -	/* Set relink_time to 0 */
> -	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, 0xFF, 0);
> -	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, 0xFF, 0);
> -	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3, 0x01, 0);
> -
> -	if (pm_state == HOST_ENTER_S3)
> -		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x10);
> -
> -	rtsx_pci_write_register(pcr, FPDCTL, 0x03, 0x03);
> -}
> -
>  static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
>  {
>  	u16 cap;
> @@ -239,7 +226,6 @@ static const struct pcr_ops rts5227_pcr_ops = {
>  	.switch_output_voltage = rts5227_switch_output_voltage,
>  	.cd_deglitch = NULL,
>  	.conv_clk_and_div_n = NULL,
> -	.force_power_down = rts5227_force_power_down,
>  };
>  
>  /* SD Pull Control Enable:
> @@ -389,7 +375,6 @@ static const struct pcr_ops rts522a_pcr_ops = {
>  	.switch_output_voltage = rts522a_switch_output_voltage,
>  	.cd_deglitch = NULL,
>  	.conv_clk_and_div_n = NULL,
> -	.force_power_down = rts5227_force_power_down,
>  };
>  
>  void rts522a_init_params(struct rtsx_pcr *pcr)
> diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
> index 28feab1449ab..781a86def59a 100644
> --- a/drivers/misc/cardreader/rts5228.c
> +++ b/drivers/misc/cardreader/rts5228.c
> @@ -99,9 +99,8 @@ static void rts5228_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
>  	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
>  				RELINK_TIME_MASK, 0);
>  
> -	if (pm_state == HOST_ENTER_S3)
> -		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> -					D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
> +	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> +			D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
>  
>  	rtsx_pci_write_register(pcr, FPDCTL,
>  		SSC_POWER_DOWN, SSC_POWER_DOWN);
> diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
> index 941b3d77f1e9..719aa2d61919 100644
> --- a/drivers/misc/cardreader/rts5249.c
> +++ b/drivers/misc/cardreader/rts5249.c
> @@ -78,20 +78,6 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
>  		pcr->flags |= PCR_REVERSE_SOCKET;
>  }
>  
> -static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
> -{
> -	/* Set relink_time to 0 */
> -	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, 0xFF, 0);
> -	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, 0xFF, 0);
> -	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3, 0x01, 0);
> -
> -	if (pm_state == HOST_ENTER_S3)
> -		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> -			D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
> -
> -	rtsx_pci_write_register(pcr, FPDCTL, 0x03, 0x03);
> -}
> -
>  static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
>  {
>  	struct pci_dev *pdev = pcr->pci;
> @@ -360,7 +346,6 @@ static const struct pcr_ops rts5249_pcr_ops = {
>  	.card_power_on = rtsx_base_card_power_on,
>  	.card_power_off = rtsx_base_card_power_off,
>  	.switch_output_voltage = rtsx_base_switch_output_voltage,
> -	.force_power_down = rtsx_base_force_power_down,
>  };
>  
>  /* SD Pull Control Enable:
> @@ -585,7 +570,6 @@ static const struct pcr_ops rts524a_pcr_ops = {
>  	.card_power_on = rtsx_base_card_power_on,
>  	.card_power_off = rtsx_base_card_power_off,
>  	.switch_output_voltage = rtsx_base_switch_output_voltage,
> -	.force_power_down = rtsx_base_force_power_down,
>  	.set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
>  };
>  
> @@ -700,7 +684,6 @@ static const struct pcr_ops rts525a_pcr_ops = {
>  	.card_power_on = rts525a_card_power_on,
>  	.card_power_off = rtsx_base_card_power_off,
>  	.switch_output_voltage = rts525a_switch_output_voltage,
> -	.force_power_down = rtsx_base_force_power_down,
>  	.set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
>  };
>  
> diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
> index b9f66b1384a6..897cfee350e7 100644
> --- a/drivers/misc/cardreader/rts5260.c
> +++ b/drivers/misc/cardreader/rts5260.c
> @@ -87,21 +87,6 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
>  		pcr->flags |= PCR_REVERSE_SOCKET;
>  }
>  
> -static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
> -{
> -	/* Set relink_time to 0 */
> -	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
> -	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, MASK_8_BIT_DEF, 0);
> -	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
> -				RELINK_TIME_MASK, 0);
> -
> -	if (pm_state == HOST_ENTER_S3)
> -		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> -					D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
> -
> -	rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN, ALL_POWER_DOWN);
> -}
> -
>  static int rtsx_base_enable_auto_blink(struct rtsx_pcr *pcr)
>  {
>  	return rtsx_pci_write_register(pcr, OLT_LED_CTL,
> @@ -620,7 +605,6 @@ static const struct pcr_ops rts5260_pcr_ops = {
>  	.card_power_on = rts5260_card_power_on,
>  	.card_power_off = rts5260_card_power_off,
>  	.switch_output_voltage = rts5260_switch_output_voltage,
> -	.force_power_down = rtsx_base_force_power_down,
>  	.stop_cmd = rts5260_stop_cmd,
>  	.set_l1off_cfg_sub_d0 = rts5260_set_l1off_cfg_sub_d0,
>  	.enable_ocp = rts5260_enable_ocp,
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 37ccc67f4914..3f84b898bd9c 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -1096,6 +1096,20 @@ static void rtsx_pci_idle_work(struct work_struct *work)
>  	mutex_unlock(&pcr->pcr_mutex);
>  }
>  
> +static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
> +{
> +	/* Set relink_time to 0 */
> +	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
> +	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, MASK_8_BIT_DEF, 0);

Personally, I don't think MASK_8_BIT_DEF is an improvement over 0xFF.

> +	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
> +			RELINK_TIME_MASK, 0);
> +
> +	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
> +			D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
> +
> +	rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN, ALL_POWER_DOWN);

This changes the value written from 0x3 to 0x7 (ALL_POWER_DOWN) in a
couple cases.  I guess you know that's OK.

> +}
> +
>  static void __maybe_unused rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state)
>  {
>  	if (pcr->ops->turn_off_led)
> @@ -1109,6 +1123,8 @@ static void __maybe_unused rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state)
>  
>  	if (pcr->ops->force_power_down)
>  		pcr->ops->force_power_down(pcr, pm_state);
> +	else
> +		rtsx_base_force_power_down(pcr, pm_state);
>  }
>  
>  void rtsx_pci_enable_ocp(struct rtsx_pcr *pcr)
> -- 
> 2.17.1
> 
