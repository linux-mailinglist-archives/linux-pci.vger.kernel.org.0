Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8133319B1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 22:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCHVuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 16:50:25 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:36104 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhCHVty (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 16:49:54 -0500
Received: by mail-io1-f44.google.com with SMTP id n14so11687154iog.3;
        Mon, 08 Mar 2021 13:49:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aopk2xA4zD/bXMuGz7qZQmTI9QDAmCg2/YOh8hW5b/0=;
        b=UtwLhXfV2cse5r8/G6vm2VCOSGyUPJULNDJXbSg0vvd+yt0zwroAt7SSsiU66gD0QT
         IgdKoWuMlTTTHWwB01AfCZWRtyuDjFGGMV7SdAogDu8NViSsFheXiX4RNLd80I05uaPU
         2od1XgmVAoZO/FvMEsvlo3R8OCeJcxhuGakaGN+kgyp0AW2vakAWQb7jliOa5A32uIZq
         4M2Ur7lIvNyk0V0c3YF6wufGsfHuMSwKKLC1tEo4K3OGgYn6ZqIpFOaiFB0KZNqO/Uwg
         pxJg9Xs3FnQNOFoxnhn7B0r9vez6LrdaTHOEbthgpnYQ94iRlhykI8H0MRwBk0KCE5qp
         kgoQ==
X-Gm-Message-State: AOAM532jdhWv80QwLGAjLfE9qtTdtn5mlGPKNQKhDETjBizyGT7RPJDP
        X/CvM9HU4EXOjJldvFUVGg==
X-Google-Smtp-Source: ABdhPJz4X8nedqPUFZXhmT/nr+nyG6cyHJpqU/AUG5gmHwFE1jAgJvvym0gu44LweRh8c7GRY2E0Ig==
X-Received: by 2002:a05:6602:2497:: with SMTP id g23mr20165160ioe.22.1615240193189;
        Mon, 08 Mar 2021 13:49:53 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k8sm6514522ilu.4.2021.03.08.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 13:49:52 -0800 (PST)
Received: (nullmailer pid 3014339 invoked by uid 1000);
        Mon, 08 Mar 2021 21:49:50 -0000
Date:   Mon, 8 Mar 2021 14:49:50 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nadeem Athani <nadeem@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: PCI: pci-ep: Add binding to specify
 virtual function
Message-ID: <20210308214950.GA3010566@robh.at.kernel.org>
References: <20210305050410.9201-1-kishon@ti.com>
 <20210305050410.9201-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305050410.9201-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 05, 2021 at 10:34:04AM +0530, Kishon Vijay Abraham I wrote:
> Add binding to specify virtual function (associated with each physical
> function) in endpoint mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/pci-ep.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> index 7847bbcd4a03..b8d5406f94ce 100644
> --- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> @@ -23,6 +23,15 @@ properties:
>      default: 1
>      maximum: 255
>  
> +  max-virtual-functions:
> +    description: Array representing the number of virtual functions corresponding to each physical
> +      function
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 1
> +    maxItems: 255
> +    items:
> +      maximum: 255

No need for maximum, as that is already the case for uint8.

With that dropped,

Reviewed-by: Rob Herring <robh@kernel.org>
