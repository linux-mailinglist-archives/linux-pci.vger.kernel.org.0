Return-Path: <linux-pci+bounces-33724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03DB20754
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE423AADE5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 11:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0BE188A0C;
	Mon, 11 Aug 2025 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HJDAfEfB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB526E16C;
	Mon, 11 Aug 2025 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911105; cv=fail; b=QU+PvyNRPWRF1PuCaP32ME6dw7769brFExIsYVwR7ba6yLMJmhOScyM32X6weE2owutj0iloJCCVOyDsnp2LME53lXBL1j8h0COBlzfHNJavGt9mIrIRk/xhvRZKbqJv7KAfuTDtg4y6hnHPQU8qxDWxnhFpwTRew/vbjcjA9cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911105; c=relaxed/simple;
	bh=B7B/cvnrjkw7WzYinWfC+cYqE/C2hN28d5rY7/gKbxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J4iIxR9KYsQPkr2aHWoZBOt+jwXQSLptNiRpFLnEvAAR5caCajJl24l0v6f/EVjhZKJyVpQXdzS7e1cM6qpKaujBOEiyrwsKsutRUwoaUouZ3Wz/rl6fuN1xulhuqHnH9IFbboV2+rsdZdx2aaOcZC3TG7tUdHRuCbAzhAJI0M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HJDAfEfB; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4fqPp92MqGk8UDoL/LARsrou8cMSO/d14V3KGubv0l1ZeRlxojvE7YwTGyjI/fv69tKzACKJFsDpG5eJG6HCPwkY58OP8VHBc+bGV28+0YBGVQVErROSFyOdWUxTwK5g8/efMeOI1CKaP84XjtM0+f4BmcNpNULpKHpi8mj86V5sCFXLi1YDxVTieICYwoiNiJbZiSR1jisO4qcJwYlYxLdnli5LA2kGEn4kUTLj8tGlKXcUwLmiYI44iRS0ZldK2WPFEHhvf5RJy3kaQN2bNF5ts1fRZNibHnZWvxx6Gkgvy2ybpftUkvzXI6ywrHWCIgUCcQtHUyUoYO6sIGusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7B/cvnrjkw7WzYinWfC+cYqE/C2hN28d5rY7/gKbxA=;
 b=j6xmzfamHDUl+GdKXNnE4q20Gl093QIdlIhMuNkueMyZAxxrc/qE9Ow7Nf/D4c9Qk8/x4GDnBgaTEb0YacS98/hHus/emG7zVFlVaxXSc/mWzhp990m+CFgdm/d3C+9E81OGdAF123mpKwntxdWSgYiLSWyTVlCRdWeZ2ZwEZVUGU33vsklIn3mF6QfC/8xN9GivY9//EixAjCYgeMLLZa/A6FKl+RIlx0gfK4ZIMIgeEMfytlG4jV0ggiq8+sh/eQxgPFh3a/i1SrsGUJXC8SAC+c5pMbJ01LU4xODKVHT8P+8YJphWkINDmcSJPllNBTeDt7OdRH6bXDvn4xfZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7B/cvnrjkw7WzYinWfC+cYqE/C2hN28d5rY7/gKbxA=;
 b=HJDAfEfBk1koau+BbtIXbnnMi7XhbTfJEpHZKhLeTjTWli78QgaYNgRHRfVworjHWcEIT36KOoiugFSFMV55zL5nrYaYx3UqvZe27XfAkEjY/UUVIZom30fBd8H+3vpljQh/AjCj2sX+5upHuvCmg9BDuFh7fRcWxUD3jLyVy10=
Received: from IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 11 Aug
 2025 11:18:21 +0000
Received: from IA1PR12MB6140.namprd12.prod.outlook.com
 ([fe80::92c9:cc21:f1dd:abec]) by IA1PR12MB6140.namprd12.prod.outlook.com
 ([fe80::92c9:cc21:f1dd:abec%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 11:18:20 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "cassel@kernel.org" <cassel@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v7 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP
 PERST#
Thread-Topic: [PATCH v7 0/2] Add support for AMD Versal Gen 2 MDB PCIe RP
 PERST#
Thread-Index: AQHcB26Nst/p2EYBhEe0zghwAGjqRrRdSpMAgAAFT5A=
Date: Mon, 11 Aug 2025 11:18:20 +0000
Message-ID:
 <IA1PR12MB6140B4DE094411A526AEA1F8CD28A@IA1PR12MB6140.namprd12.prod.outlook.com>
References: <20250807074019.811672-1-sai.krishna.musham@amd.com>
 <175490898683.10214.13460972543852737432.b4-ty@kernel.org>
In-Reply-To: <175490898683.10214.13460972543852737432.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-11T11:02:06.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6140:EE_|DS0PR12MB6488:EE_
x-ms-office365-filtering-correlation-id: 0ec8d4db-de1c-4990-75c2-08ddd8c8c783
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0o3YXVaMDRqUFNxclA4OEhCT0svOXZEbitxeHl2VTY4UXJaR0xpSUorcEQ4?=
 =?utf-8?B?OVI2SEtiSWViMEtxM2F5aVJVUDdSZEtTTi9sSWwxRndQNW9jZ0tRN29OV04y?=
 =?utf-8?B?VEFuZzZNZi9oSzI4R1ZteUcxaEdRbytsL2FnT3Y5VTBxblMrMmRDN1dXVmww?=
 =?utf-8?B?a2hYUTduOG1GTExHQ1d0MlZPQkJ3WGFtZGFyK1NsNEM3aXpiYWppekM4TEl4?=
 =?utf-8?B?Mk9sNWd6d0NsRHZ1MEw1OEpoc2ZKNmtJUnVKMWt0YjBjak02dDBEK0lGVlUw?=
 =?utf-8?B?cTA0ZFBsRkl1NzRJLzFvWGE0UjFERjAvcFM0NE9uRit3UGZBb21DdkF5RFVJ?=
 =?utf-8?B?dENueTVBS1MwWG1jYUR2RXc3TTBuZ0t4NmIrWHVKd2liSFd2aytRaWZUSW9P?=
 =?utf-8?B?VFQ4QjczOWp4ZzlncGI5MnEwbC92dkRQY2xHRm9Jd3Y3VGgwbDdOZjl6QXhp?=
 =?utf-8?B?aEFpdmxiQ2ZqUmRQTUxuSEpKMlFiR3VQM1J4blMrcVEyK3pBeXJuVjFqdjdq?=
 =?utf-8?B?WHNvNkp2UkdTWnhqL3RQWVA5WG9tclRCc2JMb3dNL0Yyb291ZVNYcE1XWC9n?=
 =?utf-8?B?dWtXYUtJS2dxb1RBdDY5NVM0T2k0aEtRZi91R3ZRdDNxK2hlaVU2S0tONDYy?=
 =?utf-8?B?Rm9raHpNVGc3U0RwWDRjSlV4M0hGYnNraHJMMkt6Q1p5eGFnZXJUdkp3VFBh?=
 =?utf-8?B?TDQxaXE2YmtyL2FUV2x1azgzbzJNVUhzWHF2MVRBc0pTZFdZSWtqWUYwZkU4?=
 =?utf-8?B?b3VEcXlOZHRLSWhhdkdOMWtmMmJLUi9GYTgySVNHc0ZmN01Lb3Y4OHhpQ2tK?=
 =?utf-8?B?UUVqQkpVVFVWWHU5OFp5bXcwYWUyZnRHT01EeHRYZ1YxOUpTM2xzMm40Rmlw?=
 =?utf-8?B?NWNIdmUwcHl3NWo2a0YrcFhmRHdzRExtdVhCMmxyTldxZHR3V3RjWCtYN29I?=
 =?utf-8?B?QzJsc1RXZ3QvNWhTL3hNbDNPSGhPTTBBY1YyNEh0bXB3UlN1Rzdld05ianRW?=
 =?utf-8?B?MkRiL2JzNjRWTDF1SlB4aEpaUVY0NEE2STVOR1U2THRabUQxM2UzOEgydkZ5?=
 =?utf-8?B?QnI0OStOdkpaYWhXZFBPWXdXa2gvaWRvUXNMV1d0YmZYeUxhNDFoeGtabEtT?=
 =?utf-8?B?R0JHVHJVVE1la3Q2RnhSWFdtTUw1enovQlU3YkJwdHpYM0dxaXJCV1haTUpl?=
 =?utf-8?B?VXVMd0htdFlPekM1WVJrVGtTYjRDaUlXVVBrN1EwQ3p6NWpkODBWWUN0YXkv?=
 =?utf-8?B?c2RZU0paeEU0a2xCS0JaQ05pOVczQTZQemlEUE9OazIwbVJXQjZHdklISlgz?=
 =?utf-8?B?UGZ2MDZPR05pS09qeDQySlhZT2NTQ3B3cHdIMzR4cU5ZMUx3a2VqWUxBdkQ5?=
 =?utf-8?B?OTdhdXhGWGh2Rkp5ODlTZ3FnRGJ2all0TjY3VWtsTmVxRjhJam1uTERUMjVC?=
 =?utf-8?B?b20wSXhMV05vQVE2b2JvaDM0eEtVbW1SbG4wSVVnaHNTWTRYMTh6aHdRdW0z?=
 =?utf-8?B?Wk9ra3hoanBiWlVVMHNyK1FzTmZVTk1GU0h5blZTSVZPT2VKSVV6cHcwd0Jn?=
 =?utf-8?B?cGFIUDhUcjhWV3dGQ1A2Y25MdnVXVXRkOHJGVEhHZ1lrTWFCdW1GdDcvUVVK?=
 =?utf-8?B?bFVmVWJDaDBaU1Z0Mm1mOTMxSWRhb3VmVFUwRTdTeFpQcnhJeGFXbWNpM0VS?=
 =?utf-8?B?a1R3VnBQa1B2VmU1bmxCTy9PSG0wZEI5YjhDaGNPNWhqcUhveDdhUG90c1Nn?=
 =?utf-8?B?UWhpSkFoakNqNTBTaVVOYWIxL2JzZ0pYR0NkaUxTOW1aYU1Zd2ptQldKdVNR?=
 =?utf-8?B?WE16b3Y1Yk9KTGFxV29KTmY4bk0wSGpudGhWL0VnNnZaZ0Fzb0xOR1BBdkht?=
 =?utf-8?B?cE9xa2pkRHJVNVdoM2k0UFg1My8wNmpTVEdVRG9GL2FDT0I4WlNnRlBEbmxw?=
 =?utf-8?B?ZFJacFhGMEphaThNVTAyZXJaWTVhellBbXVWYjZUMitGSC9nRGJ2Y2lFNG9j?=
 =?utf-8?Q?NsbzUJS8k8+Sc4se8TJBkRzdyGV12w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjhuU3dIWE5IaGxibWQ5T2lzTUdyUGdQbG5nM3hLT3Q1cVFiNHRnQXlLbytl?=
 =?utf-8?B?YWVmdG9kQnk5c0xmcjlTUjRkZDFiY1d0SDZQVTFjSHU3S2J6UjdKaGQ1NjFy?=
 =?utf-8?B?a2FsejQzcEFpK0paczhET1ZUQ1psTGVNQjlCMkYwMVpNL1JDeWp3emkyekdJ?=
 =?utf-8?B?enNVOWlEM25VMG9hV1ZBWGg1QzRlRjYvM1BPdTNhaEN6WXRISmt0Qk02OWhV?=
 =?utf-8?B?N080NEp3QUZWSFp1cHU5WitvWkdBMUJKaWF1Zk9PU0J5Rkw2Qi9xc1ZOOTJ3?=
 =?utf-8?B?eFFESUw2TFRtemtPOUNiamZNbU1CdHJJNFM4THBPNXBFOFQ4bDBZUU5sbFFl?=
 =?utf-8?B?ZEhXbHhrUDNWeHlwaEtJazMwVUlWc1BUZkxmNWQwOGpkRUZBbk5MNUd3N2xI?=
 =?utf-8?B?dWhiMjgrWXl3cWtqSGtybW1janNsVGxKUkRqamx0T2tTKzdTL3YvS25HVERn?=
 =?utf-8?B?VmwrUzJaanFBR2NlbmV6dmRMRTFkUnhaOHlXRTEyMUFZQTQ4UlUyK3o1Nm9n?=
 =?utf-8?B?WWxBbFVxQklmQ2ZLWlUwbUtIZmJHRzdaeWV6R25oVTVNcFRhWnpNcHBJRndB?=
 =?utf-8?B?ZmZZeTFJQ3BrZ3lvb0VnUTlyMjd2UU9WdEJ2dE5zN3dxcVFoWjRkZS9SOGtt?=
 =?utf-8?B?dE1vclBIRmZYUVdsaTlKUThLcjZGTzB4T2MxbFlyY0k1aVlNc1c4elJNK1ps?=
 =?utf-8?B?eDlNWDdMQ1VqUkFZZVJjRm1IVng0VUI2aW85SmJ2MW0rbDN5Z2hoR2VSZTkr?=
 =?utf-8?B?eFhscFF2SENlZno3d2Z4UElySklNS0EyVkMxSVVGd09LT3pzaHprdmdFdzM1?=
 =?utf-8?B?M2lTM3dBcVA3M3VwY1pEVS91bE9CTTkrajI4QjZ2eDJyTElpUktKLzVCWXRG?=
 =?utf-8?B?ZmkvOWpMUmovRUJ3cGdlanJhd2xMRmo3dER5SjJzalhkSHU3TEVwYW9oNDRU?=
 =?utf-8?B?NmQwUCtIT3dSN1NiRElPSnVIdmpyUkVzNTFrNExxR3Yyb1FjcnVjNTFhbG5w?=
 =?utf-8?B?TG1ud3YrVGpFakhQTDZDdnJYS2J6SWNDUHcvMEVvNm4rUUx6Z05kcDJPR3I5?=
 =?utf-8?B?WUtMbStYMzBFN2tYZUlwbnA0di82Wmw4aE02cHZZVk1YYlpnVC9BajV1ZS9u?=
 =?utf-8?B?VjNUQnllVGZtb1A5U3pCV09GcjV3eE1RWXl3WXNqVEdlZzNGREJadGJoMmVk?=
 =?utf-8?B?TGFwc2RTc2VQblhTckJIYkx1UUpRZTBvN05Fczdyd3ZIaHZuaWxsczVwWVJY?=
 =?utf-8?B?aVRFaHlhM2dBU1d1cE1GYSt3L05YWGZJTFIxdm0zVjlLelV5Z2U3WWtucFNh?=
 =?utf-8?B?NmsvOFdJWkUxdjNCalk1d0luUTRvb0pNaEFLMlFYWE4vZDlFbDBvWm1HcWdu?=
 =?utf-8?B?NW9sa0lVVG9mY294bnNIRWNlY3pRT0lGUzlEa3c0WW5sZWE5VVpHY3A2YjYv?=
 =?utf-8?B?RDdsSlNlWHN4WHdlSjQzTTdzRCtoalg1cnY3M0RYYUJEVG5QLzFRTjI4UnBV?=
 =?utf-8?B?WHh0TFZwck5jQVNGWUFLUGtzaHBXRHFuMG9DbVpZRGlqQlppQm9lZzFjWmw2?=
 =?utf-8?B?M2h0Tzd6YzlodytQMlAxNm1DclhqL1dJL0ZQbm94RURSQnlBV05OSVZOL2Nv?=
 =?utf-8?B?ZnhuaDdyUFNRaDZ6S1Njc2xKK2VBM2dOblMvazdtUkQ3VWRVZ29MYmcwWGtD?=
 =?utf-8?B?dHhrUnRnMjlFT2ZqcWlhOWVmVU9kS0dPc1FGL0s4MS8zZ1hkZUFudzF5M01i?=
 =?utf-8?B?T0xDTFhKeS80R1Y0eW96dXpjY09oR2x5MFpRd2ZUUUNCY0FWQVZLSzdTRmhy?=
 =?utf-8?B?ckc4Y21qL0dUc3VFbTVnVE03OEZmS013aXpOWkxBQjdBbDVQbnpYemt4RExK?=
 =?utf-8?B?V1FjYTBMRjgrNy9YVXB2U3dHS3IzMmFjRkpjQkxpTE5aR0dvUEJRWTBHUzVP?=
 =?utf-8?B?NmJ0RkV1cTN3SWh2cGc5TWxWMmQveERaM0xGN1VDMk9QUk5CeldLYVJ6ZjQ1?=
 =?utf-8?B?MTRqdVF5bEZ4MmI1SkJ5NkdvM0RWQXFlT2tmckYwRTRGbkkwblQybGNoa0hE?=
 =?utf-8?B?eUVnYWdOeEFsY3ZKSmpqU1B3WGJMY3FBMHlOVERZVXkxRVhXMTF6SWZGaU5T?=
 =?utf-8?Q?D3nU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec8d4db-de1c-4990-75c2-08ddd8c8c783
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 11:18:20.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UadMfv8vC5fNRes2mPzUrSvtpp1uzHIXz0V3KGCoTP8SV34S3dKNUyIPPegNChPjpN7UMz7as+rS3o/BZpcYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhh
c2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBvc3MucXVhbGNvbW0uY29tPg0KPiBTZW50OiBN
b25kYXksIEF1Z3VzdCAxMSwgMjAyNSA0OjEzIFBNDQo+IFRvOiBiaGVsZ2Fhc0Bnb29nbGUuY29t
OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJu
ZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBjYXNzZWxAa2VybmVsLm9yZzsgS3J6eXN6dG9m
IFdpbGN6ecWEc2tpDQo+IDxrd2lsY3p5bnNraUBrZXJuZWwub3JnPjsgTXVzaGFtLCBTYWkgS3Jp
c2huYSA8c2FpLmtyaXNobmEubXVzaGFtQGFtZC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgR29n
YWRhLCBCaGFyYXQNCj4gS3VtYXIgPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IEhhdmFs
aWdlLCBUaGlwcGVzd2FteQ0KPiA8dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NyAwLzJdIEFkZCBzdXBwb3J0IGZvciBBTUQgVmVyc2FsIEdlbiAy
IE1EQiBQQ0llIFJQDQo+IFBFUlNUIw0KPg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2lu
YXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uDQo+IHdoZW4g
b3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+
DQo+IE9uIFRodSwgMDcgQXVnIDIwMjUgMTM6MTA6MTcgKzA1MzAsIFNhaSBLcmlzaG5hIE11c2hh
bSB3cm90ZToNCj4gPiBBZGQgZXhhbXBsZSB1c2FnZSBvZiByZXNldC1ncGlvcyBmb3IgUENJZSBS
UCBQRVJTVCMNCj4gPg0KPiA+IEFkZCBzdXBwb3J0IGZvciBQQ0llIFJvb3QgUG9ydCBQRVJTVCMg
c2lnbmFsIGhhbmRsaW5nDQo+ID4NCj4gPiBTYWkgS3Jpc2huYSBNdXNoYW0gKDIpOg0KPiA+ICAg
ZHQtYmluZGluZ3M6IFBDSTogYW1kLW1kYjogQWRkIGV4YW1wbGUgdXNhZ2Ugb2YgcmVzZXQtZ3Bp
b3MgZm9yIFBDSWUNCj4gPiAgICAgUlAgUEVSU1QjDQo+ID4gICBQQ0k6IGFtZC1tZGI6IEFkZCBz
dXBwb3J0IGZvciBQQ0llIFJQIFBFUlNUIyBzaWduYWwgaGFuZGxpbmcNCj4gPg0KPiA+IFsuLi5d
DQo+DQo+IEFwcGxpZWQsIHRoYW5rcyENCj4NCj4gWzEvMl0gZHQtYmluZGluZ3M6IFBDSTogYW1k
LW1kYjogQWRkIGV4YW1wbGUgdXNhZ2Ugb2YgcmVzZXQtZ3Bpb3MgZm9yIFBDSWUgUlANCj4gUEVS
U1QjDQo+ICAgICAgIGNvbW1pdDogMGI5Mjc1ZWRjMzU0M2QwZDJkMDMzMTNhN2M4ZGU1MTU3ZDYx
YjE4OQ0KPiBbMi8yXSBQQ0k6IGFtZC1tZGI6IEFkZCBzdXBwb3J0IGZvciBQQ0llIFJQIFBFUlNU
IyBzaWduYWwgaGFuZGxpbmcNCj4gICAgICAgY29tbWl0OiAxZDAxNTZjOGIyMzBjYTc0MjcyNzA4
YTMyMDY2ODRlNmQ2MTU3MzAyDQo+DQoNClRoaXMgd2FzIG15IGZpcnN0IHBhdGNo4oCUSSByZWFs
bHkgYXBwcmVjaWF0ZSB0aGUgZ3VpZGFuY2UgYW5kIHN1cHBvcnQgZnJvbSBldmVyeW9uZS4gVGhh
bmsgeW91IE1hbml2YW5uYW4gZm9yIGFwcGx5aW5nIHRoZSBwYXRjaC4NCg0KQmVzdCBSZWdhcmRz
LA0KU2FpIEtyaXNobmENCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IE1hbml2YW5uYW4gU2Fk
aGFzaXZhbSA8bWFuaUBrZXJuZWwub3JnPg0KDQo=

