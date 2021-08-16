Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD83EDBE5
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhHPRBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 13:01:52 -0400
Received: from foss.arm.com ([217.140.110.172]:46696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhHPRBv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 13:01:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DD216D;
        Mon, 16 Aug 2021 10:01:19 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.42.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C118D3F40C;
        Mon, 16 Aug 2021 10:01:14 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 0/8] Add SR-IOV support in PCIe Endpoint Core
Date:   Mon, 16 Aug 2021 18:01:08 +0100
Message-Id: <162913323780.3691.9972292377170327162.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210811064656.15399-1-kishon@ti.com>
References: <20210811064656.15399-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 Aug 2021 12:16:48 +0530, Kishon Vijay Abraham I wrote:
> Patch series
> *) Adds support to add virtual functions to enable endpoint controller
>    which supports SR-IOV capability
> *) Add support in Cadence endpoint driver to configure virtual functions
> *) Enable pci_endpoint_test driver to create pci_device for virtual
>    functions
> 
> [...]

Applied to pci/endpoint, thanks!

[1/8] dt-bindings: PCI: pci-ep: Add binding to specify virtual function
      https://git.kernel.org/lpieralisi/pci/c/ea96be4a7b
[2/8] PCI: endpoint: Add support to add virtual function in endpoint core
      https://git.kernel.org/lpieralisi/pci/c/b64215ff2b
[3/8] PCI: endpoint: Add support to link a physical function to a virtual function
      https://git.kernel.org/lpieralisi/pci/c/555d7c5f83
[4/8] PCI: endpoint: Add virtual function number in pci_epc ops
      https://git.kernel.org/lpieralisi/pci/c/22a8013ade
[5/8] PCI: cadence: Simplify code to get register base address for configuring BAR
      https://git.kernel.org/lpieralisi/pci/c/9d26fd710f
[6/8] PCI: cadence: Add support to configure virtual functions
      https://git.kernel.org/lpieralisi/pci/c/f52e1cf18d
[7/8] misc: pci_endpoint_test: Populate sriov_configure ops to configure SR-IOV device
      https://git.kernel.org/lpieralisi/pci/c/681883d1d1
[8/8] Documentation: PCI: endpoint/pci-endpoint-cfs: Guide to use SR-IOV
      https://git.kernel.org/lpieralisi/pci/c/805ff686a1

Thanks,
Lorenzo
