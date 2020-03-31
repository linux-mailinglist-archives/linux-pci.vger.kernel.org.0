Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD074199C01
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 18:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgCaQpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 12:45:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39914 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730907AbgCaQpe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 12:45:34 -0400
Received: by mail-io1-f68.google.com with SMTP id c16so8001897iod.6;
        Tue, 31 Mar 2020 09:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djfMFTQal4j3YcmeP+NkvF6u8NLqjW7dMGvc7vwGSYk=;
        b=mMGMHLXNr89JWncj3NquhigkRkmG6r62SEWm5vVIMRnC2/lDisiO2+Ramphp+CVOvZ
         b/x//mm8vVtr91NsbkzWFnztuLteai9YY0R59MCgX7fKR6smfmOkNsxYvEb81YPxCOTN
         Sa7fhT3dKZK33kmQiSEEp2PuFgueridUw2xOYN1Wo7kRyYkVOkwUVne+T2Iv3etQRlbM
         4wbx+8SrgrEkm46QDy2xEgvUBuVfmwTTZZYeagmkfoxsqW2Gbt9DCzINZ7OvA+NFJ/Ld
         eA+82Vu3ol/L7wLPoIHqJOdkllfocxJK00jSFejQswMmjINgqu91/hRCAIxyETI9kKHK
         bpXQ==
X-Gm-Message-State: ANhLgQ1jY1ff3EzXbzfr/8A7p08kCqZQYhSLo4Ba5Mk1sGjW2agLULv8
        4f322oVeKeKSiyCwcQbm+Q==
X-Google-Smtp-Source: ADFU+vuLxTkZ9iuBzEXe91m9R/OUzviTz7bh17Aw3b6VexIv6nxEhQiaLJVnJGYLcpS8cWV44rER4Q==
X-Received: by 2002:a5e:da0c:: with SMTP id x12mr15992337ioj.69.1585673131358;
        Tue, 31 Mar 2020 09:45:31 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v80sm6042145ila.62.2020.03.31.09.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:45:30 -0700 (PDT)
Received: (nullmailer pid 14148 invoked by uid 1000);
        Tue, 31 Mar 2020 16:45:29 -0000
Date:   Tue, 31 Mar 2020 10:45:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: cadence: Deprecate
 inbound/outbound specific bindings
Message-ID: <20200331164529.GA32149@bogus>
References: <20200327104727.4708-1-kishon@ti.com>
 <20200327104727.4708-2-kishon@ti.com>
 <20200330160142.GA6259@bogus>
 <2a18a228-9248-24a8-c9cd-a041c62aa381@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a18a228-9248-24a8-c9cd-a041c62aa381@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 31, 2020 at 09:08:12AM +0530, Kishon Vijay Abraham I wrote:
> Hi Rob,
> 
> On 3/30/2020 9:31 PM, Rob Herring wrote:
> > On Fri, Mar 27, 2020 at 04:17:25PM +0530, Kishon Vijay Abraham I wrote:
> >> Deprecate cdns,max-outbound-regions and cdns,no-bar-match-nbits for
> >> host mode as both these could be derived from "ranges" and "dma-ranges"
> >> property. "cdns,max-outbound-regions" property would still be required
> >> for EP mode.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  2 +-
> >>  .../bindings/pci/cdns,cdns-pcie-host.yaml     |  3 +--
> >>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 25 +++++++++++++++++++
> >>  .../bindings/pci/cdns-pcie-host.yaml          | 10 ++++++++
> >>  .../devicetree/bindings/pci/cdns-pcie.yaml    |  8 ------
> >>  5 files changed, 37 insertions(+), 11 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> >> index 2996f8d4777c..50ce5d79d2c7 100644
> >> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> >> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> >> @@ -10,7 +10,7 @@ maintainers:
> >>    - Tom Joseph <tjoseph@cadence.com>
> >>  
> >>  allOf:
> >> -  - $ref: "cdns-pcie.yaml#"
> >> +  - $ref: "cdns-pcie-ep.yaml#"
> >>    - $ref: "pci-ep.yaml#"
> >>  
> >>  properties:
> >> diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >> index cabbe46ff578..84a8f095d031 100644
> >> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >> @@ -45,8 +45,6 @@ examples:
> >>              #size-cells = <2>;
> >>              bus-range = <0x0 0xff>;
> >>              linux,pci-domain = <0>;
> >> -            cdns,max-outbound-regions = <16>;
> >> -            cdns,no-bar-match-nbits = <32>;
> >>              vendor-id = <0x17cd>;
> >>              device-id = <0x0200>;
> >>  
> >> @@ -57,6 +55,7 @@ examples:
> >>  
> >>              ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
> >>                       <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
> >> +            dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
> >>  
> >>              #interrupt-cells = <0x1>;
> >>  
> >> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> >> new file mode 100644
> >> index 000000000000..6150a7a7bdbf
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> >> @@ -0,0 +1,25 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: "http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#"
> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >> +
> >> +title: Cadence PCIe Device
> >> +
> >> +maintainers:
> >> +  - Tom Joseph <tjoseph@cadence.com>
> >> +
> >> +allOf:
> >> +  - $ref: "cdns-pcie.yaml#"
> >> +
> >> +properties:
> >> +  cdns,max-outbound-regions:
> >> +    description: maximum number of outbound regions
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/uint32
> >> +    minimum: 1
> >> +    maximum: 32
> >> +    default: 32
> > 
> > I have a feeling that as the PCI endpoint binding evolves this won't be 
> > necessary. I can see a common need to define the number of BARs for an 
> > endpoint and then this will again just be error checking.
> 
> For every buffer given by the host, we have to create a new outbound
> translation. If there are no outbound regions, we have to report the error to
> the endpoint function driver. At-least for reporting the error, we'd need to
> have this binding no?

But isn't the endpoint defined to have some number of BARs? The PCI host 
doesn't decide that.

> > 
> > What's the result if you write to a non-existent region in register 
> > CDNS_PCIE_AT_OB_REGION_PCI_ADDR0/1? If the register is non-existent and 
> > doesn't abort, you could detect this instead.
> 
> I'm not sure if we should ever try to write to a non-existent register though
> the behavior could be different in different platforms. IMHO maximum number of
> outbound regions is a HW property and is best described in device tree.

AIUI, PCI defines non-existent (config space) registers to return all 
1s. Not sure if this register is in PCI config space or the host SoC bus 
(e.g. AXI). It seems PCI bridges get done both ways from what I've seen.

Rob
