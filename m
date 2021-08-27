Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E881C3F9EB6
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhH0SZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 14:25:06 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:57884 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhH0SZF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 14:25:05 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id e5ffc94e;
        Fri, 27 Aug 2021 20:24:15 +0200 (CEST)
Date:   Fri, 27 Aug 2021 20:24:14 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     devicetree@vger.kernel.org, kettenis@openbsd.org,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        marcan@marcan.st, bhelgaas@google.com, nsaenz@kernel.org,
        jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        daire.mcnamara@microchip.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
In-Reply-To: <YSkoHw3dZrW5Qnjf@rosenzweig.io> (message from Alyssa Rosenzweig
        on Fri, 27 Aug 2021 17:59:59 +0000)
Subject: Re: [PATCH v4 4/4] arm64: apple: Add PCIe node
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-5-mark.kettenis@xs4all.nl> <YSkoHw3dZrW5Qnjf@rosenzweig.io>
Message-ID: <56142087154d4d9e@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Fri, 27 Aug 2021 17:59:59 +0000
> From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> > Clock references and DART (IOMMU) references are left out at the
> > moment and will be added once the appropriate bindings have been
> > settled upon.
> > 
> 
> DART is in mainline .... is there a PCIe specific issue?

True.  I don't expect 4/4 to be merged as part of this series though
as it will need to go through marcan's tree.  It is mostly there to
show what the device tree will look like.
