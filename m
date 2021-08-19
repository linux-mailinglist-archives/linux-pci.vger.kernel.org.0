Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA3F3F1A20
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 15:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbhHSNPJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 09:15:09 -0400
Received: from foss.arm.com ([217.140.110.172]:38240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231826AbhHSNPI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 09:15:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D490031B;
        Thu, 19 Aug 2021 06:14:31 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.42.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1104C3F70D;
        Thu, 19 Aug 2021 06:14:28 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-doc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Tom Joseph <tjoseph@cadence.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/8] Add SR-IOV support in PCIe Endpoint Core
Date:   Thu, 19 Aug 2021 14:14:24 +0100
Message-Id: <162937885162.23420.11118528020954705739.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210819123343.1951-1-kishon@ti.com>
References: <20210819123343.1951-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 19 Aug 2021 18:03:35 +0530, Kishon Vijay Abraham I wrote:
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
      https://git.kernel.org/lpieralisi/pci/c/f00bfc6489
[2/8] PCI: endpoint: Add support to add virtual function in endpoint core
      https://git.kernel.org/lpieralisi/pci/c/1cf362e907
[3/8] PCI: endpoint: Add support to link a physical function to a virtual function
      https://git.kernel.org/lpieralisi/pci/c/101600e790
[4/8] PCI: endpoint: Add virtual function number in pci_epc ops
      https://git.kernel.org/lpieralisi/pci/c/53fd3cbe5e
[5/8] PCI: cadence: Simplify code to get register base address for configuring BAR
      https://git.kernel.org/lpieralisi/pci/c/0cf985d611
[6/8] PCI: cadence: Add support to configure virtual functions
      https://git.kernel.org/lpieralisi/pci/c/e19a0adf6e
[7/8] misc: pci_endpoint_test: Populate sriov_configure ops to configure SR-IOV device
      https://git.kernel.org/lpieralisi/pci/c/489b1f41e5
[8/8] Documentation: PCI: endpoint/pci-endpoint-cfs: Guide to use SR-IOV
      https://git.kernel.org/lpieralisi/pci/c/0c84f5bf3e

Thanks,
Lorenzo
