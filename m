Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30FD30AF99
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 19:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhBASj6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 13:39:58 -0500
Received: from foss.arm.com ([217.140.110.172]:36272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232913AbhBASij (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 13:38:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD29A1477;
        Mon,  1 Feb 2021 10:37:52 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E59FD3F718;
        Mon,  1 Feb 2021 10:37:50 -0800 (PST)
Date:   Mon, 1 Feb 2021 18:37:45 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: Re: [PATCH v10 00/17] Implement NTB Controller using multiple PCI EP
Message-ID: <20210201183745.GA5152@e121166-lin.cambridge.arm.com>
References: <20210129124313.28549-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129124313.28549-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 29, 2021 at 06:12:56PM +0530, Kishon Vijay Abraham I wrote:
> This series is about implementing SW defined Non-Transparent Bridge (NTB)
> using multiple endpoint (EP) instances. This series has been tested using
> 2 endpoint instances in J7 connected to J7 board on one end and DRA7 board
> on the other end. However there is nothing platform specific for the NTB
> functionality.
> 
> This was presented in Linux Plumbers Conference. Link to presentation
> and video can be found @ [1]
> Created a video demo @ [9]
> 
> RFC patch series can be found @ [2]
> v1 patch series can be found @ [3]
> v2 patch series can be found @ [4]
> v3 patch series can be found @ [5]
> v4 patch series can be found @ [6]
> v5 patch series can be found @ [7]
> v6 patch series can be found @ [8]
> v7 patch series can be found @ [10]
> v8 patch series can be found @ [11]
> v9 patch series can be found @ [12]
> 
> Changes from v9:
> 1) Fix the typos pointed out Bjorn Helgaas
> 2) Added the received Reviewed-by tags.
> 
> Changes from v8:
> 1) Do not use devm_request_irq/devm_free_irq as pci_free_irq_vectors()
> has to be used after free_irq
> 2) Drop "NTB: tool: Enable the NTB/PCIe link on the local or remote side
> of bridge" as there is a debugfs entry to enable the link
>  
> Changes from v7:
> 1) Used values stored in ctrl_reg_bar, peer_spad_reg_bar and db_reg_bar
>    instead of hardcoded values in pci_iomap of ntb_hw_epf.c driver
> 
> Changes from v6:
> 1) Fixed issues when multiple NTB devices are creating using multiple
>    functions
> 2) Fixed issue with writing scratchpad register
> 3) Created a video demo @ [9]
> 
> Changes from v5:
> 1) Fixed a formatting issue in Kconfig pointed out by Randy
> 2) Checked for Error or Null in pci_epc_add_epf()
> 
> Changes from v4:
> 1) Fixed error condition checks in pci_epc_add_epf()
> 
> Changes from v3:
> 1) Fixed Documentation edits suggested by Randy Dunlap <rdunlap@infradead.org>
> 
> Changes from v2:
> 1) Add support for the user to create sub-directory of 'EPF Device'
>    directory (for endpoint function specific configuration using
>    configfs).
> 2) Add documentation for NTB specific attributes in configfs
> 3) Check for PCI_CLASS_MEMORY_RAM (PCIe class) before binding ntb_hw_epf
>    driver
> 4) Other documentation fixes
> 
> Changes from v1:
> 1) As per Rob's comment, removed support for creating NTB function
>    device from DT
> 2) Add support to create NTB EPF device using configfs (added support in
>    configfs to associate primary and secondary EPC with EPF.
> 
> Changes from RFC:
> 1) Converted the DT binding patches to YAML schema and merged the
>    DT binding patches together
> 2) NTB documentation is converted to .rst
> 3) One HOST can now interrupt the other HOST using MSI-X interrupts
> 4) Added support for teardown of memory window and doorbell
>    configuration
> 5) Add support to provide support 64-bit memory window size from
>    DT
> 
> [1] -> https://linuxplumbersconf.org/event/4/contributions/395/
> [2] -> http://lore.kernel.org/r/20190926112933.8922-1-kishon@ti.com
> [3] -> http://lore.kernel.org/r/20200514145927.17555-1-kishon@ti.com
> [4] -> http://lore.kernel.org/r/20200611130525.22746-1-kishon@ti.com
> [5] -> http://lore.kernel.org/r/20200904075052.8911-1-kishon@ti.com
> [6] -> http://lore.kernel.org/r/20200915042110.3015-1-kishon@ti.com
> [7] -> http://lore.kernel.org/r/20200918064227.1463-1-kishon@ti.com
> [8] -> http://lore.kernel.org/r/20200924092519.17082-1-kishon@ti.com
> [9] -> https://youtu.be/dLKKxrg5-rY
> [10] -> http://lore.kernel.org/r/20200930153519.7282-1-kishon@ti.com 
> [11] -> http://lore.kernel.org/r/20201111153559.19050-1-kishon@ti.com
> [12] -> http://lore.kernel.org/r/20210104152909.22038-1-kishon@ti.com
> 
> Kishon Vijay Abraham I (17):
>   Documentation: PCI: Add specification for the *PCI NTB* function
>     device
>   PCI: endpoint: Make *_get_first_free_bar() take into account 64 bit
>     BAR
>   PCI: endpoint: Add helper API to get the 'next' unreserved BAR
>   PCI: endpoint: Make *_free_bar() to return error codes on failure
>   PCI: endpoint: Remove unused pci_epf_match_device()
>   PCI: endpoint: Add support to associate secondary EPC with EPF
>   PCI: endpoint: Add support in configfs to associate two EPCs with EPF
>   PCI: endpoint: Add pci_epc_ops to map MSI irq
>   PCI: endpoint: Add pci_epf_ops for epf drivers to expose function
>     specific attrs
>   PCI: endpoint: Allow user to create sub-directory of 'EPF Device'
>     directory
>   PCI: cadence: Implement ->msi_map_irq() ops
>   PCI: cadence: Configure LM_EP_FUNC_CFG based on epc->function_num_map
>   PCI: endpoint: Add EP function driver to provide NTB functionality
>   PCI: Add TI J721E device to pci ids
>   NTB: Add support for EPF PCI-Express Non-Transparent Bridge
>   Documentation: PCI: Add configfs binding documentation for pci-ntb
>     endpoint function
>   Documentation: PCI: Add userguide for PCI endpoint NTB function
> 
>  .../PCI/endpoint/function/binding/pci-ntb.rst |   38 +
>  Documentation/PCI/endpoint/index.rst          |    3 +
>  .../PCI/endpoint/pci-endpoint-cfs.rst         |   10 +
>  .../PCI/endpoint/pci-ntb-function.rst         |  348 +++
>  Documentation/PCI/endpoint/pci-ntb-howto.rst  |  161 ++
>  drivers/misc/pci_endpoint_test.c              |    1 -
>  drivers/ntb/hw/Kconfig                        |    1 +
>  drivers/ntb/hw/Makefile                       |    1 +
>  drivers/ntb/hw/epf/Kconfig                    |    6 +
>  drivers/ntb/hw/epf/Makefile                   |    1 +
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  754 ++++++
>  .../pci/controller/cadence/pcie-cadence-ep.c  |   60 +-
>  drivers/pci/endpoint/functions/Kconfig        |   13 +
>  drivers/pci/endpoint/functions/Makefile       |    1 +
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2128 +++++++++++++++++
>  drivers/pci/endpoint/functions/pci-epf-test.c |   13 +-
>  drivers/pci/endpoint/pci-ep-cfs.c             |  176 +-
>  drivers/pci/endpoint/pci-epc-core.c           |  130 +-
>  drivers/pci/endpoint/pci-epf-core.c           |  105 +-
>  include/linux/pci-epc.h                       |   39 +-
>  include/linux/pci-epf.h                       |   28 +-
>  include/linux/pci_ids.h                       |    1 +
>  22 files changed, 3945 insertions(+), 73 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/function/binding/pci-ntb.rst
>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-function.rst
>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst
>  create mode 100644 drivers/ntb/hw/epf/Kconfig
>  create mode 100644 drivers/ntb/hw/epf/Makefile
>  create mode 100644 drivers/ntb/hw/epf/ntb_hw_epf.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-ntb.c

Hi Kishon,

it looks like this series did not make it to linux-pci therefore
I can't apply it, not sure what happened, I need to check.

Lorenzo
