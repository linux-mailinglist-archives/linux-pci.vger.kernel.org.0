Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1450D47B8D2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 04:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhLUDHq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Dec 2021 22:07:46 -0500
Received: from mx0a-00622301.pphosted.com ([205.220.163.205]:15836 "EHLO
        mx0a-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhLUDHq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Dec 2021 22:07:46 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Dec 2021 22:07:46 EST
Received: from pps.filterd (m0241924.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BL2si7A028353;
        Mon, 20 Dec 2021 18:59:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to :
 subject : date : message-id : content-transfer-encoding : mime-version :
 content-type; s=com20210415pp;
 bh=Q9kgE7vuxKRIJtFK3m4RAdSJ5PDTufKcnsw7wpLcyaQ=;
 b=E1xBSPTq7RmCKSa8InOXD1rCHGJ4gybB2K7Nce+LDGd1+5w39tssi/57D+qP0j232Q30
 X51FYRV//h5eZLiNdTRuBWZFE1iaUu6+wzIENTQQy7BW88tWJZtMfCiHUwsopysTlncZ
 r0goDXFQZtCKeBgTlHuz10a0we/XcIQN0L0n6SZ5IinWf8x0RZfQ4kk2iYBcVeTGWkCn
 hhigECOS1905xeOTBWDuSYRvpaGGljYZQCvRRJeW/ak3WUH5KZ3ma22sasZ4hIatiaEF
 hGksDM3JOoruJ241qbY10dtmVPxcJnEqJ/RuaXaH5b96CIkr4XjQz5cNckEhQCFMB0b3 Ig== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3d2hx10egs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 18:59:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y85WK98BFTC1p21utsL4yeI8rkWmnNFduy+k1JBEH+EbnxXKbpanDwQwM9tL6k+1iLicsUkRdtZH8jJw5mJYBfxIR1cwLuF/+nIvIzhn/HM++O25rLVo4Zp875gNmz4XjZuDsjoKnOKvpuVIdVWim1++SaE5ONDtIMUOnmOF++Y8rebLYt18ePqn3XBUAJnjg9n8/lC8QNlbzKOJ1m0iamQefOVAZ0eiDetSIxJufx1wMXCELiKs5S6x5OuzpBvceJnn7WEC4LoAP86hoEslxwfSciM4y+Y7pJn91jpV1CDYK05FbPv5XRvgLxMI0q/FGV0FBkZ8rYjqxxrZhph/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPCO75iWv5AI9n0xqP/n9G3B39O0G0RAMKGUelSdHJA=;
 b=ZbsOGNF0ir31/HsIM0iQfi4/wgtGxQlnmX9+c56bx3JI4CwJ11XVpihi8Si2LUfj5RmwrbT9neilYfzzwrZwPSfplgd6JT6nFji56SNaTJrZ64YFOvOBMRSYkUtJOUCRyi/j3BGBQTf2+K7WSC+JUNktOk+6+h0bnjzSM86pKd0rg6uAXS/bqaiBr9E2erCPAeiaYkbm8psIp/G03zqhU4ylCCXrITgQ0MVTbQU+UvbEqhNNZ1CybUOvnR9NJeoMUGrjNhyPkUCgTcjSbCoPm5EgwUlpIHlXL8T6zhMQfw7GjcOD4O+vEp4NeGfy75wG6ve6rDc6AH4Swc/cKLNcmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPCO75iWv5AI9n0xqP/n9G3B39O0G0RAMKGUelSdHJA=;
 b=hj+FVgaUnfK5BVzn0+ToXsYEF0qewT1rud+2g0eKl8GLp4+9jehAG22d4VdZv0s8tj/gJhC/U6MIHOA10WOr7MThx27O7fptMO0hA21mhzQpZdhW7pq9f2GIRy8PoBDguoqNfDVf/JSd8zC1q7E8esqXDlzrON6hwvqvNY1agsg=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB3909.namprd19.prod.outlook.com (2603:10b6:610:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 02:59:56 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::3c65:8b89:ca42:d828]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::3c65:8b89:ca42:d828%6]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 02:59:56 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: [PATCH] PCI: endpoint: set_msi: return -EINVAL when interrupts num is
 smaller than 1
Thread-Topic: [PATCH] PCI: endpoint: set_msi: return -EINVAL when interrupts
 num is smaller than 1
Thread-Index: Adf2FiFmswPDWB/WQWCvxXrOLCbdxA==
Date:   Tue, 21 Dec 2021 02:59:56 +0000
Message-ID: <CH2PR19MB402491B9E503694DBCAC6005A07C9@CH2PR19MB4024.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e161b2d-7518-4493-f644-08d9c42df835
x-ms-traffictypediagnostic: CH2PR19MB3909:EE_
x-microsoft-antispam-prvs: <CH2PR19MB3909590E68545041FE50E3A4A07C9@CH2PR19MB3909.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dWg9e1q/Hj/rWd+Of29vUcbAqtR7MuLbCru4xNLfK1iVVfEPHIuE1WBxZIHwv8yWj0DP1E3qnDxGg/RTjCbucQJaXJCKDTa3wk3Xw/HWVHfv3tYmhSYXpLkS1cwHIgH60/XqaLQHmYGQupveIVSwdRTLVDcrLo52Yh9jGhNiw9Uc521KY6RvGxqUqMJuYiatISVkbdAJF5/UI7bT0HZ2mIEd2SCPxyjTxKUtRG3B3k055J1g3yJnUouUdM3yBw+iKopO34nSMXPjIHhdwIuiqcSBQV6NckWSitlfVr9OIpYvOzTUkGgjfT/rwvxrsi1rX6hUNSApwjmbyBOo/B1NAgzXUwtOM5fjHFdfefztko//7yLfR1GCXyCfmnKsBnm05Zr4sVe9h0jv3kl1Iqz2v5UPkoy/sJRTyJvPwmeuxRo3fiL/7uSnykoXAdAzxWFZUAKvVQ+CZjs99iJs1lZ728Nkk8YrmnS49N9RDgcZQHyUp5wochRntgp3LgsahBnIVpNS+Vhe9YlupiZNyPFKOIKa9vTuw5ns4logkhUFXdUmnYZCEhUauJTJxvTP69sRAhS2O15TMr7tOMdv+5X0FrqcZyuF/lqJutdiH/XpIbRiKkOoPEX7SGQTU6H+fXzUtLl2KVzkUkNT3fqXpgzBzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(88996005)(83380400001)(66556008)(64756008)(5660300002)(66946007)(86362001)(55016003)(71200400001)(66446008)(52536014)(4744005)(66476007)(8676002)(9686003)(33656002)(508600001)(7696005)(8936002)(6506007)(316002)(38100700002)(122000001)(110136005)(2906002)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?jX4FuxxvCcmV3Ilm05djkB5EHwvy6kvBYeqyLLyqy4tQrp5ormnvadaqg2?=
 =?iso-8859-2?Q?gYtgJOlnDFMh6ynmaQ0dTn5DdvAmWElCnWhwaR3FkOYsAbJxEKDxYFNnH/?=
 =?iso-8859-2?Q?S2FKo4VvLUhoFb15MjF9EIMEh8AltnXXtZkYUCuo3G8lrBLvGdMNHrqZZP?=
 =?iso-8859-2?Q?o9UMk29PaTaqnypmQa/WZhhFnEVyenCy2i+m8kGlNfoT3E+W/jmxpYHNG2?=
 =?iso-8859-2?Q?ttSqpWptNPB1i50qXqH+Vd5wtsIL8zFMXYtoB9OG4t22vOLQYFS/NfNpox?=
 =?iso-8859-2?Q?ppQV2fwJHHixxwSrXG8o+9N5/QaEBUOtRG0L3AqVimS1CWWchxGSOXpKJa?=
 =?iso-8859-2?Q?Y53Xdx5lqvgSnEM0aVqOORGNJsJzzI8DU23N7Gap6mBAotQvntAqxD92L7?=
 =?iso-8859-2?Q?PlplGaZHToXULmlN2FCiWvR817heIFiYyx9U6a8jZ6K1kEUR1iH90Lcq1T?=
 =?iso-8859-2?Q?ud/TIGv3CB/4lDkJ5EKYj0IC3vB6KIL/vGWVEg2W35fClKaqLheHxIi7tB?=
 =?iso-8859-2?Q?IimkcSZJCi5c/HX3E8EsZGbNNluxUFkMe2TyAP5mZGR4m23WGmGCFaZcr9?=
 =?iso-8859-2?Q?5Je3BnhH92w76mz07/ud1TmYuXImY6MNUC7T4eetQGk7GK5lyK/FyTUqtv?=
 =?iso-8859-2?Q?fsQdVEzGxeSSBKYpYm63+v+LxZ7ZsAyGaRjgUdSuqSAOFlE6qK0V8kwSKh?=
 =?iso-8859-2?Q?dtxqVrpDcSDqI/4GupVuwq/DllpWHKvNywxuRmwXo8Qag7ptqsdyEW9t8+?=
 =?iso-8859-2?Q?SpODsSInAVUfp1B+sjne5qFpBBIVMVOh8FREVhqk6e+1/znaA9LLQWVqWC?=
 =?iso-8859-2?Q?79yayO7kYzbCNKzlEzq6OweL3zaOHL4/E6f4qpE49CEDUuW1/lQ7uj4IAA?=
 =?iso-8859-2?Q?vHsw7NPC+ixRRRwFTo4TRCNdK37ixSVgOiJZWYqMncgyjQiU86ZO9zYj4X?=
 =?iso-8859-2?Q?UnckcrJV8WQpK4B0Fly2PyEI/kGAZTMVtd8+2VUlcytmR2gJqpL5lrzTe8?=
 =?iso-8859-2?Q?bXmC7LdGOfkJZb3nV4ZUYaLQN15V+sRtAn3nvbH7ntp19E5ZEETyu9vjE8?=
 =?iso-8859-2?Q?RZPtwWGsu7ntI53GKP7ejXcEn1bcHRz9QD1zFsfE9eRnWUvQiIZHTCsc06?=
 =?iso-8859-2?Q?ij8g0um/JMeP+KYn5k4O0d4Jz93gel+WHbD5neFJpACGZAXukxDZvSGVyv?=
 =?iso-8859-2?Q?AdKxxDhI+OLu9OppdH9fPLAE2/tM8IMduDtOCoqGDsCENNt1rsPlh5lN6G?=
 =?iso-8859-2?Q?Y3NT8WWTixdksykMEBeF6FsoahZdrC6jmTG+gfVN4r4tLPl0qcUwMUVdQB?=
 =?iso-8859-2?Q?nZDzUoI/09eVoNGp4QlipUipRmtqFu7qB9Ae/e+X5y4iu9WIBsOVpmoYOQ?=
 =?iso-8859-2?Q?i+iFK6VJQSn7xkqu5NMxKIXOsR43QEkCEdOMPxAQzsX5rKQIjifGC1qYbJ?=
 =?iso-8859-2?Q?hAzwFRSB2K8hwjbDd9dKOxSvBgnHtzTD1QVJm8nHq+oUSQBKtlKjX/qXk8?=
 =?iso-8859-2?Q?Q3zlcGDbCZ/E3QPvokJIpvp3e8ECktFE0ecCK7QNc+ZtJnIqpLRETmHwih?=
 =?iso-8859-2?Q?nN4wC9zMEbkvDbXYQKBBF84c9d99zbyuYUs9VJiBs0dg5rZn49bTsmKTls?=
 =?iso-8859-2?Q?t8jJACSDv/DaCvyekGO8j7RgGqp+Rn7b/Jh6XWT692dtI/4q9AeW4wZe9m?=
 =?iso-8859-2?Q?hPAxht0s+4P1cnBtUbQ=3D?=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e161b2d-7518-4493-f644-08d9c42df835
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 02:59:56.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDGrV0C69S8Ri1XmM79l7wu/fM7nDcrfezMl6Kg/kW3T7pqVOocgITDRCuoo7EoFWP2OMdilLrw8mmj3zoEdIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3909
X-Proofpoint-GUID: v6aGGrZw4PwudfGdi52h8YnsdEPZw_MI
X-Proofpoint-ORIG-GUID: v6aGGrZw4PwudfGdi52h8YnsdEPZw_MI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_01,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=660 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210011
Content-Type: text/plain; charset="iso-8859-2"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no sense to go further if we have no interrupts.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci=
-epc-core.c
index 38621558d3975..3bc9273d0a082 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -334,7 +334,7 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8=
 vfunc_no, u8 interrupts)
 	u8 encode_int;
=20
 	if (IS_ERR_OR_NULL(epc) || func_no >=3D epc->max_functions ||
-	    interrupts > 32)
+	    interrupts < 1 || interrupts > 32)
 		return -EINVAL;
=20
 	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
--=20
2.34.1

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
