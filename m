Return-Path: <linux-pci+bounces-34358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8456B2D5E5
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96037A007A3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B682D8DCF;
	Wed, 20 Aug 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PH2gVUHT";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BAIF3nLO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886072D8DB1;
	Wed, 20 Aug 2025 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677697; cv=fail; b=j74JvkgL+tSviU6LhFmzQkeyn7ptuBTh29MmM3aCqcu1Lckyx4Ihx9mLDmyMiHiP6I73L0zRZwa7gZle/+K6fySXMKxLj9toGzWmioUMgt2nwRU0XeMovDE4pzJQ1Ge+gMtV1sUyGsrzVQocBWZO6Fbtw/XHtA7Fig5A6UhtMoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677697; c=relaxed/simple;
	bh=7y4wuzAbld5hdU9nxT8kF9hliqq6xSaKOfcJfCDAEQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QxdZqfIpxirwX27i5+o5C4fArgf5EJFY1rIF2MTWp1JSQjv46GQfpb8aFcKLIrYrxT0ADNWgWti4ljV9J3PdlFW9NIFYVKMLCYYlz8Vur9Ng0NK84eNnXgIrUfhmL/VOFhDvsK5O+/t9H0OZv1cM2v8DPuRpE1swv/W9WyQRC84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=PH2gVUHT; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=BAIF3nLO; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K70Hhm009315;
	Wed, 20 Aug 2025 01:14:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=7y4wuzAbld5hdU9nxT8kF9hliqq6xSaKOfcJfCDAEQY=; b=PH2gVUHTRwX/
	dFa4ZadoO+Ok/V61+QYocdq6V1UF6IYtlRhA2XrpaYVADMjIKayTUgFG65nOZipc
	5nw7YhAwddjqE+7WzVLCbEQAdNJJEGec/rB78qdLOiSt+8uC32S7TcBqqPR9vRP9
	UNGyHvVkBcAoYQPVL/Mil8BBku3PHLgc6dT6lTPZKHfsgaL2yC41OuSqmTSwOySo
	FA/KI0DKiXmxeK7AG/K+HYMQ0PPRyAasKlYBh2kz//vLi5fHK14G55hxx+FP5801
	zaV8H5xU4OmpF2QhFqtCPiOjvPFHchPWetHhYl1mRVXDSAl6Me9MisKWcrCt9TQq
	fUsfsZ8Zzw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 48n0t1t7m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 01:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiwzWOFRUws4dhRxZSCaknL3i7EPeU6yCiuHINHxBx5jjAqtLI/LT0Hx5IvUizhWhlowkQ402+Chy03QK12k6tAH7JfWFmFHOAT8j51YmqddGSFo1rMHEb2cBpxLEBlP/h3gdKwLUWv1audwsTFoYZQWDSMzoGR0Ye75OyMPPnkIKqTqBx0InSPj5flJmIIKQ+nOjX7F87cYHV/UZR2QUEmyBEHWo3rzE+qWY1XqC91ABqnFcPVuOD6Tt5iKEHm3tXzL+oubiMpPyKi9YknmzmCW7CNnOCSbUwBppUDRXBWKz2ELuNygFuXeUAKMGbU2kmM5FRRVXVDv2HLeYHGkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y4wuzAbld5hdU9nxT8kF9hliqq6xSaKOfcJfCDAEQY=;
 b=XJl7QyEJXwe2wF20tgoEP5OtoGfBoQRIQGlA5rGcsuL8Rz4K5a2aBASrklnE6CnLCn/KfItPkbWhSpNM+xJ4hK0Dtf6W2PUW1u8Xi3gmS7pWVutr9W5wfyNUmBmoAmMSfJ8w0np+z4IqOR5lbagX+SaNBVomATKLH/QHLqTfNMxGsYmYcD0jMgTKHA3aGDYW19zkZu10MNKXcuh2b1eZJ95aT0qkJZWpQDxu5u+OQ7BLjCk0kDdltIPIJZk61V4lgXnrmUbK/RgEH1TZpViR1Q/l7r/vjT53K4lfj0t0j2Ps4EcArecaKcGJXtLinsMyICrh0Nu5dA14t3jmOMk5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y4wuzAbld5hdU9nxT8kF9hliqq6xSaKOfcJfCDAEQY=;
 b=BAIF3nLOeHUeY1KNXL3oiiqpkIb/hCS9KTdYgJ/EqsNfqRMM/HYkvzC82RS4k7g4tg+Rk4mIGu8xStJ32J3Fd0eiHfbvwbwgzz2eDi4vk8Z466XA5fo91FuMbPynSl6sNPvG1eFtVdU5zc9Ofr2EuRebtI6lBbVtihnb7s4OTFc=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by DS1PR07MB10732.namprd07.prod.outlook.com
 (2603:10b6:8:205::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:14:22 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05%8]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 08:14:21 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "fugang.duan@cixtech.com" <fugang.duan@cixtech.com>,
        "guoyin.chen@cixtech.com" <guoyin.chen@cixtech.com>,
        "peter.chen@cixtech.com"
	<peter.chen@cixtech.com>,
        "cix-kernel-upstream@cixtech.com"
	<cix-kernel-upstream@cixtech.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 03/15] PCI: cadence: Add register definitions for High
 Perf Architecture (HPA)
Thread-Topic: [PATCH v8 03/15] PCI: cadence: Add register definitions for High
 Perf Architecture (HPA)
Thread-Index: AQHcEQAm2r87BPJ3wEiSrBw6yxpszbRqPYGAgAD0/MA=
Date: Wed, 20 Aug 2025 08:14:21 +0000
Message-ID:
 <CH2PPF4D26F8E1C43579466E57489CD2582A233A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-4-hans.zhang@cixtech.com>
 <ef115fd1-01e9-4d36-9c6d-37ea7516123c@oracle.com>
In-Reply-To: <ef115fd1-01e9-4d36-9c6d-37ea7516123c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|DS1PR07MB10732:EE_
x-ms-office365-filtering-correlation-id: 82c81127-c377-400e-130e-08dddfc19104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFFja29qclZMUGNlN1FkSUkwWDlQVUNHclFnbjBSQUVubEx1UTMwS2hnNXhN?=
 =?utf-8?B?Q2VQMFVHQkNuN1libGs4aGRJZW1wTTlrcWdCNWozeXZ0TGt2S2N5REo3eDZL?=
 =?utf-8?B?VDZFcWxuSzFaUkpnQlBnd0RPcTZEV1ZWNTZYMGJ2YTNpd1pkZTlKTjRjd3M5?=
 =?utf-8?B?TGZnenZlUFJwU1FRaTdhVWRpVmhJemsvQlNEQVZVcjVER0ZZdURpMUM2OUxh?=
 =?utf-8?B?SEMwbjZBNzZDUEdwZStMUkhUS3JtM3pnT3F4UnZkMlBIdUg1NlVOYWtobmNB?=
 =?utf-8?B?VXliNEtJd1JWejBkSFVzakpodUdUSmc5Uys3REkxQnhjcks1V2tmQ1Z2ZXJt?=
 =?utf-8?B?YzlEYjNBSngwdm9ZbHpKc0FtU1FRQkxhQStXQWUzQzZHOTZyUUZhMzFFZ25S?=
 =?utf-8?B?WUVwOGRyemttSFhST2JkTTNrMkd3SjFGcFl6aWlWRXFIVVdkeTNmODlaTmNQ?=
 =?utf-8?B?SXViL1JNNUpFVjJJWnVUQUcrTDZzUXowUVR0SVlLaytZci9uSU9DZVNEbjBX?=
 =?utf-8?B?U1ZleUpjM0o4SFhlTzZQUFZXSWExWk9mcFVBbTFyQ290M2VwMFB0Vld2bFB0?=
 =?utf-8?B?ejRKamVCc2hPQ3hkMENhNDl3NHVZRGdPTTdJRU5sSGJ2ZnRIY09sU29QMkhn?=
 =?utf-8?B?SFR4OUNmdzVzcFdVb3R5R3NyOHY1VjdoQm5HTXc0NzQzQlFFMk5ZeC9QdkJQ?=
 =?utf-8?B?V205U3k0NUZYRFlFdHpVZkpDVEFaOXpsNXBrbWFENTFITEE4OUpGVUxlOHJz?=
 =?utf-8?B?T3JaaTVHZWxiVFNwSU9tMTh4L3VNVE9lWDFqZTErYjhHcTJOMWhPTWFVTWFy?=
 =?utf-8?B?Tjh0RmhRN3RBa0xPY0dmVjg3UFFGK3N5NGJFT21xd2YvczduN2U4cU44aHdR?=
 =?utf-8?B?eU1ZdHllVW1wODgvVUMvaUZYMHh0OFRjaUlidmtVZGs4UGdpUUhJM3BlL0pU?=
 =?utf-8?B?MGNsWHVlRndSWWIxMVJ3UXdHczNNL0ZhTjltd25FY3h2dzhQaEk4NzZlOXQ4?=
 =?utf-8?B?VFdCZ2JVL3l2cTdTVS9QWHptMHYvMnlzcWlSRjc5dWRCSURrNzhtWE1heHN0?=
 =?utf-8?B?TzdwN0FOUmpHSHlBdjdmZnNLTmw2Uk1zdnkvMDduN3hrWEwvSFJuWTRLb3px?=
 =?utf-8?B?Y1RiSEU2bUhFNTdNODdyODEweTU4WHoreVR4SGVEbjUrNFNBRzZENW5PSVFn?=
 =?utf-8?B?eW4ybk4rNzdlZHFueVR6Vks1NjRmaE9YK29PdHVqa1RKNmdDNlhVcVk0ZGZR?=
 =?utf-8?B?cEFCRkl2azdJVExYNCtZbmlVZXBBbTF0ZUtDdGRyUm1kZE1BQjRoSVlVcWVW?=
 =?utf-8?B?ZnBLS0JHZ2Z0TE5US3l4MklRbzFEdUZvUHdXSHBpZlBjcStHemhPRWovbG9T?=
 =?utf-8?B?V0djRWVEd203Zko0YkNaa3dZWldyMzE2enorWXdVd2JsSG14WEZMWk1ic2tr?=
 =?utf-8?B?emxDYWdjWjIvYlg1WVBUTUxzdnNmMVhRQVdWNVhTT3dlVkpEaFlaSzdDbTZH?=
 =?utf-8?B?Zk1vakFncHljQ29wc2dLQzN3eEY1RWlOMGIxME8zNFJCTXFkd3FyS0lQaTl5?=
 =?utf-8?B?NmV1dnBCUm9ZaHJQNHozU1I1ZU1WY1pndkZmMFlTVFNFWUxhSm54TnlCNzVT?=
 =?utf-8?B?RUd5ZXZ2TUI5c3FISjFwc0JqZmFiOWphYk5pZ3VoUlpmUmc5M0Fmbmp4aFFy?=
 =?utf-8?B?L0s1a2N4YS9RY3dHajlSTjE3eVhjeXBUN2k3UmhIWkFlNXdyTGhOT1hVNzJv?=
 =?utf-8?B?NjV5SGFIZzJSZzhYbmx0bTdPYzd2Ymw3U1BrMlAydk40WmI0SWRmMTJ3TTZT?=
 =?utf-8?B?K3BHY2JENy9Wc2tJTFFPSG83UnQrVGI4YTliaHlQd0ZuMTI0Y2prTmdEUS9q?=
 =?utf-8?B?ODNuOU1tWUUrZWxmaXJJb3V2bjRHWVF0OGd1aTlxOWZTZ2dhdVBsMUkxWVFx?=
 =?utf-8?B?dnA0RTFBc0dkbzVSalBwMS9XbzVlQm5sRXVjRkR6UEpMMUIyMGs0VXpqSHl1?=
 =?utf-8?Q?DrCCCYYCghPDC8YCbb8yhRrkTITERw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R01tT3RXOUlIaktCTGtNSnRBc25QdENsRjMvbVhVZFRZY2dxNWIvK2J5SVV1?=
 =?utf-8?B?YzdYeEpFU1lnQTkvdk1XMUwvalRIamluQ3BqVmh1eFVsU3BhWVlnMkRCVnFJ?=
 =?utf-8?B?RDErY21teG52MjJ4NElSckwxSFBjNjh0Y29heVRvUmQvM1hOY0dDQWt2anFn?=
 =?utf-8?B?VCtHYzBmUzYyQVFWUDVzZ055bTJjQi9ZSW92eXp5WDJHQ0ZsNkNaa2t6Mkpa?=
 =?utf-8?B?YXdoS3VJWUVyZEVabHo1d0NBRS8wKzNnaWFEWFM2QkJmcEZFNk5RWlFvV0w5?=
 =?utf-8?B?Tnh2aWl1VENpUmVHeUxjRFNuME5WbjNkUDFOYU9HSHJjaUpsbVZCL1BGS2NJ?=
 =?utf-8?B?WGEwRHdIajUwNGFXYXY3ZFlBcTdCTmlYUXd3TzV6dzM5TTU3Ym1Wa0JRYytX?=
 =?utf-8?B?MHRHdXhNa3V4QkRwVjJIRGg1UkJob3M0cjJ5OFZoMzV5Q1dndGVBOW5oSEQ0?=
 =?utf-8?B?SGROeDI3L1cvUG9qdWhpb3JlSGh2bm00WlJBTTJGcFNNcUc2TEhrMERXdTNm?=
 =?utf-8?B?RUR0N0laZXhwWDF6eUtUdyt3STIyUHpnR1hWMWNjakk0T2RROHFnVmZyVzk3?=
 =?utf-8?B?UmFvNnNDZENoZ1haZmczb1NyRHFQOCtzdEowWURDeWdwS0JtZWtzQ2tWcnJF?=
 =?utf-8?B?dWl0V1NSQ2M2aFV2d0tTMGFhMlVrQUtjazRMU0xJWkZJdWQxbE9hWVBrdWxq?=
 =?utf-8?B?NkV1V3dBY1NjVVowM2k0bDQ5bURyY0lCMmNETEpxcHV4ME9nSjdqNlBiNWE3?=
 =?utf-8?B?V3RHaGFVT2txdUUwR2pXZmFFQkV0eCtMbVpqTDNieXBqTjMyd2JyVWpTTDUw?=
 =?utf-8?B?WXVzaGZlcDg1bGtoRWs5NEhYTUdmQWNudUhwMlRQajNlVXJyeFNvYktxQmFT?=
 =?utf-8?B?NlV2UXlCYWlySmF0MEdTK1VBbzErZ0JoOXowbUlnWjlpa2ZWK0NPcWRDa3JH?=
 =?utf-8?B?LzE0SWNpM0JlS1FDT1pxdnhFYjVPdExrb21aTHhqMlppY1dKNXgxMzNkYTV3?=
 =?utf-8?B?S1FqaVFYdGRHZi8rSEFyTC92Q1dCZzFQd3hSU0c2VGhZQzgrRWprY3A1MXY2?=
 =?utf-8?B?SmxENDhmVjR5QTAvQkVQdFdCWkFSdW9uS2owWENzTVNjUWhCaFk0aTRIVWZI?=
 =?utf-8?B?UytKd2hmYVRKbnVmVnk5YllHSmcrdDZQd1J0NFp0em5NUFFHSHBNVDArZGYy?=
 =?utf-8?B?eGNXQzZxdWJCOU5Ed2RtU0xGS0U5T0Y4S0NHS2lIUEtjQi9xM2Zyd2lTdW1s?=
 =?utf-8?B?Q0JydkpINEpEUHQ2am1GazhxSFExNSs2ZUQwNXk0cHJhOERUTDBjM1ZyeHd0?=
 =?utf-8?B?NDhMcVhmZVdtMWdrVVE3dXRhbHdJc1hWVUxyQURjWGVyM1IrZmoraGNDeW5G?=
 =?utf-8?B?RFFaNFVITThWVUszTmZWSWVLSUZUM3RGVjlFRkdZWGlTWFdPV2ZSZDNGOFNj?=
 =?utf-8?B?enZlL2hia2VETmNCNjBQcmFXTnFMeU9DQ0VKQVEvYWpGenFFOVBCd1Voc1B5?=
 =?utf-8?B?UEFYaDVIVnplNlJDU2JXWmFwUE1mR1NVODZSZkpwRkhIWTYrS2RaSDZ6L3FR?=
 =?utf-8?B?dmJGZ3NDQ3A0ZE9CTGo5b3g1bkJJWVpjdzI5RGptOXJvODdPalFRVXp3SnNZ?=
 =?utf-8?B?Tk14N21INUtsQzdnbHc5ZmhXbmN4dnM5Yi9CV3NPOXpoT29JQ1lsSmdpb0dN?=
 =?utf-8?B?WGV2R3ZLd1BLVlpvSkNiQWxDY0t2TmdNU2ZRRnB1dHFscGFDNVN5TnZtckdx?=
 =?utf-8?B?Yk9URW04VDQ1K1BMT1lQZmFXRTNUMmlrNWRQK0hVUzViWVd3cnYvcmFMbUZM?=
 =?utf-8?B?ZzVQalVFTVFEMnhUMUUxdkwwbFVMcmJobWkrL0U3VmR1Zm9lbEEyUG1wcGFk?=
 =?utf-8?B?eW11TVc0bytHWlJnS1llSGt2S0ZJdzJIaXJYOTlDVjFuK2tyVWUzSG9qcDV0?=
 =?utf-8?B?SDJnVzFUbG5Zc1loenNYeStOeDFkUkppbDFOM3lXdmNpa2t0emRQb25uYzNa?=
 =?utf-8?B?Q2FmWDRzNGZoTDhIankzZEVPNFZXL294RDVyZ25lYTVEOThBQ1VvcDQxdjVu?=
 =?utf-8?B?dVlJeXhGMkJIV0FSeXVRWUhteERyK0w0OE5uaTExaE1GWDhRMlo4Ry9KemMz?=
 =?utf-8?Q?CS9lHn+6G5p8so1Z5SMk4qfnj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c81127-c377-400e-130e-08dddfc19104
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 08:14:21.0949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+WftZIUgKp5FzLaU104eGJR08QG7I7/ag+jXNbY+w1vFZ4foWGjZiHKcQOQVRRRL6hAL9gksCDCL2xAulQS0y2Pv8j92OAH7ZHhvaqScdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR07MB10732
X-Proofpoint-GUID: dFJNokoWHt62czMhmzrlU9KKUEU_kytY
X-Authority-Analysis: v=2.4 cv=FL1CB+os c=1 sm=1 tr=0 ts=68a583e5 cx=c_pps a=pfCY2Ats7XXgTBCGz+4jpg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Zpq2whiEiuAA:10 a=TAThrSAKAAAA:8 a=pWto40cfxrLt58bprJgA:9 a=QEXdDO2ut3YA:10 a=8BaDVV8zVhUtoWX9exhy:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: dFJNokoWHt62czMhmzrlU9KKUEU_kytY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDA3MSBTYWx0ZWRfX5vGmCKUsDjWy wxuiCN40mvSq0Dym977Fbk96mB9TVRxvndeLIEzBX4I53uwzNNYJy2UJ0EIdyaVKARdT6ald01k h1idTGRQVR5hiaMypsdChvIZ85L9vUBz2dddDC1R48IKn6s26PlRbS3WkWzUEdzgjrd69Pmnikg
 2RgqhyRcBpgNs1ybgbLDvzUe9yBjP2Dk5FfOYIGGYp+qUWAvWcazQ7liBB6x4DxTYNgX6vgJK6P /Pw+sANjWbLcHZWlm3KMbOtIeAG2ktxced241kg8dPVN/+3FYAS4cs2ngOKBlqA38jk+7MOcOP4 QmKItXjB7VXNgS5ib/FUnLqJULLblE6WVxTCmtPeeXaeaEZ3DSsM8HOIu+ZQ3SkPyIWPqIem+m4
 dRyl33pUDzPHZE5YItmsGMeIp1m/B2zrmWxtxXyT8QI/jhQoD07Wd+Rsd16HzskdFBLD4BIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200071

Pg0KPg0KPg0KPk9uIDgvMTkvMjAyNSA1OjIyIFBNLCBoYW5zLnpoYW5nQGNpeHRlY2guY29tIHdy
b3RlOg0KPj4gKyNkZWZpbmUgSFBBX0xNX1JDX0JBUl9DRkdfQ1RSTF9ESVNBQkxFRChiYXIpICAg
ICAgICAgICAgICAgIFwNCj4+ICsJCShDRE5TX1BDSUVfSFBBX0xNX0JBUl9DRkdfQ1RSTF9ESVNB
QkxFRCA8PCAoKGJhcikgKg0KPjEwKSkNCj4+ICsjZGVmaW5lIEhQQV9MTV9SQ19CQVJfQ0ZHX0NU
UkxfSU9fMzJCSVRTKGJhcikgICAgICAgICAgICAgICBcDQo+PiArCQkoQ0ROU19QQ0lFX0hQQV9M
TV9CQVJfQ0ZHX0NUUkxfSU9fMzJCSVRTIDw8ICgoYmFyKSAqDQo+MTApKQ0KPj4gKyNkZWZpbmUg
SFBBX0xNX1JDX0JBUl9DRkdfQ1RSTF9NRU1fMzJCSVRTKGJhcikgICAgICAgICAgICAgIFwNCj4+
ICsJCShDRE5TX1BDSUVfSFBBX0xNX0JBUl9DRkdfQ1RSTF9NRU1fMzJCSVRTIDw8ICgoYmFyKQ0K
PiogMTApKQ0KPj4gKyNkZWZpbmUgSFBBX0xNX1JDX0JBUl9DRkdfQ1RSTF9QUkVGX01FTV8zMkJJ
VFMoYmFyKSBcDQo+PiArDQo+CShDRE5TX1BDSUVfSFBBX0xNX0JBUl9DRkdfQ1RSTF9QUkVGRVRD
SF9NRU1fMzJCSVRTIDw8DQo+KChiYXIpICogMTApKQ0KPj4gKyNkZWZpbmUgSFBBX0xNX1JDX0JB
Ul9DRkdfQ1RSTF9NRU1fNjRCSVRTKGJhcikgICAgICAgICAgICAgIFwNCj4+ICsJCShDRE5TX1BD
SUVfSFBBX0xNX0JBUl9DRkdfQ1RSTF9NRU1fNjRCSVRTIDw8ICgoYmFyKQ0KPiogMTApKQ0KPj4g
KyNkZWZpbmUgSFBBX0xNX1JDX0JBUl9DRkdfQ1RSTF9QUkVGX01FTV82NEJJVFMoYmFyKSBcDQo+
PiArDQo+CShDRE5TX1BDSUVfSFBBX0xNX0JBUl9DRkdfQ1RSTF9QUkVGRVRDSF9NRU1fNjRCSVRT
IDw8DQo+KChiYXIpICogMTApKQ0KPj4gKyNkZWZpbmUgSFBBX0xNX1JDX0JBUl9DRkdfQVBFUlRV
UkUoYmFyLCBhcGVydHVyZSkgICAgICAgICAgIFwNCj4+ICsJCSgoKGFwZXJ0dXJlKSAtIDcpIDw8
ICgoYmFyKSAqIDEwKSkNCj4+ICsNCj4+ICsjZGVmaW5lIENETlNfUENJRV9IUEFfTE1fUFRNX0NU
UkwJCTB4MDUyMA0KPj4gKyNkZWZpbmUgQ0ROU19QQ0lFX0hQQV9MTV9UUE1fQ1RSTF9QVE1SU0VO
CUJJVCgxNykNCj4NCj5JcyB0aGF0IFRQTSBpbnRlbnRpb25hbCBvciBhIHR5cG8/DQo+DQoNClRo
YW5rcyBBbG9rIGZvciB5b3VyIGNvbW1lbnRzLiBJdCBpcyBub3QgaW50ZW50aW9uYWwgYnV0IGl0
IHdhcyBjb3BpZWQgZnJvbSBhbiBlYXJsaWVyIGF2YWlsYWJsZSBjb2RlIA0KYW5kIGlzIHVzZWQg
YWNyb3NzIEhQQSBhbmQgTGVnYWN5IGNvZGUuIEkgd2lsbCBzdWJtaXQgYSBidWcgZml4IHBhdGNo
IGxhdGVyIGZvciBmaXhpbmcgdGhpcyBpc3N1ZS4gDQoNCj5UaGFua3MsDQo+QWxvaw0K

