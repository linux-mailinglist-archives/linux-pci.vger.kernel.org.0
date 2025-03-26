Return-Path: <linux-pci+bounces-24717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A778A70EF4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 03:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF443B65EB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 02:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EEC76034;
	Wed, 26 Mar 2025 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2gU6XF5x"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F67F9;
	Wed, 26 Mar 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955799; cv=fail; b=d3QU9yilbsjH8nJPL3IOvjQSCWY3aSkameHET1PcDxyXXUC2JaogCn46uSr7lIbRWvvNCJVNpBMXZ3nBfKcECJ4ztgeX/goxdc4SfpGKOniH7Ej6UhhZ8aL1hrPNfMMY43794YbUYhX4tmz2y4MCpxzv7HwNfL90vS2vvCVqqZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955799; c=relaxed/simple;
	bh=8+FbF1z649XZLIhXkHeIdtpibNVwqPWAp2TGX94qDJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dl+Wi0CMQ37aqg8cO+XT3oR0w3qG80KN8CzAPnV5Blc4+fePVUTmJa6RRo3ZLPEFra2H6HWqUkNe/T+0zope6F1KFKNUkR5N5A6MqjVY4DhxobLtvNHdoLuflZrRn3FEp3UHanzE8acDtjjhqNotjqabv96SeZd2p/2CtgNWiZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2gU6XF5x; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKlsWLjIQGqtVwpWGlHsT2DvF1oF9s3Du9HTZ+1DQS272OxoDn0Q1vCc8nLgVd+05xjB+vQ+RCubxEW48JLjteY0gDDO5VgypgH4CH8iP0mYBGSHwYA0vm52uXBfdmqRPIvkxjE8bZdUvTt+EXJvOhfLWwRkdvBjYLz1jh3YdRJU1F7EYZNgizRcYlnATngBduqzRcw7F2KEEmok3LUeDayl+wBK46Wowi0BWfmaASx4cj3uc78A6ciRiDKS0QiBVv2lmbbUbzQEXQFXyc5bd4pWQiKDPyuqseKP+nNVwtHBRDhXfNlfCdlRc7AI3pkC0p0luFL5pfTzt3Uk1DtPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+FbF1z649XZLIhXkHeIdtpibNVwqPWAp2TGX94qDJ4=;
 b=UDEZbchxAyRGGS0qrhjb5+9a61JwnPyvzTK6c5UYP6cWYLIvWJectvWBzLjDryp21K7SV4/Do/hmheK0QOTuLrc3h8ScBD5d8D9NZwagxlZlb6iL1VbL4iQRNESn15RZyE+n0+574A5yqhMLJKCOgLsnHUBP2y4QoCZbQd2DNPeW8i6lWrixy2PiGH3k3LvZVQEHeCZly7uGzF9OYy+WU8qTezks6J6jsiFtKSH2MBIfuRmmIgMQqceyL9BWXXVAi1SsKs1bizQ1GwjfgKBmwxtKIcNDpBCBMEEQLimVwgilm0fc0a6ugifu/Qn5/MnBjl02D4Pq+v0ur8Nlg/7vZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+FbF1z649XZLIhXkHeIdtpibNVwqPWAp2TGX94qDJ4=;
 b=2gU6XF5xz29+oARpjZqYQJmqjFImGGAnWYuOmLLG772w/x6sCy14N34a4MpnNRt3vrRjE7J1WBXQ2ln4oTagFPZfbR/tJz45Kyi15GR/mKAvDtXBn/8KlQpVtkI+lVhUfemHCpCJP8E/fnSqP7XHoEEa9ORD4zrm4a/HrWp4Zvs=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Wed, 26 Mar 2025 02:23:12 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 02:23:12 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "cassel@kernel.org" <cassel@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Thread-Topic: [PATCH v4 1/2] dt-bindings: PCI: xilinx-cpm: Add reset-gpios for
 PCIe RP PERST#
Thread-Index: AQHbl+frJF7RvdoXyE2lj0XSnTqI+bN4pyWAgASzLNCABJAbgIAC0X/Q
Date: Wed, 26 Mar 2025 02:23:12 +0000
Message-ID:
 <DM4PR12MB615829F0D68B77C42A442DCFCDA62@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
 <20250318092648.2298280-2-sai.krishna.musham@amd.com>
 <afe7947b-ed71-40d0-aa2e-b16549fc6b7d@kernel.org>
 <DM4PR12MB6158F761C80CA82B59FC0634CDDB2@DM4PR12MB6158.namprd12.prod.outlook.com>
 <39968d11-1b7d-4453-8350-26ed31dae02f@kernel.org>
In-Reply-To: <39968d11-1b7d-4453-8350-26ed31dae02f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=86a912ae-014a-488d-9cf1-618c991f88e2;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-26T02:22:04Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|DS7PR12MB5790:EE_
x-ms-office365-filtering-correlation-id: f1656e71-273c-466d-595d-08dd6c0d288e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0VXc21TSGgzWW5SaWFaL1hKV0NnaWhkUDJReXAyc0VuVEY1MmxNazc0UHJN?=
 =?utf-8?B?VVNsaHAwM2NsWE1ZcVRMdEtReDFTcHRKNWx5MnlxN1hMS2lEU3lSK2w5WXJC?=
 =?utf-8?B?Rk9DY0hzNllqWTU2V2dDRU94MHlJNVBJNXM5bFhkcThOeGkvN2JFUFpjOEpZ?=
 =?utf-8?B?QktnRHFHNUp6TTVUYTVlMG5GU2lGeWRnenZuNGpUc203UDZzUUJhcTlhMkd5?=
 =?utf-8?B?ZXJTNW5MZUZDYldUVjhDS2ZTcjNVUUJXSzRzenk4SWpCZ1psbU1NckNrbGVN?=
 =?utf-8?B?bUJnU3RZWkI0L29nWldHREg2QWN6OGFvZkxTMkpkRWR0ZzVkV08wd211OWpq?=
 =?utf-8?B?cGlQRzc4NFJOMTEwMFBmN2c0T0k0ZW5QbThDZXZqVUFxL3lMSzNpZmhlWW13?=
 =?utf-8?B?TlJZVmQyeXdPUytMSEJNaFhxdU9QekVEMWVlVmZjN0p2Wm5MWUlFS21uTkNY?=
 =?utf-8?B?cklxNEJ0Y3JCVGR0Y3FHdkdoTE5nY0F6c0NxdTFCVzZXSFhzMzFmTUdNWnA3?=
 =?utf-8?B?amt6MFpOaFJSb25Ud20xMWpkaTRjNktTU2NhcDF1REgzUjNKYjlSR3k0NnFQ?=
 =?utf-8?B?OEcwZFlxajZ2V0ZpN3lTOUZ3WHdDTWUreE9zbnpzWWFFN2JkcUJBVU5nb3ho?=
 =?utf-8?B?bW5BbXpDNFZrYXFrWDFoaFRKcndRaWhCU3c0WTNST2VrckV6VjN6a3Nhang2?=
 =?utf-8?B?YzIzUmd6bFJxSlpmL2ZYcm1jL3c1WC9oTnJYNFVnTFRHeSswcHJpWlhnb3ox?=
 =?utf-8?B?RWFkN0NhTzRSV3BYMElNSnZKOUQxalhtTE03TERhaEE0d1F1NlNORXc2d00y?=
 =?utf-8?B?a1BoUFBoQmNpKzl6cHlDQU1SL3VLUzJhdVRJeU95ZlVGUm9FU3FoTWE3bmF2?=
 =?utf-8?B?YTFRZXYxdkpuemd0RlJvQjljOXhRRHJGWjdBZzR1Z2JrazN4aURWSlhjTHBN?=
 =?utf-8?B?bjk1dG55UEk1Q3Q1OVBjaWo0MFpJQ285ZENEc1NFaUpudERuWjk4MjdyWFhj?=
 =?utf-8?B?bGVaMWw3VVZSMU1scWV0MG94WHdFL3pnc2pRTFo4VEFqMEgzald3SE1RRGQy?=
 =?utf-8?B?TUpBWTRFOWJ4eEZjOXpHZkdLYWxkRFBpZ05QVDQyUkFDZTZjYW44S0tZampx?=
 =?utf-8?B?MkNOd1hTNUREbHU0NE1VR256cEd1QkF2UTdmSkRXZG5HWnROVVNkNDhpaVcy?=
 =?utf-8?B?SHZuR0ovUVM2bkRiSGNOZ3Y5TCtSTkppenp2VHg5SWU0aTFEbi9EU3BNR3Ru?=
 =?utf-8?B?MTREcm9ya0VaRThEYzduYmhtdHFlVVpDZDZNQytQM0sra1RWV1Z1dVdCMlhz?=
 =?utf-8?B?SzFCVTJFRE9OMytGSTVQbEY3Y0pSenFEMW5TSENJQmZCWko2dkJsWW5KYm4z?=
 =?utf-8?B?R3hTOUVLL1BwbDNNUy96U1ZaUzJtTlNXajMvZ2xRb2kzVUNoNWtIanczYTRI?=
 =?utf-8?B?NWpaTm9NVHRtWEkvcXJ0MVBmYUVsTUhVejdLbTdZV2x2Uk05L3NYOE14Y2kz?=
 =?utf-8?B?U2ExN1h1QllzYjM1Yjhjb1hjTmI4cEx4cnlYNmpWK3NPREFxODd4eWs0QVJJ?=
 =?utf-8?B?ajQ5UDgxSXJrT1VHc3JzOUg4TWdBc0dzT3VDdmx6cTIrS1BsbDR1dk1ZbHBz?=
 =?utf-8?B?N2M0WFRxNTJjUmszejY0SzEzcmg5N0E1SDREWFFWMUh6c0gvRllGNEdRZDRB?=
 =?utf-8?B?NnZkRzNTbHUvM0l2U1k1ckRVZ0RiTDBDWUJ1emlSUGJHcUUxaVNJVzl5dTR3?=
 =?utf-8?B?UXk3OWZGQUJzYVVBdHN6Zm9jTDlZdngxditySkNZQjZ1ZWlmWEpPV3RlZVJo?=
 =?utf-8?B?bFBTc2J1SkoxQmZHZkRZeE50UGozWXNIUjFCWXg4NXU5R2E4UEppR3VnbXdq?=
 =?utf-8?B?SU9TR0tIWjZoOVJlZjBwaHNvTGlEaUtkNXJvd212Z3FVY1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUlLT2FwYVhVeFIzamo0bFk1WEhUM3Nub3Jmd0dmMWNQaXA2WjNaV3RFZUZo?=
 =?utf-8?B?Njlkb3pWbFRVc01TV01YMGd0MHYxMmJFcXlncmtXY3pteFhIY2tFRkpRdUVp?=
 =?utf-8?B?UDFwSGtCeFVaQWlsVTVVeVRoSFU3d0V0eDVjZGE4T1JhWjVjL0p1MnNWTUxU?=
 =?utf-8?B?dlpEZWFUc1ZHcWZqTlNqS3htYzJWWjFJOGl2eURVTzZoVnJ1MGhrODBMVkdR?=
 =?utf-8?B?eHBHcEo5WmxBb2hUTmNGcnVyTnF2N25iSnVYOU8zZzlDNlFpdDYzY0M2ZFZ2?=
 =?utf-8?B?c1AyOW5FMWgyVXRiOUZsV3J0Y0tobEFmdTdnbXVYbnRWbGtHWVdGNXlJYnly?=
 =?utf-8?B?OFVBWXppVmJRWjJ3d0QyWERSUlFyc0ZteWdOY2hqS1FqUW8xM2JsQ2d2c1NX?=
 =?utf-8?B?THdsbWYwem5JNUhmRERQQWx0cTJmenp3aUZ2SGt1OHp5cHRXdUtWWGRMaklQ?=
 =?utf-8?B?N2pZcFpyNFNybzIybEpuR1doUEJjNHpGNkVpUGZXL1V4L082OVlhTmxxQkFR?=
 =?utf-8?B?d2RiT1lpUGlMcm8vT3MrNVFvOVVBU0xvSUY2c240dnNFbUE0QXRwUUZMUit3?=
 =?utf-8?B?T3JqaHV3MjNaOUV6Rko5TVlSdmpCOHN5ZGFselFDKzBubjhnSzlLNnVDeVVs?=
 =?utf-8?B?clp1VVpndjZIMEhOSDF1ckR3Mm51ZlppeUFmN2xaSFNTc0l4WXJqYndZQjRZ?=
 =?utf-8?B?b0RLd1VHSWQybUsxWHpCSlhJak5jcnJaQ2tpNzByWjBTdlltbUUveWJsemNw?=
 =?utf-8?B?b0xreHJyWlFSWGZYQVMrNG1wMUZMaFV5ZHFtajNEMlNUV2U3VE9XUXhwT1BM?=
 =?utf-8?B?eWhiUkNSY200R3M0WUV4OXBTdTJDZFJsd3NHaWx2MW9yNitKbFZNYXdlV3pL?=
 =?utf-8?B?dnN0YVlRNk5mZXkrOThmTWtHaitEUXZKU0IzTVFlUDlTWDYranQweXBsc1hi?=
 =?utf-8?B?SE5zbHpFRkdiY2x6Z2RWRyszSDFtOTRLT0w5ZXVzd2pvTU14dy9BZEk0NjVY?=
 =?utf-8?B?OUxtemJRbHFTZXZJT3p5Ky9nYmVRWkdwaW10bjNrRW4yYldyaVVySFp1RWk2?=
 =?utf-8?B?N1hKdGVZUUEzODkvRnNzWGk4bzVicVR6b3cwOStGM1Q5VWI5K0JIbzc1dXZ3?=
 =?utf-8?B?SkFIV0NudnN3aDgwYmtjSkIzWjRUeGlTR1daNVJhT2RwV0Fad3F2RS8vZ0I1?=
 =?utf-8?B?Z2xsamFraTZCZXNxSXErZlBBUWlacWF2VHBnSkZJQ29KWGRlQ0VTaXREZmhG?=
 =?utf-8?B?RHB3V2Y1S2RoTEwyUEpYL2pJT0Q3Y0d6TkdzcERBblc5Vk85VmxYUWsyZlVB?=
 =?utf-8?B?enhoMDNUQXI4VE9yVldBRmRFUmpyVXRuY0lMRHlOdkJxSzZ6b0phdDAvSnh2?=
 =?utf-8?B?a0I3dGNYYnFIUG5Ld3hsUXFRRE9rVHdDVmV2WlBiRThwZVh1RGhFQ2FwNHVB?=
 =?utf-8?B?QWI0MHZyQVpvZ3gwNkhxcThoZS9NSFVOMzB5bUdZckpIckptckVla0JNNVRz?=
 =?utf-8?B?ekk1aVB5ZDJ2Z1JyM3JtaWZ4djVURjZKeVF4UTFDa2lCSVh4aGZvdEFrMy9w?=
 =?utf-8?B?KzNVbEo1TllCN2hvNEl5TjJ2ZmdkUVNNZXJCbW1rRmdqVVJnbFRtT1pvbm5k?=
 =?utf-8?B?NlBNdGdMN1RBZWMyRFBtY3p4S3Qya2FybkRGbThERGlqY08vcFkzRy8rZjBO?=
 =?utf-8?B?Qy9ucDZEOGJKZlkwc2NFRzVCN3AvY2pFMk03TlpJaWdLUnprcTA1dEtZeTFn?=
 =?utf-8?B?bzlpOXVHQWdlOStkUm8rRTBHMlBtaGQwaEJNMUxwRi9xZVIrQi9jZEI1WEZK?=
 =?utf-8?B?c3FWWkMxb3dMZXRlR3J4UFdPZVNyT2NBd3paRkJYeVRMRTkvNUxHS0JvT1lh?=
 =?utf-8?B?a0ZKSWpmMjhGWE1UcVlBcUxVaXYwcVlZNGdIcFBSUEFPKzB2WGU1TTlFditY?=
 =?utf-8?B?cW5GUk04Q1c2eFpoc0JrMVBScVcxYzN2Z2hVNEJsT0lBQTZjNFgxRzJIQy91?=
 =?utf-8?B?bnllWGdCY0J5a1B3MVA3V3NIUE9ETnZHMC9xQnU5T280amJ3TGtxa2M2b3VB?=
 =?utf-8?B?Szh0SkdFWmQ5RGpCQnRVdjVGWFJXY1Bwanp0bHB6TmFUalM0R3hYbWoybGZp?=
 =?utf-8?Q?adIw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1656e71-273c-466d-595d-08dd6c0d288e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 02:23:12.6881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epGRPdn1Vy1PW5Lh6/TPUKtBZ8Yc4kAWTxo9v9H8Q4xJxJnlW+DMZNgEP57qqSqOucNc6XteU0P8phXzUpkeoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQpUaGFua3MsIEkgaGF2ZSByZXNvbHZlZCB0aGUgQUJJIGJyZWFr
IGFuZCBhZGRlZCBjcG1fY3J4IGF0IHRoZSBlbmQuDQpJIHdpbGwgc2VuZCBpbiB2NiBzZXJpZXMu
DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDI0LCAyMDI1IDEy
OjUwIFBNDQo+IFRvOiBNdXNoYW0sIFNhaSBLcmlzaG5hIDxzYWkua3Jpc2huYS5tdXNoYW1AYW1k
LmNvbT47DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dA
bGludXguY29tOw0KPiBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJu
ZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGNhc3Nl
bEBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgR29nYWRhLCBCaGFyYXQNCj4gS3VtYXIg
PGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IEhhdmFsaWdlLCBUaGlwcGVzd2FteQ0KPiA8
dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAx
LzJdIGR0LWJpbmRpbmdzOiBQQ0k6IHhpbGlueC1jcG06IEFkZCByZXNldC1ncGlvcyBmb3IgUENJ
ZQ0KPiBSUCBQRVJTVCMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJv
bSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcg
YXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiAy
MS8wMy8yMDI1IDEwOjQyLCBNdXNoYW0sIFNhaSBLcmlzaG5hIHdyb3RlOg0KPiA+IFtBTUQgT2Zm
aWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4NCj4g
PiBIaSBLcnp5c3p0b2YsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+PiBTZW50
OiBUdWVzZGF5LCBNYXJjaCAxOCwgMjAyNSAzOjIzIFBNDQo+ID4+IFRvOiBNdXNoYW0sIFNhaSBL
cmlzaG5hIDxzYWkua3Jpc2huYS5tdXNoYW1AYW1kLmNvbT47DQo+ID4+IGJoZWxnYWFzQGdvb2ds
ZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOw0KPiA+PiBtYW5pdmFu
bmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiA+PiBrcnprK2R0
QGtlcm5lbC5vcmc7DQo+ID4+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGNhc3NlbEBrZXJuZWwub3Jn
DQo+ID4+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbWVrLCBNaWNo
YWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgR29nYWRhLA0KPiA+PiBCaGFyYXQgS3VtYXIgPGJo
YXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IEhhdmFsaWdlLCBUaGlwcGVzd2FteQ0KPiA+PiA8
dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
NCAxLzJdIGR0LWJpbmRpbmdzOiBQQ0k6IHhpbGlueC1jcG06IEFkZA0KPiA+PiByZXNldC1ncGlv
cyBmb3IgUENJZSBSUCBQRVJTVCMNCj4gPj4NCj4gPj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9y
aWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXINCj4gPj4gY2F1dGlv
biB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5n
Lg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiAxOC8wMy8yMDI1IDEwOjI2LCBTYWkgS3Jpc2huYSBNdXNo
YW0gd3JvdGU6DQo+ID4+PiBDaGFuZ2VzIGZvciB2MjoNCj4gPj4+IC0gQWRkIGRlZmluZSBmcm9t
IGluY2x1ZGUvZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmggZm9yIFBFUlNUIw0KPiA+Pj4gcG9sYXJp
dHkNCj4gPj4+IC0gVXBkYXRlIGNvbW1pdCBtZXNzYWdlDQo+ID4+PiAtLS0NCj4gPj4+ICAuLi4v
YmluZGluZ3MvcGNpL3hpbGlueC12ZXJzYWwtY3BtLnlhbWwgICAgICAgfCAyMSArKysrKysrKysr
KysrKy0tLS0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdA0KPiA+Pj4gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3hpbGlueC12ZXJzYWwtY3BtLnlhbWwNCj4gPj4+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55
YW1sDQo+ID4+PiBpbmRleCBkNjc0YTI0YzhjY2MuLjkwNDU5NDEzOGFmMiAxMDA2NDQNCj4gPj4+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNh
bC1jcG0ueWFtbA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sDQo+ID4+PiBAQCAtMjQsMTUgKzI0LDIwIEBAIHBy
b3BlcnRpZXM6DQo+ID4+PiAgICAgIGl0ZW1zOg0KPiA+Pj4gICAgICAgIC0gZGVzY3JpcHRpb246
IENQTSBzeXN0ZW0gbGV2ZWwgY29udHJvbCBhbmQgc3RhdHVzIHJlZ2lzdGVycy4NCj4gPj4+ICAg
ICAgICAtIGRlc2NyaXB0aW9uOiBDb25maWd1cmF0aW9uIHNwYWNlIHJlZ2lvbiBhbmQgYnJpZGdl
IHJlZ2lzdGVycy4NCj4gPj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBDUE0gY2xvY2sgYW5kIHJl
c2V0IGNvbnRyb2wgcmVnaXN0ZXJzLg0KPiA+Pj4gICAgICAgIC0gZGVzY3JpcHRpb246IENQTTUg
Y29udHJvbCBhbmQgc3RhdHVzIHJlZ2lzdGVycy4NCj4gPj4NCj4gPj4gWW91IGNhbm5vdCBhZGQg
aXRlbXMgdG8gdGhlIG1pZGRsZSwgdGhhdCdzIGFuIEFCSSBicmVhay4gQWRkaW5nDQo+ID4+IHJl
cXVpcmVkIHByb3BlcnRpZXMgaXMgYWxzbyBhbiBBQkkgYnJlYWsuIFdoeSB5b3UgY2Fubm90IGFk
ZCBpdCB0byB0aGUgZW5kIG9mIHRoZQ0KPiBsaXN0Pw0KPiA+Pg0KPiA+PiBPciBhdCBsZWFzdCBl
eHBsYWluIEFCSSBicmVhayBpbXBhY3QgaW4gY29tbWl0IG1zZz8NCj4gPj4NCj4gPiBXaGVuIEkg
YWRkIHByb3BlcnR5IGF0IHRoZSBlbmQsIEknbSBvYnNlcnZpbmcgZmFpbHVyZSBkdXJpbmcgZHRf
YmluZGluZ19jaGVjay4NCj4gPiAkIG1ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0tbSBkdF9iaW5kaW5n
X2NoZWNrDQo+ID4gRFRfU0NIRU1BX0ZJTEVTPURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcA0KPiA+IG0ueWFtbA0KPiA+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0uZXhhbXBsZS5kdGI6DQo+
IHBjaWVAZmNhMTAwMDA6IHJlZy1uYW1lczoyOiAnY3BtX2Nzcicgd2FzIGV4cGVjdGVkDQo+ID4g
ICAgICAgICBmcm9tIHNjaGVtYSAkaWQ6DQo+ID4gaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVt
YXMvcGNpL3hpbGlueC12ZXJzYWwtY3BtLnlhbWwjDQo+IE1heWJlIGZvciBhIGdvb2QgcmVhc29u
Lg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

