Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6958494903
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 09:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiATIDw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 03:03:52 -0500
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:46210 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230116AbiATIDw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 03:03:52 -0500
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K7uNKY010800;
        Thu, 20 Jan 2022 00:03:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to :
 subject : date : message-id : content-transfer-encoding : mime-version :
 content-type; s=com20210415pp;
 bh=YsGnLNUA3rb0Yo+TOXesGgaq2ULszx6UXRYdoF9pqis=;
 b=xI1DLS51MTKtwfv2q5df/CnRKeoszCF37LB4KRrXB+SdIKRPGflrcW30ea04LR07GkXx
 PClcbxxJQ18oBUKri4sA1Xc7oJI8xtIj8HDM5sX185G6APnG0fEdNTtIlWhjayzedKP7
 puO0Ok9+46kBb7MosJ5fTKkzOxHsl0hFj8+LelYIzYfeZTQucRO2FDkRMQLyIJQBZP1m
 GVeuUN/Zu2bKGOIPgcDOrAUXe0p4lXtnhV8WETbORpDBs2p1DKyatXL4kmaaPF9kP/wW
 CIM+FjA1me+YB0UTVv6RvYl5VT+whtIwPGkROAvk3amizv0R0z4zjz5N+EqMDm5JAuZv QQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dpp0gr991-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 00:03:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l95cxxckNTDx0zImZn1K0P1SbyDNjZd254LeZlcQeF3sx2Nx1kufrKoV5YIaJdnnO43OXPKhvVoKL2+GQvtt+gS2lwypX6wSyQ6JO2Har/XB0sKaEOM1+PgpzzsgXLwl1Q/z8my5R2RBxCy1EvI4WwbJxcDbCM6rZiuD7kf2j828dCtJLq3sv4ylxOdKJynnl8whKsnduAxPVR4IGrM7wMLD/6sRWcJ6crQLTbYf+p3k8sHZXwYKAbsYLhfG0wprk3Cy/otjDzctUc6gsimCRqKDbOaLUUQJGmaSjdnCN8RgnKz0jQsxC0H5lp4aWoAWg4wJJfFTk9A8BDM06b55JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWJa+zEk8Shcm7QpNQdHbgho4seW+4nRQmx+yMKXOhQ=;
 b=HKO0ZYfxy2TY0akgnYR4I4QchhrB+FgTlSRjOr/UXD6984R5loqZhYjqBzEMZyPl03K9f/YOM+LU/VyK6jRCwB2Eoc7H2EsXAyEY04g8QbUrxAz1xgBx2U0V+wMz8gDETJDb19OY7dFgDVe56zK7If7eLCcA4wRgDGN0QT/qJIu+WXN+osWrETVJJ8CjkL+OgKm9JFW8sGdvN+ixZN2qFBn3OsE0BRKFOu0R8TPepelfGoxrYOPSxR2FWhMyBhivCSdgGLNLs6m3eA1YdUrUrqQGrk3SZlpeT7Esb9W/oSbkRNtrKDtdsLO239ec5WVyVBstv3oqarRdRyTohIhLvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWJa+zEk8Shcm7QpNQdHbgho4seW+4nRQmx+yMKXOhQ=;
 b=JGw6zrGrHyXxUk/M9kpB5sImvPjg0W/S1lfm4pp6Z38XwAFw+Y/7waJDT8jgxPzXrZJkSaZ0MBgKAN18tveUnMaSYipY6qpsg0c20l3Yz5u1cDEjeQnYoijXhflxut1G8AdulmPRnKPaS3oT3uUs8nc7aiLy+k4kIC4tzuYTuNAmkhmHbRiR8hQW69mkzVUNoqUzV7C0W1P6nP3MwEgfdexIgWXa+s6FMCubQqBXT/HcuFnxIvoy+yPH8zCXzu9VIpiTiRU+Qp2ngPJS2BoRdJtZFt9jGxLNCo3ZklxOCDOrh8SN4ja4SaR/ZIsXGSnlpUolFJ/Nt3jv/L9cPnuHXg==
Received: from SA1PR19MB5572.namprd19.prod.outlook.com (2603:10b6:806:229::8)
 by MN2PR19MB2944.namprd19.prod.outlook.com (2603:10b6:208:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 08:03:18 +0000
Received: from SA1PR19MB5572.namprd19.prod.outlook.com
 ([fe80::2df6:255a:c65f:69db]) by SA1PR19MB5572.namprd19.prod.outlook.com
 ([fe80::2df6:255a:c65f:69db%7]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 08:03:18 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: pci_endpoint_test: simplify endpoint test read and
 write operations
Thread-Topic: [PATCH] misc: pci_endpoint_test: simplify endpoint test read and
 write operations
Thread-Index: AdgN08pRFuc4KG9kQuiq2cd/4nCPdQ==
Date:   Thu, 20 Jan 2022 08:03:17 +0000
Message-ID: <SA1PR19MB5572EAD4025173FA9F3B3937A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e615fac-db10-4e64-2724-08d9dbeb518c
x-ms-traffictypediagnostic: MN2PR19MB2944:EE_
x-microsoft-antispam-prvs: <MN2PR19MB2944DE2AAEE97E5F4CDAAF19A05A9@MN2PR19MB2944.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4J9OUXggmqkjbx/OIhX8WqEIe/df00Ti5v3St2qsWvBL2fD4eKgpMJs8Kf0AwZYRwEby/s/OTHNHOL5AxDoGXesibFJ96Fgxv3NbEUPEzE6EjQRm1Wq8P8IgC/3f7/wbaAe+3sfoPLLuQMisxZelF4Ulku/UrIIO2LcN8Ph0h2oAZdOg1BNVPXsEt66R4aq0G6Oct+ltJ36tzlnA82YqxPbvpXtPKoY6OGODH8FL2lSP7pab/Uf98jEDUUZGKZISqSs4Hwk2nmLdWQz2Ofz+t9FJR1uaZ8Ub1rw5xMG6BHqQ0hF6ZGucJYiKuwxoSBtQqM54xcodsjA48Es/28oGu7/MdDoDLECEWWhSKYod4FNVMX6D5aOGhuPbfVkZm5cGnNTo4DkkURX9ZV+kZz1r6ZkQGOMmcm6M8hbb4B4VGshRIiGrjk1Mdtm3mcp1UOT0sltNRMVh11xwma281XfwoaZ8JWSf4VS2B0u25xvb517COOCFBvm6aoxEjjPi5E0fHENONmqjkG6GmUHQk5uDqwbpBm3ABPyIJ+NAHL22KtaeY6ZwgptidqHWzkPdTvOAdc6AaOLSW8Gg++TYnj6lymSMfcLb/jeQ+cnyS2EpFERUUw8WPrc50s6WZdVDYpdiWYRxlErTYcN+i01ASiWXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5572.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66946007)(316002)(55016003)(9686003)(64756008)(66556008)(66446008)(8936002)(6506007)(52536014)(26005)(33656002)(86362001)(122000001)(83380400001)(88996005)(2906002)(71200400001)(7696005)(8676002)(5660300002)(66476007)(508600001)(38100700002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?jo46YXpJhKxsKWR9nwCHU66TF6QxrlZDDcc3bguKNcHmqfczXnd/pjd1r8?=
 =?iso-8859-2?Q?qqbu4LjIvi6v00CeLPXMoL26oACzEc8Obs57kyIbaJN4wpqoFuaKKy56ra?=
 =?iso-8859-2?Q?ovK5uAlV2O+lwJcjSTiX/qUTqMW+42jM0w23Tma/t4UzihxOCbG/QvlFRG?=
 =?iso-8859-2?Q?Xr7x6XjOztyYdqEp+y2N2uw57tjnBufq3mUF9nyNJlxuy8W+e8ejsJeStQ?=
 =?iso-8859-2?Q?monafgls/8XExemfHEqPCuI7LqBsLg9w96U7cqYujfUmjjzGmRpCOT4BlJ?=
 =?iso-8859-2?Q?MyWJazl+7z/u9yG3CZl1Q4dMwGFpuGUhXktEskM8kloFuux3tZAcoJRhML?=
 =?iso-8859-2?Q?/Q6uHjj8TsXOlzBaW16gIB5w9/Uk8TRPAMH7YFiJGT3EkZrq/K90tVkKcs?=
 =?iso-8859-2?Q?/A0UTCzSGD+UUxEhbTphadjiRExxJ0bmLtJRy++MZY/gyYZf/F4DubMGZ9?=
 =?iso-8859-2?Q?cT2enaVud4Id3Xp0p06CBtdXTihLbGdnQV9jXj/YJTK9810EeVf5uR20eX?=
 =?iso-8859-2?Q?fMXh6KZLcAi77pvokr1LNZqu4kRVP4yMGjDt3CJfNAT7XuOnL/G1k7Ge26?=
 =?iso-8859-2?Q?yzohjvGPV9u1F1vxEoozF5lmYGZS41AwNykLQXOM6nu8lWXq0s2Qhp9WoB?=
 =?iso-8859-2?Q?hkBlb0MeR/Y1N53/Quh2woy6cYCQJO9N7Embjkbk+qWdm8shrh5fCWa62I?=
 =?iso-8859-2?Q?SUhUCtmyaPQzUHDB1zAs0aF3/8HEj8fKFO8Pfus1EZBslum37sdNDYdxcR?=
 =?iso-8859-2?Q?XhtOXFmzidYshVEFMZVuy3dw5spmJ5bEVPeRZlzxtz8U4Ak2TVG3EXSNwB?=
 =?iso-8859-2?Q?uwsbZp8a+WwrgDieAeJ0KUsmc6KYpW9LACb8UBDsX7J2nW8fmLrouDqeVw?=
 =?iso-8859-2?Q?q4BAExy8oj6qkyQY5h5WmYTIZXp5Ih2FYeYWgec4zEYVsJCC+X/Llhm2XW?=
 =?iso-8859-2?Q?88s5glWg+9jjnN3uPEjVIINcO0ub1VCjHQbg/otFIVlnC31sEmBpvhc9xX?=
 =?iso-8859-2?Q?QlKnpGDsUGhU6y0nnG3kJ2sxGsbjB23NvvbZa9x9/31IGnStFS2n1AIL3G?=
 =?iso-8859-2?Q?4YYn3N9XXoOEgBEZdhvOURSp2kNgaKvrGmc4Jz3ObBadE97eg3GPeibGXK?=
 =?iso-8859-2?Q?kdH2e0AUP5ZN8qDuDr2GW7jdkKvCaF5WiKG1tLWp0hKu1cxy8a7g64mXZh?=
 =?iso-8859-2?Q?t9YUukFqm4nbqazp/HISw+9E/zPdCXPLdophS10QDI2wv3SO6pFP26eLx/?=
 =?iso-8859-2?Q?xvLYFNL667QtpsNYA6fKvYPQAPauQoGg0HTe6Qjqf65YlDrZu1g3uql7u3?=
 =?iso-8859-2?Q?vPMwpB5/d0vO+O/+UJAYvj/69ilGieQKm9UHogRtABNEhOumy95yx5/k2r?=
 =?iso-8859-2?Q?lDIq1nfDfzKuBXTJOqkQg6qVj39SFy6POHlAyAATYrpBEepOM4++FQUSMd?=
 =?iso-8859-2?Q?rNlyP9uG9igADtv/nb65Sb2OJptGPURXvhQytfBRxOvqH91OWeRAQzoaZE?=
 =?iso-8859-2?Q?Z+l0oYgVgyJrZHSPe8FogzKX/JXRyH/3/Xr9o6CfUXo8/7XwOS9CKUpgV5?=
 =?iso-8859-2?Q?eCvkIq8XobiSwu7dH738Tr0GLIEQ/wyamzRPdptsJMmbNZIwG3Cbn+lq/b?=
 =?iso-8859-2?Q?JpBw6olM2OjFEOy+G9cIGVjZq4jXye6P6Zai4pY3SkLrwLnhkeRHwBkC9A?=
 =?iso-8859-2?Q?xCid7Uu5VfxT8gwAUcs=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5572.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e615fac-db10-4e64-2724-08d9dbeb518c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 08:03:17.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjxBQI+g3WEDIZ4XXl8KWdT4tRWwz4pNQ2lmymPyQQENJ6zKD7gDEAfgHME9OCm3uZdoa7l+fmnq5qBL6VXAOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2944
X-Proofpoint-GUID: 3L86d8oka5f7st-R-u95PHEGwzwAN2VV
X-Proofpoint-ORIG-GUID: 3L86d8oka5f7st-R-u95PHEGwzwAN2VV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_03,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200042
Content-Type: text/plain; charset="iso-8859-2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce pci_endpoint_epf_transfer_data to simplify
read and write operations.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/misc/pci_endpoint_test.c | 288 ++++++++++++-------------------
 1 file changed, 108 insertions(+), 180 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_t=
est.c
index 2ed7e3aaff3a8..55ae2f1851a13 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -103,6 +103,11 @@ enum pci_barno {
 	BAR_5,
 };
=20
+enum operation {
+	EPF_READ,
+	EPF_WRITE,
+};
+
 struct pci_endpoint_test {
 	struct pci_dev	*pdev;
 	void __iomem	*base;
@@ -142,6 +147,107 @@ static inline u32 pci_endpoint_test_bar_readl(struct =
pci_endpoint_test *test,
 {
 	return readl(test->bar[bar] + offset);
 }
+static bool pci_endpoint_test_transfer_data(struct pci_endpoint_test *test,
+				unsigned long arg, const enum operation operation)
+{
+	struct pci_endpoint_test_xfer_param param;
+	bool ret =3D false;
+	u32 flags =3D 0;
+	bool use_dma;
+	void *addr;
+	dma_addr_t phys_addr;
+	struct pci_dev *pdev =3D test->pdev;
+	struct device *dev =3D &pdev->dev;
+	void *orig_addr;
+	dma_addr_t orig_phys_addr;
+	size_t offset;
+	size_t alignment =3D test->alignment;
+	int irq_type =3D test->irq_type;
+	size_t size;
+	int err;
+
+	err =3D copy_from_user(&param, (void __user *)arg, sizeof(param));
+	if (err !=3D 0) {
+		dev_err(dev, "Failed to get transfer param\n");
+		return false;
+	}
+
+	size =3D param.size;
+	if (size > SIZE_MAX - alignment)
+		goto err;
+
+	use_dma =3D !!(param.flags & PCITEST_FLAGS_USE_DMA);
+	if (use_dma)
+		flags |=3D FLAG_USE_DMA;
+
+	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		goto err;
+	}
+
+	orig_addr =3D kzalloc(size + alignment, GFP_KERNEL);
+	if (!orig_addr)
+		goto err;
+
+	get_random_bytes(orig_addr, size + alignment);
+
+	orig_phys_addr =3D dma_map_single(dev, orig_addr, size + alignment,
+					operation =3D=3D EPF_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, orig_phys_addr)) {
+		dev_err(dev, "failed to map source buffer address\n");
+		goto err_phys_addr;
+	}
+
+	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
+		phys_addr =3D PTR_ALIGN(orig_phys_addr, alignment);
+		offset =3D phys_addr - orig_phys_addr;
+		addr =3D orig_addr + offset;
+	} else {
+		phys_addr =3D orig_phys_addr;
+		addr =3D orig_addr;
+	}
+
+	if (operation =3D=3D EPF_WRITE) {
+
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
+				 crc32_le(~0, addr, size));
+
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
+								lower_32_bits(phys_addr));
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
+								upper_32_bits(phys_addr));
+	} else {
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
+								lower_32_bits(phys_addr));
+		pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
+								upper_32_bits(phys_addr));
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	// if we ask rc to write to ep, then ep should do read operation, and vic=
e versa.
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 operation =3D=3D EPF_WRITE ? COMMAND_READ : COMMAND_WRITE);
+
+	wait_for_completion(&test->irq_raised);
+
+	dma_unmap_single(dev, orig_phys_addr, size + alignment,
+					 operation =3D=3D EPF_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	if (operation =3D=3D WRITE)
+		ret =3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS) & STATUS=
_READ_SUCCESS;
+	else
+		ret =3D crc32_le(~0, addr, size) =3D=3D pci_endpoint_test_readl(test, PC=
I_ENDPOINT_TEST_CHECKSUM);
+
+err_phys_addr:
+	kfree(orig_addr);
+
+err:
+	return ret;
+}
=20
 static inline void pci_endpoint_test_bar_writel(struct pci_endpoint_test *=
test,
 						int bar, u32 offset, u32 value)
@@ -473,191 +579,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoi=
nt_test *test,
 static bool pci_endpoint_test_write(struct pci_endpoint_test *test,
 				    unsigned long arg)
 {
-	struct pci_endpoint_test_xfer_param param;
-	bool ret =3D false;
-	u32 flags =3D 0;
-	bool use_dma;
-	u32 reg;
-	void *addr;
-	dma_addr_t phys_addr;
-	struct pci_dev *pdev =3D test->pdev;
-	struct device *dev =3D &pdev->dev;
-	void *orig_addr;
-	dma_addr_t orig_phys_addr;
-	size_t offset;
-	size_t alignment =3D test->alignment;
-	int irq_type =3D test->irq_type;
-	size_t size;
-	u32 crc32;
-	int err;
-
-	err =3D copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err !=3D 0) {
-		dev_err(dev, "Failed to get transfer param\n");
-		return false;
-	}
-
-	size =3D param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
-
-	use_dma =3D !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
-		flags |=3D FLAG_USE_DMA;
-
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
-	}
-
-	orig_addr =3D kzalloc(size + alignment, GFP_KERNEL);
-	if (!orig_addr) {
-		dev_err(dev, "Failed to allocate address\n");
-		ret =3D false;
-		goto err;
-	}
-
-	get_random_bytes(orig_addr, size + alignment);
-
-	orig_phys_addr =3D dma_map_single(dev, orig_addr, size + alignment,
-					DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
-		dev_err(dev, "failed to map source buffer address\n");
-		ret =3D false;
-		goto err_phys_addr;
-	}
-
-	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
-		phys_addr =3D  PTR_ALIGN(orig_phys_addr, alignment);
-		offset =3D phys_addr - orig_phys_addr;
-		addr =3D orig_addr + offset;
-	} else {
-		phys_addr =3D orig_phys_addr;
-		addr =3D orig_addr;
-	}
-
-	crc32 =3D crc32_le(~0, addr, size);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
-				 crc32);
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
-				 lower_32_bits(phys_addr));
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
-				 upper_32_bits(phys_addr));
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_READ);
-
-	wait_for_completion(&test->irq_raised);
-
-	reg =3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
-	if (reg & STATUS_READ_SUCCESS)
-		ret =3D true;
-
-	dma_unmap_single(dev, orig_phys_addr, size + alignment,
-			 DMA_TO_DEVICE);
-
-err_phys_addr:
-	kfree(orig_addr);
-
-err:
-	return ret;
+	return pci_endpoint_test_transfer_data(test, arg, EPF_WRITE);
 }
=20
 static bool pci_endpoint_test_read(struct pci_endpoint_test *test,
 				   unsigned long arg)
 {
-	struct pci_endpoint_test_xfer_param param;
-	bool ret =3D false;
-	u32 flags =3D 0;
-	bool use_dma;
-	size_t size;
-	void *addr;
-	dma_addr_t phys_addr;
-	struct pci_dev *pdev =3D test->pdev;
-	struct device *dev =3D &pdev->dev;
-	void *orig_addr;
-	dma_addr_t orig_phys_addr;
-	size_t offset;
-	size_t alignment =3D test->alignment;
-	int irq_type =3D test->irq_type;
-	u32 crc32;
-	int err;
-
-	err =3D copy_from_user(&param, (void __user *)arg, sizeof(param));
-	if (err) {
-		dev_err(dev, "Failed to get transfer param\n");
-		return false;
-	}
-
-	size =3D param.size;
-	if (size > SIZE_MAX - alignment)
-		goto err;
-
-	use_dma =3D !!(param.flags & PCITEST_FLAGS_USE_DMA);
-	if (use_dma)
-		flags |=3D FLAG_USE_DMA;
-
-	if (irq_type < IRQ_TYPE_LEGACY || irq_type > IRQ_TYPE_MSIX) {
-		dev_err(dev, "Invalid IRQ type option\n");
-		goto err;
-	}
-
-	orig_addr =3D kzalloc(size + alignment, GFP_KERNEL);
-	if (!orig_addr) {
-		dev_err(dev, "Failed to allocate destination address\n");
-		ret =3D false;
-		goto err;
-	}
-
-	orig_phys_addr =3D dma_map_single(dev, orig_addr, size + alignment,
-					DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, orig_phys_addr)) {
-		dev_err(dev, "failed to map source buffer address\n");
-		ret =3D false;
-		goto err_phys_addr;
-	}
-
-	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
-		phys_addr =3D PTR_ALIGN(orig_phys_addr, alignment);
-		offset =3D phys_addr - orig_phys_addr;
-		addr =3D orig_addr + offset;
-	} else {
-		phys_addr =3D orig_phys_addr;
-		addr =3D orig_addr;
-	}
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
-				 lower_32_bits(phys_addr));
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
-				 upper_32_bits(phys_addr));
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
-
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_FLAGS, flags);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
-	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_WRITE);
-
-	wait_for_completion(&test->irq_raised);
-
-	dma_unmap_single(dev, orig_phys_addr, size + alignment,
-			 DMA_FROM_DEVICE);
-
-	crc32 =3D crc32_le(~0, addr, size);
-	if (crc32 =3D=3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM=
))
-		ret =3D true;
-
-err_phys_addr:
-	kfree(orig_addr);
-err:
-	return ret;
+	return pci_endpoint_test_transfer_data(test, arg, EPF_READ);
 }
=20
 static bool pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
--=20
2.34.1

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
