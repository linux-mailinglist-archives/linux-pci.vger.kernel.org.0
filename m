Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB621693BDC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 02:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjBMBrF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 12 Feb 2023 20:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMBrE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Feb 2023 20:47:04 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32759EC7D;
        Sun, 12 Feb 2023 17:46:59 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31D1koAdB015699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31D1koAdB015699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 13 Feb 2023 09:46:50 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 13 Feb 2023 09:46:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 13 Feb 2023 09:46:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02]) by
 RTEXMBS04.realtek.com.tw ([fe80::b4a2:2bcc:48d1:8b02%5]) with mapi id
 15.01.2375.007; Mon, 13 Feb 2023 09:46:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Kalle Valo <kvalo@kernel.org>, "Leo.Li" <leo.li@realtek.com>,
        Timlee <timlee@realtek.com>, Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and L1ss for 8852c
Thread-Topic: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and
 L1ss for 8852c
Thread-Index: AQHYs5fsk0fVYj3Bv0+jQcJP/fr4uK7EfhkAgADxGJCAALXgAIAHBIEw
Date:   Mon, 13 Feb 2023 01:46:51 +0000
Message-ID: <0c5a56d67a64491eb0bac952da1d60b5@realtek.com>
References: <b658a7d2d259493c90a41871fafae359@realtek.com>
 <20230208220332.GA2485260@bhelgaas>
In-Reply-To: <20230208220332.GA2485260@bhelgaas>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2023/2/12_=3F=3F_10:57:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, February 9, 2023 6:04 AM
> To: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Leo.Li <leo.li@realtek.com>; Timlee <timlee@realtek.com>; Bernie Huang
> <phhuang@realtek.com>; linux-wireless@vger.kernel.org; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and L1ss for 8852c
> 
> On Wed, Feb 08, 2023 at 09:15:50AM +0000, Ping-Ke Shih wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > On Fri, Aug 19, 2022 at 02:48:10PM +0800, Ping-Ke Shih wrote:
> > > > From: Chin-Yen Lee <timlee@realtek.com>
> > > >
> > > > 8852CE controls CLKREQ, ASPM L1, L1ss via wifi registers
> > > > instead, so change them accordingly.
> > > ...
> 
> > > We get here via this path:
> > >
> > >   rtw89_pci_probe
> > >     rtw89_pci_l1ss_cfg
> > >       pci_read_config_dword(pdev, l1ss_cap_ptr + PCI_L1SS_CTL1, &l1ss_ctrl);
> > >       if (l1ss_ctrl & PCI_L1SS_CTL1_L1SS_MASK)
> > > 	rtw89_pci_l1ss_set(rtwdev, true);
> > >
> > > This looks like it might be a problem because L1SS configuration
> > > is owned by the PCI core, not by the device driver.  The PCI core
> > > provides sysfs user interfaces that can enable and disable L1SS at
> > > run-time without notification to the driver (see [1]).
> > >
> > > The user may enable or disable L1SS using those sysfs interfaces,
> > > and this code in the rtw89 driver will not be called.
> >
> > The chunk of code is to configure L1SS of chip specific setting
> > along with standard PCI capability, and normally the setting and
> > capability are consistent.  An exception is that PCI capability is
> > enabled but chip specific setting is disabled, when we want to use
> > module parameter to disable chip specific setting experimentally to
> > resolve interoperability problem on some platforms.
> 
> This is a significant usability problem.  An interoperability problem
> means the device doesn't work correctly for some users, and there's no
> obvious reason *why* it doesn't work, so they don't know how to fix
> it.
> 
> Module parameters are not a solution because users don't know when
> they are needed or how to use them.  This leads to situations like
> [1,2,3], where users waste a lot of time flailing around to get the
> device to work, and the eventual "solution" is to replace it with
> something else:
> 
>   After replacing the Realtek card with Intel AX200 I do not have the
>   described problem anymore.

A cause of interoperability problem could be due to PCI bridge side
configured by BIOS. We have fixed this kind of problem many times before.
Maybe, this device has less tolerance to handle PCI signals. The module
parameter is an alternative way to help users to resolve the problem in
their platforms. If people buy a computer with this device built-in, he
will meet this problem in low probability because ODM will verify this
ahead. If people buy this device themselves to install to their platforms,
it is hard to guarantee it can work well, because cause of interoperability
could be bride side as mentioned in beginning. 

> 
> > We don't suggest the use case that L1SS of PCI capability is
> > disabled but chip specific setting is enabled, because hardware
> > could get abnormal occasionally. Also, it could also get unexpected
> > behavior suddenly if we change L1SS dynamically.
> >
> > Summary:
> >
> >    PCI capability      chip specific setting       comment
> >    --------------      ---------------------       -------
> >    enabled             enabled                     ok, currently support
> >    disabled            disabled                    ok, currently support
> >    enabled             disabled                    experimental case via module parameter
> >    disabled            enabled                     don't suggest
> 
> I think the fact that you need chip-specific code here is a hardware
> defect in the rtw89 device.  The whole point of L1SS being in the PCIe
> spec is so generic software can configure it without having to know
> chip-specific details.
> 
> > With above reasons, if users meet problem or unexpected result after
> > changing L1SS, we may tell them this hardware can't dynamically
> > configure L1SS via sysfs interfaces.
> 
> How can we make this better, so the device works and users never have
> to specify those module parameters?

Normally, users don't need to specify this module parameter. If it's really
needed, we can add a quirk along with DMI vendor and product name to configure
automatically. But, indeed we still need a user to try that module parameter
can work on a certain platform.

> 
> Would it help if we had a way to make a quirk that meant "never enable
> L1SS for this device"?  Obviously that's not ideal because we want the
> power savings of L1SS, but the power saving is only worthwhile if the
> device always *works*.
> 
> Or maybe we could have a quirk that means "the PCI core will never
> change the L1SS configuration for this device"?  Would that help?
> 

In fact, we only don't suggest to change L1SS "dynamically". Initially,
enable or disable L1SS is usable, and driver will set chip-specific 
setting along with standard PCI configuration.

So, I think it would be okay to have a quirk that "never change L1SS dynamically".
But, I'm not sure if switching L1SS is a common option for average users?
I mean L1SS normally is configured by developers only, so restrictions aren't
always good to them, because they should know what they are doing. 

Ping-Ke

