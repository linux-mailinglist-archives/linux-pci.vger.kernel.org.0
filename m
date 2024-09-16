Return-Path: <linux-pci+bounces-13227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C3979A70
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 06:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F263281373
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 04:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A67E20B28;
	Mon, 16 Sep 2024 04:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="s5cy0gro"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95E1BDCF;
	Mon, 16 Sep 2024 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726461873; cv=fail; b=n+AKq3tHaJgBF85a5muNxjsP1adN0WRMwRNq3mCqvSr/bX8kKbvM1LISN19M0TiLH7CgG7QOmRjay6u8/0reJhgPtyZNLGGMN06kADCK8NI1hqEKf8zx/aHyewCIKw3dIqldQ7yN3YgbJQKXma7qxlxDxaRJ/a1ryYuPjSiMzWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726461873; c=relaxed/simple;
	bh=3x2lIP6kwZmkzGQ9vBIK5AU5WwrYU84lFNs5+WjmZr0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aCQLG3CPZQ1nVqBr2n4i4dpGFsMCG6zwonH4a8Y94top0ZJGlK5TIVDXYt6oBPvUf3reouVqHrAc53cdtnuWNJy+FBf3Q7MZDLnNW+6pqezwVWva7Vxwxjmo4z1Kcpcregw9AYJF7gKqaDAT9Cyq3guZZrwQSvcZUFPXNJcg7U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=s5cy0gro; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FLdfiU017267;
	Sun, 15 Sep 2024 21:43:56 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41na0fv5sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Sep 2024 21:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpNyzEscUqaIA4GQWyLIJSQnmAautOKzfmuf+drYzpkEKyDdb5JtUNx7hPKtBQgIIUeHI/TpAFhFRdS5Hmch2EwI/oVu/DArP4+ccX/z/3ROcb4PU1tdpr+91Ot9HI+hON42Wm/cqrzVACzxfSBLnMehGL0mzNlGCasu7nMMeniB5V9L/D5p6FOdKo6+MsThIa/fnggu7CSOQWRcLD/MojLCYEwHXxjj48DsIqaE36353xmDPNci7/EZyZPEFyYXG9EGoOkhvVOCr8Sb8m6MA+muy+kDCsiotKpfxcxmuAECKK3oNan+ca/uf24BoTxZF1J7QjJ8CbViM5R7Hae8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFtIa/KFLOatWiAeK5euQ1GTZLanvYdvjGnmRzbvJ8Y=;
 b=t91HSWVduGOZVbTPdyiSkGzR3ag3vJbmkrZf1AOG2B/ysPFd5ZjSTUNNIemUwCBxCJdF902y+/Jz8N/EBzv0vw5enUP6yItxVEbe04THgc5EHzY5IIpwC2XqFx21mw0UXXA8oEKdUqgbCCoy/+rRQDpsO8mgLUpZ43MF8YoedVrKq1HKaJs5SgJRgi9XPhmMFAhTO++4kXx3ZyykPy12o80ISHhmdaYy983C1QAKBwMC20O6FdHUweO9iwo/qKfLqRGQp0awzF3Gcwn1cBs5bvPwWIKVmWmnjOkFLh+oGBOSQ5Ij+zkmk58RuF42Uc/TnKVMFSbn0KN5DnX/8Yf/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFtIa/KFLOatWiAeK5euQ1GTZLanvYdvjGnmRzbvJ8Y=;
 b=s5cy0groW1uWhz2PPMGocWL/yZ3knlsgm4XW283NgcXe76xXMDmv/sOrpAsTtpMD1RCxN8ZojkkzwMbrw6vKaHr0vZFTNoeWHGfMAnciNr4pxNeKPUpegQd37D3PcqHOFWEI5r0MrpaVehXb6hMMOhtbJjBE8DDN9LqwdjbYinM=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by SA1PR18MB4615.namprd18.prod.outlook.com (2603:10b6:806:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 04:43:52 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 04:43:52 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Shijith Thotton <sthotton@marvell.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>
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
Thread-Index: AQHa96U5wMquoeCkjUiLMha3b4gFCrJZ8y0A
Date: Mon, 16 Sep 2024 04:43:52 +0000
Message-ID:
 <PH0PR18MB4425913FD7CCB42864311F52D9602@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20240823052251.1087505-1-sthotton@marvell.com>
 <20240826104531.1232136-1-sthotton@marvell.com>
In-Reply-To: <20240826104531.1232136-1-sthotton@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|SA1PR18MB4615:EE_
x-ms-office365-filtering-correlation-id: 907baf8a-8c9a-414a-aa75-08dcd60a2a20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9QVJhYE5xNi3iFw2v9CqyV6CDoYSSLBGTBUhUBRhkOFEOh4Ng9zXw+EKSYPp?=
 =?us-ascii?Q?lQGrC6p/hUUzuRzm7rpaBrpAFToIe62Xp3QSWmAL+8UZ5nzYCT/Zz6pioeWV?=
 =?us-ascii?Q?jiEaX7H5KoZp/lXzKca4gMzSAcUlnRZ6S25Vq/Rv97zWl2MJf9AyWIPutdbm?=
 =?us-ascii?Q?T95Rnj8oCFdtj6hf0UT//BjVtGN5BU5+JVV1A18iVpks0ZDpf0JGYwrq5a/F?=
 =?us-ascii?Q?+SB6udIojkr7qrJWnw0HscXs7XLEnG77haAVGKLCEe46vNHBKMC8arybTRm5?=
 =?us-ascii?Q?ys1+Jj4gSrNMdXsYKE1UA7/U+63w6y8f3VvyRaI7mHKQzp+uCNZ8BagloF0E?=
 =?us-ascii?Q?StnBlD9HVtqV/sZ/sSARnTxIHqFlIZt6pXAnkvys5JlJtxgDPSZoCsvd7mGU?=
 =?us-ascii?Q?VfnHzAkuWYQ2qTHGg/rpCP29ckxULs/+PUzoMa0BDF/256KeYVHIXiiXdueW?=
 =?us-ascii?Q?ljnXx0LAv6/iWbulu+oBmN6Y9KsQSfcYeQmPvQVPNJCrPU/WZNQdk81aHDPG?=
 =?us-ascii?Q?R/Do4AFQcfESs2ACLzbn5OcuIIE6KKivzUXI3hnbPs4Ink16cJSQwJnXGgJa?=
 =?us-ascii?Q?OqCHLw20wpO2PyZpWqUbQfYgPZBTY72qQlTSl/eM9jkV/EHbu7orN+YGteuK?=
 =?us-ascii?Q?9DDdpHOlPF+/wRNxJOby8NFBW7RZcan1hEA6xngJBRrnOTuW05h/RXzHJ9sk?=
 =?us-ascii?Q?yeZMBlBg3WlbVUuhY7uUQS6zOjRmkXa5SRR6Hcdi0m9u0TOsLC3tVrO+/Ass?=
 =?us-ascii?Q?xII0hsCz0ebrMjrCWsSr8fK6cmAJdIatvPQ2WBVWFc+qnOLStnKL3/ShJ8NJ?=
 =?us-ascii?Q?f/RhbEflc0eFYz5AibfvWiNI6AGv95/W8Y0vUbqVUAdUdMyAiU+XySikbYjy?=
 =?us-ascii?Q?gzmD9pYAPTAW9UXNaYAZnqWDL1Q7vzTr6D1KnoFsAdv1mJiBmwaEPjO6anDb?=
 =?us-ascii?Q?PUYCKUjdxjK/+N/bOwi3A3Ok7+ilJwuWuTiSNKYtCjY/wRA8bvflIajDgj5s?=
 =?us-ascii?Q?aRb7Q8/H4UDqvNzz0JrstIiGusCebsubQpbvqbzFAY1ikvJUWjZKcVAgdFj4?=
 =?us-ascii?Q?0Lb1Vcwur75qN+g+8N+avgDZhsMbyqaPVAsjKmF9g5ZEnCfs2nd9MgNkeNWP?=
 =?us-ascii?Q?HHS/27qqG/fWLWSXnjSJOmYocTYfZI5FsT7+tX5ZlcLP9X8N9RWH9paYPO0Y?=
 =?us-ascii?Q?CwGoZsEPVW/lyWMYugs1vuXdVEXBZoGTUPfdcQDp6sknC4TlbDaquTJyFbNW?=
 =?us-ascii?Q?tJdS4IKZBM0hXJoSgRGdWUeTFhtTDavT5/JAU/IMeEJrd7ia0GsCjjcwktAn?=
 =?us-ascii?Q?Az+aYPpHnm7XDjoMFjFnTcQcVhpxw7uJsHSVVGZvKQ4tTmrQSubolj0JAAyk?=
 =?us-ascii?Q?xeWb5HAsTvbPfbKeg8GFVDudUH599JxwxBwcIX6X0zcF0PLokA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lKbOtAwKjnGP0MvkofJDyJNUvrgbq2b/NP+Z6P2gL4eC6sqKx+fO/sUnSVAS?=
 =?us-ascii?Q?TUpBzPNyWB97eY6ho1KAidrmk6L7kuf+tEN+JtET2OnCWL8UY3XxQcZCcD4W?=
 =?us-ascii?Q?CmjT+j+4EhKe90CPnFfgmicpIlg8cs7tMvuUu//YWhkSctoXvPx935NqBVPc?=
 =?us-ascii?Q?rHVzdHkbEGut6VQFAUgbvhT9IVL0FGT3S2qlgEcU/+vIqRJHoLNpbbh2RNHZ?=
 =?us-ascii?Q?PeYslvgsYZ8HyauKvE4KeH2p9TxEI6JeXPSxZPiy9lqK32lfg90ijT7DzQYF?=
 =?us-ascii?Q?bsQ6uBkLHgKD+UXAK7ZtfjuukZt6ptMo2gwlvsCJSJJ7CEPtXTiIClAepDpy?=
 =?us-ascii?Q?tfpVDTxvwf1gAyxrEtoqN7FV9b3xZd4v7jw7IsFSQ2jlo8HlUPHL4GsPeP1/?=
 =?us-ascii?Q?WKSkZSyL5WeaPGyRt8nps664bNef/vWiXOnOmcS6YLnH2ml7C4XZeB96kC0m?=
 =?us-ascii?Q?7ZulnS1+5B57lU59hXFwXZuapt3oLYBeIPr2SZvqYBstRPew6jb/jzXcKAxd?=
 =?us-ascii?Q?OXrJL/lu7ZBklMv0XdlW9j0GaULRzKX/L2sOM60v/vWYq9r2vgGDBeIlyFfV?=
 =?us-ascii?Q?z3pBI0FogNagWnCA14eBW57R2LUVqg1gsxp8fS1DFYv8C2zvdFVZy1ouljHb?=
 =?us-ascii?Q?8YwJIbigLKaGyfbWrBM1CrmZl5QXGkSP4qD3W7TbXJp2uwgMLa9pp8MiGA+U?=
 =?us-ascii?Q?+uhjMKGsJi/Oz3momwnX8wx1pWSY5XbnlpCAb6mlOY73c0ZAsB6N55svl4zE?=
 =?us-ascii?Q?JFHfbAI3rKBgY+59DhWDMggLxvfO9IHaQbwWaeem9Mz9Q2lLhI51E6UU5OWn?=
 =?us-ascii?Q?v6CyLoTSYcqp3+sFvrRQBiJ/U0ly0BchCUXklEI7h86CQMHRLqICwIHflvcv?=
 =?us-ascii?Q?/CbZd+x3zZjMsnsl/aAG1HWZousWdV8E6wDoNHqG7bNTA68rVA1vMaFlY+47?=
 =?us-ascii?Q?k+qOBWf0gKPvEflHVebgZS1Pj9DuYse90tfyRsmqr6LQmEja9CXW67DkkWHC?=
 =?us-ascii?Q?4PoM4yWci4K94cYcQhr+OGyluL4YQKuBoHVGlc6etthN511YaSA7L/IHSfl4?=
 =?us-ascii?Q?57jyN5KBHv05oq9nHDb6VhdaRZ3jHIs4ZgPLUIvPLkZlQj/Qixzpqaylohcg?=
 =?us-ascii?Q?5efnRpE8q70eMRY74Ukes0BGZNZLoO95eHBdwDsYRq6yIs8zS7LQZ1TCXGRE?=
 =?us-ascii?Q?fowS/LYDSWKR9pzFbkJFt3KGo+Mt3R1lmuFp/q/Rq/eNwomCo5QZQ0tX5B1M?=
 =?us-ascii?Q?EAHKHOpUr6tEc+25b7DJANRqa6fuf4zFaaCIo7Df9NNCzm8hpRQZ25G/fMS1?=
 =?us-ascii?Q?EN3jeqVUEMvRIdC8xqKPQlQaV8YPGbYoZsISjSwxwkI83lpMt3A1Xw3k7mSW?=
 =?us-ascii?Q?863WNNHQDp3m7R6Ab0P1ydWhjgTDr5u/4LyRiZZCMo4KpOcdXHzKegoFeaNG?=
 =?us-ascii?Q?135qKpmxbs/LVXgE6sQhbpaWsXH9uNOAjVRWsj6HeW+hcgKIUbF5VL3HIwd0?=
 =?us-ascii?Q?Qo0jbFmfA3L+zeFez5kfx3DdGpwbpAkwjfwe9P1FcofEE8aQSWCdwa2k9MWa?=
 =?us-ascii?Q?V7mtjCt3DYgOnS4Ptj0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 907baf8a-8c9a-414a-aa75-08dcd60a2a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 04:43:52.4117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94p82Q7bCG1baCXBOvzlyZea0b0cZSrIoF12Xi6fnChYYY0aAYP6XTS4IC18bvUo483V1S7FP/AZYotNeAIumA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4615
X-Proofpoint-ORIG-GUID: CoGuJIppt02vH8v6WxhTYON26CGgaaSt
X-Proofpoint-GUID: CoGuJIppt02vH8v6WxhTYON26CGgaaSt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Helgaas,

Please check this patch.

>This patch introduces a PCI hotplug controller driver for the OCTEON
>PCIe device, a multi-function PCIe device where the first function acts
>as a hotplug controller. It is equipped with MSI-x interrupts to notify
>the host of hotplug events from the OCTEON firmware.
>
>The driver facilitates the hotplugging of non-controller functions
>within the same device. During probe, non-controller functions are
>removed and registered as PCI hotplug slots. The slots are added back
>only upon request from the device firmware. The driver also allows the
>enabling and disabling of the slots via sysfs slot entries, provided by
>the PCI hotplug framework.
>
>Signed-off-by: Shijith Thotton <sthotton@marvell.com>
>Co-developed-by: Vamsi Attunuru <vattunuru@marvell.com>
>Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>---
>
>This patch introduces a PCI hotplug controller driver for OCTEON PCIe hotp=
lug
>controller. The OCTEON PCIe device is a multi-function device where the fi=
rst
>function acts as a PCI hotplug controller.
>
>              +--------------------------------+
>              |           Root Port            |
>              +--------------------------------+
>                              |
>                             PCIe
>                              |
>+---------------------------------------------------------------+
>|              OCTEON PCIe Multifunction Device                 |
>+---------------------------------------------------------------+
>            |                    |              |            |
>            |                    |              |            |
>+---------------------+  +----------------+  +-----+  +----------------+
>|      Function 0     |  |   Function 1   |  | ... |  |   Function 7   |
>| (Hotplug controller)|  | (Hotplug slot) |  |     |  | (Hotplug slot) |
>+---------------------+  +----------------+  +-----+  +----------------+
>            |
>            |
>+-------------------------+
>|   Controller Firmware   |
>+-------------------------+
>
>The hotplug controller driver facilitates the hotplugging of non-controlle=
r
>functions in the same device. During the probe of the driver, the non-cont=
roller
>function are removed and registered as PCI hotplug slots. They are added b=
ack
>only upon request from the device firmware. The driver also allows the use=
r to
>enable/disable the functions using sysfs slot entries provided by PCI hotp=
lug
>framework.
>
>This solution adopts a hardware + software approach for several reasons:
>
>1. To reduce hardware implementation cost. Supporting complete hotplug
>   capability within the card would require a PCI switch implemented withi=
n.
>
>2. In the multi-function device, non-controller functions can act as emula=
ted
>   devices. The firmware can dynamically enable or disable them at runtime=
.
>
>3. Not all root ports support PCI hotplug. This approach provides greater
>   flexibility and compatibility across different hardware configurations.
>
>The hotplug controller function is lightweight and is equipped with MSI-x
>interrupts to notify the host about hotplug events. Upon receiving an
>interrupt, the hotplug register is read, and the required function is enab=
led
>or disabled.
>
>This driver will be beneficial for managing PCI hotplug events on the OCTE=
ON
>PCIe device without requiring complex hardware solutions.
>
>Changes in v2:
>- Added missing include files.
>- Used dev_err_probe() for error handling.
>- Used guard() for mutex locking.
>- Splited cleanup actions and added per-slot cleanup action.
>- Fixed coding style issues.
>- Added co-developed-by tag.
>
>Changes in v3:
>- Explicit assignment of enum values.
>- Use pcim_iomap_region() instead of pcim_iomap_regions().
>
> MAINTAINERS                    |   6 +
> drivers/pci/hotplug/Kconfig    |  10 +
> drivers/pci/hotplug/Makefile   |   1 +
> drivers/pci/hotplug/octep_hp.c | 409
>+++++++++++++++++++++++++++++++++
> 4 files changed, 426 insertions(+)
> create mode 100644 drivers/pci/hotplug/octep_hp.c
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 42decde38320..7b5a618eed1c 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -13677,6 +13677,12 @@ R:	schalla@marvell.com
> R:	vattunuru@marvell.com
> F:	drivers/vdpa/octeon_ep/
>
>+MARVELL OCTEON HOTPLUG CONTROLLER DRIVER
>+R:	Shijith Thotton <sthotton@marvell.com>
>+R:	Vamsi Attunuru <vattunuru@marvell.com>
>+S:	Supported
>+F:	drivers/pci/hotplug/octep_hp.c
>+
> MATROX FRAMEBUFFER DRIVER
> L:	linux-fbdev@vger.kernel.org
> S:	Orphan
>diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>index 1472aef0fb81..2e38fd25f7ef 100644
>--- a/drivers/pci/hotplug/Kconfig
>+++ b/drivers/pci/hotplug/Kconfig
>@@ -173,4 +173,14 @@ config HOTPLUG_PCI_S390
>
> 	  When in doubt, say Y.
>
>+config HOTPLUG_PCI_OCTEONEP
>+	bool "OCTEON PCI device Hotplug controller driver"
>+	depends on HOTPLUG_PCI
>+	help
>+	  Say Y here if you have an OCTEON PCIe device with a hotplug
>+	  controller. This driver enables the non-controller functions of the
>+	  device to be registered as hotplug slots.
>+
>+	  When in doubt, say N.
>+
> endif # HOTPLUG_PCI
>diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>index 240c99517d5e..40aaf31fe338 100644
>--- a/drivers/pci/hotplug/Makefile
>+++ b/drivers/pci/hotplug/Makefile
>@@ -20,6 +20,7 @@ obj-$(CONFIG_HOTPLUG_PCI_RPA)		+=3D
>rpaphp.o
> obj-$(CONFIG_HOTPLUG_PCI_RPA_DLPAR)	+=3D rpadlpar_io.o
> obj-$(CONFIG_HOTPLUG_PCI_ACPI)		+=3D acpiphp.o
> obj-$(CONFIG_HOTPLUG_PCI_S390)		+=3D s390_pci_hpc.o
>+obj-$(CONFIG_HOTPLUG_PCI_OCTEONEP)	+=3D octep_hp.o
>
> # acpiphp_ibm extends acpiphp, so should be linked afterwards.
>
>diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_hp=
.c
>new file mode 100644
>index 000000000000..77dc2740f43e
>--- /dev/null
>+++ b/drivers/pci/hotplug/octep_hp.c
>@@ -0,0 +1,409 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/* Copyright (C) 2024 Marvell. */
>+
>+#include <linux/cleanup.h>
>+#include <linux/container_of.h>
>+#include <linux/delay.h>
>+#include <linux/dev_printk.h>
>+#include <linux/init.h>
>+#include <linux/interrupt.h>
>+#include <linux/io-64-nonatomic-lo-hi.h>
>+#include <linux/kernel.h>
>+#include <linux/list.h>
>+#include <linux/module.h>
>+#include <linux/mutex.h>
>+#include <linux/pci.h>
>+#include <linux/pci_hotplug.h>
>+#include <linux/slab.h>
>+#include <linux/spinlock.h>
>+#include <linux/workqueue.h>
>+
>+#define OCTEP_HP_INTR_OFFSET(x) (0x20400 + ((x) << 4))
>+#define OCTEP_HP_INTR_VECTOR(x) (16 + (x))
>+#define OCTEP_HP_DRV_NAME "octep_hp"
>+
>+/*
>+ * Type of MSI-X interrupts.
>+ * The macros OCTEP_HP_INTR_VECTOR and OCTEP_HP_INTR_OFFSET are
>used to
>+ * generate the vector and offset for an interrupt type.
>+ */
>+enum octep_hp_intr_type {
>+	OCTEP_HP_INTR_INVALID =3D -1,
>+	OCTEP_HP_INTR_ENA =3D 0,
>+	OCTEP_HP_INTR_DIS =3D 1,
>+	OCTEP_HP_INTR_MAX =3D 2,
>+};
>+
>+struct octep_hp_cmd {
>+	struct list_head list;
>+	enum octep_hp_intr_type intr_type;
>+	u64 intr_val;
>+};
>+
>+struct octep_hp_slot {
>+	struct list_head list;
>+	struct hotplug_slot slot;
>+	u16 slot_number;
>+	struct pci_dev *hp_pdev;
>+	unsigned int hp_devfn;
>+	struct octep_hp_controller *ctrl;
>+};
>+
>+struct octep_hp_intr_info {
>+	enum octep_hp_intr_type type;
>+	int number;
>+	char name[16];
>+};
>+
>+struct octep_hp_controller {
>+	void __iomem *base;
>+	struct pci_dev *pdev;
>+	struct octep_hp_intr_info intr[OCTEP_HP_INTR_MAX];
>+	struct work_struct work;
>+	struct list_head slot_list;
>+	struct mutex slot_lock; /* Protects slot_list */
>+	struct list_head hp_cmd_list;
>+	spinlock_t hp_cmd_lock; /* Protects hp_cmd_list */
>+};
>+
>+static void octep_hp_enable_pdev(struct octep_hp_controller *hp_ctrl,
>+				 struct octep_hp_slot *hp_slot)
>+{
>+	guard(mutex)(&hp_ctrl->slot_lock);
>+	if (hp_slot->hp_pdev) {
>+		dev_dbg(&hp_slot->hp_pdev->dev, "Slot %u already
>enabled\n",
>+			hp_slot->slot_number);
>+		return;
>+	}
>+
>+	/* Scan the device and add it to the bus */
>+	hp_slot->hp_pdev =3D pci_scan_single_device(hp_ctrl->pdev->bus,
>+						  hp_slot->hp_devfn);
>+	pci_bus_assign_resources(hp_ctrl->pdev->bus);
>+	pci_bus_add_device(hp_slot->hp_pdev);
>+
>+	dev_dbg(&hp_slot->hp_pdev->dev, "Enabled slot %u\n",
>+		hp_slot->slot_number);
>+}
>+
>+static void octep_hp_disable_pdev(struct octep_hp_controller *hp_ctrl,
>+				  struct octep_hp_slot *hp_slot)
>+{
>+	guard(mutex)(&hp_ctrl->slot_lock);
>+	if (!hp_slot->hp_pdev) {
>+		dev_dbg(&hp_ctrl->pdev->dev, "Slot %u already disabled\n",
>+			hp_slot->slot_number);
>+		return;
>+	}
>+
>+	dev_dbg(&hp_slot->hp_pdev->dev, "Disabling slot %u\n",
>+		hp_slot->slot_number);
>+
>+	/* Remove the device from the bus */
>+	pci_stop_and_remove_bus_device_locked(hp_slot->hp_pdev);
>+	hp_slot->hp_pdev =3D NULL;
>+}
>+
>+static int octep_hp_enable_slot(struct hotplug_slot *slot)
>+{
>+	struct octep_hp_slot *hp_slot =3D
>+		container_of(slot, struct octep_hp_slot, slot);
>+
>+	octep_hp_enable_pdev(hp_slot->ctrl, hp_slot);
>+	return 0;
>+}
>+
>+static int octep_hp_disable_slot(struct hotplug_slot *slot)
>+{
>+	struct octep_hp_slot *hp_slot =3D
>+		container_of(slot, struct octep_hp_slot, slot);
>+
>+	octep_hp_disable_pdev(hp_slot->ctrl, hp_slot);
>+	return 0;
>+}
>+
>+static struct hotplug_slot_ops octep_hp_slot_ops =3D {
>+	.enable_slot =3D octep_hp_enable_slot,
>+	.disable_slot =3D octep_hp_disable_slot,
>+};
>+
>+#define SLOT_NAME_SIZE 16
>+static struct octep_hp_slot *
>+octep_hp_register_slot(struct octep_hp_controller *hp_ctrl,
>+		       struct pci_dev *pdev, u16 slot_number)
>+{
>+	char slot_name[SLOT_NAME_SIZE];
>+	struct octep_hp_slot *hp_slot;
>+	int ret;
>+
>+	hp_slot =3D kzalloc(sizeof(*hp_slot), GFP_KERNEL);
>+	if (!hp_slot)
>+		return ERR_PTR(-ENOMEM);
>+
>+	hp_slot->ctrl =3D hp_ctrl;
>+	hp_slot->hp_pdev =3D pdev;
>+	hp_slot->hp_devfn =3D pdev->devfn;
>+	hp_slot->slot_number =3D slot_number;
>+	hp_slot->slot.ops =3D &octep_hp_slot_ops;
>+
>+	snprintf(slot_name, sizeof(slot_name), "octep_hp_%u", slot_number);
>+	ret =3D pci_hp_register(&hp_slot->slot, hp_ctrl->pdev->bus,
>+			      PCI_SLOT(pdev->devfn), slot_name);
>+	if (ret) {
>+		kfree(hp_slot);
>+		return ERR_PTR(ret);
>+	}
>+
>+	list_add_tail(&hp_slot->list, &hp_ctrl->slot_list);
>+	octep_hp_disable_pdev(hp_ctrl, hp_slot);
>+
>+	return hp_slot;
>+}
>+
>+static void octep_hp_deregister_slot(void *data)
>+{
>+	struct octep_hp_slot *hp_slot =3D data;
>+	struct octep_hp_controller *hp_ctrl =3D hp_slot->ctrl;
>+
>+	pci_hp_deregister(&hp_slot->slot);
>+	octep_hp_enable_pdev(hp_ctrl, hp_slot);
>+	list_del(&hp_slot->list);
>+	kfree(hp_slot);
>+}
>+
>+static bool octep_hp_is_slot(struct octep_hp_controller *hp_ctrl,
>+			     struct pci_dev *pdev)
>+{
>+	/* Check if the PCI device can be hotplugged */
>+	return pdev !=3D hp_ctrl->pdev && pdev->bus =3D=3D hp_ctrl->pdev->bus &&
>+	       PCI_SLOT(pdev->devfn) =3D=3D PCI_SLOT(hp_ctrl->pdev->devfn);
>+}
>+
>+static void octep_hp_cmd_handler(struct octep_hp_controller *hp_ctrl,
>+				 struct octep_hp_cmd *hp_cmd)
>+{
>+	struct octep_hp_slot *hp_slot;
>+
>+	/*
>+	 * Enable or disable the slots based on the slot mask.
>+	 * intr_val is a bit mask where each bit represents a slot.
>+	 */
>+	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
>+		if (!(hp_cmd->intr_val & BIT(hp_slot->slot_number)))
>+			continue;
>+
>+		if (hp_cmd->intr_type =3D=3D OCTEP_HP_INTR_ENA)
>+			octep_hp_enable_pdev(hp_ctrl, hp_slot);
>+		else
>+			octep_hp_disable_pdev(hp_ctrl, hp_slot);
>+	}
>+}
>+
>+static void octep_hp_work_handler(struct work_struct *work)
>+{
>+	struct octep_hp_controller *hp_ctrl;
>+	struct octep_hp_cmd *hp_cmd;
>+	unsigned long flags;
>+
>+	hp_ctrl =3D container_of(work, struct octep_hp_controller, work);
>+
>+	/* Process all the hotplug commands */
>+	spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>+	while (!list_empty(&hp_ctrl->hp_cmd_list)) {
>+		hp_cmd =3D list_first_entry(&hp_ctrl->hp_cmd_list,
>+					  struct octep_hp_cmd, list);
>+		list_del(&hp_cmd->list);
>+		spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>+
>+		octep_hp_cmd_handler(hp_ctrl, hp_cmd);
>+		kfree(hp_cmd);
>+
>+		spin_lock_irqsave(&hp_ctrl->hp_cmd_lock, flags);
>+	}
>+	spin_unlock_irqrestore(&hp_ctrl->hp_cmd_lock, flags);
>+}
>+
>+static enum octep_hp_intr_type octep_hp_intr_type(struct
>octep_hp_intr_info *intr,
>+						  int irq)
>+{
>+	enum octep_hp_intr_type type;
>+
>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>type++) {
>+		if (intr[type].number =3D=3D irq)
>+			return type;
>+	}
>+
>+	return OCTEP_HP_INTR_INVALID;
>+}
>+
>+static irqreturn_t octep_hp_intr_handler(int irq, void *data)
>+{
>+	struct octep_hp_controller *hp_ctrl =3D data;
>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>+	enum octep_hp_intr_type type;
>+	struct octep_hp_cmd *hp_cmd;
>+	u64 intr_val;
>+
>+	type =3D octep_hp_intr_type(hp_ctrl->intr, irq);
>+	if (type =3D=3D OCTEP_HP_INTR_INVALID) {
>+		dev_err(&pdev->dev, "Invalid interrupt %d\n", irq);
>+		return IRQ_HANDLED;
>+	}
>+
>+	/* Read and clear the interrupt */
>+	intr_val =3D readq(hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>+	writeq(intr_val, hp_ctrl->base + OCTEP_HP_INTR_OFFSET(type));
>+
>+	hp_cmd =3D kzalloc(sizeof(*hp_cmd), GFP_ATOMIC);
>+	if (!hp_cmd)
>+		return IRQ_HANDLED;
>+
>+	hp_cmd->intr_val =3D intr_val;
>+	hp_cmd->intr_type =3D type;
>+
>+	/* Add the command to the list and schedule the work */
>+	spin_lock(&hp_ctrl->hp_cmd_lock);
>+	list_add_tail(&hp_cmd->list, &hp_ctrl->hp_cmd_list);
>+	spin_unlock(&hp_ctrl->hp_cmd_lock);
>+	schedule_work(&hp_ctrl->work);
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static void octep_hp_irq_cleanup(void *data)
>+{
>+	struct octep_hp_controller *hp_ctrl =3D data;
>+
>+	pci_free_irq_vectors(hp_ctrl->pdev);
>+	flush_work(&hp_ctrl->work);
>+}
>+
>+static int octep_hp_request_irq(struct octep_hp_controller *hp_ctrl,
>+				enum octep_hp_intr_type type)
>+{
>+	struct pci_dev *pdev =3D hp_ctrl->pdev;
>+	struct octep_hp_intr_info *intr;
>+	int irq;
>+
>+	irq =3D pci_irq_vector(pdev, OCTEP_HP_INTR_VECTOR(type));
>+	if (irq < 0)
>+		return irq;
>+
>+	intr =3D &hp_ctrl->intr[type];
>+	intr->number =3D irq;
>+	intr->type =3D type;
>+	snprintf(intr->name, sizeof(intr->name), "octep_hp_%d", type);
>+
>+	return devm_request_irq(&pdev->dev, irq, octep_hp_intr_handler,
>+				IRQF_SHARED, intr->name, hp_ctrl);
>+}
>+
>+static int octep_hp_controller_setup(struct pci_dev *pdev,
>+				     struct octep_hp_controller *hp_ctrl)
>+{
>+	struct device *dev =3D &pdev->dev;
>+	enum octep_hp_intr_type type;
>+	int ret;
>+
>+	ret =3D pcim_enable_device(pdev);
>+	if (ret)
>+		return dev_err_probe(dev, ret, "Failed to enable PCI device\n");
>+
>+	hp_ctrl->base =3D pcim_iomap_region(pdev, 0, OCTEP_HP_DRV_NAME);
>+	if (IS_ERR(hp_ctrl->base))
>+		return dev_err_probe(dev, PTR_ERR(hp_ctrl->base),
>+				     "Failed to map PCI device region\n");
>+
>+	pci_set_master(pdev);
>+	pci_set_drvdata(pdev, hp_ctrl);
>+
>+	INIT_LIST_HEAD(&hp_ctrl->slot_list);
>+	INIT_LIST_HEAD(&hp_ctrl->hp_cmd_list);
>+	mutex_init(&hp_ctrl->slot_lock);
>+	spin_lock_init(&hp_ctrl->hp_cmd_lock);
>+	INIT_WORK(&hp_ctrl->work, octep_hp_work_handler);
>+	hp_ctrl->pdev =3D pdev;
>+
>+	ret =3D pci_alloc_irq_vectors(pdev, 1,
>+
>OCTEP_HP_INTR_VECTOR(OCTEP_HP_INTR_MAX),
>+				    PCI_IRQ_MSIX);
>+	if (ret < 0)
>+		return dev_err_probe(dev, ret, "Failed to alloc MSI-X
>vectors\n");
>+
>+	ret =3D devm_add_action(&pdev->dev, octep_hp_irq_cleanup, hp_ctrl);
>+	if (ret)
>+		return dev_err_probe(&pdev->dev, ret, "Failed to add IRQ
>cleanup action\n");
>+
>+	for (type =3D OCTEP_HP_INTR_ENA; type < OCTEP_HP_INTR_MAX;
>type++) {
>+		ret =3D octep_hp_request_irq(hp_ctrl, type);
>+		if (ret)
>+			return dev_err_probe(dev, ret,
>+					     "Failed to request IRQ for vector
>%d\n",
>+					     OCTEP_HP_INTR_VECTOR(type));
>+	}
>+
>+	return 0;
>+}
>+
>+static int octep_hp_pci_probe(struct pci_dev *pdev,
>+			      const struct pci_device_id *id)
>+{
>+	struct octep_hp_controller *hp_ctrl;
>+	struct pci_dev *tmp_pdev =3D NULL;
>+	struct octep_hp_slot *hp_slot;
>+	u16 slot_number =3D 0;
>+	int ret;
>+
>+	hp_ctrl =3D devm_kzalloc(&pdev->dev, sizeof(*hp_ctrl), GFP_KERNEL);
>+	if (!hp_ctrl)
>+		return -ENOMEM;
>+
>+	ret =3D octep_hp_controller_setup(pdev, hp_ctrl);
>+	if (ret)
>+		return ret;
>+
>+	/*
>+	 * Register all hotplug slots. Hotplug controller is the first function
>+	 * of the PCI device. The hotplug slots are the remaining functions of
>+	 * the PCI device. They are removed from the bus and are added back
>when
>+	 * the hotplug event is triggered.
>+	 */
>+	for_each_pci_dev(tmp_pdev) {
>+		if (!octep_hp_is_slot(hp_ctrl, tmp_pdev))
>+			continue;
>+
>+		hp_slot =3D octep_hp_register_slot(hp_ctrl, tmp_pdev,
>slot_number);
>+		if (IS_ERR(hp_slot))
>+			return dev_err_probe(&pdev->dev, PTR_ERR(hp_slot),
>+					     "Failed to register hotplug slot
>%u\n",
>+					     slot_number);
>+
>+		ret =3D devm_add_action(&pdev->dev, octep_hp_deregister_slot,
>+				      hp_slot);
>+		if (ret)
>+			return dev_err_probe(&pdev->dev, ret,
>+					     "Failed to add action for
>deregistering slot %u\n",
>+					     slot_number);
>+		slot_number++;
>+	}
>+
>+	return 0;
>+}
>+
>+#define OCTEP_DEVID_HP_CONTROLLER 0xa0e3
>+static struct pci_device_id octep_hp_pci_map[] =3D {
>+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM,
>OCTEP_DEVID_HP_CONTROLLER) },
>+	{ },
>+};
>+
>+static struct pci_driver octep_hp =3D {
>+	.name =3D OCTEP_HP_DRV_NAME,
>+	.id_table =3D octep_hp_pci_map,
>+	.probe =3D octep_hp_pci_probe,
>+};
>+
>+module_pci_driver(octep_hp);
>+
>+MODULE_LICENSE("GPL");
>+MODULE_AUTHOR("Marvell");
>+MODULE_DESCRIPTION("OCTEON PCIe device hotplug controller driver");
>--
>2.25.1

Thanks,
Shijith

