Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CFA6952DC
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 22:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBMVQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 16:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMVQj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 16:16:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768219F31;
        Mon, 13 Feb 2023 13:16:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C538B81910;
        Mon, 13 Feb 2023 21:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8487C433EF;
        Mon, 13 Feb 2023 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676322995;
        bh=J/mGmXb0y317qnmiYd6Y9Gqf2IMMx2ljXhRztgwYXk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=btGLzvIIxF85HtUnkx72Y8Y0hIaAvS3vM111XNlvj7X3n/IKYW2vmKFRhRYBUY4Qj
         Jw6sggDShIpRDqWLzPMt8okA6QZJMxxHRuuSwq4rpiJPTMQAnfKd66JdnYpqhXjheX
         kOkKH/yOmkHkJtoHfCI4O9v9/MPHc4uGmtVi9l3ll7IC9sP7Znn+Iiv7PwyNu4APIZ
         uKOLFLLN1rL/fJ43Jn3anDR3xG7M46zhjCsM1EUcP6VPOukvAcHdrr2XkDOjwUdROB
         VcdYPJy31Uajwh/3UU2rlAWjimvbfnKQT2pr2Fivj6/3BcXOi55U0GpuQnp+PJzvNO
         YSNoUPKCgp4gA==
Date:   Mon, 13 Feb 2023 15:16:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, "Leo.Li" <leo.li@realtek.com>,
        Timlee <timlee@realtek.com>, Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and
 L1ss for 8852c
Message-ID: <20230213211633.GA2931225@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5a56d67a64491eb0bac952da1d60b5@realtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 13, 2023 at 01:46:51AM +0000, Ping-Ke Shih wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, February 9, 2023 6:04 AM
> > To: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: Kalle Valo <kvalo@kernel.org>; Leo.Li <leo.li@realtek.com>; Timlee <timlee@realtek.com>; Bernie Huang
> > <phhuang@realtek.com>; linux-wireless@vger.kernel.org; linux-pci@vger.kernel.org
> > Subject: Re: [PATCH v2 4/5] wifi: rtw89: pci: enable CLK_REQ, ASPM, L1 and L1ss for 8852c

It would be better if your email client allows you to respond without
the unnecessary repetition of the From/To/Cc/Subject lines above.  For
example, this would be sufficient:

  > On Thursday, February 9, 2023 6:04 AM, Bjorn Helgaas wrote:
  > > On Wed, Feb 08, 2023 at 09:15:50AM +0000, Ping-Ke Shih wrote:
  > > > On Fri, Aug 19, 2022 at 02:48:10PM, Ping-Ke Shih wrote:

Then it's shorter and easier to figure out who wrote what.

> > On Wed, Feb 08, 2023 at 09:15:50AM +0000, Ping-Ke Shih wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>

> > > The chunk of code is to configure L1SS of chip specific setting
> > > along with standard PCI capability, and normally the setting and
> > > capability are consistent.  An exception is that PCI capability is
> > > enabled but chip specific setting is disabled, when we want to use
> > > module parameter to disable chip specific setting experimentally to
> > > resolve interoperability problem on some platforms.
> > 
> > This is a significant usability problem.  An interoperability problem
> > means the device doesn't work correctly for some users, and there's no
> > obvious reason *why* it doesn't work, so they don't know how to fix
> > it.
> > 
> > Module parameters are not a solution because users don't know when
> > they are needed or how to use them.  This leads to situations like
> > [1,2,3], where users waste a lot of time flailing around to get the
> > device to work, and the eventual "solution" is to replace it with
> > something else:
> > 
> >   After replacing the Realtek card with Intel AX200 I do not have the
> >   described problem anymore.
> 
> A cause of interoperability problem could be due to PCI bridge side
> configured by BIOS. We have fixed this kind of problem many times before.
> Maybe, this device has less tolerance to handle PCI signals. The module
> parameter is an alternative way to help users to resolve the problem in
> their platforms. If people buy a computer with this device built-in, he
> will meet this problem in low probability because ODM will verify this
> ahead. If people buy this device themselves to install to their platforms,
> it is hard to guarantee it can work well, because cause of interoperability
> could be bride side as mentioned in beginning. 

The BIOS or PCI core should configure both the bridge and the endpoint
so they are consistent.  If the driver needs to do something, e.g.,
via a module parameter, that means there's a BIOS or PCI core defect
that should be fixed.  It should be fixed in the PCI core, not in the
individual driver.

> > > We don't suggest the use case that L1SS of PCI capability is
> > > disabled but chip specific setting is enabled, because hardware
> > > could get abnormal occasionally. Also, it could also get unexpected
> > > behavior suddenly if we change L1SS dynamically.
> > >
> > > Summary:
> > >
> > >    PCI capability      chip specific setting       comment
> > >    --------------      ---------------------       -------
> > >    enabled             enabled                     ok, currently support
> > >    disabled            disabled                    ok, currently support
> > >    enabled             disabled                    experimental case via module parameter
> > >    disabled            enabled                     don't suggest
> > 
> > I think the fact that you need chip-specific code here is a hardware
> > defect in the rtw89 device.  The whole point of L1SS being in the PCIe
> > spec is so generic software can configure it without having to know
> > chip-specific details.
> > 
> > > With above reasons, if users meet problem or unexpected result after
> > > changing L1SS, we may tell them this hardware can't dynamically
> > > configure L1SS via sysfs interfaces.
> > 
> > How can we make this better, so the device works and users never have
> > to specify those module parameters?
> 
> Normally, users don't need to specify this module parameter. If it's
> really needed, we can add a quirk along with DMI vendor and product
> name to configure automatically. But, indeed we still need a user to
> try that module parameter can work on a certain platform.

The fact that the parameter exists means *some* users do need it.  And
that is a huge problem because those users don't *know* they need it;
they just see a device that doesn't work, and they don't know why.
All they can do is try random combinations of parameters to see what
seems to work.  This just doesn't scale for users that deal with a
dozen different devices in their system.  We can't expect them to
fiddle with module parameters for each.

> > Would it help if we had a way to make a quirk that meant "never enable
> > L1SS for this device"?  Obviously that's not ideal because we want the
> > power savings of L1SS, but the power saving is only worthwhile if the
> > device always *works*.
> > 
> > Or maybe we could have a quirk that means "the PCI core will never
> > change the L1SS configuration for this device"?  Would that help?
> 
> In fact, we only don't suggest to change L1SS "dynamically". Initially,
> enable or disable L1SS is usable, and driver will set chip-specific 
> setting along with standard PCI configuration.

If your device is implemented correctly per the PCIe spec, there
should be no problem with changing L1SS configuration dynamically.  Of
course if there are PCI core defects that mean it doesn't work, those
can and should be fixed.

> So, I think it would be okay to have a quirk that "never change L1SS
> dynamically".  But, I'm not sure if switching L1SS is a common
> option for average users?  I mean L1SS normally is configured by
> developers only, so restrictions aren't always good to them, because
> they should know what they are doing. 

There are sysfs options for changing L1SS configuration, and it's
reasonable for users to change that based on changing workload.  I
expect tools like powertop to take advantage of that eventually.

Bjorn
