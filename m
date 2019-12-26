Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B4012AE62
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2019 21:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfLZULL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Dec 2019 15:11:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44800 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZULL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Dec 2019 15:11:11 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so23591253edb.11;
        Thu, 26 Dec 2019 12:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKyS0Vzar44g5nZVMq7w89sJBVTVVQr7IhBAjNIROrI=;
        b=dkoPDMmRO2eMwq7TMq1HtLGXctYNZZjUXuFpwJaYLHjL4DHZBgoqJoj2hhpUurQB86
         quqctLUkVeEctiVeMOgGlQKlzRsXqBY2H2rp9rluW2Ub29W0vqIMPXGP+zlhb+8UJmBD
         NSl/EdBjv3zKh1ruJhqdiuFdRG813PmDhGNiz+al4f34WHfimfbMB8AlJCQVI/WhMSfz
         7kMLzUho23PWWhN6nGDqRlnyl5bOKDsKbnmG/QVlKaVotqfucxZCUwe+mp+f52OcZpnR
         ec0YYHCFTvIhPXxhSWEyhNw5FkVMpPcjhLiNnsQBSClPmjXpKatN6p2YCq8M+5eNPBYE
         1vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKyS0Vzar44g5nZVMq7w89sJBVTVVQr7IhBAjNIROrI=;
        b=DnR6LQSXjnUhRQyozO5E/IsetZ0az9w58fZux1kQq98Jrxp4Q3ffYaJHM4i1t4pYX9
         NOUwRJO3J6gScDG7YZNTKc0ijq36SI5oNbVmRjVoMor4ZKSMdyJTOplW9m0MJzyBjCUQ
         LwRugfdSpxpHFbXgvJmkAlG4o57hFBC1po79en973PuE6pE3hc7/+QhHuHy9Tc58N9yO
         /rBTDlKGL0YojqyKHTqEyetOuib/6uGe9n4VDarN/TVZghYwnsMo3og1t3byLtzXNe2h
         lV6RgwHPa0xcb5zFh01304ZrAgTnK29GZoqarsk4+xADj4kmcsA7IRtu3XyJU0XuPl1G
         s2tw==
X-Gm-Message-State: APjAAAVestf004B6fs77qzaHfRlTJqevVd8d6/b3wBW/trHYekgrn1zw
        uXfcmB6AnPoDZ9PDQPtzrzmIiiyx5FfvXo06gZA=
X-Google-Smtp-Source: APXvYqyOHd8m4jOZ18liraS1LmkJgDRRTlRaa1TAnpybzR7ymvltec/WOyoBzbMMK/SVycz37m9EThbBbClEbuEt25k=
X-Received: by 2002:a50:fb96:: with SMTP id e22mr51700477edq.18.1577391069615;
 Thu, 26 Dec 2019 12:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20191224173942.18160-1-repk@triplefau.lt> <20191224173942.18160-6-repk@triplefau.lt>
In-Reply-To: <20191224173942.18160-6-repk@triplefau.lt>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 26 Dec 2019 21:10:58 +0100
Message-ID: <CAFBinCBzt6SRGx+8iT=NHW00ip_gtg2cW7T8z9aqjeGPH8f7OQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] dt-bindings: Add AXG PCIE PHY bindings
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 24, 2019 at 6:32 PM Remi Pommarel <repk@triplefau.lt> wrote:
>
> Add documentation for PCIE PHYs found in AXG SoCs.
>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../bindings/phy/amlogic,meson-axg-pcie.yaml  | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> new file mode 100644
> index 000000000000..c622a1b38ffc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/amlogic,meson-axg-pcie.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic AXG PCIE PHY
> +
> +maintainers:
> +  - Remi Pommarel <repk@triplefau.lt>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,axg-pcie-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  aml,hhi-gpr:
> +    maxItems: 1
nit-pick (as I didn't have time to review the whole series yet):
we have at least two other IP blocks that need this. they use
"amlogic,hhi-sysctrl" for the property name


Martin
