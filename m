Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ACF5A461B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiH2Jbr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiH2Jbn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 05:31:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771345B059;
        Mon, 29 Aug 2022 02:31:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3606AB80E1B;
        Mon, 29 Aug 2022 09:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EB6C433D6;
        Mon, 29 Aug 2022 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661765498;
        bh=DaCQt9/itQJTFVdFfWf2frefrBLkra5oL6E0l2pgOzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1UjB0kz4tKX6+aXtk/He42QK6ZZIjjj/2jm80uSBrcPBl4lY/Dd6jNYRYf/JUG4U
         szWPIe1xCyqeYejjPqpgiL/3mT0MpGeqf/fDv/w/9JaYEQJ52aB7IL/oIZdI7eZ/Di
         xUgy9/KikHWIT8ph7bTwX0xtdndX09wc/Mumr5Jpfaf2KW9iw1qG6rz4R9LYfxqIBd
         jDn3eeeiVskvTLkW6BhEKIEqvlEo3r1ydKymYg/EA1oVgE6283p85em2S2AX92DZrv
         7l3AFbXJAm1z2+rfx7i0P9Qa0nzL5ryLWEM+BCa8tL7GQkm8TFm2GASwWsb5mkX1Uk
         UJ4NxvhppiRVQ==
Date:   Mon, 29 Aug 2022 11:31:32 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: aardvark: Add support for PCI Bridge Subsystem
 Vendor ID on emulated bridge
Message-ID: <YwyHdMv1JsQNuVGS@lpieralisi>
References: <20220711221823.12154-1-pali@kernel.org>
 <20220711225915.13896-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220711225915.13896-1-pali@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 12:59:15AM +0200, Pali Rohár wrote:
> Register with Subsystem Device/Vendor ID is at offset 0x2c. Export is via
> emulated bridge.

"Export it..." I suppose.

So in short, this patch enables support for the Subsystem Device/Vendor
ID - by reading it in the PCI controller config space and storing it
in the emulated bridge control structures, so that it is exposed in
the respective PCI capability.

Correct ?

Thanks,
Lorenzo

> After this change Subsystem ID is visible in lspci output at line:
> 
>   Capabilities: [40] Subsystem
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> ---
> Changes in v2:
> * Fix wrong rebase, do not add PCIE_CORE_EXP_ROM_BAR_REG
> ---
>  drivers/pci/controller/pci-aardvark.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 74511f015168..060936ef01fe 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -32,6 +32,7 @@
>  #define PCIE_CORE_DEV_ID_REG					0x0
>  #define PCIE_CORE_CMD_STATUS_REG				0x4
>  #define PCIE_CORE_DEV_REV_REG					0x8
> +#define PCIE_CORE_SSDEV_ID_REG					0x2c
>  #define PCIE_CORE_PCIEXP_CAP					0xc0
>  #define PCIE_CORE_ERR_CAPCTL_REG				0x118
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX			BIT(5)
> @@ -982,6 +983,8 @@ static int advk_sw_pci_bridge_init(struct advk_pcie *pcie)
>  	/* Indicates supports for Completion Retry Status */
>  	bridge->pcie_conf.rootcap = cpu_to_le16(PCI_EXP_RTCAP_CRSVIS);
>  
> +	bridge->subsystem_vendor_id = advk_readl(pcie, PCIE_CORE_SSDEV_ID_REG) & 0xffff;
> +	bridge->subsystem_id = advk_readl(pcie, PCIE_CORE_SSDEV_ID_REG) >> 16;
>  	bridge->has_pcie = true;
>  	bridge->data = pcie;
>  	bridge->ops = &advk_pci_bridge_emul_ops;
> -- 
> 2.20.1
> 
