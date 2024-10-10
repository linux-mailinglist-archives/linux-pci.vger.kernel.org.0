Return-Path: <linux-pci+bounces-14237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BA9994C4
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158D9284B37
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACADA1E2841;
	Thu, 10 Oct 2024 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcMXFIVQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78516199FC5;
	Thu, 10 Oct 2024 21:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728597467; cv=none; b=HaNuRqley1t7+LD5DW5BfQj0EFPj7mkwBwMUtCkTO9hzlBfz0CMYNVSKp0ynktbjENeb9qOmrxPY9lQ7GrjL5CKWjL2ssJfuP8BYm0aYWUndIqivGHJpAVgug9pIEuVD4spo2UH5bAPchnBaJ9VPBQELQFI9vcBYqyi+IRBo+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728597467; c=relaxed/simple;
	bh=PIg4rNjufMm0ZXzR/fwAAp4m5dnCGXTZBr3gt2g4Pw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vGmHoHNFqFzZkTcOPNYRfpWTL8PH2at5US8sfOV5D8CJnW5t5/WTVkkCCkGZSzt7gPShSNcd0rHA49ePl53j3NE1zoVtHkd5IjLwsDwK9OkenP2Zk2hzOtxxXlQvh5itepWGnG88BssDu8tmBeXSM8uEbpsZMyn4Pv3SQlvs60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcMXFIVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9B6C4CEC5;
	Thu, 10 Oct 2024 21:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728597467;
	bh=PIg4rNjufMm0ZXzR/fwAAp4m5dnCGXTZBr3gt2g4Pw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KcMXFIVQ8jv/XVpwyJ6PfMLyO3SBOCQsoT8JT0jtn2DpAldU8zDYPEFsnLtYIqJx9
	 yh9aKP+gmrcbuJxajxFCDJYbXGwsglKbK6wAKGGVgw9oG2nNO01Geb9UQDm/dbDKWe
	 ItptgUPOAAs7OAUkSG2q2WTlr0mUYDSFslLbijURTxYOAltBOZKNfoMoVis6ILQnvy
	 NFJjIXmZOk0tNaH0cIZ2bNEQ3SziYA+Ponv8xvrFwVfaBrtk0316cftOnh8fS4cZGo
	 7RV01NjlibYg+772jlQwd23RdSMmpH2M3QcDTIhHuWG5vuOtZqBN6gTuZWRUR1GxzO
	 ofMm+nMwk4v6w==
Date: Thu, 10 Oct 2024 16:57:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v4 1/3] of: address: Add parent_bus_addr to struct
 of_pci_range
Message-ID: <20241010215745.GA575297@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008-pci_fixup_addr-v4-1-25e5200657bc@nxp.com>

On Tue, Oct 08, 2024 at 03:53:58PM -0400, Frank Li wrote:
> Introduce field 'parent_bus_addr' in of_pci_range to retrieve untranslated
> CPU address information.

s/in of_pci_range/in struct of_pci_range/

s/CPU address information/parent bus information/ ?

This patch adds "parent_bus_addr" (not "cpu_addr", which already
exists), and if I understand the example below correctly, it says
parent_bus_addr will be 0x8..._.... (an internal address), not a CPU
address, which would be 0x7..._....

I guess "parent_bus_addr" would be a CPU address for the bus@5f000000
ranges, but an IA address for the pcie@5f010000 ranges?

> Refer to the diagram below to understand that the bus fabric in some
> systems (like i.MX8QXP) does not use a 1:1 address map between input and
> output.
> 
> Currently, many controller drivers use .cpu_addr_fixup() callback hardcodes
> that translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR"
> (drivers/pci/controller/cadence/pcie-cadence-plat.c),
> "cpu_addr + BUS_IATU_OFFSET"(drivers/pci/controller/dwc/pcie-intel-gw.c),
> etc, even though those translations *should* be described via DT.
> 
> The .cpu_addr_fixup() can be eliminated if DT correct reflect hardware
> behavior and driver use 'parent_bus_addr' in of_pci_range.
> 
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff0_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► IOSpace   ─┼────────────►
>              BUS Fabric         │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘

Thanks for this diagram.  I think it would be nice if the ranges were
in address order, e.g.,

  0x7000_0000
  0x7ff0_0000
  0x7ff8_0000

(or the reverse).  But it's a little confusing that 0x7ff8_0000 is in
the middle because that's the highest address range of the picture.

> bus@5f000000 {
>         compatible = "simple-bus";
>         #address-cells = <1>;
>         #size-cells = <1>;
>         ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
>                  <0x80000000 0x0 0x70000000 0x10000000>;
> 
>         pcie@5f010000 {
>                 compatible = "fsl,imx8q-pcie";
>                 reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
>                 reg-names = "dbi", "config";
>                 #address-cells = <3>;
>                 #size-cells = <2>;
>                 device_type = "pci";
>                 bus-range = <0x00 0xff>;
>                 ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
>                          <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;

I'm still learning to interpret "ranges", so bear with me and help me
out a bit.

IIUC, "ranges" consists of (child-bus-address, parent-bus-address,
length) triplets.  child-bus-address requires #address-cells of THIS
node, parent-bus-address requires #address-cells of the PARENT, and
length requires #size-cells of THIS node.

I guess bus@5f000000 "ranges" describes the translation from CPU to IA
addresses, so the triplet format would be:

  (1-cell IA child addr, 2-cell CPU parent addr, 1-cell IA length)

and this "ranges":

  ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
           <0x80000000 0x0 0x70000000 0x10000000>;

means:

  (IA 0x5f000000, CPU 0x0 0x5f000000, length 0x21000000)
  (IA 0x80000000, CPU 0x0 0x70000000, length 0x10000000)

which would mean:

  CPU 0x0_5f000000-0x0_7fffffff -> IA 0x5f000000-0x7fffffff
  CPU 0x0_70000000-0x0_7fffffff -> IA 0x80000000-0x8fffffff

I must be misunderstanding something because this would mean CPU addr
0x70000000 would translate to IA addr 0x70000000 via the first range
and to IA addr 0x80000000 via the second range, which doesn't make
sense.

0x0_5f000000 doesn't appear in the diagram.  If it's not relevant, can
you just omit it from the bus@5f000000 "ranges" and just say something
like this?

  ranges = <0x80000000 0x0 0x70000000 0x10000000>, ...;

Then pcie@5f010000 describes the translations from IA to PCI bus
address?  These triplets would be:

  (3-cell PCI child addr, 1-cell IA parent addr, 2-cell PCI length)

  ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
           <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;

which would mean:

  (IA 0x8ff80000, PCI 0x81000000 0 0x00000000, length 0 0x00010000)
  (IA 0x80000000, PCI 0x82000000 0 0x80000000, length 0 0x0ff00000)

  IA 0x8ff80000-0x8ff8ffff -> PCI 0x0_00000000-0x0_0x0008ffff (I/O)
  IA 0x80000000-0x8fefffff -> PCI 0x0_80000000-0x0_0x8fefffff (32-bit mem)

The diagram shows the address translations for all three address
spaces (config, I/O, memory).  If we ignore the 0x5f000000 range, the
mem and I/O paths through the diagram make sense to me:

  CPU 0x0_7ff80000 -> IA 0x8ff80000 -> PCI   0x00000000 I/O
  CPU 0x0_70000000 -> IA 0x80000000 -> PCI 0x0_80000000 mem

I guess config space handled separately from "ranges"?  The diagram
suggests that it's something like this:

  CPU 0x0_7ff00000 -> IA 0x8ff00000 -> PCI 0x00000000 config

which looks like it would match the "reg" property.

> 	};
> };
> 
> 'parent_bus_addr' in of_pci_range can indicate above diagram internal
> address (IA) address information.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - improve commit message by driver source code path.
> 
> Change from v2 to v3
> - cpu_untranslate_addr -> parent_bus_addr
> - Add Rob's review tag
>   I changed commit message base on Bjorn, if you have concern about review
> added tag, let me know.
> 
> Change from v1 to v2
> - add parent_bus_addr in of_pci_range, instead adding new API.
> ---
>  drivers/of/address.c       | 2 ++
>  include/linux/of_address.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 286f0c161e332..1a0229ee4e0b2 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  	else
>  		range->cpu_addr = of_translate_address(parser->node,
>  				parser->range + na);
> +
> +	range->parent_bus_addr = of_read_number(parser->range + na, parser->pna);
>  	range->size = of_read_number(parser->range + parser->pna + na, ns);
>  
>  	parser->range += np;
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 26a19daf0d092..13dd79186d02c 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -26,6 +26,7 @@ struct of_pci_range {
>  		u64 bus_addr;
>  	};
>  	u64 cpu_addr;
> +	u64 parent_bus_addr;
>  	u64 size;
>  	u32 flags;
>  };
> 
> -- 
> 2.34.1
> 

