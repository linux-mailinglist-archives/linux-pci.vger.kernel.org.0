Return-Path: <linux-pci+bounces-14446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA699C9A0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 14:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455251F2160D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 12:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B168158853;
	Mon, 14 Oct 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QCtOD1f4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63E13D291;
	Mon, 14 Oct 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907351; cv=fail; b=UMqJiuY39WqJdQ2uk3Qy/17OEByDlJQHU8OYA4YH29u9nojmkbHjg77ZR8dmYfPCLJIPR549jhszab4fKmT4UQDX+pUkEl4EOHjQQ7cECL4eBboTbE+qVzzPJRtmgE0p6Bh2/ZyVJAuo65tKKwc3sbi8BiuEeuaHXoXAl91k/wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907351; c=relaxed/simple;
	bh=EZ2LW8rghIKpnsgypjkac44zcYKK3H9rcMyIuIzYZEw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pJndHacBibmyNtxFFN88hLJrc+//P/uL4T15x4+P1yzoETkUYiRT8oPFUeweyQzWySeHHRB+3RQagK3dqXnlNoeWqfHHPR1x7OC8TFRonzVVxO5n9NkDHPlEwNRx0RQuD9UDcH/TiHsEEgp0CZFBnEbjede7WiLS5proitDkHk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QCtOD1f4; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9kSso015853;
	Mon, 14 Oct 2024 05:01:55 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4290y706ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 05:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFMTG/09Ch1xcoT6UFzpOedZXMaca1zbTb672xgkwwVW4q2FWSfPvY5r4Jn77e7n5tm4T3QQhP+J7eqfcDG/GE/QACCmIPYZq4uPakqYH84eJZse+dtweQThJE5n1fP51VPrDZeNVGAMqK52ZXckC+d1QUIS3k09znUIoTBmmn3AO0+YZwTwY4roVbGj1/tkNScS7UeYBE1zEEc2vMYdqEi9va9hzy5O/+YGmpqAP4dR8NNbCh3DrYwZ6C8M3xoGgKGkvQ/TwaXjDQjBuk/Juz3FyKXW+68HdYx/P0ZeA5NDoIBLtpCbl9wXPHMYOvzlnYhvmeOQ8U+mggmwSMFjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LuplXxwndOIiMDcd82I3i1v5NQw8hyrocB28o/batA=;
 b=D1Puf1i/CxKDtZJSe1HFbLEiOJ7uQHgWEDQUTy4d07jS+wHzwxHyMspDfZQAOcRLHQosMmD63iJ8Hb/ZlQz25+BPpbXQgSJxi1A36Ql/fxyHiDAcLNAXf4xK9JXEBRosf4OSzmQ7E4XvsIB3nCoOC/swr0G8bEH6OcraP3Gbhjny6Yynzo/8gSwNRCOQBAJTC5stbf026Aa8R+VFfJ3kDSzijaGyB8R7+mpEME67DSZNetT+rhofi3NkflLcOBaes9Xp8A/tE7PwNPaDpsyGALXP0L70Xw49PPcA704j71uCYkagbl/MeEen1Pu96bI/ETKQU9hyl2KM7fkrknEueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LuplXxwndOIiMDcd82I3i1v5NQw8hyrocB28o/batA=;
 b=QCtOD1f4+8IDCh/vhSAOvgPVU8exGAV4l+ubRF9uBzoxgcp+Ts+9Ik9GMXB+j/I0MkJl/IHRawfUEuaYqn9T1cVF0efY+6fnOxxfPBIoUjtGepW/lw47fzfcNKc4HX1hivjcUNfZYqikuQGHNLJeqGEG2YY8MYyAuFGwUOnahzY=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by IA2PR18MB6053.namprd18.prod.outlook.com (2603:10b6:208:4aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 12:01:50 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 12:01:50 +0000
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
Thread-Index: AQHa96U5wMquoeCkjUiLMha3b4gFCrJZ8y0AgBAoL7CAHFZOMA==
Date: Mon, 14 Oct 2024 12:01:50 +0000
Message-ID:
 <PH0PR18MB4425833D3D768EA6558ACEBBD9442@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20240823052251.1087505-1-sthotton@marvell.com>
 <20240826104531.1232136-1-sthotton@marvell.com>
 <PH0PR18MB4425913FD7CCB42864311F52D9602@PH0PR18MB4425.namprd18.prod.outlook.com>
 <PH0PR18MB44255522F80C7113038EB8A3D96A2@PH0PR18MB4425.namprd18.prod.outlook.com>
In-Reply-To:
 <PH0PR18MB44255522F80C7113038EB8A3D96A2@PH0PR18MB4425.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|IA2PR18MB6053:EE_
x-ms-office365-filtering-correlation-id: de8b5ad5-7cb1-4e99-10fd-08dcec47fc74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kuWBxYVZKFvl2m3DLPNErs5QFy1yjJCY3vrPEkWGZCZUF7569WWJD8orghYK?=
 =?us-ascii?Q?EmZYwrqwFWit3Pc97Xn9Nb+dzZjLo0rsCySkD97I7C4x2XqfqGsV34y0U7rM?=
 =?us-ascii?Q?Z22PjY+dqOa8j0ey0oYro5G2ClCMWZFHN4zNz1qJLifw6QLUuq5IwYD0FNRc?=
 =?us-ascii?Q?Q2+JAJxOGmYjtmWpl7/dI7bp9fjklMOEST9wbReNPQdgUz7VcRovyn/1FSb5?=
 =?us-ascii?Q?luluDAPfC7COPBQTXR3hHo1gZfwRhMIKma0ajZQRu6D/GhjiQ9KCwgQNa99O?=
 =?us-ascii?Q?9iM/ayrzJowJad7JAyAzJBIPvrIfJRN+IyXy8iGa4pTcm2OSuYCDk0OgXB/3?=
 =?us-ascii?Q?+fp6+XxZjwXORqnyvgR+AIJQdTM6E4kL499ulrzMcRGbxN2ZneaQpf/SXtEi?=
 =?us-ascii?Q?oDmhwg8iis7PscUBcasaFGb2P4+PRljInMoupBfj/ppXSWZa6ugkZcje0xro?=
 =?us-ascii?Q?bk3B2eY5MYFNmUnr/7G7YplZzM/PaJyZ+l5yxqmYQmTk+n4l3b3BBEaIqzTZ?=
 =?us-ascii?Q?hlVwaYElaXn/7tBy6a/qb3l9pETSc984T8CkMkJY/FPAHhYquczbgBVDUmev?=
 =?us-ascii?Q?Yv16syvjL4NkpdLgfuaPZ0v0+32CCXRofs6tU+bKCES3Gp62+dYjVogTyAWU?=
 =?us-ascii?Q?HBCOUEpJjP81jOk1TwbbqbsxfBN1nKTrRrWz0I8l/zaBczbIOUEVCyTDzhiC?=
 =?us-ascii?Q?m0VMZps+hjgqaY/cg6PKCo2xYjh8UUpdxUfLvJQ3a5tsdea6V6LyBeV81ik6?=
 =?us-ascii?Q?ZaajnqCPnfy/QNAtVWTY+gh++Etc8RBLT5FMjNo/irwPVPMthD0rK90Q1U+c?=
 =?us-ascii?Q?aCKNeJk5wG/wg84KzXOi5X8eVMd4/hMunxK7HBKhafqe78zmE1PRvBEf/dQr?=
 =?us-ascii?Q?igWj2Tqi6wOekrLm8cT7aJXws34qX5ZGPP0UAh4Zk8IPDZhEOaAV/S66Fc+A?=
 =?us-ascii?Q?fd/pN+rQKd7WL0pwMXsh6CkfoEDcf/+Zg++z9UhkIiEO4E+6mLmdk5wplsS4?=
 =?us-ascii?Q?rDJ0TxQDbzHI0RhQ4f//lNdjWJrYhEnSSq405YnuJYr95E6VHSQYIMlPbZVF?=
 =?us-ascii?Q?oSwxzApsWL7UAbfY0ZxLwnkrOzvu2iuenD5YHmKVV1mqAcl6+5v8y2wbRH+h?=
 =?us-ascii?Q?1DLbuVBtN/r5Sw6Zpjmu4F3SBU46Jkdue0QXpkpBpAKEBdrrK76DPAIW0PCm?=
 =?us-ascii?Q?iWks7TpYeJtrx4e1NJ2Lpyhr0uqo8FoT+lZ7uDPjgmzRrjt68pQmc26TO/S0?=
 =?us-ascii?Q?2ilGNlbIPE+dyMs+IJ2PnKxUyOzKd5++arIomXMJAd0a6avRr+9Xrie8FHps?=
 =?us-ascii?Q?zTm+LHMVHP+7sj9KXDb7AfCjJVH+9zjliEfuJm/CTtHbUA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zjF6zLD7BRrCXBiY5CEQ0C2kV5dNdI5L8yteOqVYJC9FT2BboEYspHndOCjO?=
 =?us-ascii?Q?B04Avc4X+qHdIoweNGmgrCrcwA60gepvTHmuPAweMcjOngFPLu5zo3Uiw8CB?=
 =?us-ascii?Q?W4H0KNtM2g0sMM/V6EnVU8S58wn0rjvTlipbD344O6QHDYoKXUmMF6cW6Ql/?=
 =?us-ascii?Q?2zpPMG5Iv0xViwo+ezI5/mIRHzkG7S1u7HkHDgv0hV8y1PniNnNXPm4lTU7E?=
 =?us-ascii?Q?0ohFMBMdiQrk/vhThoOmpHGZrakYY+Kd336cTpRiWr9Ms7AIZGhancFlj46J?=
 =?us-ascii?Q?H8g9E8hqEzDG0LtZ87bCxg1d+Et29+3uuP/jxp3+JCJ9x0gj/0W+edd5PQkF?=
 =?us-ascii?Q?8Tnn0MFsZ7o3u3RcA7vASD/BPtQAnaDDiCyiv2pGCpW56hUZbnV4RqAVcErZ?=
 =?us-ascii?Q?kacHLAWH2NkxS65iKNg3uKBRdozDJLvOdOkzTDL7FK3xtqiIiqcWnBzKa5mW?=
 =?us-ascii?Q?c+edg/Fm5pB7k4lI/aUp8iypOkwe3LFCdFEsCjfoP2ZlFIiEysgnfe0yn6B/?=
 =?us-ascii?Q?p7qlCXtA9LK51yALEuOPCtTpmwMozAJZdgtjVWoYGq08EWCFc0qFBixh/oAC?=
 =?us-ascii?Q?MlUeN8fBg5s4rX2U/BFdy15/sTPsQPeALpDgfH97fQrElQKmhcDPj7TTBjVC?=
 =?us-ascii?Q?wRqytqWDRtxqPyqJRXjqph295hBWm8lt9rna/ebMJsI/Edw33XHaFlXByVIr?=
 =?us-ascii?Q?ObFAN+LHeZWqas486Npj7Bo0nh/5JNR7/OtiIM6Gda2T04OhiwEtt4Qw3U07?=
 =?us-ascii?Q?nJtue6D/SpRMHWpqJiWK2kz/hX/6p76YFGNdKvJ4d6ktLhMqJnv+oyz3wVxh?=
 =?us-ascii?Q?IPjBoUrl3E5tJc09/XPvF9nFfqMQ+C4cirohM9NgBd3QMk1HCWcL+31cckh6?=
 =?us-ascii?Q?8yKZR10gA6j9s1Wp4C0oCyqO5KouS84J5uvAmvF7DjaO4HKqS1xl1IAeTBwC?=
 =?us-ascii?Q?VwHJF2zVZTt2vvovBsKL9urndgt9/jmikJJSVCCyHGmComUdnpZkaASKISw5?=
 =?us-ascii?Q?9rFzojenxzQyT/vSKXbXejPwFzjpbHMwdnm5ZEY0NRQKnqNoMq7zB8mI0rY3?=
 =?us-ascii?Q?LdymJgRlhnGmYuNqYmU3ex+7/RqO83id9johGzHWtTwevuCKJ+h0OSRpzDgZ?=
 =?us-ascii?Q?7DnxUke6gFFVDwOSQnEiOnHMup88Hle4CJvQdlHeVnwwc9+FPzFNbl/lpI9Q?=
 =?us-ascii?Q?qDPkA23tXuGsnFZ1HEIy6nxH92I8SCoS2bDKm9hP6ohhtulK7uiQ/mwtZWm7?=
 =?us-ascii?Q?YJaArR1wOBbDanGddyG2ul2daFJ9lJYmyPc5qwLPsjnkSynZ5XoUfZ/WA/z9?=
 =?us-ascii?Q?O3SXo5VaQQ/z5k9IaBAidmHAFVbFaYf4koexM00A7IrY4AiRoFyqjX/N7kiL?=
 =?us-ascii?Q?OgGBBKBB7rFWxSGt6p2oOw9nZi9Q9mhg/RJEFq1ywRvC8UPiS5gYSTJYVnJ2?=
 =?us-ascii?Q?omkUhajfBzOsdNTdRd0mO3bfCKcwtPGPM79cLuwTEgJPwzyST9arleXEeHdO?=
 =?us-ascii?Q?HnVQ8wEtuLKMxKR7M1vvDWXI8X7RTnY8LXP37dDCeWEA4/nAWHQmvBnAh3Fv?=
 =?us-ascii?Q?sOA7j5aZHURyPGs6NI2B5hiuuzPkZjijRNEqNH/N?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de8b5ad5-7cb1-4e99-10fd-08dcec47fc74
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 12:01:50.1865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1HtY+xNdgOxD/I1KUW788Ky8WmOfnx6TA6kWb2GRz7znNPwG5n+rlXZODzlPwv0FzJ1wj3a5Isq5IJwi2HuWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB6053
X-Proofpoint-GUID: nbOqvQsAkgkTd4bj_-d3nxNhgpn-ZEL_
X-Proofpoint-ORIG-GUID: nbOqvQsAkgkTd4bj_-d3nxNhgpn-ZEL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Just a gentle reminder to review the patch when you get a chance.
let me know if any adjustments are needed. Thanks!

>Just a gentle reminder.
>Could you please comments if there are improvements needed?
>
>>Hi Helgaas,
>>
>>Please check this patch.
>>
>>>This patch introduces a PCI hotplug controller driver for the OCTEON
>>>PCIe device, a multi-function PCIe device where the first function acts
>>>as a hotplug controller. It is equipped with MSI-x interrupts to notify
>>>the host of hotplug events from the OCTEON firmware.
>>>
>>>The driver facilitates the hotplugging of non-controller functions
>>>within the same device. During probe, non-controller functions are
>>>removed and registered as PCI hotplug slots. The slots are added back
>>>only upon request from the device firmware. The driver also allows the
>>>enabling and disabling of the slots via sysfs slot entries, provided by
>>>the PCI hotplug framework.
>>>
>>>Signed-off-by: Shijith Thotton <sthotton@marvell.com>
>>>Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
>>>Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>>>---
>>>
>>>This patch introduces a PCI hotplug controller driver for OCTEON PCIe
>hotplug
>>>controller. The OCTEON PCIe device is a multi-function device where the =
first
>>>function acts as a PCI hotplug controller.
>>>
>>>              +--------------------------------+
>>>              |           Root Port            |
>>>              +--------------------------------+
>>>                              |
>>>                             PCIe
>>>                              |
>>>+---------------------------------------------------------------+
>>>|              OCTEON PCIe Multifunction Device                 |
>>>+---------------------------------------------------------------+
>>>            |                    |              |            |
>>>            |                    |              |            |
>>>+---------------------+  +----------------+  +-----+  +----------------+
>>>|      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
>>>| (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
>>>+---------------------+  +----------------+  +-----+  +----------------+
>>>            |
>>>            |
>>>+-------------------------+
>>>|   Controller Firmware   |
>>>+-------------------------+
>>>
>>>The hotplug controller driver facilitates the hotplugging of non-control=
ler
>>>functions in the same device. During the probe of the driver, the non-
>>controller
>>>function are removed and registered as PCI hotplug slots. They are added
>back
>>>only upon request from the device firmware. The driver also allows the u=
ser
>to
>>>enable/disable the functions using sysfs slot entries provided by PCI ho=
tplug
>>>framework.
>>>
>>>This solution adopts a hardware + software approach for several reasons:
>>>
>>>1. To reduce hardware implementation cost. Supporting complete hotplug
>>>   capability within the card would require a PCI switch implemented wit=
hin.
>>>
>>>2. In the multi-function device, non-controller functions can act as emu=
lated
>>>   devices. The firmware can dynamically enable or disable them at runti=
me.
>>>
>>>3. Not all root ports support PCI hotplug. This approach provides greate=
r
>>>   flexibility and compatibility across different hardware configuration=
s.
>>>
>>>The hotplug controller function is lightweight and is equipped with MSI-=
x
>>>interrupts to notify the host about hotplug events. Upon receiving an
>>>interrupt, the hotplug register is read, and the required function is en=
abled
>>>or disabled.
>>>
>>>This driver will be beneficial for managing PCI hotplug events on the OC=
TEON
>>>PCIe device without requiring complex hardware solutions.
>>>
>>>Changes in v2:
>>>- Added missing include files.
>>>- Used dev_err_probe() for error handling.
>>>- Used guard() for mutex locking.
>>>- Splited cleanup actions and added per-slot cleanup action.
>>>- Fixed coding style issues.
>>>- Added co-developed-by tag.
>>>
>>>Changes in v3:
>>>- Explicit assignment of enum values.
>>>- Use pcim_iomap_region() instead of pcim_iomap_regions().
>>>
>>> MAINTAINERS                    |   6 +
>>> drivers/pci/hotplug/Kconfig    |  10 +
>>> drivers/pci/hotplug/Makefile   |   1 +
>>> drivers/pci/hotplug/octep_hp.c | 409
>>>+++++++++++++++++++++++++++++++++
>>> 4 files changed, 426 insertions(+)
>>> create mode 100644 drivers/pci/hotplug/octep_hp.c
>>>
>>>diff --git a/MAINTAINERS b/MAINTAINERS
>>>index 42decde38320..7b5a618eed1c 100644
>>>--- a/MAINTAINERS
>>>+++ b/MAINTAINERS
>>>@@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
>>> R:	vattunuru@marvell.com
>>> F:	drivers/vdpa/octeon_ep/
>>>
>>>+MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
>>>+R:	Shijith Thotton <sthotton@marvell.com>
>>>+R:	Vamsi Attunuru <vattunuru@marvell.com>
>>>+S:	Supported
>>>+F:	drivers/pci/hotplug/octep_hp.c
>>>+
>>> MATROX FRAMEBUFFER DRIVER
>>> L:	linux-fbdev@vger.kernel.org
>>> S:	Orphan
>>>diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>>>index 1472aef0fb81..2e38fd25f7ef 100644
>>>--- a/drivers/pci/hotplug/Kconfig
>>>+++ b/drivers/pci/hotplug/Kconfig
>>>@@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
>>>
>>> 	  When in doubt, say Y.
>>>
>>>+config HOTPLUG_PCI_OCTEONEP
>>>+	bool "OCTEON PCI device Hotplug controller driver"
>>>+	depends on HOTPLUG_PCI
>>>+	help
>>>+	  Say Y here if you have an OCTEON PCIe device with a hotplug
>>>+	  controller. This driver enables the non-controller functions of the
>>>+	  device to be registered as hotplug slots.
>>>+
>>>+	  When in doubt, say N.
>>>+
>>> endif # HOTPLUG_PCI
>>>diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>>>index 240c99517d5e..40aaf31fe338 100644
>>>--- a/drivers/pci/hotplug/Makefile
>>>+++ b/drivers/pci/hotplug/Makefile
>>>@@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+=3D
>>>rpaphp.o
>>> obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+=3D rpadlpar_io.o
>>> obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+=3D acpiphp.o
>>> obj-$(CONFIG_HOTPLUG_PCI_S390)		+=3D s390_pci_hpc.o
>>>+obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+=3D octep_hp.o
>>>
>>> # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>>>
>>>diff --git a/drivers/pci/hotplug/octep_hp.c
>b/drivers/pci/hotplug/octep_hp.c
>>>new file mode 100644
>>>index 000000000000..77dc2740f43e
>>>--- /dev/null
>>>+++ b/drivers/pci/hotplug/octep_hp.c
>>>@@ -0,0 +1,409 @@
>>>+// SPDX-License-Identifier: GPL-2.0-only
>>>+/* Copyright (C) 2024 Marvell. */
>>>+
>>>+#include <linux/cleanup.h>
>>>+#include <linux/container_of.h>
>>>+#include <linux/delay.h>
>>>+#include <linux/dev_printk.h>
>>>+#include <linux/init.h>
>>>+#include <linux/interrupt.h>
>>>+#include <linux/io-64-nonatomic-lo-hi.h>
>>>+#include <linux/kernel.h>
>>>+#include <linux/list.h>
>>>+#include <linux/module.h>
>>>+#include <linux/mutex.h>
>>>+#include <linux/pci.h>
>>>+#include <linux/pci_hotplug.h>
>>>+#include <linux/slab.h>
>>>+#include <linux/spinlock.h>
>>>+#include <linux/workqueue.h>
>>>+
>>>+#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
>>>+#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
>>>+#define OCTEP_HP_DRV_NAME "octep_hp"
>>>+
>>>+/*
>>>+ * Type of MSI-X interrupts.
>>>+ * The macros OCTEP_HP_INTR_VECTOR and OCTEP_HP_INTR_OFFSET are
>>>used to
>>>+ * generate the vector and offset for an interrupt type.
>>>+ */
>>>+enum octep_hp_intr_type {
>>>+	OCTEP_HP_INTR_INVALID =3D -1,
>>>+	OCTEP_HP_INTR_ENA =3D 0,
>>>+	OCTEP_HP_INTR_DIS =3D 1,
>>>+	OCTEP_HP_INTR_MAX =3D 2,
>>>+};
>>>+
>>>+struct octep_hp_cmd {
>>>+	struct list_head list;
>>>+	enum octep_hp_intr_type intr_type;
>>>+	u64 intr_val;
>>>+};
>>>+
>>>+struct octep_hp_slot {
>>>+	struct list_head list;
>>>+	struct hotplug_slot slot;
>>>+	u16 slot_number;
>>>+	struct pci_dev *hp_pdev;
>>>+	unsigned int hp_devfn;
>>>+	struct octep_hp_controller *ctrl;
>>>+};
>>>+
>>>+struct octep_hp_intr_info {
>>>+	enum octep_hp_intr_type type;
>>>+	int number;
>>>+	char name[16];
>>>+};
>>>+
>>>+struct octep_hp_controller {
>>>+	void __iomem *base;
>>>+	struct pci_dev *pdev;
>>>+	struct octep_hp_intr_info intr[OCTEP_HP_INTR_MAX];
>>>+	struct work_struct work;
>>>+	struct list_head slot_list;
>>>+	struct mutex slot_lock; /* Protects slot_list */
>>>+	struct list_head hp_cmd_list;
>>>+	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
>>>+};
>>>+
>>>+static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
>>>+				 struct octep_hp_slot *hp_slot)
>>>+{
>>>+	guard(mutex)(&hp_ctrl->slot_lock);
>>>+	if (hp_slot->hp_pdev) {
>>>+		dev_dbg(&hp_slot->hp_pdev->dev, "Slot %u already
>>>enabled\n",
>>>+			hp_slot->slot_number);
>>>+		return;
>>>+	}
>>>+
>>>+	/* Scan the device and add it to the bus */
>>>+	hp_slot->hp_pdev =3D pci_scan_single_device(hp_ctrl->pdev->bus,
>>>+						  hp_slot->hp_devfn);
>>>+	pci_bus_assign_resources(hp_ctrl->pdev->bus);
>>>+	pci_bus_add_device(hp_slot->hp_pdev);
>>>+
>>>+	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %u\n",
>>>+		hp_slot->slot_number);
>>>+}
>>>+
>>>+static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
>>>+				  struct octep_hp_slot *hp_slot)
>>>+{
>>>+	guard(mutex)(&hp_ctrl->slot_lock);
>>>+	if (!hp_slot->hp_pdev) {
>>>+		dev_dbg(&hp_ctrl->pdev->dev, "Slot %u already disabled\n",
>>>+			hp_slot->slot_number);
>>>+		return;
>>>+	}
>>>+
>>>+	dev_dbg(&hp_slot->hp_pdev->dev, "Disabling slot %u\n",
>>>+		hp_slot->slot_number);
>>>+
>>>+	/* Remove the device from the bus */
>>>+	pci_stop_and_remove_bus_device_locked(hp_slot->hp_pdev);
>>>+	hp_slot->hp_pdev =3D NULL;
>>>+}
>>>+
>>>+static int octep_hp_enable_slot(struct hotplug_slot *slot)
>>>+{
>>>+	struct octep_hp_slot *hp_slot =3D
>>>+		container_of(slot, struct octep_hp_slot, slot);
>>>+
>>>+	octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
>>>+	return 0;
>>>+}
>>>+
>>>+static int octep_hp_disable_slot(struct hotplug_slot *slot)
>>>+{
>>>+	struct octep_hp_slot *hp_slot =3D
>>>+		container_of(slot, struct octep_hp_slot, slot);
>>>+
>>>+	octep_hp_disable_pdev(hp_slot->ctrl, hp_slot);
>>>+	return 0;
>>>+}
>>>+
>>>+static struct hotplug_slot_ops octep_hp_slot_ops =3D {
>>>+	.enable_slot =3D octep_hp_enable_slot,
>>>+	.disable_slot =3D octep_hp_disable_slot,
>>>+};
>>>+
>>>+#define SLOT_NAME_SIZE 16
>>>+static struct octep_hp_slot *
>>>+octep_hp_register_slot(struct octep_hp_controller *hp_ctrl,
>>>+		       struct pci_dev *pdev, u16 slot_number)
>>>+{
>>>+	char slot_name[SLOT_NAME_SIZE];
>>>+	struct octep_hp_slot *hp_slot;
>>>+	int ret;
>>>+
>>>+	hp_slot =3D kzalloc(sizeof(*hp_slot), GFP_KERNEL);
>>>+	if (!hp_slot)
>>>+		return ERR_PTR(-ENOMEM);
>>>+
>>>+	hp_slot->ctrl =3D hp_ctrl;
>>>+	hp_slot->hp_pdev =3D pdev;
>>>+	hp_slot->hp_devfn =3D pdev->devfn;
>>>+	hp_slot->slot_number =3D slot_number;
>>>+	hp_slot->slot.ops =3D &octep_hp_slot_ops;
>>>+
>>>+	snprintf(slot_name, sizeof(slot_name), "octep_hp_%u", slot_number);
>>>+	ret =3D pci_hp_register(&hp_slot->slot, hp_ctrl->pdev->bus,
>>>+			      PCI_SLOT(pdev->devfn), slot_name);
>>>+	if (ret) {
>>>+		kfree(hp_slot);
>>>+		return ERR_PTR(ret);
>>>+	}
>>>+
>>>+	list_add_tail(&hp_slot->list, &hp_ctrl->slot_list);
>>>+	octep_hp_disable_pdev(hp_ctrl, hp_slot);
>>>+
>>>+	return hp_slot;
>>>+}
>>>+
>>>+static void octep_hp_deregister_slot(void *data)
>>>+{
>>>+	struct octep_hp_slot *hp_slot =3D data;
>>>+	struct octep_hp_controller *hp_ctrl =3D hp_slot->ctrl;
>>>+
>>>+	pci_hp_deregister(&hp_slot->slot);
>>>+	octep_hp_enable_pdev(hp_ctrl, hp_slot);
>>>+	list_del(&hp_slot->list);
>>>+	kfree(hp_slot);
>>>+}
>>>+
>>>+static bool octep_hp_is_slot(struct octep_hp_controller *hp_ctrl,
>>>+			     struct pci_dev *pdev)
>>>+{
>>>+	/* Check if the PCI device can be hotplugged */
>>>+	return pdev !=3D hp_ctrl->pdev && pdev->bus =3D=3D hp_ctrl->pdev->bus =
&&
>>>+	       PCI_SLOT(pdev->devfn) =3D=3D PCI_SLOT(hp_ctrl->pdev->devfn);
>>>+}
>>>+
>>>+static void octep_hp_cmd_handler(struct octep_hp_controller *hp_ctrl,
>>>+				 struct octep_hp_cmd *hp_cmd)
>>>+{
>>>+	struct octep_hp_slot *hp_slot;
>>>+
>>>+	/*
>>>+	 * Enable or disable the slots based on the slot mask.
>>>+	 * intr_val is a bit mask where each bit represents a slot.
>>>+	 */
>>>+	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
>>>+		if (!(hp_cmd->intr_val & BIT(hp_slot->slot_number)))
>>>+			continue;
>>>+
>>>+		if (hp_cmd->intr_type =3D=3D OCTEP_HP_INTR_ENA)
>>>+			octep_hp_enable_pdev(hp_ctrl, hp_slot);
>>>+		else
>>>+			octep_hp_disable_pdev(hp_ctrl, hp_slot);
>>>+	}
>>>+}
>>>+
>>>+static void octep_hp_work_handler(struct work_struct *work)
>>>+{
>>>+	struct octep_hp_controller *hp_ctrl;
>>>+	struct octep_hp_cmd *hp_cmd;
>>>+	unsigned long flags;
>>>+
>>>+	hp_ctrl =3D container_of(work, struct octep_hp_controller, work);
>>>+
>>>+	/* Process all the hotplug commands */
>>>+	spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>>>+	while (!list_empty(&hp_ctrl->hp_cmd_list)) {
>>>+		hp_cmd =3D list_first_entry(&hp_ctrl->hp_cmd_list,
>>>+					  struct octep_hp_cmd, list);
>>>+		list_del(&hp_cmd->list);
>>>+		spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>>>+
>>>+		octep_hp_cmd_handler(hp_ctrl, hp_cmd);
>>>+		kfree(hp_cmd);
>>>+
>>>+		spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>>>+	}
>>>+	spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>>>+}
>>>+
>>>+static enum octep_hp_intr_type octep_hp_intr_type(struct
>>>octep_hp_intr_info *intr,
>>>+						  int irq)
>>>+{
>>>+	enum octep_hp_intr_type type;
>>>+
>>>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>>>type++) {
>>>+		if (intr[type].number =3D=3D irq)
>>>+			return type;
>>>+	}
>>>+
>>>+	return OCTEP_HP_INTR_INVALID;
>>>+}
>>>+
>>>+static irqreturn_t octep_hp_intr_handler(int irq, void *data)
>>>+{
>>>+	struct octep_hp_controller *hp_ctrl =3D data;
>>>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>>>+	enum octep_hp_intr_type type;
>>>+	struct octep_hp_cmd *hp_cmd;
>>>+	u64 intr_val;
>>>+
>>>+	type =3D octep_hp_intr_type(hp_ctrl->intr, irq);
>>>+	if (type =3D=3D OCTEP_HP_INTR_INVALID) {
>>>+		dev_err(&pdev->dev, "Invalid interrupt %d\n", irq);
>>>+		return IRQ_HANDLED;
>>>+	}
>>>+
>>>+	/* Read and clear the interrupt */
>>>+	intr_val =3D readq(hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>>>+	writeq(intr_val, hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>>>+
>>>+	hp_cmd =3D kzalloc(sizeof(*hp_cmd), GFP_ATOMIC);
>>>+	if (!hp_cmd)
>>>+		return IRQ_HANDLED;
>>>+
>>>+	hp_cmd->intr_val =3D intr_val;
>>>+	hp_cmd->intr_type =3D type;
>>>+
>>>+	/* Add the command to the list and schedule the work */
>>>+	spin_lock(&hp_ctrl->hp_cmd_lock);
>>>+	list_add_tail(&hp_cmd->list, &hp_ctrl->hp_cmd_list);
>>>+	spin_unlock(&hp_ctrl->hp_cmd_lock);
>>>+	schedule_work(&hp_ctrl->work);
>>>+
>>>+	return IRQ_HANDLED;
>>>+}
>>>+
>>>+static void octep_hp_irq_cleanup(void *data)
>>>+{
>>>+	struct octep_hp_controller *hp_ctrl =3D data;
>>>+
>>>+	pci_free_irq_vectors(hp_ctrl->pdev);
>>>+	flush_work(&hp_ctrl->work);
>>>+}
>>>+
>>>+static int octep_hp_request_irq(struct octep_hp_controller *hp_ctrl,
>>>+				enum octep_hp_intr_type type)
>>>+{
>>>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>>>+	struct octep_hp_intr_info *intr;
>>>+	int irq;
>>>+
>>>+	irq =3D pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(type));
>>>+	if (irq < 0)
>>>+		return irq;
>>>+
>>>+	intr =3D &hp_ctrl->intr[type];
>>>+	intr->number =3D irq;
>>>+	intr->type =3D type;
>>>+	snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
>>>+
>>>+	return devm_request_irq(&pdev->dev, irq, octep_hp_intr_handler,
>>>+				IRQF_SHARED, intr->name, hp_ctrl);
>>>+}
>>>+
>>>+static int octep_hp_controller_setup(struct pci_dev *pdev,
>>>+				     struct octep_hp_controller *hp_ctrl)
>>>+{
>>>+	struct device *dev =3D &pdev->dev;
>>>+	enum octep_hp_intr_type type;
>>>+	int ret;
>>>+
>>>+	ret =3D pcim_enable_device(pdev);
>>>+	if (ret)
>>>+		return dev_err_probe(dev, ret, "Failed to enable PCI device\n");
>>>+
>>>+	hp_ctrl->base =3D pcim_iomap_region(pdev, 0, OCTEP_HP_DRV_NAME);
>>>+	if (IS_ERR(hp_ctrl->base))
>>>+		return dev_err_probe(dev, PTR_ERR(hp_ctrl->base),
>>>+				     "Failed to map PCI device region\n");
>>>+
>>>+	pci_set_master(pdev);
>>>+	pci_set_drvdata(pdev, hp_ctrl);
>>>+
>>>+	INIT_LIST_HEAD(&hp_ctrl->slot_list);
>>>+	INIT_LIST_HEAD(&hp_ctrl->hp_cmd_list);
>>>+	mutex_init(&hp_ctrl->slot_lock);
>>>+	spin_lock_init(&hp_ctrl->hp_cmd_lock);
>>>+	INIT_WORK(&hp_ctrl->work, octep_hp_work_handler);
>>>+	hp_ctrl->pdev =3D pdev;
>>>+
>>>+	ret =3D pci_alloc_irq_vectors(pdev, 1,
>>>+
>>>OCTEP_HP_INTR_VECTOR(OCTEP_HP_INTR_MAX),
>>>+				    PCI_IRQ_MSIX);
>>>+	if (ret < 0)
>>>+		return dev_err_probe(dev, ret, "Failed to alloc MSI-X
>>>vectors\n");
>>>+
>>>+	ret =3D devm_add_action(&pdev->dev, octep_hp_irq_cleanup, hp_ctrl);
>>>+	if (ret)
>>>+		return dev_err_probe(&pdev->dev, ret, "Failed to add IRQ
>>>cleanup action\n");
>>>+
>>>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>>>type++) {
>>>+		ret =3D octep_hp_request_irq(hp_ctrl, type);
>>>+		if (ret)
>>>+			return dev_err_probe(dev, ret,
>>>+					     "Failed to request IRQ for vector
>>>%d\n",
>>>+					     OCTEP_HP_INTR_VECTOR(type));
>>>+	}
>>>+
>>>+	return 0;
>>>+}
>>>+
>>>+static int octep_hp_pci_probe(struct pci_dev *pdev,
>>>+			      const struct pci_device_id *id)
>>>+{
>>>+	struct octep_hp_controller *hp_ctrl;
>>>+	struct pci_dev *tmp_pdev =3D NULL;
>>>+	struct octep_hp_slot *hp_slot;
>>>+	u16 slot_number =3D 0;
>>>+	int ret;
>>>+
>>>+	hp_ctrl =3D devm_kzalloc(&pdev->dev, sizeof(*hp_ctrl), GFP_KERNEL);
>>>+	if (!hp_ctrl)
>>>+		return -ENOMEM;
>>>+
>>>+	ret =3D octep_hp_controller_setup(pdev, hp_ctrl);
>>>+	if (ret)
>>>+		return ret;
>>>+
>>>+	/*
>>>+	 * Register all hotplug slots. Hotplug controller is the first functio=
n
>>>+	 * of the PCI device. The hotplug slots are the remaining functions of
>>>+	 * the PCI device. They are removed from the bus and are added back
>>>when
>>>+	 * the hotplug event is triggered.
>>>+	 */
>>>+	for_each_pci_dev(tmp_pdev) {
>>>+		if (!octep_hp_is_slot(hp_ctrl, tmp_pdev))
>>>+			continue;
>>>+
>>>+		hp_slot =3D octep_hp_register_slot(hp_ctrl, tmp_pdev,
>>>slot_number);
>>>+		if (IS_ERR(hp_slot))
>>>+			return dev_err_probe(&pdev->dev, PTR_ERR(hp_slot),
>>>+					     "Failed to register hotplug slot
>>>%u\n",
>>>+					     slot_number);
>>>+
>>>+		ret =3D devm_add_action(&pdev->dev, octep_hp_deregister_slot,
>>>+				      hp_slot);
>>>+		if (ret)
>>>+			return dev_err_probe(&pdev->dev, ret,
>>>+					     "Failed to add action for
>>>deregistering slot %u\n",
>>>+					     slot_number);
>>>+		slot_number++;
>>>+	}
>>>+
>>>+	return 0;
>>>+}
>>>+
>>>+#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3
>>>+static struct pci_device_id octep_hp_pci_map[] =3D {
>>>+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
>>>OCTEP_DEVID_HP_CONTROLLER) },
>>>+	{ },
>>>+};
>>>+
>>>+static struct pci_driver octep_hp =3D {
>>>+	.name =3D OCTEP_HP_DRV_NAME,
>>>+	.id_table =3D octep_hp_pci_map,
>>>+	.probe =3D octep_hp_pci_probe,
>>>+};
>>>+
>>>+module_pci_driver(octep_hp);
>>>+
>>>+MODULE_LICENSE("GPL");
>>>+MODULE_AUTHOR("Marvell");
>>>+MODULE_DESCRIPTION("OCTEON PCIe device hotplug controller driver");
>>>--
>>>2.25.1
>>

