Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3291C4938C1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 11:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353810AbiASKoM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 05:44:12 -0500
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:6610 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347702AbiASKoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 05:44:11 -0500
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JAUnu2029823;
        Wed, 19 Jan 2022 02:44:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=com20210415pp;
 bh=/IT6W3myCztCGYM3/kVn2e5Se12XF4dR83MLNSkJlMs=;
 b=ov7aOEwSkr38HASnj8wmD+iU2RONRYsCeRqgndjkR5KTwLDoxA8oRe77f728EtJmiCHB
 25wlVKuArcxmjOMjMC51igXcmLP+heeELINE4YkpjEZjRSW/iCFWiLjbsgWVdrK8lzyh
 6M4DgiOKPXGBqUilztM9ADKGQpUgqSGFL/KQHKnqFV850unhf20g6YSPNDVlwFKOkogu
 cdARL8Veou2b+a2mQ8ETmlMJJNoHvMUDA1D8Qqn8efZWuyFeVEK8aJpb5MEFZQokqFvX
 YakVHk0HGt7d5LNAful19umBsc/uup9PZVg5WFmF8lYiSaJAYA+rT1EpkFeBJrb3CQOj Lg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dna2r0t0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 02:44:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ann/C0qPC1qTjAF0B3Tachsfx3RsBCtAccm1jXoh1apXl/24pXXf4Qpz9nuxRKsEIopBQBzpbaQzJACru/KUK1ZWVlA/Rd3J3b9rSKzasUJ+ro6EbV+4S3+EgJejzYvXThr1D/6HGpXz3cHr18FjlEKHq9Ajfq4Qags1QLBUcymR2cBqX/RwFmuqwIVK+LQuO3M6++HNXehfGc492i6JXlyFXUpoKLU3+7tX+1bT6K/Q7zEl0BDhquVFu28TilbFAdac6oREjBRSKLxI8mG/pQqQHUVxAKhJoh38ITfsexmCrj3J/o0iXrps5GGJNTkhPLAyQdcDpIUcHeIhUZLvfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYoGA6mcw7td1bqWktj10LI1j5wF9UmgliJ1PP6uJ4A=;
 b=O+jjEraa1mamLtNLR0BaeLpbNb4VwcXcRP/YMEBT0oD5nzjYKeezqDasGBACsLpymGrkbXx6ILjM2KpedYYX+W/f6xPTBX6CpGM4VCsJnH0Hg+gccTCLNhMlFFJh3ZSiB5F2PdSD5RdferKbeeRL6tv3wOn7t1q9SLROQ1mIHuozUi3mc6RGNOqQ0T0w34bBss8DCCItHSKL+FM94RIRzAqnYSwNJH+yI/sMXOyBNOw46ZwZ+RsmjAxiDSI6KTg/o9jvRXOKDLVmcTA8/WWQsImdbLhxhraYSXHLyM3AmjKUwqQaOAwIDPns2K4JwH+f+jdhCpewXSUiXGLhVIDKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYoGA6mcw7td1bqWktj10LI1j5wF9UmgliJ1PP6uJ4A=;
 b=bkSJUzqe7Mw7KAoTxh2rgXq7v7Zq88KYhnlMMMteIF6mPW+iFnQKYOER3c6ld5Z+Th3buuk2K17yI9FLKZV+aZwDYKTiQAWDH6ogc5QovYXNj0+1+U4eH3ooJUwtl/CKKJxw05yo+dp6q5FM8JT5zmBDk67p5maGnHWzF2+jYH/4xPM7fAu1nNbfKjA86mWX8iO3+olCIBc+LypDSa0EHaUIytTBxogbULsF/rgKsMc6gHHJLkW1w0ArR9yZuMwdn6pBzQ0VvCwjcp1uaQtW3rDgoB7703GPy0fH2cr8bF+nf3k+4Hc/YxcCTaAxyyyXJYnFRuXC+FmCmAIxaHxgRA==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by BYAPR19MB2600.namprd19.prod.outlook.com (2603:10b6:a03:137::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 10:43:59 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%6]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 10:43:59 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] PCI: endpoint: Add prefetch bar support
Thread-Topic: [PATCH V2] PCI: endpoint: Add prefetch bar support
Thread-Index: AdgNIP8MQV6u7vHJQtKTQOmhk65Esw==
Date:   Wed, 19 Jan 2022 10:43:58 +0000
Message-ID: <PH7PR19MB556260173DB5C9C9EE290DBAA0599@PH7PR19MB5562.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8fb6793-3c35-4a8f-b1b1-08d9db389986
x-ms-traffictypediagnostic: BYAPR19MB2600:EE_
x-microsoft-antispam-prvs: <BYAPR19MB2600B18FD71386E76E66FA65A0599@BYAPR19MB2600.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +OQslq87jKtf+qtdz4tJePxNrwD6e0yZ00kHeK7w00mXmseCgUQ+0kJVuztEf85LC1qonSRTUGOx9BTfVNvf+zi0ODSBwuw/yLkqBak2pYZDw2IAjvlfNLRcXGt8SATGs6gswWAc/PQohNFMdzrhGu/pOkX61IEQlCFJtPYYIVHQGyy9/zupucF/Klgw6EtYvyPd+FvUw9yAVCuAp7/Ko03T4uzP3U2P3o7SXZB9X5Af80/1trype9LnfpzBMIoauEadpEkxMQO33AFKwwO58zMHbQvI1tixcld90zAgIcrpFNgXDUoGJgyCN6DCy3q9ob9MLb/8SdCCaCBGckSyxfvRt7AVoGn+6b+f3yKRvlRyExu3t804iGT7ZNno7Ea2L24+yhjROiO/2sVWSsni3KaVH6kI51OI6HEwsNw1aFmQfcNqDYEiI7Z13P/5mKpcmwdZkOw6VPnOh8SoEa4IP9cF7A07Ifk/lUODW03LGinLKqPxy+SQXSkGQAevqfb1sT15rWhLnGbBDBHc+up3l34dByJNBJd2T9KFFT1mvu5tuogpTMRTDyqT9DYi7Aio44VUw8dAgiMK9erC4aiWidO4eOwxTF9kS5Y6/qidDrBgSN3987F9tTdQREiyxpxGMeCy1VWhVANWDIQxZUYz1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(508600001)(8936002)(55016003)(66446008)(122000001)(66946007)(66476007)(66556008)(64756008)(5660300002)(186003)(2906002)(52536014)(26005)(86362001)(6506007)(7696005)(110136005)(71200400001)(33656002)(88996005)(316002)(9686003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YehlTyUwbAr3/Tw/9/HJBXim8gItYOAE6Gr8lUzJhEN/MVsjtjYVrH4lbP3x?=
 =?us-ascii?Q?h/bWB7NupjTdkxj1byp0+2P74Mj8xO5+5Hmw636+P3gVeROuZov0qCUZFM1I?=
 =?us-ascii?Q?yCJdw9bEd4pRGOZMBvDKnJI7fRoPs0rL/6d54SzxReQc+iALsbmVnP/FGnBD?=
 =?us-ascii?Q?pKkecMUGhoU6s0zeSjgI1kK0BtWJ4ETAifLbqGm9AJfmZIWZWhAFhYF8RP6J?=
 =?us-ascii?Q?TSpuKD/tUr/jrKBCODb7cUFZ5ceGEWhcWhxYT12RuHmNLdWcwjAPfPQViKcv?=
 =?us-ascii?Q?HGTtmRcR+dXA386LhUJSgySS8vCgsQUCju1SmbanOiWf5R3hGlsRdw/s9y4z?=
 =?us-ascii?Q?GkAf3WOea/AtpF4mbbtey9WLHWW13Kz17fDdMdc76e6Zee6p5xnFL0B1u3N4?=
 =?us-ascii?Q?CxYwfubJiEcVt98rZTGM1ixKF9fRQvB48Oq5lMG8mbKFqVojhrjFo46ms1aU?=
 =?us-ascii?Q?/PYi0CoPhYQt31YBbxzI/tTirBEGDqOJQgYyTk+h6PNwJS1jmNSgF7+Y62Kc?=
 =?us-ascii?Q?5YCTz3A/ILMNZEYAjcB54nIaf2myDJ8ngY3u5srYAadLB67UuzkLUOZfh1CU?=
 =?us-ascii?Q?wzTsPLJaaznaQSilFJeUDwh/q/k/EKZrNRtC+jTGABhxMkXYh06Yqo130J/C?=
 =?us-ascii?Q?tAm6fBVgx0l1qY6MxxqkqgMVuzTuh/EuVOLxptvM6rGmCVDImTdhwSZfqdBk?=
 =?us-ascii?Q?c69lHI3MiY114TyRy5IB0PunEnbQFkQw3vkfJ7V234w225IO8gNAgt2uAFnk?=
 =?us-ascii?Q?c2m0ZsD8qINcMimLMSxLi+5HF2RVE86AsyzpAMeUWng9WJXfz1XcIlWzxZBs?=
 =?us-ascii?Q?+ePPxr+cEiptlSwwwHN3WP2rWGwgtQ/pcSVUn9wOdu68JMkvL0w8yrFzRHw2?=
 =?us-ascii?Q?UMDY5vpKcDh72UonEZIha/x3uz4s0hb2wpDWGjKzMZ0FsTZKW7aoBuiK6Wkh?=
 =?us-ascii?Q?vvwcsSF9YWhXxGNIgY7OCr9gM+pqmcMF9fgfApNmLnnYrB5TwM5SyBnvevBl?=
 =?us-ascii?Q?n1ZHpS3wy9ZxHJgyo/gS6y1seBjiQo3At8RlHda4AFl9kKPHraevs8+M/bfR?=
 =?us-ascii?Q?zmf46YuKirF+Ck5Dp859bBCmXQPJO8BDeuI1Eu0dNudx65fsRQuaR65yk0cQ?=
 =?us-ascii?Q?2ong+qB9xrIu/O1Yf/BhosthioEXRHmpqiy0dkVkvQb+s12bKSE6UbwbTEXv?=
 =?us-ascii?Q?TKm75cHfgDC62bzquYE7edeZJ0E3/l1qQuuYCqnLAhNbb+j6QposiEMudXg4?=
 =?us-ascii?Q?sHVqsxJBN3kBMJxWauwwgjTCaOcuiun01759boG6ybw84594VUxHLnABEZEt?=
 =?us-ascii?Q?3nwIXYQK3xnu4RBMYT6KJuWmLL2QZJSAxoFyWXmsIyG+b8KdC6ZcN14C9lAM?=
 =?us-ascii?Q?vQZ8Rh3T8aRRTp0ODtBVQkfnhDqENG4YiAbc0tUxLx/C9LLEtzoXDkwELGZF?=
 =?us-ascii?Q?phFjSChBJjjRkEYt/XSgMofWXH4MxY77KIv6c4dXDafdVTlptMz2GFqlqIet?=
 =?us-ascii?Q?oty4s2Xo8+5y0yy2YKvsbKjIfqyoUGS2kq06sB3sfz93gIFrhiBBdP7egK5F?=
 =?us-ascii?Q?SY/HVylCBe8iGWyCG9ag764fqOlwiSV46QDd2QrKgVX13681plfHzsUCvTBe?=
 =?us-ascii?Q?UMMl9VxHtkUL+1Q+9cduiyM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fb6793-3c35-4a8f-b1b1-08d9db389986
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 10:43:58.8934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G25woaytK8Z7vOCeaBO6/qeIYVOV5kYDn4g7hLXHYB6F4JtRxnnjNJJnvNny78GMQb3aK0h966QT2xSrMpN41A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2600
X-Proofpoint-ORIG-GUID: X2PT4M6kFL9LNU0jpR49xS0nwuicRoZc
X-Proofpoint-GUID: X2PT4M6kFL9LNU0jpR49xS0nwuicRoZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_07,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190059
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before this commit, epf cannot set bar to be prefetchable.
Prefetchable bar can also help epf device to use bridge's
prefetch memory window.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
Changes in v2:
Remove Gerrit Change-Id.

 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 include/linux/pci-epc.h                       | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/en=
dpoint/functions/pci-epf-test.c
index 90d84d3bc868..96489cfdf58d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -817,15 +817,19 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
 {
 	struct pci_epf_bar *epf_bar;
 	bool bar_fixed_64bit;
+	bool bar_prefetch;
 	int i;
=20
 	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
 		epf_bar =3D &epf->bar[i];
 		bar_fixed_64bit =3D !!(epc_features->bar_fixed_64bit & (1 << i));
+		bar_prefetch =3D !!(epc_features->bar_prefetch & (1 << i));
 		if (bar_fixed_64bit)
 			epf_bar->flags |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;
 		if (epc_features->bar_fixed_size[i])
 			bar_size[i] =3D epc_features->bar_fixed_size[i];
+		if (bar_prefetch)
+			epf_bar->flags |=3D PCI_BASE_ADDRESS_MEM_PREFETCH;
 	}
 }
=20
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index a48778e1a4ee..825632d581d0 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -161,6 +161,7 @@ struct pci_epc {
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function =
driver
  * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
+ * @bar_prefetch: bitmap to indicate prefetchable BARs
  * @bar_fixed_size: Array specifying the size supported by each BAR
  * @align: alignment size required for BAR buffer allocation
  */
@@ -171,6 +172,7 @@ struct pci_epc_features {
 	unsigned int	msix_capable : 1;
 	u8	reserved_bar;
 	u8	bar_fixed_64bit;
+	u8	bar_prefetch;
 	u64	bar_fixed_size[PCI_STD_NUM_BARS];
 	size_t	align;
 };
--=20
2.34.1

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
