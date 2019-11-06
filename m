Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF11AF1AD1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 17:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfKFQJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 11:09:42 -0500
Received: from foss.arm.com ([217.140.110.172]:42422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbfKFQJm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 11:09:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A98346A;
        Wed,  6 Nov 2019 08:09:41 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82DC23F71A;
        Wed,  6 Nov 2019 08:09:39 -0800 (PST)
Date:   Wed, 6 Nov 2019 16:09:37 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        roy.zang@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1028a-pcie"
Message-ID: <20191106160937.GB23381@e121166-lin.cambridge.arm.com>
References: <20190902034319.14026-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902034319.14026-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 02, 2019 at 11:43:17AM +0800, Xiaowei Bao wrote:
> Add the PCIe compatible string for LS1028A

Sentences must be terminated with a period.

> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - No change.
> v3:
>  - No change.
> v4:
>  - No change.
> v5:
>  - No change.
> v6:
>  - No change.
> 
>  Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index e20ceaa..99a386e 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -21,6 +21,7 @@ Required properties:
>          "fsl,ls1046a-pcie"
>          "fsl,ls1043a-pcie"
>          "fsl,ls1012a-pcie"
> +        "fsl,ls1028a-pcie"
>    EP mode:
>  	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
>  - reg: base addresses and lengths of the PCIe controller register blocks.

I have applied this series to pci/layerscape, thanks.

Lorenzo
