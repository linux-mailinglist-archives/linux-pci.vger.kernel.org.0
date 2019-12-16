Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA921202AA
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 11:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLPKcd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 05:32:33 -0500
Received: from foss.arm.com ([217.140.110.172]:49062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfLPKcc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 05:32:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D71C91FB;
        Mon, 16 Dec 2019 02:32:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EFAD3F6CF;
        Mon, 16 Dec 2019 02:32:31 -0800 (PST)
Date:   Mon, 16 Dec 2019 10:32:29 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: qcom: Add support for SDM845
 PCIe
Message-ID: <20191216103229.GP24359@e119886-lin.cambridge.arm.com>
References: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
 <20191107001642.1127561-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107001642.1127561-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:16:41PM -0800, Bjorn Andersson wrote:
> Add compatible and necessary clocks and resets definitions for the
> SDM845 PCIe controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> 
> Changes since v1:
> - Picked up Rob and Vinod's R-b
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index ada80b01bf0c..981b4de12807 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -11,6 +11,7 @@
>  			- "qcom,pcie-ipq4019" for ipq4019
>  			- "qcom,pcie-ipq8074" for ipq8074
>  			- "qcom,pcie-qcs404" for qcs404
> +			- "qcom,pcie-sdm845" for sdm845
>  
>  - reg:
>  	Usage: required
> @@ -126,6 +127,18 @@
>  			- "master_bus"	AXI Master clock
>  			- "slave_bus"	AXI Slave clock
>  
> +-clock-names:
> +	Usage: required for sdm845
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +			- "aux"		Auxiliary clock
> +			- "cfg"		Configuration clock
> +			- "bus_master"	Master AXI clock
> +			- "bus_slave"	Slave AXI clock
> +			- "slave_q2a"	Slave Q2A clock
> +			- "tbu"		PCIe TBU clock
> +			- "pipe"	PIPE clock
> +
>  - resets:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> @@ -188,6 +201,12 @@
>  			- "pwr"			PWR reset
>  			- "ahb"			AHB reset
>  
> +- reset-names:
> +	Usage: required for sdm845
> +	Value type: <stringlist>
> +	Definition: Should contain the following entries
> +			- "pci"			PCIe core reset
> +
>  - power-domains:
>  	Usage: required for apq8084 and msm8996/apq8096
>  	Value type: <prop-encoded-array>
> -- 
> 2.23.0
> 
