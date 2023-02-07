Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0968E223
	for <lists+linux-pci@lfdr.de>; Tue,  7 Feb 2023 21:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBGUtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Feb 2023 15:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBGUtp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2023 15:49:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45E8CDD2;
        Tue,  7 Feb 2023 12:49:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D2E761169;
        Tue,  7 Feb 2023 20:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E85C433EF;
        Tue,  7 Feb 2023 20:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675802982;
        bh=T6G70bbso9b+ZXRdkYRuUprPT0mR17BdhO9Oo4NPLlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QfenOZLM1lQGUd2TtlyIE+6SUKQxz0evl+ZPL60PjGMEysXFd2gdg6P9IX7j4WoHO
         Vc0q7G+C273g9I0c00ItmI2lzY3YJhHI+Tk6HIt3LyKZB8mdjc/IMGLY+FSZeHg+/N
         xq9ECITt5plvO9IuT/QvncTZigK0vVgxW+i8ipHOqPsbWMHugLuFAGkaHTpPMtZpRk
         RDb+6i8kftCTQskCTuGdil2yDqjexbRqiyQnHPcuREZssVt7c1HdC2Sr3QxJMaez4c
         jkh/BdKzYWFqo5KfoyFunZiQkGF0Ccq9Ew9piTK183ALTzGYL2qJHPT+pZhEFda7HZ
         sO80RK3FHClRA==
Date:   Tue, 7 Feb 2023 14:49:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Chia-Yuan Li <leo.li@realtek.com>,
        Chin-Yen Lee <timlee@realtek.com>,
        Po-Hao Huang <phhuang@realtek.com>,
        linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and
 L1ss for 8852c
Message-ID: <20230207204940.GA2373732@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819064811.37700-5-pkshih@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 02:48:10PM +0800, Ping-Ke Shih wrote:
> From: Chin-Yen Lee <timlee@realtek.com>
> 
> 8852CE controls CLKREQ, ASPM L1, L1ss via wifi registers
> instead, so change them accordingly.

> ...
>  static void rtw89_pci_l1ss_set(struct rtw89_dev *rtwdev, bool enable)
>  {
> +	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
>  	int ret;
>  
> -	if (enable)
> -		ret = rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_TIMER_CTRL,
> -						RTW89_PCIE_BIT_L1SUB);
> -	else
> -		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_TIMER_CTRL,
> -						RTW89_PCIE_BIT_L1SUB);
> -	if (ret)
> -		rtw89_err(rtwdev, "failed to %s L1SS, ret=%d",
> -			  enable ? "set" : "unset", ret);
> +	if (chip_id == RTL8852A || chip_id == RTL8852B) {
> +		if (enable)
> +			ret = rtw89_pci_config_byte_set(rtwdev,
> +							RTW89_PCIE_TIMER_CTRL,
> +							RTW89_PCIE_BIT_L1SUB);
> +		else
> +			ret = rtw89_pci_config_byte_clr(rtwdev,
> +							RTW89_PCIE_TIMER_CTRL,
> +							RTW89_PCIE_BIT_L1SUB);
> +		if (ret)
> +			rtw89_err(rtwdev, "failed to %s L1SS, ret=%d",
> +				  enable ? "set" : "unset", ret);
> +	} else if (chip_id == RTL8852C) {
> +		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_L1SS_STS_V1,
> +						RTW89_PCIE_BIT_ASPM_L11 |
> +						RTW89_PCIE_BIT_PCI_L11);
> +		if (ret)
> +			rtw89_warn(rtwdev, "failed to unset ASPM L1.1, ret=%d", ret);
> +		if (enable)
> +			rtw89_write32_clr(rtwdev, R_AX_PCIE_MIX_CFG_V1,
> +					  B_AX_L1SUB_DISABLE);
> +		else
> +			rtw89_write32_set(rtwdev, R_AX_PCIE_MIX_CFG_V1,
> +					  B_AX_L1SUB_DISABLE);
> +	}
>  }

We get here via this path:

  rtw89_pci_probe
    rtw89_pci_l1ss_cfg
      pci_read_config_dword(pdev, l1ss_cap_ptr + PCI_L1SS_CTL1, &l1ss_ctrl);
      if (l1ss_ctrl & PCI_L1SS_CTL1_L1SS_MASK)
	rtw89_pci_l1ss_set(rtwdev, true);

This looks like it might be a problem because L1SS configuration is
owned by the PCI core, not by the device driver.  The PCI core
provides sysfs user interfaces that can enable and disable L1SS at
run-time without notification to the driver (see [1]).

The user may enable or disable L1SS using those sysfs interfaces, and
this code in the rtw89 driver will not be called.

Bjorn

P.S. rtw89_pci_l1ss_set() is only called from rtw89_pci_l1ss_cfg()
which always supplies "enable == true", so it looks like that
parameter is not needed.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-bus-pci?id=v6.1#n410
