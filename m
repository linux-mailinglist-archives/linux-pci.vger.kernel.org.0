Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2274811C7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Dec 2021 11:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbhL2Ktu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 05:49:50 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:41716 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235648AbhL2Ktt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 05:49:49 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BTAdmmw025913;
        Wed, 29 Dec 2021 10:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to :
 subject : date : message-id : references : in-reply-to :
 content-transfer-encoding : mime-version : content-type; s=com20210415pp;
 bh=wGW4oZWTFS+ajqK2LopiU+yv5M1qUqcS/y0NigAHn/g=;
 b=CkJf/C4ddkg8DI0HNh+zG1bBLmw+aniY6qvmiMCfqOkcjiEJK8vnhVprubH0HacftaWd
 Qzrl5jKVJeCIP7gogLMJIPNZnV1dvdZb+5xT+NIqRAZ5TbShqrPY19zuXYGZWiG/j+94
 z4nhMy3d4HPc78JHlkY7/fF62s7s+zHriuRWAjoiDnvbnv8o6gzFPrvGNhDrftDhPWa6
 WNybBSo22VgP/uOW+1xdTuobtL8L/hZZ7g9Wr4wjdkhtm9xtxxN2uvxHjxyY1Hc+7xRs
 xsftvfOQz5ENFejQWL7MNVIp5xYLyN3LWUiU1xmTUR3bDpzqv6+4E4AiXANiNzaE5mm7 sA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3d79dws9j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Dec 2021 10:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzFbYoPVOZCoLvBBLGFMP563ZsS05FXi/pwhvO+BN9RuB9y8Y/BcWxezSKAZwjrewfss/dsbM/Udb31i7YOgTx6VTwdp+CWeNIINETlq8EqO+UxFjt9CH6vTXv2scluJyz+h4bacM7jwzlyUG6XlRvaCtO5++bpHvNtG6VC4VS6Ggjh/20FjayF+Wyykv6F7aeu3Qw3ev1RY7A2YEL6zgnZJuZuzqQPaMc6cHPvZlWd7sqsZDsGVL2KHIAeXQojNQnXeYeGqLEaMnhzlGaU4qd6UC1nsTaAVLF6asEEDoijM1Cm2fLfKua4u5qzN95noSH5/RWQVBTiYuX3PCB9EeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVkc+brojsH2Sr1s9jHIacfM1W5Xxj4AmaUUGIVk4e0=;
 b=fywjvADD007HOW5YDzmfnoyqtTwkiXjQJAx5gcABTav3sxxjw2TqqxOSKD9WQCT0iGtB4cREX37RqrWyokn46yLV7qmYmVU6qy5twbW7sETyRnKmtSOjObSOzXcqAGw/eDb/bBEAywURuXXErgDOP32cWNmOYcDu3NMmW9vzfpxRJb7SPThsWccbPnPzT1ZZY4nHr6r9+xICobkp8fQ134oIGtESz25duswGd+VXoYQsfqBdz8wikGIvSwxrV/HbHiWXShA1zICje1bbkyEh0M9C4mr4QlU7/7AxoxotNEkpO51SjU2VW9dKgjTuZejSuCIclXvdW3OT9U+mLIJusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVkc+brojsH2Sr1s9jHIacfM1W5Xxj4AmaUUGIVk4e0=;
 b=ZXBrX5VBys/W8wGgN9SqzI90Ic8P5ySUit28zhxOE0RjHyi+PBmWGXFUomR9Sm4SRjmNs0Lyt056Q4kJTMKtkrVB7iElX7dhcHTnUHQZCsB9yr+MXssT7O1ge9q7Nwialy6uSk6Z9RltC+d4ryIpftb8xhqciidm6n9dIbqxzVQ=
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by PH7PR19MB5659.namprd19.prod.outlook.com (2603:10b6:510:13f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 29 Dec
 2021 10:49:38 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%5]) with mapi id 15.20.4823.022; Wed, 29 Dec 2021
 10:49:38 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: pci_endpoint_test: fix misuse of COMMAND_READ/WRITE
Thread-Topic: [PATCH] misc: pci_endpoint_test: fix misuse of
 COMMAND_READ/WRITE
Thread-Index: Adf8ec9MVzgZ+shNToay1AX1NAaMGAAJ34Cw
Date:   Wed, 29 Dec 2021 10:49:37 +0000
Message-ID: <PH7PR19MB5562E60AFDA5416F50376924A0449@PH7PR19MB5562.namprd19.prod.outlook.com>
References: <PH7PR19MB55623C78565E9CEA2A98D237A0449@PH7PR19MB5562.namprd19.prod.outlook.com>
In-Reply-To: <PH7PR19MB55623C78565E9CEA2A98D237A0449@PH7PR19MB5562.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf9c299f-51ce-4343-0b8b-08d9cab8e900
x-ms-traffictypediagnostic: PH7PR19MB5659:EE_
x-microsoft-antispam-prvs: <PH7PR19MB5659469AC893E265558EEBF3A0449@PH7PR19MB5659.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aHwHbKlvXWUYRi7HdAasuQBVw+AdTZf87XwCVSAo2xGp48/x1tMqyC6J1cmSg+4xi+DeAFuOqIDx6dT2CFHmvgc6JwoScDvMY4tLw51+uMB07yKARLmvtr+4myFBHKggAd0TD7oLU6KiThue0yAXKVvjPRc7QhPLaJLO6aOepNjYpRTZ5IL2Qm0PC6nNtDUDB6SV9OtGSoABXcvJ42UtbwVL2bfEYcEl9bf9669XUeh/nAuAEdyZPhdhBD404oBXTR4luW6B2J2jRdDjQm3prQp2oI8mghK8+hrlDLSO6p5K8n6VRfeYp1EQsaaZohHYeNVf98VqGpEkWvNBsnMLUoCWjhUjoCYeVcOX83oz8V+QhTQh8lFWz/eNZzQscbckevQEGqITfpcJkh7SdIgl7cwlKIByM0mOBcF5RASvC0O71MTgGHy6q5p702u8a8jkDWqKSR6uF1VqbYYWzA7d4ki0d0bFSQ5lsPmh5DWnXMnv+Qx3ERM+c0Ewqa/aonm8vo0vFNxRBjMK3nOTvAQIVu9NnbApaeLpNKArXtyYHBAW3IDjPktZahr50jr4sDS6j6pzxMDH/5VQaV/Izkvsvg0t4F0YQESiFLiMnBqtGk1cRk8M7vR0pdzqQ2G7KR05VRZ4a26ei/UPL4Zw+wDIjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(316002)(2940100002)(122000001)(508600001)(71200400001)(83380400001)(33656002)(88996005)(7696005)(66476007)(64756008)(66446008)(66946007)(9686003)(110136005)(55016003)(5660300002)(2906002)(6506007)(66556008)(8676002)(53546011)(186003)(26005)(86362001)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?lKV2CnJ4ICgSkthQkADqXJUzT6H2wB1PI89Rq3bF2JJOeuQioXiNeI/P5s?=
 =?iso-8859-2?Q?18O9FD1txzor8yHwmsu3h5NyoE1VmYq9VRX0CsH/ee6PVQWzxVlR+RF/SQ?=
 =?iso-8859-2?Q?SPIyC4Fp6xeqKUUOJmEJJCVQKmYCerv2GYZuwIcS5C1MJ4j6KNlDRnhqDY?=
 =?iso-8859-2?Q?JK0+RbqslPFaB9D+sUkGWuK5r0pE/1+GFOyy3W0+FYObuMTa4L+hI2uABL?=
 =?iso-8859-2?Q?1qF8fEqJzCMiW3ANrrDr9yO81TFG+/YSOTAJF0ZCUYMP1JFJtocBfS4wei?=
 =?iso-8859-2?Q?M2DFiuZO6wZn0kw+BFXyxyp1lL+WG6fe/2Zc88qMGiAcOfCzIiKlIr2Qns?=
 =?iso-8859-2?Q?F1eAk/SuUEVYi5pAx1GsXKiLqFn65DsbZ/JPSfduR1h9+vuhQpnVZPo+cF?=
 =?iso-8859-2?Q?bVRE1ce8EyrbTKbHpB9sFO4oLUYIX1BUQk0legmy2OhYhI5XQPlqqFU1Gu?=
 =?iso-8859-2?Q?vyjyxHsdiFIdVuCmwVeKAZlbkqwwSn9Ox0CLYcv6aEkgiTesJrAJo96Gyo?=
 =?iso-8859-2?Q?14gvYAvxeCtR3nDhMK7vCz7LMFpZ3SgvjKrZcsCdaMfEAW9k82P7xQkGC9?=
 =?iso-8859-2?Q?Pp9YO0FBmBu2eFlc1UsFWMSjUNqW5lG8nwDwBU2uMC25DPhfsBrUkbVf9J?=
 =?iso-8859-2?Q?3RBV8mGCV/oCsxEXlns1DbWp0xjtO654yBXeFxPFTi1+UZ8W7vQUd8ej5d?=
 =?iso-8859-2?Q?cZy1jNzVheMvDpPqlk0DUu5oM3tXSkHKrdNPJmQnjrDTZhLMH5gyj1iTEl?=
 =?iso-8859-2?Q?18b/XcS/zsqnUgb1NWFLRaQ7WyG15ZbyBb0Vold7psMJIh7VdiELZdtjAZ?=
 =?iso-8859-2?Q?/qXp0oT3ljCpdaTzoo/QUqM7ShPO3ViuhtUK0+2Uuu9vlB/NvbffQE5ej1?=
 =?iso-8859-2?Q?5oN90dJzy3rzJe8h05FHbg9h0pMEbH0y822E5e7so43CrAcKfr/y3Zbqa6?=
 =?iso-8859-2?Q?syckbyWdQX/vZ1n0Q65MTNCgP45YLQKNsUnI46+MHdYv67eyl5JtVpEKEH?=
 =?iso-8859-2?Q?tilEsj5SljEgtq3ktjvsHIPSCYT2GqEr1s4GWL4LcKQXBHmwk1ypNZYNDp?=
 =?iso-8859-2?Q?BtklYY7cI8aBWPPBgPiOMxQzwewC9JZS4way0TfTZyfTGy3yXCqHttnczC?=
 =?iso-8859-2?Q?Y8rzKTedO4U31UGCBT4YE5NkSf/TtnvquAIgWenVuq9KWd2u8vLWsyItuI?=
 =?iso-8859-2?Q?vMZLs/ygtGQCQt8XgMHmwUBOtR2f2LAfFVjL031Fz9tN8i+nF0VI932yA7?=
 =?iso-8859-2?Q?o1VvGjKub01ZIazSwjBiWeHwMolxHcH8hYu8gkKWxCAI7ufDvuj5oJ7FS8?=
 =?iso-8859-2?Q?u8/Y/kPQ7XZkIXNx2MJiuwm+ufliwtuN1U6V0sAR0y6/+XFhs6Way5742Q?=
 =?iso-8859-2?Q?tO/58aO2pxpA8O2UfrJkVHZmyj+IuMGILb2KuGJnMAPFPlJDxdxVKdv7E8?=
 =?iso-8859-2?Q?sqWPqoaLm9/hJXy4vW1C5/uSNUvY2JKTSJfJEzi1qAImJ2sICi9jLfmCEq?=
 =?iso-8859-2?Q?61bfclGFsrLbC5D/P5QqfCyndF2ieLzRWfXq3On1mQEzXG6JnZyDUbxns8?=
 =?iso-8859-2?Q?7f0BzCn918SqhhpWABGIETXUfKvXTwE5jGfF/b4j7MbPPzdNPPWh+vT7kv?=
 =?iso-8859-2?Q?FbZJj/qOaQoyPiNB14GGHdnSOy6BaEHzUyEAagzZPOPWtAtF5C0u+GfO64?=
 =?iso-8859-2?Q?YlCjk3wC+QFe90ijdlY=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9c299f-51ce-4343-0b8b-08d9cab8e900
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 10:49:37.9336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/U7APlOQNLb0+9RK70b4XgduzG8S4OGUBTG9wr4UPGweGMw6dXfwVDiS7iDMTFyQ4emsfSNLnfDcO32Id4E9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5659
X-Proofpoint-GUID: EkAoBhW5LVbYe9D3yl0X0OS0CHesgyiu
X-Proofpoint-ORIG-GUID: EkAoBhW5LVbYe9D3yl0X0OS0CHesgyiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-29_04,2021-12-29_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112290058
Content-Type: text/plain; charset="iso-8859-2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry, I misunderstood the two functions. pci_endpoint_test_write has fulfi=
lled orig_addr, which is used to dma_map_single. So it ask the device to re=
ad from the dma address, and **writes** to its own dma address/buf.=20

Pls ignore this patch, thanks.

> -----Original Message-----
> From: Li Chen
> Sent: Wednesday, December 29, 2021 2:07 PM
> To: Kishon Vijay Abraham I; Lorenzo Pieralisi; Krzysztof Wilczy=F1ski; Ar=
nd
> Bergmann; Greg Kroah-Hartman; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] misc: pci_endpoint_test: fix misuse of
> COMMAND_READ/WRITE
>=20
> IIUC, COMMAND_WRITE should be set for pci_endpoint_test_write,
> and COMMAND_READ should be set for pci_endpoint_test_read.
>=20
> Signed-off-by: Li Chen <lchen@ambarella.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> index 2ed7e3aaff3a8..ea7a90830932d 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -551,12 +551,12 @@ static bool pci_endpoint_test_write(struct
> pci_endpoint_test *test,
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> irq_type);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 COMMAND_READ);
> +				 COMMAND_WRITE);
>=20
>  	wait_for_completion(&test->irq_raised);
>=20
>  	reg =3D pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> -	if (reg & STATUS_READ_SUCCESS)
> +	if (reg & STATUS_WRITE_SUCCESS)
>  		ret =3D true;
>=20
>  	dma_unmap_single(dev, orig_phys_addr, size + alignment,
> @@ -643,7 +643,7 @@ static bool pci_endpoint_test_read(struct
> pci_endpoint_test *test,
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE,
> irq_type);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
>  	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
> -				 COMMAND_WRITE);
> +				 COMMAND_READ);
>=20
>  	wait_for_completion(&test->irq_raised);
>=20
> --
> 2.34.1

Regards,
Li

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
