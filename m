Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199D93FB9A9
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbhH3QDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 12:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237896AbhH3QDf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 12:03:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A5B561004;
        Mon, 30 Aug 2021 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630339362;
        bh=x2qifvJ1cqJUkaOT6haFlQcLC+nqt/Nc3ZTkGSieFhQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mpie3L+CFw8XSKjDi4IpjUUfrZssT9UOwyRwUT0sc+Wwfp7GS8qxR3HsByRS6ISDC
         bPFoNSXDgpUNx7SroQdutdQWkFcBG2eiq1lVw3Dnu5C4bx49WPK+U3tdjyDxSccTMh
         tKhTI8qFGPuKGyV8VRJ92CDtM2cu037rabYVsjWtAKf9PUZ/2sBJ97I7klLv/BeStp
         3M595YTzjElkRGD+V1yNyr3hgl9267KIePXXWBmtiWZ/taRzxXe+7ylDVs7T3bKOno
         qKJMPkFG1yCMtfx+dJDVtHf1WTkTiEiUxYNK7GHUcB9i9V8doBeEh9aOI6iY2WwqX0
         BvSqKAkziN3OQ==
Received: by mail-ed1-f51.google.com with SMTP id dm15so22377735edb.10;
        Mon, 30 Aug 2021 09:02:41 -0700 (PDT)
X-Gm-Message-State: AOAM5324T7EAFyEB7MidQayPxFerihsUTd4XAIjmI0VtJxsNth5cY6n3
        FyjBeAss51jDNQ9DwQOey++px8bUWQKxl77DVA==
X-Google-Smtp-Source: ABdhPJx9f5vkA1BYplPP05YhVBr3AEKG45JrVMeVtIUiB8UGNB9eGoSn14w7FGJpfzYvYQxKZzee3hZY4BNFTk8fenk=
X-Received: by 2002:a05:6402:180f:: with SMTP id g15mr19235985edy.258.1630339360618;
 Mon, 30 Aug 2021 09:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210827022638.3573-1-jianjun.wang@mediatek.com>
In-Reply-To: <20210827022638.3573-1-jianjun.wang@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Aug 2021 11:02:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJTW=ot=BBWQfOj9rJ82dnVV21TpHGf3vieUQ_Jd8i9Rg@mail.gmail.com>
Message-ID: <CAL_JsqJTW=ot=BBWQfOj9rJ82dnVV21TpHGf3vieUQ_Jd8i9Rg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: mediatek-gen3: Add support for MT8195
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rex-BC.Chen@mediatek.com, Tinghan Shen <TingHan.Shen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 9:26 PM Jianjun Wang <jianjun.wang@mediatek.com> wrote:
>
> MT8195 is an ARM platform SoC which has the same PCIe IP with MT8192.
>
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 742206dbd965..93e09c3029b7 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -48,7 +48,9 @@ allOf:
>
>  properties:
>    compatible:
> -    const: mediatek,mt8192-pcie
> +    enum:
> +      - mediatek,mt8192-pcie
> +      - mediatek,mt8195-pcie

I thought you wanted to support 8192 as the fallback:

compatible = "mediatek,mt8195-pcie", "mediatek,mt8192-pcie";

The above schema doesn't allow this.

Rob
