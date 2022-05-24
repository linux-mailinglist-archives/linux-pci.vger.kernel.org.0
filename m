Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243C2532C9E
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 16:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiEXOxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiEXOxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 10:53:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF36B7FC;
        Tue, 24 May 2022 07:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 71084CE1A79;
        Tue, 24 May 2022 14:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E86BC34113;
        Tue, 24 May 2022 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653403981;
        bh=aQMKObCI/wXU9KRbqc0YGAaJAJMCZKvdynoK3xBEU38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TF2kwm0RqaGemV2Wv/S+jcS7+lxUP9KXaWeAfBWdC2ix95MTDlPNhQbfFdPfdluLH
         K6IvwEbz7a483YDyz+f+SjlxvgxIKsNy0QWSvCfdoUmwsNGalqRLALItMru6SYp4pq
         VuBOcgaRxLFWmSavk/Fvs37WK6vdJ9r/2bBQPI+hKCfqRklLeUFDhe8Vd2zm0WbEiX
         DpO3bnOKsAQAbkrV1ck/0CJOWrRQ3YPyVT8q6ohHa2JPckEVsjdJKeRu7+tbww8yD5
         V2S63Y6yj2InZhsChE2IMGUibZTjpn9H8oqbnxXmjBuJpM7f8N4BtX9TXe2UK9Yolx
         O0wrWizT6njGg==
Date:   Tue, 24 May 2022 09:52:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 0/8] PCI: qcom: Fix higher MSI vectors handling
Message-ID: <20220524145258.GA242731@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523181836.2019180-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 23, 2022 at 09:18:28PM +0300, Dmitry Baryshkov wrote:
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

20f1bfb8dd62 is currently on Lorenzo's pci/qcom branch:

  $ git log --oneline remotes/lorenzo/pci/qcom
  bddedfeb1315 dt-bindings: PCI: qcom: Add schema for sc7280 chipset
  a6f2d6b1b349 dt-bindings: PCI: qcom: Specify reg-names explicitly
  81dab110d351 dt-bindings: PCI: qcom: Do not require resets on msm8996 platforms
  5383d16f0607 dt-bindings: PCI: qcom: Convert to YAML
  3ae93c5a9718 PCI: qcom: Fix unbalanced PHY init on probe errors
  b986db29edbb PCI: qcom: Fix runtime PM imbalance on probe errors
  dcd9011f591a PCI: qcom: Fix pipe clock imbalance
  3007ba831ccd PCI: qcom: Add SM8150 SoC support
  f52d2a0f0d32 dt-bindings: pci: qcom: Document PCIe bindings for SM8150 SoC
  20f1bfb8dd62 PCI: qcom: Add support for handling MSIs from 8 endpoints
  312310928417 Linux 5.18-rc1

Is it safe for me to just drop that single patch before sending the
pull request for v5.19?  Then target the rest of this series for
v5.20?

Bjorn
