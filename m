Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05214938B5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 11:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353825AbiASKkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 05:40:08 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:14524 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240089AbiASKkI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 05:40:08 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20JAU8BT006716;
        Wed, 19 Jan 2022 10:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=com20210415pp;
 bh=+7Bdwgz3ibA1dt0DdcearNf+/L55liCc15mo7th4HAI=;
 b=Dx3lyQGgFjPtjleWNX99adgF35/8omoCQiIJ5Q7iiexvYmqlwqBuYDm/BVNEGUGW6SYP
 VJm78JDmdbeQHvg2EarD+1Ptg1387m3rx+7ialDj+/2q8hflqsdvek7lEnuHaa6ZEDVv
 d0ka0kt2AqrCZYjtzJRurxWDd8ai/I2uHNBrWPuipRDsX4t8fXciGr+PK5QBsJ/Q6xPH
 q5+7jR3IlvE8TTg7Ja5EqZpl6l/dZZtt5WA3ImXSaaIw57DlVhdZzdXX3xeuMuNgbFCS
 RmFLVJmKcbbjKGqzIrNKlBrpo0jZITqi5+8VktmNmoY7chijaGEGCp6yPdlExAJYQyk7 tQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dp42208p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 10:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqpeZk5L4N9Xkz9KbmarevGeO2M1BH4SXxgL72dQKa5uLGYZjZmekeSZ+Sm5rKMl4SJBLaUG8Adyeyhirm2Ua8yKXDvQAW4frgopjFJLDua795vYgduC38hWC7VrYqO9+4qKBVhwfDVU6qpF3jEUzVKuTNzbDUEHzjA2ALqNr2ckJ+Ag9kTBykFHNFF3e/A47Ot35Sv9pHHEOuSofl8H6oDV1cbVeYb8c4Z3C+2/PcPIeV4OuZ0ZMsggo85eVYaHFdWnEY9SIbslXpsj5LQCNve5UOi01mWjcAE5i2zSyD6B4+T9W2w3kGia0AKj93tUPDirNoGoB/+N0LQQRa9CUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV764kRssRLLP5tobm4ETAoWBANgB7HlxFgNIcZsw3U=;
 b=Wl7MOmBnqj7r9o8RHeaeZtTHhcIaovrJHTjnt8JyInfc61cmtseeFT0mywzjNcdi3AC7EOPx4qecMD52+7BPiC/acTC4WvTXn0uZZ8PwsTh5YXErcJ4L9KKnE1ZkjGWbasofWzViZENaUMyst/y+gABEaZ8XI1cJ8ohUKJzdanIgId6XgGspi4ikKgoCNmSNUwL7C7N9LPSLKUMv1qh/GuQxml19TK9MEdPLEaLL/RT/mRApA4jvSbjSkE2FDLfbtcAFZEOTLMmJYZ8lwT2vG41IELpGr8GcLXzN8Vva8Qx1IyMrXbDbwFd4IvGBxyd4LzkRVH+1+HkaHRQ42jta6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV764kRssRLLP5tobm4ETAoWBANgB7HlxFgNIcZsw3U=;
 b=ZKSvTQz95kK1aryW6Nto7fOdlkqM9rMdkjUnuWj7wxfIt3GkqtJ2CtD+j8svZm+zqIUZe9N3JSZPeUl6idLhOM6UzA0mpUHmolCGTxZyQ9ioLQRAQePtHE7n+8aHS6tfYBK7LInoLISjZhjK/YweV5TX+FjehSqxKqBpy25IUgG62C6pEzbL10NOXnr2OwmSCGvDSpcV1CBx6ADlfNx1jXjBhRV6dUvu8PifYlD37gs9TW6vodzhnCbfOaauUCnN+A1jhPuowX8vxeb7UQNOahTZ4grBOk4nlFpKmJwwr6IUNJPrg1JvJFp0fRymdS4QagOvXBDOfAyX4L07MphAog==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by MN2PR19MB2638.namprd19.prod.outlook.com (2603:10b6:208:108::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 10:39:50 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%6]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 10:39:49 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: endpoint: Add prefetch bar support
Thread-Topic: [PATCH] PCI: endpoint: Add prefetch bar support
Thread-Index: AdgNIHtaIU026n9GTm60uUgVu/jtKw==
Date:   Wed, 19 Jan 2022 10:39:49 +0000
Message-ID: <PH7PR19MB5562C967A2480E2EE980289CA0599@PH7PR19MB5562.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9766c37e-2a0c-4c91-4a29-08d9db380510
x-ms-traffictypediagnostic: MN2PR19MB2638:EE_
x-microsoft-antispam-prvs: <MN2PR19MB2638A36F63BC8821AC651407A0599@MN2PR19MB2638.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fsM6Ci0yR9eh9lXU5wu2TUoXo2Gc6LenSiTersLfsH+/ETmuudS84qoYyzmzFq3G3C4smOlLlRCYer4kSIEeuol033Txy16q/2qXfC+mupVd7gnp/vXjq49Dm+HZmFDSzQfw3WP8kPUkMao+ykuPPTfE61Twl5Itkn27vjPbeHF+/EfV9hVxXmFzG7f/+u1+eEXHn1gs/0sr74GMbpFH6iIrGocillKmD4ei1a1bzqK/aUtp7sffYZukiDACX5WhvwLeJwtULyxlAMe8uvEdKB7kAUJuHbECVZ+t0GI9xRdnUHZtFgJQGDEws8n0UcqvscdK0raX20QXIyMu7nampQ2wLRe5H1ntIBPXJ3Rz8SR6MKroJ9hnhZRvkoM6LzwdyQe1VYEdnFSFSen4O16uSE5Py6AlQNI0cADu4v0oyCfsUaev1mbeNH95w0cKz5tk3LlvLdhIcTTA3FJqWhRW8fNoOsoX4Gv+yUvZJCYMXm6Ua/m03D0nLG5VRogeh7+Brmz/hYNcpfH07W/ZzNQG37/sR9FyLaAYOQYiIWRXeC3LYUAe+EjpL9vnMyEBmVqGHEEcR6gss09j3OJ3bj5WfIn6cRVIJ87KBQC7lFHIUZb+8A/oN1Tp/fvCYofT5xPRMjWppkGC8ClaKYEvxx3afQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2906002)(88996005)(8936002)(52536014)(7696005)(8676002)(66946007)(71200400001)(110136005)(9686003)(316002)(86362001)(66446008)(64756008)(55016003)(66476007)(186003)(33656002)(38100700002)(6506007)(66556008)(122000001)(508600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vqReHOoZ1JeuMqUGCWWNp8Am94bi16Dt5PnpvjytDA5sqmxrJilf0HzOtwKY?=
 =?us-ascii?Q?2NuCkjxznGZzpEx8Yz62Wao/CLkaU0d+32ueY7RJyw3X48xx9nSPpcArLu4p?=
 =?us-ascii?Q?Yj2UDpOWO085Q0jEW+16/auMl6J6Lo1rrx4/cK7gCltuVO9jwKSLZ3AsLSsE?=
 =?us-ascii?Q?kEKYLfO4Ypmd3AnQF1u1mrCSG+bdbrkbeTmztQodcCH7FZiwaoj5t1CSeRH4?=
 =?us-ascii?Q?D5dA8pdyo1W5WS4SuFZZNdc2JQQBAAQ5Q8DSlawVpUn/xxpZfKGokahEFFCR?=
 =?us-ascii?Q?7Yk8+nnxVIidfFaN9C3U7nEzAcPQT3vhYFG0Vfe+CDX4z265WjYInrvbiO0V?=
 =?us-ascii?Q?ckFxd3Xqg4fxVzKPbI+UsERQ+v8zQpYtYA0HzSNFxh6ml9E5LjtNVEYBAt0Q?=
 =?us-ascii?Q?4mfE5ltwFbw/Q2ZcYlgHo5Az8YZdPPYzIF3LIeDhYKY0ell1VI87bHgyP82/?=
 =?us-ascii?Q?LbiQ8TsbGkOH/g41lic/33q0hZf53saUSJhDi29XNKZIK3sIK67Jfmx8RByj?=
 =?us-ascii?Q?DieJjd3xzQrWE/35+0eiTuCXzrXtj6CBd53M3oAFksNWQeExQPP/lXraPtbU?=
 =?us-ascii?Q?1IaD+dslNL/XagAkF0bDQrbubkoEBn9sB7q9Rg1WBad2QAuBsT0jINFyOVGk?=
 =?us-ascii?Q?R5Y9TqCb+co91sn8VMBb5/eJgvMnFgqn/u603NiyQc1DOgGTRP5UPjFDkg0U?=
 =?us-ascii?Q?wbrbWxGqSr+YPMTSKz6ol5mmIWs2u5bRe7wvYdjxhEDaOXO6z33s8v8fIRB4?=
 =?us-ascii?Q?PvzQQ35Vs9XkBQCJyUrP8f8dAfaUoXIi1F9VXl26P2idhLvKWAteQ2f/BTug?=
 =?us-ascii?Q?TkBN8xoSBiwWx+9SWysysNdVPhFWxcxGa/u/HmI3aHTsJQNi8BxeZhB1edgy?=
 =?us-ascii?Q?PQcebXBVux/+oFTKssqMvYX8hNv0AarRmUEd+BEnbisY38N8XtyyCG3PDYF3?=
 =?us-ascii?Q?mfjuWdZo5aRdoSL+8CKzZeTuTJxs9eRTdH66BHOssBHIoCCmPArWiypcgJyw?=
 =?us-ascii?Q?mBYQ+nv2B4US3KxSMJD8ZSN7RBX870qdfdu60Hza2sGi4z/o54CeHsWt2GaI?=
 =?us-ascii?Q?ANa1UJ8yBWdwhV3iAOJ3gM3CNqmNHbeNA+5TyO+/H10EfGu/oy0v/0AO9kis?=
 =?us-ascii?Q?dbnM8C2ujuZJMVxz8QDrO4ifvloC/6tvx1g7j3ziHcQSD7KWvxnHEAK++/6l?=
 =?us-ascii?Q?MeNuCntrobyoUN0kmzyXGm4G5bzquBswtjw4Vx54YxV4aB+RYWDAL9aMSjQl?=
 =?us-ascii?Q?HLwkAPFbX/s4jdj2gKJiMTAVg7aYwuhhtJA5SVduDv7qUVCAq4egOGwEKZYV?=
 =?us-ascii?Q?XMkMN74pGeWoXq59Ggt8D/w20FMJSIuJCWt+JcpTkaxDR+YiYBO+ODiqlv3t?=
 =?us-ascii?Q?FSh2w+S6xY7YB3EVZHBVFggn7T6HPu+jB7X5pws2ofJoxiV70LaQAGRKlYQ0?=
 =?us-ascii?Q?jfFRbZyN6Ae6T5NDhf40qBwz0E/MdeqvCYtQiub+NPOfot2bcAdZamTOVliW?=
 =?us-ascii?Q?bXlg16K66t6C+4obijJdk9ZK29qA/zBYqH8l7uwsljySfEABnGvaYkWntVzj?=
 =?us-ascii?Q?eUZSrRu476zcA7TF6ibeRVi6sDTcngUqHoR9EPgaVoy3uDsm3LNvhzMxTd6H?=
 =?us-ascii?Q?/Rhi77SV0v2Y0l2gunShDoA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9766c37e-2a0c-4c91-4a29-08d9db380510
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 10:39:49.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brFufcUGL6xd4n2XlA7MYOaUmRAjEGdp+YS4NKSzGd/0pkG604+EAxWw2syBE+obP1CnJefoXxYAKBEdPUXJLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2638
X-Proofpoint-GUID: xoNfV0bOlfVDIc-7Ku3NtgvMmnhws-rI
X-Proofpoint-ORIG-GUID: xoNfV0bOlfVDIc-7Ku3NtgvMmnhws-rI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190057
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before this commit, epf cannot set bar to be prefetchable.
Prefetchable bar can also help epf device to use bridge's
prefetch memory window.

Signed-off-by: Li Chen <lchen@ambarella.com>
Change-Id: I1691a946d715cc161711d6eef56e7a74678a3578
---
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

Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
