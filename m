Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42E07622F0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 22:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjGYUFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGYUFU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 16:05:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BFF11A;
        Tue, 25 Jul 2023 13:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1B3E618CB;
        Tue, 25 Jul 2023 20:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F2BC433C8;
        Tue, 25 Jul 2023 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690315518;
        bh=KbZ7xcfcFhT25D3gtOxDO4GakROqumhS5uMELtEXV0Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JNwtE5fban7jWQ1PRTNc3jNaCcyJ5nHy9x4611ZvDP2YhiWx8ysF8NuyhML+TR3IR
         hYhTTWKV6lWVCLnImgEIFoIxpuvN/yoZtxaFquorZMCYXUp+OZtbdG2iMaYtH3heW8
         OP1nG7jVbS7+9TrDtjJ+rqdpoK+fQBsVLqdnifklI1TOaSmZaHCYC1cu5RWRMBPub+
         Ea8gT33O6e1RS4nxTMXwxM3HXRPDJJAM4ZOlL9hPCAKtOy1GwubBQUnFKmyJvd6mU7
         H6M8XSGVB1AsdTVOdt7TWAUOHEvkGDB6CCVrDuZoNcOI5Tbbg+2ubYvhJYbHCmky67
         EOmVdRhu/9PIQ==
Date:   Tue, 25 Jul 2023 15:05:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sajid Dalvi <sdalvi@google.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] Revert "PCI: dwc: Wait for link up only if link is
 started"
Message-ID: <20230725200515.GA663333@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706082610.26584-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Fabio, Xiaolei, Jon]

On Thu, Jul 06, 2023 at 10:26:10AM +0200, Johan Hovold wrote:
> This reverts commit da56a1bfbab55189595e588f1d984bdfb5cf5924.
> 
> A recent commit broke controller probe by returning an error in case the
> link does not come up during host initialisation.
> 
> As explained in commit 886a9c134755 ("PCI: dwc: Move link handling into
> common code") and as indicated by the comment "Ignore errors, the link
> may come up later" in the code, waiting for link up and ignoring errors
> is the intended behaviour:
> 
> 	 Let's standardize this to succeed as there are usecases where
> 	 devices (and the link) appear later even without hotplug. For
> 	 example, a reconfigured FPGA device.
> 
> Reverting the offending commit specifically fixes a regression on
> Qualcomm platforms like the Lenovo ThinkPad X13s which no longer reach
> the interconnect sync state if a slot does not have a device populated
> (e.g. an optional modem).
> 
> Note that enabling asynchronous probing by default as was done for
> Qualcomm platforms by commit c0e1eb441b1d ("PCI: qcom: Enable async
> probe by default"), should take care of any related boot time concerns.
> 
> Finally, note that the intel-gw driver is the only driver currently not
> providing a start_link callback and instead starts the link in its
> host_init callback, and which may avoid an additional one-second timeout
> during probe by making the link-up wait conditional. If anyone cares,
> that can be done in a follow-up patch with a proper motivation.
> 
> Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
> Reported-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Cc: Sajid Dalvi <sdalvi@google.com>
> Cc: Ajay Agarwal <ajayagarwal@google.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

da56a1bfbab5 appeared in v6.5-rc1, so we should definitely fix this
before v6.5.

Based on the conversation here, I applied this to for-linus for v6.5.

I looked for Bjorn A's report but couldn't find it; I'd like to
include the URL if there is one.  I did add the reports from Fabio
Estevam, Xiaolei Wang, and Jon Hunter (Fabio and Xiaolei even included
patches).

Current commit log, corrections/additions welcome:

  This reverts commit da56a1bfbab55189595e588f1d984bdfb5cf5924.

  Bjorn Andersson, Fabio Estevam, Xiaolei Wang, and Jon Hunter reported that
  da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started") broke
  controller probing by returning an error in case the link does not come up
  during host initialisation, e.g., when the slot is empty.

  As explained in commit 886a9c134755 ("PCI: dwc: Move link handling into
  common code") and as indicated by the comment "Ignore errors, the link may
  come up later" in the code, waiting for link up and ignoring errors is the
  intended behaviour:

    Let's standardize this to succeed as there are usecases where devices
    (and the link) appear later even without hotplug. For example, a
    reconfigured FPGA device.

  Reverting the offending commit specifically fixes a regression on Qualcomm
  platforms like the Lenovo ThinkPad X13s which no longer reach the
  interconnect sync state if a slot does not have a device populated (e.g. an
  optional modem).

  Note that enabling asynchronous probing by default as was done for Qualcomm
  platforms by commit c0e1eb441b1d ("PCI: qcom: Enable async probe by
  default"), should take care of any related boot time concerns.

  Finally, note that the intel-gw driver is the only driver currently not
  providing a .start_link() callback and instead starts the link in its
  .host_init() callback, which may avoid an additional one-second timeout
  during probe by making the link-up wait conditional. If anyone cares, that
  can be done in a follow-up patch with a proper motivation.

  [bhelgaas: add Fabio Estevam, Xiaolei Wang, Jon Hunter reports]
  Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
  Link: https://lore.kernel.org/r/20230704122635.1362156-1-festevam@gmail.com/
  Link: https://lore.kernel.org/r/20230705010624.3912934-1-xiaolei.wang@windriver.com/
  Link: https://lore.kernel.org/r/6ca287a1-6c7c-7b90-9022-9e73fb82b564@nvidia.com
  Link: https://lore.kernel.org/r/20230706082610.26584-1-johan+linaro@kernel.org
  Reported-by: Bjorn Andersson <quic_bjorande@quicinc.com>
  Reported-by: Fabio Estevam <festevam@gmail.com>
  Reported-by: Xiaolei Wang <xiaolei.wang@windriver.com>
  Reported-by: Jon Hunter <jonathanh@nvidia.com>
  Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
  Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
  Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
  Cc: Sajid Dalvi <sdalvi@google.com>
  Cc: Ajay Agarwal <ajayagarwal@google.com>

> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 13 ++++--------
>  drivers/pci/controller/dwc/pcie-designware.c  | 20 +++++++------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>  3 files changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cf61733bf78d..9952057c8819 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -485,20 +485,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_remove_edma;
>  
> -	if (dw_pcie_link_up(pci)) {
> -		dw_pcie_print_link_status(pci);
> -	} else {
> +	if (!dw_pcie_link_up(pci)) {
>  		ret = dw_pcie_start_link(pci);
>  		if (ret)
>  			goto err_remove_edma;
> -
> -		if (pci->ops && pci->ops->start_link) {
> -			ret = dw_pcie_wait_for_link(pci);
> -			if (ret)
> -				goto err_stop_link;
> -		}
>  	}
>  
> +	/* Ignore errors, the link may come up later */
> +	dw_pcie_wait_for_link(pci);
> +
>  	bridge->sysdata = pp;
>  
>  	ret = pci_host_probe(bridge);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index df092229e97d..8e33e6e59e68 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -644,20 +644,9 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>  	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
>  }
>  
> -void dw_pcie_print_link_status(struct dw_pcie *pci)
> -{
> -	u32 offset, val;
> -
> -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> -
> -	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> -		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> -		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> -}
> -
>  int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  {
> +	u32 offset, val;
>  	int retries;
>  
>  	/* Check if the link is up or not */
> @@ -673,7 +662,12 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		return -ETIMEDOUT;
>  	}
>  
> -	dw_pcie_print_link_status(pci);
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +
> +	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> +		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> +		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 615660640801..79713ce075cc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -429,7 +429,6 @@ void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  int dw_pcie_edma_detect(struct dw_pcie *pci);
>  void dw_pcie_edma_remove(struct dw_pcie *pci);
> -void dw_pcie_print_link_status(struct dw_pcie *pci);
>  
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> -- 
> 2.39.3
> 
