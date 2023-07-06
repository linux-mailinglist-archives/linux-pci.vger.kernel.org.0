Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21540749A54
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 13:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjGFLMi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 07:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGFLMh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 07:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566DDC;
        Thu,  6 Jul 2023 04:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7B0661909;
        Thu,  6 Jul 2023 11:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDADC433C7;
        Thu,  6 Jul 2023 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688641956;
        bh=BOEale8M+9gWzJpHRuHXhPnvc4ZSy1w4GTYANy5u44s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kMxNh/3WZijIVGdc5yewDH3XOYZUJwECrYRcBFuLMNQ6IMO+jdsuY6d6UiK1oWhZx
         vMdet9znENk+RtaQZfEztdHqN1uut3JpGzkFSI17xYpbcX9RGgw2PRiKI6uIpZzhiD
         bfXQOzUbhI3UcUlU/v5fz+mIBTxc1EsVRivVIoHifcmzkQOKhmmSOCFTWXj2rErFBW
         34/4SE/+Sre/Kam6uvCMHHDa4TYCH4ggFSZNAdXJGALxdDqTG1dYhsdXobgKbupeEz
         GOJ/uscUFvn5ndcc75HnJ4G3BMHCYZETHEzWtfVBiu1RYhJbcrzcigPlpj37ufzAWg
         PSSkAfs7Wg0PQ==
Date:   Thu, 6 Jul 2023 16:42:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 0/6] arm64: qcom: sa8775p: add support for PCIe
Message-ID: <20230706111218.GA4808@thinkpad>
References: <1688545032-17748-1-git-send-email-quic_msarkar@quicinc.com>
 <20230705084606.GF11854@thinkpad>
 <a450e2e8-307d-49e9-d76d-de397b801a96@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a450e2e8-307d-49e9-d76d-de397b801a96@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 06, 2023 at 08:39:54AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2023 10:46, Manivannan Sadhasivam wrote:
> > On Wed, Jul 05, 2023 at 01:47:05PM +0530, Mrinmay Sarkar wrote:
> >> Update the relavent DT bindings for PCIe, add new config to the phy
> >> driver add pcie and phy nodes to the .dtsi file and enable then in 
> >> board .dts file for the sa8775p-ride platform.
> >>
> >> Mrinmay Sarkar (6):
> >>   dt-bindings: PCI: qcom: Add sa8775p compatible
> >>   dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY
> >>   PCI: qcom: Add support for sa8775p SoC
> >>   phy: qcom-qmp-pcie: add support for sa8775p
> >>   arm64: dts: qcom: sa8775p: Add pcie0 and pcie1 nodes
> >>   arm64: dts: qcom: sa8775p-ride: enable pcie nodes
> > 
> > Please note that the dts patches should come before driver patches.
> >
> 
> Why? DTS is always independent thus usually put at the end of patchset
> or better separate. It is the first time I hear that DTS should be
> before driver.
> 

This is what I was suggested by Rob during my initial days and I've been
following this pattern since then. If that's not the case, I have no issues.

- Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
