Return-Path: <linux-pci+bounces-12068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858B895C4E4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 07:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA0E286312
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 05:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5B4C62B;
	Fri, 23 Aug 2024 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UUKCoWkp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4C2C190;
	Fri, 23 Aug 2024 05:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724391010; cv=fail; b=gm/dLGB5EORBUcXdK9MLdjr+CKR4YvclrLfvzW3aQzUj1I4V06xibUBZRyZLD063DJOuz6bVDzDtlL124kRg478OSSDqwPVmTUE1ticbCRJoeZgBf/42+6ll6be+a6RcwEpMz4FP5VUVPKO0Y9/KgOcIgSPJmBBiHnNsC68W2Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724391010; c=relaxed/simple;
	bh=E3rwdrTWl7n8PUMs6uM4p/afiRmwiTt81dv2/PBAJgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HxR55MWeppfq6O5xExYuo8ynxA/0f2kSrlwX1QR3flnFaGH0yyf9XpfKJ9lClY8p2IRWTT4U8YpwgFbXqEz9qCs/OXa2Dt7m/mv/EXojqGt5urarLHHxybcAIvwDplwzkzQln0iINX3fpxsqQJoUDbbJVAdvzBRKmNU0xuSW/wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UUKCoWkp; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MLLfRp015606;
	Thu, 22 Aug 2024 22:29:52 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41650uuxpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 22:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cu3PWTSrQq26ttmpZYs9uLF6ttE5fHpYH4oZ1AfkfSI+04E+TZwrdooVl2LGT0obfQIPbsa7NngGzZBmm77JqHPhu1OTsPemKRsRSC4V70DBkvgmdO8hveiHNopgtCkz2QPHUf6/W4iCqaHUgThZJCxp3y6H6VHoWsO/ffgHYgiQmWO7jtH1/hX1Ni0nQoOhpX9ist5FgmuwM857k+X3LoX+aC77DlNBQMvbXMcOHLotMI936PJxDUmH+smMco2tBfUcfmF9Gsiv7GTxUQ9jGJV/ZaQ68dM4uIJ/oBq9epMhbccaPMr3eYRGj+Ta6/EfTTkletENIboqhiRQ8IMGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3rwdrTWl7n8PUMs6uM4p/afiRmwiTt81dv2/PBAJgQ=;
 b=fiuh0XKG79Xn5SIeU8x9UowKUjJcirAYfk6G/yleeebP1LJjpofmSBA8fVGOqad04URvkVycZI11GW6E/qxPxBnPEQPH4o0WEKOub4kc6Qx0Fd3BAHZH0ByoXztM6JMixxU7NVdw8HxJu53C7vMay1za7ovhpzdAja2J9I0dnMOONvYin9Uw3jK75SHZoBinZqNTN2MECPPEMOFKVGdf65Yk5FaF45owvxgV2h+9uUrYJwgdGrxoTUQmuYgm++0vy7Rl2xEzi1+cY00NBG8OBTEWE/e1CbeIuYc1rlYcprydgKhRaWQnHhQwJDaLEeRn+wBbkPFiJjkaokzOHM9m7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3rwdrTWl7n8PUMs6uM4p/afiRmwiTt81dv2/PBAJgQ=;
 b=UUKCoWkpDCJk44zL3q3irlu3QI9vXyPED8B5x6SgBSGRpQwIFh9QXXRqQ3ftDbXnyI+gkDEFEL0Kvxyvxm1UCI7LghJtVH92yGlMTi4u6jzl1E+JhBrX1D8TxgkcpcdSBUzAUppR1b9z9jBwzfy/RKocXMCcBMjigJdsmz8argQ=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by CH3PR18MB5512.namprd18.prod.outlook.com (2603:10b6:610:15d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 05:29:46 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 05:29:46 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        D Scott Phillips
	<scott@os.amperecomputing.com>,
        Philipp Stanner <pstanner@redhat.com>
Subject: RE: [PATCH] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Index: AQHa9KKDy6MeBzMkf0aF99RoTKPmg7I0UD3w
Date: Fri, 23 Aug 2024 05:29:46 +0000
Message-ID:
 <PH0PR18MB44258270BCAF802C8B3398B5D9882@PH0PR18MB4425.namprd18.prod.outlook.com>
References: <20240820152734.642533-1-sthotton@marvell.com>
 <20240821122404.00001a71@Huawei.com>
 <PH0PR18MB4425BE8D3F5F9C5114D8C289D98F2@PH0PR18MB4425.namprd18.prod.outlook.com>
In-Reply-To:
 <PH0PR18MB4425BE8D3F5F9C5114D8C289D98F2@PH0PR18MB4425.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|CH3PR18MB5512:EE_
x-ms-office365-filtering-correlation-id: 901f7973-83a3-4eff-fea7-08dcc334999b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmZqNWlhcGVGTWxDczkzSTNyc3ZheTh2YmNNV2x2Q3lwdnczVDluT2tUN2FP?=
 =?utf-8?B?ZXJHQlNkcnU2TVFLcGhkSDBSemovRU1ad3RUeDZYYWlhQ2g1eWtweTVwYjhF?=
 =?utf-8?B?VHVDSEh2WEs0SkF6VjNpM0RHRnBQTUJXOTlKYkFnMi9vZDNSRE55THh4anRy?=
 =?utf-8?B?djArSlhEc3lIcjdYQ0VlTGFiNFNXbGdTaTk2bGhNRFl1UFpjQzZWakgrU3Br?=
 =?utf-8?B?N211OWFkSGFiQmZBTmFUeFJ0OVJaL0gvTDV0bndQZzBWN1F0cFZPUkR1MkJX?=
 =?utf-8?B?Qk94V2J6VUs4OFlyU0M4aXlMT2g0bEFvdjhaOU96V0YzdU1XeUs4V0JISFdt?=
 =?utf-8?B?cDNGRXVYRFBtdWIvNUU3OUNrZkhyWWFmTCtDd1RNSlJ6T0hFaEYyUzlkbGlF?=
 =?utf-8?B?OFVjL0ZrSUpFT1Q5SzhqWmIxYVVzdnZod3lkZExaZWpwWE5uTHRwR3RoZUlM?=
 =?utf-8?B?aFIrTUFVTzNOS2tnNlZiY1oxM1ZnazRMOUVLbEJCUDdEZUI2Q2pYRzRYbStm?=
 =?utf-8?B?N1FJSDZuWGpweGNybG5TcGVrZXVFYkMvcnZRQ29sVjA1bkRPckpSdHFxUUZ4?=
 =?utf-8?B?SHdSYVZMM3hseExlamRnNmVBMW9Ocm85Qk5xemNML082L2lFbUxCN2xGejV1?=
 =?utf-8?B?VUZXRFZ3OWxVejNrSzBNb0VGVEJyNkhYaXRvcUFuNzhhQ1lHNFJmYjhUQlhS?=
 =?utf-8?B?YTFydlNNeEZSWkhRU2lyRXBwdm4xdis3WS9PRFdzVmFYNUx5RGNKUE1ESzhH?=
 =?utf-8?B?U3FKczR4dm1NS2FtUVY2MnBOZVlvRWU5d2l5Y0ZoaXhQYllTWWIrYlh6Z1Ur?=
 =?utf-8?B?N2pVeUQrSWFDalIxa2FFSnpnYW5sZHIvUHpiOCtmV2IrRUlabDQ1L1JNWHNM?=
 =?utf-8?B?bysxZHhWalFZU28xSjdFQldETHBVZ0p2Z3p2VzJzOURmemp1SkdsRUcwa1pj?=
 =?utf-8?B?WlJmK0JLWTQ1bTRPRm1iSkJFZkFOS3R4UlV0bDN5NEltNHhINCtNeHg4Nzli?=
 =?utf-8?B?OVU3WHN3OEhkWVhkWWdBdStuUU1KRTVWdHBmVDhFZ1Vva0tUMGlneHJBcXpB?=
 =?utf-8?B?dC96WTRwdnE2TURsVG1aMmcwcyt2Q0F6MlFDbHVjbW53OGJTeW9XNmhWMkpF?=
 =?utf-8?B?Z0NmdWNOVTN3WWxsUU91US9Zd0NBNzdKZnZWMVlRZUV4SmxYRWg5UHhVYWJZ?=
 =?utf-8?B?K2hEUXNKM1Y5WFVHV0xPRTZpUXNLSGYvKzlrN0FoL21LU1BzalRSTDZjbzNy?=
 =?utf-8?B?aUVuUzZVbkhSanRwekV1MC84SXNRMEs2Y0NxMGlsSkN5L0J0RFFBQ1JUZTE0?=
 =?utf-8?B?SUJSYXZBV1Fsc1dnRDJUbkpWWWkyN01odDZzZm5QYUJydzd3MmtNWS8ycHho?=
 =?utf-8?B?ZHRDN1h0UjQ0a09MZGE5VUhSR2JjbndYS1RSYm5ZK3l5eE9vV3VjQVRWUUdJ?=
 =?utf-8?B?Q1p0T3kvNVNFbSt3NHlWMFhXeXVkUzgveWFJY3pnaEhuOFE3dUhGb2Y2Z0Ey?=
 =?utf-8?B?RjZKaUdZNHV4OUZmNFk5b1BWZlEySDVJSHJRNzhBeFBvbGNPTU5qaUUvTm9j?=
 =?utf-8?B?VlNrS3FJMmNEakJ4dXdOS3k3bVR0b3A3S3NOcmlaZXduVDBmVFhxKys3WGh0?=
 =?utf-8?B?NGRMeVFOOG1QZzRMUVdoNXIwYkttK1lvOERRUzI1OENMUHVxOVM2ME5lOXZQ?=
 =?utf-8?B?dnJKZHhFM1k3a21OQjRFNWxkUFE5NGUwaEJWMG5GSGJMb3VQbUczd1dMY0lv?=
 =?utf-8?B?akJvVHZSME9xZEFvVVFlbjNuTHNjZHRpbnFsSEJoK0FnTEpJRDF1T3lyRDJ4?=
 =?utf-8?B?VmgzNGdhSTN2Yk9kUDI1eEJHL2VveFBKQ2NaZzB4RVE4d0RWK3o2bzBSaEN6?=
 =?utf-8?B?WTlyYXk5Vzk1cnlYR0pqdFhJTE9sdGZ4elptWXp2Z28wQUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWxGSHdOMEMzTjVzM1dubU9VRmkyUmZQZUhwcWc2TXNaaWtWTnhGeUJlVTdR?=
 =?utf-8?B?cEpxV21UcjI4bDVMOWNleVQwcHl4Zi9BYXpVYkhDYnFmaWpyLzZrcTJkVjFk?=
 =?utf-8?B?ZkRiSEY0YlFsR0hTQjk3UDlDY05GU3hOWGsyTTRNbkF0ak1rSFBpM3lHZzFn?=
 =?utf-8?B?Qmt6Y3BMMk5NVitpekFXcEJERG9Dd05Fblk2eXZacEYwM1AwRmFEZXNPeHFY?=
 =?utf-8?B?MWx2ZE1NNE5jRjl0VSswb3hQUjFvajM4U3luK0VEWmRHSnd2aU9IQk95VXRt?=
 =?utf-8?B?QnZMWnFwNDBQTGFvYnpsMDJEZFhKK0ZZSnRDUjVwMG9ZelVjanJDck1TNUZG?=
 =?utf-8?B?dmhWN0lISGNRWnZKRWNyeHRHQ3VDMlVBMUZ5ZEpRTGF0NGVUVk5mdFB2OEEr?=
 =?utf-8?B?Q0lQTGQxV0lseThzQVBXMURwMmZIaW1sdm1WUmdOMngxUEhmZmM1OStGQTI5?=
 =?utf-8?B?QjlpZ0p0NHZTNXNzRmI2bm84a0l4QmRwWjErUFNPY1BsZWhJeUZueXI3TzFB?=
 =?utf-8?B?MnhZS1N4YUFZR2lETVFQZnpsRmRZLzlmUytoK0FzWUp2L2NFcUxXN0UvdVBP?=
 =?utf-8?B?MzFWL1VuODY4MTBsbDJyZVV2MzBDcHA4Q3ZBUWFlSVd1NUlMd2l3R21uR0RV?=
 =?utf-8?B?ZjdxMWpjelBUdjlqY2lGZlZDVG5yWS9sNmE4YWd5eWVVQkJ0VlhWZVhhcWF6?=
 =?utf-8?B?Z3Judk5PM0E4aGpCVlp1SnhFR3lZSm5ZeG9BaUE2akpxQlRWZGNTTForUmNy?=
 =?utf-8?B?Rm56VTk2aitRUzg4OHBmWFFhbnBlTjcvT0VBYmQ3R3VsbXlaMEYvWDdKNktw?=
 =?utf-8?B?dTlRU3hYekxLWWY1WThDUktaN1kwOTRSa0ZWUDBYWi9kWDFNajh6ek1VUzFx?=
 =?utf-8?B?Z1plUFZQT3NUN2R1ZDMrNi9RbnhYRlFEbWgwWWZuOE9LTjlWUDl5OVFyTE16?=
 =?utf-8?B?N2hnd0kyVXdLSDhkazluOGF3UlJaS1NKTGJpQmY5SkJHNFNBYVJJTXpmbkha?=
 =?utf-8?B?TnRCbnBrbzV0REs5eVVKV0JDNXJKaHhQQUlFeTVmRm94K0FuYitQaS9RMGZR?=
 =?utf-8?B?UHB0TThsSGprWGhlOGhldGpCQWp4a281V1pzMC9uN056U2FmQlE0N1lXQnpu?=
 =?utf-8?B?eVFKdmRnZWRkaDZVUHZsZEJDSXNNK09MRTV1cEZyZ0hEV1dHUGNBTGRBQ00x?=
 =?utf-8?B?UElTUUNmUENLWm1SZ0xKVTUvTm1kRDNGRlE3MVdEWnpzaDR1cFVEd2tFemRY?=
 =?utf-8?B?ZW91YUU1dElRY1RYVTRuOHVhamx5V0V5Z2IxWlZHcXhuL2FJSi9Edkt4UDFw?=
 =?utf-8?B?eDc2R09ob2tmOVdDTWpIV1I0Y1RCYUZzL0I0bDBGeFduODIwYXVOSWZ3emJz?=
 =?utf-8?B?MmE3UFV1TDFyaEhYSVhPVUFqUWxTRkROWHJpcGVMaFZuUStTRFpoWlZQNE96?=
 =?utf-8?B?T2VpYjBnejUrYk8xMFMxWjdOUkhaVWQwZnlLT2dLdWExdmFnZ2Q1SjU2YjhS?=
 =?utf-8?B?OFpLTEE0Z1R2ajJSa3RaWC9UbGg1aEVWUmJEa1ZWSjllNnJ1MVphU3RCUU4w?=
 =?utf-8?B?S1dydC85UU5RU1JsM1Nqbk8wN010WXdaVlU3akJQendFNFZvM3c5Mng5bTk5?=
 =?utf-8?B?R004ZXhmMHNXQ2h5blljUE9IWC9pZThKNjEwMDdkUzJ0dmQxclNSSHl2NDlp?=
 =?utf-8?B?UklmSFRtRW1sZjlvUUM3VE1IenRsTVJpOEptSUNKQUZCc0xRRmlQYy9jMFVq?=
 =?utf-8?B?QmlJZnZKNVU5bTF3aWdFUWRENHNjU2JOM29teU1qNG8rL3B5NDNaUTlrbk9B?=
 =?utf-8?B?SllkcEtwY1ZYMWg3LzNCWlJHOVkvS2hwTEhCKzU2aEEwZ2hPU1BqYWtKV1Bi?=
 =?utf-8?B?STRHRHoyNUxudTNWa0tYdGVzNjhPLzQ1Y0dmeW43SHgxN0ViUzFrT1Jtb3Bu?=
 =?utf-8?B?SERKbFVvOGF4UXpDNWlOMTd3bVhiWnV5NTFsUjVjYzFOd1JaaFZ3YkZrNTJq?=
 =?utf-8?B?YmE1MDZhV0FzUERQVWxtSnZ6YzdXaldVMzliM0xtMEZMWmhrYXhqWkErOUhS?=
 =?utf-8?B?WUVWc0NYUnYxSE5KK3FlSTgxV2lWcTJmc2E4WVByc2NZYXpMOXM5eTRsWDFB?=
 =?utf-8?Q?FcabdcVsqTrfPRTbzmE03sfMi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901f7973-83a3-4eff-fea7-08dcc334999b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 05:29:46.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xN44TOVed6ckiXHpgyhywGIl/o8sUIR7aqwdh6/6f4AFrFn8/7+I3S/VQdi17yyO/Cjt4IDs7B+xXFgFvpa9oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB5512
X-Proofpoint-GUID: grkKdHT3lLXJC5idMgSyVZVO37bc3VY_
X-Proofpoint-ORIG-GUID: grkKdHT3lLXJC5idMgSyVZVO37bc3VY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_02,2024-08-22_01,2024-05-17_01

Pj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIFBDSSBob3RwbHVnIGNvbnRyb2xsZXIgZHJpdmVy
IGZvciB0aGUgT0NURU9ODQo+Pj4gUENJZSBkZXZpY2UsIGEgbXVsdGktZnVuY3Rpb24gUENJZSBk
ZXZpY2Ugd2hlcmUgdGhlIGZpcnN0IGZ1bmN0aW9uIGFjdHMNCj4+PiBhcyBhIGhvdHBsdWcgY29u
dHJvbGxlci4gSXQgaXMgZXF1aXBwZWQgd2l0aCBNU0kteCBpbnRlcnJ1cHRzIHRvIG5vdGlmeQ0K
Pj4+IHRoZSBob3N0IG9mIGhvdHBsdWcgZXZlbnRzIGZyb20gdGhlIE9DVEVPTiBmaXJtd2FyZS4N
Cj4+Pg0KPj4+IFRoZSBkcml2ZXIgZmFjaWxpdGF0ZXMgdGhlIGhvdHBsdWdnaW5nIG9mIG5vbi1j
b250cm9sbGVyIGZ1bmN0aW9ucw0KPj4+IHdpdGhpbiB0aGUgc2FtZSBkZXZpY2UuIER1cmluZyBw
cm9iZSwgbm9uLWNvbnRyb2xsZXIgZnVuY3Rpb25zIGFyZQ0KPj4+IHJlbW92ZWQgYW5kIHJlZ2lz
dGVyZWQgYXMgUENJIGhvdHBsdWcgc2xvdHMuIFRoZSBzbG90cyBhcmUgYWRkZWQgYmFjaw0KPj4+
IG9ubHkgdXBvbiByZXF1ZXN0IGZyb20gdGhlIGRldmljZSBmaXJtd2FyZS4gVGhlIGRyaXZlciBh
bHNvIGFsbG93cyB0aGUNCj4+PiBlbmFibGluZyBhbmQgZGlzYWJsaW5nIG9mIHRoZSBzbG90cyB2
aWEgc3lzZnMgc2xvdCBlbnRyaWVzLCBwcm92aWRlZCBieQ0KPj4+IHRoZSBQQ0kgaG90cGx1ZyBm
cmFtZXdvcmsuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGlqaXRoIFRob3R0b24gPHN0aG90
dG9uQG1hcnZlbGwuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZhbXNpIEF0dHVudXJ1IDx2YXR0
dW51cnVAbWFydmVsbC5jb20+DQo+Pkkgd2FzIGN1cmlvdXMsIHNvIGRyaXZlIGJ5IHJldmlldy4N
Cj4+DQo+PldoYXQgd2FzIFZhbXNpJ3MgaW52b2x2ZW1lbnQ/ICBHaXZlbiBTaGlqaXRoIHNlbnQg
dGhpcw0KPj5JJ2QgZ3Vlc3MgY28gZGV2ZWxvcGVyPyAgSW4gd2hpY2ggQ28tZGV2ZWxvcGVkLWJ5
IHRhZw0KPj5zaG91bGQgYmUgdXNlZC4NCj4+DQouLi4NCj4+PiArfQ0KPj4+ICsNCj4+PiArc3Rh
dGljIGludCBvY3RlcF9ocF9jb250cm9sbGVyX3NldHVwKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBz
dHJ1Y3QNCj4+b2N0ZXBfaHBfY29udHJvbGxlciAqaHBfY3RybCkNCj4+PiArew0KPj4+ICsJc3Ry
dWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4+PiArCWludCByZXQ7DQo+Pj4gKw0KPj4+
ICsJcmV0ID0gcGNpbV9lbmFibGVfZGV2aWNlKHBkZXYpOw0KPj4+ICsJaWYgKHJldCkgew0KPj4+
ICsJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBQQ0kgZGV2aWNlXG4iKTsNCj4+T25s
eSBjYWxsZWQgZnJvbSBwcm9iZSwgc28NCj4+CQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgpDQo+Pg0K
Pj4+ICsJCXJldHVybiByZXQ7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICsJcmV0ID0gcGNpbV9pb21h
cF9yZWdpb25zKHBkZXYsIEJJVCgwKSwgT0NURVBfSFBfRFJWX05BTUUpOw0KPj5HaXZlbiB0aGVy
ZSBpcyBhIHBhdGNoIG9uIGxpc3QgZGVwcmVjYXRpbmcgdGhpcywgcmVjb25zaWRlci4NCj4+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDgwNzA4MzAxOC44NzM0LTItDQo+cHN0YW5u
ZXJAcmVkaGF0LmNvbS8NCj4+K0NDIFBoaWxpcHANCj4+DQo+DQo+T2theS4gVGhlIEFQSSBpcyBh
dmFpbGFibGUgaW4gb3JpZ2luL2RldnJlcyBicmFuY2guICBXaWxsIHJlYmFzZSBvbiB0b3Agb2Yg
aXQuDQo+DQoNCkkgZm9yZ290IGFib3V0IHRoZSBrZXJuZWwgdGVzdCByb2JvdC4NCkknbGwgaG9s
ZCBvZmYgb24gbWFraW5nIHRoaXMgY2hhbmdlIHVudGlsIHRoZSBwYXRjaCBpcyBtZXJnZWQgaW50
byBwY2kvbmV4dC4NCg0KDQo=

