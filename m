Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310E68C25A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 16:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjBFP4y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjBFP4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 10:56:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455781E2B5;
        Mon,  6 Feb 2023 07:56:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D250D60DC0;
        Mon,  6 Feb 2023 15:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104B5C433EF;
        Mon,  6 Feb 2023 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675699011;
        bh=BnMU2Vjrd6tRJvjN7xf5KorwAqVeIfdrGkW2yAZq9kQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ROhVM2Efz4vn2nh6kD6hb6VC89uKawXBwAHz5MXriaSHKM3TGp6uEWGs1ov1dLIBP
         4AUw3NeaIg0tbdX7P5IJjuSdbVJlJEeIqhGLd8818ThIPLEOtDMjK86AoOBsG9mQ5y
         bjHTjilv/6+C3nLLDiI114GMOQ2Ek4i/1J8nCf9VBgxIqtHvp+mR5LPP7zIrMksf+s
         EXnP6pFXTiwpU7u7Nnhju4JP/TojbNXs8hW7sN+gOkyxrn8VA2O2idinA0TMpRPlY5
         zM+fZOsT6nl/3k3xvNtpxlpr2LPs10GUGN1T3ctmJj8oOP2KG9FS9rDViCRb+QhibI
         htvSjNWMXZcaA==
Date:   Mon, 6 Feb 2023 09:56:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, linux-pci@vger.kernel.org,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zeno Davatz <zdavatz@gmail.com>
Subject: Re: [PATCH] Revert "fbdev: Remove conflicting devices on PCI bus"
Message-ID: <20230206155649.GA2212009@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twrKFPkEXTFWousnmJoH-mEG1KvGEBwqYY2e0biw-h8bw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 06:59:40AM +1000, Dave Airlie wrote:
> On Sat, 4 Feb 2023 at 09:09, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > This reverts commit 145eed48de278007f646b908fd70ac59d24ed81a.
> >
> > Zeno Davatz reported that 145eed48de27 ("fbdev: Remove conflicting devices
> > on PCI bus") caused a console hang.  The machine was actually still usable
> > via ssh, etc., but there was no activity on the console.
> >
> > Reverting 145eed48de27 for the nvidiafb on that system fixed the problem.
> >
> > Revert 145eed48de27 ("fbdev: Remove conflicting devices on PCI bus") since
> > we don't know what caused the problem.
> 
> Why is the user using nvidiafb?

I don't know, and of course, it really doesn't matter; we shouldn't
regress a user's experience, and there's no hint to the user of where
to look for a resolution.

Thanks for working out a better fix!

Bjorn
