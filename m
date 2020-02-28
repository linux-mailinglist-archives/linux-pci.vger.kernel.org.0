Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6008173B95
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgB1PiX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:38:23 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43023 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgB1PiX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:38:23 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so3203305oif.10;
        Fri, 28 Feb 2020 07:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PDpey6T8lgxYQHJUzjwO210zO7/INLaAqTjmTmx/Qhg=;
        b=tRtdIaJWoK8dJLjYMmYsV+iguGKL3Z9hB6ZjJvZfLtEUqiQoLo9Qw0R+rzfjDDAOrr
         8becKJjUB11MVIeU99OBHKEKPREh5sMk9NnhHt/VJ/YJkKqK/pKNwxDqwU5VV1/Vzj8f
         JZp8pyweYLS9ROT5ju8Rj75w0KrrZfLhpQWR1L35LdchgXb3AW3aEro5CZyVy5d/Pw0U
         8y1GFMvp9ybhxHllCNZ6PzD+/GPi+sJBnzRnOT6dksOm6hNQdyldgszcXxIP/iDxCYr0
         mBWQG1MbLgs8uDwI+GHahLUxf8CxfPtYTIZxBp+xJDXz1h/qPW7iCzVBE9cWc1FTqXqW
         8pnA==
X-Gm-Message-State: APjAAAWGgH1QMRa1VMBFuzvY/K3WaVgjCyoCaTaYNHKse2quBz7jiVUi
        Mg8Iaub2jJCB3AWJ8YmPAQ==
X-Google-Smtp-Source: APXvYqwHhcuUz78YlJ14pZKglmsIhSta+BjmU1PYsKxSZExgso3eu7jX1iI+4smic8rg9VnjmMfOUg==
X-Received: by 2002:aca:4a86:: with SMTP id x128mr1057001oia.29.1582904301019;
        Fri, 28 Feb 2020 07:38:21 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b4sm3181050oie.55.2020.02.28.07.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:38:20 -0800 (PST)
Received: (nullmailer pid 6555 invoked by uid 1000);
        Fri, 28 Feb 2020 15:38:19 -0000
Date:   Fri, 28 Feb 2020 09:38:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: PCI: cadence: Add PCIe RC/EP DT
 schema for Cadence PCIe
Message-ID: <20200228153819.GA5476@bogus>
References: <20200224130905.952-1-kishon@ti.com>
 <20200224130905.952-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224130905.952-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 06:39:03PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe Host (RC) and Endpoint (EP) device tree schema for Cadence
> PCIe core library. Platforms using Cadence PCIe core can include the
> schemas added here in the platform specific schemas.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/cdns-pcie-host.yaml          | 27 ++++++++++++++++
>  .../devicetree/bindings/pci/cdns-pcie.yaml    | 31 +++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
