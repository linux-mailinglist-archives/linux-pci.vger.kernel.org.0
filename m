Return-Path: <linux-pci+bounces-11717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F96953D85
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 00:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E829B21762
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 22:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73183149E15;
	Thu, 15 Aug 2024 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC0C7mZ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8115E88;
	Thu, 15 Aug 2024 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762040; cv=none; b=VNloqMd1jtAO7imZbf6m6M6rV0cwhXlEju2ZK7kPh8WwYrngm+I7Y15rDq/bbdsAClMVrB3Pku9zt6XaAdrMgd/DvtbqeMdyt7NdU4IFKv+gn+6wPwOmcrqvycMF3TtsYnmsDNu+I+5VUwLoD7EJazZ2vJ2DZRhkvn8mwa8YCoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762040; c=relaxed/simple;
	bh=aAhmwc2XBL2mTwtpKR8e15PDIvETaRybQYrNDcdlfjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aOV6/wfamuWCvRS9eWTZhjShIknn4Ly2ShBLlJMElU2MxTcl90sKL/b+arkQIT23SRpcRxmLpo7PuB0Nk9lW4s8WNv1rdm9FUbPfEmcfAltIuPfXITWefQ3l7ybKIXbtpCI0L7tfM8B4Af6FUlqSWAD3daM6E5YrnRxUsS9Iy+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC0C7mZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3C2C32786;
	Thu, 15 Aug 2024 22:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723762039;
	bh=aAhmwc2XBL2mTwtpKR8e15PDIvETaRybQYrNDcdlfjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TC0C7mZ+1MmFMTo791OuXb0I0rYujgURU+xrl7807tmraxl4osagATfnrYTU+VhXn
	 42+wd/CdwLPwUqXpKSUnFa1EZRukcZr2Nvz9Vg1zAw5NMV4UMvQJCtPNhZo6QvB3l3
	 l5oZMswB++Jds8jpFRgSp4hSbK6XIc7UlIzjatOl6SjaC7QUWcJqeTnq9IDtMH/H9G
	 HsJCvyaubd5fJ2itU5/SgFkMzqw2gx2soY5qeG+wrxxN557QfPgjCHipOHRs7iiAHd
	 7hehjgtB0zuyp0caafzNc9Gxhi9pO1TfG2wNMyi+uFyOJh7GqLsN92+gRUiQU9qgR2
	 +Cl3nYGDi9jPw==
Date: Thu, 15 Aug 2024 17:47:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vidya Sagar <vidyas@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] PCI: qcom-ep: Move controller cleanups to
 qcom_pcie_perst_deassert()
Message-ID: <20240815224717.GA53536@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729122245.33410-1-manivannan.sadhasivam@linaro.org>

[+cc Vidya, Jon since tegra194 does similar things]

On Mon, Jul 29, 2024 at 05:52:45PM +0530, Manivannan Sadhasivam wrote:
> Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
> deinit notify function pci_epc_deinit_notify() are called during the
> execution of qcom_pcie_perst_assert() i.e., when the host has asserted
> PERST#. But quickly after this step, refclk will also be disabled by the
> host.
> 
> All of the Qcom endpoint SoCs supported as of now depend on the refclk from
> the host for keeping the controller operational. Due to this limitation,
> any access to the hardware registers in the absence of refclk will result
> in a whole endpoint crash. Unfortunately, most of the controller cleanups
> require accessing the hardware registers (like eDMA cleanup performed in
> dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
> functions are currently causing the crash in the endpoint SoC once host
> asserts PERST#.
> 
> One way to address this issue is by generating the refclk in the endpoint
> itself and not depending on the host. But that is not always possible as
> some of the endpoint designs do require the endpoint to consume refclk from
> the host (as I was told by the Qcom engineers).
> 
> So let's fix this crash by moving the controller cleanups to the start of
> the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
> called whenever the host has deasserted PERST# and it is guaranteed that
> the refclk would be active at this point. So at the start of this function,
> the controller cleanup can be performed. Once finished, rest of the code
> execution for PERST# deassert can continue as usual.

What makes this v6.11 material?  Does it fix a problem we added in
v6.11-rc1?

Is there a Fixes: commit?

This patch essentially does this:

  qcom_pcie_perst_assert
-   pci_epc_deinit_notify
-   dw_pcie_ep_cleanup
    qcom_pcie_disable_resources

  qcom_pcie_perst_deassert
+   if (pcie_ep->cleanup_pending)
+     pci_epc_deinit_notify(pci->ep.epc);
+     dw_pcie_ep_cleanup(&pci->ep);
    dw_pcie_ep_init_registers
    pci_epc_init_notify

Maybe it makes sense to call both pci_epc_deinit_notify() and
pci_epc_init_notify() from the PERST# deassert function, but it makes
me question whether we really need both.

pcie-tegra194.c has a similar structure:

  pex_ep_event_pex_rst_assert
    pci_epc_deinit_notify
    dw_pcie_ep_cleanup

  pex_ep_event_pex_rst_deassert
    dw_pcie_ep_init_registers
    pci_epc_init_notify

Is there a reason to make them different, or could/should a similar
change be made to tegra?

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 2319ff2ae9f6..e024b4dcd76d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -186,6 +186,8 @@ struct qcom_pcie_ep_cfg {
>   * @link_status: PCIe Link status
>   * @global_irq: Qualcomm PCIe specific Global IRQ
>   * @perst_irq: PERST# IRQ
> + * @cleanup_pending: Cleanup is pending for the controller (because refclk is
> + *                   needed for cleanup)
>   */
>  struct qcom_pcie_ep {
>  	struct dw_pcie pci;
> @@ -214,6 +216,7 @@ struct qcom_pcie_ep {
>  	enum qcom_pcie_ep_link_status link_status;
>  	int global_irq;
>  	int perst_irq;
> +	bool cleanup_pending;
>  };
>  
>  static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
> @@ -389,6 +392,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  		return ret;
>  	}
>  
> +	if (pcie_ep->cleanup_pending) {

Do we really need this flag?  I assume the cleanup functions could
tell whether any previous setup was done?

> +		pci_epc_deinit_notify(pci->ep.epc);
> +		dw_pcie_ep_cleanup(&pci->ep);
> +		pcie_ep->cleanup_pending = false;
> +	}
> +
>  	/* Assert WAKE# to RC to indicate device is ready */
>  	gpiod_set_value_cansleep(pcie_ep->wake, 1);
>  	usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
> @@ -522,10 +531,9 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
>  
> -	pci_epc_deinit_notify(pci->ep.epc);
> -	dw_pcie_ep_cleanup(&pci->ep);
>  	qcom_pcie_disable_resources(pcie_ep);
>  	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
> +	pcie_ep->cleanup_pending = true;
>  }
>  
>  /* Common DWC controller ops */
> -- 
> 2.25.1
> 

