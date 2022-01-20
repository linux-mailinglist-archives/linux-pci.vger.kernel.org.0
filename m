Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8081D49492D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 09:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359030AbiATINO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 03:13:14 -0500
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:10238 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358401AbiATINO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 03:13:14 -0500
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K7JNaU004546;
        Thu, 20 Jan 2022 00:13:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to :
 subject : date : message-id : content-transfer-encoding : mime-version :
 content-type; s=com20210415pp;
 bh=a3O1xpVh36t9eMam4ssvT9Ni1gMWrfRgytp6aZJW8fc=;
 b=L0GaCgyra9PCpwy6b6+RqSyAVBJHsAdszpAo97bi0D/p4nEXSJt9kSwIeqvlzuXNaDOc
 gGZa+sOZfj5mlUi202PijR0Nt0nFE0ofYurqdzKULzOMFaDvSgHzCOd1o3BCrzzQPT76
 5jDyWkAwwt+VMO+m/OaBli3Ir6HOUaZSIFich2pOS9j3L75+F+RaGrdYBIm3//03T290
 6jPcAfdew/ia2ibCBgaQeOWU2d5SRFr4XWarF3QYYohTqW9pzw0I1VkYG/ZVewpjGqnE
 8tp0B83AZQktbnFQgx/Dex3OiZTIqtbMDpPNlC5P9Dg8tmGoJcMYYUvFaKE3aFxodrke IA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dpp0gr9bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 00:13:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xcikrr62IVGd/bU2DRn5Fq1Jarfr5bs1tnfpWGl/3m63GWVqaQIQGJ5nJLAoWs2X+EHjBNR+HoeAI+PMHpKnyHKO1T3EJ+hbMmHHRamHh6P6tmp9SFqBT4v5xt82Y/vjZccIIRFofVSeja0ky2obzBbjtuCtARCZHG4uo2+tstDXytLP5ByNIUBBCngqkFw91DEvJ5LHjXtG9Ey2kXpfZRWIPuvGq6AphiKkJA5iN+CQQzF2jE6V/PbtuFYprzWwDRJf49uxTB2goxX7hdt0MakMpROtNmnvxQvAlDnZ76xqR1ol9Odm+lps2a+/ycWQZLlkUCvhoqtdTw7l0TI1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+MqkHOtflAs9/Y2a4adcbCO/ravZbh/ZjHgsferh+w=;
 b=h2AoHtYvWO/VFbHyknqJOuTKJJoKth53BcSkefvq6aAXNuPNVtE9BC9wWMexYSSb7xTKgcPhUmWoHMOMziaswoFTfr7VKXzaJgV2kIk/BvZ3deEh1wp7m28stDefaivGN40UlOAqA3p+55XjFXd5wwIuay5d6IN0426BS3c9JFPXFNNMFntph8V6YVz8xX1Hsu9UZl08mNW+I9Xqa4lgAy8V7OrCu6nHTmw4RevezDmSHu3Z4mDNHN7ENJtYqIfeY/ezggJwO1bGMK9qi1U7jSPC7dmwGIB+SZcb9gk0ajEFQ+WEmTiiTwnkk5a/n99Buorim7XekDVYdR59PNCd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+MqkHOtflAs9/Y2a4adcbCO/ravZbh/ZjHgsferh+w=;
 b=ZmOytHrILLGEoeaRZZjf/yeADZMMS+gFgVgnaSXlSzPV3BJdm8Ui8tVP5DGS7m4i0T59yUi5qdraU+6jVaDaF+4iqiq6K9mZshtSSYcq6oomEIxSJ1M6g8Cggu8DAtMRpGVo2N6QBbuvhLEc7uN9P8TS2uK6XnRLIiS+rzvH7ZnPpJMV4qn4zKaKqY4atf0gjhDgtQVVY03oQ/nilNUfTgJA4c7qF7HsfO4FS7fAKUyTEFPp4rNuuAsi3oKjYokGMpltm8cX6hvQXdzx+KNBrp8yPzt92G94unbBWlWGfl6+DptUtBy6OmInw+Z0eZHLARLBeHXyGPQRRxz8FPVNUw==
Received: from SA1PR19MB5572.namprd19.prod.outlook.com (2603:10b6:806:229::8)
 by SN4PR19MB5469.namprd19.prod.outlook.com (2603:10b6:806:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Thu, 20 Jan
 2022 08:12:59 +0000
Received: from SA1PR19MB5572.namprd19.prod.outlook.com
 ([fe80::2df6:255a:c65f:69db]) by SA1PR19MB5572.namprd19.prod.outlook.com
 ([fe80::2df6:255a:c65f:69db%7]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 08:12:59 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] misc: pci_endpoint_test: simplify endpoint test read and
 write operations
Thread-Topic: [PATCH V2] misc: pci_endpoint_test: simplify endpoint test read
 and write operations
Thread-Index: AdgN1YJSBLU9hgDcRtau2ZYVLup/Hw==
Date:   Thu, 20 Jan 2022 08:12:59 +0000
Message-ID: <SA1PR19MB5572E83712B72A4E89EAD9C7A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceb8d138-c6a8-43cf-1e87-08d9dbecac23
x-ms-traffictypediagnostic: SN4PR19MB5469:EE_
x-microsoft-antispam-prvs: <SN4PR19MB5469A3A0FCAFB51399CF1DF3A05A9@SN4PR19MB5469.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GulfL7V5w9bk4CgYXTV1WmrSMv+c92ZfClIUCyqckaKwKMqAaxEJjmp3VXoyt2m0DrN+69q00QVXyHAW38kIR9ps4R/+EFU5xy/MVsd5AwJmOKKiwUAAKhyBr9d/Bjf964arXarR0VjNKGIhS+xKLxyDMkWxxHOdLR6px+r95sAZBoIt9jvl1CO8otGWXFS++VM8yFyrA3wTDz8EOhuGrF9+nJxKzgi7w9cQ9vJBeUIuhhZWCIF3IMfwKcvifkzNeT+hOWNCuxiwT/clA7Y/10nS/z8x/Ah6Au4YqSpuP2EzvbqYJWNWLak9aDImqPiusfWIyDRvUhao9gmCYVkTvPdlej7IaZFG/pEeQ1YrXsph7JnVzrUvG522cYhK/XKNyDLSDYcvB0ghPq91VFzV2o3HogGF+fMNM0dqfN9feEDaQxVSyCz5ryFWNeT+2SJsBhRyKJa0hfl42EJiiM/MZT9IG+MPIA4PHhtkF5FYeI2BBod80SpnLamVrCwmkoPdKZDC2C/US/B6K7vjX0s41H7SR2VTc1jR6Ye+xFTcXHW9D8NV8xkgmspP5/7K/KqUeyojrP2PU5XPO2UwC+MlZ/rvW5evO2N9wCQgwtMLGD81l50VsMDRg5QRd/vX2CRyJw1dDAsl+5DL1kcPGo36Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5572.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(26005)(508600001)(52536014)(6506007)(110136005)(316002)(9686003)(8676002)(71200400001)(86362001)(33656002)(55016003)(8936002)(83380400001)(66476007)(66556008)(64756008)(66446008)(186003)(88996005)(122000001)(38100700002)(5660300002)(66946007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?YCA6bE+PIRdrttiZcGISKrGlaBfZAk63L1mKWSgcNUZs22JGncqq4HpigG?=
 =?iso-8859-2?Q?Zs2orsL8QGvjSXKgi0I6OY78ksb8TALgVIHpNwu7cVh/KGgys5mAORVtN+?=
 =?iso-8859-2?Q?yw+C5JZx6Cn23n+iV7oebOnbciMabEg+uQvZCa0RD44hg3v8NJ78/nNFYD?=
 =?iso-8859-2?Q?8ZZ/SsP8xPvYa2vpCTv5kcRaqmXaXRm81+6nKwHmLtI53shjki7s4YnDD3?=
 =?iso-8859-2?Q?qN01CVJJSHJQY/JgH72FfxX6gbp5egz1ztBDAvMMJ6uMHDqcUYDr8gPIgR?=
 =?iso-8859-2?Q?5WDS/sp+5OP86DRvhzej5Lv5d0s/LaCSdj8kSb0oOVSCbwZzhFLsKzQuO2?=
 =?iso-8859-2?Q?it+0CfDYG+ZG/w/mzUG+lehdKKrmesv8SYwXMGJByaamdvsaAKCXvzZO0o?=
 =?iso-8859-2?Q?bcdbETSVHdpVz7kLQS1dM2V7LYw9wyu92GBq8jZhNrwD3kQ2Ti6dow4+b/?=
 =?iso-8859-2?Q?VN9Y3Ks3tWFVXnMylmWbafVSZH0xd5VgYNCfMwoZSomLpf2PyYSlLEq3VU?=
 =?iso-8859-2?Q?bLBCGPj1A7/lHYNiesrJjZ0LLm8Ik0xQ5e8nIuU/HqbPPRa75z2lCCQ1MO?=
 =?iso-8859-2?Q?HSS+/KWt1sUyYpqWwyI+pjEmdfgVgQ0KkwfxuBwg+nU7NeJRBhs2+/3TFe?=
 =?iso-8859-2?Q?bpICK7lQJsFDJ8qvHV5GvSq+ek2jRio3E6DVmQmtglRPtrpt14jR7p3AwC?=
 =?iso-8859-2?Q?wnvsiYMlL9Cmmm4/bfsK5sTtN7PdNgSKQDbTIk1aYPSpsRhCUUAQOnWrJy?=
 =?iso-8859-2?Q?e5V7RJxv+gEEUtoD3CY++R2IDfn9RjFK69Auwr4WB6f+wZZQihqg5zlnXi?=
 =?iso-8859-2?Q?F/H02F3kt5VRCda5sGbDHz1VfrUKrcGtrdGA9yrh1MCo39esxwwTykhjzo?=
 =?iso-8859-2?Q?HPYWoLnu8QhKSJyEnZBUSIw8VhU3OeNOx3V8y75MnvMNicEuk1sySu3/UB?=
 =?iso-8859-2?Q?WYORkt5qooOeh4cI8huecslDILsGAlB2l5VxSaLaC5Yt7OdVKZZzjvUE0f?=
 =?iso-8859-2?Q?knZRzqQoma78AhaT5YWzg6Cccgp880+VKUYkkZM1mhddxU6xRhZFZ/HUZ2?=
 =?iso-8859-2?Q?xJpe+hZazJbjUdgz26kDodS5oAgqYNUp7OYlmfXqVp6Lqnl5fGPphNu3Wj?=
 =?iso-8859-2?Q?8VxKRrNyNdHJqA3SvCNWse1In9pBb6scmupWULiYxh5civcpBizbdrJvmV?=
 =?iso-8859-2?Q?kRoCb5ux8V4sri0rkhTh9qVYmHyGJ+4HrtRfuoNb0RhW3YNZhh927/MSKp?=
 =?iso-8859-2?Q?YBYKPPxdI7y4ENqMl+Ll9U1OElJkxIpi1/PMx91a4fCKUN6y46G6Kai5cS?=
 =?iso-8859-2?Q?navdCFF/Sah1A86dqLErZuRzcdapwn2uRhDcJGA6whrxEZUqBKxxzo3+eH?=
 =?iso-8859-2?Q?hKHRJniv3n8jOe055Ki9/KtEu5zxXEIwant8nn6Zq2aIx2v6kCUUBY8Vjc?=
 =?iso-8859-2?Q?z/1krFAdFSKAYYQoKrZ+PwkUEnKtmoiMUA01pKLIsCw/zI81Bsljjqc2g1?=
 =?iso-8859-2?Q?DhILC199Xo3H+8nk2yxckPDYC8ukBV6i5o5PQXwB9+GSIkmMGgNmfLe/xX?=
 =?iso-8859-2?Q?ijzi5BXbmZuxr46mdBln0XF9++8Dx6WoEVW1i1qYwo97VThKaVwfIaecH4?=
 =?iso-8859-2?Q?gF3KQqtvi9tU3CWYIRUpDAePqQQZV5mqJsKy9OOrIdoz9iD5E1N+RgLx7H?=
 =?iso-8859-2?Q?3BnibwIjZMV9BHtoGvQ=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5572.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb8d138-c6a8-43cf-1e87-08d9dbecac23
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 08:12:59.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UO0BIv2WldSSVs5HZlHI3YLnVKtcuTgQTErpkElJ3uqkYlVFMDX/Ac+R0tUJXfiz2bBER36Rq3Tj4mGZT7J5XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR19MB5469
X-Proofpoint-GUID: SzpPI8EEuIxjvZwM5B67QJfY5ZeCM8Y_
X-Proofpoint-ORIG-GUID: SzpPI8EEuIxjvZwM5B67QJfY5ZeCM8Y_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_03,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200043
Content-Type: text/plain; charset="iso-8859-2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce pci_endpoint_epf_transfer_data to simplify
read and write operations.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
Changes in V2:
fix WARNING: line length of 108 exceeds 100 columns
#128: FILE: drivers/misc/pci_endpoint_test.c:243:

 drivers/misc/pci_endpoint_test.c | 289 ++++++++++++-------------------
 1 file changed, 109 insertions(+), 180 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_t=
est.c
index 2ed7e3aaff3a8..b6b0b19b251b3 100644
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
@@ -142,6 +147,108 @@ static inline u32 pci_endpoint_test_bar_readl(struct =
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
+		ret =3D crc32_le(~0, addr, size) =3D=3D
+			pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM);
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
@@ -473,191 +580,13 @@ static bool pci_endpoint_test_copy(struct pci_endpoi=
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
