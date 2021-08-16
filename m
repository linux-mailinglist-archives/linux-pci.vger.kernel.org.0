Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34443ECD29
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhHPDSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:18:55 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45336 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S232249AbhHPDSw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:18:52 -0400
Date:   Sun, 15 Aug 2021 21:34:36 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: PCI: Add Apple PCI controller
Message-ID: <YRnArENaLb5SgSfQ@sunset>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-2-alyssa@rosenzweig.io>
 <87bl5z18vt.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl5z18vt.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

> > Document the properties used by the Apple PCI controller. This is a
> > fairly standard PCI controller, although it is not derived from any
> > known non-Apple IP.
> > 
> > Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> I would rather you post something as an extension to Mark's work, for
> multiple reasons:
> 
> - Mark's patch is still being discussed, and is the current
>   reference (specially given that it is already in use in OpenBSD and
>   u-boot).
>   
> - we cannot have multiple bindings. There can only be one, shared
>   across implementations. Otherwise, you need a different kernel
>   depending on whether you are booting from m1n1 or u-boot.
> 
> - what you have here is vastly inconsistent (you are describing the
>   MSIs twice, using two different methods).

Absolutely agree, the frankenstein bindings here were the main reason v1
was marked RFC. For v2, I've rebased on Mark's patch, which makes a
bunch of driver magic disappear.

Alyssa
