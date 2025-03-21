Return-Path: <linux-pci+bounces-24317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5AA6B7D9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ECF484970
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57231F1936;
	Fri, 21 Mar 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5XUHhw/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C91F1536;
	Fri, 21 Mar 2025 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550124; cv=fail; b=uQFTYqv0oRFAU00UhqG6ruTbBD9RrP8TltWMmNvnPjWvcqViI4MMDHd08rkc/2TkIlleGKlnHE7ycB7/7tW5uW80I+HPh6bA5gWf/2MFptLISwMr0TzQlVybSbPdyIAXJv111xdWtzJvOg92wQzI0Zg60lWrRW3yItEJnmCfZsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550124; c=relaxed/simple;
	bh=aCPvv0xA4V5JXS0iHBWEzwMcfksYvkHQmIh+xnjZRV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ckj6pwLG5iZ4ZE5s5xcVqBYxbsxYxiay1T8l3R7DmSu9P/KfUxROW00QWJIW+P13Ds1jS17Rf2kDsG2KZsjjSPHyWbHSeU3MadNrWBOUlQppxhyfZHXlHURtsLLlKDdbOIHvscqdJExfV77MCl4LOlq+uoCOTJYls9397Bk/uLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5XUHhw/Y; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ6oRnzk5sV9ezGwwX5KWZFF3jWlhTCq/bYaAChNTqCxdJ+TU4Ck994ba/T/aoVzouSk1CBXb0+O/O8CuNisHDS1NCXri7y1Nakgqtkx9CcMqqRRavGhVoRwoWW8E+wpt6rJBcQLZBXsEGpHpeqwVuhgAO9EvyMz/Pkbv01S5gz2BfLWguxkM4wM6JGajfWlc2g93kAtnwIs6Z57LCuSZ2YLn0yjGLY7cqQy6YIUHfd+9nwYVwTdZzzv/6Q7Hw4W17NLk0Jcs9V2LysOXiNeBfJW9GLP2EX5dZjEqzDoSazUhCoLzIzT8OJs6eBbnnCDu8X9X5ECnJcWkfQ1cw3Bow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCPvv0xA4V5JXS0iHBWEzwMcfksYvkHQmIh+xnjZRV4=;
 b=mTNIjK7pCW69qqhwvYAfRh3s/7W6ywQXxnlgxdSl8v9B8omRmJhTensu6V8OG0b6l3UtGBqBUewvUS3lcUjKI2KwoGCPcmUm2AK6FMjEZ0py5Ay01eB6k896C6I2EMCqGIdeVgVj4aewy9KRj0WrHJpax+SamO7MidsrdnqHU9uYMqLLqD48LunJoN17yTVAlel+tJr6BFpZtrgSYsWVtmijoeb0zb9P0pgqEzLhgHIj1aidflo7kbRawvqL53jEKn7lTTEZ5p08Iwhgr/cK2Fa9CsLg3wrqZyRikRIER1Iivo4v1T1b0rR1L0T+vnzVGgo8w/AI+HbPJClyOWmzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCPvv0xA4V5JXS0iHBWEzwMcfksYvkHQmIh+xnjZRV4=;
 b=5XUHhw/YpIu2K/IJwdsO7gO3PXk8Ya471RUtM8hU2V0jmLTjjBjqj2EocC8zJF49+/YZK5Xw5mlXhIH63XmhA/W5yk8VFuMZP/HSTge49PW6t6PMjVu1dixCJdplmaWgkpY4Hf0X3+6WaCaSVgfHHgAf9gCwkXR/PyvYc9yZF3k=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 09:42:00 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%4]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 09:42:00 +0000
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
Thread-Index: AQHbl+frJF7RvdoXyE2lj0XSnTqI+bN4pyWAgASzLNA=
Date: Fri, 21 Mar 2025 09:42:00 +0000
Message-ID:
 <DM4PR12MB6158F761C80CA82B59FC0634CDDB2@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
 <20250318092648.2298280-2-sai.krishna.musham@amd.com>
 <afe7947b-ed71-40d0-aa2e-b16549fc6b7d@kernel.org>
In-Reply-To: <afe7947b-ed71-40d0-aa2e-b16549fc6b7d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bf7f305f-5d2e-4c81-a2fb-1b1b774da8db;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-21T09:38:55Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|LV3PR12MB9401:EE_
x-ms-office365-filtering-correlation-id: 77b9cc28-014c-443f-5fe7-08dd685ca0d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Kzd4KzdCbzJHU0F5dXlhV0M3YnI1cTBwN2k3RHlLUW9QUkFXNTNMS3ltcmhi?=
 =?utf-8?B?QWNmeHlTUnp2N3hwYk01ZUhmaDA2NEFaOUhDM2lmMEtWU2w4Wiswb1p2eTJ2?=
 =?utf-8?B?UDhNaGlmcS9namxjYUsyVXVqcmFnUUI3eWJXeXNTOG13aG1GeEg1cnVJRjQv?=
 =?utf-8?B?UDc2UzZ4WExLSVA5Y1hTNXRYK2JOZEJQa1hhYVE5NndLQ2xIanBwYkM0c2tl?=
 =?utf-8?B?T2cvVjVUY0hIOHRyWERlMXRMamQ1bExSUjlnQWNjWW9hNWVLWDl2cTdRYTJx?=
 =?utf-8?B?OExndVhDTTczSkpSWVRQY3YrK2gvblAzNmpCclpLL2JxR2U5VldMRjd1dXhM?=
 =?utf-8?B?RUdMTzFoUi9laUNNcXBob0RwWWdGbGRLb0FCWHVLQTlPaFlvdGg2K0wzc0dN?=
 =?utf-8?B?WE5neWJpN2t3MVd1QXl1Qkp0T1RpaGhITXFqODhqZnczTDhmc1ZUR1lhdy9N?=
 =?utf-8?B?ajd3TFUxRWdnNGxsYkpQdXFMY2UzalFrbTk2ZzdzdHJ1UG9Vc01iR0phd3I0?=
 =?utf-8?B?UW9pOWdwdWF3REdsU2RkdUlTRW43cDZtcGtxQWFRZHVRQU9FUDFGM09rYjFQ?=
 =?utf-8?B?L25kSWhVajNRNU9vdGRvWnBiZTFycFBXUlJDMEdMWkg4NTVjZ1FWSFQ0enA5?=
 =?utf-8?B?VVcwRUpTR2EwNEUrcU5HZS9iTmMzQ1JsYmNQTXYvbjkrR2JZdWUzR0xicU5p?=
 =?utf-8?B?UHRCcFNxbGkzM3dVeWtIcGtUWWw0VTREaTFCdHVDUzdEZTZLcmZBbENhUmdt?=
 =?utf-8?B?aWp2bXpzU2V1dHR1WlB6SmZMUWkvcnRsaCthMG9FTlRwYlVqa0hmN0RuZGho?=
 =?utf-8?B?REFRNHVMVlFVZkFsS2s5WlVITzlNS2dCK2lqWFlIeit1d011a056Vnk2M21v?=
 =?utf-8?B?dGM5aXgrMi8rR2FUd01RMFRwbFNuNzBNQlRjOTB1dEtBeUFHRmEvRm93TFho?=
 =?utf-8?B?Nm11YXg2dXFKdXFqZUpnRlVJRWNWVG15RU9jaktNbHdQc3EzeHk4Ukd6dGNW?=
 =?utf-8?B?WUU4V0tsRjVKeGNJOTRLdHRERXZ0V3FYVHFWUitnRXBidXJmUDlTdjlhdkdR?=
 =?utf-8?B?ZnRsOVlFOGY3d0RqNk5CV3pQUmx4azRaYVkyam85ck8wVnpxQ3NQKzZSNWFk?=
 =?utf-8?B?Q25PYlVneHNMbmZtMVo5bFE5MDZZQVVJWXlINllreEszWDVVOHFmSCtJZDNv?=
 =?utf-8?B?OEpTcTk2dkNMaVFLK0preWIvWjlxcmpjek43d2Z2MlNWNkpKbW4xYnhISzNa?=
 =?utf-8?B?QWNzYzlWSG5wczZ1c2hPdS9FWllSbHMyd0wwMGVPNmNKV0hnWUg2NXNDMHE3?=
 =?utf-8?B?b3RVVjlEUjBaelNBQVYyM0VkaXVBWGp6dVdVOGlzSVpIc010RVN5ei82a3lt?=
 =?utf-8?B?anZWSGtKcmh6Nnc0aDAzQWkySzZyRVI5UEVQTXo3eHhLM2xUMUZDVE1LOWlq?=
 =?utf-8?B?QUxzRkJIcXdCMldQUHFDT1dUT3krRlByMDFuUUUzUHNZQWVDRVVqZjFMOHYz?=
 =?utf-8?B?Tkt6Um5aRnhNNng0cS80bW5JaVhZamdVMUU1NHRpZE55bkoxR0lqNktwK0RY?=
 =?utf-8?B?TndpaGN2RklVWXVMcmY4VVZRVVJZRDQ3aThyTTlsNWNmMlJrUmpFRmIrZms0?=
 =?utf-8?B?akpwOWIrQ003c1BkSEFNSnBSdkxDdVFJaCtlTUdNL2ZsNDYyYjVoeFJvU1pB?=
 =?utf-8?B?MTdmd2lMWkhHMnhRMzBzR2c5enlSYzBxY3FCTTFkdXpCY0xiVTQxTUx0eUcy?=
 =?utf-8?B?WEF3R0RoNllqMVNXcUkraTBEbkhrMTREbTNlYWUxZ2hMV3kxTDJoeThzd3Vm?=
 =?utf-8?B?NTNmd2JoNHBOaEdVS000OFdYb204V3RLMkdGa2dQakkwUVNEbGhmaE9Qdm5N?=
 =?utf-8?B?QU9KenBZTU1QRDR6RS9LUDl5ekRJeDdTWGFoN1dlT0tpanc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVR6VnZMOXZkRzc0ZTdmYXJoaGtzNk5VOUpMYmJKVEtHVldxRFBSZmNMN2Za?=
 =?utf-8?B?ZlQwVzNaZTJCaCs3ck5Cd0tNMnFmNkhwNXJCRHJYK2FZMFdJZzFGUzNLaGJI?=
 =?utf-8?B?ZjF4UHdlbW1QMjNkeHMyY1ZoRGVXYkMxbHB6MEZGaEFPYnFQRHVZWVp6Q2tV?=
 =?utf-8?B?ZGR1bzBMQkx1TFRmUnE3bTY0VWZjRHlJTjRXSXV4c2VUMzIyZlNDSE5leW00?=
 =?utf-8?B?ZUxpUDFRRGM2YTVLRW9QQ1B1d1lZRHIzakxzbXhlN3h2bnlETnI1WjV0Mmpj?=
 =?utf-8?B?RU9ZRWd1Ky8wSVJoTEZ6UW45Umc4aEdXZDF2R2IwaFN6bS9OcWlrQ0J3YzRL?=
 =?utf-8?B?YXdEbllWekFlTll6UHJFUkRRYTlFTkZud2YyVERRN3JDcVFmS2phMnFoQUVN?=
 =?utf-8?B?ZW5BbUFRSUFla0c3cHpMQXNYeG51RHdoMlViQzY1WWRjeEFsYkNKQjJMR3lI?=
 =?utf-8?B?RCt4aGh2dG1LUmJDUGYvb3hpWTZQNjUvMG5ybThvYm15N3R2clJ5dTJpVk9W?=
 =?utf-8?B?VGMzK2JkaS9jdGF1NEtPaUJJR3RxVmI2SlkrVDJLWkxrYlFjZGhocTMwVzU4?=
 =?utf-8?B?dVhNQWlNWXZORU83Mk1RWnhLTU9EUVZEYzYzbVBHRmlxMVZHY20zWHIxd0J0?=
 =?utf-8?B?ZmUrazdXSytsZUNiQTVuak9TeXdLOVpmVGVJRWJuWWdpMy9OR0hwMmpIYWVm?=
 =?utf-8?B?R0owbjdmTFFuMUlJcTRodWdBRWhEMTVCVldTM2FkeFBoU2R2NGVXTTYzZUZW?=
 =?utf-8?B?UjkxMDc4NVRGb2ZrZ2RpSEx3bG5pWGlmNzNlaDc5MlRIa25leXY2MWRpeGto?=
 =?utf-8?B?ZFRtNEdjNzJnWFViWkRXcElQaVlMWDNyd1IrOXpqLzNrcTFVNWR3bjZtR3pO?=
 =?utf-8?B?R1l2ZHpBeEdqY0JpNHZpN2ZvL1ZVNTU5R3k4Ti9XTWtlUkV5emJSQ2lzTkZo?=
 =?utf-8?B?THJIeG1RNVBBM3BiRHBQUnJTYUgxdnNtd1h2ZTZPMC9LWVNsUnlDMSszcGNE?=
 =?utf-8?B?dktUeUxrSGszZlkxS1cyS0FFRHc3WEl6czVsRGpPMUppbFhoSFp0Z0ppRnN6?=
 =?utf-8?B?S0tiZUF2NEJyaVlOK3RhRnNHcjRGeGZFT0RrOU05emFKeDY2QWJHWUR2Nm0r?=
 =?utf-8?B?S2o1VStLbHQ1a3FZT0lPVHVuc2xUOEw5N3FoVVQyR2xON1d4UmFFQ3dYcWRK?=
 =?utf-8?B?TkJIcTFjamxrWnNNUE9paWNDSkNNTjRWNlVBMElJQXF3OHRyWEdldlhEOXYx?=
 =?utf-8?B?SFlqUDFtZlVtWFRqa1Qzbno0WnFpc0NQdHJwK2YyOHdHWEtaSmJ5VVJmSHdL?=
 =?utf-8?B?Wml4dkFnRnYxYWVCdzRxci8xRE5tc0I0T0dleEJmUlNYaWQwNGFVNFMrQ3lF?=
 =?utf-8?B?RVR2SHNvM2JHOWd6T1hwWGZqTkVoaXcyS3RLS3Vla1hyQVA1YVkzbUZoT29k?=
 =?utf-8?B?SWlmUnZFdjdmK2RJYnN1TlFMZjhBTmJDUEJGaVFtUmxYVHNPQ0Z5RTh5dEFn?=
 =?utf-8?B?YW9acEZtTDAyN2JFcjhVei94djNyZ3htQXM1b3dobElaREJqT3E0SEo4bG85?=
 =?utf-8?B?d1NXM3V0d1lrU041eEpOZ2VvckNQWEVxWWdFTHZueE9MQ2srQlFsM0d3QVkz?=
 =?utf-8?B?RFJDN21WMzVvL2lHVFUvVmRiVklyTENyZTNlaUR6ckxOZzc4MXNUR2hETjFq?=
 =?utf-8?B?QkRUdnBXdXJCb2ZORlcyUlNDNjdYbVdPMlEreExhSU9OZmZBUnh5dVAxVkpr?=
 =?utf-8?B?UGQrYjRQM1lKNElGa3pneWxjTmJMUUlDckNTeXRDRmdBOXBGR210eCtZalNF?=
 =?utf-8?B?Um92Nk94QUhDblRaZmpLb243ZGVaNVp3ZE92NTVicU5UVUFyRndqaEJXUkJt?=
 =?utf-8?B?TWZ5bEJRMlJpdzFJTUUvK0p1M2F0cE4zRVdPYk1SUmdPTGxxUjk2cjdycEhy?=
 =?utf-8?B?OWN3WkJ1ZlRPb0lkREtzRDd1QUhQVy82Skh4WmxKL1BXMDROZ1liQXhGT2Ew?=
 =?utf-8?B?YjhhazdpWlowN1BzVHNoTjRLYUF6NmFsd1VkSWcyL1c1NjZCTVQ3TzZXUHB4?=
 =?utf-8?B?NC81MGZ6a1NYRWdSVTZBTEhqN1lSZHJaajZBOFRkMHNra1NiZ0NNbUxXbkF1?=
 =?utf-8?Q?f4tM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b9cc28-014c-443f-5fe7-08dd685ca0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 09:42:00.0587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5g3TDkU/Wi4Q9otBIuJTxjTDaSZO5tkW1A96vTzG4u2m7Grl93u7eVGNJO9jjD7tu7ZHKZ9Ep5vPuGfecvCJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwg
TWFyY2ggMTgsIDIwMjUgMzoyMyBQTQ0KPiBUbzogTXVzaGFtLCBTYWkgS3Jpc2huYSA8c2FpLmty
aXNobmEubXVzaGFtQGFtZC5jb20+Ow0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBscGllcmFsaXNp
QGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsNCj4gbWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFy
by5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBr
ZXJuZWwub3JnOyBjYXNzZWxAa2VybmVsLm9yZw0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEdvZ2FkYSwg
QmhhcmF0DQo+IEt1bWFyIDxiaGFyYXQua3VtYXIuZ29nYWRhQGFtZC5jb20+OyBIYXZhbGlnZSwg
VGhpcHBlc3dhbXkNCj4gPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgMS8yXSBkdC1iaW5kaW5nczogUENJOiB4aWxpbngtY3BtOiBBZGQgcmVz
ZXQtZ3Bpb3MgZm9yIFBDSWUNCj4gUlAgUEVSU1QjDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2Fn
ZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24N
Cj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGlu
Zy4NCj4NCj4NCj4gT24gMTgvMDMvMjAyNSAxMDoyNiwgU2FpIEtyaXNobmEgTXVzaGFtIHdyb3Rl
Og0KPiA+IENoYW5nZXMgZm9yIHYyOg0KPiA+IC0gQWRkIGRlZmluZSBmcm9tIGluY2x1ZGUvZHQt
YmluZGluZ3MvZ3Bpby9ncGlvLmggZm9yIFBFUlNUIyBwb2xhcml0eQ0KPiA+IC0gVXBkYXRlIGNv
bW1pdCBtZXNzYWdlDQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNh
bC1jcG0ueWFtbCAgICAgICB8IDIxICsrKysrKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3hpbGlueC12
ZXJzYWwtY3BtLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+IGluZGV4IGQ2NzRhMjRjOGNjYy4uOTA0NTk0
MTM4YWYyIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+IEBAIC0yNCwx
NSArMjQsMjAgQEAgcHJvcGVydGllczoNCj4gPiAgICAgIGl0ZW1zOg0KPiA+ICAgICAgICAtIGRl
c2NyaXB0aW9uOiBDUE0gc3lzdGVtIGxldmVsIGNvbnRyb2wgYW5kIHN0YXR1cyByZWdpc3RlcnMu
DQo+ID4gICAgICAgIC0gZGVzY3JpcHRpb246IENvbmZpZ3VyYXRpb24gc3BhY2UgcmVnaW9uIGFu
ZCBicmlkZ2UgcmVnaXN0ZXJzLg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBDUE0gY2xvY2sg
YW5kIHJlc2V0IGNvbnRyb2wgcmVnaXN0ZXJzLg0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBD
UE01IGNvbnRyb2wgYW5kIHN0YXR1cyByZWdpc3RlcnMuDQo+DQo+IFlvdSBjYW5ub3QgYWRkIGl0
ZW1zIHRvIHRoZSBtaWRkbGUsIHRoYXQncyBhbiBBQkkgYnJlYWsuIEFkZGluZyByZXF1aXJlZCBw
cm9wZXJ0aWVzDQo+IGlzIGFsc28gYW4gQUJJIGJyZWFrLiBXaHkgeW91IGNhbm5vdCBhZGQgaXQg
dG8gdGhlIGVuZCBvZiB0aGUgbGlzdD8NCj4NCj4gT3IgYXQgbGVhc3QgZXhwbGFpbiBBQkkgYnJl
YWsgaW1wYWN0IGluIGNvbW1pdCBtc2c/DQo+DQpXaGVuIEkgYWRkIHByb3BlcnR5IGF0IHRoZSBl
bmQsIEknbSBvYnNlcnZpbmcgZmFpbHVyZSBkdXJpbmcgZHRfYmluZGluZ19jaGVjay4NCiQgbWFr
ZSBEVF9DSEVDS0VSX0ZMQUdTPS1tIGR0X2JpbmRpbmdfY2hlY2sgRFRfU0NIRU1BX0ZJTEVTPURv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFt
bA0KRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNw
bS5leGFtcGxlLmR0YjogcGNpZUBmY2ExMDAwMDogcmVnLW5hbWVzOjI6ICdjcG1fY3NyJyB3YXMg
ZXhwZWN0ZWQNCiAgICAgICAgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcv
c2NoZW1hcy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbCMNCj4NCj4gPiAtICAgIG1pbkl0ZW1z
OiAyDQo+ID4gKyAgICBtaW5JdGVtczogMw0KPiA+DQo+ID4gICAgcmVnLW5hbWVzOg0KPiA+ICAg
ICAgaXRlbXM6DQo+ID4gICAgICAgIC0gY29uc3Q6IGNwbV9zbGNyDQo+ID4gICAgICAgIC0gY29u
c3Q6IGNmZw0KPiA+ICsgICAgICAtIGNvbnN0OiBjcG1fY3J4DQo+ID4gICAgICAgIC0gY29uc3Q6
IGNwbV9jc3INCj4gPiAtICAgIG1pbkl0ZW1zOiAyDQo+ID4gKyAgICBtaW5JdGVtczogMw0KPiA+
ICsNCj4gPiArICByZXNldC1ncGlvczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBHUElPIHVzZWQg
YXMgUEVSU1QjIHNpZ25hbA0KPg0KPiBJc24ndCB0aGlzIGFscmVhZHkgaW4gcGNpLWJ1cy1jb21t
b24ueWFtbD8NCj4NCj4NCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

