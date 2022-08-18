Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DD3598E28
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 22:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiHRUiU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 16:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344916AbiHRUiT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 16:38:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D5CE0D2
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 13:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E39AFB82216
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 20:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672B3C433C1;
        Thu, 18 Aug 2022 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660855094;
        bh=6Lsy0QaxfV6sD1O8kfNMv6jWWiIgfjbYjaUEeiQnpZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GHqlOIcqhocdbmY56+RBw2wUFa+XU+/RQhpmBU3iNw0GCy/D/PO6cTivwW30rUOpq
         8QZuT5OINLUWYQ7/NK0GiYMiO9/5ohREqvLPLXcw3lMvTx89My7rN3zi++cGAL2nud
         4o5HBR1ZTDttkXXxSGlgukaAYEQt4MFWQxnTU+zZjY9lGo/PE7JDCU3Q2l+suqrWDf
         Er6IONkOrkpDE+kNaEdmDV0m6IJr2Pd/3TgjtXlQe2zaYDuYWTwauJiS7ZNGK2fsU5
         oF7Z9DpqlgY6j4CkkMV9tqrPrOaWvQ9C6yHCchFqgol7HozQrWwv9+fTmKFNXO0qkd
         kDfbhLnGf4l2A==
Date:   Thu, 18 Aug 2022 15:38:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Tom Seewald <tseewald@gmail.com>, Stefan Roese <sr@denx.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        regressions@lists.linux.dev, linux-pci@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Message-ID: <20220818203812.GA2381243@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216373-41252@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Adding amdgpu folks]

On Wed, Aug 17, 2022 at 11:45:15PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216373
> 
>             Bug ID: 216373
>            Summary: Uncorrected errors reported for AMD GPU
>     Kernel Version: v6.0-rc1
>         Regression: No
> ...

I marked this as a regression in bugzilla.

> Hardware:
> CPU: Intel i7-12700K (Alder Lake)
> GPU: AMD RX 6700 XT [1002:73df]
> Motherboard: ASUS Prime Z690-A
> 
> Problem:
> After upgrading to v6.0-rc1 the kernel is now reporting uncorrected PCI errors
> for my GPU.

Thank you very much for the report and for taking the trouble to
bisect it and test Kai-Heng's patch!

I suspect that booting with "pci=noaer" should be a temporary
workaround for this issue.  If it, can you add that to the bugzilla
for anybody else who trips over this?

> I have bisected this issue to: [8795e182b02dc87e343c79e73af6b8b7f9c5e635]
> PCI/portdrv: Don't disable AER reporting in get_port_device_capability()
> Reverting that commit causes the errors to cease.

I suspect the errors still occur, but we just don't notice and log
them.

> I have also tried Kai-Heng Feng's patch[1] which seems to resolve a similar
> problem, but it did not fix my issue.
> 
> [1]
> https://lore.kernel.org/linux-pci/20220706123244.18056-1-kai.heng.feng@canonical.com/
>
> dmesg snippet:
> 
> pcieport 0000:00:01.0: AER: Multiple Uncorrected (Non-Fatal) error received:
> 0000:03:00.0
> amdgpu 0000:03:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal),
> type=Transaction Layer, (Requester ID)
> amdgpu 0000:03:00.0:   device [1002:73df] error status/mask=00100000/00000000
> amdgpu 0000:03:00.0:    [20] UnsupReq               (First)
> amdgpu 0000:03:00.0: AER:   TLP Header: 40000001 0000000f 95e7f000 00000000

I think the TLP header decodes to:

  0x40000001 = 0100 0000 ... 0000 0001 binary
  0x0000000f = 0000 0000 ... 0000 1111 binary

  Fmt           010b                 3 DW header with data
  Type          0000b  010 0 0000    MWr Memory Write Request
  Length        00 0000 0001b        1 DW
  Requester ID  0x0000               00:00.0
  Tag           0x00
  Last DW BE    0000b                must be zero for 1 DW write
  First DW BE   1111b                all 4 bytes in DW enabled
  Address       0x95e7f000
  Data          0x00000000

So I think this is a 32-bit write of zero to PCI bus address
0x95e7f000.

Your dmesg log says:

  pci 0000:02:00.0: PCI bridge to [bus 03]
  pci 0000:02:00.0:   bridge window [mem 0x95e00000-0x95ffffff]
  pci 0000:03:00.0: reg 0x24: [mem 0x95e00000-0x95efffff]
  [drm] register mmio base: 0x95E00000

So this looks like a write to the device's BAR 5.  I don't see a PCI
reason why this should fail.  Maybe there's some amdgpu reason?

Bjorn
