Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438067DD396
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 17:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjJaQ7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 12:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346739AbjJaQ7Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 12:59:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF737A9B;
        Tue, 31 Oct 2023 09:58:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2DEC433C8;
        Tue, 31 Oct 2023 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698771487;
        bh=SDYNmQ31DRGQ6K6cvQJhakeVosYz6EJUiy1qhYajt4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6PHJWwML+z6Tp2ZxssUi6DpmmRgo2PUKJPfl+MxUB2da+3TPLHydgekhWXyukmcM
         Xi9r5ZZ+gQg/I7Gi+iOZCjRVTLa9pBWQrl794nSIjSWmCK+zn+Hef4ehuLlxhAeH1V
         PxNLmzRa3taxJNVAPihEepzCGIx/UjRVQ511sORubx+s/IBr9jlcBgPOYBaLaqQG2c
         0EBB1vnJluGEd/EAnecikr6pBWApK1t/BxLdKyfwkGmo8fg0b4uJuPpx7qFbRvFqVH
         IAK2Dg6whcrjkQK1rYAxY76jYVZROYDediL391AMopkKrmHrRLdhuSB7rzmkcO70vA
         7+Avoub7lvA8w==
Date:   Tue, 31 Oct 2023 22:27:47 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/3] arm64: qcom: sa8775p: add cache coherency support
 for SA8775P
Message-ID: <20231031165747.GF11778@thinkpad>
References: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 31, 2023 at 09:16:23PM +0530, Mrinmay Sarkar wrote:
> This series is to enable cache snooping logic in both RC and EP
> driver and add the "dma-coherent" property in dtsi to support
> cache coherency in SA8775P.
> 

You need to explain why cache snooping needs to be enabled _only_ on SA8775P and
not on other platforms, here and also in patch description.

Cover letter is not just meant for describing the changes you are submitting,
you should also put as much info required for the reviewers/maintainers to get
motivation behind the series.

- Mani

> To verify this series we required [1]
> 
> [1] https://lore.kernel.org/all/1698729108-27356-1-git-send-email-quic_msarkar@quicinc.com/
> 
> Mrinmay Sarkar (3):
>   PCI: qcom: Enable cache coherency for SA8775P RC
>   PCI: qcom-ep: Enable cache coherency for SA8775P EP
>   arm64: dts: qcom: sa8775p: Mark PCIe controller as cache coherent
> 
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  2 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c |  8 ++++++++
>  drivers/pci/controller/dwc/pcie-qcom.c    | 11 +++++++++++
>  3 files changed, 21 insertions(+)
> 
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
