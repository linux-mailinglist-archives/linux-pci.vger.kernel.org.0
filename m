Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40612773CB9
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjHHQI6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjHHQHF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEFE35AA
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 08:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13D4262412
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 07:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526F6C433C8;
        Tue,  8 Aug 2023 07:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691479663;
        bh=U753SDuUGCkWy3McgLEuxZrqQxZcA+CCmk5ZBlnRydM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4yTuMjsnSVvsMwUzWwYblhkWsMS6VvasMAvsPFXpjlEQTygxTKzJW+Bfh55EXHRE
         1+oeYnhz+h7ozx2ImJPo6GK1mhwHASvV+cqHZ34OCRcugc5rdQiC+kJ+WNbq4ivqmm
         sOUlnFo4iuMLu/epOna2eYZI8QHvvOZCllKaDYauhA/vgZR3SWJYDBb4A62Fn1yPDF
         2LhOa2RXI1XVX22TR1yK2KeYo6hdzZpPyvWIODssluwu4ffDKpVroY8EOxw3+oExL9
         +gY7pqc+jzEQk7SC/SERwZFF93YomjbhNVjNLiYrVN0GD1J2nk4BDOUc/mQUwbKN8/
         FDFTaKd7++20w==
Received: by pali.im (Postfix)
        id E9CD0687; Tue,  8 Aug 2023 09:27:40 +0200 (CEST)
Date:   Tue, 8 Aug 2023 09:27:40 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808072740.bn6ketsfatxw55ge@pali>
References: <20230114164125.1298-1-pali@kernel.org>
 <ZMzicVQEyHyZzBOc@shell.armlinux.org.uk>
 <ZM0RIheSZKiImCsz@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM0RIheSZKiImCsz@shell.armlinux.org.uk>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 04 August 2023 15:54:26 Russell King (Oracle) wrote:
> On Fri, Aug 04, 2023 at 12:35:13PM +0100, Russell King (Oracle) wrote:
> > Hi,
> > 
> > So it seems this patch got applied, but it wasn't Cc'd to
> > linux-arm-kernel or anyone else, so those of us with platforms never
> > had a chance to comment on it.
> > 
> > *** This change causes a regression to working setups. ***
> > 
> > It appears that the *only* reason this patch was proposed is to stop a
> > kernel developer receiving problem reports from a set of users, but
> > completely ignores that there is another group of users where this works
> > fine - and thus the addition of this patch causes working setups to
> > regress.
> > 
> > Because one is being bothered with problem reports is not a reason to
> > mark a driver broken - and especially not doing so in a way that those
> > who may be affected don't get an opportunity to comment on the patch!
> > Also, there is _zero_ information provided on what the reported problems
> > actually are, so no one else can guess what these issues are.
> > 
> > However, given that there are working setups and this change causes
> > those to regress, it needs to be reverted.
> > 
> > For example, I have an Atheros PCIe WiFi card in an Armada 388 Clearfog
> > platform, and this works fine.
> 
> Further testing - same platform with a mini-PCIe SATA card:
> 
> 01:00.0 SATA controller: ASMedia Technology Inc. ASM1062 Serial ATA Controller (rev 01)
> 
> with a WD10JPVX-60JC3T0 2.5" drive with hdparm -t:
> 
>  Timing buffered disk reads: 344 MB in  3.01 seconds = 114.16 MB/sec
> 
> which is about what is expected for spinny-rust 2.5" drives.
> 
> This was tested with ASPM and AER disabled. AER isn't supported anyway
> as pcie_init_service_irqs() fails with -ENODEV.

So another thing which is broken. Perfect!

> For further info, the Atheros WiFi card was:
> 
> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
