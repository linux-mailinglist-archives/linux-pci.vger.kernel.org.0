Return-Path: <linux-pci+bounces-20631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22242A24C1A
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 00:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B83916427F
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 23:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC9153BF8;
	Sat,  1 Feb 2025 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="caoF5p3i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803F74068;
	Sat,  1 Feb 2025 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738451188; cv=fail; b=sl6ubVSgp3bs1c/b8PxQhoeK5NneDeeHo81ZwQBA2yzRb4cR9B5foKN7YtAWl70ZHZ7tsR5bx47LzEAVV85jdwBvecvPv/IkcSzYxA/OmswfOEGtA+5E8eHUiiOCo3xeB/78V2+ncI/a46WGsY6LxbKmWkHTvUbh5eAD53ugWnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738451188; c=relaxed/simple;
	bh=Gl3YCRLU6CWg054Ehp9hACM5+83G7Xj6aSjuSHF0zeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WzimAsnF4+h1yP7GX0vVXQvbUxd3bEH5WX4uYGNb9IGO0+NfDjYujVFsB6p1oJAr8AR2ecW2srzQlIjjaIMzmkqbhs2/rRXmHOzmg/fw1ag2tprIXSWP+YR2tkjWTIPdDiFovzArXYYSy/2SjrymS63yQRFeliswW8xPBq2lCTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=caoF5p3i; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 511Mb44o016033;
	Sat, 1 Feb 2025 15:06:00 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44hm0jrfj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 15:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzWQCrhOYBhmWtTrkZJM/rpMcyCBXtIMGfvlpEW7gsu3KRxV4GV3osC1JVEBrjITE37KBYjSktCcdqvPeKDW3kDQ1nzAPauIrxoe7YKSjN5Ubm/fcMu6o2k6NKMw/ajv+n87bGJZdeN8UJ6rJMuwAcaXJhnrZ6hGyeoL8o6ZZQMiWSwa4sezy2kjTBNtePs1szg2ItA8EF0OCy9R1TXvNq871ujyJEfwAi1DLxgKpVqlYtGJnkg34EcssFMT/JH6Ylnp6cWlId0JmfJ4mYuIpUTwlow5RQflql9eIp8j3NmkBDlaciuakxAdl4q2/bNddEEHHspr08NRFovsQJGBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl3YCRLU6CWg054Ehp9hACM5+83G7Xj6aSjuSHF0zeY=;
 b=c97S6/WsRNZA/+TzbKi+BaOYgBuGrljASxGarEthxpJ8QJVj35nSelIwyNFmgzM/cxAOYk/Z3o91/82WUVJr01SVNO9LvpAaMqDFbtlrztaLE6f6Pcx+FZ7FyovJWoYngZW/Bb9hRvyQiPGZEDh7R2hTk7T19X01cCYbUILb1vUHq9fEBaDBcwh67D5ozS0uXuT2FEhJyXFxx/vZh/CZgwQBYVt6M7g+zZndq5irlIpLATKzvFdChlQNJRmbMDlQiY6cbXBXGaNNo7p07eJgwdhdm0yGLhcwLRkKBP6pp0PkeBjSRvluwbjbFNpm/zptfJv+skKvH7C1zDGiF4gn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl3YCRLU6CWg054Ehp9hACM5+83G7Xj6aSjuSHF0zeY=;
 b=caoF5p3iFlpuWMLxf9l4/r4JQHqZYJ2y8lEcomUjIPUVVltqUiMElVCYTg7KJxWve2eGob3cGlbG0XlCgzLVHSvQJ52uNh2comHYJMvrWDcxpm654gwepbaUpWs8+yGf5Gog6kbppr4agGR7aSxxJnymZG5OHkqKRG+pzCuLSTw=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by DM4PR18MB4160.namprd18.prod.outlook.com (2603:10b6:5:38b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Sat, 1 Feb
 2025 23:05:56 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%3]) with mapi id 15.20.8398.020; Sat, 1 Feb 2025
 23:05:56 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas
	<helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com"
	<bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanghoon Lee <salee@marvell.com>
Subject: Re: [PATCH 1/1] PCI: armada8k: Add link-down handle
Thread-Topic: [PATCH 1/1] PCI: armada8k: Add link-down handle
Thread-Index: AQHbdP3ZtQbq+OyfdEOfQPFKLWvdMg==
Date: Sat, 1 Feb 2025 23:05:56 +0000
Message-ID:
 <BY3PR18MB4673207A36B2CD7C3B75EBA0A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20241112213255.GA1861331@bhelgaas>
 <AD287CCE-9FFE-49BC-B9CA-B5CED4F05AF1@linaro.org>
 <BY3PR18MB46737FB5FDBD75CF31B505B8A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
In-Reply-To:
 <BY3PR18MB46737FB5FDBD75CF31B505B8A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|DM4PR18MB4160:EE_
x-ms-office365-filtering-correlation-id: c5ec7f7c-4521-45cd-e795-08dd4314fc2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3BHaU93bjc5eFNYVmJscHBiQkttUzVRN1ZObytaNFo3RDFjNVJaNng4RVcy?=
 =?utf-8?B?L3QwQjhsMWx1M3VKOVBLVTRFVE40UHFHR2Vvb01XQzlKNGdtTFhuWnYra1BL?=
 =?utf-8?B?dTN5dUZnMEZ4TE1xSmxNODRDUENFRDRENHZOcWV5OEpLSTBEYU1wTVpUcmZw?=
 =?utf-8?B?YjIyVk54aUQwRlNBWmRINnA0WGxRYlQ1eTEwNGNvdkNmREJtZjF6bmFKZ1lx?=
 =?utf-8?B?MjRyKzF0WmdPRVdRRklsaUc1ZDZKbGtHTjFMazgwQytWbEtGOHp1M0xIV1hJ?=
 =?utf-8?B?Zk9weXRWVXFGSGFvMExYOHoyOGZ3TUpOYTlUbnh0Q0FoTFpKRmUzM3dLTFY4?=
 =?utf-8?B?bGQ0bk16SEFyMEYyUHpxaHVmQnE5QmtJZFBGSE9rcnlpbFdzQTBKVjBScXNE?=
 =?utf-8?B?T2xhbCt6L21Fdndsa055bzU2M2ZoMU1KbzZxYTRQWXNTNFNiR2dDaGJVaTVO?=
 =?utf-8?B?cVpzb0xvbklSTFlNa3Avb1dnSXZ4SzN1ZVNSTFBZTTk4YUhSWjlJVEVwamNS?=
 =?utf-8?B?enlneStmNXA5YkpxdHpOdDBxbzE1UU4zUjVxMzRCQVZlbG1ZbTlnNU9za2NZ?=
 =?utf-8?B?eEZ2cjNLSUllWVFkUkdzdk1jNjFxMUxYejFrYjJ2QVNtUGFCQnZpQlJLMDAy?=
 =?utf-8?B?RytpdTllTUpCWkVib1drdXE2K3pDSE5GdjkxalhCSlQ1bStJL1JZUkE5OXVY?=
 =?utf-8?B?bVBQbTZmWkZZVmorbGhWZDlFeWFxeFY2alJkRHdTVWtHV00zampOVStIelZB?=
 =?utf-8?B?M3V1MXFhV3JUU2I2N2hGakh3V0ZiYWlsc3hWeUs0VnZEdEFsMllEb084R1RH?=
 =?utf-8?B?M1h5T1ZIbmVHTGdUOXdlRFMvZU1YTlIwNFY3cDBNeDE2TmZXbkMyVGRhZHMx?=
 =?utf-8?B?MitKSU5PbWFWUDRjd3NUS1VXQnJhRlFQMi9oZFJkU1MydC85Wi9uMXV1T09J?=
 =?utf-8?B?amJmQUkvajRQd1kzN0hZY3JYbUU5VG1NV3FzN0JDYklheE5jc1pVZlYyeGZs?=
 =?utf-8?B?Mys3VU5YQ0hWUDl5OXB2NGhscGd6MnJSOEtYdHgrMnRIdlBLUWNUZTZEVGZ0?=
 =?utf-8?B?SDdjZkZGTVB0N1RNOXVtVlIrN3I5VHlTQnlJcWppbzVRem1NcldnNHFuOERX?=
 =?utf-8?B?bzhxaTd3M2QwQms3UW5hYmRoKy9rQUVDUmwwNGpRNGdTVTN3bjhzaFF1cFNj?=
 =?utf-8?B?c3p1NFNkUlNLaFdHNmhoMWhqRURSQW15akg4T2FNcEl3TVNXVnJTSVJtSld3?=
 =?utf-8?B?SnFTMWhaS1lkVysvbVkxazNzeDA4ZENha09FK0RTVk5UL1N1N0dSYnZUek50?=
 =?utf-8?B?NG1qWlJrdzZDNWRUTlFIRU9EaFVseE5Hc0ZyU3lQMHl3OXFia3gvdk5BeTVG?=
 =?utf-8?B?M2pFU1RDdk9HeCs5anI5QzU4ZlVHaTV3UDUxZnkvbFFBWFNDa1ZnNnJqbEtm?=
 =?utf-8?B?MEtnSEhyYm9jN05qWkpmNWx1UG9jdFZ0VWNjMGQ3ZTU2ZFVXekkrN05jdG1N?=
 =?utf-8?B?L0lsRVgyRTVxbjVhNkw1WmhwVG12T2w0QjhCczA1eGlCZEEyTWljVjJGNlhY?=
 =?utf-8?B?NzhIazh6dmc4WkZiQTJwRzdGRUZ0dlZibHFCRXh3M0pFNWNUN3FNdE9mcG5W?=
 =?utf-8?B?ZzVTZURMRS9wdFVhSGlEZk1lQW15N1BIdHFQaGgyMGpGWVdoVnlGVEhmU0FU?=
 =?utf-8?B?MG1MQ3lFTGFMN1I1N2F4cEg4cmxJOWt4N2xXdWJ6eG04bWpFREJsZW1POHI3?=
 =?utf-8?B?dytzQU9IZGNpdWw2R1ZBVHNKUGdLcGFFSkpWaFU3TWFuSWRndURtUEVxeHc2?=
 =?utf-8?B?d0c2T3JvNFNNcTB6YTViWEk5eVNKSUZOVEFKSWNHUDVMWThsMlhiYzZIVHdp?=
 =?utf-8?B?SWNLcVpNTWkvQSs2NUU2cEQxcjFPN2RraGx5d0YzeTM3UU9qak84QmFxQTVG?=
 =?utf-8?Q?yjtUYGiG4sC5A32Fi5YB2qMYdItMqiq0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmtJcUJxZUNIUSsxUWxEWStUT2FJOHUvakRQL21YeVc3bzUweVc1VlozNXVn?=
 =?utf-8?B?d1ZOSGZLSmVvTUc2RlZBcW0wVXh5Q2ExSWlacTMzMStjRjYzd2hySHBVOU5V?=
 =?utf-8?B?QzFBVVFxZlNNMVdKNytXZkhCYWgwQWk5Vll3UUhITDJHc1BFVmRONFJpMUph?=
 =?utf-8?B?TGp0NDhpbXpZTHRYbDNqMkZUTEZ4dXhHMStwSDUvMVE5NlQvMWhMNmVBUzJj?=
 =?utf-8?B?dWRTTDU3VTRWVjF6bVFYcDBUU2JMWGMxaHVzM1drY2ViRnczNFd4RnlvcDQw?=
 =?utf-8?B?VkRBcTlqRzRSbWF6YUtXL2dVVkJrZlRrUnMzeHo1Ym00cmpKNno0WENVa0Y0?=
 =?utf-8?B?ZWhVWml4Y2pNNEh0bW1yL1pPRHRFaFpGRGUzaTk5UzdrUUxYWUxlUEd5M2VL?=
 =?utf-8?B?cmM4MnN6N2dBVmUvVnZteFFnU0FMQTI2TzlrcFlIVHFpc0lxWXBSVGI1WEp1?=
 =?utf-8?B?NWJQU01jeVZiVDlLS0tXV0wwL3dNc2tlNFk3cG84Sm5Wbm03ZVFhYkN1RHd6?=
 =?utf-8?B?Sk02YmQwOEpxOHJrTTRKWjUwNjgyNFNmanR2MXRUSWlrTEVzQ1BqQWFCY2Np?=
 =?utf-8?B?aDdqbXRBMDc3c3NIbDVuVmRRS2RoRkJ6eHM4Ykc0OE1ETVBtcTVPZ2VhWjNC?=
 =?utf-8?B?OGEwcjFlQTMyNm85WmJTeW9UZmxGczIzL0F5VnpKZ0NjaHBRYjZMMll2Q1FY?=
 =?utf-8?B?V2h4eWUxTGh5VTNrYTlCUkFheDVQQTUzQ2tUdEdhejZoN1RQbkYvNnVGSzlr?=
 =?utf-8?B?akpOV0FoN29TVGdDSWhYU29Tbm80alpWZ0xtZHFQcHZOYU84akJYT2ZEQWpG?=
 =?utf-8?B?cm1lZld5dkZDMTExU0oxSStJc3ptQ0dVTTM3ak4rbmZSWXQxSjlFTzBsSnBT?=
 =?utf-8?B?Q1FzWnZHUTM3K3QxWDExQ2R3SFJ3OG84RDRBc2NIcUxDSStlNVN2YlZWVzlF?=
 =?utf-8?B?enBpVmpNd24veEVNNTBjcEJlZjRmeWFkVTRuci9YTXNGbXlZT2VPTkthODBh?=
 =?utf-8?B?R2hsZmhEaWRqZHlGa1hHYWEzbmd4L2Z2NG1kVkxjc2RFZUE3akI2MkVCaDJw?=
 =?utf-8?B?MlR3L0dNNjdKKzNGRlNkbW5DNzl4Q2diYW5UYkJKOFU0b3d2Ym5FV09XSXJE?=
 =?utf-8?B?bG1Yc0hmb1ZnTzZJOWhkS29UZzBMd1pGZ0dtbDE3RjErdldRWVpxd2NEenNk?=
 =?utf-8?B?WWdvQXZCcGIrVXR5MUNjWXVaZ1VnR0liVUhDd204eUNUdlBmdS9FeUdFZkkx?=
 =?utf-8?B?VmdDbzNzTGNBckMrMzRaL2JNcy84OWkwdzlXbHdGZGRVc0dOR25BYlQ0OGhX?=
 =?utf-8?B?QVlYNVBscFB6N0VJT01QYlJEdlNKbjVRb0crcmlFbjZzbTZROC84eW1SeFpM?=
 =?utf-8?B?OTFDbnpjbEIwaHY5WTB5MnJMQWVkT2xCYTZ3NEpGc3dKWmZXL0NaeWs1UWVJ?=
 =?utf-8?B?eFFtaWVSWjdndzhjYkQrQTdaTURERlNJVGVNOXVTRUpaL0E0Sm5YbTZxbjdk?=
 =?utf-8?B?NVhVZ1dXTTNlNTBNSEk5SkZFZ01mRFRlRjljaWViZGdvcUdRY0VUR0tiMTRX?=
 =?utf-8?B?V21QZEt4Skl0b1BBMGtVQytLSnorendwVE11cktULzllUTI4RDJJUCtFYzlI?=
 =?utf-8?B?WEFiM3U4czlESWE5TW1ZcFp3QnZYQUsxRmZ5QmlqeFRzTUllOWZ1VmVuQTcy?=
 =?utf-8?B?TEVUc1d0TUdGYlRrRlZxKys2ZWJ4WGg1cDFtVlV1N1pjQmdjQnUxR3ZiRm9z?=
 =?utf-8?B?T012M1IxWXJJeUJtN1g3clNhWXlRMDd3R0FpNEo1a1RpaUdsUEFzNzl0VkJ5?=
 =?utf-8?B?cHdBR0lKK3c2dERkNjFtbFpHYXcwZnp5Rnc3cW1HVms4ZHIyOXZoRUpURnpr?=
 =?utf-8?B?b2lhRGpWZ3NMTCtNaEJLUTlaMSsxTG1vUE1RWnZRRW1vZFBlNnVVd0U1QjJI?=
 =?utf-8?B?RTk0Y005NklSNDF6aEtCUmdGa0J4ejRmTzA2QVM4YmVvRDZSOHZ2YU0vR0pG?=
 =?utf-8?B?enFFRDVOZmx2STdwZnBwcC93RDBHSktwUFlZeWZlLzJkaG9kbHJMTVl0R3R0?=
 =?utf-8?B?R0dObWFES0NkbkpqaUlySEZUVWp1dVc2c0FLYm5wVmFvNHMyRXpqQUlmVkhO?=
 =?utf-8?Q?Za46UX4/93n3VtD28+ogaGgU1?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ec7f7c-4521-45cd-e795-08dd4314fc2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2025 23:05:56.5445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gq9CoAJEJwwlqUGWthp0g0Rvh8L5ORIWByMSsr6pYwJj7PANeXja2iT9ikZWsz9+x1opZA+YpecCgLZxVaFDvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4160
X-Proofpoint-ORIG-GUID: mYKoN0xlkBNeBE8wg21tpNrc_af2I5xU
X-Proofpoint-GUID: mYKoN0xlkBNeBE8wg21tpNrc_af2I5xU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_09,2025-01-31_02,2024-11-22_01

PiBPbiBOb3ZlbWJlciAxMywgMjAyNCAzOjAyOjU1IEFNIEdNVCswNTozMCwgQmpvcm4gSGVsZ2Fh
cw0KPiA8bWFpbHRvOmhlbGdhYXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID5JbiBzdWJqZWN0Og0K
PiA+DQo+ID4gIFBDSTogYXJtYWRhOGs6IEFkZCBsaW5rLWRvd24gaGFuZGxpbmcNCj4gPg0KPiA+
T24gTW9uLCBOb3YgMTEsIDIwMjQgYXQgMTA6NDg6MTNQTSAtMDgwMCwgSmVuaXNoa3VtYXIgTWFo
ZXNoYmhhaQ0KPiBQYXRlbCB3cm90ZToNCj4gPj4gSW4gUENJRSBJU1Igcm91dGluZSBjYXVzZWQg
YnkgUlNUX0xJTktfRE9XTiB3ZSBzY2hlZHVsZSB3b3JrIHRvDQo+ID4+IGhhbmRsZSB0aGUgbGlu
ay1kb3duIHByb2NlZHVyZS4NCj4gPj4gTGluay1kb3duIHByb2NlZHVyZSB3aWxsOg0KPiA+PiAx
LiBSZW1vdmUgUENJZSBidXMNCj4gPj4gMi4gUmVzZXQgdGhlIE1BQw0KPiA+PiAzLiBSZWNvbmZp
Z3VyZSBsaW5rIGJhY2sgdXANCj4gPj4gNC4gUmVzY2FuIFBDSWUgYnVzDQo+ID4NCj4gPnMvUENJ
RS9QQ0llLw0KPiA+DQo+ID5SZXdyYXAgdG8gZmlsbCA3NSBjb2x1bW5zLg0KPiA+DQo+ID5JIGFz
c3VtZSB0aGlzIGJhc2ljYWxseSByZW1vdmVzIGEgUm9vdCBQb3J0IChhbmQgdGhlIGhpZXJhcmNo
eSBiZWxvdw0KPiA+aXQpIGlmIHRoZSBsaW5rIGdvZXMgZG93biwgYW5kIHRoZW4gcmVzZXRzIHRo
ZSBNQUMgYW5kIHRyaWVzIHRvIGJyaW5nDQo+ID51cCB0aGUgbGluayBhbmQgZW51bWVyYXRlIHRo
ZSBoaWVyYXJjaHkgYWdhaW4uDQo+ID4NCj4gPk5vIG90aGVyIGRyaXZlcnMgZG8gdGhpcywgc28g
d2h5IGRvZXMgYXJtYWRhOGsgbmVlZCBpdD8gIElzIHRoaXMgdG8NCj4gPndvcmsgYXJvdW5kIHNv
bWUgdW5yZWxpYWJsZSBsaW5rPw0KPiANCj4gQ2VydGFpbmx5IFFjb20gSVBzIGhhdmUgdGhpcyBz
YW1lIGZlYXR1cmUgYW5kIEkgd2FzIGFsc28gbG9va2luZyB0byBpbXBsZW1lbnQNCj4gaXQuIEJ1
dCB0aGUgbGluayBkb3duIHNob3VsZCBub3QgYmUgaGFuZGxlZCBieSB0aGlzIGluIHRoZSBjb250
cm9sbGVyIGRyaXZlci4NCj4gDQo+IEluc3RlYWQsIGl0IHNob3VsZCBiZSB0aWVkIHRvIGJ1cyBy
ZXNldCBpbiB0aGUgY29yZSBhbmQgdGhlIHJlc2V0IHNob3VsZCBiZSBkb25lDQo+IHRocm91Z2gg
YSBjYWxsYmFjayBpbXBsZW1lbnRlZCBpbiB0aGUgY29udHJvbGxlciBkcml2ZXJzLiBUaGlzIHdh
eSwgdGhlIHJlc2V0DQo+IGNhbm5vdCBoYXBwZW4gaW4gdGhlIGJhY2sgb2YgUENJIGNvcmUgYW5k
IGNsaWVudCBkcml2ZXJzLg0KPiANCj4gVGhhdCBzYWlkLCB0aGUgTGluayBkb3duIElSUSByZWNl
aXZlZCBieSB0aGlzIGRyaXZlciBzaG91bGQgYWxzbyBiZSBwcm9wYWdhdGVkDQo+IGJhY2sgdG8g
dGhlIFBDSSBjb3JlIGFuZCB0aGUgY29yZSBzaG91bGQgdGhlbiBjYWxsIHRoZSBjYWxsYmFjayB0
byByZXNldCB0aGUgYnVzDQo+IHRoYXQgSSBtZW50aW9uZWQgYWJvdmUuDQo+IA0KDQpJdCdzIG1v
cmUgdGhhbiBhIHdvcmstYXJvdW5kIGZvciB0aGUgdW5yZWxpYWJsZSBsaW5rLiBBIGZldyBjdXN0
b21lcnMgbWF5IGhhdmUNCnN1Y2ggYXBwbGljYXRpb24gLSBpbmRlcGVuZGVudCBwb3dlciBzdXBw
bHkgdG8gdGhlIGRldmljZSB3aXRoIGRlZGljYXRlZCByZXNldA0KR1BJTyB0byAjUFJTVC4gSW4g
dGhpcyB3YXksIHRoZSBwb3dlciBjeWNsZSBhbmQgd2FybSByZXNldCBvZiBSQyBhbmQgRVAgd29u
J3QNCmhhdmUgaW1wYWN0IG9uIGVhY2ggb3RoZXIuIEhvd2V2ZXIsIGl0IG1heSBsZWFkIGludG8g
dGhlIFBDSSBkcml2ZXIgbm90IGF3YXJlDQpvZiB0aGUgbGluayBkb3duIHdoZW4gYW4gdW5leHBl
Y3RlZCBwb3dlciBkb3duIG9yIHJlc2V0IG9jY3VycyBvbiB0aGUgZGV2aWNlLg0KV2UgY2Fubm90
IGFzc3VtZSB0aGUgbGluayB3aWxsIGJlIHJlY292ZXJlZCBzb29uLiBUaGUgd29yc2UgdGhpbmcg
aXMgdGhlIGRyaXZlcg0KbWF5IGNvbnRpbnVlIGFjY2VzcyB0byB0aGUgZGV2aWNlLCB3aGljaCBt
YXkgaGFuZyB0aGUgYnVzLiBTaW5jZSB0aGUgZGV2aWNlDQppcyBubyBsb25nZXIgcHJlc2VudCBv
biB0aGUgYnVzLCBpdCdzIGJldHRlciB0byByZW1vdmUgaXQuIEJlc2lkZXMsIGluIG9yZGVyIHRv
IGJyaW5nDQp1cCB0aGUgbGluaywgdGhlIG9ubHkgd2F5IGlzIHRvIHJlc2V0IHRoZSBNQUMsIHdo
aWNoIHN0YXJ0cyBvdmVyIHRoZSBzdGF0ZSBtYWNoaW5lDQpvZiBMVFNTTS4NCg0KV2VsbCwgd2Ug
YWxzbyBub3RpY2VkIHRoYXQgdGhlcmUgaXMgbm8gb3RoZXIgZHJpdmVyIHRoYXQgZGlkIHRoaXMu
IEkgYWdyZWUgaXQgaXMgbm90DQpuZWNlc3NhcnkgaWYgdGhlIHBvd2VyIGN5Y2xlIG9yIHdhcm0g
cmVzZXQgb2YgdGhlIGRldmljZSBpcyBkb25lIGdyYWNlZnVsbHkuIFRoZQ0KdXNlciBjYW4gcmVt
b3ZlIHRoZSBkZXZpY2UgcHJpb3IgdG8gdGhlIHBvd2VyIGN5Y2xlL3Jlc2V0LiAgQW5kIGRvIHRo
ZSByZXNjYW4NCmFmdGVyIHRoZSBsaW5rIGlzIHJlY292ZXJlZC4gSG93ZXZlciwgdGhlIHVuZXhw
ZWN0ZWQgcG93ZXIgZG93biBpcyBzdGlsbCBwb3NzaWJsZS4NClBsZWFzZSBlbmxpZ2h0ZW4gbWUg
aWYgdGhlcmUgaXMgYW55IGJldHRlciBhcHByb2FjaCB0byBoYW5kbGUgc3VjaCB1bmV4cGVjdGVk
DQpsaW5rIGRvd24uDQoNCkluIHRoZSBtZWFud2hpbGUsIEkgYW0gcXVpdGUgaW50ZXJlc3RlZCB0
aGUgY2FsbGJhY2sgaW1wbGVtZW50YXRpb24gc3VnZ2VzdGVkDQpieSBNYW5pLiBCdXQgSSBhbSBz
dXJlIGlmIHdlIGhhdmUgc3VjaCBpbmZyYXN0cnVjdHVyZSByaWdodCB0aGVyZS4gTWFuaSwgY291
bGQNCnlvdSBwbGVhc2UgZWxhYm9yYXRlIGEgYml0IG1vcmUsIG9yIGlzIHRoZXJlIGFueSBleGFt
cGxlcyBpbiB0aGUgZXhpc3RpbmcgY29kZQ0KYW5kIHBhdGNoZXMuDQoNCj4gPg0KPiA+SSB3b3Vs
ZCB0aGluayB0aGlzIHdvdWxkIGJlIHJlcG9ydGVkIHZpYSBBRVIgYW5kIHBvc3NpYmx5IGhhbmRs
ZWQgdGhlcmUNCj4gPmFscmVhZHksIGJ1dCBhcHBhcmVudGx5IG5vdD8NCj4gDQo+IE5vLCB0aGVz
ZSBhcmUgbm90IHJlcG9ydGVkIHZpYSBBRVIgKGF0bGVhc3Qgb24gUWNvbSBwbGF0Zm9ybXMpLiBX
ZSBoYXZlIGENCj4gZ2xvYmFsX2lycSB0aGF0IGZpcmVzIHdoZW4gTGluayBkb3duIGhhcHBlbnMu
DQo+IA0KPiAtIE1hbmkNCj4gDQoNCk5vLiBBbHRob3VnaCBBRVIgaXMgcmVwb3J0ZWQsIGl0IGlz
IGNvbnNpZGVyIGFzIGEgcmVjb3ZlcmFibGUgZXJyb3Igc29tZWhvdy4NCkxpa2UgUUNPTSBwbGF0
Zm9ybSwgdGhlIGxpbmsgZG93biBpcyBhIGdsb2JhbCBpcnEuIFRoZSBkaWZmZXJlbmNlIGlzIHRo
YXQNCkFybWFkYThrIGRvbid0IGhhdmUgYW4gaXJxIGZvciBsaW5rIHVwLiANCg0KPiA+DQo+ID4+
IFNpZ25lZC1vZmYtYnk6IEplbmlzaGt1bWFyIE1haGVzaGJoYWkgUGF0ZWwNCj4gPj4gPG1haWx0
bzpqcGF0ZWwyQG1hcnZlbGwuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtYXJtYWRhOGsuYyB8IDg0DQo+ID4+ICsrKysrKysrKysrKysrKysrKysr
KysNCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMNCj4g
Pj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMNCj4gPj4gaW5k
ZXggMDc3NzU1MzliMzIxLi5iMWI0OGMyMDE2ZjcgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYXJtYWRhOGsuYw0KPiA+PiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMNCj4gPj4gQEAgLTIxLDYgKzIxLDggQEAN
Cj4gPj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPj4gICNpbmNsdWRl
IDxsaW51eC9yZXNvdXJjZS5oPg0KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L29mX3BjaS5oPg0KPiA+
PiArI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9y
ZWdtYXAuaD4NCj4gPj4NCj4gPj4gICNpbmNsdWRlICJwY2llLWRlc2lnbndhcmUuaCINCj4gPj4N
Cj4gPj4gQEAgLTMyLDYgKzM0LDkgQEAgc3RydWN0IGFybWFkYThrX3BjaWUgew0KPiA+PiAgCXN0
cnVjdCBjbGsgKmNsa19yZWc7DQo+ID4+ICAJc3RydWN0IHBoeSAqcGh5W0FSTUFEQThLX1BDSUVf
TUFYX0xBTkVTXTsNCj4gPj4gIAl1bnNpZ25lZCBpbnQgcGh5X2NvdW50Ow0KPiA+PiArCXN0cnVj
dCByZWdtYXAgKnN5c2N0cmxfYmFzZTsNCj4gPj4gKwl1MzIgbWFjX3Jlc3RfYml0bWFzazsNCj4g
Pj4gKwlzdHJ1Y3Qgd29ya19zdHJ1Y3QgcmVjb3Zlcl9saW5rX3dvcms7DQo+ID4+ICB9Ow0KPiA+
Pg0KPiA+PiAgI2RlZmluZSBQQ0lFX1ZFTkRPUl9SRUdTX09GRlNFVAkJMHg4MDAwDQo+ID4+IEBA
IC03Miw2ICs3Nyw4IEBAIHN0cnVjdCBhcm1hZGE4a19wY2llIHsNCj4gPj4gICNkZWZpbmUgQVhf
VVNFUl9ET01BSU5fTUFTSwkJMHgzDQo+ID4+ICAjZGVmaW5lIEFYX1VTRVJfRE9NQUlOX1NISUZU
CQk0DQo+ID4+DQo+ID4+ICsjZGVmaW5lIFVOSVRfU09GVF9SRVNFVF9DT05GSUdfUkVHCTB4MjY4
DQo+ID4+ICsNCj4gPj4gICNkZWZpbmUgdG9fYXJtYWRhOGtfcGNpZSh4KQlkZXZfZ2V0X2RydmRh
dGEoKHgpLT5kZXYpDQo+ID4+DQo+ID4+ICBzdGF0aWMgdm9pZCBhcm1hZGE4a19wY2llX2Rpc2Fi
bGVfcGh5cyhzdHJ1Y3QgYXJtYWRhOGtfcGNpZSAqcGNpZSkNCj4gPj4gQEAgLTIxNiw2ICsyMjMs
NjUgQEAgc3RhdGljIGludCBhcm1hZGE4a19wY2llX2hvc3RfaW5pdChzdHJ1Y3QNCj4gZHdfcGNp
ZV9ycCAqcHApDQo+ID4+ICAJcmV0dXJuIDA7DQo+ID4+ICB9DQo+ID4+DQo+ID4+ICtzdGF0aWMg
dm9pZCBhcm1hZGE4a19wY2llX3JlY292ZXJfbGluayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndzKSB7
DQo+ID4+ICsJc3RydWN0IGFybWFkYThrX3BjaWUgKnBjaWUgPSBjb250YWluZXJfb2Yod3MsIHN0
cnVjdCBhcm1hZGE4a19wY2llLA0KPiByZWNvdmVyX2xpbmtfd29yayk7DQo+ID4+ICsJc3RydWN0
IGR3X3BjaWVfcnAgKnBwID0gJnBjaWUtPnBjaS0+cHA7DQo+ID4+ICsJc3RydWN0IHBjaV9idXMg
KmJ1cyA9IHBwLT5icmlkZ2UtPmJ1czsNCj4gPj4gKwlzdHJ1Y3QgcGNpX2RldiAqcm9vdF9wb3J0
Ow0KPiA+PiArCWludCByZXQ7DQo+ID4+ICsNCj4gPj4gKwlyb290X3BvcnQgPSBwY2lfZ2V0X3Ns
b3QoYnVzLCAwKTsNCj4gPj4gKwlpZiAoIXJvb3RfcG9ydCkgew0KPiA+PiArCQlkZXZfZXJyKHBj
aWUtPnBjaS0+ZGV2LCAiZmFpbGVkIHRvIGdldCByb290IHBvcnRcbiIpOw0KPiA+PiArCQlyZXR1
cm47DQo+ID4+ICsJfQ0KPiA+PiArCXBjaV9sb2NrX3Jlc2Nhbl9yZW1vdmUoKTsNCj4gPj4gKwlw
Y2lfc3RvcF9hbmRfcmVtb3ZlX2J1c19kZXZpY2Uocm9vdF9wb3J0KTsNCj4gPg0KPiA+QWRkIGJs
YW5rIGxpbmUuDQo+ID4NCj4gPj4gKwkvKg0KPiA+PiArCSAqIFNsZWVwIG5lZWRlZCB0byBtYWtl
IHN1cmUgYWxsIHBjaWUgdHJhbnNhY3Rpb25zIGFuZCBhY2Nlc3MNCj4gPj4gKwkgKiBhcmUgZmx1
c2hlZCBiZWZvcmUgcmVzZXR0aW5nIHRoZSBtYWMNCj4gPj4gKwkgKi8NCj4gPj4gKwltc2xlZXAo
MTAwKTsNCj4gPg0KPiA+cy9wY2llL1BDSWUvDQo+ID5zL21hYy9NQUMvIChhbHNvIGJlbG93KQ0K
PiA+DQo+ID5XaGF0IFBDSWUgc3BlYyBwYXJhbWV0ZXIgaXMgdGhlIDEwMG1zPyAgSWYgd2UgZG9u
J3QgYWxyZWFkeSBoYXZlIGENCj4gPiNkZWZpbmUgZm9yIGl0LCBhZGQgb25lIGluIGRyaXZlcnMv
cGNpL3BjaS5oIHdpdGggc3BlYyBjaXRhdGlvbi4NCj4gPg0KPiA+PiArCS8qIFJlc2V0IG1hYyAq
Lw0KPiA+PiArCXJlZ21hcF91cGRhdGVfYml0c19iYXNlKHBjaWUtPnN5c2N0cmxfYmFzZSwNCj4g
VU5JVF9TT0ZUX1JFU0VUX0NPTkZJR19SRUcsDQo+ID4+ICsJCQkJcGNpZS0+bWFjX3Jlc3RfYml0
bWFzaywgMCwgTlVMTCwgZmFsc2UsIHRydWUpOw0KPiA+PiArCXVkZWxheSgxKTsNCj4gPj4gKwly
ZWdtYXBfdXBkYXRlX2JpdHNfYmFzZShwY2llLT5zeXNjdHJsX2Jhc2UsDQo+IFVOSVRfU09GVF9S
RVNFVF9DT05GSUdfUkVHLA0KPiA+PiArCQkJCXBjaWUtPm1hY19yZXN0X2JpdG1hc2ssIHBjaWUt
DQo+ID5tYWNfcmVzdF9iaXRtYXNrLA0KPiA+PiArCQkJCU5VTEwsIGZhbHNlLCB0cnVlKTsNCj4g
Pj4gKwl1ZGVsYXkoMSk7DQo+ID4+ICsNCj4gPj4gKwlyZXQgPSBkd19wY2llX3NldHVwX3JjKHBw
KTsNCj4gPj4gKwlpZiAocmV0KQ0KPiA+PiArCQlnb3RvIGZhaWw7DQo+ID4+ICsNCj4gPj4gKwly
ZXQgPSBhcm1hZGE4a19wY2llX2hvc3RfaW5pdChwcCk7DQo+ID4+ICsJaWYgKHJldCkgew0KPiA+
PiArCQlkZXZfZXJyKHBjaWUtPnBjaS0+ZGV2LCAiZmFpbGVkIHRvIGluaXRpYWxpemUgaG9zdDog
JWRcbiIsIHJldCk7DQo+ID4+ICsJCWdvdG8gZmFpbDsNCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4g
KwlpZiAoIWR3X3BjaWVfbGlua191cChwY2llLT5wY2kpKSB7DQo+ID4+ICsJCXJldCA9IGR3X3Bj
aWVfc3RhcnRfbGluayhwY2llLT5wY2kpOw0KPiA+PiArCQlpZiAocmV0KQ0KPiA+PiArCQkJZ290
byBmYWlsOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCS8qIFdhaXQgdW50aWwgdGhlIGxpbmsg
YmVjb21lcyBhY3RpdmUgYWdhaW4gKi8NCj4gPj4gKwlpZiAoZHdfcGNpZV93YWl0X2Zvcl9saW5r
KHBjaWUtPnBjaSkpDQo+ID4+ICsJCWRldl9lcnIocGNpZS0+cGNpLT5kZXYsICJMaW5rIG5vdCB1
cCBhZnRlciByZWNvbmZpZ3VyYXRpb25cbiIpOw0KPiA+PiArDQo+ID4+ICsJYnVzID0gTlVMTDsN
Cj4gPj4gKwl3aGlsZSAoKGJ1cyA9IHBjaV9maW5kX25leHRfYnVzKGJ1cykpICE9IE5VTEwpDQo+
ID4+ICsJCXBjaV9yZXNjYW5fYnVzKGJ1cyk7DQo+ID4+ICsNCj4gPj4gK2ZhaWw6DQo+ID4+ICsJ
cGNpX3VubG9ja19yZXNjYW5fcmVtb3ZlKCk7DQo+ID4+ICsJcGNpX2Rldl9wdXQocm9vdF9wb3J0
KTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiAgc3RhdGljIGlycXJldHVybl90IGFybWFkYThrX3Bj
aWVfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqYXJnKSAgew0KPiA+PiAgCXN0cnVjdCBhcm1h
ZGE4a19wY2llICpwY2llID0gYXJnOw0KPiA+PiBAQCAtMjUzLDYgKzMxOSw5IEBAIHN0YXRpYyBp
cnFyZXR1cm5fdCBhcm1hZGE4a19wY2llX2lycV9oYW5kbGVyKGludA0KPiBpcnEsIHZvaWQgKmFy
ZykNCj4gPj4gIAkJICogaW5pdGlhdGUgYSBsaW5rIHJldHJhaW4uIElmIGxpbmsgcmV0cmFpbnMg
d2VyZQ0KPiA+PiAgCQkgKiBwb3NzaWJsZSwgdGhhdCBpcy4NCj4gPj4gIAkJICovDQo+ID4+ICsJ
CWlmIChwY2llLT5zeXNjdHJsX2Jhc2UgJiYgcGNpZS0+bWFjX3Jlc3RfYml0bWFzaykNCj4gPj4g
KwkJCXNjaGVkdWxlX3dvcmsoJnBjaWUtPnJlY292ZXJfbGlua193b3JrKTsNCj4gPj4gKw0KPiA+
PiAgCQlkZXZfZGJnKHBjaS0+ZGV2LCAiJXM6IGxpbmsgd2VudCBkb3duXG4iLCBfX2Z1bmNfXyk7
DQo+ID4+ICAJfQ0KPiA+Pg0KPiA+PiBAQCAtMzIyLDYgKzM5MSw4IEBAIHN0YXRpYyBpbnQgYXJt
YWRhOGtfcGNpZV9wcm9iZShzdHJ1Y3QNCj4gPj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+
Pg0KPiA+PiAgCXBjaWUtPnBjaSA9IHBjaTsNCj4gPj4NCj4gPj4gKwlJTklUX1dPUksoJnBjaWUt
PnJlY292ZXJfbGlua193b3JrLCBhcm1hZGE4a19wY2llX3JlY292ZXJfbGluayk7DQo+ID4+ICsN
Cj4gPj4gIAlwY2llLT5jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCBOVUxMKTsNCj4gPj4gIAlpZiAo
SVNfRVJSKHBjaWUtPmNsaykpDQo+ID4+ICAJCXJldHVybiBQVFJfRVJSKHBjaWUtPmNsayk7DQo+
ID4+IEBAIC0zNDksNiArNDIwLDE5IEBAIHN0YXRpYyBpbnQgYXJtYWRhOGtfcGNpZV9wcm9iZShz
dHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+PiAgCQlnb3RvIGZhaWxfY2xrcmVn
Ow0KPiA+PiAgCX0NCj4gPj4NCj4gPj4gKwlwY2llLT5zeXNjdHJsX2Jhc2UgPSBzeXNjb25fcmVn
bWFwX2xvb2t1cF9ieV9waGFuZGxlKHBkZXYtDQo+ID5kZXYub2Zfbm9kZSwNCj4gPj4gKwkJCQkJ
CSAgICAgICAibWFydmVsbCxzeXN0ZW0tDQo+IGNvbnRyb2xsZXIiKTsNCj4gPj4gKwlpZiAoSVNf
RVJSKHBjaWUtPnN5c2N0cmxfYmFzZSkpIHsNCj4gPj4gKwkJZGV2X3dhcm4oZGV2LCAiZmFpbGVk
IHRvIGZpbmQgbWFydmVsbCxzeXN0ZW0tY29udHJvbGxlclxuIik7DQo+ID4+ICsJCXBjaWUtPnN5
c2N0cmxfYmFzZSA9IDB4MDsNCj4gPj4gKwl9DQo+ID4+ICsNCj4gPj4gKwlyZXQgPSBvZl9wcm9w
ZXJ0eV9yZWFkX3UzMihwZGV2LT5kZXYub2Zfbm9kZSwgIm1hcnZlbGwsbWFjLXJlc2V0LQ0KPiBi
aXQtbWFzayIsDQo+ID4+ICsJCQkJICAgJnBjaWUtPm1hY19yZXN0X2JpdG1hc2spOw0KPiA+PiAr
CWlmIChyZXQgPCAwKSB7DQo+ID4+ICsJCWRldl93YXJuKGRldiwgImNvdWxkbid0IGZpbmQgbWFj
IHJlc2V0IGJpdCBtYXNrOiAlZFxuIiwgcmV0KTsNCj4gPj4gKwkJcGNpZS0+bWFjX3Jlc3RfYml0
bWFzayA9IDB4MDsNCj4gPj4gKwl9DQo+ID4+ICAJcmV0ID0gYXJtYWRhOGtfcGNpZV9zZXR1cF9w
aHlzKHBjaWUpOw0KPiA+PiAgCWlmIChyZXQpDQo+ID4+ICAJCWdvdG8gZmFpbF9jbGtyZWc7DQo+
ID4+IC0tDQo+ID4+IDIuMjUuMQ0KPiA+Pg0KPiANCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p
4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

