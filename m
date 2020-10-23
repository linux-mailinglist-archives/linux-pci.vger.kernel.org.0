Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7006C2974C9
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbgJWQlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 12:41:51 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39950 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbgJWQlv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 12:41:51 -0400
Received: by mail-ot1-f67.google.com with SMTP id f97so1934244otb.7;
        Fri, 23 Oct 2020 09:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FEBJaWN8Esn19Hc7kbCS8B998syb6EN/9qSrNFekzF0=;
        b=S/iQ9FRiTZaCHty0Lbzf1C2Wu2a81tTmq/i6MtNALJ7s5mlC8Y8ljhKs8aAw8cxiX0
         GIKwUXZdV4bH/abmjVDjlz2Ebejv+OJXL/ptU9DEW9xMqdZxlhhcCj603uxLmkKCLMDv
         WIXrU7u8NLMekLw5naQ/vXyUwrZz1BXI65zQgOZ3THCGbcFcF4CxX8Q7waYZ6QJQyDF8
         b8MaedhviwfOPZy3Ti+G5oRxwkgOSOGOAzJtDO2G08ldeAut5kg0PsbLt0gmEbcaKZGH
         y1VBXCfivUcOc4T9uUSXBJZt5bp+AGEH8uorF099bUwO74YcLVDT0PJHsnUK6P9014j9
         KxRA==
X-Gm-Message-State: AOAM530h2ga4Mqv6UTzyHMi8fZcKCbkLWZ+sJiUBwKSmLtPWLEre0jJ8
        LSj6E5KMWA3rFPy3bwHZcQ==
X-Google-Smtp-Source: ABdhPJyOlQ5BemqD1h51zUQ8stg0lloHHrLoVNEyEjVZpe7nk74BYwZBKEP/2bFMd6EjjW+6UrZvng==
X-Received: by 2002:a05:6830:140b:: with SMTP id v11mr2420250otp.92.1603471310494;
        Fri, 23 Oct 2020 09:41:50 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h3sm473420oom.18.2020.10.23.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:41:49 -0700 (PDT)
Received: (nullmailer pid 2840151 invoked by uid 1000);
        Fri, 23 Oct 2020 16:41:48 -0000
Date:   Fri, 23 Oct 2020 11:41:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        david.abdurachmanov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v17 2/3] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Message-ID: <20201023164148.GA2839812@bogus>
References: <20201022132223.17789-1-daire.mcnamara@microchip.com>
 <20201022132223.17789-3-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022132223.17789-3-daire.mcnamara@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 22 Oct 2020 14:22:22 +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Add device tree bindings for the Microchip PolarFire PCIe controller
> when configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

