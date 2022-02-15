Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B794B62FA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 06:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiBOFja (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 00:39:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbiBOFj1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 00:39:27 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10085.outbound.protection.outlook.com [40.107.1.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E11EC49
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 21:39:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7byLbslgnDvhzhCY6AxAPvUj5a3P0p/41UpDE9IitZXxf7oucsboHwo4EhSePX0H2u2jWBED3znGXmk32KsJUDxgyfxf8J9KPOly5/qGykIzeLa0CWhb/1PtYArtyt5GK/GlR9rh7yDNF/aE0/qAAwNy6nz9YeRN0hk8I94sZuD4LHvjCT8rRlWafddVTBOTCpf2vqaO+Op56m0DRav88JrfZPUe49NrsQFHMNHYhqtN5Y+kCKkMCHur5K40AtjR06v+5bBNI+4tLraHfcRmOXsdd2RPIFUtzwBo9IfSydbVv+Ehh7ih3atPTt5RujOTFDDjNaTRSpDmqBYWaJApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiOiY5ce5NC7bLWyHbPSmLTdsW2PGxGYYR9XE4+Xa2M=;
 b=h8NtzuPdLxLoR6MYeGvhEbikfgOJICexP5RfKO3Fi0u6fbwBH9XmUbaCesY7nFYGhsIlNMCmNiIf6YiMWMVzPAftOv81G/KTItCSgL0Er9c7bTSwoI9kCMXZ3ID4lRl3OlTzsyqIFDgUspuuQphqUFuwaLX50jeqxj3OsdCl7N5dGVx9WDKIIOSO0D+P9+Gh42LN6qoqRJ63Zq4nuhXg7wE5rVPH9iPYpHCYlJGnKMRcKInqPyfTWeu1voAKyZ76Fkj/Y1P8iOBzy7ittQVOnR7cGkoH5+9aMym/lCMuXDDmOWgOSB9FIJjugzAXfRx6uFm2ZxcTrYaht9m2B0uaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiOiY5ce5NC7bLWyHbPSmLTdsW2PGxGYYR9XE4+Xa2M=;
 b=S2wHtkKvmWAvWYSLavhGTVhYQknUolpT7ec1h6+LI3e57BwR6SZOKnwuItsodvFv45dW4DFHEP3q23Rl6yl87k5RxvfyRwwiL7uISoE86hDaiwlVmDTeDlJnUVo8uanXh+cCOKRKoRcEETXSBsSIDX0hn/g24PZCXT2B0L4kxFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by VI1PR04MB2976.eurprd04.prod.outlook.com (2603:10a6:802:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 05:39:13 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::4881:43a4:4127:f25e%6]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 05:39:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     linux-pci@vger.kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lznuaa@gmail.com,
        hongxing.zhu@nxp.com
Subject: [RFC PATCH 4/4] Documentation: PCI: Add specification for the PCI vNTB function device
Date:   Mon, 14 Feb 2022 23:38:44 -0600
Message-Id: <20220215053844.7119-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20220215053844.7119-1-Frank.Li@nxp.com>
References: <20220215053844.7119-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae010d90-5ff7-4cf4-a801-08d9f0457f76
X-MS-TrafficTypeDiagnostic: VI1PR04MB2976:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB2976C328FDAC08BFBC05372088349@VI1PR04MB2976.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erT1LsaVv6CEt/aC/7FzMROCMyOk39AX4Dc/KCrQjp5xnsUXe6OjfcbBX7rEKyE2k19vna1WEElXV8rECf77Rq8S1zHbtQ0P743oiF7UWYzJNsal5C8twVG0gSsazwmo74OUinEs99Uc8yzKAALHbh6GCfwqKdWLzCiyRAIZk6U88ZLFb8rKqhI1NO+kDRfOO6MYR9S5Ja/gvaCgOVdN9p5gGLchCKjQtan/SBvJPmDPRKyvQ2i/IOJCzyXQpm/1+v6WEbnd+d9QGzFwa/k7VH8ccUuhVVdljHYqa4H8lf2+o6Lnh0t1aF31Px/qHDyQUfa2L6B+1hdhy97Hh+0Q5zt3dKQlv+PqoBO32rbV2jtawnzzFy4Wg9Lj0oLUOjxG5/Zc+8D0N7UlJO7ZNhxU/DLyq4mA2jYcwhQ9yzK9OP7cS0BWm1Xr3jPeezVmlL1BQ8vfbR/mqLPbxBUEMtUr8C7flNYPPxRGXfeVB6JgXt8ZTs/xvkPwhtfMyryNIUJPQDyFTaZlKcSy9bfiybDtG5ZDgTYCseiKP8jtct5nVTUhO961C1lOLYFkR4sgo23Y+L4ueiBkEHRynKJxjgKhFXn4yhPwPd7Ti9nYzyjTgjGc4XBp5eWqU4jmyDWxEjgNtoAmeiP0E67+FgpXfjwx/vg1cRUXXMMZmMxuNQg42oGCCFW/1XATPKNWT8LjWkxTag4E250yVp2sK8XR3odDuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(5660300002)(26005)(52116002)(38350700002)(186003)(6512007)(83380400001)(38100700002)(86362001)(36756003)(2906002)(8936002)(8676002)(508600001)(66476007)(316002)(2616005)(66556008)(66946007)(6666004)(1076003)(6486002)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PwyMXfu1YZyCIxZPzLHjiMeVpXdv1gdS2E79TvNBifcTc3c37dGnsjX6kqmy?=
 =?us-ascii?Q?Ec/s1f96KTyPqpNVyKBxvRhrsS7xSxTY/AWhZnmVuyR5l0jUESpIA8Hbfa/e?=
 =?us-ascii?Q?6gjBnatJTbNbJK2bLgX/cDpJKR6dk4wqGRuF8WdgJdksyFeyZVNEoG8VDblp?=
 =?us-ascii?Q?lgk6XQvpfj1FmIgY1bkFjgHjozhbwHZwDEeyCnMGrCh6UTky0UtYK7TkY+CD?=
 =?us-ascii?Q?VevPSwniot96qc+BsLDcEUmIzNEEf94mqnMcjh8RAmnXlb6yO+IeKyPfdmrw?=
 =?us-ascii?Q?Gah0/WywO4Kytf72cVg6I7sAFo1BAliLr35fELF8i0QPI5aoeslEjFEPcVns?=
 =?us-ascii?Q?Ue3jDJ8r4q4tN8c6Tx7jaYAaIOq+OTVIO2RKTPWf3GM/AqBQ6DrTBohjKRkW?=
 =?us-ascii?Q?8vB1Yk9okDonkg/vgR/+cDaY9JVrZIkwIVayV0EPMgIYXuSVo/iQqswq5BjH?=
 =?us-ascii?Q?fIETGnBFQK1RvGVnLIUgwHHcaWUmaJXJEkAH2QH9ZnIbH2HBAWDJ/ezLkCUy?=
 =?us-ascii?Q?Rp5pR0vO2uXkVrlNg5Uq7FECsek35fE/zD4u4FozIpZReu0LypROIWBpO6yI?=
 =?us-ascii?Q?7c2LYExe/wd3g+apjx3tXjp8QccTPhrq/g7p/uM5JWH18uMmXIclJyW6Vl0r?=
 =?us-ascii?Q?R7gpxTNmKjz2JsRLoOcr9EbLxAw7be5KAZF7XW3L7/4QCWvZFS9KrM9TxR8d?=
 =?us-ascii?Q?A8v798yzZL/WS7eU7tNp8aWN/vjx/GmIJsvxF9FHlEszyuG9AhJkoxgsxmRn?=
 =?us-ascii?Q?h14tREuqt4XnLNVFQUNglhmXJJOI2yM/rCSnJmSDivX+IxF6O7eYQRRM5rmm?=
 =?us-ascii?Q?9O/02qYbqf+spgEOcMiJeGYXai3Zp38F2KpoYdiG5dp7CAgNvhFuGvpdgzL2?=
 =?us-ascii?Q?nF0f8I1nuyO90POY3fawz6o753S/iUX/b9lJzV7mqGMldYsPYhU58q+o/ABi?=
 =?us-ascii?Q?a2uhEpkHv2ktxIYTKLyItrwmrGZCTUMlWBU0+HtwaGmNmSG5TOAScOmxg4fz?=
 =?us-ascii?Q?c8zorRV5RTRdiJ2d94or78HSn5OLkg8L51ciFYzpvDb0hLbmVSbnFJcDlgST?=
 =?us-ascii?Q?Yj99uRu9uQKB22AZ3OxBcF4XvrKkna4llpN6PumhdwHmtlCqh6uVUdN9/pxP?=
 =?us-ascii?Q?gFjMf91Ci/ycejl9Z1H7A3sKrFH7fuvhrrgzTQ+Emt18TfGsgkfmBmp6k/g3?=
 =?us-ascii?Q?PHbTNIFO/DRfKmiopGIewgDY7Sf3KFANzw3wvWJeXmI/bIOhG/EIpomVuhgJ?=
 =?us-ascii?Q?3KR15+0ZIgDjElDn/5STHTZTpiY56SB7dnWF1Jd9KlboMZDZmly3vuYMTare?=
 =?us-ascii?Q?FQOPQu6CDHDA/CuLZhCVkuGXufcdgswReTg3YY2OupetiDtLXnEe5n7ZkaCK?=
 =?us-ascii?Q?Lt8B5uSxeCn6HcwwfKFs5Z2NO7BN2HIU8pDHnvcklC1nWb/wvtvx22bOY+6R?=
 =?us-ascii?Q?aMFtJxggkoweyMPP/VfHO8JKxRRL3OreqRce+bedwB9pD8zHAht3fteAGIFb?=
 =?us-ascii?Q?2OL43jvIVxnYTa6FU5P6Pla9dWr77MF80oK5bTaOkdh1zE2gCC7ttMthO7fP?=
 =?us-ascii?Q?UZeLx6vw1jCRftEzcy26fqRqXNHycAz6J5Fjt5A3P2L9sA7gvyGJ2mSwmJZJ?=
 =?us-ascii?Q?mcSm1IxFy9hIm/HkMNvbUAs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae010d90-5ff7-4cf4-a801-08d9f0457f76
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 05:39:13.4496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2unBSMm3BEfLNATqhoNaEZAY3pxNkDURyUs6qd3cr2sHkVx8GO3B/i/AXy2t1rZoG1n6hPWsWy3PoIthsoKzUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2976
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add specification for the PCI vNTB function device. The endpoint function
driver and the host PCI driver should be created based on this
specification.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/PCI/endpoint/index.rst          |   2 +
 .../PCI/endpoint/pci-vntb-function.rst        | 126 ++++++++++++++
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 161 ++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-howto.rst

diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
index 38ea1f604b6d3..4d2333e7ae067 100644
--- a/Documentation/PCI/endpoint/index.rst
+++ b/Documentation/PCI/endpoint/index.rst
@@ -13,6 +13,8 @@ PCI Endpoint Framework
    pci-test-howto
    pci-ntb-function
    pci-ntb-howto
+   pci-vntb-function
+   pci-vntb-howto
 
    function/binding/pci-test
    function/binding/pci-ntb
diff --git a/Documentation/PCI/endpoint/pci-vntb-function.rst b/Documentation/PCI/endpoint/pci-vntb-function.rst
new file mode 100644
index 0000000000000..cad8013e88390
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-vntb-function.rst
@@ -0,0 +1,126 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+PCI vNTB Function
+=================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+The difference between PCI NTB function and PCI vNTB function is
+
+PCI NTB function need at two endpoint instances and connect HOST1
+and HOST2.
+
+PCI vNTB function only use one host and one endpoint(EP), use NTB
+connect EP and PCI host
+
+.. code-block:: text
+
+
+  +------------+         +---------------------------------------+
+  |            |         |                                       |
+  +------------+         |                        +--------------+
+  | NTB        |         |                        | NTB          |
+  | NetDev     |         |                        | NetDev       |
+  +------------+         |                        +--------------+
+  | NTB        |         |                        | NTB          |
+  | Transfer   |         |                        | Transfer     |
+  +------------+         |                        +--------------+
+  |            |         |                        |              |
+  |  PCI NTB   |         |                        |              |
+  |    EPF     |         |                        |              |
+  |   Driver   |         |                        | PCI Virtual  |
+  |            |         +---------------+        | NTB Driver   |
+  |            |         | PCI EP NTB    |<------>|              |
+  |            |         |  FN Driver    |        |              |
+  +------------+         +---------------+        +--------------+
+  |            |         |               |        |              |
+  |  PCI BUS   | <-----> |  PCI EP BUS   |        |  Virtual PCI |
+  |            |  PCI    |               |        |     BUS      |
+  +------------+         +---------------+--------+--------------+
+      PCI RC                        PCI EP
+
+Constructs used for Implementing vNTB
+=====================================
+
+	1) Config Region
+	2) Self Scratchpad Registers
+	3) Peer Scratchpad Registers
+	4) Doorbell (DB) Registers
+	5) Memory Window (MW)
+
+
+Config Region:
+--------------
+
+It is same as PCI NTB Function driver
+
+Scratchpad Registers:
+---------------------
+
+  It is appended after Config region.
+
+  +--------------------------------------------------+ Base
+  |                                                  |
+  |                                                  |
+  |                                                  |
+  |          Common Config Register                  |
+  |                                                  |
+  |                                                  |
+  |                                                  |
+  +-----------------------+--------------------------+ Base + span_offset
+  |                       |                          |
+  |    Peer Span Space    |    Span Space            |
+  |                       |                          |
+  |                       |                          |
+  +-----------------------+--------------------------+ Base + span_offset
+  |                       |                          |      + span_count * 4
+  |                       |                          |
+  |     Span Space        |   Peer Span Space        |
+  |                       |                          |
+  +-----------------------+--------------------------+
+        Virtual PCI             Pcie Endpoint
+        NTB Driver               NTB Driver
+
+
+Doorbell Registers:
+-------------------
+
+  Doorbell Registers are used by the hosts to interrupt each other.
+
+Memory Window:
+--------------
+
+  Actual transfer of data between the two hosts will happen using the
+  memory window.
+
+Modeling Constructs:
+====================
+
+32-bit BARs.
+
+======  ===============
+BAR NO  CONSTRUCTS USED
+======  ===============
+BAR0    Config Region
+BAR1    Doorbell
+BAR2    Memory Window 1
+BAR3    Memory Window 2
+BAR4    Memory Window 3
+BAR5    Memory Window 4
+======  ===============
+
+64-bit BARs.
+
+======  ===============================
+BAR NO  CONSTRUCTS USED
+======  ===============================
+BAR0    Config Region + Scratchpad
+BAR1
+BAR2    Doorbell
+BAR3
+BAR4    Memory Window 1
+BAR5
+======  ===============================
+
+
diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
new file mode 100644
index 0000000000000..b4a679144692a
--- /dev/null
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -0,0 +1,161 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================================
+PCI Non-Transparent Bridge (NTB) Endpoint Function (EPF) User Guide
+===================================================================
+
+:Author: Frank Li <Frank.Li@nxp.com>
+
+This document is a guide to help users use pci-epf-vntb function driver
+and ntb_hw_epf host driver for NTB functionality. The list of steps to
+be followed in the host side and EP side is given below. For the hardware
+configuration and internals of NTB using configurable endpoints see
+Documentation/PCI/endpoint/pci-vntb-function.rst
+
+Endpoint Device
+===============
+
+Endpoint Controller Devices
+---------------------------
+
+To find the list of endpoint controller devices in the system::
+
+        # ls /sys/class/pci_epc/
+          5f010000.pcie_ep
+
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
+        # ls /sys/kernel/config/pci_ep/controllers
+          5f010000.pcie_ep
+
+Endpoint Function Drivers
+-------------------------
+
+To find the list of endpoint function drivers in the system::
+
+	# ls /sys/bus/pci-epf/drivers
+	pci_epf_ntb  pci_epf_test  pci_epf_vntb
+
+If PCI_ENDPOINT_CONFIGFS is enabled::
+
+	# ls /sys/kernel/config/pci_ep/functions
+	pci_epf_ntb  pci_epf_test  pci_epf_vntb
+
+
+Creating pci-epf-vntb Device
+----------------------------
+
+PCI endpoint function device can be created using the configfs. To create
+pci-epf-vntb device, the following commands can be used::
+
+	# mount -t configfs none /sys/kernel/config
+	# cd /sys/kernel/config/pci_ep/
+	# mkdir functions/pci_epf_vntb/func1
+
+The "mkdir func1" above creates the pci-epf-ntb function device that will
+be probed by pci_epf_vntb driver.
+
+The PCI endpoint framework populates the directory with the following
+configurable fields::
+
+	# ls functions/pci_epf_ntb/func1
+	baseclass_code    deviceid          msi_interrupts    pci-epf-ntb.0
+	progif_code       secondary         subsys_id         vendorid
+	cache_line_size   interrupt_pin     msix_interrupts   primary
+	revid             subclass_code     subsys_vendor_id
+
+The PCI endpoint function driver populates these entries with default values
+when the device is bound to the driver. The pci-epf-vntb driver populates
+vendorid with 0xffff and interrupt_pin with 0x0001::
+
+	# cat functions/pci_epf_vntb/func1/vendorid
+	0xffff
+	# cat functions/pci_epf_vntb/func1/interrupt_pin
+	0x0001
+
+
+Configuring pci-epf-vntb Device
+-------------------------------
+
+The user can configure the pci-epf-vntb device using its configfs entry. In order
+to change the vendorid and the deviceid, the following
+commands can be used::
+
+	# echo 0x1957 > functions/pci_epf_vntb/func1/vendorid
+	# echo 0x0809 > functions/pci_epf_vntb/func1/deviceid
+
+In order to configure NTB specific attributes, a new sub-directory to func1
+should be created::
+
+	# mkdir functions/pci_epf_vntb/func1/pci_epf_vntb.0/
+
+The NTB function driver will populate this directory with various attributes
+that can be configured by the user::
+
+	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
+	db_count    mw1         mw2         mw3         mw4         num_mws
+	spad_count
+
+A sample configuration for NTB function is given below::
+
+	# echo 4 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
+	# echo 128 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
+	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
+	# echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
+
+Binding pci-epf-ntb Device to EP Controller
+--------------------------------------------
+
+NTB function device should be attached to PCI endpoint controllers
+connected to the host.
+
+	# ln -s controllers/5f010000.pcie_ep functions/pci-epf-ntb/func1/primary
+
+Once the above step is completed, the PCI endpoint controllers are ready to
+establish a link with the host.
+
+
+Start the Link
+--------------
+
+In order for the endpoint device to establish a link with the host, the _start_
+field should be populated with '1'. For NTB, both the PCI endpoint controllers
+should establish link with the host (imx8 don't need this steps)::
+
+	# echo 1 > controllers/5f010000.pcie_ep/start
+
+RootComplex Device
+==================
+
+lspci Output at Host side
+------------------------
+
+Note that the devices listed here correspond to the values populated in
+"Creating pci-epf-ntb Device" section above::
+
+	# lspci
+        00:00.0 PCI bridge: Freescale Semiconductor Inc Device 0000 (rev 01)
+        01:00.0 RAM memory: Freescale Semiconductor Inc Device 0809
+
+Endpoint Device / Virtual PCI bus
+=================================
+
+lspci Output at EP Side / Virtual PCI bus
+-----------------------------------------
+
+Note that the devices listed here correspond to the values populated in
+"Creating pci-epf-ntb Device" section above::
+
+        # lspci
+        10:00.0 Unassigned class [ffff]: Dawicontrol Computersysteme GmbH Device 1234 (rev ff)
+
+Using ntb_hw_epf Device
+-----------------------
+
+The host side software follows the standard NTB software architecture in Linux.
+All the existing client side NTB utilities like NTB Transport Client and NTB
+Netdev, NTB Ping Pong Test Client and NTB Tool Test Client can be used with NTB
+function device.
+
+For more information on NTB see
+:doc:`Non-Transparent Bridge <../../driver-api/ntb>`
-- 
2.24.0.rc1

