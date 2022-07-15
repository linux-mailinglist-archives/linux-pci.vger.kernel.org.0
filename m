Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49F0576A25
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiGOWtR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 18:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiGOWtQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 18:49:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452BC422E1;
        Fri, 15 Jul 2022 15:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D512C61AEA;
        Fri, 15 Jul 2022 22:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5377C3411E;
        Fri, 15 Jul 2022 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657925354;
        bh=/HK8+6F2X24xjQ7OGtj8N78bPEbS4rUf1HbEkEcWz0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=evXgj3yNkRI6HvFzrpBM26FOti3FIvdzxUvD8k77uj3aoRDt94ERnVjHetrWIMqwm
         lHQz2UAQk7RUuNtjX61jlIBEI+9NJ/WNmhepK/foupVbnSk9ZH9k+fX9HjduU/9QR5
         Jckp3R2MSL3jaA7EjfrS269Tu+BauLCMrkeT7RgPwe5TSsLjJwWXK9jjjydKqV3Tp2
         zn6pErQqqAmEX4W9v8pIhF/tJPyaYpa86QGMrO9vtlLd1wwn8MRV2PWDX4jQ3I+/4L
         ZpjaBaZhae/a6coQin0Aui8lGps0VK4sXDa8Ej00RyNLk8Ilj+9LifOWS3zoLgJArZ
         Vg2wPKb4q5Ehw==
Date:   Fri, 15 Jul 2022 17:49:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manyi Li <limanyi@uniontech.com>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        bhelgaas@google.com, refactormyself@gmail.com, kw@linux.com,
        rajatja@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        rafael@kernel.org
Subject: Re: [PATCH] PCI/ASPM: Should not report ASPM support to BIOS if FADT
 indicates ASPM is unsupported
Message-ID: <20220715224911.GA1208192@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715093236.GA12020@srcf.ucam.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Manyi, FYI, your emails aren't making it to the linux-pci list (or to
me), so I'm missing most of this conversation.

If you look at the lore archive:
  https://lore.kernel.org/all/20220713112612.6935-1-limanyi@uniontech.com/
you'll see all the message-ids that are not found.

Maybe you're sending HTML or something else vger doesn't like?
http://vger.kernel.org/majordomo-info.html#taboo

On Fri, Jul 15, 2022 at 10:32:36AM +0100, Matthew Garrett wrote:
> On Fri, Jul 15, 2022 at 05:19:25PM +0800, Manyi Li wrote:
> > On 2022/7/15 16:29, Matthew Garrett wrote:
> > > On Fri, Jul 15, 2022 at 03:40:36PM +0800, Manyi Li wrote:
> > > 
> > > > Please see the details of this issus:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=216245
> > > 
> > > Hmm. The only case where changing aspm_support_enabled to false should
> > > matter is in pcie_aspm_init_link_state(), where it looks like we'll
> > > potentially rewrite some registers even if aspm_disabled is true. I
> > > think in theory we shouldn't actually modify anything as a result, and
> > > the lspcis from the bug don't show any ASPM values having changed, but I
> > > don't trust Realtek hardware in the general case so maybe it gets upset
> > > here? If the proposed patch is to just set aspm_support_enabled to false
> > > when we see the FADT bit set then I think this is fine.
> > > 
> > 
> > "aspm_support_enabled" alse be used in calculate_support():
> > if (pcie_aspm_support_enabled())
> >     support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> > When set OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT, cause this AER
> > issue. I want don't set OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT when
> > we see the FADT bit set.
> 
> Oh hm. Are you sure it's the OSC call that breaks it? I have some 
> recollection that I verified the behaviour of Windows here, but it's 
> been over 10 years since I touched this so I could well be wrong. I can 
> try to set up a test env to verify the behaviour of Windows when it 
> comes to _OSC if the FADT says ASPM is unsupported.
