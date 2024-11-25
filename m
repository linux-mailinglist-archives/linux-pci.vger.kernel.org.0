Return-Path: <linux-pci+bounces-17295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA339D8D54
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 21:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EE7162DAF
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B001B4144;
	Mon, 25 Nov 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PacYlELp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063342B9BF;
	Mon, 25 Nov 2024 20:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565958; cv=none; b=WPF4tkZJs9l872VYZDLjrY15UoYZphXErB5sXNODsIEo7c/0/jdF3g6krVImXvoo5xm+zCmsJtGFn47+b4kfA39fychwNuVKzAVoVrkueoN1CkSE5S0wpfejTTP8uYsQtWG6X3v/bBHZvwjdWPsHXrff5/5MTcS2zxHdEkQiR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565958; c=relaxed/simple;
	bh=bdSSjFLFiQHnv2PmWyoKtsdumWG74eZUCi9McWaukqE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ESsZsiUbVYEBpePSREZZQEQpSqkeSYvYppJIlnaCQONn+78claL95q1HnBckkiYzqyAGeSDRxkfw+0biphS18/Cnk+m6j0X6lmQD2F4sb4jcfFhxi8RwAF6joe8Xhyzz5maRrLiRHaoEE+RcS/1Ev8t4F3wftyW/9kNBL/NB6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PacYlELp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F0EC4CECE;
	Mon, 25 Nov 2024 20:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732565957;
	bh=bdSSjFLFiQHnv2PmWyoKtsdumWG74eZUCi9McWaukqE=;
	h=Date:From:To:Cc:Subject:From;
	b=PacYlELp7NHIKC1wX0bIvWGbq/eYWWVdGkRI8Do5X3FQ1KsNNpbDeYNMJWFfAlEli
	 QwVeK+25aHqtl0az/BKSjlyg6qTsfaPQCu+WaOW6zFTVzsnUhzCKeiPspg1qDn6OAB
	 CFh3p+gMDm7jSZqd9LGLGdFOX3BLm9c6s50QfkSSRM7Vb/FXhw1P8jdi58ZfNDtI/0
	 YzZeCUmBqvLixGPVjVd/Bkaa35JkklPzfLrj1yguK3bI4yVhWiaJDhYc5xmErHqKfd
	 k94Rhh3Nfew9vd89T6WjVywYGCPJG2PATDQRP9v8jYBoZBC3i29JeWIdlZXDf1H7go
	 yy58yEUyvd7Hg==
Date: Mon, 25 Nov 2024 14:19:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [GIT PULL] PCI changes for v6.13
Message-ID: <20241125201915.GA2609291@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.13-changes

for you to fetch changes up to 10099266dec8275a6899e6a27dcdfebbcc726cc7:

  Merge branch 'pci/typos' (2024-11-25 13:41:00 -0600)


NB:

  - Rebased this morning to remove duplicate commits.  Result is git
    diff-identical to 0f3d0b32cf72, which has been in linux-next since
    Nov 22.

  - Conflict in drivers/pci/probe.c between existing 1d59d474e1cb ("PCI:
    Hold rescan lock while adding devices during host probe") and new
    dc421bb3c0db ("PCI: Enable runtime PM of the host bridge").

  - Conflict in drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c between existing
    ad783b9f8e78 ("PCI/pwrctl: Abandon QCom WCN probe on pre-pwrseq
    device-trees") and new 086bf79a4d45 ("PCI/pwrctrl: Rename pwrctl files
    to pwrctrl") and e826ea4c7f26 ("PCI/pwrctrl: Rename pwrctrl functions
    and structures").  Note the names in pci_pwrctrl_pwrseq_of_match[]
    that need to be updated but aren't flagged as a conflict.
 
----------------------------------------------------------------

Enumeration:

  - Make pci_stop_dev() and pci_destroy_dev() safe so concurrent callers
    can't stop a device multiple times, even as we migrate from the global
    pci_rescan_remove_lock to finer-grained locking (Keith Busch)

  - Improve pci_walk_bus() implementation by making it recursive and moving
    locking up to avoid need for a 'locked' parameter (Keith Busch)

  - Unexport pci_walk_bus_locked(), which is only used internally by the
    PCI core (Keith Busch)

  - Detect some Thunderbolt chips that are built-in and hence 'trustworthy'
    by a heuristic since the 'ExternalFacingPort' and 'usb4-host-interface'
    ACPI properties are not quite enough (Esther Shimanovich)

Resource management:

  - Use PCI bus addresses (not CPU addresses) in 'ranges' properties when
    building dynamic DT nodes so systems where PCI and CPU addresses differ
    work correctly (Andrea della Porta)

  - Tidy resource sizing and assignment with helpers to reduce redundancy
    (Ilpo Järvinen)

  - Improve pdev_sort_resources() 'bogus alignment' warning to be more
    specific (Ilpo Järvinen)

Driver binding:

  - Convert driver .remove_new() callbacks to .remove() again to finish the
    conversion from returning 'int' to being 'void' (Sergio Paracuellos)

  - Export pcim_request_all_regions(), a managed interface to request all
    BARs (Philipp Stanner)

  - Replace pcim_iomap_regions_request_all() with
    pcim_request_all_regions(), and pcim_iomap_table()[n] with
    pcim_iomap(n), in the following drivers: ahci, crypto qat, crypto
    octeontx2, intel_th, iwlwifi, ntb idt, serial rp2, ALSA korg1212
    (Philipp Stanner)

  - Remove the now unused pcim_iomap_regions_request_all() (Philipp
    Stanner)

  - Export pcim_iounmap_region(), a managed interface to unmap and release
    a PCI BAR (Philipp Stanner)

  - Replace pcim_iomap_regions(mask) with pcim_iomap_region(n), and
    pcim_iounmap_regions(mask) with pcim_iounmap_region(n), in the
    following drivers: fpga dfl-pci, block mtip32xx, gpio-merrifield,
    cavium (Philipp Stanner)

Error handling:

  - Add sysfs 'reset_subordinate' to reset the entire hierarchy below a
    bridge; previously Secondary Bus Reset could only be used when there
    was a single device below a bridge (Keith Busch)

  - Warn if we reset a running device where the driver didn't register
    pci_error_handlers notification callbacks (Keith Busch)

ASPM:

  - Disable ASPM L1 before touching L1 PM Substates to follow the spec
    closer and avoid a CPU load timeout on some platforms (Ajay Agarwal)

  - Set devices below Intel VMD to D0 before enabling ASPM L1 Substates as
    required per spec for all L1 Substates changes (Jian-Hong Pan)

Power management:

  - Enable starfive controller runtime PM before probing host bridge
    (Mayank Rana)

  - Enable runtime power management for host bridges (Krishna chaitanya
    chundru)

Power control:

  - Use of_platform_device_create() instead of of_platform_populate() to
    create pwrctl platform devices so we can control it based on the child
    nodes (Manivannan Sadhasivam)

  - Create pwrctrl platform devices only if there's a relevant power supply
    property (Manivannan Sadhasivam)

  - Add device link from the pwrctl supplier to the PCI dev to ensure
    pwrctl drivers are probed before the PCI dev driver; this avoids a race
    where pwrctl could change device power state while the PCI driver was
    active (Manivannan Sadhasivam)

  - Find pwrctl device for removal with of_find_device_by_node() instead of
    searching all children of the parent (Manivannan Sadhasivam)

  - Rename 'pwrctl' to 'pwrctrl' to match new bandwidth controller
    ('bwctrl') and hotplug files (Bjorn Helgaas)

Bandwidth control:

  - Add read/modify/write locking for Link Control 2, which is used to
    manage Link speed (Ilpo Järvinen)

  - Extract Link Bandwidth Management Status check into pcie_lbms_seen(),
    where it can be shared between the bandwidth controller and quirks that
    use it to help retrain failed links (Ilpo Järvinen)

  - Re-add Link Bandwidth notification support with updates to address the
    reasons it was previously reverted (Alexandru Gagniuc, Ilpo Järvinen)

  - Add pcie_set_target_speed() and related functionality so drivers can
    manage PCIe Link speed based on thermal or other constraints (Ilpo
    Järvinen)

  - Add a thermal cooling driver to throttle PCIe Links via the existing
    thermal management framework (Ilpo Järvinen)

  - Add a userspace selftest for the PCIe bandwidth controller (Ilpo
    Järvinen)

PCI device hotplug:

  - Add hotplug controller driver for Marvell OCTEON multi-function device
    where function 0 has a management console interface to enable/disable
    and provision various personalities for the other functions (Shijith
    Thotton)

  - Retain a reference to the pci_bus for the lifetime of a pci_slot to
    avoid a use-after-free when the thunderbolt driver resets USB4 host
    routers on boot, causing hotplug remove/add of downstream docks or
    other devices (Lukas Wunner)

  - Remove unused cpcihp struct cpci_hp_controller_ops.hardware_test
    (Guilherme Giacomo Simoes)

  - Remove unused cpqphp struct ctrl_dbg.ctrl (Christophe JAILLET)

  - Use pci_bus_read_dev_vendor_id() instead of hand-coded presence
    detection in cpqphp (Ilpo Järvinen)

  - Simplify cpqphp enumeration, which is already simple-minded and doesn't
    handle devices below hot-added bridges (Ilpo Järvinen)

Virtualization:

  - Add ACS quirk for Wangxun FF5xxx NICs, which don't advertise an ACS
    capability but do isolate functions as though PCI_ACS_RR and PCI_ACS_CR
    were set, so the functions can be in independent IOMMU groups (Mengyuan
    Lou)

TLP Processing Hints (TPH):

  - Add and document TLP Processing Hints (TPH) support so drivers can
    enable and disable TPH and the kernel can save/restore TPH
    configuration (Wei Huang)

  - Add TPH Steering Tag support so drivers can retrieve Steering Tag
    values associated with specific CPUs via an ACPI _DSM to improve
    performance by directing DMA writes closer to their consumers (Wei
    Huang)

Data Object Exchange (DOE):

  - Wait up to 1 second for DOE Busy bit to clear before writing a request
    to the mailbox to avoid failures if the mailbox is still busy from a
    previous transfer (Gregory Price)

Endpoint framework:

  - Skip attempts to allocate from endpoint controller memory window if the
    requested size is larger than the window (Damien Le Moal)

  - Add and document pci_epc_mem_map() and pci_epc_mem_unmap() to handle
    controller-specific size and alignment constraints, and add test cases
    to the endpoint test driver (Damien Le Moal)

  - Implement dwc pci_epc_ops.align_addr() so pci_epc_mem_map() can observe
    DWC-specific alignment requirements (Damien Le Moal)

  - Synchronously cancel command handler work in endpoint test before
    cleaning up DMA and BARs (Damien Le Moal)

  - Respect endpoint page size in dw_pcie_ep_align_addr() (Niklas Cassel)

  - Use dw_pcie_ep_align_addr() in dw_pcie_ep_raise_msi_irq() and
    dw_pcie_ep_raise_msix_irq() instead of open coding the equivalent
    (Niklas Cassel)

  - Avoid NULL dereference if Modem Host Interface Endpoint lacks 'mmio' DT
    property (Zhongqiu Han)

  - Release PCI domain ID of Endpoint controller parent (not controller
    itself) and before unregistering the controller, to avoid
    use-after-free (Zijun Hu)

  - Clear secondary (not primary) EPC in pci_epc_remove_epf() when removing
    the secondary controller associated with an NTB (Zijun Hu)

Cadence PCIe controller driver:

  - Lower severity of 'phy-names' message (Bartosz Wawrzyniak)

Freescale i.MX6 PCIe controller driver:

  - Fix suspend/resume support on i.MX6QDL, which has a hardware erratum
    that prevents use of L2 (Stefan Eichenberger)

Intel VMD host bridge driver:

  - Add 0xb60b and 0xb06f Device IDs for client SKUs (Nirmal Patel)

MediaTek PCIe Gen3 controller driver:

  - Update mediatek-gen3 DT binding to require the exact number of clocks
    for each SoC (Fei Shao)

  - Add support for DT 'max-link-speed' and 'num-lanes' properties to
    restrict the link speed and width (AngeloGioacchino Del Regno)

Microchip PolarFlare PCIe controller driver:

  - Add DT and driver support for using either of the two PolarFire Root
    Ports (Conor Dooley)

NVIDIA Tegra194 PCIe controller driver:

  - Move endpoint controller cleanups that depend on refclk from the host
    to the notifier that tells us the host has deasserted PERST#, when
    refclk should be valid (Manivannan Sadhasivam)

Qualcomm PCIe controller driver:

  - Add qcom SAR2130P DT binding with an additional clock (Dmitry
    Baryshkov)

  - Enable MSI interrupts if 'global' IRQ is supported, since a previous
    commit unintentionally masked them (Manivannan Sadhasivam)

  - Move endpoint controller cleanups that depend on refclk from the host
    to the notifier that tells us the host has deasserted PERST#, when
    refclk should be valid (Manivannan Sadhasivam)

  - Add DT binding and driver support for IPQ9574, with Synopsys IP v5.80a
    and Qcom IP 1.27.0 (devi priya)

  - Move the OPP "operating-points-v2" table from the qcom,pcie-sm8450.yaml
    DT binding to qcom,pcie-common.yaml, where it can be used by other Qcom
    platforms (Qiang Yu)

  - Add 'global' SPI interrupt for events like link-up, link-down to
    qcom,pcie-x1e80100 DT binding so we can start enumeration when the link
    comes up (Qiang Yu)

  - Disable ASPM L0s for qcom,pcie-x1e80100 since the PHY is not tuned to
    support this (Qiang Yu)

  - Add ops_1_21_0 for SC8280X family SoC, which doesn't use the
    'iommu-map' DT property and doesn't need BDF-to-SID translation (Qiang
    Yu)

Rockchip PCIe controller driver:

  - Define ROCKCHIP_PCIE_AT_SIZE_ALIGN to replace magic 256 endpoint .align
    value (Damien Le Moal)

  - When unmapping an endpoint window, compute the region index instead of
    searching for it, and verify that the address was mapped (Damien Le
    Moal)

  - When mapping an endpoint window, verify that the address hasn't been
    mapped already (Damien Le Moal)

  - Implement pci_epc_ops.align_addr() for rockchip-ep (Damien Le Moal)

  - Fix MSI IRQ data mapping to observe the alignment constraint, which
    fixes intermittent page faults in memcpy_toio() and memcpy_fromio()
    (Damien Le Moal)

  - Rename rockchip_pcie_parse_ep_dt() to rockchip_pcie_ep_get_resources()
    for consistency with similar DT interfaces (Damien Le Moal)

  - Skip the unnecessary link train in rockchip_pcie_ep_probe() and do it
    only in the endpoint start operation (Damien Le Moal)

  - Implement pci_epc_ops.stop_link() to disable link training and
    controller configuration (Damien Le Moal)

  - Attempt link training at 5 GT/s when both partners support it (Damien
    Le Moal)

  - Add a handler for PERST# signal so we can detect host-initiated resets
    and start link training after PERST# is deasserted (Damien Le Moal)

Synopsys DesignWare PCIe controller driver:

  - Clear outbound address on unmap so dw_pcie_find_index() won't match an
    ATU index that was already unmapped (Damien Le Moal)

  - Use of_property_present() instead of of_property_read_bool() when
    testing for presence of non-boolean DT properties (Rob Herring)

  - Advertise 1MB size if endpoint supports Resizable BARs, which was
    inadvertently lost in v6.11 (Niklas Cassel)

TI J721E PCIe driver:

  - Add PCIe support for J722S SoC (Siddharth Vadapalli)

  - Delay PCIE_T_PVPERL_MS (100 ms), not just PCIE_T_PERST_CLK_US (100 us),
    before deasserting PERST# to ensure power and refclk are stable
    (Siddharth Vadapalli)

TI Keystone PCIe controller driver:

  - Set the 'ti,keystone-pcie' mode so v3.65a devices work in Root Complex
    mode (Kishon Vijay Abraham I)

  - Try to avoid unrecoverable SError for attempts to issue config
    transactions when the link is down; this is racy but the best we can do
    (Kishon Vijay Abraham I)

Miscellaneous:

  - Reorganize kerneldoc parameter names to match order in function
    signature (Julia Lawall)

  - Fix sysfs reset_method_store() memory leak (Todd Kjos)

  - Simplify pci_create_slot() (Ilpo Järvinen)

  - Fix incorrect printf format specifiers in pcitest (Luo Yifan)

----------------------------------------------------------------
Ajay Agarwal (1):
      PCI/ASPM: Disable L1 before disabling L1 PM Substates

Andrea della Porta (1):
      PCI: of_property: Assign PCI instead of CPU bus address to dynamic PCI nodes

AngeloGioacchino Del Regno (2):
      PCI: mediatek-gen3: Add support for setting max-link-speed limit
      PCI: mediatek-gen3: Add support for restricting link width

Bartosz Wawrzyniak (1):
      PCI: cadence: Lower severity of message when phy-names property is absent in DTS

Bjorn Helgaas (36):
      PCI: Fix typos
      PCI: Drop duplicate pcie_get_speed_cap(), pcie_get_width_cap() declarations
      PCI/pwrctrl: Rename pwrctl files to pwrctrl
      PCI/pwrctrl: Rename pwrctrl functions and structures
      Merge branch 'pci/aspm'
      Merge branch 'pci/bwctrl'
      Merge branch 'pci/doe'
      Merge branch 'pci/devm'
      Merge branch 'pci/driver-remove'
      Merge branch 'pci/enumeration'
      Merge branch 'pci/hotplug'
      Merge branch 'pci/hotplug-octeon'
      Merge branch 'pci/locking'
      Merge branch 'pci/of'
      Merge branch 'pci/pm'
      Merge branch 'pci/pwrctl'
      Merge branch 'pci/reset'
      Merge branch 'pci/resource'
      Merge branch 'pci/thunderbolt'
      Merge branch 'pci/tph'
      Merge branch 'pci/virtualization'
      Merge branch 'pci/dt-bindings'
      Merge branch 'pci/endpoint'
      Merge branch 'pci/controller/cadence'
      Merge branch 'pci/controller/dwc'
      Merge branch 'pci/controller/imx6'
      Merge branch 'pci/controller/j721e'
      Merge branch 'pci/controller/keystone'
      Merge branch 'pci/controller/mediatek'
      Merge branch 'pci/controller/microchip'
      Merge branch 'pci/controller/qcom'
      Merge branch 'pci/controller/rockchip'
      Merge branch 'pci/controller/tegra194'
      Merge branch 'pci/controller/vmd'
      Merge branch 'pci/misc'
      Merge branch 'pci/typos'

Christophe JAILLET (1):
      PCI: cpqphp: Remove unused struct ctrl_dbg.ctrl

Conor Dooley (2):
      dt-bindings: PCI: microchip,pcie-host: Add reg for Root Port 2
      PCI: microchip: Add support for using either Root Port 1 or 2

Damien Le Moal (21):
      PCI: endpoint: Introduce pci_epc_function_is_valid()
      PCI: endpoint: Improve pci_epc_mem_alloc_addr()
      PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
      PCI: endpoint: Update documentation
      PCI: endpoint: test: Use pci_epc_mem_map/unmap()
      PCI: dwc: endpoint: Clear outbound address on unmap
      PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation
      PCI: endpoint: test: Synchronously cancel command handler work
      PCI: rockchip-ep: Fix address translation unit programming
      PCI: rockchip-ep: Use a macro to define EP controller .align feature
      PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
      PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
      PCI: rockchip-ep: Implement the pci_epc_ops::align_addr() operation
      PCI: rockchip-ep: Fix MSI IRQ data mapping
      PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
      PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
      PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
      PCI: rockchip-ep: Refactor endpoint link training enable
      PCI: rockship-ep: Implement the pci_epc_ops::stop_link() operation
      PCI: rockchip-ep: Improve link training
      PCI: rockchip-ep: Handle PERST# signal in EP mode

Dmitry Baryshkov (1):
      dt-bindings: PCI: qcom,pcie-sm8550: Add SAR2130P compatible

Esther Shimanovich (1):
      PCI: Detect and trust built-in Thunderbolt chips

Fei Shao (1):
      dt-bindings: PCI: mediatek-gen3: Allow exact number of clocks only

Gregory Price (1):
      PCI/DOE: Poll DOE Busy bit for up to 1 second in pci_doe_send_req()

Guilherme Giacomo Simoes (1):
      PCI: cpcihp: Remove unused struct cpci_hp_controller_ops.hardware_test

Ilpo Järvinen (23):
      PCI: hotplug: Remove "Returns" kerneldoc from void functions
      PCI: Simplify pci_create_slot() logic
      resource: Add resource set range and size helpers
      PCI: Use resource_set_{range,size}() helpers
      PCI: Use align and resource helpers, and SZ_* in quirk_s3_64M()
      PCI: Add ALIGN_DOWN_IF_NONZERO() helper
      PCI: Remove unused PCI_SUBTRACTIVE_DECODE
      PCI: Move struct pci_bus_resource into bus.c
      PCI: Simplify pci_read_bridge_bases() logic
      PCI: Improve pdev_sort_resources() warning message
      PCI: cpqphp: Fix PCIBIOS_* return value confusion
      PCI: cpqphp: Use pci_bus_read_dev_vendor_id() to detect presence
      PCI: cpqphp: Use define to read class/revision dword
      PCI: cpqphp: Simplify PCI_ScanBusForNonBridge()
      Documentation PCI: Reformat RMW ops documentation
      PCI: Protect Link Control 2 Register with RMW locking
      PCI: Store all PCIe Supported Link Speeds
      PCI: Refactor pcie_update_link_speed()
      PCI: Abstract LBMS seen check into pcie_lbms_seen()
      PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller
      PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed
      thermal: Add PCIe cooling driver
      selftests/pcie_bwctrl: Create selftests

Jian-Hong Pan (2):
      PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
      PCI: vmd: Set devices to D0 before enabling PM L1 Substates

Julia Lawall (1):
      PCI: hotplug: Reorganize kerneldoc parameter names

Keith Busch (7):
      PCI: Make pci_stop_dev() concurrent safe
      PCI: Make pci_destroy_dev() concurrent safe
      PCI: Move __pci_walk_bus() mutex to where we need it
      PCI: Convert __pci_walk_bus() to be recursive
      PCI: Unexport pci_walk_bus_locked()
      PCI: Add 'reset_subordinate' to reset hierarchy below bridge
      PCI: Warn if a running device is unaware of reset

Kishon Vijay Abraham I (2):
      PCI: keystone: Set mode as Root Complex for "ti,keystone-pcie" compatible
      PCI: keystone: Add link up check to ks_pcie_other_map_bus()

Krishna chaitanya chundru (1):
      PCI: Enable runtime PM of the host bridge

Lukas Wunner (1):
      PCI: Fix use-after-free of slot->bus on hot remove

Luo Yifan (1):
      tools: PCI: Fix incorrect printf format specifiers

Manivannan Sadhasivam (7):
      PCI: qcom: Enable MSI interrupts together with Link up if 'Global IRQ' is supported
      PCI: qcom-ep: Move controller cleanups to qcom_pcie_perst_deassert()
      PCI: tegra194: Move controller cleanups to pex_ep_event_pex_rst_deassert()
      PCI/pwrctl: Use of_platform_device_create() to create pwrctl devices
      PCI/pwrctl: Create pwrctl device only if at least one power supply is present
      PCI/pwrctl: Ensure that pwrctl drivers are probed before PCI client drivers
      PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent

Mayank Rana (1):
      PCI: starfive: Enable controller runtime PM before probing host bridge

Mengyuan Lou (1):
      PCI: Add ACS quirk for Wangxun FF5xxx NICs

Niklas Cassel (2):
      PCI: dwc: ep: Use align addr function for dw_pcie_ep_raise_{msi,msix}_irq()
      PCI: dwc: ep: Fix advertised resizable BAR size regression

Nirmal Patel (1):
      PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs

Philipp Stanner (15):
      PCI: Make pcim_request_all_regions() a public function
      ata: ahci: Replace deprecated PCI functions
      crypto: qat - replace deprecated PCI functions
      crypto: marvell - replace deprecated PCI functions
      intel_th: pci: Replace deprecated PCI functions
      wifi: iwlwifi: replace deprecated PCI functions
      ntb: idt: Replace deprecated PCI functions
      serial: rp2: Replace deprecated PCI functions
      ALSA: korg1212: Replace deprecated PCI functions
      PCI: Remove pcim_iomap_regions_request_all()
      PCI: Make pcim_iounmap_region() a public function
      PCI: Deprecate pcim_iounmap_regions()
      fpga/dfl-pci.c: Replace deprecated PCI functions
      gpio: Replace deprecated PCI functions
      ethernet: cavium: Replace deprecated PCI functions

Qiang Yu (4):
      dt-bindings: PCI: qcom: Move OPP table to qcom,pcie-common.yaml
      dt-bindings: PCI: qcom,pcie-x1e80100: Add 'global' interrupt
      PCI: qcom: Remove BDF2SID mapping config for SC8280X family SoC
      PCI: qcom: Disable ASPM L0s for X1E80100

Rick Wertenbroek (1):
      PCI: endpoint: Fix pci_epc_map map_size kerneldoc string

Rob Herring (Arm) (2):
      dt-bindings: PCI: snps,dw-pcie: Drop "#interrupt-cells" from example
      PCI: dwc: Use of_property_present() for non-boolean properties

Sergio Paracuellos (2):
      PCI: controller: Switch back to struct platform_driver::remove()
      PCI: acpiphp_ampere_altra: Switch back to struct platform_driver::remove()

Shijith Thotton (1):
      PCI: hotplug: Add OCTEON PCI hotplug controller driver

Siddharth Vadapalli (2):
      PCI: j721e: Add PCIe support for J722S SoC
      PCI: j721e: Deassert PERST# after a delay of PCIE_T_PVPERL_MS milliseconds

Stefan Eichenberger (1):
      PCI: imx6: Fix suspend/resume support on i.MX6QDL

Todd Kjos (1):
      PCI: Fix reset_method_store() memory leak

Wang Jiang (1):
      PCI: endpoint: Remove surplus return statement from pci_epf_test_clean_dma_chan()

Wei Huang (3):
      PCI: Add TLP Processing Hints (TPH) support
      PCI/TPH: Add Steering Tag support
      PCI/TPH: Add TPH documentation

Yang Li (1):
      PCI: mediatek-gen3: Remove unneeded semicolon

Zhongqiu Han (1):
      PCI: endpoint: epf-mhi: Avoid NULL dereference if DT lacks 'mmio'

Zijun Hu (2):
      PCI: endpoint: Fix PCI domain ID release in pci_epc_destroy()
      PCI: endpoint: Clear secondary (not primary) EPC in pci_epc_remove_epf()

devi priya (2):
      dt-bindings: PCI: qcom: Document the IPQ9574 PCIe controller
      PCI: qcom: Add support for IPQ9574

 Documentation/ABI/testing/sysfs-bus-pci            |  11 +
 Documentation/PCI/endpoint/pci-endpoint.rst        |  29 ++
 Documentation/PCI/index.rst                        |   1 +
 Documentation/PCI/pciebus-howto.rst                |  14 +-
 Documentation/PCI/tph.rst                          | 132 +++++
 Documentation/admin-guide/kernel-parameters.txt    |   4 +
 .../bindings/pci/mediatek-pcie-gen3.yaml           |   5 +-
 .../bindings/pci/microchip,pcie-host.yaml          |  11 +-
 .../bindings/pci/plda,xpressrich3-axi-common.yaml  |  14 +-
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |   4 +
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  |   4 -
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   4 +-
 .../bindings/pci/qcom,pcie-x1e80100.yaml           |   9 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  50 ++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml      |   1 -
 .../bindings/pci/starfive,jh7110-pcie.yaml         |   7 +
 Documentation/driver-api/driver-model/devres.rst   |   1 -
 Documentation/driver-api/pci/pci.rst               |   3 +
 MAINTAINERS                                        |  19 +-
 arch/s390/pci/pci_bus.c                            |   2 +-
 arch/x86/pci/acpi.c                                | 119 +++++
 arch/x86/pci/fixup.c                               |   2 +-
 drivers/ata/acard-ahci.c                           |   6 +-
 drivers/ata/ahci.c                                 |   6 +-
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c       |  11 +-
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c        |  11 +-
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c |  14 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |  13 +-
 drivers/fpga/dfl-pci.c                             |  16 +-
 drivers/gpio/gpio-merrifield.c                     |  15 +-
 drivers/hwtracing/intel_th/pci.c                   |   9 +-
 drivers/net/ethernet/cavium/common/cavium_ptp.c    |   7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  16 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                    |  13 +-
 drivers/pci/Kconfig                                |  11 +-
 drivers/pci/Makefile                               |   3 +-
 drivers/pci/bus.c                                  | 134 +++--
 drivers/pci/controller/cadence/pci-j721e.c         |  39 +-
 drivers/pci/controller/cadence/pcie-cadence.c      |   4 +-
 drivers/pci/controller/dwc/pci-exynos.c            |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c              |  57 ++-
 drivers/pci/controller/dwc/pci-keystone.c          |  14 +-
 drivers/pci/controller/dwc/pcie-bt1.c              |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |  38 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   4 +-
 drivers/pci/controller/dwc/pcie-histb.c            |   2 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c         |   2 +-
 drivers/pci/controller/dwc/pcie-kirin.c            |   2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   8 +-
 drivers/pci/controller/dwc/pcie-qcom.c             |  19 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |   2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |   9 +-
 drivers/pci/controller/pci-aardvark.c              |   2 +-
 drivers/pci/controller/pci-host-generic.c          |   2 +-
 drivers/pci/controller/pci-mvebu.c                 |   2 +-
 drivers/pci/controller/pci-tegra.c                 |   4 +-
 drivers/pci/controller/pci-thunder-pem.c           |   4 +-
 drivers/pci/controller/pci-xgene-msi.c             |   2 +-
 drivers/pci/controller/pcie-altera-msi.c           |   2 +-
 drivers/pci/controller/pcie-altera.c               |   6 +-
 drivers/pci/controller/pcie-brcmstb.c              |   2 +-
 drivers/pci/controller/pcie-hisi-error.c           |   2 +-
 drivers/pci/controller/pcie-iproc-platform.c       |   2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c        |  77 ++-
 drivers/pci/controller/pcie-mediatek.c             |   2 +-
 drivers/pci/controller/pcie-mt7621.c               |   2 +-
 drivers/pci/controller/pcie-rcar-host.c            |   4 +-
 drivers/pci/controller/pcie-rockchip-ep.c          | 440 +++++++++++++----
 drivers/pci/controller/pcie-rockchip-host.c        |   6 +-
 drivers/pci/controller/pcie-rockchip.c             |  21 +-
 drivers/pci/controller/pcie-rockchip.h             |  24 +-
 drivers/pci/controller/pcie-xilinx-nwl.c           |   2 +-
 drivers/pci/controller/plda/pcie-microchip-host.c  | 126 ++---
 drivers/pci/controller/plda/pcie-starfive.c        |  12 +-
 drivers/pci/controller/vmd.c                       |  17 +-
 drivers/pci/devres.c                               |  67 +--
 drivers/pci/doe.c                                  |  14 +-
 drivers/pci/ecam.c                                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c       |   6 +
 drivers/pci/endpoint/functions/pci-epf-test.c      | 380 +++++++-------
 drivers/pci/endpoint/pci-epc-core.c                | 193 ++++++--
 drivers/pci/endpoint/pci-epc-mem.c                 |   9 +-
 drivers/pci/hotplug/Kconfig                        |  10 +
 drivers/pci/hotplug/Makefile                       |   1 +
 drivers/pci/hotplug/acpiphp_ampere_altra.c         |   2 +-
 drivers/pci/hotplug/cpci_hotplug.h                 |   1 -
 drivers/pci/hotplug/cpqphp_pci.c                   |  47 +-
 drivers/pci/hotplug/cpqphp_sysfs.c                 |   1 -
 drivers/pci/hotplug/octep_hp.c                     | 427 ++++++++++++++++
 drivers/pci/hotplug/pci_hotplug_core.c             |   8 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   5 +
 drivers/pci/hotplug/pciehp_hpc.c                   |   2 +-
 drivers/pci/iov.c                                  |   6 +-
 drivers/pci/of.c                                   |  27 +
 drivers/pci/of_property.c                          |   2 +-
 drivers/pci/pci-sysfs.c                            |  26 +
 drivers/pci/pci.c                                  |  98 ++--
 drivers/pci/pci.h                                  |  79 ++-
 drivers/pci/pcie/Makefile                          |   2 +-
 drivers/pci/pcie/aer.c                             |  15 +-
 drivers/pci/pcie/aspm.c                            | 100 ++--
 drivers/pci/pcie/bwctrl.c                          | 366 ++++++++++++++
 drivers/pci/pcie/portdrv.c                         |   9 +-
 drivers/pci/pcie/portdrv.h                         |   6 +-
 drivers/pci/probe.c                                |  77 ++-
 drivers/pci/pwrctl/Makefile                        |   6 -
 drivers/pci/pwrctl/core.c                          | 157 ------
 drivers/pci/{pwrctl => pwrctrl}/Kconfig            |   0
 drivers/pci/pwrctrl/Makefile                       |   6 +
 drivers/pci/pwrctrl/core.c                         | 148 ++++++
 .../pci-pwrctrl-pwrseq.c}                          |  34 +-
 drivers/pci/quirks.c                               |  70 +--
 drivers/pci/remove.c                               |  32 +-
 drivers/pci/setup-bus.c                            |  41 +-
 drivers/pci/setup-res.c                            |   7 +-
 drivers/pci/slot.c                                 |  24 +-
 drivers/pci/tph.c                                  | 547 +++++++++++++++++++++
 drivers/thermal/Kconfig                            |   9 +
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/pcie_cooling.c                     |  80 +++
 drivers/tty/serial/rp2.c                           |  12 +-
 include/linux/ioport.h                             |  32 ++
 include/linux/pci-bwctrl.h                         |  28 ++
 include/linux/pci-epc.h                            |  38 ++
 include/linux/{pci-pwrctl.h => pci-pwrctrl.h}      |  22 +-
 include/linux/pci-tph.h                            |  44 ++
 include/linux/pci.h                                |  66 +--
 include/uapi/linux/pci_regs.h                      |  38 +-
 sound/pci/korg1212/korg1212.c                      |   6 +-
 tools/pci/pcitest.c                                |  10 +-
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/pcie_bwctrl/Makefile       |   2 +
 .../pcie_bwctrl/set_pcie_cooling_state.sh          | 122 +++++
 .../selftests/pcie_bwctrl/set_pcie_speed.sh        |  67 +++
 134 files changed, 4173 insertions(+), 1164 deletions(-)
 create mode 100644 Documentation/PCI/tph.rst
 create mode 100644 drivers/pci/hotplug/octep_hp.c
 create mode 100644 drivers/pci/pcie/bwctrl.c
 delete mode 100644 drivers/pci/pwrctl/Makefile
 delete mode 100644 drivers/pci/pwrctl/core.c
 rename drivers/pci/{pwrctl => pwrctrl}/Kconfig (100%)
 create mode 100644 drivers/pci/pwrctrl/Makefile
 create mode 100644 drivers/pci/pwrctrl/core.c
 rename drivers/pci/{pwrctl/pci-pwrctl-pwrseq.c => pwrctrl/pci-pwrctrl-pwrseq.c} (64%)
 create mode 100644 drivers/pci/tph.c
 create mode 100644 drivers/thermal/pcie_cooling.c
 create mode 100644 include/linux/pci-bwctrl.h
 rename include/linux/{pci-pwrctl.h => pci-pwrctrl.h} (69%)
 create mode 100644 include/linux/pci-tph.h
 create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
 create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh

