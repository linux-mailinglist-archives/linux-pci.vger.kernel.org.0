Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A61499194
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 21:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348672AbiAXUMG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 15:12:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33698 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378280AbiAXUGo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 15:06:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25EA460989;
        Mon, 24 Jan 2022 20:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DB4C340E5;
        Mon, 24 Jan 2022 20:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643054803;
        bh=tAxMFrZB97HTTzVWzaI/qrmHKlzIq2ip8Mfv5JarAmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W71W7OVtlJXUuzDFOk4JNI3jFFGpgJEWDwmQccXN2Sp6MvKfTszyA9pNH+/chP+7S
         AnJDhIObpRrxXfudSNj6cqZXbINuLF5Y7pGb7zr2DC+bd/YXrAaNUNIMeTEWf4yDYE
         Miir9XGkeks2RYTOw/CQna7HPJn1PIsmfZcYSvuRrXqCzImlUIu32veQcMlzrTXc7b
         m7EPBYtGKfrGoipdu9cncLKmh6zxvFVDBzcH9cb3sMC/z5AdUZv23XEgSpxWYZbPku
         o5vOCZTHDMCFCCZolSlNkiDjckOwhjzH/J3uL0nTHS3bntFwFV9inMlyvZL/+MDHHs
         TjxxMgsR4d90g==
Date:   Mon, 24 Jan 2022 14:06:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH RESEND v2 1/5] dt-bindings: pci: st-pcie: PCIe controller
 found on STi platforms
Message-ID: <20220124200641.GA1546900@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103074731.3651-2-avolmat@me.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 03, 2022 at 08:47:27AM +0100, Alain Volmat wrote:
> Addition of the bindings for the Designware based PCIe controller
> that can be found on STi platforms such as STiH407, STiH410 or STiH418.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
>  .../devicetree/bindings/pci/st,st-pcie.yaml   | 112 ++++++++++++++++++
>  2 files changed, 113 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,st-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index 9ed0dfba7f89..3a92078128f7 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -35,7 +35,7 @@ properties:
>      maxItems: 5
>      items:
>        enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
> -              ulreg, smu, mpu, apb, phy ]
> +              ulreg, smu, mpu, apb, phy, mem-window ]
>  
>    num-lanes:
>      description: |
> diff --git a/Documentation/devicetree/bindings/pci/st,st-pcie.yaml b/Documentation/devicetree/bindings/pci/st,st-pcie.yaml
> new file mode 100644
> index 000000000000..2fa686d573c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/st,st-pcie.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/st,st-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe RC controller on ST STi platform
> +
> +maintainers:
> +  - Alain Volmat <avolmat@me.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: st,stih407-pcie
> +
> +  reg:
> +    items:
> +      - description: Controller control and status registers.
> +      - description: PCIe configuration registers.
> +      - description: Memory made available to the controller
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: mem-window

I guess "mem-window" is the range for inbound DMA?  Other controllers
should have similar ranges.  Can we use the same DT reg names used by
other controllers instead of adding something new and STi-specific?

> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +    - description: Controller reset
> +    - description: Powerdown reset (optional)
> +    minItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: softreset
> +      - const: powerdown

"softreset" and "powerdown" appear only in this binding.  Are they
really unique to STi, or can we use the same names used for other
controllers?
