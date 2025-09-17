Return-Path: <linux-pci+bounces-36388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E33B821F2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 00:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA76488445
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 22:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D10F30DEBF;
	Wed, 17 Sep 2025 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaKTMrT1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11832FBDFD;
	Wed, 17 Sep 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758147189; cv=none; b=evenklO/PM0n6nmUjCn+pJAfkpFufAZCQdHu5wLIskLktPykO69WMY2fNz5Kv2FNY7+IrssMvJ0wphKxQ6d2DtrHcYJQRPkP5RVfSyfIENPf8xzd4Xeohz+uToWrjEPhxzdNwBlWUS14aqvgWQ8TFB2sZNbN6QtW/F4sL4E+kRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758147189; c=relaxed/simple;
	bh=nRhOXcIKGpSGtX2j3Z7sQdDPzcHkUdRka8dIo7+u2MM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fsJDga/zl3nZjDlxtap2/TMvBdqlk9TT2+nQrOvi1fMOCDRkoE8DOiDFHVzMjhP2LIJCikzSZA3qD+g4nCTYaHCQx/nOzx974QwcH13LG5+eJ+A62DZ9c/xx+u4QEVMhUF5tfHnuVz70IYG5b6VNrA3Y/193/SiNQy2gCCqt8s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaKTMrT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C506C4CEE7;
	Wed, 17 Sep 2025 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758147188;
	bh=nRhOXcIKGpSGtX2j3Z7sQdDPzcHkUdRka8dIo7+u2MM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BaKTMrT1udkFpO61y+Hb4PIDaqrTRP5+K4vQcHhu3ukTFmGGuFhiyBJFYJrcVQOb9
	 Yp+FgtddGxOhXyXQ479M/AYNZAjCbF7W3oTzy0AOE7LQIGXEV+GEmcWss7f11dqTde
	 JNK2/5fySEjH8S3B5iDRzx79wWjGU+JjbX1/h0WdEColE08kYHmT+nU2pIluwYB1rA
	 T9p/acvm2s8Slk8W+oRgopfbQSJ05X8ixNAO+H8hVoF+SwQ8ZtxZMh8WOcFsE375Xf
	 0IjqXKbOYV9D5j9+YmPhWEDZCPnelCPCPIGlzcyKHXk2KJ7XQMJREtdO/irULVANoL
	 d9uVDvLmgJAFQ==
Date: Wed, 17 Sep 2025 17:13:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
Message-ID: <20250917221306.GA1878395@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917045238.1048484-2-hongxing.zhu@nxp.com>

In the subject, can you replace "one more" with something specific?
E.g., maybe "Add external reference clock input" or similar?

On Wed, Sep 17, 2025 at 12:52:36PM +0800, Richard Zhu wrote:
> Add one more reference clock "extref" for a reference clock that comes
> from external crystal oscillator.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8db..0134a759185e 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -105,6 +105,12 @@ properties:
>              define it with this name (for instance pipe, core and aux can
>              be connected to a single source of the periodic signal).
>            const: ref
> +        - description:
> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> +            inputs, one from an internal PLL, the other from an off-chip crystal
> +            oscillator. If present, 'extref' refers to a reference clock from
> +            an external oscillator.
> +          const: extref
>          - description:
>              Clock for the PHY registers interface. Originally this is
>              a PHY-viewport-based interface, but some platform may have
> -- 
> 2.37.1
> 

