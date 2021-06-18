Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912893AD429
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 23:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhFRVLH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 17:11:07 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:33637 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhFRVLH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 17:11:07 -0400
Received: by mail-oo1-f42.google.com with SMTP id v17-20020a4aa5110000b0290249d63900faso2798616ook.0;
        Fri, 18 Jun 2021 14:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=frRBpIJZObpmwDftURD9RgvF5osDKnY9SoJHh87QQOw=;
        b=GWiBzNa4SDC3uw5BNu737b8LGneU5wWui3UZYGCEVV63w9yBa78rAfnTaSfSrwCne4
         YogT53XPHkLAmw/oEnpqUCEWzrmVec66nyaqefRlr/vzyqoljlH4di2M02ExBFUcpkfY
         b1peRcOMvvQ1Ndj+CYlZUvn2KPM25ZhJ2dIHAIRqJ/oHbB+MNss+gwz4S2Eta3caTkHk
         Jaxwnkve3unkzYhOVZuQqTC8riQ+wccaEfZZX8qiCt3u2L6BQBPzZWh0ZvyBjkXM51q1
         cOUMxoK3sOD7AeG/i1im0uIEg2TnjSuGQQTiHBFYou35BM60MTwTATpSdvXhP4RAU9Ty
         apvA==
X-Gm-Message-State: AOAM532vDKesknPR7jXkd4fvRUPT5C2Pju4Rv2bAnhMgKFdModYX1YTt
        6tI9/XIO/PkOvPJaWmb5nQ==
X-Google-Smtp-Source: ABdhPJzJs34aVbpGHJvcdeb16PRfJefG4VEzrs4xqpD8Aaguoyrw3bHFo2RGmH5YAQAotMKwhfD7TQ==
X-Received: by 2002:a4a:e54e:: with SMTP id s14mr10720963oot.27.1624050536344;
        Fri, 18 Jun 2021 14:08:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 16sm2246125otm.57.2021.06.18.14.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:08:55 -0700 (PDT)
Received: (nullmailer pid 2877551 invoked by uid 1000);
        Fri, 18 Jun 2021 21:08:53 -0000
Date:   Fri, 18 Jun 2021 15:08:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     pali@kernel.org, tsbogend@alpha.franken.de,
        linux-kernel@vger.kernel.org, neil@brown.name,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        john@phrozen.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        ilya.lipnitskiy@gmail.com, matthias.bgg@gmail.com,
        linux-staging@lists.linux.dev, bhelgaas@google.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mt7621-pci: PCIe binding
 documentation for MT7621 SoCs
Message-ID: <20210618210853.GA2877517@robh.at.kernel.org>
References: <20210609140159.20476-1-sergio.paracuellos@gmail.com>
 <20210609140159.20476-2-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609140159.20476-2-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 09 Jun 2021 16:01:57 +0200, Sergio Paracuellos wrote:
> Add device tree binding documentation for PCIe in MT7621 SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/pci/mediatek,mt7621-pci.yaml     | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
