Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9B68EAFF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 10:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjBHJSy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 8 Feb 2023 04:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjBHJS3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 04:18:29 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A066E8F;
        Wed,  8 Feb 2023 01:16:09 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3189FhKH2030736, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3189FhKH2030736
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 8 Feb 2023 17:15:43 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 8 Feb 2023 17:15:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 8 Feb 2023 17:15:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Wed, 8 Feb 2023 17:15:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Kalle Valo <kvalo@kernel.org>, "Leo.Li" <leo.li@realtek.com>,
        Timlee <timlee@realtek.com>, Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and L1ss for 8852c
Thread-Topic: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and
 L1ss for 8852c
Thread-Index: AQHYs5fsk0fVYj3Bv0+jQcJP/fr4uK7EfhkAgADxGJA=
Date:   Wed, 8 Feb 2023 09:15:50 +0000
Message-ID: <b658a7d2d259493c90a41871fafae359@realtek.com>
References: <20220819064811.37700-5-pkshih@realtek.com>
 <20230207204940.GA2373732@bhelgaas>
In-Reply-To: <20230207204940.GA2373732@bhelgaas>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2023/2/8_=3F=3F_06:00:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, February 8, 2023 4:50 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Leo.Li <leo.li@realtek.com>; Timlee <timlee@realtek.com>; Bernie Huang
> <phhuang@realtek.com>; linux-wireless@vger.kernel.org; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and L1ss for 8852c
> 
> On Fri, Aug 19, 2022 at 02:48:10PM +0800, Ping-Ke Shih wrote:
> > From: Chin-Yen Lee <timlee@realtek.com>
> >
> > 8852CE controls CLKREQ, ASPM L1, L1ss via wifi registers
> > instead, so change them accordingly.
> 
> > ...
> >  static void rtw89_pci_l1ss_set(struct rtw89_dev *rtwdev, bool enable)
> >  {
> > +	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
> >  	int ret;
> >
> > -	if (enable)
> > -		ret = rtw89_pci_config_byte_set(rtwdev, RTW89_PCIE_TIMER_CTRL,
> > -						RTW89_PCIE_BIT_L1SUB);
> > -	else
> > -		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_TIMER_CTRL,
> > -						RTW89_PCIE_BIT_L1SUB);
> > -	if (ret)
> > -		rtw89_err(rtwdev, "failed to %s L1SS, ret=%d",
> > -			  enable ? "set" : "unset", ret);
> > +	if (chip_id == RTL8852A || chip_id == RTL8852B) {
> > +		if (enable)
> > +			ret = rtw89_pci_config_byte_set(rtwdev,
> > +							RTW89_PCIE_TIMER_CTRL,
> > +							RTW89_PCIE_BIT_L1SUB);
> > +		else
> > +			ret = rtw89_pci_config_byte_clr(rtwdev,
> > +							RTW89_PCIE_TIMER_CTRL,
> > +							RTW89_PCIE_BIT_L1SUB);
> > +		if (ret)
> > +			rtw89_err(rtwdev, "failed to %s L1SS, ret=%d",
> > +				  enable ? "set" : "unset", ret);
> > +	} else if (chip_id == RTL8852C) {
> > +		ret = rtw89_pci_config_byte_clr(rtwdev, RTW89_PCIE_L1SS_STS_V1,
> > +						RTW89_PCIE_BIT_ASPM_L11 |
> > +						RTW89_PCIE_BIT_PCI_L11);
> > +		if (ret)
> > +			rtw89_warn(rtwdev, "failed to unset ASPM L1.1, ret=%d", ret);
> > +		if (enable)
> > +			rtw89_write32_clr(rtwdev, R_AX_PCIE_MIX_CFG_V1,
> > +					  B_AX_L1SUB_DISABLE);
> > +		else
> > +			rtw89_write32_set(rtwdev, R_AX_PCIE_MIX_CFG_V1,
> > +					  B_AX_L1SUB_DISABLE);
> > +	}
> >  }
> 
> We get here via this path:
> 
>   rtw89_pci_probe
>     rtw89_pci_l1ss_cfg
>       pci_read_config_dword(pdev, l1ss_cap_ptr + PCI_L1SS_CTL1, &l1ss_ctrl);
>       if (l1ss_ctrl & PCI_L1SS_CTL1_L1SS_MASK)
> 	rtw89_pci_l1ss_set(rtwdev, true);
> 
> This looks like it might be a problem because L1SS configuration is
> owned by the PCI core, not by the device driver.  The PCI core
> provides sysfs user interfaces that can enable and disable L1SS at
> run-time without notification to the driver (see [1]).
> 
> The user may enable or disable L1SS using those sysfs interfaces, and
> this code in the rtw89 driver will not be called.

The chunk of code is to configure L1SS of chip specific setting along with
standard PCI capability, and normally the setting and capability are consistent.
An exception is that PCI capability is enabled but chip specific setting is
disabled, when we want to use module parameter to disable chip specific
setting experimentally to resolve interoperability problem on some platforms. 

We don't suggest the use case that L1SS of PCI capability is disabled but 
chip specific setting is enabled, because hardware could get abnormal
occasionally. Also, it could also get unexpected behavior suddenly if we change
L1SS dynamically.

Summary:

   PCI capability      chip specific setting       comment
   --------------      ---------------------       -------
   enabled             enabled                     ok, currently support
   disabled            disabled                    ok, currently support
   enabled             disabled                    experimental case via module parameter
   disabled            enabled                     don't suggest


With above reasons, if users meet problem or unexpected result after changing
L1SS, we may tell them this hardware can't dynamically configure L1SS via
sysfs interfaces. 

Ping-Ke


