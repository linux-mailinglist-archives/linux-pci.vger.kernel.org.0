Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAA8B637
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 13:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfHMLEQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 07:04:16 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:15278
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728660AbfHMLEP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 07:04:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYARIjSlnxnCGmSt4+foUp2l8r2fGVVHh829kgHRCGZ7gX8sZ1EaGpeELaPSM4805IqLvmZRML/2+fBNgD31UqT1eDHHcJiQSR6YtGBUKTIoJ25oVllMrhDC1kt0a1ex4zRJLcIZ8L7pUjGMtPyppaWaOJsx3gUh8eCzpJbOeRbUaLDvafUhUhul5k1gxxGt6bwAkMnblJCwQoa2sFYj4cpwQ6coHvBdsXCf863giWTJWbHHwW5wn1SMEBVyAEkmqJC3SeaewyGP3yHNe60FDZXRAprMMUgbTpEMV2svr8nwmOmJgr8eSwioq3lo7dQSIeXYakHl4reFU5W2it2c0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQWV8uTqSYeNroxv7nK8KOa3g2IxfigbdnsDgxPhiC0=;
 b=RjuJ7ZEfRSCaPW/b1VwCeWln5g13a+xh9j16FDvPoITtQIoiPCICx4oWwNZuNIa3W65pPqPcpMDouhZv6PuiZVgLQQE6Dsc7xDPgo4rOG6SMUkzE5mDelSbdbRfz0Lrw+K1HUMt6QgZmss9Yusn9atmFxN8g9UvfiJkDioE4MS/D9oSK+lYRRJ7IkCmyVv3Ic3tKqIErl+toIBEnh8EIM+vo6vrszG2jWIpv3ecgUK8W6K+xxhg99Oyo1RKATT+myFr1O3laZt8go7xN73HkOZbCJdy6xvE/sYP44DbgpjRUlEsFubFTnJ58h3fH45RA1x9nlfoCWAn+1eVBwJGoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQWV8uTqSYeNroxv7nK8KOa3g2IxfigbdnsDgxPhiC0=;
 b=nM2uADlgWqxi+AuwBDo4Q/DtGl6Iw552lcTcXnJRTUPObezEtSMZLJowGtFml0pzU85KY5cNGn/6ruvLX5tns8qc+EyZ4iuFVKjM9amJdNuPV94wGSHR14abFIVYdU9VxpvX+yvZxEAxHzFNl/3Mf6QfGJr6V/vyTlEUJkF2xao=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7035.eurprd04.prod.outlook.com (52.135.61.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Tue, 13 Aug 2019 11:04:04 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Tue, 13 Aug 2019
 11:04:04 +0000
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
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv8 2/7] PCI: mobiveil: Make mobiveil_host_init() can be used to
 re-init host
Thread-Topic: [PATCHv8 2/7] PCI: mobiveil: Make mobiveil_host_init() can be
 used to re-init host
Thread-Index: AQHVUcbSoN4coXHkjE+114stUlWz+A==
Date:   Tue, 13 Aug 2019 11:04:04 +0000
Message-ID: <20190813110557.45643-3-Zhiqiang.Hou@nxp.com>
References: <20190813110557.45643-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190813110557.45643-1-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-correlation-id: 889fa406-0176-4d69-aae8-08d71fddf465
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB7035;
x-ms-traffictypediagnostic: DB8PR04MB7035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7035508DF38D5274A1FA76F784D20@DB8PR04MB7035.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(189003)(199004)(256004)(14444005)(66066001)(50226002)(316002)(4326008)(66556008)(66946007)(1076003)(186003)(64756008)(66476007)(386003)(71190400001)(6486002)(6506007)(26005)(7736002)(71200400001)(110136005)(486006)(305945005)(2501003)(53936002)(54906003)(52116002)(81166006)(6116002)(7416002)(3846002)(25786009)(478600001)(102836004)(36756003)(66446008)(76176011)(5660300002)(14454004)(6512007)(81156014)(446003)(99286004)(11346002)(8936002)(86362001)(2906002)(6436002)(2616005)(2201001)(8676002)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7035;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UoFlPHjw7NBDi3uR+c4RhhvugexQ7YegYOYq7Kkhf5SaVe7j0B31g3FYuSWciLBOOwuhaKyqPtJkQ7VVfTxu5DZi9JxoCqI0O1r3bsS7oEWWHg2dT11phdkSfyzjeaEHh6Q0fKFbCMDfHtf+L0KH3uLwd9Xhq5m1WiqLIkL8NFZSHlXL19RUvaLjpgBgkDBuU0vD+y8otgZjJpn40zMtRdmJIU5wgXL998rd49Ngaycb4vCOsqdriTs+/mth7cjNWMwvtphuOqeKD+qRbKE7hw/v9Lr92BeZ9shLS5hRB026pp3+QAUVBXspAuBAM4VmHx9k9T4/44+QlFw4tdVBon+FMnTORK1WGJqmGYmj0jL2xP5gXaudRuzMGAqQZYZ3TVhja4ZAzO9BxKUnxFMaHFc+AiMGNRG2muyYqQvKqXI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889fa406-0176-4d69-aae8-08d71fddf465
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 11:04:04.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VPoLdirpNJFo8vtzz5wI43vaVsYVOiom8PjShY4W+wgT3hPlhiCEkcRxmsyyR8+uU7LpvZQQPtAxYg5Ad7xGlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Make the mobiveil_host_init() function can be used to re-init
host controller's PAB and GPEX CSR register block, as NXP
integrated Mobiveil IP has to reset and then re-init the PAB
and GPEX CSR registers upon hot-reset.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V8:
 - Re-generate the patch on the new code base.

 .../controller/mobiveil/pcie-mobiveil-host.c  | 43 ++++++++++---------
 .../pci/controller/mobiveil/pcie-mobiveil.h   |  3 +-
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-host.c
index 995487c4f760..775754522363 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -215,16 +215,21 @@ static void mobiveil_pcie_enable_msi(struct mobiveil_=
pcie *pcie)
 	writel_relaxed(1, pcie->apb_csr_base + MSI_ENABLE_OFFSET);
 }
=20
-static int mobiveil_host_init(struct mobiveil_pcie *pcie)
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
 {
 	u32 value, pab_ctrl, type;
 	struct resource_entry *win;
=20
-	/* setup bus numbers */
-	value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
-	value &=3D 0xff000000;
-	value |=3D 0x00ff0100;
-	csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	pcie->ib_wins_configured =3D 0;
+	pcie->ob_wins_configured =3D 0;
+
+	if (!reinit) {
+		/* setup bus numbers */
+		value =3D csr_readl(pcie, PCI_PRIMARY_BUS);
+		value &=3D 0xff000000;
+		value |=3D 0x00ff0100;
+		csr_writel(pcie, value, PCI_PRIMARY_BUS);
+	}
=20
 	/*
 	 * program Bus Master Enable Bit in Command Register in PAB Config
@@ -270,7 +275,7 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry(win, &pcie->resources) {
+	resource_list_for_each_entry(win, pcie->resources) {
 		if (resource_type(win->res) =3D=3D IORESOURCE_MEM) {
 			type =3D MEM_WINDOW_TYPE;
 		} else if (resource_type(win->res) =3D=3D IORESOURCE_IO) {
@@ -541,8 +546,6 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie=
)
 	resource_size_t iobase;
 	int ret;
=20
-	INIT_LIST_HEAD(&pcie->resources);
-
 	ret =3D mobiveil_pcie_parse_dt(pcie);
 	if (ret) {
 		dev_err(dev, "Parsing DT failed, ret: %x\n", ret);
@@ -551,34 +554,35 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pc=
ie)
=20
 	/* parse the host bridge base addresses from the device tree file */
 	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &pcie->resources, &iobase);
+						    &bridge->windows, &iobase);
 	if (ret) {
 		dev_err(dev, "Getting bridge resources failed\n");
 		return ret;
 	}
=20
+	pcie->resources =3D &bridge->windows;
+
 	/*
 	 * configure all inbound and outbound windows and prepare the RC for
 	 * config access
 	 */
-	ret =3D mobiveil_host_init(pcie);
+	ret =3D mobiveil_host_init(pcie, false);
 	if (ret) {
 		dev_err(dev, "Failed to initialize host\n");
-		goto error;
+		return ret;
 	}
=20
 	ret =3D mobiveil_pcie_interrupt_init(pcie);
 	if (ret) {
 		dev_err(dev, "Interrupt init failed\n");
-		goto error;
+		return ret;
 	}
=20
-	ret =3D devm_request_pci_bus_resources(dev, &pcie->resources);
+	ret =3D devm_request_pci_bus_resources(dev, pcie->resources);
 	if (ret)
-		goto error;
+		return ret;
=20
 	/* Initialize bridge */
-	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent =3D dev;
 	bridge->sysdata =3D pcie;
 	bridge->busnr =3D pcie->rp.root_bus_nr;
@@ -589,13 +593,13 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pc=
ie)
 	ret =3D mobiveil_bringup_link(pcie);
 	if (ret) {
 		dev_info(dev, "link bring-up failed\n");
-		goto error;
+		return ret;
 	}
=20
 	/* setup the kernel resources for the newly added PCIe root bus */
 	ret =3D pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		return ret;
=20
 	bus =3D bridge->bus;
=20
@@ -605,7 +609,4 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie=
)
 	pci_bus_add_devices(bus);
=20
 	return 0;
-error:
-	pci_free_resource_list(&pcie->resources);
-	return ret;
 }
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
index 4825e30030cd..4f17a9837fe9 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -153,7 +153,7 @@ struct mobiveil_pab_ops {
=20
 struct mobiveil_pcie {
 	struct platform_device *pdev;
-	struct list_head resources;
+	struct list_head *resources;
 	void __iomem *csr_axi_slave_base;	/* PAB registers base */
 	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
 	void __iomem *apb_csr_base;	/* MSI register base */
@@ -167,6 +167,7 @@ struct mobiveil_pcie {
 };
=20
 int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
+int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit);
 bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
 int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
 void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
--=20
2.17.1

