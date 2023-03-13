Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458D06B81D2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Mar 2023 20:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCMToF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Mar 2023 15:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjCMTn7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Mar 2023 15:43:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3217C82ABC;
        Mon, 13 Mar 2023 12:43:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7675B81219;
        Mon, 13 Mar 2023 19:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318A3C433D2;
        Mon, 13 Mar 2023 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678736631;
        bh=AAJ8fexIUs5Qt7ugdJhkcwzCF4TSyWEGeh3eK5e33NI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BxzCay8eGGUAi43a+5Nl70MBgtrA78JIqjxELsmiQq4/OqyxQwbFluQ4ZUXBr52I0
         II02kWsDTjn5VaFamjBVCpF83x+9T/EwKMVYHeWtafVPUFUp+uwQvxne4mQsoq7KDz
         HDYrkEutmWtOlKvIr0YUiwHpI6/1EZ/0Vs3PdyMvD21H6nKfLU5MEukeGd3dsGIJMW
         Vt1iOQEgy0zbkXIFtfgJc4Bx0pteEbsOhQkz0x2iUMp2fLeeA6e+CDoCDEg48RKl/g
         IKg8Fq1UYWfw0QKfTmepkTCac9ArtUE6FKw0O/lC1oV/KVI6wKzCG2fM/0BHoBXxQs
         kC/zh3LNTCbTw==
Date:   Mon, 13 Mar 2023 14:43:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Raz Adashi <raza@marvell.com>
Subject: Re: [PATCH v4 2/8] PCI: armada8k: Add AC5 SoC support
Message-ID: <20230313194349.GA1529210@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313124016.17102-3-enachman@marvell.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 13, 2023 at 02:40:10PM +0200, Elad Nachman wrote:
> From: Raz Adashi <raza@marvell.com>
> 
> pcie-armada8k driver is utilized to serve also AC5.
> 
> Driver assumes interrupt mask registers are located
> in the same address inboth CPUs. This assumption is
> incorrect - fix it for AC5.

s/inboth/in both/

Rewrap to fill 75 columns.

> +#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is 0x10000 */

Don't add this comment in patch [2/8] and then update it in patch
[6/8].  Make it what you want the first time.  Also nice if you make
it fit in 80 columns like the rest of the file.

> -static const struct dw_pcie_ops dw_pcie_ops = {
> +static u32 ac5_xlate_dbi_reg(u32 reg)
> +{
> +	/* Handle AC5 ATU access */
> +	if ((reg & ~0xfffff) == PCIE_ATU_ACCESS_MASK_AC5) {
> +		reg &= 0xfffff;
> +		/* ATU registers offset is 0xC00 + 0x200 * n,
> +		 * from RFU registers.
> +		 */
> +		reg = 0xc000 | (0x200 * (reg >> 9)) | (reg & 0xff);
> +	} else if ((reg & 0xfffff000) == PCIE_VENDOR_REGS_OFFSET) {
> +		/* PCIe RFU registers in A8K are at offset 0x8000 from base
> +		 * (0xf2600000) while in AC5 offset is 0x10000 from base
> +		 * (0x800a0000) therefore need the addition of 0x8000.
> +		 */
> +		reg += PCIE_VENDOR_REGS_OFFSET;

This is a hidden assumption that the AC5 offset (0x10000) happens to
be twice PCIE_VENDOR_REGS_OFFSET (0x8000).  I think the AC5 offset
deserves its own separate #define.

Use the conventional multi-line comment style:

  /*
   * ...
   */

> +	pci->ops = data->pcie_ops;
>  	pci->dev = dev;
> -	pci->ops = &dw_pcie_ops;

The diff is easier to read if you don't move the "pci->ops ="
assignment.  Move it if there's a *reason* to move it, but leave it
at the same spot otherwise.
