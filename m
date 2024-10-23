Return-Path: <linux-pci+bounces-15108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DBC9AC2EB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 11:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500F8284753
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D2381BA;
	Wed, 23 Oct 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="kEblY6tv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B441922CA;
	Wed, 23 Oct 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674402; cv=fail; b=oDJsP9BT3P9Ca+ZTIlmYH4BuvAzhLb2gSjTgTe/hCWmxdXRJLfR0rn3ad96+GQ5fkOlLxZbOGttd5BOO2RTJPNO/UFeIwdTFNt2zCSZTkWy8uUDDYuZaK/QJCy61oRZBewR5gKXWir8gXi1O8rdBqweM7/FA0crcYp8fI2IqDpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674402; c=relaxed/simple;
	bh=ndxwhgKyZeNKoqLy/I7HU02ddWsP2TLmdd5jlkkcYk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QexZK7QlxPTfVUkBkii6sWd6wt6gWABmpVGrNBvn9u/vL1RN/q1hVhfylQzhZXVLWsUgy9cMlzQSPO872Uv8hIDXcphVTDsOV/C0zctEiY4+TsVA55DPIjqGMFrSaUjogB+33zordRORfHJa1Laydd3MW3uo2S+/1sv1EstSqbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=kEblY6tv; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N5nAKW009037;
	Wed, 23 Oct 2024 02:06:25 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42euavgdhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 02:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/ftuFBa9kpO0cq7mBgWTYKz7/ZWDQ7VQLCY8qWroc0Yez0k+Gq57bMUawIapLvnvkV5T5P4kggbLfYoqYPnowF7ENeArS6ZHBJgfoljfJ0o4b33uMlwL2PoLoQYWEC8xaDKjRkQhjUu5P+MRBiAQE04iDrTEH9J5u/s60x7xgiFO+0XbgeWxRZSQH4DxMqkvAnNxjKGQws3W80VprnIozIkQQQ+jjvFG4KlTnRYneu7q96+8ZKGTGxoV9BWhdmuCQlB/+ROFQN6AiqwaluOrKoNDUkKILEtBRejEJqEHKo+yTYl+hJkapU9BgDM+Qi0uJ2EblaW7kskxvseiDpQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoHSBO7wErysWVq+EDdmZPYJnkReaQyqoJK/6nzeEfU=;
 b=YKzHwBaz8+Fl7ZrGbWFun1aj/7zgKb17iJPAo/7P/KcYFZViXAEDhxpXjEeh0bkcm14enUXgSg///ad4ewaPs+pPdWeTNaacFxMSPls+fCN0pjosAyjJoNqwa44DTl+dfN/V0BTnnWzvOjdCprFAbxemGjQf4atGo8KIBwr+UudhtDBvxoVwBBJL/W4xEaeakiwhUXK1w93pM9KxgeNttUz1GKZIcwM85OI36UMd+DhyhmCej8a99tJn1AFt1K9FAliXBhD5DQDuuXU2lgEEVkQqrl6ptNfPbur+OwNLos1yRkAleMfWATzy1FBmDexxLIsuAoRvZ7pfoDSe9aaPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoHSBO7wErysWVq+EDdmZPYJnkReaQyqoJK/6nzeEfU=;
 b=kEblY6tveooIwjU6yl8aMj11Kawx+0QDTksZQ07qlk8xSlTAOcHbcMqqIpICLuc7IUm2+o5WYnVwD8HCZGtvxXrEJMJ+0JzwFYaHdJI8Dqr//6Zqv5g5LwVeo/Rzfjc4pO0Zd5UEj1ckKTvtT4JqiwoifXuhEfhXALbr+KDvNWs=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by CH3PR18MB5403.namprd18.prod.outlook.com (2603:10b6:610:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 09:06:19 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 09:06:19 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: RE: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH v3] PCI: hotplug: Add OCTEON PCI hotplug controller
 driver
Thread-Index: AQHa96U5wMquoeCkjUiLMha3b4gFCrJZ8y0AgBAoL7CAHFZOMIAN9GUw
Date: Wed, 23 Oct 2024 09:06:19 +0000
Message-ID:
 <PH0PR18MB4425E62B53F58BF18C1FA102D94D2@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20240823052251.1087505-1-sthotton@marvell.com>
 <20240826104531.1232136-1-sthotton@marvell.com>
 <PH0PR18MB4425913FD7CCB42864311F52D9602@PH0PR18MB4425.namprd18.prod.outlook.com>
 <PH0PR18MB44255522F80C7113038EB8A3D96A2@PH0PR18MB4425.namprd18.prod.outlook.com>
 <PH0PR18MB4425833D3D768EA6558ACEBBD9442@PH0PR18MB4425.namprd18.prod.outlook.com>
In-Reply-To:
 <PH0PR18MB4425833D3D768EA6558ACEBBD9442@PH0PR18MB4425.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|CH3PR18MB5403:EE_
x-ms-office365-filtering-correlation-id: bf6fbbc4-21c8-4ceb-80e0-08dcf341f55b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hD6wGtt0lQIYpq+ExLYDJ+Jh1UROXIuLyipTmznHYOEkjwVqGRgAeaFw/iRr?=
 =?us-ascii?Q?Tb91lM5rUXd4gbaB1sILi7aGOzK+UXdIg73hDTetqgXu4wFiqnmnxeSy8p2J?=
 =?us-ascii?Q?TeiB5gmluPyhsSWJQat+Yf7CxNzdY528jiibgwJ3bZzzxpqspNG4lQj0hbIT?=
 =?us-ascii?Q?FvNy1xBl4ceDz4pJxuC3p0v5QUB0Ho5cxFblJF5HBLAigvGsFsamzB7r7bN9?=
 =?us-ascii?Q?CvKyd1VuuQ1vp2I7Aef5cuu1Th6487EFO0RRD8U0M/drtBKd3mO8jGIqwr2i?=
 =?us-ascii?Q?jowTpLWxE8R0LkzzEqMa/yJRqW4iyQugU9HYEafTxy8wtLh7nUj6rak7jY8w?=
 =?us-ascii?Q?/KJOl2WrFZHVSddPIlbgLO3njST3Tn6ZUkSowuy7ixJ+ucJeSk02Grr9JveW?=
 =?us-ascii?Q?h7tzCh+k8CVJ2qHN5AIYQ49vnE+4Tq+DE4YuxDmaOIvna+q+XT40BK0Qtl/M?=
 =?us-ascii?Q?/MlhyuNkURiS4mEkbkyq1IafiT6WgN11RpoP+yp9swR9kqBYQE3KKvTNJwoJ?=
 =?us-ascii?Q?E49HycogZm3XC8fGoXe0O8e0Z2hvY7JTSMGxzK6LW6oME3iezf8G+w53HTql?=
 =?us-ascii?Q?UeQoylVA6y4BTW2DLy2nv33io7d9RyEJC5EarC4VI6r5bfBbbqVPtqowZf3w?=
 =?us-ascii?Q?/OXaiPfenB2/8pxWaHz2s0BkVq8wLgN4ZJNcv8BKXb0RDCE/wqtennHIGMC7?=
 =?us-ascii?Q?qGbhlv6zu5yEnfFcnQQMGJnj4/JkfosoEsIh3daicu7xzQLDmO9yvT9sdleS?=
 =?us-ascii?Q?MhInpFrg9sukMiuMHrlz1M+STolnluogaVe/dw+7obCxmswebdTBghkHRhsz?=
 =?us-ascii?Q?lFg8HT5/PckiOQ9yFRNPJupU44dvajGXYU4/Q8/aITsd5GmlQyRuiVcOs4rC?=
 =?us-ascii?Q?5MNNiBCjkZdvjhqezTxVL5KePVjtvxGI0NSJn6mrtlw5eBVTSYJ4ewx7iNF7?=
 =?us-ascii?Q?Q/hurSvXckInrGj+AqI6pFPW6wsXX1IylEHniekOm4bS6OsTxBET/LucBVOw?=
 =?us-ascii?Q?hxEgqWmHJkegQKx5NV7jCuFonX59WoPlqYyjbJCRfhDeABI1wMQlW8iLP+t4?=
 =?us-ascii?Q?1zOusC9attiJ0PCWIJI3q9XnAc8GuLYXwjBVvkcvHRuO3hBzoFAgSL3g5mte?=
 =?us-ascii?Q?CUpjHusiMlJyFeRnuOZO+fejDxIeb8/hWkMSI+iZ70w6h+8r6TIgXc/QgaVW?=
 =?us-ascii?Q?T9k3QX4pbWrJitQRsA9sgkqx78768urRYFaRnuDFJhc/v28upKKHQ0nou9tW?=
 =?us-ascii?Q?N4g6SBMCLwpQPinyHAgzzuiP+6YjlVZE8dbt8pJBKG9lQBjbSpU+aHZAytrA?=
 =?us-ascii?Q?RzPAB53x6RQEAavhH+PYV1/+eZ+TPpcmEc5HzAcTx9DR+Bdlec8TqZ1e47LF?=
 =?us-ascii?Q?bbVeNYw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZDri71Psj2aqqHYIoi8rebmFKXse1C11rGCF3jGjXdPgysPXbUrXR3L56gRV?=
 =?us-ascii?Q?//I3YJiv0AWghT1JwiDWRaD3+MlUas7tOB2vFdoU/1IZjgtAIcEmkMUz2dGd?=
 =?us-ascii?Q?dyBLN9VtIQDZtMlJN/YKk78rjVOU1ec3uaSUfo6Lb8oXG0T9RrqKWaXzTrDs?=
 =?us-ascii?Q?obhc5sXvc8U5XVaXyBuYMAmQ+0oeLjLp/SbH56hD4dhOZUpNGYEFBWIHtK/9?=
 =?us-ascii?Q?uUH/VqWVyY05s31Uz0RG374jzeTk233OoQZtcjVpnNby/FPhdMqU1FmHWByY?=
 =?us-ascii?Q?H7tF/Ab8IzcTqQmnreSyBDf+qXipmTNyml3zaLf46nQHxMdBz1awsGb0+ibY?=
 =?us-ascii?Q?XtJ0DYNReHwRubyVGy0OFjo0Vk8kCOKtX40vTbW7uToD0bYQrV6/X0Ei9ZJK?=
 =?us-ascii?Q?e2FYWxcgYyerCEN5afPXnze/I4mTlnh2uYfzyJN0sIkAfhbmYGhY4uScFTiZ?=
 =?us-ascii?Q?WPhNqbrxSHkulT7qwEJVe85aJJOLxHO/dItMCuuUmqkvczteqQg/XXx6Z7QK?=
 =?us-ascii?Q?ex5W93jKp67N/8DV4gIVC0jjKeRwvggs9UUc2w62PhMNipD2fHyiwtwh5hbd?=
 =?us-ascii?Q?93O3iy6b9cVfDtNJ+0WVBwvTGsH42gOX//viLOzpS7VKne7pPQ26pczxV/wV?=
 =?us-ascii?Q?XRo7u1B3QtMcwbSZwyhCh+nMzMTxFUAAmIkZwsAf8CRRcT62CutFn6DQwJTk?=
 =?us-ascii?Q?sismVTsRO9HHeBYqPkNwwqhChxosvHK2WY4POTtHEV+F7JqN9aR3H9bky6/Y?=
 =?us-ascii?Q?IiEfxV/HAH/QTwMwtZ+nf+3ME5vGi70QaOIiPYfyD5XV4k8YFlBILM4cN2g4?=
 =?us-ascii?Q?agLk2b5Jak6LxdZ0yC2MVN0kRotFUJzbTJkGHeGB0h5L67GNTMWVrjhQkwqw?=
 =?us-ascii?Q?oezJAOCJB6FWSw5Ejcvz608b4BEy2B7kZJpvSuqMeNebFXQQZ8YBREZsIz5n?=
 =?us-ascii?Q?gsRQX/YE3hPUbndsF4kOToV4qH+oz3g7dAYPyLj2aU7UKusmQDYBvuTy3dS1?=
 =?us-ascii?Q?xTqpgKvRJH/mMq06pRelLJp5CjnGvyDcbgxU6kkM5O2Z4hyRacgdF3GktxO1?=
 =?us-ascii?Q?nJR69XbpBRervXPbcZzBinvwtQ0A5ObUPJh+zwDxogF3CRl+TZ0M2E9rDXGp?=
 =?us-ascii?Q?lSaO3gWwCQRH45mKxvi3jq1HcccQoR9I1EqYWkWKy8RYTjBw9seg79DbOllt?=
 =?us-ascii?Q?BnM+dy7ZU1z5Kh+yjaE5G1z3uzgOGvIW0rnPeH6R7TdFfRn0+BHy2KV0ikF0?=
 =?us-ascii?Q?2w5k/sZl+we0nOq0k6Qo4Be0e9tYm4GDAddXNDHT8PKvT1hC7P1WnaMCYK2M?=
 =?us-ascii?Q?eRcHZXXjlzJ08rz1sXzDFM6emf73dDDu6jqZreMilN6Ukke7f1tN+rnLml0q?=
 =?us-ascii?Q?klRb5SKRjIOfxqiV2PwJYeXVnLYHf+sz5OVt+ehC726nINp7W7Os0ih6L5Zj?=
 =?us-ascii?Q?v5GqBlOHhEkFZ+hSl8hoWtkSd0uBESWNrSR8eBYRHcJys2aFWgsSXTwqfC4O?=
 =?us-ascii?Q?I6/pZrhCeboxNZFCoiz7UONcMfSa18orgqPaMOQlo4TPvI5JIHJVgivCLGA6?=
 =?us-ascii?Q?inXGIZuxULTKTP9I8cF0cjtqPyjp5SYP8t58/bur?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6fbbc4-21c8-4ceb-80e0-08dcf341f55b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 09:06:19.4473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3R251EuGRokHeqIuXz5tM7+3T9VVN07KToM+dwNwHhz9yE6O90rfwb3vHnvn2+cICU50SZjmqbJa9ElS06aV4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5403
X-Proofpoint-ORIG-GUID: _gY9RuKaVigSaTT2Pg1C2SKBAI1OjHzn
X-Proofpoint-GUID: _gY9RuKaVigSaTT2Pg1C2SKBAI1OjHzn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Ping. Please check this patch.

>>>>This patch introduces a PCI hotplug controller driver for the OCTEON
>>>>PCIe device, a multi-function PCIe device where the first function acts
>>>>as a hotplug controller. It is equipped with MSI-x interrupts to notify
>>>>the host of hotplug events from the OCTEON firmware.
>>>>
>>>>The driver facilitates the hotplugging of non-controller functions
>>>>within the same device. During probe, non-controller functions are
>>>>removed and registered as PCI hotplug slots. The slots are added back
>>>>only upon request from the device firmware. The driver also allows the
>>>>enabling and disabling of the slots via sysfs slot entries, provided by
>>>>the PCI hotplug framework.
>>>>
>>>>Signed-off-by: Shijith Thotton <sthotton@marvell.com>
>>>>Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
>>>>Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>>>>---
>>>>
>>>>This patch introduces a PCI hotplug controller driver for OCTEON PCIe
>>hotplug
>>>>controller. The OCTEON PCIe device is a multi-function device where the
>first
>>>>function acts as a PCI hotplug controller.
>>>>
>>>>              +--------------------------------+
>>>>              |           Root Port            |
>>>>              +--------------------------------+
>>>>                              |
>>>>                             PCIe
>>>>                              |
>>>>+---------------------------------------------------------------+
>>>>|              OCTEON PCIe Multifunction Device                 |
>>>>+---------------------------------------------------------------+
>>>>            |                    |              |            |
>>>>            |                    |              |            |
>>>>+---------------------+  +----------------+  +-----+  +----------------=
+
>>>>|      Function 0     |  |   Function 1   |  | ... |  |   Function 7   =
|
>>>>| (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) =
|
>>>>+---------------------+  +----------------+  +-----+  +----------------=
+
>>>>            |
>>>>            |
>>>>+-------------------------+
>>>>|   Controller Firmware   |
>>>>+-------------------------+
>>>>
>>>>The hotplug controller driver facilitates the hotplugging of non-contro=
ller
>>>>functions in the same device. During the probe of the driver, the non-
>>>controller
>>>>function are removed and registered as PCI hotplug slots. They are adde=
d
>>back
>>>>only upon request from the device firmware. The driver also allows the =
user
>>to
>>>>enable/disable the functions using sysfs slot entries provided by PCI h=
otplug
>>>>framework.
>>>>
>>>>This solution adopts a hardware + software approach for several reasons=
:
>>>>
>>>>1. To reduce hardware implementation cost. Supporting complete hotplug
>>>>   capability within the card would require a PCI switch implemented wi=
thin.
>>>>
>>>>2. In the multi-function device, non-controller functions can act as
>emulated
>>>>   devices. The firmware can dynamically enable or disable them at runt=
ime.
>>>>
>>>>3. Not all root ports support PCI hotplug. This approach provides great=
er
>>>>   flexibility and compatibility across different hardware configuratio=
ns.
>>>>
>>>>The hotplug controller function is lightweight and is equipped with MSI=
-x
>>>>interrupts to notify the host about hotplug events. Upon receiving an
>>>>interrupt, the hotplug register is read, and the required function is e=
nabled
>>>>or disabled.
>>>>
>>>>This driver will be beneficial for managing PCI hotplug events on the
>OCTEON
>>>>PCIe device without requiring complex hardware solutions.
>>>>
>>>>Changes in v2:
>>>>- Added missing include files.
>>>>- Used dev_err_probe() for error handling.
>>>>- Used guard() for mutex locking.
>>>>- Splited cleanup actions and added per-slot cleanup action.
>>>>- Fixed coding style issues.
>>>>- Added co-developed-by tag.
>>>>
>>>>Changes in v3:
>>>>- Explicit assignment of enum values.
>>>>- Use pcim_iomap_region() instead of pcim_iomap_regions().
>>>>
>>>> MAINTAINERS                    |   6 +
>>>> drivers/pci/hotplug/Kconfig    |  10 +
>>>> drivers/pci/hotplug/Makefile   |   1 +
>>>> drivers/pci/hotplug/octep_hp.c | 409
>>>>+++++++++++++++++++++++++++++++++
>>>> 4 files changed, 426 insertions(+)
>>>> create mode 100644 drivers/pci/hotplug/octep_hp.c
>>>>
>>>>diff --git a/MAINTAINERS b/MAINTAINERS
>>>>index 42decde38320..7b5a618eed1c 100644
>>>>--- a/MAINTAINERS
>>>>+++ b/MAINTAINERS
>>>>@@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
>>>> R:	vattunuru@marvell.com
>>>> F:	drivers/vdpa/octeon_ep/
>>>>
>>>>+MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
>>>>+R:	Shijith Thotton <sthotton@marvell.com>
>>>>+R:	Vamsi Attunuru <vattunuru@marvell.com>
>>>>+S:	Supported
>>>>+F:	drivers/pci/hotplug/octep_hp.c
>>>>+
>>>> MATROX FRAMEBUFFER DRIVER
>>>> L:	linux-fbdev@vger.kernel.org
>>>> S:	Orphan
>>>>diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>>>>index 1472aef0fb81..2e38fd25f7ef 100644
>>>>--- a/drivers/pci/hotplug/Kconfig
>>>>+++ b/drivers/pci/hotplug/Kconfig
>>>>@@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
>>>>
>>>> 	  When in doubt, say Y.
>>>>
>>>>+config HOTPLUG_PCI_OCTEONEP
>>>>+	bool "OCTEON PCI device Hotplug controller driver"
>>>>+	depends on HOTPLUG_PCI
>>>>+	help
>>>>+	  Say Y here if you have an OCTEON PCIe device with a hotplug
>>>>+	  controller. This driver enables the non-controller functions of the
>>>>+	  device to be registered as hotplug slots.
>>>>+
>>>>+	  When in doubt, say N.
>>>>+
>>>> endif # HOTPLUG_PCI
>>>>diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefil=
e
>>>>index 240c99517d5e..40aaf31fe338 100644
>>>>--- a/drivers/pci/hotplug/Makefile
>>>>+++ b/drivers/pci/hotplug/Makefile
>>>>@@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+=3D
>>>>rpaphp.o
>>>> obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+=3D rpadlpar_io.o
>>>> obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+=3D acpiphp.o
>>>> obj-$(CONFIG_HOTPLUG_PCI_S390)		+=3D s390_pci_hpc.o
>>>>+obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+=3D octep_hp.o
>>>>
>>>> # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>>>>
>>>>diff --git a/drivers/pci/hotplug/octep_hp.c
>>b/drivers/pci/hotplug/octep_hp.c
>>>>new file mode 100644
>>>>index 000000000000..77dc2740f43e
>>>>--- /dev/null
>>>>+++ b/drivers/pci/hotplug/octep_hp.c
>>>>@@ -0,0 +1,409 @@
>>>>+// SPDX-License-Identifier: GPL-2.0-only
>>>>+/* Copyright (C) 2024 Marvell. */
>>>>+
>>>>+#include <linux/cleanup.h>
>>>>+#include <linux/container_of.h>
>>>>+#include <linux/delay.h>
>>>>+#include <linux/dev_printk.h>
>>>>+#include <linux/init.h>
>>>>+#include <linux/interrupt.h>
>>>>+#include <linux/io-64-nonatomic-lo-hi.h>
>>>>+#include <linux/kernel.h>
>>>>+#include <linux/list.h>
>>>>+#include <linux/module.h>
>>>>+#include <linux/mutex.h>
>>>>+#include <linux/pci.h>
>>>>+#include <linux/pci_hotplug.h>
>>>>+#include <linux/slab.h>
>>>>+#include <linux/spinlock.h>
>>>>+#include <linux/workqueue.h>
>>>>+
>>>>+#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
>>>>+#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
>>>>+#define OCTEP_HP_DRV_NAME "octep_hp"
>>>>+
>>>>+/*
>>>>+ * Type of MSI-X interrupts.
>>>>+ * The macros OCTEP_HP_INTR_VECTOR and OCTEP_HP_INTR_OFFSET are
>>>>used to
>>>>+ * generate the vector and offset for an interrupt type.
>>>>+ */
>>>>+enum octep_hp_intr_type {
>>>>+	OCTEP_HP_INTR_INVALID =3D -1,
>>>>+	OCTEP_HP_INTR_ENA =3D 0,
>>>>+	OCTEP_HP_INTR_DIS =3D 1,
>>>>+	OCTEP_HP_INTR_MAX =3D 2,
>>>>+};
>>>>+
>>>>+struct octep_hp_cmd {
>>>>+	struct list_head list;
>>>>+	enum octep_hp_intr_type intr_type;
>>>>+	u64 intr_val;
>>>>+};
>>>>+
>>>>+struct octep_hp_slot {
>>>>+	struct list_head list;
>>>>+	struct hotplug_slot slot;
>>>>+	u16 slot_number;
>>>>+	struct pci_dev *hp_pdev;
>>>>+	unsigned int hp_devfn;
>>>>+	struct octep_hp_controller *ctrl;
>>>>+};
>>>>+
>>>>+struct octep_hp_intr_info {
>>>>+	enum octep_hp_intr_type type;
>>>>+	int number;
>>>>+	char name[16];
>>>>+};
>>>>+
>>>>+struct octep_hp_controller {
>>>>+	void __iomem *base;
>>>>+	struct pci_dev *pdev;
>>>>+	struct octep_hp_intr_info intr[OCTEP_HP_INTR_MAX];
>>>>+	struct work_struct work;
>>>>+	struct list_head slot_list;
>>>>+	struct mutex slot_lock; /* Protects slot_list */
>>>>+	struct list_head hp_cmd_list;
>>>>+	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
>>>>+};
>>>>+
>>>>+static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
>>>>+				 struct octep_hp_slot *hp_slot)
>>>>+{
>>>>+	guard(mutex)(&hp_ctrl->slot_lock);
>>>>+	if (hp_slot->hp_pdev) {
>>>>+		dev_dbg(&hp_slot->hp_pdev->dev, "Slot %u already
>>>>enabled\n",
>>>>+			hp_slot->slot_number);
>>>>+		return;
>>>>+	}
>>>>+
>>>>+	/* Scan the device and add it to the bus */
>>>>+	hp_slot->hp_pdev =3D pci_scan_single_device(hp_ctrl->pdev->bus,
>>>>+						  hp_slot->hp_devfn);
>>>>+	pci_bus_assign_resources(hp_ctrl->pdev->bus);
>>>>+	pci_bus_add_device(hp_slot->hp_pdev);
>>>>+
>>>>+	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %u\n",
>>>>+		hp_slot->slot_number);
>>>>+}
>>>>+
>>>>+static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
>>>>+				  struct octep_hp_slot *hp_slot)
>>>>+{
>>>>+	guard(mutex)(&hp_ctrl->slot_lock);
>>>>+	if (!hp_slot->hp_pdev) {
>>>>+		dev_dbg(&hp_ctrl->pdev->dev, "Slot %u already disabled\n",
>>>>+			hp_slot->slot_number);
>>>>+		return;
>>>>+	}
>>>>+
>>>>+	dev_dbg(&hp_slot->hp_pdev->dev, "Disabling slot %u\n",
>>>>+		hp_slot->slot_number);
>>>>+
>>>>+	/* Remove the device from the bus */
>>>>+	pci_stop_and_remove_bus_device_locked(hp_slot->hp_pdev);
>>>>+	hp_slot->hp_pdev =3D NULL;
>>>>+}
>>>>+
>>>>+static int octep_hp_enable_slot(struct hotplug_slot *slot)
>>>>+{
>>>>+	struct octep_hp_slot *hp_slot =3D
>>>>+		container_of(slot, struct octep_hp_slot, slot);
>>>>+
>>>>+	octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
>>>>+	return 0;
>>>>+}
>>>>+
>>>>+static int octep_hp_disable_slot(struct hotplug_slot *slot)
>>>>+{
>>>>+	struct octep_hp_slot *hp_slot =3D
>>>>+		container_of(slot, struct octep_hp_slot, slot);
>>>>+
>>>>+	octep_hp_disable_pdev(hp_slot->ctrl, hp_slot);
>>>>+	return 0;
>>>>+}
>>>>+
>>>>+static struct hotplug_slot_ops octep_hp_slot_ops =3D {
>>>>+	.enable_slot =3D octep_hp_enable_slot,
>>>>+	.disable_slot =3D octep_hp_disable_slot,
>>>>+};
>>>>+
>>>>+#define SLOT_NAME_SIZE 16
>>>>+static struct octep_hp_slot *
>>>>+octep_hp_register_slot(struct octep_hp_controller *hp_ctrl,
>>>>+		       struct pci_dev *pdev, u16 slot_number)
>>>>+{
>>>>+	char slot_name[SLOT_NAME_SIZE];
>>>>+	struct octep_hp_slot *hp_slot;
>>>>+	int ret;
>>>>+
>>>>+	hp_slot =3D kzalloc(sizeof(*hp_slot), GFP_KERNEL);
>>>>+	if (!hp_slot)
>>>>+		return ERR_PTR(-ENOMEM);
>>>>+
>>>>+	hp_slot->ctrl =3D hp_ctrl;
>>>>+	hp_slot->hp_pdev =3D pdev;
>>>>+	hp_slot->hp_devfn =3D pdev->devfn;
>>>>+	hp_slot->slot_number =3D slot_number;
>>>>+	hp_slot->slot.ops =3D &octep_hp_slot_ops;
>>>>+
>>>>+	snprintf(slot_name, sizeof(slot_name), "octep_hp_%u", slot_number);
>>>>+	ret =3D pci_hp_register(&hp_slot->slot, hp_ctrl->pdev->bus,
>>>>+			      PCI_SLOT(pdev->devfn), slot_name);
>>>>+	if (ret) {
>>>>+		kfree(hp_slot);
>>>>+		return ERR_PTR(ret);
>>>>+	}
>>>>+
>>>>+	list_add_tail(&hp_slot->list, &hp_ctrl->slot_list);
>>>>+	octep_hp_disable_pdev(hp_ctrl, hp_slot);
>>>>+
>>>>+	return hp_slot;
>>>>+}
>>>>+
>>>>+static void octep_hp_deregister_slot(void *data)
>>>>+{
>>>>+	struct octep_hp_slot *hp_slot =3D data;
>>>>+	struct octep_hp_controller *hp_ctrl =3D hp_slot->ctrl;
>>>>+
>>>>+	pci_hp_deregister(&hp_slot->slot);
>>>>+	octep_hp_enable_pdev(hp_ctrl, hp_slot);
>>>>+	list_del(&hp_slot->list);
>>>>+	kfree(hp_slot);
>>>>+}
>>>>+
>>>>+static bool octep_hp_is_slot(struct octep_hp_controller *hp_ctrl,
>>>>+			     struct pci_dev *pdev)
>>>>+{
>>>>+	/* Check if the PCI device can be hotplugged */
>>>>+	return pdev !=3D hp_ctrl->pdev && pdev->bus =3D=3D hp_ctrl->pdev->bus=
 &&
>>>>+	       PCI_SLOT(pdev->devfn) =3D=3D PCI_SLOT(hp_ctrl->pdev->devfn);
>>>>+}
>>>>+
>>>>+static void octep_hp_cmd_handler(struct octep_hp_controller *hp_ctrl,
>>>>+				 struct octep_hp_cmd *hp_cmd)
>>>>+{
>>>>+	struct octep_hp_slot *hp_slot;
>>>>+
>>>>+	/*
>>>>+	 * Enable or disable the slots based on the slot mask.
>>>>+	 * intr_val is a bit mask where each bit represents a slot.
>>>>+	 */
>>>>+	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
>>>>+		if (!(hp_cmd->intr_val & BIT(hp_slot->slot_number)))
>>>>+			continue;
>>>>+
>>>>+		if (hp_cmd->intr_type =3D=3D OCTEP_HP_INTR_ENA)
>>>>+			octep_hp_enable_pdev(hp_ctrl, hp_slot);
>>>>+		else
>>>>+			octep_hp_disable_pdev(hp_ctrl, hp_slot);
>>>>+	}
>>>>+}
>>>>+
>>>>+static void octep_hp_work_handler(struct work_struct *work)
>>>>+{
>>>>+	struct octep_hp_controller *hp_ctrl;
>>>>+	struct octep_hp_cmd *hp_cmd;
>>>>+	unsigned long flags;
>>>>+
>>>>+	hp_ctrl =3D container_of(work, struct octep_hp_controller, work);
>>>>+
>>>>+	/* Process all the hotplug commands */
>>>>+	spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>>>>+	while (!list_empty(&hp_ctrl->hp_cmd_list)) {
>>>>+		hp_cmd =3D list_first_entry(&hp_ctrl->hp_cmd_list,
>>>>+					  struct octep_hp_cmd, list);
>>>>+		list_del(&hp_cmd->list);
>>>>+		spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>>>>+
>>>>+		octep_hp_cmd_handler(hp_ctrl, hp_cmd);
>>>>+		kfree(hp_cmd);
>>>>+
>>>>+		spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>>>>+	}
>>>>+	spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>>>>+}
>>>>+
>>>>+static enum octep_hp_intr_type octep_hp_intr_type(struct
>>>>octep_hp_intr_info *intr,
>>>>+						  int irq)
>>>>+{
>>>>+	enum octep_hp_intr_type type;
>>>>+
>>>>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>>>>type++) {
>>>>+		if (intr[type].number =3D=3D irq)
>>>>+			return type;
>>>>+	}
>>>>+
>>>>+	return OCTEP_HP_INTR_INVALID;
>>>>+}
>>>>+
>>>>+static irqreturn_t octep_hp_intr_handler(int irq, void *data)
>>>>+{
>>>>+	struct octep_hp_controller *hp_ctrl =3D data;
>>>>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>>>>+	enum octep_hp_intr_type type;
>>>>+	struct octep_hp_cmd *hp_cmd;
>>>>+	u64 intr_val;
>>>>+
>>>>+	type =3D octep_hp_intr_type(hp_ctrl->intr, irq);
>>>>+	if (type =3D=3D OCTEP_HP_INTR_INVALID) {
>>>>+		dev_err(&pdev->dev, "Invalid interrupt %d\n", irq);
>>>>+		return IRQ_HANDLED;
>>>>+	}
>>>>+
>>>>+	/* Read and clear the interrupt */
>>>>+	intr_val =3D readq(hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>>>>+	writeq(intr_val, hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>>>>+
>>>>+	hp_cmd =3D kzalloc(sizeof(*hp_cmd), GFP_ATOMIC);
>>>>+	if (!hp_cmd)
>>>>+		return IRQ_HANDLED;
>>>>+
>>>>+	hp_cmd->intr_val =3D intr_val;
>>>>+	hp_cmd->intr_type =3D type;
>>>>+
>>>>+	/* Add the command to the list and schedule the work */
>>>>+	spin_lock(&hp_ctrl->hp_cmd_lock);
>>>>+	list_add_tail(&hp_cmd->list, &hp_ctrl->hp_cmd_list);
>>>>+	spin_unlock(&hp_ctrl->hp_cmd_lock);
>>>>+	schedule_work(&hp_ctrl->work);
>>>>+
>>>>+	return IRQ_HANDLED;
>>>>+}
>>>>+
>>>>+static void octep_hp_irq_cleanup(void *data)
>>>>+{
>>>>+	struct octep_hp_controller *hp_ctrl =3D data;
>>>>+
>>>>+	pci_free_irq_vectors(hp_ctrl->pdev);
>>>>+	flush_work(&hp_ctrl->work);
>>>>+}
>>>>+
>>>>+static int octep_hp_request_irq(struct octep_hp_controller *hp_ctrl,
>>>>+				enum octep_hp_intr_type type)
>>>>+{
>>>>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>>>>+	struct octep_hp_intr_info *intr;
>>>>+	int irq;
>>>>+
>>>>+	irq =3D pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(type));
>>>>+	if (irq < 0)
>>>>+		return irq;
>>>>+
>>>>+	intr =3D &hp_ctrl->intr[type];
>>>>+	intr->number =3D irq;
>>>>+	intr->type =3D type;
>>>>+	snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
>>>>+
>>>>+	return devm_request_irq(&pdev->dev, irq, octep_hp_intr_handler,
>>>>+				IRQF_SHARED, intr->name, hp_ctrl);
>>>>+}
>>>>+
>>>>+static int octep_hp_controller_setup(struct pci_dev *pdev,
>>>>+				     struct octep_hp_controller *hp_ctrl)
>>>>+{
>>>>+	struct device *dev =3D &pdev->dev;
>>>>+	enum octep_hp_intr_type type;
>>>>+	int ret;
>>>>+
>>>>+	ret =3D pcim_enable_device(pdev);
>>>>+	if (ret)
>>>>+		return dev_err_probe(dev, ret, "Failed to enable PCI device\n");
>>>>+
>>>>+	hp_ctrl->base =3D pcim_iomap_region(pdev, 0, OCTEP_HP_DRV_NAME);
>>>>+	if (IS_ERR(hp_ctrl->base))
>>>>+		return dev_err_probe(dev, PTR_ERR(hp_ctrl->base),
>>>>+				     "Failed to map PCI device region\n");
>>>>+
>>>>+	pci_set_master(pdev);
>>>>+	pci_set_drvdata(pdev, hp_ctrl);
>>>>+
>>>>+	INIT_LIST_HEAD(&hp_ctrl->slot_list);
>>>>+	INIT_LIST_HEAD(&hp_ctrl->hp_cmd_list);
>>>>+	mutex_init(&hp_ctrl->slot_lock);
>>>>+	spin_lock_init(&hp_ctrl->hp_cmd_lock);
>>>>+	INIT_WORK(&hp_ctrl->work, octep_hp_work_handler);
>>>>+	hp_ctrl->pdev =3D pdev;
>>>>+
>>>>+	ret =3D pci_alloc_irq_vectors(pdev, 1,
>>>>+
>>>>OCTEP_HP_INTR_VECTOR(OCTEP_HP_INTR_MAX),
>>>>+				    PCI_IRQ_MSIX);
>>>>+	if (ret < 0)
>>>>+		return dev_err_probe(dev, ret, "Failed to alloc MSI-X
>>>>vectors\n");
>>>>+
>>>>+	ret =3D devm_add_action(&pdev->dev, octep_hp_irq_cleanup, hp_ctrl);
>>>>+	if (ret)
>>>>+		return dev_err_probe(&pdev->dev, ret, "Failed to add IRQ
>>>>cleanup action\n");
>>>>+
>>>>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>>>>type++) {
>>>>+		ret =3D octep_hp_request_irq(hp_ctrl, type);
>>>>+		if (ret)
>>>>+			return dev_err_probe(dev, ret,
>>>>+					     "Failed to request IRQ for vector
>>>>%d\n",
>>>>+					     OCTEP_HP_INTR_VECTOR(type));
>>>>+	}
>>>>+
>>>>+	return 0;
>>>>+}
>>>>+
>>>>+static int octep_hp_pci_probe(struct pci_dev *pdev,
>>>>+			      const struct pci_device_id *id)
>>>>+{
>>>>+	struct octep_hp_controller *hp_ctrl;
>>>>+	struct pci_dev *tmp_pdev =3D NULL;
>>>>+	struct octep_hp_slot *hp_slot;
>>>>+	u16 slot_number =3D 0;
>>>>+	int ret;
>>>>+
>>>>+	hp_ctrl =3D devm_kzalloc(&pdev->dev, sizeof(*hp_ctrl), GFP_KERNEL);
>>>>+	if (!hp_ctrl)
>>>>+		return -ENOMEM;
>>>>+
>>>>+	ret =3D octep_hp_controller_setup(pdev, hp_ctrl);
>>>>+	if (ret)
>>>>+		return ret;
>>>>+
>>>>+	/*
>>>>+	 * Register all hotplug slots. Hotplug controller is the first functi=
on
>>>>+	 * of the PCI device. The hotplug slots are the remaining functions o=
f
>>>>+	 * the PCI device. They are removed from the bus and are added back
>>>>when
>>>>+	 * the hotplug event is triggered.
>>>>+	 */
>>>>+	for_each_pci_dev(tmp_pdev) {
>>>>+		if (!octep_hp_is_slot(hp_ctrl, tmp_pdev))
>>>>+			continue;
>>>>+
>>>>+		hp_slot =3D octep_hp_register_slot(hp_ctrl, tmp_pdev,
>>>>slot_number);
>>>>+		if (IS_ERR(hp_slot))
>>>>+			return dev_err_probe(&pdev->dev, PTR_ERR(hp_slot),
>>>>+					     "Failed to register hotplug slot
>>>>%u\n",
>>>>+					     slot_number);
>>>>+
>>>>+		ret =3D devm_add_action(&pdev->dev, octep_hp_deregister_slot,
>>>>+				      hp_slot);
>>>>+		if (ret)
>>>>+			return dev_err_probe(&pdev->dev, ret,
>>>>+					     "Failed to add action for
>>>>deregistering slot %u\n",
>>>>+					     slot_number);
>>>>+		slot_number++;
>>>>+	}
>>>>+
>>>>+	return 0;
>>>>+}
>>>>+
>>>>+#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3
>>>>+static struct pci_device_id octep_hp_pci_map[] =3D {
>>>>+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
>>>>OCTEP_DEVID_HP_CONTROLLER) },
>>>>+	{ },
>>>>+};
>>>>+
>>>>+static struct pci_driver octep_hp =3D {
>>>>+	.name =3D OCTEP_HP_DRV_NAME,
>>>>+	.id_table =3D octep_hp_pci_map,
>>>>+	.probe =3D octep_hp_pci_probe,
>>>>+};
>>>>+
>>>>+module_pci_driver(octep_hp);
>>>>+
>>>>+MODULE_LICENSE("GPL");
>>>>+MODULE_AUTHOR("Marvell");
>>>>+MODULE_DESCRIPTION("OCTEON PCIe device hotplug controller driver");
>>>>--
>>>>2.25.1
>>>

