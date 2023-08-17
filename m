Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685DD77F627
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjHQMOU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 17 Aug 2023 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350735AbjHQMNv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:13:51 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245432727;
        Thu, 17 Aug 2023 05:13:46 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-56d0deeca09so1156057eaf.0;
        Thu, 17 Aug 2023 05:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692274425; x=1692879225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35lrfKrc1jJmS1GksDSgsQkAe1/qYH5sZbvlKzuw6F0=;
        b=ECq5Upo1NVakeioVKkf4Eaz2FG32K0uK9235hXLK58V8HYC8PBOyyL6FpKDGmQJlNd
         +vWmi17+mZogE24FxSGmEAQjHp96wF86I1S6OHz7MhIUV07jsRbjZve7ES7RRWvJc+yk
         irpWRO4QCcRrOVg6soFW0DT8c3JwvmaF+UFKo90yj5uhIVQl43e+IvzkkQnZtZpVCwlq
         m/um7APIfGIvEkx/ZKngVSdeKyRfWCatYifSYG1q45i1ZGTXiDiUi25YccI423vBTSAx
         6iKJG4/LwjHeNpkzrZMmghrCy403Rm/w3xt4G1tFzo1QRumdftV/mmBWlLZFoRAVHLwA
         Rj3g==
X-Gm-Message-State: AOJu0Yx9S9UzXwRaiSnIHb9lQE69D2abZOcJMncmvtOA1HoEwo+McTqV
        L3vmJgvUPo0RVxRfTPx10TQflxagTUGnG/VmU2U=
X-Google-Smtp-Source: AGHT+IEV3ZsCfY4D+eopVMXtQI0RCA0Ekyx5phmY3CkyIpLxnRc2AVJnQUHO4M1WGy62fNAG/4g5UuQsIu+ujKdgtf0=
X-Received: by 2002:a4a:4305:0:b0:56e:72e0:9c5f with SMTP id
 k5-20020a4a4305000000b0056e72e09c5fmr1435739ooj.1.1692274425389; Thu, 17 Aug
 2023 05:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230816223831.GA291481@bhelgaas> <6a91a3e1-61a2-4f33-ae01-ea4b5ad24ec6@amd.com>
In-Reply-To: <6a91a3e1-61a2-4f33-ae01-ea4b5ad24ec6@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 14:13:34 +0200
Message-ID: <CAJZ5v0i46b2th2iATB-Zsfhexcva8h_KAxYtUsGDHS_3zXnn-Q@mail.gmail.com>
Subject: Re: [PATCH v11 9/9] PCI: ACPI: Use device constraints to decide PCI
 target state fallback policy
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 17, 2023 at 3:26 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
>
> On 8/16/2023 5:38 PM, Bjorn Helgaas wrote:
> > [I see that you just posted a v12 that doesn't touch drivers/pci at
> > all.  I haven't looked at it yet, so maybe my questions/comments below
> > are no longer relevant.]
>
> I'm not married to either approach but I think that you'll like the v12
> approach better.
>
> Let me try to answer your questions anyway though because I think
> they're still applicable for understanding of this issue.
>
> >
> > On Wed, Aug 16, 2023 at 07:57:52AM -0500, Limonciello, Mario wrote:
> >> On 8/15/2023 6:48 PM, Bjorn Helgaas wrote:
> >>> On Wed, Aug 09, 2023 at 01:54:53PM -0500, Mario Limonciello wrote:
> >>>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >>>> PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
> >>>> storing a value to the `bridge_d3` variable in the `struct pci_dev`
> >>>> structure.
> >>>>
> >>>> pci_power_manageable() uses this variable to indicate a PCIe port can
> >>>> enter D3.
> >>>> pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
> >>>> decide whether to try to put a device into its target state for a sleep
> >>>> cycle via pci_prepare_to_sleep().
> >>>>
> >>>> For devices that support D3, the target state is selected by this policy:
> >>>> 1. If platform_pci_power_manageable():
> >>>>      Use platform_pci_choose_state()
> >>>> 2. If the device is armed for wakeup:
> >>>>      Select the deepest D-state that supports a PME.
> >>>> 3. Else:
> >>>>      Use D3hot.
> >>>>
> >>>> Devices are considered power manageable by the platform when they have
> >>>> one or more objects described in the table in section 7.3 of the ACPI 6.5
> >>>> specification.
> >>>>
> >>>> When devices are not considered power manageable; specs are ambiguous as
> >>>> to what should happen.  In this situation Windows 11 leaves PCIe
> >>>> ports in D0 while Linux puts them into D3 due to the above mentioned
> >>>> commit.
> >>>
> >>> Why would we not use the same policy as Windows 11?
> >>
> >> That's what I'm aiming to do with my patch series.
> >
> > OK, help me out because I think I have a hint of how this works, but
> > I'm still really confused.  Here's the sort of commit log I envision
> > (but I know it's all wrong, so help me out):
>
> I was intentionally trying to leave the actual problem out of the commit
> from your earlier feedback and just put it in the cover letter.
>
> But if it's better to keep in the commit message I'll return those details.

It is.

If you make a change in order to address a specific problem, that
problem needs to be described in the changelog of the patch making
that change.

Anything else is more or less confusing IMO.
