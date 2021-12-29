Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B38548103F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Dec 2021 07:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhL2GHj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 01:07:39 -0500
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:29646 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234520AbhL2GHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 01:07:39 -0500
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BT64lSW012466;
        Tue, 28 Dec 2021 22:07:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to :
 subject : date : message-id : content-transfer-encoding : mime-version :
 content-type; s=com20210415pp;
 bh=/omBWCIbafD8kLqQUOsGPJqVxH+KzYGJXQcIPMYS5zM=;
 b=XT1U/au0Wc0rf5UOO8ekh3psNmVAiUR5oY8EQ4Bgm/ETi3b7/fetc+g5NNkKKBZFJOPd
 HocVLHQHf5Di6mIsOiBLibpocCydVY/2HaTkTS/xGDUxNzl8eLZ/dV68c23dbGcZDzU5
 aHT2MwvDkTRMKMlF2AC59RZrkdbKPE/shQmq8UjgpAUy4C97hwxySsVFloCH+PM1Nqv2
 gRlga/LqNe+tROEMzGEypBzWDTMlx0K0kMzM7jHHsubQBOvsNtJX/2eJLfrq9ATcldqW
 iL1/ULUhTMa0S1rxv65casg4CmIUDsS/2uAEV9RfiZ6f4qtkL8GdkIcW5jkQJ0wjRPPR QQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3d7f1dh3hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Dec 2021 22:07:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw0whSiJ1pVsCI50ngKk1H67j210Oe4/8/1MTqhKkeWY7FG+S29xIzpAtlYzjVr8f+lckoEsB6Wbjsb/Cn55qYb2D5k94Ew1ObHH3zlnHQrcajoCIuRxyuEjdApWRflu5tbnFZi5eNhkLNe5Lu60+V3c8M30Z8pb/fhf2lbN03kjd74eX0AF5yclhShAfV1zJea5oC8TkFhcwV8HUEm31BrDh0e3VX752ounbRnk3J4SeAxsR4bY4oTxvFe+/YpAv5mrndD7CwuY9qvu72gRXUj1vvXa3qor91OJcSWJ/eIAR4TpC6jCTNLrJFNzrHOq4kq5I9go4td+jqGAD4vL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Wfc8iZEqgIgTegNd+W4/c7w283MftuSwCA8nPVXm7w=;
 b=C9M/utajHhBnefuYuLj1yRRCIFQhp6eil4+yac8fRMdw3V7tVmXN6f8CDObZkHwPaJrU3w+iM7XuPyuqj8+2AfXWcUV75uzlkD9vIdeITjv4UbMv5xoJ/EEb3WXzrscfL1gzqOnxZeZYm4UdqMkGWjSqcBuJJbodq9yF9xwAFSuwRyArHxiw7hHiE4P9S/7jkCNedV1+IJvbHEHItIpAu+LWaleshsYdJZPVue5X1pyqTJ8a3SZ9kUlYRkN+LpBcrOGxpK1C1A2Atb0P/jtCICLywq9CLuWT50esdGxgZ+G1KuuNB0xAlK4ZiCBDWc53pWy/TK2je97a+HNvY308Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wfc8iZEqgIgTegNd+W4/c7w283MftuSwCA8nPVXm7w=;
 b=DmgXo3FJKMWxqWxUNdrwUnNZ/66BHjyW+shlX06EeuNY0VL2rhpJRVNGGnjNKxfG//yGk8OdowwZoAKys/aDbIGHjLnQbCiBa0CTdJpoC/faVMrBXA4wtkfHN/591tKZxJoTZshFgCaANiFD2ci9P+yOcvxKrdfZo8lDNw0fIqs=
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by PH0PR19MB5441.namprd19.prod.outlook.com (2603:10b6:510:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 29 Dec
 2021 06:07:24 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%5]) with mapi id 15.20.4823.022; Wed, 29 Dec 2021
 06:07:24 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] misc: pci_endpoint_test: fix misuse of COMMAND_READ/WRITE
Thread-Topic: [PATCH] misc: pci_endpoint_test: fix misuse of
 COMMAND_READ/WRITE
Thread-Index: Adf8ec9MVzgZ+shNToay1AX1NAaMGA==
Date:   Wed, 29 Dec 2021 06:07:24 +0000
Message-ID: <PH7PR19MB55623C78565E9CEA2A98D237A0449@PH7PR19MB5562.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 182edb38-6253-43a8-563c-08d9ca917bb0
x-ms-traffictypediagnostic: PH0PR19MB5441:EE_
x-microsoft-antispam-prvs: <PH0PR19MB54410575D8BB1F69F0BA5611A0449@PH0PR19MB5441.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkXvhdpyGCPtsfDXFhclpA8/ljoRVJJl2/0A7n1pVO0c08ypIDeDK3PowcyjciO9Pnw3yONhb66SfJEdZ+a01jxuRbkNLWWKP9Bp1PbE4LR/3HF2foUOA0Hlpw7eM1SlPqAsYqY4YtIf8DavChmKX+0792yzzNI6iHZS2lCNPWAoEDvUwXiy3kZ4zFnl+xWFyvQI32EDj2OlsNTWb+IGf4ajqsgh/rW7YkcF7IKMVl9u0B9Efp8/o7LWCxzhglyFQTxm6y8wtXmZlawgDJKkng8ENQz6ZfjX69hBUlEY3GxOYHaLMy/TbRN5LgkLUGyoc/6lStYtwaax6KBcc1rAuSjvsOP7mC2zdACvIDjzHPsBFgoRJQFTvNwCvX/EGg4Yw4jkraFEVtni8OrObW2FsYzR/ogpFHfZT7gOCFW3kDqaReCHz4QLJ/nL5S7hrD/q+6tCEWLW+cvmRXGilMMuZ5hTL264+L5Q9lWO5khSWXzmKDgk7exuvKaa2+1MqWEEkItlkozMihz0ArMl+Q0DwRPC35awLJD4K8DSCOivyGzeTWSqoJanx6xvjYaxmUEaDZ9ICWjX6/0JLGaPpGqtKM6jOD09kQJy+XtgH7yNHmXlGsfJlqumJzTEEYbtOpJjuWf1+y6/p8dr4ZghSPFRww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66556008)(66476007)(66946007)(5660300002)(52536014)(64756008)(66446008)(2906002)(508600001)(88996005)(122000001)(38100700002)(9686003)(110136005)(316002)(8676002)(8936002)(26005)(55016003)(83380400001)(186003)(33656002)(6506007)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?pvCJl1wyrVDQzlAsiyu3p1KGFGCbWpXq1y79AG9CI7noqv9gIYOci8AyIm?=
 =?iso-8859-2?Q?fiwgvfzbOOLspxSrKryM+zPNeGeRIdhTt2pQOlCo610G7Fz1jXH17XWVFZ?=
 =?iso-8859-2?Q?PKqEH6L8948dv4N72Y781gur86SE833q7QJ7WKxNuSnIvPrUZihX22AeaZ?=
 =?iso-8859-2?Q?nECxvDnXFKrc/R2KlLZFlSy4MgwJbbfkYlfZCL9gwKtU+Z0g4MY0iRswn4?=
 =?iso-8859-2?Q?EeTe6W8LxoSDofmc6s7OG8kASD43M9jcY1ZO88/qdRWROfYTzyBGhL7CTA?=
 =?iso-8859-2?Q?B734PCvl8391VoVsaBcVtXQARzWs0Ry0xnr9dXzIEfBwwMkr9qgc8UrWUC?=
 =?iso-8859-2?Q?Uujutgxdz9ZMT2wEcPaMpwE3LyGJpSzYVqiy7q1R2WcMJ6f2DMYpB80Nq8?=
 =?iso-8859-2?Q?4BqGfI6bZKsgbTKx8gumuMHjc0dWae65/i+PyswGv1FsHsTdr8YijmVii+?=
 =?iso-8859-2?Q?Lhn43DljSfuznOhCsGwF/779jS7hL6SD/YXHbLyJSGcqU5vzgapeJ+NkNt?=
 =?iso-8859-2?Q?CYn1Rjt2D8auh7w//QW3noHfIw2dFYoLpX3PEIkXcYV4Yz5cHwI6d2v78D?=
 =?iso-8859-2?Q?xnEFw4eGjTrDkylXzQk8MYSk5McUkuL0fSHLvUNvjxCxr6LEljnaXdzEgX?=
 =?iso-8859-2?Q?4/2OKXOwW/azuWUBUBhpf/bD1FgQK0pr76fJcpLLf3d0pz8Fs+Lni9LmvW?=
 =?iso-8859-2?Q?+dnm+xMEIUv1JwkBX9kTphindlHUVjdRLEgjHFmbnkQYsmA+Yy6hsDcp/X?=
 =?iso-8859-2?Q?K1ASQrcr+Qn2ZF6ahCG4I75s4UTTEnn5ops7VFhRNRRLIXLb9rCjxrhpen?=
 =?iso-8859-2?Q?4qCNDTXK0MiTtfCshhhJ1RTqqMMP5jbG4wiYpTcAZ5vr8u6a956TQlQuUG?=
 =?iso-8859-2?Q?MEIdsN6vGU8SGrABAxekH4v++1cg3G3tq1+Ex6mJ8zOOdHOxXFAKCXZovi?=
 =?iso-8859-2?Q?CkXA6nVUCCj2O+v9VE+Tfdq3/pDOhln6+06S51+Nq2x9GtPZTin6lCdfEE?=
 =?iso-8859-2?Q?rSyaoJ0h9QWYBaoxdl7e6+BmVWF3wRVL4DdFWpuBDNM2WZedzt6Ty7+1bN?=
 =?iso-8859-2?Q?gl6+f9+KEAr7nOgxEXZsE05+t/a70pfK40yK5G09022jB5N4rT3mOhMVST?=
 =?iso-8859-2?Q?7Jeab9sRDOabGSnihSi9qZzUejlHYGGlcEQh4gDouZxo8aCu6gi2Egsmkm?=
 =?iso-8859-2?Q?DZAkE7zJFq0gjNBf6hKUh8APplLTPQg56QRvNGYG5pkI+U/Pr4kY39ZGWw?=
 =?iso-8859-2?Q?WuF8Q1ik/ezHMeUy13xU6hydqgqVIlQa3xEKFTseovd0DZg32pRdUazNkd?=
 =?iso-8859-2?Q?oNyFE6HFKKQ3bmYHWwKiPmSLLAGdmehlR5NxgLoKevgITV6jFHsgDOSHGM?=
 =?iso-8859-2?Q?5hCvb8VzXCJRxYhkbXirKSuDG29Gj6PjL1C3j5MUxpRV27cmGTuhmnYhto?=
 =?iso-8859-2?Q?sx0kglVzQJNJY9RbxSLEtWfKaIhvxBVXhcJjM89yfNFdylAcRmJiQmlTJM?=
 =?iso-8859-2?Q?5M489nd2XrVEGdAO3lt1pQBlIcdSlU+zzIhdLG4xIMaqfD6x/7al7rHJIB?=
 =?iso-8859-2?Q?T12eGgQe043/+HpERxuyRaIby4QmrMcVuRVSCJnL1IcN5BHkZ3uwslSGVA?=
 =?iso-8859-2?Q?RKUL2saZp1yQq0tGcRbDZw0pHfcVeTcWYrswQq4mQSWRfQmdgNMENI0/C/?=
 =?iso-8859-2?Q?/skQYFr8HuySfBkLWpc=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182edb38-6253-43a8-563c-08d9ca917bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 06:07:24.2296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+KomdcPLSDgjKXcIuvS4MsPv7vNBkHRA82tqJbSg2+6y6kpOCtKSdSEFkyJdbXxjpL5QfO71Xw/xWh4VGwnVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5441
X-Proofpoint-ORIG-GUID: 5tCJon9bp0jlRkfRGc5keGezCdVsmh2V
X-Proofpoint-GUID: 5tCJon9bp0jlRkfRGc5keGezCdVsmh2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-29_02,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112290033
Content-Type: text/plain; charset="iso-8859-2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IIUC, COMMAND_WRITE should be set for pci_endpoint_test_write,
and COMMAND_READ should be set for pci_endpoint_test_read.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/misc/pci_endpoint_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_t=
est.c
index 2ed7e3aaff3a8..ea7a90830932d 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -551,12 +551,12 @@ static bool pci_endpoint_test_write(struct pci_endpoi=
nt_test *test,
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_READ);
+				 COMMAND_WRITE);
=20
 	wait_for_completion(&test->irq_raised);
=20
 	reg =3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
-	if (reg & STATUS_READ_SUCCESS)
+	if (reg & STATUS_WRITE_SUCCESS)
 		ret =3D true;
=20
 	dma_unmap_single(dev, orig_phys_addr, size + alignment,
@@ -643,7 +643,7 @@ static bool pci_endpoint_test_read(struct pci_endpoint_=
test *test,
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
-				 COMMAND_WRITE);
+				 COMMAND_READ);
=20
 	wait_for_completion(&test->irq_raised);
=20
--=20
2.34.1

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
