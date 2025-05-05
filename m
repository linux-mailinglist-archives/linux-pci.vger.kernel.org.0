Return-Path: <linux-pci+bounces-27126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8669DAA8C6C
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 08:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62842188FC5A
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 06:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682EB1ACEDA;
	Mon,  5 May 2025 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZvQzDQmr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD2117A58F;
	Mon,  5 May 2025 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746427643; cv=fail; b=ge9J697kz9iFpLREPzj8PUnF83WyjX1mz2ZPeAcHwNbPW+u5Vw2ZIm4FSPE4SkQi5EsogSq3WRyEM/F+yUapz/9Lm9GXrxR06RpBRDkXheU5tVYIbAWxg2ZK5XMe1vqDnRfoqd3qTIzqC1vVrN+nRJxKDrBSXmEWPIVgFh+X9QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746427643; c=relaxed/simple;
	bh=wWAG+d0ebd1EGxNxck4Iiik9Nd67DMdWXkwbz9ShqSU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KszdY9ClnQPG44KGJvrrFLJuZUC0J2YH9i7ZwwFbstpI9csvrSnes+WD7PN9vntBByK5L/9xGL8lT59+PVx9gqsEi44inzhkAnOTeHZTB3H/L1NAC0Ghen/gDIp+nMas6Y/0LSmqu907rgGWMWNNq6Lx4GlP0ZF0JpzoTXnDAfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZvQzDQmr; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5Wt0zqshXZjRhNYX7WX5dhlmdbBRSs/GwdKX0cWze37/nsDISDhhQN/eFkeq40fDwVZv67Vz/4yNzQTAWBqvgHvYelfCPYdqLzzYrFdGOmjrJPbuYa09uXrMNwn/FnPt+Vl81VXTltJFLcgk6Rkn35uvdbpaOwJCZLfOoidWWVnLPbXD1NiAARaoNIaPvikxY8A8nt+Me4DNCPViY2Q6lfKDpTJZrJ42myQfGPOBWhllrb7pQWtCAGLsQySqfqbiAYFNHv3UhssFKrUJDuCqPpW7XIaJsqeMMbWo8nf61/J86WV8P/UDrTvP6mteGh5mLLylv9J/eYvHrny5Rbl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWAG+d0ebd1EGxNxck4Iiik9Nd67DMdWXkwbz9ShqSU=;
 b=RNbIKjzssfuD6VhLP3j2/PidOL7FBfsaJDAiaz+ceaZjTPP/uHl3M55t/WFCB4tq9RCIvwMzeFewoWNm/WYwRbmKer1DcNKKiy2vpHP9l2RQF+oU3doKbrU1btoHDrVKQyXG0Cd1vFwXdy1R9FgZ05u2GmLogc7WoTO48QF8sLEsxaE0AyacKeTuIG4wJBo1zIFWuwnwi+y6LGI7E5c1sFuIkMQQ0od7EiVXCyTy52wgLRB40hlzUPxJmv8a1LTRAMBc1yBYBq+WqLGoELCYol+F8LWISlZ1+jAeGuiuxpTs8089YPKQKGz9KoWhIlUtJYFqISrD+FxvyYx63mMkfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWAG+d0ebd1EGxNxck4Iiik9Nd67DMdWXkwbz9ShqSU=;
 b=ZvQzDQmrT7aJIwyywzwMBylX5lwh77IyVQG89LV+7V2/ZoP5VlJLMD8tWKSRDXZ5fIR/Yyu4fgUuTKZlAfOcT+VppF5n3cOfzRo5PEhpgqcMJW5Cm6sGPU3t/Nia883g/8cpVwXBpCW4Phhrym5duh1W5QMkwDmVJe4HXgedlLg19qF80/BAHokobdFo/hVl2cUrsXJ5/F36lEGXY+PCrzDB8znsUUCzgUfViE0rz6uH7A6u/wIVvcDBVDYwb/P7prW1HrAuwfNERe7ufrZUUZGzkCawf8zQjMHZqPyXTVTjzjH4TiGbdG+rXFWL/4fbCA2X6i2GjI9CNLQlKgNLrw==
Received: from SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 06:47:18 +0000
Received: from SN7PR12MB8028.namprd12.prod.outlook.com
 ([fe80::f9c1:e211:c67a:89d4]) by SN7PR12MB8028.namprd12.prod.outlook.com
 ([fe80::f9c1:e211:c67a:89d4%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 06:47:18 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "cassel@kernel.org" <cassel@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding
	<treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Krishna Thota
	<kthota@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	"sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH V3] PCI: dwc: tegra194: Broaden architecture dependency
Thread-Topic: [PATCH V3] PCI: dwc: tegra194: Broaden architecture dependency
Thread-Index: AQHbr2zgilNpNz4SqkqdSaDjn3zHj7Oprb6AgBoGZ68=
Date: Mon, 5 May 2025 06:47:18 +0000
Message-ID:
 <SN7PR12MB802801514D1FFFC21603C236B88E2@SN7PR12MB8028.namprd12.prod.outlook.com>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <vrqkwvwwjrirsrrionoqbdynha3pahabmkhzk5rs5vfb3wugh7@4zagyt7ycbbv>
In-Reply-To: <vrqkwvwwjrirsrrionoqbdynha3pahabmkhzk5rs5vfb3wugh7@4zagyt7ycbbv>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8028:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: 93f4cfca-841d-4ff1-2a9d-08dd8ba0adf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MkNUWFdCOUlYcDRWWGt2ZThoc21uNVhHK204RWlxd3Axd2tZQmJxWlErKzlr?=
 =?utf-8?B?Nkdmc0VqMzNBTGJiQnY0THd2bW0xdVluaExRdG1oYVZGaGJsdFFBR0ZsdTVB?=
 =?utf-8?B?UzlxWkRNbEp6ejZ1NVlEdEg2cnNkTWdrVFRkOVBNVHdrWjlvRUo5UHlzTDNZ?=
 =?utf-8?B?Q3cySmp3VWtENGlocHVIbGVuTXh0QmttT011c21INU92MWJhWFU2STE0YWZV?=
 =?utf-8?B?M29ydGZLdHhFTE9iU1dUaUZ1TzFTb3h6dCt3bGZkMnkvdnpQZXVRRHNpS3hG?=
 =?utf-8?B?MGtxL2NyQzVRaVRvejNpdHdtdWpHK1l5clBNOC90RHN1S1FSZ3VmVHNpeVN1?=
 =?utf-8?B?VHFYMDRubVkxUHFVQktFQ2dhUGUyb21vN0hocVQ1NC9kVkx2TTBZYThSRDVC?=
 =?utf-8?B?NDhRZXVjVmtvdnIyMDdVZHVaOGVzSFpuSGZib3dDaVhSbFJPaTltTHhKbWlQ?=
 =?utf-8?B?Z1NPbk95VndVQWpTemNabzJheVBXQVNPR1RRd1pzWTd2R3FqT1h0a3I1N0Fz?=
 =?utf-8?B?OU9BRjFjZzlFWjlSTW84anBTWGhaQmYrbmNKcXBvem1uRWp5Tnp6R2M5MHZC?=
 =?utf-8?B?U1FNR1g4RGpmZDVrTnc3RTlSVVBOQ01ZKzlHZGpVMVJvZHdySnROZnJrOTQ2?=
 =?utf-8?B?ZW1IRzhtL3FLT2NnRGNYY09tWVR5TmZYenpGR1JwTzZ5QlI4YjdhWU9Idjd3?=
 =?utf-8?B?RG4xQ1hrZlU1aFZHY0VBRU1Rbmd5amhBaW13dytsckFrWkZIT2pZMVJDQ2k4?=
 =?utf-8?B?bDVEdXVqMG5FTDBsNjRZT2JzVFZOS0xQOXFtQkd0NldBaGYvMktJYUNKeno0?=
 =?utf-8?B?TjBqcHB4UU5FQ1dkTjdZZlJUVTNMUDd0MHZBdXgzOTIwTjNSYVp4TkpyZ0J5?=
 =?utf-8?B?R3BiVm03TStITUsrcTd4SFIvM0FTUDhLNzhXT29XbnNjMkY1VXBHaHlTVWRu?=
 =?utf-8?B?WjhKa2x3aXBTOXlxSlBCYmh1c2FoRWFYNW43SElHVmoxT1NtYmdVdkJBUDha?=
 =?utf-8?B?REdEVUFldTc2TnBJWUV5MDhlSHN4d29UZElIcHdPZzFicVdZTDVuMGpKdGNs?=
 =?utf-8?B?TkNOSVUyeXpxa1NTejFyd3FYUXc4UElIVnJUcktUU2ZCeWR2U2FnQ0RwSm9n?=
 =?utf-8?B?YlJZTDFCZzhpd1dnN1RxQWRjaFBEbXU0akErVzhXMUl0ai9VYVR4R0FhMk5t?=
 =?utf-8?B?MjFISlpnM2V1MUJ2SGhoS05xblNxdDlzK2ZoeSt1NWJmQjFBcUxzcFJvVWpw?=
 =?utf-8?B?NUpkZ3FiK21vdmdUU0JRc2duUHFBV2lzR3g0b1d2dHlTMlRuS2JrS3ozeDND?=
 =?utf-8?B?cEFoU1BRWC85TjVBZTBMYW9HT2NVTkRaTU9qK21kTGZObDdMVkZCWXpHeTNN?=
 =?utf-8?B?NlVZanVTb2RJSDkzdi9yeXhmYjM2VjV1bVVGdVZvZDFscE1JMDBFOFZOdWl1?=
 =?utf-8?B?dXpHeDhLc293RDVRMG9xcXQ3TzJDTldleE5tQis2NmJNYXdQMkMvMXhUbDcv?=
 =?utf-8?B?ckZGTWVaWjg1SkpoNnNzbUpmUXZjWGJDaUN5YkJ1WmxQWnZVNXppejFOMTVt?=
 =?utf-8?B?d2FmQ1lHYzk3aUMxeHVaRlZwL3pRbHd1YkVBRk5Qdm5mNG9aT0xyRlBKSnNM?=
 =?utf-8?B?ZnZWRVdsRlQ0d0V1YXh3K2xkdy9hY3g4MVk2cEFyYXFPZmRaaktHSlRDUWQ3?=
 =?utf-8?B?aTNYbnlWc3o4VVhwRFR3a28wand4YlEyeGpDYU0rK1VSaDdENjArT0cvclcz?=
 =?utf-8?B?MVBGdm5nUld6V0VrYVF3UUxmYklQbGk2eFgvaXc0OVRkekpDSnBkQjVaaTNW?=
 =?utf-8?B?UCtENWJlRk44UGhMSG9LWFV4SDRpWk1UdDZubk00NkY1ZDhMeklmZmd6WDdU?=
 =?utf-8?B?ZmpFemFaQU5vUzhDM3hNWlJlYXNtbXhCZ2ZBWUZZeG1xNDROdkFEM3Z1ZU16?=
 =?utf-8?B?TE83MUhsUGVGMGtkMUM5RUFKaTAxTS92SU9PTXR6SFR0bkRCNGJlWWhMU3BC?=
 =?utf-8?Q?Va6TNc73I2uMy7idlzG6avVAIXjPEk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8028.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFBTT1JOZkpxM01ldVdnMDRGb1lGTUhCV01tZ0x3SU1pcnI5ZDVablhWQU93?=
 =?utf-8?B?VTEzNU10TzdRMVU5b2NteEMybzlKUkhteUpJWE1Kb0k4aFlCb2tzcXBXRS9u?=
 =?utf-8?B?RTloMllwS0FMUVpoYUNrT0ZJdXJWbzBpRHVhS09wRkRMKzF5Q01KNEVnajJC?=
 =?utf-8?B?NXpoVWwzZHZXUXVrcFloanlQL0NOb1BDOVlhRk9EZmRIQmlnWG1wSkZrcGV0?=
 =?utf-8?B?R0pmeHVYdWVNNUZGRFRWUHd3REhnczdUQ001N1B4dHkvV3NzSEhYWHlsQVZm?=
 =?utf-8?B?TjdXNDh5akczV2gybmxrYysvakw1Q1B4SU1JOWZGaE1URWFHeGg4KzV5c2FR?=
 =?utf-8?B?eW96eTZZYmc4aGhxZFRWYk94d3ZraUlVZDY1VkJxcUtsWXo5Sk95MEhmcmVT?=
 =?utf-8?B?aHNrMkJCTytWYVFXeFNpMDdJWXY5WS94Y1RqL0hWa2dNWWx0RVhTN3lNM2VM?=
 =?utf-8?B?OXZRN0UyUEJLeFpkUXFkNWZrMHJWQk1XaUQzaTRHV2ZGRExzeVhPN0FUK3Bh?=
 =?utf-8?B?YzFiazFlNzdWWFhqZnhvcW5RalV3SVZmb2xIc2hMTGhML3EvSzk1MkJsR3Fr?=
 =?utf-8?B?WE12dG0vVzBoWENMOWF0NkNkUkFaa09oQkZqMDhNSHdUUlRnZi9DdGJvQ3FG?=
 =?utf-8?B?VjFaejI5bGNLeUFkb3dGcHFWS1NKSEhLdHNUNXIxL2ZleDBTd01OcTgwd3pi?=
 =?utf-8?B?NjRSQjdScUJvM1Z2UVhuYVUzYktnYVBJSDNJUkxXVHdVZXNTWWZpVEx0L0hW?=
 =?utf-8?B?SE1aWmNjYjArRThOYWwzSGEzNHNkRGhHNFV6dzIyak1yMzFMV3ZPdXZrYjVM?=
 =?utf-8?B?RlgrSGtONnVscGpGQmVXRi9ubENKQVNvbmhia1p3TDhpRlhtR2tHMWQzOVRN?=
 =?utf-8?B?c2o2amZ2RWgyZnltOVlpZXZQUVZLU00vVmlFTXhpSkZhNFpsbnpIYU90eFZs?=
 =?utf-8?B?REtDb3U4STh6ZVpPTjJIL095TEowK1hJajI2QjhWUUNLcDZIRCsyazdjaEpS?=
 =?utf-8?B?amtnT3BOWTAzSzhmTFpna3U3WXVqY2dZRzRKRXlCSDNpS3paS2t6cFhycmFy?=
 =?utf-8?B?TU1tZkswU00yYnE5NSt1YTZvb0R2UEJPVmQzMElkV2R1TnVTVkVRUGloalhZ?=
 =?utf-8?B?bGJVOXlEYmtGSElNc3ZhS3ZvNk8yeDFsb2dMUlYwNjRYbndDT0ZZK3M2OWFk?=
 =?utf-8?B?VXRla01ITHg3U2l5NXQvMW1udmMwNzZqMlV2Tnk3aUtVM1VSaW9EVFRJOWV6?=
 =?utf-8?B?NWVXS1hlZ1VjczV1YTczWm1IWW9JS0k5TlJpY2lFaThzREl6aFhTclRMbTdT?=
 =?utf-8?B?YWVkRXhPblFsNXg2NVhWZng1Y3dxaUZuRWdnWmNQQnEzeEk4dDhmanBTa0pE?=
 =?utf-8?B?WXJyQzRmbVQwaHdSRGhFZXZkdUVrd1NtWG5DQ3JkL2E5THlwWDRiUU0zZGh5?=
 =?utf-8?B?YlFuTHVlTWxVbStJZ0kxd3l0VDYxTHJuay9WdzlKdHRZVk1tMUQ4ZFZheWlD?=
 =?utf-8?B?ajBxdVErZU1MOG84SnZkc1NtM0R2ZllJbnhNSjRLdGh0Tkd3RmVmZDdGajZ3?=
 =?utf-8?B?TWE3V053WmRXNkl0a210VVRzc1JQTFZaVm9PQnVwalZuVjdsaXdsajlQZXZN?=
 =?utf-8?B?V3RnVXlCc09MdSsvZE9IMWptSUVudkFJY1JHT1AxQWFIdXlJYWFlTVRpdjZB?=
 =?utf-8?B?Ti9sRnc4b0w2dVFSckdvQXhrcSt1ZHRMMU90N2hGM1IyQnk3dXZnd0Z1WVl4?=
 =?utf-8?B?MHhRV21ZNTBhaUUzSkVtbkhhMWxaK2FvQ3RzbEowbzcwcjYyK2lIVlBJczc2?=
 =?utf-8?B?RktaVDJSV25kUmM4Y2RvZktOS25VeldQcHc2bDVZeU5TaXlra2ZCQjJZNHQr?=
 =?utf-8?B?cy9vVEtKR3Q3RDJCcXJKR21XWFlVK0RaYXM2OXB3U2E3cjJFbE1RRWpIZzdw?=
 =?utf-8?B?UVQvTVBDaVpsakM1MWEzVEhlN0x3aGlJc29kZ24rdm1nZVZUYU9NcHRTa241?=
 =?utf-8?B?MU1hYW5WZnBBOXBLWHk4SFltY1VuaDZFSVA4QmEvdDQ2Vmw1TDFtbU1wcTU5?=
 =?utf-8?B?VVp4UjBiaFJwRzBVcW9lWG80ejBpd2pUSUtyUmRzbVNvTWdUeUJuM3ZYbjU3?=
 =?utf-8?Q?yyqg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8028.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f4cfca-841d-4ff1-2a9d-08dd8ba0adf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 06:47:18.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syf0pnEwrEKIbYqnSpY3aJV150OX9SHlBXizNNgWWPJ2JOXLWzS6Lr8j9awSdK6pFBu2A+JwbeBjH6SNMY3Xxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290

SGkgTWFuaXZhbm5hbiwKUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBhcmUgZXhwZWN0aW5nIGFu
eSBmdXJ0aGVyIGNoYW5nZXMgdG8gdGhpcyBwYXRjaC4KClRoYW5rcywKVmlkeWEgU2FnYXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KRnJvbTrCoE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+ClNlbnQ6wqBGcmlk
YXksIEFwcmlsIDE4LCAyMDI1IDIyOjUxClRvOsKgVmlkeWEgU2FnYXIgPHZpZHlhc0BudmlkaWEu
Y29tPgpDYzrCoGxwaWVyYWxpc2lAa2VybmVsLm9yZyA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPjsg
a3dAbGludXguY29tIDxrd0BsaW51eC5jb20+OyByb2JoQGtlcm5lbC5vcmcgPHJvYmhAa2VybmVs
Lm9yZz47IGJoZWxnYWFzQGdvb2dsZS5jb20gPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBjYXNzZWxA
a2VybmVsLm9yZyA8Y2Fzc2VsQGtlcm5lbC5vcmc+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
IDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5n
QG52aWRpYS5jb20+OyBKb24gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT47IEtyaXNobmEg
VGhvdGEgPGt0aG90YUBudmlkaWEuY29tPjsgTWFuaWthbnRhIE1hZGRpcmVkZHkgPG1tYWRkaXJl
ZGR5QG52aWRpYS5jb20+OyBzYWdhci50dkBnbWFpbC5jb20gPHNhZ2FyLnR2QGdtYWlsLmNvbT4K
U3ViamVjdDrCoFJlOiBbUEFUQ0ggVjNdIFBDSTogZHdjOiB0ZWdyYTE5NDogQnJvYWRlbiBhcmNo
aXRlY3R1cmUgZGVwZW5kZW5jeQrCoApFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3Blbmlu
ZyBsaW5rcyBvciBhdHRhY2htZW50cwoKCk9uIFRodSwgQXByIDE3LCAyMDI1IGF0IDAxOjE2OjA3
UE0gKzA1MzAsIFZpZHlhIFNhZ2FyIHdyb3RlOgo+IFJlcGxhY2UgQVJDSF9URUdSQV8xOTRfU09D
IGRlcGVuZGVuY3kgd2l0aCBhIG1vcmUgZ2VuZXJpYyBBUkNIX1RFR1JBCj4gY2hlY2ssIGFsbG93
aW5nIHRoZSBQQ0llIGNvbnRyb2xsZXIgdG8gYmUgYnVpbHQgb24gVGVncmEgcGxhdGZvcm1zCj4g
YmV5b25kIFRlZ3JhMTk0LiBBZGRpdGlvbmFsbHksIGVuc3VyZSBjb21wYXRpYmlsaXR5IGJ5IHJl
cXVpcmluZwo+IEFSTTY0IG9yIENPTVBJTEVfVEVTVC4KPgo+IExpbms6IGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1wY2kvcGF0Y2gvMjAyNTAxMjgwNDQyNDQuMjc2
NjMzNC0xLXZpZHlhc0BudmlkaWEuY29tLwo+IFNpZ25lZC1vZmYtYnk6IFZpZHlhIFNhZ2FyIDx2
aWR5YXNAbnZpZGlhLmNvbT4KClJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1h
bml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPgoKLSBNYW5pCgo+IC0tLQo+IHYzOgo+ICog
QWRkcmVzc2VkIHdhcm5pbmcgZnJvbSBrZXJuZWwgdGVzdCByb2JvdAo+Cj4gdjI6Cj4gKiBBZGRy
ZXNzZWQgcmV2aWV3IGNvbW1lbnRzIGZyb20gTmlrbGFzIENhc3NlbCBhbmQgTWFuaXZhbm5hbiBT
YWRoYXNpdmFtCj4KPsKgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcgfCA0ICsr
LS0KPsKgIGRyaXZlcnMvcGh5L3RlZ3JhL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICst
Cj7CoCAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZwo+IGluZGV4IGQ5ZjAzODYzOTZlZC4uODE1YjZl
MGQ2YTBjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcK
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnCj4gQEAgLTIyNiw3ICsy
MjYsNyBAQCBjb25maWcgUENJRV9URUdSQTE5NAo+Cj7CoCBjb25maWcgUENJRV9URUdSQTE5NF9I
T1NUCj7CoMKgwqDCoMKgwqAgdHJpc3RhdGUgIk5WSURJQSBUZWdyYTE5NCAoYW5kIGxhdGVyKSBQ
Q0llIGNvbnRyb2xsZXIgKGhvc3QgbW9kZSkiCj4gLcKgwqDCoMKgIGRlcGVuZHMgb24gQVJDSF9U
RUdSQV8xOTRfU09DIHx8IENPTVBJTEVfVEVTVAo+ICvCoMKgwqDCoCBkZXBlbmRzIG9uIEFSQ0hf
VEVHUkEgJiYgKEFSTTY0IHx8IENPTVBJTEVfVEVTVCkKPsKgwqDCoMKgwqDCoCBkZXBlbmRzIG9u
IFBDSV9NU0kKPsKgwqDCoMKgwqDCoCBzZWxlY3QgUENJRV9EV19IT1NUCj7CoMKgwqDCoMKgwqAg
c2VsZWN0IFBIWV9URUdSQTE5NF9QMlUKPiBAQCAtMjQxLDcgKzI0MSw3IEBAIGNvbmZpZyBQQ0lF
X1RFR1JBMTk0X0hPU1QKPgo+wqAgY29uZmlnIFBDSUVfVEVHUkExOTRfRVAKPsKgwqDCoMKgwqDC
oCB0cmlzdGF0ZSAiTlZJRElBIFRlZ3JhMTk0IChhbmQgbGF0ZXIpIFBDSWUgY29udHJvbGxlciAo
ZW5kcG9pbnQgbW9kZSkiCj4gLcKgwqDCoMKgIGRlcGVuZHMgb24gQVJDSF9URUdSQV8xOTRfU09D
IHx8IENPTVBJTEVfVEVTVAo+ICvCoMKgwqDCoCBkZXBlbmRzIG9uIEFSQ0hfVEVHUkEgJiYgKEFS
TTY0IHx8IENPTVBJTEVfVEVTVCkKPsKgwqDCoMKgwqDCoCBkZXBlbmRzIG9uIFBDSV9FTkRQT0lO
VAo+wqDCoMKgwqDCoMKgIHNlbGVjdCBQQ0lFX0RXX0VQCj7CoMKgwqDCoMKgwqAgc2VsZWN0IFBI
WV9URUdSQTE5NF9QMlUKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvdGVncmEvS2NvbmZpZyBi
L2RyaXZlcnMvcGh5L3RlZ3JhL0tjb25maWcKPiBpbmRleCBmMzBjZmI0MmIyMTAuLjM0MmZiNzM2
ZGE0YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3BoeS90ZWdyYS9LY29uZmlnCj4gKysrIGIvZHJp
dmVycy9waHkvdGVncmEvS2NvbmZpZwo+IEBAIC0xMyw3ICsxMyw3IEBAIGNvbmZpZyBQSFlfVEVH
UkFfWFVTQgo+Cj7CoCBjb25maWcgUEhZX1RFR1JBMTk0X1AyVQo+wqDCoMKgwqDCoMKgIHRyaXN0
YXRlICJOVklESUEgVGVncmExOTQgUElQRTJVUEhZIFBIWSBkcml2ZXIiCj4gLcKgwqDCoMKgIGRl
cGVuZHMgb24gQVJDSF9URUdSQV8xOTRfU09DIHx8IEFSQ0hfVEVHUkFfMjM0X1NPQyB8fCBDT01Q
SUxFX1RFU1QKPiArwqDCoMKgwqAgZGVwZW5kcyBvbiBBUkNIX1RFR1JBIHx8IENPTVBJTEVfVEVT
VAo+wqDCoMKgwqDCoMKgIHNlbGVjdCBHRU5FUklDX1BIWQo+wqDCoMKgwqDCoMKgIGhlbHAKPsKg
wqDCoMKgwqDCoMKgwqAgRW5hYmxlIHRoaXMgdG8gc3VwcG9ydCB0aGUgUDJVIChQSVBFIHRvIFVQ
SFkpIHRoYXQgaXMgcGFydCBvZiBUZWdyYSAxOXgKPiAtLQo+IDIuMjUuMQo+CgotLQrgrq7grqPg
rr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+N

