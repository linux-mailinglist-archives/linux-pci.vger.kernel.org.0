Return-Path: <linux-pci+bounces-21558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47042A37409
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 12:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70DE57A37DB
	for <lists+linux-pci@lfdr.de>; Sun, 16 Feb 2025 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9CB18DB0C;
	Sun, 16 Feb 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJx5Pj5Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9101758B;
	Sun, 16 Feb 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739707022; cv=none; b=IAXUkw7+XYfO4hBG1dZQxMg1qsUiC11xq6NRxlsRqhLnSlb03MqYhqbkZUhkTutRG5keLcOJdBfK200x20kgTb5zepdsLw2dEAT78RGHrlrW6dNGdxzd7N5m83njgLCtqCl04uyNq4x+hyMy+ti3FUKvmgAjzhc6o/jhz12gOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739707022; c=relaxed/simple;
	bh=INgzFAQSUZOHbR17BYG1nE9t4bf6CjVOqoe2+0K8ocM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0I81QNGEZ3pTiKjJtf3LaE9V/MeSw8/cSkPRVgqkPD/zoRAgbLuPVFRUHN1fdLLcFXTebWe6djcj2KSZ5CiB8e326iuqzvD1w81aUaMm+kljArXIcmpdLw0gmis7SQ8+VEtckbeYFWuHzWOMxDmktxLWm5XheS1KqZAJezzZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJx5Pj5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D891EC4CEDD;
	Sun, 16 Feb 2025 11:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739707021;
	bh=INgzFAQSUZOHbR17BYG1nE9t4bf6CjVOqoe2+0K8ocM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HJx5Pj5Z+5S1TFrAdZnTi0YPEonL4fDgzy4DGml5ZvxjKtiaB1MEl+ySb5ndyoxMf
	 QVZSsGECv4ykxizODyikMw80AQ8frybebuau/r/gC7Fzz/G1jrEkJdchNBB8901JxT
	 CsUdxkxa96IUJGYErMGx61oL0uYB1IJHT5GWwG0bbw9tcl3brwlV7FDGCOnkbjs2rk
	 jJVQiZ0mY3fpGvOCcGHDAxasfeESy6bog/a39Ka4aD6DS/0o6BG5Ou5O+R2JOlOHxO
	 WECXuFNxU0vaAst7rq4wtB2CdXvSGlAw2UTNnUx26fke1StQDHMS17cIdeRNyGdm7l
	 dAW0HiSNF0mnA==
Date: Sun, 16 Feb 2025 12:56:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, joyce.ooi@intel.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
	peter.colberg@altera.com
Subject: Re: [PATCH v7 2/7] dt-bindings: intel: document Agilex PCIe Root Port
Message-ID: <20250216-ubiquitous-agile-spoonbill-cf12ab@krzk-bin>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com>
 <20250215155359.321513-3-matthew.gerlach@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250215155359.321513-3-matthew.gerlach@linux.intel.com>

On Sat, Feb 15, 2025 at 09:53:54AM -0600, Matthew Gerlach wrote:
> The Agilex7f devkit can support PCIe End Points with the appropriate
> daughter card.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v7:
>  - New patch to series.
> ---
>  Documentation/devicetree/bindings/arm/intel,socfpga.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> index 2ee0c740eb56..0da5810c9510 100644
> --- a/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> +++ b/Documentation/devicetree/bindings/arm/intel,socfpga.yaml
> @@ -20,6 +20,7 @@ properties:
>                - intel,n5x-socdk
>                - intel,socfpga-agilex-n6000
>                - intel,socfpga-agilex-socdk
> +              - intel,socfpga-agilex7f-socdk-pcie-root-port

Compatible should represent the board, so what is here exactly the
board? 7f? Agilex7f? socdk? Or is it standard agilex-socdk but with some
things attached?

But then, are they attached or you just creat the same board with
different configuration?

Best regards,
Krzysztof


