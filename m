Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213A54C3134
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiBXQ0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 11:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiBXQ0a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 11:26:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DBB1CA5C0
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 08:25:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 743F461935
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 16:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABE7C340F0;
        Thu, 24 Feb 2022 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645719933;
        bh=PH7VHYIVRaHEXfd5vcYi0l8KPvcJAxez/B7s3yxyG4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=br14pY4TqCrlVycMjPNXWHbfxUkkjYOkpDybHUbsxA4BzhLa3uhmsp99uldtAjWGx
         78yYxvleIARNDTxEMuBgbMnhQ5NGtKdRv2fZvTxiOiPIc7m2X7r+X95C5TQgVVoaFA
         wX+aDn+tx/ni7jV2f0TWiDYFi+j14om0xBRa3OiGSZ/UmHQAIwBVn/gkCNHaqVqtzz
         ahqQFGxWphPUAvl1WP73f5krAoPunpPt/APJS2dXZPBh6YO22mqYenzEuA5dTuwpFw
         9tZizrcfLVSzhVpvkXMLVnRt2Hg1s/bWj1MiqRmy1btTdb6Z/mjAr1rvYbuCQOnU/b
         g9IoCzPU1hBxw==
Date:   Thu, 24 Feb 2022 10:25:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marcel Menzel <mail@mcl.gg>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: Kernel 5.16.3 and above fails to detect PCIe devices on Turris
 Omnia (Armada 385 / mvebu)
Message-ID: <20220224162532.GA274119@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4dd76f4-19e4-c35a-bd46-6e014707402e@mcl.gg>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 24, 2022 at 05:00:30PM +0100, Marcel Menzel wrote:
> +linux-pci
> 
> Am 24.02.2022 um 14:52 schrieb Marcel Menzel:
> > Am 24.02.2022 um 14:09 schrieb Marcel Menzel:
> > > Hello,
> > > 
> > > When upgrading from kernel 5.16.2 to a newer version (tried 5.16.3
> > > and 5.16.10 with unchanged .config), the Kernel fails to detect both
> > > my installed mPCIe WiFi cards in my Turris Omnia (newer version,
> > > silver case, GPIO pins installed again).
> > > I have two Mediatek MT7915 based cards installed. I also tried with
> > > one Atheros at9k and one ath10k based card, yielding the same
> > > result. On a Kernel version newer than 5.16.2, all cards aren't
> > > getting recognized correctly.
> > > 
> > > Before 5.16.3 I also had to disable PCIe ASPM via boot aragument,
> > > otherwise the WiFi drivers would complain about weird device
> > > behaviors and failing to initialize them, but re-enabling it does
> > > not yield any different results.

Please try this commit, which is headed to mainline today:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=for-linus&id=c49ae619905eebd3f54598a84e4cd2bd58ba8fe9

This commit should fix the PCI enumeration problem.  If you still have
to disable ASPM, that sounds like a separate problem that we should
also try to debug.

Bjorn
