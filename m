Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B6A4422B5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 22:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhKAVfk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 17:35:40 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45685 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhKAVfj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 17:35:39 -0400
Received: by mail-oi1-f174.google.com with SMTP id u2so7755531oiu.12;
        Mon, 01 Nov 2021 14:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rAZfMt0W72OQ5Uazy33FSpqP64Oe4jvKwHBVPsVewGM=;
        b=c3vSq+ZjR5jLWdI0ZUZaY0TzrAQK09oT4Wpq89I6y1SyPdJq5L2pVA7bdEuHJBQ2bP
         Bz0x6QMzDwgH4C4ZeRh1MTF95/j/Z2smkmckzjgQV0dxEx9/Xg4+SEK9BHtbDCn2FdMw
         tp+IdPZw2PUXecBmxR1BRlQzqCICY9FtnTHk3++RJrmn9s/IlJkWtAzJ1D7ok5avGfYQ
         mOJ6g3Cqg2Pbeip+k3gkDYLPsKTEw/w8pY8cLCPF34mBHLK9uUH1LgNLotL5fcSTZ3xQ
         8igMD2beoOVEHAfMJOlJF5IfXovaGlQwUUqZhXQNd5uEjPOikyee5J570VRyYVFdPHUD
         LUBw==
X-Gm-Message-State: AOAM531mo66KDhtj0eDrI+o8/PA2htRqR/RVfDRqtSXdf7N1WUUolxxW
        xW5QrOSILFHQ4lhEGYPYzqxhQLso7A==
X-Google-Smtp-Source: ABdhPJyZvDljdInZp2AIvJVkRBF2bwvS15/1QohCgzr/lJbsxLdLWdVN5P2cIxaAQrhQBL8KIOYlRA==
X-Received: by 2002:a05:6808:18a7:: with SMTP id bi39mr1413053oib.136.1635802385437;
        Mon, 01 Nov 2021 14:33:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c18sm2615222otr.32.2021.11.01.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 14:33:04 -0700 (PDT)
Received: (nullmailer pid 1102648 invoked by uid 1000);
        Mon, 01 Nov 2021 21:33:04 -0000
Date:   Mon, 1 Nov 2021 16:33:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] dt-bindings: pci: rcar-pci-ep: Document r8a7795
Message-ID: <YYBdEFBKsxwaTNtg@robh.at.kernel.org>
References: <e4acfe90021e45658e82ed042746707ace208a93.1635337518.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4acfe90021e45658e82ed042746707ace208a93.1635337518.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 27 Oct 2021 14:26:36 +0200, Geert Uytterhoeven wrote:
> From: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> 
> Document the support for R-Car PCIe EP on R8A7795 SoC device.
> 
> Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
