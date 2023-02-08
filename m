Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451FC68FA0C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 23:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjBHWDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 17:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjBHWDs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 17:03:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6286834015;
        Wed,  8 Feb 2023 14:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F273C617E4;
        Wed,  8 Feb 2023 22:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331FAC43442;
        Wed,  8 Feb 2023 22:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675893814;
        bh=WxjfPuZxzq0Q204rr5rhM8R6eLnkbE/hw+T43rI0+O8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BcDPCWytzcirHPDmKRIHIGLoJTHcRmtRCedYt6VjkDhix/43eTd28d/C7PLQLOQtj
         QaO6pEFnnCjFq9BZ8OhEX74rof1EIVGv/UJVGg4Vw0RS8M1YdDh6qpBmnpZtAiD/lS
         zvhAaCw8Mh1xFfqSvIoaL/Qr+dPYeyxZp7FE/nzLgH6t6xgv+SrivnMAPJtLHuDJ8z
         kitldEDv+bOdovEkNMeZBZHaMOUeLvhvfu1Ar7Ti7MKwzWbXdkYYYZXFfDkNpgG9KD
         qV4rGDbeUW6UTE6zCIL2RwLg+SXfICvWIe9qMssys/3yrYo6cFGm1im4ZCRfolmboG
         I6abIbcRlrBIA==
Date:   Wed, 8 Feb 2023 16:03:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, "Leo.Li" <leo.li@realtek.com>,
        Timlee <timlee@realtek.com>, Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and
 L1ss for 8852c
Message-ID: <20230208220332.GA2485260@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b658a7d2d259493c90a41871fafae359@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 08, 2023 at 09:15:50AM +0000, Ping-Ke Shih wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > On Fri, Aug 19, 2022 at 02:48:10PM +0800, Ping-Ke Shih wrote:
> > > From: Chin-Yen Lee <timlee@realtek.com>
> > >
> > > 8852CE controls CLKREQ, ASPM L1, L1ss via wifi registers
> > > instead, so change them accordingly.
> > ...

> > We get here via this path:
> > 
> >   rtw89_pci_probe
> >     rtw89_pci_l1ss_cfg
> >       pci_read_config_dword(pdev, l1ss_cap_ptr + PCI_L1SS_CTL1, &l1ss_ctrl);
> >       if (l1ss_ctrl & PCI_L1SS_CTL1_L1SS_MASK)
> > 	rtw89_pci_l1ss_set(rtwdev, true);
> > 
> > This looks like it might be a problem because L1SS configuration
> > is owned by the PCI core, not by the device driver.  The PCI core
> > provides sysfs user interfaces that can enable and disable L1SS at
> > run-time without notification to the driver (see [1]).
> > 
> > The user may enable or disable L1SS using those sysfs interfaces,
> > and this code in the rtw89 driver will not be called.
> 
> The chunk of code is to configure L1SS of chip specific setting
> along with standard PCI capability, and normally the setting and
> capability are consistent.  An exception is that PCI capability is
> enabled but chip specific setting is disabled, when we want to use
> module parameter to disable chip specific setting experimentally to
> resolve interoperability problem on some platforms. 

This is a significant usability problem.  An interoperability problem
means the device doesn't work correctly for some users, and there's no
obvious reason *why* it doesn't work, so they don't know how to fix
it.

Module parameters are not a solution because users don't know when
they are needed or how to use them.  This leads to situations like
[1,2,3], where users waste a lot of time flailing around to get the
device to work, and the eventual "solution" is to replace it with
something else:

  After replacing the Realtek card with Intel AX200 I do not have the
  described problem anymore.

> We don't suggest the use case that L1SS of PCI capability is
> disabled but chip specific setting is enabled, because hardware
> could get abnormal occasionally. Also, it could also get unexpected
> behavior suddenly if we change L1SS dynamically.
> 
> Summary:
> 
>    PCI capability      chip specific setting       comment
>    --------------      ---------------------       -------
>    enabled             enabled                     ok, currently support
>    disabled            disabled                    ok, currently support
>    enabled             disabled                    experimental case via module parameter
>    disabled            enabled                     don't suggest

I think the fact that you need chip-specific code here is a hardware
defect in the rtw89 device.  The whole point of L1SS being in the PCIe
spec is so generic software can configure it without having to know
chip-specific details.

> With above reasons, if users meet problem or unexpected result after
> changing L1SS, we may tell them this hardware can't dynamically
> configure L1SS via sysfs interfaces. 

How can we make this better, so the device works and users never have
to specify those module parameters?

Would it help if we had a way to make a quirk that meant "never enable
L1SS for this device"?  Obviously that's not ideal because we want the
power savings of L1SS, but the power saving is only worthwhile if the
device always *works*.

Or maybe we could have a quirk that means "the PCI core will never
change the L1SS configuration for this device"?  Would that help?

Bjorn

[1] https://github.com/lwfinger/rtw89/issues/41
[2] https://bbs.archlinux.org/viewtopic.php?id=273515
[3] https://bugs.launchpad.net/ubuntu/+source/linux-firmware/+bug/1971656
