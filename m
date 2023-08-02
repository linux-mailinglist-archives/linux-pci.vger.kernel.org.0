Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F22B76D3AE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 18:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjHBQbn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjHBQbm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 12:31:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E264210D;
        Wed,  2 Aug 2023 09:31:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AC7A6199A;
        Wed,  2 Aug 2023 16:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347FDC433C8;
        Wed,  2 Aug 2023 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690993900;
        bh=0lpVhKDUd7Tnt1pOBSUzHZtuD1Oebkn4+PkPwpT2kKs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=j0r8Vw0e00dzFIZouvGCpEl3w6wxJOtu5r+oKgbEEIllcsLcOgwkF+oW74VmuJJBr
         gXosxOrbTcwzjl6Ri2+Vpvwaj+dLrnCki/kBmQADQLYHTqjK1iBIe0nH+4h3waSf4r
         M5D19Z0MEPM1/zXyX7/FVkLek5okoT7aKTw3f7d3T0A6x3xJp4N5+9kQoMj3Om7XEg
         o4mGK6UbzNe388NZKfrgdLIRcayKsqL+xqLQhVUYoEmA3lv84UP4bfn656s9Lv9ldl
         QzrI/ZsQwszGGQoAl5MCHtteyeekqY7TOFtRf2V5B13p4QR5qccuN6FUyqNfPADYIn
         dtQWeEO7uAhyA==
Date:   Wed, 2 Aug 2023 11:31:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     mani@kernel.org, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v7 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <20230802163138.GA61043@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802155748.212377-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 11:57:47AM -0400, Frank Li wrote:
> Introduce helper function dw_pcie_get_ltssm to retrieve SMLH_LTSS_STATE.

s/dw_pcie_get_ltssm/dw_pcie_get_ltssm()/

> Add callback .pme_turn_off and .exit_from_l2 for platform specific PME
> handling.
> 
> Add common dw_pcie_suspend(resume)_noirq() API to avoid duplicated code
> in dwc pci host controller platform driver.
> 
> Typical L2 entry workflow/dw_pcie_suspend_noirq()
> 
> 1. Transmit PME turn off signal to PCI devices and wait for PME_To_Ack.
> 2. Await link entering L2_IDLE state.
> 
> Typical L2 exit workflow/dw_pcie_resume_noirq()
> 
> 1. Issue exit from L2 command.
> 2. Reinitialize PCI host.
> 3. Wait for link to become active.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Change from v6 to v7
>  - change according to Manivannan's comments.
>    fix sleep value 100 (should be 1000 for 1ms).

> +	 * PCI Express Base Specification Rev 4.0 Section 5.3.3.2.1 PME
> +	 * Synchronization Recommends 1ms to 10ms timeout to check L2 ready.
> +	 */
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +				1000, 10000, false, pci);

Thanks for the spec citation.  Can you please reference the current
spec, i.e., "PCIe r6.0, sec 5.3.3.2.1".

s/Recommends/recommends/

It would really be great to have a #define for this since the bare
numbers are not very meaningful and they're not specific to DWC so a
#define would let us find similar situations in other drivers.

Bjorn
