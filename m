Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC373EB6DF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 16:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhHMOlD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 10:41:03 -0400
Received: from foss.arm.com ([217.140.110.172]:54196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233567AbhHMOlD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 10:41:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C8051042;
        Fri, 13 Aug 2021 07:40:36 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2F7E3F718;
        Fri, 13 Aug 2021 07:40:33 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     kw@linux.com, Michal Simek <michal.simek@xilinx.com>,
        git@xilinx.com, bharat.kumar.gogada@xilinx.com, monstr@monstr.eu,
        linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: xilinx-nwl: Add clock handling
Date:   Fri, 13 Aug 2021 15:40:28 +0100
Message-Id: <162886561478.21160.11916586885494837733.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1624618100.git.michal.simek@xilinx.com>
References: <cover.1624618100.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 25 Jun 2021 12:48:21 +0200, Michal Simek wrote:
> this small series add support for enabling PCIe reference clock by driver.
> 
> Thanks,
> Michal
> 
> Changes in v3:
> - use PCIe instead of pcie
> - add stable cc
> - update commit message - reported by Krzysztof
> 
> [...]

Applied to pci/xilinx-nwl, thanks!

[1/2] dt-bindings: pci: xilinx-nwl: Document optional clock property
      https://git.kernel.org/lpieralisi/pci/c/4d79e36718
[2/2] PCI: xilinx-nwl: Enable the clock through CCF
      https://git.kernel.org/lpieralisi/pci/c/de0a01f529

Thanks,
Lorenzo
