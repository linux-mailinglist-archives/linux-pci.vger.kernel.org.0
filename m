Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0D6CEF78
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 18:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjC2Qbw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 12:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjC2Qbj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 12:31:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7526EB3;
        Wed, 29 Mar 2023 09:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8897BB81E4A;
        Wed, 29 Mar 2023 16:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD9EC433D2;
        Wed, 29 Mar 2023 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680107469;
        bh=k3b3Fe0T8t6/PcyzgMQf12MeXwh+Qk1B1rqKQei5AEE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PykEtgb+jW+5qbJfga44DjFfiiIN58EAKI5oRPDhsiTR3aVgIN51ES4CIhhhi9Ett
         4i96MeY1pSx9OdAAQui+kyz2vis5gSYe1wME4/Dpsqi93pMsHp66H4WIjMt4C2sLtZ
         PBVJpYucYFfTgnX/XZlpKER0xN5Q/mhrm3/A4+SkEHfd0Wi2d5XOOx1ynZc0WOnswu
         +e4onW0QuTND/zQI6KLiDA4qNeEM62H+oHvlOostDarDby3m8ZDupPRpIvRv2KxgQn
         535sOW8WGQafHrzWparz2CX3pBLVdzx2YJZJ6hFNYo2jglTTwy6MjElmwVq0kIxSCF
         7unoKNId+7O1g==
Date:   Wed, 29 Mar 2023 11:31:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xinghui Li <korantwork@gmail.com>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
Message-ID: <20230329163107.GA3061927@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEm4hYW3zvte_kdWMFrv-pKVijQaL7KzbE12WHuO14s73ExUbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 04:57:08PM +0800, Xinghui Li wrote:
> On Wed, Mar 29, 2023 at 5:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > It would also be nice to include a hint about why a user would choose
> > "on" or "off".  What is the performance effect?  What sort of I/O
> > scenario would lead you to choose "on" vs "off"?
> >
> Before this patch, I sent the patch named :
> PCI: vmd: Do not disable MSI-X remapping in VMD 28C0 controller
> (patchwork link:
> https://patchwork.kernel.org/project/linux-pci/patch/20221222072603.1175248-1-korantwork@gmail.com/)
> We found the 4k rand read's iops could drop 50% if 4 NVMEs were
> mounted in one PCIE port with VMD MSI bypass.
> I suppose this is because the VMD Controller can aggregate interrupts.
> But those test result is so long that I didn't add them to this patch
> commit log.
> If you believe it is necessary, I will try to add some simple instructions

I don't think we need detailed performance numbers, but we need
something like:

  - "msi_remap=off" improves interrupt handling performance by
    avoiding the VMD MSI-X domain interrupt handler

  - But "msi_remap=on" is needed when ...?

> > ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
> > suggests that MSI-X remapping (I assume the "msi_remap=on" case):
> >
> >   - Limits the number MSI-X vectors available to child devices to the
> >     number of VMD MSI-X vectors.
> >
> >   - Reduces interrupt handling performance because child device
> >     interrupts have to go through the VMD MSI-X domain interrupt
> >     handler.
> >
> > So I assume "msi_remap=off" would remove that MSI-X vector limit and
> > improve interrupt handling performance?
> >
> > But obviously there's more to consider because those are both good
> > things and if we could do that all the time, we would.  So there must
> > be cases where we *have* to remap.  ee81ee84f873 suggests that not all
> > VMD devices support disabling remap.  There's also a hint that some
> > virt configs require it.
> >
> I used to just want to disable 28C0's VMD MSI bypass by default.
> But Nirmal suggested the current method by adjusting the param.
> Because he and other reviewers worry there are some other scenarios we
> didn't consider.
> Adding a method to adjust VMD'S MSI-X mode is better.

This commit log doesn't outline any of those other scenarios, and it
doesn't say anything about when "msi_remap=on" or "msi_remap=off"
would be necessary or desired, so I have no idea how users are
supposed to figure out whether or not to use this parameter.

> > This patch doesn't enforce either of those things.  What happens if
> > the user gets it wrong?
>
> If I am wrong, please feel free to correct me at any time.
> I place the "vmd_config_msi_remap_param" that is VMD MSI-X's mode
> param configuring helper front
> "vmd_enable_domain". So, It will not change the logic disabling
> remapping from ee81ee84f873, such as
> "Currently MSI remapping must be enabled in guest passthrough mode".
> So, if the user config the wrong type, it will not work, and they can
> find it by dmesg.

That's kind of a problem.  I'm not in favor of something failing and
the user having to debug it via dmesg.  That causes user frustration
and problem reports.

I don't know what "guest passthrough mode" is.  Can you detect that
automatically?

Bjorn
