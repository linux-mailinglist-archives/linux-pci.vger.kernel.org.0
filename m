Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2689602
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 06:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfHLEWU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 00:22:20 -0400
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:41425
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfHLEWU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 00:22:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRVRyClPNyDd8bqcZWYZrwzZ8dMAbs5ZyB6KgUB/og0BiwnhOvxkHv986G3kYHV/EsoeVFFdIYdfYqneMqHLkNoOXICpmknosGV9NmJbAYbgiJGqo4n9qJzGYvh1dNwEE3MxQ6Wkik/u5PJ9snwtUwkLNA8RO6GU/ra8zvgEGOFozBvBshBZFuO4BaJmc/vD8SC5o/sS0qknRiYqtdt7MqIpwcX1uhW7A8Viryj5j3s+i1/xI7NI4j3nrIeIicMRWtX4FqVrA5Jpy6gnMgepPPuQJP5Kb/4vkX1HhBZwjnfU0eAJqcGfF0SLA3uj83WtLUQ2lu3DwILoLiJUhrRdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKR+Bq+eBm7trp5DLBa1GKo6NJwsHMnldT+3tag/Ya4=;
 b=LjdBCk8/C8NwveyxWvULvBvveXF7+aUqN0w4UZHMu4dApdVxVlTj8oVAUOyQcnna2hBZIPlIQP5LXkGtpNATUbi2mEh9eXe1pfTG5BzFLpU3xeB1RlTD+NbMEp5gtqWtN5SIcSFRcK48K/giDfmJiZPgbKKyaH6MJ37RxqIbT1nqly3hIz2EY+y+PytfRJoYa36eDHRk6PBBQnF1EExFKY1O0WbY70EZ6W2mEebfUwpxOqIkdtCIjbzXD0R7RowyyeFMZ7D2vrkODQ9W0N4Sf4/EZECtUV0pcQZU2Y24Z8RENj65FV6MVD0ETZSV8Xhwf/Uca9yvKJG8Ua2/U9FbLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKR+Bq+eBm7trp5DLBa1GKo6NJwsHMnldT+3tag/Ya4=;
 b=IlRoB9lzz7vIjnv7QpuGR8Ffb7HSFTZ0eMK4LChU14gRlaiA8WcVKVQUuGkzzWaV4GEo1DXyTtIQdhNWce4I5FK8+vxA2Cm8eSsGt9fddjjgDaZBLlGeIyyv4xe20EovE3T2K4jTSzCYdEiXvprcDlicpJMCtAWfeSGYNQee5S8=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5931.eurprd04.prod.outlook.com (20.179.11.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Mon, 12 Aug 2019 04:22:12 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Mon, 12 Aug 2019
 04:22:12 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 0/4] Layerscape: Remove num-lanes property from PCIe nodes
Thread-Topic: [PATCH 0/4] Layerscape: Remove num-lanes property from PCIe
 nodes
Thread-Index: AQHVUMWDCaTFip+5o0aBISlIjqAbjA==
Date:   Mon, 12 Aug 2019 04:22:11 +0000
Message-ID: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:203:52::24) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9a45e35-35d6-496a-1d70-08d71edca58d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB5931;
x-ms-traffictypediagnostic: DB8PR04MB5931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5931D1784DDAF6FD4B4AE24D84D30@DB8PR04MB5931.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(6436002)(256004)(25786009)(66476007)(66556008)(66946007)(50226002)(2616005)(476003)(64756008)(186003)(486006)(6486002)(66066001)(66446008)(53936002)(7416002)(71190400001)(6512007)(71200400001)(2501003)(8936002)(4326008)(8676002)(6116002)(3846002)(52116002)(110136005)(54906003)(305945005)(7736002)(1076003)(81166006)(81156014)(86362001)(5660300002)(14454004)(26005)(478600001)(36756003)(2201001)(2906002)(386003)(6506007)(102836004)(99286004)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5931;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EftrESN0ZBFXUwDQImCrXHRWp2MRPKYCmJ9mTpV0qDNsGVwU9MuNuXTTqt6j9Lrr03KrUPj/oJBd0sZjJTS6xPuYpL1bMAQYECeKUaECgTWjNd/UKwOlrWveqeszJqbavx+jfajKuefL4J9NqR9FqhRhNiP+PcjXejgyIXbUjWw0NE5HQfSFRfNTH/jtD/jDvgmQonPz/YmipNLtWIpkGijJXNMmPcB9R4ECSoEUxli5pYxoQY9noGUlpjUQahV4UODAp0WlfacWwEF86DfOZTCz3FfXau1rAP8p1YdlZf0+Wr6F49sFCIJHxQND3iB7NOQdRzzT7Ic6qfvZHpko+l80pY8zP4zZyC35l7at79Dl28cQCfpnP5C/nfgBHFrZ0pjzcbdg3TVa17Fu1CwiClEx9I8mCmGGnfZk7FKrxM4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a45e35-35d6-496a-1d70-08d71edca58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 04:22:11.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xoNSwBt0LH3q4ZZJchHjCGMu/g1q5SJWz6SlaKTW4lx3Q1U+wooDzdH+g//qX0pg0ceqnjc9L1KqVaw+GCrTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5931
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

On FSL Layerscape SoCs, the number of lanes assigned to PCIe
controller is not fixed, it is determined by the selected
SerDes protocol. The current num-lanes indicates the max lanes
PCIe controller can support up to, instead of the lanes assigned
to the PCIe controller. This can result in PCIe link training fail
after hot-reset.

Hou Zhiqiang (4):
  dt-bingings: PCI: Remove the num-lanes from Required properties
  PCI: dwc: Return directly when num-lanes is not found
  ARM: dts: ls1021a: Remove num-lanes property from PCIe nodes
  arm64: dts: fsl: Remove num-lanes property from PCIe nodes

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 1 -
 arch/arm/boot/dts/ls1021a.dtsi                            | 2 --
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi            | 1 -
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi            | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi            | 6 ------
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi            | 3 ---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi            | 4 ----
 drivers/pci/controller/dwc/pcie-designware.c              | 6 ++++--
 8 files changed, 4 insertions(+), 22 deletions(-)

--=20
2.17.1

