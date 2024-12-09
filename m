Return-Path: <linux-pci+bounces-17919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8580F9E920E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 12:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5130216121C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CDF21884F;
	Mon,  9 Dec 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1SjkxoDJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D3218E8A;
	Mon,  9 Dec 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743318; cv=fail; b=rzEbscS1RhQ+sflTdWDw+v1N7hyUpt3vQKfhvpFScQSy1YcImQVZ2ZOe72lxkWFo91Q+gBWdyyfyY7OZBUXLEHgVRuP4JHPhlDGND1U+d78S85JxvJHdmjlZheF1INjhLY/t60fFmdMz5tZ+VP+sKwxmOPsSr3TG6xcS4MLb7qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743318; c=relaxed/simple;
	bh=097C2jCNE6DWOlvGzt4R453lBSaD6rnU2w61evA8+Jg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PY+L8AXPsunwsw/UBh1NiEQNC3Xx9oWZkdSnvAZXpInr/J0hpSXHp3kFfoxJpk12po9gsHk/mX7UWE+8HRnUHDY7XpAAG4TH27rtjgj1zhJKaQP05Qr1ybjRurZsxr/mXCx3sripCHa1E89xBqV8R0FcNc7QQh52P+5Ce/sxk7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1SjkxoDJ; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nD7a0FRSplBKwyo8CDfdlhYUX88T41xlg5PZAwMhZEm4Zg1MmB3o1xbTGoSIx1bC7bIPTdUfrFj7jWe2XjohfSCsGrl+8JICKVbCD9YN4BEn7CIgDd543nMUBBcdtyQyoUsg6vFBo90Rg7+WIebyAFLg0LyNfHRjzcwN+Zt24Xe7TTCSuSLdQs1l0TMXIP4HPLjeODX7iMcLYsR8s34gNBqeItq7vVqFPXgnMszW+dS5m7pkzWhMlUJ66g8L9PUM145qFOX//g6BQT6eON3WxQO4P39aGXFEZQLdqe99q94VhOT1AAGFbQIXILhkVJrkwSKVS4iC4NSrtVHJLHaNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=097C2jCNE6DWOlvGzt4R453lBSaD6rnU2w61evA8+Jg=;
 b=t/QMx+9z8nC3rYNmeL2W1kgXJ1P41aN9waLAyPs1MM0si3+Axoom5yDXAQ36az71pWSRh3oLDlNGRUIfo+z3pyD4vds1RkpwAL7XmFEz/bCTaHF4oH7MS7ZEQIIEK4O0JOtTr4m+GFvOMK0E8tJ+S2Clrk8bAgRR4KbL3CrRQS97LfcI7lHq9aYRQ34shLGGn7zfI6BfvHDlG7IRZO7F+K7PsThEcHcQ3HS8IrXSHMzwtu96w+WVyP3fR7G4j3fXFNvVT0Y8vm/AtrR5ZPcdDJkg2VENN+7jz0VP4lVKXIE2DKcloTAMz+QMPOLt1oAehtTAmzO0T1aaj6tt4BSaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=097C2jCNE6DWOlvGzt4R453lBSaD6rnU2w61evA8+Jg=;
 b=1SjkxoDJLQLmkk2e81ltuJpoYHBGARARoPQRyNL6xCMujMxCdAiA4gfG/elH1njMIJPMzQzq5k7Mx+K5ywOJWQ6SBh7LGFz4seyhvKBkydQEvjtNTBwZzNm59XM2ZdvcKcfGMd4EbhmFXxxNDJ+95Lur9X7EVVyeV4gEOBM8e5M=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 11:21:53 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%6]) with mapi id 15.20.8207.014; Mon, 9 Dec 2024
 11:21:52 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "Simek, Michal" <michal.simek@amd.com>, "Gogada,
 Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index:
 AQHbQMPBUsv/8qTDsEOX3G1ItJvCnrLOtysAgAPsY4CACbzOAIABLeMQgAAw+YCAABfm4A==
Date: Mon, 9 Dec 2024 11:21:52 +0000
Message-ID:
 <SN7PR12MB7201B7601A59ADDBB2C8CCF98B3C2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241127115804.2046576-3-thippeswamy.havalige@amd.com>
 <20241129202202.GA2771092@bhelgaas>
 <SN7PR12MB72011B385AD20A70DB8B56338B352@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20241208125858.u2f3tk63bxmww3l6@thinkpad>
 <SN7PR12MB72012B3F617DCE9BC398227C8B3C2@SN7PR12MB7201.namprd12.prod.outlook.com>
 <E73C5B2C-A594-49DB-9AF6-F2E3FDE972A4@linaro.org>
In-Reply-To: <E73C5B2C-A594-49DB-9AF6-F2E3FDE972A4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|CH3PR12MB8581:EE_
x-ms-office365-filtering-correlation-id: bd0b030d-a3b9-4d31-a308-08dd1843aea6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1FKbGRWWW5PZjkxS1RyNC8wSG1RU2hzMldBMFNqWTZSMzluWHJVTFpkNzFE?=
 =?utf-8?B?WFBzZzkxVVNERld4UEpZS1R4ODcrTVFLZEd0c0M5WjZVOHNuWjV0WUQ4bU9p?=
 =?utf-8?B?THhwTkFCeEhNSS9ZeTREd1pwSTd2bXIzdXZjQlk3SjlvRFpMNDdlVzdSeGg5?=
 =?utf-8?B?aGRtcElXODFoOWNpZmt4dHFveHZJNDdLU0UyOWlER2xCYXJiSERUNVhPcDRi?=
 =?utf-8?B?b0dIVy9LZXR4M2lCVWU5K2xCbS9wSW9CVzZ5emsrd1RlTXFPNzhoVm84Ri9t?=
 =?utf-8?B?eDdObXhDOHYwS0FmTWhhNS9ZMVBhZituSEkvNjRhdEVwcmlSSi9XNmNHRk5z?=
 =?utf-8?B?TzRqZUJyVzcxbnJrcktNRFY1c3ZLTjd4d3VQWWV0bDZla2ZBRDJDOW0yRmN0?=
 =?utf-8?B?QzFYeXE0L21zaVNUYmlGTkZHQlZWNW4vOURQKzJYWFRZZ2tKbFRiODRiMm40?=
 =?utf-8?B?ckwrS1F6dkh6ZHNVR3pYelNIMm1Ua2pHM2s3R2Z1Z0tkZHdPZXVObGhNQ0k0?=
 =?utf-8?B?SERyY1lvTGMvbklhUmtrM1ZBZnNIa3lqVVBhV3NBZ1V2TXI3b1Rsd29EZ2Vp?=
 =?utf-8?B?bnVkTFdxOVZ1aVo5bDVHWlViTnNuRFo2ZUw4QXFLdXNMc08yT2xCdlBkQmtx?=
 =?utf-8?B?LzR4VXFHejlsWk9lWU52WSt1WlJCSHdmWko0V0RHVmJtSWhVQWlkTnNiNG1a?=
 =?utf-8?B?bEcrVmtRV2lEWlNGTGxlVkcyQ1VpOFhrQ1Fyc0hGblY2djdnYjlybHVMVHQz?=
 =?utf-8?B?ZXBYRTAxdHlvSVZFMHF3Z2NWVElEK1lFZDZaZWhjV2FVcVpwRVdyY2xEbVJT?=
 =?utf-8?B?a05jSWlsblkxM3N2SndBUlF4Wk9ndGVUMEdwaWF5NWZQOXJnU3VLUmlUckJ4?=
 =?utf-8?B?MzZNc3c2MXU3Rm9XaWxROFJRSkV2WTNvZlREQ0lYZkhMNUw0bFJRcDRIT2hT?=
 =?utf-8?B?K1UrRWFqdTVxTEJDOWorSHVrTUt0Z3hFV3pLbnFZTS9oalFVMVFrbEdETk53?=
 =?utf-8?B?N1Jxam16QlRNN1NMS0w0RnpsS0x2MC9Gd1RTQnJRLzhIMzlPVXZvVzBuc21w?=
 =?utf-8?B?QndhWFlzdndqdlZWdVZRdEozUGlqWkJpRzZ2aE9WVkk4VUtlcUduYitvL3Vz?=
 =?utf-8?B?aGduS1BMek9xc1JBZ3V5UUxoVUoyYk1Gdy8vQ1cwU09aWGFrK0xNbDd1M1lO?=
 =?utf-8?B?eFlSZFIwYnNMN0xPMng4OHNZb05ZTGtnV2xucFU3azJpZjJTclpUNlFtS0Ux?=
 =?utf-8?B?K0ZQWnZySmRDMDlMRHFsVURmeGVUQytQUkhUYnVqdHdjQ2hRTEFJL2krVGU1?=
 =?utf-8?B?eFZLM2phYUtjb0tGV1REaDBSVHI0dkVSL3dzaStWbnhjV2lHQzJobGZscnlj?=
 =?utf-8?B?TXJrYWNmMEVEL2xBTlJKdHZIRE1HSGVwOUVxMDVTTUN4QStUZHB2c2k2SEVa?=
 =?utf-8?B?eEtWK1lEWnVSNDdkU1lRTXowUTdpZUVsZDNEOVljZzBNR3FzZFkzOU1IaFFD?=
 =?utf-8?B?TVdpTkVkWnJZZWNoOHo1SDc2eHdPWks5NDdnQVVHK2xydG5STXVQYmlUZk1v?=
 =?utf-8?B?NmJJOHZ1MzdyNGl6c2tTaG9jSldiaTRNRWQxdzYySzZyZ0wxcWdaZmhjdmtq?=
 =?utf-8?B?TFo2VWNMYWlMNkY4bnM1QWxQYlBneitLcXp4VEgwa3hHME9qaE9xS3V3OWNp?=
 =?utf-8?B?ZzU5T2FhcGdYRVU0NVJGZ3l1SUdBQnZtVG9QTXZUdzhVRi9mK3lJR09TU1hq?=
 =?utf-8?B?Q0JGRXNGdmg3K2VpTnVGSGZ3bHFZS1pucWtNaTlOYTd2em1TNEp1YlBtaVlv?=
 =?utf-8?B?eUo5ZzFqR3NsNDNxNThneGhNMzRCM0x3K3p2UnkzcFlNU1pmYWMvUlhPWWhM?=
 =?utf-8?B?ekI5ZmxIdUc3OWJtM2VFNDUxY3BwWDlrR1c0bmxOYkhFb2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjVHZG9Ed0M5VFlicFprTEdydkNQRVNFSGFYNGoybXVoNk1lSmRsKzU0d0oy?=
 =?utf-8?B?YlhmNU9PUXJoMkZrTmo1ZXY4MURCMWd2dk4yay9CQm15VjBpeUpDZ1IrbGtT?=
 =?utf-8?B?d29YSzMxNmVId2pvTzk1Snp0U0FxMzNMeHIxT0gvWEcrT3AzbHF2WnFkZzVR?=
 =?utf-8?B?VzBoSkxTa1QvYm1IUlZkd2xUdm5VRnVQaVZ3QlNZT1dxS3VlcVVCYzVSbnZH?=
 =?utf-8?B?SXVvc2JTeFF2a3pNNlhsQThSK0xUbERxejQ3RE5LZ0pFSjZwWEE2VnNvRWx6?=
 =?utf-8?B?RExpbjhHTWErMnpPRmR6UGxXa2dkOHZyc212SnFGV2lUTFRHVmVCazhWNlRs?=
 =?utf-8?B?eDB2SDlZV2JFUW5jK1d6YytnRm1HY3IrclEwcFZ2SUFDeHNBVXlzSlJ1UVN2?=
 =?utf-8?B?clBWZEJmNXc0allwcE5wTm5GcWNjaWp3RkdHL1Jib05HaDhab2J3OEN3QmdZ?=
 =?utf-8?B?KzMyV3oxcmUxZE9zMlY0WHovck1qU00zWjRjS2lUWjNCVUJEM2NmNmRzdkRS?=
 =?utf-8?B?NkNtdnhoWTRGQy9CSzB6SHJrcmJaVHRTVkJBaTIzL3J5QlJaa2ZmZ0tkVjR2?=
 =?utf-8?B?bmdaN2RYTlQvc1VaUWEwbmx0amlVVjJaTmlQODlybFpFMkhtOXJtTkczSXRh?=
 =?utf-8?B?ZGdaQXJHWVY5NTJWSFVvZXhDcmNqNFhXNUNvRXo3bmR1aFFTRzZnemEyK2Ri?=
 =?utf-8?B?ZWtVRW1jb29zeVVZZElMcjhseWhaR2FSamxiM2RhS3U3Nk1wMjUrVUhzNExQ?=
 =?utf-8?B?N29DQjZBTTAxb0RGaDY1RTlmY0JSTUZlc0NNUEdqV2RQeTBEell2Nm9oMzl6?=
 =?utf-8?B?eTJrUm1hTnVocmtBTWNiRHJOTXNtRFpabHNCUTlmZTk2cmkzOFZ5NHFnZ1ZR?=
 =?utf-8?B?U3QrT29zdzhESXVxZ1hjUXJ6NHM0K3EvMlZGOFBlQjlwVTdVQjc0dFR2bjlm?=
 =?utf-8?B?K3FremJNR0ZiNmNjRUlKZStuQ3luc3RpT1NKNHpVd1YvMUJBTzFOOTRBbFZZ?=
 =?utf-8?B?cDh4a2xZWDJNbjErUkVCdTRPWmRVUE9tKy9WdWpmWEJIYUp3U2QxZFNpNkZa?=
 =?utf-8?B?NFpoZVNnWGIrWTROZFB2cW5XOHVFNTFJbXZWL3ZwR1ZvM2diVnJ1eSs3bXRH?=
 =?utf-8?B?aHhTaURMc3h1OTNYb0VsQU1ETVY0YjBBMEdVdmFKYkVGbzgvWUQ0VDdBUXlq?=
 =?utf-8?B?YjFDbHVZdkNWdU5wREU4L2dLN3V1SURRMW8wQjZ0cWN4Rjc3VE8yQ1Z3ZUZP?=
 =?utf-8?B?Tkh2S0Irei9MR2NIZmJjTHo2aEZkRHhlMk1jYk8zaXB6ZUNEZ1hpRnpsdStB?=
 =?utf-8?B?VkptNTV5V3FzcDRDSWNHYnlyMllyaGJOZldqTmNqYUd5Q1l2cFU1aFRERXRz?=
 =?utf-8?B?R2tGOUhldHBFeFZiNkhJc1RBNmdlV1EwVWJ4b0N1WENuY3Z3Rk9TS0JaY1Vy?=
 =?utf-8?B?Q1Z3ejBWdnhjOGJGNkRuU2RzcnZMUTNCM3lNa1BVeGhKbHFLdWttSnpGL3VM?=
 =?utf-8?B?SE40cE1MMWMyZ2hqaDZYYitMNFZiVmFmR1Y5eGhrZC9tK0hvVU9jbHFMVkhY?=
 =?utf-8?B?bFd3ZWJHL215bzhjQ2djZjVxNk1pbVJFdEsrUGRKZzZTNnpOUUU1RVFOYURD?=
 =?utf-8?B?ME1vVDhkUzc0WFhOUC9qVmJsVDVpdkNUYlJYTi9ra3JtU2VVOTBxZDBEdWFw?=
 =?utf-8?B?c3hYaUlmT3Qwc0JaUHI0MHR5UThicWJOMWZPMGZKWTZMSkp0YlRpVDFBWmlm?=
 =?utf-8?B?NWVQN0g0Uk16R2dIazhDb2tOVVpKVzdsa0N0SmhPYmdWc3F5ZDlSVGFYbW5N?=
 =?utf-8?B?MHl2MkRXNXp1L0VvZ09IK3YzbHZFU0pWSDhSejlVZWgrR05vU21Qc1Z2NGNw?=
 =?utf-8?B?bUpGbDQ2eE9teFExa1R0SDd5cEl2TXo1MW5yd2l5NVJVSjJoSVh6WDZTcjZV?=
 =?utf-8?B?UmJNbGo1UGhlWTZKWkJlbVdYQ01qaEUyYVZ4OUMwK1d0ZEZqNkhxaW1IVCtl?=
 =?utf-8?B?UTA3cjlPT0lkUStldUZuUjFkbXdPNkRNalNNdjZ6U0gyK25WaEhRenIyWGFI?=
 =?utf-8?B?Ti8yY29hTzdrUnlsVHArQ2tSSFNPTVB2a0cyc0ZNeHpWN0dIbTNucU53YXgx?=
 =?utf-8?Q?cqSw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0b030d-a3b9-4d31-a308-08dd1843aea6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 11:21:52.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEySdjwv2Q+WUijB3ETDVoDq56tizynKmHffsSPX6icw5cAzn9ebLol4ZPVRVwIQPljImyZvRG/0BSTtQN+vMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581

SGkgTWFuaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFu
bmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50
OiBNb25kYXksIERlY2VtYmVyIDksIDIwMjQgMzoyNSBQTQ0KPiBUbzogSGF2YWxpZ2UsIFRoaXBw
ZXN3YW15IDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tPg0KPiBDYzogQmpvcm4gSGVsZ2Fh
cyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gbHBpZXJhbGlz
aUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJu
ZWwub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGppbmdvb2hhbjFAZ21haWwuY29tOyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT47IEdvZ2FkYSwgQmhhcmF0IEt1bWFyDQo+IDxiaGFyYXQua3VtYXIuZ29nYWRh
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8yXSBQQ0k6IGFtZC1tZGI6IEFkZCBB
TUQgTURCIFJvb3QgUG9ydCBkcml2ZXINCj4gDQo+IA0KPiANCj4gT24gRGVjZW1iZXIgOSwgMjAy
NCAzOjE0OjE1IFBNIEdNVCswNTozMCwgIkhhdmFsaWdlLCBUaGlwcGVzd2FteSINCj4gPHRoaXBw
ZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+IHdyb3RlOg0KPiA+SGkgU2FkaGFzaXZhbSwNCj4gPg0K
PiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBtYW5pdmFubmFuLnNh
ZGhhc2l2YW1AbGluYXJvLm9yZw0KPiA+PiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5v
cmc+DQo+ID4+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIgOCwgMjAyNCA2OjI5IFBNDQo+ID4+IFRv
OiBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+
ID4+IENjOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+OyBiaGVsZ2Fhc0Bnb29n
bGUuY29tOw0KPiA+PiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBr
ZXJuZWwub3JnOw0KPiA+PiBrcnprK2R0QGtlcm5lbC5vcmc7DQo+ID4+IGNvbm9yK2R0QGtlcm5l
bC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGNvbm9yK2RldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgamlu
Z29vaGFuMUBnbWFpbC5jb207IFNpbWVrLCBNaWNoYWwNCj4gPj4gPG1pY2hhbC5zaW1la0BhbWQu
Y29tPjsgR29nYWRhLCBCaGFyYXQgS3VtYXINCj4gPj4gPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1k
LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIFBDSTogYW1kLW1kYjogQWRkIEFN
RCBNREIgUm9vdCBQb3J0IGRyaXZlcg0KPiA+Pg0KPiA+PiBPbiBNb24sIERlYyAwMiwgMjAyNCBh
dCAwODoyMTozNkFNICswMDAwLCBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgd3JvdGU6DQo+ID4+DQo+
ID4+IFsuLi5dDQo+ID4+DQo+ID4+ID4gPiA+ICsJZCA9IGlycV9kb21haW5fZ2V0X2lycV9kYXRh
KHBjaWUtPm1kYl9kb21haW4sIGlycSk7DQo+ID4+ID4gPiA+ICsJaWYgKGludHJfY2F1c2VbZC0+
aHdpcnFdLnN0cikNCj4gPj4gPiA+ID4gKwkJZGV2X3dhcm4oZGV2LCAiJXNcbiIsIGludHJfY2F1
c2VbZC0+aHdpcnFdLnN0cik7DQo+ID4+ID4gPiA+ICsJZWxzZQ0KPiA+PiA+ID4gPiArCQlkZXZf
d2FybihkZXYsICJVbmtub3duIElSUSAlbGRcbiIsIGQtPmh3aXJxKTsNCj4gPj4gPiA+ID4gKw0K
PiA+PiA+ID4gPiArCXJldHVybiBJUlFfSEFORExFRDsNCj4gPj4gPiA+DQo+ID4+ID4gPiBJIHNl
ZSB0aGF0IHNvbWUgb2YgdGhlc2UgbWVzc2FnZXMgYXJlDQo+ID4+ID4gPiAiQ29ycmVjdGFibGUv
Tm9uLUZhdGFsL0ZhdGFsIGVycm9yIG1lc3NhZ2UiOyBJIGFzc3VtZSB0aGlzIFJvb3QNCj4gPj4g
PiA+IFBvcnQgZG9lc24ndCBoYXZlIGFuIEFFUiBDYXBhYmlsaXR5LCBhbmQgdGhpcyBpbnRlcnJ1
cHQgaXMgdGhlDQo+ID4+ID4gPiAiU3lzdGVtIEVycm9yIiBjb250cm9sbGVkIGJ5IHRoZSBSb290
IENvbnRyb2wgRXJyb3IgRW5hYmxlIGJpdHMNCj4gPj4gPiA+IGluDQo+ID4+IHRoZQ0KPiA+PiA+
ID4gUENJZSBDYXBhYmlsaXR5PyAgKFNlZSBQQ0llIHI2LjAsIHNlYyA2LjIuNikNCj4gPj4gPiA+
DQo+ID4+ID4gPiBJcyB0aGVyZSBhbnkgd2F5IHRvIGhvb2sgdGhpcyBpbnRvIHRoZSBBRVIgaGFu
ZGxpbmcgc28gd2UgY2FuIGRvDQo+ID4+ID4gPiBzb21ldGhpbmcNCj4gPj4gYWJvdXQNCj4gPj4g
PiA+IGl0LCBzaW5jZSB0aGUgZGV2aWNlcyAqYmVsb3cqIHRoZSBSb290IFBvcnQgbWF5IHN1cHBv
cnQgQUVSIGFuZA0KPiA+PiA+ID4gbWF5IGhhdmUNCj4gPj4gdXNlZnVsDQo+ID4+ID4gPiBpbmZv
cm1hdGlvbiBsb2dnZWQ/DQo+ID4+ID4gPg0KPiA+PiA+ID4gU2luY2UgdGhpcyBpcyBEV0MtYmFz
ZWQsIEkgc3VwcG9zZSB0aGVzZSBhcmUgZ2VuZXJhbCBxdWVzdGlvbnMNCj4gPj4gPiA+IHRoYXQg
YXBwbHkgdG8gYWxsIHRoZSBzaW1pbGFyIGRyaXZlcnMuDQo+ID4+ID4NCj4gPj4gPg0KPiA+PiA+
IFRoYW5rcyBmb3IgcmV2aWV3LCBXZSBoYXZlIHRoaXMgaW4gb3VyIHBsYW4gdG8gaG9vayBwbGF0
Zm9ybQ0KPiA+PiA+IHNwZWNpZmljIGVycm9yDQo+ID4+IGludGVycnVwdHMNCj4gPj4gPiB0byBB
RVIgaW4gZnV0dXJlIHdpbGwgYWRkIHRoaXMgc3VwcG9ydC4NCj4gPj4gPg0KPiA+Pg0KPiA+PiBT
byBvbiB5b3VyIHBsYXRmb3JtLCBBRVIgKGFsc28gUE1FKSBpbnRlcnJ1cHRzIGFyZSByZXBvcnRl
ZCBvdmVyIFNQSQ0KPiA+PiBpbnRlcnJ1cHQgb25seSBhbmQgbm90IHRocm91Z2ggTVNJL01TSS1Y
PyBNb3N0IG9mIHRoZSBEV0MgY29udHJvbGxlcnMNCj4gPj4gaGF2ZSB0aGlzIHdlaXJkIGJlaGF2
aW9yIG9mIHJlcG9ydGluZyBBRVIvUE1FIG9ubHkgdGhyb3VnaCBTUEksIGJ1dA0KPiA+PiB0aGF0
IHNob3VsZCBiZSBsZWdhY3kgY29udHJvbGxlcnMuIE5ld2VyIG9uZXMgZG9lcyBzdXBwb3J0IE1T
SS4NCj4gPg0KPiA+VGhhbmtzIGZvciB5b3VyIGNvbW1lbnQsIFllcyBvdXIgcGxhdGZvcm0gc3Vw
cG9ydHMgcGxhdGZvcm0gc3BlY2lmaWMNCj4gPkVycm9yIEludGVycnVwdHMgb3ZlciBTUEkuDQo+
ID4NCj4gDQo+IE15IHF1ZXN0aW9uIHdhcyBzcGVjaWZpY2FsbHkgYWJvdXQgd2hldGhlciB5b3Vy
IHBsYXRmb3JtIF9vbmx5XyBzdXBwb3J0cyBTUEkgb3INCj4gYm90aCBTUEkgYW5kIE1TSSBmb3Ig
QUVSL1BNRS4NCg0KDQpZZXMsIG91ciBwbGF0Zm9ybSBzdXBwb3J0cyBBRVIvUE1FIG92ZXIgYm90
aCBNU0kgYW5kIFNQSS4NCg0KPiANCj4gLSBNYW5pDQo+IA0KPiDgrq7grqPgrr/grrXgrqPgr43g
rqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQoNClJlZ2FyZHMsDQpUaGlwcGVzd2Ft
eSBIDQo=

