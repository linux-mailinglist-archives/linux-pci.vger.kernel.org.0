Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09569103230
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 04:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfKTDqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 22:46:01 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:34753
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727695AbfKTDqA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 22:46:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKAlWEWkH3MsXwO0r9fLuRnboYakOqkTpQhSB6AJSoV66gTy1wPuIYBYaiQlpDuA19U1Ywmg7DAtUnj1XH0z0sFxFOkHqvmf0Ja7Zok1AFiWfaANcODOc35B7suordhSzjp+/pT5R0zz62Ff/v06AMYPvknlU9i02JdAvgxgJn/sL+vlG5fM9DWCzgDml30ISwmUQm2NjSJCE0eg9Gjk85K0QYqWAE5HswsPrxowQJ9HW9Y87GbEo+Ug6XaID3VnWydVCXPGu5ICUckxgqGtHDanErc+Af/ELlWEoQJPnXhUhRAhuRO/v7of1hhQ0TC+Lm4bCerPOZfYnytm9Zy7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irUxrJ91vUjvc++H0x9KCLnC8wVeqmY2KZwUu4nyM3M=;
 b=ELj3SXSZwQBjNzHpk8TSVud+kN/RdaEHoqGg10J3hCZ7mWwvlONoKLqV3sfk1FnO2M2bmeDfLxAzzd897TB7AkrrOtY0jQBxKCgYyCN4eG9x5hJaqQIwbq5llx2lvMwmamL316sbGAwbur7CLY1J5nm+Mea8Ux2WWF7foKL0bWrTa5OU/esaL78Mg+VDHmu0u1fjcaZRemSxKtDRTHZJXwN7XSDNijeODIJq/mxY7zPUY/MfgTVwol+N51klX05VtSerRyPTidP3l85emmEyvStSN0LSSjLz71GThgDczdtvg3/VzmS4vHhHipnh02LDXeWKCIzk7UZoTXQxPLGAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irUxrJ91vUjvc++H0x9KCLnC8wVeqmY2KZwUu4nyM3M=;
 b=MIgWMexkERXWJekD/qEV7enwq29pgv3UrYIfkzXTdQ7Hd+npyeEVqhEkwTew+HIAprGo/zQMPTel4WGucOQUrDdYNyynk1Mc4HsURIzgou8NN4eFZkBXlKJo9awu4iP5VThvk1DiGNAq86qwu+FNxBvYZlO4sAJQUmLvKUuATno=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5657.eurprd04.prod.outlook.com (20.179.9.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 03:45:57 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 03:45:57 +0000
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
Subject: [PATCHv9 06/12] PCI: mobiveil: Add callback function for link up
 check
Thread-Topic: [PATCHv9 06/12] PCI: mobiveil: Add callback function for link up
 check
Thread-Index: AQHVn1UEYLWmKTdIpEiL1397xUm0IA==
Date:   Wed, 20 Nov 2019 03:45:57 +0000
Message-ID: <20191120034451.30102-7-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 2de09eb7-1dc6-4518-6710-08d76d6c269e
x-ms-traffictypediagnostic: DB8PR04MB5657:|DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5657C8E66B3CCE85AAB258AB844F0@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(54906003)(86362001)(36756003)(256004)(7736002)(305945005)(6116002)(66066001)(3846002)(110136005)(316002)(71190400001)(7416002)(1076003)(71200400001)(52116002)(2501003)(4326008)(5660300002)(66476007)(476003)(64756008)(66556008)(11346002)(446003)(76176011)(2616005)(66946007)(6512007)(66446008)(8676002)(386003)(6506007)(2906002)(99286004)(102836004)(6486002)(81166006)(81156014)(8936002)(50226002)(186003)(26005)(478600001)(14454004)(486006)(6436002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5657;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHiIvr1qFtacDtCOshqj15NnMQ6Bkr4JOJlJPeNME9Ium0ASDPjhMhsT5nnGeYscODpP5tFLjqHjIBMAKvJXQp0QLxl6xgLl/SAvpMDeXt+sDdMvI18ZR0hI2t4sLst5peNo8KkolgehPgU/8Jp6uBxxD+sixrMDQ/VDKn8jqtks5lBZ0s23MqYZoVgbf/8oOKyJK+p6qai1zhSLbUSXG2jntaBIjbtoRAV6ApEdALC2I0OQqRY9flVYKuBoXNLEq8UybsQre3S1PpGJkRJ9mTyYYGqYFoc0O5hdmRiP9SB0iIBoF1BQQO8Yu85Fio/2gzUypUBNPXzo6JkAchm098MvGGa+rY1BPLU6keU4AS+G7x2eL+URadkBoObDCEF71UQbqIcytD1wVBhPdW4fXEJi7glK3p6cH0TImGRv0dsELNwKdUc9vstUNX4MlA5A
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de09eb7-1dc6-4518-6710-08d76d6c269e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:45:57.0833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tvzEl/jNklY0Io5H4w8PSXhWrTZkDFRGYc31gSNMIr0/qSzA8piMnrMiu8biMUtefvt1gRPd+UxOxHiKD7xxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The platforms, in which the Mobiveil GPEX is integrated,
may have their specific mechanism to check link up status.
This patch is to enable these platforms to implement theirs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V9:
 - New patch splited from the #1 of V8 patches to make it easy to review.

 drivers/pci/controller/mobiveil/pcie-mobiveil.c | 3 +++
 drivers/pci/controller/mobiveil/pcie-mobiveil.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.c
index 2773f823c9ea..b9ed2d95641c 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -125,6 +125,9 @@ void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32=
 val, u32 off,
=20
 bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
 {
+	if (pcie->ops->link_up)
+		return pcie->ops->link_up(pcie);
+
 	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
 		LTSSM_STATUS_L0_MASK) =3D=3D LTSSM_STATUS_L0;
 }
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 18d85806a7fc..95d2e7c809b8 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -148,6 +148,10 @@ struct root_port {
 	struct pci_host_bridge *bridge;
 };
=20
+struct mobiveil_pab_ops {
+	int (*link_up)(struct mobiveil_pcie *pcie);
+};
+
 struct mobiveil_pcie {
 	struct platform_device *pdev;
 	void __iomem *csr_axi_slave_base;	/* root port config base */
@@ -157,6 +161,7 @@ struct mobiveil_pcie {
 	int ppio_wins;
 	int ob_wins_configured;		/* configured outbound windows */
 	int ib_wins_configured;		/* configured inbound windows */
+	const struct mobiveil_pab_ops *ops;
 	struct root_port rp;
 };
=20
--=20
2.17.1

