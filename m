Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81B15B81C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgBMEJo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:09:44 -0500
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:18305
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729555AbgBMEJn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:09:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr+IRcZ4RxPr0YmQwdKIOBmCmu1DXqG7X38Hr/eazSnnylboI/UX3kKAK4gNAz09+zp3/aP9TCt4t4r/WpGghaXSYzDgIDNFb/bAQ7XLxWUgRkdAl2XrUPcUQtD3lmGTHpFvh8ZgxXqzaLEXoF7yuPq82VE2XwwKEt53Pd5lKj7QZ9fj+6lT50NVgftaRGbOwj/Y9Ak+1Zh6HqC2aNn+7er9jIa3+dvxzSvhFQefgzCApcS1KRXDZRtmyV3BaoeLToaUQxkEBSAXGlUMwoAqsqHDIswbRE/xnVPuskBfID1/EZZXO3OCWr69K9Vhcj0dJGVmEPw5vzDyoLeBv0cPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4Hh0QblikEoU7VGAmR1c9Kd4Ow2pfg5W6cYvypFkew=;
 b=GrK5pYavFbB+00dYvCofYFm4lrTlO+SX9w15al7uW/szWutNXJUahKCBSj21OHSMy7E1TFzea/0v5ZHICVqswqBCW23Wg8FETFF321qeq7BYFlNijRXKHZ99Gyh2tP3+da7dS62+8Bv4sdn1fg4SHQddSCc8IhKte0b3zG8EvhSprETJtZ3E2NuBMONCoAEJlqWa1g9lw2+zfSozhewb3n1cz4EYQO6WQZNsCmIuEZT5bfGk3+LYUiWCtEeet4iDgLfrvStDcVtEbfkDshFzj0Owx8V0l/WmS15YV2UMhIUx6nCh4Ot3MEC+b1kVBqrN7u5ZbMd5AcxRgyq3Eat14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4Hh0QblikEoU7VGAmR1c9Kd4Ow2pfg5W6cYvypFkew=;
 b=bbANXkpT5JwqBTp/oAgILIJUxZCTG0p39Ub9ffvDMwR+d7YjYbbswUvDXp2WhdvWW+Oc0uIfohMr9ctYLqFXWZiEf3oKpwomQ5wMAXn3tIW391lYNFuspQLKTbE2W8ae4NdS2Dy0+F9kzA0Ef0r3FSW5OWiBviFWnpamAskBH2A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:09:40 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:09:40 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 00/13] PCI: Recode Mobiveil driver and add PCIe Gen4 driver for NXP Layerscape SoCs
Date:   Thu, 13 Feb 2020 12:06:31 +0800
Message-Id: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:09:34 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 906d8492-fe66-4721-f325-08d7b03a8bee
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7084C7AFAAC5E5615B860962841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(81156014)(8676002)(81166006)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xemg9WW0zFbq38cOO8ZUUMoKd6YY8O1z53f/q1hyv3T1BaUkOzzsk9ZzaNj8Pc/4bFuI+9LacfSWSTlwZBDZ22HhTmLTNhPHREi2DwpV04bXCFXB6hT/17rYouBHeDpzv3g0TK6U4EvJVxfDMyYJEPREeeqdwDCPBpZWHA39ANteDuby/9oLCvaZ6y7EIBC1bWHfhJ0guJCkFZ2JNJTAVs6rXY1FvHcx2jdDjpHycmPAYt1MZLonT+rrDS6MbA4wwUAkNphs1YJ0cdKz7+XanIhu1zphW10e+pyCFIVwBby6fep13eEwyrS7m1jiaG6q1JcgTy61xMmr9VxkizjwLuEkdPp3jc0HThlHGz/iZIW0SjHgmTNiUpVJ1f+ynIK+qXN6PHfJdCTzZJ1JSLIoV/GPSNqKYORenDOltvSOc1/J/OBN6sKJX7HXzSIW0izis54PPz8cuosBaF5YqpkRGLctZC1jwzITIJPUCzcO3r1zW30Zt9U4Jz0fVgXXYhd
X-MS-Exchange-AntiSpam-MessageData: pvfklXitTc7g1Nswv4vC+5PATpq28c3BSv8x0gouKNbdwwzr4yEn1sDBt+fHqAAb62aUeGnQZV0ayX8nv8gVAnEIpy0Dd1cU+/1kvdVF9qsgucEayAzPMgti12gFJQ+CE8fSBp1Wnhr5TEacz/ojkg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906d8492-fe66-4721-f325-08d7b03a8bee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:09:40.1947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+Asztjl9owD1xPEwxHkAP0HsiUpjApoEgb98AdL0BURl3izIfHzvBZ4M5FCf1BKepWzKPSSNUhl1QyH10k+iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch set is to recode the Mobiveil driver and add
PCIe support for NXP Layerscape series SoCs integrated
Mobiveil's PCIe Gen4 controller.

Hou Zhiqiang (13):
  PCI: mobiveil: Introduce a new structure mobiveil_root_port
  PCI: mobiveil: Move the host initialization into a function
  PCI: mobiveil: Collect the interrupt related operations into a
    function
  PCI: mobiveil: Modularize the Mobiveil PCIe Host Bridge IP driver
  PCI: mobiveil: Add callback function for interrupt initialization
  PCI: mobiveil: Add callback function for link up check
  PCI: mobiveil: Allow mobiveil_host_init() to be used to re-init host
  PCI: mobiveil: Add 8-bit and 16-bit CSR register accessors
  PCI: mobiveil: Add Header Type field check
  dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4 controller
  PCI: mobiveil: Add PCIe Gen4 RC driver for NXP Layerscape SoCs
  arm64: dts: lx2160a: Add PCIe controller DT nodes
  arm64: defconfig: Enable CONFIG_PCIE_LAYERSCAPE_GEN4

 .../bindings/pci/layerscape-pcie-gen4.txt     |  52 ++
 MAINTAINERS                                   |  10 +-
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 +++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/pci/controller/Kconfig                |  11 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/mobiveil/Kconfig       |  33 +
 drivers/pci/controller/mobiveil/Makefile      |   5 +
 .../mobiveil/pcie-layerscape-gen4.c           | 267 +++++++++
 .../pcie-mobiveil-host.c}                     | 564 ++++--------------
 .../controller/mobiveil/pcie-mobiveil-plat.c  |  61 ++
 .../pci/controller/mobiveil/pcie-mobiveil.c   | 230 +++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   | 226 +++++++
 13 files changed, 1170 insertions(+), 455 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 create mode 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 rename drivers/pci/controller/{pcie-mobiveil.c => mobiveil/pcie-mobiveil-host.c} (54%)
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h

-- 
2.17.1

