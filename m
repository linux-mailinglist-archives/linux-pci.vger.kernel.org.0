Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D88F49E5EE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 16:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiA0PXg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 10:23:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41210 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiA0PXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 10:23:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D19061356;
        Thu, 27 Jan 2022 15:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A227CC340E4;
        Thu, 27 Jan 2022 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643297014;
        bh=y6d+jRTmcap665QuVDISL57EylZTRwEwZaCF30UdSSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ucqh7UOBNrx25G3/jcxOJOWbfy4xE7btiU2t25yjvEGn6gyMZasO4eLP4OEyvBqvr
         AZ8+L+XpkLaCDaz9/n9uEcu5BhTQyn68bfBP5/ZwB0FkLyFcPw/WUdueF2PWXffeUb
         6jJv1ayCvkxsH33r0zJcf5fv5vtWiNx2BU1cePZ8Snu13h+fbf7/x//MXs6CPtfgg2
         g6bXYnpOKtnDIRfzewKCglNZayydQmA4n4hHxZJITe27GvA9USSsVdRgsHlmnG6G26
         uT+gKC+vcB0JkTtfhU6h8JrQPdySdmf4RV2QE6XC3vbE1cesvooZAxeul1h3irctND
         +7PiQISrpQ8ZQ==
Date:   Thu, 27 Jan 2022 09:23:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: ti,j721e: Add device id for J721S2
Message-ID: <20220127152333.GA101708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab490690-eac2-c714-1359-b4058e2f98ff@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo, initial post
https://lore.kernel.org/r/20211130035608.13492-1-a-govindraju@ti.com]

On Tue, Jan 25, 2022 at 12:06:16PM +0530, Aswath Govindraju wrote:
> On 30/11/21 9:26 am, Aswath Govindraju wrote:
> > Document the device id of J721S2 SoC.
> > 
> > Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> > ---
> > 
> 
> May I know if this patch can be picked up?

"git log Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml"
says most changes to this file have been applied by Lorenzo, so I cc'd
him.

> > changes since v1:
> > - changed (oneOf, items) into enum
> > 
> >  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> > index cc900202df29..41df8f1c2d4c 100644
> > --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> > +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> > @@ -64,13 +64,11 @@ properties:
> >      const: 0x104c
> >  
> >    device-id:
> > -    oneOf:
> > -      - items:
> > -          - const: 0xb00d
> > -      - items:
> > -          - const: 0xb00f
> > -      - items:
> > -          - const: 0xb010
> > +    enum:
> > +      - 0xb00d
> > +      - 0xb00f
> > +      - 0xb010
> > +      - 0xb013
> >    msi-map: true
> >  
> > 
> 
