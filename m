Return-Path: <linux-pci+bounces-12893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8661296F1CA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 12:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2A2B262AA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE191C9DEA;
	Fri,  6 Sep 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yQxfYGID"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE41B83A18;
	Fri,  6 Sep 2024 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619425; cv=fail; b=WOU1mVK0No0IgGWoGt/xdUAagDODcZugmMQ0upuH8s2y/68tzwGw9SxdRPHHgFjrDw/LTpzKHio50JvOCna4NJ6adfRU1/v/j/sAoNiB7ZYZ9EgEHP8tb5w2CnE9nmT12Bq+A+4LP5Q2ZjYFdKceMnsvt0QTz7bh8+3uVD1Hqek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619425; c=relaxed/simple;
	bh=PnKmDu+DDx4l1xs2bBMwqjh0TWgJ9W8sAiNZWQXiv58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rM8xDavhbi1FhXw+BqYARUzQlQDxG8C2YDLZYvoC6TEM3Lvyr2+e6lwSyHupEQgsvGi7C5GaPPe3EygIXo0dqjRhe/+KFxb5yMDaSezFVY8L17F/D+H4jYD00ACZ+cN4jH1nRPIgPGFLfIvXVtEKZQ1buNbOKjLc1lkbEjUuriE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yQxfYGID; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRhNhBptrvKUGrGHaJDKJDlfLnaqxpzqgzZiiNadRzMeprJZumL06AzKZXFqHL6wWbbfBfWUJcnie+FPLw57LRDeCl0LMYoA19IIuWmjIfVVvzKR41osX5MkwlxR8G2TqWhLrT0J1iimEIq7fWiNOk4Kmd46nG0kEPbROIsUNU/7HHUax6Q/VgBwp0FkeCkZJcxyxteFMY7bYGRaC9kcFG18ltWlIl7TuaVMLtTWoQNkQWjj4NU89bMFYox/v2IE0qmsGoub1CJuoQsBqSF7yACvqhgXdVcfS03JGOBis9WDvCmZfci2NZqD7Cw4q9Bcu5166lrL9bq2ZBj+choTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnKmDu+DDx4l1xs2bBMwqjh0TWgJ9W8sAiNZWQXiv58=;
 b=ii3xWHr9/cq/kyUx0cUkxtpRkLSDWIvkcea5pZ9g085fJjCA1U55qaJ0nof8D0V/nSmHHbVsoh+ixP/5F/nwVlEcmP0idflp4n1cILQyKLHyIZe/iJE2efw/z2AXmrs3mH70n5DGzpPu7qKJluZ1FvmLu828C3OXGiN4AnGPsuGB/kFJqXCQJQG4mPhD3tWqYrNOspoNUBj63R8OMV/SxItXl3/MoPvDki5NYBmwOR217cP1e4uPlRaR7tjmpSAIg+gs5ePDYc3uSywYoInk8dm+rnFw+1+qcGUjz1DkF9BtVxn2gCWQcaEKrJ2oeaK0T4kmaNyRt/JR5Z61pWnZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnKmDu+DDx4l1xs2bBMwqjh0TWgJ9W8sAiNZWQXiv58=;
 b=yQxfYGIDAPX5wM2U/o7Sk9W2wlmQMV46KT41eFft9/vIH6LFM2G15xyhsN+QyK6047ez6GxyakivoXDgLGhC9Si9zJC8oVlsoZ3shvV0cW58eNstNmUdHZSuaAYNUy18ZC5beobQan8/pjRuPtf0N9cdvsJMJO9B/6cDogZCknQ=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 10:43:35 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 10:43:33 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Simek, Michal"
	<michal.simek@amd.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>
Subject: RE: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string
 for CPM5 controller-1.
Thread-Topic: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string
 for CPM5 controller-1.
Thread-Index: AQHbAD+qs/ZP6ddUUkqwXrFBAjDnM7JKhZSAgAAMnRA=
Date: Fri, 6 Sep 2024 10:43:33 +0000
Message-ID:
 <SN7PR12MB7201F82C9BC29ACEE7E209028B9E2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240906093148.830452-1-thippesw@amd.com>
 <20240906093148.830452-2-thippesw@amd.com>
 <e985a9d4-b398-4290-a4b9-08999c6a9f71@kernel.org>
In-Reply-To: <e985a9d4-b398-4290-a4b9-08999c6a9f71@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|MN0PR12MB6054:EE_
x-ms-office365-filtering-correlation-id: a4e3f79a-e2e5-42c9-57a6-08dcce60c18a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZEtkWk9WcUN5aTE3TTFnY3JpWHFMZDViekhlU0ovRDZHTXlSc0ZNaFpiam9B?=
 =?utf-8?B?MWh0Y3hGN1I5VzhCV2ZhNzljM2k3QmlVNEQyV08xb1dDRHIvYmk5ejkyZG9N?=
 =?utf-8?B?Smo5dWdSdExEM0lkVXJZZjkrMm9mcTk0Sm1lbmZuMUZBcVV3L05vcWpYVWFD?=
 =?utf-8?B?M25KMVBYbjErT1NldllRRjI4Y3F4U29JMXF2V2dvSU4vT2NPcmFjaE9SMXhH?=
 =?utf-8?B?c2RmT3gxZkpsVXlock5DQmovT25DZy9QOERhOU92MmtRa003elFJQ3cvT2h3?=
 =?utf-8?B?Z1RjZWFVcG5QMDZhTGthTHo5c3VTK01MejRqNXdmZTltYlN0bnM3bjRwS0l0?=
 =?utf-8?B?d2dhYnRJd1dmb0JjajhvN1grOTlPazdwdFVsa1EwNmZwY0tpUURYTFlsR0cw?=
 =?utf-8?B?NklicTBkM3NKYWpEaGJTV1ZTK2RNaUtlU0dOVFNFVG55QndkY3N3bzNnSFQ5?=
 =?utf-8?B?c1cwWVQ5U3pLblNYdHNGcVhzV1hZSE9NMkFlcmhhTEZETWp5b2YzMkwvaFRO?=
 =?utf-8?B?aDhJZjkwaVRwQWFTM1M2WStCeGhMOEZBdG52RjJRaWljNU1BamxhMnpkdWZ6?=
 =?utf-8?B?N3hoSEtROUs5Y2dpZXZhdVFOMC9LRkl5QjFNRXZMSjVPWllYVGllbEJHRHlO?=
 =?utf-8?B?TnUxWXh3dy9NYjlVaTVON1lGeXNLcUQ1NUcxd1ZQNG9VTFI2UmFPYU0vWTJF?=
 =?utf-8?B?NzhYaFlWVGtQaTRoZEVjUHhMbFRCVWU4QmM5dVJGaDRYcHZjK0crVEVPaTFL?=
 =?utf-8?B?WUsxMVVpNGxlS001VTc5Q0lQOHVjZWQyRllXMS82L1ZLdHJuSi9hbm5UNVRD?=
 =?utf-8?B?QmV4bm9Zbkh5MFBSVWlzbHVNWUkzWHZMWW9wd3pUcXNXWXRaZURuekVkYXJh?=
 =?utf-8?B?TG1NMmdLSXVIWlBjQjJaNWZRem9RNlVvV1FPaTlGY1JLeXJOdWpwQmtrR0s1?=
 =?utf-8?B?dzkwMjBKaU1OYjhSVEt1cDkrTGhVeVVVTjhUeU9JRWdaMnlxZDVJdysvYlhS?=
 =?utf-8?B?ZlZpRXpGOVZJb2ZOZWw0WnhaQ3RRbTdReWtBSkluV3o5Wnl5RExOMGNBYmVE?=
 =?utf-8?B?TXpxL0VJMmVHTGZVbmorQndSbDBET2tLN2d4N0hJcldaM0dIWTdnQ05Na3R6?=
 =?utf-8?B?a0g5T0p4aU1RYnBpSTdTY2FTQWRFUXhtM2I0ZUxmbVdFbjB5c2RJQldpT3VF?=
 =?utf-8?B?MEZSTExVSjZqMXE2djdva09hMGdwWEc2emxPR0w4Z3BENVBEZ25ZNmRDZFJr?=
 =?utf-8?B?M0tuaFNJSEQ5bGhnTE1JYnpDUkh4eVAyN3ZqWHJPSXdUM2d3LzYwVG1hUTJR?=
 =?utf-8?B?K2dueHBLMmV6bVpvd0lBYkthbk14V1ZNelV5SnlDL0kvc3FpNFUyWER6Z2VQ?=
 =?utf-8?B?cytIWW1GUWNMcFJqRjhHM3JqRFRtbzhwY0hscGtrY1hHNzQxL2xITDJBMVdD?=
 =?utf-8?B?aUxiRzJ5bDR6MEFrU2EzN2RMa2ZrYnJQMWV1b0ZnQWhLc1JBUGwvZHQ0YThL?=
 =?utf-8?B?YnRDMGFHNVlia2t1MVNwckV3SHRHQWUrMlB5bnl3MnZKL0dPUDU0cGxZbjk2?=
 =?utf-8?B?OGlEb3ZDYkRZcUROYWd6OEhBZVB3TWEzUE1nSGJNemd2ZmZwNWtvUnRkTEdl?=
 =?utf-8?B?bmE4Sks2YkFuM28zTXVIbysybjZEY3ZNSEpzRDlIQ3NDaTM1WHFSMXBMUGRO?=
 =?utf-8?B?MHJ2a2d0Tm01L2lhR0RpT3RCRHZZZ1pjTEppYVdIYmd6ZDNvbzZFbWRhVERF?=
 =?utf-8?B?UnhuRVMwT0RCcXVsMU9JNVcrYlNLTm5UQ0NSU1o5OUpCZXNUaG9LOWFHRGF3?=
 =?utf-8?B?QytwTFhqSHJwZ1FVSmZ0V1IxVUpNdDFxRDhZWmNuYmFZRk9HcjdSaUpIMW53?=
 =?utf-8?B?dnE0TUl0YUdDMHlieVRNQ0FRNjdVL0tDMEkxUUJ5KzJPWG1sN0xFVG45dCs1?=
 =?utf-8?Q?DYJjG9mw7zM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFpHOEduRVRvb3ZhK3JOMFhnTkFkMGdHNVdLZUI1ZGIzK1lvOFk4bnJXbUxE?=
 =?utf-8?B?NTRueFI4VThsZVNhd2VCbXAzUGQ2QWxXRzlhVjlUa1NJOFFpZVFyVWdQS0ds?=
 =?utf-8?B?L2NSdzlNbkRYQjhTcExsVXlZeHI0YVBCU0hIcEJCdkU3a3lMWjd5VHZkUGZH?=
 =?utf-8?B?RGhndkR6N1VGQ1VqczN1YnErRHFIV3hpWVVyK1EwK0ZpRlV6blBoODF6N1RI?=
 =?utf-8?B?cGZZK0tpUEp5MGovVzZzd0ZIemhNSFROdmVvVUJGdG9vK3NURGlxcmtFdmE1?=
 =?utf-8?B?YUdjR3ozcy92eXdZOWd5VzVaeFJRQ2N0TDJBM01wb3JmWS9kcW1hTGpRV0VZ?=
 =?utf-8?B?allsNzN6SUVCSkxxZzNjSnZSamtVblcwWndNb0QyK0ZCd0tkVWhjaktoZWkv?=
 =?utf-8?B?L0NCbWU4a252c1dFbHRkVjVsTEc2amJJTXB2YmFoSEdzaitCbmxmd29ZSXdQ?=
 =?utf-8?B?cWFlWkVJOVh6TzIvS2pHOCtDdUJTUkNKdG82N1BoTGZ5ZDVDdVltTWpnNXZu?=
 =?utf-8?B?SjM1MnMzRlJyYlBJS0JkMHdLTWNYbkpMeEZlTnBvVUhIVDR3VkZ6RlZJbm9l?=
 =?utf-8?B?Z2FjNzhFRmZ3NmtNTmxOcTI2SndQeU5kdlMzQ1c0THpnOWQ3Z3QyNDJFdFZp?=
 =?utf-8?B?SVBtdWtHZzRyWE9XTmJ1b3BaamxRZGkwb0x0WDVrYURISnFneFZrb2tUVmhE?=
 =?utf-8?B?dTNVRFpzR3dLbEdvb1RlSDlUbHNDYUhnNS9uM2c2d0RqMTA5dVFNRVBrblQr?=
 =?utf-8?B?OWx5VG4xSHlBbHA3b3JGenN1cDAwa2hVYmZLWS9hcGtVUUVtWWYxLzUvSUp5?=
 =?utf-8?B?S0o2d2RYWCtFNlpDN1hILzc0b1crNmt3c3QvMDJjWTRzTkZNTHlEeGJpWmpS?=
 =?utf-8?B?dElCb1d3NUdoTW5tdkxteldBKzFYYVhmcGhNUE5QdG5CL3BoRzNyNjA3Rk1Z?=
 =?utf-8?B?VzhybVl1N0hHb25HYVBXenAvNVp5R1UrNUJQcEZzRmlSOWxYblcwS1YxaFVJ?=
 =?utf-8?B?ZlNBVjRYWmwwb1lYbFRhZ2VyemNUbzBKUXE2TjhyRXJoN0szdXl1NmxaQlNR?=
 =?utf-8?B?NkRtaW5UVnJvaTFqa3ZHby8xYW1BMmVwMUp2elBSZkJPdi85ZERLV3V3TGpL?=
 =?utf-8?B?V1V1MlBRcDJwcXJqTWkvamhpYUZUZnU3Vm9xVFp0cU5GRjB5ejZwWG5GWXha?=
 =?utf-8?B?cFk0c3l4VDViSzZnTjQ1QjE4YnFudWtOQnVyUTB5SnBtSnQxekVlSW94amlK?=
 =?utf-8?B?c2o2b09Fc1ZJWS9QMFdNNnlFczJCQnF5R3loSm4zSVdCeDI5OUhJNVp1SnEz?=
 =?utf-8?B?ZjFGSlJKZnlZNTF6RGpndHU0ZEpsV28wRzJReVVMclhic2RzNms5eGpKc2hX?=
 =?utf-8?B?OGE3UzEzS3BYK3hWUzdDQXBwaWhWSENuOHVNQ1ltdllqVFJzcEg2OExST3ZD?=
 =?utf-8?B?VnROcVdBM21YdG5pQUUzWHBrR0Q4UzZKRFdaQnFGalc1YXh0SzN6VW13czdr?=
 =?utf-8?B?QVNqT0hlU3Z6TXZZdEw4WjNaNjdocXQ0RSt3ak52dVpDNWNvZHpmODdkM2E3?=
 =?utf-8?B?bjZEdjVaMzNnakR6WExoOWZRSmpjczFmK1ZhaHFPNGFzRVlxaEFpRko3LytY?=
 =?utf-8?B?M3pWK2UvQ1VUcHZWT0s5b2g0UU41UkphOHpXaE1VVkxvbVdLOXNOeENxSFVL?=
 =?utf-8?B?QkVwcHdwRHlMbHArZzhJUG80RnJSZmJ5MTJlZXltcVl1Y21BMUc5ejFBRENk?=
 =?utf-8?B?enpHTG9LS2ZYK2RTVmYra3M1bzRXVGVHWTdyODAvY2s0WkZHVlJQRE1VUHNi?=
 =?utf-8?B?eDdIQVRUSzV2dVhKRjFoNXNOMkM2a25YdlFWMWltVU5zM1ZiWmlZTFhBMkFo?=
 =?utf-8?B?eEhOV1R6bUJpZlQwbDdCUjJlempzMnp0eTZPVDRjVmZiSENpTUFKckk1TDl4?=
 =?utf-8?B?VHdURmVuN2J1RzZjbUg1MkZtVG9MSWFUN0RGYmk2aFNuY1lINk9ZSXhNWElx?=
 =?utf-8?B?MFUwbm5HZlh5Mm1EcjY3RDhuR2JmaS9ONHM3UHBOSi9wN21zaWtzS0xZd2pE?=
 =?utf-8?B?akhEMnNoMU9CTGwremhRcmVNSmJ3WU5yWnNRUlB3bTgvcitYaDlxdEt3d3NS?=
 =?utf-8?Q?ZH+8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e3f79a-e2e5-42c9-57a6-08dcce60c18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 10:43:33.8872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MCqNrQQ+akuqIv6YJhiqQGwVCEflzSHLvIH6dnm6OZHwS1lVqHPIpdUWH2KqpyoAXCJT3P87yJEvE/SMAk0pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

SGkgS3J6eXN6dG9mDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIFNlcHRl
bWJlciA2LCAyMDI0IDM6MjYgUE0NCj4gVG86IEhhdmFsaWdlLCBUaGlwcGVzd2FteSA8dGhpcHBl
c3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT47DQo+IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8u
b3JnOyByb2JoQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBiaGVs
Z2Fhc0Bnb29nbGUuY29tOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrcnprK2R0QGtlcm5lbC5vcmc7IGNv
bm9yK2R0QGtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBHb2dh
ZGEsIEJoYXJhdCBLdW1hciA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29tPjsgU2ltZWssDQo+
IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3
QGxpbnV4LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IFBDSTog
eGlsaW54LWNwbTogQWRkIGNvbXBhdGlibGUgc3RyaW5nDQo+IGZvciBDUE01IGNvbnRyb2xsZXIt
MS4NCj4gDQo+IE9uIDA2LzA5LzIwMjQgMTE6MzEsIFRoaXBwZXN3YW15IEhhdmFsaWdlIHdyb3Rl
Og0KPiA+IFRoZSBYaWxpbnggVmVyc2FsIHByZW1pdW0gc2VyaWVzIGhhcyBDUE01IGJsb2NrIHdo
aWNoIHN1cHBvcnRzIHR3bw0KPiA+IHR5cGVBIFJvb3QgUG9ydCBjb250cm9sbGVyIGZ1bmN0aW9u
YWxpdHkgYXQgR2VuNSBzcGVlZC4NCj4gPg0KPiA+IEFkZCBjb21wYXRpYmxlIHN0cmluZyB0byBk
aXN0aW5ndWlzaCBiZXR3ZWVuIHR3byBDUE01IHJvb3Rwb3J0DQo+IGNvbnRyb2xsZXIxLg0KPiAN
Cj4gU3ViamVjdHMgTkVWRVIgZW5kIHdpdGggZnVsbCBzdG9wcy4NClRoYW5rcywgVXBkYXRlIGlu
IHRoZSBuZXh0IHBhdGNoIHNlcmllcy4NCj4gPg0KPiA+IEVycm9yIGludGVycnVwdCByZWdpc3Rl
ciBhbmQgYml0cyBmb3IgYm90aCB0aGUgY29udHJvbGxlcnMgYXJlIGF0DQo+ID4gZGlmZmVyZW50
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGhpcHBlc3dhbXkgSGF2YWxpZ2UgPHRoaXBwZXN3
QGFtZC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbCB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1s
DQo+ID4gaW5kZXggOTg5ZmIwZmEyNTc3Li5iNjNhNzU5ZWMyZDcgMTAwNjQ0DQo+ID4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55
YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxp
bngtdmVyc2FsLWNwbS55YW1sDQo+ID4gQEAgLTE3LDYgKzE3LDcgQEAgcHJvcGVydGllczoNCj4g
PiAgICAgIGVudW06DQo+ID4gICAgICAgIC0geGxueCx2ZXJzYWwtY3BtLWhvc3QtMS4wMA0KPiA+
ICAgICAgICAtIHhsbngsdmVyc2FsLWNwbTUtaG9zdA0KPiA+ICsgICAgICAtIHhsbngsdmVyc2Fs
LWNwbTUtaG9zdDENCj4gDQo+IFRoYXQncyBwb29yIG5hbWluZy4gIi0xLjAwIiBhbmQgbm93ICIx
Ii4gR2V0IHlvdXIgbmFtaW5nIHJlYXNvbmFibGUuLi4NCkhlcmUgMS4wMCByZXByZXNlbnRzIHRo
ZSBJUCB2ZXJzaW9uaW5nIGFuZCBob3N0MSByZXByZXNlbnRzIGNvbnRyb2xsZXItMS4gDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

