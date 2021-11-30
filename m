Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31C4628ED
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 01:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhK3APq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 19:15:46 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33399 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhK3APq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 19:15:46 -0500
Received: by mail-oi1-f170.google.com with SMTP id q25so37930920oiw.0;
        Mon, 29 Nov 2021 16:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yaTORaek8SGtN1jMlwQxhZ6UKgv8m7MkqR3SQOMbc+I=;
        b=ok0pcboQp/46FzYsiNEReJ+5mnKkMitvcl/8x9V4MX89+bWgqFSzjJ4CvygfZwSreI
         OkSmwQHCaEP3mqmUaJH74mMNEowG6fgoZbcDdjHx8tzW/hi2uXe1Jxa2SwTeNipom/H8
         Ph9s+fewNQjU1CiQx9VkPyVwGKwTE4pMWq/QUjnR6Jv/oreiMpi8nUb70NBIzWEVPWB6
         BRYkh9ZlEOPibf25q/qfsLCFQynLf2fGE2JgXU7iZ58yybG2QTXY8Q6t8dxP8vbu+Ttp
         CztBz8FOQaYc6A7BQn+A4IDcK0H2O21MywybdcJIqmHTP+0D74fIZVMVgrelt4PUMlBz
         BtjQ==
X-Gm-Message-State: AOAM531xuppDorqCpmbBXb61Y8nX8vYVzVheHiUEBd6/KwyFBduREZr1
        WKWxu7eVpJ3kXnq4QYtK9Q==
X-Google-Smtp-Source: ABdhPJyP+dCDXIubcceXPglQT3v6v/BHRwyvbbdmZ53hCSzkx6c6437/LRnAzyqK9bkLmDC24d2HSQ==
X-Received: by 2002:aca:130e:: with SMTP id e14mr1209178oii.51.1638231147371;
        Mon, 29 Nov 2021 16:12:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 3sm3298124oif.12.2021.11.29.16.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:12:26 -0800 (PST)
Received: (nullmailer pid 870866 invoked by uid 1000);
        Tue, 30 Nov 2021 00:12:25 -0000
Date:   Mon, 29 Nov 2021 18:12:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: ti,j721e: Add device id for J721S2
Message-ID: <YaVsaYqWIFCwHigK@robh.at.kernel.org>
References: <20211119133253.18590-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119133253.18590-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 07:02:53PM +0530, Aswath Govindraju wrote:
> Document the device id of J721S2 SoC.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index cc900202df29..0411bf5a1700 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -71,6 +71,8 @@ properties:
>            - const: 0xb00f
>        - items:
>            - const: 0xb010
> +      - items:
> +          - const: 0xb013

This can all be just an 'enum'.

>  
>    msi-map: true
>  
> -- 
> 2.17.1
> 
> 
