Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910224FEBE7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiDMAWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 20:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiDMAWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 20:22:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26443383
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 17:19:43 -0700 (PDT)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7BA423F6FE
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 00:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1649809180;
        bh=Av2vidYT+scYaugnqXMT68dvLkZMawKIoL93FWxX1Aw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=a4n9gNLkVuKLgIiJhf06YNCCX7asFTx00SiVj+ju9Fm8co+CgfQMpRUGQbjIF4yyq
         DMvrdoP+yLfnGoluulMeV8c0zUdYWU4ZalXClq45VkKR+2s5fq6zo/baKdq0Z3MiMs
         IPO74Jn3Xxa57Eq9Hgf369Ia3PCC19tSxAzCoW6hB31Cn97K6k6R2rbCVZYzIYEK1W
         lKCqrAt5KWuGVZz1h97u5wrbsbPgMjC4pc8VMZiJSMFRFGfy4/n40I7XKSjaOuKV5g
         Z4QJyXq91yj1qH82UCGKl53sAkIe4Qr/Zi2RthyCkjcst43UWAvy1sSNBvaCxKPl4I
         TAOPDT7RdpYrw==
Received: by mail-oo1-f69.google.com with SMTP id z25-20020a4a6559000000b003247904266fso306967oog.1
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 17:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Av2vidYT+scYaugnqXMT68dvLkZMawKIoL93FWxX1Aw=;
        b=IrZh3VkGG0a1CqR+ErcpCV0JqIRFJnAm6FT+JvybI2S0NyUlHb3rw5BDAI25e1/g35
         d5UPDrcX6ftLBMauXL/rbHM6oQFc4tNKJaJZPvpvRo0XLDsV0NalonSsBXsuejNeuQhL
         cZnD8LlBa28AqLS0jtpTudl4iYSRh/lwgPxlXHA6bt3x5sRJuxjGRqB0jCuAOepRp1JR
         FQGjC5gnCtfcG2Iw6FagWg9O1fg8MgKTnniU10aPK3H3VFPxrgdwRegOH28ElSDKz/Ga
         teQyzM9ehc3dQNS37l7LiTKBO8mWQBNRNB39LQeANcTYTIApahk8pnPkPHPsbpYTxwKf
         tMqA==
X-Gm-Message-State: AOAM530zkmObkzgPiHZ4FL1tlTj60EBM8yVpbzSumB80N5sEBYOC0wEE
        nzx88eBpDYIULaot+6Jyh9wAt8ZPOci+rrMaF8Ue0qQ77fdFIXW7sH8mkU8xL2GMPlRtYOGeJMN
        g0RdIpVWAELGRgCqyJoTu0iXLlA3g7TE3r99etqGn8HZGn3auYiNQ9g==
X-Received: by 2002:aca:2b0d:0:b0:2d9:dc99:38a2 with SMTP id i13-20020aca2b0d000000b002d9dc9938a2mr2815433oik.198.1649809179143;
        Tue, 12 Apr 2022 17:19:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsF5IH7sAR4VoxIIVUUP1QoENI3Xj6hxHJCDmxv5qwsYdCK85Gr2XEbOINsjnAOr7vSlvpFgwBGbvnnfQUWXU=
X-Received: by 2002:aca:2b0d:0:b0:2d9:dc99:38a2 with SMTP id
 i13-20020aca2b0d000000b002d9dc9938a2mr2815409oik.198.1649809178769; Tue, 12
 Apr 2022 17:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <0d8cc8c0-31a1-0290-5aa5-0c7b16db1edb@nvidia.com> <20220412225047.GA627910@bhelgaas>
In-Reply-To: <20220412225047.GA627910@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 13 Apr 2022 08:19:26 +0800
Message-ID: <CAAd53p4r1v_sN=8kv_fOx_VEb3k=4rU9iw52LfmEHO1crnms=g@mail.gmail.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "Kenneth R. Crudup" <kenny@panix.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        chris.packham@alliedtelesis.co.nz, yangyicong@hisilicon.com,
        treding@nvidia.com, jonathanh@nvidia.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Ricky Wu <ricky_wu@realtek.com>,
        Rajat Jain <rajatja@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Victor Ding <victording@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 13, 2022 at 6:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Ricky for rtsx_pci ASPM behavior, Rajat, Prasad for L1 SS stuff,
> Victor for interest in disabling ASPM during save/restore]
>
> On Wed, Feb 16, 2022 at 06:41:39PM +0530, Vidya Sagar wrote:
> > On 2/16/2022 11:30 AM, Kenneth R. Crudup wrote:
> > > On Wed, 16 Feb 2022, Vidya Sagar wrote:
> > >
> > > > I see that the ASPM-L1 state of Realtek NIC which was in
> > > > disabled state before hibernate got enabled after hibernate.
> > >
> > > That's actually my SD-Card reader; there's a good chance the BIOS
> > > does "something" to it at boot time, as it's possible to boot from
> > > SD-Card on my laptop.
> > >
> > > > This patch doesn't do anything to LnkCtl register which has
> > > > control for ASPM L1 state.
> > >
> > > > Could you please check why ASPM L1 got enabled post hibernation?
> > >
> > > I wouldn't know how to do that; if you're still interested in that
> > > let me know what to do to determine that.
>
> > I would like Bjorn to take a call on it.
> > At this point, there are contradictions in observations.
>
> Remind me what contradictions you see?  I know Kenny saw NVMe errors
> on a kernel that included 4257f7e008ea ("PCI/ASPM: Save/restore L1SS
> Capability for suspend/resume") in December 2020 [1], and that he did
> *not* see those errors on 4257f7e008ea in February 2022 [2].  Is that
> what you mean?
>
> > Just to summarize,
> > - The root ports in your laptop don't have support for L1SS
> > - With the same old code base with which the errors were observed plus my
> > patch on top of it, I see that ASPM-L1 state getting enabled for one of the
> > endpoints (Realtek SD-Card reader) after system comes out of hibernation
> > even though ASPM-L1 was disabled before the system enter into hibernation.
> > No errors are reported now.
>
> I assume you refer to [2], where on 4257f7e008ea ("PCI/ASPM:
> Save/restore L1SS Capability for suspend/resume"), Kenny saw ASPM L1
> disabled before hibernate and enabled afterwards:
>
>   --- pre-hibernate
>   +++ post-hibernate
>     00:1d.7 PCI bridge [0604]: Intel [8086:34b7]
>       Bus: primary=00, secondary=58, subordinate=58
>         LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>     58:00.0 RTS525A PCI Express Card Reader [10ec:525a]
>   -     LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
>   -             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>   +     LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk-
>   +             ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>
> Per PCIe r6.0, sec 7.5.3.7, "ASPM L1 must be enabled by software in
> the Upstream component on a Link prior to enabling ASPM L1 in the
> Downstream component on that Link," so this definitely seems broken,
> but wouldn't explain the NVMe issue.
>
> The PCI core (pcie_config_aspm_link()) always enables L1 in the
> upstream component before the downstream one, but 58:00.0 uses the
> rtsx_pci driver, which does a lot of its own ASPM fiddling, so my
> guess is that it's doing something wrong here.
>
> > - With the linux-next top of the tree plus my patch, no change in the ASPM
> > states and no errors also reported.
>
> I don't know which report this refers to.
>
> > This points to BIOS being buggy (both old and new with new one being less
> > problematic)
>
> I agree that a BIOS change between [1] and [2] seems plausible, but I
> don't think we can prove that yet.  I'm slightly queasy because while
> Kenny may have updated his BIOS, most people will not have.
>
> I think we should try this patch again with some changes and maybe
> some debug logging:
>
>   - I wonder if we should integrate the LTR, L1 SS, and Link Control
>     ASPM restore instead of having them spread around through
>     pci_restore_ltr_state(), pci_restore_aspm_l1ss_state(), and
>     pci_restore_pcie_state().  Maybe a new pci_restore_aspm() that
>     would be called from pci_restore_pcie_state()?
>
>   - For L1 PM Substates configuration, sec 5.5.4 says that both ports
>     must be configured while ASPM L1 is disabled, but I don't think we
>     currently guarantee this: we restore all the upstream component
>     state first, and we don't know the ASPM state of the downstream
>     one.  Maybe we need to:
>
>       * When restoring upstream component,
>           + disable its ASPM
>
>       * When restoring downstream component,
>           + disable its ASPM
>           + restore upstream component's LTR, L1SS
>           + restore downstream component's LTR, L1SS
>           + restore upstream component's ASPM
>           + restore downstream component's ASPM

Right now L1SS isn't reprogrammed after S3, and that causes WD NVMe
starts to spew lots of AER errors.
So yes please restore L1SS upon resume. Meanwhile I am asking vendor
_why_ restoring L1SS is crucial for it to work.

I also wonder what's the purpose of pcie_aspm_pm_state_change()? Can't
we just restore ASPM bits like other configs?

Kai-Heng

>
>       This seems pretty messy, but seems like what the spec requires.
>
>     - Add some pci_dbg() logging of all these save/restore values to
>       help debug any issues.
>
> Bjorn
>
> [1] https://lore.kernel.org/r/20201228040513.GA611645@bjorn-Precision-5520
> [2] https://lore.kernel.org/r/3ca14a7-b726-8430-fe61-a3ac183a1088@panix.com
