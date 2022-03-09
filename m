Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1204D3690
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 18:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiCIQhF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 11:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiCIQez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 11:34:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C94A0BF4;
        Wed,  9 Mar 2022 08:29:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2E01B820D3;
        Wed,  9 Mar 2022 16:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CC2C340F7;
        Wed,  9 Mar 2022 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646843392;
        bh=6NcM3s9FUXJzXCNhdm5FnAc37hj/GF+Xkb2PBQn28cQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WDai5sJOP0tmymKTQzKf2ANe1AJWqo9ZRi44HfcNQ4Fnz4JXyv0gB9vtsCG53l4Ye
         5XrtOF3s3VtGSAsBXi4AJmZHD9KpUys8ZZVVNdFkKlXE6/X7q68DA66xieesEWaZPA
         +viuT/Ra3kI4UZnTGpANJbgxYK9K2fMq/IHwD1PmooN+HMaJ05iipM/o/1WqJBnp9M
         GX9/vI1YQfCM8WHyFtgQrXVZKIatk4MBQ68HA9upWZOw0xuN9ZXp1t9+8HAfMZt/Ld
         1dCaW/7ph0w3hrjmrDq8UNwuzU8uxcRjgqUBMih+CD8ndTqnAS8GQi8ISQuB0fyJ3K
         N5F41RqMqMV1A==
Date:   Wed, 9 Mar 2022 10:29:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v9 00/11] vgaarb: Rework default VGA device selection
Message-ID: <20220309162950.GA55262@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225221523.GA385757@bhelgaas>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 25, 2022 at 04:15:23PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 24, 2022 at 04:47:42PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Current default VGA device selection fails in some cases because part of it
> > is done in the vga_arb_device_init() subsys_initcall, and some arches
> > enumerate PCI devices in pcibios_init(), which runs *after* that.
> > 
> > The big change from the v8 posting is that this moves vgaarb.c from
> > drivers/gpu/vga to drivers/pci because it really has nothing to do with
> > GPUs or DRM.
> 
> I provisionally applied this to pci/vga and put it into -next just
> to get a little runtime on it.
> 
> But I'd prefer not to unilaterally yank this out of drivers/gpu
> without a consensus from the GPU folks that this is the right thing to
> do.
> 
> Any thoughts?  If it seems OK to you, I think patch 1/11 (the move
> itself) is all you would need to look at, although of course I would
> still be grateful for any review and feedback on the rest.
> 
> After it's in drivers/pci, all the blame for any issues would come my
> way.

Ping?  This has been in -next since the Feb 28 tree, and I plan to
ask Linus to include it during the v5.18 merge window (which will
probably open Mar 13) unless somebody objects.

Bjorn
