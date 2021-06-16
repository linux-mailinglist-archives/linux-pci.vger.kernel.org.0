Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637913AA75F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 01:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhFPXXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 19:23:11 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:44600 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbhFPXXK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Jun 2021 19:23:10 -0400
Received: by mail-il1-f174.google.com with SMTP id i17so3761347ilj.11;
        Wed, 16 Jun 2021 16:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dO/0IK3ZChPtbT+cDEit4w38mGS2paOCnZ+uimQh1SQ=;
        b=smMMOfXXCvvcrZOA/BJrcmBePvZ73keN8P3TIzaVmTy61LTB4aIab1S6MDmVlRtivC
         SFWbZgLu/pAd6NmeNPsCSufbZW6yh0swe0Yy5+tonEF0xWRgog3iVTmZaRuqn/WopS6W
         RlvkeAruEdJNXUvTfBTGkzhVvNTcj7NcCIOGQ6kd3HwBcnzorTsg+lSCrnCisevlPsZ0
         sYuzywm58DPTTkpFRZiACp9O4antUDeNcxjQV1XoO3kFCn5VfZvzVKaEhvxxRqUHY8PM
         nHRpXb2trS1kFSkbS6vkATxgaP6iQYIN54cxqJk65lQwRnt3bZSx/Wvz3b0yGuGLcwrl
         TT1g==
X-Gm-Message-State: AOAM531mv33oUyaSe7HoOiNQH1N3VmOfXaM+Rfo0HMwgtnRxI3zxPlSQ
        8pK/nvnYCEuixAaG3rIXA83HPJuE8w==
X-Google-Smtp-Source: ABdhPJwbEKMKP1IXu446J/OQg89LxbdPTvXIDDBvFnLkwH8A3fS/ZsKWSzd/W2KIkLEioD0jIIKk8A==
X-Received: by 2002:a92:d245:: with SMTP id v5mr1353902ilg.245.1623885662599;
        Wed, 16 Jun 2021 16:21:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n17sm886429ilm.34.2021.06.16.16.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:21:01 -0700 (PDT)
Received: (nullmailer pid 274985 invoked by uid 1000);
        Wed, 16 Jun 2021 23:20:59 -0000
Date:   Wed, 16 Jun 2021 17:20:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <kristo@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: ti,am65: Convert PCIe host/endpoint
 mode dt-bindings to YAML
Message-ID: <20210616232059.GA274875@robh.at.kernel.org>
References: <20210603133450.24710-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603133450.24710-1-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 03 Jun 2021 19:04:50 +0530, Kishon Vijay Abraham I wrote:
> Convert PCIe host/endpoint mode dt-bindings for TI's AM65/Keystone SoC
> to YAML binding.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes from v1:
> 1) Removed '"' for the included schemas
> 2) Used default #address-cells and #size-cells for the example
> 
>  .../devicetree/bindings/pci/pci-keystone.txt  | 115 ------------------
>  .../bindings/pci/ti,am65-pci-ep.yaml          |  74 +++++++++++
>  .../bindings/pci/ti,am65-pci-host.yaml        |  96 +++++++++++++++
>  3 files changed, 170 insertions(+), 115 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-keystone.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> 

Applied, thanks!
