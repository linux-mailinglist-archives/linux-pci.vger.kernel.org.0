Return-Path: <linux-pci+bounces-14346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905F199AB0B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 20:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27451284455
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 18:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942F51CB32E;
	Fri, 11 Oct 2024 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PrwASKC6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883851C8FB7;
	Fri, 11 Oct 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671758; cv=fail; b=ML/mQk2YBAFJjplG0ZMSZt9uBqeyr0Ifa85hxdxxCREfeRlcGwPI1TnbvdV8d5NS0wmn7404ULn2yJCh3JGrMFyMkUGBDT43dj0tWWjQcgmSCh0gsHqrXDaqepQtvXci7BRrURhgiLWXJoFsLpFVVIlAD3GJK/HlEAzLYExpQbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671758; c=relaxed/simple;
	bh=FyO2VzYhSob1yYvYWrpykrnc8UEW8iQzQfM80zMeGNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qq5In/myGwV+t8QqAkUPrtEAB5iBvVArGAeyEYdmdTUSF9VFSB4GrPdSpV7DHBGvi7OHimC03kVz5RoQC22jRDPFz1hRjNVJ4r6TJgAaraduUGGgnnRGANbQ4nYJLXl/1Nzud3ZB0snoVSrAdaWtHsQbNHsAiAPzReR8tP9QQlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PrwASKC6; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZhfD7qTS2SHEST2lpnzLMoT9ORFa0yu1NOMghyoeXCsf6Quw3HUa1AKvbJ/NUP2dTJBUGDdcByd46neReu298RWNQzQ1OGu84r06sxJ2s1FewbxUgLAbtHou9HzGqYMkDp4uNZVIuj7d625qXrsKAyJQTWf0UNbvzXjMfrFi8gIaomg+OU3MK6AfzTynAkPNegTfnz9h1C3trBC2KjoxQOlaVcEHE90+128mtnCmfSHjxxNLf84d19khTIOtb5SXlDdh5Z0dFPaf2qUNxcogW8TsKx1zf0l/XREMVHiAwJ189RFfnB3WxMjzMuu/VpKXJsVgtu3QXF70n2XTJBrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWu43i8MEhoN0ct6TIBbfDOPKTpyv33cMiyDdz1LqA4=;
 b=ALA2Gy+Gu01OlnPTKIHjAxcveVtfQOuC/96RK19LKdlx9rmwAEoIXKHkt97o5l4J7NWrwZB/QHxpT7Vky5eNoEqLH4McEDqYOvfd+K5q5y1A1Q/SaHZxhXu8rkJcJutD+3DMYpl8OJqf61NTevC9BqCwEytPBQJd4R/oO0y2KwVlaL69c3XbINOoIL5PEXrzfPaMOi2sgyi2w+9k2PkzUIin/ne73KiKJggx8yZMgEu3SCpUCeVx1F+sukmTNkAM6oO87uI5SJB11/bUwhGxs0G9mPQaee1wiSOuFQisxXzbGVvV/eKnmEw2VgsIrgjznJBfp+ADLZcIgpem33ayiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWu43i8MEhoN0ct6TIBbfDOPKTpyv33cMiyDdz1LqA4=;
 b=PrwASKC6cJ9Xj8QF2MvZBw5CAIVAIJFdEQwEjv3o6fpVJTU/pPjfzXmig+W6zH8XY8aQQDhjdoKmQ4Lwx5MQUMUj+vN6n3mYJmjMFQ0J0A406x2MBr6M95dC7vWQjW43qa/T3f5KDO3m/dLRHKVlXBPQ71tT1BISMyCF6lLD+DU=
Received: from MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Fri, 11 Oct
 2024 18:35:53 +0000
Received: from MN0PR12MB6174.namprd12.prod.outlook.com
 ([fe80::7830:2e2e:ab97:550d]) by MN0PR12MB6174.namprd12.prod.outlook.com
 ([fe80::7830:2e2e:ab97:550d%4]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 18:35:52 +0000
From: "Panicker, Manoj" <Manoj.Panicker2@amd.com>
To: Jakub Kicinski <kuba@kernel.org>, "Huang2, Wei" <Wei.Huang2@amd.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"gospo@broadcom.com" <gospo@broadcom.com>, "michael.chan@broadcom.com"
	<michael.chan@broadcom.com>, "ajit.khaparde@broadcom.com"
	<ajit.khaparde@broadcom.com>, "somnath.kotur@broadcom.com"
	<somnath.kotur@broadcom.com>, "andrew.gospodarek@broadcom.com"
	<andrew.gospodarek@broadcom.com>, "VanTassell, Eric"
	<Eric.VanTassell@amd.com>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "horms@kernel.org" <horms@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lukas@wunner.de" <lukas@wunner.de>,
	"paul.e.luse@intel.com" <paul.e.luse@intel.com>, "jing2.liu@intel.com"
	<jing2.liu@intel.com>
Subject: RE: [PATCH V7 4/5] bnxt_en: Add TPH support in BNXT driver
Thread-Topic: [PATCH V7 4/5] bnxt_en: Add TPH support in BNXT driver
Thread-Index: AQHbFOymny8b5yRiOUCrayOvouxiEbJ85UmAgAUJI7A=
Date: Fri, 11 Oct 2024 18:35:52 +0000
Message-ID:
 <MN0PR12MB6174E0F2572E7BFC65EA464BAF792@MN0PR12MB6174.namprd12.prod.outlook.com>
References: <20241002165954.128085-1-wei.huang2@amd.com>
	<20241002165954.128085-5-wei.huang2@amd.com>
 <20241008063959.0b073aab@kernel.org>
In-Reply-To: <20241008063959.0b073aab@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d8a284a2-84e0-46e0-bcf6-24a0baa1181c;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-11T18:33:59Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6174:EE_|SA3PR12MB8439:EE_
x-ms-office365-filtering-correlation-id: 10c0d433-4023-4fa0-1bb9-08dcea238947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0lUSZBGeZd03IppzGSVrTxDi60bjkzODlmoD+mth5i5q8/Gosfke2CzDou9e?=
 =?us-ascii?Q?ycIInYmv5moMw5GEVRlUA7DfosguB+3fwofrSimhdBh4idJLlr8Qy0U8u7Dq?=
 =?us-ascii?Q?0xKzTvDpBybNNzL59oI4wIcOSN3cHwMV8RsibK7QwGtwidYNqVZCMIxguOQz?=
 =?us-ascii?Q?Ji9w25bI01cam1px3W4Dl9+fKTiuEXr7GbUlUpBf0S4bI46WweKbfOCOyX1Q?=
 =?us-ascii?Q?2UWKCEW8/COBFZ7THE5w0RdlwGB9ug1TRaWl19x/8S8jik/lnR+k86dpdGwY?=
 =?us-ascii?Q?2upFSVOj8W4VlrdAK1IJEM5SAK/+/F8C4vlPyugb8mpal0hjE5ecKdOev2TA?=
 =?us-ascii?Q?JbbdOO3gUKfWrSIC8AvXKdwdw3fZLbJeRSRQSXU5cSDV54+G2kyBc5i2limN?=
 =?us-ascii?Q?mHwITF3GyKFCd5JsKZLVaiXXzhMFvznAZLK2bhQNcAJOscL1ushQwpTsuNHT?=
 =?us-ascii?Q?9E6VhVt1+kbRdDaza/HphzCwMrGg0oVUKkKnUgCThfzzoFBFtdAjc9GspThP?=
 =?us-ascii?Q?XDC4OGz8w0831hLa+inf9pcIfZvYf/evyfSNSERnb1HpXNeMg3MLZhh6iWQX?=
 =?us-ascii?Q?c3ekyR+rI3ZCa9WDxzvSFoukicU2yCDWWsO2EAOugd0VWpUAxj8OTa96uwGl?=
 =?us-ascii?Q?go/JUZzUgXjUGDLc/jHaK1yAiMQhHMwqtkjkPOQNgAQL+ybganQBu9m2Hey1?=
 =?us-ascii?Q?Wh87QqIPRqFHe1vAZccHVyEHob7OZjhkDp55ntAmD/LOl2CoCsXdTjIJK7GK?=
 =?us-ascii?Q?fWJHs2Ek8qaLt7ZHMH1iYQkXGk9JoZ0hauzZLY38uaHP1jxZ0wOPMPr+iJJO?=
 =?us-ascii?Q?SV83vpuqOuEgyDPwIVXfA4Cyfm1fLrFCTCjc8WsFgHmQDx0nXHyO/QTHRNn3?=
 =?us-ascii?Q?bq1+J97DYPGMpqnugC83QSQ3zd2UyJRjMgN92fZQpL3SpGVpIog9+6wzSWFa?=
 =?us-ascii?Q?aUV+aUUz9/X1fdnPmN6uqskMyVBj5jy9YX2tp6UwZpxp+IxYPDCST1m/JypH?=
 =?us-ascii?Q?df0f2Xz0+PGbja04H9E49S+zQOwZArCaTxwQgCOaq8k4RPpi/ch0cEakya01?=
 =?us-ascii?Q?ZGvGgxYmZNhDHwmipkJUA/vgOuzOwkR4ZuZ6SJXedIx4owEPQ2vESIr7K7r7?=
 =?us-ascii?Q?RapFo7gNeHlw/YS9hzHZ5WjWKqlN9R0B3ZLjobjWHc0rSZkguEbfOyvBYI82?=
 =?us-ascii?Q?IWP20RDizBC1cn/x/sAjPmh38b0r9XO4VZBppfuZSmWhHzbojgPYMT+flbLD?=
 =?us-ascii?Q?J6kfx1/zsLTxjAycZoAA2RvFujc9S22mtxYLY9UraUoEv/m3XdgND7bQUJ14?=
 =?us-ascii?Q?ASxBU3ggCtQmnQPB95Gt9R1cU4PCQvEmhSq29sZoLqEwZg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QzS1g7ppgzonrhbJpMuDAH3MeRGy6L5AlVcF34CpBbjzrFIB8NcIiOPmLTjx?=
 =?us-ascii?Q?o/xjScL4Lft/8vy8+dzxEULKQ/U3LMy5IjvAqx9h6Pq00L+2MwATzL0bA/SB?=
 =?us-ascii?Q?3O4WTYkcfVWBjPhLP1i+vUp3LN+ihaamc/V1IRi5GF37TM9Q1KVmbDpM+XZb?=
 =?us-ascii?Q?VZl1/zS10R5IDFdDCkeDJzXwSC96i7YXouOX1HFgDUxAYcbRnEc5XTC2L6Te?=
 =?us-ascii?Q?D/7/0hbJLX26rZ+GKIkKatPEF8NPBZv7PbEA/thQVKrm3Jz3gkKUYSOJY7z9?=
 =?us-ascii?Q?gdfZIF8b9kn3sxlcLSc6Fo0VcYulZovr0C8tDakH9DLqn8dCBdR28XkoYAED?=
 =?us-ascii?Q?20MdEYuu2CFGr+MBWjqCAitpTpLXbtTzGpCLlp6t6bcJu8cvw4OMha+WSJaB?=
 =?us-ascii?Q?xn83fNQLfKguFhrAV4OSaFBAfWycOW7Qj+aZy633ZsPEXrtN9+o5xlxs2D8o?=
 =?us-ascii?Q?8oqihaCMJo4URSxqDuVb9LJdoeuKgIMkZ7dClGT/ZQkOG3h7fAp83Z0RCNFV?=
 =?us-ascii?Q?PSWxGyycyKLzwtcYVfsA4y6XteyTmOzXaua/jnLK//ER7l6ITdGPktDRjLes?=
 =?us-ascii?Q?W0CGUOYQlO84qxtmt3YKZlBycxb48bmVWK5RUrblWUn5BaRwa2VIBlRqjEFu?=
 =?us-ascii?Q?vTswVoarTvqQXcKTEzC2a0jclBeYZyirP3aoBHFoolau07lpMcBcjB8nNOYw?=
 =?us-ascii?Q?rapjyMiJCwuNMnzECerTllBolE+ovZf81XBB81dk/FH/qyDGhEfXg4hKu4Tm?=
 =?us-ascii?Q?XpldfCrgngeoetNonASghhBqOpz5vgVpC3X7LQSXcnHtBtJyHIUXgSQicAga?=
 =?us-ascii?Q?6rJ5bVluyuM98GrOZ6Jh7fUA2uwjioEuyMKOxexJ1C79edGsFpPNmyTUHF/w?=
 =?us-ascii?Q?jhZJQzzCXQTAs6IHon1udp5fxrNOjH3tB/wmxJIrB4M431v441O9lXBcqPVl?=
 =?us-ascii?Q?Ed4igB9vy7xsTKvqPlYlv1ZuPj87Vygslq0CFh6iw1PT6pDcRd48U7ec2iPr?=
 =?us-ascii?Q?A+0ZZrnRJBEAdSrj/0w+MNtoMMrnGuShXdUl7+4Iqw4e8+3LNGSorakdoTmV?=
 =?us-ascii?Q?3Wx7I0TuVRLZPxW7FP0kRvvAdpvEk6HUMBxfr1FIysrlEmvUDGqVP+4iq9KA?=
 =?us-ascii?Q?gc6R20QKR9BSR82oPJ+lOCqVwV2kK/6SDWnpchZXjRnOWgLp1ITdjvTuXt+G?=
 =?us-ascii?Q?ZEXoc3xKGiKwggYeUrnuW5SnBwqKUIXqgx60xsPP//PEDczkYXSECygvHXrw?=
 =?us-ascii?Q?2s4wrpeT5CLfohqM3e1WT+Bgpqzgo6VxxIlj1RkMXt3cwfcg0dLJ7QVtZlw4?=
 =?us-ascii?Q?MTT7uS7Z+9DjBmEydGjQ2sSkdOfmZDYYLAcgEFGDKL7GVy9VAub0xU3Bm66n?=
 =?us-ascii?Q?zqhI7aGSqsQUqDj88Cbaw90j8dBufZSDuu8YbZ3RjLkFSA4QAEYf2rOm6Kxl?=
 =?us-ascii?Q?D8i93xW7PNfaikHkbw+FVH0UJ38I5kDOaP5elaN1Mrd7J6sDdhfejLk73RaF?=
 =?us-ascii?Q?dPm9fBvDMELNrFknqkaHOMP5ny2SaPRgnMpZslNOUBC+273n/PMyye6sIbIy?=
 =?us-ascii?Q?dKUcCWeSCTLnOu2d4eI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c0d433-4023-4fa0-1bb9-08dcea238947
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 18:35:52.7625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BHOdpQdr1pVar5u7hTEQJhoLgY9+V0D3xm/seCukw30/YSowUrkZNUHLXTBu/fx5q9im2Iwglx6GXXN2erPZlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439

[AMD Official Use Only - AMD Internal Distribution Only]

Hello Jakub,

Thanks for the feedback. We'll update the patch to cover the code under the=
 rtnl_lock.

About the empty function, there are no actions to perform when the driver's=
 notify.release function is called. The IRQ notifier is only registered onc=
e and there are no older IRQ notifiers for the driver that could get called=
 back. We also followed the precedent seen from other drivers in the kernel=
 tree that follow the same mechanism .

See code:
From drivers/net/ethernet/intel/i40e/i40e_main.c
static void i40e_irq_affinity_release(struct kref *ref) {}


From drivers/net/ethernet/intel/iavf/iavf_main.c
static void iavf_irq_affinity_release(struct kref *ref) {}


From drivers/net/ethernet/fungible/funeth/funeth_main.c
static void fun_irq_aff_release(struct kref __always_unused *ref)
{
}


Thanks
Manoj

-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>
Sent: Tuesday, October 8, 2024 6:40 AM
To: Huang2, Wei <Wei.Huang2@amd.com>
Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; linux-doc@vger=
.kernel.org; netdev@vger.kernel.org; Jonathan.Cameron@Huawei.com; helgaas@k=
ernel.org; corbet@lwn.net; davem@davemloft.net; edumazet@google.com; pabeni=
@redhat.com; alex.williamson@redhat.com; gospo@broadcom.com; michael.chan@b=
roadcom.com; ajit.khaparde@broadcom.com; somnath.kotur@broadcom.com; andrew=
.gospodarek@broadcom.com; Panicker, Manoj <Manoj.Panicker2@amd.com>; VanTas=
sell, Eric <Eric.VanTassell@amd.com>; vadim.fedorenko@linux.dev; horms@kern=
el.org; bagasdotme@gmail.com; bhelgaas@google.com; lukas@wunner.de; paul.e.=
luse@intel.com; jing2.liu@intel.com
Subject: Re: [PATCH V7 4/5] bnxt_en: Add TPH support in BNXT driver

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


On Wed, 2 Oct 2024 11:59:53 -0500 Wei Huang wrote:
> +     if (netif_running(irq->bp->dev)) {
> +             rtnl_lock();
> +             err =3D netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr)=
;
> +             if (err)
> +                     netdev_err(irq->bp->dev,
> +                                "rx queue restart failed: err=3D%d\n", e=
rr);
> +             rtnl_unlock();
> +     }
> +}
> +
> +static void __bnxt_irq_affinity_release(struct kref __always_unused
> +*ref) { }

An empty release function is always a red flag.
How is the reference counting used here?
Is irq_set_affinity_notifier() not synchronous?
Otherwise the rtnl_lock() should probably cover the running check.

