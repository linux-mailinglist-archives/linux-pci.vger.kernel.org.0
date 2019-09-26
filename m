Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9678EBF154
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 13:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfIZLap (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 07:30:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50874 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfIZLap (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 07:30:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUYVf042269;
        Thu, 26 Sep 2019 06:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569497434;
        bh=AODQipcO23pd9f37IOWlgE5poXTiPRDoNcx+qXkr20M=;
        h=From:To:CC:Subject:Date;
        b=uUSatvgquM3Ai5CHXKoumsLDveqvuPj1C7ArpZR2Q3kdPTzEie3537LXa1wHq1qi0
         kQdyO4cX0C3haZRWgmfkvig1/lqh7jUE1Hc+hJiCxzI7IRc0enF9/8TbJ1CQj5VMMW
         mg64SA1ngYHALIxwwzkTt8hLRisj3MN4ApcoO/xA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBUYPd090803
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:30:34 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:30:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:30:26 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBUTjr069017;
        Thu, 26 Sep 2019 06:30:30 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>, <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-ntb@googlegroups.com>
Subject: [RFC PATCH 00/21] Implement NTB Controller using multiple PCI
Date:   Thu, 26 Sep 2019 16:59:12 +0530
Message-ID: <20190926112933.8922-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series is sent as RFC since this series is dependent on
[1] (cannot be merged before that series) and to get early review
comments.

I'll also split this series into smaller chunk when I post the
next revision.

This series is about implementing SW defined NTB using
multiple endpoint instances. This series has been tested using
2 endpoint instances in J7 connected to two DRA7 boards.

This was presented in Linux Plumbers Conference. The presentation
can be found @ [2]

This series:
  *) Add support to define endpoint function using device tree
  *) Add a specification for implementing NTB controller using
     multiple endpoint instances.
  *) Add a NTB endpoint function driver and a NTB host side PCI
     driver that follows the specification.
  *) Add support in PCIe endpoint core to support secondary
     interface.
  *) Add a device tree overlay file to configure J7 as NTB

The test setup is something like below
   +-------------+                                   +-------------+
   |             |                                   |             |
   |    DRA72    |                                   |    DRA76    |
   |             |                                   |             |
   +------^------+                                   +------^------+
          |                                                 |
          |                                                 |
+---------|-------------------------------------------------|---------+
|  +------v------+                                   +------v------+  |
|  |             |                                   |             |  |
|  |     EP      |                                   |     EP      |  |
|  | CONTROLLER1 |                                   | CONTROLLER2 |  |
|  |             <----------------------------------->             |  |
|  |             |                                   |             |  |
|  |             |                                   |             |  |
|  |             |                 J7                |             |  |
|  |             |  (Configured using NTB Function)  |             |  |
|  +-------------+                                   +-------------+  |
+---------------------------------------------------------------------+

Here DRA72 and DRA76 could be replaced with *any* PCI host.

EP side (J7):
=============

In the kernel:
        cd /sys/kernel/config/pci_ep/
        echo 1 > controllers/d800000.pcie-ep/start
        echo 1 > controllers/d000000.pcie-ep/start

RC side (DRA7):
===============
        echo 0000:01:00.0 > /sys/bus/pci/devices/0000\:01\:00.0/driver/unbind
        echo 0000:01:00.0 > /sys/bus/pci/drivers/ntb_hw_epf/bind
        modprobe ntb_transport
        modprobe ntb_netdev

On each of the hosts Ethernet Interface will be created.

Provide an IP address to each of the hosts:
HOST1 (dra72):
ifconfig eth2 192.168.1.2 up

HOST2 (dra76):
ifconfig eth2 192.168.1.1 up

Once this is done standard network utilities like ping or iperf can be
used.

root@dra7xx-evm:~# iperf -c 192.168.1.2
------------------------------------------------------------
Client connecting to 192.168.1.2, TCP port 5001
TCP window size: 2.50 MByte (default)
------------------------------------------------------------
[  3] local 192.168.1.1 port 60814 connected with 192.168.1.2 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec   705 MBytes   591 Mbits/sec

[1] -> http://lore.kernel.org/r/20190604131516.13596-1-kishon@ti.com
[2] -> https://www.linuxplumbersconf.org/event/4/contributions/395/attachments/284/481/Implementing_NTB_Controller_Using_PCIe_Endpoint_-_final.pdf

Kishon Vijay Abraham I (21):
  dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF Bus
  dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF Device
  dt-bindings: PCI: Endpoint: Add DT bindings for PCI EPF NTB Device
  Documentation: PCI: Add specification for the *PCI NTB* function
    device
  PCI: endpoint: Add API to get reference to EPC from device-tree
  PCI: endpoint: Add API to create EPF device from device tree
  PCI: endpoint: Add "pci-epf-bus" driver
  PCI: endpoint: Make *_get_first_free_bar() take into account 64 bit
    BAR
  PCI: endpoint: Add helper API to get the 'next' unreserved BAR
  PCI: endpoint: Make pci_epf_driver ops optional
  PCI: endpoint: Add helper API to populate header with values from DT
  PCI: endpoint: Add support to associate secondary EPC with EPF
  PCI: endpoint: Add pci_epc_ops to map MSI irq
  PCI: cadence: Implement ->msi_map_irq() ops
  PCI: endpoint: Remove unused pci_epf_match_device()
  PCI: endpoint: Fix missing mutex_unlock in error case
  PCI: endpoint: *_free_bar() to return error codes on failure
  PCI: endpoint: Add EP function driver to provide NTB functionality
  PCI: Add TI J721E device to pci ids
  NTB: Add support for EPF PCI-Express Non-Transparent Bridge
  NTB: tool: Enable the NTB/PCIe link on the local or remote side of
    bridge

 Documentation/PCI/endpoint/pci-test-ntb.txt   |  315 +++++
 .../bindings/pci/endpoint/pci-epf-bus.txt     |   27 +
 .../bindings/pci/endpoint/pci-epf-ntb.txt     |   31 +
 .../bindings/pci/endpoint/pci-epf.txt         |   28 +
 drivers/ntb/hw/Kconfig                        |    1 +
 drivers/ntb/hw/Makefile                       |    1 +
 drivers/ntb/hw/epf/Kconfig                    |    5 +
 drivers/ntb/hw/epf/Makefile                   |    1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c               |  648 ++++++++++
 drivers/ntb/test/ntb_tool.c                   |    1 +
 drivers/pci/controller/pcie-cadence-ep.c      |   59 +
 drivers/pci/endpoint/Makefile                 |    3 +-
 drivers/pci/endpoint/functions/Kconfig        |   12 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 1143 +++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-test.c |   12 +-
 drivers/pci/endpoint/pci-ep-cfs.c             |    6 +-
 drivers/pci/endpoint/pci-epc-core.c           |  221 +++-
 drivers/pci/endpoint/pci-epf-bus.c            |   54 +
 drivers/pci/endpoint/pci-epf-core.c           |  133 +-
 include/linux/pci-epc.h                       |   42 +-
 include/linux/pci-epf.h                       |   35 +-
 include/linux/pci_ids.h                       |    1 +
 23 files changed, 2715 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-test-ntb.txt
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-bus.txt
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf-ntb.txt
 create mode 100644 Documentation/devicetree/bindings/pci/endpoint/pci-epf.txt
 create mode 100644 drivers/ntb/hw/epf/Kconfig
 create mode 100644 drivers/ntb/hw/epf/Makefile
 create mode 100644 drivers/ntb/hw/epf/ntb_hw_epf.c
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-ntb.c
 create mode 100644 drivers/pci/endpoint/pci-epf-bus.c

-- 
2.17.1

