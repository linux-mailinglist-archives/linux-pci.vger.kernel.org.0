Return-Path: <linux-pci+bounces-20113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1422AA1616B
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 12:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843621886188
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jan 2025 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20171CDFD5;
	Sun, 19 Jan 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8GIcEDx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81F2F2F
	for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737287060; cv=none; b=uPSrDU8umMNa9v7yvq8hrtNJegZQNrqLo+Lz6OePdnPvpRxtItLoVCwFWmqnJ7eY8VKnafm6/R/zQmAfzVMiwD+dwwmr3v3XyzzWm81yyHrDAJ9izpu6rUhSuVGPdJEvhGdwYCeKr4MEPiQbaSV5iZKdR/MLkOnydQu59HWwFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737287060; c=relaxed/simple;
	bh=rjVO4xWRk/gjJJA9CXQGZHz8oF/CaRnJdzw2fdD3obU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL8WEpAunDoAg3CqbyVR8OBI1cM06PmLetseJ0ujAt4R0VGqT2DfcgzQY7v66hSzqRO5Gt3GkXhCVupSF0IOcphJf/badOH642RpvRXXdFSgJJodwWcSIely6yJdayJEFDNTHmwVf1z+xylM2JfJS7jjlb5JCqt3iNOhmZ9WdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G8GIcEDx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee74291415so4732055a91.3
        for <linux-pci@vger.kernel.org>; Sun, 19 Jan 2025 03:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737287057; x=1737891857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6+lWdzxEABJhTz3N49CZLSm2ho2j3jwiaZfvlUx3iXU=;
        b=G8GIcEDxCEjrdUDcryMZFA0+Td0BQMyXMEbRvCSmUvLmrdPoZzZ2DlVgwlwGaiyLt5
         WBzD+aVT+yjr5xlMggTrLn0rJoNEue6Fs5JBIm+iGvOE/r7mxFIl2kWTCeu2xtvmSdRc
         0/su5jH1CZsUKt/uL/S+8VOASRTfnuwsGWI9/pN4HXnTbUSiZP0M4JDop+YeNOS77WAy
         G1SkrHusm1CaB1wKLfbpvTBIyOFqLpp5+Iw+Sw69USwGI2dhQiv8jmkGMwpTlGD7tVxs
         GpPpj8Dn7Kxvlfdoxt/PspE0aDNkkIqKGU5eqHKjaQNo2AnZky6ybK6Y9sdBD5qz/K0Z
         gacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737287057; x=1737891857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+lWdzxEABJhTz3N49CZLSm2ho2j3jwiaZfvlUx3iXU=;
        b=AWdfbIFk+7ATpcA5p9yXcnQF/8h94kQhzIwoc93tcU1frLZ0OxjGmyw6sap2X2w3ap
         TD3XkR5OiK5jwv3FqbY43IfNyAv7bWN61X6c5o2NJSrCaSMPPG/NzYWQWS91SFg//nde
         uQL6+tMCbObbx5kf18Csaw1hfGvI+bIoZgaMf+UvLe4Z814eiQM7EUpXjoiF5/iGzI6k
         s7Phw1i2icuBVwye3NhP7pqindqA6I5eu73YLK0Mio+Rk4fl7B2DGVtCY69M5o+Qy3pP
         FfvwiUwdoBD2uLZ8Lw/01yYfKaHqQFqIitGHu+F3T3lbHkgPgICU3y7dherbgrsjaWJ1
         aVHg==
X-Forwarded-Encrypted: i=1; AJvYcCUzD9gUmgkv+rDvmBh/dWPoTr3mq/09B+kgtUY2JgVx2SdBeMA74jjFsLRW46NfCNOlJz5u6/MydbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9fgfrJwEo97Ck/l/L6XFm9kIcZzO/BTT0TMfkwEPIUUi4EWx
	1U0MbrlbcDv6tLNfEyV7/4rTnYn2ETZWCXvQyChrlynd+ssJUkGZCqxyQV0Qcg==
X-Gm-Gg: ASbGncs1sepb//V0nFPrtlKNV3UMcjLAbrSZg9B3jtNoXxhv8bPVbpteShCdPg7icFN
	2VRn91fVOykOYZSRPRbaWEQ8xlXRSm/F/nV+yjajYctZWQtt/HIe9PsEcfgmCwwZrXvM0orKhXz
	I4iEpZqdJjLipY7ifqNziBGeeCO7AcKC8dta8DpRwFzlF+N2XyYIGhsx0UayVysXSZDFpMOozRY
	EOkTgsQ94wo6Y2i7sNk3SdQ+pKrVuwDGFmt7HwcmsLx0jpzoTT23w+NA4nqjw/7nAppNU5h39tp
	OdjskA==
X-Google-Smtp-Source: AGHT+IGIqG0I4JFtsqTLJCOT0IGJ5wugXePDSjsQS2yugp63XxMvwV3JCOcwVD84NlRABzOAby6emQ==
X-Received: by 2002:a17:90b:258c:b0:2ee:dd9b:e3e8 with SMTP id 98e67ed59e1d1-2f782c73b69mr13432058a91.8.1737287056908;
        Sun, 19 Jan 2025 03:44:16 -0800 (PST)
Received: from thinkpad ([120.56.195.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77629acfcsm5520272a91.35.2025.01.19.03.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 03:44:16 -0800 (PST)
Date: Sun, 19 Jan 2025 17:14:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
	arnd@arndb.de, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
	krzk+dt@kernel.org, lee@kernel.org, lpieralisi@kernel.org,
	palmer@dabbelt.com, paul.walmsley@sifive.com, pbrobinson@gmail.com,
	robh@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Message-ID: <20250119114408.3ma4itsjyxki74h4@thinkpad>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <5a784afde48c44b5a8f376f02c5f30ccff8a3312.1736923025.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a784afde48c44b5a8f376f02c5f30ccff8a3312.1736923025.git.unicorn_wang@outlook.com>

On Wed, Jan 15, 2025 at 03:06:37PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add binding for Sophgo SG2042 PCIe host controller.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 147 ++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> new file mode 100644
> index 000000000000..f98e71822144
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/sophgo,sg2042-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 PCIe Host (Cadence PCIe Wrapper)
> +
> +description:
> +  Sophgo SG2042 PCIe host controller is based on the Cadence PCIe core.
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +properties:
> +  compatible:
> +    const: sophgo,sg2042-pcie-host
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: cfg
> +
> +  vendor-id:
> +    const: 0x1f1c
> +
> +  device-id:
> +    const: 0x2042
> +
> +  msi:
> +    type: object
> +    $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: sophgo,sg2042-pcie-msi
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      interrupt-names:
> +        const: msi
> +
> +  msi-parent: true
> +
> +  sophgo,link-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      SG2042 uses Cadence IP, every IP is composed of 2 cores (called link0
> +      & link1 as Cadence's term). Each core corresponds to a host bridge,
> +      and each host bridge has only one root port. Their configuration
> +      registers are completely independent. SG2042 integrates two Cadence IPs,
> +      so there can actually be up to four host bridges. "sophgo,link-id" is
> +      used to identify which core/link the PCIe host bridge node corresponds to.
> +
> +      The Cadence IP has two modes of operation, selected by a strap pin.
> +
> +      In the single-link mode, the Cadence PCIe core instance associated
> +      with Link0 is connected to all the lanes and the Cadence PCIe core
> +      instance associated with Link1 is inactive.
> +
> +      In the dual-link mode, the Cadence PCIe core instance associated
> +      with Link0 is connected to the lower half of the lanes and the
> +      Cadence PCIe core instance associated with Link1 is connected to
> +      the upper half of the lanes.
> +
> +      SG2042 contains 2 Cadence IPs and configures the Cores as below:
> +
> +                     +-- Core (Link0) <---> pcie_rc0  +-----------------+
> +                     |                                |                 |
> +      Cadence IP 1 --+                                | cdns_pcie0_ctrl |
> +                     |                                |                 |
> +                     +-- Core (Link1) <---> disabled  +-----------------+
> +
> +                     +-- Core (Link0) <---> pcie_rc1  +-----------------+
> +                     |                                |                 |
> +      Cadence IP 2 --+                                | cdns_pcie1_ctrl |
> +                     |                                |                 |
> +                     +-- Core (Link1) <---> pcie_rc2  +-----------------+
> +
> +      pcie_rcX is PCIe node ("sophgo,sg2042-pcie-host") defined in DTS.
> +
> +      Sophgo defines some new register files to add support for their MSI
> +      controller inside PCIe. These new register files are defined in DTS as
> +      syscon node ("sophgo,sg2042-pcie-ctrl"), i.e. "cdns_pcie0_ctrl" /
> +      "cdns_pcie1_ctrl". cdns_pcieX_ctrl contains some registers shared by
> +      pcie_rcX, even two RC (Link)s may share different bits of the same
> +      register. For example, cdns_pcie1_ctrl contains registers shared by
> +      link0 & link1 for Cadence IP 2.
> +
> +      "sophgo,link-id" is defined to distinguish the two RC's in one Cadence IP,
> +      so we can know what registers (bits) we should use.
> +
> +  sophgo,syscon-pcie-ctrl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the PCIe System Controller DT node. It's required to
> +      access some MSI operation registers shared by PCIe RCs.
> +
> +allOf:
> +  - $ref: cdns-pcie-host.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - vendor-id
> +  - device-id
> +  - sophgo,link-id
> +  - sophgo,syscon-pcie-ctrl
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pcie@62000000 {
> +      compatible = "sophgo,sg2042-pcie-host";
> +      device_type = "pci";
> +      reg = <0x62000000  0x00800000>,
> +            <0x48000000  0x00001000>;

Use single space between address and size.

> +      reg-names = "reg", "cfg";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
> +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;

For sure you don't need to set 'relocatable' flag for both regions.

> +      bus-range = <0x00 0xff>;
> +      vendor-id = <0x1f1c>;
> +      device-id = <0x2042>;

As Bjorn explained in v2, these properties need to be moved to PCI root port
node. Your argument of a single root port node for a host bridge doesn't add as
we have found that describing the root port properties in host bridge only
creates issues.

Btw, we are migrating the existing single RP platforms too to root port node.

> +      cdns,no-bar-match-nbits = <48>;
> +      sophgo,link-id = <0>;
> +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;

Where is the num-lanes property?

> +      msi-parent = <&msi_pcie>;
> +      msi_pcie: msi {

'msi' is not a standard node name. 'interrupt-controller' is what usually used
to describe the MSI node.

Btw, is the MSI controller a separate IP inside the host bridge? If not, there
would no need to add a separate node. Most of the host bridge IPs implementing
MSI controller, do not use a separate node.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

