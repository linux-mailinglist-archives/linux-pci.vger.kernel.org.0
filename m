Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1ED94DC6
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 21:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfHSTUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 15:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfHSTUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 15:20:31 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17AF12087E;
        Mon, 19 Aug 2019 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242431;
        bh=mG2HJ7ByVaW1dDAJz+vU8qAxV4KuK3rv7da95GJX51M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zSGZjJKJ5pww7+4hGv/zTuIMc45d4i/kLOPPByKZnnoFmkOlGVrgLGVutJggmmbKC
         iSTRM5pmfDRA+ao5V9mA0gTi75FAJXoXjmwNhUTfXJQq37jz7qWWzkrSFoR081bf5C
         HNGtdjqy1cuqxmTkNehM6lKsZ/0M+tv+AzIHv1mw=
Date:   Mon, 19 Aug 2019 14:20:29 -0500
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
Subject: Re: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from Required
 properties
Message-ID: <20190819192029.GS253360@google.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-2-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812042435.25102-2-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:

  s/dt-bingings/dt-bindings/

Also, possibly

  s/PCI:/PCI: designware:/

since this only applies to designware-pcie.txt.

On Mon, Aug 12, 2019 at 04:22:16AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The num-lanes is not a mandatory property, e.g. on FSL
> Layerscape SoCs, the PCIe link training is completed
> automatically base on the selected SerDes protocol, it
> doesn't need the num-lanes to set-up the link width.
> 
> It has been added in the Optional properties. This
> patch is to remove it from the Required properties.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index 5561a1c060d0..bd880df39a79 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -11,7 +11,6 @@ Required properties:
>  	     the ATU address space.
>      (The old way of getting the configuration address space from "ranges"
>      is deprecated and should be avoided.)
> -- num-lanes: number of lanes to use
>  RC mode:
>  - #address-cells: set to <3>
>  - #size-cells: set to <2>
> -- 
> 2.17.1
> 
