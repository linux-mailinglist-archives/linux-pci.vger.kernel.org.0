Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5FC6648B6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 19:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbjAJSOb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 13:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjAJSNP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 13:13:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D269FFC;
        Tue, 10 Jan 2023 10:12:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA0E61866;
        Tue, 10 Jan 2023 18:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C3C433D2;
        Tue, 10 Jan 2023 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673374324;
        bh=vfmjTd2s2iQMdYWl5aI3DzZI0zQRjiUp//jXzzInAMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VeK+yuaq5DgsGSZyfGzKQULrAucyPz+Elir7EsxCKVvZFe8GbBpcZ8jFl6O3sfLys
         VVWY5sxHBt0x+ZqDpQoJtREZGPUt0VEYm84YdiT6z0yLzhy6euHEr28W25ZCaCCmSq
         NldU5F9KeYFxoRBYxBgbTCPE6p0OqUsudDPwfgdupo1iavZ2//EcrTRTkGFs1zHguM
         aLKBO735wSxvlU3rNdHjlvvWP02eNNcN2pMG6YCyhoNN7r4PFTqcVV05vLOiSnhts/
         tsfFFHBpACREVrKOFMbh6b8p6M7rM4kk+qZzQecQtB97dkkuF+cV/MLe2dWIpmeKdX
         7zMMg8v6EpxwQ==
Date:   Tue, 10 Jan 2023 12:12:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-pci@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        David E Box <david.e.box@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <linuxkernelml@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] x86/pci: Simplify is_mmconf_reserved() messages
Message-ID: <20230110181202.GA1591198@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63bda96bcb95c_5178e29418@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 10:07:39AM -0800, Dan Williams wrote:
> Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > is_mmconf_reserved() takes a "with_e820" parameter that only determines the
> > message logged if it finds the MMCONFIG region is reserved.  Pass the
> > message directly, which will simplify a future patch that adds a new way of
> > looking for that reservation.  No functional change intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  arch/x86/pci/mmconfig-shared.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> > index 758cbfe55daa..cd16bef5f2d9 100644
> > --- a/arch/x86/pci/mmconfig-shared.c
> > +++ b/arch/x86/pci/mmconfig-shared.c
> > @@ -446,13 +446,12 @@ typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
> >  
> >  static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
> >  				     struct pci_mmcfg_region *cfg,
> > -				     struct device *dev, int with_e820)
> > +				     struct device *dev, char *method)
> 
> @method could be 'const char *', but either way:

Of course, thanks!  Folded in.
