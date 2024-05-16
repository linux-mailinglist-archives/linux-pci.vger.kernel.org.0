Return-Path: <linux-pci+bounces-7548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CB8C71B9
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 08:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E941C20DC0
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 06:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA902744D;
	Thu, 16 May 2024 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdpoUf+g"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7113225570;
	Thu, 16 May 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715842452; cv=fail; b=nih62KX8NbghuDzRx/PNzQl51iufDqLHgprGSnfs9BmEyupPiPmukkoP/exjmJgfbJCbigrdf+izz4tQyxHhYiHb4S4Q5EEAChEgOAoi0rFB0CjWNvn408Y/GVQdjO7bZkz0uF1ih1pnggmsl1HqRSXP6L/L2+TmMSciBkSpSXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715842452; c=relaxed/simple;
	bh=xM34b5ZgBUIBqiV2bj2PEtymnUsgM9DU/OPdFf9NOq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GkOg7JokNriktZodeRl/GedYh34ChcEyuH/AHinUineeNngskT89vEJ/f2VRh6diMJXyLhFPMmfpUNw+Dg5dLlWbHZLqx8JBV3eUmodMRLReQsygP5zuWKyiaqGHCtjDe7FE0J8ZG3MFlJ5oWfvn4/WjCNyZrot0AC63tvUe6FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdpoUf+g; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKguUsOok+qAQ2ZiPq6BqdvWPpQB5zwvIyAH1xB+grtOhcrhAPiKVwPzTahWzoeDyk5gbLy/ycNgk07Y0/rK4wAa5eV0k4kAXX4uFi36JihREFR6C2lXZm80Hrw773hrCXlXr/TjTPY+NlCMjhk2FCMJdjTHX9V8wn0f2Sv1E84Ep88VS7E0r0xLJfbjFWGimQBBPTj+OYq9B/Pq+cvhCu8OjBuwxbtDGQ5FjbA8Ud23y/WRKREWNDBCjIVEzvZQ8/getR9b5BIuBTXsGkvUiGhAdWlYyCaJ1tUuSGxjS90fuQz255d3ItdZ8s3p9WgHFMxSRfcXoaKzsPWrJ0AKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xM34b5ZgBUIBqiV2bj2PEtymnUsgM9DU/OPdFf9NOq4=;
 b=Rga4r2IfDQNUPByIMGOvLPakjtO4omScD2lhtC3c+pJkCX6mkLSpWXva4h5KvK1ODSVjjWeEVgYINHZ361MyRcQqvYVegG0eMYiP29rx14lCKYRzMmGvgCV75XFdu9hXR8aoGlZ4Ze2OQxY3tTx7pI/gw+xXvz/fDcXVBep3MQbWQm6pfZsa5aI8IVjKRFCcqp01R+xCFXIQsj8EekXoIeS25Zo2S0YYZItq4y+rXztdH8uMVrUDovcVCUbxCdBS+abandNPfTWSMrZUDNCD13vtgiD4chuVKXFxuDPVzyfrQvmK+Sktsd5pq1CBLqqbQ5Inj2J81FkKe7LL1ob2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xM34b5ZgBUIBqiV2bj2PEtymnUsgM9DU/OPdFf9NOq4=;
 b=LdpoUf+gUwIcU/5YeCWQou2c+pqgD8Ob8Bxjeo+amQdNRZgamRs6Hz5gG6FD8JaBiNG1zbn4v4b+gSCaWPikpNLkodvHNBBt6oHOAEQUoTt3jxcun6g29evBPwjq+6zwOnbkyRngBMMxTLt/RCdi5eFETbz7A/sdClU6jwT6Vlc=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Thu, 16 May
 2024 06:54:05 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7587.026; Thu, 16 May 2024
 06:54:05 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Stefano Stabellini <sstabellini@kernel.org>
CC: Juergen Gross <jgross@suse.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	=?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Huang, Ray"
	<Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v7 2/2] xen/privcmd: Add new syscall to get gsi
 from dev
Thread-Topic: [RFC KERNEL PATCH v7 2/2] xen/privcmd: Add new syscall to get
 gsi from dev
Thread-Index: AQHappQxRQ+jZBZ+9UGzYgGu09lQUrGY5VCAgAENwoA=
Date: Thu, 16 May 2024 06:54:05 +0000
Message-ID:
 <BL1PR12MB584969F16D93CC4A5C8E1F0FE7ED2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240515065011.13797-1-Jiqian.Chen@amd.com>
 <20240515065011.13797-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2405151537430.2544314@ubuntu-linux-20-04-desktop>
In-Reply-To:
 <alpine.DEB.2.22.394.2405151537430.2544314@ubuntu-linux-20-04-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.7587.026)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|LV2PR12MB5773:EE_
x-ms-office365-filtering-correlation-id: a47bb112-6c77-4fee-d989-08dc7574fa42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?dzdiYWZWdmtMQUYzREpXQUtFamdtWFJJekhiWE55d2ZKZkpLemVFRmdxMHZL?=
 =?utf-8?B?Rnk0RnFoUUVlNHg0M21DNk9kM3ZKMTZoa0oyL05Femp1QzVjS3UvSzBXRnRP?=
 =?utf-8?B?YmE2U3AzaVpVYjRJeVQwZUdtdFBUQ3IwV1RKNzJrSExGNmg5MFFhaUpKQjYx?=
 =?utf-8?B?aW1md1BOZy9acnlXRTY2OXhuMmdQanpoeW5TTHkxcU1KVmxhUGFKS095bjlu?=
 =?utf-8?B?bys5czZwNy9MZXZLSUpNdXZ6aHdhNTZuWnQwbzI0UmErRWduQWxubVkxazZE?=
 =?utf-8?B?UWxIQmkzOXIzUi9kWHhiNTNISHhKMkR3UVZYMFhuMzYvd1FrN3NHS1BFZCsv?=
 =?utf-8?B?MjUrM0dPcE95eUxJa0prRW9kaGxLOWlwZzMyeUpIYSt3L2JoVys2R0QzYmdF?=
 =?utf-8?B?dEJUNDBJcEJubU95ZEZZMXhLLzh6d1o3MHNxMkMzeUx3M2E0QWlmTDZFUUpD?=
 =?utf-8?B?bzdmU0pRSk5nNk05SG00Qy95M1N1K2lJZmRYNzJyQ0ptVzZYenZnaWQvNXdK?=
 =?utf-8?B?UFVZUDZ4R3ViMm9LUENyKzVHSmwzTFAwbGozekJUT1p3OVN5d2Ftd2VNREVI?=
 =?utf-8?B?ZGZ3S0d2alFOWkZjUk1USTNnMWhBZWdBZ0paTHlaRUMzYUFKeWdpaERiUHkx?=
 =?utf-8?B?VTBXYXdFdW1LSk1wRHdNOThXUHo0Z0tLMW81VDl1eWhqR3o4Nk55bzBSRU41?=
 =?utf-8?B?Um4zSmRpcTdHUHM4YUIyZ05wR3RCMHhrcG1kM1VvL2ZQdGxyNG5IMktoaitX?=
 =?utf-8?B?dUdTQTZ4QzM3VFg5QlBNbm1TZ1lkNS9jWlRnTUxxU2FNMTVFWWlWWmlVVU96?=
 =?utf-8?B?NytOZ3lnZnA2QWxML0tXbU8wSThlMy9lMWlFd1VGWEZBcUJKeVo0NmdxWU82?=
 =?utf-8?B?NXpSR1BxQXR0cjlyakorQWF0cnp4dFpNTG0rMGRTU2xCdXBKcWwyYUlTMEdH?=
 =?utf-8?B?MDE3S25SKzZ0T0NYN2g1b0dmR1JxeE9CWkhFMkxmdEVUV3JoWSt5N2ZHVzJ1?=
 =?utf-8?B?YnhQOHRDdFI0NzVnQWU3a3l2eWR5akVQS3liZHExMFJKS0FSODBCK2N6Umpx?=
 =?utf-8?B?ZjhJMlhmVXkza25Kc1FmSUhtYWJEWFpYZFE4YjRFbGU0VmpkcGVvM3dkbzZS?=
 =?utf-8?B?QTdoYkJlYjhsSHZMSldGTGZaNHlUMXQ2QjM1YThEMWx3VHlFS2xVRm4vSkFM?=
 =?utf-8?B?c1RQaWxsWStINGlILzdxTFlnKzdHRUZsRjdMMlpOa0pDYlpTZ0xpZENLRXVz?=
 =?utf-8?B?bk5SUmFMck9MQWdvODdFNHd6YTNESTV1U1JLc1pKV00xbmRtZlFXMEM4NDJQ?=
 =?utf-8?B?MlVCWlp1bTZYQzRxZ3grbkpFcVRsTCtadWxIMFhIelEvZkhJSE9NSStmS0hE?=
 =?utf-8?B?aEVaTE1icXhRUFE0UjE2WVcrd05ETjQxUzJZdjloRHVXR1RWcFd4UmEwRHJI?=
 =?utf-8?B?NllBMlRaMUluY3RtcHgzTUswa0hXVWVYNTdzbW9KSkRRbTBRbEFqa2JyZmRm?=
 =?utf-8?B?bDdrUEwrM3JNalZQbGM2RE1LdmxDRklOWnJRdURyOXp3Smt5T1R2VUJDUERw?=
 =?utf-8?B?bmVqU2NYbFJNQ1FJdy9CWFF6NFRpZWliS2hEdEdwaG56VmVpaGNSemlqalAw?=
 =?utf-8?B?Mk9iZHc1c1RRMHptLzZCTERMN2lVcEZwbnMwdjlDT3B5bUttSkwycTFzeVMw?=
 =?utf-8?B?c29JMDYrb0NVczA5SGQxenZhaTVyNE5sd2ljYnMrbE5kWXhMSzIrUStZQjNC?=
 =?utf-8?B?eUxPK1dFN1htaFBKZXA3dXcwaURtWDFoZ2w5SlVhTWNNQlhmSC9WUGlBQVZO?=
 =?utf-8?B?MnIzZTJmNFNWTkFwcFhnUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWw1YUQ2V3A3TGJJdG1YZlM4c2E3azFUTFBpclZzR3dLN0xPZ2U0QTVxVTNR?=
 =?utf-8?B?b1FFcEVHdnFacXpyV3dxRzFaRFhXRjc1bUFadnA1aFM4NDdDWHFaOUhjQ1d2?=
 =?utf-8?B?cGhJRDlLN01ZbEpCUWg1VDNKY0xFQm84R3N3SXl1VVhrYU1VSGVMaW02a2kv?=
 =?utf-8?B?TkdZdFZEVVRISGYzNkNHRlc5bU50TXRXQm9SNmN5L1MrWEVXQlM2NXNJYWhm?=
 =?utf-8?B?M3lIcS9sMm4rZStjeVcrR2phZXJldDV0UnE1N3B2Y1p4YVNlTktzQlE3ZU5q?=
 =?utf-8?B?SjBOQ0xiaFFMTlZnVjhvOXdUbVJweXFnK0dmUE9CRnI4WlloaktVa0ZZOVZT?=
 =?utf-8?B?YldQNWJxd1A1N2d0NDFEVE8vUWd0VGVEbEFMakl2SEo0d01kK1RIOTdZYVRm?=
 =?utf-8?B?R1ZWMTBtdFdVZzF3cVJ4QVRIVmJ5U1BqekpDOW1Nc09HRUZtcTJ5aDJ3SGFl?=
 =?utf-8?B?Rm4zdW0xeTNsYWhqZURwZ3lYekpzb0dObGd5Y2FCTXlnMm5pVWtMbDJjaXV2?=
 =?utf-8?B?YmV5ZzRxQWw3ZWtBS3RqdjJzK0NOVXZMYXVld2JVTG9iWlVEZGU4MDNud1g0?=
 =?utf-8?B?ckVUcTFjL0VFL3BXUUwvRW1CUGVJQ0pHTUZlK1BLUEdnODl6UVRQenpDajFs?=
 =?utf-8?B?bXhsdXNybTQ2MzkreDlQT0xVZjZhNWl0VGY5aTZjcGNDNzYxbTQwYUphZFNw?=
 =?utf-8?B?ZURXNGpqNkxmVzliL2ZFa0RoWEZ4bE9KSVNkNHlDNGNWeUJBZ01LS2didEJN?=
 =?utf-8?B?ZHBjNVpMUjFwbjJrYlNrQXc0aUJ2eG1BNzBNWUxTZWs4OVpWeWljYWNlbXJ6?=
 =?utf-8?B?WUVZQ090eVVsdURHT0hLV2lRN1NVcGsvVVNhSFZPbXNsNVVQMmJab21lR2xj?=
 =?utf-8?B?M2tLYWR0dktxQUsrTUtrQ3BoOHdrS2JpbHVkSU0xUGxXMThFd01FSHBBcUVC?=
 =?utf-8?B?WldNUi91RXlLc2l2b3BsSnY5ZEZKc2gvc0xHMG50WVJiUkFPTVRESmRUNnl3?=
 =?utf-8?B?QWFKK3ZCd1hzY3hBVG9qVFUzenlacnJsWC9QTnN2N3N5V1FPZW5ZRlFSTzl5?=
 =?utf-8?B?NDJoVjl5MHNXM3pZOTdwZTg2MmhIWDhWVElzcUNSa3JMcEFLWFdjRmNoOHBN?=
 =?utf-8?B?Z3hGVWg2Qy9QYzNFUzRCS1ZMc1c1RzdEb0NOYXl1ODYrVEtaTExZYUZaMmNW?=
 =?utf-8?B?Nnl4RVA0cUNDeEZJaXlHRXZFbDQ0bWlkdVdQNWtBcytiWmlxdDQxcVdGbHkz?=
 =?utf-8?B?Qnp3c0tGdS9naC9YbC8yYVZEM24wZy9ibFFpMUxiRzhIbHBnL25Ud0dwMUVi?=
 =?utf-8?B?V1BPdVNXN3FSRVRYSUJwRXdpelJBV3YxUW1CQ2VIaE55elFveXNnNnNrNjN1?=
 =?utf-8?B?Y2hXZ1B0MFN6STVrUk1DNjMrREhPL3B5WWNTc2d0SDdEM1AwazM4OW9uaERy?=
 =?utf-8?B?SnZmd2pLcTBpQzZYM3dsdFkxOU1CbmNVSWxUc0Fqdno1aEduSm1PTm1vOTV1?=
 =?utf-8?B?TkhvS3FHd0FHVE1OWnpIeUNwR3hkVjhsaGZsV20rSEp0bWxMWi9MT0NXaUJR?=
 =?utf-8?B?RG5oR0lVUWxiNFZtYURGVUpkRG9qcTRiNVJ5K2dZajdEais0NmZvQW9pdmQ0?=
 =?utf-8?B?SUNSZm1ScGl0cHlxWUxDRVhNLzU4U1Y2V1JVeHBCNElsUHhLTjZNeWZKMVA1?=
 =?utf-8?B?QjB0a2ZodzJaWjNxUy96cS9RWmV4RFFVcGtWZVVLc01BS0FlMFJLanBtY3hS?=
 =?utf-8?B?NU0rdEZ5S1ZnZGlsZDdOVXNRWFRKdk1OY2ZaVFZhZmtrNU9saEoyamphS1Rh?=
 =?utf-8?B?OFI1Mkg2dldMQkxuVEFXQUtYT3ZPWENTNVNtSHJVZURzbTFFRXdjN1ZYdWlC?=
 =?utf-8?B?ZnVoSmpNdEdwMHMyNUdaWnN5S3dBZDRWR1RNdTVSTm5PMVVLUUxDMzJBUGNE?=
 =?utf-8?B?WDZPbFp0cFliV3NKM1gwV0pCNVA3N3JpNkR2cFByUXNTSDQvM2M3NkcxQU9C?=
 =?utf-8?B?V3dkNGtQTGtDb3pTUVhMTittSlI1TWJWaDY3L1lRQmdvZkcwZlBrZjhLc0J3?=
 =?utf-8?B?d3RlakRmclRmMGMranRPUlZrc3R3MmYwdktZa1UzSGViMUJiY2ZDL3U2cTlY?=
 =?utf-8?Q?4DEE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBD9AC12B24A724A99225388A515DDC6@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47bb112-6c77-4fee-d989-08dc7574fa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 06:54:05.4973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dilf7WJlqIDtaDoz9SUlYgBvNsnvAaoKxQMV8UMHwv5wLrJSDr/CpItfSl0SkPOTbOdOhi/wOiPeyGX7+R05Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773

T24gMjAyNC81LzE2IDA2OjQyLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6DQo+IE9uIFdlZCwg
MTUgTWF5IDIwMjQsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4gSW4gUFZIIGRvbTAsIGl0IHVzZXMg
dGhlIGxpbnV4IGxvY2FsIGludGVycnVwdCBtZWNoYW5pc20sDQo+PiB3aGVuIGl0IGFsbG9jcyBp
cnEgZm9yIGEgZ3NpLCBpdCBpcyBkeW5hbWljLCBhbmQgZm9sbG93DQo+PiB0aGUgcHJpbmNpcGxl
IG9mIGFwcGx5aW5nIGZpcnN0LCBkaXN0cmlidXRpbmcgZmlyc3QuIEFuZA0KPj4gdGhlIGlycSBu
dW1iZXIgaXMgYWxsb2NlZCBmcm9tIHNtYWxsIHRvIGxhcmdlLCBidXQgdGhlDQo+PiBhcHBseWlu
ZyBnc2kgbnVtYmVyIGlzIG5vdCwgbWF5IGdzaSAzOCBjb21lcyBiZWZvcmUgZ3NpIDI4LA0KPj4g
aXQgY2F1c2VzIHRoZSBpcnEgbnVtYmVyIGlzIG5vdCBlcXVhbCB3aXRoIHRoZSBnc2kgbnVtYmVy
Lg0KPj4gQW5kIHdoZW4gcGFzc3Rocm91Z2ggYSBkZXZpY2UsIFFFTVUgd2lsbCB1c2UgZGV2aWNl
J3MgZ3NpDQo+PiBudW1iZXIgdG8gZG8gcGlycSBtYXBwaW5nLCBidXQgdGhlIGdzaSBudW1iZXIg
aXMgZ290IGZyb20NCj4+IGZpbGUgL3N5cy9idXMvcGNpL2RldmljZXMvPHNiZGY+L2lycSwgaXJx
IT0gZ3NpLCBzbyBpdCB3aWxsDQo+PiBmYWlsIHdoZW4gbWFwcGluZy4NCj4+IEFuZCBpbiBjdXJy
ZW50IGxpbnV4IGNvZGVzLCB0aGVyZSBpcyBubyBtZXRob2QgdG8gZ2V0IGdzaQ0KPj4gZm9yIHVz
ZXJzcGFjZS4NCj4+DQo+PiBGb3IgYWJvdmUgcHVycG9zZSwgcmVjb3JkIGdzaSBvZiBwY2lzdHVi
IGRldmljZXMgd2hlbiBpbml0DQo+PiBwY2lzdHViIGFuZCBhZGQgYSBuZXcgc3lzY2FsbCBpbnRv
IHByaXZjbWQgdG8gbGV0IHVzZXJzcGFjZQ0KPj4gY2FuIGdldCBnc2kgd2hlbiB0aGV5IGhhdmUg
YSBuZWVkLg0KPj4NCj4+IENvLWRldmVsb3BlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1k
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29t
Pg0KPj4gLS0tDQo+PiAgZHJpdmVycy94ZW4vcHJpdmNtZC5jICAgICAgICAgICAgICB8IDI4ICsr
KysrKysrKysrKysrKysrKysrKysNCj4+ICBkcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1
Yi5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+PiAgaW5jbHVkZS91YXBp
L3hlbi9wcml2Y21kLmggICAgICAgICB8ICA3ICsrKysrKw0KPj4gIGluY2x1ZGUveGVuL2FjcGku
aCAgICAgICAgICAgICAgICAgfCAgMiArKw0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4v
cHJpdmNtZC5jIGIvZHJpdmVycy94ZW4vcHJpdmNtZC5jDQo+PiBpbmRleCA2N2RmYTQ3Nzg4NjQu
LjU5NTNhMDNiNWNiMCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL3ByaXZjbWQuYw0KPj4g
KysrIGIvZHJpdmVycy94ZW4vcHJpdmNtZC5jDQo+PiBAQCAtNDUsNiArNDUsOSBAQA0KPj4gICNp
bmNsdWRlIDx4ZW4vcGFnZS5oPg0KPj4gICNpbmNsdWRlIDx4ZW4veGVuLW9wcy5oPg0KPj4gICNp
bmNsdWRlIDx4ZW4vYmFsbG9vbi5oPg0KPj4gKyNpZmRlZiBDT05GSUdfQUNQSQ0KPj4gKyNpbmNs
dWRlIDx4ZW4vYWNwaS5oPg0KPj4gKyNlbmRpZg0KPj4gIA0KPj4gICNpbmNsdWRlICJwcml2Y21k
LmgiDQo+PiAgDQo+PiBAQCAtODQyLDYgKzg0NSwyNyBAQCBzdGF0aWMgbG9uZyBwcml2Y21kX2lv
Y3RsX21tYXBfcmVzb3VyY2Uoc3RydWN0IGZpbGUgKmZpbGUsDQo+PiAgCXJldHVybiByYzsNCj4+
ICB9DQo+PiAgDQo+PiArc3RhdGljIGxvbmcgcHJpdmNtZF9pb2N0bF9nc2lfZnJvbV9kZXYoc3Ry
dWN0IGZpbGUgKmZpbGUsIHZvaWQgX191c2VyICp1ZGF0YSkNCj4+ICt7DQo+PiArCXN0cnVjdCBw
cml2Y21kX2dzaV9mcm9tX2RldiBrZGF0YTsNCj4+ICsNCj4+ICsJaWYgKGNvcHlfZnJvbV91c2Vy
KCZrZGF0YSwgdWRhdGEsIHNpemVvZihrZGF0YSkpKQ0KPj4gKwkJcmV0dXJuIC1FRkFVTFQ7DQo+
PiArDQo+PiArI2lmZGVmIENPTkZJR19BQ1BJDQo+PiArCWtkYXRhLmdzaSA9IHBjaXN0dWJfZ2V0
X2dzaV9mcm9tX3NiZGYoa2RhdGEuc2JkZik7DQo+PiArCWlmIChrZGF0YS5nc2kgPT0gLTEpDQo+
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsjZWxzZQ0KPj4gKwlrZGF0YS5nc2kgPSAtMTsNCj4g
DQo+IFNob3VsZCB3ZSByZXR1cm4gYW4gZXJyb3IgaW5zdGVhZCwgbGlrZSAtRUlOVkFMLCB0byBt
YWtlIHRoZSBiZWhhdmlvcg0KPiBtb3JlIHNpbWlsYXIgdG8gdGhlIENPTkZJR19BQ1BJIGNhc2U/
DQpPSywgd2lsbCByZXR1cm4gLUVJTlZBTCBpZiBub3QgY29uZmlnIGFjcGkuDQpMaWtlOg0Kc3Rh
dGljIGxvbmcgcHJpdmNtZF9pb2N0bF9nc2lfZnJvbV9kZXYoc3RydWN0IGZpbGUgKmZpbGUsIHZv
aWQgX191c2VyICp1ZGF0YSkNCnsNCiNpZmRlZiBDT05GSUdfQUNQSQ0KCXN0cnVjdCBwcml2Y21k
X2dzaV9mcm9tX2RldiBrZGF0YTsNCg0KCWlmIChjb3B5X2Zyb21fdXNlcigma2RhdGEsIHVkYXRh
LCBzaXplb2Yoa2RhdGEpKSkNCgkJcmV0dXJuIC1FRkFVTFQ7DQoNCglrZGF0YS5nc2kgPSBwY2lz
dHViX2dldF9nc2lfZnJvbV9zYmRmKGtkYXRhLnNiZGYpOw0KCWlmIChrZGF0YS5nc2kgPT0gLTEp
DQoJCXJldHVybiAtRUlOVkFMOw0KDQoJaWYgKGNvcHlfdG9fdXNlcih1ZGF0YSwgJmtkYXRhLCBz
aXplb2Yoa2RhdGEpKSkNCgkJcmV0dXJuIC1FRkFVTFQ7DQoNCglyZXR1cm4gMDsNCiNlbHNlDQoJ
cmV0dXJuIC1FSU5WQUw7DQojZW5kaWYNCn0NCg0KPiANCj4gDQo+PiArI2VuZGlmDQo+PiArDQo+
PiArCWlmIChjb3B5X3RvX3VzZXIodWRhdGEsICZrZGF0YSwgc2l6ZW9mKGtkYXRhKSkpDQo+PiAr
CQlyZXR1cm4gLUVGQVVMVDsNCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4g
ICNpZmRlZiBDT05GSUdfWEVOX1BSSVZDTURfRVZFTlRGRA0KPj4gIC8qIElycWZkIHN1cHBvcnQg
Ki8NCj4+ICBzdGF0aWMgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3QgKmlycWZkX2NsZWFudXBfd3E7
DQo+PiBAQCAtMTUyOSw2ICsxNTUzLDEwIEBAIHN0YXRpYyBsb25nIHByaXZjbWRfaW9jdGwoc3Ry
dWN0IGZpbGUgKmZpbGUsDQo+PiAgCQlyZXQgPSBwcml2Y21kX2lvY3RsX2lvZXZlbnRmZChmaWxl
LCB1ZGF0YSk7DQo+PiAgCQlicmVhazsNCj4+ICANCj4+ICsJY2FzZSBJT0NUTF9QUklWQ01EX0dT
SV9GUk9NX0RFVjoNCj4+ICsJCXJldCA9IHByaXZjbWRfaW9jdGxfZ3NpX2Zyb21fZGV2KGZpbGUs
IHVkYXRhKTsNCj4+ICsJCWJyZWFrOw0KPj4gKw0KPj4gIAlkZWZhdWx0Og0KPj4gIAkJYnJlYWs7
DQo+PiAgCX0NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1
Yi5jIGIvZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNpX3N0dWIuYw0KPj4gaW5kZXggMmI5MGQ4
MzJkMGE3Li40YjYyYjRkMzc3YTkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3hlbi94ZW4tcGNp
YmFjay9wY2lfc3R1Yi5jDQo+PiArKysgYi9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1
Yi5jDQo+PiBAQCAtNTYsNiArNTYsOSBAQCBzdHJ1Y3QgcGNpc3R1Yl9kZXZpY2Ugew0KPj4gIA0K
Pj4gIAlzdHJ1Y3QgcGNpX2RldiAqZGV2Ow0KPj4gIAlzdHJ1Y3QgeGVuX3BjaWJrX2RldmljZSAq
cGRldjsvKiBub24tTlVMTCBpZiBzdHJ1Y3QgcGNpX2RldiBpcyBpbiB1c2UgKi8NCj4+ICsjaWZk
ZWYgQ09ORklHX0FDUEkNCj4+ICsJaW50IGdzaTsNCj4+ICsjZW5kaWYNCj4+ICB9Ow0KPj4gIA0K
Pj4gIC8qIEFjY2VzcyB0byBwY2lzdHViX2RldmljZXMgJiBzZWl6ZWRfZGV2aWNlcyBsaXN0cyBh
bmQgdGhlIGluaXRpYWxpemVfZGV2aWNlcw0KPj4gQEAgLTg4LDYgKzkxLDkgQEAgc3RhdGljIHN0
cnVjdCBwY2lzdHViX2RldmljZSAqcGNpc3R1Yl9kZXZpY2VfYWxsb2Moc3RydWN0IHBjaV9kZXYg
KmRldikNCj4+ICANCj4+ICAJa3JlZl9pbml0KCZwc2Rldi0+a3JlZik7DQo+PiAgCXNwaW5fbG9j
a19pbml0KCZwc2Rldi0+bG9jayk7DQo+PiArI2lmZGVmIENPTkZJR19BQ1BJDQo+PiArCXBzZGV2
LT5nc2kgPSAtMTsNCj4+ICsjZW5kaWYNCj4+ICANCj4+ICAJcmV0dXJuIHBzZGV2Ow0KPj4gIH0N
Cj4+IEBAIC0yMjAsNiArMjI2LDI1IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RldiAqcGNpc3R1Yl9k
ZXZpY2VfZ2V0X3BjaV9kZXYoc3RydWN0IHhlbl9wY2lia19kZXZpY2UgKnBkZXYsDQo+PiAgCXJl
dHVybiBwY2lfZGV2Ow0KPj4gIH0NCj4+ICANCj4+ICsjaWZkZWYgQ09ORklHX0FDUEkNCj4+ICtp
bnQgcGNpc3R1Yl9nZXRfZ3NpX2Zyb21fc2JkZih1bnNpZ25lZCBpbnQgc2JkZikNCj4+ICt7DQo+
PiArCXN0cnVjdCBwY2lzdHViX2RldmljZSAqcHNkZXY7DQo+PiArCWludCBkb21haW4gPSBzYmRm
ID4+IDE2Ow0KPj4gKwlpbnQgYnVzID0gKHNiZGYgPj4gOCkgJiAweGZmOw0KPj4gKwlpbnQgc2xv
dCA9IChzYmRmID4+IDMpICYgMHgxZjsNCj4+ICsJaW50IGZ1bmMgPSBzYmRmICYgMHg3Ow0KPiAN
Cj4geW91IGNhbiB1c2UgUENJX0RFVkZOIFBDSV9TTE9UIFBDSV9GVU5DIHBjaV9kb21haW5fbnIg
aW5zdGVhZCBvZiBvcGVuDQo+IGNvZGluZy4NClRoYW5rcywgd2lsbCBjaGFuZ2UgdG8gdXNlIHRo
ZXNlIGluIG5leHQgdmVyc2lvbi4NCkJ1dCBwY2lfZG9tYWluX25yIHJlcXVpcmVzIHBhc3Npbmcg
aW4gcGNpX2Rldi4NCldpbGwgY2hhbmdlIGxpa2U6DQoJaW50IGRvbWFpbiA9IChzYmRmID4+IDE2
KSAmIDB4ZmZmZjsNCglpbnQgYnVzID0gUENJX0JVU19OVU0oc2JkZik7DQoJaW50IHNsb3QgPSBQ
Q0lfU0xPVChzYmRmKTsNCglpbnQgZnVuYyA9IFBDSV9GVU5DKHNiZGYpOw0KDQo+IA0KPiANCj4+
ICsNCj4+ICsJcHNkZXYgPSBwY2lzdHViX2RldmljZV9maW5kKGRvbWFpbiwgYnVzLCBzbG90LCBm
dW5jKTsNCj4+ICsNCj4+ICsJaWYgKCFwc2RldikNCj4+ICsJCXJldHVybiAtMTsNCj4+ICsNCj4+
ICsJcmV0dXJuIHBzZGV2LT5nc2k7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKHBjaXN0
dWJfZ2V0X2dzaV9mcm9tX3NiZGYpOw0KPj4gKyNlbmRpZg0KPj4gKw0KPj4gIHN0cnVjdCBwY2lf
ZGV2ICpwY2lzdHViX2dldF9wY2lfZGV2X2J5X3Nsb3Qoc3RydWN0IHhlbl9wY2lia19kZXZpY2Ug
KnBkZXYsDQo+PiAgCQkJCQkgICAgaW50IGRvbWFpbiwgaW50IGJ1cywNCj4+ICAJCQkJCSAgICBp
bnQgc2xvdCwgaW50IGZ1bmMpDQo+PiBAQCAtMzY3LDE0ICszOTIsMjAgQEAgc3RhdGljIGludCBw
Y2lzdHViX21hdGNoKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiAgCXJldHVybiBmb3VuZDsNCj4+
ICB9DQo+PiAgDQo+PiAtc3RhdGljIGludCBwY2lzdHViX2luaXRfZGV2aWNlKHN0cnVjdCBwY2lf
ZGV2ICpkZXYpDQo+PiArc3RhdGljIGludCBwY2lzdHViX2luaXRfZGV2aWNlKHN0cnVjdCBwY2lz
dHViX2RldmljZSAqcHNkZXYpDQo+PiAgew0KPj4gIAlzdHJ1Y3QgeGVuX3BjaWJrX2Rldl9kYXRh
ICpkZXZfZGF0YTsNCj4+ICsJc3RydWN0IHBjaV9kZXYgKmRldjsNCj4+ICAjaWZkZWYgQ09ORklH
X0FDUEkNCj4+ICAJaW50IGdzaSwgdHJpZ2dlciwgcG9sYXJpdHk7DQo+PiAgI2VuZGlmDQo+PiAg
CWludCBlcnIgPSAwOw0KPj4gIA0KPj4gKwlpZiAoIXBzZGV2KQ0KPj4gKwkJcmV0dXJuIC1FSU5W
QUw7DQo+PiArDQo+PiArCWRldiA9IHBzZGV2LT5kZXY7DQo+PiArDQo+PiAgCWRldl9kYmcoJmRl
di0+ZGV2LCAiaW5pdGlhbGl6aW5nLi4uXG4iKTsNCj4+ICANCj4+ICAJLyogVGhlIFBDSSBiYWNr
ZW5kIGlzIG5vdCBpbnRlbmRlZCB0byBiZSBhIG1vZHVsZSAob3IgdG8gd29yayB3aXRoDQo+PiBA
QCAtNDQ4LDYgKzQ3OSw3IEBAIHN0YXRpYyBpbnQgcGNpc3R1Yl9pbml0X2RldmljZShzdHJ1Y3Qg
cGNpX2RldiAqZGV2KQ0KPj4gIAkJZGV2X2VycigmZGV2LT5kZXYsICJGYWlsIHRvIGdldCBnc2kg
aW5mbyFcbiIpOw0KPj4gIAkJZ290byBjb25maWdfcmVsZWFzZTsNCj4+ICAJfQ0KPj4gKwlwc2Rl
di0+Z3NpID0gZ3NpOw0KPj4gIA0KPj4gIAlpZiAoeGVuX2luaXRpYWxfZG9tYWluKCkgJiYgeGVu
X3B2aF9kb21haW4oKSkgew0KPj4gIAkJZXJyID0geGVuX3B2aF9zZXR1cF9nc2koZ3NpLCB0cmln
Z2VyLCBwb2xhcml0eSk7DQo+PiBAQCAtNDk1LDcgKzUyNyw3IEBAIHN0YXRpYyBpbnQgX19pbml0
IHBjaXN0dWJfaW5pdF9kZXZpY2VzX2xhdGUodm9pZCkNCj4+ICANCj4+ICAJCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJnBjaXN0dWJfZGV2aWNlc19sb2NrLCBmbGFncyk7DQo+PiAgDQo+PiAtCQll
cnIgPSBwY2lzdHViX2luaXRfZGV2aWNlKHBzZGV2LT5kZXYpOw0KPj4gKwkJZXJyID0gcGNpc3R1
Yl9pbml0X2RldmljZShwc2Rldik7DQo+PiAgCQlpZiAoZXJyKSB7DQo+PiAgCQkJZGV2X2Vycigm
cHNkZXYtPmRldi0+ZGV2LA0KPj4gIAkJCQkiZXJyb3IgJWQgaW5pdGlhbGl6aW5nIGRldmljZVxu
IiwgZXJyKTsNCj4+IEBAIC01NjUsNyArNTk3LDcgQEAgc3RhdGljIGludCBwY2lzdHViX3NlaXpl
KHN0cnVjdCBwY2lfZGV2ICpkZXYsDQo+PiAgCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwY2lz
dHViX2RldmljZXNfbG9jaywgZmxhZ3MpOw0KPj4gIA0KPj4gIAkJLyogZG9uJ3Qgd2FudCBpcnFz
IGRpc2FibGVkIHdoZW4gY2FsbGluZyBwY2lzdHViX2luaXRfZGV2aWNlICovDQo+PiAtCQllcnIg
PSBwY2lzdHViX2luaXRfZGV2aWNlKHBzZGV2LT5kZXYpOw0KPj4gKwkJZXJyID0gcGNpc3R1Yl9p
bml0X2RldmljZShwc2Rldik7DQo+PiAgDQo+PiAgCQlzcGluX2xvY2tfaXJxc2F2ZSgmcGNpc3R1
Yl9kZXZpY2VzX2xvY2ssIGZsYWdzKTsNCj4+ICANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vh
cGkveGVuL3ByaXZjbWQuaCBiL2luY2x1ZGUvdWFwaS94ZW4vcHJpdmNtZC5oDQo+PiBpbmRleCA4
YjhjNWQxNDIwZmUuLjIyMGU3NjcwYTExMyAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvdWFwaS94
ZW4vcHJpdmNtZC5oDQo+PiArKysgYi9pbmNsdWRlL3VhcGkveGVuL3ByaXZjbWQuaA0KPj4gQEAg
LTEyNiw2ICsxMjYsMTEgQEAgc3RydWN0IHByaXZjbWRfaW9ldmVudGZkIHsNCj4+ICAJX191OCBw
YWRbMl07DQo+PiAgfTsNCj4+ICANCj4+ICtzdHJ1Y3QgcHJpdmNtZF9nc2lfZnJvbV9kZXYgew0K
Pj4gKwlfX3UzMiBzYmRmOw0KPj4gKwlpbnQgZ3NpOw0KPj4gK307DQo+PiArDQo+PiAgLyoNCj4+
ICAgKiBAY21kOiBJT0NUTF9QUklWQ01EX0hZUEVSQ0FMTA0KPj4gICAqIEBhcmc6ICZwcml2Y21k
X2h5cGVyY2FsbF90DQo+PiBAQCAtMTU3LDUgKzE2Miw3IEBAIHN0cnVjdCBwcml2Y21kX2lvZXZl
bnRmZCB7DQo+PiAgCV9JT1coJ1AnLCA4LCBzdHJ1Y3QgcHJpdmNtZF9pcnFmZCkNCj4+ICAjZGVm
aW5lIElPQ1RMX1BSSVZDTURfSU9FVkVOVEZECQkJCQlcDQo+PiAgCV9JT1coJ1AnLCA5LCBzdHJ1
Y3QgcHJpdmNtZF9pb2V2ZW50ZmQpDQo+PiArI2RlZmluZSBJT0NUTF9QUklWQ01EX0dTSV9GUk9N
X0RFVgkJCQlcDQo+PiArCV9JT0MoX0lPQ19OT05FLCAnUCcsIDEwLCBzaXplb2Yoc3RydWN0IHBy
aXZjbWRfZ3NpX2Zyb21fZGV2KSkNCj4+ICANCj4+ICAjZW5kaWYgLyogX19MSU5VWF9QVUJMSUNf
UFJJVkNNRF9IX18gKi8NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3hlbi9hY3BpLmggYi9pbmNs
dWRlL3hlbi9hY3BpLmgNCj4+IGluZGV4IDliNTAwMjcxMTNmMy4uMGJmNWY0ODg0NDU2IDEwMDY0
NA0KPj4gLS0tIGEvaW5jbHVkZS94ZW4vYWNwaS5oDQo+PiArKysgYi9pbmNsdWRlL3hlbi9hY3Bp
LmgNCj4+IEBAIC04Myw0ICs4Myw2IEBAIGludCB4ZW5fYWNwaV9nZXRfZ3NpX2luZm8oc3RydWN0
IHBjaV9kZXYgKmRldiwNCj4+ICAJCQkJCQkgIGludCAqZ3NpX291dCwNCj4+ICAJCQkJCQkgIGlu
dCAqdHJpZ2dlcl9vdXQsDQo+PiAgCQkJCQkJICBpbnQgKnBvbGFyaXR5X291dCk7DQo+PiArDQo+
PiAraW50IHBjaXN0dWJfZ2V0X2dzaV9mcm9tX3NiZGYodW5zaWduZWQgaW50IHNiZGYpOw0KPj4g
ICNlbmRpZgkvKiBfWEVOX0FDUElfSCAqLw0KPj4gLS0gDQo+PiAyLjM0LjENCj4+DQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=

