Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FEA2D7C0F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 18:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393446AbgLKRDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 12:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732975AbgLKRDW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Dec 2020 12:03:22 -0500
X-Gm-Message-State: AOAM53178bA+nCbFcIII+02iSM8zYFOh9cBF2vy7h/n1oiublmNnnqJ1
        N0w6MQfQ1uweOfSkJ2FvB30Xq7t02ea1SautGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607706161;
        bh=y0iNFo76mlQYUJFryBQiNquPjuWXnGlz2WqZxVAwjgA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I4hM40l0M6OrHcn/orBRf8m08bD+W2kUjwQDYMu2dfdLEI5iOFFPUSLVVTyk7i9l8
         zi6unOryox1CdcqSQHhktMrMxrprrvFLvpkdIkZKWmO44Yk49kK856rd/aZyqPk6WV
         Ej1iZelReO+bLICKMFqermLcYO7n5eylnLFq6UQvrp5duCI4T4Yz5RWyJNop/+x8Rs
         tSnN/SFuJ/xQNQozCxzxsYgJpLgKh1e43SeLFKhXtWliuRJeEA6BXZdm1Ku9qTp6sp
         YSMgwg6VFuqW3VvnBeLRmxTEdozphBKjSN+ob5R7uRT8uNGMOpL88SzHDldObBhtA5
         F34QuRR9E4EKQ==
X-Google-Smtp-Source: ABdhPJyiSYcSmzFPaA/db9tWHgk0Qa+ICGHcDsV0onNX7+M7lISTBoLrAApqTz2kNjv3+vBzN8809rcghpehq3UG8oI=
X-Received: by 2002:a17:906:ae43:: with SMTP id lf3mr10982133ejb.130.1607706159765;
 Fri, 11 Dec 2020 09:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20201211144236.3825-1-nadeem@cadence.com> <20201211144236.3825-2-nadeem@cadence.com>
In-Reply-To: <20201211144236.3825-2-nadeem@cadence.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Dec 2020 11:02:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLTz2k03gzrjDqi2d1NHQV+3pXxg6OqwcJ17CmfGYMf-A@mail.gmail.com>
Message-ID: <CAL_JsqLTz2k03gzrjDqi2d1NHQV+3pXxg6OqwcJ17CmfGYMf-A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: pci: Retrain Link to work around Gen2
 training defect.
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        pthombar@cadence.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 11, 2020 at 9:03 AM Nadeem Athani <nadeem@cadence.com> wrote:
>
> Cadence controller will not initiate autonomous speed change if strapped as
> Gen2. The Retrain Link bit is set as quirk to enable this speed change.
> Adding a quirk flag based on a new compatible string.
>
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> index 293b8ec318bc..204d78f9efe3 100644
> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> @@ -15,7 +15,9 @@ allOf:
>
>  properties:
>    compatible:
> -    const: cdns,cdns-pcie-host
> +    enum:
> +        - cdns,cdns-pcie-host
> +        - cdns,cdns-pcie-host-quirk-retrain

So, we'll just keep adding quirk strings on to the compatible? I don't
think so. Compatible strings should map to a specific
implementation/platform and quirks can then be implied from them. This
is the only way we can implement quirks in the OS without firmware
(DT) changes.

Rob
