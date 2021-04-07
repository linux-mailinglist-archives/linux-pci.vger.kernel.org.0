Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6859035714D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343542AbhDGQCJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 12:02:09 -0400
Received: from foss.arm.com ([217.140.110.172]:59878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242044AbhDGQCI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 12:02:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA99F1063;
        Wed,  7 Apr 2021 09:01:58 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.58.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AA133F73D;
        Wed,  7 Apr 2021 09:01:57 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, bhelgaas@google.com
Subject: Re: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic using CCI
Date:   Wed,  7 Apr 2021 17:01:50 +0100
Message-Id: <161781127065.668.2308248891622722223.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
References: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Feb 2021 14:17:31 +0530, Bharat Kumar Gogada wrote:
> Add support for routing PCIe DMA traffic coherently when
> Cache Coherent Interconnect (CCI) is enabled in the system.
> The "dma-coherent" property is used to determine if CCI is enabled
> or not.
> Refer to https://developer.arm.com/documentation/ddi0470/k/preface
> for the CCI specification.

Applied to pci/xilinx, thanks!

[1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic using CCI
      https://git.kernel.org/lpieralisi/pci/c/213e122052
[2/2] PCI: xilinx-nwl: Add optional "dma-coherent" property
      https://git.kernel.org/lpieralisi/pci/c/1c4422f226

Thanks,
Lorenzo
