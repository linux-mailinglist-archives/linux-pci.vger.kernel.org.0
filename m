Return-Path: <linux-pci+bounces-6570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA948AE6CD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 14:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1B61C20888
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 12:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D906E12EBF1;
	Tue, 23 Apr 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKY/7MhB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC02D85C48;
	Tue, 23 Apr 2024 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876299; cv=none; b=mTkTd0ajOYaMsKw8P/BJJGEIJacZ/YUt+wKUnvPX4VFXWBEowCMKhU8nkNeF5nLslbXNHHOsevuR81UiuYA1tsjrqqQjmBh0EqmC6YdfkFbIukfT2cR/mmWUfiZvsBZ/ZFP8Z0MNfQXe/DrJ9z5dwXvX6F4oIG+oKlUdnHyuJp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876299; c=relaxed/simple;
	bh=cTXx+iD2wmjxxov1qX3iubOa9Y20RoJrqWIrv/7Wz0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk16loD62knNnz5V3UlkUb6PBWeweXHcGotd5G2Tg70yu+2Kli9oP8m/oK3GaNxMBT5RFxps+29qcjirq7PsWHfWz79pYzGTTrai8m8a/Y6Z35a6pfspY+Zqt2FvIrk0+pLWngcG5vEu7fQcxQN+ysOvFUk+cJxniNQHgzo+rYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKY/7MhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E753EC116B1;
	Tue, 23 Apr 2024 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713876299;
	bh=cTXx+iD2wmjxxov1qX3iubOa9Y20RoJrqWIrv/7Wz0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKY/7MhBGou+3DqZ/lN9QH+aKZ7FDa9tbgHIKuxifPyXktA/MznLQJ1uuwRhwD2lB
	 OmyXEgOTk60IOS1FJJrXEK1huQIM5Njl3G/q+fg3GtKaWH1Kz6tGsCsiJ42M43z0Lo
	 QtZc/bPi71errt/8feNSEc1qXa2sQd3EPwoPzJmlDQVbmsEZwOtaaczeUP4rZAqUNr
	 dyi7rVBAQN0aHCWrbllEil1GKKrufWjy28e/dnnNBB9g1bj3kKqtrSrzliOjuuiYwu
	 vuCT6Am90rSjErLhmETtvcXPFOwHGQyoxUFJiN0B87fYFip+YA9uRq2wHtYlgMMNJa
	 TKXfcsBb5u59A==
Date: Tue, 23 Apr 2024 07:44:56 -0500
From: Rob Herring <robh@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: pci: xilinx-nwl: Add phys
Message-ID: <20240423124456.GB4105016-robh@kernel.org>
References: <20240422195904.3591683-1-sean.anderson@linux.dev>
 <20240422195904.3591683-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422195904.3591683-2-sean.anderson@linux.dev>

On Mon, Apr 22, 2024 at 03:58:58PM -0400, Sean Anderson wrote:
> Add phys properties so Linux can power-on/configure the GTR
> transcievers.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> index 426f90a47f35..02315669b831 100644
> --- a/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
> @@ -61,6 +61,14 @@ properties:
>    interrupt-map:
>      maxItems: 4
>  
> +  phys:
> +    maxItems: 4
> +
> +  phy-names:
> +    maxItems: 4
> +    items:
> +      - pattern: '^pcie-phy[0-3]$'

The names here are pointless and redundant. Names are local to the 
device, so 'pcie' is redundant. They only refer to PHYs, so 'phy' is 
redundant too. All you are left with is the index of the entry.

Now if PCIe can work on only lanes 2 and 3 or similar, then maybe 
-names becomes useful.

Rob

