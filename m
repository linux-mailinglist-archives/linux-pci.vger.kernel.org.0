Return-Path: <linux-pci+bounces-20169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BCEA1766E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 05:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896FE7A26F8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 04:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F717B4EC;
	Tue, 21 Jan 2025 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkTdXA3B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847941527AC
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737432613; cv=none; b=XOcwfmpbZJ7yp3iqb3PfSGsnrS+5tUQ9quVzMDl7juCRK6WDEVVMAVUX/E9avD3wKTzePX/EnU206Ob7ZG2AV5wY12Nbd/TuoKrqMJFaX+z9B2nCbbE9LuKIOvm9pJ9kV87/AuDvdWDZHD64/3YxhkTLBo8UELHxQyCgUMokH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737432613; c=relaxed/simple;
	bh=2677cB2cYRBn/ZI5F3BzpYB/tQDA6LdTZ9oH56N7Lpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj8QwJ83ncALfr40w8cWOrhe4lAk0aNPquayQUFMjeMaMBxpDPFM+nNEf0RAr1Zjrx01r4+hgxTYksEbpZtegzDVLGXHDplWpCrd/yJ7p2VrXZXm5XxgwMek8iCSS5645TmPki7giq7EoznE1649xBxZvXTp4PhaOrHGwU/FLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VkTdXA3B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21649a7bcdcso86447275ad.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 20:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737432610; x=1738037410; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25C9szHhX7J4MA6YES08ppeFphUsaevkSNkDCIhAMZk=;
        b=VkTdXA3BYtV4zQ62AbyAm2PqCWmXqZmBLWrhleoMMlzepB3aRjamwPEu7xXswlT3UL
         C48R4+3nwxQ3n/9kmummaBTv6tVFRCzCeSwpQIQpsJuQalWtUYeZrKVv1gdmioJ12m0Z
         dPxQxIk9AvN0Z+fRcCRg+15GlhzBFw4QduXt/NvtIOyieRF3CGQnlOCWcUC05eHZrs9q
         BCE2rXXVsp3UdI7opwLPWTcfHdt03xP/ubzulPW9k7bNsHJLwOXYmtGPfJivNZ4cSiUG
         S49GYsvWoLbbmS7H2bgtAQbl7PYO2wL9LAXWM/MTqYSYI/asTDj1ldHTXoU7ROhMMUVs
         uCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737432610; x=1738037410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25C9szHhX7J4MA6YES08ppeFphUsaevkSNkDCIhAMZk=;
        b=tLHS2+W9a3wxHbomc6ewysOZov1V3v5/me1K8s1qomXIqJxjhLIAiY9j9hYoyqjuWK
         qfs/FEEEhAOEEnqjefBVXjEbihCz4ggaYsI395Floa2WnB/fPGvxeci2Y5V7PorPrfNg
         4T0/bKc5H3Cwjb6OLXyojSIfTeP+MDW9IJNShOSN1wS1kx0GXr5bhkAAWYMgQSA9GnkM
         56bWAdrdwj4VqzsaoL/4sy+FTKvL497mFtxCPebpezgE4p/nWQwaIWyRiEjxyhpvxhml
         48y0sRBoRN9wCGcjjFCURmIn1pEh4bYMNsUrLBeYoYWlMu2EQ9Lp7IibqPF3aqJoh2Yf
         xJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWOxzaClWDLCFg5fAF0MF0CBVHnOF2Llup5HSF7lyS+/tIVKC1nyPoLnSZmvhaQlPAtT5YA9Yf69jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwISuoL0JCBUQqi5QXyr+Zl1DTgaDbdW0fTpWVcQep7/CFfKn
	QRLiBxRA5reXBrpQs+NI/Bf8/6fAqK3emt+LtaOew+zo9eaR6ecN88bGv60W0A==
X-Gm-Gg: ASbGncsEetom70xhmAtCRyIBw+jsmfd6hPjhfXhAS2pYPE5pyCiGDYBEFW26gBZ8X8c
	eTP/iQTu7ahaawbxSPiz/N14OOU3u0M86H50U59WoZ9BhEyVipiXT55x6tqMeoFPJlqDAsWTHNT
	HdU40wtwSNp+E0wa7gHyIko16Hk5fo6UCK6I38eey+02uxUglYuWrX+HyS3u56B7d+Yb4AyK/GC
	A74zKIXI2ei6KeSqlq2NKMFwzIXOTzC3DNEa2oJq6pdonCYiLe9QumF7aeiVeQH8D626KQVMLYw
	U0+4Vn0=
X-Google-Smtp-Source: AGHT+IE5Kg66oBpFvdTLTvpI6AESwwe9wmyYxOKxkpoiHSTsg6rSQrQzze2gwE5JIYFIh5THYCZMeg==
X-Received: by 2002:a05:6a00:ad8d:b0:72a:ae66:3050 with SMTP id d2e1a72fcca58-72daf931cd0mr21985640b3a.1.1737432610592;
        Mon, 20 Jan 2025 20:10:10 -0800 (PST)
Received: from thinkpad ([117.213.102.234])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa751asm7925904b3a.162.2025.01.20.20.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 20:10:10 -0800 (PST)
Date: Tue, 21 Jan 2025 09:40:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jingoohan1@gmail.com,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v7 2/3] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB
 PCIe Root Port Bridge
Message-ID: <20250121041002.d77m5hloydwqbrzp@thinkpad>
References: <20250119224305.4016221-1-thippeswamy.havalige@amd.com>
 <20250119224305.4016221-3-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250119224305.4016221-3-thippeswamy.havalige@amd.com>

On Mon, Jan 20, 2025 at 04:13:04AM +0530, Thippeswamy Havalige wrote:
> Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

Couple of comments below. With those fixed,

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Changes in v2:
> -------------
> - Modify patch subject.
> - Add pcie host bridge reference.
> - Modify filename as per compatible string.
> - Remove standard PCI properties.
> - Modify interrupt controller description.
> - Indentation
> 
> Changes in v3:
> -------------
> - Modified SLCR to lower case.
> - Add dwc schemas.
> - Remove common properties.
> - Move additionalProperties below properties.
> - Remove ranges property from required properties.
> - Drop blank line.
> - Modify pci@ to pcie@
> 
> Changes in v4:
> -------------
> - None.
> 
> Changes in v5:
> -------------
> - None.
> Changes in v6:
> --------------
> - Reduce dbi size to 4k.
> - update register name to slcr.
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> new file mode 100644
> index 000000000000..db751a51e63c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/amd,versal2-mdb-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
> +
> +maintainers:
> +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: amd,versal2-mdb-host
> +
> +  reg:
> +    items:
> +      - description: MDB System Level Control and Status Register (SLCR) Base
> +      - description: configuration region
> +      - description: data bus interface
> +      - description: address translation unit register
> +
> +  reg-names:
> +    items:
> +      - const: slcr
> +      - const: config
> +      - const: dbi
> +      - const: atu
> +
> +  ranges:
> +    maxItems: 2
> +
> +  msi-map:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-controller:
> +    description: identifies the node as an interrupt controller
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      interrupt-controller: true
> +
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +
> +    required:
> +      - interrupt-controller
> +      - "#address-cells"
> +      - "#interrupt-cells"
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - msi-map
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcie@ed931000 {
> +            compatible = "amd,versal2-mdb-host";
> +            reg = <0x0 0xed931000 0x0 0x2000>,
> +                  <0x1000 0x100000 0x0 0xff00000>,
> +                  <0x1000 0x0 0x0 0x1000>,
> +                  <0x0 0xed860000 0x0 0x2000>;
> +            reg-names = "slcr", "config", "dbi", "atu";
> +            ranges = <0x2000000 0x00 0xa8000000 0x00 0xa8000000 0x00 0x10000000>,

I/O PCI address starts from 0.

Also use 0x0 instead of 0x00 for consistency.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

