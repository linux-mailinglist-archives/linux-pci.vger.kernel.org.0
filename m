Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6287046A60C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 20:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348777AbhLFT5B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 14:57:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33244 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345170AbhLFT5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 14:57:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80560B81259;
        Mon,  6 Dec 2021 19:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF317C341C2;
        Mon,  6 Dec 2021 19:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638820409;
        bh=YaiGyuoAMZtNHbo6Hvo28lPWKGFlXg2Zux4O7lNuyl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Am2Pm50gCfT/lAyWjlwVELCBhYOWbuwGBGoG/MIDx9u3hUNB49R8zQ0Byc5MYGGdP
         xR0KAb7kgyYkefLP5JahpR3AXYPbYj/74Z+OroSMh26Sc2vaU6McOTNUTKgrTw5zI6
         yFdU0tbS/Z9zTuYnR6v1uykFl1+7l14k9a3qs7w49EIx6xpKwpsRXNxzUIyGCFSPrq
         vIZOfzmooRJDdfBA8ceGfkwHEgqWGVWTGxUcAgt4ktM+9wLTF+kM3QcwRlN85Jkq3k
         +BADILqPJm5fYsI9RpIAVKsUcxuLy0mgCRsBGRdGPsxK49QtwWsEFvHJqvrnO8+Tp8
         oRPd/uEuoGkzw==
Date:   Mon, 6 Dec 2021 13:53:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 05/10] PCI: qcom: add flag to enable use of
 ddrss_sf_tbu clock
Message-ID: <20211206195327.GA5802@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202141726.1796793-6-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 02, 2021 at 05:17:21PM +0300, Dmitry Baryshkov wrote:
> Qualcomm PCIe driver uses compatible string to check if the ddrss_sf_tbu
> clock should be used. Since sc7280 support has added flags, switch to
> the new mechanism to check if this clock should be used.

Thanks for doing this!

If you have occasion to update this series, please update the subject
lines to match the existing convention of capitalizing the first word.
"git log --oneline drivers/pci/controller/dwc/pcie-qcom.c" looks like
this:

  4e0e90539bb0 ("PCI: qcom: Fix an error handling path in 'qcom_pcie_probe()'")
  45a3ec891370 ("PCI: qcom: Add sc8180x compatible")
  aa9c0df98c29 ("PCI: qcom: Switch pcie_1_pipe_clk_src after PHY init in SC7280")
  b89ff410253d ("PCI: qcom: Replace ops with struct pcie_cfg in pcie match data")
  2cfef1971aea ("PCI: qcom: Use PHY_REFCLK_USE_PAD only for ipq8064")
  7081556f81f7 ("PCI: qcom: Add support for ddrss_sf_tbu clock")
  4c9398822106 ("PCI: qcom: Add support for configuring BDF to SID mapping for SM8250")
  e1dd639e374a ("PCI: qcom: Add SM8250 SoC support")

Personally, I would also reorder the wording so the more important
words are earlier, e.g.,

  PCI: qcom: Add ddrss_sf_tbu clock flag
  PCI: qcom: Add SM8450 support
  PCI: qcom: Remove qcom_pcie, qcom_pcie_cfg redundancy

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 64f762cdbc7d..e51b313da46f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -194,7 +194,9 @@ struct qcom_pcie_ops {
>  
>  struct qcom_pcie_cfg {
>  	const struct qcom_pcie_ops *ops;
> +	/* flags for ops 2.7.0 and 1.9.0 */
>  	unsigned int pipe_clk_need_muxing:1;
> +	unsigned int has_ddrss_sf_tbu_clk:1;
>  };
>  
>  struct qcom_pcie {
> @@ -1164,7 +1166,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
>  	res->clks[3].id = "bus_slave";
>  	res->clks[4].id = "slave_q2a";
>  	res->clks[5].id = "tbu";
> -	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sm8250")) {
> +	if (pcie->cfg.has_ddrss_sf_tbu_clk) {
>  		res->clks[6].id = "ddrss_sf_tbu";
>  		res->num_clks = 7;
>  	} else {
> @@ -1515,6 +1517,7 @@ static const struct qcom_pcie_cfg sdm845_cfg = {
>  
>  static const struct qcom_pcie_cfg sm8250_cfg = {
>  	.ops = &ops_1_9_0,
> +	.has_ddrss_sf_tbu_clk = true,
>  };
>  
>  static const struct qcom_pcie_cfg sc7280_cfg = {
> -- 
> 2.33.0
> 
