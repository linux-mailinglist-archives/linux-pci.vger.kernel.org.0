Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5EB3F40C4
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhHVSED (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Aug 2021 14:04:03 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:53092 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhHVSEC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Aug 2021 14:04:02 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 217fc3f5;
        Sun, 22 Aug 2021 20:03:18 +0200 (CEST)
Date:   Sun, 22 Aug 2021 20:03:18 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     maz@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com,
        stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev,
        marcan@marcan.st, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YRnArENaLb5SgSfQ@sunset> (message from Alyssa Rosenzweig on Sun,
        15 Aug 2021 21:34:36 -0400)
Subject: Re: [RFC PATCH 1/2] dt-bindings: PCI: Add Apple PCI controller
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-2-alyssa@rosenzweig.io>
 <87bl5z18vt.wl-maz@kernel.org> <YRnArENaLb5SgSfQ@sunset>
Message-ID: <56140c6524624af0@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Sun, 15 Aug 2021 21:34:36 -0400
> From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> Hi Marc,
> 
> > > Document the properties used by the Apple PCI controller. This is a
> > > fairly standard PCI controller, although it is not derived from any
> > > known non-Apple IP.
> > > 
> > > Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > 
> > I would rather you post something as an extension to Mark's work, for
> > multiple reasons:
> > 
> > - Mark's patch is still being discussed, and is the current
> >   reference (specially given that it is already in use in OpenBSD and
> >   u-boot).
> >   
> > - we cannot have multiple bindings. There can only be one, shared
> >   across implementations. Otherwise, you need a different kernel
> >   depending on whether you are booting from m1n1 or u-boot.
> > 
> > - what you have here is vastly inconsistent (you are describing the
> >   MSIs twice, using two different methods).
> 
> Absolutely agree, the frankenstein bindings here were the main reason v1
> was marked RFC. For v2, I've rebased on Mark's patch, which makes a
> bunch of driver magic disappear.

I updated the t8103.dtsi bindings on the apple-m1-m1n1-nvme branch in
my u-boot repository to be more in line with the current DT binding
proposal.

Note that the format of the msi-ranges property is still under
discussion.  See:

http://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210726083204.93196-2-mark.kettenis@xs4all.nl/

Cheers,

Mark
