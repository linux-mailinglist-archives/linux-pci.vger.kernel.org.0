Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F9D3FCF00
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 23:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhHaVRA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 17:17:00 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45581 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhHaVRA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Aug 2021 17:17:00 -0400
Received: by mail-ot1-f49.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso835076otv.12;
        Tue, 31 Aug 2021 14:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rZmwEc8NSqQoWoUVVA+56Qi0kmHYwHehZyUiwcO+sqs=;
        b=S+S+fT55alkGNj8IncFdTS6BxUSlz7Oi4zETbZiR9uF+9017cNbh1K135uwkxqEl1+
         h9LUlcST+dw/et2Gxi/QsuJhkhT8jkAuLBOiVNt1J1zsa/pOZL4CYRYrRN14EpCijK7D
         CEeQQr7QMJ/m4crHJ0x1+JqftJ+pTEX5a98ivwyPIk2eDjo8QSTgWUTOOtXwEl8vMYrq
         JDPtyIfk8uO/ai+/oXDLBQQZ3Vpza/d3A15RHTlqBJtFATs6iNCN7w6nqW8Xu7IXYZEz
         c5M9XY5AhXKnLWICjlZDb6K8ri3kIWx9bKuFl80SxPwPkRagCAxn03KbmdlKvRJyrj5A
         Cbvg==
X-Gm-Message-State: AOAM533QaFcPkiuSQQXSvR5w445I/GQnDTw5183Bf1+ZXyaPkysyqkMg
        tOuxbNbGSws0Ww2aQBj1Mw==
X-Google-Smtp-Source: ABdhPJw7RRtPYNtKDaTLRNDD+gWvBYmpgo6Y5q94eazPn7Kx9XK37LCbzcdLvdMzHqsNBXzR9UapMw==
X-Received: by 2002:a9d:4b86:: with SMTP id k6mr21942828otf.198.1630444564237;
        Tue, 31 Aug 2021 14:16:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b9sm4276424otp.46.2021.08.31.14.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 14:16:03 -0700 (PDT)
Received: (nullmailer pid 659825 invoked by uid 1000);
        Tue, 31 Aug 2021 21:16:02 -0000
Date:   Tue, 31 Aug 2021 16:16:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] dt-bindings: interrupt-controller: msi: Add
 msi-ranges property
Message-ID: <YS6cEkDn5IAVW/xQ@robh.at.kernel.org>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-3-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827171534.62380-3-mark.kettenis@xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 27, 2021 at 07:15:27PM +0200, Mark Kettenis wrote:
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> Update the MSI controller binding to add an msi-ranges property
> that specifies how MSIs map onto regular interrupts on some other
> interrupt controller.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../bindings/interrupt-controller/msi-controller.yaml     | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> index 5ed6cd46e2e0..bf8b8a7dba09 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> @@ -31,4 +31,12 @@ properties:
>        Identifies the node as an MSI controller.
>      $ref: /schemas/types.yaml#/definitions/flag
>  
> +  msi-ranges:
> +    description:
> +      A list of pairs <intid span>, where "intid" is the specification

It's not really 'pairs' and 'interrupt specifier' is the terminology the 
spec uses. How about:

A list of <phandle intspec span>, where "phandle" is parent interrupt 
controller, "intspec" is the starting/base interrupt specifier, and 
"span" is the size of that range (typically multiples of 32).

The 'multiples of 32' part is what Marc told me.

> +      of the first interrupt (including the phandle for the interrupt
> +      controller) that can be used as an MSI, and "span" the size of
> +      that range. Multiple ranges can be provided.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
>  additionalProperties: true
> -- 
> 2.32.0
> 
> 
