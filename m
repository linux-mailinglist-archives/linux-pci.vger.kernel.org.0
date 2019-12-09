Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D19A116ED6
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 15:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfLIOSH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Dec 2019 09:18:07 -0500
Received: from foss.arm.com ([217.140.110.172]:33784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbfLIOSH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 09:18:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4701328;
        Mon,  9 Dec 2019 06:18:06 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 404123F718;
        Mon,  9 Dec 2019 06:18:05 -0800 (PST)
Date:   Mon, 9 Dec 2019 14:17:59 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        andrew.murray@arm.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v11 0/3] PCI: Add Intel PCIe Driver and respective
 dt-binding yaml file
Message-ID: <20191209141759.GA3802@e121166-lin.cambridge.arm.com>
References: <cover.1575860791.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575860791.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 11:20:03AM +0800, Dilip Kota wrote:
> Intel PCIe is Synopsys based controller. Intel PCIe driver uses
> DesignWare PCIe framework for host initialization and register
> configurations.
> 
> Changes on v11:
> 	Patches rebase on kernel v5.5-rc1
> 
> Dilip Kota (3):
>   dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
>   PCI: dwc: intel: PCIe RC controller driver
>   PCI: artpec6: Configure FTS with dwc helper function
> 
>  .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 ++++++
>  drivers/pci/controller/dwc/Kconfig                 |  11 +
>  drivers/pci/controller/dwc/Makefile                |   1 +
>  drivers/pci/controller/dwc/pcie-artpec6.c          |   8 +-
>  drivers/pci/controller/dwc/pcie-designware.c       |  57 +++
>  drivers/pci/controller/dwc/pcie-designware.h       |  12 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c         | 545 +++++++++++++++++++++
>  include/uapi/linux/pci_regs.h                      |   1 +
>  8 files changed, 766 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>  create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c

Applied to pci/dwc, thanks.

Lorenzo
