Return-Path: <linux-pci+bounces-18642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD1D9F4EC8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A051895493
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126301F4712;
	Tue, 17 Dec 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcnR5NNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8B1EBFE3;
	Tue, 17 Dec 2024 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734447661; cv=none; b=F7tibfsk3HiSSB5NPQrPuYsSDiOpKrxoaMxyhbgSQ9YcuG/tDX2I/4/j/pCpV/KA4v7j06bqpY2RDD4+Bz+Ghm8o9CUB4NV6zjSUDN6YdwCgfo94VKkH0XBIWJDJdrkPpPUklEdrl/lPFHsOMbm5KbTGEf4sX4ctu3QcN+hTNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734447661; c=relaxed/simple;
	bh=oGESw4Z2Z6XFu8JPC4NPpdSSXjk/ztQXAzsuIWRsIP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPcbT19LaGtJkYHBU0yT+aODelzqyKdDUvb4iGoNIQyBCKgytxlM8Z7CioEuyIOqetLr1Rd2xsGg/y5twFWjBVM7UF+I5E4V6vvOH1KPavFBql67M2q2+9TmHTW0buWKNXBjuz/VBVce/vgzHBXypn6uo0jHKu9PVGHbEKV0ByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcnR5NNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A38C4CED3;
	Tue, 17 Dec 2024 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734447660;
	bh=oGESw4Z2Z6XFu8JPC4NPpdSSXjk/ztQXAzsuIWRsIP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcnR5NNU+i+HZX99WpEpnYV9khJg16QL9JMcQGK7zoOesDXHAj67k7PppyxKFLFUl
	 Dox0DqF3qFP0zQKl7BdHkZGq1nadUR+QL6oiYiRcmn6mPskE/V+Q2LK9YNe2wR6y41
	 XnewgirSwaaaTHRJNWO+XmMTJ9/3KkR8/Smc3Wmsw2juatJTL2gYcWsjo6xZ7Busmg
	 tceq1z8z6oqBtOCA3tkuGXx3VzP+bINyUZXQ+nESXPSVLQTDCOBeduiD1wIyztFFVx
	 1JaG2EixZfBqtmy2rAliMSELplqRj0D3rBYZmaRnIoaM3MLDdjGJ7fp+JL0XJ9hlAm
	 AQVZED4nlYD/g==
Date: Tue, 17 Dec 2024 09:00:58 -0600
From: Rob Herring <robh@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [RESEND PATCH v5 1/3] dt-bindings: PCI: dwc: Add AMD Versal2 mdb
 slcr support
Message-ID: <20241217150058.GA1660852-robh@kernel.org>
References: <20241213064035.1427811-1-thippeswamy.havalige@amd.com>
 <20241213064035.1427811-2-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213064035.1427811-2-thippeswamy.havalige@amd.com>

On Fri, Dec 13, 2024 at 12:10:33PM +0530, Thippeswamy Havalige wrote:
> Add support for mdb slcr aperture that is only supported for AMD Versal2
> devices.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v3:
> -------------
> - Introduced below changes in dwc yaml schema.
> Changes in v5:
> -------------
> - Modify mdb_pcie_slcr as constant.
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 548f59d76ef2..696568e81cfc 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -113,6 +113,8 @@ properties:
>                enum: [ smu, mpu ]
>              - description: Tegra234 aperture
>                enum: [ ecam ]
> +            - description: AMD MDB PCIe slcr region
> +              const: mdb_pcie_slcr

Including the block name is redundant. Just 'slcr' is sufficient.

>      allOf:
>        - contains:
>            const: dbi
> -- 
> 2.34.1
> 

