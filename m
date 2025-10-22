Return-Path: <linux-pci+bounces-38981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490E6BFB4AD
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B54319C0991
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E484E3191DA;
	Wed, 22 Oct 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QabOc7Dc"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF131AF22;
	Wed, 22 Oct 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127451; cv=fail; b=BRpwWq6EubrKzlO87cfLHRox4cJCpsKawr3Dfj+q+JJ8aXS0Cnx5IlLkLbpkiayDSoOtffiPcTTTv9PA4izukJrf7eWn9wGjZIUh7PIdk5+wQ0ix+yJgCKNiXRLcGYKIT8iAONcxLgOKQLFWqiBrdwIRkTsHZJppVEXAmflFXvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127451; c=relaxed/simple;
	bh=6uvZSSo92Mz7gXqmpxVQTTDmCNeDWxzQ8ByAMvE+dAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIxufW1PCyxVzPyR9iBnLoiZ1/8R3m3YdM7fjvj6Tcy7UlHi2lCFEKVzZkDdYDA+UTmdVo4Bgw+8txb7RCCiuoj6YnOCntqOtIwdtaAHsyGgOzdpWTMqzoV2ngqbqUQOloDpB4mXdlx3X+cMdh9Fz6rkjwfL+oCRJ9rUIoP8ZXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QabOc7Dc; arc=fail smtp.client-ip=52.101.62.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHHCSSRWfWxoQsPpfeG+bgqmxQrDlHC9ivTtL5Tr8gm1hJ0nwz2lbhHqYarRbFWVz6Z4EhqRgytJ7s5+2NRKbDFjHSHVcARhEx/RpspIq28D5F5fKhewQBOhRQF54gms5ogsRlLG0esXHDDdz37NTGmEf1GGVYSrGlb9mU+jrtlQhJ6xLKncH9S1sNhtVPGlvQE9+J707XchY+aFNDOXEgO47WqY5RE+u4HGELmC5vv41Rb5iR1Y1tTl3j+pyU0Z1EQprlZAC9Jyu30WoBuDwWEzg5Qe1gxuwRq9ylUNRxJxo6zDqasoeufca8pKunCc7Y62UrFWQv50ASwmc9HsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uvZSSo92Mz7gXqmpxVQTTDmCNeDWxzQ8ByAMvE+dAs=;
 b=lmIlaUG2q4W3XGDw6av5zI2dCtH6zVtmWfpBa5yH5xlsc0z6P7MCmS7RqHDFmvEItTTkcEcF7kQaeE0DbqFFv9QZfkPDMTdtvX9lltYKwulYs6XPNGTRuBQc3WOqR505b6eE4RuglZj3WIkj4K0ZlkYksoXSJVfBsmGwexXWKSd/HHi7+S8IbRdU2n9v6J/VX2J9P4hvU4Kc77pkZxRc9VwlC3SRx/iGFKnwXkZKM7CcQG/+R7RvFKsj6kDe1I5lNx7I5/CC5SkPPWSIH4InCzuXpjwjAEKEkDOMngSFyRTXUlW7/vmjpikuhD0oo3XAMNZoNYtXtNJgs41JQGdI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uvZSSo92Mz7gXqmpxVQTTDmCNeDWxzQ8ByAMvE+dAs=;
 b=QabOc7DchkOb2PJiW6xSAQHdsY4rp6Jj2DSs6facRJ4Ezr2bAWn0N8/140qlsgnZvYaRNxjraf6eG8bRVs6ot+TAhUQpN9wMRdD2bVFFONNDynWrJFv1oQO8GElUIXgzq1RZqKt2PJHgfSd3xvzUH/eAVfBqs+0Z13z+dzNIBsg=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 10:04:05 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 10:04:05 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "mani@kernel.org" <mani@kernel.org>, Stefan Roese
	<stefan.roese@mailbox.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, "Bandi, Ravi Kumar"
	<ravib@amazon.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
	"Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
Subject: RE: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Topic: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
Thread-Index:
 AQHcKoFZBALFGa/Kqki5vrSD8b1UILTNCbqAgAAGd4CAABdpAIAAHYKAgAAJCICAAJ+fgIAAMSWAgAAAawA=
Date: Wed, 22 Oct 2025 10:04:05 +0000
Message-ID:
 <SN7PR12MB72017ACEC56064C19C1B62938BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
In-Reply-To: <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-22T09:56:42.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ5PPF75EAF8F39:EE_
x-ms-office365-filtering-correlation-id: c3973a23-e5c4-4ffa-dcb8-08de11525577
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RThtbGNFajR4OWR6QVIzMW1TR1lDRGR1VEVTbGtZTmFZQWJUbW93YWRRWjZR?=
 =?utf-8?B?V2EyN0ZheDhvdXVoUXZaaTE4RzFiNFNLQy83VWphV2pOMWwwNDY5eHowQ3Nw?=
 =?utf-8?B?U3UxcEdnQXBhSER6ZXpWSW1WOUpLMHBMVkZVc3hxak1TU1VxeTduemlTVmkz?=
 =?utf-8?B?YU5IOWJDUkUvZjV4TVlFdXg3emM5UGJRVWd6SVp1Um9NR1YxTTNwZmFtUmxs?=
 =?utf-8?B?YVUrcWRQM1ZMZzNoTEtFd2EyL1UwaHRqTTZtc2ZXaXAzaFVtaEltNzZZTFp4?=
 =?utf-8?B?UjZsdnc1UWdTUCszMGxwOFllMkdYaXd6VEU1L3JmYkFDNmlKU0xqbWxZWmRn?=
 =?utf-8?B?dFVCNVdSUkNXcEFJczVkSDBLM3FKVmJiVG96NDFiV3VJYkN3RnlrRmhyVGRN?=
 =?utf-8?B?c2R3RjYwNmVwR0JDMlpraCt5MDZwaE14SUxiakYyTmZtRXFQT0JPNUEwTzdQ?=
 =?utf-8?B?aWRpZFF1TERoWXJSVW9KT2pDQUp4M2FhNkVoSEdUajAzQkNEU2VYeVI5WDdB?=
 =?utf-8?B?VjR0MlZwNHdVKytIVUlVeUl6aFgwMXRBa2tjVDZOUmFNcmZWbnlkU2swRm9j?=
 =?utf-8?B?UnF5cHhSNjNTcE1KUzd6ejhodE0vbE9iTEZtNXBMVjJKbHlFYU1IejgxUnlz?=
 =?utf-8?B?NmU3K043WjhiMWFQckdBZmFaenlrUENLVG16OFdYU1FSWGIrNk1TeURISkdR?=
 =?utf-8?B?YlVMS0hxL1lDSldITkdpbjF5V25nV0htTUd2anR1QkJ5dGhQWlNzMnJwOVBo?=
 =?utf-8?B?N01tSTlEYmlZZE9TaUFMdnpCTGRBUnNwOXJkeEQ5aTMvZmQ0am1xTkk5eWxx?=
 =?utf-8?B?amt5azI1UGRzZEl2YlAwWG1MMDhFeTlTb3dqNWFZT2t5OC85MU12aVZOcFlH?=
 =?utf-8?B?WFVhc3p5SDk2L2U2aVRsSWtRQ1FyU2Q5RVIyTmVGUmZ0aklYZS9ZemNuZ0Z2?=
 =?utf-8?B?R1NxMUZ1M3JIMXo3a2lvNW1USlEvbnpqZWdOTUpvYVNXa2ZGNFdjay9DVExS?=
 =?utf-8?B?bFRKN2lTUnYvLzFEd1oyVjA3TWx4MFdQOHRXNmFxZ0NJenFNM29LU1ZnTWNZ?=
 =?utf-8?B?ZnBhenpmL2VTNkhQNUg4QWhzTGw4czc1TzJUUk01bE54WmszczhMLzNQTU9K?=
 =?utf-8?B?cWowTnY5bTVUQ005Qys3MXJXL29nY08wcjE3QnppRFRxcTZ6Z2J3NytNVDNL?=
 =?utf-8?B?TjFPV00ycFVjOVpBNnFMNkxTL0V4YWJRSVZTcU5OaDNkQ0JsQkd2cWdLZzli?=
 =?utf-8?B?ZUlkZmRUZjVuNTZsaFFaV1B6SE96K2ZmZitPVGFpUXpaSXdveXBiQU9kejNm?=
 =?utf-8?B?VkU3aEs3SUJKSXcyNWJSRU82ajVTeTdsNldXbjlhN1Ird3FOU09XN1BlUEpR?=
 =?utf-8?B?a0lFdjdrenVRSUNJTHFacVVsa3NDTFYzaHF3anNhVkt0a2R1azJLMzRPVk54?=
 =?utf-8?B?ZUZ5ZUd5TjJKbG03TEpoVVFDVGZVcG5oVGVvUW9yZkFKdzVsVDJQMU80cWZ1?=
 =?utf-8?B?N1cwZnJhdUtMUzVRZnFZVzlZSUZJWlozWGJwcWw3a1dXMGxCdTdINHR0Mkxu?=
 =?utf-8?B?bTl1dFJlbXRCQzlnMnFOd2hVZXZiWTNZaG9mWkxaTGV5WlBuOGR5eTc0T0U3?=
 =?utf-8?B?emRpTjkwK2xRSC81eCtGdFpHWDRJWTlQdlhGVEZOV3dCMVN6RnNsSkMwVEFp?=
 =?utf-8?B?OWM2ODE1WHZ1LzdycTFGNEgwTldHbjkxVE0zWVBibmtzN0c3cSszVDF3a1RO?=
 =?utf-8?B?dEpOeWFSWVBkVnRtNWE1Q01YQzA3ejVHSG1xWGlpNHFOdUFGS1JiU0sxaGRk?=
 =?utf-8?B?TWM3b2ZNb2VGdE1LazlpT0JiL29xcDNJdHJaZU5aMDZOQU1FWVluT1lOaGNz?=
 =?utf-8?B?WnlwTkhYYy9uV2hkUkJXMHp0aGVZR2xEd2ovbnI2czV1bjdtdVVkdllpbFJD?=
 =?utf-8?B?UHQ2YllpellBQmU5R2VsRzhSUXBaQWRUNXFhN0l2WTZ3WDZGcHpUMlNybm83?=
 =?utf-8?B?Vkh0emNCSko5TnM1UXRid0M1Sm5uR2gvS1pMSTdvaXRxZHdLQVBYV2lKM2hH?=
 =?utf-8?Q?2PkF9N?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWJMN3NVT0RMREEvQi9vdkxOZk1sOUtMWVovcWk0VUJUNkJZYW1kYzhtY1k1?=
 =?utf-8?B?d05MY2QvVmFucHlGbUl2dy9lUDVBdlVJZHBDb0pmbnRmN3RRSkdGcUNpS3dU?=
 =?utf-8?B?RkJRcGZHTzJGYmNTa2pZYnAzZDlRRHViM3NUSmNnV2xqb0JLWFRQSjcyNzB4?=
 =?utf-8?B?QWlWWlhPWWdvbE9xb1lSYUtjdW82dllndmJINFBLZTBjRXYvK3hlbkw0OW5L?=
 =?utf-8?B?VjcwUTVjRVlNdnhWK3NlaHdQWVlWY1grbU1NSzg2YWhLOVl2NFJkOXg2N20w?=
 =?utf-8?B?VFhoOWVXckt2aGJ3U1FFVi9kQWZyM2FRanI2bGRsWERNYUM1UmpSc0M2ZFNK?=
 =?utf-8?B?dDhldm9SYkZRSkZNcWx5YkVNZXBJZ0NTeTJONVdHU2IrMHRJZlc1TjNWNlJM?=
 =?utf-8?B?alFXN01WME9ET0J5WlNibW0vWUYzemhpZ3IyQ3dDTDk3aEkzN0lxSzQrQUs5?=
 =?utf-8?B?YmQ0UzlleldoUlBNcVhzdzBaTnZpT0VEdDcvejA2cTFmaFpEV3JaQ3luWDk5?=
 =?utf-8?B?ckYybHEyMjVpRFNJZjF1ODdtT0cwMGdFcVB4SjdxZnJFUGh1M3lrYUZUYmhy?=
 =?utf-8?B?NGxoM3RwL3ducHBUMUQ0RmdzQUgzM081elpWR3FpQmxhZ0I5TWFIMnBLZit5?=
 =?utf-8?B?Uk1xODU5anZxQUVoM2pwelpZbmFnQklJNkhLMElmYW5xQTA2ZmtzQmNCRU1W?=
 =?utf-8?B?WG40RjVib01ad2FxRitCMkNFZlhpcU5HcDdkTmwrWGhSWmptd2JReWxrbnYy?=
 =?utf-8?B?bzc4ZnM4TGNhSStQL3huVzBvK0RXOGJ0N3pXTHprOGcvMnVlM2RCUFdLdW9w?=
 =?utf-8?B?cWFvdzlwbmNLcjNzUzIvQk1hMm50UzdiT1d1UTZ0b2x0bkJ1M0ZqdzhuUXIy?=
 =?utf-8?B?T3Y3YitNVm5XUm0rRWdtMFdRU2dNakx3K28wUXpQbndaNGxCUGE2eG8wbzlp?=
 =?utf-8?B?ZFNTWG5rRGlEOHA5YmhzeHloQUVOWGtwZU5OZnNTb0F4S2pyeXM4MlFjQ2Fq?=
 =?utf-8?B?eFYxSHVINERjSDhpKytCUjJrZ1JDc20wL0U5U2RYUlliaFd5S1puNE4wRDNJ?=
 =?utf-8?B?K0FtbXkyQWNYSXEzYURlVDI4WTA1SE0vRkdsMUdpWCtqZEIrdmpNUGtsWENr?=
 =?utf-8?B?blNjUE5NZEk3S3RiMVZSbGpoZTVnOGhIaC9xQ085Q3dDaXVJTlhqMTUrVjBk?=
 =?utf-8?B?eWIvUUpSS3ZzR0gzb0xwaDE3RDZiaGh1b3F0WWFqTHZrL0xrL0VsZE9hK3Fy?=
 =?utf-8?B?b2FJZXp2VG1nZlBNV1lybXZBZ3pQRDBwQ3UvM3RTYjc4T2tyZXR1K2hXVGhD?=
 =?utf-8?B?WHNkU2R5a2VBQllKWWJIUk1uN0p0UDRsRjEwMTJSdVEvd0pqQUJ3YjY1YnE0?=
 =?utf-8?B?cmNjUHd3WFhGNUQ5TXEwbS9KVTJQVmxwdnZINGtQaGx4RHNsNGtPc2dQOERa?=
 =?utf-8?B?UlRTYUNzbzhSNXNzMWRxMnoxbEtmYll5SXRPQnF3akZjMTRrbSt3WlFmTEI5?=
 =?utf-8?B?cWVzYUJFSFVlcWVmcG5udHY2Q1d4cUNEUkVUQVVJdEQxR0R4aE5VR0xlVlpl?=
 =?utf-8?B?QW40U2xMRVBHSC9kYTgvNGZCWjVZNmpnUThuUE05VHR6UlZYTENtR0xLWEV3?=
 =?utf-8?B?VENZeHpuaEU5dTdEb0NBemVyZElCdloyMW5qR3QwVTcxS3lvY3EzaDUvRkhz?=
 =?utf-8?B?OC9QVUxrb1Q4MGNPMFBlMlhLNk9SWWpicXdQNmVJdm5MUm9vbVZnaW9pVUl1?=
 =?utf-8?B?dFl0QWM1bFJIQVBSNkZWZE84a3JEMEtZVmVNdEF2S2ZibmJoRjlCNkpDUVAr?=
 =?utf-8?B?MzhYSzNjOVFQQytwOW9wOXVXeE9CVDZ3WXFEVDdTbTlFVW1rSDN3UGdDUTFW?=
 =?utf-8?B?dDBTdDhpcDNPR0dMWnRvYUZDV3FGa0VlOXRDUlZBK2lDam04WDM0enR0NWpj?=
 =?utf-8?B?dmtTSElDMXlLdTlDVVFjTEhRbHdZYzRvd1RwdlgyOVJMM3dkOVY4enlzdURp?=
 =?utf-8?B?bHJ4Y2Y3QkhLZWxkL1V5ZlB2Wi9WbUlqMFNSNThzYlBKQURFQmFiRHVSYTJa?=
 =?utf-8?B?aDd1UzlybEZqR1BDS1RVa3pJTmdCUTY0RTNmOHBCUlZoWGhpR05kdTBLelFr?=
 =?utf-8?Q?DaBc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3973a23-e5c4-4ffa-dcb8-08de11525577
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 10:04:05.1654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVtukDC5YIGAnNWlh3pehJW4evHm+ukkRKhB3mCGb0RGOgV19d+Ek3/rvtMSfBaezHb1m44pNAMWKqxXUd9bxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFuaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBtYW5p
QGtlcm5lbC5vcmcgPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDIyLCAyMDI1IDM6MjUgUE0NCj4gVG86IFN0ZWZhbiBSb2VzZSA8c3RlZmFuLnJvZXNlQG1haWxi
b3gub3JnPg0KPiBDYzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgQmFuZGks
IFJhdmkgS3VtYXINCj4gPHJhdmliQGFtYXpvbi5jb20+OyBIYXZhbGlnZSwgVGhpcHBlc3dhbXkN
Cj4gPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7
DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGt3aWxj
enluc2tpQGtlcm5lbC5vcmc7DQo+IHJvYmhAa2VybmVsLm9yZzsgU2ltZWssIE1pY2hhbCA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+OyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnOyBTZWFuIEFuZGVyc29uIDxzZWFuLmFuZGVyc29uQGxpbnV4LmRldj4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2Ml0gUENJOiB4aWxpbngteGRtYTogRW5hYmxlIElOVHggaW50ZXJydXB0cw0K
Pg0KPiBPbiBXZWQsIE9jdCAyMiwgMjAyNSBhdCAwODo1OToxOUFNICswMjAwLCBTdGVmYW4gUm9l
c2Ugd3JvdGU6DQo+ID4gSGkgQmpvcm4sDQo+ID4gSGkgUmF2aSwNCj4gPg0KPiA+IE9uIDEwLzIx
LzI1IDIzOjI4LCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBPY3QgMjEsIDIw
MjUgYXQgMDg6NTU6NDFQTSArMDAwMCwgQmFuZGksIFJhdmkgS3VtYXIgd3JvdGU6DQo+ID4gPiA+
ID4gT24gVHVlLCBPY3QgMjEsIDIwMjUgYXQgMDU6NDY6MTdQTSArMDAwMCwgQmFuZGksIFJhdmkg
S3VtYXIgd3JvdGU6DQo+ID4gPiA+ID4gPiA+IE9uIE9jdCAyMSwgMjAyNSwgYXQgMTA6MjPigK9B
TSwgQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiB3cm90ZToNCj4gPiA+ID4g
PiA+ID4gT24gU2F0LCBTZXAgMjAsIDIwMjUgYXQgMTA6NTI6MzJQTSArMDAwMCwgUmF2aSBLdW1h
ciBCYW5kaQ0KPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBUaGUgcGNpZS14aWxpbngtZG1hLXBs
IGRyaXZlciBkb2VzIG5vdCBlbmFibGUgSU5UeA0KPiA+ID4gPiA+ID4gPiA+IGludGVycnVwdHMg
YWZ0ZXIgaW5pdGlhbGl6aW5nIHRoZSBwb3J0LCBwcmV2ZW50aW5nIElOVHgNCj4gPiA+ID4gPiA+
ID4gPiBpbnRlcnJ1cHRzIGZyb20gUENJZSBlbmRwb2ludHMgZnJvbSBmbG93aW5nIHRocm91Z2gg
dGhlDQo+ID4gPiA+ID4gPiA+ID4gWGlsaW54IFhETUEgcm9vdCBwb3J0IGJyaWRnZS4gVGhpcyBp
c3N1ZSBhZmZlY3RzIGtlcm5lbCA2LjYuMCBhbmQNCj4gbGF0ZXIgdmVyc2lvbnMuDQo+ID4gPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBUaGlzIHBhdGNoIGFsbG93cyBJTlR4IGludGVycnVw
dHMgZ2VuZXJhdGVkIGJ5IFBDSWUNCj4gPiA+ID4gPiA+ID4gPiBlbmRwb2ludHMgdG8gZmxvdyB0
aHJvdWdoIHRoZSByb290IHBvcnQuIFRlc3RlZCB0aGUgZml4IG9uDQo+ID4gPiA+ID4gPiA+ID4g
YSBib2FyZCB3aXRoIHR3byBlbmRwb2ludHMgZ2VuZXJhdGluZyBJTlR4IGludGVycnVwdHMuDQo+
ID4gPiA+ID4gPiA+ID4gSW50ZXJydXB0cyBhcmUgcHJvcGVybHkgZGV0ZWN0ZWQgYW5kIHNlcnZp
Y2VkLiBUaGUNCj4gPiA+ID4gPiA+ID4gPiAvcHJvYy9pbnRlcnJ1cHRzIG91dHB1dA0KPiA+ID4g
PiA+ID4gPiA+IHNob3dzOg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gWy4uLl0N
Cj4gPiA+ID4gPiA+ID4gPiAzMjogICAgICAgIDMyMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZl
bnQgIDE2IExldmVsICAgICA0MDAwMDAwMDAuYXhpLQ0KPiBwY2llLCBhemRydg0KPiA+ID4gPiA+
ID4gPiA+IDUyOiAgICAgICAgNDcwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMTYgTGV2
ZWwgICAgIDUwMDAwMDAwMC5heGktDQo+IHBjaWUsIGF6ZHJ2DQo+ID4gPiA+ID4gPiA+ID4gWy4u
Ll0NCj4gPg0KPiA+IEZpcnN0IGEgY29tbWVudCBvbiB0aGlzIElSUSBsb2dnaW5nOg0KPiA+DQo+
ID4gVGhlc2UgbGluZXMgZG8gTk9UIHJlZmVyIHRvIHRoZSBJTlR4IElSUShzKSBidXQgdGhlIGNv
bnRyb2xsZXINCj4gPiBpbnRlcm5hbCAiZXZlbnRzIiAoZXJyb3JzIGV0YykuIFBsZWFzZSBzZWUg
dGhpcyBsb2cgZm9yIElOVHggb24gbXkNCj4gPiBWZXJzYWwgcGxhdGZvcm0gd2l0aCBwY2lfaXJx
ZF9pbnR4X3hsYXRlIGFkZGVkOg0KPiA+DQo+ID4gIDI0OiAgICAgICAgICAwICAgICAgICAgIDAg
IHBsX2RtYTpSQy1FdmVudCAgIDAgTGV2ZWwgICAgIExJTktfRE9XTg0KPiA+ICAyNTogICAgICAg
ICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgICAzIExldmVsICAgICBIT1RfUkVTRVQN
Cj4gPiAgMjY6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAgOCBMZXZl
bCAgICAgQ0ZHX1RJTUVPVVQNCj4gPiAgMjc6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1h
OlJDLUV2ZW50ICAgOSBMZXZlbCAgICAgQ09SUkVDVEFCTEUNCj4gPiAgMjg6ICAgICAgICAgIDAg
ICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAxMCBMZXZlbCAgICAgTk9ORkFUQUwNCj4gPiAg
Mjk6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAxMSBMZXZlbCAgICAg
RkFUQUwNCj4gPiAgMzA6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAy
MCBMZXZlbCAgICAgU0xWX1VOU1VQUA0KPiA+ICAzMTogICAgICAgICAgMCAgICAgICAgICAwICBw
bF9kbWE6UkMtRXZlbnQgIDIxIExldmVsICAgICBTTFZfVU5FWFANCj4gPiAgMzI6ICAgICAgICAg
IDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAyMiBMZXZlbCAgICAgU0xWX0NPTVBMDQo+
ID4gIDMzOiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjMgTGV2ZWwg
ICAgIFNMVl9FUlJQDQo+ID4gIDM0OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1F
dmVudCAgMjQgTGV2ZWwgICAgIFNMVl9DTVBBQlQNCj4gPiAgMzU6ICAgICAgICAgIDAgICAgICAg
ICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAyNSBMZXZlbCAgICAgU0xWX0lMTEJVUg0KPiA+ICAzNjog
ICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgIDI2IExldmVsICAgICBNU1Rf
REVDRVJSDQo+ID4gIDM3OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAg
MjcgTGV2ZWwgICAgIE1TVF9TTFZFUlINCj4gPiAgMzg6ICAgICAgICAgOTQgICAgICAgICAgMCAg
cGxfZG1hOlJDLUV2ZW50ICAxNiBMZXZlbCAgICAgODQwMDAwMDAuYXhpLXBjaWUNCj4gPiAgMzk6
ICAgICAgICAgOTQgICAgICAgICAgMCAgcGxfZG1hOklOVHggICAwIExldmVsICAgICBudm1lMHEw
LCBudm1lMHExDQo+ID4NCj4gPiBUaGUgbGFzdCBsaW5lIHNob3dzIHRoZSBJTlR4IElSUXMgaGVy
ZSAoJ3BsX2RtYTpJTlR4JyB2cyAncGxfZG1hOlJDLQ0KPiA+IEV2ZW50JykuDQo+ID4NCj4gPiBN
b3JlIGJlbG93Li4uDQo+ID4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IENoYW5n
ZXMgc2luY2UgdjE6Og0KPiA+ID4gPiA+ID4gPiA+IC0gRml4ZWQgY29tbWl0IG1lc3NhZ2UgcGVy
IHJldmlld2VyJ3MgY29tbWVudHMNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEZp
eGVzOiA4ZDc4NjE0OWQ3OGMgKCJQQ0k6IHhpbGlueC14ZG1hOiBBZGQgWGlsaW54IFhETUENCj4g
PiA+ID4gPiA+ID4gPiBSb290IFBvcnQgZHJpdmVyIikNCj4gPiA+ID4gPiA+ID4gPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJhdmkg
S3VtYXIgQmFuZGkgPHJhdmliQGFtYXpvbi5jb20+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+IEhpIFJhdmksIG9idmlvdXNseSB5b3UgdGVzdGVkIHRoaXMsIGJ1dCBJIGRvbid0IGtub3cg
aG93IHRvDQo+ID4gPiA+ID4gPiA+IHJlY29uY2lsZSB0aGlzIHdpdGggU3RlZmFuJ3MgSU5UeCBm
aXggYXQNCj4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MTAyMTE1
NDMyMi45NzM2NDAtMS1zdGVmYW4ucm9lDQo+ID4gPiA+ID4gPiA+IHNlQG1haWxib3gub3JnDQo+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IERvZXMgU3RlZmFuJ3MgZml4IG5lZWQgdG8gYmUg
c3F1YXNoZWQgaW50byB0aGlzIHBhdGNoPw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFN1cmUs
IHdlIGNhbiBzcXVhc2ggU3RlZmFu4oCZcyBmaXggaW50byB0aGlzLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gSSBrbm93IHdlICpjYW4qIHNxdWFzaCB0aGVtLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
SSB3YW50IHRvIGtub3cgd2h5IHRoaW5ncyB3b3JrZWQgZm9yIHlvdSBhbmQgU3RlZmFuIHdoZW4g
dGhleQ0KPiA+ID4gPiA+ICp3ZXJlbid0KiBzcXVhc2hlZDoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ICAgLSBXaHkgZGlkIElOVHggd29yayBmb3IgeW91IGV2ZW4gd2l0aG91dCBTdGVmYW4ncyBwYXRj
aC4gIERpZCB5b3UNCj4gPiA+ID4gPiAgICAgZ2V0IElOVHggaW50ZXJydXB0cyBidXQgbm90IHRo
ZSByaWdodCBvbmVzLCBlLmcuLCBkaWQgdGhlIGRldmljZQ0KPiA+ID4gPiA+ICAgICBzaWduYWwg
SU5UQSBidXQgaXQgd2FzIHJlY2VpdmVkIGFzIElOVEI/DQo+ID4gPiA+DQo+ID4gPiA+IEkgc2F3
IHRoYXQgaW50ZXJydXB0cyB3ZXJlIGJlaW5nIGdlbmVyYXRlZCBieSB0aGUgZW5kcG9pbnQgZGV2
aWNlLA0KPiA+ID4gPiBidXQgSSBkaWRu4oCZdCBzcGVjaWZpY2FsbHkgY2hlY2sgaWYgdGhleSB3
ZXJlIGNvcnJlY3RseSB0cmFuc2xhdGVkDQo+ID4gPiA+IGluIHRoZSBjb250cm9sbGVyLiBJIG5v
dGljZWQgdGhhdCB0aGUgbmV3IGRyaXZlciB3YXNuJ3QgZXhwbGljaXRseQ0KPiA+ID4gPiBlbmFi
bGluZyB0aGUgaW50ZXJydXB0cywgc28gbXkgZmlyc3QgYXBwcm9hY2ggd2FzIHRvIGVuYWJsZSB0
aGVtLA0KPiA+ID4gPiB3aGljaCBoZWxwZWQgdGhlIGludGVycnVwdHMgZmxvdyB0aHJvdWdoLg0K
PiA+ID4NCj4gPiA+IE9LLCBJJ2xsIGFzc3VtZSB0aGUgaW50ZXJydXB0cyBoYXBwZW5lZCBidXQg
dGhlIGRyaXZlciBtaWdodCBub3QNCj4gPiA+IGhhdmUgYmVlbiBhYmxlIHRvIGhhbmRsZSB0aGVt
IGNvcnJlY3RseSwgZS5nLiwgaXQgd2FzIHByZXBhcmVkIGZvcg0KPiA+ID4gSU5UQSBidXQgZ290
IElOVEIgb3Igc2ltaWxhci4NCj4gPiA+DQo+ID4gPiA+ID4gICAtIFdoeSBkaWQgU3RlZmFuJ3Mg
cGF0Y2ggd29yayBmb3IgaGltIGV2ZW4gd2l0aG91dCB5b3VyIHBhdGNoLiAgSG93DQo+ID4gPiA+
ID4gICAgIGNvdWxkIFN0ZWZhbidzIElOVHggd29yayB3aXRob3V0IHRoZSBDU1Igd3JpdGVzIHRv
IGVuYWJsZQ0KPiA+ID4gPiA+ICAgICBpbnRlcnJ1cHRzPw0KPiA+ID4gPg0KPiA+ID4gPiBJJ20g
bm90IGVudGlyZWx5IHN1cmUgaWYgdGhlcmUgYXJlIGFueSBvdGhlciBkZXBlbmRlbmNpZXMgaW4g
dGhlDQo+ID4gPiA+IEZQR0EgYml0c3RyZWFtLiBJJ2xsIGludmVzdGlnYXRlIGZ1cnRoZXIgYW5k
IGdldCBiYWNrIHRvIHlvdS4NCj4gPiA+DQo+ID4gPiBTdGVmYW4gY2xhcmlmaWVkIGluIGEgcHJp
dmF0ZSBtZXNzYWdlIHRoYXQgaGUgaGFkIGFwcGxpZWQgeW91ciBwYXRjaA0KPiA+ID4gZmlyc3Qs
IHNvIHRoaXMgbXlzdGVyeSBpcyBzb2x2ZWQuDQo+ID4NCj4gPiBZZXMuIEkgYXBwbGllZCBSYXZp
J3MgcGF0Y2ggZmlyc3QgYW5kIHN0aWxsIGdvdCBubyBJTlR4IGRlbGl2ZXJlZCB0bw0KPiA+IHRo
ZSBudm1lIGRyaXZlci4gVGhhdCdzIHdoYXQgbWUgdHJpZ2dlcmVkIHRvIGRpZyBkZWVwZXIgaGVy
ZSBhbmQNCj4gPiByZXN1bHRlZCBpbiB0aGlzIHYyIHBhdGNoIHdpdGggcGNpX2lycWRfaW50eF94
bGF0ZSBhZGRlZC4NCj4gPg0KPiA+IEJUVzoNCj4gPiBJIHJlLXRlc3RlZCBqdXN0IG5vdyB3L28g
UmF2aSdzIHBhdGNoIGFuZCB0aGUgSU5UeCB3b3JrZWQuIFN0aWxsIEkNCj4gPiB0aGluayBSYXZp
J3MgcGF0Y2ggaXMgdmFsaWQgYW5kIHNob3VsZCBiZSBhcHBsaWVkLi4uDQo+DQo+IEhvdyBjb21l
IElOVHggaXMgd29ya2luZyB3aXRob3V0IHRoZSBwYXRjaCBmcm9tIFJhdmkgd2hpY2ggZW5hYmxl
ZCBJTlR4DQo+IHJvdXRpbmcgaW4gdGhlIGNvbnRyb2xsZXI/IFdhcyBpdCBlbmFibGVkIGJ5IGRl
ZmF1bHQgaW4gdGhlIGhhcmR3YXJlPw0KDQpDYW4geW91IHBsZWFzZSBjcm9zcy1jaGVjayB0aGUg
aW50ZXJydXB0LW1hcCBwcm9wZXJ0eSBpbiB0aGUgZGV2aWNlIHRyZWU/IEN1cnJlbnRseSwgdGhl
IGRyaXZlciBpc27igJl0IHRyYW5zbGF0aW5nIChwY2lfaXJxZF9pbnR4X3hsYXRlKSB0aGUgSU5U
eCBudW1iZXIuDQoNCkhlcmXigJlzIHJlcXVpcmVkIERUIHByb3BlcnR5Og0KDQppbnRlcnJ1cHQt
bWFwID0gPDAgMCAwIDEgJnBjaWVfaW50Y18wIDA+LA0KICAgICAgICAgICAgICAgIDwwIDAgMCAy
ICZwY2llX2ludGNfMCAxPiwNCiAgICAgICAgICAgICAgICA8MCAwIDAgMyAmcGNpZV9pbnRjXzAg
Mj4sDQogICAgICAgICAgICAgICAgPDAgMCAwIDQgJnBjaWVfaW50Y18wIDM+Ow0KPg0KPiAtIE1h
bmkNCj4NCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCu
v+CuteCuruCvjQ0K

