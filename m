Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74B3509747
	for <lists+linux-pci@lfdr.de>; Thu, 21 Apr 2022 08:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiDUGTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Apr 2022 02:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiDUGTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 02:19:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6AB1EA
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 23:16:46 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 23CEE3F1C4
        for <linux-pci@vger.kernel.org>; Thu, 21 Apr 2022 06:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650521804;
        bh=4rIquQnSrrUbcKOnnaDzSBZiVnXkNjP1A1/q1C21TSs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Sz6YMc0A0CKjAqWwpxlLOsChDZRKoSduwNWtgRlwZvuOfH8Go28m4OohiVRLZj7Vl
         B/wXZi3hYh3AewgnRLzuG+XYUy7ygs9vtFm374QFz6Kc7OZKFWhbqWEqojkSgfQgtc
         rIKE5OEQ0id/4yuT4QGRCzyWLDzwDIJkA8vhwTQvnlEJB0e6bqCeoGMSpPbp4/W/nZ
         +POjFEhw3MnlTgsOojPI712wNPk/m/pGiq7MSoMAiPmMp6kHhNBGII92dTdntWRbRh
         1XwPVkwjjulnAgjx0a6VREpYuVqCL4eM4UhhlMohXtfr0I11EZc/7DUNt3ZfXrApaa
         R1TZxFSM7YvnA==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-d39f735dc3so1675128fac.21
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 23:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rIquQnSrrUbcKOnnaDzSBZiVnXkNjP1A1/q1C21TSs=;
        b=oxcv9BohJYRJb5+lXaqhgw6Sew+Wz9J3/qEb3P+sx7Yu33UvLefeZn7qH7YyLhjoay
         P9YEYVWaX7meLuzZzE6Oic682a5fXgLYbfAxHev/RQCP56rCmdC1x9Oh1Te07Da4B0wo
         tRt4NIAvPlMN5CEkCCLtf2Y8XKgH/FMo9h1GVhEK3JXwZX6P/O9b74SzeTJyKV3nZEra
         ROdOOc1s4f1YE9XhVG2vh5GFKuiqIcNHG9kKBRaG0nj13LoaqVh5CNQCckXSKc6veT/c
         G5wqxTOk2nYWFoODbWEmu/Tdkc+NzKSoFfgqdDlwNWB8CsVo1xm0xmI7LHy7TFitfvS8
         JSng==
X-Gm-Message-State: AOAM531X4xdz+dnva9YirWexQtHq063+aL6aZu8XxWCcOrX2B3xY22W0
        v/xm+Fg93Xswn5qEBhLrRCrYRvVoUBLjOFDA1/hcKvEPU6+mwUIOfHpfMi90XakppRkRDyFOC28
        X2TC9Gmkh80vaA3IhrBSA7NvS8daFBTAhNn8gKwuFHco+akm+/2Af1Q==
X-Received: by 2002:a9d:7603:0:b0:605:5078:69 with SMTP id k3-20020a9d7603000000b0060550780069mr5395422otl.269.1650521802883;
        Wed, 20 Apr 2022 23:16:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCNA8XcD5V5QoiDwf06vQV9VRrHk+sxaun0nN5hpwSl8XQIwhBA52+WCfQnkLejNKzN1rC6Iz2plhTlsOk6Jk=
X-Received: by 2002:a9d:7603:0:b0:605:5078:69 with SMTP id k3-20020a9d7603000000b0060550780069mr5395413otl.269.1650521802610;
 Wed, 20 Apr 2022 23:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6DX2C7KVRV=uu_mmPTTjE7=RsXfNPxjbOBLRbf-pXi5A@mail.gmail.com>
 <20220415212533.GA844147@bhelgaas>
In-Reply-To: <20220415212533.GA844147@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Apr 2022 14:16:29 +0800
Message-ID: <CAAd53p6jh7Jx3pzg9TzrSrW8+3pzLN6EBAFjFv+7T4tMODmX+g@mail.gmail.com>
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
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 16, 2022 at 5:25 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Apr 15, 2022 at 10:26:19PM +0800, Kai-Heng Feng wrote:
> > On Fri, Apr 15, 2022 at 12:41 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Apr 13, 2022 at 08:19:26AM +0800, Kai-Heng Feng wrote:
> > > > On Wed, Apr 13, 2022 at 6:50 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > ...
> > >
> > > > >   - For L1 PM Substates configuration, sec 5.5.4 says that both ports
> > > > >     must be configured while ASPM L1 is disabled, but I don't think we
> > > > >     currently guarantee this: we restore all the upstream component
> > > > >     state first, and we don't know the ASPM state of the downstream
> > > > >     one.  Maybe we need to:
> > > > >
> > > > >       * When restoring upstream component,
> > > > >           + disable its ASPM
> > > > >
> > > > >       * When restoring downstream component,
> > > > >           + disable its ASPM
> > > > >           + restore upstream component's LTR, L1SS
> > > > >           + restore downstream component's LTR, L1SS
> > > > >           + restore upstream component's ASPM
> > > > >           + restore downstream component's ASPM
> > > >
> > > > Right now L1SS isn't reprogrammed after S3, and that causes WD NVMe
> > > > starts to spew lots of AER errors.
> > >
> > > Right now we don't fully restore L1SS-related state after S3, so maybe
> > > there's some inconsistency that leads to the AER errors.
>
> > > Could you collect the "lspci -vv" state before and after S3 so we can
> > > compare them?
> > >
> > > > So yes please restore L1SS upon resume. Meanwhile I am asking vendor
> > > > _why_ restoring L1SS is crucial for it to work.
> > > >
> > > > I also wonder what's the purpose of pcie_aspm_pm_state_change()? Can't
> > > > we just restore ASPM bits like other configs?
> > >
> > > Good question.  What's the context?  This is in the
> > > pci_raw_set_power_state() path, not the pci_restore_state() path, so
> > > seems like a separate discussion.
> >
> > Because this patch alone doesn't restore T_PwrOn and LTR1.2_Threshold.
>
> I assume the post-S3 path is basically this:
>
>   pci_pm_resume_noirq
>     pci_pm_default_resume_early
>       pci_power_up
>         pci_raw_set_power_state(D0)
>           pcie_aspm_pm_state_change
>             pcie_config_aspm_path
>               pcie_config_aspm_link
>                 pcie_config_aspm_l1ss
>                   clear PCI_EXP_LNKCTL_ASPM_L1 etc
>                   set PCI_L1SS_CTL1_ASPM_L1_1 etc
>                 pcie_config_aspm_dev
>                   set PCI_EXP_LNKCTL_ASPM_L1 etc
>       pci_restore_state
>         pci_restore_ltr_state
>         pci_restore_aspm_l1ss_state     # after this patch
>         pci_restore_pcie_state
>
> Hmm...  I think I see what you're saying.  pcie_aspm_pm_state_change()
> fiddles with ASPM and L1SS enable bits.  It likely disables L1,
> enables L1SS, enables L1, but never restores the LTR capability or the
> T_PwrOn and LTR1.2_Threshold bits you mention.
>
> Then we turn around and overwrite all that stuff (and the LTR cap) in
> pci_restore_state().  That all seems fairly broken, and I agree, I
> don't know why pcie_aspm_pm_state_change() exists.

I went through the whole discussion again, maybe Kenneth's case is
also the result of pcie_aspm_pm_state_change()?
Since Kenneth is using TLP to switch ASPM between performance and
powersaving/powersupersaving, that means 'aspm_disabled' is false.
Hence the KOXIA NVMe stops working post suspend and Realtek card
reader toggles L1ss post hibernation.

Kenneth, can you please see if removing pcie_aspm_pm_state_change()
from pci_raw_set_power_state() helps?

Anyway, this can be easier to spot if dmesg was attached.

>
> > So I forced the pcie_aspm_pm_state_change() calling path to eventually
> > call aspm_calc_l1ss_info() which solved the problem for me.
>
> This would update T_PwrOn and LTR1.2_Threshold, so I guess it makes
> sense that this would help.  But I think we need to figure out the
> reason why pcie_aspm_pm_state_change() exists and get rid of it or at
> least better integrate it with pci_restore_state().
>
> If we call pcie_aspm_pm_state_change() after D3cold or reset, things
> still aren't going to work because the LTR cap isn't restored or
> programmed.

More than that, the ASPM sysfs won't be restored correctly after
resume [1] because of it.
So I'd like to post a patch to drop pcie_aspm_pm_state_change() if
there's no objection.

[1] https://lore.kernel.org/linux-pci/20211021035159.1117456-2-kai.heng.feng@canonical.com/

Kai-Heng
