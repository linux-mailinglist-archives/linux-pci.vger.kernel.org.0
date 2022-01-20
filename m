Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25724945D2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 03:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbiATCbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 21:31:11 -0500
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:3806 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232373AbiATCbK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 21:31:10 -0500
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K0vBsl032271;
        Thu, 20 Jan 2022 02:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=com20210415pp;
 bh=A5CTq2JHkJfhsZktrwJTCGJQK5l8ubYowxvFFW9Ntzk=;
 b=muVaGzewgAZJR9RNilQ+yD+ia/5CeCokfF4j+fBHUtb12ShNV/sxoc+3qyN/5xY6Z7VS
 CsXoKNYF8jYM1Ko7GW4w4ueP1IHiwN9dWjWk84gBiXynQ00S/zUCXqnrfVkfVeSWyp8W
 L33/yzkT2axD+S3MyNG1P1CW6RUCFKWI/QEfdSJmgf+5KzLr9owPMF7aszCo8k67+Hvc
 fOARQO98Vc8o+6gaVG5q/mLlyWrfVQQ+kgYzSrxTrvx5vWP4PBdwfrQTww4GfapflQQk
 7XkJ/5oDQMJAevLpri//p75Zyq7U4L7SS1i17Theeu1LYwpjBpjWyuq2OyE+so+GNK20 hw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-00622301.pphosted.com (PPS) with ESMTPS id 3dp4220hy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 02:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUArcf54RA2IIUX5yF2hsL1SIwSflWbAMThoVlWuQBYbFcB830GoZY+yGk5xa4T3G8FrwCVZznlYYu+ywqV0oRfI4PHDnhXnJSH2jI0t9q5R5A3kmv0So6g22qu1Hk5B7BFbP1b7LOYnGaT18r1L/3WBjCwh7C+0RmOU8Mg46KbE0h4KQjjL4bhzPGWLXKJl3HKZOaoqHGqKut//SDHESXPa56Cag9Nrj+LcrGAVhKfGGHZUTZox2/1tgovAp0NbZ4ZnQak8xDPi4ArFQdVvDHg8t+bHnEH1T/o1EmMDXKQLVSyAehknQ3aFaRbGnRHZDbg1KCjrT4iDzJwUVJOGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aDhmoeq+lu8OXBAHNSfHnzJwnWsTZUiV8hdsI83V84=;
 b=erESF8OqUUK/v+8kQq5FmS63iQK6L7Sx0y09jOhYpWItM1A3b5UtuB2+VjsFRCjasAvLrMikQCAR+b2oyelGN70b5Szur/14Dwond47sf+G4k4xMjohaAygdujpN1UJl055oeIo0RQQ4lAO+1CYj5+TjZ/mhJ6hGOxF9l6F05llTkGOnOOx7sBsq4zT9a50aDu7wunDT0LsbYsBphXEP+ndtceeEXVmWPr/NkRg5Rqqmhj7t34fRuSdafijm1pPJ4hy9TPBmmf/4M1wVkZHGZC4KaFBS3Pi4JY2tgcAcfulnRzeIUgvbwO8PygqoSRnHq6Lelmk5+w/loMpA9lloWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aDhmoeq+lu8OXBAHNSfHnzJwnWsTZUiV8hdsI83V84=;
 b=KzC8eCkCR/sre/i8amWzUX0L3GOy7zPpbus5PL/8+qnYOHLTYpQ6GyONRy4XreQsnnJilUGO/lFHNW2Krc+Sv1YMFHjcMnZ/Xceh7+yK+EadydO784bt7Z6hayTavoysAtFhBZbNhBSFzllsNvf7Lrt4JqrSXGfkdefcUvDKfl1rd1pHeITnSJybCdjWAuJTS8Lcg5797ODUtJCHozXoyM6it6PamrCn4EiAeJEODrrfx6tvt4cL3nPLiH0erbkFs/0SCAtWAbHbNERekhVHhEeCLk3iOU1Ki1vNfd8DR8M4bzxE8KJv1DA1bp8MT2CkVknIosm3T8p9c68nSePdPA==
Received: from PH7PR19MB5562.namprd19.prod.outlook.com (2603:10b6:510:132::22)
 by BN0PR19MB5328.namprd19.prod.outlook.com (2603:10b6:408:15b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 02:30:39 +0000
Received: from PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959]) by PH7PR19MB5562.namprd19.prod.outlook.com
 ([fe80::8c3a:e80f:9fe7:959%6]) with mapi id 15.20.4888.013; Thu, 20 Jan 2022
 02:30:39 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] PCI: endpoint: Add prefetch BAR support
Thread-Topic: [PATCH v3] PCI: endpoint: Add prefetch BAR support
Thread-Index: AdgNpbRFMbwlAAdrR8SridNp8fgVlA==
Date:   Thu, 20 Jan 2022 02:30:39 +0000
Message-ID: <PH7PR19MB556226840B8D47D74B65062EA05A9@PH7PR19MB5562.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ec46448-5350-4dd7-9288-08d9dbbcd93b
x-ms-traffictypediagnostic: BN0PR19MB5328:EE_
x-microsoft-antispam-prvs: <BN0PR19MB53283B9F3A7B30C4F8D3FF52A05A9@BN0PR19MB5328.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ud7hyiST+ppwRNJmWIQvNkBQKNsZjCpAB+ste/TSCeeuQ3lWcOXmkzMHvIUOldWasapus+vEGbSAOg9oE5jRalC7eDU5Qa+ugKkSbRFtBL7K01RmDJB8AW+pORiUG1SSVTjUeyfHs59YBjRZ0C8XNZjJz+UnDnsHcH23kGOqdhKAn/ZeNx5Y4H7qu1kVISn7DHXrJH+GktCbgHqN99Skc/MqUJgkQKpFjSuF2Uq9zi9tN6ZPz2ma4RP4he/rWqwJf7mZ2jylucm5J9OQIfqKJkAFlBkDx8EJtUxP1b/dnQ9zE6A3/MvJOIsUDBG6zvfqFzuDNvKLd+UkCEajSnDCib1T+5BXA0x+kyLVaQuqhuhGv7f6J2TEItAcypXZOQHfyoegahK9zosKTqmm1acpTn2EGm2DL55m0n0I5V3obPJyYoNp/JNb63BK/O2b8QYxkljbaWuCi3lhTqVxCnwVBuGbImnYNA2jgGsSRvhmMj0mbyboIfbfTQNoP/defAqXpj6VtHJdG8ZRjUEv7DFZ26MCazeuBoxlDBS6iwZLvHSF+87QwMX3oKbEc6Ss53GZhjLUm+dhnML80ghrPYSEVtkAz92stRq/aErtAJvO3gUVi6987pqZUaTIzwTkTsp+yHKICIG8IhOt6fSegmBY1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5562.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(186003)(86362001)(9686003)(122000001)(52536014)(6916009)(33656002)(54906003)(38100700002)(55016003)(4326008)(8676002)(7696005)(5660300002)(66946007)(508600001)(71200400001)(66446008)(88996005)(8936002)(66476007)(64756008)(2906002)(66556008)(6506007)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?02aHHjzaBirzLzwNvNy88VBH+C2eMkS/mDWdyaeyhbym0CTQOFDgemO0KhfI?=
 =?us-ascii?Q?4xZM8NPGrOB81mTNmpH2eeGHSp69/2s31fR2Ii/phLMNPuiTqCxnJGKsYGgj?=
 =?us-ascii?Q?5qT0Dgz0W0jCiUsSKrzIB51xQ2yqOp9EtKbw9aKNLIeAjseZpJro3k7VJaiN?=
 =?us-ascii?Q?kv6SiBxhfQB8OT3ahoxn/PipcpobxL4AhL3LyefpVoo9puYiLARhMnzpMMf6?=
 =?us-ascii?Q?O996KM6ILRjmTQ7WtMmBaQa/bHk0WAIaKmGJYS5EWxcCa3dPygXeFKXJ6rv7?=
 =?us-ascii?Q?DjG4dJ2Wag7rZZHHAOMpetmS8D05iCuhixnZUjlUlq6LZI/ouwFYFS2KqUZP?=
 =?us-ascii?Q?d3OwgSLTcCKAdnsSRt7IcUH2puRcDYl2jC/K3A9TbeEMV1tC2LHApaW6Nkip?=
 =?us-ascii?Q?fI+598C44A4k5CsD4eF3M9koY4Au8yaGq57hg6RRlZ2nlp/ZZ0ICL3wLSIGQ?=
 =?us-ascii?Q?TWEdbm57qDGkqmfd/J4ElhmcV8aBRZIElT95SzQVcT44QRj+02tyX4w+PPii?=
 =?us-ascii?Q?a98uBVxZhx9wSNPRx9QG0jKS5qgP+57X/oGXBQW5DdVOVNplg38Z8pT1gsRI?=
 =?us-ascii?Q?QBFhWV/n331btPY1mrfyd1WelPh8tG5CSDaUXHlbFQNRm94HdDTedo4AxNB0?=
 =?us-ascii?Q?GbjdLmKzsft8PaoRFhD8HsfekhM4HLP6TjEelcov2wFesnPwueK/0kktLq4+?=
 =?us-ascii?Q?0cmCCBOtQ2T01+N4cwnXjJnK5OuWonKY7NwXWY7rd5x8NEHowztQGHD3OGu7?=
 =?us-ascii?Q?NcaTEvXmwek/6S19Dvy2Tgd4+wzlaOhxvZ7uF8BbV4MralUM+shEzJKvVCf0?=
 =?us-ascii?Q?Zia1a/Y2b/FVFUUPKF1FaH/E+PZVr+3anbhA3tL4ByLZZcVib6GyBeWQxe7K?=
 =?us-ascii?Q?6VGATzJrjAFrdyLhep0rBtCASLWXyDnrVspU6rNxgm6p8DZWooOsnvo3t6sf?=
 =?us-ascii?Q?CcCK4ILJDGY90BmYuNSkX0eLM+VT2eD2NUFp+l5Gmygqn6dlYcNuWMCWGsOn?=
 =?us-ascii?Q?9L8gLeh270BtTe/8qrVW3+Scw4jb3swEdJegiWgNKdJZChjfuLR0lDg82tTh?=
 =?us-ascii?Q?UqvQ7QMgsLZTv06SNwDn6Oxp48TrgkPjQ/Hux9nEGCZPJXB55EvA9usnDR70?=
 =?us-ascii?Q?ZKgjguHMChaPsPAYJ8DjLWEMvBVHEW2Keq0rR14V15aWW4QHj7TmJiCNattI?=
 =?us-ascii?Q?g+0NfWvwjNDF75yfXHoALhOTvE8Ak66u6mBcFYAiKMsQ1vM7I/EN33urMohQ?=
 =?us-ascii?Q?VngNd0tuRrrN0oNYk1BN4z+F+1GLMHzczbNhzeDsibO+q/h04SGoRp/8pLQI?=
 =?us-ascii?Q?P1MGbvfuj7+1j26uS/Z5UBmZXNdEEmTFBUjvIEaa7ACAUqum3nwp5vrTuY6F?=
 =?us-ascii?Q?u9mFcMYF28v7pe7djJCCWEeu9feNe1V9x9+l+mGiVlqjwaOekIYWo+D3j7GN?=
 =?us-ascii?Q?dqcDbFPkDXA3SgXS6eyHWkjYcZJccIgW6xwNyXIN7C2DODR7/Ws/mvcWfWw7?=
 =?us-ascii?Q?QG5Y7+HQ4XyGVspw/f8SdCdug19BCLSXNKlfoWF5NQfbvDVj3MGDKJDSXCLo?=
 =?us-ascii?Q?asXPKsRz5B8EPbtvNZ5+P1Zz15WFfkR4LXN8kKPhyhqecLqXoB553xqAzqvv?=
 =?us-ascii?Q?/35B+6n1hFDSG6p2M0KhMF0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5562.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec46448-5350-4dd7-9288-08d9dbbcd93b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 02:30:39.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /E8SIqExyhAChKCry6d0HcdJ5/fH9lkIBw7sx4kEnY+REEaf+SVDQ8xTof+sTUzZDAzyWbHjuH7W6TsVdSu0ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR19MB5328
X-Proofpoint-GUID: H8O7qriCkPvx0K3f0zqgIV56Fz7YCrIu
X-Proofpoint-ORIG-GUID: H8O7qriCkPvx0K3f0zqgIV56Fz7YCrIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_12,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 mlxlogscore=952 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200012
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Before this commit, epf cannot set BAR to be prefetchable.
Prefetchable BAR can also help epf device to use bridge's
prefetch memory window.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
Changes in v2:
Remove Gerrit Change-id
Changes in v3:
capitalize "BAR" in the subject and commit log as suggested by Bjorn.

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
