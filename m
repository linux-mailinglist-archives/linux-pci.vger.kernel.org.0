Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46799B18D
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393322AbfHWOEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 10:04:55 -0400
Received: from foss.arm.com ([217.140.110.172]:35076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfHWOEz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Aug 2019 10:04:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9429128;
        Fri, 23 Aug 2019 07:04:54 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A388D3F718;
        Fri, 23 Aug 2019 07:04:52 -0700 (PDT)
Date:   Fri, 23 Aug 2019 15:04:47 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        roy.zang@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, zhiqiang.hou@nxp.com,
        bhelgaas@google.com
Subject: Re: [PATCH v4 1/3] dt-bindings: pci: layerscape-pci: add compatible
 strings "fsl,ls1028a-pcie"
Message-ID: <20190823140447.GA19283@e121166-lin.cambridge.arm.com>
References: <20190823082643.10903-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823082643.10903-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 23, 2019 at 04:26:41PM +0800, Xiaowei Bao wrote:
> Add the PCIe compatible string for LS1028A
> 
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

This series does not apply to v5.3-rc1, what is it based on ?

Lorenzo
