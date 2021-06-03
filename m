Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FD839A5A0
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFCQVb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 12:21:31 -0400
Received: from foss.arm.com ([217.140.110.172]:45146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCQVb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 12:21:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5066E11B3;
        Thu,  3 Jun 2021 09:19:46 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1BE83F73D;
        Thu,  3 Jun 2021 09:19:44 -0700 (PDT)
Date:   Thu, 3 Jun 2021 17:19:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, robh@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: imx6q-pcie: Add "vph-supply" for PHY
 supply voltageg
Message-ID: <20210603161939.GA19835@lpieralisi>
References: <1622183383-3287-1-git-send-email-hongxing.zhu@nxp.com>
 <1622183383-3287-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622183383-3287-2-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 28, 2021 at 02:29:42PM +0800, Richard Zhu wrote:
> The i.MX8MQ PCIe PHY can use either a 1.8V or a 3.3V power supply.
> Add a "vph-supply" property to indicate which regulator supplies
> power for the PHY.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
>  1 file changed, 3 insertions(+)

For DT bindings you must CC devicetree@vger.kernel.org, please resend.

Thanks,
Lorenzo

> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index de4b2baf91e8..d8971ab99274 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -38,6 +38,9 @@ Optional properties:
>    The regulator will be enabled when initializing the PCIe host and
>    disabled either as part of the init process or when shutting down the
>    host.
> +- vph-supply: Should specify the regulator in charge of VPH one of the three
> +  PCIe PHY powers. This regulator can be supplied by both 1.8v and 3.3v voltage
> +  supplies.
>  
>  Additional required properties for imx6sx-pcie:
>  - clock names: Must include the following additional entries:
> -- 
> 2.17.1
> 
