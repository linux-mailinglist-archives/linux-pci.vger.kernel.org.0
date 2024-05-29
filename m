Return-Path: <linux-pci+bounces-8044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BEA8D3D00
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 18:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46CC1C211B5
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0461836E5;
	Wed, 29 May 2024 16:41:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663388BFF;
	Wed, 29 May 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000868; cv=none; b=BZhSIngvinu/XHHHraDz80Yb1bEx8hTpkaXitlMc7+uczoTQZef27GOyGmONfkWgZD5Fr7qyBQMCoBHstJ45P4MCgzuPM1ZnPRBxNs3MOwjRgDD5v1eysXU4zFAtDNTYDyPKhKklzA9JDMosKhQGU9rAnITinGXdP/gjYzuLPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000868; c=relaxed/simple;
	bh=jfcXkJGLtt1htSvgBRQJrWooMWWHCAH6z5xRmj9DOzs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r2I3peCudDc+NFgTnfT8Yzqbu3WjvPaPWU0eFpG26kH7GxLp91zK1WK6F21hNgzNO403z+zhms0PWBwtboZ8lWGPDLUMNE+zw1pNnDL5rH23KtkfdxSK0UtMQVhGvjnjyZSbQLpJrgSW077KMwUxj7C6VPZZgV4+z/a3vWWuALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VqFVB5PBvz67l0C;
	Thu, 30 May 2024 00:40:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 973A6140B33;
	Thu, 30 May 2024 00:41:03 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 17:41:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linuxarm@huawei.com>, <terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register CXL PMUs (and aer)
Date: Wed, 29 May 2024 17:40:54 +0100
Message-ID: <20240529164103.31671-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Focus of this RFC is CXL Performance Monitoring Units in CXL Root Ports +
Switch USP and DSPs.

The final patch moving AER to the aux bus is in the category of 'why
not try this' rather than something I feel is a particularly good idea.
I would like to get opinions on the various ways to avoid the double bus
situation introduced here. Some comments on other options for those existing
'pci_express' bus devices at the end of this cover letter.

The primary problem this RFC tries to solve is providing a means to
register the CXL PMUs found in devices which will be bound to the
PCIe portdrv. The proposed solution is to avoid the limitations of
the existing pcie service driver approach by bolting on support
for devices registered on the auxiliary_bus.

Background
==========

When the CXL PMU driver was added, only the instances found in CXL type 3
memory devices (end points) were supported. These PMUs also occur in CXL
root ports, and CXL switch upstream and downstream ports.  Adding
support for these was deliberately left for future work because theses
ports are all bound to the pcie portdrv via the appropriate PCI class
code.  Whilst some CXL support of functionality on RP and Switch Ports
is handled by the CXL port driver, that is not bound to the PCIe device,
is only instantiated as part of enumerating endpoints, and cannot use
interrupts because those are in control of the PCIe portdrv. A PMU with
out interrupts would be unfortunate so a different solution is needed.

Requirements
============

- Register multiple CXL PMUs (CPMUs) per portdrv instance.
- portdrv binds to the PCIe class code for PCI_CLASS_BRIDGE_PCI_NORMAL which
  covers any PCI-Express port.
- PCI MSI / MSIX message based interrupts must be registered by one driver -
  in this case it's the portdrv.
- portdrv goes through a dance to discover the minimal number of irq vectors
  required, and as part of this it needs to find out the highest vector number
  used.
- CXL PMUs store the interrupt message number (the one needed to find the
  above number of vectors registered) in a register in a BAR.  That
  BAR + offset of the register block is discovered from the CXL
  Register Locator DVSEC.  As such finding the maximum interrupt message
  number used by any CPMU requires checking all CXL PMU register blocks
  in the CXL Register Locator DVSEC, briefly mapping their register space
  and checking that one register.  This is safe to do because the rest
  of the CXL stack doesn't map this section of the BAR and the CXL PMU
  device is not added until after we have unmapped it again.

Dependency fun.
- The existing CXL_PMU driver registers the device on the CXL_BUS.
- portdrv is not modular.
- CONFIG_CXL_BUS is potentially modular (i.e. not available until the
  core CXL module is loaded).
- The portdrv can't be dependent on CONFIG_CXL_BUS directly without
  forcing CXL to be built in.

There are various ways to solve this dependency issue an meet the above
requirements.

1. Add an intermediate glue device that has a driver that can depend on
   CONFIG_CXL_BUS and hence ensure that is loaded before doing a full
   enumeration of the CXL PMU instances and registering  appropriate
   devices. To allow for simple tear down, device managed interfaces are
   used against the platform driver, so that when it goes away it removes
   the CPMU device instances cleanly. The parents are set one level higher
   however, so that path can be used to get to the underlying PCI Device
   (which can't go away without tearing everything down as it's the
    grandparent device).

                                                             On CXL BUS    
 _____________ __            ________________ __           ________ __________
|  Port       |  | creates  |                |  | creates |        |          |
|  PCI Dev    |  |--------->| PCIE CPMU GLUE |  |-------->| CPMU A |          |
|_____________|  |          | Platform Device|  |         |________|          |
|pordrv binds    |          |________________|  |         | perf/cxlpmu binds |
|________________|          |cxlpmu_glue binds  |         |___________________|
                            | enumerates CPMUs  |          ________ __________
                      Deps /|___________________|-------->|        |          |
                          /                               | CPMU B |          |
                    cxl_core.ko                           |________|          |
		    /  providing CXL_BUS                  | perf/cxlpmu binds | 
               Deps/                                      |___________________|
 _____________ __ /
|  Type 3     |  | creates                                 ________ _________
|  PCI Dev    |  |--------------------------------------->|        |         |
|_____________|  |                                        | CPMU C |         |
| cxl_pci binds  |                                        |________|         |
|________________|                                        | perf/cxpmu binds |
                                                          |__________________|

2. Make the CXL_PMU driver handle multiple buses. This will look similar
   to a sensor driver with I2C and SPI drivers but in this case register as a
   driver for devices on the CXL_BUS and one for another 'new' bus (e.g.
   the auxiliary bus which exists to enable this sort of hybrid driver)
   Register auxiliary devices directly from portdrv. This has to be done
   in multiple steps so enough interrupt vectors are allocated before the
   CPMU device is added and that driver might probe.

                                On auxiliary bus, children of the portdrv.
 _____________ __            ________ __________
|  Port       |  | creates  |        |          |
|  PCI Dev    |  |--------->| CPMU A |          |
|_____________|  |          |________|          |
|pordrv binds    |          | perf/cxlpmu binds |
|________________|          |___________________|
                 \         
                  \
                   \         ________ __________
                    \       |        |          |
                     ------>| CPMU A |          |    
                            |________|          |
                            | perf/cxlpmu binds |
                            |___________________|
 AND
 
                     cxl_core.ko           
		    /  providing CXL_BUS   
               Deps/                                         On CXL BUS
 _____________ __ /
|  Type 3     |  | creates                                 ________ _________
|  PCI Dev    |  |--------------------------------------->|        |         |
|_____________|  |                                        | CPMU C |         |
| cxl_pci binds  |                                        |________|         |
|________________|                                        | perf/cxpmu binds |
                                                          |__________________|                  

I have code for both and on balance option 2 is cleaner as no magic glue
devices are registered so that's what is presented in this RFC

AER experiment
==============

Note that this discussion oddly enough doesn't apply to the the CXL
PMU because we need a bus structure of some type to solve the
registration dependency problems.  The existing portdrv subdrivers
(or at least those I've looked at in detail) are much simpler.

Having two different types of bus under a portdrv instance is far
from ideal. Given I'm adding an auxbus and I wanted to poke some of
the corners + I have suitable CXL error injection support in QEMU
that lets me exercise the AER flows I decided to play a bit with that.
Note that there is some power management support in this patch set
and I hacked in callbacks to the AER driver to test that but it is
infrastructure that AER itself doesn't need.

In previous discussions various approaches have been proposed.

1) Auxiliary bus as done here.  It works, but is messy and there
   is realtively little point if the AER driver is always forced
   to be built in and load immediately anyway. Is there any interest
   in making the service drivers modular?

2) Turning the service drivers into straight forward library
   function calls.  This basically means providing some storage
   for their state and calling the bits of probe and remove
   not related to the struct device (which will no longer exist)
   directly.

I'm happy to look at either, but keen that if possible we don't
gate the CPMU support on that.  There have been discusisons around
the need for vendor specific telemetry solutions on CXL switches
and to try and encourage the upstream approach, I'd like to ensure
we have good support the facilities in the CXL specification.

Side question.  Does anyone care if /sys/bus/pci_express goes away?
- in theory it's ABI, but in practice it provides very little
  actual ABI.

If we do need to maintain that, refactoring this code gets much
harder and I suspect our only way forwards is a cut and paste
version of the auxiliary_bus that gives the flexibility needed
but would still provide that /sys/bus/pci_express.
Not nice if we can avoid it!

Other misc questions / comments.
- Can we duplicate the irq discovery into the auxiliary_bus drivers?
  They do need to be discovered in pordrv to work out how many
  vectors to request, but the current multipass approach of
  (1. Discovery, 2. IRQ pass one, 3. Store the IRQs) means
  auxiliary devices can only be created in an additional pass 4
  unless we don't pass them the irqs and allow the child device
  drivers to query it directly when they load.  Note this also
  avoids the theoretical possiblity that they move when portdrv
  reduces the requested vectors (to avoid waste).
- Additional callbacks for auxiliary_driver needed for runtime pm.
  For now I've just done suspend and resume, but we need the
  noirq variant and runtime_suspend / runtime_resume callbacks
  to support all the existing pcie_driver handled subdevices.
- Worth moving any of the drivers that register in parallel
  with the pcie portdrv over to this new approach (the Designware
  PMU for example?)
  
Jonathan Cameron (9):
  pci: pcie: Drop priv_data from struct pcie_device and use
    dev_get/set_drvdata() instead.
  pci: portdrv: Drop driver field for port type.
  pci: pcie: portdrv: Use managed device handling to simplify error and
    remove flows.
  auxiliary_bus: expose auxiliary_bus_type
  pci: pcie: portdrv: Add a auxiliary_bus
  cxl: Move CPMU register definitions to header
  pci: pcie/cxl: Register an auxiliary device for each CPMU instance
  perf: cxl: Make the cpmu driver also work with auxiliary_devices
  pci: pcie: portdrv: aer: Switch to auxiliary_bus

 drivers/base/auxiliary.c          |   2 +-
 drivers/cxl/pmu.h                 |  54 +++++++
 drivers/pci/hotplug/pciehp_core.c |  13 +-
 drivers/pci/hotplug/pciehp_hpc.c  |   2 +-
 drivers/pci/pci-driver.c          |   4 -
 drivers/pci/pcie/Kconfig          |  10 ++
 drivers/pci/pcie/Makefile         |   1 +
 drivers/pci/pcie/aer.c            |  68 +++++---
 drivers/pci/pcie/cxlpmu.c         | 129 +++++++++++++++
 drivers/pci/pcie/dpc.c            |   1 -
 drivers/pci/pcie/pme.c            |  14 +-
 drivers/pci/pcie/portdrv.c        | 254 +++++++++++++++++++++++-------
 drivers/pci/pcie/portdrv.h        |  37 +++--
 drivers/perf/Kconfig              |   1 +
 drivers/perf/cxl_pmu.c            | 153 ++++++++++--------
 include/linux/auxiliary_bus.h     |   1 +
 16 files changed, 558 insertions(+), 186 deletions(-)
 create mode 100644 drivers/pci/pcie/cxlpmu.c

-- 
2.39.2


