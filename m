Return-Path: <linux-pci+bounces-30571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF007AE75BE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 06:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4125A1A91
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C2A48;
	Wed, 25 Jun 2025 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="arBbEktq"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A94C83;
	Wed, 25 Jun 2025 04:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750824914; cv=fail; b=V1TV7p+WxdQRFFgzjT29gqcSBa15FX2TuTSqyo2kdz+6g7cNal/usHZaR+FJFW68Nr4mr0No2rysGsgjWqUYW5Rh/Et8Cckb2kSUtKaNxh71lOZIY1NPqCbYcQbINMBN20PehJfYcddWUGDWVtvgZLSzTgRsLgWVd5g7v/z6dQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750824914; c=relaxed/simple;
	bh=H0pP0MlEAuqULTHkoEIEQvCx1OgEMu2sratQkCGOhb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dR2GvBc6D8sBNoxhNq7yX2RxTjdSx+ZXTz6rQCEyg4ym4eBeQNiRq9YHQRFD4i13jRllmJ7XhlYduqemehklN9PUwBcpuCZN6qUZWIzydz29fTXlp6zr11AuWELPTEt6UPTxP26QFoVwdyWUO2o4aCxml6fc5JE34lJR6r4VK2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=arBbEktq; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux5D0gQYmitBZ/kp7wrrNeZR8y0YMkrRBvP5/EhFzw88/uthkAyE16JtU5C4dPJEFUuS2EwDklZLLb2zbiUhsQssn7PLn2Q7M2wGo7nQSbQRUEep0B9GGK65IMyp1aNmv2UwdPe/v3JBAcxi0UUSZB8tyFSo4q0+xuWoBYuSNhswL2FHp/rMn5jFYJq/lFM4pW86E1avQk1XVSkOhhaGcUOZai4AQF0cGkEtHSCMjzSO1tVb46RLKh5tZhJAnzGcQQbwl/cQBs61RsAsP7beK8Otq8cxAawSgtgXKdmcphjmAMZnf3k7qxaxlbGn6uqQNdil2nlkoyIlTBdVPd2lQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0pP0MlEAuqULTHkoEIEQvCx1OgEMu2sratQkCGOhb0=;
 b=veInba1yaY6J0zYSwnHlHGL4ey/fIHI6046e71AWlKUUXmaZXyiEE0lVl/ZZTmhYus45S5dw/sGvwgGKZY/e0plXuf7qOUIMJosOLMcXkLrVLDb0UVn1DPSKzVYrAU4PJ7/9cyvEiVwLTulz2fx2aNbKTOkhyXkUz98h3ZM9o3SGsUaLDeE+hALByr+rLCl0LIDZaA5934WFDg+XhkeWaD1eAokN7AzPjqp4co+llm5zKKoj77j0/41d2+uhJBKC7uu11zCdSAH8uYG01SjU5MwpkpLjYLTxNMnVTWcfoX7uapBORX1hLJVKgnOWVHFbmjItM13pjjhtMMptBVZxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0pP0MlEAuqULTHkoEIEQvCx1OgEMu2sratQkCGOhb0=;
 b=arBbEktqK7RCtOEo3h4QL5NwRB2uxJ5kS6cSOYAC/zKNyUCXrccFoxHYgtl0DrXmteNtjr6t0xnT08g+uq166sLJqVFdSkUVlpPUqcgDE8tz23epALZ4APA5K6aUkhw8Qcv9RXo+rI3CsLkTzthVIVizjKZppoW66TQDSZEBz+E=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 SA1PR12MB9489.namprd12.prod.outlook.com (2603:10b6:806:45c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.23; Wed, 25 Jun 2025 04:15:09 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 04:15:09 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v3 1/2] dt-bindings: PCI: amd-mdb: Add reset-gpios
 property for PCIe RP PERST# handling
Thread-Topic: [PATCH v3 1/2] dt-bindings: PCI: amd-mdb: Add reset-gpios
 property for PCIe RP PERST# handling
Thread-Index: AQHb4ChbWU/Js07REECHJCA1c+jrELQQZxKAgALnpeA=
Date: Wed, 25 Jun 2025 04:15:09 +0000
Message-ID:
 <DM4PR12MB6158ADC754402BAD15C57818CD7BA@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250618080931.2472366-1-sai.krishna.musham@amd.com>
 <20250618080931.2472366-2-sai.krishna.musham@amd.com>
 <29bdba7e-63f6-4084-901d-beaab0e74894@oss.qualcomm.com>
In-Reply-To: <29bdba7e-63f6-4084-901d-beaab0e74894@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-25T04:13:33.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|SA1PR12MB9489:EE_
x-ms-office365-filtering-correlation-id: 3552eb8e-957e-4e3e-dfc2-08ddb39edf98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFdEL0RnSWJNbDdSMEQ1YklGN3ZjRzdZWGx6aWxMKzc2MDVrcUljWXNBb0hz?=
 =?utf-8?B?SHROVXpyRlFuOFhuanYzeEt0SGt1ZEpyQkRtTkgrMnRZLzZJa1FiWCtuN3VW?=
 =?utf-8?B?dEl1TFRXTlZFb2xnZnBYQ2ZNLzhrbUVod01pMEJ2c3kwTTJ3cXBtbUQzNk5Q?=
 =?utf-8?B?allpNU12c0pRV2J1VTlGWEh1WDZxQWRzNFpqZVFDWTV3bS9pcjlVdDJUelJ2?=
 =?utf-8?B?dmg5WVVBSDQyR1I3UzRUL1REcGkvSzFYTlNKMXJaU3RyNkV6ZXFMaitpdHNs?=
 =?utf-8?B?NGVWUVlyRnloL25SV2hpYWh0bGFBZStreUo0eE1SMjcvY0xwakh4dnNvbldX?=
 =?utf-8?B?L0tsZVJOUHdOd2hjbUdGaHkyL2tVRkNKTU5DSkRxdjJlTzEzNU9HWlp3OTBE?=
 =?utf-8?B?OUNYSWoza0tXNkZ0SnVxdUkwMWJtQU5YZU1PTDRYSDVWWWJ6YXJqdWNibEUz?=
 =?utf-8?B?U0g0WUwydUxrdkpySUU3YzNJK3l3TmhJMGFmeFhzUHRZcEg1aGZSVXZZUVNY?=
 =?utf-8?B?dERuczJEWUpiZkxoNTk2d2x3dzZ6ZU5wM1E4V0U0cE4vdU00T3d1bkJQNmYx?=
 =?utf-8?B?Yk1EL2FQc1Q4emQ1TzJMak05bHVxVHJsdGVRc2IwZVpkQVhEUng3ajZPWTE2?=
 =?utf-8?B?RjhnUzU1ZGZjV0hmenF1eXlxTlJBWENPS2lPbFV0Y0tuelI4V0hmbCs4VEky?=
 =?utf-8?B?eURVVWt0ZW5WdExUc1NDNjh6U3NJNU51UVpoTDVlbCt0bWVRN1pCWFpwVnFE?=
 =?utf-8?B?c0FyMjFBZHVBMEZ3K2pxYmhvQ0xIbXlTZ1pnNGorMnJYeGFSeWlUZkZQejF5?=
 =?utf-8?B?LzBwZDkwUXRyWEtWcmh5em84NDUxU3lLSWNqd2lXSnA0ZnE4anN0S09kUmxo?=
 =?utf-8?B?RDlCSDJZclR0RXdvVjlYSDVld0piYVJFOUFVRTVvbVA0SzEwNHJDbHdnWHZH?=
 =?utf-8?B?cTlHR3BDUTR5alp1OVNZSlAzSWtOeHBndWozZklEb0ZFWmhGM200bnVHS2tN?=
 =?utf-8?B?eEtIejBHNlI1K3E2WTl3ajNmT1RqZUZYZ0Jna25LKzF3UDZMenlxRWs0c1dP?=
 =?utf-8?B?U2N0eW5SRnA3K00rc3RyNFNTTVNTNEM1U1VCVzViYXFad25WSkkvYWtFM0ls?=
 =?utf-8?B?dld4VE5YTHBuUUkrcW9PQWJySEFObFB5TVJDWlNCWElTd1h1YitjVm1kdEdj?=
 =?utf-8?B?eVcvNzdieDE1dDlrV3dGdWwwMkxhT2sybG5Ed0RNS0srM1hweWxPRnBRL3U5?=
 =?utf-8?B?cDhXNThFNURQc09MZWYxV05JaTJKSzJzblJwaWJqZExPWTJCdUExcmt3VTg5?=
 =?utf-8?B?TWdiMTJtRzd6WTN4bSttRml6M2ZzdGNKTkxzQWJZR3VZczBCc29zT2xPZEtO?=
 =?utf-8?B?MSthM2pXa2hYTmc1OWRReUVqRmFPNndpTndIQzNRTlZTWHdCNy9yNXJOTlJk?=
 =?utf-8?B?WFlGR013M2luOEVGNkY4K0QxNnZSa0ZXWlJtODlrekpMSFAzWnllWlN0YkVh?=
 =?utf-8?B?TUhyb3lVMGFvSnEvVDJDdUoySGdLd0ZJZGNVMWYyNFBBSlJScFRWbGh4Yks5?=
 =?utf-8?B?YjVPQmFJcWYzb1VBcU1SZ2JKK3ZwY1RqcG1KRlU1MDZSTWFoRlkvL3loZ0Jz?=
 =?utf-8?B?VW9iaXJuRm9BOFZJUWN3QmMxU2RBQnlPSkJaZHZUallnWk5JT1lXc3RiV2pO?=
 =?utf-8?B?UUVjVXFEeVNrWXJKRG4vOVdIY05zS0dZRElmMjY3VVNYSUxLeURhODNtYkFD?=
 =?utf-8?B?b3NqNC9KYjlta0VIZVZBeE14bVQvY2JmR3RlZkFvN3dxMEMySWlIZ0d4T3I4?=
 =?utf-8?B?dmFseWdIZVVBUTRYWjZZYjR6UENmaVJlc0VlYWJqSkRhL1ErcVpmTThtVVF1?=
 =?utf-8?B?SDNBMEt5L1dSMEdlUDREeGE0VTl6aTNndUdkc1pWcGZtbW1VOXp0aWw4MWxa?=
 =?utf-8?B?V1FxQjNIY3BrdytnM2Q2cGV5RXdKWEw5MmNzVm1wenlYSXpMOHg2Vm5Ia2Fq?=
 =?utf-8?Q?aIlXdh10SVycMTxxkyw2RiGv0ofI4E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXlUMGVNUXRMT0gvMHVaUEtkb25zV2lCN0xweWN6Rk0zMkhCeGp1ZW1DeWFi?=
 =?utf-8?B?Ni85S2k3VW9qRGR5YmpDVm1YbUxFYldGWWdmcFRneTdFbFBMME4rdW90cFJU?=
 =?utf-8?B?cjdMVW1vVmVmMDh5enk2Mnc2UXF1ZHBCWnJwdkZCTExqYlRPT0NLSVpaaUhw?=
 =?utf-8?B?QkF5SFdJTFdaVXE4ODB3bzcwZXE2MnNOQ1RJWWxGRWNnT2pxVjlLWllPZkRt?=
 =?utf-8?B?LzhlbWUwblhnNnZrai9YZnAzTnBzU0lDczRNSDBVN0o0VnBWUElicDBHUUpF?=
 =?utf-8?B?Wml0QWs0bUg3a1Zvd0RFWEJBaE0xblR1dVhVd3JLTHBVNWUwMVhSaVlTQ0Y1?=
 =?utf-8?B?c0M5TzRETGk3dGNWc2swTXhPUW5vdUpuTkZpa1Mzeko0QnFUcjBHV1M1M3gz?=
 =?utf-8?B?Mm5VWVQ3ZFVtQXFPL090M2Z5Q1BMT2tScWJVM1U3bFd0N1p0MEFYK2MrZlF3?=
 =?utf-8?B?OTBTeU82TkNlR2hvM2xHR1g0Ti91RW5EUW9KWHIwT29TNkt0VmI3bndtMEpw?=
 =?utf-8?B?cmVhRUZUL0pWL1FxZFVrVDlNVG5xUFI4STZrQnZsekhBdG9VR0dYWnJPcW5u?=
 =?utf-8?B?OHlGSDBWUUFGVS96SVl0YmJwdjVnOWJ3azczQmI5aE96RnkyNXlyMTM0QStK?=
 =?utf-8?B?eDFhVEtzU0xVVW5kNkRqSi9XbDlZL0lHZ3VJV2I0RTlJMHZZRStOaTBoN0VC?=
 =?utf-8?B?RkhidjE5dWVBSGZEVWVQVHdjNXYzdUQyNFI1YVVmck1Yc25PVW5jYlh6bDRI?=
 =?utf-8?B?WUEzTml4NGZxTUk0WlROUDVXY0lCNlJWT1VSd0U5RHVxMDhlOHNqZzR5ZnNT?=
 =?utf-8?B?WTcyUmI5TkR0eDNoTkViblFMdDdHMyt5Qy8zTm9MOWMxRkdFYlg3dkdCMlpY?=
 =?utf-8?B?M1A4Y29ySE1IN1BuL3grRFhvQ1Ezd0JON2xJLy9JTHlobTNHUUovYWFTc1N4?=
 =?utf-8?B?Q1YzM3MzRytSelNGc21uQWRsNUJmODF3QjdKMjFWbUl0VGg1eWN2dFVaYjhT?=
 =?utf-8?B?SFJqUVZwdVpKbm03M1FHc0hDOUFQc2k3bjlrS09xQ1Z6ZDJHc3UxaHFlaDA1?=
 =?utf-8?B?aDZvMXJwYVdtaFZNaHRFQTl3alI2dVhKRTQ5anlBSTJKZjdscGVneHREajRk?=
 =?utf-8?B?ZStka1M4Y1dCZEcwVStIWm90cDFGVW5KS3Arb3F4N3dVKzBZTTdOa2tIWFU1?=
 =?utf-8?B?R1FURGVxVnlNRjN3QXQrK0FXdkdZbEJrbXNObjBrOGkySzFpKy9xQXRqV3RG?=
 =?utf-8?B?cGI1L2gydFc3NXYrYU8xMFRsSEVVakdwVjZBQXFLbUVycUhrNThTZittOEth?=
 =?utf-8?B?WjVKV25VVEtzOXJqS1d6U25ONEphbFdhZU9QbWtmQ1ZaK3BTVDh5YnF4NWFn?=
 =?utf-8?B?Sjg2ZDBvQVJkSjJEakpsa0FzdzJ2WjF2ZkFBaEFmSEhZSGpPcUZxZ1Y3amdD?=
 =?utf-8?B?U2hrdE1hRlhUS0lpdVVFWWgrUUFjYXN0QjkzOHdweSsxOE9vWWJ0enZUaFNp?=
 =?utf-8?B?NkZDYkdMcm81QituS2tiaTdmRTFPRVU5dVZ2b3NHR3BMbHBoWWFTQVFVYk00?=
 =?utf-8?B?VWRUV0hWeHdUSUxWWUFZbEtRdGN3Y29HN2hOWGVuTi9qd3ltcm5QYlY2NHR3?=
 =?utf-8?B?d0pFY1ViR2Zkdy9rbnd4RXBXam5FWTZMYUZWUnQ2WXdXY2hVTlpRQkF4OEdi?=
 =?utf-8?B?QU9ZNXZJLzE1QWdKWklTTlNpOU43RStWZ2dlMW5zeUhpa2hvVUFTbUlxNGx2?=
 =?utf-8?B?WUR4N21IQW02aFJDVk5XckxST09sK3B2cngyWnk3eTBTaHBhcTArZWNLNmNj?=
 =?utf-8?B?cEE3Mzh4YnNjOXJFeENwMlZrblFQaFZuZ2RJSVBmVFRDOUtPdGUzY3NYYkJz?=
 =?utf-8?B?bnJPQnROU2QwMHlrVVNscWN4emRucm1kMkduVHhaZXlCLytLdkJsWjNZUlBw?=
 =?utf-8?B?RTlvUUxMLzBtTkFFa0kwWFFlWFUvN0tXMUJzNG5nT3l3ZlJvUVZrOE1jSFNo?=
 =?utf-8?B?RVVWNnFIVnN2ZUdvUEI1cFh6TG5VZ28ydkNSWGdwT3cwME1Rb3JOTDFBWG5a?=
 =?utf-8?B?ZVQ5K3NxQzBpOU42N3NPL0NzMUpwbXdKRVRSVVFvWnI4R1BhU1BLL2RubERk?=
 =?utf-8?Q?SqmE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3552eb8e-957e-4e3e-dfc2-08ddb39edf98
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 04:15:09.3619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXxlUCXYgpEXanp00hNCg0ajuGO9V8xG62hi4T0L0kqtV5TF2hPXtP3vsRl8zK6oRI0JhQ03iyGq20KxgPBqRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9489

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3Jpc2huYSBDaGFpdGFueWEsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogS3Jpc2huYSBDaGFpdGFueWEgQ2h1bmRydSA8a3Jpc2huYS5jaHVuZHJ1QG9zcy5x
dWFsY29tbS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAyMywgMjAyNSAxOjIyIFBNDQo+IFRv
OiBNdXNoYW0sIFNhaSBLcmlzaG5hIDxzYWkua3Jpc2huYS5tdXNoYW1AYW1kLmNvbT47DQo+IGJo
ZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOyBt
YW5pQGtlcm5lbC5vcmc7DQo+IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBj
b25vcitkdEBrZXJuZWwub3JnOyBjYXNzZWxAa2VybmVsLm9yZw0KPiBDYzogbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47
IEdvZ2FkYSwgQmhhcmF0DQo+IEt1bWFyIDxiaGFyYXQua3VtYXIuZ29nYWRhQGFtZC5jb20+OyBI
YXZhbGlnZSwgVGhpcHBlc3dhbXkNCj4gPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBkdC1iaW5kaW5nczogUENJOiBhbWQtbWRiOiBB
ZGQgcmVzZXQtZ3Bpb3MgcHJvcGVydHkNCj4gZm9yIFBDSWUgUlAgUEVSU1QjIGhhbmRsaW5nDQo+
DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291
cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlj
a2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gNi8xOC8yMDI1IDE6MzkgUE0s
IFNhaSBLcmlzaG5hIE11c2hhbSB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIGByZXNl
dC1ncGlvc2AgcHJvcGVydHkgaW4gdGhlIFBDSWUgUm9vdCBQb3J0IChSUCkNCj4gPiBjaGlsZCBu
b2RlIHRvIGhhbmRsZSB0aGUgUEVSU1QjIHNpZ25hbCB2aWEgR1BJTy4gVXBkYXRlIHRoZSBleGFt
cGxlDQo+ID4gdG8gcmVmbGVjdCB0aGlzIGFkZGl0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2FpIEtyaXNobmEgTXVzaGFtIDxzYWkua3Jpc2huYS5tdXNoYW1AYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IC0gTW92ZSByZXNldC1ncGlvcyB0byBQQ0kgYnJp
ZGdlIG5vZGUuDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gVXBkYXRlIGNvbW1pdCBt
ZXNzYWdlDQo+ID4gLS0tDQo+ID4gICAuLi4vYmluZGluZ3MvcGNpL2FtZCx2ZXJzYWwyLW1kYi1o
b3N0LnlhbWwgICAgfCAyNiArKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdl
ZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvYW1kLHZlcnNhbDItbWRiLWhvc3QueWFtbA0KPiBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvYW1kLHZlcnNhbDItbWRiLWhvc3Qu
eWFtbA0KPiA+IGluZGV4IDQzZGMyNTg1YzIzNy4uM2ZmZTQ1MTI2NTBkIDEwMDY0NA0KPiA+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvYW1kLHZlcnNhbDItbWRi
LWhvc3QueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvYW1kLHZlcnNhbDItbWRiLWhvc3QueWFtbA0KPiA+IEBAIC03MSw2ICs3MSwyMSBAQCBwcm9w
ZXJ0aWVzOg0KPiA+ICAgICAgICAgLSAiI2FkZHJlc3MtY2VsbHMiDQo+ID4gICAgICAgICAtICIj
aW50ZXJydXB0LWNlbGxzIg0KPiA+DQo+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ICsgICde
cGNpZUBbMC0yXSwwJCc6DQo+ID4gKyAgICB0eXBlOiBvYmplY3QNCj4gPiArICAgICRyZWY6IC9z
Y2hlbWFzL3BjaS9wY2ktcGNpLWJyaWRnZS55YW1sIw0KPiA+ICsNCj4gPiArICAgIHByb3BlcnRp
ZXM6DQo+ID4gKyAgICAgIHJlZzoNCj4gPiArICAgICAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4g
PiArICAgICAgcmVzZXQtZ3Bpb3M6DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IEdQSU8gY29u
dHJvbGxlZCBjb25uZWN0aW9uIHRvIFBFUlNUIyBzaWduYWwNCj4gPiArICAgICAgICBtYXhJdGVt
czogMQ0KPiA+ICsNCj4gVGhpcyBpcyBhbHJlYWR5IHBhcnQgb2YgcGNpLWJ1cy1jb21tb24ueWFt
bCBpbiBkdHNjaGVtYSBubyBuZWVkIHRvDQo+IGRlZmluZSBpdCBhZ2FpbiBoZXJlLg0KPg0KDQpU
aGFua3MgZm9yIHRoZSByZXZpZXcuIFN1cmUsIEkgd2lsbCByZW1vdmUgaXQuDQoNCj4gLSBLcmlz
aG5hIENoYWl0YW55YS4NCj4NCj4gPiArICAgIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UN
Cj4gPiArDQo+ID4gICByZXF1aXJlZDoNCj4gPiAgICAgLSByZWcNCj4gPiAgICAgLSByZWctbmFt
ZXMNCj4gPiBAQCAtODcsNiArMTAyLDcgQEAgZXhhbXBsZXM6DQo+ID4gICAgIC0gfA0KPiA+ICAg
ICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+
DQo+ID4gICAgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2ly
cS5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiA+DQo+
ID4gICAgICAgc29jIHsNCj4gPiAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4g
QEAgLTExMiw2ICsxMjgsMTYgQEAgZXhhbXBsZXM6DQo+ID4gICAgICAgICAgICAgICAjc2l6ZS1j
ZWxscyA9IDwyPjsNCj4gPiAgICAgICAgICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+
ID4gICAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgcGNpZUAwLDAgew0KPiA+ICsgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNp
IjsNCj4gPiArICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHgwIDB4MCAweDAgMHgwPjsNCj4g
PiArICAgICAgICAgICAgICAgIHJlc2V0LWdwaW9zID0gPCZ0Y2E2NDE2X3UzNyA3IEdQSU9fQUNU
SVZFX0xPVz47DQo+ID4gKyAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4g
PiArICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgcmFuZ2VzOw0KPiA+ICsgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiAgICAgICAgICAgICAg
IHBjaWVfaW50Y18wOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+ID4gICAgICAgICAgICAgICAg
ICAgI2FkZHJlc3MtY2VsbHMgPSA8MD47DQo+ID4gICAgICAgICAgICAgICAgICAgI2ludGVycnVw
dC1jZWxscyA9IDwxPjsNCg==

