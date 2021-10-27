Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104CC43C9FE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbhJ0MtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 08:49:01 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33397 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbhJ0MtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 08:49:01 -0400
Received: by mail-wr1-f43.google.com with SMTP id m22so4053528wrb.0;
        Wed, 27 Oct 2021 05:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0i79uPRCmX80gmP5j45gffMsWk5YGAYUEfx8SEm13/k=;
        b=3fFzpppLKRxR6Q/KYfmcA2SEbmRBMYlVOn9K7IRBronJNV3Tpprh6dAP1tsB3d3iFP
         5tEFBd6zo+G3fLQ/5uP8hRE+zbgnzl3rruugDnjTryxy47SittMLcZ8ND/IL9lu0QQXa
         Eh6f21JqPtdU86MgnKvFeTIJXVJZuFCUkNqSZ/G4LzyZsNGKjzx1AOq/vnp/WWk9d7LO
         QGGFpm9H876Cv4eYdrubmb6wqPV0CS+hZazVKLxr5wNhkELMpWxjzxm0W9PBrfhW/M6y
         Is/1eE5FmyoP96L0ecoTgVKYx/z67iUOnvvwsnAUDtQsuNHkLGfaDxOfBaJlugoCWbNm
         jXEQ==
X-Gm-Message-State: AOAM531NxGKIbaMYVoy2cQBd5jVlk6zG+hXwqMB6VmB7rEiLPoFGzCnc
        WIB90V9ApUXNXX8r1ZRg9IM=
X-Google-Smtp-Source: ABdhPJwRfTIKue/gCyowiA+0n5wKFzz2rRjDO/BK/to8Vm1yjkZzpuyy+M9KzWIdXWKhB+4PZ5oZEw==
X-Received: by 2002:adf:a411:: with SMTP id d17mr33227540wra.232.1635338795087;
        Wed, 27 Oct 2021 05:46:35 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id 9sm3263250wmi.46.2021.10.27.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:46:34 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:46:33 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH] dt-bindings: pci: rcar-pci-ep: Document r8a7795
Message-ID: <YXlKKROsS07F64xg@rocinante>
References: <e4acfe90021e45658e82ed042746707ace208a93.1635337518.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4acfe90021e45658e82ed042746707ace208a93.1635337518.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert and Yuya,

[...]
> --- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -19,6 +19,7 @@ properties:
>            - renesas,r8a774b1-pcie-ep     # RZ/G2N
>            - renesas,r8a774c0-pcie-ep     # RZ/G2E
>            - renesas,r8a774e1-pcie-ep     # RZ/G2H
> +          - renesas,r8a7795-pcie-ep      # R-Car H3

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
