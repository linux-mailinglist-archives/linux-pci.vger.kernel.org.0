Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB2628BF0C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404075AbgJLRaY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 13:30:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37578 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403805AbgJLRaX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2020 13:30:23 -0400
Received: by mail-oi1-f193.google.com with SMTP id t77so19508049oie.4;
        Mon, 12 Oct 2020 10:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gNwjPesxpBjopk2GNZh+9rdN0E3TWK6jx3SW4ZJaqOc=;
        b=J918cK3lVPE2b2XlYtI7ar8vPhVpRoCKbIosA807VGq30cg13EFMgLLywRYrvmD+Rh
         mLeWeyqSzp7Sj6yQk4OTFC51lYXpnDzRyFRlP0NK/2zvgmqEO4IiJJ+lQ8a6Cky+thKp
         DTaLm3BK95FBDA38A07n3BvagEeEGyh5Nn8mCSoEkO2rAg7At/o6iopuptP69+bXr1RG
         kfhVBqwtQ+E4uk0bSXKKZdu4i/9j4bSk8FXqsujfky+nTa7yIrv6HHSXNJ2UuHx9xHSW
         2HtaymNoDwolpXPcFoQxkZG6JlOHeg3QNGhjVb8urirw4RqnqJm0p2rp7RUi55LBKTsS
         ZU6w==
X-Gm-Message-State: AOAM533uIk4vjjUOBA8kD7IfHftD+WnkEPR3bhxQ6lBg1zh2Psp/hBfW
        5m/QSEITqv8rTRiDZ1o4bw==
X-Google-Smtp-Source: ABdhPJxvq9+kkJx9i7hqrA0SWl0qognXkLZEj9NVi7a6wWCs3cHj9QQ/qTjrffpLYx0gree8Vrgymw==
X-Received: by 2002:aca:4ec7:: with SMTP id c190mr11397149oib.16.1602523822632;
        Mon, 12 Oct 2020 10:30:22 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j21sm9123708otq.18.2020.10.12.10.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:30:22 -0700 (PDT)
Received: (nullmailer pid 1792182 invoked by uid 1000);
        Mon, 12 Oct 2020 17:30:21 -0000
Date:   Mon, 12 Oct 2020 12:30:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     devicetree@vger.kernel.org, david.abdurachmanov@gmail.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org
Subject: Re: [PATCH v16 2/3] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Message-ID: <20201012173021.GA1792130@bogus>
References: <20201012105754.22596-1-daire.mcnamara@microchip.com>
 <20201012105754.22596-3-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012105754.22596-3-daire.mcnamara@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 12 Oct 2020 11:57:53 +0100, daire.mcnamara@microchip.com wrote:
> Add device tree bindings for the Microchip PolarFire PCIe controller
> when configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
