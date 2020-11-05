Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9472A841C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgKEQ4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 11:56:32 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:46244 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEQ4a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 11:56:30 -0500
Received: by mail-oo1-f66.google.com with SMTP id c25so587295ooe.13;
        Thu, 05 Nov 2020 08:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u0lRutCOwKSfB7LNOinwZwq0bR1ziMUdiw46dx6Reig=;
        b=AR3K9+QPvXL2i0aErtCQJBBKMhhspS3/7Sw+4nBz2JpejRXp9tU+iWQZiHky4kSG52
         +HSfFlamJao8kSGekf6vUHTbxQI12utZ3DsmZzuA+BiWUWdt1uXGPIyPuH5qC3SLWMa1
         FUql6FXeTjIBZD7DWwzAueQJ/VYnpKjXBiOfvrULf9BT880RHJgwO+T3rwr8YKNIg9eh
         aF1n8aHWMn3Y5OdCmKOPxWwVgHfh40TOiMRmryWMbozZoXZGKnULE4qdoQCEWgY590Jt
         ymlbELvE7GblMDSpqE1Lb3qSsykj+MNMKuo3gJ8O8zVbC8SWUpU7S1jU+BG8NpyefWZT
         luVg==
X-Gm-Message-State: AOAM532AsDL5PYor0PKnKTWJVsZLIArCtz3mXGVoSf8Dg3G7Lzr5U2aX
        1V8KXkdwNdG7x5LR8bSbNCKtVop/LQ==
X-Google-Smtp-Source: ABdhPJyPl2XBRIN6I+lGrZahqYDdCtZDKHkCfSDAoCAUjWYDMpGfqaAHV0BNK9rNy7qze71HbwZuRA==
X-Received: by 2002:a4a:d815:: with SMTP id f21mr2461685oov.44.1604595389404;
        Thu, 05 Nov 2020 08:56:29 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 76sm431259oty.15.2020.11.05.08.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:56:28 -0800 (PST)
Received: (nullmailer pid 1474695 invoked by uid 1000);
        Thu, 05 Nov 2020 16:56:27 -0000
Date:   Thu, 5 Nov 2020 10:56:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Tero Kristo <t-kristo@ti.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/8] dt-bindings: PCI: Add EP mode dt-bindings for TI's
 J7200 SoC
Message-ID: <20201105165627.GA1474647@bogus>
References: <20201102101154.13598-1-kishon@ti.com>
 <20201102101154.13598-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102101154.13598-4-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 02 Nov 2020 15:41:49 +0530, Kishon Vijay Abraham I wrote:
> Add PCIe EP mode dt-bindings for TI's J7200 SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml       | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
