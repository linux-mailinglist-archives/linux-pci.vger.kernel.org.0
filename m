Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70A72D31A0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 19:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgLHSBq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 13:01:46 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35062 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgLHSBq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 13:01:46 -0500
Received: by mail-oi1-f173.google.com with SMTP id s2so10839752oij.2;
        Tue, 08 Dec 2020 10:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kFebtoZ+xbAt55JiPd4L9/A7iku/ldoQ9QBHKjhY4bM=;
        b=RteRTuKLndOrCBgNO++E1L7GSd6ARkDl1TLB5qZhreN0OiWHWkFBVHZeQ/j0IOczS7
         plsIluq+k/D9Xl3QqbwD2L0Ig5KEMWxkL5WcBiXTVtd91jUS2uhMRP73psj/962/GvFG
         DTPGNAht1WXFjNhpaJX/a1TVpKolluPGPxpDORcqpuINApYfbqIlqokOsvLixOyxitNZ
         mIScF9XhiLV4OxHqZ4iEXtS8obB3zf/XygdnBLc5bUdIUQByK6J00lJywa1mtMATiIqG
         zUq8SPu0cqranC24+n4fxrfoCP/7TbrJqtTsb0iGzcZEEkW56EZaSna9nBpONAGAFCwx
         QREw==
X-Gm-Message-State: AOAM532lZCxp4RP6FHeqz+iO4Gz6F02i5GoRfGXN4DQp+KAywNW4GX8f
        uZwUdOVqhjOR4tuP2PMwwQ==
X-Google-Smtp-Source: ABdhPJyUR6+RUSOcxFLBvWT3TN2A5KaWs9sDnn+DI2X0yrSULmGJ8hz6OalYNy9b7luqMKMC1W+yFA==
X-Received: by 2002:aca:c0c6:: with SMTP id q189mr3649888oif.178.1607450465207;
        Tue, 08 Dec 2020 10:01:05 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x66sm3845250oig.56.2020.12.08.10.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:01:03 -0800 (PST)
Received: (nullmailer pid 2794752 invoked by uid 1000);
        Tue, 08 Dec 2020 18:01:02 -0000
Date:   Tue, 8 Dec 2020 12:01:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] dt-bindings: pci: rcar-pci-ep: Document missing
 interrupts property
Message-ID: <20201208180102.GA2630497@robh.at.kernel.org>
References: <20201126115927.4089838-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126115927.4089838-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 26, 2020 at 12:59:27PM +0100, Geert Uytterhoeven wrote:
> The R-Car PCIe controller does not use interrupts when configured
> for endpoint mode, hence the bindings do not document the interrupt
> property.  However, all DTS files provide interrupts properties, and
> thus fail to validate.
> 
> Fix this by documenting the interrupts property.
> 
> Fixes: 5be478f9c24fbdf8 ("dt-bindings: Another round of adding missing 'additionalProperties'")

I don't think this fixes is appropriate. The commit itself wasn't 
broken, this binding is.

> Fixes: 4c0f80920923f103 ("dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Alternatively, the interrupts properties should be removed from the
> corresponding device nodes in the DTS files.  Obviously they should be
> retained in the device nodes representing PCIe controllers configured in
> host mode, which describe the same hardware...

No, I think this patch is the right change. EP and host bindings should 
be similiar.

Fix your Sob and resend please.

Rob
