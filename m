Return-Path: <linux-pci+bounces-19886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18333A122F1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156E916BD67
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69E23F293;
	Wed, 15 Jan 2025 11:43:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E723F266;
	Wed, 15 Jan 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941384; cv=none; b=LHraWV4TVgXt7xBRnyEbAarJTpDvGiVNKvTo2Rjg5QMZeyJ8zUFdmFRHp1VEQiiLaCozr1M+4JBv9zraubz2gANXI/7nNMCmeb0piKZVYAW09VdrMkHRsi1uqwSTl0fqjAmTvXrDdpi+4uUnzwM3WbkA99MV7WW5OybqQaM1wtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941384; c=relaxed/simple;
	bh=InqappHPXxwAr+7XartCJ+X8hEIz7bXePnlvQCf8JEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfDYkL/zqfT33zmVGu1gbgyfrcLWDAdIa+vBhaAQEYZdrLef4Ql9fr9OYrvLCCeEmrsUdw3z2X9MtNrYDaa+a8334ln9q3c7apMz5PpzDCyBAFKmDpSm5Bu8XMjikihsXaRljufh8zS8wwio9ka6MEPCHC3BbSOENulypF24q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21644aca3a0so144989395ad.3;
        Wed, 15 Jan 2025 03:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736941382; x=1737546182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCinpPyq6kUzNoKBfO2/OVSn+RgG9IGx3IVY4KpK3Ug=;
        b=ra4u6ERPsO8NUo4E2uKt4RyW1d66tH9q7IGaYRHR8IErH0XaQ5VJofWLRyWV69HubG
         4e9pvMn5OdwZF7NhMqWZB/kqP0KdnI3iQIxrcGy6H5dbLn5CAF/wYfh4wtrTqPyLVC1i
         rNRwRmec9oPWGF/IJhQ+t1wUvbSjVapoKfjWQqjGw0wN4YglYPT3ASuaVN/aKOuTRE9l
         6Ahxo2K8ROMm3Aaa6MCAjq8XUkGfn79+OY8DtnzYEIOhAinvD/7wUxt55hjfKKLxoP7b
         9tpALksRHviZNgZRlE5+f5Tiew4RJ0EyplGqW9EVHkQCvb5ipxp4SEbF1BZQfv7Ko6yP
         L8pA==
X-Forwarded-Encrypted: i=1; AJvYcCWN0aZkPzjj/JVmH3+9f62Jsa8ylemHQ4HRdsUBExvpEWkbWCkmUeTmNjm/oYzc0cxhDTceR1F/RpgMrJwo@vger.kernel.org, AJvYcCWfxbwzbjaRl/vip+hAOqOzyE7b6UUkd+yEDXwDpcYHW0nJ14ff2MxVyE6xUD6J94tnhTNt8lkMLty9@vger.kernel.org, AJvYcCXOB8aG7lfbZQKb/WWe+tQWLX6MJFvhcJ0b/Oa1QHMxTF/1tjkqfiWEbjaHHu/8klIEdNoC526/zTDo@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5Ouyqkp+TDOg2GSrPjcxMxWE5u1WpphF9WCU1rKKrTFhkngQ
	B+Omf9JTlyxo12hzmeymY32w/MwbbRPuHAy58lrDlePFEDsjQon+
X-Gm-Gg: ASbGnctbGahR56omOc6WtwIM2bY950Dsk699ekOFWXF6giNtQ7xp21/NVpoT5OW1TTq
	cbtspOAcJp/lQ9mVVSBIYneBOwMnC/jbfY2p+vOvuXd/wveBUkVDd7XJlnjkDysFK5hoTrRYTjo
	ElE85ROXMg+c9ezWRu7X2oPQpdFyVrbpyxr9TtS0Td/naCdsMCIgqxb8wSoQ409qNdwpZ2CmxHv
	8Ya1xn87S3i3qIZ1CeambIwaBrMxzwn+I1kQtv1eLfyqODy0rHbM+1VY/nUv7vl+OaIRav9qxjZ
	ipKnM07q6oTVyvU=
X-Google-Smtp-Source: AGHT+IHQawHUCYw2ob/UyXfWjtyHo9HpYp1N2sGEBkA9xtrXsmWo2Qf3wAOlf+UJO53bmKCDDt6eBQ==
X-Received: by 2002:a17:902:ea03:b0:216:2d42:2e05 with SMTP id d9443c01a7336-21a83f6fa87mr547916735ad.22.1736941381887;
        Wed, 15 Jan 2025 03:43:01 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21e279sm81344075ad.134.2025.01.15.03.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:43:01 -0800 (PST)
Date: Wed, 15 Jan 2025 20:42:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <20250115114259.GP4176564@rocinante>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>

Hello,

> == RC side:
> 
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff8_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
>              BUS Fabric         │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘
> 
> Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
> fabric convert cpu address before send to PCIe controller.
> 
>     bus@5f000000 {
>             compatible = "simple-bus";
>             #address-cells = <1>;
>             #size-cells = <1>;
>             ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> 
>             pcie@5f010000 {
>                     compatible = "fsl,imx8q-pcie";
>                     reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
>                     reg-names = "dbi", "config";
>                     #address-cells = <3>;
>                     #size-cells = <2>;
>                     device_type = "pci";
>                     bus-range = <0x00 0xff>;
>                     ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
>                              <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
>             ...
>             };
>     };
> 
> Device tree already can descript all address translate. Some hardware
> driver implement fixup function by mask some bits of cpu address. Last
> pci-imx6.c are little bit better by fetch memory resource's offset to do
> fixup.
> 
> static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> {
> 	...
> 	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> 	return cpu_addr - entry->offset;
> }
> 
> But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
> although address translate is the same as IORESOURCE_MEM.
> 
> This patches to fetch untranslate range information for PCIe controller
> (pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().
> 
> == EP side:
> 
>                    Endpoint
>   ┌───────────────────────────────────────────────┐
>   │                             pcie-ep@5f010000  │
>   │                             ┌────────────────┐│
>   │                             │   Endpoint     ││
>   │                             │   PCIe         ││
>   │                             │   Controller   ││
>   │           bus@5f000000      │                ││
>   │           ┌──────────┐      │                ││
>   │           │          │ Outbound Transfer     ││
>   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
>   ││     │    │  Fabric  │Bus   │                ││PCI Addr
>   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
>   ││     │CPU │          │0x8000_0000            ││
>   │└─────┘Addr└──────────┘      │                ││
>   │       0x7000_0000           └────────────────┘│
>   └───────────────────────────────────────────────┘
> 
> bus@5f000000 {
>         compatible = "simple-bus";
>         ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> 
>         pcie-ep@5f010000 {
>                 reg = <0x5f010000 0x00010000>,
>                       <0x80000000 0x10000000>;
>                 reg-names = "dbi", "addr_space";
>                 ...                ^^^^
>         };
>         ...
> };
> 
> Add `bus_addr_base` to configure the outbound window address for CPU write.
> The BUS fabric generally passes the same address to the PCIe EP controller,
> but some BUS fabrics convert the address before sending it to the PCIe EP
> controller.
> 
> Above diagram, CPU write data to outbound windows address 0x7000_0000,
> Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
> 
> Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> the device tree provides this information.
> 
> The both pave the road to eliminate ugle cpu_fixup_addr() callback function.

Applied to controller/dwc for v6.14, thank you!

	Krzysztof

