Return-Path: <linux-pci+bounces-38985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD379BFB573
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 12:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804C718820CF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 10:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DB330B521;
	Wed, 22 Oct 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k1Fa/wKb"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72742280332;
	Wed, 22 Oct 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128013; cv=fail; b=RVvSN1bUDIehCKp45iE1Xi5X9H2pxkCvQ7y/OQ1MPUWk9Th/0skKmK98Hy9ObVMPjIFiDDEpmENticyPuM9PuQeQsIahUVaIVI5gny5y3VCkY5No38YPF4j3wGewlkObc2zDNvAM9cmutuTy+El0Vvq9I2j/r3r23zcDvMFRlJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128013; c=relaxed/simple;
	bh=clGx5v+e3f0F/SYdT9Dll4WPS7AcC7smG2A7NNYm6AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TvL4dfRmS52l/PsxI1wHBpnE7ESwXMhy/QDS6Hvox+u6FfPcmKH/HLewPx13b3CorHiwFs9h4hu/mMnEKtnUBNxeHhCkx1uyXkYanK3fEM93bBR1WrmD72Fxuw+wTJI/Lerjn3hAUJ95/Tc5AfRlwX5irGjYu4rKSxVq8hQnZ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k1Fa/wKb; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQFxweRneFk9PxDtFNx/dtlT/+urSJ4SQxEyR4nVH84gTIBc5kT/Y1/0oR4Bq+vKYhAFkHIGrxTZk7daC3De2nbt5LgSnrvk0fgEHZxYsyeoJHKk/l3f68o73BkBq38HUUr1vXsjKxQC1TRE+IDKxDSh57aJClcGFkHBSCpV8DhsMOqhG8pPOLyATWRizL9pPRw46v099NHxTXLv/BYBDmavKxKU17xDyH9Vm9XywFOmA1r7RHvyGVx5tg7IGWECNIxGkb/uH0/8Zzw4IUTwXDz6gANMucGlX7HzLjEzEVJV9oD/PnOjZGDjFB6kUfgmItpX6Bk6nzwAwtI2VlcAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clGx5v+e3f0F/SYdT9Dll4WPS7AcC7smG2A7NNYm6AA=;
 b=oKOfIhECYiiKXj0Ta+UCIdN8ufciHChZTyQc++22kxjd5Jk7EzOuJh+TQXFGkc3G9hK8u41skF9uqLS9ZgcNSacrfM/TMqrzTk8toNsNhfS78CiOY4nPq9Q5h2lZQNRqcG1gx+HIabwDyLIgGdairMqslKVNR6+HMt4RvwnpDPtDAOZdeKo39r9F89rPie7/1hvjfuwo4UxQKIvhGe5gI1O8b+ohU914R6TX1WxNWkvHZPsm3WczlymlNJP5mptX9dlXndK17ecxc8SL1sy7hMGRxx+64CI4PTc27IuLFAHSD+nd4WEk7/xY3JptdfmxP3PPtl9S9wMmXtv+xQ6aKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clGx5v+e3f0F/SYdT9Dll4WPS7AcC7smG2A7NNYm6AA=;
 b=k1Fa/wKbb9cU31B/MnXzbVSoY3da0bYPOgM+gKaRr5r/MLy2G2K4dYBzX3YW0BGQdTKLcqFBTZgG8CkdgNosfNSzOn0dCokIYzFGE6iamVF3xWtZRaCIc1mQb4JA0JVPFmXR8eCYR96hEDE7fCAVsZ6/2UTkP/ilizblskbW6A8=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 10:13:28 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 10:13:28 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Stefan Roese <stefan.roese@mailbox.org>, "mani@kernel.org"
	<mani@kernel.org>
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
 AQHcKoFZBALFGa/Kqki5vrSD8b1UILTNCbqAgAAGd4CAABdpAIAAHYKAgAAJCICAAJ+fgIAAMSWAgAAAawCAAAQRAIAAAEuA
Date: Wed, 22 Oct 2025 10:13:27 +0000
Message-ID:
 <SN7PR12MB72012E58AAD2E8C2D7E068B28BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
 <SN7PR12MB72017ACEC56064C19C1B62938BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <bdedc85c-c82e-4513-9bfd-c6d41f945e75@mailbox.org>
In-Reply-To: <bdedc85c-c82e-4513-9bfd-c6d41f945e75@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-22T10:12:18.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ2PR12MB8111:EE_
x-ms-office365-filtering-correlation-id: 7b8b0b21-a475-47f0-82b3-08de1153a4f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NGZ0Rm9JZUxFd2ZOZGdRRmJzOFRRTE9ta3d5dytRKzR2R0pYMXJycE5Ta2FD?=
 =?utf-8?B?ajdTZyttaVNZS05KYXQ1OXcvbHM5VEErT25BQWEvMmMrQ2UyaXFocUNLczJJ?=
 =?utf-8?B?TEp5ZjF2Rjc4c0NMeExwR2UvZFliV2ltc3lSUm5VbVYxa3pxMHloclVGYXIx?=
 =?utf-8?B?UTNqZEgzUnVidSs4UGF1VXRmOGtaa0FucGlKd2c2Q3pnQmJjWjVDaitCcG9n?=
 =?utf-8?B?QUlLNjdEUmI1Mk92QVVWS3BrQWwyUkpsTk53RXQ3TjI5ekhyWHAzNzNqaDBJ?=
 =?utf-8?B?ZWpndHA4MVYxeTFkdW9IWXQ3ektJOFBueFNQdkNURzNlU2pOR2hiemIwTlVj?=
 =?utf-8?B?RlIyS0FlLzBNZTR2R09qWk5MSGdoWjRxSFlVYUNYY1NIVTlCYmZkN3Rnemxy?=
 =?utf-8?B?UTdIUTE0a2dqYjg5K0EvYmgwUVNrdk9mT3dsSUV1UnFkQlpEeGVWczJoMCta?=
 =?utf-8?B?Zi9sVGFVL0hiZm9VaFRQQWNMUzl1Q1FiOU5lZU5lNkZxTWg2dnZSZ3B2UnNM?=
 =?utf-8?B?aWsyUHFtbU9Fak1sU2pDaE1Tbk50ekJRRlhoajhRVWNldUVFZUJ1V1FFcVZm?=
 =?utf-8?B?SlNiYjlQRThWVmVjRVZaZXFacGlXSlhidkRGMzBqRmYvdGh4a25ySElOcVBh?=
 =?utf-8?B?M3pJcG9oRGhBbjdmM1A2RzFxenhQS1dlTjc4a2p2YnkwMGhtbkhzZTdXNmw5?=
 =?utf-8?B?NUs4cFJRVTNXSXRla0oybHlzb0dYQloyWGd1Z09ub2d2cWoxd3VybUl2RkFh?=
 =?utf-8?B?dXFWd3JLaC9lRTk5RnUvRHo5SmpsYjZra3JzL1Zmd3BxR1NwVWJyTXkrVE92?=
 =?utf-8?B?SEpLRzcxdlRtbWFqTUpJQzVPS1RxNGkvWkFzSDEzbFhDUmRHWWp1Q2VQSXNL?=
 =?utf-8?B?RFU2TUVhVXIraDBuTGVSdTE0YThNTUZPZFNxdHQ2WGZsNElONDVoLzFUTjN0?=
 =?utf-8?B?T0xTMzJxaUQ3Sm10c3NmQ1pDY3dpQjJ5UDdFOThmcjZpWFZBSElFKzRPRXhv?=
 =?utf-8?B?aTdzZWxyMG5YNnJRNitGQys3RlpNZUZ6Zk5KRUFKeFR1SVhndDRhZTFhcE1H?=
 =?utf-8?B?QVVOMnA3VS9FeDYxKzZxK1Z4SHltQ1gvbXlrQjJvdHQ4WjBKMFYzZnBjYXla?=
 =?utf-8?B?a3RYQ3g2RFMxbWxPTC9GYmxqdTlRQmRpenptTWNLMnZzMnJ2SnhoUXZHbkhj?=
 =?utf-8?B?L2ZvRWoxM1h5QkFGUWQzc3lwejhKbXdjSVBTSjNDQzNsNjdKalFvSEU0WU9W?=
 =?utf-8?B?UnYyRE5qN2FIUVFCT1ZOcnBhNE44R3k5NHp2bUJPLzdVYnB5ZGRETTNuT1NM?=
 =?utf-8?B?R0dxNzIxVDlFVFJQZTRXRURWb0p1bUR3Nk5NZng5Vm9FdFNuckZWU3pVYzhE?=
 =?utf-8?B?RjgyYW5DeWIyRDFyWktLRi9idGR2NFQvSko5MGdLbDNnYUlBMzBmTUVYcTlz?=
 =?utf-8?B?U2tJQjJ4bUxxajJuMUJmdXpmK0wvMm4vNHZnOUVyY0oyc0VoQlBHTjlmQU9D?=
 =?utf-8?B?YUllK2FHSndRU0kxRFNWNCtKTmFzYStzRk0wci80NjJ6NFlpeStoMENTMjZ5?=
 =?utf-8?B?N1EzU0d2TkI1cTZKbTZldzlQdkQ0MTJZbC9BVEhsNS9OendONVV0SVdITVRs?=
 =?utf-8?B?MTNKbUpHV3BtaTd6N25uTXdxaHNJc2Nmb0cwT09iMEViaGRqNW4wYzVRdlRs?=
 =?utf-8?B?NEwxeDlvcmtzaVlvM2N6MXpYdjNtV2VQRmM2U21GTFV5S2FHWDc4SGRveGlo?=
 =?utf-8?B?SFFreVUrRUlRbytGN200dzF3azlJMTJZU0xnZlp5UCtNYkRtblppcGp6WDdE?=
 =?utf-8?B?N0prQm8yUURXY0RYcW1xUE9Wczc4dENzL0U4WUhyWFd4UkErNUpvRWRZWW5n?=
 =?utf-8?B?Z045SGJmbDI2dHo4N1gzRGx0N2QzNXBCYjh2c3plZ3JiK2VOWjd4ZUdlRUFW?=
 =?utf-8?B?RUhzZFdaUTVJSVpvRWpMS2dlZDBCL3BZbHVLK0dPclZiaHdxZzl1M3pxT04y?=
 =?utf-8?B?Z042ZnRwQjFZd3NFMEFTL1NQZkJxM3Y4RGlrSGdYd3BOTnpRWDIzMnJRMWg0?=
 =?utf-8?Q?wFFQ/n?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXYxQkIxcytpT0IvOVFQRmJVWkd3cVgrWFdkanRRc3R6d1VtSVFJUzlIQnZu?=
 =?utf-8?B?azROSFAzbERibmEvbDR2Y3J0Q09kcXZnaS96aXRwSEw4TjN2eUdkQ1pycUtj?=
 =?utf-8?B?SlZPbWgwM2plN1dhcjFGVjVQck9va295UUh3bUNpenRrc2YvNkFMTk53U1Bk?=
 =?utf-8?B?RFpKTVFISVZxanMrdUkvdVBJbVQwdm9PVlBNMU9DeW1TREZxQ3A1Njc2cXJV?=
 =?utf-8?B?ZXZCeFV6dFU1RU5YVlZ4RHNjVVNVQktEeFlzZ3JOZWlDb3I3cjlaU1puWTNE?=
 =?utf-8?B?a2N4U0NZdkVkaTRoQjIzeWN6NFZkL0FKUHAzZW14N1pqenhRVHJJbkdOSERo?=
 =?utf-8?B?RDlZVVhTR3hmVWRGbFJOcUtXSTNWQnIwVG1uV21UTzJSNlQ4a3ZqNE9CWFNR?=
 =?utf-8?B?RDJlTW9SK0dHMVZSM1F6UTl0ajRWdk5GdnBPZnRRa1V4dWVsYVBOUXhYdGYx?=
 =?utf-8?B?UkdBV3hzTENyTHdaTHhVTi9XQ29sejVyb2NhTGhLRlNmZEVNVEU3VVlFcURT?=
 =?utf-8?B?anEzSy9peVlCQkMxOW1lQ1dYdmJISkJHT2YrazRpM3ZxdnJ2NWVEZUZkNVFX?=
 =?utf-8?B?Y0JnT1o0Ni9Rb2FicmxXMkk4K3V1M0V0UFY0bGE3aDlrM25TVGhyMzdhWHdo?=
 =?utf-8?B?RVNzSitxTU9USlh4U2JvbUlqYUgvWmI1ZXFuSWtMVnB5bUNaNkJtcjM0bjJx?=
 =?utf-8?B?UHBMcVRtdWh5eVZCaTBleWN2RTdiZUo2bEZVazh1YlJiRG1ieVVKNVRtaU5H?=
 =?utf-8?B?U3JrUjhSMlpNNGNLUGhHQ3dKNktlT2dSY240bFRQSkxtaVErTEV2SzJmWDBp?=
 =?utf-8?B?QnhIb3lUZnc2MTdDNUxCS0lzWWdlTmVoV0ViVVpicndBL1pYMkxZWjhGblBz?=
 =?utf-8?B?cWR6RDJ5bWs0WVExVm9mME5xZzIyY3FuVHBYQnY4UTloRWdRMTZqdXV3Z0tB?=
 =?utf-8?B?Mk9yZDR6K1lrZHhmcXVyYlo4V1M1d1I1aUlidlYvWXROaDExc2RUQjkyYnJV?=
 =?utf-8?B?QWxqZ0ZIWEk2Q0tOQVkrdHdSNlVneUFLRFZKYzZ1R3h6Mzh6bUVwMU1pUS9x?=
 =?utf-8?B?UmoyakRWS0xRSndXTWM1SEY5TFExcFdWV200OVJ3aHFxRzcxV0prVlBGS1RS?=
 =?utf-8?B?RTBnTVJoODNNV1pHRDU5RVdWanpRRFIzUGF3cmVsNzRiWk04eTlGNmtqMkZR?=
 =?utf-8?B?QUNsY2NVNUZlckRwU2JCcHc0Wm9CZU9SY0FkUmxlSzF1VGdZbmNuaE5yUlVP?=
 =?utf-8?B?Uk5hTDBBdEJkZTRsTVp0b1JMWVdBRVFBdkhvMisxZllUemlaMmV2RVlScHZL?=
 =?utf-8?B?OUJsaXIzaGR1czFhcVM5MTl6c0FOTFZ2aTRqSjFHeHppUWx0WVJWeFNPWUhl?=
 =?utf-8?B?NExUZ08xYmdHeXBMY3lYSlVMaVRRaVBiQS9qT0dQT2kwd252N3Z5WTZJekJ3?=
 =?utf-8?B?NDk2azIvQlpJS3grY05RUEdyWUc4VkQ4RGE1WkZ2YzBPb0tVREZka2Vnc2t0?=
 =?utf-8?B?eVRIaUtFSTl4c2xaOHN0eVA0Rjc4dStJRGkvY1FrZERqekU0MER5cklVUU10?=
 =?utf-8?B?VHlOcldURi83dlFCVlZBRGdud1BrOUI5T082aXNRODNjanVmWFRKbjF3ZjA2?=
 =?utf-8?B?aDlFaURlbWcxalZYSFA4ckN2OFFzSWJ4bnczakdGQjMvTnNDN2pQekNDd2FF?=
 =?utf-8?B?TTcxcXZSQVgrQUxCVk51VlBoMmdHRHNkZ05iVHM5MWIrUStFTncvcUtKSHBn?=
 =?utf-8?B?TVdmSXF2T3U4UjI5M0Y3U3hNdktEbTdFV3hkUjBraVVYaWNlZnNpYmg3K0s5?=
 =?utf-8?B?ZWdkQ2dnZzZvUzlwRXBXYnlIVkw4Y0l1TjVxZ2x0OVNISjZ5ZWxoeUVsYjdr?=
 =?utf-8?B?RGxaUENPZVRjZ2w0SmlpUVN6MzB2MytuTmFWR1JpUCsrcWtqMlpJTnluM3Bk?=
 =?utf-8?B?Z2dOYUdpdTRGS21QVUlpR0FnVzZzdFl4UXg5bGk0KzcvelkyZFJQMzRDVm1C?=
 =?utf-8?B?ViswTXNENGZUWndJZEY5bFo0UHp6eG1DcFU3ZDZvZVlZQzVnQ21nemJsd2Fk?=
 =?utf-8?B?dnAxcXYyNzNxSUkyWXU0c01rem11Vk1ndjZ4QXg4N1RqdFNYNEE1RkdTYkJm?=
 =?utf-8?Q?epmY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8b0b21-a475-47f0-82b3-08de1153a4f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 10:13:28.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vf3fWZ6X+CHaj916ROx3EUuKi0OsaJnyyitFxs0+wjPHWQlrwWoOLOwS6tlDK8o47hA5yxpzNrVjllxYr1Jveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVmYW4gUm9lc2UgPHN0
ZWZhbi5yb2VzZUBtYWlsYm94Lm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIyLCAy
MDI1IDM6NDEgUE0NCj4gVG86IEhhdmFsaWdlLCBUaGlwcGVzd2FteSA8dGhpcHBlc3dhbXkuaGF2
YWxpZ2VAYW1kLmNvbT47DQo+IG1hbmlAa2VybmVsLm9yZw0KPiBDYzogQmpvcm4gSGVsZ2FhcyA8
aGVsZ2Fhc0BrZXJuZWwub3JnPjsgQmFuZGksIFJhdmkgS3VtYXINCj4gPHJhdmliQGFtYXpvbi5j
b20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LQ0K
PiBwY2lAdmdlci5rZXJuZWwub3JnOyBrd2lsY3p5bnNraUBrZXJuZWwub3JnOyByb2JoQGtlcm5l
bC5vcmc7IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgU2VhbiBBbmRlcnNvbg0KPiA8c2Vhbi5hbmRl
cnNvbkBsaW51eC5kZXY+OyBZZWxlc3dhcmFwdSwgTmFnYXJhZGhlc2gNCj4gPG5hZ2FyYWRoZXNo
LnllbGVzd2FyYXB1QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogeGls
aW54LXhkbWE6IEVuYWJsZSBJTlR4IGludGVycnVwdHMNCj4NCj4gT24gMTAvMjIvMjUgMTI6MDQs
IEhhdmFsaWdlLCBUaGlwcGVzd2FteSB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5
IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+DQo+ID4gSGkgTWFuaSwNCj4g
Pg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBtYW5pQGtlcm5l
bC5vcmcgPG1hbmlAa2VybmVsLm9yZz4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIy
LCAyMDI1IDM6MjUgUE0NCj4gPj4gVG86IFN0ZWZhbiBSb2VzZSA8c3RlZmFuLnJvZXNlQG1haWxi
b3gub3JnPg0KPiA+PiBDYzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgQmFu
ZGksIFJhdmkgS3VtYXINCj4gPj4gPHJhdmliQGFtYXpvbi5jb20+OyBIYXZhbGlnZSwgVGhpcHBl
c3dhbXkNCj4gPj4gPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+OyBscGllcmFsaXNpQGtl
cm5lbC5vcmc7DQo+ID4+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4+IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsgU2lt
ZWssIE1pY2hhbA0KPiA+PiA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBsaW51eC1hcm0tIGtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBTZWFuIEFuZGVyc29uDQo+ID4+IDxzZWFuLmFuZGVy
c29uQGxpbnV4LmRldj4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gUENJOiB4aWxpbngt
eGRtYTogRW5hYmxlIElOVHggaW50ZXJydXB0cw0KPiA+Pg0KPiA+PiBPbiBXZWQsIE9jdCAyMiwg
MjAyNSBhdCAwODo1OToxOUFNICswMjAwLCBTdGVmYW4gUm9lc2Ugd3JvdGU6DQo+ID4+PiBIaSBC
am9ybiwNCj4gPj4+IEhpIFJhdmksDQo+ID4+Pg0KPiA+Pj4gT24gMTAvMjEvMjUgMjM6MjgsIEJq
b3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4+Pj4gT24gVHVlLCBPY3QgMjEsIDIwMjUgYXQgMDg6NTU6
NDFQTSArMDAwMCwgQmFuZGksIFJhdmkgS3VtYXIgd3JvdGU6DQo+ID4+Pj4+PiBPbiBUdWUsIE9j
dCAyMSwgMjAyNSBhdCAwNTo0NjoxN1BNICswMDAwLCBCYW5kaSwgUmF2aSBLdW1hciB3cm90ZToN
Cj4gPj4+Pj4+Pj4gT24gT2N0IDIxLCAyMDI1LCBhdCAxMDoyM+KAr0FNLCBCam9ybiBIZWxnYWFz
DQo+ID4+Pj4+Pj4+IDxoZWxnYWFzQGtlcm5lbC5vcmc+DQo+ID4+IHdyb3RlOg0KPiA+Pj4+Pj4+
PiBPbiBTYXQsIFNlcCAyMCwgMjAyNSBhdCAxMDo1MjozMlBNICswMDAwLCBSYXZpIEt1bWFyIEJh
bmRpDQo+ID4+IHdyb3RlOg0KPiA+Pj4+Pj4+Pj4gVGhlIHBjaWUteGlsaW54LWRtYS1wbCBkcml2
ZXIgZG9lcyBub3QgZW5hYmxlIElOVHggaW50ZXJydXB0cw0KPiA+Pj4+Pj4+Pj4gYWZ0ZXIgaW5p
dGlhbGl6aW5nIHRoZSBwb3J0LCBwcmV2ZW50aW5nIElOVHggaW50ZXJydXB0cyBmcm9tDQo+ID4+
Pj4+Pj4+PiBQQ0llIGVuZHBvaW50cyBmcm9tIGZsb3dpbmcgdGhyb3VnaCB0aGUgWGlsaW54IFhE
TUEgcm9vdCBwb3J0DQo+ID4+Pj4+Pj4+PiBicmlkZ2UuIFRoaXMgaXNzdWUgYWZmZWN0cyBrZXJu
ZWwgNi42LjAgYW5kDQo+ID4+IGxhdGVyIHZlcnNpb25zLg0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+
Pj4+IFRoaXMgcGF0Y2ggYWxsb3dzIElOVHggaW50ZXJydXB0cyBnZW5lcmF0ZWQgYnkgUENJZSBl
bmRwb2ludHMNCj4gPj4+Pj4+Pj4+IHRvIGZsb3cgdGhyb3VnaCB0aGUgcm9vdCBwb3J0LiBUZXN0
ZWQgdGhlIGZpeCBvbiBhIGJvYXJkIHdpdGgNCj4gPj4+Pj4+Pj4+IHR3byBlbmRwb2ludHMgZ2Vu
ZXJhdGluZyBJTlR4IGludGVycnVwdHMuDQo+ID4+Pj4+Pj4+PiBJbnRlcnJ1cHRzIGFyZSBwcm9w
ZXJseSBkZXRlY3RlZCBhbmQgc2VydmljZWQuIFRoZQ0KPiA+Pj4+Pj4+Pj4gL3Byb2MvaW50ZXJy
dXB0cyBvdXRwdXQNCj4gPj4+Pj4+Pj4+IHNob3dzOg0KPiA+Pj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4+
IFsuLi5dDQo+ID4+Pj4+Pj4+PiAzMjogICAgICAgIDMyMCAgICAgICAgICAwICBwbF9kbWE6UkMt
RXZlbnQgIDE2IExldmVsICAgICA0MDAwMDAwMDAuYXhpLQ0KPiA+PiBwY2llLCBhemRydg0KPiA+
Pj4+Pj4+Pj4gNTI6ICAgICAgICA0NzAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAxNiBM
ZXZlbCAgICAgNTAwMDAwMDAwLmF4aS0NCj4gPj4gcGNpZSwgYXpkcnYNCj4gPj4+Pj4+Pj4+IFsu
Li5dDQo+ID4+Pg0KPiA+Pj4gRmlyc3QgYSBjb21tZW50IG9uIHRoaXMgSVJRIGxvZ2dpbmc6DQo+
ID4+Pg0KPiA+Pj4gVGhlc2UgbGluZXMgZG8gTk9UIHJlZmVyIHRvIHRoZSBJTlR4IElSUShzKSBi
dXQgdGhlIGNvbnRyb2xsZXINCj4gPj4+IGludGVybmFsICJldmVudHMiIChlcnJvcnMgZXRjKS4g
UGxlYXNlIHNlZSB0aGlzIGxvZyBmb3IgSU5UeCBvbiBteQ0KPiA+Pj4gVmVyc2FsIHBsYXRmb3Jt
IHdpdGggcGNpX2lycWRfaW50eF94bGF0ZSBhZGRlZDoNCj4gPj4+DQo+ID4+PiAgIDI0OiAgICAg
ICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgIDAgTGV2ZWwgICAgIExJTktfRE9X
Tg0KPiA+Pj4gICAyNTogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgICAz
IExldmVsICAgICBIT1RfUkVTRVQNCj4gPj4+ICAgMjY6ICAgICAgICAgIDAgICAgICAgICAgMCAg
cGxfZG1hOlJDLUV2ZW50ICAgOCBMZXZlbCAgICAgQ0ZHX1RJTUVPVVQNCj4gPj4+ICAgMjc6ICAg
ICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAgOSBMZXZlbCAgICAgQ09SUkVD
VEFCTEUNCj4gPj4+ICAgMjg6ICAgICAgICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50
ICAxMCBMZXZlbCAgICAgTk9ORkFUQUwNCj4gPj4+ICAgMjk6ICAgICAgICAgIDAgICAgICAgICAg
MCAgcGxfZG1hOlJDLUV2ZW50ICAxMSBMZXZlbCAgICAgRkFUQUwNCj4gPj4+ICAgMzA6ICAgICAg
ICAgIDAgICAgICAgICAgMCAgcGxfZG1hOlJDLUV2ZW50ICAyMCBMZXZlbCAgICAgU0xWX1VOU1VQ
UA0KPiA+Pj4gICAzMTogICAgICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgIDIx
IExldmVsICAgICBTTFZfVU5FWFANCj4gPj4+ICAgMzI6ICAgICAgICAgIDAgICAgICAgICAgMCAg
cGxfZG1hOlJDLUV2ZW50ICAyMiBMZXZlbCAgICAgU0xWX0NPTVBMDQo+ID4+PiAgIDMzOiAgICAg
ICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjMgTGV2ZWwgICAgIFNMVl9FUlJQ
DQo+ID4+PiAgIDM0OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAgMjQg
TGV2ZWwgICAgIFNMVl9DTVBBQlQNCj4gPj4+ICAgMzU6ICAgICAgICAgIDAgICAgICAgICAgMCAg
cGxfZG1hOlJDLUV2ZW50ICAyNSBMZXZlbCAgICAgU0xWX0lMTEJVUg0KPiA+Pj4gICAzNjogICAg
ICAgICAgMCAgICAgICAgICAwICBwbF9kbWE6UkMtRXZlbnQgIDI2IExldmVsICAgICBNU1RfREVD
RVJSDQo+ID4+PiAgIDM3OiAgICAgICAgICAwICAgICAgICAgIDAgIHBsX2RtYTpSQy1FdmVudCAg
MjcgTGV2ZWwgICAgIE1TVF9TTFZFUlINCj4gPj4+ICAgMzg6ICAgICAgICAgOTQgICAgICAgICAg
MCAgcGxfZG1hOlJDLUV2ZW50ICAxNiBMZXZlbCAgICAgODQwMDAwMDAuYXhpLXBjaWUNCj4gPj4+
ICAgMzk6ICAgICAgICAgOTQgICAgICAgICAgMCAgcGxfZG1hOklOVHggICAwIExldmVsICAgICBu
dm1lMHEwLCBudm1lMHExDQo+ID4+Pg0KPiA+Pj4gVGhlIGxhc3QgbGluZSBzaG93cyB0aGUgSU5U
eCBJUlFzIGhlcmUgKCdwbF9kbWE6SU5UeCcgdnMgJ3BsX2RtYTpSQy0NCj4gPj4+IEV2ZW50Jyku
DQo+ID4+Pg0KPiA+Pj4gTW9yZSBiZWxvdy4uLg0KPiA+Pj4NCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+
Pj4+PiBDaGFuZ2VzIHNpbmNlIHYxOjoNCj4gPj4+Pj4+Pj4+IC0gRml4ZWQgY29tbWl0IG1lc3Nh
Z2UgcGVyIHJldmlld2VyJ3MgY29tbWVudHMNCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiBGaXhl
czogOGQ3ODYxNDlkNzhjICgiUENJOiB4aWxpbngteGRtYTogQWRkIFhpbGlueCBYRE1BIFJvb3QN
Cj4gPj4+Pj4+Pj4+IFBvcnQgZHJpdmVyIikNCj4gPj4+Pj4+Pj4+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+ID4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBSYXZpIEt1bWFyIEJhbmRpIDxy
YXZpYkBhbWF6b24uY29tPg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBIaSBSYXZpLCBvYnZpb3Vz
bHkgeW91IHRlc3RlZCB0aGlzLCBidXQgSSBkb24ndCBrbm93IGhvdyB0bw0KPiA+Pj4+Pj4+PiBy
ZWNvbmNpbGUgdGhpcyB3aXRoIFN0ZWZhbidzIElOVHggZml4IGF0DQo+ID4+Pj4+Pj4+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTEwMjExNTQzMjIuOTczNjQwLTEtc3RlZmFuLnJvZQ0K
PiA+Pj4+Pj4+PiBzZUBtYWlsYm94Lm9yZw0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBEb2VzIFN0
ZWZhbidzIGZpeCBuZWVkIHRvIGJlIHNxdWFzaGVkIGludG8gdGhpcyBwYXRjaD8NCj4gPj4+Pj4+
Pg0KPiA+Pj4+Pj4+IFN1cmUsIHdlIGNhbiBzcXVhc2ggU3RlZmFu4oCZcyBmaXggaW50byB0aGlz
Lg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IEkga25vdyB3ZSAqY2FuKiBzcXVhc2ggdGhlbS4NCj4gPj4+
Pj4+DQo+ID4+Pj4+PiBJIHdhbnQgdG8ga25vdyB3aHkgdGhpbmdzIHdvcmtlZCBmb3IgeW91IGFu
ZCBTdGVmYW4gd2hlbiB0aGV5DQo+ID4+Pj4+PiAqd2VyZW4ndCogc3F1YXNoZWQ6DQo+ID4+Pj4+
Pg0KPiA+Pj4+Pj4gICAgLSBXaHkgZGlkIElOVHggd29yayBmb3IgeW91IGV2ZW4gd2l0aG91dCBT
dGVmYW4ncyBwYXRjaC4gIERpZCB5b3UNCj4gPj4+Pj4+ICAgICAgZ2V0IElOVHggaW50ZXJydXB0
cyBidXQgbm90IHRoZSByaWdodCBvbmVzLCBlLmcuLCBkaWQgdGhlIGRldmljZQ0KPiA+Pj4+Pj4g
ICAgICBzaWduYWwgSU5UQSBidXQgaXQgd2FzIHJlY2VpdmVkIGFzIElOVEI/DQo+ID4+Pj4+DQo+
ID4+Pj4+IEkgc2F3IHRoYXQgaW50ZXJydXB0cyB3ZXJlIGJlaW5nIGdlbmVyYXRlZCBieSB0aGUg
ZW5kcG9pbnQgZGV2aWNlLA0KPiA+Pj4+PiBidXQgSSBkaWRu4oCZdCBzcGVjaWZpY2FsbHkgY2hl
Y2sgaWYgdGhleSB3ZXJlIGNvcnJlY3RseSB0cmFuc2xhdGVkDQo+ID4+Pj4+IGluIHRoZSBjb250
cm9sbGVyLiBJIG5vdGljZWQgdGhhdCB0aGUgbmV3IGRyaXZlciB3YXNuJ3QgZXhwbGljaXRseQ0K
PiA+Pj4+PiBlbmFibGluZyB0aGUgaW50ZXJydXB0cywgc28gbXkgZmlyc3QgYXBwcm9hY2ggd2Fz
IHRvIGVuYWJsZSB0aGVtLA0KPiA+Pj4+PiB3aGljaCBoZWxwZWQgdGhlIGludGVycnVwdHMgZmxv
dyB0aHJvdWdoLg0KPiA+Pj4+DQo+ID4+Pj4gT0ssIEknbGwgYXNzdW1lIHRoZSBpbnRlcnJ1cHRz
IGhhcHBlbmVkIGJ1dCB0aGUgZHJpdmVyIG1pZ2h0IG5vdA0KPiA+Pj4+IGhhdmUgYmVlbiBhYmxl
IHRvIGhhbmRsZSB0aGVtIGNvcnJlY3RseSwgZS5nLiwgaXQgd2FzIHByZXBhcmVkIGZvcg0KPiA+
Pj4+IElOVEEgYnV0IGdvdCBJTlRCIG9yIHNpbWlsYXIuDQo+ID4+Pj4NCj4gPj4+Pj4+ICAgIC0g
V2h5IGRpZCBTdGVmYW4ncyBwYXRjaCB3b3JrIGZvciBoaW0gZXZlbiB3aXRob3V0IHlvdXIgcGF0
Y2guICBIb3cNCj4gPj4+Pj4+ICAgICAgY291bGQgU3RlZmFuJ3MgSU5UeCB3b3JrIHdpdGhvdXQg
dGhlIENTUiB3cml0ZXMgdG8gZW5hYmxlDQo+ID4+Pj4+PiAgICAgIGludGVycnVwdHM/DQo+ID4+
Pj4+DQo+ID4+Pj4+IEknbSBub3QgZW50aXJlbHkgc3VyZSBpZiB0aGVyZSBhcmUgYW55IG90aGVy
IGRlcGVuZGVuY2llcyBpbiB0aGUNCj4gPj4+Pj4gRlBHQSBiaXRzdHJlYW0uIEknbGwgaW52ZXN0
aWdhdGUgZnVydGhlciBhbmQgZ2V0IGJhY2sgdG8geW91Lg0KPiA+Pj4+DQo+ID4+Pj4gU3RlZmFu
IGNsYXJpZmllZCBpbiBhIHByaXZhdGUgbWVzc2FnZSB0aGF0IGhlIGhhZCBhcHBsaWVkIHlvdXIN
Cj4gPj4+PiBwYXRjaCBmaXJzdCwgc28gdGhpcyBteXN0ZXJ5IGlzIHNvbHZlZC4NCj4gPj4+DQo+
ID4+PiBZZXMuIEkgYXBwbGllZCBSYXZpJ3MgcGF0Y2ggZmlyc3QgYW5kIHN0aWxsIGdvdCBubyBJ
TlR4IGRlbGl2ZXJlZCB0bw0KPiA+Pj4gdGhlIG52bWUgZHJpdmVyLiBUaGF0J3Mgd2hhdCBtZSB0
cmlnZ2VyZWQgdG8gZGlnIGRlZXBlciBoZXJlIGFuZA0KPiA+Pj4gcmVzdWx0ZWQgaW4gdGhpcyB2
MiBwYXRjaCB3aXRoIHBjaV9pcnFkX2ludHhfeGxhdGUgYWRkZWQuDQo+ID4+Pg0KPiA+Pj4gQlRX
Og0KPiA+Pj4gSSByZS10ZXN0ZWQganVzdCBub3cgdy9vIFJhdmkncyBwYXRjaCBhbmQgdGhlIElO
VHggd29ya2VkLiBTdGlsbCBJDQo+ID4+PiB0aGluayBSYXZpJ3MgcGF0Y2ggaXMgdmFsaWQgYW5k
IHNob3VsZCBiZSBhcHBsaWVkLi4uDQo+ID4+DQo+ID4+IEhvdyBjb21lIElOVHggaXMgd29ya2lu
ZyB3aXRob3V0IHRoZSBwYXRjaCBmcm9tIFJhdmkgd2hpY2ggZW5hYmxlZA0KPiA+PiBJTlR4IHJv
dXRpbmcgaW4gdGhlIGNvbnRyb2xsZXI/IFdhcyBpdCBlbmFibGVkIGJ5IGRlZmF1bHQgaW4gdGhl
IGhhcmR3YXJlPw0KPiA+DQo+ID4gQ2FuIHlvdSBwbGVhc2UgY3Jvc3MtY2hlY2sgdGhlIGludGVy
cnVwdC1tYXAgcHJvcGVydHkgaW4gdGhlIGRldmljZSB0cmVlPw0KPiBDdXJyZW50bHksIHRoZSBk
cml2ZXIgaXNu4oCZdCB0cmFuc2xhdGluZyAocGNpX2lycWRfaW50eF94bGF0ZSkgdGhlIElOVHgg
bnVtYmVyLg0KPiA+DQo+ID4gSGVyZeKAmXMgcmVxdWlyZWQgRFQgcHJvcGVydHk6DQo+ID4NCj4g
PiBpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJnBjaWVfaW50Y18wIDA+LA0KPiA+ICAgICAgICAg
ICAgICAgICAgPDAgMCAwIDIgJnBjaWVfaW50Y18wIDE+LA0KPiA+ICAgICAgICAgICAgICAgICAg
PDAgMCAwIDMgJnBjaWVfaW50Y18wIDI+LA0KPiA+ICAgICAgICAgICAgICAgICAgPDAgMCAwIDQg
JnBjaWVfaW50Y18wIDM+Ow0KPg0KPiBIZXJlIHRoZSBhdXRvLWdlbmVyYXRlZCBEVCBwcm9wZXJ0
eSAoVml2YWRvIDIwMjUuMSkgZm9yIG91ciBkZXNpZ246DQo+DQo+ICAgICAgICAgIGludGVycnVw
dC1tYXAgPSA8MCAwIDAgMSAmcHN2X3BjaWVfaW50Y18wIDE+LA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgPDAgMCAwIDIgJnBzdl9wY2llX2ludGNfMCAyPiwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgIDwwIDAgMCAzICZwc3ZfcGNpZV9pbnRjXzAgMz4sDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICA8MCAwIDAgNCAmcHN2X3BjaWVfaW50Y18wIDQ+Ow0KPg0KPiBTbyB3ZSBzaG91
bGQgbWFudWFsbHkgImZpeCIgdGhlIGF1dG8tZ2VuZXJhdGVkIERUIGluc3RlYWQ/IEkgd291bGQg
cmF0aGVyIGxpa2UNCj4gdG8gc2tpcCBzdWNoIGEgc3RlcCwgYXMgdGhpcyBpcyBlcnJvciBwcm9u
ZSB3aXRoIGZyZXF1ZW50IHVwZGF0ZXMgZnJvbSB0aGUgRlBHQQ0KPiBiaXN0cmVhbSBkZXNpZ24u
DQpZZXMsIHlvdSBuZWVkIHRvIG1hbnVhbGx5IGZpeCB0aGlzIGF1dG8tZ2VuZXJhdGVkIERUIGZv
ciBub3cuIFdpbGwgdGFrZSB0aGlzIGRpc2N1c3Npb24gb2ZmbGluZS4NCj4NCj4gVGhhbmtzLA0K
PiBTdGVmYW4NCg0K

