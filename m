Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2103F645C00
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiLGOGd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 09:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiLGOGE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 09:06:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF6A2BEC
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 06:05:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D0CC617A9
        for <linux-pci@vger.kernel.org>; Wed,  7 Dec 2022 14:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906A2C433C1;
        Wed,  7 Dec 2022 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670421906;
        bh=tPXYl0PL9opV7TH+ZTTdR4oUqeZXGjyedJLPpxS40GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tpxu4pFFkXnTjvsU4SoUSkaT1/Q51Pxi4jnoZggIWqOgZi6b2CCG5HqmD0xG4KKKn
         G7uuemDLOlOtXdkf18QlSf1aTQP1uttP4MHy9ABaxyOQirXEupGUD13XzvM2qdNZ8/
         c6L4WG+j3eaAavzRG+Jd3ZNh8SESSALIUUhmtN4vGZgEbbccmDEJJdYbyyj6VENJi8
         Uzw3g2cZ2/GnWzLJFLWPUpJHoUffCH0FxYVx508VHUfcCkQaLVFCaJj4mm/vHPDpRT
         M59DM5mQfCW6C9juLp9tR0JM/7YSTjKawlFVTbN29lG75CMyRX5N4X8U/Hq2VZpQoF
         +xfv2255qu0ww==
Date:   Wed, 7 Dec 2022 14:05:03 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Francisco Blas Izquierdo Riera <klondike@klondike.es>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: Add DMA alias for Intel Corporation 8 Series HECI
Message-ID: <Y5Cdj2wS+FLjjx2Q@kernel.org>
References: <20221121164037.8C73110BB536@smtp.xiscosoft.net>
 <20221129182756.GA727866@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129182756.GA727866@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 29, 2022 at 12:27:56PM -0600, Bjorn Helgaas wrote:
> Does the TPM work under Windows?  If so, it would suggest that there's
> a different way to use it that doesn't require the quirk or the DMAR
> override.  Or maybe it only works on Windows without the IOMMU being
> enabled?

Haswell was the first generation having firmware TPM, and had fTPM
implementation that was flakky in many ways (e.g. Intel TXT still required
a discrete TPM so servers never used it). We have some workarounds for it
already in place.

I'm almost 100% confident nobody seriously tried to use it on server
side and/or together with MMIO.

> Naive question: apparently the TPM is doing DMA reads/writes.  I see
> tpm_crb.c doing MMIO mappings (ioremap()), but I don't see any DMA
> mappings.  Is that implicit or done elsewhere?

Firmware does this. Kernel does not and should not care how it does
it because it is not part of the specification [1]. Kernel cares only
of getting a buffer pointed out by the firmware.

[1] Section 6.5.3 in https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/

BR, Jarkko
