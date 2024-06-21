Return-Path: <linux-pci+bounces-9094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEDC912EC9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 22:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AD31F22095
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8FF16D4CE;
	Fri, 21 Jun 2024 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPU0uu0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3521C6AF;
	Fri, 21 Jun 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002828; cv=none; b=II3oB80m0W9/d8EFTG0eu3E3oQhK1aZLOEPNdXYe7BDeX7r+GgVQvaWP/p8Ow4PCODoNZgtqM7UoNEIpGpovPwyXvZP7BRRdsqUzSgcB2QZEz5pep+3C0+RICha8784XYog0V4HEc7xVmw7ilTgHYpte+jMJSb1Gceaya2vpfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002828; c=relaxed/simple;
	bh=t48+TP5yhU/reT7yabkzWYexkIaNNZf8msp9Wlsf3Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iXmWNh+QI48UAl7mywgsyDGYdwEbUs0jrWXyu+ISdUZ9x5NLXqzGCQ5IkwFHuSR2Z5oIClol9x6h4n0rhn/rxncx8Ld3n0soor+mRSQ30h0HwQskeUo5SH7xuMgumzexRIXc7R+eIZyIhdNNfz0Ohta/oTFRvrjORyWES9iM7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPU0uu0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A67BC32781;
	Fri, 21 Jun 2024 20:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719002827;
	bh=t48+TP5yhU/reT7yabkzWYexkIaNNZf8msp9Wlsf3Eg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qPU0uu0RXQZBESyi9gAi67rXsuXp4js7nyrqyDdO12QT30gnjVeZ/BpwzKb1225TM
	 7/5ISCsRlMUG/Z+4IW3Xe2KTO5GPEWof2l8OWT4qv28SZ7U9zUym0y9nVoYPqDcNvE
	 kDKzFh0PDD9Dr1dz1MdcxBbNSDQrr7O2pEomZ38aApuxVExK2jJtwlg0ivPJBMTESC
	 XI4IdSoxGXXbQu/yZquauvFq+B3FpGbvmOMdFHeqpLHMmED/ftAGSdrsZlWSHwFQmD
	 kux94bWvnup6QjpBuWaAn7pyVnVNrIKzS9ogDsMZdP8oMCS2b9gfmYiVltSULlaix2
	 9zY3EYWklBpCw==
Date: Fri, 21 Jun 2024 15:47:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v1] PCI: qcom: Avoid DBI and ATU register space mirror to
 BAR/MMIO region
Message-ID: <20240621204705.GA1395276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620213405.3120611-1-quic_pyarlaga@quicinc.com>

On Thu, Jun 20, 2024 at 02:34:05PM -0700, Prudhvi Yarlagadda wrote:
> PARF hardware block which is a wrapper on top of DWC PCIe controller
> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
> register to get the size of the memory block to be mirrored and uses
> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
> address of DBI and ATU space inside the memory block that is being
> mirrored.
> 
> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
> boundary is used for BAR region then there could be an overlap of DBI and
> ATU address space that is getting mirrored and the BAR region. This
> results in DBI and ATU address space contents getting updated when a PCIe
> function driver tries updating the BAR/MMIO memory region. Reference
> memory map of the PCIe memory region with DBI and ATU address space
> overlapping BAR region is as below.
> 
> 			|---------------|
> 			|		|
> 			|		|
> 	-------	--------|---------------|
> 	   |	   |	|---------------|
> 	   |	   |	|	DBI	|
> 	   |	   |	|---------------|---->DBI_BASE_ADDR
> 	   |	   |	|		|
> 	   |	   |	|		|
> 	   |	PCIe	|		|---->2*SLV_ADDR_SPACE_SIZE
> 	   |	BAR/MMIO|---------------|
> 	   |	Region	|	ATU	|
> 	   |	   |	|---------------|---->ATU_BASE_ADDR
> 	   |	   |	|		|
> 	PCIe	   |	|---------------|
> 	Memory	   |	|	DBI	|
> 	Region	   |	|---------------|---->DBI_BASE_ADDR
> 	   |	   |	|		|
> 	   |	--------|		|
> 	   |		|		|---->SLV_ADDR_SPACE_SIZE
> 	   |		|---------------|
> 	   |		|	ATU	|
> 	   |		|---------------|---->ATU_BASE_ADDR
> 	   |		|		|
> 	   |		|---------------|
> 	   |		|	DBI	|
> 	   |		|---------------|---->DBI_BASE_ADDR
> 	   |		|		|
> 	   |		|		|
> 	----------------|---------------|
> 			|		|
> 			|		|
> 			|		|
> 			|---------------|

Nice diagram.  Run it through "expand" to convert the tabs to spaces
so it doesn't get messed up if indented.

> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
> used for BAR region which is why the above mentioned issue is not
> encountered. This issue is discovered as part of internal testing when we
> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
> we are trying to fix this.
> 
> As PARF hardware block mirrors DBI and ATU register space after every
> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
> U64_MAX to PARF_SLV_ADDR_SPACE_SIZE register to avoid mirroring DBI and
> ATU to BAR/MMIO region. Write the physical base address of DBI and ATU
> register blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR
> (default 0x1000) respectively to make sure DBI and ATU blocks are at
> expected memory locations.

This seems ... weird.  You mention BARs, which means a PCI device, so
that part must refer to a Root Port.

The diagram also mentions address space *outside* the BAR, so that
cannot be a PCI device (unless the device is defective and responds to
accesses outside its BARs).  Maybe this space belongs to the Root
Complex (which is not a PCI device, so its resources must be described
via DT)?

Is this overlap of BAR space and ATU/DBI stuff (I assume the ATU/DBI
is *not* supposed to be part of the BAR) a result of some invalid
configuration done by a bootloader?  Or is it a result of Linux
assigning invalid space for the BAR?

> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 40 ++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 5 deletions(-)
> 
> Tested:
> - Validated NVME functionality with PCIe6a on x1e80100 platform.
> - Validated WiFi functionality with PCIe4 on x1e80100 platform.
> - Validated NVME functionality with PCIe0 and PCIe1 on SA8775p platform.
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 5f9f0ff19baa..864548657551 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -49,7 +49,12 @@
>  #define PARF_LTSSM				0x1b0
>  #define PARF_SID_OFFSET				0x234
>  #define PARF_BDF_TRANSLATE_CFG			0x24c
> +#define PARF_DBI_BASE_ADDR_V2			0x350
> +#define PARF_DBI_BASE_ADDR_V2_HI		0x354

Previously these functions wrote PARF_DBI_BASE_ADDR:

  qcom_pcie_post_init_1_0_0()
  qcom_pcie_post_init_2_3_2()
  qcom_pcie_post_init_2_3_3()
  qcom_pcie_init_2_7_0()      (weird that this is init, not post_init)
  qcom_pcie_post_init_2_9_0()

This patch updates qcom_pcie_post_init_2_3_2() and
qcom_pcie_init_2_7_0() to use PARF_DBI_BASE_ADDR_V2 instead.

I assume PARF_DBI_BASE_ADDR_V2 and PARF_ATU_BASE_ADDR are new for
2.3.2 and 2.7.0?  And they don't apply to 2.3.3 and 2.9.0?  And 1.0.0,
2.3.3, and 2.9.0 don't have this problem?

It'd be nice to have a hint in the commit log about which versions are
and are not affected.

>  #define PARF_SLV_ADDR_SPACE_SIZE		0x358
> +#define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35C
> +#define PARF_ATU_BASE_ADDR			0x634
> +#define PARF_ATU_BASE_ADDR_HI			0x638
>  #define PARF_NO_SNOOP_OVERIDE			0x3d4
>  #define PARF_DEVICE_TYPE			0x1000
>  #define PARF_BDF_TO_SID_TABLE_N			0x2000
> @@ -319,6 +324,33 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
> +static void qcom_pcie_avoid_dbi_atu_mirroring(struct qcom_pcie *pcie)

I think I would just call this "configure_dbi_atu" or similar, since I
think it's about configuring them correctly, and the mirroring is just
a consequence of doing it wrong.

> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	struct platform_device *pdev;
> +	struct resource *atu_res;
> +	struct resource *dbi_res;
> +
> +	pdev = to_platform_device(pci->dev);
> +	if (!pdev)
> +		return;

I don't think "!pdev" is even possible.

> +	dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	if (dbi_res) {
> +		writel(lower_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2);
> +		writel(upper_32_bits(dbi_res->start), pcie->parf + PARF_DBI_BASE_ADDR_V2_HI);
> +	}
> +
> +	atu_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> +	if (atu_res) {
> +		writel(lower_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR);
> +		writel(upper_32_bits(atu_res->start), pcie->parf + PARF_ATU_BASE_ADDR_HI);
> +	}
> +
> +	writel(lower_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> +	writel(upper_32_bits(U64_MAX), pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_HI);
> +}
> +
>  static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
>  {
>  	u32 val;
> @@ -623,8 +655,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
>  	val &= ~PHY_TEST_PWR_DOWN;
>  	writel(val, pcie->parf + PARF_PHY_CTRL);
>  
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> +	qcom_pcie_avoid_dbi_atu_mirroring(pcie);
>  
>  	/* MAC PHY_POWERDOWN MUX DISABLE  */
>  	val = readl(pcie->parf + PARF_SYS_CTRL);
> @@ -900,6 +931,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	/* Wait for reset to complete, required on SM8450 */
>  	usleep_range(1000, 1500);
>  
> +	qcom_pcie_avoid_dbi_atu_mirroring(pcie);

Why did you move this setup earlier than the previous
PARF_DBI_BASE_ADDR write?  Is there some 2.7.0 difference that requires
this?

>  	/* configure PCIe to RC mode */
>  	writel(DEVICE_TYPE_RC, pcie->parf + PARF_DEVICE_TYPE);
>  
> @@ -908,9 +941,6 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	val &= ~PHY_TEST_PWR_DOWN;
>  	writel(val, pcie->parf + PARF_PHY_CTRL);
>  
> -	/* change DBI base address */
> -	writel(0, pcie->parf + PARF_DBI_BASE_ADDR);
> -
>  	/* MAC PHY_POWERDOWN MUX DISABLE  */
>  	val = readl(pcie->parf + PARF_SYS_CTRL);
>  	val &= ~MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN;



