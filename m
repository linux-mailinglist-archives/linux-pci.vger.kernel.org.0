Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAE103244
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 04:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfKTDq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 22:46:58 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:17604
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727518AbfKTDq6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 22:46:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIwfrMgMEQgRpGK0VeIFiSMzAQDvJ4mv7WVwmoB3iRb3877OrYdUjdN99rv9gI2PPKdJPgA/UGB2WtKQRxGV6Y3OleQWBd7dqoerriMGGoUSCfnu45oyqKFWBv8CekFlmRWtibbQjGP760lpqXkATtAwymOtd9TWaaabf9DmPru+5JbUB5ybZthLTg+vnipkuPb4PAFx6wzkeAesjiX/Q5YsiyzNJffu7stSyOxtn1cH43d0/rtgSyJGS8R1/YodTdrrz2QNSPvLQv1Zm6HQOs6kcCQ7+Y/aEm6v+AvUTJ16e8DLX/A6ZMVMdJAHPU2+qXAfq2amMAHSc1bRO5SbiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zphJDwe9+zv4TeGT11iRMz4oU4/XEu7IF8op8dkKql4=;
 b=mDHR1QrU6INuG+9++D7DieT+JH3bsSNjEj75VPpZq/nFow7wmToo26/ZwIlWTi9rZMaCt6PnNpOFvFugD32mcZc6cG6WJ8MndBd2dOVqAJLH2qRgQ7mC8Ah1l08y50VfUyVYq1lhjeqsXKIwd9rvJketpY8HW/xE64KJqazNL5vAL11ZkL2/ajn9aUTqH6eVfvephDIkz5Z4lFnPYrOUADoGptTGqbqIzvd8lOWVeGPnJFq9cDWeOgJU7d/qpbpYLzMxUSgeEkqAAj+GGegdzOp8Fr12PtcA2Umz2V5kfCL5D6NgCcyFrlTeeRo6vNEspcD4nmrgieaKmyvpk2efhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zphJDwe9+zv4TeGT11iRMz4oU4/XEu7IF8op8dkKql4=;
 b=PDS2lG8bhi+SX/2khTaxRUOmJKhS2eg+rHfXsvrhNDNqmBmBdbZS4Bv8fOmLswVvcdOd9vhxY5L8OIB95lYHFIcXQGe0OeXImJNi+gj0RKlLfDdgJOXt5uUaay3YOwU/HL+7ub0Je912HwVKtTUQyvNWCMVNej2XYIay4zYGW0E=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5657.eurprd04.prod.outlook.com (20.179.9.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 03:46:10 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 03:46:10 +0000
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
Subject: [PATCHv9 08/12] PCI: mobiveil: Add 8-bit and 16-bit CSR register
 accessors
Thread-Topic: [PATCHv9 08/12] PCI: mobiveil: Add 8-bit and 16-bit CSR register
 accessors
Thread-Index: AQHVn1UM/CwMe5ZZnEiSNfgmt9Cx/g==
Date:   Wed, 20 Nov 2019 03:46:10 +0000
Message-ID: <20191120034451.30102-9-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 1614a5f6-fe1e-4004-ec94-08d76d6c2e87
x-ms-traffictypediagnostic: DB8PR04MB5657:|DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB56577810EBA278E35FC1E4F4844F0@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(54906003)(86362001)(36756003)(256004)(7736002)(305945005)(6116002)(66066001)(3846002)(110136005)(316002)(71190400001)(7416002)(1076003)(71200400001)(52116002)(2501003)(4326008)(5660300002)(66476007)(476003)(64756008)(66556008)(11346002)(446003)(76176011)(2616005)(66946007)(6512007)(66446008)(8676002)(386003)(6506007)(2906002)(99286004)(102836004)(6486002)(81166006)(81156014)(8936002)(50226002)(186003)(26005)(478600001)(14454004)(486006)(6436002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5657;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSeXNm9s2KhTOWf7hIg/nxTjHF/fwje3E8i4wCAFqDASQLq/nYeNiWWBqEfDVOxF6GZZDerXTyxCQO9O+8Hv0Mrrt79Pf+8gBuKMhp3p1ZKXoXTTeSTNjuI9XbCl60x3grDizqgwQLFHnfHa73WPRF2PD80qcFSQnVWVljijsu6DyZU2xw/OUKtNXBafuFCI7i3Q5RGl/TKbl3d4TXuFx2ZnLox4AlreDYFk6yPPS6u5LuPZflXhYVPMyEu3lfjVkPhiL1lOMCGCEJEdFDKItuuXZ1/P5LQipX2ONPjLrLSfKhZ57WvKP1SIksrEbD/nHtzHVqchCMiWlnCFO1HMmTsCduUG044YZaohIgWbV0xtyj2PDjYb/CAPJT+jUhDjWAZzK0srRYCvj6EwaBvuaT4kx66veozUF5gCD4DCtR+l0Qf82QyOkrdtMXT+mFoj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1614a5f6-fe1e-4004-ec94-08d76d6c2e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:46:10.4677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UomE1xHoP1bhmFwYLtAYl/KiPnvWGuYeiTqCui13vrS4nTegP0H9PzCN+oyQEWYaFUk+3GIlewUwmndRSQM9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

There are some 8-bit and 16-bit registers in PCIe configuration
space, so add these accessors accordingly.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V9:
 - No change

 .../pci/controller/mobiveil/pcie-mobiveil.h   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 37116c2a19fe..750a7fd95bc1 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -182,10 +182,33 @@ static inline u32 mobiveil_csr_readl(struct mobiveil_=
pcie *pcie, u32 off)
 	return mobiveil_csr_read(pcie, off, 0x4);
 }
=20
+static inline u32 mobiveil_csr_readw(struct mobiveil_pcie *pcie, u32 off)
+{
+	return mobiveil_csr_read(pcie, off, 0x2);
+}
+
+static inline u32 mobiveil_csr_readb(struct mobiveil_pcie *pcie, u32 off)
+{
+	return mobiveil_csr_read(pcie, off, 0x1);
+}
+
+
 static inline void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val=
,
 				       u32 off)
 {
 	mobiveil_csr_write(pcie, val, off, 0x4);
 }
=20
+static inline void mobiveil_csr_writew(struct mobiveil_pcie *pcie, u32 val=
,
+				       u32 off)
+{
+	mobiveil_csr_write(pcie, val, off, 0x2);
+}
+
+static inline void mobiveil_csr_writeb(struct mobiveil_pcie *pcie, u32 val=
,
+				       u32 off)
+{
+	mobiveil_csr_write(pcie, val, off, 0x1);
+}
+
 #endif /* _PCIE_MOBIVEIL_H */
--=20
2.17.1

