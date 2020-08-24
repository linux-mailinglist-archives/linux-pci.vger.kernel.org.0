Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E90250C15
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 01:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgHXXFd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 19:05:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44348 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHXXFa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 19:05:30 -0400
Received: by mail-io1-f65.google.com with SMTP id v6so10521419iow.11;
        Mon, 24 Aug 2020 16:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LnGLggCC6t4eeH6RGHgV+CdMrLeiVTW47t40q2yEbSA=;
        b=JC0iz9tX0sgRtp88/7Qipt/f8+m74Q/NGi405ucij0kWHk7D0fYijF5R6CCLhcCNZI
         xv4j104Xzq9+Mxxor9wp2FLNpEGjemMxJz5/RTn6lt0nrXicMoxQgo9LCiWed6v8KPhY
         gsu4of4eA3mC+s2WKL5tcyc3zf9YqM26e5EZSg+D/Kypx5MlXOYy+OKyzI6Lnb+JfBcr
         hTKz8exTsf7K+b70GgaBN/gaVlhubZzNV3s/EemlazSAfePbsSqimMQKKnXw+xSZWsJv
         j8TE+9LRXZPLTM3GpxO3WdprZvyBVK8DizvEJGJ2RG7Yx/QHenOu/x7mDdZW1VHeraIL
         RoWA==
X-Gm-Message-State: AOAM532j+u5tfpkyMZRNvprTPxBfeNLOiA7gaMugW4JI+c5K4Js5Vr4h
        sBUnch/b9RdsgYLqfEmedg==
X-Google-Smtp-Source: ABdhPJxjW6Z/0DNopQefNMSz2Y33hFI2dXsZobX+uD1VPIebi2iNlXYREKpv0yRibAxo1PsikSR2aA==
X-Received: by 2002:a02:a04d:: with SMTP id f13mr7825907jah.112.1598310329586;
        Mon, 24 Aug 2020 16:05:29 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id x185sm7579268iof.41.2020.08.24.16.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:05:28 -0700 (PDT)
Received: (nullmailer pid 3499633 invoked by uid 1000);
        Mon, 24 Aug 2020 23:05:26 -0000
Date:   Mon, 24 Aug 2020 17:05:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Chris Paterson <Chris.Paterson2@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: rcar: Add device tree support for
 r8a7742
Message-ID: <20200824230526.GA3499580@bogus>
References: <20200810174156.30880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200810174156.30880-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810174156.30880-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 Aug 2020 18:41:55 +0100, Lad Prabhakar wrote:
> Add support for r8a7742. The Renesas RZ/G1H (R8A7742) PCIe controller
> is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
