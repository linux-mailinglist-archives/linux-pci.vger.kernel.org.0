Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A673F576139
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiGOMYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 08:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGOMYx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 08:24:53 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77C1814A5;
        Fri, 15 Jul 2022 05:24:52 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id c131so7450326ybf.9;
        Fri, 15 Jul 2022 05:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QmoyCDeaSy0Y4BLqpZD4hIwfUSZvp3gh3g/tY1Os7n4=;
        b=gHFfYJP3+22pnwC9WvkQlHarRgfcdYInwlGU1bnz9uD3CixVb6osL36HpZ0aLtf/D5
         jjdBX6piorRS0N1o7y/Zh56o2O+mQvlJAwsAeo1r8qZPjLw6z3eGM3BcVLr1QuGjVs5x
         5kNsFhY3pOvQ/pDOWprn8JYKil5tkxgeZcIl/+DKkBF9VP09SfMHm59Fl09z4uG16sp0
         0WRFjfSw+yC36Lb6Z8CFeY6vfY0zBjEX0NmAFLae9ifmChj+WGhwWOsD8UzOKKwveLHK
         Za/m4/nH2FKq7v5feqIVqP0p6vGY08zjAufK6ES3JUTOff7AXgJ0I5Yrba3irFBgW4Wo
         uHqw==
X-Gm-Message-State: AJIora8WFd7aWvPFCrsYl7spBGGI2kFumjVWfHTmdCBYDeIhHgAVAi6t
        8JDaf8lsd3apwLpKSvSPsMtIL9TxmrHwLX0LSw4=
X-Google-Smtp-Source: AGRyM1vG21oV6A3QVXCpfotTxqB0C9JWJCppfsJ2Qa/5lcfLJFdYGFVVBzPo5GqWOzeTNBCmOw1/cf33RQTxQUYfxFo=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr13225660ybm.482.1657887891874; Fri, 15
 Jul 2022 05:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220713112612.6935-1-limanyi@uniontech.com> <20220713182852.GA841582@bhelgaas>
 <CAAd53p7g2Md73=UU6Rp-TZkksc+H02KAX58bWCzsgQ__VwvJ+g@mail.gmail.com> <62d11a02.1c69fb81.ee60c.b0efSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <62d11a02.1c69fb81.ee60c.b0efSMTPIN_ADDED_BROKEN@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 14:24:39 +0200
Message-ID: <CAJZ5v0gKMqOwg3JLx4PBksnpUhgaDDfahmE5RjJMTByOLAQOFg@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
To:     Manyi Li <limanyi@uniontech.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 9:40 AM Manyi Li <limanyi@uniontech.com> wrote:
>
>
>
> On 2022/7/14 11:20, Kai-Heng Feng wrote:
> > [+Cc Matthew]
> >
> > On Thu, Jul 14, 2022 at 2:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >> [+cc Kai-Heng, Vidya, who also have ASPM patches in flight]
> >>
> >> On Wed, Jul 13, 2022 at 07:26:12PM +0800, Manyi Li wrote:
> >>> Startup log of ASUSTeK X456UJ Notebook show:
> >>> [    0.130563] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> >>> [   48.092472] pcieport 0000:00:1c.5: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> >>> [   48.092479] pcieport 0000:00:1c.5:   device [8086:9d15] error status/mask=00000001/00002000
> >>> [   48.092481] pcieport 0000:00:1c.5:    [ 0] RxErr
> >>> [   48.092490] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> >>> [   48.092504] pcieport 0000:00:1c.5: AER: can't find device of ID00e5
> >>> [   48.092506] pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
> >>
> >> Can you elaborate on the connection between the FADT ASPM bit and the
> >> AER logs above?
>
> Sorry,I don't know about that.
>
> >>
> >> What problem are we solving here?  A single corrected error being
> >> logged?  An infinite stream of errors?  A device that doesn't work at
> >> all?
> >
> > Agree, what's the real symptom of the issue?
>
> Please see the details of this issus:
> https://bugzilla.kernel.org/show_bug.cgi?id=216245
>
> >
> >>
> >> We don't need the dmesg timestamps unless they contribute to
> >> understanding the problem.  I don't think they do in this case.
> >
> > According to commit 387d37577fdd ("PCI: Don't clear ASPM bits when the
> > FADT declares it's unsupported"), the bit means "just use the ASPM
> > bits handed over by BIOS".
> >
> > However, I do wonder why both drivers/pci/pci-acpi.c and
> > drivers/acpi/pci_root.c are doing the ACPI_FADT_NO_ASPM check,

Because pci_root.c doesn't read aspm_disabled.

> > maybe one of them should be removed?

Arguably, pci_root.c could look at aspm_disabled instead of looking at
the FADT flag directly.

> I think duplicate work has been done, but comment
> in drivers/acpi/pci_root.c is
> * We want to disable ASPM here, but aspm_disabled
> * needs to remain in its state from boot so that we
> * properly handle PCIe 1.1 devices.  So we set this
> * flag here, to defer the action until after the ACPI
> * root scan.
>
> I don't understand this logic.

This is about the case after failing acpi_pci_osc_control_set() and
generally we need to defer setting aspm_disabled because of
pcie_aspm_sanity_check().

> >
> >>
> >>> Signed-off-by: Manyi Li <limanyi@uniontech.com>
> >>> ---
> >>>   drivers/pci/pcie/aspm.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> >>> index a96b7424c9bc..b173d3c75ae7 100644
> >>> --- a/drivers/pci/pcie/aspm.c
> >>> +++ b/drivers/pci/pcie/aspm.c
> >>> @@ -1359,6 +1359,7 @@ void pcie_no_aspm(void)
> >>>        if (!aspm_force) {
> >>>                aspm_policy = POLICY_DEFAULT;
> >>>                aspm_disabled = 1;
> >>> +             aspm_support_enabled = false;
> >>
> >> This makes pcie_no_aspm() work the same as booting with
> >> "pcie_aspm=off".  That might be reasonable.
> >>
> >> I do wonder why we need both "aspm_disabled" and
> >> "aspm_support_enabled".  And I wonder why we need to set "aspm_policy"
> >> when we're disabling ASPM.  But those aren't really connected to your
> >> change here.
> >
> >  From what I can understand "aspm_disabled" means "don't touch ASPM
> > left by BIOS", and "aspm_support_enabled" means "whether ASPM is
> > disabled via command line".
> > There seems to be some overlaps though.
>
> According to commit 8b8bae901ce23 ("PCI/ACPI: Report ASPM support to
> BIOS if not disabled from command line"), "aspm_support_enabled" means
> whether or not report ASPM support to the BIOS through _OSC.

Right.
