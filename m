Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA690578346
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 15:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiGRNLr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 09:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiGRNLr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 09:11:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D617E00;
        Mon, 18 Jul 2022 06:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3359B81606;
        Mon, 18 Jul 2022 13:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C460C341C0;
        Mon, 18 Jul 2022 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658149894;
        bh=MhGofgDoMMDBdAYGoofIPmQh3z/yVJHsZX4HZNkNyqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ChJF1Wyq7nDl3fBXZP72NQONyySuxH8CVGQp/Ro3xH6Wpl2RCdplHf8pIwjn12+Oj
         HfMgZY5rGxRQ9uAn9xNq2/bXVppk2Ws//EAF7y55ZYXazqv0a3d1U2qJLae6jz0Wna
         0MA1/oKD9LCHWfujdie9UM3oJeuoBXCXrFaZSRtInlCQH3Qt5hO4iBpCZDaYX//ZDB
         o9H1j7ZVZXrcMcCskmXSHIuK5U1NvCpYJcKDC0B8fRP1ubDfOB4kdhe42nuR4xoqRb
         xgzC5MWMTXWe9e+Q4EB9upyUcMFsw3CGHrL4z8MldwjVPM3gGHvgkEC21meim5MmVe
         /If+vjgPIDAIQ==
Received: by pali.im (Postfix)
        id 58BAF7FD; Mon, 18 Jul 2022 15:11:31 +0200 (CEST)
Date:   Mon, 18 Jul 2022 15:11:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220718131131.dclndpkkh7yojhj4@pali>
References: <20220716222454.29914-1-jim2101024@gmail.com>
 <20220716222454.29914-3-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716222454.29914-3-jim2101024@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Saturday 16 July 2022 18:24:49 Jim Quinlan wrote:
> @@ -948,6 +941,40 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	if (pcie->gen)
>  		brcm_pcie_set_gen(pcie, pcie->gen);
>  
> +	/* Don't advertise L0s capability if 'aspm-no-l0s' */
> +	aspm_support = PCIE_LINK_STATE_L1;
> +	if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> +		aspm_support |= PCIE_LINK_STATE_L0S;
> +	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> +	u32p_replace_bits(&tmp, aspm_support,
> +		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> +
> +	/*
> +	 * For config space accesses on the RC, show the right class for
> +	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
> +	 */
> +	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +	u32p_replace_bits(&tmp, 0x060400,

There is already macro PCI_CLASS_BRIDGE_PCI_NORMAL, so please use it
instead of magic constant.

I introduced it recently in commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=904b10fb189cc15376e9bfce1ef0282e68b0b004

> +			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> +
> +	return 0;
> +}
