Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5BE3446CC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCVOLN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 10:11:13 -0400
Received: from foss.arm.com ([217.140.110.172]:60946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhCVOLH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 10:11:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 638EB1042;
        Mon, 22 Mar 2021 07:11:07 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.55.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA75C3F719;
        Mon, 22 Mar 2021 07:11:05 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Kapil Karkra <kapil.karkra@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 0/2] VMD MSI Remapping Bypass
Date:   Mon, 22 Mar 2021 14:11:00 +0000
Message-Id: <161642217049.2836.9881489151722165383.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210210161315.316097-1-jonathan.derrick@intel.com>
References: <20210210161315.316097-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Feb 2021 09:13:13 -0700, Jon Derrick wrote:
> The Intel Volume Management Device acts similar to a PCI-to-PCI bridge in that
> it changes downstream devices' requester-ids to its own. As VMD supports PCIe
> devices, it has its own MSI-X table and transmits child device MSI-X by
> remapping child device MSI-X and handling like a demultiplexer.
> 
> Some newer VMD devices (Icelake Server) have an option to bypass the VMD MSI-X
> remapping table. This allows for better performance scaling as the child device
> MSI-X won't be limited by VMD's MSI-X count and IRQ handler.
> 
> [...]

Applied to pci/vmd, thanks!

[1/2] iommu/vt-d: Use Real PCI DMA device for IRTE
      https://git.kernel.org/lpieralisi/pci/c/9b4a824b88
[2/2] PCI: vmd: Disable MSI-X remapping when possible
      https://git.kernel.org/lpieralisi/pci/c/ee81ee84f8

Thanks,
Lorenzo
