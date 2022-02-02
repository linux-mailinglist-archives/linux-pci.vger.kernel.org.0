Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18AE4A69D4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 03:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiBBCGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 21:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiBBCGf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 21:06:35 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0CC061714
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 18:06:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o64so18900827pjo.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 18:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8NaK6sogIQ9vr23uq3ONCRZOGt+JDgbjU55p0WZp4U=;
        b=bfP6aLccvV4nBE91AzyhEB+9wzkc3lnTdeQz2pDYN+pboTQ/PNybvwrn+LpcyKBBxv
         KeWaA+rToyLUpVDwgxI7FDgZtJGZOoMSTMPsXpPVcPiqQyWtb2hOp8ZCp27GHqDI6sb1
         0GOVrybLfDhc8lgnSrII4ufgbX/XH6ixzM7lF3uFWj44zEQ6yJZwv6q+szt45nm91d7m
         X8DZr01oeCBpXuNWL4yP263MF73rs3FBn5OxE7LQ/rCISl86epCO1jHqvAJ9uqZNIU6H
         PXs1dzc2aqAO/WtzZGqCliKcS+jd6L2aiYOnXmSA0C6GFVrXo8k8BeNRgHnxGVTJFO+c
         B1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8NaK6sogIQ9vr23uq3ONCRZOGt+JDgbjU55p0WZp4U=;
        b=mnZmB2yNhHcz8ZJRd9+gzSGmU5KwygQieXGu1pT4DdptBRTVSx8OFfZt2XR56/Qcm6
         QqyY/dO1XxW4wth+PrquVtvIzWWChP63wncPH1G4sSivLPpuGMpFRagN77dcXbdNgLx5
         J5oegSOi1hRHORWnZKPHLAuQuLpL1JOGJaaTqmJjj1eWWVKozvO4rWipWfPKP5QoW0iG
         eCZG7ZuCcgnAlUr/ahOZ+g7X/qQuvGVqm4AcmFXlOyrytDxfErMqhh1kVaNYmOqWNMao
         CA8fDNtbLVNXI+9wLkVIlOaOKJZ1aqh761V5B0TAcMrCewRNb93cLE9vHeHpqz/yjvF7
         upJQ==
X-Gm-Message-State: AOAM532zKG8wdDgOy+aVievGOlFhEIypLa8mS8NHKkjL5BQ8SdXVnAe7
        cJIO0Fe2Z1BAZg+Cl+Wy4aIcjL+5jUfmMFRYv+FvLQ==
X-Google-Smtp-Source: ABdhPJx0554lrOHB07UdrxMgw1RFi/OP2MSvhvTbPt2YwPByF5SP+JUPDvszH7looKd1nhnBvBbvijrznsTw/Kwt9XI=
X-Received: by 2002:a17:902:ced2:: with SMTP id d18mr28827516plg.21.1643767594601;
 Tue, 01 Feb 2022 18:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20220121214117.GA1154852@bhelgaas> <Ye5GvQbFKo+CFtRb@lahna>
 <Ye/X7E2dKb+zem34@lahna> <Ye/btvA1rLB2rp02@kroah.com> <Ye/zTHR5aCG58z87@lahna>
 <CAJZ5v0gitdeEAxcgSoB1=VHA9FnRdCtmUqA_cN_f1a2yFRDghQ@mail.gmail.com>
 <CACK8Z6H2DLTJgxgS3pcvfOh=5S8cxEMKvwEPfB9zoVf1g2H_UQ@mail.gmail.com>
 <YfOf2X7Snm7cvDRV@lahna> <CACK8Z6FMgc5UQY-ZGB9sKYR5Wt6L6huTnEKZaFyVRAmDmQt9XQ@mail.gmail.com>
 <CAJZ5v0iuM_qjhPxvhzgvtKM-4pBB2skf9G=R=Qo6NzKnZ2LN=w@mail.gmail.com>
 <YfeEoF35RPDVMdzD@lahna> <CACK8Z6EBbdPHhMtD+vMWs54GRw-ChCeNNfeKM4Hk5JcAqex6hg@mail.gmail.com>
In-Reply-To: <CACK8Z6EBbdPHhMtD+vMWs54GRw-ChCeNNfeKM4Hk5JcAqex6hg@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 1 Feb 2022 18:05:58 -0800
Message-ID: <CACK8Z6ET81wSUu_kyMHx88OUPvicMoxMejYp_0vwRGP75urFrQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 11:57 AM Rajat Jain <rajatja@google.com> wrote:
>
> Hello Mika, Rafael,
>
> On Sun, Jan 30, 2022 at 10:42 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Sun, Jan 30, 2022 at 03:30:39PM +0100, Rafael J. Wysocki wrote:
> > > > I'm open to doing so if the others also feel the same way. IMHO
> > > > though, the semantics of ACPI "DmaProperty" differ from the semantics
> > > > of the property I'm proposing here.
> > > >
> > > > The current (documented) semantics (of "DmaProperty"): *This device
> > > > (root port) is trusted*, but any devices downstream are not to be
> > > > trusted.
> > > >
> > > > What I need and am proposing (new "UntrustedDevice"): *This device as
> > > > well as any downstream devices* are untrusted.
> > > >
> > > > Note that there may be firmware implementing "DmaProperty" already out
> > > > there (for windows), and if we decide to use it for my purposes, then
> > > > there shall be a discrepancy in how Linux uses that property vs
> > > > Windows. Is that acceptable?
> > >
> > > It may be confusing, so I'd rather not do that.
> > >
> > > The platform firmware will use it with the Windows use case in mind
> > > and if it has side effects in Linux, problems are likely to appear in
> > > the field.
> > >
> > > So the question is rather not about it being acceptable, but about
> > > whether or not this is generally going to work.
> >
> > I was kind of implying that we could perhaps contact Microsoft and ask
> > them if the wording could be changed to cover all the devices, not just
> > PCIe root ports. I think this is something they will also need for
> > things like internal WI-FI controllers.
>
> We (Chromeos) do not have a contact at Microsoft, not sure if Intel
> does. If someone can point me to a contact I will be happy to initiate
> a conversation. However, given that they have already published it,
> and changing the semantics might mean they will also have to change
> windows implementation. Not sure if we have enough leverage with
> Microsoft here, so I wouldn't have any high hopes though.

To keep everyone updated, Mika has helped me initiate a conversation
with Microsoft on this (Thanks a lot Mika!). We're still waiting to
hear their feedback. Until then, I've posted a v2 for review at:
https://patchwork.kernel.org/project/linux-pci/patch/20220202020103.2149130-1-rajatja@google.com/

If we can reach an agreement with Microsoft, I can change the property
name in the patch (to "DmaProperty"), but would appreciate review of
any other aspects of v2 in the meantime.

Thanks & Best Regards,

Rajat


> Like Rafael
> said, we're on the receiving end here.
>
> Rafael, one last question: is "untrusted-device" an acceptable ACPI
> property name, or does it have to be Camel case?
>
> Thanks & Best Regards,
>
> Rajat
>
> >
> > If that's not possible then no objections adding "UntrustedDevice". We
> > just need to deal with the "DmaProperty" anyway and both end up setting
> > pdev->untrusted in the similar manner.
