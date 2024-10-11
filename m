Return-Path: <linux-pci+bounces-14261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C1999DEB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 09:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C28B22AC8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AA1209F52;
	Fri, 11 Oct 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pqu9IsSq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858CE20A5E5;
	Fri, 11 Oct 2024 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631790; cv=fail; b=pkFrk8/wznSOU5MqV5su8QtUjdW7wq/oQ1NUO6fODEbxc1MuYg2GgPYKEKBVGRoE4Rvx1liHCfc3KS0XKdhplDs7qee0NGFzFTKm7kcYRoZmnikzUxBe3loRvfXf+56+2YqIRDEFjYudPaLn4AIseJ3/H7nTlawNiVeaAh+31gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631790; c=relaxed/simple;
	bh=KoPBAlziQif0MpQhmTnxVH90z330/GqiGFFAP8gCwxY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ahjj8AfJt2C/pE3ZHQFN6ZsLZ7a4Nsz1TDMo4KQQvIJ2jOvzDuSm3xqfYq1aivvV+4+Ywg4i3Sppw0Jnc/FRCc+pE68H9/t6tqV5YAxzgswle2zAcQ+whelRAPyrpu4Vayf9vfENQBYM6W6x4J2KAVz2lLldI4PmsGEqXs9evgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pqu9IsSq; arc=fail smtp.client-ip=40.107.241.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDJSIxCq18sQMS9uswb65SRRJrVqKkCF0le/nmIsKebT+kcKIIH3Au/S7jWXawDwk+/nOkEp2wqN9nWM/uPt1jF7z1XGGdBKkXOxp1SvbfU25zYb61zd63ifLQ5KWqu47IyMOrA4JZZeA6EaNGjo/zEE5mz2EDnyYoPSknHDga/zzRm9MV95ujzjD7MN8mdBFy7W4FHkPD5dR19GWx2K0SFvCE/aNqnfByzOcf4heP8bm3VvzEBRoyci6PkQoMb9+NWl5ZfN6M+Pk2AElZ3SD9swp7MLcxJcZIatXShsnCZusXtGOrliFuCpMU7Ftyc3+oACTTxV/4Eh/SUaO4JDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoPBAlziQif0MpQhmTnxVH90z330/GqiGFFAP8gCwxY=;
 b=xbcS2V1FmuJ/Sspkxz3DzFhdRf+uGDKB1Q/+lzZeTXkH8jlefA/WQyvXpEhGeaBaMM+lsUfcLCqDOwPClGpQtWejtDCBrg9amLaSK8O2lGlRD/GqiaEP86BBe9M213ufOEtAzzW5197QOLGp6ewPfT16cZPN1fMGZze6kT1sAF3jdaM6T/ESEHqo3uU4lTjorZ1RKwIVJshq14xvjqmumXeraOCWcZWcNdd/AsotRJVXgMlWY5LUlgMC9bnpUxkTTR6OXbdjaSzIzciue+A7zW263tvbWrEoSFdyhx+2Ft3IYsGDNch0BuMNKvauHCDp6w+edMqkJYLtfucrliSNpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoPBAlziQif0MpQhmTnxVH90z330/GqiGFFAP8gCwxY=;
 b=Pqu9IsSqkz4kxU0ejkfADFX38rK2h+DxnnxXTYbBRjwR8FEgqnVS0C4M2fsYbXZofGcB8hp6ahvT9WeKwyAhkQLpZlmf/f7/BOY3trFZlLfLmQDsHLrlXG8LORQ4drJ6ecoq20WS433byiCP1PYYlcUIiDTsRo7TRiJ2+0EBm7phsO+37DpnuN2Im+MG9OI+q/KdI+lBsYNwi1o6dHG6JiJ+b5nEBPU4bldD6WPUpT/29sIrwGQassM+MZJc+8Xv2ljBC3Syqx0YW1jeKYD67y89+aBpype4UNls5i8kFtecGkwCoItEC7vi8zIy0oTRQhkZvjIeV7yLiQ+f/RruEQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7791.eurprd04.prod.outlook.com (2603:10a6:102:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 07:29:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Fri, 11 Oct 2024
 07:29:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 11/11] MAINTAINERS: update ENETC driver files and
 maintainers
Thread-Topic: [PATCH net-next 11/11] MAINTAINERS: update ENETC driver files
 and maintainers
Thread-Index: AQHbGjMG0icrobd2ckyrkNnSVruYHrKAXqiAgABwiDCAACRAAIAANqIQ
Date: Fri, 11 Oct 2024 07:29:44 +0000
Message-ID:
 <PAXPR04MB85103099EA80F900B863816088792@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-12-wei.fang@nxp.com>
 <ZwgpF3CJepAklWeT@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510EF1F7A375A16211F26CF88792@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <Zwil5tBLtO0X6/ke@lizhi-Precision-Tower-5810>
In-Reply-To: <Zwil5tBLtO0X6/ke@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7791:EE_
x-ms-office365-filtering-correlation-id: 4940a238-d49d-4825-facb-08dce9c67a43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFcraEpqYTBQVUpXQjlrTWY3U08wcWxKTWV1dDJXemxoUHd4TkhrYk1UNlJx?=
 =?utf-8?B?ZlpYVTVublZoZEJtSGhzNHViNEV4NlhiOFN6VUdhTzZiODJTeWtjVFF3NXNt?=
 =?utf-8?B?blNLZlhRb3NVZERWQmF1aHJiSWh0TXJBc1VLdyt3aUFLWnhnMEtlR3RaMUl2?=
 =?utf-8?B?ZHppKzMrVWwyT1hjVFZJV3ZHYWt1ZVR2d1A1NUR4bjFNUnh3bGRaMENXc1kr?=
 =?utf-8?B?Z0g3MzlwUWFTdXMxejZuZ1ducTk0M2xualNMSGc3RHhZUHQxVVhtYzduUGcy?=
 =?utf-8?B?L09iNnBUQ2JCYlVNc09CZVFJbUYzelJkVmR0dVhyeCtGS3VKMEZYaDA5dEox?=
 =?utf-8?B?TmNBTnFZWk0xMkhWZlpIRUR2OUNmQTZFajRZVzhvVUQvcVFpbmQ1KzFzUUFz?=
 =?utf-8?B?c0VIUDZWL0p4ekV4UU51V0xVTWx4dlVYMkIyNWNzTzM5SWlpenBjNUhITGlW?=
 =?utf-8?B?Y3B5SzJ4djE4eGFqUG5ldnFBdGJYQUhudVZUb3Z2UEZWVWZkTXVkeTlhOGc3?=
 =?utf-8?B?cUNTcFFpSTVjbTVZQnI1U1NUTmo2Z3pWdDVxWkdNTHJxTGNteEx0OVZGTWtI?=
 =?utf-8?B?TE41a093N3dnbTFtNUwvTE9VY3NqbjBaQzlYV3UyL2h3WWhpSDVpdEhNUlQ4?=
 =?utf-8?B?M1d4ckZob216aElhNWo3azhxcHFuTk9nUTJVNnFWSUM4MnhWazlqeGxyczE5?=
 =?utf-8?B?VVlqTEZtSm0vVHQ1MGxZeGhBRURNWXpPSVk5R0IwSVgvWWs5dnd1dkV4ekgw?=
 =?utf-8?B?eTI0Q1E3ck9ZQVFFSWdaZjRybnhkL05pQUJnNFF1c25IemdISGxmMlhRSTA5?=
 =?utf-8?B?M2tpbjhLejFpRW5mZHJMNEdWSzFDcjhkSmd5bzU5c0VXR1RxUkVSVFN5WExD?=
 =?utf-8?B?Q2RXUVJrUGFTYUFoZlJoZWMyOUJlKzdFUFZoRDBNWWpkbENLaFZ3WWFqNXl2?=
 =?utf-8?B?Y0gyUE5PdTVFVjE4Sy80M0xhMmpURWtGWkpiYXpZeUt2UlcyVWdabGdZeGgx?=
 =?utf-8?B?d0NXM1IwUHRFMDZPT0hTcmZwSGFRTU9DZ28xQXRrdnNiYlN3QmNuek1qbnhC?=
 =?utf-8?B?b2hWbGQ0OHRsOFpKVzlDRW4rdUhLbGVhTk90dXRsUjR5Mk1kUHlxVFdwRThF?=
 =?utf-8?B?S2ovdUVpcHpPdUtWQzQwUkQ1VUJxcGFqVlljdllvY0RJL25Rdzhqc0NwR0hM?=
 =?utf-8?B?b1dWREdsMDBqS2JSMkhRUVgzNHVIaU1DZFVKZjNMTUxyQXZzeWQvY1pjYTZR?=
 =?utf-8?B?VnVqa0F6MUFxcTZ1TjBBeWx0UC9jbXhHOW1JUktNc0NQemxROGo1d0xnWm40?=
 =?utf-8?B?M3JkeHBuR3dQTm40VXdIOFlUbkxHWCtjQzdKdVJtT0NVSFNSR3hPYVI0MCsw?=
 =?utf-8?B?eFl4bXNzbXk0MlU2S3Q5eFA4L0ZrcUpuVTgwZzg2TzdIbzhQRnR1Q0JLZ0xB?=
 =?utf-8?B?NWhuMlg1ZUtjTm1ka0NsSVJkNjQreU9wTGJYeWI5UmFWRGxVa0xrRVZ6SU4r?=
 =?utf-8?B?N1BNdm1ORldzR2RCdjMxYWp4c1hlMGdta1RvaEpMenluZlMzTmgxMmRHTFlP?=
 =?utf-8?B?RHcvRVlzaEc5Y3hCUTQ0VUwxcTFxbGkwYUJIUGNoYWNXSjllMW9wZUwza2FP?=
 =?utf-8?B?MzBCYklKSjBrdzgwS0FBc24zY0Q1VmttSmlXK3ltSWJncU1aZGt6ZG4ycjRZ?=
 =?utf-8?B?L09ZZG1kSUYzNDFCVnJTeEpjb1BoNm1pVFVvK2s4MGtaN2ZUT3gzb0xZMnZz?=
 =?utf-8?B?NDY0OTFZVjQ1RmEzUHprdGRuMStheGlKcnMvb3EvTTRHNEdkZmg1MHJJRmt5?=
 =?utf-8?B?cG5CS0ZMZEtEZlBqRGhQZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXd6blppZncvNmtnYzdhTFJLRjNLWlZWMWQ1bk9ORWgwNmVZdG9IdC9ZQ2hl?=
 =?utf-8?B?Wm9jVnBMWTZTNVh1RmVkZGFQT1laVVZlTitIL2JyMUNDQ3pLQURKQitkK3ow?=
 =?utf-8?B?dUJQNlIvOE1ZQ1hrdHo5Q2lmYXR0a3k5T3F5c1JWVkpLYlBpQzdTdFN3TmNh?=
 =?utf-8?B?emNuRDY5QkQwK3JQMDBlTUhNZHA0TTIxK0NyeVJxeUJJcXpVYk5hclBtaUx2?=
 =?utf-8?B?aDhYOXpPNGNXM0orZVRSckJNUHYxYjBDdXMwbGtNdWlIM1M3MStIYlo1WWVL?=
 =?utf-8?B?bC81Wnc2d1ZsVEZKcDh2cSsvRWpacWpNMktlRmRKd0lZMC9ZdVpMMWc2RUV3?=
 =?utf-8?B?NGhjcmJnK0F4UENKYXRwRlBFWjByS0hqMnFLQmFtSkZvWHlTTFdKcEdKbWRv?=
 =?utf-8?B?Y3dxLzgxeG1zNzQvZWg2Umt4RXJSWWcycThldVZxVWpWUVprUVRDWFh0a084?=
 =?utf-8?B?V016MWxweEhHeVF2WHh5aGJmV1pNMTNEM05TNEd6TS90YytyRTVpV0l5TUsx?=
 =?utf-8?B?V0VjQTFkN2orUmJESHJkQlRKU0pHdmJGZ0dURUxFSXJTaGtSUk5qamFVUFZ1?=
 =?utf-8?B?cUZlVHh0Z0hyM0RvQXp3R3hzdTZYSUFweTBmdWRvanBYUjJMV3lUQTJPN2M0?=
 =?utf-8?B?a2VpZXV2dW5yUi9DR0g0N0NyclJCRXBGSDgrOTZ4SjJzY3Y2SnErTGdVcFdu?=
 =?utf-8?B?YlFKTnVGT1BwalJmVXpqbDVpb3pGeXRDb3JEbzZ0OUJUYmNvdnFQdk8zUWw1?=
 =?utf-8?B?TStCM2kweVJROVNibk5QeGtpNFZEUjVEL29pZU9xWURLQVFhOGNOTVhGQTZH?=
 =?utf-8?B?NkIwQ2dBaTFCQ2QxZGhWekttVExFK0VRMkF6cFVCK2VIaTltZ0R1a0RVUXpS?=
 =?utf-8?B?Nk5BZFZZWWxtaGlUdjVGS3V2WWVoRU1aa0ZPN0YvN3A5aW51WVVOK0Fidmdm?=
 =?utf-8?B?dTlmZ3pjTTc3cUZmdUJZQk1zZ3hKZUhCMTFrYnB5emswUUVBbTRhYXVNRkFq?=
 =?utf-8?B?blBrUk9oQmZnanRtTktjclo1a3ZNU0Y5aDhocS9TQ3BhQnhzWEJYd2dqcEVk?=
 =?utf-8?B?VWw1cHdBWUwwMm1Tc3RYZnJHeE54ZmljcGl1TjJGbDF5SXRaeUU0L0tHTGF5?=
 =?utf-8?B?NlVkMFA4MkVBeGNvSkhzZlpqWk5vbUpiQk1Wd0hQUFh6TjFvV3krVFdrNHgy?=
 =?utf-8?B?bVhqK3NLb1VCYVJDQjFvK3ExMnRYTXNOWGYyUU5ERlRscjdvUmRKdnNnUS9t?=
 =?utf-8?B?aFNzL0pyTVlOU2hNMWNGK3l3d0ZDOEp6V2hGMVRHUE0xclhZWGlZeGVaRjJr?=
 =?utf-8?B?eG1KeHVrNWJNeldJSmViVndVbm9ESitxSXlGc0VsTWN1eU0xeDdyR09CelF3?=
 =?utf-8?B?QjNHR0dsNjFza0U3eVk4SHptNksxczhiaTRzV25ZbEJFaTZ3VUZoTFhkVWZM?=
 =?utf-8?B?WjBDbTE1Q2JGdmszVXBYQXJJTXJ5K09iT0RCYVN1a1pNWUg0clNSMXpGY0FK?=
 =?utf-8?B?RTlGbWlYN3B0SVgwS2w5dUtmODdiRlc5QW5maWxBeUxSRUR5RHY0RXE4bk4r?=
 =?utf-8?B?VmJoaGpTZ1ljODkrMWxLTGgycnIyWGFDVVNOQXVBQkk1a29JMkJRemJ0Tm02?=
 =?utf-8?B?WEc5MUR1UkNJZ1FhaTNLbCswMzBWSllLQVRKUGl1QlZlNGU2RmZjWFBmRzlG?=
 =?utf-8?B?cEdKbm90NlBOTllrSXl4Ylp2WmtySFZqVEhoV1ZNWjZtZ0Nqa2JiNG9MRWtB?=
 =?utf-8?B?U25qTWVSdzJ3VUwxUzNBR2JBcVBBalRSMDRrNUdZYnBVbTZRNFZ6YzlWUnRB?=
 =?utf-8?B?c1FUZWNveTN4NXJ3WjZPZGtsamx0bGVmOUxKQWo4WGZESjVKb1UvWGEvc1JU?=
 =?utf-8?B?RHE3TVVlOHpRenZQTDEyZ3Y2OHU2SkRQOVk2MHJZb3ZqbVhYMkJIczd0VXNZ?=
 =?utf-8?B?dE0wb2t5dDdJZkM1ZDdSMmt0WGlCeWNCZXVjb3YwOWo1b2tsR1k2N0o1anFp?=
 =?utf-8?B?RHpEVjVQOTlteDR0N2hXaU5Na1dOVU9oTS8raGdLYkZSeWN4aHA2aDV6OGJr?=
 =?utf-8?B?R1JvSWNKQjY3T0JxK1VvUmdyOWJma3BVVGFuZjFZY0NJeWpWaXhXNnRWTS9E?=
 =?utf-8?Q?qZRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4940a238-d49d-4825-facb-08dce9c67a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 07:29:44.3361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GI0eluVwByZMIqbo+yym8+yL73oBPezqYsf9FQctuUlD0wPzr6LFV2b78bd7/efkf98KTTVv+aFJaSQ3P9xX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7791

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDEw5pyIMTHml6UgMTI6MTMNCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRA
Z29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBr
ZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IFZs
YWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+OyBDbGF1ZGl1DQo+IE1hbm9p
bCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhw
LmNvbT47DQo+IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsgbGludXhAYXJtbGludXgub3Jn
LnVrOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIG5ldC1uZXh0IDExLzExXSBNQUlOVEFJTkVSUzogdXBkYXRlIEVORVRDIGRy
aXZlciBmaWxlcw0KPiBhbmQgbWFpbnRhaW5lcnMNCj4gDQo+IE9uIEZyaSwgT2N0IDExLCAyMDI0
IGF0IDAyOjA1OjM3QU0gKzAwMDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0K
PiA+ID4gU2VudDogMjAyNOW5tDEw5pyIMTHml6UgMzoyMQ0KPiA+ID4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiA+ID4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0
QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gPiA+IHBhYmVuaUByZWRoYXQuY29tOyBy
b2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gPiA+IGNvbm9yK2R0QGtlcm5l
bC5vcmc7IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+Ow0KPiA+ID4g
Y29ub3IrQ2xhdWRpdQ0KPiA+ID4gTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xh
cmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gPiA+IGNocmlzdG9waGUubGVy
b3lAY3Nncm91cC5ldTsgbGludXhAYXJtbGludXgub3JnLnVrOw0KPiA+ID4gYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4g
PiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiA+ID4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCBuZXQtbmV4dCAxMS8xMV0gTUFJTlRBSU5FUlM6IHVwZGF0ZSBFTkVUQyBkcml2ZXIN
Cj4gPiA+IGZpbGVzIGFuZCBtYWludGFpbmVycw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgT2N0IDA5
LCAyMDI0IGF0IDA1OjUxOjE2UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gPiBBZGQg
cmVsYXRlZCBZQU1MIGRvY3VtZW50YXRpb24gYW5kIGhlYWRlciBmaWxlcy4gQWxzbywgYWRkDQo+
ID4gPiA+IG1haW50YWluZXJzIGZyb20gdGhlIGkuTVggc2lkZSBhcyBFTkVUQyBzdGFydHMgdG8g
YmUgdXNlZCBvbiBpLk1YDQo+IHBsYXRmb3Jtcy4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAg
TUFJTlRBSU5FUlMgfCA5ICsrKysrKysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9N
QUlOVEFJTkVSUyBpbmRleA0KPiA+ID4gPiBhZjYzNWRjNjBjZmUuLjM1NWI4MWI2NDJhOSAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiA+ID4gKysrIGIvTUFJTlRBSU5FUlMN
Cj4gPiA+ID4gQEAgLTkwMTUsOSArOTAxNSwxOCBAQCBGOglkcml2ZXJzL2RtYS9mc2wtZWRtYSou
Kg0KPiA+ID4gPiAgRlJFRVNDQUxFIEVORVRDIEVUSEVSTkVUIERSSVZFUlMNCj4gPiA+ID4gIE06
CUNsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPg0KPiA+ID4gPiAgTToJVmxh
ZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4NCj4gPiA+ID4gK006CVdlaSBG
YW5nIDx3ZWkuZmFuZ0BueHAuY29tPg0KPiA+ID4gPiArTToJQ2xhcmsgV2FuZyA8eGlhb25pbmcu
d2FuZ0BueHAuY29tPg0KPiA+ID4gPiArTDoJaW14QGxpc3RzLmxpbnV4LmRldg0KPiA+ID4gPiAg
TDoJbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiAgUzoJTWFpbnRhaW5lZA0KPiA+ID4g
PiArRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mc2wsZW5ldGMtaWVy
Yi55YW1sDQo+ID4gPiA+ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0
L2ZzbCxlbmV0Yy1tZGlvLnlhbWwNCj4gPiA+ID4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjLnlhbWwNCj4gPiA+ID4gK0Y6CURvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwueWFtbA0KPiA+ID4NCj4g
PiA+IE1pc3NlZCBlbmV0Y19wZl9jb21tb24uYw0KPiA+ID4NCj4gPiBlbmV0Y19wZl9jb21tb24u
YyBpcyBpbiBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvDQo+IA0KPiBPaCwg
c29ycnksIEkgbWlzcyBpdC4NCj4gTWF5YmUNCj4gDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjKi55YW1sIHdpbGwgYmUgc2ltcGxlLg0KPiANCg0KWWVz
LCBJIHdpbGwgcmVmaW5lIGl0LCB0aGFua3MNCg0KPiANCj4gPg0KPiA+ID4NCj4gPiA+ID4gIEY6
CWRyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy8NCj4gPiA+ID4gK0Y6CWluY2x1
ZGUvbGludXgvZnNsL2VuZXRjX21kaW8uaA0KPiA+ID4gPiArRjoJaW5jbHVkZS9saW51eC9mc2wv
bmV0Y19nbG9iYWwuaA0KPiA+ID4gPg0KPiA+ID4gPiAgRlJFRVNDQUxFIGVUU0VDIEVUSEVSTkVU
IERSSVZFUiAoR0lBTkZBUikNCj4gPiA+ID4gIE06CUNsYXVkaXUgTWFub2lsIDxjbGF1ZGl1Lm1h
bm9pbEBueHAuY29tPg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjM0LjENCj4gPiA+ID4NCg==

