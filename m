Return-Path: <linux-pci+bounces-11940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30885959983
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 13:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DFC281355
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66020C007;
	Wed, 21 Aug 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="EHnJebNI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E320C008;
	Wed, 21 Aug 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234474; cv=fail; b=Q76dtIC5aFjQJj+M2/hmWQS+X6glLHTwqzq1qXuYt+Ao/Q4QueqUIrSARqbFlRJ9/zwCLisNdW/1U2MuVSgFnx4DF2TePLlIbBttE4VEQdiRVvKuxML7OQSt2M20sYiUFXXRtA4RZb88y+N0au7jwFvfEhCOcRS40dvy1/OfrPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234474; c=relaxed/simple;
	bh=l8eUiU+A5atTQl/EjgpN4r7hBnewBigPWujCR9EyJrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FR1zdnFxj8oX01MZ263Cj/+1SxFSnjuOZfZs58NbR7UQbSx/x9tF4nIPkbG+/TNwqdx7ffLF9iKRC1GDss56ErO4rfmfN13VZHHe7kO99lLCIEKmcapOnZdDhFgzzVk9Wz+7RZvQZCp1Nz9op5N8RmhomJNj/YaGBCqI1dEK8tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=EHnJebNI; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L6MWRh012080;
	Wed, 21 Aug 2024 03:00:50 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 415aw2gmxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 03:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxIrn1zggG5CoqQHYMAk+n9JXC9FgnXJClyWGKyceUk/lJo6p7Cz2hcv59qQaJ2YMnt/uauX7uwQhFw5Y6X7j2OFoF2Zwmyxs0AP10q0MiIiGoT3Ac/Asof+UkQ+3hkV8Ya3WHfkRmJcnjox2WT9vzdJc4Es3qf4sg+b7Q77EzKQTrHZTFZFtnhF3FGe3X/A1PNPMvXHfuk4ZCtZmjAZOQYVFWkqQDw8UpIMemZPMTMwuiHTJ5hE2quUst2GyvlD4UkF0NFCbH5V8THUwXOP9ZTMJBlJCo/SnrT2h+Po+FaxP0m1OQ8D8ZOizBNQPbM2waXdpMXa7rSPn3ZPAyqlWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jS1r/XUE0mNLPl0Gu2XRPGoC9B52EDLYkKVx/6Qka8=;
 b=w546RDhpxZpXj3I0gsDoIHKkG5sJDYKjWyhKX/UHNW9za8QdzHzXjm4+xppynhjyo+2eiJMsAhypV7GaHlXe47JK8WQCCF1fThsF57N5cXJCIC3Bwh8Ry1w7S2g8CikaTox/3nGvQA9QzbbzGZ8gfoATwl4cVb1IgV4sG/2dITQgTRdHhzt0E37D2/dhHl0MV3d6yv+aTXoZez7rmd/3LJwkkJaIp0Oa4AJ3tvGHaCg4f6doUWPkHg7nclSC+36sJzgHmyY2xCcFq7ui1dNjHNIyzrptSIHInHM9NEaxBjOFWA1EGvxR1NCCX//iOtsNNUwAvx+e6idenaerc6Ca1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jS1r/XUE0mNLPl0Gu2XRPGoC9B52EDLYkKVx/6Qka8=;
 b=EHnJebNIyjieyLSdRcEzmQViq0wPpvThp6bYjljVPcNbqZMtpYh1YCl12n6csb2mGZJAovp+ck6C++D3WAtEAzsSMVlXgp3QztxxvDb4pYf6Ibvf43Urk9G+0WhKfl54BtWatDKkdBUCHGyNlX1gyDhRUNMEli7CPJb0JZx5D30=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by SA6PR18MB6246.namprd18.prod.outlook.com (2603:10b6:806:41f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 10:00:48 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 10:00:47 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jerin Jacob
	<jerinj@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        Vamsi Krishna
 Attunuru <vattunuru@marvell.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        D
 Scott Phillips <scott@os.amperecomputing.com>
Subject: Re: [PATCH] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Index: AQHa87D+fyHT8T9Di0iSMdqaeZVJ5w==
Date: Wed, 21 Aug 2024 10:00:47 +0000
Message-ID:
 <PH0PR18MB442535D2828B701CD84A3994D98E2@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20240820152734.642533-1-sthotton@marvell.com>
 <d4a5ad63-cb4e-a725-a7dd-3ac52fff25fb@linux.intel.com>
In-Reply-To: <d4a5ad63-cb4e-a725-a7dd-3ac52fff25fb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|SA6PR18MB6246:EE_
x-ms-office365-filtering-correlation-id: 5b6d401e-6059-44bf-1e70-08dcc1c8216a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cD7r1xJw+TMBeRjNRNapNN01LA1WVUGrqFjJN6WxU9ITfVtNxEPaZW1aWX?=
 =?iso-8859-1?Q?UKT7wGA6q+SI8pA2MJiPn+PbC9WWsZfioKXifN0OQU7Ea7iIvfIkOjnp1l?=
 =?iso-8859-1?Q?mjCQNQTmOuxM26pjXbdHIx3hgKDWut9UcHpbVYhepuWcf1XSTUjo18on9Y?=
 =?iso-8859-1?Q?4aQlGtqZMAh7rrA2XwvxrsQOn+hpAwTwaLsaYuzR5HspMDFRg0IxfNZKjN?=
 =?iso-8859-1?Q?AcPLjDvlVHMiDYhKjqz942yLzZUlRstg34yNKUdY13W6EdiOjUNjba/REq?=
 =?iso-8859-1?Q?2LkaiZzyAwCjNkj6b9gHQtdjeVHl9ov146ko1vF78bNDkd6o1eNYHtBulz?=
 =?iso-8859-1?Q?7ZRIw96FEos9egvUgqKZohOxlZRToA73NTRW3aTwQp9JxRMAA+MjmgQ2Rg?=
 =?iso-8859-1?Q?mRS4wyqYNkbc/6/5wX70MrDunFf7Iw0wfnXjzy2kwoEcupzP8OkLTSZQ7K?=
 =?iso-8859-1?Q?vzm20Z1u/lU3BUAz17UaLp+KV/G2qrFfTJy5mqbZdz3wcMk5UlFkq6C5e/?=
 =?iso-8859-1?Q?O6pewrfV/Y1Jk4RewrOfBBl3Qv2unkGnBAeVYjCM4p3Yb9+Q24pON0xFTt?=
 =?iso-8859-1?Q?MjMwVbQBlu26drHnHzXdPFSRVqoaI25xx5AozRNyk6XZw2ak9sjZstA+if?=
 =?iso-8859-1?Q?rj++Weswf19MB0Tw3BnT9jY1PYBSeEXJLTCwRyEYPHgNMyTGuCQMEE53M2?=
 =?iso-8859-1?Q?H+MzA/pLooszPpzD5Bcc7FcTgymhsnxm+Hm1ep9mKTpxQO5gmsk/gnz1fL?=
 =?iso-8859-1?Q?hysHULMGp4Z4q3eFt9H0YFdAkijEwYbRkuAOpKKohLM69Oq+WYUXLTsQpm?=
 =?iso-8859-1?Q?aDn2594rYRXeCTgFtopvOOxzQZvKHLizmgQ80YfRCoT1unumIL8KvdsdQA?=
 =?iso-8859-1?Q?COyNuOxdRleL7psMBkLL3n4BYoXzoeL1SoS+01ZYZwtdbRXSLSDpzALwjL?=
 =?iso-8859-1?Q?0bYcglPJ6iCa5XnW3mAwKW1Op4Tj2vJsIvuUpT+1d+Jk3tfu+luCJh+HE4?=
 =?iso-8859-1?Q?syi4WZzi4zIBYwrL+NfruB1lLwSmjjeLd3Az0VPcMklSyOcrAhOvreSCQA?=
 =?iso-8859-1?Q?FNzZxtU5JgOlhRBkbV3pBvpONho363RZy7kb2CLZ1nTwi/aOKYO78GkDsk?=
 =?iso-8859-1?Q?BItrocdsxHqAQJIaCWSJkn0f/C4ugM5LR5mAoT4cA31uXvoYykO/4ls4ee?=
 =?iso-8859-1?Q?WU6lZojL/15nFdo+9DUR2z3U7vV4xkeU4Pgeu5yyWkjp3/Th0AT1ypAhaJ?=
 =?iso-8859-1?Q?nd88PU3+LLZXm3wJEpIx4zWJZ1bTrRG75tnUsJAoFPdmCBFQu9xYt7HQ+C?=
 =?iso-8859-1?Q?D6i3djQ6XBJKADqKOoLW0prVbpW72FRfuLaaypn/YLFW3TVDFtQjYgkUax?=
 =?iso-8859-1?Q?yycqrDofImdCZVWQ4VMTexHFdUhXgFTDbojPBpEUciWR6KRndT/J9JfkWB?=
 =?iso-8859-1?Q?Jz+AgxsNULZnPotVs8gDKfcgOSdzhv01TrzF/Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ob3/S1fvsu+eCOq36/LwYuyitMWI6jAsRGqm6iW9utzVNO/7sFQZaQG9TN?=
 =?iso-8859-1?Q?g1/GLmJaIoHrm+QwrSC2eXiNhWnUwcrDI1cEhx0HQSITB59iA9Jv7NE6v7?=
 =?iso-8859-1?Q?7kVpfd6QNs83BsU9v0c2rQo8edgfaaR2TkVsdYQfKgHHCRZDNepcDHaCYm?=
 =?iso-8859-1?Q?7CFAyvAkDQewljJ0VC8sO+B/Of2o8bOXbyfeDrD7OUDoenyShe6VHkFfnm?=
 =?iso-8859-1?Q?azhTH2/AjPfCuJNq/ZBGy7NZ2uY3ORwGDyQnF4ABnPEs3/P2HyCkXR3sTh?=
 =?iso-8859-1?Q?sXXuDQqYr6KuALMfEegKNEZxontXNtwcZTpeKyIR5Qd+gnST+yPv2mWdZl?=
 =?iso-8859-1?Q?3ikxcbYrej9xPZlLMX9jjDVWjI9lRe+aktUxGIukSSwOA+wVmvvigStykK?=
 =?iso-8859-1?Q?60bc9H6Ld/GYUemHSaRK/okzNgMlqJvCGhYQKjLli++QPaGf2zE+uZ5+er?=
 =?iso-8859-1?Q?EHMLVct7e7c22c3I0dtKsWNwOPq4v2yKaj/3W4uJ5p2UMXX/8HX+jIX0SK?=
 =?iso-8859-1?Q?vytd4eMqBmiAKERBRw+3PBVQOC5/ZRqS8WezQ22E2GDUarrKSA4/l2l9aY?=
 =?iso-8859-1?Q?y2xCm25Nc9JdJl+OGzNSjmg3qLbtNaWlFGjHNn3PNFFGTgX14Uhpg3ua4S?=
 =?iso-8859-1?Q?VwVyljeUDdw1kyBkND0ZhBkxCDvd8aWno7eWiGi00TrKYo9mH+o7IFly+b?=
 =?iso-8859-1?Q?OKtI8RFdyMo1OnI4GGsJRljxRq+P6VpSH6hWhdZ/oKDhoeJLJY8P0S5GUv?=
 =?iso-8859-1?Q?4jcKFgoDIsoYZ5TxJykTklDU8PqUg3B0NdsrOEAh1wdTwDczNQMZDU3UrS?=
 =?iso-8859-1?Q?VTJrWZ8EEGfWp9ILLiTbyaGhQY7s+ru5sIPLh962x8gVNyDZC2x2VCDIHT?=
 =?iso-8859-1?Q?g+YEjaY6KI+8f3RHq3IYlWpfQtRzb5GyJcI9Fx0O/58S+sb/tFQCR7yn1c?=
 =?iso-8859-1?Q?sYYCSaqP0Hqoh281hegLC0AkwCh2HhwE+6vRP6d/q9VnOIlE2legdIVl0j?=
 =?iso-8859-1?Q?pZa35WNpFSB0hq4Ly9EJgxXClQtaqBru0k1LNuaBsTtaOZuxMfNpnyhpB3?=
 =?iso-8859-1?Q?3OFp8MMPoEsehg4GPhyGfQdSdh1LsRIw+qT3c/BbLcQ4v8S3gmiyEUwUao?=
 =?iso-8859-1?Q?lEbp9jMoxjnQdOZRTQ5sc74wtKIURJ6ZcAaUyQ0CUP6cM3xLI2XG5jsJ6+?=
 =?iso-8859-1?Q?r8U0iRNohBnVmMLHXksWxSmOMNMBB/+YtUyyxgzFOTKicqJTO76nDkaTji?=
 =?iso-8859-1?Q?BLIk+Tu8uoo+m+uB+TDCwktqk4jRRhLwAlIpmOxFuSuFKpWBHoFDi7JSo9?=
 =?iso-8859-1?Q?hUh6fz+sxftKUbmnKMMAHTIQfd3bn6iUWsQ1/eUZtsa9CP+1zUfTHZZDZY?=
 =?iso-8859-1?Q?cVMjRL4VqVLAoKh9rxG369DFz8Y3TS040hkUT3MQw/63fBaygBJ3RAG3ai?=
 =?iso-8859-1?Q?sro71MFGXmZr2j4Ik+17ie9vikCCyW5qMIinr/X+gai/oa5yy2zDi2aR7b?=
 =?iso-8859-1?Q?FAhkZ+fCTcCfSXzIu/EaPiewKhT+UgK0F7N2Utp92dj7ushP2PrOrETvm5?=
 =?iso-8859-1?Q?uTTy7R+ClP1+Eyfd15izHlJK0nC5gblVwKaAFA3LOSRHUOPweNVY4V2rTk?=
 =?iso-8859-1?Q?4sBWLNsjlCG/DzBgvwq0cVX/R23sJBpzEh?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6d401e-6059-44bf-1e70-08dcc1c8216a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 10:00:47.7738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAb8EilA49vkOB+AxRYjIs6Wyxuac8JbSLC7bar1stXjH2M/A4zqL8SMM1dX7YTri/Wl9INJwwvVe0OXcubaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR18MB6246
X-Proofpoint-GUID: E_5teQ-LtEE7mV4NcTrbmza3erRYvB71
X-Proofpoint-ORIG-GUID: E_5teQ-LtEE7mV4NcTrbmza3erRYvB71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_07,2024-08-19_03,2024-05-17_01


>On Tue, 20 Aug 2024, Shijith Thotton wrote:
>
>> This patch introduces a PCI hotplug controller driver for the OCTEON
>> PCIe device, a multi-function PCIe device where the first function acts
>> as a hotplug controller. It is equipped with MSI-x interrupts to notify
>> the host of hotplug events from the OCTEON firmware.
>>
>> The driver facilitates the hotplugging of non-controller functions
>> within the same device. During probe, non-controller functions are
>> removed and registered as PCI hotplug slots. The slots are added back
>> only upon request from the device firmware. The driver also allows the
>> enabling and disabling of the slots via sysfs slot entries, provided by
>> the PCI hotplug framework.
>>
>> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
>> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>> ---
>>
>> This patch introduces a PCI hotplug controller driver for OCTEON PCIe ho=
tplug
>> controller. The OCTEON PCIe device is a multi-function device where the =
first
>> function acts as a PCI hotplug controller.
>>
>>               +--------------------------------+
>>               |           Root Port            |
>>               +--------------------------------+
>>                               |
>>                              PCIe
>>                               |
>> +---------------------------------------------------------------+
>> |              OCTEON PCIe Multifunction Device                 |
>> +---------------------------------------------------------------+
>>             |                    |              |            |
>>             |                    |              |            |
>> +---------------------+  +----------------+  +-----+  +----------------+
>> |      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
>> | (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
>> +---------------------+  +----------------+  +-----+  +----------------+
>>             |
>>             |
>> +-------------------------+
>> |   Controller Firmware   |
>> +-------------------------+
>>
>> The hotplug controller driver facilitates the hotplugging of non-control=
ler
>> functions in the same device. During the probe of the driver, the non-
>controller
>> function are removed and registered as PCI hotplug slots. They are added
>back
>> only upon request from the device firmware. The driver also allows the u=
ser
>to
>> enable/disable the functions using sysfs slot entries provided by PCI ho=
tplug
>> framework.
>>
>> This solution adopts a hardware + software approach for several reasons:
>>
>> 1. To reduce hardware implementation cost. Supporting complete hotplug
>>    capability within the card would require a PCI switch implemented wit=
hin.
>>
>> 2. In the multi-function device, non-controller functions can act as emu=
lated
>>    devices. The firmware can dynamically enable or disable them at runti=
me.
>>
>> 3. Not all root ports support PCI hotplug. This approach provides greate=
r
>>    flexibility and compatibility across different hardware configuration=
s.
>>
>> The hotplug controller function is lightweight and is equipped with MSI-=
x
>> interrupts to notify the host about hotplug events. Upon receiving an
>> interrupt, the hotplug register is read, and the required function is en=
abled
>> or disabled.
>>
>> This driver will be beneficial for managing PCI hotplug events on the OC=
TEON
>> PCIe device without requiring complex hardware solutions.
>>
>>  MAINTAINERS                    |   6 +
>>  drivers/pci/hotplug/Kconfig    |  10 +
>>  drivers/pci/hotplug/Makefile   |   1 +
>>  drivers/pci/hotplug/octep_hp.c | 351
>+++++++++++++++++++++++++++++++++
>>  4 files changed, 368 insertions(+)
>>  create mode 100644 drivers/pci/hotplug/octep_hp.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 42decde38320..7b5a618eed1c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
>>  R:	vattunuru@marvell.com
>>  F:	drivers/vdpa/octeon_ep/
>>
>> +MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
>> +R:	Shijith Thotton <sthotton@marvell.com>
>> +R:	Vamsi Attunuru <vattunuru@marvell.com>
>> +S:	Supported
>> +F:	drivers/pci/hotplug/octep_hp.c
>> +
>>  MATROX FRAMEBUFFER DRIVER
>>  L:	linux-fbdev@vger.kernel.org
>>  S:	Orphan
>> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>> index 1472aef0fb81..2e38fd25f7ef 100644
>> --- a/drivers/pci/hotplug/Kconfig
>> +++ b/drivers/pci/hotplug/Kconfig
>> @@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
>>
>>  	  When in doubt, say Y.
>>
>> +config HOTPLUG_PCI_OCTEONEP
>> +	bool "OCTEON PCI device Hotplug controller driver"
>> +	depends on HOTPLUG_PCI
>> +	help
>> +	  Say Y here if you have an OCTEON PCIe device with a hotplug
>> +	  controller. This driver enables the non-controller functions of the
>> +	  device to be registered as hotplug slots.
>> +
>> +	  When in doubt, say N.
>> +
>>  endif # HOTPLUG_PCI
>> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>> index 240c99517d5e..40aaf31fe338 100644
>> --- a/drivers/pci/hotplug/Makefile
>> +++ b/drivers/pci/hotplug/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+=3D
>rpaphp.o
>>  obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+=3D rpadlpar_io.o
>>  obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+=3D acpiphp.o
>>  obj-$(CONFIG_HOTPLUG_PCI_S390)		+=3D s390_pci_hpc.o
>> +obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+=3D octep_hp.o
>>
>>  # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>>
>> diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_=
hp.c
>> new file mode 100644
>> index 000000000000..efeb542d4993
>> --- /dev/null
>> +++ b/drivers/pci/hotplug/octep_hp.c
>> @@ -0,0 +1,351 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (C) 2024 Marvell. */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/pci_hotplug.h>
>> +#include <linux/slab.h>
>> +
>> +#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
>> +#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
>> +#define OCTEP_HP_DRV_NAME       "octep_hp"
>> +
>> +/* Interrupt vectors for hotplug enable and disable events. */
>> +enum octep_hp_vec_type {
>> +	OCTEP_HP_VEC_ENA,
>> +	OCTEP_HP_VEC_DIS,
>
>If I understand your code right, these cannot be arbitrary numbers but has
>to be specific numbers to match the vector number so you should explicitly
>set them to those values.

octep_hp_vec_type is used to specify the type of hotplug interrupt. There a=
re
two types of hotplug interrupts, enable and disable. The vectors for these
interrupts are formed using the macros OCTEP_HP_INTR_VECTOR(x) where x is t=
he
type of interrupt. The vectors for enable and disable interrupts are 16 and=
 17
respectively.

I have not set them in enum since the vectors are sequential. I will change=
 it as
below to make it clearer.

enum octep_hp_intr_type {
        OCTEP_HP_INTR_INVALID =3D -1,
        OCTEP_HP_INTR_ENA =3D 0,
        OCTEP_HP_INTR_DIS =3D 1,
};

>> +};
>> +
>> +struct octep_hp_cmd {
>> +	struct list_head list;
>
>Missing include for list_head.

Will add.

>
>> +	enum octep_hp_vec_type vec_type;
>> +	u64 slot_mask;
>> +};
>> +
>> +struct octep_hp_slot {
>> +	struct list_head list;
>> +	struct hotplug_slot slot;
>> +	u16 slot_number;
>> +	struct pci_dev *hp_pdev;
>> +	unsigned int hp_devfn;
>> +	struct octep_hp_controller *ctrl;
>> +};
>> +
>> +struct octep_hp_controller {
>> +	void __iomem *base;
>> +	struct pci_dev *pdev;
>> +	struct work_struct work;
>
>Missing include.

Will add.

>
>> +	struct list_head slot_list;
>> +	struct mutex slot_lock; /* Protects slot_list */
>
>Missing include.

Will add.

>
>> +	struct list_head hp_cmd_list;
>> +	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
>> +};
>> +
>> +static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
>struct octep_hp_slot *hp_slot)
>> +{
>> +	mutex_lock(&hp_ctrl->slot_lock);
>
>Use guard().

Will change to use guard().

>
>> +	if (hp_slot->hp_pdev) {
>> +		dev_dbg(&hp_slot->hp_pdev->dev, "Slot %u already
>enabled\n", hp_slot->slot_number);
>> +		mutex_unlock(&hp_ctrl->slot_lock);
>> +		return;
>> +	}
>> +
>> +	/* Scan the device and add it to the bus */
>> +	hp_slot->hp_pdev =3D pci_scan_single_device(hp_ctrl->pdev->bus,
>hp_slot->hp_devfn);
>> +	pci_bus_assign_resources(hp_ctrl->pdev->bus);
>> +	pci_bus_add_device(hp_slot->hp_pdev);
>> +
>> +	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %u\n", hp_slot-
>>slot_number);
>
>Missing include for dev_dbg().
>

Will add.

>> +	mutex_unlock(&hp_ctrl->slot_lock);
>> +}
>> +
>> +static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
>> +				  struct octep_hp_slot *hp_slot)
>> +{
>> +	mutex_lock(&hp_ctrl->slot_lock);
>
>Use guard().

Will change.

>
>> +	if (!hp_slot->hp_pdev) {
>> +		dev_dbg(&hp_ctrl->pdev->dev, "Slot %u already disabled\n",
>hp_slot->slot_number);
>> +		mutex_unlock(&hp_ctrl->slot_lock);
>> +		return;
>> +	}
>> +
>> +	dev_dbg(&hp_slot->hp_pdev->dev, "Disabling slot %u\n", hp_slot-
>>slot_number);
>> +
>> +	/* Remove the device from the bus */
>> +	pci_stop_and_remove_bus_device_locked(hp_slot->hp_pdev);
>> +	hp_slot->hp_pdev =3D NULL;
>> +	mutex_unlock(&hp_ctrl->slot_lock);
>> +}
>> +
>> +static int octep_hp_enable_slot(struct hotplug_slot *slot)
>> +{
>> +	struct octep_hp_slot *hp_slot =3D container_of(slot, struct
>octep_hp_slot, slot);
>
>Missing include for container_of().

Will add.

>
>> +
>> +	octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
>> +	return 0;
>> +}
>> +
>> +static int octep_hp_disable_slot(struct hotplug_slot *slot)
>> +{
>> +	struct octep_hp_slot *hp_slot =3D container_of(slot, struct
>octep_hp_slot, slot);
>> +
>> +	octep_hp_disable_pdev(hp_slot->ctrl, hp_slot);
>> +	return 0;
>> +}
>> +
>> +static struct hotplug_slot_ops octep_hp_slot_ops =3D {
>> +	.enable_slot =3D octep_hp_enable_slot,
>> +	.disable_slot =3D octep_hp_disable_slot,
>> +};
>> +
>> +#define SLOT_NAME_SIZE 16
>> +static int octep_hp_register_slot(struct octep_hp_controller *hp_ctrl, =
struct
>pci_dev *pdev,
>> +				  u16 slot_number)
>> +{
>> +	char slot_name[SLOT_NAME_SIZE];
>> +	struct octep_hp_slot *hp_slot;
>> +	int ret;
>> +
>> +	hp_slot =3D kzalloc(sizeof(*hp_slot), GFP_KERNEL);
>> +	if (!hp_slot)
>> +		return -ENOMEM;
>> +
>> +	hp_slot->ctrl =3D hp_ctrl;
>> +	hp_slot->hp_pdev =3D pdev;
>> +	hp_slot->hp_devfn =3D pdev->devfn;
>> +	hp_slot->slot_number =3D slot_number;
>> +	hp_slot->slot.ops =3D &octep_hp_slot_ops;
>> +
>> +	snprintf(slot_name, SLOT_NAME_SIZE, "octep_hp_%u", slot_number);
>
>SLOT_NAME_SIZE -> sizeof(slot_name)

Will change.

>
>> +	ret =3D pci_hp_register(&hp_slot->slot, hp_ctrl->pdev->bus,
>PCI_SLOT(pdev->devfn), slot_name);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to register hotplug slot %u\n",
>slot_number);
>> +		kfree(hp_slot);
>> +		return ret;
>> +	}
>> +
>> +	octep_hp_disable_pdev(hp_ctrl, hp_slot);
>> +	list_add_tail(&hp_slot->list, &hp_ctrl->slot_list);
>> +
>> +	return 0;
>> +}
>> +
>> +static bool octep_hp_slot(struct octep_hp_controller *hp_ctrl, struct p=
ci_dev
>*pdev)
>> +{
>> +	/* Check if the PCI device can be hotplugged */
>> +	return pdev !=3D hp_ctrl->pdev && pdev->bus =3D=3D hp_ctrl->pdev->bus =
&&
>> +		PCI_SLOT(pdev->devfn) =3D=3D PCI_SLOT(hp_ctrl->pdev->devfn);
>> +}
>> +
>> +static void octep_hp_cmd_handler(struct octep_hp_controller *hp_ctrl,
>struct octep_hp_cmd *hp_cmd)
>> +{
>> +	struct octep_hp_slot *hp_slot;
>> +
>> +	/* Enable or disable the slots based on the slot mask */
>> +	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
>> +		if (hp_cmd->slot_mask & BIT(hp_slot->slot_number)) {
>
>Reverse logic & use continue ?

Sure. Will change.

>
>> +			if (hp_cmd->vec_type =3D=3D OCTEP_HP_VEC_ENA)
>> +				octep_hp_enable_pdev(hp_ctrl, hp_slot);
>> +			else
>> +				octep_hp_disable_pdev(hp_ctrl, hp_slot);
>> +		}
>> +	}
>> +}
>> +
>> +static void octep_hp_work_handler(struct work_struct *work)
>> +{
>> +	struct octep_hp_controller *hp_ctrl =3D container_of(work, struct
>octep_hp_controller, work);
>> +	struct octep_hp_cmd *hp_cmd;
>> +	unsigned long flags;
>> +
>> +	/* Process all the hotplug commands */
>> +	spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>> +	while (!list_empty(&hp_ctrl->hp_cmd_list)) {
>> +		hp_cmd =3D list_first_entry(&hp_ctrl->hp_cmd_list, struct
>octep_hp_cmd, list);
>> +		list_del(&hp_cmd->list);
>> +		spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>> +
>> +		octep_hp_cmd_handler(hp_ctrl, hp_cmd);
>> +		kfree(hp_cmd);
>> +
>> +		spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>> +	}
>> +	spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>> +}
>> +
>> +static irqreturn_t octep_hp_intr_handler(int irq, void *data)
>> +{
>> +	struct octep_hp_controller *hp_ctrl =3D data;
>> +	struct pci_dev *pdev =3D hp_ctrl->pdev;
>> +	enum octep_hp_vec_type vec_type;
>> +	struct octep_hp_cmd *hp_cmd;
>> +	u64 slot_mask;
>> +
>> +	vec_type =3D pci_irq_vector(pdev,
>OCTEP_HP_INTR_VECTOR(OCTEP_HP_VEC_ENA)) =3D=3D irq ?
>> +		OCTEP_HP_VEC_ENA : OCTEP_HP_VEC_DIS;
>
>This is a bit unusual and complicated to do all this in one statement. But
>can't you just store that ena irq number into struct octep_hp_controller
>so you don't need to make the call here every time?
>

Will move this logic to a new function to get the vector type based on the =
irq
number. Avoided storing the irq number in the controller structure as we do=
n't
expect a lot of hotplug interrupts.

>> +	slot_mask =3D readq(hp_ctrl->base +
>OCTEP_HP_INTR_OFFSET(vec_type));
>> +	if (!slot_mask) {
>> +		dev_err(&pdev->dev, "Invalid slot mask %llx\n", slot_mask);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	hp_cmd =3D kzalloc(sizeof(*hp_cmd), GFP_ATOMIC);
>> +	if (!hp_cmd)
>> +		return IRQ_HANDLED;
>> +
>> +	hp_cmd->slot_mask =3D slot_mask;
>> +	hp_cmd->vec_type =3D vec_type;
>> +
>> +	/* Add the command to the list and schedule the work */
>> +	spin_lock(&hp_ctrl->hp_cmd_lock);
>> +	list_add_tail(&hp_cmd->list, &hp_ctrl->hp_cmd_list);
>> +	spin_unlock(&hp_ctrl->hp_cmd_lock);
>> +	schedule_work(&hp_ctrl->work);
>> +
>> +	/* Clear the interrupt */
>> +	writeq(slot_mask, hp_ctrl->base +
>OCTEP_HP_INTR_OFFSET(vec_type));
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static void octep_hp_deregister_slots(struct octep_hp_controller *hp_ct=
rl)
>> +{
>> +	struct octep_hp_slot *hp_slot, *tmp;
>> +
>> +	/* Deregister all the hotplug slots */
>> +	list_for_each_entry_safe(hp_slot, tmp, &hp_ctrl->slot_list, list) {
>> +		pci_hp_deregister(&hp_slot->slot);
>> +		octep_hp_enable_pdev(hp_ctrl, hp_slot);
>> +		list_del(&hp_slot->list);
>> +		kfree(hp_slot);
>> +	}
>> +}
>> +
>> +static void octep_hp_controller_cleanup(void *data)
>> +{
>> +	struct octep_hp_controller *hp_ctrl =3D data;
>> +
>> +	pci_free_irq_vectors(hp_ctrl->pdev);
>> +	flush_work(&hp_ctrl->work);
>> +	octep_hp_deregister_slots(hp_ctrl);
>> +}
>> +
>> +static int octep_hp_controller_setup(struct pci_dev *pdev, struct
>octep_hp_controller *hp_ctrl)
>> +{
>> +	struct device *dev =3D &pdev->dev;
>> +	int ret;
>> +
>> +	ret =3D pcim_enable_device(pdev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable PCI device\n");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D pcim_iomap_regions(pdev, BIT(0), OCTEP_HP_DRV_NAME);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to request MMIO region\n");
>> +		return ret;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +	pci_set_drvdata(pdev, hp_ctrl);
>> +
>> +	INIT_LIST_HEAD(&hp_ctrl->slot_list);
>> +	INIT_LIST_HEAD(&hp_ctrl->hp_cmd_list);
>> +	mutex_init(&hp_ctrl->slot_lock);
>> +	spin_lock_init(&hp_ctrl->hp_cmd_lock);
>> +	INIT_WORK(&hp_ctrl->work, octep_hp_work_handler);
>> +
>> +	hp_ctrl->pdev =3D pdev;
>> +	hp_ctrl->base =3D pcim_iomap_table(pdev)[0];
>> +	if (!hp_ctrl->base) {
>> +		dev_err(dev, "Failed to get device resource map\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret =3D pci_alloc_irq_vectors(pdev, 1,
>OCTEP_HP_INTR_VECTOR(OCTEP_HP_VEC_DIS) + 1,
>> +				    PCI_IRQ_MSIX);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to alloc MSI-X vectors");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D devm_add_action(dev, octep_hp_controller_cleanup, hp_ctrl);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to add action for controller cleanup\n");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D devm_request_irq(dev, pci_irq_vector(pdev,
>OCTEP_HP_INTR_VECTOR(OCTEP_HP_VEC_ENA)),
>> +			       octep_hp_intr_handler, 0, "octep_hp_ena",
>hp_ctrl);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register slot enable interrupt
>handle\n");
>> +		return ret;
>> +	}
>> +
>> +	ret =3D devm_request_irq(dev, pci_irq_vector(pdev,
>OCTEP_HP_INTR_VECTOR(OCTEP_HP_VEC_DIS)),
>> +			       octep_hp_intr_handler, 0, "octep_hp_dis", hp_ctrl);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register slot disable interrupt
>handle\n");
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int octep_hp_pci_probe(struct pci_dev *pdev, const struct
>pci_device_id *id)
>> +{
>> +	struct octep_hp_controller *hp_ctrl;
>> +	struct pci_dev *tmp_pdev =3D NULL;
>> +	u16 slot_number =3D 0;
>> +	int ret;
>> +
>> +	hp_ctrl =3D devm_kzalloc(&pdev->dev, sizeof(*hp_ctrl), GFP_KERNEL);
>> +	if (!hp_ctrl)
>> +		return -ENOMEM;
>> +
>> +	ret =3D octep_hp_controller_setup(pdev, hp_ctrl);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to setup octep controller\n");
>
>So both octep_hp_controller_setup() and this function print an error?
>Wouldn't the one from octep_hp_controller_setup() suffice?

Will remove the extra print.

>--
> i.
>
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Register all hotplug slots. Hotplug controller is the first functio=
n of
>the PCI device.
>> +	 * The hotplug slots are the remaining functions of the PCI device. Th=
ey
>are removed from
>> +	 * the bus and are added back when the hotplug event is triggered.
>
>Reflow the comment to 80 chars.

Will change.

>
>> +	 */
>> +	for_each_pci_dev(tmp_pdev) {
>> +		if (octep_hp_slot(hp_ctrl, tmp_pdev)) {
>
>Reverse logic & use continue.
>

Will change.

>> +			ret =3D octep_hp_register_slot(hp_ctrl, tmp_pdev,
>slot_number++);
>> +			if (ret) {
>> +				dev_err(&pdev->dev, "Failed to register
>hotplug slots.\n");
>> +				return ret;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3
>> +static struct pci_device_id octep_hp_pci_map[] =3D {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
>OCTEP_DEVID_HP_CONTROLLER) },
>> +	{ 0 },
>> +};
>> +
>> +static struct pci_driver octep_hp =3D {
>> +	.name     =3D OCTEP_HP_DRV_NAME,
>> +	.id_table =3D octep_hp_pci_map,
>> +	.probe    =3D octep_hp_pci_probe,
>> +};
>> +
>> +module_pci_driver(octep_hp);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Marvell");
>> +MODULE_DESCRIPTION("OCTEON PCIe device hotplug controller driver");
>>

Thanks for the review.
Shijith

