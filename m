Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC65B3F2C6D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 14:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbhHTMsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 08:48:42 -0400
Received: from foss.arm.com ([217.140.110.172]:60712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhHTMsl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 08:48:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D20FE11FB;
        Fri, 20 Aug 2021 05:48:03 -0700 (PDT)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 768143F66F;
        Fri, 20 Aug 2021 05:48:01 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "srikanth.thokala@intel.com" <srikanth.thokala@intel.com>,
        robh+dt@kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        mgross@linux.intel.com, linux-pci@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com,
        lakshmi.bai.raja.subramanian@intel.com, kw@linux.com,
        devicetree@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        maz@kernel.org
Subject: Re: [PATCH v11 0/2] PCI: keembay: Add support for Intel Keem Bay
Date:   Fri, 20 Aug 2021 13:47:55 +0100
Message-Id: <162946366363.6132.9269397652737555918.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210805211010.29484-1-srikanth.thokala@intel.com>
References: <20210805211010.29484-1-srikanth.thokala@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 6 Aug 2021 02:40:08 +0530, srikanth.thokala@intel.com wrote:
> The first patch is to document DT bindings for Keem Bay PCIe controller
> for both Root Complex and Endpoint modes.
> 
> The second patch is the driver file, a glue driver. Keem Bay PCIe
> controller is based on DesignWare PCIe IP.
> 
> The patch was tested with Keem Bay evaluation module board, with B0
> stepping.
> 
> [...]

Applied to pci/keembay, thanks!

[1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
      https://git.kernel.org/lpieralisi/pci/c/33d2f8e4ff
[2/2] PCI: keembay: Add support for Intel Keem Bay
      https://git.kernel.org/lpieralisi/pci/c/0c87f90b4c

Thanks,
Lorenzo
