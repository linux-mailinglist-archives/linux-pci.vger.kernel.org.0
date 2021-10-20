Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C17434A01
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 13:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJTLa4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 07:30:56 -0400
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:15082 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJTLa4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 07:30:56 -0400
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Oct 2021 07:30:55 EDT
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K9rUIa002598;
        Wed, 20 Oct 2021 11:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=com20210415pp;
 bh=ZmS121j3QMqsqpfjRVYxRhbAV3PsFxTYIrHqgRUSWA8=;
 b=WGbLS0QXkAe15Nd1SRiBYe7xpVcmp1J57XwSlWOi86gkmEjux+GprLIiAIp86C5tPYDT
 02nmTCEmzWP/2KAxho8HEigeIX/oxWQ62ba43wEX5VbW/B8MDmUq1oFXdWiVzVVOE1be
 wFPs17N3ZC0+94ITqXuCMmwAKjiGxTlL2vuuFvN7xuunqCfNiJFd7zjC+Iac7sBiRmE5
 ndRhOxVJObUqE8nG9wcJfSdCkSm6RpaABGGLRKOGDyOBnoTxK+XUTRZbUotKN5u4V3KL
 Oo7wwwq6ZJ5NEM5QKveLZR5P+eo+xsF9/nTa7xbRrmhM6uDkiAYcpVMSoYkX2/j2eJUT Yw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-00622301.pphosted.com with ESMTP id 3bsmpt0q35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 11:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE9NROL0BakDONt3Nlbco/eBszrvdyIrbgyNJhVkqO3s1hNpzSvYxkZAQqTMewVEB1SZoaoF8F7KYp33KyBrC4q8qaP3x60djqsOGCeuiVTG1ymS+vUpUBM5Nt7UBvRQ8KR7ZNfbxPUwREZLGFOudkbrC70VEGFuq9E9dDIsDkjxAJzhmmxr7AhGGxektYrq1K+AFDWA/flP0Nmj83eAGc5Y5Dtx+JbcO7OfDYb/aNgJfhRo6ubZ5JZFWXZJUMoUcRiSAfqP3oMXykojjemuLdjRKFoW19/rgrOxADGqFUFlN8dhkAjEzfgVwYqhTl6fcQDHVHf0ExMQMLNIJNkEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h83+KjEWlBvROAEh0xLBPvWKRtiZjOyEKWPML4ZrkQE=;
 b=QdswwFGsMbB49qZPKoo/p4PDeUdItqhTEmePqAnn/w2TD0RorqsZ76DbD549WGjB7R3EBKnvgK9PWpVhJmobILAkgX2m/jfB8+DwSL6dh+uii757yOTBoSpAv5oj3ALnncQpnJfLcs9Ig2eSD/nBLMgI9bBWnHr69/C65kDM8j2rrHeiDd5AlT+d/0QuOfTBamQJ6PpAyyzEyFkPlEkUER/rqhkAgicuzB8ztwutYJdcveVVTqyGacrm6B+3kvrh4rGGLjcq3dw24aFeq+q3sGPgmJnwdE6KJf9HjK3qtEm/CtYg8Nus88jhrQXSM5P2smGv68ZogziD4gV+WgCC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h83+KjEWlBvROAEh0xLBPvWKRtiZjOyEKWPML4ZrkQE=;
 b=bZKzpXJpCCUPy51ubANYi+ZPdnPIe2/7/q2IM4Veay98oZQ6Bk1FMbC+CE7IyD2eV7mJPbKYjq2qx87y+qj656Drt9l4JLCksQfAY+5I9pn4Ty++hFLdRv7eSJsqRxdLXwkd3xfPXiSzb9NUeZwuYjIRF+Dho4uX2KU7vOtEbEc=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB3830.namprd19.prod.outlook.com (2603:10b6:610:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 11:17:51 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%5]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 11:17:51 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: cadence: add missing return for plat probe
Thread-Topic: [PATCH] PCI: cadence: add missing return for plat probe
Thread-Index: AdfFouKp30ngCunBRzmXJxWO9Vyxyg==
Date:   Wed, 20 Oct 2021 11:17:51 +0000
Message-ID: <CH2PR19MB4024632D33EB6FACF54D3CCAA0BE9@CH2PR19MB4024.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86174c14-5121-4701-4f5d-08d993bb4171
x-ms-traffictypediagnostic: CH2PR19MB3830:
x-microsoft-antispam-prvs: <CH2PR19MB3830CB883627F8AA90A6B033A0BE9@CH2PR19MB3830.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIUlHoCOuHkAjqFgdAUYj61wVtdfSP1X9bVa72C5+jUve09iStOKA+ApaNweR2oXyhMN70M0kSoYFrlGOZOJNEcW0Y1sui+us+QAYlNJkiekLieYgmTwnMJj/HHxCsURJ8cjvzYXu3uaDX1TAXuz4jG6tt0vlzT0oKm9FqKVfXE9n5/ZZtn6yhwuMTdV/WqyYAu2ZsI+JRLSRcKZsQ8kSXJAsPvUC74yhfdQP1jQ7FVt/5BKQYGv0Z2QIdpCsVyy7mDOYJqsPKQWyH15tnq+YIrLtTve3lLpSnwjer6Bf/9XqlHu9FzymuaXxvt6n0LdSt2HCq+lXahXdALwhTIbFmFuWgnhLJNElySvujAy1H0O3AolwuvkRyyG7MgAhUN5U5XImoYn1Di4l6Az3Ciy6D9k0yaPLzNqFRPtwUj5XUQ404vQ0/1QTKYr+gm9XHg/gcbD2AwoDRYbhEI4AKNSd0lUSBfNvDUIgk9k7TfDkuHaPY1N87Ee74kpoJ/6WFyyKyFHFapyUERuOpdGjH7Zl+Ea5Qkc+qCWmK1otLKmJiE91ThGdPCi9Cbe84drD8cfLod9NoZKK1qNYVSMzdDM7ydOdnuatKgzNf3SZR+1KZJ6TssHj6k0N/UkX/NSEfHXHVcjzloQYoEw5oq8ndY6Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52536014)(508600001)(122000001)(7696005)(8936002)(64756008)(186003)(6506007)(86362001)(316002)(71200400001)(4744005)(55016002)(2906002)(88996005)(26005)(5660300002)(38100700002)(66946007)(66476007)(8676002)(66556008)(9686003)(33656002)(110136005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y5UEtybdZzPe2AiKJ1UN65I0t2OJYy/cNGwv4tQg5uYZOJUcXEdjspvIkg5i?=
 =?us-ascii?Q?w62XnClekkPycQsrjb1uRFhSfy4xzDLv0NYY5ABLiaBUw/vndwbiFSRUKglm?=
 =?us-ascii?Q?tiFzbJujAq5hRgC6gYVJn5SxIHKhUSiztsjG8eJVxNrUY5LrXdy+IdkoQInL?=
 =?us-ascii?Q?jvUNCnxisqFJo3D0Q/B9SXc9HJXgaQUHCVr83mWBLNIiHWe0PP9zPjCmunMl?=
 =?us-ascii?Q?JCL5L3IYPnsXQ/OIxqrfKvg9Bj9sh4ASqc4jkRKfn1gFCuo+fm84nSd6sssu?=
 =?us-ascii?Q?eu5OXgMSNPvvqUeCMa4uXQF7R+6D3uRGStInr3tanuyMYNDHual6SxLbzaCS?=
 =?us-ascii?Q?yyVMVBeZvSkloWY1AXKiR1XHqm1iOkNbv7gXpdYV6DLbaw2StEYgK9fbM3uc?=
 =?us-ascii?Q?fKp7bF3tsxg1sdEc7dFrWrgbc0Gk2+9oGVlepkmLuzxgz+hW/S8ucDZ+1dZF?=
 =?us-ascii?Q?xWBUneRSaBWWcQNCC+OZ8AgbhRLnjYY++NFk6hnIQsnR58rk5aqcgnxNC9pw?=
 =?us-ascii?Q?/qb6v53iX0ZRYFhZN0ZQkDuaH/5CEKM1bhKCOKMbeD4pvt4zX5sE8ZVSeZc3?=
 =?us-ascii?Q?jfaKadlFqjQuyX43jLkKXDu43pQicedmsjOgGdSHhL+7pzH5JJXnEd2VTKFD?=
 =?us-ascii?Q?453jKzB0XW4m8kJ+GL+wVlFn/O2khU/4U7J6tFfzgooSlpUi/rOysPkm4pkw?=
 =?us-ascii?Q?Zi192Ri0h0TYryaGeVZSUiw/CTSJWvnhytBdVxR9aCfRp15ECfplhmOHYQ4V?=
 =?us-ascii?Q?ooSGA/mkPFo+pihmXP8jMeQTYozKN/qHX1KZOmmndGHEzVrUu/pfKmnMphpV?=
 =?us-ascii?Q?dAqIQDBYWET8FpL/JNd+ffT0NMvYkU/N0GF1ZqpFevtfslBoOHZbEoT6tm/G?=
 =?us-ascii?Q?rLgTc2QEWAEMBo5F4eeQhkkSWMEH1WNACoGiWV/5tvcdM+cNWPwrHIbZMU8O?=
 =?us-ascii?Q?1NR/7+R2KktGtZ7qvF27dSFLkP3/MA+w7QpyaTo72pMOI0dqTDZ+7lt9h7Sr?=
 =?us-ascii?Q?nDVKcaFDwBLwZzcHlx0sc49/vxeNQcPISCyTNviNpXXKW7lRw2sEgJwBMHkL?=
 =?us-ascii?Q?QdccA41PzuIV2k0Lq+JhJGYF4YDnKyx9iDXg7dWmSzPJL1YYH1UQRcRVlT5L?=
 =?us-ascii?Q?hgzwFsAXV4BXJaWWnlPOAb7hz2hZleoG3dJM2aXx5+PwVuoUeT3jDckS76Ve?=
 =?us-ascii?Q?YqApklqNDYR/bNQTxd39iwnX2y7vYvnI+dY5kCV4ZYdH36aBEC8iM0FwqAVA?=
 =?us-ascii?Q?vjgIcI5TTWuUD2R/aXlA3A9SPRDiY0YrlUwugoS/ES8Fc9TycFIneSGigq18?=
 =?us-ascii?Q?qE7/rv2Ot75+pnP3avL/s9jf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86174c14-5121-4701-4f5d-08d993bb4171
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 11:17:51.4752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lchen@ambarella.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3830
X-Proofpoint-ORIG-GUID: Ld5N__AJps9-sh4VBgXlKjamzDxlULV6
X-Proofpoint-GUID: Ld5N__AJps9-sh4VBgXlKjamzDxlULV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_04,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200064
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Otherwise, the code will continue to error handle,
which is not excepted.

Signed-off-by: Li Chen <lchen@ambarella.com>
Signed-off-by: Xuliang Zhang <xlzhanga@ambarella.com>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/p=
ci/controller/cadence/pcie-cadence-plat.c
index 5fee0f89ab59..a224afadbcc0 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -127,6 +127,8 @@ static int cdns_plat_pcie_probe(struct platform_device =
*pdev)
 			goto err_init;
 	}
=20
+	return 0;
+
  err_init:
  err_get_sync:
 	pm_runtime_put_sync(dev);
--=20
2.33.0

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
