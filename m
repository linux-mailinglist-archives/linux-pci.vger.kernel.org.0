Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6732165959
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfGKOuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 10:50:12 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:43577 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfGKOuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 10:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562856610; x=1594392610;
  h=from:to:cc:message-id:mime-version:subject:resent-from:
   resent-cc:date:content-transfer-encoding;
  bh=cbNKXHdWGGN5N4ljL3044bGhDdetj8MItmt22zUHnUM=;
  b=W1JL3mvtD1ckvn701aIaobkIN0tnEssc01Evbi2tdkgi2u+HZz76kB8x
   uOGKuC5Mcf+w/6WcnZVlAjTI4ozNfjQslB1b3RKdwPe1tNMwNYzuxjbuU
   vfUwtqOaEa566drug8FLMdmov1YOqo2WnIIpIi6EhHD1Ctp3LIZcoTeJr
   w=;
X-IronPort-AV: E=Sophos;i="5.62,478,1554768000"; 
   d="scan'208";a="741352044"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Jul 2019 14:50:08 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-4ff6265a.us-west-2.amazon.com (Postfix) with ESMTPS id 9F981A17B9;
        Thu, 11 Jul 2019 14:50:07 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:50:06 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:50:06 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.107.0.52) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Jul 2019 14:50:05 +0000
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Mailbox Transport; Wed, 10 Jul 2019 16:45:28 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3; Wed, 10 Jul 2019 16:45:28 +0000
Received: from email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com
 (10.25.10.214) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 10 Jul 2019 16:45:28
 +0000
Received: by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix)
        id 1D462A2387; Wed, 10 Jul 2019 16:45:28 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com
 (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70]) by
 email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS
 id 50D71A2361; Wed, 10 Jul 2019 16:45:27 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com (localhost [127.0.0.1]) by
 u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Debian-10) with ESMTP id
 x6AGjNOk021313; Wed, 10 Jul 2019 19:45:23 +0300
Received: (from jonnyc@localhost)
        by u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Submit) id x6AGjK5C021200;
        Wed, 10 Jul 2019 19:45:20 +0300
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Message-ID: <20190710164519.17883-1-jonnyc@amazon.com>
Content-Type: text/plain
MIME-Version: 1.0
Subject: [PATCH 0/8] Amazon's Annapurna Labs DT-based PCIe host controller
 driver
Date:   Thu, 11 Jul 2019 17:50:03 +0300
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for Amazon's Annapurna Labs DT-based PCIe host
controller driver.
Additionally, it adds 3 quirks (ACS, VPD and MSI-X) and 2 generic DWC patch=
es.

Regarding the 2nd DWC patch (PCI flags support), do you think this should
be done in the context of a host-bridge driver at all (as opposed to PCI
system-wide code)?


Ali Saidi (1):
  PCI: Add ACS quirk for Amazon Annapurna Labs root ports

Jonathan Chocron (7):
  PCI: Add Amazon's Annapurna Labs vendor ID
  PCI/VPD: Add VPD release quirk for Amazon Annapurna Labs host bridge
  PCI: Add quirk to disable MSI support for Amazon's Annapurna Labs host
    bridge
  dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe host bridge binding
  PCI: al: Add support for DW based driver type
  PCI: dw: Add validation that PCIe core is set to correct mode
  PCI: dw: Add support for PCI_PROBE_ONLY/PCI_REASSIGN_ALL_BUS flags

 .../devicetree/bindings/pci/pcie-al.txt       |  45 ++
 MAINTAINERS                                   |   1 +
 drivers/pci/controller/dwc/Kconfig            |  11 +
 drivers/pci/controller/dwc/pcie-al.c          | 397 ++++++++++++++++++
 .../pci/controller/dwc/pcie-designware-ep.c   |   8 +
 .../pci/controller/dwc/pcie-designware-host.c |  31 +-
 drivers/pci/quirks.c                          |  27 ++
 drivers/pci/vpd.c                             |  12 +
 include/linux/pci_ids.h                       |   2 +
 9 files changed, 530 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt

--=20
2.17.1


