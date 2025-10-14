Return-Path: <linux-pci+bounces-38000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F7BBD7040
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 03:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C713A9333
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 01:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078F6262FF8;
	Tue, 14 Oct 2025 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iFXrCGwe"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B21DFCB;
	Tue, 14 Oct 2025 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406959; cv=none; b=M8m0qxyHWnH1eTIR4cA85KqguS/okNCS4n8bwy2mL5VKfxsH9qXh8CI7IeMVcD1Sr5p6y/2yCQd3rpbHZ/U/DTmRvckyGXmbKsja9MF3kT0/fl42V5InqBfJdhoQGOaKXvb9dNUUarJCQtdAcuw8KrMucM+hWghBU7YhccIY/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406959; c=relaxed/simple;
	bh=0mh4xG7+M6ggnaXpSXp8eTqz5OBYvKU3WBQiQrvVGBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k36vTnJf1xojxIdC5cpfAFjA/AAa2zbY6T+Y+FeCvCVamgXT/D6hziUzj+qjLhz7kQvJl1r986/mGz6xiMQMyWHPGHdFmrOOgwsTYp0qTEhpS7JWFDIVlIY8Z/Ik3QKsnojZWq0YHMMcTZ74K7rcINheuhBNbPhBrsVJS+kKuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iFXrCGwe; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2318725CB6;
	Tue, 14 Oct 2025 03:55:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkLoRsdbueVj; Tue, 14 Oct 2025 03:55:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760406953; bh=0mh4xG7+M6ggnaXpSXp8eTqz5OBYvKU3WBQiQrvVGBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iFXrCGwe3S+r7Iu59V4RRMK+8KqNdYf0Y1nCPBYRaS1Uxs9cSz65LUhlVF+z7jlNf
	 anxe9TPPc16H06SRqR/iygEsRqJ2nrCteSSXVgVQ47fvwY9JTogktvvpOFWMxcyljr
	 J1OB1TRF6C0XRqrh5PMijvbKMuX9oD/Ha6BfleDrn9qD6diUFHkA8gRmWsXR0MFD0l
	 NtafMOB9EPDHsxkgxWZD5JOKVvEnO/4Qk2LqdMmSwCw2Wu330kDf4pV22+jEco4hAL
	 RZtHkuSBQ7p+VPvG3ksOXSpCJp+x8Z8u1WreE/R42/3sQO1T/f8yB2VpEvsuBtNuLV
	 IlHR9m6sjEGKw==
Date: Tue, 14 Oct 2025 01:55:28 +0000
From: Yao Zi <ziyao@disroot.org>
To: Alex Elder <elder@riscstar.com>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org, guodong@riscstar.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, christian.bruel@foss.st.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
Message-ID: <aO2tkGSUTYssSaVf@pie>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013153526.2276556-4-elder@riscstar.com>

On Mon, Oct 13, 2025 at 10:35:20AM -0500, Alex Elder wrote:
> Add the Device Tree binding for the PCIe root complex found on the
> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
> typically used to support a USB 3 port.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - Renamed the binding, using "host controller"
>     - Added '>' to the description, and reworded it a bit
>     - Added reference to /schemas/pci/snps,dw-pcie.yaml
>     - Fixed and renamed the compatible string
>     - Renamed the PMU property, and fixed its description
>     - Consistently omit the period at the end of descriptions
>     - Renamed the "global" clock to be "phy"
>     - Use interrupts rather than interrupts-extended, and name the
>       one interrupt "msi" to make clear its purpose
>     - Added a vpcie3v3-supply property
>     - Dropped the max-link-speed property
>     - Changed additionalProperties to unevaluatedProperties
>     - Dropped the label and status property from the example
> 
>  .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> new file mode 100644
> index 0000000000000..87745d49c53a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K1 PCI Express Host Controller
> +
> +maintainers:
> +  - Alex Elder <elder@riscstar.com>
> +
> +description: >
> +  The SpacemiT K1 SoC PCIe host controller is based on the Synopsys
> +  DesignWare PCIe IP.  The controller uses the DesignWare built-in
> +  MSI interrupt controller, and supports 256 MSIs.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:

...

> +  num-viewport:
> +    const: 8

This property has been deprecated for a long time, and the driver now
detects viewports at runtime since commit 281f1f99cf3a (PCI: dwc: Detect
number of iATU windows, 2020-11-05), IOW, it makes no effect with the
current mainline DWC PCIe driver. Is it really necessary?

Best regards,
Yao Zi

