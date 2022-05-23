Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C034530ACE
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 10:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiEWHmY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 03:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiEWHmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 03:42:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF10F17AAD;
        Mon, 23 May 2022 00:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53BC1611EA;
        Mon, 23 May 2022 07:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B264CC385A9;
        Mon, 23 May 2022 07:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653291727;
        bh=HAjPqoyDD6oHGanrXj5u75+aRxLCv20nYIubEPTBqpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yl18+CX+VP/9hYN/HE7P3LbzW6fCp4NMkC7qFpZDMKoOvcqmQITxeGG5uXpov5jUt
         XRMScnFLJA+mZYF8TOrA/R2Q+FuV44ZXAm46F2gSAadgbTTpF1gBnwKIra2G73usVj
         OibCFyHe8Xug86Ck6FLc+wpXisPqBDGNgHcWcv97JOolI3y2vRe2n2qZtDBzrSw3tm
         oD1kqI9q236yKbj19vQlfofGRKUH441Z6G4U/sfanFoHgyn4fsfshAHAu6dMz2gpGo
         OaFdTv0KtDJNWR70PvFIR+MlE69bW1enP/xXnJqHzr2rt4T02M5FTS6NU5fr7xeDma
         /f9a536ppnXKQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nt2hY-0001Xt-Cu; Mon, 23 May 2022 09:42:04 +0200
Date:   Mon, 23 May 2022 09:42:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v11 0/7] PCI: qcom: Fix higher MSI vectors handling
Message-ID: <Yos6zKHUKywKcmzy@hovoldconsulting.com>
References: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520183114.1356599-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 09:31:07PM +0300, Dmitry Baryshkov wrote:
> I have replied with my Tested-by to the patch at [2], which has landed
> in the linux-next as the commit 20f1bfb8dd62 ("PCI: qcom:
> Add support for handling MSIs from 8 endpoints"). However lately I
> noticed that during the tests I still had 'pcie_pme=nomsi', so the
> device was not forced to use higher MSI vectors.
> 
> After removing this option I noticed that hight MSI vectors are not
> delivered on tested platforms. After additional research I stumbled upon
> a patch in msm-4.14 ([1]), which describes that each group of MSI
> vectors is mapped to the separate interrupt. Implement corresponding
> mapping.
> 
> The first patch in the series is a revert of  [2] (landed in pci-next).
> Either both patches should be applied or both should be dropped.
> 
> Patchseries dependecies: [3] (for the schema change).
> 
> Changes since v10:
>  - Remove has_split_msi_irqs flag. Trust DT and use split MSI IRQs if
>    they are described in the DT. This removes the need for the
>    pcie-qcom.c changes (everything is handled by the core (suggested by
>    Johan).

You could also mention the rebase and fixed warnings with less than
eight msi.
 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-4.14/-/commit/671a3d5f129f4bfe477152292ada2194c8440d22
> [2] https://lore.kernel.org/linux-arm-msm/20211214101319.25258-1-manivannan.sadhasivam@linaro.org/
> [3] https://lore.kernel.org/linux-arm-msm/20220422211002.2012070-1-dmitry.baryshkov@linaro.org/
> 
> 
> Dmitry Baryshkov (7):
>   PCI: dwc: Convert msi_irq to the array
>   PCI: dwc: split MSI IRQ parsing/allocation to a separate function
>   PCI: dwc: Handle MSIs routed to multiple GIC interrupts
>   PCI: dwc: Implement special ISR handler for split MSI IRQ setup
>   dt-bindings: PCI: qcom: Support additional MSI interrupts
>   arm64: dts: qcom: sm8250: provide additional MSI interrupts
>   dt-bindings: mfd: qcom,qca639x: add binding for QCA639x defvice

Looks like you used the wrong offsets from HEAD or something when
generating the series as the first two patches ([1] above, which is not
yet in linux-next, and the dw_pcie_free_msi() fix) are now missing and
the last patch is new and unrelated.

Johan
