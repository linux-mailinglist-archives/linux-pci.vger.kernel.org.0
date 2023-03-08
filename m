Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C826B12D1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 21:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCHUSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 15:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCHUSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 15:18:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A2937F32;
        Wed,  8 Mar 2023 12:18:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D07C4618D9;
        Wed,  8 Mar 2023 20:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D47C433D2;
        Wed,  8 Mar 2023 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678306709;
        bh=ZtTQKPw9Lhws3bMR0Dxy6tKp0Y2Sewfp9TGaLVkmtN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F3AxgntVW29X9pG+G1qzmxHeFIbfgjuVpWg0O2Ib0HBI/zZbEoDMSTHKJsEOs4mTz
         KDL+B8wzlZdzT3/LxYrnRdA3HHGp2UNZ2Ou5sDvd70MhPrz5bbuXsbeIkea0FZV0w1
         da7M9eZbcOoc3K55AREpzpjmixf9b/Y4/tl0ZgmkqOwb+s423chpOEAheE5cKI5cYF
         8JgKUsLMyhiFYbMZMx3JSMNyLzwXdmZipqevrjLvcAN21MWK2nHL9r+wqdG1bPp8JO
         WO7zp6GezHRRhRJO+vjPs8fRTHDxz84/SWCwFmPTMEfz79DpEAH/I5jK0x6Lea0S+F
         YplK3ZMi8GeWA==
Date:   Wed, 8 Mar 2023 14:18:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Grant Grundler <grundler@chromium.org>
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O 'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>
Subject: Re: [PATCH] PCI/AER: correctable error message as KERN_INFO
Message-ID: <20230308201827.GA1039517@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANEJEGvB0+XTgUwJi80BRFpNYWrbtiz17baSoxcR_OpSdnzahg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 12:00:48PM -0800, Grant Grundler wrote:
> Ping? Did I miss an email or other work that this patch collides with?

Nope, we typically make topic branches based on -rc1, so not much
happens during the merge window.  -rc1 was tagged Sunday, so things
will start appearing in -next soon.

Bjorn

> On Tue, Feb 28, 2023 at 10:05 PM Grant Grundler <grundler@chromium.org> wrote:
> >
> > Since correctable errors have been corrected (and counted), the dmesg output
> > should not be reported as a warning, but rather as "informational".
> >
> > Otherwise, using a certain well known vendor's PCIe parts in a USB4 docking
> > station, the dmesg buffer can be spammed with correctable errors, 717 bytes
> > per instance, potentially many MB per day.
> >
> > Given the "WARN" priority, these messages have already confused the typical
> > user that stumbles across them, support staff (triaging feedback reports),
> > and more than a few linux kernel devs. Changing to INFO will hide these
> > messages from most audiences.
> >
> > Signed-off-by: Grant Grundler <grundler@chromium.org>
> > ---
> > This patch will likely conflict with:
> >   https://lore.kernel.org/all/20230103165548.570377-1-rajat.khandelwal@linux.intel.com/
> >
> > which I'd also like to see upstream. Please let me know to resubmit mine if Rajat's patch lands first. Or feel free to fix up this one.
> >
> >  drivers/pci/pcie/aer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index f6c24ded134c..e4cf3ec40d66 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -692,7 +692,7 @@ static void __aer_print_error(struct pci_dev *dev,
> >
> >         if (info->severity == AER_CORRECTABLE) {
> >                 strings = aer_correctable_error_string;
> > -               level = KERN_WARNING;
> > +               level = KERN_INFO;
> >         } else {
> >                 strings = aer_uncorrectable_error_string;
> >                 level = KERN_ERR;
> > @@ -724,7 +724,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> >         layer = AER_GET_LAYER_ERROR(info->severity, info->status);
> >         agent = AER_GET_AGENT(info->severity, info->status);
> >
> > -       level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
> > +       level = (info->severity == AER_CORRECTABLE) ? KERN_INFO : KERN_ERR;
> >
> >         pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> >                    aer_error_severity_string[info->severity],
> > --
> > 2.39.2.722.g9855ee24e9-goog
> >
