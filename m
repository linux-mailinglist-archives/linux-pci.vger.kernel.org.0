Return-Path: <linux-pci+bounces-25721-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FEEA87093
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 06:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E4B17A7CB
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 04:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF0383A5;
	Sun, 13 Apr 2025 04:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M6tloXeR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9A2AE68;
	Sun, 13 Apr 2025 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744518133; cv=fail; b=g8Cp/LMdceLJUroDIvOOc2nhytit0Bb9McVfD2SPfL5OXdBM/AxtAsiN3qq6fG10zwQXISPSDc8xSYqEuFRWZOgao2oLOLr1VFHu3bjWSNaGcK0aknuns7AMpx2jIYya7LyJzNmv1j/lru5jvkMsf02i021qfi5VyUQb1hH1zAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744518133; c=relaxed/simple;
	bh=nhQbu0CQKrZ/QNgj9sw1dMHfRBgTaf3M0LTACdtph7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AsveGOJHJJW3sGJW0NYIIjUKttjgZhnRLPbIB0Nlf7ROckbF49rhbsB5RKYJYit/iEArQIpMpMlYxtLXeHdYaZFNoWeZq0iU54wg7Bmxf40rToQdDb+f22Ua7LayjksCU8zi0iH8jTRePxAl3pOvMkRk7xTCPzfcrk28qunoEtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M6tloXeR; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVSI/xP0FMvhE0n6UTQ8+ETafV/CkqLnVH8l+k4kB9GXRJwSp7NdwCsqX2Kkl+GM2Hp0+ZYfihVbrF7E15iTFA8m3BZ1Yk81vGNPyN4MkgS7o4oOF5Uu4yolybDY8ghdNSnl+tYNq42oZTqwAd02S2sPpZgSgDvp4sgo+WA6UmqAkzhhhdzaUevV7iW18JecB1jmWTyif5KcdzGMpJbEhTCLLVjxbYHLqEPhLydZyh0DkZxoyWqQtzqDASqgliC8Ypvus1z5MafvAX4egKSjCWuK6CbRYxBlqS8yctm9EMD3zR3dvNpD2e1+bpG7pX+9NlkO4MgZJvMWbVY4J2JzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhQbu0CQKrZ/QNgj9sw1dMHfRBgTaf3M0LTACdtph7I=;
 b=LT7RtN3F57KxGpJ2FrCrUYU62iJSzv1R9wO0/ewrLNG7I1uPY3RBWwNW9nfL4vSSM3dQSKUZkrh8cw/xrXkpZJiw/LBHiDzeSAS0/Zo2ZwNCcQ8MJwS/4yD47MgpstybkRvE6fgxBTs+GhYnz3NaV+/EaPJfr9pN7UUJFoNlmEUqqzlq1T8Cgj+j2NzYltHoU3GWlkBYrJ3487WEZ4mQz3dRS6JFDe2XK7Z7B89la0WKySc4hi3DI6nvRBOC/eRmdi4YBrQIsm7aEUe4AVlhhfGsOHrDI1K8TfKDaolXcHPBVbZy8K8oEGwj9tetprUx/XobIW6pRWjRO3rjSRgcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhQbu0CQKrZ/QNgj9sw1dMHfRBgTaf3M0LTACdtph7I=;
 b=M6tloXeRNFFXLAWZDC/q6mgHI04vzkaBKTnExBCL6B0eLV5jHtTxbm8mWo/GkCgsZr5SMuwjWU8P9vTYqqAmRhHGMAwsm6BUJQUbdypN9Zf34gsPGy3dfqDAPZR0JCOPYMraU4jD02Iufc7ZZ1lQM9NZbPwFRZldJ2cdEbmANwI=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Sun, 13 Apr
 2025 04:22:08 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%7]) with mapi id 15.20.8632.025; Sun, 13 Apr 2025
 04:22:06 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cassel@kernel.org"
	<cassel@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Thread-Topic: [PATCH v6 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Thread-Index: AQHbnfbpjrXLjxd/8EKiaV/Ed5MZLrOHPpIAgAAL/ICAC9f18IAAAzgAgA31JyA=
Date: Sun, 13 Apr 2025 04:22:06 +0000
Message-ID:
 <DM4PR12MB6158AC2A27BD6D7AF8C852C0CDB02@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250326022811.3090688-1-sai.krishna.musham@amd.com>
 <20250326022811.3090688-3-sai.krishna.musham@amd.com>
 <cjrb3idrj3x7vo4fujl6nakj3foyu64gtxwovmxd4qvovvhwqq@26bpt5b4zjao>
 <f65db82b-fedb-43d8-9d61-53e1bacda3ba@kernel.org>
 <DM4PR12MB61587CD51275A8E63A9B704ECDA92@DM4PR12MB6158.namprd12.prod.outlook.com>
 <45429e61-9219-42ca-b901-ff9508b9e985@kernel.org>
In-Reply-To: <45429e61-9219-42ca-b901-ff9508b9e985@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=89ff0f4c-3836-45eb-9552-993477934a01;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-13T04:20:36Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|SN7PR12MB7936:EE_
x-ms-office365-filtering-correlation-id: 218710e8-e4e4-4a04-df24-08dd7a42c01f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T0hCSEhuYmxPbE93T0I5S1RYUGJSK0dGMllZdkUwMFBIV0ZYL1RNd3k5RGFW?=
 =?utf-8?B?MS8rRjRuNFRWUUlaWDF3M2ZMNTMwcGEva0xkZlQwbkdrd1pKcmN1Yjd2cFdt?=
 =?utf-8?B?NktqamUycDdoZ2cwZGtOTTcwNEJKdHNrbFFIWnRjcFFQUVkrb1ZjSVlxSU0z?=
 =?utf-8?B?d0FnUm1Uc3dwbEpNbU10TnR5cGtadG5YeE4wN2VNYy9xN1dHS0JJVmVwTnVa?=
 =?utf-8?B?K2RwTDJ0eTdlR2hMOFllNENia0k0b01HTWtOK3M3N01IbTR2WE5oNm1XaUxL?=
 =?utf-8?B?NUVtaC9YczhsblprNXNWSC9ub1hzUUI0QlhEOFdUdVIrSTUvRlhiQ2ZGdXZJ?=
 =?utf-8?B?b2RJT1JvaG81UStCNWRSVGM3WEUrWk9WYU9oUEpWa0FCMXczQll6bEZqeThY?=
 =?utf-8?B?RlNKa2FoYVdQNmZCRENFeEVVcnBYN2VXOXlNLzdNNVc3OWFwRzFGRGQrT2lT?=
 =?utf-8?B?M2JITGtBbHFRL0owaGMzRlkrNjhYL2JHVGFkVm5VU3BNNTFkMEpLc0NRMDhQ?=
 =?utf-8?B?N0tXcmcwa0JRNDAyUnFkM2RPWllRY0hXdW5jbTBUUzZpYjJGTDBNLzA2WTNo?=
 =?utf-8?B?TzFCSlZwVCs5NWZFL0E0Tlh2UUJqTUNCaEI1N2xVMUovWUVnSy94TG5vaXVC?=
 =?utf-8?B?Z1dNOEg0YnhsSHFLSEZicUdrM0FSanRKSGlnUGxwS1dJS1ZWK1lXWVpyNkV1?=
 =?utf-8?B?ZXBmUm0vb1Y2eTRHMDJrMUdEMjNHc1RtY05oVVJZMXhFWTNLbm1XS0NHZy80?=
 =?utf-8?B?VTBJN05mVDVLR2YrTkRTRXo4Sno1cm1YWDh0R2FOQUJhT3VIUlV2dmJFZUkx?=
 =?utf-8?B?NitLSlQ1cHU3VVV4cittR1VWcHpiYlQzVXNGaUZGaHYwSm9mdE51dGZaTTdm?=
 =?utf-8?B?MDVYZVJYZnlXL2VYUSt2T2c5Tkd3VUJhVVl3S1VPR1cyeHBra25sanZoSzF6?=
 =?utf-8?B?aldFc2NVcngwNHFSd1phdm5UaWZYT3ZTclZNS3FlVlJUU2RsQ0ZkcHltdnh4?=
 =?utf-8?B?ZFo0UkJuTGhrR0dIMnRQVG1UM09rVE90eXBsclZ5SVFibHloNFFMR0FZc1Rp?=
 =?utf-8?B?M3E3VHJSTzFEMmxNdFNMbkY0L3dsOVo5ME5DL1cvNXMxMlZob09BbzFnL3Vv?=
 =?utf-8?B?VFEyOHczZENHQlBzU29yV1M1R1JqZmJseU1ScFRJQlRmWFBEVkU1aTQ0dllK?=
 =?utf-8?B?M3NTbWIvYUk2Q3EvVWJqUXFPcUV5L1RPbTFMZjgrSkYzUXJWVXF0OFZ3aVMw?=
 =?utf-8?B?ZEt5aVkvNDBDMWIrVFIrU1lZb2JXRFBORENCSW9LanZRRi8rS3NJZzJQWWto?=
 =?utf-8?B?eXNORmRtc1IzL081WmJLNE9ORHhJVEhQb2hRd1RzQ215OUhJeWNpbVFaU3lq?=
 =?utf-8?B?SkdQazNuVzY4R20rS0NWb2RRbVpaQXRJb0ZkNEdYTGo3MUZZb2RqNldnbEZk?=
 =?utf-8?B?UHFmOFZDbmU4Qkx6a2hmOXVNUGl2cWJrNkFSVHo1MEtWTEFXbTNKRmlYVEpN?=
 =?utf-8?B?S3NraGkwOXVzTGpQZjQydDRidzRCY3FXNjFTUkNGZXF2YTVhM0xyM3Bia0tO?=
 =?utf-8?B?bzFwc0g1OUcyc0h3QmU3bFlBUC9ueDhVSTN4cFlSNitBRmo5dzZvamwxcXhy?=
 =?utf-8?B?L08xL253VU5Xbk15OXE0a2FRYkxGSmp5NkNqNk5WN1JBcFFDa3ZmNDkrK0Mv?=
 =?utf-8?B?bDZiMk5oQVUwVFZGVlRvZ282cEg1SmY1UTQvTFAvRkt1SHZtQnNMalp1ZXJv?=
 =?utf-8?B?MHJIbkZ0SHhHckRIQmxmTW8zZTBUTWRNZjd2anIxc3RVdWZLeENmZlRhUFhV?=
 =?utf-8?B?QVBDeUNNUVlZZjFUWjdVMURycWtXMlluVVRIcXJaU1VobjEvOU11Z2JiWW8x?=
 =?utf-8?B?UytmanpXazBlZEJlRnNPKzkvZjhPeUtwUzA0OGRubnd4dmd3d1B1U2tROWpH?=
 =?utf-8?B?Q1UxdVc2SHRVKzFiYjRmQ2tBMnFmRklEQ0c1dFdpTUZrdjd2S1QwcmVPVER1?=
 =?utf-8?Q?+YecAwqjxX+1MwVXLCqOYIYleYk3E4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTdOUm41Z2JySEZvMjBwTlFjeVhhWmVNSGZPRE1BYzhOYUw2b0RLVGVTb1dT?=
 =?utf-8?B?NDlJZnNGTithbjhxb0xOV3VKTUY1Uk1zbndPc0ptSDRXc0RZdGJCSzd5MjRs?=
 =?utf-8?B?T0VNV0ZVM2FIMjhoYk55RVJqSlJzaEV0bTMxL3VMOXhRaitPZzAxKzhCaitt?=
 =?utf-8?B?QXBmVjRqOTB4Y3pGWHprSW5OM0paNjNzS0lNYzlLQWRuVmFqWlFsbmprZ3Bn?=
 =?utf-8?B?VDdjRHd1amxzY205WXNWcUNLTFdUMGUxWTA0ZE5Tdk5xVTM0dnVyWHZyZ2dh?=
 =?utf-8?B?RTNBdi9zaDZydnhPai83VUZuNVo0eGFxMHF2MjdESGhBeTYyUmYvUzJ1Y2tl?=
 =?utf-8?B?OTlRb2xhL1lUeEh0NFBya0x5OUFKOXZITUd5VmZMNi9VOEJIVURIVUJ2ZmNt?=
 =?utf-8?B?dDhsazNWQStyd0ZnaHNsWXZVUXkzbEdCRjlRbWdzWGV3ME5MdC9MZEUrbFI2?=
 =?utf-8?B?WEJlNk9TOHN6VktrVFlDcUFvN2tzdXl2cEdhcVloWWdLK2c2S3RtaWh4VW5x?=
 =?utf-8?B?OVRKc1BiS2JrL2poVmxOeURMdHoxVG9IbklzU0JFZGVEUi9zQ1UwbkQraXdW?=
 =?utf-8?B?QzNPZnRLVThPRENtZDd4TVM3YkxlT0pIZlMxRmlNMGM1dkZqVWFmS05FWm44?=
 =?utf-8?B?Q05GV1ZreFVrVVlYYVBadFpiazRHOGI0MDZCTm91enlGOXRVQkE1UldTb2Yx?=
 =?utf-8?B?eW5HQjNLRXQwd0FLNktGYzRsM0xuTGVjV3VIWTJZMkd0a0NpV0dYWTJ2Mlcv?=
 =?utf-8?B?bWExT1MzaGlKeXRvak9hakhnMTUvNGJaRkt1WGE4RHlYclg4elhCNmFCa290?=
 =?utf-8?B?MDVxTzJxSFNzZFlqbFJ6OVZOL0VDdWo2UUtFSHByN2xRYndnSkFWTlBzZ1p6?=
 =?utf-8?B?WGhiZVN0aitSYmJ1dS9wbEwwQ1dUWnUzTGpDNzhOVC9sZGJkQmxKM0x4aUpr?=
 =?utf-8?B?Mk5VamdoNTBac0hhaGIrN09raFNnWlJUSENqNkxabVZtRnZCdVIxakVxeFZP?=
 =?utf-8?B?VlBHYmdFdDBIMmxqRnhwcUQxdnA3dy9IZnlpNEU0eGxJeVRNNlFLVHNRcDNw?=
 =?utf-8?B?Z0t3Zlg0MHZjbnBMNEZDRE0zV2laS2FwSHVBSjdzUnpiaThobnZQYW4vSi9F?=
 =?utf-8?B?eGduTXczQTVaZmtUeVBaV0RHSER5V3RTM242UENMZHpaQXNIbXBma2Fwemcx?=
 =?utf-8?B?cVBMSmV6MDJQNm01aGExQ2tFZU81bzh3WDBzSFpOZnFOV1ZrQ2twME9WZTZ2?=
 =?utf-8?B?cGZidHI3c1MxcTVyL3lzRVV1bXdmd3AxTEFGUU9qc3hTclg0UTl4Y3hJUCsr?=
 =?utf-8?B?b240RXV2dEdXUmpvSlRQTWZjZDJESG12ZVdkcVFTRU5zM0xIak53emI4b200?=
 =?utf-8?B?T20wSDNvRlpWY2JEN0g0RWpZcXRDUGtxL0dtTHFCVUp0KytJWkFFQ3Q1MUlh?=
 =?utf-8?B?V25WendFdzZkeGJxTEpKR2FEcHloRWRvMkJxaWlXRXE3T3NtanVsZ2Q4TG1U?=
 =?utf-8?B?Mm8vbE9IYkNQaGlvdE84S0YyZzdaQms1YWc1WkEzcFZyNmRRanNXQUxacm1o?=
 =?utf-8?B?RnhDYlQ1dE50QzNwUVgzVG9vR29sY1hYMnlnNWR4OHhtQ3Rld1BGdWtvMjNG?=
 =?utf-8?B?MU9HR0k0dXFwaEo1OE5RUEh6STgyZW9wd1lYU25JWldyKzVUV3doaEdxWGla?=
 =?utf-8?B?V005Y09zVjNreU5CNGgxVGtvNVZ3SG52REQyR2VIOGUxQ0kvZjZJS3pYQllS?=
 =?utf-8?B?Z0hYbjhWMUFXOWkxMzB1eXN3N05LaldyZ3BtT2FvRkdpVjNONFVCaEFkTUo0?=
 =?utf-8?B?SlVsRUw4OG1OTVBaLzArY21HbEhhL3lQcnRaanQ1dnk1TWVsSGlhd3Y5bmNO?=
 =?utf-8?B?MzBPbUw4a2pDeW1tRkE1T01zYTBSSjh1NCt0RDh5N3AySnJ2VHpxYnBBdE41?=
 =?utf-8?B?Rjk0bys3TmxxQnIrczIzckFZbVY0eDdhZTFmZWxZeE0xUlllcTNZbjN0a1hE?=
 =?utf-8?B?Z0QvQmdMa3Joakp3bmlqZEE1elhDeTliUXpPUlNzNXRYV1BseS9WV0tWNzR2?=
 =?utf-8?B?STZwbjZlMWNZOUx0MGRiTjE0anYydi9qQUtiUWs0eVQ0SlU0eFZkeDh2LzdT?=
 =?utf-8?Q?hVRM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 218710e8-e4e4-4a04-df24-08dd7a42c01f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2025 04:22:06.6071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cN6nn1gQjtWKLbVXOVzzLqr0Qh/RAfPQLzPSESJ8Ep/QUO7KktghQ/hH8cvFyB6wfN7WTL7efb+PJx/irMPhPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBB
cHJpbCA0LCAyMDI1IDEyOjQyIFBNDQo+IFRvOiBNdXNoYW0sIFNhaSBLcmlzaG5hIDxzYWkua3Jp
c2huYS5tdXNoYW1AYW1kLmNvbT47IE1hbml2YW5uYW4NCj4gU2FkaGFzaXZhbSA8bWFuaXZhbm5h
bi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBscGll
cmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBrZXJuZWwub3JnOw0KPiBrcnpr
K2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGNhc3NlbEBrZXJuZWwub3JnOyBs
aW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5z
aW1la0BhbWQuY29tPjsgR29nYWRhLCBCaGFyYXQgS3VtYXINCj4gPGJoYXJhdC5rdW1hci5nb2dh
ZGFAYW1kLmNvbT47IEhhdmFsaWdlLCBUaGlwcGVzd2FteQ0KPiA8dGhpcHBlc3dhbXkuaGF2YWxp
Z2VAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAyLzJdIFBDSTogeGlsaW54LWNw
bTogQWRkIHN1cHBvcnQgZm9yIFBDSWUgUlAgUEVSU1QjDQo+IHNpZ25hbA0KPg0KPiBDYXV0aW9u
OiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHBy
b3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3Ms
IG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIDA0LzA0LzIwMjUgMDk6MDMsIE11c2hhbSwgU2Fp
IEtyaXNobmEgd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5h
bCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+IEhpIEtyenlzenRvZiwNCj4gPg0KPiA+IFRo
YW5rIHlvdSBmb3IgcmV2aWV3aW5nLg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4g
Pj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDI3LCAyMDI1IDExOjM4IFBNDQo+ID4+IFRvOiBNYW5p
dmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPjsgTXVz
aGFtLA0KPiA+PiBTYWkgS3Jpc2huYSA8c2FpLmtyaXNobmEubXVzaGFtQGFtZC5jb20+DQo+ID4+
IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4
LmNvbTsNCj4gPj4gcm9iaEBrZXJuZWwub3JnOw0KPiA+PiBrcnprK2R0QGtlcm5lbC5vcmc7IGNv
bm9yK2R0QGtlcm5lbC5vcmc7IGNhc3NlbEBrZXJuZWwub3JnOyBsaW51eC0NCj4gPj4gcGNpQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29t
PjsNCj4gPj4gR29nYWRhLCBCaGFyYXQgS3VtYXIgPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNv
bT47IEhhdmFsaWdlLA0KPiA+PiBUaGlwcGVzd2FteSA8dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1k
LmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAyLzJdIFBDSTogeGlsaW54LWNwbTog
QWRkIHN1cHBvcnQgZm9yIFBDSWUgUlANCj4gPj4gUEVSU1QjIHNpZ25hbA0KPiA+Pg0KPiA+PiBD
YXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4g
VXNlIHByb3Blcg0KPiA+PiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tp
bmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+ID4+DQo+ID4+DQo+ID4+IE9uIDI3LzAzLzIwMjUg
MTg6MjUsIE1hbml2YW5uYW4gU2FkaGFzaXZhbSB3cm90ZToNCj4gPj4+PiAgLyoqDQo+ID4+Pj4g
QEAgLTU1MSw2ICs2MDAsMjcgQEAgc3RhdGljIGludCB4aWxpbnhfY3BtX3BjaWVfcGFyc2VfZHQo
c3RydWN0DQo+ID4+IHhpbGlueF9jcG1fcGNpZSAqcG9ydCwNCj4gPj4+PiAgICAgICAgICAgICAg
cG9ydC0+cmVnX2Jhc2UgPSBwb3J0LT5jZmctPndpbjsNCj4gPj4+PiAgICAgIH0NCj4gPj4+Pg0K
PiA+Pj4+ICsgICAgcG9ydC0+Y3J4X2Jhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2VfYnluYW1lKHBkZXYsDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgImNwbV9jcngiKTsNCj4gPj4+PiArICAgIGlmIChJ
U19FUlIocG9ydC0+Y3J4X2Jhc2UpKSB7DQo+ID4+Pj4gKyAgICAgICAgICAgIGlmIChQVFJfRVJS
KHBvcnQtPmNyeF9iYXNlKSA9PSAtRUlOVkFMKQ0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAg
IHBvcnQtPmNyeF9iYXNlID0gTlVMTDsNCj4gPj4+PiArICAgICAgICAgICAgZWxzZQ0KPiA+Pj4+
ICsgICAgICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKHBvcnQtPmNyeF9iYXNlKTsNCj4g
Pj4+PiArICAgIH0NCj4gPj4+PiArDQo+ID4+Pj4gKyAgICBpZiAocG9ydC0+dmFyaWFudC0+dmVy
c2lvbiA9PSBDUE01TkNfSE9TVCkgew0KPiA+Pj4+ICsgICAgICAgICAgICBwb3J0LT5jcG01bmNf
YXR0cl9iYXNlID0NCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICBkZXZtX3BsYXRmb3JtX2lv
cmVtYXBfcmVzb3VyY2VfYnluYW1lKHBkZXYsDQo+ID4+Pj4gKw0KPiA+Pj4+ICsgImNwbTVuY19h
dHRyIik7DQo+ID4+Pg0KPiA+Pj4gV2hlcmUgaXMgdGhpcyByZXNvdXJjZSBkZWZpbmVkIGluIHRo
ZSBiaW5kaW5nPw0KPiA+Pj4NCj4gPj4NCj4gPj4gU28gdGhpcyBpcyB2NiBhbmQgc3RpbGwgbm90
IHRlc3RlZC4NCj4gPj4NCj4gPj4gV2hlcmUgaXMgdGhlIERUUyB1c2luZyB0aGlzIGJpbmRpbmcg
YW5kIGRyaXZlciwgc28gd2UgY2FuIHZlcmlmeSB0aGF0DQo+ID4+IEFNRCBpcyBub3Qgc2VuZGlu
ZyB1cyBzdWNoIHRvdGFsbHkgYm9ndXMsIGRvd25zdHJlYW0gY29kZT8NCj4gPj4NCj4gPg0KPiA+
IFRoaXMgcGF0Y2ggaXMgdGVzdGVkIGZvciBtZW50aW9uZWQgQ1BNIHZlcnNpb25zLCBJIGFwb2xv
Z2l6ZSB0aGF0DQo+DQo+IE5vLCBpdCB3YXNuJ3QuIFRlc3Rpbmcgd291bGQgcG9pbnQgdGhhdCBv
dXQuDQo+DQo+ID4gSSBtaXNzZWQgYWRkaW5nIHRoZSBjcG01bmNfYXR0ciByZXNvdXJjZSBpbiBE
VCBiaW5kaW5nLiBJIHdpbGwgbm90DQo+ID4gcmVwZWF0IHRoaXMgYWdhaW4uIEkgd2lsbCBhZGQg
dGhlIHJlc291cmNlIGluIHRoZSBuZXh0IHBhdGNoLg0KPiA+IFRoYW5rcyBmb3IgeW91ciB1bmRl
cnN0YW5kaW5nLg0KPg0KPiBBZ2Fpbiwgd2hlcmUgaXMgdGhlIERUUz8NCg0KSSB3aWxsIHVwZGF0
ZSBEVFMgYW5kIHNlbmQgdGhlIHBhdGNoLg0KDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQoNCg0KVGhhbmtzLA0KU2FpIEtyaXNobmENCg==

