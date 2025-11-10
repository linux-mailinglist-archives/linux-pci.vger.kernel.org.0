Return-Path: <linux-pci+bounces-40701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65306C46759
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B0E1899F87
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0F308F18;
	Mon, 10 Nov 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCGzzz2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8916CD33;
	Mon, 10 Nov 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776226; cv=none; b=LDSC0NWzsBxWEXqhYkBpfGGt1/9If8NH+hP8Z3DLU3RX4qTM/9CGgaElBauTGZQLqEqWGKkmkrnDWp8Wm9njtrZNY1IJJ631lM10HL7d5TMsv9zNT4dkb006AcxGopZx9VMStQt//2EZpsSt3alKRaz6Nn98MQqT2+T3kla3J0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776226; c=relaxed/simple;
	bh=exuxjfiF+hl8JLjvfyMbiNZrRie/mRLZNK7fcvMzatU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bW08Ie20gpBdmOXCw/yuOGd7U+jbJo8n4wCc8B1EiI4bqfRepqeNMKvrt6ZXLAEKH2SSZWqCnfL8ARlBX1BXyc4gGzA049v6Y6pp8VWd3Y68hHshQTXeiCQo1dhbsJFX9ghDh8os1rmzlN8kz1EkyLIwlyV2NeAvr01QPLujuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCGzzz2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BD3C4CEFB;
	Mon, 10 Nov 2025 12:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762776226;
	bh=exuxjfiF+hl8JLjvfyMbiNZrRie/mRLZNK7fcvMzatU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aCGzzz2B+iIhrbnKcTBUrTkJoaey5UBdodVT7is7nxq/bsuacn1mWrSFdPw3MeBK6
	 xyCChGTKzwMwYsKPORp++PIQx+oQmfnNtOIos9jeZV/f3KCOAW/YIHLHG+zrRI0D6e
	 5XH5FdLJGAwUvLTZVLwlgVxQ1U7uPHKNNvoNLC6NNar+pwcHwQZC3DJVH7mX0O2Buw
	 o5ciXKyW4rtCR77dJnkpGTUBcVt/zSWq2O5mKY+hOtm1cwQ7WY2ytVWFfynHV2nPls
	 ZowwPx5Vyjny8kAE/1ATpZ023Y3oTpA1RwB4kKLzJX4RqOsjBqx79J8tHgoonfuyVD
	 asKXjznFT7D4g==
Date: Mon, 10 Nov 2025 17:33:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, robh@kernel.org, krzk@kernel.org, 
	helgaas@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2] schemas: pci: Document PCIe T_POWER_ON
Message-ID: <gqvc3orlyk6l5jq2bpxsf5lvvafmtxcpdquffcpdqdiek3bldh@l3em25rqaldg>
References: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110112947.2071036-1-krishna.chundru@oss.qualcomm.com>

On Mon, Nov 10, 2025 at 04:59:47PM +0530, Krishna Chaitanya Chundru wrote:
> From PCIe r6, sec 5.5.4 & Table 5-11 in sec 5.5.5 T_POWER_ON is the
> minimum amount of time(in us) that each component must wait in L1.2.Exit
> after sampling CLKREQ# asserted before actively driving the interface to
> ensure no device is ever actively driving into an unpowered component and
> these values are based on the components and AC coupling capacitors used
> in the connection linking the two components.
> 
> This property should be used to indicate the T_POWER_ON for each Root Port.
> 

I'm not sure if we should restrict this property to just Root Ports. Defining a
property in 'pci-bus-common.yaml' means, all PCI bridges could use it, but this
value is applicable to endpoint devices also.

Also, you might want to add some info that the driver (or DT consumer) should
derive the T_POWER_ON Scale and T_POWER_ON Value from this value.

- Mani

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v1:
> - Updated the commiit text (Mani).
> - Link to v1: https://lore.kernel.org/all/20251110112550.2070659-1-krishna.chundru@oss.qualcomm.com/#t
> 
>  dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
> index 5257339..bbe5510 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -152,6 +152,15 @@ properties:
>        This property is invalid in host bridge nodes.
>      maxItems: 1
>  
> +  t-power-on-us:
> +    description:
> +      The minimum amount of time that each component must wait in
> +      L1.2.Exit after sampling CLKREQ# asserted before actively driving
> +      the interface to ensure no device is ever actively driving into an
> +      unpowered component. This value is based on the components and AC
> +      coupling capacitors used in the connection linking the two
> +      components(PCIe r6.0, sec 5.5.4).
> +
>    supports-clkreq:
>      description:
>        If present this property specifies that CLKREQ signal routing exists from
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

