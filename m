Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E63332C7E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 17:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhCIQq7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 11:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhCIQqo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Mar 2021 11:46:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2603A6523C;
        Tue,  9 Mar 2021 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615308404;
        bh=RMuhxlWDr/r4WRIMBjUfGXkdUAHrO0I8oA8IyU3VFFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ARjXIRzW1QTmrBj4oKD8skJteEymA+z/2M7i8AfLGwdsFqzQ7G1/ziAc+LX4BxVKk
         AkzSp4ZpHyIVYodLKh9oZAw/WPGyOvj9EyuFGaIhZxnRRzMfwo+u27hLIcEn4Ex8Qy
         FGdcxm0JsYuadm3V7eaJoH9b6Sm49jlWdBtg4Cphszrt6nHWHYR8/U52cVZsb6KA9q
         OsWwmatkgmcMqCwmTMBVn3gs6iQTlF0A5Ea9o9uB2lDr7m2BY5kM3sLkeCVO5n+owx
         t+BLwi2eQUx4iR6ktE0/iHOyYFWBsvGJ7SAIrZ8vwjA62DRNfSfhvFS66nXSVmnWuU
         YwmSP581kulFg==
Received: by mail-ed1-f44.google.com with SMTP id b13so21578666edx.1;
        Tue, 09 Mar 2021 08:46:44 -0800 (PST)
X-Gm-Message-State: AOAM533/BAE5JtfuN5BOzCHTGZ+bYD9nMBpxlDpiClRHJ7XJL8Hax9tH
        6DFojF9aPu8dRrBvPnY8WxjHngZT/H86v6/GsA==
X-Google-Smtp-Source: ABdhPJyEb71X8b4Z+MqyVeM6DPC6hgj3zw9kIgCbE/MTLqqs0cnJzMorzefBS1R28UIUW2kwGB6bbNEoNb9+T3Y7jEs=
X-Received: by 2002:a05:6402:c88:: with SMTP id cm8mr5184509edb.62.1615308402777;
 Tue, 09 Mar 2021 08:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20210309073142.13219-1-nadeem@cadence.com> <20210309073142.13219-2-nadeem@cadence.com>
In-Reply-To: <20210309073142.13219-2-nadeem@cadence.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Mar 2021 09:46:30 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJf1JHNEygoSPOqFocXL4F4M7p-MB-UxOp=D--NKnvTZw@mail.gmail.com>
Message-ID: <CAL_JsqJf1JHNEygoSPOqFocXL4F4M7p-MB-UxOp=D--NKnvTZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings:pci: Set LTSSM Detect.Quiet state delay.
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 9, 2021 at 12:31 AM Nadeem Athani <nadeem@cadence.com> wrote:
>
> The parameter detect-quiet-min-delay can be used to program the minimum
> time that LTSSM waits on entering Detect.Quiet state.
> 00 : 0us minimum wait time in Detect.Quiet state.
> 01 : 100us minimum wait time in Detect.Quiet state.
> 10 : 1000us minimum wait time in Detect.Quiet state.
> 11 : 2000us minimum wait time in Detect.Quiet state.

What determines this setting? Is it per board or SoC? Is this a
standard PCI timing thing? Why does this need to be tuned per
platform?

> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-host.yaml        | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> index 293b8ec318bc..a1d56e0be419 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> @@ -27,6 +27,18 @@ properties:
>
>    msi-parent: true
>
> +  detect-quiet-min-delay:
> +    description:
> +      LTSSM Detect.Quiet state minimum delay.
> +      00 : 0us minimum wait time
> +      01 : 100us minimum wait time
> +      10 : 1000us minimum wait time
> +      11 : 2000us minimum wait time
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 3
> +    default: 0
> +
>  required:
>    - reg
>    - reg-names
> @@ -48,6 +60,7 @@ examples:
>              linux,pci-domain = <0>;
>              vendor-id = <0x17cd>;
>              device-id = <0x0200>;
> +            detect-quiet-min-delay = <0>;
>
>              reg = <0x0 0xfb000000  0x0 0x01000000>,
>                    <0x0 0x41000000  0x0 0x00001000>;
> --
> 2.15.0
>
