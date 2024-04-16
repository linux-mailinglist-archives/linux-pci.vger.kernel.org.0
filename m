Return-Path: <linux-pci+bounces-6330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5A68A71D8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954501F234A7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D526130ACC;
	Tue, 16 Apr 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZqFs0N2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F36CDC8;
	Tue, 16 Apr 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713286965; cv=none; b=CfCg1pk1H5YSCj/3M6gPq2YR4ez5y2wand4/8xE471UszDhLOhjTLCO9pkkoInO8y4Wh1MVhAXUl3pjKwiqMoUPbQrKeib3WRGn6s+HpqgEB235biqs0eBxLh+uEGcJoa8Z+z2bduX/HiE2oZp5GrCY5iA3pFSv/UOhf8LIquPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713286965; c=relaxed/simple;
	bh=swpRmuyUm0NTUnfkBwhLOJvbAum9jZWIxRc49A9ZH5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KJQzVtqfNYJJw8cp/bYzTfUfyw6tFiltDsqxrZNywdIjQmx2NwTAYO0ZZDFb2Wy57yTSFhnWpcACGbChlXsorTckYzlman/SNlYYTNE+geT1+Js/ErdByuGDyr4VR42/IkedBA4zkBsM8XjEJwqF6nw4YR7vSnWzliAmJLhIqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZqFs0N2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FC6C113CE;
	Tue, 16 Apr 2024 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713286964;
	bh=swpRmuyUm0NTUnfkBwhLOJvbAum9jZWIxRc49A9ZH5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HZqFs0N2qr133iHkYPMr1Mc2JByYkEaWVvjnKEfjaX32Nhmv2fqJG7Th2YDS66Tqs
	 4tpQoGzhikLNsaxlvpvZfPLEZ5mkf63F7BV6Y45dcVMkLUHVXzQjwmE6LNJHlU6qSa
	 HCITBkntv5/CzIqgXeNgaitqisOJRTNxP27ZMevlI1SM9fXNRp4bLw5RiNzHbUhuET
	 iMApbzOVc2SajcWEOI/aWRYOin/aZ25kh1mxYg5zENyMQ+DAYGVGpZRZqeV/WyM0v2
	 /fqYQzwTKLJvd6PHAdItQkBHuMO64xfKG98KmGhkCWJyC39XXmMqJpFqP1+TYm1Rv7
	 1SgIAXwx7MGiw==
Date: Tue, 16 Apr 2024 12:02:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 4/5] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
Message-ID: <20240416170242.GA164032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-pme_msg-v6-4-56dad968ad3a@nxp.com>

On Mon, Apr 15, 2024 at 03:33:28PM -0400, Frank Li wrote:
> Add PCIE_MSG_CODE_PME_TURN_OFF macros to enable a PCIe host driver to send
> PME_Turn_Off messages.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 19b4227a8a7e8..1f6d54a5a7cfc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -30,6 +30,8 @@
>  #define PCIE_MSG_TYPE_R_LOCAL	4
>  #define PCIE_MSG_TYPE_R_GATHER	5
>  
> +#define PCIE_MSG_CODE_PME_TURN_OFF	0x19

This is defined in PCIe r6.0, sec 2.2.8.2, so move this below the INTx
#defines so they're all in the order of the spec sections and add the
spec citation to follow the same style as the surrounding #defines,
i.e.,

  /* Power Management Messages; PCIe r6.0, sec 2.2.8.2 */
  #define PCIE_MSG_CODE_PME_TURN_OFF   0x19

While you're at it, tweak the [1/5] comments to be:

  /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
  /* INTx Mechanism Messages; PCIe r6.0, sec 2.2.8.1 */

since the "Message Routing See: PCIe ..." comments are run together
and need some punctuation between the text and the citation.

With these,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>  /* INTx Mechanism Messages See: PCIe r6.0, sec 2.2.8.1 */
>  #define PCIE_MSG_CODE_ASSERT_INTA	0x20
>  #define PCIE_MSG_CODE_ASSERT_INTB	0x21
> 
> -- 
> 2.34.1
> 

