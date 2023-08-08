Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E477434A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 20:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjHHSAO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjHHR7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 13:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D72CEE2
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 09:27:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 531B062531
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 16:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71430C433B7;
        Tue,  8 Aug 2023 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691511989;
        bh=zE/uSYeRloetY2ZRpWdkDWpaPNmX2Vprz3+Hc9pFNr8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Sjdz06csNVGed3j66FD4E/PDkuW6p4aJDFTASGiBQPnqYPMIcBAKLqdysbMQqSGSj
         Vr60OZ3318kwP8ODF2E8XcwylDOyDCIuuhhha7vfn24K0HNilLiRd0p0TJvmmCDf4q
         PzutiWTgmR9s2XhbbObOl+ZnWfKF21ZcB4nOC1LkkOdXYuzjK6McaPjFAwvimVJ7qc
         4sbBlNPB6fy3zfBF+yxgbTOtoRHWlaAzr7V6ZkLGLQsoAeTb0Dc81xM0/putFxpyCC
         eGLnfxkHj0+g+njPF9/QrW+TT66W4OV1B3dqcx58PwF4rvi83hx3sT63JZgC2AUHyu
         aV2sreGd2MOKg==
Date:   Tue, 8 Aug 2023 11:26:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: Mark driver as BROKEN
Message-ID: <20230808162627.GA314706@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808072605.n3rjfsxuogza7qth@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-arm-kernel, beginning of thread:
https://lore.kernel.org/r/20230114164125.1298-1-pali@kernel.org]

On Tue, Aug 08, 2023 at 09:26:05AM +0200, Pali Rohár wrote:
> On Friday 04 August 2023 12:35:13 Russell King (Oracle) wrote:
> ...

> > For example, I have an Atheros PCIe WiFi card in an Armada 388 Clearfog
> > platform, and this works fine.
> > 
> > Uwe has a SATA controller for a bunch of disks in an Armada 370 based
> > NAS platform that is connected to PCIe, and removing PCIe support
> > effectively makes his platform utterly useless.
> > 
> > Please revert this patch.
> 
> Please do not revert it, instead start fixing problems.

We know that like all the other drivers, the mvebu driver isn't
perfect.  But I don't think effectively removing the driver completely
helps anybody.  If people try to use it and notice problems, we have a
chance to try to fix them.

Or maybe I'm missing your point.  I think you're suggesting that we
keep pci-mvebu in the tree but unselectable because it depends on
CONFIG_BROKEN.  What would be the advantage of doing that?

Bjorn
