Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A1948B46E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 18:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbiAKRup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 12:50:45 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34587 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbiAKRup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 12:50:45 -0500
Received: by mail-oi1-f177.google.com with SMTP id r131so140842oig.1;
        Tue, 11 Jan 2022 09:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xpEEP6pn59TAkOy+KIoH6uTjJ6S6pmp9UVrqmovuxDE=;
        b=YJ25l3EgN2rD2Czconkq/TijjLo6pp6BeiRUYYhb9ETvv1a3ANRk4ntTSEeWjmqb2m
         Owj1AQTF+JAdLAk9lbTgVtUI+/fqTX6R97APAbPzB+/ZIEq42CLMWGFrfjZhEbMPTJPQ
         JCNgYfJ9iXsmK4h44xyDaNrfBlsvST3UZhLM5ZYxOlW5VU7bWstiqGlBRCRvBQLm3U5e
         18jsCnkix1fvljRN0bsKQRJFObpRREvwn2Zg1RYNBoxwEgvpxga+KnsNibA1pqjxpWhD
         1tjPcP6esQFDp02/bByoVksSrXXAChTUvt5Kekr7IDJ2Moz19pYMd7gowe8zgbFu7ir6
         C9Jw==
X-Gm-Message-State: AOAM531hATMwIQlzPHhG8eCOphQAoG+QeQWD0gYy1Mh++v4hsNlTZ0a0
        rQTfO6BG/PDR+CawVkNEQqT9nA0KpQ==
X-Google-Smtp-Source: ABdhPJwwX2jBplY7ZSp7V0C8lWNfBrPtgM86TV0fUt2mbnasJt+D7XWKI7BTjDNSI5byvJHPplpI/Q==
X-Received: by 2002:a05:6808:4d2:: with SMTP id a18mr2576006oie.99.1641923444555;
        Tue, 11 Jan 2022 09:50:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a26sm48342oos.39.2022.01.11.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:50:43 -0800 (PST)
Received: (nullmailer pid 3226952 invoked by uid 1000);
        Tue, 11 Jan 2022 17:50:42 -0000
Date:   Tue, 11 Jan 2022 11:50:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: snps,dw-pcie-ep: Drop conflicting
 'max-functions' schema
Message-ID: <Yd3Dcltq5IG6CeWa@robh.at.kernel.org>
References: <20220107030358.2378221-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107030358.2378221-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 06 Jan 2022 21:03:57 -0600, Rob Herring wrote:
> 'max-functions' is already defined in pci-ep.yaml schema as a uint8 and all
> users of it expect an uint8. Drop the conflicting schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 

Applied, thanks!
