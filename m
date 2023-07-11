Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FDB74F4FA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjGKQU1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjGKQUJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 12:20:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453EF10E3;
        Tue, 11 Jul 2023 09:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0BA161562;
        Tue, 11 Jul 2023 16:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95D6C433C9;
        Tue, 11 Jul 2023 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689092372;
        bh=93JhDreefZ2IaOeQ5o+vxmKR9FPwV2k7NiXOGpNuMCM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GqeN214M5tCT1zk3DKwIwk9lUERRHUO5CzojBlqjfl864/8o/15oEIAtlfKGaU7SH
         64mmYRlhtcOyIamQwm5tShwx4KAhmOpsOPW2aoPhviU9yVNuBt8emDlfucOwXtRjvS
         U7AH4V3gC3Kf5dR6XpwgcdSYJcA1/G12ZbT7FZ3Ziz1RMlx39mZY+GBz82/YbkNV65
         ZwebRQFY6e/Nxv5oFdJktBrFR3sdObl7CQkTglS7B0Bt971vxtxI6p7daFugYx3t6E
         Yn10gmBjI+wjVnKMNbN4nIesLF/BGScBHm0fZZjH9ImEuTgpc3AvsUlb939VnXhCzT
         MXaj/jXbYHmdg==
Date:   Tue, 11 Jul 2023 11:19:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 00/13] PCI: Define Intel PCI IDs and use them in drivers
Message-ID: <20230711161930.GA250687@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzv6h2ui.wl-tiwai@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 11, 2023 at 05:42:13PM +0200, Takashi Iwai wrote:
> On Tue, 11 Jul 2023 17:36:20 +0200, Mark Brown wrote:
> > On Tue, Jul 11, 2023 at 05:24:07PM +0200, Pierre-Louis Bossart wrote:
> > > On 7/11/23 14:57, Amadeusz Sławiński wrote:
> > 
> > > > Simplify things, by adding PCI IDs to global header and make use of them
> > > > in drivers. This allows for removal of comments by having IDs themselves
> > > > being self explanatory. Additionally it allows for removal of existing
> > > > inconsistencies by having one source of truth.
> > 
> > > I'd like to hear from Takashi and Mark on how this would work, we have
> > > to provide new PCI IDs for both trees using a common 'pci_ids.h' file.
> > 
> > We can probably just agree on a tree to apply things and work from
> > there.
> 
> Yes, simply apply on top of 6.5-rc1 or such a stable point and tag it.
> Then other trees can merging it.
> 
> I can do it if both Bjorn and Mark agree (after all patches get
> reviewed and no objection comes up).

Sure.  I acked the PCI ones, so you can merge these via whatever tree
makes the most sense.  We might have minor conflicts during the merge
window, but they should be easy to fix.

Bjorn
