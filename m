Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580F6217031
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 17:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgGGPPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 11:15:38 -0400
Received: from foss.arm.com ([217.140.110.172]:56318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbgGGPPh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 11:15:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E3F8C0A;
        Tue,  7 Jul 2020 08:15:36 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 638773F68F;
        Tue,  7 Jul 2020 08:15:34 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:15:28 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/12] Multiple fixes in PCIe qcom driver
Message-ID: <20200707151528.GA18240@e121166-lin.cambridge.arm.com>
References: <20200615210608.21469-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615210608.21469-1-ansuelsmth@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 15, 2020 at 11:05:56PM +0200, Ansuel Smith wrote:
> This contains multiple fix for PCIe qcom driver.
> Some optional reset and clocks were missing.
> Fix a problem with no PARF programming that cause kernel lock on load.
> Add support to force gen 1 speed if needed. (due to hardware limitation)
> Add ipq8064 rev 2 support that use a different tx termination offset.
> 
> v7:
> * Rework GEN1 patch
> 
> v6:
> * Replace custom define
> * Move define not used in 07 to 08
> 
> v5:
> * Split PCI: qcom: Add ipq8064 rev2 variant and set tx term offset
> 
> v4:
> * Fix grammar error across all patch subject
> * Use bulk api for clks
> * Program PARF only in ipq8064 SoC
> * Program tx term only in ipq8064 SoC
> * Drop configurable tx-dempth rx-eq
> * Make added clk optional
> 
> v3:
> * Fix check reported by checkpatch --strict
> * Rename force_gen1 to gen
> 
> v2:
> * Drop iATU programming (already done in pcie init)
> * Use max-link-speed instead of force-gen1 custom definition
> * Drop MRRS to 256B (Can't find a realy reason why this was suggested)
> * Introduce a new variant for different revision of ipq8064
> 
> Abhishek Sahu (1):
>   PCI: qcom: Change duplicate PCI reset to phy reset
> 
> Ansuel Smith (10):
>   PCI: qcom: Add missing ipq806x clocks in PCIe driver
>   dt-bindings: PCI: qcom: Add missing clks
>   PCI: qcom: Add missing reset for ipq806x
>   dt-bindings: PCI: qcom: Add ext reset
>   PCI: qcom: Use bulk clk api and assert on error
>   PCI: qcom: Define some PARF params needed for ipq8064 SoC
>   PCI: qcom: Add support for tx term offset for rev 2.1.0
>   PCI: qcom: Add ipq8064 rev2 variant
>   dt-bindings: PCI: qcom: Add ipq8064 rev 2 variant
>   PCI: qcom: Replace define with standard value
> 
> Sham Muthayyan (1):
>   PCI: qcom: Support pci speed set for ipq806x
> 
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  15 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        | 186 +++++++++++-------
>  2 files changed, 128 insertions(+), 73 deletions(-)

Applied to pci/dwc for v5.9, thanks.

Lorenzo
