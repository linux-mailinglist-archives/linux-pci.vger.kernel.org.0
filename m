Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9779C37210A
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 22:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhECUCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 16:02:01 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45660 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhECUCA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 16:02:00 -0400
Received: by mail-oi1-f169.google.com with SMTP id n184so6537975oia.12;
        Mon, 03 May 2021 13:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X4KlkqE3016HoNlp0LRojABlkrGtR4P8b0/UN4z4Wws=;
        b=WQe8S8gFdatf+c9SuwP4GO1FlqylxGWN/GDG+t+y7iXax5dWe1vhFQ0FFweui31xl3
         SjLhTvLiomSPLuNaKfrj4BAYpjMpQN6M9aThQoj0l2k0rZ0343uWGPfb1oDt6mmXSgfW
         YlhMrxJ6SEdvzxKBI4lOs1j0AEg5b/G9MUBVKRKcytgphUIlqFFQsFJNl5izp5UFUJGC
         hAAumypXPon4qCtzofx8Cfwi7/PYTE/WLFCPOVqfZchGFDTsrmMuRQX+neOJr6zjXCHr
         nYOzK9+aXBiFmYuXas7jtfD+criT/3bOke0I5UT4OKiO2poajR9MQr5GIk8V/VJGC9Y0
         MFlw==
X-Gm-Message-State: AOAM532vBxe2V+wCJ2NHgbDENuJM4itjneQuGcDbrha0QWFPsxtOcOhJ
        pmnsPz+KIwv4969bEeKQSQ==
X-Google-Smtp-Source: ABdhPJw/z/Vth2Mtu621HryVgzw1JKr612CTsqcBJJAY8Yx4T9tFrlIVUWKKxSx4SxYC3g+Bx2HX+w==
X-Received: by 2002:a54:4184:: with SMTP id 4mr199285oiy.72.1620072066668;
        Mon, 03 May 2021 13:01:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a4sm204369oib.17.2021.05.03.13.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 13:01:05 -0700 (PDT)
Received: (nullmailer pid 2295442 invoked by uid 1000);
        Mon, 03 May 2021 20:01:04 -0000
Date:   Mon, 3 May 2021 15:01:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] dt-bindings: PCI: rcar-pci-host: Document missing R-Car
 H1 support
Message-ID: <20210503200104.GA2295387@robh.at.kernel.org>
References: <fb0bb969cd0e5872ab5eac70e070242c0d8a5b81.1619700202.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb0bb969cd0e5872ab5eac70e070242c0d8a5b81.1619700202.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 29 Apr 2021 14:44:09 +0200, Geert Uytterhoeven wrote:
> scripts/checkpatch.pl -f drivers/pci/controller/pcie-rcar-host.c:
> 
>     WARNING: DT compatible string "renesas,pcie-r8a7779" appears un-documented -- check ./Documentation/devicetree/bindings/
>     #853: FILE: drivers/pci/controller/pcie-rcar-host.c:853:
>     +	{ .compatible = "renesas,pcie-r8a7779",
> 
> Re-add the compatible value for R-Car H1, which was lost during the
> json-schema conversion.  Make the "resets" property optional on R-Car
> H1, as it is not present yet on R-Car Gen1 SoCs.
> 
> Fixes: 0d69ce3c2c63d4db ("dt-bindings: PCI: rcar-pci-host: Convert bindings to json-schema")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This was never enabled in the upstream r8a7779.dtsi, but the Linux
> driver does support it.
> ---
>  .../devicetree/bindings/pci/rcar-pci-host.yaml       | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Applied, thanks!
