Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3233345C00
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 11:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhCWKft (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 06:35:49 -0400
Received: from foss.arm.com ([217.140.110.172]:43636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhCWKfq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Mar 2021 06:35:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FCF31042;
        Tue, 23 Mar 2021 03:35:46 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.56.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97A933F719;
        Tue, 23 Mar 2021 03:35:43 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nadeem Athani <nadeem@cadence.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH v4 0/4] AM64: Add PCIe bindings and driver support
Date:   Tue, 23 Mar 2021 10:35:33 +0000
Message-Id: <161649569906.24052.18351976498140721873.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210308063550.6227-1-kishon@ti.com>
References: <20210308063550.6227-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 8 Mar 2021 12:05:46 +0530, Kishon Vijay Abraham I wrote:
> AM64 uses the same PCIe controller as in J7200, however AM642 EVM
> doesn't have a clock generator (unlike J7200 base board). Here
> the clock from the SERDES has to be routed to the PCIE connector.
> This series provides an option for the pci-j721e.c driver to
> drive reference clock output to the connector.
> 
> v1 of the patch series can be found @ [1]
> v2 of the patch series can be found @ [2]
> v3 of the patch series can be found @ [3]
> 
> [...]

Applied to pci/cadence, thanks!

[1/4] dt-bindings: PCI: ti,j721e: Add binding to represent refclk to the connector
      https://git.kernel.org/lpieralisi/pci/c/f9875d1a36
[2/4] dt-bindings: PCI: ti,j721e: Add host mode dt-bindings for TI's AM64 SoC
      https://git.kernel.org/lpieralisi/pci/c/3201f355e9
[3/4] dt-bindings: PCI: ti,j721e: Add endpoint mode dt-bindings for TI's AM64 SoC
      https://git.kernel.org/lpieralisi/pci/c/6b7d5394c2
[4/4] PCI: j721e: Add support to provide refclk to PCIe connector
      https://git.kernel.org/lpieralisi/pci/c/49e0efdce7

Thanks,
Lorenzo
