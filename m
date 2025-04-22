Return-Path: <linux-pci+bounces-26365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C62A95E98
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 08:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8543A38FA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40B319F41C;
	Tue, 22 Apr 2025 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fhhB+UBs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E3197A68;
	Tue, 22 Apr 2025 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304323; cv=fail; b=a8WsDu8ieEKAg8qld4ZNDxvrdjKK83/o29YI/jW1YAOIotgVKy0M2eF/ooPn4hPmOjd9OJUjy0dMVDhtcBmteNFdQ3N0Ykq4Z4F19FL6dANXSxAKzZ7eueRvH1Jri0waqJLV1f/nl6SqsLJFsehhE1Wn/Blt0ku8FYFq+nuWkts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304323; c=relaxed/simple;
	bh=XTX2ucdEMHIjB0rLVdU+lsSnJ/mIqzqlOxZKF+pbqhM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlGidO5jVJhsBeLThqNpg1ZCB3UDa83FevIYCRm7fhf1e4xDyB9E+ckcLVxJNrdSaiIjOECS1EjbQAhAg9eXzfYfcqwfvuHYyS9+SnfwXXedfik2BffnHd3Kgpl0cGxBULadfcv/ejNus58UV89WYOYQtfxaiMpNJJECLViP+nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fhhB+UBs; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxFHWvsMaZ2cJ7niUpISek0i1+Rj7klbBCF7+S55CTNf0DafMI6oJR8QoH4EQmGVtTU/X3Leuo2G4gpXD3yFQvAiL+aGdWvpogGLwabSfhOGVUk/w4ZhxrCzGHdaz/4ZheY1uIo3rnuW5D0WxuEEySfYaMll4tCVIQ7F7qJn+hWXNJH0mjiDXjXgsmasSE78LcOxD++IfuLXJ9oPr8pahgsl9WcXtYQTCP3N4WI43s7DRiiuyJr4/qtwFRntDPzZVIUHMkGhcg/7daqwZMgQhSOHsRwY8QFAoksR6Z4Ts1nPdYXcdmQINgClbS7zIOGt0l/ldnXEF/FqcnmojJ67zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTX2ucdEMHIjB0rLVdU+lsSnJ/mIqzqlOxZKF+pbqhM=;
 b=liX6ajeAzafwDLi9heWDiNmo10Cm0DSyD4WLvKtyWVzZb/7/hoWW5PF+jktjOVg2G37Zt1gu7MEs6JZquQmLuJiW5TlC6yA5dDUZcWX+IBmB1ZE0eC2j/4vHbhGt6HnL3dYTVolUZWPguBsBEzhKtmVknKtZ+3TklPk7kNljNLBavSm6Rp0Sye1b+N7wLLisieZpnNCz7xZl0h+7Nf1pwVhaglh9kpiTDLsbLygK6b7PJ0P5pe0LZVM2bDiItRtSs23nabFBd+VEEIh7WPofyEyp651q94s+hsSVXZwMcnCTnM6aV4C3FMpORR4Ipd1Ut6BzIz/dw5KRRd58qz4Oyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTX2ucdEMHIjB0rLVdU+lsSnJ/mIqzqlOxZKF+pbqhM=;
 b=fhhB+UBs8ilNFLIMckjg5H1AWLAm1KSJlEdU2QhmpcpdZiTETsfGujGlOZ3min8cVxeNRkTDJ8gyweD+WRuJFjVsgKs7YMSUfJ1KUcJvskZPrS0encXKKAblNttT7Sk8SSyLmGcZaZd859C2bugjD2K6b7vmW1MDDUrxcxiyPIA=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Tue, 22 Apr 2025 06:45:19 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 06:45:19 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [RESEND PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add `cpm_crx`
 and `cpm5nc_fw_attr` properties
Thread-Topic: [RESEND PATCH v7 1/2] dt-bindings: PCI: xilinx-cpm: Add
 `cpm_crx` and `cpm5nc_fw_attr` properties
Thread-Index: AQHbrOyiG1HeLApj8U6pHK3ZPQFrqrOivGoAgABRrwCAASgiAIALExTA
Date: Tue, 22 Apr 2025 06:45:18 +0000
Message-ID:
 <DM4PR12MB61581A9D423C750921FA0116CDBB2@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250414032304.862779-1-sai.krishna.musham@amd.com>
 <20250414032304.862779-2-sai.krishna.musham@amd.com>
 <20250414-naughty-simple-rattlesnake-bb75bb@shite>
 <IA1PR12MB6140D67181ED0003799228DACDB32@IA1PR12MB6140.namprd12.prod.outlook.com>
 <4b741da1-6540-4e5c-aa32-098420cab3c2@kernel.org>
In-Reply-To: <4b741da1-6540-4e5c-aa32-098420cab3c2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=085afc2a-1a7e-4a5b-a0fb-f6a6fed87670;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-22T06:41:30Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|CH3PR12MB7547:EE_
x-ms-office365-filtering-correlation-id: 668c2014-a669-4c68-412a-08dd81693f4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjJLT0JsY3ZESmx3anJvU2swamhPQUEwVDRZMkVuRWh0NWMzdlVkcncwUmt4?=
 =?utf-8?B?TFJRd3VqU3VIZ1ZLOXN3bjZSeG9uV1Mzb0xWd0xrUGQ2REN6NkF0Z2lRdjFY?=
 =?utf-8?B?VUkxOEQvQ3VTZkJMcmlKMjloMGhCWnRWdGhSVXhwSzUwZ05XL25WY25QY1gx?=
 =?utf-8?B?VHdmOTAxdjFYaW9OTEVPOTludDdUWHJnNVlDZHVFcHE1R0YrOGtUdVkzQ1JF?=
 =?utf-8?B?aFdFUUxQZmJwOVRHTG1jY2d0M09zbTVtVUM3eThCbzQvRllvNlBYRm1Ld2g5?=
 =?utf-8?B?bEt2OStkY2VTQ0JyQVJydGxjemFpK3FGRktMUGFvdlF6ZVVyaTMweXpzSWNV?=
 =?utf-8?B?NGgwcTFYd2tkTURSaFN2Um04RGIzVVpKd3ZWbThjWmsxM2dnNXU3OWVSK2Yv?=
 =?utf-8?B?UG5nSmNlSjNYK2dWNFR0OEJRSmI5RTV2M3IwTzNpWFlhdUVidWRjQWtJV3g5?=
 =?utf-8?B?dWx1QkpXNTVPeTlkWXRBS0ZQQWh3TkFBcEdWcUNVVXZsNkZSNHVNa2tkS3l2?=
 =?utf-8?B?N2psTnB5QmxTeTYvVnVBYy83M3l5Vml0Z0JhN0pKZE1yd3R3Z0Z6SXRsY0pT?=
 =?utf-8?B?MFBhVWlvQkxFS3AwbEJ2dG9DeHZINGJCRlRxRWU1M1RHOTJCeWRJVUlMbjBm?=
 =?utf-8?B?Sk1tN05Demg5MnlEenFCRjJXNkRHRFRvcHZWNUFkSm14dGd6Q2I4dllwRjJB?=
 =?utf-8?B?MHREVko2QXZWR3Q2bjBzUE1JUlFaOU1PSFhJMHVJTmdXK0Z1U3R1S2dDMFdB?=
 =?utf-8?B?Y2ltbDM0N3hBdE9lTGtGekFYQWFwT0d4TGFnaW1yTzQ5em0wZ29ydUFHcmFp?=
 =?utf-8?B?UUxhUkN2cDdEc3I5RTJqMnE2QTgrdTJIQ0U2RS9jMytJd3hBcWFaQnM2U2Z1?=
 =?utf-8?B?VWpCOVBVTXg1UzRUOVc5WGJZOVpvcjFzcW8vOU9PT2tKalZXUnZSOWhVWkhZ?=
 =?utf-8?B?NFhuQ3R0UUxmdjhuU2d4c05MSk1rOVEvV2h1bDY4N0lpZm9Lak1EbENiaHRN?=
 =?utf-8?B?dGRjZ0NYN1ZxbEFBWFg5NVB3RVVxMndjbURwekViUXVZSGxqK3lWSW95TjNz?=
 =?utf-8?B?alZwdkJacWlmRHdMVFAwb2tvS3RsajNVUTFheGQxbnZIS2xibGtXK3NiazRr?=
 =?utf-8?B?ZXNvYjlEdW45MVE5eDhXVEZFSzVUdGVObTZBQ0puVlp1VXEvTkJkSEo0MnVD?=
 =?utf-8?B?eU5wMHA4ZWdJU1QrYWw2Qm5BdU9xUjcrOEhUOEttaGZ0eXdkV1U0SjF3NDlC?=
 =?utf-8?B?UDlxRzV4SjhES2VqcmxaSzNSZUJMMEc0elFnOHJuTXhNVTR1MElSek4wWDdD?=
 =?utf-8?B?VEV2ckErNU5jY3R4eWdMd3dmNmZxVzlRNmtJcVZmL2s2c3BhRWFSWmlnV0hP?=
 =?utf-8?B?em5yaWhpb2dOU0NkWlhCaGFTVUwrS1RtL0hVZ3FGcU4vQTBhdndJbHlvUEhr?=
 =?utf-8?B?QTYyU1kzNVY5RFU3aG1HaWJ0eW4wQXBNWHFBTHVzQUlHMEJYWHY3ZUtBQjZO?=
 =?utf-8?B?SDVFcCs1OXgzWTM3V0ZYQW44Q1FpeEpETEluNkFYODBQa0dHWUJXdnBrdVRV?=
 =?utf-8?B?YjQ1N25tYSsrOG9yUEJkc2JzaDhmeEViMXNMMWJxa2c1SGovL3M4REhDSDdv?=
 =?utf-8?B?end6RGt5ZlBGZ3RrMDMxN2hKcmdQdm1CcksxNFl1U3F4Wjh1MUZCaXNhZXpC?=
 =?utf-8?B?UXI2YXBXcjR1QkdjdENWOTBBQVdUeXFEZjBwLzdYTGxybzRuaWwwd0N3S3F2?=
 =?utf-8?B?Y3VEVVN6TmtqUDNwaysyUjUyNEhTK094ZnZ4VzlHbVJ2WE1qc3FJdm5BZ3BO?=
 =?utf-8?B?S1lMR3V3cng5TFVSNEQzckJxM2krMldSOXYrT0YrM2NPTitFL2RHUS9KcTlz?=
 =?utf-8?B?THkvZVhnRkw2Zll2Nm4yNlJyRDBFcnJkZ2ZHZnBpWk94L29LSWQvQ2JHNVEv?=
 =?utf-8?B?cVhSWlNIU05TSzN1Q3FkRUt3cVR5RTRhU29tYnZPb2NCRzVHOUdheUVlQjZn?=
 =?utf-8?Q?0SW9zKrhy/FPLNYJRwqYsPIJwZgkjE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXBKV3gvcldOV2VmdEJFQ0E0RXFYak5PdGlRREF5bTZMVUtwczA5L0ovWVdw?=
 =?utf-8?B?WVkvMEJKeitZS3JKNTY0K1o1b09La1JNdXNRY1A1c2plTnRDQ1J2dGJYaW9I?=
 =?utf-8?B?N3JaSnlKQy9oZGJqSzgxWDFTNDN0aVhtWnRIVkNzZEpkT2FLbjFKYWhUZDQ0?=
 =?utf-8?B?WEFKcGZOUjZNQWp1amVpMjhNd3pnZFJZQ1dYM2xIQzhwWVZvb1ZxdG1jRENm?=
 =?utf-8?B?WjRVb2FYdzl4eXoyWE1CTU9XSDdzV0tyZFBaTkNqMU1Yd2tJYkpIWVo3Y3RL?=
 =?utf-8?B?VmNFZTB4dEZXY00rbXJHaGtNU3FoK0lBSjRPRk9SK2t2ZzZEVEQ3WkZRV01P?=
 =?utf-8?B?SzlVODduamEvOWJmYWxmdU41NkdDaEE2MTNRYTFZYURPR1lhS2o1RE5nL2Yv?=
 =?utf-8?B?ZWs1MzBncnk5VHlKTnVIMzQway96cEhwQzV2WGViNTYvYk9WNHZDN0hwdmUz?=
 =?utf-8?B?TkVLTlN2U0RmYWI5eGs0bkQ2VSs5cG16SDZGYmFPejd1S1RDaHFtdGdtcDVE?=
 =?utf-8?B?SEJlZlg4dDZqT1NJbVpsSEJhd2ppMmdIRzVTNTIrVExjYmloeDUwaTZSNE9u?=
 =?utf-8?B?TzE1MWhnL2xuL0dGUll3RVE1c0VrUG1hV2JKeDRTV0ZwV0hMZ3AxbFpUOXRI?=
 =?utf-8?B?d2haRER6TXU3MVBnNlFjWHRHYU5nVHFTWEdyNEpLNzczQkNlSjRIbHlxVFoz?=
 =?utf-8?B?YWJQMFNCSklnM1ZIQXVWa2hhcEZWL2dhUTRnUEZkMEJmdlJhNEVuVkthVlgv?=
 =?utf-8?B?bm5VamlreENHYUF0akd5eTVaNXNZWUtXNXAvZ2NoYkl0RHhTcGtyS0xxVDcw?=
 =?utf-8?B?UDVtMXBtWEhoQ2VtU1IzRVF6blFlM3lqejljb3NaUkhaRWpyMjVDTGVzTHNl?=
 =?utf-8?B?bkZ1cmh3Z1ovK3IzOHNWOWFCdUZhR05XcHlpUUd6a3dmYmZkVE55eWxXbHB4?=
 =?utf-8?B?Vmpvektrd1F4ZU9sSXN4M25Sdk1DeEJFajNjNVVkSzFQalAzVEZxUUpTd2pa?=
 =?utf-8?B?dnFhQlhwT21wdmZWK2dZT094eVRoOTRSUmQyMy9DakNlRm14NSt0MEdvSC9i?=
 =?utf-8?B?U0ZVYXVwNzV1SjNjc3lFSmFMbjlpRVR6ZVo4MnhhcXNZeHZVTGR6dE1PdEE3?=
 =?utf-8?B?YnlIcEEvazJpNWR0UmhmNEFoUmllV1FLb2hXb3hEWDh6K240SGhnbWlrNmdD?=
 =?utf-8?B?anJEN0psbkRCdkpGYVJJbDNxY1NGUlkzTXVoRnZCcFpQYWdFZWF1TXMwM3BS?=
 =?utf-8?B?dXFETEt5NjNrdmlweDh1d2ZsNDNFRmRSRUlpNmFKWkx6TVVPQkZJUWk5T0lE?=
 =?utf-8?B?YnFIQTNrUFpQRUp4aWJUMVlkc2huVEtabXdha2VvajJkNVU5a1dUSEhkZmlh?=
 =?utf-8?B?RVd1WUttZDN0QVlNeVUwT1dFNDdWS21lWUR2UitPVFA0ejlQVzd5dERGaUFv?=
 =?utf-8?B?Y3ZING1MSnRYWitIUUx6YTk3Y1hnMjZ1aFk5WkZJdEFnN2R3cnNhMlU1NjBQ?=
 =?utf-8?B?dGRaMFVSU0dabCsvWGlCdVdDUTBXMDUyOGtmTmd6TXhycTNlZXcyVzdzQTJW?=
 =?utf-8?B?Wm5QaHh6SDZFNFFwWnI0N0lDZ3NYTC8xRVFFSVFSUTVNM05JajFlS2o0OGlB?=
 =?utf-8?B?WkgxZ0l4OG5sTnNJT0QwTWtycmJGNEFqeTFBdlpLTWc5TUoyZlR5Q3hES3Nj?=
 =?utf-8?B?N2QzYkQ2RHM1c0lsWTQ5dzgvOEt1WjBQT0ZwUFZVekgrMXhhTWdOaHM5SFZN?=
 =?utf-8?B?TlRnWEg0VUVrT20xNTdSVDVZa2Irem9Wd1A3OTBEVGxCelR0Q24wSWU1WWdH?=
 =?utf-8?B?STNkUUNxNWVhZ3RDOFlSWTg5LzRsaXRrd2lnTXBHWm9IajhxNUNCZnhlZ3JJ?=
 =?utf-8?B?SDBpRzlaQ1Fld0pRcWoyb3FZdFY3TE9Rbk0yb3E3YlZkbmNBdUlyak82aWZi?=
 =?utf-8?B?WEdyaURmY29xcHNHM0xMVGFaY1ZxMjcreXZwS1hQWW5nWHBoUHJlb3RSYWVq?=
 =?utf-8?B?Z0hHeFZ6dmQrOFJsL3pmRzJyc2pPQTBFTDFUREZ2UE5nY1gvN1NZYXkxOFo3?=
 =?utf-8?B?aTFkMytaQzFwNnZkTzcrUUNSU0xFWDFveGx5dUZ5eERSckRFckNuMTRTUzAx?=
 =?utf-8?Q?HiOM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 668c2014-a669-4c68-412a-08dd81693f4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:45:18.9509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5gqi6cAujgmoB9VeF7iG/Fi43/XaY4kTO3aazF4juY6s7KX0uvCqtGoO4MZHQEm7CljCUAxkIPJrLO9Wjdfdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwg
QXByaWwgMTUsIDIwMjUgMTE6MDQgQU0NCj4gVG86IE11c2hhbSwgU2FpIEtyaXNobmEgPHNhaS5r
cmlzaG5hLm11c2hhbUBhbWQuY29tPg0KPiBDYzogYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJh
bGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207DQo+IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBs
aW5hcm8ub3JnOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3Ir
ZHRAa2VybmVsLm9yZzsgY2Fzc2VsQGtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEdvZ2FkYSwg
QmhhcmF0IEt1bWFyDQo+IDxiaGFyYXQua3VtYXIuZ29nYWRhQGFtZC5jb20+OyBIYXZhbGlnZSwg
VGhpcHBlc3dhbXkNCj4gPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUkVTRU5EIFBBVENIIHY3IDEvMl0gZHQtYmluZGluZ3M6IFBDSTogeGlsaW54LWNwbTog
QWRkIGBjcG1fY3J4YA0KPiBhbmQgYGNwbTVuY19md19hdHRyYCBwcm9wZXJ0aWVzDQo+DQo+IENh
dXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBV
c2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBs
aW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMTQvMDQvMjAyNSAxNDoyMywgTXVzaGFt
LCBTYWkgS3Jpc2huYSB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIElu
dGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+DQo+ID4gSGkgS3J6eXN6dG9mLA0KPiA+DQo+
ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4N
Cj4gPj4gU2VudDogTW9uZGF5LCBBcHJpbCAxNCwgMjAyNSAxMjozMiBQTQ0KPiA+PiBUbzogTXVz
aGFtLCBTYWkgS3Jpc2huYSA8c2FpLmtyaXNobmEubXVzaGFtQGFtZC5jb20+DQo+ID4+IENjOiBi
aGVsZ2Fhc0Bnb29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsN
Cj4gPj4gbWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc7IHJvYmhAa2VybmVsLm9yZzsN
Cj4gPj4ga3J6aytkdEBrZXJuZWwub3JnOw0KPiA+PiBjb25vcitkdEBrZXJuZWwub3JnOyBjYXNz
ZWxAa2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbWVrLA0K
PiA+PiBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgR29nYWRhLCBCaGFyYXQgS3VtYXIN
Cj4gPj4gPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IEhhdmFsaWdlLCBUaGlwcGVzd2Ft
eQ0KPiA+PiA8dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6
IFtSRVNFTkQgUEFUQ0ggdjcgMS8yXSBkdC1iaW5kaW5nczogUENJOiB4aWxpbngtY3BtOiBBZGQN
Cj4gPj4gYGNwbV9jcnhgIGFuZCBgY3BtNW5jX2Z3X2F0dHJgIHByb3BlcnRpZXMNCj4gPj4NCj4g
Pj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXINCj4gPj4gY2F1dGlvbiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNs
aWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiBNb24sIEFw
ciAxNCwgMjAyNSBhdCAwODo1MzowM0FNIEdNVCwgU2FpIEtyaXNobmEgTXVzaGFtIHdyb3RlOg0K
PiA+Pj4gQWRkIHRoZSBgY3BtX2NyeGAgcHJvcGVydHkgdG8gbWFuYWdlIHRoZSBQQ0llIElQIHJl
c2V0LCBhbmQNCj4gPj4+IGBjcG01bmNfZndfYXR0cmAgcHJvcGVydHkgdG8gY2xlYXIgZmlyZXdh
bGwgYWZ0ZXIgbGluayByZXNldCwgd2hpbGUNCj4gPj4+IG1haW50YWluaW5nIGJhY2t3YXJkIGNv
bXBhdGliaWxpdHkgd2l0aCBleGlzdGluZyBkZXZpY2UgdHJlZXMuDQo+ID4+Pg0KPiA+Pj4gQWxz
bywgaW5jb3Jwb3JhdGUgYHJlc2V0LWdwaW9zYCBpbiBleGFtcGxlIGZvciBHUElPLWJhc2VkIGhh
bmRsaW5nDQo+ID4+PiBvZiB0aGUgUENJZSBSb290IFBvcnQgKFJQKSBQRVJTVCMgc2lnbmFsIGZv
ciBlbmFibGluZyBhc3NlcnQgYW5kDQo+ID4+PiBkZWFzc2VydCBjb250cm9sLg0KPiA+Pj4NCj4g
Pj4+IFRoZSBgcmVzZXQtZ3Bpb3NgIGFuZCBgY3BtX2NyeGAgcHJvcGVydGllcyBtdXN0IGJlIHBy
b3ZpZGVkIGZvciBDUE0sDQo+ID4+PiBDUE01IGFuZCBDUE01X0hPU1QxLiBGb3IgQ1BNNU5DLCBh
bGwgdGhyZWUgcHJvcGVydGllcyAtDQo+ID4+PiBgcmVzZXQtZ3Bpb3NgLCBgY3BtX2NyeGAgYW5k
IGBjcG01bmNfZndfYXR0cmAgbXVzdCBiZSBleHBsaWNpdGx5DQo+ID4+PiBkZWZpbmVkIHRvIGVu
c3VyZQ0KPiA+Pg0KPiA+PiBUaGlzIHdlIHNlZSBmcm9tIHRoZSBkaWZmLCBidXQgd2h5IHRoZXkg
bXVzdCBiZSBkZWZpbmVkPw0KPiA+Pg0KPiA+Pj4gcHJvcGVyIGZ1bmN0aW9uYWxpdHkuDQo+ID4+
DQo+ID4+IFdoYXQgZnVuY3Rpb25hbGl0eT8NCj4gPj4NCj4gPg0KPiA+IEZvciBvdXIgY29udHJv
bGxlciwgaWYgY3BtX2NyeCBpcyBub3QgcHJvdmlkZWQgbGFuZSBlcnJvcnMgd2lsbCBiZSBvYnNl
cnZlZC4NCj4gPiBTcGVjaWZpY2FsbHkgZm9yIENQTTVOQywgaWYgY3BtNW5jX2Z3X2F0dHIgcHJv
cGVydHkgaXMgbm90IHByb3ZpZGVkLA0KPiA+IHRoZSBmaXJld2FsbCBpcyBub3QgY2xlYXJlZCBh
ZnRlciByZXNldCBhbmQgZnVydGhlciBQQ0llIHRyYW5zYWN0aW9ucyB3aWxsIG5vdCBiZQ0KPiBh
bGxvd2VkLg0KPiA+IFRoZXJlZm9yZSwgdGhlc2UgcHJvcGVydGllcyBtdXN0IGJlIGRlZmluZWQu
DQo+DQo+IFRoaXMgbXVzdCBiZSBpbiB0aGUgY29tbWl0IG1zZy4NCj4NCg0KU3VyZSwgSSB3aWxs
IGFkZCB0aGlzIGluIGNvbW1pdCBtZXNzYWdlLiBUaGFua3MuDQoNCj4gPg0KPiA+Pj4NCj4gPj4+
IEluY2x1ZGUgYW4gZXhhbXBsZSBEVFMgbm9kZSBhbmQgY29tcGxldGUgdGhlIGJpbmRpbmcgZG9j
dW1lbnRhdGlvbg0KPiA+Pj4gZm9yIENQTTVOQy4gQWxzbywgZml4IHRoZSBicmlkZ2UgcmVnaXN0
ZXIgYWRkcmVzcyBzaXplIGluIHRoZQ0KPiA+Pj4gZXhhbXBsZSBmb3IgQ1BNNS4NCj4gPj4+DQo+
ID4+PiBTaWduZWQtb2ZmLWJ5OiBTYWkgS3Jpc2huYSBNdXNoYW0gPHNhaS5rcmlzaG5hLm11c2hh
bUBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiBDaGFuZ2VzIGZvciB2NzoNCj4gPj4+IC0gVXBk
YXRlIENQTTVOQyBkZXZpY2UgdHJlZSBiaW5kaW5nLg0KPiA+Pj4gLSBBZGQgQ1BNNU5DIGRldmlj
ZSB0cmVlIGV4YW1wbGUgbm9kZS4NCj4gPj4+IC0gVXBkYXRlIGNvbW1pdCBtZXNzYWdlLg0KPiA+
Pj4NCj4gPj4+IENoYW5nZXMgZm9yIHY2Og0KPiA+Pj4gLSBSZXNvbHZlIEFCSSBicmVhay4NCj4g
Pj4+IC0gVXBkYXRlIGNvbW1pdCBtZXNzYWdlLg0KPiA+Pj4NCj4gPj4NCj4gPj4gLi4uDQo+ID4+
DQo+ID4+PiArICAtIGlmOg0KPiA+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4+PiArICAgICAg
ICBjb21wYXRpYmxlOg0KPiA+Pj4gKyAgICAgICAgICBjb250YWluczoNCj4gPj4+ICsgICAgICAg
ICAgICBlbnVtOg0KPiA+Pj4gKyAgICAgICAgICAgICAgLSB4bG54LHZlcnNhbC1jcG01bmMtaG9z
dA0KPiA+Pj4gKyAgICB0aGVuOg0KPiA+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4+PiArICAg
ICAgICByZWc6DQo+ID4+PiArICAgICAgICAgIGl0ZW1zOg0KPiA+Pj4gKyAgICAgICAgICAgIC0g
ZGVzY3JpcHRpb246IENQTSBzeXN0ZW0gbGV2ZWwgY29udHJvbCBhbmQgc3RhdHVzIHJlZ2lzdGVy
cy4NCj4gPj4+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBDb25maWd1cmF0aW9uIHNwYWNl
IHJlZ2lvbiBhbmQgYnJpZGdlIHJlZ2lzdGVycy4NCj4gPj4+ICsgICAgICAgICAgICAtIGRlc2Ny
aXB0aW9uOiBDUE0gY2xvY2sgYW5kIHJlc2V0IGNvbnRyb2wgcmVnaXN0ZXJzLg0KPiA+Pj4gKyAg
ICAgICAgICAgIC0gZGVzY3JpcHRpb246IENQTTVOQyBGaXJld2FsbCBhdHRyaWJ1dGUgcmVnaXN0
ZXIuDQo+ID4+PiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+ID4+PiArICAgICAgICByZWctbmFt
ZXM6DQo+ID4+PiArICAgICAgICAgIGl0ZW1zOg0KPiA+Pj4gKyAgICAgICAgICAgIC0gY29uc3Q6
IGNwbV9zbGNyDQo+ID4+PiArICAgICAgICAgICAgLSBjb25zdDogY2ZnDQo+ID4+PiArICAgICAg
ICAgICAgLSBjb25zdDogY3BtX2NyeA0KPiA+Pj4gKyAgICAgICAgICAgIC0gY29uc3Q6IGNwbTVu
Y19md19hdHRyDQo+ID4+PiArICAgICAgICAgIG1pbkl0ZW1zOiAyDQo+ID4+DQo+ID4+IFdoeSBp
bnRlcnJ1cHRzIGFyZSBub3QgcmVxdWlyZWQgZm9yIHRoaXMgdmFyaWFudD8gV2h5IGlzbid0IHRo
aXMgYW4NCj4gPj4gaW50ZXJydXB0IGNvbnRyb2xsZXI/DQo+ID4+DQo+ID4NCj4gPiBNU0kgYW5k
IE1TSS1YIGludGVycnVwdHMgYXJlIGhhbmRsZWQgdmlhIEdJQywgc28gbXNpLW1hcCBwcm9wZXJ0
eSBpcw0KPiA+IHJlcXVpcmVkIGZvciBpbnRlcnJ1cHQgaGFuZGxpbmcuDQo+ID4gTGVnYWN5IGlu
dGVycnVwdCBzdXBwb3J0IGlzIG5vdCBhdmFpbGFibGUsIGFuZCBFcnJvciBpbnRlcnJ1cHQgc3Vw
cG9ydA0KPiA+IHdpbGwgYmUgYWRkZWQgaW4gZnV0dXJlLCBvbmNlIGl0IGlzIGFkZGVkIGNvcnJl
c3BvbmRpbmcgRFQgY2hhbmdlcyB3aWxsIGJlIGFkZGVkLg0KPg0KPiBJIGRvbid0IHRoaW5rIGNv
bW1pdCBtc2cgZXhwbGFpbmVkIHRoaXMuDQo+DQoNClN1cmUsIEkgd2lsbCBtZW50aW9uIHRoaXMg
YWxzbyBpbiBjb21taXQgbWVzc2FnZSBhbmQgc2VuZCBpbiBuZXh0IHBhdGNoLg0KDQo+ID4NCj4N
Cj4NCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KVGhhbmtzLA0KU2FpIEtyaXNo
bmENCg==

