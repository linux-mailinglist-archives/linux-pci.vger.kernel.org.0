Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18C3007E1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbhAVPzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 10:55:48 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35318 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbhAVPzq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jan 2021 10:55:46 -0500
Received: by mail-ot1-f45.google.com with SMTP id 36so5508981otp.2;
        Fri, 22 Jan 2021 07:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+Blmlo5/G343X4GJ/Rd6bvnggbhUWj/TZr//zejW8U=;
        b=NZgjaPTLlYll7mva98KMj0NRhxCBUMGe/eR6LS+ybfR/Y/wsshte5cGBpyVZlRLVys
         fIh7TmdgpdS3aYfAs95hS4DIE1IMtnsHc3cQ9ha1b16xpaSJAMThQOvDuslHIx7I9QTu
         ddbdkTwRfzdmIxQaSFtubnO9jV6rN+W64vgVKrp5WMjHF1o167qUzJF7TPsBlXnAXPgH
         oMnH6TPrzdFbkpbnhFuMIx9RuLTSiAHnuDhGy2KP5MTGcTsFQeUgevEW7JTrhNzS0Qf1
         YRAWkFxIOIoqbrugux9taVtSgygwzCcffJkKIpTtx3eYeVnXrEcBkFwvtj3RfHthOl3h
         vJmg==
X-Gm-Message-State: AOAM530NIwkhkcD006hr8bUqDmH3yjqMBU+R2HvdcY4ZlqtyL0Ld+tGk
        /eXJbu54Qqgc7Y5GxAWpLvdLBhUuNQ==
X-Google-Smtp-Source: ABdhPJyJqKvwJn/o/cYm8DTTbgPOgWIx77c0lSo5V9uwOCGEsJ1kcCpBGX5Hh5syHMjZTSUFVXb5RA==
X-Received: by 2002:a9d:66d1:: with SMTP id t17mr3651979otm.163.1611330905408;
        Fri, 22 Jan 2021 07:55:05 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j1sm1751786oiw.50.2021.01.22.07.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 07:55:04 -0800 (PST)
Received: (nullmailer pid 864183 invoked by uid 1000);
        Fri, 22 Jan 2021 15:55:03 -0000
Date:   Fri, 22 Jan 2021 09:55:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <20210122155503.GA860027@robh.at.kernel.org>
References: <20210120101554.241029-1-xxm@rock-chips.com>
 <3af70037-c05d-1759-2bae-41db1e8e2768@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3af70037-c05d-1759-2bae-41db1e8e2768@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 20, 2021 at 06:07:29PM +0100, Johan Jonker wrote:
> Hi Simon,
> 
> Thanks you for version 2.
> A few comments, have a look if it is useful or that you disagree.
> 
> This patch has no commit message. Add one in version 3.
> 
> Submit all patches in one batch with the same sort message ID to all
> maintainers including Heiko.
> 
> Heiko Stuebner <heiko@sntech.de>
> 
> Example message ID:
> 20210120101554.241029-1-xxm@rock-chips.com
> 
> /////
> 
> Included is a copy of the Rockchip pcie nodes in a sort of test.dts below.
> Could you confirm that the properties in that dts are the one that we
> can expect for Linux mainline and can base our YAML document on?
> 
> With rk3568-cru.h and rk3568-power.h manualy added we do some tests with
> the following commands:
> 
> make ARCH=arm64 dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/pci/pci-bus.yaml
> 
> /////
> 
> Example notifications:
> 
> /arch/arm64/boot/dts/rockchip/test.dt.yaml: pcie@fe270000: reg: [[3,
> 3225419776, 0, 4194304], [0, 4263968768, 0, 65536]] is too long
> 
> /arch/arm64/boot/dts/rockchip/test.dt.yaml: pcie@fe270000: ranges:
> 'oneOf' conditional failed, one must be fixed:
> 
> Before you submit version 3 make sure that all warnings gone as much as
> possible.
> 
> On 1/20/21 11:15 AM, Simon Xue wrote:
> > Signed-off-by: Simon Xue <xxm@rock-chips.com>
> > ---
> >  .../bindings/pci/rockchip-dw-pcie.yaml        | 140 ++++++++++++++++++
> >  1 file changed, 140 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > new file mode 100644
> > index 000000000000..9d3a57f5305e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DesignWare based PCIe RC controller on Rockchip SoCs
> > +
> > +maintainers:
> > +  - Shawn Lin <shawn.lin@rock-chips.com>
> > +  - Simon Xue <xxm@rock-chips.com>
>      - Heiko Stuebner <heiko@sntech.de> ;)
> > +
> > +description: |+
> > +  RK3568 SoC PCIe host controller is based on the Synopsys DesignWare
> > +  PCIe IP and thus inherits all the common properties defined in
> > +  designware-pcie.txt.
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +# We need a select here so we don't match all nodes with 'snps,dw-pcie'
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: rockchip,rk3568-pcie
> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  compatible:
> 
> > +    item:
> 
>     items:
> 
> > +      - const: rockchip,rk3568-pcie
> > +      - const: snps,dw-pcie
> 
> Add empty line
> 
> > +  reg:    items:
>       - description:
>       - description:
> 
> Add some description for regs.
> 
> > +    maxItems: 1
> remove
> 
> This reg maxItems gives errors.
> 
> > +
> 
> > +  interrupt:
> interrupts:
>    items:
> 
> > +      - description: system information
> > +      - description: power management control
> > +      - description: PCIe message
> > +      - description: legacy interrupt
> > +      - description: error report
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: sys
> > +      - const: pmc
> > +      - const: msg

MSI? If so, use 'msi'. The DWC core will handle setting it up now.

> > +      - const: legacy
> > +      - const: err
> > +
> > +  clocks:
> > +    items:
> > +      - description: AHB clock for PCIe master
> > +      - description: AHB clock for PCIe slave
> > +      - description: AHB clock for PCIe dbi
> > +      - description: APB clock for PCIe
> > +      - description: Auxiliary clock for PCIe
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aclk_mst
> > +      - const: aclk_slv
> > +      - const: aclk_dbi
> > +      - const: pclk
> > +      - const: aux
> > +
> > +  msi-map: true
> > +
> > +  power-domains:
> > +    maxItems: 1
> 
> /////
> These properties come from designware-pcie.txt
> Maybe add them here for now till there's a common yaml?
> 
>   num-ib-windows: number of inbound address translation windows
>   num-ob-windows: number of outbound address translation windows

These can be and are now detected at runtime.

Rob
