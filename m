Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B367398FF8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jun 2021 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFBQcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 12:32:19 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:57728 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhFBQcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 12:32:18 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id d16ea0b5;
        Wed, 2 Jun 2021 18:30:33 +0200 (CEST)
Date:   Wed, 2 Jun 2021 18:30:33 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, marcan@marcan.st, robin.murphy@arm.com,
        devicetree@vger.kernel.org, kettenis@openbsd.org, maz@kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210601203314.GA977583@robh.at.kernel.org> (message from Rob
        Herring on Tue, 1 Jun 2021 15:33:14 -0500)
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
References: <20210530224404.95917-1-mark.kettenis@xs4all.nl>
 <20210530224404.95917-2-mark.kettenis@xs4all.nl>
 <1622554330.029938.242360.nullmailer@robh.at.kernel.org> <20210601203314.GA977583@robh.at.kernel.org>
Message-ID: <5613143777fa92ad@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Tue, 1 Jun 2021 15:33:14 -0500
> From: Rob Herring <robh@kernel.org>
> 
> On Tue, Jun 01, 2021 at 08:32:10AM -0500, Rob Herring wrote:
> > On Mon, 31 May 2021 00:44:00 +0200, Mark Kettenis wrote:
> > > From: Mark Kettenis <kettenis@openbsd.org>
> > > 
> > > The Apple PCIe host controller is a PCIe host controller with
> > > multiple root ports present in Apple ARM SoC platforms, including
> > > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > > 
> > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > ---
> > >  .../devicetree/bindings/pci/apple,pcie.yaml   | 167 ++++++++++++++++++
> > >  MAINTAINERS                                   |   1 +
> > >  2 files changed, 168 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/pci/apple,pcie.example.dts:20:18: fatal error: dt-bindings/pinctrl/apple.h: No such file or directory
> >    20 |         #include <dt-bindings/pinctrl/apple.h>
> >       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Looking at the example, I don't think you need this header.

Indeed.  And I forgot to remove it in the respin.

> Looks like irq.h is needed though.

Hmm, apple-aic.h includes irq.h, but the current t8103.dtsi includes
both.  Similar situation with arm-gic.h and irq.h, where some DT files
include both and others only include arm-gic.h.  I can do it either
way for v3.
