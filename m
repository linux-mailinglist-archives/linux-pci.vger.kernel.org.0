Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6F3FA0A6
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhH0UhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 16:37:15 -0400
Received: from rosenzweig.io ([138.197.143.207]:43708 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231317AbhH0UhP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 16:37:15 -0400
Date:   Fri, 27 Aug 2021 16:09:13 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, kettenis@openbsd.org,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        marcan@marcan.st, bhelgaas@google.com, nsaenz@kernel.org,
        jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        daire.mcnamara@microchip.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] arm64: apple: Add PCIe node
Message-ID: <YSlGaVSaqphqXbBr@sunset>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-5-mark.kettenis@xs4all.nl>
 <YSkoHw3dZrW5Qnjf@rosenzweig.io>
 <56142087154d4d9e@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56142087154d4d9e@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > > Clock references and DART (IOMMU) references are left out at the
> > > moment and will be added once the appropriate bindings have been
> > > settled upon.
> > > 
> > 
> > DART is in mainline .... is there a PCIe specific issue?
> 
> True.  I don't expect 4/4 to be merged as part of this series though
> as it will need to go through marcan's tree.  It is mostly there to
> show what the device tree will look like.

Fair enough. When it does get merged it'll need the updates from my my
PCIe series (v2). It looks like the only change needed for the commit
proposed there is updating the msi-ranges format. Hopefully the solution
proposed here is acceptable to both robh and maz so we can move forward
with this :-)
