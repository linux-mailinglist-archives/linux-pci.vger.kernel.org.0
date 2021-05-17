Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2703826A5
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 10:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhEQIUG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 04:20:06 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:58305 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbhEQISq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 04:18:46 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 97a99768;
        Mon, 17 May 2021 10:17:21 +0200 (CEST)
Date:   Mon, 17 May 2021 10:17:21 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rob Herring <robh@kernel.org>
Cc:     arnd@arndb.de, devicetree@vger.kernel.org, robh+dt@kernel.org,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        marcan@marcan.st, linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, kettenis@openbsd.org
In-Reply-To: <1621218423.820656.1315835.nullmailer@robh.at.kernel.org>
        (message from Rob Herring on Sun, 16 May 2021 21:27:03 -0500)
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
References: <20210516211851.74921-1-mark.kettenis@xs4all.nl> <20210516211851.74921-2-mark.kettenis@xs4all.nl> <1621218423.820656.1315835.nullmailer@robh.at.kernel.org>
Message-ID: <5612d6300212c4e1@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Rob Herring <robh@kernel.org>
> Date: Sun, 16 May 2021 21:27:03 -0500
> 
> On Sun, 16 May 2021 23:18:46 +0200, Mark Kettenis wrote:
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > The Apple PCIe host controller is a PCIe host controller with
> > multiple root ports present in Apple ARM SoC platforms, including
> > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  .../devicetree/bindings/pci/apple,pcie.yaml   | 150 ++++++++++++++++++
> >  MAINTAINERS                                   |   1 +
> >  2 files changed, 151 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/pci/apple,pcie.example.dts:20:18: fatal error: dt-bindings/pinctrl/apple.h: No such file or directory
>    20 |         #include <dt-bindings/pinctrl/apple.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/pci/apple,pcie.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1416: dt_binding_check] Error 2

While that header file is part of the dependency mentioned in the
cover letter, it isn't even needed.  Will fix this when I spin v2.
Sorry for the noise.
