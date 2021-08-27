Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8459E3F9E6D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbhH0SAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 14:00:49 -0400
Received: from rosenzweig.io ([138.197.143.207]:43652 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238532AbhH0SAt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 14:00:49 -0400
Received: by rosenzweig.io (Postfix, from userid 1000)
        id 4A9E941AEC; Fri, 27 Aug 2021 17:59:59 +0000 (UTC)
Date:   Fri, 27 Aug 2021 17:59:59 +0000
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/4] arm64: apple: Add PCIe node
Message-ID: <YSkoHw3dZrW5Qnjf@rosenzweig.io>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-5-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827171534.62380-5-mark.kettenis@xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Clock references and DART (IOMMU) references are left out at the
> moment and will be added once the appropriate bindings have been
> settled upon.
> 

DART is in mainline .... is there a PCIe specific issue?
