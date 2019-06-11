Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DFB3D182
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389384AbfFKPzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 11:55:32 -0400
Received: from foss.arm.com ([217.140.110.172]:36590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388958AbfFKPzc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jun 2019 11:55:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FA9B337;
        Tue, 11 Jun 2019 08:55:31 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EBD63F246;
        Tue, 11 Jun 2019 08:55:29 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:55:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v1 0/3] PCIe and AR8151 on APQ8098/MSM8998
Message-ID: <20190611155521.GA18411@redmoon>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 28, 2019 at 05:59:48PM +0100, Marc Gonzalez wrote:
> Hello everyone,
> 
> After a lot of poking, I am finally able to use the AR8151 ethernet on the APQ8098 board.
> The magic bits are the iommu-map prop and the PCIE20_PARF_BDF_TRANSLATE_N setup.
> 
> The WIP thread is archived here:
> https://marc.info/?t=155059539200004&r=1&w=2
> 
> 
> Marc Gonzalez (3):
>   PCI: qcom: Setup PCIE20_PARF_BDF_TRANSLATE_N
>   arm64: dts: qcom: msm8998: Add PCIe SMMU node
>   arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes
> 
>  arch/arm64/boot/dts/qcom/msm8998.dtsi  | 93 ++++++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom.c |  4 ++
>  2 files changed, 97 insertions(+)

Marc,

what's the plan with this series ? Please let me know so that
I can handle it correctly in the PCI patch queue, I am not
sure by reading comments it has evolved much since posting.

Thanks,
Lorenzo
