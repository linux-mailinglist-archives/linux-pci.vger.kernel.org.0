Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81024AD70D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 12:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359507AbiBHLbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 06:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356361AbiBHKeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 05:34:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE1FC03FEC0;
        Tue,  8 Feb 2022 02:34:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15B7FCE17E4;
        Tue,  8 Feb 2022 10:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8AAC340EE;
        Tue,  8 Feb 2022 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644316459;
        bh=yieHCbixVdUQUxC/CWP4LS/N805UUg5GNnCTqTxQ/vI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eW+G5qznzIan98DKllGDvV6H59u/71I0033VnSYxYCVq8ENrNstGwVS++HNHBiMDE
         WMFN3SltAXhU0fH2jnrD1Mn0dALuUn+heF4iC4I3W23/7PIsyRXteBYeE+3woxnfLh
         ZP/eIRCa/HegQQlUkd9iXqmmrx/oVOnERvevm6KmeBtSr//gC+KQwKKlTJTZPEv2Yt
         BZX77WI/gRS3Ui4ZPAENHX6NoTZeKm9AaP+44fuDAkkyOqzsVebBcIhShdo4lZDqz4
         8z0QN/VfZwb3iplhAqOdCSM/xVtxq3ocI3xKem6WWK9dHAtnhOMM9Krme/VChAf31M
         nct6nfEHruDyw==
Message-ID: <6d10427ef9c40220e7f0d608a25954523c1a77b6.camel@kernel.org>
Subject: Re: [PATCH v1 3/4] MIPS: bmips: Remove obsolete DMA mapping support
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Feb 2022 11:34:13 +0100
In-Reply-To: <20211209204726.6676-4-jim2101024@gmail.com>
References: <20211209204726.6676-1-jim2101024@gmail.com>
         <20211209204726.6676-4-jim2101024@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-12-09 at 15:47 -0500, Jim Quinlan wrote:
> The code in 'arch/mips/bmips/dma.c' performed DMA mapping for inbound
> regions.  This mapping was and is required for the Broadcom STB PCIe
> controller HW.  This code is removed as the current 'struct device' has a
> @dma_range_map field which performs the same functionality by processing
> the "dma-ranges" DT property.
> 
> Subsequently, ARCH_HAS_PHYS_TO_DMA is now unset since the dma_to_phys()
> and phys_to_dma() functions are removed.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas
