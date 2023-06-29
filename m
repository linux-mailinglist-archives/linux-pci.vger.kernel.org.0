Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C3D742A47
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 18:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjF2QIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 12:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjF2QIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 12:08:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54829E;
        Thu, 29 Jun 2023 09:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83EAD61593;
        Thu, 29 Jun 2023 16:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9259C433C0;
        Thu, 29 Jun 2023 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688054918;
        bh=ha9nFOTThKQkXYIfeLwSXUJFETP5wuyEziul21nMFA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aqQUQ/JaA3UajUyWxo6+H5aNLqjsbbodmBl1f1j5E5/cTJTNkPWlsITqtNi3M0Xsq
         3JaoJs6hKAGv75Znl3Ay1BcYBwMUMJ6cYPim8BF4JmR+CN9qohwCB7pxUX+T8FxNaU
         kpIbDUyFyEKkGrzqFd9xvTYs58ztGiOdIeomTilEJPpZXGxgR2wWJN/cEHqK0iUf/g
         7L4rrj2VaPRR82GNDS7dKFNRcL74ygZVLWxkfldMtnDVedxIsyr747/yFqtvO6yqqo
         2SFpcIiUINvurr2TfCfOHxqlz3rJoKqidSlD71R+HJPumfFeQJe5KCacUu/+teRgwb
         YljrYtXdfkykg==
Date:   Thu, 29 Jun 2023 11:08:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH 3/8] ALSA: hda: Update PCI ID list
Message-ID: <20230629160836.GA398698@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230628205135.517241-4-amadeuszx.slawinski@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Personally I would look for a more descriptive verb for the subject.
"Update" suggests that you might be adding or removing IDs, but I
think this patch is basically a mechanical conversion to use macros
instead of hard-coded hex.  Maybe "Convert to PCI_VDEVICE" or
something?

On Wed, Jun 28, 2023 at 10:51:30PM +0200, Amadeusz Sławiński wrote:
> Use PCI device IDs from pci_ids.h header and while at it change to using
> PCI_VDEVICE macro, to simplify declarations. This allows to change magic
> number PCI vendor IDs to macro ones for all vendors. For Intel devices
> use device IDs macros where defined.

> -#define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
> +#define IS_APL(pci) ((pci)->vendor == PCI_VENDOR_ID_INTEL && \
> +					(pci)->device == PCI_DEVICE_ID_INTEL_HDA_APL)

The actual content change seems fine, but the name change from BXT to
APL seems like it might be material for a separate patch, possibly
along with a similar name and comment change for
bxt_reduce_dma_latency()?

>  static const char * const driver_short_names[] = {
>  	[AZX_DRIVER_ICH] = "HDA Intel",
> @@ -571,7 +572,7 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
>  	snd_hdac_set_codec_wakeup(bus, false);
>  
>  	/* reduce dma latency to avoid noise */
> -	if (IS_BXT(pci))
> +	if (IS_APL(pci))
>  		bxt_reduce_dma_latency(chip);

