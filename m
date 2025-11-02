Return-Path: <linux-pci+bounces-40046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C7C28A01
	for <lists+linux-pci@lfdr.de>; Sun, 02 Nov 2025 06:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EA9A4E126E
	for <lists+linux-pci@lfdr.de>; Sun,  2 Nov 2025 05:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174B25A2C8;
	Sun,  2 Nov 2025 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XkbZSLLi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NNa82Mps"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4958259CA0;
	Sun,  2 Nov 2025 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762062685; cv=fail; b=oJm0Lx0ZQjFtlVaZSqUa+I+/dLHOMfLNCwpTiEV1S5NcU8S4fTMC7eBfw9IAsmQWgwLNd+uo3Agv2HC0wgAq9AQYbnJYIMP+8jXVV37iRCSie80ssvzhhj1+yr3bLHWrzRuSY8I+xnaFD3Cg4urwfYztjIV84qnM7R173bBLUvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762062685; c=relaxed/simple;
	bh=ahNCQ5lbA0w8rKuU8d3GNgUg8TeY5eIya+xMJL4ysBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TcNhWoGdCc99WBMXjneFAG3srAWN/ZU9kJssG/36eV0A7GwQIrwvGmiufFgomGgGKp+M2bZvQLBk5mXzwqvLdwbhHt58UrxNfe6GdHIebj00M/3/XLEvWbc1MJxKegLEq9Y1UqWY5OjlxWQ4HutAGVtsG5zlVqK+phU6si0mZr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=XkbZSLLi; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=NNa82Mps; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A1IjOpT1621617;
	Sat, 1 Nov 2025 22:51:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=ahNCQ5lbA0w8rKuU8d3GNgUg8TeY5eIya+xMJL4ysBA=; b=XkbZSLLiFrus
	M3lEnMr1n2sTL8Lvrc17Y3vbW2+4LHOulxZinrHvWOIM4Ql0HqP4kEjuX2yCd3bq
	YKzcMYx375tavE0MQV5MmKdviscTJb9Lcp4dA7uVtlBulIpQ1a6ckNyN8lBKve33
	1mGuZeVi3PfDVQWOwDgRdzCEAAAZPm6oeJbp5PfsqSbGWoDNqOoa7L95vL+ajWY8
	vPbhT32h6Mw/sbXckFsQdpkHN7g8f4JFC2YIN/SAgHjiCvqGyky4Xn6v+HlHlasJ
	z/3KEqAC0b8BoHaS6q6/+Stcc+T4lQaTC7f5xrkaii+D5w54Tc4tlnJDlz3FeOn6
	bpDAUuo5nw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4a5erub67g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 01 Nov 2025 22:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5NkMgufQKWDqdu4wlr/8kfHy/KODZTTo5u4Uv7Y9qTZGwijBeJQ4WMSTd/PDtnXqeUDrF3al+599VgWIGYcvyicsSqeJ7YxqenSz4s4wh/OlpWkJbueQGCTIxVl3+qgHDOn9TLJWZCRCaS6AVzF5vbfapugpxMbhvHizIZxVCPr0yW53yefIAAO0dEAbmvnXHy+oQWLpPrYZEQCr0lbE3AvPJV+wJVs3hZQ0jiNuUocxOvkt7kYTVH1sDN8uIe/yMUlLcVRK1BRnW8K91wIYQl/GdL6faGyf0/3b8AJ82UO4bg8Cqejn1orMGKH/woSeoe5aJBBLTZNv5TlHcdaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahNCQ5lbA0w8rKuU8d3GNgUg8TeY5eIya+xMJL4ysBA=;
 b=tSnbP0hiyZDIhX2iaZqQRDA9KhM0GfXwN2ON0KIfXGEweicpzJLCUOjr7ejRFQXjypZmVWuEdaw9rhO3puXWdscuwfB718I/yOwWdjJ0br5+03BEXGV2yA91VezuH/S3t9XJKFVhFemc1XeqI1i8N9QlxZ/4YVNZHsS1jotSfbtlfv2MLP9CNE/+XNXTPnN/7RvkUOhWf8TDpZndMsh5kIw1jBJhZfexscYEcEU1uVyqWQ+zoae4SM5iSg5uE8uYX8rz+bX/lZS9yT9iJd12/3hY4tlntuWuMHdk97VUHAchQHkWOx1067HH3qHXtnmoZCJvuQmenHUxC/R6XOUlFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahNCQ5lbA0w8rKuU8d3GNgUg8TeY5eIya+xMJL4ysBA=;
 b=NNa82MpsrEQZMbm+LdixB58kUgYTkpfJeS0iTm/Zkix4YDLBMzTCZQEu5eCdwmnX/eWUxXcp/it7tOVm3+7oHNKupUpJb1IJg3jFTmXE7jDmGNbzdVdTI/wj7s075iZ1f9idXAJfd8YBNIRLWLHpp2yeZOKgH6rrreASruP0FrM=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by PH0PR07MB10829.namprd07.prod.outlook.com
 (2603:10b6:510:337::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Sun, 2 Nov
 2025 05:51:05 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::94fb:f289:aeea:1d35]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::94fb:f289:aeea:1d35%5]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 05:51:05 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "fugang.duan@cixtech.com"
	<fugang.duan@cixtech.com>,
        "guoyin.chen@cixtech.com"
	<guoyin.chen@cixtech.com>,
        "peter.chen@cixtech.com" <peter.chen@cixtech.com>,
        "cix-kernel-upstream@cixtech.com" <cix-kernel-upstream@cixtech.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Thread-Topic: [PATCH v10 04/10] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Thread-Index: AQHcQXoWEUMpe7PTXEWbAr9PiY4tfLTcCaEAgALQoSCAABkOAIAAAYcg
Date: Sun, 2 Nov 2025 05:51:05 +0000
Message-ID:
 <CH2PPF4D26F8E1C0BE70D4B6BB9B3A334D9A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
 <20251020042857.706786-5-hans.zhang@cixtech.com>
 <u7g4b4cgh4usmndpzatfg24x37sabd7psxik6pxmbpu2764d6s@zczbojakk4c4>
 <CH2PPF4D26F8E1CFC4FF273AA07E283BBF3A2C6A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <2aanerkp7c4qd4mukz6oaxafe22assjyah2kdbdmyuich5hzha@k6hlzvarixxo>
In-Reply-To: <2aanerkp7c4qd4mukz6oaxafe22assjyah2kdbdmyuich5hzha@k6hlzvarixxo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|PH0PR07MB10829:EE_
x-ms-office365-filtering-correlation-id: 7b675ed5-f1e9-4e5e-bc58-08de19d3d011
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1VWK1RFeGlzOS90ZXFRd0dpc1d1bmlWL1Q5WElMU25uZ1JQcGJpNUszem9Z?=
 =?utf-8?B?U0lXTjlpQXFZN2RTYkFUZGFJSWx2TXMwYXdzV0d4dHdUNzV5M1RXYXU1Rnha?=
 =?utf-8?B?RmZHSlhVYUpaR211VWhuM1NQak44UXphbkVFMzd5MGVWcDV5V1g0bDBaL2pm?=
 =?utf-8?B?eTIwTXpmRjJqMUlOZ2RzYUZyK0tVVXMyYnNaSDhVZGVodlR2Wm9Gbi82R1dm?=
 =?utf-8?B?RkZBMnRMT1NiWTEwNFE5dHBRY1MxaVRNMmRlQU9hMnBMaVlHcUU1RCtVeVRa?=
 =?utf-8?B?SVZ6cFNURHJ5Y1lIZk1ZYytsSE5uQlFOYUgzOFFYR0RFVnZRVVV4bHJTV29p?=
 =?utf-8?B?bk9QZFZlM3FUTW0xWW5rb0ZsSEZYMVUyeFp4R3VFRys5S2x2Nk8vM0ZndlpM?=
 =?utf-8?B?YmZacE1TRzQ5MVdrakwvTmlLRU5UQjZKQTFtQzYyeTdob1B0VEMvTmU1MWRV?=
 =?utf-8?B?bnpOUTR2ak9NNFhjK3ZhK253SWJ1RjIwMWt3cmE1bkhWOE9EaURPRmpmVkJV?=
 =?utf-8?B?UjhMRWh6L3R2UlIvMHZiZ3RENUp4MWlvbFJIL0N2bFZWOGQ0T1Q0M3IvaVJU?=
 =?utf-8?B?YUFtdGk1S1A1R0FXZi96YW1pakVnZE8zZG11WEJkWnlXVS9HNHRoamczYlp3?=
 =?utf-8?B?bHVPR3ZWVTI4Z0lURHFablRnRU4yR1NWbzBTTC92QndXM0Qrb29SL1lpaUhX?=
 =?utf-8?B?aXRoMzQ4VGkwRnlPV3Fya21tUjRidG5QcFVwcmhISlpValhNQytBMjd6TGdG?=
 =?utf-8?B?NlQwdHlkN3MzdXFBRndiZXpYYzdJV25RcjdoVzIzc0Z6UlNzclFqWGw4MGUy?=
 =?utf-8?B?akNVTndtRjVPNitROTFabVhncnFEaFFDNnFDVUw0OXJBT2FTa0lsTW9hSnJy?=
 =?utf-8?B?c2I1QjVhVHVscGZSMVJlMUp2NEZranU1eDBob3JwaG9pdnN1OVhuVUtMYXJu?=
 =?utf-8?B?RlBHWldoaEpQcHI4czNjSG55Qi9kRzZXSWJwTkcxakF6T01KZ1FCM3dFMXNm?=
 =?utf-8?B?TFg2KytiNThSSjFTZWRDZ0o3aWxGbGtQTDlxZ2V6V2pJSzYwalpUWUQ3NUZp?=
 =?utf-8?B?VW9MWFJZTU94VWNITFM1bHlHQXNhWDZDdHpVcFozUjdDYzJ2b2RMSGtCeEpm?=
 =?utf-8?B?eEpMODhmcUtVdXpjblFhMWlZUEFYdUM0aG42SVhPMDF5Tzl2Z3Byd3FTZnhr?=
 =?utf-8?B?R2M4aVdjZkxxS0NrcDlXSW5aMXhHZjk2OXJtamloS3FsNnV0cFJ2aS9MRFRU?=
 =?utf-8?B?MFlNRUk3WVc5ekcwS0JZQ2Z5WGNwWUlaeVRNazRpcGlPb1NRZi94QXV2aFJC?=
 =?utf-8?B?VzVVWTExSFRUR0Q1TzRQRDRJYzdTMEZrUldwMDY4WGRtNGVabVAyZGF1aUE1?=
 =?utf-8?B?KzlUbmdTQk4rVm1QWjhTOGgxcVhBMDVKRS90Ym83VlZPdHpxKytiS3owam5h?=
 =?utf-8?B?U1YydGpUekVESm9ncktBVllSMDg2bWVGQlFSSGxjamJRaEg4a0VQOTJZaWFU?=
 =?utf-8?B?b2JRMjRtU2xxL3ZQVVFPcU93aHlmbHVUTVY0QUhabElhekpuSHo0SFMwMFJp?=
 =?utf-8?B?TUthT2FJcEZYbVg3ZkJHbjFXMDZMUm1uUkxudVNoSk9vUmh0aG5jRDlYMmJV?=
 =?utf-8?B?L0o3MWJPYWFERFFFckFlNEZRZDByM3gyb2VoTFhrNURPaWVYSDBEdWFrV2FG?=
 =?utf-8?B?clRMc2FqaEhsU2pxUnJoZFRRbXg1UXJPaUkxdC9HdmRobVJYdS8wUzA1N0pQ?=
 =?utf-8?B?ck5iSWNleThINXBXNEdlYWV6dHIxVkkwZmZ6d0tFMDB0d1BtSVJVV2JmTmVY?=
 =?utf-8?B?K2VxeHBBdGlWTXU2bTZWM2E4dk9kZGZTL2RDQ2g2Rk4xOUZYTGFaeHFVSEt6?=
 =?utf-8?B?S3piM1F5TlQzYXFDbWZKWVNWM0lFZVVpVVdUQ1NMS2UxWGRmYWR4bXVqdnpO?=
 =?utf-8?B?Y3lRYldMY1hzL1BtRytORnFvTXM0cHo5d2dBUUdtMzBZSEVOV2czeGdqMVFH?=
 =?utf-8?B?K3BDZzJHSlU4Rm1XcC81RXNpbWRUNWxGT3l0RGdlSGozM0xEd1UydHB4NUY0?=
 =?utf-8?Q?te9JVB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnNubVIwQlIyV0Zhc2l6MS9HSWFQMEY5eHRKVjJrb3FDV1VHRU5sRTZsZ0RF?=
 =?utf-8?B?dE9sZXRxbFR4czBOWDNjSXNqeFY3YkpFdnZJYno1V1A4KzJ2V0FsclYvRGhp?=
 =?utf-8?B?S1dkK281dStZZUh3aUpjZzEybkZmb1pNZktuMzkzaFNBWm0yR1JOR0pIVGpv?=
 =?utf-8?B?aDhqRHZiS0t4akRIdnNqUkFwL1JvRVc2ZGtQbTlyRzIzWEg4Qm5Ga1FJKytn?=
 =?utf-8?B?Y3FianNwWEkydGhVRTVVL1Aydmc2UzBNQzNoVGNOcERrc0FzbmZrWnhDdHFi?=
 =?utf-8?B?bVNuQlBuV0d0cVFoUlEzbHpXczNlTUhTZGtmSXRaNXRpc3d2V2NpODROZUtC?=
 =?utf-8?B?MjRVSThvZXAwN0cxOWUzTkNBY0lJUnl6MTc5MHFlTUczc2JmVnNRQmRiTnAw?=
 =?utf-8?B?NldjZytuSnMwLysxWG5OeVByQUNzWmo2a0pxbVFwdldXTXJxNVY1VXVoR3RL?=
 =?utf-8?B?SzZWTkVwWEpjVXAwVklvRW5iY1BkclNnUE1qVDQyYVZhN25RR2dmanJEU1Bj?=
 =?utf-8?B?QWM3NWpRTHI2bWVQdU1vd1h5OEpZZ3p2MlNlYmh2b2JxMmovSjdsUmlwQUVw?=
 =?utf-8?B?eGwxOXVQRlhoVGJOOTRmVnFpQm1JNUpUcDRpSUpTMlZ0Y1M5MVNuUi95WlZK?=
 =?utf-8?B?T1Y0ZmlRaWZyY2ZuYUdaZWxsR2orZ3dDNUNYNlJzTmhWK3h2a3VhMDBuN0NW?=
 =?utf-8?B?MkpwSHljcmhOeEt6elNnTG1sUWg0Q0dRN0tyMW5ROWVqTDVvTU1tWXpQaWZP?=
 =?utf-8?B?TyttZVk1ZFFwVWg0aVFSSEJWNmJDLytWU0FqQU12d01tdXMxM2RIazZSVEgy?=
 =?utf-8?B?Unl3TnJDSWVjRDBQYW5kWWcvZFFna3dheWF1anV1U2k1c1AvUzhETzI0VFBF?=
 =?utf-8?B?ZVNRWWhnUUd0UCtFa2lvclczMkdMc09oM3JLMXFDcjQzWEtaTXZIZ1ovUC9t?=
 =?utf-8?B?M0hVKzVua2p6TmpXTjB0NXI4R1N6eklRT1BIeFJucW9GWlQzdWRJcnNCcVBh?=
 =?utf-8?B?NkhEaVE3N09Hc3F2MkxrWFd6Wmp2LzZsQUI3a0E0dER4d1BRYWtvclVVL0pN?=
 =?utf-8?B?U1A3Z0o0SXFGMERteDhJZlZWWFVUMHMzWTZjRXRnNld2c2pXcHJvNk5TaURv?=
 =?utf-8?B?bkhEN2FyTmpsc2wvemxnNmh0Zzc5NGtPdHFlcnlMbk13SFgwWVdiUmFSUFlu?=
 =?utf-8?B?Nm5UOUJLUFZrRjkwenB4MnBUWUlNV09tbVVDMCtsRUtGdUhwcjdwUlVzMGUy?=
 =?utf-8?B?T2VMU2FGSTFKSlNxZk1VZ0o5ajRhcTNXQUl3cXJRZTZWR3h1NHk2WDJDazFk?=
 =?utf-8?B?eGtmSWxnZU9vODdGa3l5MFRRMkNWWm5jWituam9JOFdFSy83WWxLZSttT3cz?=
 =?utf-8?B?MElQd01pdUozNW1qWDhUSnBCcHZ6NUtKMCtpd3I0Q1Q2NHZlVGtqWnRkYzht?=
 =?utf-8?B?R1ZRNEFIUitQaDkwaklRRmE5WVQweUhzNC9BVUUxc2tYTjBoSURCTHZzRGRJ?=
 =?utf-8?B?azdNcEdiWnlTeW5JeWN3a2JrSWNsUlRwdTRMcVZWQTg2N3BLd3Z2WWZrdURO?=
 =?utf-8?B?eERDbklrR1B3V1RKaGdlNXFSTFpzZzBabG5LMGdsZWJ2VEdBajdjeEttMnVr?=
 =?utf-8?B?aFlMTnMydElHZ3FoWVJIeXRuUHpITjBjZlVxdkNKMzFlVkNtaVE2WGs4dnli?=
 =?utf-8?B?amNsT0pRMENuNFB1M1Z6NDUxdHRLVjZUaU1kbHUwQkNLaEJ3RjBQOU1WU1hu?=
 =?utf-8?B?NHppREpsRnRUTysvMTFGSWEzUlU4dDJxTjkrdFNoZmtQb3AwMnZSRzByNE92?=
 =?utf-8?B?UVF1MnFlKzNmYmQxeVZuVWphOVh4cmE5ZUVkQUJzSThhQ2RyN1RSWEhOeXhk?=
 =?utf-8?B?QS9KUU92Um9ObG5PdXl6LzJ6NnVDSlUxeXFjSVVnS3Z4VjBUejF4K2NRaERi?=
 =?utf-8?B?bEh1SWNLTDBFZkdSUWxWLytXS3ZSSThQMUkxb3JlcUV2ZDdnUktHZFl6ak0r?=
 =?utf-8?B?WVBiTUwrckpISHVSRXowbnFJQVZJaTZMR2lQS2ZNUmFvZ3JubUpBRHdzM1dt?=
 =?utf-8?B?S0pvZ0ZQNDJ3MnVIVFM0UmwwSDBZazV3WllMbm9kSjNrcGtHOWVPNmEzcUVw?=
 =?utf-8?Q?0QvUWfQUBmkytt3mQRc9PGgW+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b675ed5-f1e9-4e5e-bc58-08de19d3d011
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2025 05:51:05.2278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1W1j3ckXAlqkD4b3YvQiXVrY0Cn3hnZtQMEvcAVasgUIfz2VR73wCWHTIQaCMq3IY6pYKlDI7Ll7VJZLRAQeOO2PlS1T4GuXV4pBBRf/4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB10829
X-Authority-Analysis: v=2.4 cv=LIprgZW9 c=1 sm=1 tr=0 ts=6906f14b cx=c_pps
 a=htKwazZePKloe4WR6Wq9JA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KqdflEGtlSFDAPbqAXkA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDA1MSBTYWx0ZWRfX8jljh6krevyF
 AeblK683l/d4ALeJNSD1VSq+PshIF8r4a9YqonkFfUkObq+3thfC9BX3o1KIn7rAfOR2EJ9bgvb
 DFfvWEUfuAeG8mBEfO62lIRDnqP+kCQzYyPbiH6jXicGffZeDe7ZmZqZ643DRJUc6V4XZKvvWJ2
 fd0y7lP5eJZW+PwaWh9NPjisxq1bmgTjEK7aiI72O7egjs85JiCoo4o/Hi/tqPXDtgwQ5BuMQHQ
 dxP7e42L7/cvU1YfR0iCZKAReQ71VLsbx2HBUmCZ00itbNjpb0eEhv6asCkSOjZeWqicXfWuYtD
 H6VLcvY5bFmeP7RnsR8SuCRJLUrqVfsWki/uLh60AtgCigmyFkTEXyLioS0wuXbEVFTzVyWQvwe
 zqJWGSDm6pni0cpfdrO36ZCfrBAlAg==
X-Proofpoint-ORIG-GUID: 6_z9qRNNkIHORrNqlh5x2E22BYrEVHo0
X-Proofpoint-GUID: 6_z9qRNNkIHORrNqlh5x2E22BYrEVHo0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511020051

SGkgTWFuaSwNCg0KUGxzIGZpbmQgbXkgY29tbWVudHMgYmVsb3cuDQoNCj4+ID4+ICsJCQl2YWx1
ZSB8PQ0KPj4gPkhQQV9MTV9SQ19CQVJfQ0ZHX0NUUkxfUFJFRl9NRU1fNjRCSVRTKGJhcik7DQo+
PiA+PiArCX0gZWxzZSB7DQo+PiA+PiArCQl2YWx1ZSB8PSBIUEFfTE1fUkNfQkFSX0NGR19DVFJM
X01FTV8zMkJJVFMoYmFyKTsNCj4+ID4+ICsJCWlmICgoZmxhZ3MgJiBJT1JFU09VUkNFX1BSRUZF
VENIKSkNCj4+ID4+ICsJCQl2YWx1ZSB8PQ0KPj4gPkhQQV9MTV9SQ19CQVJfQ0ZHX0NUUkxfUFJF
Rl9NRU1fMzJCSVRTKGJhcik7DQo+PiA+PiArCX0NCj4+ID4+ICsNCj4+ID4+ICsJdmFsdWUgfD0g
SFBBX0xNX1JDX0JBUl9DRkdfQVBFUlRVUkUoYmFyLCBhcGVydHVyZSk7DQo+PiA+PiArCWNkbnNf
cGNpZV9ocGFfd3JpdGVsKHBjaWUsIFJFR19CQU5LX0lQX0NGR19DVFJMX1JFRywNCj4+ID5DRE5T
X1BDSUVfSFBBX0xNX1JDX0JBUl9DRkcsIHZhbHVlKTsNCj4+ID4+ICsNCj4+ID4+ICsJcmV0dXJu
IDA7DQo+PiA+PiArfQ0KPj4gPj4gKw0KPj4gPj4gK3N0YXRpYyBpbnQgY2Ruc19wY2llX2hwYV9o
b3N0X2Jhcl9jb25maWcoc3RydWN0IGNkbnNfcGNpZV9yYyAqcmMsDQo+PiA+PiArCQkJCQkgc3Ry
dWN0IHJlc291cmNlX2VudHJ5ICplbnRyeSkNCj4+ID4NCj4+ID5UaGlzIGFuZCBvdGhlciBmdW5j
dGlvbnMgYXJlIGFsbW9zdCBzYW1lIGFzIGluICdwY2llLWNhZGVuY2UtaG9zdCcuIFdoeQ0KPmRv
bid0DQo+PiA+eW91IHJldXNlIHRoZW0gaW4gYSBjb21tb24gbGlicmFyeT8NCj4+DQo+PiBUaGUg
ZnVuY3Rpb24gY2Ruc19wY2llX2hwYV9ob3N0X2Jhcl9jb25maWcoKSBjYWxscyBmdW5jdGlvbnMN
Cj5jZG5zX3BjaWVfaHBhX2hvc3RfYmFyX2liX2NvbmZpZygpDQo+PiB3aGljaCBpcyBub3QgY29t
bW9uLiBBbGwgZnVuY3Rpb25zIHRoYXQgYXJlIGNvbW1vbiBiZXR3ZWVuIHRoZSB0d28NCj5hcmNo
aXRlY3R1cmUgYXJlIG1vdmVkIHRvIHRoZQ0KPj4gY29tbW9uIGxpYnJhcnkgZmlsZSBiYXNlZCBv
biBlYXJsaWVyIGNvbW1lbnRzLg0KPj4NCj4NCj5UaGlzIGlzIG5vdCBhIGdvb2QgcmVhc29uIHRv
IGR1cGxpY2F0ZSB0aGUgd2hvbGUgZnVuY3Rpb24uIFlvdSBjb3VsZCBqdXN0IG1ha2UNCj50aGUg
Y29tbW9uIGZ1bmN0aW9uIGFjY2VwdCB0aGUgY2FsbGJhY2sgaWJfY29uZmlnKCkgYW5kIHBhc3Mg
ZWl0aGVyDQo+Y2Ruc19wY2llX2hvc3RfYmFyX2liX2NvbmZpZygpIG9yIGNkbnNfcGNpZV9ocGFf
aG9zdF9iYXJfaWJfY29uZmlnKCkuDQo+DQo+VGhpcyBwYXR0ZXJuIGNvdWxkIGJlIGRvbmUgZm9y
IG90aGVyIGZ1bmN0aW9ucyBhcyB3ZWxsLiBQbGVhc2UgYXVkaXQgYWxsIG9mIHRoZW0NCj5hbmQg
bW92ZSB0aGVtIHRvIGNvbW1vbiBsaWJyYXJ5LiBDdXJyZW50bHksIEkgY291bGQgc2VlIGEgbG90
IG9mIGR1cGxpY2F0aW9ucw0KPnRoYXQgY291bGQgYmUgYXZvaWRlZC4NCg0KVGhlIHZlcnkgZmly
c3QgcGF0Y2ggIGZvciB0aGlzIGZlYXR1cmUgaW5jbHVkZWQgYW4gb3BzIHN0cnVjdCAgd2hpY2gg
d2FzIHJlZ2lzdGVyZWQgKHZlcnkgc2ltaWxhciB0byBhIGNhbGxiYWNrKS4gQXJlIGFyZSBhc2tp
bmcgbWUgdG8gYWdhaW4gaW1wbGVtZW50IHRoZSBzYW1lIGRlc2lnbiB3aGljaCB3YXMgZWFybGll
ciByZWplY3RlZCA/DQoNClNlY29uZGx5IGV4Y2VwdCB0aGUgbmFtZXMgb2YgdGhlIGZ1bmN0aW9u
cywgdGhlIHJlZ2lzdGVycyBhbmQgdGhlaXIgb2Zmc2V0IHdyaXR0ZW4gYW5kIHRoZSBzZXF1ZW5j
ZSBhbHNvIGNoYW5nZXMgZm9yIHRoZSBpbXBsZW1lbnRhdGlvbnMuDQoNCj4NCj4tIE1hbmkNCj4N
Cj4tLQ0KPuCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7g
r40NCg==

