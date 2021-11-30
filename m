Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25246368B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhK3OZt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 09:25:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33190 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhK3OZt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 09:25:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF0F5B81A02;
        Tue, 30 Nov 2021 14:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532E0C53FCD;
        Tue, 30 Nov 2021 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638282147;
        bh=3+/5iwystls40fckNW8SLuocskVo5H8LAK4JbnvcCtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RAzG8hmI7LxL3BsrQSEg7baE1yLleKswlv0YpfPcJLzTquLaLi/7BpU3PA/G84B42
         D3WwknTGIZx4Ynpe6iySTdD3lpPU8HcAqvch7j8IGOti/G3RJxgo2QAcH1gJWkPR6Q
         t/jPZ5g5hnTq2YJseuGnW8nse+3JncCDkDGK9sVkx/aQBRIvVWqJ1DNjhn616oafZs
         r4wZGlvG+RXkBzADJJyZPw1Ezwz1YUmbyYOto6MjXD87N76nm+lu4jOlc7Z/Ts8Rod
         XwtXFF73NFsAKDEzjTW1ZZ8ChMJ4QvjLi0+chh+5n8laVO+CT7yJ9jZrHThcLyG8EY
         /Qpp9ylavnytg==
Date:   Tue, 30 Nov 2021 08:22:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme
 interrupts
Message-ID: <20211130142225.GA2731608@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120001621.21246-5-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 06:16:21PM -0600, Li Yang wrote:
> Some platforms using this controller have separated interrupt lines for
> aer or pme events instead of having a single interrupt line for
> miscellaneous events.  Define interrupts in the binding for these
> interrupt lines.

s/separated/separate/

In subject, commit log, and description and comments below:

s/aer/AER/
s/pme/PME/

These are acronyms, not words, and capitalizing them matches usage in
the specs.

It's OK to keep them lower-case in code-like things like variable
names and interrupt-names.

> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../devicetree/bindings/pci/layerscape-pci.txt     | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 8fd6039a826b..bcf11bfc4bab 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -31,8 +31,13 @@ Required properties:
>  - reg: base addresses and lengths of the PCIe controller register blocks.
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> -- interrupt-names: Must include the following entries:
> -  "intr": The interrupt that is asserted for controller interrupts
> +- interrupt-names: It could include the following entries:
> +  "aer": For interrupt line reporting aer events when non MSI/MSI-X/INTx mode
> +		is used
> +  "pme": For interrupt line reporting pme events when non MSI/MSI-X/INTx mode
> +		is used
> +  "intr": For interrupt line reporting miscellaneous controller events
> +  ......
>  - fsl,pcie-scfg: Must include two entries.
>    The first entry must be a link to the SCFG device node
>    The second entry is the physical PCIe controller index starting from '0'.
> @@ -52,8 +57,9 @@ Example:
>  		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
>  		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>  		reg-names = "regs", "config";
> -		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> -		interrupt-names = "intr";
> +		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>, /* aer interrupt */
> +			<GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* pme interrupt */
> +		interrupt-names = "aer", "pme";
>  		fsl,pcie-scfg = <&scfg 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
> -- 
> 2.25.1
> 
