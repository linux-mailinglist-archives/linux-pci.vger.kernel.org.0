Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ABF780822
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359007AbjHRJTm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Aug 2023 05:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359013AbjHRJT0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 05:19:26 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EE0358D;
        Fri, 18 Aug 2023 02:19:24 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-56d67c5e87cso125679eaf.0;
        Fri, 18 Aug 2023 02:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692350364; x=1692955164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hT0hnCuLjpo8MFwXMV532U+BBHGpwy7DBDu59dcH3a8=;
        b=Rh1e0spHRF5ojF4u2rLxbotI42Svlsy2gMktcl+2k3gm2y9KAHIYHUrmE3TJD61TI7
         QAGTbH6hI5aJoKllfmtvQffhrm3Cdyf7EsK3jZ5SNgUpK8zlvx21xaBoeLrVLRYyrjWs
         shOcorGVT7e9rhr6A5N9CQwSR3xcQDZ5h4WnbRkb9LFr6xtrk36A4C1WKzzklowhB81J
         unC8mWx/+Ba7Bzoexam8hp+on4c8ihUYMQjCLxc8FbkhbfETDodRzdF5uyN0gGF+OWnG
         O426KYbAFrSNGWZQd/xHiM7NKT1DBRfRwJDYrDUmxIjmSlLbilAEnjRxWAc+j/tKhmDc
         8nUA==
X-Gm-Message-State: AOJu0YzmDW2IiWfudHcypM4UHB3M6jT4wcRUlVZ428HI9reA2yjmVAk5
        1Eg0SAblZynebDapE0OxdWJjHa1Kvc8DNpprjT9bXoNa
X-Google-Smtp-Source: AGHT+IEOmvo2+2r17iZjbNPDIoVJ4vvqT1956pbectWeT3dwXSoWsdixXdJsjL9FBnjXcxF3h/0ndQn4dawelRTwueo=
X-Received: by 2002:a05:6820:44a:b0:563:3b56:5dc1 with SMTP id
 p10-20020a056820044a00b005633b565dc1mr2125628oou.0.1692350364066; Fri, 18 Aug
 2023 02:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230818051319.551-1-mario.limonciello@amd.com>
 <20230818051319.551-2-mario.limonciello@amd.com> <CAJZ5v0iHvbbNBnwb-RKvcBaFR8VMGyGt--b6RmbUmwuzcBZKnQ@mail.gmail.com>
 <106803fab8da4648a6881991c7f37214@AcuMS.aculab.com>
In-Reply-To: <106803fab8da4648a6881991c7f37214@AcuMS.aculab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 11:19:12 +0200
Message-ID: <CAJZ5v0h1tCBOcnU2mCGbgE53_=ZM3kHHXzpCtqv=d9LOadaycQ@mail.gmail.com>
Subject: Re: [PATCH v13 01/12] PCI: Only put Intel PCIe ports >= 2015 into D3
To:     David Laight <David.Laight@aculab.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 10:21 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Rafael J. Wysocki
> > Sent: Friday, August 18, 2023 9:12 AM
> >
> > On Fri, Aug 18, 2023 at 7:14 AM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> > > changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> > > from modern machines (>=2015) are allowed to be put into D3.
> > >
> > > Iain reports that USB devices can't be used to wake a Lenovo Z13
> > > from suspend. This is because the PCIe root port has been put
> > > into D3 and AMD's platform can't handle USB devices waking in this
> > > case.
> > >
> ...
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 60230da957e0c..051e88ee64c63 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3037,10 +3037,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> > >                         return false;
> > >
> > >                 /*
> > > -                * It should be safe to put PCIe ports from 2015 or newer
> > > +                * It is safe to put Intel PCIe ports from 2015 or newer
> > >                  * to D3.
> > >                  */
> >
> > I would say "Allow Intel PCIe ports from 2015 onward to go into D3 to
> > achieve additional energy conservation on some platforms" without the
> > "It is safe" part that is kind of obvious (it wouldn't be done if it
> > were unsafe).
>
> Just say why...
>
> "Don't put root ports into D3 on non-Intel systems to avoid issues
> with USB devices being unable to wake up some AMD based laptops."

Well, both pieces of information are actually useful: Why it is done
on Intel systems in the first place and why it cannot be done on AMD
systems.
