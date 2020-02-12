Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2742E159ED8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 02:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBLB7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 20:59:05 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33045 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgBLB7F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2020 20:59:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so543954oig.0;
        Tue, 11 Feb 2020 17:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pztga/VfrpOW3mpKvfzJW4XJ0PmmY7R31h2DX/6cIMc=;
        b=mAdthPqcwhiRo8hfojUvRpLrmkV3NNlvlhAcxr2F2pnt7S5AlOZ8oK6V2pbkpGwFfl
         q8cnXwZelLRsIq40QoRp/A15qeJwjVr/6+R2hHaC7T78hXUMtHt02oRUa7MCFciMyUy4
         XSP/BpwSfdv9JSjNXMEe5Epj/SMTZmRY8mRpWarIHPXBQ5mJeW5bE2P1zdn2hAF3RBjk
         7Kq+VgmPIjRSh3kEsfPDR1Q44j2XA2jtPG1p2JwgD5nN7zdDabcbr2o2tUuLun7jnSbL
         Re56U5eqTC7sksWEcBC/+yg6qoLHyqxLPiifW19b+zVRv59KGvTpo5CLTsujVV1wh3l1
         5Irw==
X-Gm-Message-State: APjAAAV9ohWSMAfL84Fze5E0GhQjiOvO6ptQg8nqxsH3qYc+eexdUYlm
        cea9CgX0jd0N08O99R/nMw==
X-Google-Smtp-Source: APXvYqzW6ROfSZI0pr+oJju9AGLtvmicqpA3cEsg6tlxYJ1VfmwTE0d9sylHIJtmrFHKeeljCubQ+g==
X-Received: by 2002:aca:5a04:: with SMTP id o4mr4772399oib.113.1581472742537;
        Tue, 11 Feb 2020 17:59:02 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t22sm2067498otq.18.2020.02.11.17.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 17:59:01 -0800 (PST)
Received: (nullmailer pid 15263 invoked by uid 1000);
        Wed, 12 Feb 2020 01:59:00 -0000
Date:   Tue, 11 Feb 2020 19:59:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: Convert PCIe Host/Endpoint in
 Cadence platform to DT schema
Message-ID: <20200212015900.GA14509@bogus>
References: <20200210123507.9491-1-kishon@ti.com>
 <20200210123507.9491-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210123507.9491-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 10 Feb 2020 18:05:07 +0530, Kishon Vijay Abraham I wrote:
> Include Cadence core DT schema and define the Cadence platform DT schema
> for both Host and Endpoint mode. Note: The Cadence core DT schema could
> be included for other platforms using Cadence PCIe core.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 48 ++++++++++++
>  .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
>  .../bindings/pci/cdns,cdns-pcie-host.yaml     | 76 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  5 files changed, 125 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.example.dt.yaml: pcie@fc000000: 'device_type' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.example.dt.yaml: pcie@fc000000: 'ranges' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.example.dt.yaml: pcie@fc000000: '#address-cells' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.example.dt.yaml: pcie@fc000000: '#size-cells' is a required property

See https://patchwork.ozlabs.org/patch/1235807
Please check and re-submit.
