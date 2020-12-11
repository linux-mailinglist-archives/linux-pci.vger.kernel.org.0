Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19E2D6E97
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 04:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbgLKD2k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 22:28:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45623 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405216AbgLKD2Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 22:28:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id f132so8323047oib.12;
        Thu, 10 Dec 2020 19:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eJ9AhbR7dNhyrIAYTLNaexWFEr8PcE/a+4lZQcMflOY=;
        b=hVC9gQu1KWqRmG8bM0/Aah2H0goaQhCqtY58abnMqAYxfiacGT1KDJ5nQirbk7JURt
         fN7d6yl7TM5Sfmk4Zd8x3ZFZuwWqRfNF55JrNZ2ZJTB2gyDpUhtZPlH3muphOKK7IOgn
         0tXdBw6FxFNv5Y3XX8UCE4/Y3G13zeOgW1DheX4UZvt7y0sTNeVHOKgfmF1pvHgCZFyO
         leK31/8AnHndCWLJAXvIFpTy4PPIdkmSlaEVbKx+29KDWTe3pZUxFsraFbkIKyt1qiUk
         obKsXj4kVJ0+/F+Mwe/NRrhRpzkFU9BPgemeIbkpKCHNq0JOT8co3UaRQdppKgfpH5th
         H9VQ==
X-Gm-Message-State: AOAM531pJQfKmYbnAI6nYlu6RAkT1MzMANOsuQLsF9LwIo5aFDdxH/a/
        MAAA0LMrqomS/MRucGE74WCKGWCKgg==
X-Google-Smtp-Source: ABdhPJw0lGiB1h/FpZokQM3xt/Q9C5srIa56/s86Ohke5ZYCBQy8qi0mlicAN7fw4oZPzQuostgzeQ==
X-Received: by 2002:aca:3c3:: with SMTP id 186mr7739011oid.22.1607657255601;
        Thu, 10 Dec 2020 19:27:35 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d62sm1500475oia.6.2020.12.10.19.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 19:27:34 -0800 (PST)
Received: (nullmailer pid 3576272 invoked by uid 1000);
        Fri, 11 Dec 2020 03:27:34 -0000
Date:   Thu, 10 Dec 2020 21:27:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pci: rcar-pci-ep: Document missing
 interrupts property
Message-ID: <20201211032734.GA3576224@robh.at.kernel.org>
References: <20201209101231.2206479-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209101231.2206479-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 09 Dec 2020 11:12:31 +0100, Geert Uytterhoeven wrote:
> The R-Car PCIe controller does not use interrupts when configured
> for endpoint mode, hence the bindings do not document the interrupts
> property.  However, all DTS files provide interrupts properties, and
> thus fail to validate.
> 
> Fix this by documenting the interrupts property.
> 
> Fixes: 4c0f80920923f103 ("dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2:
>   - Fix authorship,
>   - Add Reviewed-by,
>   - Drop RFC state,
>   - Fix name of interrupts property in patch description,
>   - Drop inappropriate Fixes tag,
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Applied, thanks!
