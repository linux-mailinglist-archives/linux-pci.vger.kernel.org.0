Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB427B41B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 20:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgI1SJf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 14:09:35 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:45279 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1SJf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 14:09:35 -0400
Received: by mail-oo1-f68.google.com with SMTP id h8so553909ooc.12;
        Mon, 28 Sep 2020 11:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wMT5ZrxVtHbXVPSICRQWobxCMk3iNHaaOR4uieHpOHA=;
        b=h/Cenc/1HEL0jq38qR0jfteF/pKDX3oKx0BCXWnT34FzYrBQ38zPIsMLslKUm0/83s
         3mxKXo3pB+Ip/ijAaCA7pM6q7ZZMYaY6DnTaYqcMC489j6eMs71WZBoCzLOsZl+6/+Zk
         U2Nt45hefJb/Bys+2sI5KCLNfsgVXwpa7q+AF4hpcj+4E0jOSOvPVTOriJxbVHhm/UFw
         YexDcvxY5m65hbRhbSjeSY5lXyu/vO8/faf7mR92pnBi5AUqWSFVR7Noyr7sFF/O0Ib7
         EGDdhjuniaD74t3xakll1STxhinLCTkKNXxKcmAF2IZuvf/FOEi5Ghs8CaVfPI5XL+nk
         Ynpg==
X-Gm-Message-State: AOAM533P5fD98g8YPgs2F/2SBHE+NmpEj3Tes/nKwUgVHaaMqVqo3tzi
        dh97sKAHOmfj9sUgBqrqSDwXD35qXoeG
X-Google-Smtp-Source: ABdhPJwjKDnO50jz8lQGsBYCJS49AqBrllbiT5iMZ+97qq7nHLg337GBNQdl5XKa2g1uvACykSHM2A==
X-Received: by 2002:a4a:614f:: with SMTP id u15mr1698170ooe.70.1601316573938;
        Mon, 28 Sep 2020 11:09:33 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h14sm400674otr.21.2020.09.28.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:09:33 -0700 (PDT)
Received: (nullmailer pid 3007215 invoked by uid 1000);
        Mon, 28 Sep 2020 18:09:32 -0000
Date:   Mon, 28 Sep 2020 13:09:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: PCI: uniphier-ep: Add iATU register
 description
Message-ID: <20200928180932.GA3006259@bogus>
References: <1601255133-17715-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1601255133-17715-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601255133-17715-3-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Sep 2020 10:05:31 +0900, Kunihiko Hayashi wrote:
> In the dt-bindings, "atu" reg-names is required to get the register space
> for iATU in Synopsis DWC version 4.80 or later.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.example.dt.yaml: pcie-ep@66000000: reg: [[1711276032, 4096], [1711280128, 4096], [1711341568, 65536], [1728053248, 4194304]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.example.dt.yaml: pcie-ep@66000000: reg-names: ['dbi', 'dbi2', 'link', 'addr_space'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml


See https://patchwork.ozlabs.org/patch/1372225

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

