Return-Path: <linux-pci+bounces-16638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A419C6F12
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 13:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288FBB2896D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6992C1FF5FE;
	Wed, 13 Nov 2024 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="MjAw8Nfa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DB1FF046;
	Wed, 13 Nov 2024 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500744; cv=fail; b=d8sz7OrGeVjfZtHmxA5pDidD9BtHDtJBmFpoo1Vpal/6x3XUWFOEdvkFBlQqUy2xuL1/mZYkqtEfgr3nnkvWI3guBLj9M/TYtHalnyGgnioqrx/+kbC787emoqGeCSZ3YODHC79M2EoxHd8xxlB1uIGNQpNxUXHEUeJboIHzU8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500744; c=relaxed/simple;
	bh=CuehIiL3ExnVcoe99rZ8PxR5V9EMgi3k9F9layUp02U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CLaW27yQ8jk6Ed3eXZWzhczgi9y2OIBBWBzUvhtrTiqM/X6W8BeghVEJzyGmc6LQBNBF0TJOKUv3MiUX72U76moLlZuNcySoGEVbSiurR2R/WDAKkMfsbI/25djADF0tg49LYqfbCGRmc2rJV4QHAWP0eBcjxOw/e3/6n+oUWfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=MjAw8Nfa; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD6XPjP016867;
	Wed, 13 Nov 2024 04:20:26 -0800
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42vpxp0k38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 04:20:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtG47vgJSdPyfe0Rx3BAnbZHz/IOe/HSTcU+SkWvQEZj4mZamkJXUJhacuztz1mUibt6+w+GtYJhkYwSenfaxaoLmQerVwwiKt1uY1/fKkDUQuSGmH1Jf2vwlhK3ERTBS4IXzAOd8f8o0K7Co63Fuxj3hd8adBcNHZJ87trQe70kmUCVKqxZEX8/ftXz5sKES6RyVBcYjI61t6kYbeUGjc10Gm4Sdke9ZAaxlyZ3bpu5MdIe4GcMjzrDRjpIzV/dKhJVu57ITRRS0yneB3D3s8C1JDxMLknVheuut3Z3Hp7z9h6SMgKEJqmuvEZy3e0yCLWbNGa4SD+XgpLendLJQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuehIiL3ExnVcoe99rZ8PxR5V9EMgi3k9F9layUp02U=;
 b=S3zmcal6p1HQX5UMtLYT10043IBbs50+fV8EUhIXQOU70ftAhapeI/nhOkFcHOFET3tH8WMiu0S1w30jMFxK88ufA2vJ8WIT9vQTMtVRZFkvKw5tBDYtdN2eBWRSst5Ejl3h7kDexrT1qh+7YYd1+ArCNBsYcl2cineNX9h3j/6MiHK1uexIQOCfwFguIJ3P472ayNRoSdCgzuc9jtmX04WUbLywy0mA7X6cCVwQP35CXlrkmv1KYsEP9lLC1Oo1LxsRKQOLdPeNkArJWUWpKwTvWliGgFVnwh+2oX95pdSLo2YfyhLZ+ORc0rSGAxYq70DEY5X6Z1OfZx09/mJKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuehIiL3ExnVcoe99rZ8PxR5V9EMgi3k9F9layUp02U=;
 b=MjAw8NfaUBFqK+WTmyoW6C6+caigxQSWz9l82kIy9mevqnaL6+NO9bsQIeNBGhTkwunbBSbA0fdOEobqCSQEDMhn8RZjODljm2MkDE2DfaFFVlHwO2IMQk0+Aq00PPrNJDRfRZBNiY1ptSVg62SMSkWo3wCXmxF1gS7pALw9k6g=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by SA1PR18MB5741.namprd18.prod.outlook.com (2603:10b6:806:3a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Wed, 13 Nov
 2024 12:20:21 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%5]) with mapi id 15.20.8137.030; Wed, 13 Nov 2024
 12:20:20 +0000
From: Shijith Thotton <sthotton@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rafael@kernel.org"
	<rafael@kernel.org>,
        "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>,
        Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        Vamsi Krishna Attunuru <vattunuru@marvell.com>
Subject: Re: [PATCH v4] PCI: hotplug: Add OCTEON PCI hotplug controller driver
Thread-Topic: [PATCH v4] PCI: hotplug: Add OCTEON PCI hotplug controller
 driver
Thread-Index: AQHbNcZoZhaUGHlsrEe4/IfLGFiGww==
Date: Wed, 13 Nov 2024 12:20:20 +0000
Message-ID:
 <PH0PR18MB4425C1F63EAFFA2AA3BFCBF2D95A2@PH0PR18MB4425.namprd18.prod.outlook.com>
References:
 <PH0PR18MB4425F2F17BA6CC582638F9D7D9592@PH0PR18MB4425.namprd18.prod.outlook.com>
 <20241112160833.GA1845767@bhelgaas>
In-Reply-To: <20241112160833.GA1845767@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|SA1PR18MB5741:EE_
x-ms-office365-filtering-correlation-id: fee90463-e6bc-4051-46e0-08dd03dd8ae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTR4c0FDa0NpYWhhaCs0Ni9SRVlnTU9YcUgrSTdVdmQ2MkptY3ZOUzFaRzNB?=
 =?utf-8?B?WmdHM2tMUThmY3JQOWtZemVWNmFhQmErZ3gyam4rcTFuWW5pK0dCc25yM0dW?=
 =?utf-8?B?TEhmYStyb0pBeVAyS0U2ZDE4WU9YMTAwYldtQmx2QTZQQ24rOWdDTHUrMEFl?=
 =?utf-8?B?eHJCemVTV283eWo1ZUdDWk1NMjFZVGt2NEVpKzV1R3hHN3BOUDN5Wnd1dG1o?=
 =?utf-8?B?SDM3RURxbWlxSHAvSnRZMG5MMStJZkZrOGl2UjhxaGhqNWpTMjcveFV6Nkwy?=
 =?utf-8?B?WjYvcTVmbWhHc0poemtyNXZ3cHRxNWt3YklwR3IxUGxMa0gvOXVaUDgxeW5m?=
 =?utf-8?B?MG8zOHB6bDgrdDQ4bzBVdjhKNzQxZGZiQnViU0hQOXFLYW9lUkphVHo0Qito?=
 =?utf-8?B?Y2pLL3lpNU40L2dLYjgzZDNHbmp4eHVhNm56bEZwWWhjaXBsZU53UFFacFlR?=
 =?utf-8?B?QmRDcnBIWnRRN0UzK0pEZUQ1SU9TcHEzcENQdlZjT0R1YWttb3dPcy9nNTBH?=
 =?utf-8?B?RjBuajVyUThuU1VRSXFWWjc0Tkp1WTVpckdGWGVzTVhYcWp4dldzMmMyQ2Nq?=
 =?utf-8?B?eGRMZm1IYTd4WFJFNU9wUkJOMVJmQmpwNlc0QVMrNjB3SGNPNHFxTW9mdW94?=
 =?utf-8?B?bHlBMUlEZFJTUk9nYmdjVmgvdm90bnJqc3hQMlZCN2dWTnkrdFNnRUFLd3N2?=
 =?utf-8?B?RkxYYld1RFVtQnlZWWJ3TTYxaUo2elJZWlh0S2lWWmlNd0J5TEpJYmpyT3ZJ?=
 =?utf-8?B?cExSWnFJRUFjTkRhWGo2eG9lZjVNOWJZUEpYRmRwY05PZ1YxcncrbkY2Z0VK?=
 =?utf-8?B?YURONklQaW90ZklTRWMrVDZlRHBQOE5pVmpoK094STg3UEpISGVibjNEUWt5?=
 =?utf-8?B?Tzg1V3lSVGlxN2NaUTVQVnFZL0V0Y0xMREZBZVo2QXR3OEM1YUVIam50SU1L?=
 =?utf-8?B?YmtZUjZWYm5XRytEcTl2N2I4VjlDc01DMzBub0pUY1N2NktYS0dVNHVnWnBU?=
 =?utf-8?B?Nzc2SlVLdDFBUllYUGc4WXRFRG9NTDZoMzZRSFZEM0hneHk3ZmVicUxpdnpY?=
 =?utf-8?B?UDZMUlVCR2tTNUZjREROZkdTQ2ozcDJKeHhiMkhub0Q4UlRMRytJR2UrVm9s?=
 =?utf-8?B?V3VMcFhVbHhHM0Q1WFR6cXZjTFlqdTlCSFVVdmw0UEhtTjZmQ0VlVmJINnUv?=
 =?utf-8?B?OUV4Y0FaN0tESUtDNGd2NzNUTDRjZEYzQ3VrZkUvWE0waDdQb1hvOUQ1RUhM?=
 =?utf-8?B?eS9ydndCT2UyTDVBR3ZUa2ZCS2s4NWoxUElMcE1qUmVNVnJUSlhsbkJiQTdQ?=
 =?utf-8?B?akY0cWVaeW1QUjQ2RW4xYzZNNlkvV0ViUjNJWnMxQlU4UC9hOEdxOWoyMkF3?=
 =?utf-8?B?TFFqZ2VFVHM5QnN6ck5sdnVHTklhS1JFV0djd3hyQkVORGhETW9iWXpmK0I4?=
 =?utf-8?B?MHhCdTFQMjY0bTRWMEJpUE02MkI3MjV6MU13TjAvaWgxR1I5MkpLLzg4Q3M4?=
 =?utf-8?B?Z0tCM25VV1lncGxJNmVjODQxMXBVaDNLUk1vTE5HSGNld01VR3VzMlkzUTJj?=
 =?utf-8?B?UFVYNkNlZUVoajk0N1F2NlhCL1Jqb24wYmZtQmpoeXRTTEJPMlFiWUZ2dDd1?=
 =?utf-8?B?WHFLOTBkNXJrTjhlM1IycE9rdWNpVUp0bFhUV0x5dEE0dG9CdFc4RFRBZjdG?=
 =?utf-8?B?ZXNzMFU5NC9RcHFPSFRORzRBVVJWOTRwL1FZdlhLcWZXRDZXeFlkM1V5dFdv?=
 =?utf-8?B?Yjd1cEpoaGtsaWErVjdKZWc5ckNXa0NLUXpNUXFDRC9IaGFwMzgrczB5b202?=
 =?utf-8?Q?ULC8OZGwv/Usw914ijHPlhNlf2kEEIo+wFU9I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFdqbXZXZjRKbVFhN21HSGc1VFRja3JjNC9icDU1S1J2VjQ0NFhhbURKTFNZ?=
 =?utf-8?B?elNHNm4wQnk5SXJtV3VIeXg5Vmd6NmlGZXhtNHRudDVLVDFWaUhCU0dVNmNH?=
 =?utf-8?B?VTN5VUJ2K1hBMWhSTXlhK1hIL2tXQnRuckg2akIrQ1ZxdUJ0elZxbGtPR2g5?=
 =?utf-8?B?d1U3cFRBeXpQRkpDN2g4WWJSK3dXUXRQWmJZZ2xlS2pvOVgvejFoRVhIeDVu?=
 =?utf-8?B?ZGxFejVmNWE4aW5lY0w0T0h5cXdNckVZSWp5Z2MwbVA1ZmQvTzl0YWJkU1pM?=
 =?utf-8?B?K2dnTUM3UHk5ZFlucGZBL0FrUHlSN1l2UFN2VllFVHlDaS8vdm9uc3BXVXpB?=
 =?utf-8?B?OHpWK0JTWEZTREc4T0hITTljWWVvandQV0dwMjF0QjNYR0kxVVJCU3RSSzdu?=
 =?utf-8?B?UW5EOHphQnNPMnJHQ0V5SUtBM0lIbE9OdTJXTk9qc3RNWVg2Ulo1cnJhcW1r?=
 =?utf-8?B?NWVFMlFzSDl5Q0tZaWJDV25STnBDczhHMWZzZ3U4NERGaE01ZVFwYmRRUURV?=
 =?utf-8?B?WHhHVHhGMFFudDFITVhVZ0cwWGlTMXA5aENVaGxiREg4YXZVeGF5dmVjOFI3?=
 =?utf-8?B?WTY0RWgvdFBWWEdsMVJTSXZBNGFMNnN3bHZEcW1mSXBOblNzZDR1WWZBdEVy?=
 =?utf-8?B?Yk92U3NZYi9BOHRVc2dTM0kwV1d0NEVKN2xZN2VydUp3VEtwQ0RNN3NjK0l1?=
 =?utf-8?B?ZG5XK0lscW9YSE1wc3Rjek1tSjJyZGs2MytOd2NRUE5RanhUOEwrOGwvZVVQ?=
 =?utf-8?B?TVpKMHRyWTl0bjR3RUZLUzNWemlHRi9ramtmL0JSSSs2WlFQamlLcWw5RFRV?=
 =?utf-8?B?dmU4eW1NRlRuc1pNa21ZT0tZaXh4bDFJc0d5ZE9UMUU4bU5zbEJmbmtKU3B0?=
 =?utf-8?B?T1k1T3U5YWhzT3FacDFJMUpVcjlTK2kwMnBlc0FRS2NYYU1OMThrZmQ2VnQ5?=
 =?utf-8?B?L2Q0c3BHK0dPWHViYXVzSU1TZlBXcU1yT0podU5za2kyOWI2ZjArV3RGYlBW?=
 =?utf-8?B?YUNvNmFGcFFTQWMzQ0xYaVIxWnpHUlFLOEZpcHZuakJZRk9oc3BVR3F1d3F0?=
 =?utf-8?B?cUFvU0l5d1ljN2ZQWElsWXZabmZXK0pkSHhUUDhOMm5xUzc0K2dHY0dYZFp4?=
 =?utf-8?B?NHhvNElCdVJVR2VkbFFtbnVMVElzYWF3cENFSHB5dEJYNXVPd0Y0UHRVZG9r?=
 =?utf-8?B?cWxCZTdQWFlTdzBXaERKZGtxdEFEWE5lSmY3N2ZvUTRUY1g1UjUxWDNVMjAr?=
 =?utf-8?B?NVhpVmlrdE5iampidWdZSmdKTEJTcGJmbkRWZXhnVzB5TlRYZ2tiN1dQSlNw?=
 =?utf-8?B?N0h2azlUa2hmRzhHMXBFbWtrMWdmVkNKM00yWVY5YjhkRElMRmR2bk94NG91?=
 =?utf-8?B?NDdqSzk1dWJhNWNOYlN0c2NvZlJ1aW9YVUl1WGNSSExpNjJ2UEVyL2l4U1hE?=
 =?utf-8?B?NTRBdUZxc3d1VHQ2UkZ0VkFXS3ExSWRJUTJna09EU1hRRURSdmlRVHdWUVFs?=
 =?utf-8?B?bEFzcWJ5c0NneXdlYVV6K2FsMGMvZWhLdDk1ZU91MXJtRGlwclEvRTFWemFY?=
 =?utf-8?B?QWM5MkMvb3VGdCs3UjhvWEZvV0ZjM1NxNEFpT2pSYU1ocmp5NWVJNUNFMmxB?=
 =?utf-8?B?TXluMkZFODUveHdWOGc0ZEpqaWlpTWFVbzRCRnM3a1RqbVRGWUxrWjhENjRw?=
 =?utf-8?B?V3ZLRHN5Z05ab3pnRjRLeXAvMGwwTk44UE5WQXF3WVd6Z0tzZWNLcFVyWHFG?=
 =?utf-8?B?KzdMUTFVMmJsNEl6NWRFbktPU21TaHlIeEg4MFVaUFF4SXhIYysyQloycHpZ?=
 =?utf-8?B?OHdLL3BrblUraitwcS9JbHczdzZHSzh2QzB3MWZ4dVczWENmOUthVk1DT2lj?=
 =?utf-8?B?djhpWU9kVFBnUmdqNlE2V0V5K0RYc1RCcldCWVlzRTBNdXhlbXBvWG9MYkZ1?=
 =?utf-8?B?TUpSdk14WnJSM2V2Wjd0YlQ2eGpjcE5MZVNSdE1ZSzJNVENTNTZ2WUJXMFZT?=
 =?utf-8?B?OGpKUlM4MlJsRVM0dXdmTHErSWRpd2tOT0FYbjdNaERuQm5hZnlUdXFza0cx?=
 =?utf-8?B?VVNDVExNd1FidHVaWWxqWDY2c28zRmQrajYxdy96RHZsZUlzSXg3VjJVdHl2?=
 =?utf-8?Q?krBPZ5tmEhPZ0KWYkbz39BtzU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4425.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee90463-e6bc-4051-46e0-08dd03dd8ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 12:20:20.8744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VYTi0yGqkGMlBeOrk6PO72tutJXBZd5rq9rkGmuWyEFf8NnQA9hNKW/irQRwvZ0Dla4rx3ruuhEwbNWpC27KKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5741
X-Proofpoint-GUID: 9lupDkHggaKUrshFoozKVl9TCDZMB9wA
X-Proofpoint-ORIG-GUID: 9lupDkHggaKUrshFoozKVl9TCDZMB9wA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Pj4gPj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgUENJIGhvdHBsdWcgY29udHJvbGxlciBkcml2
ZXIgZm9yIHRoZSBPQ1RFT04NCj4+ID4+IFBDSWUgZGV2aWNlLiBUaGUgT0NURU9OIFBDSWUgZGV2
aWNlIGlzIGEgbXVsdGktZnVuY3Rpb24gZGV2aWNlIHdoZXJlIHRoZQ0KPj4gPj4gZmlyc3QgZnVu
Y3Rpb24gc2VydmVzIGFzIHRoZSBQQ0kgaG90cGx1ZyBjb250cm9sbGVyLg0KPj4gPj4NCj4+ID4+
ICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+ID4+
ICAgICAgICAgICAgICAgIHwgICAgICAgICAgIFJvb3QgUG9ydCAgICAgICAgICAgIHwNCj4+ID4+
ICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+ID4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+PiA+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBQQ0llDQo+PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fA0KPj4gPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSsNCj4+ID4+IHwgICAgICAgICAgICAgIE9DVEVPTiBQQ0llIE11bHRp
ZnVuY3Rpb24gRGV2aWNlICAgICAgICAgICAgICAgICB8DQo+PiA+PiArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4gPj4g
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgIHwgICAgICAg
ICAgICB8DQo+PiA+PiAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgfCAgICAgICAgICAgIHwNCj4+ID4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0rICArLS0t
LS0tLS0tLS0tLS0tLSsgICstLS0tLSsgICstLS0tLS0tLS0tLS0tLS0tKw0KPj4gPj4gfCAgICAg
IEZ1bmN0aW9uIDAgICAgIHwgIHwgICBGdW5jdGlvbiAxICAgfCAgfCAuLi4gfCAgfCAgIEZ1bmN0
aW9uIDcgICB8DQo+PiA+PiB8IChIb3RwbHVnIGNvbnRyb2xsZXIpfCAgfCAoSG90cGx1ZyBzbG90
KSB8ICB8ICAgICB8ICB8IChIb3RwbHVnIHNsb3QpIHwNCj4+ID4+ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0rICArLS0tLS0tLS0tLS0tLS0tLSsgICstLS0tLSsgICstLS0tLS0tLS0tLS0tLS0tKw0K
Pj4gPj4gICAgICAgICAgICAgIHwNCj4+ID4+ICAgICAgICAgICAgICB8DQo+PiA+PiArLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+ID4+IHwgICBDb250cm9sbGVyIEZpcm13YXJlICAgfA0K
Pj4gPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+PiA+Pg0KPj4gPj4gVGhlIGhvdHBs
dWcgY29udHJvbGxlciBkcml2ZXIgZW5hYmxlcyBob3RwbHVnZ2luZyBvZiBub24tY29udHJvbGxl
cg0KPj4gPj4gZnVuY3Rpb25zIHdpdGhpbiB0aGUgc2FtZSBkZXZpY2UuIER1cmluZyBwcm9iaW5n
LCB0aGUgZHJpdmVyIHJlbW92ZXMNCj4+ID4+IHRoZSBub24tY29udHJvbGxlciBmdW5jdGlvbnMg
YW5kIHJlZ2lzdGVycyB0aGVtIGFzIFBDSSBob3RwbHVnIHNsb3RzLg0KPj4gPj4gVGhlc2Ugc2xv
dHMgYXJlIGFkZGVkIGJhY2sgYnkgdGhlIGRyaXZlciwgb25seSB1cG9uIHJlcXVlc3QgZnJvbSB0
aGUNCj4+ID4+IGRldmljZSBmaXJtd2FyZS4NCj4+ID4+DQo+PiA+PiBUaGUgY29udHJvbGxlciB1
c2VzIE1TSS1YIGludGVycnVwdHMgdG8gbm90aWZ5IHRoZSBob3N0IG9mIGhvdHBsdWcNCj4+ID4+
IGV2ZW50cyBpbml0aWF0ZWQgYnkgdGhlIE9DVEVPTiBmaXJtd2FyZS4gQWRkaXRpb25hbGx5LCB0
aGUgZHJpdmVyDQo+PiA+PiBhbGxvd3MgdXNlcnMgdG8gZW5hYmxlIG9yIGRpc2FibGUgaW5kaXZp
ZHVhbCBmdW5jdGlvbnMgdmlhIHN5c2ZzIHNsb3QNCj4+ID4+IGVudHJpZXMsIGFzIHByb3ZpZGVk
IGJ5IHRoZSBQQ0kgaG90cGx1ZyBmcmFtZXdvcmsuDQo+PiA+DQo+PiA+Q2FuIHdlIHNheSBzb21l
dGhpbmcgaGVyZSBhYm91dCB3aGF0IHRoZSBiZW5lZml0IG9mIHRoaXMgZHJpdmVyIGlzPw0KPj4g
PkZvciBleGFtcGxlLCBkb2VzIGl0IHNhdmUgcG93ZXI/DQo+Pg0KPj4gVGhlIGRyaXZlciBlbmFi
bGVzIGhvdHBsdWdnaW5nIG9mIG5vbi1jb250cm9sbGVyIGZ1bmN0aW9ucyB3aXRoaW4gdGhlIGRl
dmljZQ0KPj4gd2l0aG91dCByZXF1aXJpbmcgYSBmdWxseSBpbXBsZW1lbnRlZCBzd2l0Y2gsIHJl
ZHVjaW5nIGJvdGggcG93ZXINCj5jb25zdW1wdGlvbg0KPj4gYW5kIHByb2R1Y3QgY29zdC4NCj4N
Cj5SZWR1Y2VkIHByb2R1Y3QgY29zdCBpcyBtb3RpdmF0aW9uIGZvciB0aGUgaGFyZHdhcmUgZGVz
aWduLCBub3QgZm9yDQo+dGhpcyBob3RwbHVnIGRyaXZlci4NCj4NCj5Zb3UgZGlkbid0IGV4cGxp
Y2l0bHkgc2F5IHRoYXQgd2hlbiBmdW5jdGlvbiAwIGhvdC1yZW1vdmVzIGFub3RoZXINCj5mdW5j
dGlvbiwgaXQgcmVkdWNlcyBvdmVyYWxsIHBvd2VyIGNvbnN1bXB0aW9uLiAgQnV0IEkgYXNzdW1l
IHRoYXQncw0KPnRoZSBjYXNlPw0KPg0KDQpZZXMsIEkgd2lsbCBleHBsYWluIGl0IGluIGRldGFp
bCBiZWxvdw0KDQo+PiA+V2hhdCBjYXVzZXMgdGhlIGZ1bmN0aW9uIDAgZmlybXdhcmUgdG8gcmVx
dWVzdCBhIGhvdC1hZGQgb3INCj4+ID5ob3QtcmVtb3ZhbCBvZiBhbm90aGVyIGZ1bmN0aW9uPw0K
Pj4NCj4+IFRoZSBmaXJtd2FyZSB3aWxsIGVuYWJsZSB0aGUgcmVxdWlyZWQgbnVtYmVyIG9mIG5v
bi1jb250cm9sbGVyDQo+PiBmdW5jdGlvbnMgYmFzZWQgb24gcnVudGltZSBkZW1hbmQsIGFsbG93
aW5nIGNvbnRyb2wgb3ZlciB0aGVzZQ0KPj4gZnVuY3Rpb25zLiBGb3IgZXhhbXBsZSwgaW4gYSB2
RFBBIHNjZW5hcmlvLCBlYWNoIGZ1bmN0aW9uIGNvdWxkIGFjdA0KPj4gYXMgYSBkaWZmZXJlbnQg
dHlwZSBvZiBkZXZpY2UgKHN1Y2ggYXMgbmV0LCBjcnlwdG8sIG9yIHN0b3JhZ2UpDQo+PiBkZXBl
bmRpbmcgb24gdGhlIGZpcm13YXJlIGNvbmZpZ3VyYXRpb24uDQo+DQo+V2hhdCBpcyB0aGUgcGF0
aCBmb3IgdGhpcyBydW50aW1lIGRlbWFuZD8gIEkgYXNzdW1lIGZ1bmN0aW9uIDANCj5wcm92aWRl
cyBzb21lIGludGVyZmFjZSB0byByZXF1ZXN0IGEgc3BlY2lmaWMga2luZCBvZiBmdW5jdGlvbmFs
aXR5DQo+KG5ldCwgY3J5cG8sIHN0b3JhZ2UsIGV0Yyk/DQo+DQoNClJpZ2h0IG5vdywgaXQgZG9u
ZSB2aWEgZmlybXdhcmUgbWFuYWdlbWVudCBjb25zb2xlLg0KDQo+SSBkb24ndCBrbm93IGFueXRo
aW5nIGFib3V0IHZEUEEsIHNvIGlmIHRoYXQncyBpbXBvcnRhbnQgaGVyZSwgaXQNCj5uZWVkcyBh
IGxpdHRsZSBtb3JlIGNvbnRleHQuDQo+DQo+PiBIb3QgcmVtb3ZhbCBpcyB1c2VmdWwgaW4gY2Fz
ZXMgb2YgbGl2ZSBmaXJtd2FyZSB1cGRhdGVzLg0KPg0KPlNvIHRoZSBpZGVhIGlzIHRoYXQgZnVu
Y3Rpb24gWCBpcyBob3QtcmVtb3ZlZCwgd2hpY2ggZm9yY2VzIHRoZSBkcml2ZXINCj50byBsZXQg
Z28gb2YgaXQsIHRoZSBmaXJtd2FyZSBpcyB1cGRhdGVkLCBhbmQgWCBpcyBob3QtYWRkZWQgYWdh
aW4sDQo+YW5kIHRoZSBkcml2ZXIgYmluZHMgdG8gaXQgYWdhaW4/DQo+DQoNCkkgd2lsbCBleHBs
YWluIHRoZSBwcm9jZXNzIGluIGRldGFpbCwgd2hpY2ggc2hvdWxkIGFsc28gYWRkcmVzcyB0aGUg
cXVlc3Rpb25zDQpiZWxvdy4NCg0KPkFuZCBzb21ld2hlcmUgaW4gdGhlcmUgaXMgYSByZXNldCBv
ZiBmdW5jdGlvbiBYLCBhbmQgYWZ0ZXIgdGhlIHJlc2V0DQo+WCBpcyBydW5uaW5nIHRoZSBuZXcg
ZmlybXdhcmU/DQo+DQo+V2hvL3doYXQgaW5pdGlhdGVzIHRoaXMgd2hvbGUgcGF0aD8gIFNvbWUg
cmVxdWVzdCB0byBmdW5jdGlvbiAwLA0KPnNheWluZyAicGxlYXNlIHJlbW92ZSBmdW5jdGlvbiBY
Ij8NCj4NCj5CdXQgSSBndWVzcyBtYXliZSBpdCBkb2Vzbid0IGdvIHRocm91Z2ggZnVuY3Rpb24g
MCwgc2luY2Ugb2N0ZW9uX2hwDQo+Y2xhaW1zIGZ1bmN0aW9uIDAsIGFuZCBpdCBkb2Vzbid0IHBy
b3ZpZGUgdGhhdCBmdW5jdGlvbmFsaXR5LiAgTWF5YmUNCj50aGUgaW5kaXZpZHVhbCBkcml2ZXJz
IGZvciAqb3RoZXIqIGZ1bmN0aW9ucyBrbm93IGhvdyB0byBpbml0aWF0ZQ0KPnRoZXNlIHRoaW5n
cywgYW5kIHRob3NlIGZ1bmN0aW9ucyBpbnRlcm5hbGx5IGNvbW11bmljYXRlIHdpdGggZnVuY3Rp
b24NCj4wIHRvIGFzayBpdCB0byBzdGFydCBhIGhvdC1yZW1vdmUvaG90LWFkZCBzZXF1ZW5jZT8N
Cj4NCj5UaGF0IHdvdWxkbid0IGV4cGxhaW4gdGhlIHBvd2VyIHJlZHVjdGlvbiBwbGFuLCB0aG91
Z2guICBBIGRyaXZlciBmb3INCj5mdW5jdGlvbiBYIGNvdWxkIGNvbmNlaXZhYmx5IHRlbGwgaXRz
IGRldmljZSAiSSdtIG5vIGxvbmdlciBuZWVkZWQiDQo+YW5kIGZ1bmN0aW9uIFggY291bGQgdGVs
bCBmdW5jdGlvbiAwIHRvIHJlbW92ZSBpdC4gIFRoYXQgbWlnaHQgZW5hYmxlDQo+c29tZSBwb3dl
ciBzYXZpbmdzLiAgQnV0IHRoYXQgZG9lc24ndCBoYXZlIGEgcGF0aCB0byAqcmUtZW5hYmxlKg0K
PmZ1bmN0aW9uIFgsIHNpbmNlIGZ1bmN0aW9uIFggaGFzIGJlZW4gcmVtb3ZlZCBhbmQgdGhlcmUn
cyBubyBkcml2ZXIgdG8NCj5hc2sgZm9yIGl0IHRvIGJlIGhvdC1hZGRlZCBhZ2Fpbi4NCj4NCj5N
YXliZSB0aGVyZSdzIHNvbWUgb3V0LW9mLWJhbmQgbWFuYWdlbWVudCBwYXRoIHRoYXQgY2FuIHRl
bGwgZnVuY3Rpb24NCj4wIHRvIGRvIHRoaW5ncywgaW5kZXBlbmRlbnQgb2YgUENJZT8NCj4NCg0K
T3VyIGltcGxlbWVudGF0aW9uIGFpbXMgdG8gYWNoaWV2ZSB0d28gbWFpbiBvYmplY3RpdmVzOg0K
DQoxLiBFbmFibGUgY2hhbmdpbmcgYSBmdW5jdGlvbidzIHBlcnNvbmFsaXR5IGF0IHJ1bnRpbWUu
DQoyLiBSZWR1Y2UgcG93ZXIgY29uc3VtcHRpb24uDQoNClRoZSBPQ1RFT04gUENJIGRldmljZSBo
YXMgbXVsdGlwbGUgQVJNIGNvcmVzIHJ1bm5pbmcgTGludXgsIHdpdGggaXRzIGZpcm13YXJlDQpj
b21wb3NlZCBvZiBtdWx0aXBsZSBjb21wb25lbnRzLiBGb3IgZXhhbXBsZSwgdGhlIGZpcm13YXJl
IGluY2x1ZGVzIGNvbXBvbmVudHMNCmxpa2UgVmlydGlvLW5ldCwgTlZNZSwgYW5kIFZpcnRpby1D
cnlwdG8sIHdoaWNoIGNhbiBiZSBhc3NpZ25lZCB0byBhbnkgZnVuY3Rpb24NCmF0IHJ1bnRpbWUu
IFRoZSBkZXZpY2UgZmlybXdhcmUgaXMgYWNjZXNzaWJsZSB2aWEgYSBtYW5hZ2VtZW50IGNvbnNv
bGUsIGFsbG93aW5nDQpjb21wb25lbnRzIHRvIGJlIHN0YXJ0ZWQgb3Igc3RvcHBlZC4gRm9yIGVh
Y2ggY29tcG9uZW50LCBhbiBhc3NvY2lhdGVkIGZ1bmN0aW9uDQppcyBob3QtYWRkZWQgb24gdGhl
IGhvc3QgdG8gZXhwb3NlIGl0cyBmdW5jdGlvbmFsaXR5LiBJbml0aWFsbHksIGFmdGVyIGJvb3Qs
IG9ubHkNCkZ1bmN0aW9uIDAgYW5kIHRoZSBjb250cm9sbGVyIGZpcm13YXJlIGFyZSBhY3RpdmUu
DQoNCkhlcmUncyBhIGJyZWFrZG93bjoNCg0KQXQgVGltZSAwOg0KLSBMaW51eCBib290cyBvbiB0
aGUgZGV2aWNlLCBzdGFydGluZyB0aGUgY29udHJvbGxlciBmaXJtd2FyZS4NCg0KQXQgVGltZSAx
Og0KLSBUaGUgaG90cGx1ZyBkcml2ZXIgbG9hZHMgb24gdGhlIGhvc3QsIHRlbXBvcmFyaWx5IHJl
bW92aW5nIG90aGVyIGZ1bmN0aW9ucy4NCg0KQXQgVGltZSAyOg0KLSBBIG5ldHdvcmsgZGV2aWNl
IGZpcm13YXJlIGNvbXBvbmVudCBzdGFydHMgb24gYW4gQVJNIGNvcmUgKGluaXRpYXRlZCB0aHJv
dWdoDQogIGEgY29uc29sZSBjb21tYW5kKS4NCi0gVGhpcyBjb21wb25lbnQgc2V0cyB1cCB0aGUg
RnVuY3Rpb24gMSBjb25maWd1cmF0aW9uIHNwYWNlLCBkYXRhLCBhbmQgb3RoZXINCiAgcmVxdWVz
dCBoYW5kbGVycyBmb3IgbmV0d29yayBwcm9jZXNzaW5nLg0KLSBUaGUgZmlybXdhcmUgaXNzdWVz
IGEgaG90LWFkZCByZXF1ZXN0IHRvIEZ1bmN0aW9uIDAgKGhvdHBsdWcgZHJpdmVyKSBvbiB0aGUN
CiAgaG9zdCB0byBlbmFibGUgRnVuY3Rpb24gMS4NCg0KQXQgVGltZSAzOg0KLSBUaGUgRnVuY3Rp
b24gMCBob3RwbHVnIGRyaXZlciBvbiB0aGUgaG9zdCByZWNlaXZlcyB0aGUgaG90LWFkZCByZXF1
ZXN0IGFuZA0KICBlbmFibGVzIEZ1bmN0aW9uIDEgb24gdGhlIGhvc3QuDQotIEEgbmV0d29yayBk
cml2ZXIgYmluZHMgdG8gRnVuY3Rpb24gMSBiYXNlZCBvbiBkZXZpY2UgY2xhc3MgYW5kIElELg0K
DQpBdCBUaW1lIDQ6DQotIFRoZSBuZXR3b3JrIGRldmljZSBmaXJtd2FyZSBjb21wb25lbnQgcmVj
ZWl2ZXMgYSBzdG9wIHNpZ25hbC4NCi0gVGhlIGZpcm13YXJlIGlzc3VlcyBhIGhvdC1yZW1vdmUg
cmVxdWVzdCBmb3IgRnVuY3Rpb24gMSBvbiB0aGUgaG9zdC4NCi0gVGhlIGZpcm13YXJlIGNvbXBv
bmVudCBoYWx0cywgcmVkdWNpbmcgdGhlIGRldmljZSdzIHBvd2VyIGNvbnN1bXB0aW9uLg0KDQpB
dCBUaW1lIDU6DQotIFRoZSBGdW5jdGlvbiAwIGhvdHBsdWcgZHJpdmVyIG9uIHRoZSBob3N0IHJl
Y2VpdmVzIHRoZSBob3QtcmVtb3ZlIHJlcXVlc3QgYW5kDQogIGRpc2FibGVzIEZ1bmN0aW9uIDEg
b24gdGhlIGhvc3QuDQoNCkF0IFRpbWUgNjoNCi0gQSBjcnlwdG8gZGV2aWNlIGZpcm13YXJlIGNv
bXBvbmVudCBzdGFydHMgb24gYW4gQVJNIGNvcmUuDQotIFRoaXMgY29tcG9uZW50IGNvbmZpZ3Vy
ZXMgdGhlIEZ1bmN0aW9uIDEgY29uZmlndXJhdGlvbiBzcGFjZSBmb3IgY3J5cHRvDQogIHByb2Nl
c3NpbmcgYW5kIHNldHMgdXAgdGhlIHJlcXVpcmVkIGZpcm13YXJlIGhhbmRsZXJzLg0KLSBUaGUg
ZmlybXdhcmUgaXNzdWVzIGEgaG90LWFkZCByZXF1ZXN0IHRvIGVuYWJsZSBGdW5jdGlvbiAxIG9u
IHRoZSBob3N0Lg0KDQpBdCBUaW1lIDc6DQotIFRoZSBGdW5jdGlvbiAwIGhvdHBsdWcgZHJpdmVy
IG9uIHRoZSBob3N0IHJlY2VpdmVzIHRoZSBob3QtYWRkIHJlcXVlc3QgYW5kICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZW5hYmxlcyBGdW5jdGlvbiAxIG9uIHRoZSBob3N0Lg0KLSBBIGNyeXB0
byBkcml2ZXIgYmluZHMgdG8gRnVuY3Rpb24gMSBiYXNlZCBvbiBkZXZpY2UgY2xhc3MgYW5kIElE
Lg0KDQpUaGUgZmlybXdhcmUgY29tcG9uZW50IGZvciBlYWNoIGZ1bmN0aW9uIG9ubHkgcnVucyBh
bmQgaXMgaG90LWFkZGVkIHdoZW4NCm5lZWRlZC4gT25seSBGdW5jdGlvbiAwIGFuZCB0aGUgY29u
dHJvbGxlciBmaXJtd2FyZSByZW1haW4gYWN0aXZlDQpjb250aW51b3VzbHkuIFRoaXMgZHluYW1p
YyBjb250cm9sIHJlZHVjZXMgcG93ZXIgdXNhZ2UgYnkga2VlcGluZyB1bm5lY2Vzc2FyeQ0KY29t
cG9uZW50cyBvZmYuIEFkZGl0aW9uYWxseSwgYSBzaW5nbGUgZnVuY3Rpb24gY2FuIGFkYXB0IGl0
cyBwZXJzb25hbGl0eSBiYXNlZA0Kb24gdGhlIGFzc29jaWF0ZWQgZmlybXdhcmUgY29tcG9uZW50
LCBlbmhhbmNpbmcgZmxleGliaWxpdHkuIA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIA0KSSBob3BlIHRoaXMgY2xhcmlmaWVzIHRoZSBpbXBsZW1lbnRhdGlvbi4gTGV0
IG1lIGtub3cgaWYgeW91IGhhdmUgYW55DQpxdWVzdGlvbnMuDQoNClRoYW5rcywNClNoaWppdGgN
Cg==

