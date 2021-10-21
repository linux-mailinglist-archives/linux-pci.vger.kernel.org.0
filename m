Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F544358BC
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 04:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhJUDA6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 23:00:58 -0400
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:59244 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhJUDA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 23:00:58 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Oct 2021 23:00:58 EDT
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L1peBW002474;
        Wed, 20 Oct 2021 19:50:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=com20210415pp;
 bh=n/38vW33hgZ6Mn76dP60GwXHA3a3aEyHbO5WGUAmrJY=;
 b=JfNTTx1XJ+XM1zN66OLuxz8ELIypOsYZQuS3kEQFjS1gpEgbrInAGaxRBbo1hQle+Jkj
 wbT7HDi1L1KyLg7jsdiiyWvskUbIiv9P9pxJtJtFvOsHsUsPuMp82UY3SO4BEn/Kidi8
 oJE+dSYL6GMsNmlmHhWTIC1maY1fVsd8BNwGt32HJdXA4U9O1rpYh5E4EXa8ivsDXh2Z
 gQTFZpal+lpPI4IVkG1KhRgan+6Tt5l6FQucdRKiSQwm13U0sW2W+VJCFs1fTM6zReuK
 KQIQB4f4+nMdeSyFYF7eyDz+/vyowNr1UvcMh/DPzEr72pDtTVcndap7N/YezDX8HLKG kA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00622301.pphosted.com with ESMTP id 3btneb88sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 19:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBmOaIah3qPWICJ7JNB3FEmHPOHv0XXX8eDPhdSI9v1/CUc9KxRGJj8fUMvBvQomHnfAERllYlcyMLrXDFegBuxxNZuCdcaZ5SOnD+H9FguUVGB0dFMGcXsH5MGO5aq66guKY7YiduCLZG1h3vEMYQpWjnkXxUdQgi4xuO1OUIz9/shH/X+qI7u/0ZzBYv96QS5gOFtzaQtx21oIdUppskBQe+H4xNh0E1UJgS0EMoYJFlZZ57qXvMNTasNehcqanii0pExweVmJYfe90NMxqwr6us/5/31/nslxt8U2vqU8jOWyMJp+xyCxNHtVPz19FGMeP7sxcLJKUsN4QOcyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjX/2C2E2gATfztiAKi6cjOzhWZU29a4kzacng/sjxw=;
 b=WCEuOllhAbq02SamqiOUojN2bk+lhvCHDGsxcXb9/i2SYVZikhDQZrI1TpHzhNLF7emwOpEg4SkNS2magj1kBADYMey98CEW+nleh8MbuTj/MBJQDmgTl6cJes93wCGHDTz0YHHheVWbGSw0rgiM3FiJWzZDC700aHdP6kDdb1/PW1v3R9zREdSvpTMGE21hMz3c+dt1qsglNo+TFizXGGTELLzBo/QS3t0QtFMA9UQbT8vwJP07VJIlCbwo4RTMFdEi1nAHhx+P1vcgYU71yI0Zk9UmgxLleZq5nq9I038i1rlq4683h6cIURSp6hw/C8ek1q2mL+Z+JMfRo0mEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjX/2C2E2gATfztiAKi6cjOzhWZU29a4kzacng/sjxw=;
 b=ZCmnjYg2iy5eCk46Kz4ZIXl2McL2xSjtXgNvrjIQa7U+RYSOCI2E7Aq4/qPEp/UzjBD9Jy39IlD9acoWZ5CTTpALmxGCxpviZUInqTl3nfW7birgWifHDy0bTgtGvvU02kZfJoINxkW5LD+w0RFUzJlmiAEQQd14cSXBd9MpPus=
Received: from DM6PR19MB4027.namprd19.prod.outlook.com (2603:10b6:5:248::20)
 by DM5PR19MB1228.namprd19.prod.outlook.com (2603:10b6:3:b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 02:50:20 +0000
Received: from DM6PR19MB4027.namprd19.prod.outlook.com
 ([fe80::29e3:491b:caaa:8cef]) by DM6PR19MB4027.namprd19.prod.outlook.com
 ([fe80::29e3:491b:caaa:8cef%4]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 02:50:19 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCI: cadence: Add missing return in cdns_plat_pcie_probe()
Thread-Topic: [PATCH v2] PCI: cadence: Add missing return in
 cdns_plat_pcie_probe()
Thread-Index: AdfGJXsneGNhzEUJSnSJFpIT3qRvIQ==
Date:   Thu, 21 Oct 2021 02:50:19 +0000
Message-ID: <DM6PR19MB40271B93057D949310F0B0EDA0BF9@DM6PR19MB4027.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98f4c2f2-57be-4e8f-43e1-08d9943d8549
x-ms-traffictypediagnostic: DM5PR19MB1228:
x-microsoft-antispam-prvs: <DM5PR19MB12288D2E3B6D005D75EF21DFA0BF9@DM5PR19MB1228.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j6K3ESdjmACEnf0/Qeq0pMrEyYkGOy+kjSWwtsGaj3qYB8dlvVR3kT70VVxz6UG0j7XFcBcCgT+9qIbcncktCH6+7/v5QrqsEJVrjM4VKu2T0hoz6zfEVIp7Fr/GBIJ4A6rSY1zS8qIiNulpYBCxpB3/+Cnfc64dhEboDixisBe0Dz2n9Gwi5Lu6MU20at+pZjb6dqBEEyJgANDmRP1Oj3nj+m8H2pfE79KZy8A2KLz07oP7BY3BMJ6nLiHehViPTIAnTHElTzo/d4I1g3WZW1/o9Crl7SWIKQ65C46l+1tAmhYPkwCTCHbO+C925wK3rw+ZB5XJHjgCg4M0fYDjYfKlUFM1Oqp8bIaDpJUu7cWsgjgjfx4Ya/3KJq3GpzMo7as2AXKx6equzdbEJtzNurTY2330jJhCAtqHy4PUCuJi3qElyt/VE3D4CQfdyhR1PkHz9uzbuZtFmcAg7KvYd/PMkYgkBoCEgJvs/BtNULZCXsIxfV2HS6BffiPmUQ01PSVhJRBEf58+/pHa4sN1p+hBeWir+ZXNN/r6+2/9utMNbXxn2xGUxQE1JiUG9lTyCjus6QgzrzZkbpryLr/EkrgJ+74KFzyp7BfBy2v4QfBNHtpy8V4ikX6HqA0qZqgVTnSA1JQC1O969VFTIfm4oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB4027.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(122000001)(54906003)(8936002)(4326008)(66446008)(64756008)(66556008)(66476007)(6916009)(8676002)(5660300002)(2906002)(33656002)(66946007)(71200400001)(86362001)(186003)(316002)(38100700002)(4744005)(52536014)(55016002)(9686003)(508600001)(26005)(7696005)(6506007)(88996005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d58t3fffoAii28bbOcJHkf7kJAjnjNactOOWnMGWAt9Yn28TTlAwnU7+9Dsx?=
 =?us-ascii?Q?eElnxUsZEp4S62ZxPaMJR2cXWXh5UnBOKQOnsiCggjKwsUQ/XWgAGOAKT9XO?=
 =?us-ascii?Q?15zqNpRQOt7PP+I8cxpbTWdiFrnH+wbA+F4MzW5SEVbFvKp+dhdJrgnjRxwz?=
 =?us-ascii?Q?ziBI4XGxKPezj9b9Kl6IOojXLu75tTwt/cGiRB6YJVIvZ+R//SZ5chAJ+Ot7?=
 =?us-ascii?Q?t5zmvWLnHdB52g9EbVRq+KOhuzSCpQGNZJ3RStxcXeL4CD2BJ7MCF29oIhAZ?=
 =?us-ascii?Q?2i1Rre0pjAbg6Q9TClWGqirNn+OJgHbOf+nm1Pphu1eB54YScuZ8qLVJMvHO?=
 =?us-ascii?Q?mpDPwCrcbw7BnyxEHD9piyRVf1Gym4yyHfu/L5IAkoBa1pIcB5BxXfvzJI2A?=
 =?us-ascii?Q?rZyfOFfqQFrppup2uaMMSuLIa+pkvkXCqMKOdFaH1Vn1o86lOYhZ0tgl0vbJ?=
 =?us-ascii?Q?XA9m7DIOSpz2d4DeamH1x1fvWECCdQsWw17sDkVRMsBLaVT8iTMDETgMH47Z?=
 =?us-ascii?Q?i91Y3TgVhezyWbKwyd0gKyaLeQsKuJJevJbzj6zYtemdG7nQboIP+frxToNZ?=
 =?us-ascii?Q?hDBEEWH3FpzH6KfYcY9UpsPL7GJvoCGdxMI7FjPrnxicmY8jUDnOceMCGzUm?=
 =?us-ascii?Q?/8UD8QTP1alWIR74x3sOVLJqtvih/QxFOMn0+rqjvbcnmNyXJC5Oc3k6nM9d?=
 =?us-ascii?Q?UiUYbBhE5uCXCog+wJhDQmHkBZFj066h6awzY8WMLL93FepW5mQBX2LIlgqN?=
 =?us-ascii?Q?OYlQMNh8zb/vhhpKD23TKR8QXNJNJu/y3Af77aFx9+s2gmBqd2EegJ56suUj?=
 =?us-ascii?Q?aDvIasb2NR2qXW5de7VvdoktfbGSAmGRg8VYm6lAaS1qqqV/SOWfFk999vhe?=
 =?us-ascii?Q?bs5JJle8NI0bTKBdo7KgjpTXbze2PTuO7bXa2yfjkoGPR9eDI6frk24xYG9J?=
 =?us-ascii?Q?YozMvc1Jb/XEYHBfWT4xV2Ytu7zNU7kLpHcQuJrvlq/VNjvAeRbPa41Kgzu3?=
 =?us-ascii?Q?xY7HT0QacBx5Jb+XLfos7dR9yeVnLxjVF1X8eFLJg/D1Im0/V1ZaNm44c4vh?=
 =?us-ascii?Q?KnJlIODyxkiO6Y5hlnP5bp7LfkxsKDn0FYEcgUFci8Bklq+hkAtM5A/QS6qv?=
 =?us-ascii?Q?/3oN0NHC31URmAMQVgYO/yB83eP0wQbc5qWdGb8+WEOk0IctbI2y+YuyYCyF?=
 =?us-ascii?Q?9pIUt26tY1qIUiBJUC9fn7UK9ff0KECP1Rh4ivSvBX1LQVLHnb1ee42C5doT?=
 =?us-ascii?Q?auN/eKvlypmasA8djXO1yIhOqNp5WBdanZgM3HaeHou2LdSx44JF4B0xj9Ay?=
 =?us-ascii?Q?qy+oiTsf5mcZ4uEKLEwO+WXn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4027.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f4c2f2-57be-4e8f-43e1-08d9943d8549
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 02:50:19.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lchen@ambarella.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1228
X-Proofpoint-ORIG-GUID: Pk_BHD4gIWaJN-rEml9dDz17GvY0fB_F
X-Proofpoint-GUID: Pk_BHD4gIWaJN-rEml9dDz17GvY0fB_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501 adultscore=0
 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210011
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When cdns_plat_pcie_probe() succeeds, return success instead of
falling into the error handling code.

Signed-off-by: Xuliang Zhang <xlzhanga@ambarella.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core librar=
y")
Cc: stable@vger.kernel.org
Signed-off-by: Li Chen <lchen@ambarella.com>
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
