Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB924EDEA
	for <lists+linux-pci@lfdr.de>; Sun, 23 Aug 2020 17:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHWPc3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Aug 2020 11:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgHWPc2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Aug 2020 11:32:28 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A7CD206B5;
        Sun, 23 Aug 2020 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598196747;
        bh=Z6ZPWRlmCAHW1jTvwzP3xfRIxulAioPOnJbhxtTXie8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRJJUrAWNUG6/ToeybbY5+Zm9YBoUmBTb3xPRl8DpTR/5eUibABGHFx9+tyO8sA1W
         toktLTkNX2qKqeH6Ih4FD29VPty/AojWiASr436+QMsheofeY+JtAwQqei+KeSd7IX
         Hlkqhjy9Do+iMJkHBY4GqkSqi0HSerBNHksTX7gk=
Date:   Sun, 23 Aug 2020 21:02:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, svarbanov@mm-sol.com,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        mgautam@codeaurora.org, smuthayy@codeaurora.org,
        varada@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: Re: [PATCH V2 1/7] dt-bindings: PCI: qcom: Add ipq8074 Gen3 PCIe
 compatible
Message-ID: <20200823153222.GS2639@vkoul-mobl>
References: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
 <1596036607-11877-2-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596036607-11877-2-git-send-email-sivaprak@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29-07-20, 21:00, Sivaprakash Murugesan wrote:
> ipq8074 has two PCIe ports while the support for Gen2 PCIe port is
> already available add the support for Gen3 binding.
> 
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 47 ++++++++++++++++++++++

The issue is the yaml file is not in linux-phy next.. did we get the
conversion done?

>  1 file changed, 47 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 2eef6d5..e0559dd 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -23,6 +23,7 @@ properties:
>        - qcom,pcie-ipq8064
>        - qcom,pcie-ipq8064-v2
>        - qcom,pcie-ipq8074
> +      - qcom,pcie-ipq8074-gen3
>        - qcom,pcie-msm8996
>        - qcom,pcie-qcs404
>        - qcom,pcie-sdm845
> @@ -295,6 +296,52 @@ allOf:
>         compatible:
>           contains:
>             enum:
> +             - qcom,pcie-ipq8074-gen3
> +   then:
> +     properties:
> +       clocks:
> +         items:
> +           - description: sys noc interface clock
> +           - description: AXI master clock
> +           - description: AXI secondary clock
> +           - description: AHB clock
> +           - description: Auxilary clock
> +           - description: AXI secondary bridge clock
> +           - description: PCIe rchng clock
> +       clock-names:
> +         items:
> +           - const: iface
> +           - const: axi_m
> +           - const: axi_s
> +           - const: ahb
> +           - const: aux
> +           - const: axi_bridge
> +           - const: rchng
> +       resets:
> +         items:
> +           - description: PIPE reset
> +           - description: PCIe sleep reset
> +           - description: PCIe sticky reset
> +           - description: AXI master reset
> +           - description: AXI secondary reset
> +           - description: AHB reset
> +           - description: AXI master sticky reset
> +           - description: AXI secondary sticky reset
> +       reset-names:
> +         items:
> +           - const: pipe
> +           - const: sleep
> +           - const: sticky
> +           - const: axi_m
> +           - const: axi_s
> +           - const: ahb
> +           - const: axi_m_sticky
> +           - const: axi_s_sticky
> + - if:
> +     properties:
> +       compatible:
> +         contains:
> +           enum:
>               - qcom,pcie-msm8996
>     then:
>       properties:
> -- 
> 2.7.4

-- 
~Vinod
