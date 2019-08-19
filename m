Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619CF94DD7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfHSTYn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 15:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbfHSTYn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 15:24:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09FF1206C1;
        Mon, 19 Aug 2019 19:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242682;
        bh=AP7Vdzra3NcppB0agbt0hGNputzUIfBO2Q8KFiwaX2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4SO6OUPDs3akkK6X0jKRt3/uQXiwFsXxa+QmJFy+HqxrMbrbXzZCGeiE187Fjc+Z
         u7QhIt5LWmeR8hfrNg28WBiPEh6LJQjvi51U2/H5U+q03iWVOIINDqtXaL/7StXi6h
         Z8ieypqUVtUvhZW20m3AoFVdqdgsUPEKRtFA3CdQ=
Date:   Mon, 19 Aug 2019 14:24:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCH 3/4] ARM: dts: ls1021a: Remove num-lanes property from
 PCIe nodes
Message-ID: <20190819192440.GT253360@google.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-4-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812042435.25102-4-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 12, 2019 at 04:22:27AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> On FSL Layerscape SoCs, the number of lanes assigned to PCIe
> controller is not fixed, it is determined by the selected
> SerDes protocol in the RCW (Reset Configuration Word), and
> the PCIe link training is completed automatically base on
> the selected SerDes protocol, and the link width set-up is
> updated by hardware. So the num-lanes is not needed to
> specify the link width.
> 
> The current num-lanes indicates the max lanes PCIe controller
> can support up to, instead of the lanes assigned to the PCIe
> controller. This can result in PCIe link training fail after
> hot-reset. So remove the num-lanes to avoid set-up to incorrect
> link width.

It would be useful to explain *why* "num-lanes" in DT causes a link
training failure.  Maybe the code programs "num-lanes" somewhere,
overriding what hardware automatically sensed?  Maybe the code tries
to bring up exactly "num-lanes" lanes even if not all are present?

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 464df4290ffc..2f6977ada447 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -874,7 +874,6 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			num-lanes = <4>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
> @@ -899,7 +898,6 @@
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			num-lanes = <4>;
>  			num-viewport = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
> -- 
> 2.17.1
> 
