Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6444173B99
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgB1Pib (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:38:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42311 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgB1Pia (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:38:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id l12so3209610oil.9;
        Fri, 28 Feb 2020 07:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjpOoQ6SrmpTD4jRlUbCwuPmJbm+pfRvcUtwmZdw+b4=;
        b=O9zUqvm4AkZ//AMsP9kGpsmgKCAIwh/v4LwCicib5imcQCq67wQ4L2XvjCu4JjwaGn
         tgH/3zSXSWZqQqSMvVAKVfdlc9S7qh876C/0Vs0/QAmC51HYGcZGBT7gdJ4n1LhcE38B
         41cT37ru0TEoCg9gVyTxlWqCje+tjEVE/KrZPwj83nPdzr7kG2gaqdtlBwQbIzzAcLSV
         2IEiUpH22By6VR5jJXaLgSVV0c6hmStr0Y9aqVprTM2uAE7LbVrvdZkneX6dzqixsXYF
         BD149Qg22s5vwLB4qxHOHSilvKwb+4XH9mY4MPTo20qPe8t5SMbPbIWn4vhgx3+ZSkqZ
         vE/g==
X-Gm-Message-State: APjAAAUV7SB8Al78smy8zdylxhDamrfdCWJoJmfCBK7rk7Sok4uooRYv
        hcbPUj02QZ0ZrqrFFB9Kag==
X-Google-Smtp-Source: APXvYqx34e0n0sHYQ7PUQhwNdX9WDVjeJ7QIoZfwVJlIS7mTMIDy0Oo09Czz+PQSogxpnYhb1TnRIA==
X-Received: by 2002:a05:6808:487:: with SMTP id z7mr3704319oid.46.1582904309840;
        Fri, 28 Feb 2020 07:38:29 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l207sm3287973oih.25.2020.02.28.07.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:38:29 -0800 (PST)
Received: (nullmailer pid 6854 invoked by uid 1000);
        Fri, 28 Feb 2020 15:38:28 -0000
Date:   Fri, 28 Feb 2020 09:38:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: Convert PCIe Host/Endpoint in
 Cadence platform to DT schema
Message-ID: <20200228153828.GA6802@bogus>
References: <20200224130905.952-1-kishon@ti.com>
 <20200224130905.952-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224130905.952-4-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Feb 2020 18:39:04 +0530, Kishon Vijay Abraham I wrote:
> Include Cadence core DT schema and define the Cadence platform DT schema
> for both Host and Endpoint mode. Note: The Cadence core DT schema could
> be included for other platforms using Cadence PCIe core.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 49 ++++++++++++
>  .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     | 76 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  5 files changed, 126 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
