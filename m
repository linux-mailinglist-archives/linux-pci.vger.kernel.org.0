Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ADF453BAA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 22:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhKPVeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 16:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhKPVeC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 16:34:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A94361465;
        Tue, 16 Nov 2021 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637098264;
        bh=AhSW+z29ukUaI4sgjjRdVPgwUI6/M8usLcrVanI20cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuoCR5RjNl07SkKEM2lBRUOqbbR8uhFDiSuGkS1hZg/gUmdlzc+zY25ndKzX84sPA
         pBib3WOO1+3pe2VQJfph62Md99ji/PtO25y8eFm/a+XrtbS5r0Chu3ePEfQdjQGLvY
         ofKMzu+edXe8304UhX7vbPmtiR+CXpGeQVOx8QPG4zLnv1j5I4FSXhMU7HdnEkIT2y
         pnMlLoKPCVrN7RyGy+C7DU6icq2fU8Kpi5VGvt1yjyJfOBK6hRSm4Fe0gXzs2aJcAf
         6jl+xsI5pQDtqfsJrI2fQ4L9sDfADxDYP7e4rnxTQmZZKp0pMgVTBV8SgvTqQuJoee
         K1bVfZdPdoDZA==
Received: by pali.im (Postfix)
        id EE74388C; Tue, 16 Nov 2021 22:31:01 +0100 (CET)
Date:   Tue, 16 Nov 2021 22:31:01 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <20211116213101.enedflqtezel5rmq@pali>
References: <20211031150706.27873-1-kabel@kernel.org>
 <YY6HYM4T+A+tm85P@robh.at.kernel.org>
 <20211112153208.s4nuckz7js4fipce@pali>
 <CAL_JsqJ+FYFFcDEm-_Ow=9TERhhEMVKm3OCHyDdGo02onK7dmg@mail.gmail.com>
 <20211112171249.46xmj5zo3svm4qn2@pali>
 <CAL_Jsq+0ByuPqGw0L94qJktMy+J2XyGUQ1ZRjkBoMGX+ggBizw@mail.gmail.com>
 <20211113113106.a3ludtlycnrmbvnh@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211113113106.a3ludtlycnrmbvnh@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 13 November 2021 12:31:06 Pali Rohár wrote:
> On Friday 12 November 2021 14:56:26 Rob Herring wrote:
> > The only
> > versioning we have ATM is the kernel requires a minimum version of
> > dtschema (which we'll have to bump for all this).
> > 
> > We could have something like:
> > 
> > old-pci-bridge.yaml:
> >   allOf:
> >     - $ref: pci-host-bridge.yaml#
> >     - $ref: pcie-port.yaml#
> > 
> > new-pci-bridge.yaml:
> >   allOf:
> >     - $ref: pci-host-bridge.yaml#
> >   properties:
> >     pci@0:
> >       $ref: pcie-port.yaml#
> > 
> > And then both of the above schemas will have $ref to a pci-bridge.yaml
> > schema which should be most of pci-bus.yaml. linux,pci-domain and
> > dma-ranges? go to pci-host-bridge.yaml. max-link-speed, num-lanes,
> > reset-gpios, slot-power-limit-milliwatt, and the pending supply
> > additions (Broadcom) go to pcie-port.yaml.
> 
> This looks like a nice solution.
> 
> I would propose just one other thing: Do not allow new kernel drivers
> to use old-pci-bridge.yaml schema, so new drivers would not use old
> "deprecated" APIs...
> 
> So should I prepare some schemas and send it for review via github pull
> request mechanism? (I'm not sure how is that github project related to
> kernel DTS bindings and how is reviewing on it going...)

I prepared something for discussion:
https://github.com/devicetree-org/dt-schema/pull/64
