Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3A42A67A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhJLN4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 09:56:14 -0400
Received: from foss.arm.com ([217.140.110.172]:43702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhJLN4M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 09:56:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26CD1ED1;
        Tue, 12 Oct 2021 06:54:11 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.55.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7D033F66F;
        Tue, 12 Oct 2021 06:54:09 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Adrian Huang <adrianhuang0701@gmail.com>, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Adrian Huang <ahuang12@lenovo.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Nirmal Patel <nirmal.patel@linux.intel.com>, kw@linux.com,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 1/1] PCI: vmd: Do not disable MSI-X remapping if interrupt remapping is enabled by IOMMU
Date:   Tue, 12 Oct 2021 14:54:04 +0100
Message-Id: <163404682781.16928.14940056295397673727.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210901124047.1615-1-adrianhuang0701@gmail.com>
References: <20210901124047.1615-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 1 Sep 2021 20:40:47 +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> When enabling VMD in BIOS setup (Ice Lake Processor: Whitley platform),
> the host OS cannot boot successfully with the following error message:
> 
>   nvme nvme0: I/O 12 QID 0 timeout, completion polled
>   nvme nvme0: Shutdown timeout set to 6 seconds
>   DMAR: DRHD: handling fault status reg 2
>   DMAR: [INTR-REMAP] Request device [0x00:0x00.5] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
> 
> [...]

Applied to pci/vmd, thanks!

[1/1] PCI: vmd: Do not disable MSI-X remapping if interrupt remapping is enabled by IOMMU
      https://git.kernel.org/lpieralisi/pci/c/2565e5b69c

Thanks,
Lorenzo
