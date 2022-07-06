Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D585694A2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 23:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiGFVmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 17:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiGFVmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 17:42:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6ED1EAFE;
        Wed,  6 Jul 2022 14:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49787B81F0A;
        Wed,  6 Jul 2022 21:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB5EC3411C;
        Wed,  6 Jul 2022 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657143722;
        bh=237T2NMtfBHPcTAQZk28ShAHQrc+trAx58+zY3ugzkw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PsiagAJAt/MA+7E2Gn2q2BBgWl3jBFqnkCAfGKBKUWgsuJ5ZiwnTaj8mv30mCv5ZL
         ckewqGdEF/XYlXWfMDdgh8oxb6Jj9BVdgC7SMyaXGbVTy/hmKvlFQwlysr6askIi9L
         c3ePrN1SuSmQMHDaNAjYZN22mcRysRlzvhxMtyIctmv58ymMHtc+E1Cn3D1y6nEkyE
         E2WzKs5Fwd3W1s1ahczkUx0gOq6/wuFPF0bqb2UBa8djvlECEWm7cyC6Hlhm/FEV0L
         xart0T50uXJPIS7AEyRWGFC/u2+lUNb7z1KR7wSSfSPyMRERBFAGrFfed9kiW0zQ4+
         ROcsalVqhWJlA==
Date:   Wed, 6 Jul 2022 16:42:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 4/4] PCI: brcmstb: Augment driver for MIPs SOCs
Message-ID: <20220706214200.GA224369@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209204726.6676-5-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 03:47:25PM -0500, Jim Quinlan wrote:
> The current brcmstb driver works for Arm and Arm64.  A few things are
> modified here for us to support MIPs as well.
> 
>   o There are four outbound range register groups and each directs a window
>     of up to 128MB.  Even though there are four 128MB DT "ranges" in the
>     bmips PCIe DT node, these ranges are contiguous and are collapsed into
>     a single range by the OF range parser.  Now the driver assumes a single
>     range -- for MIPs only -- and splits it back into 128MB sizes.
> 
>   o For bcm7425, the config space accesses must be 32-bit reads or
>     writes.  In addition, the 4k config space register array is missing
>     and not used.
> 
>   o The registers for the upper 32-bits of the outbound window address do
>     not exist.
> 
>   o Burst size must be set to 256 (this refers to an internal bus).
> ...

> @@ -118,6 +118,7 @@
>  #define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
>  #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
> +#define  PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x00800000

> @@ -883,7 +937,10 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	pcie->bridge_sw_init_set(pcie, 0);
>  
>  	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> -	tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
> +	if (is_bmips(pcie))
> +		tmp &= ~PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
> +	else
> +		tmp &= ~PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK;
>  	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
>  	/* Wait for SerDes to be stable */
>  	usleep_range(100, 200);

brcm_pcie_resume() has similar code that updates
PCIE_MISC_HARD_PCIE_HARD_DEBUG [1]:

  tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
  u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
  writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);

  /* wait for serdes to be stable */
  udelay(100);

This patch didn't change brcm_pcie_resume() to check is_bmips().
Should it?

If so, it would be nice to use the same method for updating the value
(either u32p_replace_bits or plain C bitops) in both places.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-brcmstb.c?id=v5.18#n1452
