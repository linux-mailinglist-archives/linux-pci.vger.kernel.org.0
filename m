Return-Path: <linux-pci+bounces-7730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 389CB8CB509
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 23:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B77E1C2103D
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4247B146A97;
	Tue, 21 May 2024 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="trGxadL+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BDD50276;
	Tue, 21 May 2024 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325464; cv=fail; b=VP1ogBEArWiqLZ63kDQ1TnZsWiuGCk5XTFg0sxRqJK5nr/NILwOGCEpFTbEHLt7KbbstqSgjp4VMBQrQHMCwvG2X9wTXJOynEwZK2NzDFZnHEzSbQADXOg5D6EKcBQvgWJ5MTPHQUhMmIil8QCLKWm3TbKmfBauGJN4RYNSM4cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325464; c=relaxed/simple;
	bh=OZkHyFVAlGR92aVye4Hat/KCcFuWDYxGG6Pitz1RSdw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hKqxK0b8dYbJuqAHfwu91AwOQWslafyvMH35uXQkgWk/QGuzGwYC5qDIdIYiwv5ktA+gii5jYUK7ZnSl9pCkAMLEONcZ96f/eiupewblgV4L4Ejk/TRcG0srUUZJ2/AkwHGGFDIrI+jLDLEQQ3daAz2AQ7BATH2+XcP3EKpFots=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=trGxadL+; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3KZ783fwFp8h/v9/wI+5blUhEM/+UbO/HRv9syX84J/NwcYRhcXZc4095WQgsCGX51pgCaCZh0HW0jSfcWfoQ4eDeXJARtk3QoEJJMX+7lRBbbJjsQ+z22kw5tnVpp0Iyskkc6Tcm4fStZkq3dNaWZW5NP6jB7V7sro56X72bWznPe5rgye6Ed/BtYwMPjXi5ksu28mjxPoS6T23VwlJnNsLfSOGWmgAxJALeHz67oH4zTqmv5ktFHZvsAOrVWdDiht+ef0Fm+TSolZ9s94Y+i+EX2S3iNkdNYiDNU0ZZ/cVvrtHCWaumvBv7DLH7Ah56dO8oUjrfJ7SJelpEJ0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZkHyFVAlGR92aVye4Hat/KCcFuWDYxGG6Pitz1RSdw=;
 b=df2feaOzDdPnMu7R+5z7SM2OTfWjMC5wzPM36ELA8ZAdsV6mFXonQPKQ5G+aMg6nYHq5QNEHvJapaSprcoko6ni0bjpi4WdMJVHk0EaZR6ueGEA0MeZ+yvRZE8Lq8p2Ygt+jDRQuWu/bdQiraa3vt6BWCtHMRSGfft7gtLfYDTGm4NFlsGNjZzecDriciAY0fxB+/xVyaDaxbB4NN8da+0BxtGXzid0cw44boIQSfcBiISE6fgZIVGGsymS9Qzj+WwSQqfZtfONIVRWJQ1AEN8c4c1DiaZqTKBvBU4OSiT+3UuBLtcu4KpJVWdw8u0pnj+/hHP71NBGsWqOu8Sk7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZkHyFVAlGR92aVye4Hat/KCcFuWDYxGG6Pitz1RSdw=;
 b=trGxadL+69Nqxr48ld7Gh+XrsN3qn+vStFihZn68h6p/6RFw2l5OM26YWObrhLxZMOmOV1K3hCPtqjJsJ+gKg6SZ79H7w4hA3VrDUDrNDFN2dOiQy3YxU9cG+ma3JOlgDScZ0OzTp4oOmUVvYf8uB6sv3ESDAr2R+iA5d0mI2k0/MZyaEZOnL5O61gX0hptSxHeqSDhtdirED06Ld3GB72XOOREZHXGkc2ZbreTmJwzQ5oEMlTXG/oZxKNB1WT731RaoEdXnwqNG0ZPp3EsTJVBVkhwCy6APWNX70tMLEQGwo4gII6tI0jOkPBJ3AMXt2j5bt6T/tXD+6QLZrBsfkw==
Received: from CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Tue, 21 May
 2024 21:04:18 +0000
Received: from CY5PR12MB6060.namprd12.prod.outlook.com
 ([fe80::cc8c:bd46:c88f:a1d0]) by CY5PR12MB6060.namprd12.prod.outlook.com
 ([fe80::cc8c:bd46:c88f:a1d0%7]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 21:04:18 +0000
From: Vikram Sethi <vsethi@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Aslot
	<os.vaslot@gmail.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>
CC: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	Vikram Sethi <vikramsethi@gmail.com>
Subject: RE: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Thread-Topic: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Thread-Index: AQHaq6U5ct/dCUiEIU6bQKWDlfCL1bGh/WOAgAAo7wA=
Date: Tue, 21 May 2024 21:04:18 +0000
Message-ID:
 <CY5PR12MB60607B123B05AF10568ED5EDBDEA2@CY5PR12MB6060.namprd12.prod.outlook.com>
References: <E1AAAE3F-E059-4C57-BC23-6B436A39430A@gmail.com>
 <664ce3e1a25fe_e8be29431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <664ce3e1a25fe_e8be29431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6060:EE_|CY5PR12MB6036:EE_
x-ms-office365-filtering-correlation-id: 990785f1-9972-4a07-8583-08dc79d9942e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Wm9JSXhQOWloRzJYLzJvWmpEN2J4ZVJ5S2VuTXhjcFY1MUZxVzdNZll2UHlE?=
 =?utf-8?B?OWQwbFNVVzlBMDU3S3BDbE04azBaY1lYaGg1WDNLVGxyRCt1aDFDQ0oyWVpq?=
 =?utf-8?B?a2t0OTVTTkRlNlRrWlhEaE9GSVpvdnJyS0x6ZDFjVFRKME9kODVtNFc1ZlhE?=
 =?utf-8?B?d0ZHVEZBTWUzbWN3SHd6NHFhV1ljb25WMmVrQ1EwQTlUWmJnUmtYUWJyU1pV?=
 =?utf-8?B?R1U5U0dKcUZwdHgvbUFOb3h0VlRNZUFLaEhNOGxXNkdaOFoxUTNkek1yZ2hO?=
 =?utf-8?B?WEpPa01GVXU0YURxcXJzMHFTRmxtM1htYXYzSUNUbk9HelJxczMwWllxNGta?=
 =?utf-8?B?TjJFcVZjbFJ1TUpNN0praWg4QzNWQXlLSXFGL0hBMFBnS0VvckUyTVlVK0hV?=
 =?utf-8?B?RGZCUDRNTnphNXA1Sk5CUFlFdUorZDJyY2ZsVzk2dWhiOG9qOUN6OVBhK2R3?=
 =?utf-8?B?NUdkQWoyRWx2YSs3TkhJZWpicG5CYnR0NjROYlpkNTZtWVlaeG5YV3dPRDhj?=
 =?utf-8?B?emVUYmVBZmpEc0ZPcnp3TUFLSWF0RWk0T2dXaG8zclAweTcvTmlUOEtsNEZV?=
 =?utf-8?B?K2V5Uy8wcmczY0pQcVZpYUlmS2V0cWkxQmNSRUgydmZLZTBWRDM5ejRUVVJz?=
 =?utf-8?B?MS9CYXkrWGYzTVVvaWtGZXQyUUd5R0RNeUlCbUFwcDdRZ3hUUVdydXE0VFZ4?=
 =?utf-8?B?RlhKSXlHNWlGRDBEdUlIN1o2NXBrY0I0NmZFV1U0amhLMTBZcUdUcTB4d0pU?=
 =?utf-8?B?Z3Z1aGZMYUVCcUxzSUZDMlZtaUJMNDhmUllSdDVYV2YvenM3TmxXeU4yengw?=
 =?utf-8?B?UUl4eUpweXFwWkZJVlZVQkRQb1Z2TGsrUHllK0Zyb2xJUG0ya1VmMU5oOFhx?=
 =?utf-8?B?QWdMOWd0UWVUZTBMQndjVE90aFhMNW1FNEZpNWxoWVh6RmErMTg4ZDZFOVcv?=
 =?utf-8?B?cU1SK3pRUTR5RiswdnRhUVRKMWNWMDFBZW0vZHRtK0ZGaFNsRHlZbEgxd2V5?=
 =?utf-8?B?WjlienozNk8rYUdsUG96Y2xtR0RLNnB1UEtBeVhMSklQUTFjOVg0VmVhZTly?=
 =?utf-8?B?S0xkVTIvdURNUlJXWThZNmIwbUIwa0ZmdzNMdFpFd0plMTNqWHRaUWdGdUVM?=
 =?utf-8?B?djVrWE96NFlYS2cwVEFwRWxqVTJpY0w2bGg5NlV6dThsRzd4dWNHcml0ODdt?=
 =?utf-8?B?U25xWjA4dFNKb1R6YVVSbXJxV2NLMlNoYlptQklOajdSUitCdjZORmpGSlVk?=
 =?utf-8?B?VUFGR2JEbUttNkFRV3NQUVp1dWhQcEt6R2xsWC9VL2NMVTBkckxTcmFFaEVw?=
 =?utf-8?B?cXVrQmNMbVdrSXFoR0cwSWRyc0U1WFRiQzFyNWtSb0diMWU4YXIydS9abVVn?=
 =?utf-8?B?bjRNNVZ0eWhEaStRc3dVTkl6YU01Wmd5dWIyZ1BwcHdFUjFlaHVTby9DL0w2?=
 =?utf-8?B?OVhKdkJLcGRSdDFxZWFDNDROUTE4OWhKRGFDRmtvN25odGsyYlArU3BmVUIz?=
 =?utf-8?B?NXNYTjRiM1ZUaE1RUUxLM3Fhem1Wcm93OXpOSWhvbkUvSmRHQm9ZUDMrOVlo?=
 =?utf-8?B?ZXFjQUhaL09OZy8xeUd3VUZORERFNnpnbDJKbHc1TTdRN21qcGRDZmZuenhW?=
 =?utf-8?B?WWhFZHk4OWlDbUFIbEVjK2tNU01RT1ZlQjhUT2pUK20yQThpMC9OWU5ncWxv?=
 =?utf-8?B?c1o0ZHlCblBUQzUwWE83QU5ZYm9GOXRHbFJOT3EvVUVsSDNPMTFoOVk2bjha?=
 =?utf-8?B?LzBvcnRJSS8zR1dXNkgrRjE4RjU3QmxUOVoyR2JndUJOSm56eis2MzVIbjRX?=
 =?utf-8?B?dkV6RHJqY05wSVFQK05tUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6060.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3FkNzRIU3VLN2EyZHBvNGIyeElXYTJZOE11UGtTRDZQZWhEZFRPaHV6QjEx?=
 =?utf-8?B?blN2LzZJV01nc2s2TGREc0RDVXV0bjF1anJvaHdITDJLSk1BVmpHM1Vyc0Yw?=
 =?utf-8?B?RHBha3pZczUzeGJrbzB5bDNXRVBVck9kcG1velkrUG0vMlF2VURpVkVzOUZD?=
 =?utf-8?B?WWpRN095cjlvbnA0QjM0RTJxZ2JXaHQrTlBlZE1KUXNGUVlNdWxzWU1OVnR0?=
 =?utf-8?B?WmUyaWJNbk5zWmF4NVd6dllleWhRYWdKOWxYYzloMlhiWldCNHlyWjhmTzN6?=
 =?utf-8?B?NUFtd0ZNVVJCQWpZdW1mV2d1V2c1UFlTR3J6N2hocVczMDVJRzVTRXpmQTkv?=
 =?utf-8?B?NUhIdDM1REJjT201Yjh3NFR5R3lqeGJEVzN3cFRDQ0tBdmUwQ1J1bkYwL1N6?=
 =?utf-8?B?ektaamxBNHA5SDJYcGM5Q3RHL1VqOXB0bkNkeWhRRWRjSjFmQTNaNWlNTExm?=
 =?utf-8?B?allLYm94NlVLQldPV1ZXYVBWUE1rMUNOLzZnWFNFVFBDY0hPcERzT2lHa094?=
 =?utf-8?B?bDFNdlJVMUZUbElhTzBGck5TMnBtZzBrM1FoUFJDdkg5WUlDMDBCZG16Y1g4?=
 =?utf-8?B?QlpGTHl0Q29NaDg1aWRpSUZBcDNYSXREdDNXM1lSeFJ1K0RaUVpCcWRXeDc3?=
 =?utf-8?B?bVU2ajVHYlBVWGJMbEZGOVFWSlVsaGZuS0JoWXAySjR3a29ucVZ2NXBjeGdW?=
 =?utf-8?B?b1BSS0Jha2R1TmhuQSswaGRRV3BBb2FBeXc2WnpucmRtMnpCUUdHOGgvWm5u?=
 =?utf-8?B?eUhrNkZkWVJiSVNVSS9TYk42UHN6RnNTMWxXL3hDdUJxV0ZrWWVXeXBzZUIr?=
 =?utf-8?B?bVRDaXg2RXV3TW9xRk9odVFiaDArMXJvUUdKbmpVNndCYXhYSVJXMUFnZWxy?=
 =?utf-8?B?SklhNXZlN0VLdmdjNWVTeVlHcmJGck94Z1ZUTlZoUHBDclhqVVpLa3NSendL?=
 =?utf-8?B?L2lvNEtBRDY5SlBoVU1HMk9xQTVrTFFJMkpvdk1KblU5VkxzUVR4VVZkRUVP?=
 =?utf-8?B?blZpdnVLS2U5WDZyWDgrUlhZcUM2cVlSRGhHM2RSZWhpMEhGNW5Eb2VPY1A5?=
 =?utf-8?B?VmNRaE1manIxYjV3V2JHMGl4dVpTYldWZVBiNkcxUmE4NFppRk9IS2sxQ2FQ?=
 =?utf-8?B?VkEvRXJHRHVuR1VrM0hodEVxeGcvTmQ5Zm9mby9aQnNZaFMwRkV4aVQ0eG0v?=
 =?utf-8?B?YUZyT3hGbW4vdFZPRDBMWGxtbmYrYVhCaVpCM2YrTk5mL2pWMlhCU0ZBVzZX?=
 =?utf-8?B?ZGhtbUdWVlR6MEd0cElnZFN1UjREa2xGUWZEdmU4di8rajQ4ZWRzQTI2NnMr?=
 =?utf-8?B?a3Jnb1NkRDNsNXVpVEo5OGxOdkNsV0MwZmNJR01wLys4TXVxaER1OXJTNlpm?=
 =?utf-8?B?Y1NkODhTOGprdExDQXNKRC9kcy9NcjIvNy9kaW5YVVRwbmpEbzFMaUhETnJO?=
 =?utf-8?B?bUhnQ3Z3OVhjZU9Vam1rR3BaWm5STGhlSi8xQVc4RmJYYnU5a0FmakQ5RHd1?=
 =?utf-8?B?TUF0SmN2WXdxNkduTWZzTE9xcDROSVJmZFh4ZmVVU0dDdHZKRkd4bkpTb3lQ?=
 =?utf-8?B?VCtaOUk2ZVJ0M3hrbkdZUFN0ajdsYTlKV0EzcGR3YUdqbEExUDJ5U3J1WUYr?=
 =?utf-8?B?VzIzNnlwTzgwM1NaWWltYS9uR1kwOWRSR0g5Y0FzaUlKQzduZEpKeDJOQ1lL?=
 =?utf-8?B?Q2xpVVVNV3RXK3BvMUZia01QcHU4aXV0dEExRTVXRzk5WFVoQVRkendNN1dN?=
 =?utf-8?B?WUY4SDcxWG1QNTFPLzNydURKYkJsSnFWN1U3YUxJSHZ3TTZxN3ZqMmhrWXYr?=
 =?utf-8?B?NVpsWlRlSmVmdmhSa291d3hwZmJGa1lZT2xsTXduUVFvZ015R0ZaY1JwdHJn?=
 =?utf-8?B?QWdlTDQvMW5MeTVaRS82TklVcFZnbTU3N1Eyb3FPeThRLzN1aFlaS0lqSm1Y?=
 =?utf-8?B?N2tFTFgrS2lsa0dtRmdnRHJmWlhDVjJLQU5IWVhUQzNGMEdPeVIyQkIrbjhF?=
 =?utf-8?B?YVZlTVlQMFVmSk56cURvdW5Wak9JbTRwZFZnU2l1ZncyNUJtdWIyOENQenpL?=
 =?utf-8?B?QXlVSmttTGJYVHhEUVhSNmZGS3BBV3l3NThNV1lwN2pSRjdkb3lSbitjcXBC?=
 =?utf-8?Q?aCqeEmQpMyalWoQKxYF/HOFap?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6060.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990785f1-9972-4a07-8583-08dc79d9942e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 21:04:18.0388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7/JUfav2KlxP/wjTL0Re/ieI81CQL8UPCOrOJiSEUPaTNVdby2vshX3AL0yJqcs05doj36DjrG8SBIuE6ALDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036

SGkgRGFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbiBXaWxs
aWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjEs
IDIwMjQgMToxMiBQTQ0KPiBUbzogVmlzaGFsIEFzbG90IDxvcy52YXNsb3RAZ21haWwuY29tPjsg
ZGF2ZS5qaWFuZ0BpbnRlbC5jb20NCj4gQ2M6IEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbTsg
YWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbTsgZGF2ZUBzdGdvbGFicy5uZXQ7DQo+IGlyYS53ZWlueUBpbnRl
bC5jb207IGxpbnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGx1a2FzQHd1bm5lci5kZTsgdmlzaGFsLmwudmVybWFAaW50ZWwuY29tOyBWaWtyYW0g
U2V0aGkNCj4gPHZpa3JhbXNldGhpQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAyLzNdIFBDSTogQ3JlYXRlIG5ldyByZXNldCBtZXRob2QgdG8gZm9yY2UgU0JSIGZvciBDWEwN
Cj4gDQo+IA0KPiANCj4gVmlzaGFsIEFzbG90IHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4gRm9y
IFQyIGFuZCBUMyBwZXJzaXN0ZW50IG1lbW9yeSBkZXZpY2VzLCB3b3VsZG7igJl0IHdlIGFsc28g
bmVlZCBhIHdheQ0KPiA+IHRvIHRyaWdnZXIgZGV2aWNlIGNhY2hlIGZsdXNoIGFuZCB0aGVuIGRp
c2FibGUgb3V0IG9mDQo+ID4gY3hsX3JlZXN0X2J1c19mdW5jdGlvbigpPw0KPiA+DQo+ID4gQ1hM
IFNwZWMgMy4xIChBdWcg4oCZMjMpLCBTZWN0aW9uIDkuMyB3aGljaCByZWZlcnMgdG8gc3lzdGVt
IHJlc2V0IGZsb3cNCj4gPiBoYXMgUkVTRVRQUkVQIFZETXMgdG8gdHJpZ2dlciBkZXZpY2UgY2Fj
aGUgZmx1c2gsIHB1dCBtZW1vcnkgaW4gc2FmZQ0KPiA+IHN0YXRlLCBldGMuIFRoZXNlIGRldmlj
ZXMgd291bGQgYmVuZWZpdCBmcm9tIHRoaXMgaW4gY2FzZSBvZiBTQlIgYXMNCj4gPiB3ZWxsLCBi
dXQgaXQgaXMgcm9vdCBwb3J0IHNwZWNpZmljIHNvIG1heSBiZSBhbiBBQ1BJIG1ldGhvZCBjb3Vs
ZCBiZQ0KPiA+IGludm9sdmVkIG91dCBvZiBjeGxfcmVzZXRfYnVzX2Z1bmN0aW9uKCk/DQo+IA0K
PiBJbiBzaG9ydCwgbm8sIE9TIGluaXRpYXRlZCBkZXZpY2UtY2FjaGUtZmx1c2ggaXMgbm90IGlu
ZGljYXRlZCwgbm9yIHBvc3NpYmxlIChHUEYNCj4gaGFzIG5vIG1lY2hhbmlzbSBmb3Igc3lzdGVt
LXNvZnR3YXJlIHRyaWdnZXIpIGZvciB0aGlzIGNhc2UuDQo+IA0KPiBTcGVjaWZpY2FsbHkgdGhh
dCBzZWN0aW9uIHN0YXRlczoNCj4gDQo+ICIuLi5pdCBpcyBleHBlY3RlZCB0aGF0IHRoZSBDWEwg
ZGV2aWNlcyBhcmUgYWxyZWFkeSBpbiBhbiBJbmFjdGl2ZSBTdGF0ZSB3aXRoIHRoZWlyDQo+IGNv
bnRleHRzIGZsdXNoZWQgdG8gdGhlIHN5c3RlbSBtZW1vcnkgb3IgQ1hMLWF0dGFjaGVkIG1lbW9y
eSBiZWZvcmUgdGhlDQo+IHBsYXRmb3JtIHJlc2V0IGZsb3cgaXMgdHJpZ2dlcmVkIg0KPiANCj4g
Li4uc28gaWYgcmVzZXQgaXMgdHJpZ2dlcmVkIHdoaWxlIHRoZSBkZXZpY2UgaXMgbWFwcGVkIGFu
ZCBhY3RpdmUgdGhlbiB0aGUNCj4gYWRtaW5pc3RyYXRvciBnZXRzIHRvIGtlZXAgYWxsIHRoZSBw
aWVjZXMuIFRoaXMgU0JSIGVuYWJsaW5nIGlzIGFsbCBhYm91dCBtYWtpbmcNCj4gc3VyZSB0aGUg
a2VybmVsIGxvZyByZWZsZWN0cyB3aGVuIHRoZSBhZG1pbmlzdHJhdG9yIG1lc3NlZCB1cCBhbmQg
dHJpZ2dlcmVkDQo+IHJlc2V0IHdoaWxlIHRoZSBkZXZpY2UgaGFkIGFjdGl2ZSBkZWNvZGVycy4N
Cg0KRm9yIGEgLmNhY2hlIGNhcGFibGUgZGV2aWNlLCBzaG91bGRuJ3QgdGhlIGtlcm5lbCBiZSB3
cml0aW5nIHRvIHRoZSBkZXZpY2UgQ1hMIENvbnRyb2wyIHJlZ2lzdGVyICIgSW5pdGlhdGUgY2Fj
aGUgd3JpdGViYWNrIGFuZCBJbnZhbGlkYXRpb24iLCBhcyBwYXJ0IG9mIHRoZSAiT1Mgb3JjaGVz
dHJhdGVkIHJlc2V0IGZsb3ciPw0KVW5saWtlIENYTCByZXNldCwgdGhlIGxpbmsgaXMgZ29pbmcg
ZG93biBpbiBTQlIgY2FzZSwgc28gdGhlIGRldmljZSBoYXMgbm8gY2hhbmNlIG9mIGRvaW5nIHRo
ZSB3cml0ZWJhY2sgb2YgZGlydHkgc3lzdGVtIG1lbW9yeSBsaW5lcyBpdCBob2xkcy4gSGVuY2Ug
T1MgbXVzdCBkbyBpdCBwcmlvciB0byB0aGUgU0JSIGlzc3VhbmNlLiANCk9yIGlzIHRoZSBhc3N1
bXB0aW9uIHRoYXQgdGhlIG9ubHkgJ3N1cHBvcnRlZCcvd29ya2FibGUgU0JSIGZvciBzdWNoIGEg
ZGV2aWNlIHdvdWxkIGluY2x1ZGUgcHJldmlvdXNseSBvZmZsaW5pbmcgaXRzIG1lbW9yeSBhbmQg
dW5sb2FkaW5nIGl0cyBkcml2ZXIsIGFuZCBwYXJ0IG9mIHRoYXQgc3RlcCB3b3VsZCBiZSBkcml2
ZXIgY29kZSBkb2luZyB0aGUgZGV2aWNlIGNhY2hlIFdCK2ludmFsaWRhdGU/DQoNCkkgdGhpbmsg
dGhhdCBhZGRpdGlvbmFsbHksIGtlcm5lbCBzaG91bGQgYWxzbyBiZSBkb2luZyBhIGhvc3QgY2Fj
aGUgZmx1c2ggaGVyZSB0byBXQitpbnZhbGlkYXRlIGRpcnR5IERldmljZSBvd25lZC9ob21lZCBs
aW5lcyBjYWNoZWQgaW4gdGhlIGhvc3QgQ1BVLCB0byBoYW5kbGUgdGhlIHByZXZpb3VzbHkgZGlz
Y3Vzc2VkIHNjZW5hcmlvIG9mIGRldmljZSBzbm9vcCBmaWx0ZXIgYmVpbmcgcmVzZXQgYXMgcGFy
dCBvZiByZXNldCwgYnV0IG5vdCBleHBlY3RpbmcgZnV0dXJlIFdCcyBmcm9tIGhvc3QsIGFuZCBy
YWlzaW5nIGVycm9ycyBpZiB0aGF0IHdlcmUgdG8gaGFwcGVuLg0KDQpUaGFua3MsDQpWaWtyYW0g
DQo=

