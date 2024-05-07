Return-Path: <linux-pci+bounces-7195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880CA8BEDD3
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4403D28258B
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 20:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D1187326;
	Tue,  7 May 2024 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKt9KQnW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D8187322;
	Tue,  7 May 2024 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112403; cv=none; b=CIKufl4hXRZGcbSiEXwSH/kSBaDNaEawz95cFE+3WeXT/rqbUMTAOyupGYlXX8PvFKwNKOC+DZ4hTFK66QwS11nXRcQwpsMkSGyvoxjSSKMLAr/tERmGDcRpuOpKl6JZ5yVCDJcF1hB0EDOI8VKllwkxKZqaJXbci3BA24yUCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112403; c=relaxed/simple;
	bh=acG14ml/zqtb1vBxEjTQuN/g1tObIuG0QTsAXNvULEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7ItJ55Xh8OZZBtBjQWl+2LZ1zFdfVe5b18yzsWvRMgU2OM4ZOEA7dkGZ0IXVoxc8e6tkGd/Cx726+jAtKcZoapZWM9xSWdljf7W3hiaEd7pg/KPMX3aI8LLbPf9UIrXx/ikwosy4WTlZv7NHr9KGehUfvmjAfETlWD90NwOPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKt9KQnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37D4C2BBFC;
	Tue,  7 May 2024 20:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715112403;
	bh=acG14ml/zqtb1vBxEjTQuN/g1tObIuG0QTsAXNvULEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKt9KQnW8liXbyhKmttXpkF/f3CRwgGzKimW22zRzq64M44sJHSojwmcrmOgv4lHN
	 owDGl3c9BNRcE5H5Nsrjrl2BqvKiVenkl8+tDTdSUQwSPKGBVerxR6M87tGNS3OuuK
	 dERWJ6SdJlifNkZZsxrPaamB2dcY59bZtx2+9BkR9mqhfMG4e6yFX/D+HHOc7uDEpi
	 lsCmd+ampGcDwus562WLhh32w9rn3s3Zb4Cg6BAvrc8GebJF2ru67k76eazC6NH0YG
	 dApaWkeNjw8rodJCxMhnCWkafrbp1fOTmgrwoDJMLQLYI/IzDGC0aQvfaEzWR1EC22
	 lTXuua5ZrJB3w==
Date: Tue, 7 May 2024 15:06:40 -0500
From: Rob Herring <robh@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: pci: xilinx-nwl: Add phys
Message-ID: <20240507200640.GA955773-robh@kernel.org>
References: <20240506161510.2841755-1-sean.anderson@linux.dev>
 <20240506161510.2841755-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506161510.2841755-2-sean.anderson@linux.dev>

On Mon, May 06, 2024 at 12:15:04PM -0400, Sean Anderson wrote:
> Add phys properties so Linux can power-on/configure the GTR
> transcievers.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - Remove phy-names
> - Add an example
> 
>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> index 426f90a47f35..693b29039a9b 100644
> --- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> @@ -61,6 +61,10 @@ properties:
>    interrupt-map:
>      maxItems: 4
>  
> +  phys:
> +    minItems: 1
> +    maxItems: 4

I assume this is 1 phy per lane, but don't make me assume and define it.

Rob

