Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191992F22CE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jan 2021 23:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbhAKWci (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 17:32:38 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:44486 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389738AbhAKWci (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2021 17:32:38 -0500
Received: by mail-oi1-f176.google.com with SMTP id d189so268166oig.11;
        Mon, 11 Jan 2021 14:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JKujtSpNWqEBNkstC1Xi1WJEZqjaluSLJI5TMgni9DE=;
        b=ZdMn+1HhnDMRhAr32BCXSi+/tYuATxGtFycDH21oCV/qKMuVuykLuCQtgLtW49BtIT
         DoprPon1Vqdwk9vD+QtjAoQUQFnIOVwqyN+fgEZ2e9U742z5Dn5R5CYHLEH6anl2E+RA
         e/uMeARrOjSf7++2NT2Kz5S7+/OcbOOEJr4deTHr62/w2zzodNUBAtc5IbPLqiwlfC3a
         fYBz+i5e1FjsUzdszKzRl3ynC49pP4gOqak625uNLVI9sbgaaeAKer4Z0Y3LI1Pl+M7j
         PHSKRefFvWCkTOq31tvByMHlJbjeFQ5+KiZfDRc0mqYUzeD83TrEi4cG6pM5Xg4WvAyd
         jxZg==
X-Gm-Message-State: AOAM531vtBH5/hwZziIVPQ4LaM0OrmO/HmLWdR5MnJR9TQ4qdusFL3Df
        72hjgyEkbujKeWPkSfT05w==
X-Google-Smtp-Source: ABdhPJzN6H3NDZjxhTjlFEytVExkly/VEM/rbtk+zSRv+UsB7q0EttO8kSe4TBbuNrMt5qlO+8v8qg==
X-Received: by 2002:aca:4e0a:: with SMTP id c10mr634718oib.14.1610404317091;
        Mon, 11 Jan 2021 14:31:57 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k10sm234299otn.71.2021.01.11.14.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 14:31:55 -0800 (PST)
Received: (nullmailer pid 3177511 invoked by uid 1000);
        Mon, 11 Jan 2021 22:31:54 -0000
Date:   Mon, 11 Jan 2021 16:31:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nadeem Athani <nadeem@cadence.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: ti,j721e: Add binding to
 represent refclk to the connector
Message-ID: <20210111223154.GA3175106@robh.at.kernel.org>
References: <20210104124103.30930-1-kishon@ti.com>
 <20210104124103.30930-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104124103.30930-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 04, 2021 at 06:11:00PM +0530, Kishon Vijay Abraham I wrote:
> Add binding to represent refclk to the PCIe connector.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-host.yaml         | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index 0880a613ece6..7607018a115b 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -46,12 +46,21 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 1
> -    description: clock-specifier to represent input to the PCIe
> +    minItems: 1
> +    maxItems: 2
> +    description: clock-specifier to represent input to the PCIe for 1 item.
> +      2nd item if present represents reference clock to the connector.
>  
>    clock-names:
> -    items:
> -      - const: fck
> +    oneOf:
> +      - description: Represent input clock to the PCIe
> +        items:
> +          - const: fck
> +      - description: Represent input clock to the PCIe and reference clock to
> +          the connector.
> +        items:
> +          - const: fck
> +          - const: pcie_refclk

Can be just:

minItems: 1
items:
  - const: fck
  - const: pcie_refclk
