Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83488472F22
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 15:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhLMO0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 09:26:46 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:34534 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235523AbhLMO0p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 09:26:45 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BDAhLmj009614;
        Mon, 13 Dec 2021 06:26:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Ikki9IvP1+PkAY47EipSTYeUttcSdFA5JC5Jkvt876g=;
 b=hITUuCLo5JPpaBCb4R6J/JCCin4hBemglKxT4YAk4XiQhOuigR2cax0Qo/ih62I3/Qgo
 6kTMNIVBwHZJSuTC2+0+8eUR2EE+/B9fU9m4iONqCExZfpZiyaPFrwWMt3SeXNai+Au9
 d0sOJ2KzVRCyswV6d9iNsXN3H8ar6RaR4P5wMcrMyLlcML0z0+crK12smgBuBFhOdhds
 zkyo+iLl+qSmBk9xGI7Hs/YQhNKTsJvRvFoqtnhfwSs6FPLBnvNl1mB0e3j0pl9B4a2t
 357JkCznDb1VPBMQLoG+Y+jAqmTraQo/sgBGzd5vs17mY4tfr2JelwCwudWnbM2N9UG5 jw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3cwc9rvavr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Dec 2021 06:26:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6Vdvp8yrS6P19BZiwmy8nK1h0K9m+ea0IuAPGYR1jqu09ZwCddt2vbPgzv5QOS481AhQW014ZB0QfG4TdV3BkrNac89boyLSANI71UXGb5HL1naSmv+JHW20+TcyXJW8YzpF3cdQPMpURLzBf+h5ByV0W7worVZlcqomo28xTuoaPbvV42eoq0WUN099wNT7PNqDoHa/exTmQ5LYYIMBUwchvP3tEOOEISABXttSZ6amjGN4ZmPU465BkYnE1tbdCS+Xovo9JyUm/gh72lvmSPLWGusZJfveapyJVqv6MyPq4uJM5WcxD3v/T+zf9lv4TxhdMyY9UzG9v6WSdueQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ikki9IvP1+PkAY47EipSTYeUttcSdFA5JC5Jkvt876g=;
 b=JtpSbzhxwB+dNypYAN5y9EyS6wxevG3dnBhZuZW18fdppRljhuHdq0zblKg5uNmBwurB8Xvz2/TQafLcPrmx4UcgCU/m4lh60mjH2WYedumrISqtFg1mUygHfMaKJy1GBmf3JXR6RZrK0hNmCLPiGulZlBJyvdDiz2ig6i3iesFhiFfIKtTOJu3BeNcf9YqGJsmVJu5ENRDBQcAWWpIYQYK8AKh3CKETEXrKlHNlyDr92F4Op+hNChY4nIPpC+Rwt1gwTsopScyiCgmtRLH0UezDgvFnW8Vsaww90FVUShbGxqqn6kSFd2CSJC6JI0wHnV7jcC8lf/l/Ct/NuukdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ikki9IvP1+PkAY47EipSTYeUttcSdFA5JC5Jkvt876g=;
 b=hdjYfWlki6bPNFggg5cMUGMrw8TtvgJa7Vpu1zSw3r1fbl+hU6vwuYpnUgKjAJicpPdnDeYwESBvYS6BKNjRuAmUaWnN51Df9KGwU1uUUuwx/pTyn+26HvvUGUK83SwOFloQ5QHPNp7zbHWdlnugv73qONui+qXEQr84MzOcn+I=
Received: from DM6PR07MB6762.namprd07.prod.outlook.com (2603:10b6:5:1ce::15)
 by DM6PR07MB6377.namprd07.prod.outlook.com (2603:10b6:5:17e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 13 Dec
 2021 14:26:25 +0000
Received: from DM6PR07MB6762.namprd07.prod.outlook.com
 ([fe80::812b:af5a:3654:5855]) by DM6PR07MB6762.namprd07.prod.outlook.com
 ([fe80::812b:af5a:3654:5855%3]) with mapi id 15.20.4755.021; Mon, 13 Dec 2021
 14:26:25 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Parshuram Raju Thombare <pthombar@cadence.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>
CC:     "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>
Subject: RE: [PATCH v2] PCI: cadence: Clear FLR in device capabilities
 register
Thread-Topic: [PATCH v2] PCI: cadence: Clear FLR in device capabilities
 register
Thread-Index: AQHX2r0TP33efy7A9EqV237U/UK0yKwwpVDw
Date:   Mon, 13 Dec 2021 14:26:25 +0000
Message-ID: <DM6PR07MB6762C7B62F28747F4FE51A31C1749@DM6PR07MB6762.namprd07.prod.outlook.com>
References: <1637048356-73662-1-git-send-email-pthombar@cadence.com>
In-Reply-To: <1637048356-73662-1-git-send-email-pthombar@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1hNmI3NTcwZC01YzIwLTExZWMtODY1OC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcYTZiNzU3MGYtNWMyMC0xMWVjLTg2NTgtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI1MTE5IiB0PSIxMzI4Mzg3OTE4NTc1NDEwNTIiIGg9IkJIaCtCd01KKy9YTjR0ZEhhRnRCVjlHNk5WTT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9143eae-f083-48d9-da0c-08d9be448b9f
x-ms-traffictypediagnostic: DM6PR07MB6377:
x-microsoft-antispam-prvs: <DM6PR07MB6377F0C47C2DFA6909F6FB23C1749@DM6PR07MB6377.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0czJ83HtOjihofWog0Rryp+QAvzjFMAQFTLgQzbBil26bfeS8GOaqVGww31CIVOZvTNaD2J+8vcON8eDvY+MTp3RtzSy5VaJqon5JdYW44Klsxr28Mh+oKGgAQbNK4aA8aLJBIaSBcDyZsAhUh4juarGYNUHr9drxdIzymr6REvqmK1htqyuCxRH2I2YiWkU86auOq2SGlLJ3TiUNOQbY+Upt8mCcB9CnSYIZ2umd4nDe+GUQk496IVTkKlHFkAPBZ3nNwhX1gQK/nJSrl6kZ08f4mKXr2RPdUy520s0fcYObPSBArVBgBc4h2GJhcU6BVdD6BktC6HfexQpMOkiy7blqD2x6LcZm33FqCa67uw6HvYNja5gwNstWr95JQHU86CL18YnwIc8roB+F+CirvwH3FVB6RMP4QP1Mgpf6uljGSg7Jo4vN043e0BXntV4mVXm26CQPv5lRAj9Om32/bWNr6dJzZC5uhbz6JMWG2DJrQHfqYbdGtlxO6AAaPLxxsOWZ88WJpIK93aiQZjlPQE+yLBCH+Blwyd7BO/dJGFIOGzxnnxELRtByhED+gMDdoiSdKNVKLAbJVI2kAperCm6ZIjZ94cNUM/2eI6D/pC15Yr/RbkQ5sIPm6T/PjpyXT65H/vP7BdkAJiAGbo71GWD8kLwixcWLhFIuclX9eRLNWCo1IF6o1ukSlJmYg+gq4dtLaWFuas/XoscE3TDjRBL2hbUaObCS9jlsHvJ5c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6762.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(55016003)(83380400001)(86362001)(66556008)(54906003)(33656002)(508600001)(122000001)(8676002)(38100700002)(110136005)(8936002)(66446008)(7696005)(64756008)(5660300002)(2906002)(66946007)(4326008)(71200400001)(66476007)(76116006)(26005)(186003)(9686003)(6506007)(38070700005)(107886003)(316002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L3b7KVlPCuCVVEh9LKtk1XUIoYYk5H+s+qcPlk/twIo7lEckEuZdR4lzzy+x?=
 =?us-ascii?Q?oM2XJIZxsIh9Hu3D09ep+C4+ZiQrHC38LZn+F5lSHuP6BgFWkvM+BR7VjJpa?=
 =?us-ascii?Q?91J4XAdyUf59J1MDOZnHcMz+wmyUFFUZ2TQKhdEzjek8Jocuo4SQiLMUa8WP?=
 =?us-ascii?Q?JvLLO+TRHWgeRTZFAyGiyqikfJxkcsXvqepwvqnODpZliepOE5uIgH+61SXf?=
 =?us-ascii?Q?+FlweVeyAZ1RG9n3Lhtn2Jmhu5+ysNcdogYkb2n/GIRI59SezmxFmbLzBMh/?=
 =?us-ascii?Q?2GkJUe8Ve6gtk5o+TnqYZ3OOwq7hZbeN8Zi2ECbWzAveiFcFSvjZHLy01+Ju?=
 =?us-ascii?Q?iIdZhSGwgPHsAQP+805DYd5+yE1NX8IJpjFRhoRgaQEhwiQrDjKAtZC+8TvJ?=
 =?us-ascii?Q?hte1rm6uaU+bsEWkvQEY6PxB12USq2Q8zJdJbbcDqFqYTSgKXp2dRUSYTj5S?=
 =?us-ascii?Q?jZo864qF2/hMy/xxUPZ5nA0h7RTN8Li7PR4wjXzTqHRimbn1HcBE+sM5PfzR?=
 =?us-ascii?Q?ECToY2suvgre4qTkaCGTOzqceglKPIZ9VZVsk1sJ4v3/D9Knb5gykii5URox?=
 =?us-ascii?Q?KXFGUIJJVIxdlbKV1g0VOT+INDKBVGvx23tnngwLy6RQ7DUqFssra1ZsQIhB?=
 =?us-ascii?Q?Izvrrrt2wNItmXMV2+df54jA1gW5pZFopvoJo6gkN2dAGSQntwTCCVnjt26x?=
 =?us-ascii?Q?7cdEaLZJbsop1eO9CTzrfUuRTwrEoqnWIdXTtodlZKNXmPLDZK3PBNyPtl6R?=
 =?us-ascii?Q?XsCteTw/HTCaIBMeYkatVm5kxV2/h3+7WH4iDD2bRVnFRGpIvW5S1lK8yW9T?=
 =?us-ascii?Q?iC0AZlIBXXZTpMe5AVZlRblyEyAQupDnR9rIHcklsM6E8IpTsZOWLG/vj9kw?=
 =?us-ascii?Q?GY3/oA7Z1Ui4FXu9h8BYnG2/hoIShFsqI40ZeHalYjkex5DxonQLr7lAqnh7?=
 =?us-ascii?Q?NGzypBWc80dD8b2pZdNWO2MX5SAMErC1o3wwekBRkHSScmhrNLCf5Z73dz9J?=
 =?us-ascii?Q?2ewWNaGfgIJia/4lRmLTmCpEjIBXGbLoYSutF84CEMJbHYlbxvmfMYUJc+UC?=
 =?us-ascii?Q?YIy2w6T4n0uL5pG+YrSSjL7OkMO1p6HQpIIFcejGwSxSyIeKkswicJvpt3C6?=
 =?us-ascii?Q?26jTN3SmN3qn4E46d+DLLnlAR5zqGgEWj5tFi0QHGjSmL6WnTZNX4npI2HDX?=
 =?us-ascii?Q?DFYyud35cQ4hb+WSR4qTFozyyk99j6x5lFqZiVnVrn56d30ay38okozRw69o?=
 =?us-ascii?Q?1qLfGBW5ZWuPn6bPQfpq0mu2GLxAtMyQZaLha25kJai2Y37tBV3IowKe1FId?=
 =?us-ascii?Q?8eJ298D1fsh3yvGMBShUbNE2xCDgYEI44To578NvBfYE6V3pDbbczZr1dFuL?=
 =?us-ascii?Q?WIXAffsiXFDHoDnzDyZWStnc4A5x69fip0K9wTvWJ+UWjT070Eq7NvP37Wsh?=
 =?us-ascii?Q?GQ/X4vvlkDK2Z9sdaHfM8K4pTp648tsKC76NqyBTDxQi+/Z4jIGs+M72oIjq?=
 =?us-ascii?Q?RJnqPCwDV4WkbSJoWjzuJAkLdugvm3uxAM/yY8fgaXLgxvlOieWqmsi6baVr?=
 =?us-ascii?Q?moaZkVQwm3ZcY2GfWACIM7Rqx1BIHGBXT6KKnTsh4fNoKr+jz2z1u7j6UPuo?=
 =?us-ascii?Q?VYV07NCZsSDygVpbjFq67f8bj/6+vVcU6MNweYv6YWL4JacVBRJmzCaY2hdA?=
 =?us-ascii?Q?A25cmQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6762.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9143eae-f083-48d9-da0c-08d9be448b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 14:26:25.8573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOz69CCSovFgdGNM31Yj9NqTQEP/QCGXP/xjAik7UGz64d1pjeog/QpaEFW6+FdrauR+5cYwIQhdAvn1qHL1KXE15hZTiw4in3Ld4yQgVf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6377
X-Proofpoint-ORIG-GUID: trBg6z7xuL1XMnvN076iBlzVuG2BwfRM
X-Proofpoint-GUID: trBg6z7xuL1XMnvN076iBlzVuG2BwfRM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-13_06,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112130092
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping !

Regards,
Parshuram Thombare

>-----Original Message-----
>From: Parshuram Raju Thombare <pthombar@cadence.com>
>Sent: Tuesday, November 16, 2021 1:09 PM
>To: bhelgaas@google.com; kishon@ti.com; Tom Joseph
><tjoseph@cadence.com>; lorenzo.pieralisi@arm.com; robh@kernel.org;
>kw@linux.com
>Cc: linux-omap@vger.kernel.org; linux-pci@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Milind Parab
><mparab@cadence.com>; Parshuram Raju Thombare
><pthombar@cadence.com>
>Subject: [PATCH v2] PCI: cadence: Clear FLR in device capabilities registe=
r
>
>From: Parshuram Thombare <pthombar@cadence.com>
>
>Clear FLR (Function Level Reset) from device capabilities
>registers for all physical functions.
>
>During FLR, the Margining Lane Status and Margining Lane Control
>registers should not be reset, as per PCIe specification.
>However, the controller incorrectly resets these registers upon FLR.
>This causes PCISIG compliance FLR test to fail. Hence preventing
>all functions from advertising FLR support if flag quirk_disable_flr
>is set.
>
>Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
>---
>Changes since v1:
>Changes suggested by Bjorn in the description.
>
>---
> drivers/pci/controller/cadence/pci-j721e.c       |  3 +++
> drivers/pci/controller/cadence/pcie-cadence-ep.c | 18 +++++++++++++++++-
> drivers/pci/controller/cadence/pcie-cadence.h    |  3 +++
> 3 files changed, 23 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pci/controller/cadence/pci-j721e.c
>b/drivers/pci/controller/cadence/pci-j721e.c
>index ffb176d..635e36c 100644
>--- a/drivers/pci/controller/cadence/pci-j721e.c
>+++ b/drivers/pci/controller/cadence/pci-j721e.c
>@@ -70,6 +70,7 @@ struct j721e_pcie_data {
> 	enum j721e_pcie_mode	mode;
> 	unsigned int		quirk_retrain_flag:1;
> 	unsigned int		quirk_detect_quiet_flag:1;
>+	unsigned int		quirk_disable_flr:1;
> 	u32			linkdown_irq_regfield;
> 	unsigned int		byte_access_allowed:1;
> };
>@@ -308,6 +309,7 @@ static int cdns_ti_pcie_config_write(struct pci_bus *b=
us,
>unsigned int devfn,
> static const struct j721e_pcie_data j7200_pcie_ep_data =3D {
> 	.mode =3D PCI_MODE_EP,
> 	.quirk_detect_quiet_flag =3D true,
>+	.quirk_disable_flr =3D true,
> };
>
> static const struct j721e_pcie_data am64_pcie_rc_data =3D {
>@@ -510,6 +512,7 @@ static int j721e_pcie_probe(struct platform_device
>*pdev)
> 			goto err_get_sync;
> 		}
> 		ep->quirk_detect_quiet_flag =3D data->quirk_detect_quiet_flag;
>+		ep->quirk_disable_flr =3D data->quirk_disable_flr;
>
> 		cdns_pcie =3D &ep->pcie;
> 		cdns_pcie->dev =3D dev;
>diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>index 88e05b9..4b1c4bc 100644
>--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>@@ -565,7 +565,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
> 	struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
> 	struct cdns_pcie *pcie =3D &ep->pcie;
> 	struct device *dev =3D pcie->dev;
>-	int ret;
>+	int max_epfs =3D sizeof(epc->function_num_map) * 8;
>+	int ret, value, epf;
>
> 	/*
> 	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
>@@ -573,6 +574,21 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
> 	 */
> 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc-
>>function_num_map);
>
>+	if (ep->quirk_disable_flr) {
>+		for (epf =3D 0; epf < max_epfs; epf++) {
>+			if (!(epc->function_num_map & BIT(epf)))
>+				continue;
>+
>+			value =3D cdns_pcie_ep_fn_readl(pcie, epf,
>+
>	CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
>+					PCI_EXP_DEVCAP);
>+			value &=3D ~PCI_EXP_DEVCAP_FLR;
>+			cdns_pcie_ep_fn_writel(pcie, epf,
>+
>	CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
>+					PCI_EXP_DEVCAP, value);
>+		}
>+	}
>+
> 	ret =3D cdns_pcie_start_link(pcie);
> 	if (ret) {
> 		dev_err(dev, "Failed to start link\n");
>diff --git a/drivers/pci/controller/cadence/pcie-cadence.h
>b/drivers/pci/controller/cadence/pcie-cadence.h
>index 262421e..e978e7c 100644
>--- a/drivers/pci/controller/cadence/pcie-cadence.h
>+++ b/drivers/pci/controller/cadence/pcie-cadence.h
>@@ -123,6 +123,7 @@
>
> #define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
> #define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
>+#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
> #define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
>
> /*
>@@ -357,6 +358,7 @@ struct cdns_pcie_epf {
>  *        minimize time between read and write
>  * @epf: Structure to hold info about endpoint function
>  * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
>+ * @quirk_disable_flr: Disable FLR (Function Level Reset) quirk flag
>  */
> struct cdns_pcie_ep {
> 	struct cdns_pcie	pcie;
>@@ -372,6 +374,7 @@ struct cdns_pcie_ep {
> 	spinlock_t		lock;
> 	struct cdns_pcie_epf	*epf;
> 	unsigned int		quirk_detect_quiet_flag:1;
>+	unsigned int		quirk_disable_flr:1;
> };
>
>
>--
>1.9.1

