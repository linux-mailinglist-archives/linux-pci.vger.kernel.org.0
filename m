Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9B1CD6E5
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 12:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgEKKwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 06:52:53 -0400
Received: from foss.arm.com ([217.140.110.172]:56220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgEKKww (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 06:52:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CF811FB;
        Mon, 11 May 2020 03:52:52 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEFAA3F305;
        Mon, 11 May 2020 03:52:50 -0700 (PDT)
Date:   Mon, 11 May 2020 11:52:48 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Andrew Murray <amurray@thegoodpenguin.co.uk>,
        "open list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 0/4] PCI: brcmstb: Some minor fixes/features
Message-ID: <20200511105248.GB24954@e121166-lin.cambridge.arm.com>
References: <20200507201544.43432-1-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507201544.43432-1-james.quinlan@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 04:15:39PM -0400, Jim Quinlan wrote:
> v3 -- A change was submitted to [1] to make 'aspm-no-l0s' a general
>       property for PCIe devices.  As such, the STB PCIe YAML  file
>       merely notes that it may be used.
> 
> v2 -- Dropped commit concerning CRS.
>    -- Chanded new prop 'brcm,aspm-en-l0s' to 'aspm-no-l0s'.
>    -- Capitalize first letter in commit subject line; spelling.
> 
> v1 -- original
> 
> [1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/pci/pci-bus.yaml
> 
> Jim Quinlan (4):
>   PCI: brcmstb: Don't clk_put() a managed clock
>   PCI: brcmstb: Fix window register offset from 4 to 8
>   dt-bindings: PCI: brcmstb: New prop 'aspm-no-l0s'
>   PCI: brcmstb: Disable L0s component of ASPM if requested
> 
>  .../bindings/pci/brcm,stb-pcie.yaml           |  2 ++
>  drivers/pci/controller/pcie-brcmstb.c         | 19 +++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)

Applied to pci/brcmstb, thanks !

Lorenzo
