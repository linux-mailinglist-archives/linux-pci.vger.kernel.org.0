Return-Path: <linux-pci+bounces-12907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5271696FC0E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 21:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65E21F2435A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 19:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38AD1C86FB;
	Fri,  6 Sep 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZU2+aMoo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D713D8B4;
	Fri,  6 Sep 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650358; cv=none; b=UprYwRP7FtYJ4WfhAGkwjjUhcvhzIWfG2xyjPTgb4Dko2NhryIM7nOdGitGnIVdH+H0QVdN2Yulgj0YY4exp69vnWhpt3Lfp8M+XzfHUjuqXqrot3W9hXEktkY0NtCSXg6cAOEn5Gm4aZz8weIhopCJzdze+MVfyakLHq0YPgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650358; c=relaxed/simple;
	bh=uzldwJZF5hTvN4y6bSJPJbRlepiP11kuFlhBZ0Sx01I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bOWYR7YlxpVZNaRO+hx2VPDkL7lCMVYDHiLx3GW6FpK5AkeypLrfW903n6y51WQHPdWHee3gZDTKP653XhAlN+3mKEYEdec/JcBSf8Je07su8ssw9sJNExf0gKuuW/9QExz10Uf8eiFmKNQUm4Q4Bi+ZgagxFn3D/gtY5yhRvjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZU2+aMoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0367C4CEC4;
	Fri,  6 Sep 2024 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725650358;
	bh=uzldwJZF5hTvN4y6bSJPJbRlepiP11kuFlhBZ0Sx01I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZU2+aMoobVJIjpK1lUEyHJIbj3oEoCgBqnA9qUkYrgm7TwcFBbvytVTOEfcSzLU77
	 MJZLnovtfotDB3aaOImmguA0OIvfL+BL8w1v3QpjQpiOxtXeuMyqwQGb6y2hQ4R9C7
	 m9k2qH0z+QE1USt3nmfoLQNikDL0MBC3RNOuRU5gsAh0uLtLwyvj4Frfto8MTZSi8F
	 6lZ+iZWfQao72hLfUVqWdJFwOX33ewQx2LIpkON9AjNiS5n5OKFETvpbCV7q5GZNFB
	 0NEFI6o2slttAogJbt6kIESUwzwYwIbo6/H38fce8HixHD42Zeuv+zq1H6XHJGtaBX
	 PHSjbeQRSkwBA==
Date: Fri, 6 Sep 2024 14:19:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: manivannan.sadhasivam@linaro.org, robh@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	bharat.kumar.gogada@amd.com, michal.simek@amd.com,
	lpieralisi@kernel.org, kw@linux.com
Subject: Re: [PATCH 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller-1
Message-ID: <20240906191915.GA425558@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906093148.830452-3-thippesw@amd.com>

On Fri, Sep 06, 2024 at 03:01:48PM +0530, Thippeswamy Havalige wrote:
> In the CPM5, controller-1 has platform-specific error interrupt bits
> located at different offsets compared to controller-0.

Technically mentions a difference between controller-0 and
controller-1, but doesn't say what the patch does.

> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>
> ---
>  drivers/pci/controller/pcie-xilinx-cpm.c | 39 +++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index a0f5e1d67b04..d672f620bc4c 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -30,10 +30,13 @@
>  #define XILINX_CPM_PCIE_REG_IDRN_MASK	0x00000E3C
>  #define XILINX_CPM_PCIE_MISC_IR_STATUS	0x00000340
>  #define XILINX_CPM_PCIE_MISC_IR_ENABLE	0x00000348
> -#define XILINX_CPM_PCIE_MISC_IR_LOCAL	BIT(1)
> +#define XILINX_CPM_PCIE0_MISC_IR_LOCAL	BIT(1)
> +#define XILINX_CPM_PCIE1_MISC_IR_LOCAL	BIT(2)
>  
> -#define XILINX_CPM_PCIE_IR_STATUS       0x000002A0
> -#define XILINX_CPM_PCIE_IR_ENABLE       0x000002A8
> +#define XILINX_CPM_PCIE0_IR_STATUS       0x000002A0
> +#define XILINX_CPM_PCIE1_IR_STATUS       0x000002B4
> +#define XILINX_CPM_PCIE0_IR_ENABLE       0x000002A8
> +#define XILINX_CPM_PCIE1_IR_ENABLE       0x000002BC

These are all indented with spaces; should use tabs like the other
definitions above.

>  #define XILINX_CPM_PCIE_IR_LOCAL        BIT(0)

Same here (although you didn't change this one).

>  #define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
> @@ -280,10 +283,17 @@ static void xilinx_cpm_pcie_event_flow(struct irq_desc *desc)
>  	pcie_write(port, val, XILINX_CPM_PCIE_REG_IDR);
>  
>  	if (port->variant->version == CPM5) {
> -		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE_IR_STATUS);
> +		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE0_IR_STATUS);
>  		if (val)
>  			writel_relaxed(val, port->cpm_base +
> -					    XILINX_CPM_PCIE_IR_STATUS);
> +					    XILINX_CPM_PCIE0_IR_STATUS);
> +	}
> +
> +	else if (port->variant->version == CPM5_HOST1) {
> +		val = readl_relaxed(port->cpm_base + XILINX_CPM_PCIE1_IR_STATUS);
> +		if (val)
> +			writel_relaxed(val, port->cpm_base +
> +					    XILINX_CPM_PCIE1_IR_STATUS);
>  	}

When possible, I think it would be nicer to encode this difference in
the data, i.e., in struct xilinx_cpm_variant, than in the code.  For
example,

    struct xilinx_cpm_variant {
      enum xilinx_cpm_version version;
 +    u32 ir_status;
    }

    static const struct xilinx_cpm_variant cpm5_host = {
      .version = CPM5,
 +    .ir_status = XILINX_CPM_PCIE0_IR_STATUS,
    };

    static const struct xilinx_cpm_variant cpm5_host = {
      .version = CPM5_HOST1,
 +    .ir_status = XILINX_CPM_PCIE1_IR_STATUS,
    };

Then this code could look like this, where it basically tests a
*feature* instead of checking for all the different variants:

  struct xilinx_cpm_variant *variant = port->variant;

  if (variant->ir_status) {
    val = readl_relaxed(port->cpm_base + variant->ir_status);
    if (val)
      writel_relaxed(port->cpm_base + variant->ir_status);
  }

(Apparently the CPM variant doesn't require this at all?)

>  	/*
> @@ -483,12 +493,19 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
>  	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
>  	 * CPM SLCR block.
>  	 */
> -	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> +	writel(XILINX_CPM_PCIE0_MISC_IR_LOCAL,
>  	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
>  
>  	if (port->variant->version == CPM5) {
>  		writel(XILINX_CPM_PCIE_IR_LOCAL,
> -		       port->cpm_base + XILINX_CPM_PCIE_IR_ENABLE);
> +		       port->cpm_base + XILINX_CPM_PCIE0_IR_ENABLE);
> +	}
> +
> +	else if (port->variant->version == CPM5_HOST1) {
> +		writel(XILINX_CPM_PCIE1_MISC_IR_LOCAL,
> +		       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> +		writel(XILINX_CPM_PCIE_IR_LOCAL,
> +		       port->cpm_base + XILINX_CPM_PCIE1_IR_ENABLE);

This looks questionable and worth a comment if this is what you
intend.

  CPM
    - sets PCIE0_MISC_IR_LOCAL in PCIE_MISC_IR_ENABLE

  CPM5
    - sets PCIE0_MISC_IR_LOCAL in PCIE_MISC_IR_ENABLE
    - sets PCIE_IR_LOCAL in PCIE0_IR_ENABLE

  CPM5_HOST1
    - sets PCIE0_MISC_IR_LOCAL in PCIE_MISC_IR_ENABLE
    - sets PCIE1_MISC_IR_LOCAL in PCIE_MISC_IR_ENABLE (overwrite)
    - sets PCIE_IR_LOCAL in PCIE1_IR_ENABLE

The CPM5_HOST1 overwrite looks either wrong or like the first write
was unnecessary.

You might be able to simplify this by adding .misc_ir_value,
.ir_enable, and .ir_local_value:

  struct xilinx_cpm_variant *variant = port->variant;

  writel(variant->misc_ir_value,
         port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
  if (variant->ir_enable)
    writel(variant->ir_local_value, port->cpm_base + ir_enable);

>  	/* Enable the Bridge enable bit */

Unrelated to *this* patch except for being in the diff context, but
"enable the enable bit" is unclear because "enable" isn't something
you can do to a bit; you can *set* or *clear* a bit.

Bjorn

