Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A185761B7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiGOMca convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 15 Jul 2022 08:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGOMc3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 08:32:29 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D1713D65;
        Fri, 15 Jul 2022 05:32:28 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31bf3656517so45209557b3.12;
        Fri, 15 Jul 2022 05:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OjxnZb7meHcqrP1kpVMixA9ZvzRnaNtGWdUlQK9VV+M=;
        b=GNQt0nYETwGug4NvYtq1njmDLF2jzfDzbYnBo/R+pBumV2+qYNqIwcjYXDskUZ8rGo
         MjDWGSIu5xK5Wm2wEj0fGAWbH3qRn19N5aUNLMm58Tzxy+aBKJ2e/eISNklxr9FrQiDn
         MzqhJ+pqrAIAfzQrfvBGAlyxuo9dY2+Pakcw+d6jVKy/C35DGB1JfATEJ/6O3KQ4O14n
         JigHaXRwzcAx+YDzOnj3f5z45uDwiyR84HQTF55S4+kOfpt+g7zZESZf5p9hJZdzhpz+
         9KgLLLvxuAHwFK5pCWUdM1jcY2YDHAlCQ1uEG4lU2ids3x/8mPgLYgPwuNY/J+EtSbii
         P0RA==
X-Gm-Message-State: AJIora+lv/3ZYlykD76T0vrdoNNKe/h5ePE2dNViWg8A6VAFtsKEKYEw
        OhSw+4OTeIcYe03SCKt2RyK8YPph1VgR2yNcQln5fEcOeeA=
X-Google-Smtp-Source: AGRyM1s++VDNfV3ZtENKhzMx6BK4IlNXSALHoNcFxPJGeuFyVGgf3QqnXWE9Kej9RrfsQd8N01hZjKxD6oq5n1kNOR0=
X-Received: by 2002:a81:17d0:0:b0:31c:c5e2:fc1e with SMTP id
 199-20020a8117d0000000b0031cc5e2fc1emr15917280ywx.196.1657888347705; Fri, 15
 Jul 2022 05:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220713112612.6935-1-limanyi@uniontech.com> <20220713182852.GA841582@bhelgaas>
 <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com>
 <7305201c-eaf2-cb36-80fe-15174d3e33c7@uniontech.com> <20220715082945.GA10661@srcf.ucam.org>
 <c8498fc1-854f-efdc-bbc8-3de67dcf6430@uniontech.com> <20220715093236.GA12020@srcf.ucam.org>
 <62d14039.1c69fb81.86d3c.71c2SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <62d14039.1c69fb81.86d3c.71c2SMTPIN_ADDED_BROKEN@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 14:32:16 +0200
Message-ID: <CAJZ5v0hQezrqP8W0GBs8edqTLxZ=ZBmqYsevn57PUgnEDf0EXg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
To:     Manyi Li <limanyi@uniontech.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 12:23 PM Manyi Li <limanyi@uniontech.com> wrote:
>
>
>
> On 2022/7/15 17:32, Matthew Garrett wrote:
> > On Fri, Jul 15, 2022 at 05:19:25PM +0800, Manyi Li wrote:
> >>
> >>
> >> On 2022/7/15 16:29, Matthew Garrett wrote:
> >>> On Fri, Jul 15, 2022 at 03:40:36PM +0800, Manyi Li wrote:
> >>>
> >>>> Please see the details of this issus:
> >>>> https://bugzilla.kernel.org/show_bug.cgi?id=216245
> >>>
> >>> Hmm. The only case where changing aspm_support_enabled to false should
> >>> matter is in pcie_aspm_init_link_state(), where it looks like we'll
> >>> potentially rewrite some registers even if aspm_disabled is true. I
> >>> think in theory we shouldn't actually modify anything as a result, and
> >>> the lspcis from the bug don't show any ASPM values having changed, but I
> >>> don't trust Realtek hardware in the general case so maybe it gets upset
> >>> here? If the proposed patch is to just set aspm_support_enabled to false
> >>> when we see the FADT bit set then I think this is fine.
> >>>
> >>
> >> "aspm_support_enabled" alse be used in calculate_support():
> >> if (pcie_aspm_support_enabled())
> >>      support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> >> When set OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT, cause this AER
> >> issue. I want don't set OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT when
> >> we see the FADT bit set.
> >
> > Oh hm. Are you sure it's the OSC call that breaks it? I have some
>
> I don't sure.
>
> > recollection that I verified the behaviour of Windows here, but it's
> > been over 10 years since I touched this so I could well be wrong. I can
> > try to set up a test env to verify the behaviour of Windows when it
> > comes to _OSC if the FADT says ASPM is unsupported.
> >
> but, I did a test，this modification also solves the problem:
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d57cf8454b93..b3ea8e886d7c 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -494,8 +494,8 @@ static u32 calculate_support(void)
>          support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
>       if (pci_ext_cfg_avail())
>               support |= OSC_PCI_EXT_CONFIG_SUPPORT;
> -    if (pcie_aspm_support_enabled())
> -            support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> +//  if (pcie_aspm_support_enabled())
> +//          support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>       if (pci_msi_enabled())
>               support |= OSC_PCI_MSI_SUPPORT;
>       if (IS_ENABLED(CONFIG_PCIE_EDR))
>
> This issue occur in the Notebook: ASUSTeK COMPUTER INC. X456UJ
> (ASUS-NotebookSKU) Notebook
>
> log "AER: Corrected error received: 0000:00:1c.5" is in the device:
> 00:1c.5 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
> Express Root Port #6 [8086:9d15] (rev f1)

So it looks like the BIOS sets ACPI_FADT_NO_ASPM and then happily
grants control of ASPM via _OSC.  That's somewhat contradictory.

I would rather look at adjusting pcie_aspm_sanity_check() to this case
instead of wholesale changing the way _OSC is handled at the host
bridge level.
