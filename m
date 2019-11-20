Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222C5103237
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 04:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfKTDqp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 22:46:45 -0500
Received: from mail-eopbgr10064.outbound.protection.outlook.com ([40.107.1.64]:27138
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727362AbfKTDqp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 22:46:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5nhIIXcc4LIHsGYMVKVtlm25PR8diBgF1IhXC9kK0JGOr7emJ4Je4A2MnHd/l485btMNpduYpe7XQDpGK/ZET6t/HbI/7DfZ7DDodfhxO8zvDv3sHbD9Ga5hS8G1lsrDYKGgcGpWQLEWrcXpjwB+Zg+hnOSpDZVVNCQmcA0XWhMyztTnZR5+JG+Q8P5voMtDXR2CByw0xExnh4jJxXHsn2o9OmX2Mr6Gaq/ST3+4r2hqto4HUAhiiJqbikqKcTJX+mXqep6t8m2//k6i2azGS7wJUMqtVjG7h0Tn3pQ7VJRkhG9IeTFEV1IDkK/aSESXn7v6MbveU47pV8aUqLwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvECcNdsNP8ZxLYSQY4khzYzlK5B0ouWjp4ZsyQVMWE=;
 b=c3SdO/X6zR3Fko1Gr3GwSeGLn5aJn/Q+eYKSH0rw/MWRTaBqTxuI9jQk18O2Q2WBlRq9wmrLCr+72XEKfIXJxoII0aJDJ5qXX9pgEhC6C6P42b5SaIE0yQqtXekXvgYaMHHF6sbxZq0xHodv3xi85zd8fPExvnfML0v5heTUB25NjeFkKfjbRJPSLfoxW6d5x/kiMZn0luGHhj0lJJi+UcFdfxUBv6Ypkj459qo+xHQR5EzJ7FatNNveq8mUxCe2/ggwCsginzeyvWzqIJFCF77RjDhMdJdZ1OHn7ZGe4PQiAl+OO310xUQqWOymAzgNQg6ZQ5+lvpjNNAbSQHzTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvECcNdsNP8ZxLYSQY4khzYzlK5B0ouWjp4ZsyQVMWE=;
 b=KooYPAYl6PpYVNNjld6/PNJJlf2kLBh3un8SWTTLajGealHr7KYY1sk8a492KNQU1j6aijhr+VGdSIk1MymgqfifyySr9IHBzVmIEdgfZHJQ+FzQl2vySLgD0lCsf3rutI3HqFnVnVh9THbx4Cq/oXI4mkZdXj02sQdorhYyqSo=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5740.eurprd04.prod.outlook.com (20.179.9.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Wed, 20 Nov 2019 03:46:37 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 03:46:37 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv9 12/12] arm64: defconfig: Enable CONFIG_PCIE_LAYERSCAPE_GEN4
Thread-Topic: [PATCHv9 12/12] arm64: defconfig: Enable
 CONFIG_PCIE_LAYERSCAPE_GEN4
Thread-Index: AQHVn1Uc4M4RucFezkSHTTtL1plrKw==
Date:   Wed, 20 Nov 2019 03:46:37 +0000
Message-ID: <20191120034451.30102-13-Zhiqiang.Hou@nxp.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5777c186-826b-4758-d6db-08d76d6c3e7a
x-ms-traffictypediagnostic: DB8PR04MB5740:|DB8PR04MB5740:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5740FD1F6D73666FB6F571A3844F0@DB8PR04MB5740.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(189003)(199004)(8936002)(305945005)(102836004)(71190400001)(71200400001)(76176011)(386003)(14454004)(478600001)(66946007)(66446008)(99286004)(66556008)(64756008)(446003)(2906002)(2616005)(66476007)(11346002)(36756003)(52116002)(6506007)(7416002)(6512007)(186003)(256004)(26005)(6436002)(6486002)(4326008)(110136005)(8676002)(316002)(6116002)(66066001)(2201001)(25786009)(4744005)(486006)(3846002)(1076003)(7736002)(5660300002)(81166006)(81156014)(50226002)(86362001)(476003)(2501003)(54906003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5740;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aiVbzQqlrFdyuxHzzTMiwP1AMPxeLmNYZEfJRR9YYSJRsl3Yb5YS2NtLERE+si728BlNK9js1pmozSv2z6FF4iO96t4bGMJv+yd4olMBO+h9HIa/ZfOSTT3P/wFIiXJrhKkL52GAf5u+Lv/PVnfpnn7zJl4TzeeG7xNRKf2fK+xLfva5iBch9UwJ01EQCjCJrMj8A0WOmp95V+xGB/G02Aj3WBG6BKUgbMzpJiJ3qMyEdHismk7/Wf0eXtk484RdVkkIC3BzTIINgk+6nYlHlHpP60XuMJvC7cncHv/3qPFzEjyslvWgzji3S/FWMq+qavWUnJDSHQKeqeMBt9H2Qh1JfTCjGG3zXkTcX9yBJQdCn2njOVcFkcaww0v9vYsVOpu7TIEA4dTNIsV6WLe8YVeuDswuUGMkV6YSMypU1t1kNmvx/LO4cbHj8VZu225+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5777c186-826b-4758-d6db-08d76d6c3e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:46:37.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAvMzeWFzRvOAoTeCI4EuyrEhPt8RKMYxaTxUaoGA9VvU6uPVn4hNXbSf3Q2z9ncbBAOgWP+Yg1o/esjlPGnog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5740
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Enable the PCIe Gen4 controller driver for Layerscape SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V9:
 - No change

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7fa92defb964..0e51207b5ed5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -199,6 +199,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=3Dy
 CONFIG_PCI_HOST_THUNDER_ECAM=3Dy
 CONFIG_PCIE_ROCKCHIP_HOST=3Dm
 CONFIG_PCI_LAYERSCAPE=3Dy
+CONFIG_PCIE_LAYERSCAPE_GEN4=3Dy
 CONFIG_PCI_HISI=3Dy
 CONFIG_PCIE_QCOM=3Dy
 CONFIG_PCIE_ARMADA_8K=3Dy
--=20
2.17.1

