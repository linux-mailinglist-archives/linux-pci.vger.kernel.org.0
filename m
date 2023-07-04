Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C074705F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGDMFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 08:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGDMFI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 08:05:08 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A9D10F2
        for <linux-pci@vger.kernel.org>; Tue,  4 Jul 2023 05:05:05 -0700 (PDT)
X-ASG-Debug-ID: 1688472295-086e23149814910001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id Qixcqczxx7gpNvsY (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 04 Jul 2023 20:04:55 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:04:55 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 4 Jul
 2023 20:04:53 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
        <leoliu-oc@zhaoxin.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>
Subject: [PATCH v3 0/5] Parse the PCIe AER and set to relevant registers
Date:   Tue, 4 Jul 2023 20:04:53 +0800
X-ASG-Orig-Subj: [PATCH v3 0/5] Parse the PCIe AER and set to relevant registers
Message-ID: <20230704120453.1322069-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1688472295
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3854
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.110906
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: leoliu-oc <leoliu-oc@zhaoxin.com>

According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
register values form HEST PCI Express AER Structure should be written to
relevant PCIe Device's AER Capabilities. So the purpose of the patch set
is to extract register values from HEST PCI Express AER structures and
program them into AER Capabilities.
Refer to the ACPI Spec r6.5 for a more detailed description.
Considering that HEST AER patch is an effective supplement to _HPP/_HPX
method when the Firmware does not support the _HPP/_HPX method and can be
specially configured for the AER register of a specific device.
The question about whether OS has control of AER to write the information
in the HEST AER structure to the AER register of the corresponding device
is similar to the question about _HPX/_HPP method to write the AER
information to the AER register of the corresponding device.I looked in
ACPI Spec for a description of the relationship between writing to the AER
register through the _HPP/_HPX method and whether the OS requires AER
control:
1.OSPM uses the information returned by _HPX to determine how to
configure PCI Functions that are hot- plugged into the system, to
configure Functions not configured by the platform firmware during initial
system boot, and to configure Functions any time they lose configuration
space settings (e.g. OSPM issues a Secondary Bus Reset/Function Level
Reset or Downstream Port Containment is triggered).

2._HPX may return multiple types or Record Settings (each setting in a
single sub-package.) OSPM is responsible for detecting the type of
Function and for applying the appropriate settings. OSPM is also
responsible for detecting the device / port type of the PCI Express
Function and applying the appropriate settings provided.
For example, the Secondary Uncorrectable Error Severity and Secondary
Uncorrectable Error Mask settings of Type 2 record are only applicable to
PCI Express to PCI-X/PCI Bridge whose device / port type is 1000b.
Similarly, AER settings are only applicable to hot plug PCI Express
devices that support the optional AER capability.

3.Note: OSPM may override the settings provided by the _HPX object's Type2
record (PCI Express Settings) or Type3 record (PCI Express Descriptor
Settings) when OSPM has assumed native control of the corresponding
feature. For example, if OSPM has assumed ownership of AER (via _OSC),
OSPM may override AER related settings returned by _HPX. This means that
writing the AER register value by _HPX does not require the OS to gain
control of the AER. Also from the usage description of _HPX, I think
ownership of AER means who decides the configuration value of the AER
register rather than who can write the configuration value. Even though
the OS does not have control or ownership of the AER, it should still
write the configuration values determined by the firmware to the AER
register at the request of the firmware. 
Therefore, the ownership of AER is not considered in this patch.

v1->v2:
Correct some terminology.

v2->v3:
Refined code comments, add commit information.

leoliu-oc (5):
  ACPI/APEI: Add apei_hest_parse_aer()
  ACPI/APEI: Remove static from apei_hest_parse()
  PCI: Add PCIe to PCI/PCI-X Bridge AER fields
  ACPI/PCI: Add pci_acpi_program_hest_aer_params()
  PCI: Config PCIe devices's AER register

 drivers/acpi/apei/hest.c      | 116 +++++++++++++++++++++++++++++++++-
 drivers/pci/pci-acpi.c        |  92 +++++++++++++++++++++++++++
 drivers/pci/pci.h             |   5 ++
 drivers/pci/probe.c           |   1 +
 include/acpi/actbl1.h         |  69 ++++++++++++++++++++
 include/acpi/apei.h           |  12 ++++
 include/uapi/linux/pci_regs.h |   3 +
 7 files changed, 296 insertions(+), 2 deletions(-)

-- 
2.34.1

