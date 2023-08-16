Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6977EA93
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbjHPUSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 16:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346105AbjHPUR5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 16:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E31FE3
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 13:17:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4A8642F3
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 20:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5217CC433C8;
        Wed, 16 Aug 2023 20:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692217075;
        bh=Hix2WGg8SCqVC2r11ACYhXIuNzsUDKSjcpusYfnd35o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SZlYua5EMhLLg15fHwR3HLwOj7X9yO12bSEgTMcXPKVCAQUAPbVo9O+ribZ8LQDvM
         ZMyGU45mOsVs9TSRdAmKYnczWdtAAxNkFBKT5EKDfJJHDsBhhCpbsd08l523sYvGjx
         UdeAI6TzlZq9z6vKi0+n+MVTvPVC8ApPGR/ZnS+ZLp7w4Eh1+DgYmZ2aSGgogcYJok
         L0UMN5JosuOax37J3NEUh29RtwH4pfE/9hFg8Swaq4OYs0zfptak3KPdh48WwC/yJY
         DtmYUsWYZJHGIY7x+of3FCPWrBMnmV9b7nyBFM0fw9btzsGzePvHRR/++RSaQXeEYf
         v0eUsRzqLdtCQ==
Date:   Wed, 16 Aug 2023 15:17:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sheena Mohan <sheenamo@google.com>
Cc:     Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        andriy.shevchenko@intel.com, joel.a.gibson@intel.com,
        emil.s.tantilov@intel.com, gaurav.s.emmanuel@intel.com,
        mike.conover@intel.com, shaopeng.he@intel.com,
        anthony.l.nguyen@intel.com, pavan.kumar.linga@intel.com,
        Aahil Awatramani <aahila@google.com>
Subject: Re: [PATCH 2/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Message-ID: <20230816201753.GA296521@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADWJPTsm7XUMR94aLAg_o5TyMPQxXGwi++_9LtQVbhsi7A0_QA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 12:50:28PM -0700, Sheena Mohan wrote:
> It is good to have the SW fix for backward compatibility rather than
> disabling ATS on previous revisions. Maybe adding a flag to toggle the
> feature will be useful.

FYI, I received this (and probably the other direct recipients did,
too), but I think the mailing lists rejected it, probably because it
was a multi-part message (see
http://vger.kernel.org/majordomo-info.html).

The list archive is https://lore.kernel.org/linux-pci/20230816172115.1375716-1-bartosz.pawlowski@intel.com/

> On Wed, Aug 16, 2023 at 10:39 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Wed, Aug 16, 2023 at 05:21:15PM +0000, Bartosz Pawlowski wrote:
> > > There is a HW issue in A and B steppings of Intel IPU E2000 that it
> > > expects wrong endianness in ATS invalidation message body. This problem
> > > can lead to outdated translations being returned as valid and finally
> > > cause system instability.
> > >
> > > In order to prevent such issues introduce quirk_intel_e2000_no_ats()
> > > function to disable ATS for vulnerable IPU E2000 devices.
> > >
> > > Signed-off-by: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >
> > Andy, Alexander, would you please reiterate your reviewed-by on the
> > mailing list?  I try to avoid relying on internal reviews collected by
> > the author.  Those are great and I'm glad they happen, but it's good
> > if they also appear as part of the public conversation on the mailing
> > list.
> >
> > > ---
> > >  drivers/pci/quirks.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index a900546d8d45..9aa1e0148ed2 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -5550,6 +5550,28 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> > 0x7347, quirk_amd_harvest_no_ats);
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x734f,
> > quirk_amd_harvest_no_ats);
> > >  /* AMD Raven platform iGPU */
> > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8,
> > quirk_amd_harvest_no_ats);
> > > +
> > > +/*
> > > + * Intel IPU E2000 revisions before C0 implement incorrect endianness
> > > + * in ATS Invalidate Request message body. Although there is existing
> > software
> > > + * workaround for this issue, it is not functionally complete (no 5-lvl
> > paging
> > > + * support) and it requires changes in all IOMMU implementations
> > supporting
> > > + * ATS. Therefore, disabling ATS seems to be more reasonable.
> > > + */
> > > +static void quirk_intel_e2000_no_ats(struct pci_dev *pdev)
> > > +{
> > > +     if (pdev->revision < 0x20)
> > > +             quirk_no_ats(pdev);
> > > +}
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1451,
> > quirk_intel_e2000_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1452,
> > quirk_intel_e2000_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1453,
> > quirk_intel_e2000_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1454,
> > quirk_intel_e2000_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1455,
> > quirk_intel_e2000_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1457,
> > quirk_intel_e2000_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1459,
> > quirk_intel_e2000_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145a,
> > quirk_intel_e2000_no_ats);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x145c,
> > quirk_intel_e2000_no_ats);
> > >  #endif /* CONFIG_PCI_ATS */
> > >
> > >  /* Freescale PCIe doesn't support MSI in RC mode */
> > > --
> > > 2.41.0
> > >
> > > ---------------------------------------------------------------------
> > > Intel Technology Poland sp. z o.o.
> > > ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII
> > Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP
> > 957-07-52-316 | Kapital zakladowy 200.000 PLN.
> > > Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu
> > ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w
> > transakcjach handlowych.
> > >
> > > Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego
> > adresata i moze zawierac informacje poufne. W razie przypadkowego
> > otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej
> > usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> > > This e-mail and any attachments may contain confidential material for
> > the sole use of the intended recipient(s). If you are not the intended
> > recipient, please contact the sender and delete all copies; any review or
> > distribution by others is strictly prohibited.
> > >
> >
