Return-Path: <linux-pci+bounces-16729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151D59C825E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 06:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC403283AB8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 05:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E0E1494CC;
	Thu, 14 Nov 2024 05:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="McvUeL5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081DA801;
	Thu, 14 Nov 2024 05:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731562077; cv=fail; b=pj2cI7GXwQQxw9p8KDDixxk+7JbNjErfK7lpxcvrf+gjuz0AP2buh6hLZJyh+mnNtNJPHE2EhjrOGBXZN8WiHMMTqrP+niUY00evv5Ck8V4J7syiHDn12sUzIRDGzWxf7Jf8S6mhNdjZg3EUK27W5NPxvAgO1aRAa+/4/hsz614=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731562077; c=relaxed/simple;
	bh=tcYet2wC1kkeU5sFx2Oyp7Zre5mbCZwhV2ApwjZmQVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l2LyfXViF0h21LM5SNm0O92EkN/i6zEBdkALz39ZygrVG2vfNC9h9dFaZOVG3LawHO6SBceJ58FZy2tDpYHHqovSE87rmOC1WmS6BZkI0Nqqohf+/HBzNKQLuimaqIlxlmpXeFXhF6IcDibUS/ttciHPhvc/2tYbXBq8+AfWYeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=McvUeL5w; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE3TZM2025188;
	Wed, 13 Nov 2024 21:17:22 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42w9bpg5a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 21:17:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjfkdZjFAPqBtVN1aEqRgClYiL9WDGKyykHbJ8ee9EP5HmyVLT5Bq5GzQ2nXVLtD0uqVK84AYUrtw2HcNbUB0NMv3l0zXafUwU/0gToCCJaLMKL0y4+Quq2ZjYiaIWs4Jm8mYv0HVQs3zY8L1GUmsPyNwiFc36cWf8kZfTN46w9OjXTcqyxD9R0pgZhKYjZug8pyvpDHj2s1UjP2U8wnFQY61lLYHKWzNCnGzFgvKigfFEoUvq5rlPvCH4Cm8Ef9kbLINN5j8OIdPZ/GRHQJgscj8BqXG/FXOOLpq88y6ROxEz4IsODLV2nGAGTcTB1eKs+1Czy5I0BtDb6E9kigkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcYet2wC1kkeU5sFx2Oyp7Zre5mbCZwhV2ApwjZmQVs=;
 b=lZdPGHvxZuaH9r1dEIIdjzDGVYgmtYcvUZ0opQ9ONueAsemp5ViEYqxgXMw72czwE+C+uCTIiYRGDonYiOdXP/ZiSXZVp35ZS+ZjKPUfyPS6dPQOpn0bzyZy0WK6q3/vBThY2oW3Fq4ihF/IPOYgkd5mcb1FDCovN4BxiIQ+RTAOwYDeX2/ADPQBlRqrMgU25oA8yz3xCDmqK4PSlw2F3yk0fZSPc12LkvO9ZbElWn25dAMjVTiEKhT/pOiZ81dSOc57iIEHzzqwNCDzSKEf6mMKaw2OXuIJPLYoQrkpWqBC8jPGfd1IuV6vCqfgFgPQ9ZRVwkGu9t2AOzNiTkBmWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcYet2wC1kkeU5sFx2Oyp7Zre5mbCZwhV2ApwjZmQVs=;
 b=McvUeL5w34+2wWU8CddZbVjTuwOeDr0QetxjNTDKJJLy9Pum1zquPGCcRPFP6W0WxxdgnAt5mMc1sg1w/WulSqbc59RdqF8Q+CDk6VffSb9aO26uRRLjep9dOPbeFZLOPwQeXOeoBkzK8zaUBKMNIu34L3UeAbBu2eomaTCUysk=
Received: from PH0PR18MB4425.namprd18.prod.outlook.com (2603:10b6:510:ef::13)
 by MN2PR18MB3771.namprd18.prod.outlook.com (2603:10b6:208:210::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 05:17:19 +0000
Received: from PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4]) by PH0PR18MB4425.namprd18.prod.outlook.com
 ([fe80::424f:7fcf:ce0d:45c4%5]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 05:17:18 +0000
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
Thread-Index: AQHbNlR5ByTftVF2WUqCFuLruPlUkA==
Date: Thu, 14 Nov 2024 05:17:18 +0000
Message-ID:
 <PH0PR18MB4425CD5BD139261F035D19CDD95B2@PH0PR18MB4425.namprd18.prod.outlook.com>
References:
 <PH0PR18MB4425C1F63EAFFA2AA3BFCBF2D95A2@PH0PR18MB4425.namprd18.prod.outlook.com>
 <20241114000324.GA1967327@bhelgaas>
In-Reply-To: <20241114000324.GA1967327@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4425:EE_|MN2PR18MB3771:EE_
x-ms-office365-filtering-correlation-id: 1a8c8124-77a5-488d-d541-08dd046b9c6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1lDSHlzT3F5UHIrOHUxSVo1ejNWb2RVR0VWLzl0bEdpMFM2U0FIMERaNFdm?=
 =?utf-8?B?ZmNNRThSc1VSb0NrM2RYSytvdUFwMS90SU44MnhEbmdGNkVRbkVjODhvWGpj?=
 =?utf-8?B?TVVnUllIU2lNbHlvQjJzeGtnUjV5QldRV1FEd3RPRytHL055bW0wVUNMTWlw?=
 =?utf-8?B?bDhTSE9zb1ltM2tDN3pEUWwyUURrdTl5MUFFYjJKWWZkSWpEVHFLalc4Sk84?=
 =?utf-8?B?QUNrcHRzK29oRE5TLzNhd1RYTlJvYmNJZWVISmlvYkZiRStPSWtUSFpBQXkz?=
 =?utf-8?B?bW9VNHJCanFqbFZVMDNxdzMwd21nU2R0elcyZ2V4bDBIVDBSNGVOWTVFU1NO?=
 =?utf-8?B?TUFkdzROOFkza3lJeHdwR3JLYm1zWEVnYStNajZuNmg3Vy9qeVl6aURIVmtH?=
 =?utf-8?B?Qjh1aDFobWFLdjdsV2s0a2xvMzVERUZYUFBTZWFTaExhOWsxcS9BQU9KK1pV?=
 =?utf-8?B?WlJQYkwyRjF6aVhXWWxhaGMybTA5VStlRm92UWw1eUZjTml2eStOejI0QWts?=
 =?utf-8?B?U05CRDBuS3BOaVRnOXdUYVIyMWJYaElsUzg3dW9EVFJvTG9OaWNrdnVJWUdO?=
 =?utf-8?B?VHBDcHQ1b3d5dVAxRWd1YTk1LzV1MGJuYWtTRUpwV253MG5WZmkvVXVwM2xz?=
 =?utf-8?B?RUlLSDNDRy9QdDZoOHg4UmRFSFdCalhzSnpSZTgwTHplakFhbjZOTnZJbXY2?=
 =?utf-8?B?NzJKejNvaTZtdVRqd0xqTlBaNTJXSldhMmE5azFMOHZzbGltc1loN0NvOEFr?=
 =?utf-8?B?RDY2L1F1NU9PcG14cGFOUlNTR2pRWkRYRjRhdmhtQjZtVXh6RFRpVGRkbzNt?=
 =?utf-8?B?Z1JCemczYzMrTHVoakN2RXBHUHJRRXZaTVJzMjlINDRNajBLbFFZSHhnOC9V?=
 =?utf-8?B?OFFkTFJYb2xxcGNQQkpPNE5OaGhTTlhGeC9JNkt5Z2hDa3E5c0oxWEprY0x2?=
 =?utf-8?B?MVpVYnZYNzdwaGlMODNtbjdMZHJWcEM2N1ByM3YwNWNvbVJ4ZVMyR2lyODJy?=
 =?utf-8?B?M1R3VnJjL1cwUWFaMlVWMGRuVnByL1ZCNHNkaHI1YlpZSEQzc0ZnWW5YN3pJ?=
 =?utf-8?B?Ym9tVXpjbmdWQnZmbDMwUkhJaVk0TmdETXUza05TL0x1ckg2L0dYM3FGZ2tP?=
 =?utf-8?B?UE5qVVRHc2RYRVlDekNFa1UyWUdGVEJCb1BDMjBmWXhmdTFmYzJEVW9wNy9C?=
 =?utf-8?B?STIzcitya3lWc1R3c3I5Rm1TNnZqZVQrRXdvZitSZ0VENkVGTTBtcDczcGNR?=
 =?utf-8?B?bnExeTNkejZEcVRNZU9BL1JZSkVJOXQrT1MrLzZUQkJHVEU5OFcwbkFhZEVh?=
 =?utf-8?B?OC8zcElWc0UxRzdiYmdPZEl4YVpNSklSOXpzQnZ5VDIyeSs3Rkk1N1d2SkQ2?=
 =?utf-8?B?dmJYOWZwbFlrUGlOTzZNU05iMWlvTnc2M0dGRjhtM3pZWFpPSUFPdUFTN1dX?=
 =?utf-8?B?eTVPVG43azhreW1EbmJYS2s4bGRmNGZhT1RldjZLRGVaVXA5a1Q2b0VvTkpj?=
 =?utf-8?B?QVdQR0pUZnMxRkQ0dDYycHhlWnZDMXRPUzQwcHlTQklERlBNWW54d1lWWFYw?=
 =?utf-8?B?QW1XUVRleURBOXFBcjhwY1BSdjFNNVNBUnExNkZsRXpkSHBGNVl5Y2o3MlpS?=
 =?utf-8?B?RWRzbVlKdnVlYzdNemt0UUJkZllLZE5UUUJISWZXcnNiL2hqM0ZXSVNxOGdL?=
 =?utf-8?B?SWcxMDhlS2tWNThqbjZFcE9Da3hzeFhWei8vekY4WURjanpRQmlISlBtY3Iv?=
 =?utf-8?B?dm9HVXkvRjhObGJBRzZkY0Q4YnN3M3JkVWxTT3NjMTNiWDZnQVlOTzdJQnV2?=
 =?utf-8?Q?J0LYFXlI/tpvf7d1AzffDC8J2sEsOjXxZ8cOo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHBGWnRmd2ZoZTFBdWVwYnkwZXE2OVVuWk95ZzBWR1pWay9LUXVIdjh6Um8v?=
 =?utf-8?B?NGo5ZDhJQ00xeU5vL0dsbG5sblpST1JPeEYzQUZNcDE1WUZpYlpHTVhRdGNj?=
 =?utf-8?B?L1YzdFk0TDFkRlQ0ZndUa3pxZjc0Wjk0QWhPZXNMK29nakQrS09CVVd4TXE2?=
 =?utf-8?B?ZkFmOUtMaHUybU5GTXpIWWxrbmZ5OVpmbjJyTE15ZmNLdXZtUk82T1IvVmdn?=
 =?utf-8?B?VHgyQTcrbExocEtsNE9tazEyL2paVFdRTHNyNnRGSnhQU0YvKzVhRjJMdHlQ?=
 =?utf-8?B?VFV1ZUc4MzRqYXJjWDdrWU1BZXhvaVJic0t2YWFHY01DdUxFMUsvTGZ3Vm9W?=
 =?utf-8?B?d1JkVTZjMGFIY0MxYkYrVHJiMG5Gc3UzSTlCOUxBMkJMOSs4OVlGTy96Wkhv?=
 =?utf-8?B?Z2M1WVZhTW9WdkpUQ01SV2dIcEJQSFRURTNQaEVwaWFnTUhiaEVLRUtwSlp4?=
 =?utf-8?B?ck1Mejhlak9rTmRrcnpXa0VWam5RdHZ2WkFqaHhIRGxJRk0wTmdQUHVjdjFp?=
 =?utf-8?B?UTh5MzRPZ0lIWXhWblArMEdxZlE3aWEvYUpjWjVzRHBURG54UUxPYThWcHVF?=
 =?utf-8?B?WEMrNWNjdXJHWDJPbFJvYk04ZXZJNkt1d1JwUWkyMTJlNmV3Y0JqVnlEUktI?=
 =?utf-8?B?Y0FmblUvTHY5WVFiNHYveFl1RlZjOVVVYVRhQSs2cGtBWE5HY0RaQXg1ZUpJ?=
 =?utf-8?B?T2ZyV3ozRmFYUXBpMWdMUnFnR2YwcUFnaUtwRzlEVzNqODZmam1LeG9OTHV1?=
 =?utf-8?B?QWVjbTd4VmxWVjFhcno0TkQwYW5VbU1DYlduU0F2U2ZmdXF5ekt0ejQzVDhx?=
 =?utf-8?B?amJxOUg1eS9GeGRSUjVDdFYzTER0amc1RTBQNVByQzBVZUovSk9OR3dSaWNL?=
 =?utf-8?B?K1JMTloxQU1mVUFqTW5tUEFTeGZsQmpEQWxBaGN4S0huWUtQMkhQUk1qYkQ3?=
 =?utf-8?B?ZUVYeHF0RC9mTmgvUWFaOWUvUTFkTnNIZjFFczkyQk91dEhyV3oxTmd5OWM4?=
 =?utf-8?B?WVNZQzJSYk80aUgvMDZBZFlLUnlrR3hWeURxTS81Y2VlTU5mWGRtSGZKM25x?=
 =?utf-8?B?MkNOSGtqNmxxVitlMlFuS1VNQ1VWcVo3QnlXaXRYcG1VMnRpTzlabjlwdzVS?=
 =?utf-8?B?RXZ0ay9yUnZqSzlhTHc2TTk5ZlVUNGdRZ0YzSWNETGR1N2hTRkZzbXhOQ1g2?=
 =?utf-8?B?bDk4Qm5SZ1FyMzR1TXFCVStKamt0bGZGNFRVRmlUSFFSYVJOL0tpbUxxUUt5?=
 =?utf-8?B?bERlcGdoUDZRZUhvUTlpK3p4TExnNUI0L0grZ01NZjJsL3NEbkNRa0dSR1hT?=
 =?utf-8?B?aWp5WGJvOVU3V1NoTjZOREZPSy9BSVBlR0E0djA4WmwwZnhoR3lOVjdzY1V3?=
 =?utf-8?B?WHpTOFZmaTJScjlOeks2NVpMTG8xMHl1M0EvUVBOaHlsU3dWZ1dZU1padGgw?=
 =?utf-8?B?cmNFT1RWeC9uRHgxZzhZVldNQm5XcTVIanVibDQvRWxkeTF2VVV5ZkNTT1du?=
 =?utf-8?B?RDdUeXUveEhYaFBrcWh3YjRTMTNuK0huUnpuSytEdEFRV2UrVlNwckR3YXFP?=
 =?utf-8?B?V2twb3JPRW9LL2ZyeSs3dHYweVpqNWh5cTgzREl1RHBzTGlVZVpYeFVHVzJv?=
 =?utf-8?B?aXhrbGtkelFwOEh3TkRzVHBhbmFVenpNN3hUUEF3TWtiLzVVbFVqZEhSdjZL?=
 =?utf-8?B?M21QbENUbGFhQTNBT1pEaHpLUGlncEpWRStSdUFQbEtwOVBPV0Y0Q0U5N3pp?=
 =?utf-8?B?OWF5NnhMcFR3SDhtd3hnVzlYcjV1TjlCaXBjeFlndmFrYkhaaUxKd0tBV285?=
 =?utf-8?B?SVBRMk01SHhzbWlCNzdWWnpkL0kwRkY4eGJzNDE1ZnAwWmFJYTdsZk55VThC?=
 =?utf-8?B?clU3ZnJpZUtlU21kM3dUanE3c2R6cmJMZlliekdaQ0NlMEkxRFNTcTJxVEk3?=
 =?utf-8?B?UDdiUGFLMyt1R3RPY2laUzE1ZUpVS3lpZ0w1Z1hlcFVhOWlWMWZsNFVWYi9Z?=
 =?utf-8?B?WU8xM1k1TUZRWDBWMzRIVXhYYzc3SkJoa3pSWGdPbnowQXQzRlVXZ1ZBdEZk?=
 =?utf-8?B?WnlONlRCd0VYMTJlTGR4OG40UE9ZbFI1YVhKMXBoVHU1cTBWL3hNeElLZm5j?=
 =?utf-8?Q?Lo3JisSFz2hphr0PD/mgJToDT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8c8124-77a5-488d-d541-08dd046b9c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 05:17:18.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpZpzV+zIBQHvaXq0BJaOl2FHBZAWylOqe5cVJVPG2KJBHlVwfgO7GqHGOcf3GwNpwcGoMoLmmZf6nXuX5+OpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3771
X-Proofpoint-GUID: f9Ek1tIKOxnbsr0tF9fVuG5_ONcUfCYt
X-Proofpoint-ORIG-GUID: f9Ek1tIKOxnbsr0tF9fVuG5_ONcUfCYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Pj4gPj4gPj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgUENJIGhvdHBsdWcgY29udHJvbGxlciBk
cml2ZXIgZm9yIHRoZSBPQ1RFT04NCj4+ID4+ID4+IFBDSWUgZGV2aWNlLiBUaGUgT0NURU9OIFBD
SWUgZGV2aWNlIGlzIGEgbXVsdGktZnVuY3Rpb24gZGV2aWNlIHdoZXJlDQo+dGhlDQo+PiA+PiA+
PiBmaXJzdCBmdW5jdGlvbiBzZXJ2ZXMgYXMgdGhlIFBDSSBob3RwbHVnIGNvbnRyb2xsZXIuDQo+
PiA+PiA+Pg0KPj4gPj4gPj4gICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKw0KPj4gPj4gPj4gICAgICAgICAgICAgICAgfCAgICAgICAgICAgUm9vdCBQb3J0
ICAgICAgICAgICAgfA0KPj4gPj4gPj4gICAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tKw0KPj4gPj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwNCj4+ID4+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBDSWUNCj4+ID4+ID4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+PiA+PiA+PiArLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4g
Pj4gPj4gfCAgICAgICAgICAgICAgT0NURU9OIFBDSWUgTXVsdGlmdW5jdGlvbiBEZXZpY2UgICAg
ICAgICAgICAgICAgIHwNCj4+ID4+ID4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+PiA+PiA+PiAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgIHwNCj4+ID4+
ID4+ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8ICAg
ICAgICAgICAgfA0KPj4gPj4gPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICstLS0tLS0tLS0t
LS0tLS0tKyAgKy0tLS0tKyAgKy0tLS0tLS0tLS0tLS0tLS0rDQo+PiA+PiA+PiB8ICAgICAgRnVu
Y3Rpb24gMCAgICAgfCAgfCAgIEZ1bmN0aW9uIDEgICB8ICB8IC4uLiB8ICB8ICAgRnVuY3Rpb24g
NyAgIHwNCj4+ID4+ID4+IHwgKEhvdHBsdWcgY29udHJvbGxlcil8ICB8IChIb3RwbHVnIHNsb3Qp
IHwgIHwgICAgIHwgIHwgKEhvdHBsdWcgc2xvdCkgfA0KPj4gPj4gPj4gKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLSsgICstLS0tLS0tLS0tLS0tLS0tKyAgKy0tLS0tKyAgKy0tLS0tLS0tLS0tLS0tLS0r
DQo+PiA+PiA+PiAgICAgICAgICAgICAgfA0KPj4gPj4gPj4gICAgICAgICAgICAgIHwNCj4+ID4+
ID4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPj4gPj4gPj4gfCAgIENvbnRyb2xsZXIg
RmlybXdhcmUgICB8DQo+PiA+PiA+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsNCj4+ID4+
ID4+DQo+PiA+PiA+PiBUaGUgaG90cGx1ZyBjb250cm9sbGVyIGRyaXZlciBlbmFibGVzIGhvdHBs
dWdnaW5nIG9mIG5vbi1jb250cm9sbGVyDQo+PiA+PiA+PiBmdW5jdGlvbnMgd2l0aGluIHRoZSBz
YW1lIGRldmljZS4gRHVyaW5nIHByb2JpbmcsIHRoZSBkcml2ZXIgcmVtb3Zlcw0KPj4gPj4gPj4g
dGhlIG5vbi1jb250cm9sbGVyIGZ1bmN0aW9ucyBhbmQgcmVnaXN0ZXJzIHRoZW0gYXMgUENJIGhv
dHBsdWcgc2xvdHMuDQo+PiA+PiA+PiBUaGVzZSBzbG90cyBhcmUgYWRkZWQgYmFjayBieSB0aGUg
ZHJpdmVyLCBvbmx5IHVwb24gcmVxdWVzdCBmcm9tIHRoZQ0KPj4gPj4gPj4gZGV2aWNlIGZpcm13
YXJlLg0KPj4gPj4gPj4NCj4+ID4+ID4+IFRoZSBjb250cm9sbGVyIHVzZXMgTVNJLVggaW50ZXJy
dXB0cyB0byBub3RpZnkgdGhlIGhvc3Qgb2YgaG90cGx1Zw0KPj4gPj4gPj4gZXZlbnRzIGluaXRp
YXRlZCBieSB0aGUgT0NURU9OIGZpcm13YXJlLiBBZGRpdGlvbmFsbHksIHRoZSBkcml2ZXINCj4+
ID4+ID4+IGFsbG93cyB1c2VycyB0byBlbmFibGUgb3IgZGlzYWJsZSBpbmRpdmlkdWFsIGZ1bmN0
aW9ucyB2aWEgc3lzZnMgc2xvdA0KPj4gPj4gPj4gZW50cmllcywgYXMgcHJvdmlkZWQgYnkgdGhl
IFBDSSBob3RwbHVnIGZyYW1ld29yay4NCj4+ID4+ID4NCj4+ID4+ID5DYW4gd2Ugc2F5IHNvbWV0
aGluZyBoZXJlIGFib3V0IHdoYXQgdGhlIGJlbmVmaXQgb2YgdGhpcyBkcml2ZXIgaXM/DQo+PiA+
PiA+Rm9yIGV4YW1wbGUsIGRvZXMgaXQgc2F2ZSBwb3dlcj8NCj4+ID4+DQo+PiA+PiBUaGUgZHJp
dmVyIGVuYWJsZXMgaG90cGx1Z2dpbmcgb2Ygbm9uLWNvbnRyb2xsZXIgZnVuY3Rpb25zIHdpdGhp
biB0aGUNCj5kZXZpY2UNCj4+ID4+IHdpdGhvdXQgcmVxdWlyaW5nIGEgZnVsbHkgaW1wbGVtZW50
ZWQgc3dpdGNoLCByZWR1Y2luZyBib3RoIHBvd2VyDQo+PiA+Y29uc3VtcHRpb24NCj4+ID4+IGFu
ZCBwcm9kdWN0IGNvc3QuDQo+PiA+DQo+PiA+UmVkdWNlZCBwcm9kdWN0IGNvc3QgaXMgbW90aXZh
dGlvbiBmb3IgdGhlIGhhcmR3YXJlIGRlc2lnbiwgbm90IGZvcg0KPj4gPnRoaXMgaG90cGx1ZyBk
cml2ZXIuDQo+PiA+DQo+PiA+WW91IGRpZG4ndCBleHBsaWNpdGx5IHNheSB0aGF0IHdoZW4gZnVu
Y3Rpb24gMCBob3QtcmVtb3ZlcyBhbm90aGVyDQo+PiA+ZnVuY3Rpb24sIGl0IHJlZHVjZXMgb3Zl
cmFsbCBwb3dlciBjb25zdW1wdGlvbi4gIEJ1dCBJIGFzc3VtZSB0aGF0J3MNCj4+ID50aGUgY2Fz
ZT8NCj4+ID4NCj4+DQo+PiBZZXMsIEkgd2lsbCBleHBsYWluIGl0IGluIGRldGFpbCBiZWxvdw0K
Pj4NCj4+ID4+ID5XaGF0IGNhdXNlcyB0aGUgZnVuY3Rpb24gMCBmaXJtd2FyZSB0byByZXF1ZXN0
IGEgaG90LWFkZCBvcg0KPj4gPj4gPmhvdC1yZW1vdmFsIG9mIGFub3RoZXIgZnVuY3Rpb24/DQo+
PiA+Pg0KPj4gPj4gVGhlIGZpcm13YXJlIHdpbGwgZW5hYmxlIHRoZSByZXF1aXJlZCBudW1iZXIg
b2Ygbm9uLWNvbnRyb2xsZXINCj4+ID4+IGZ1bmN0aW9ucyBiYXNlZCBvbiBydW50aW1lIGRlbWFu
ZCwgYWxsb3dpbmcgY29udHJvbCBvdmVyIHRoZXNlDQo+PiA+PiBmdW5jdGlvbnMuIEZvciBleGFt
cGxlLCBpbiBhIHZEUEEgc2NlbmFyaW8sIGVhY2ggZnVuY3Rpb24gY291bGQgYWN0DQo+PiA+PiBh
cyBhIGRpZmZlcmVudCB0eXBlIG9mIGRldmljZSAoc3VjaCBhcyBuZXQsIGNyeXB0bywgb3Igc3Rv
cmFnZSkNCj4+ID4+IGRlcGVuZGluZyBvbiB0aGUgZmlybXdhcmUgY29uZmlndXJhdGlvbi4NCj4+
ID4NCj4+ID5XaGF0IGlzIHRoZSBwYXRoIGZvciB0aGlzIHJ1bnRpbWUgZGVtYW5kPyAgSSBhc3N1
bWUgZnVuY3Rpb24gMA0KPj4gPnByb3ZpZGVzIHNvbWUgaW50ZXJmYWNlIHRvIHJlcXVlc3QgYSBz
cGVjaWZpYyBraW5kIG9mIGZ1bmN0aW9uYWxpdHkNCj4+ID4obmV0LCBjcnlwbywgc3RvcmFnZSwg
ZXRjKT8NCj4+ID4NCj4+DQo+PiBSaWdodCBub3csIGl0IGRvbmUgdmlhIGZpcm13YXJlIG1hbmFn
ZW1lbnQgY29uc29sZS4NCj4+DQo+PiA+SSBkb24ndCBrbm93IGFueXRoaW5nIGFib3V0IHZEUEEs
IHNvIGlmIHRoYXQncyBpbXBvcnRhbnQgaGVyZSwgaXQNCj4+ID5uZWVkcyBhIGxpdHRsZSBtb3Jl
IGNvbnRleHQuDQo+PiA+DQo+PiA+PiBIb3QgcmVtb3ZhbCBpcyB1c2VmdWwgaW4gY2FzZXMgb2Yg
bGl2ZSBmaXJtd2FyZSB1cGRhdGVzLg0KPj4gPg0KPj4gPlNvIHRoZSBpZGVhIGlzIHRoYXQgZnVu
Y3Rpb24gWCBpcyBob3QtcmVtb3ZlZCwgd2hpY2ggZm9yY2VzIHRoZSBkcml2ZXINCj4+ID50byBs
ZXQgZ28gb2YgaXQsIHRoZSBmaXJtd2FyZSBpcyB1cGRhdGVkLCBhbmQgWCBpcyBob3QtYWRkZWQg
YWdhaW4sDQo+PiA+YW5kIHRoZSBkcml2ZXIgYmluZHMgdG8gaXQgYWdhaW4/DQo+PiA+DQo+Pg0K
Pj4gSSB3aWxsIGV4cGxhaW4gdGhlIHByb2Nlc3MgaW4gZGV0YWlsLCB3aGljaCBzaG91bGQgYWxz
byBhZGRyZXNzIHRoZSBxdWVzdGlvbnMNCj4+IGJlbG93Lg0KPj4NCj4+ID5BbmQgc29tZXdoZXJl
IGluIHRoZXJlIGlzIGEgcmVzZXQgb2YgZnVuY3Rpb24gWCwgYW5kIGFmdGVyIHRoZSByZXNldA0K
Pj4gPlggaXMgcnVubmluZyB0aGUgbmV3IGZpcm13YXJlPw0KPj4gPg0KPj4gPldoby93aGF0IGlu
aXRpYXRlcyB0aGlzIHdob2xlIHBhdGg/ICBTb21lIHJlcXVlc3QgdG8gZnVuY3Rpb24gMCwNCj4+
ID5zYXlpbmcgInBsZWFzZSByZW1vdmUgZnVuY3Rpb24gWCI/DQo+PiA+DQo+PiA+QnV0IEkgZ3Vl
c3MgbWF5YmUgaXQgZG9lc24ndCBnbyB0aHJvdWdoIGZ1bmN0aW9uIDAsIHNpbmNlIG9jdGVvbl9o
cA0KPj4gPmNsYWltcyBmdW5jdGlvbiAwLCBhbmQgaXQgZG9lc24ndCBwcm92aWRlIHRoYXQgZnVu
Y3Rpb25hbGl0eS4gIE1heWJlDQo+PiA+dGhlIGluZGl2aWR1YWwgZHJpdmVycyBmb3IgKm90aGVy
KiBmdW5jdGlvbnMga25vdyBob3cgdG8gaW5pdGlhdGUNCj4+ID50aGVzZSB0aGluZ3MsIGFuZCB0
aG9zZSBmdW5jdGlvbnMgaW50ZXJuYWxseSBjb21tdW5pY2F0ZSB3aXRoIGZ1bmN0aW9uDQo+PiA+
MCB0byBhc2sgaXQgdG8gc3RhcnQgYSBob3QtcmVtb3ZlL2hvdC1hZGQgc2VxdWVuY2U/DQo+PiA+
DQo+PiA+VGhhdCB3b3VsZG4ndCBleHBsYWluIHRoZSBwb3dlciByZWR1Y3Rpb24gcGxhbiwgdGhv
dWdoLiAgQSBkcml2ZXIgZm9yDQo+PiA+ZnVuY3Rpb24gWCBjb3VsZCBjb25jZWl2YWJseSB0ZWxs
IGl0cyBkZXZpY2UgIkknbSBubyBsb25nZXIgbmVlZGVkIg0KPj4gPmFuZCBmdW5jdGlvbiBYIGNv
dWxkIHRlbGwgZnVuY3Rpb24gMCB0byByZW1vdmUgaXQuICBUaGF0IG1pZ2h0IGVuYWJsZQ0KPj4g
PnNvbWUgcG93ZXIgc2F2aW5ncy4gIEJ1dCB0aGF0IGRvZXNuJ3QgaGF2ZSBhIHBhdGggdG8gKnJl
LWVuYWJsZSoNCj4+ID5mdW5jdGlvbiBYLCBzaW5jZSBmdW5jdGlvbiBYIGhhcyBiZWVuIHJlbW92
ZWQgYW5kIHRoZXJlJ3Mgbm8gZHJpdmVyIHRvDQo+PiA+YXNrIGZvciBpdCB0byBiZSBob3QtYWRk
ZWQgYWdhaW4uDQo+PiA+DQo+PiA+TWF5YmUgdGhlcmUncyBzb21lIG91dC1vZi1iYW5kIG1hbmFn
ZW1lbnQgcGF0aCB0aGF0IGNhbiB0ZWxsIGZ1bmN0aW9uDQo+PiA+MCB0byBkbyB0aGluZ3MsIGlu
ZGVwZW5kZW50IG9mIFBDSWU/DQo+PiA+DQo+Pg0KPj4gT3VyIGltcGxlbWVudGF0aW9uIGFpbXMg
dG8gYWNoaWV2ZSB0d28gbWFpbiBvYmplY3RpdmVzOg0KPj4NCj4+IDEuIEVuYWJsZSBjaGFuZ2lu
ZyBhIGZ1bmN0aW9uJ3MgcGVyc29uYWxpdHkgYXQgcnVudGltZS4NCj4+IDIuIFJlZHVjZSBwb3dl
ciBjb25zdW1wdGlvbi4NCj4+DQo+PiBUaGUgT0NURU9OIFBDSSBkZXZpY2UgaGFzIG11bHRpcGxl
IEFSTSBjb3JlcyBydW5uaW5nIExpbnV4LCB3aXRoIGl0cw0KPmZpcm13YXJlDQo+PiBjb21wb3Nl
ZCBvZiBtdWx0aXBsZSBjb21wb25lbnRzLiBGb3IgZXhhbXBsZSwgdGhlIGZpcm13YXJlIGluY2x1
ZGVzDQo+Y29tcG9uZW50cw0KPj4gbGlrZSBWaXJ0aW8tbmV0LCBOVk1lLCBhbmQgVmlydGlvLUNy
eXB0bywgd2hpY2ggY2FuIGJlIGFzc2lnbmVkIHRvIGFueQ0KPmZ1bmN0aW9uDQo+PiBhdCBydW50
aW1lLiBUaGUgZGV2aWNlIGZpcm13YXJlIGlzIGFjY2Vzc2libGUgdmlhIGEgbWFuYWdlbWVudCBj
b25zb2xlLA0KPmFsbG93aW5nDQo+PiBjb21wb25lbnRzIHRvIGJlIHN0YXJ0ZWQgb3Igc3RvcHBl
ZC4gRm9yIGVhY2ggY29tcG9uZW50LCBhbiBhc3NvY2lhdGVkDQo+ZnVuY3Rpb24NCj4+IGlzIGhv
dC1hZGRlZCBvbiB0aGUgaG9zdCB0byBleHBvc2UgaXRzIGZ1bmN0aW9uYWxpdHkuIEluaXRpYWxs
eSwgYWZ0ZXIgYm9vdCwgb25seQ0KPj4gRnVuY3Rpb24gMCBhbmQgdGhlIGNvbnRyb2xsZXIgZmly
bXdhcmUgYXJlIGFjdGl2ZS4NCj4+DQo+PiBIZXJlJ3MgYSBicmVha2Rvd246DQo+Pg0KPj4gQXQg
VGltZSAwOg0KPj4gLSBMaW51eCBib290cyBvbiB0aGUgZGV2aWNlLCBzdGFydGluZyB0aGUgY29u
dHJvbGxlciBmaXJtd2FyZS4NCj4+DQo+PiBBdCBUaW1lIDE6DQo+PiAtIFRoZSBob3RwbHVnIGRy
aXZlciBsb2FkcyBvbiB0aGUgaG9zdCwgdGVtcG9yYXJpbHkgcmVtb3Zpbmcgb3RoZXIgZnVuY3Rp
b25zLg0KPj4NCj4+IEF0IFRpbWUgMjoNCj4+IC0gQSBuZXR3b3JrIGRldmljZSBmaXJtd2FyZSBj
b21wb25lbnQgc3RhcnRzIG9uIGFuIEFSTSBjb3JlIChpbml0aWF0ZWQNCj50aHJvdWdoDQo+PiAg
IGEgY29uc29sZSBjb21tYW5kKS4NCj4+IC0gVGhpcyBjb21wb25lbnQgc2V0cyB1cCB0aGUgRnVu
Y3Rpb24gMSBjb25maWd1cmF0aW9uIHNwYWNlLCBkYXRhLCBhbmQgb3RoZXINCj4+ICAgcmVxdWVz
dCBoYW5kbGVycyBmb3IgbmV0d29yayBwcm9jZXNzaW5nLg0KPj4gLSBUaGUgZmlybXdhcmUgaXNz
dWVzIGEgaG90LWFkZCByZXF1ZXN0IHRvIEZ1bmN0aW9uIDAgKGhvdHBsdWcgZHJpdmVyKSBvbiB0
aGUNCj4+ICAgaG9zdCB0byBlbmFibGUgRnVuY3Rpb24gMS4NCj4+DQo+PiBBdCBUaW1lIDM6DQo+
PiAtIFRoZSBGdW5jdGlvbiAwIGhvdHBsdWcgZHJpdmVyIG9uIHRoZSBob3N0IHJlY2VpdmVzIHRo
ZSBob3QtYWRkIHJlcXVlc3QgYW5kDQo+PiAgIGVuYWJsZXMgRnVuY3Rpb24gMSBvbiB0aGUgaG9z
dC4NCj4+IC0gQSBuZXR3b3JrIGRyaXZlciBiaW5kcyB0byBGdW5jdGlvbiAxIGJhc2VkIG9uIGRl
dmljZSBjbGFzcyBhbmQgSUQuDQo+Pg0KPj4gQXQgVGltZSA0Og0KPj4gLSBUaGUgbmV0d29yayBk
ZXZpY2UgZmlybXdhcmUgY29tcG9uZW50IHJlY2VpdmVzIGEgc3RvcCBzaWduYWwuDQo+PiAtIFRo
ZSBmaXJtd2FyZSBpc3N1ZXMgYSBob3QtcmVtb3ZlIHJlcXVlc3QgZm9yIEZ1bmN0aW9uIDEgb24g
dGhlIGhvc3QuDQo+PiAtIFRoZSBmaXJtd2FyZSBjb21wb25lbnQgaGFsdHMsIHJlZHVjaW5nIHRo
ZSBkZXZpY2UncyBwb3dlciBjb25zdW1wdGlvbi4NCj4+DQo+PiBBdCBUaW1lIDU6DQo+PiAtIFRo
ZSBGdW5jdGlvbiAwIGhvdHBsdWcgZHJpdmVyIG9uIHRoZSBob3N0IHJlY2VpdmVzIHRoZSBob3Qt
cmVtb3ZlIHJlcXVlc3QNCj5hbmQNCj4+ICAgZGlzYWJsZXMgRnVuY3Rpb24gMSBvbiB0aGUgaG9z
dC4NCj4+DQo+PiBBdCBUaW1lIDY6DQo+PiAtIEEgY3J5cHRvIGRldmljZSBmaXJtd2FyZSBjb21w
b25lbnQgc3RhcnRzIG9uIGFuIEFSTSBjb3JlLg0KPj4gLSBUaGlzIGNvbXBvbmVudCBjb25maWd1
cmVzIHRoZSBGdW5jdGlvbiAxIGNvbmZpZ3VyYXRpb24gc3BhY2UgZm9yIGNyeXB0bw0KPj4gICBw
cm9jZXNzaW5nIGFuZCBzZXRzIHVwIHRoZSByZXF1aXJlZCBmaXJtd2FyZSBoYW5kbGVycy4NCj4+
IC0gVGhlIGZpcm13YXJlIGlzc3VlcyBhIGhvdC1hZGQgcmVxdWVzdCB0byBlbmFibGUgRnVuY3Rp
b24gMSBvbiB0aGUgaG9zdC4NCj4+DQo+PiBBdCBUaW1lIDc6DQo+PiAtIFRoZSBGdW5jdGlvbiAw
IGhvdHBsdWcgZHJpdmVyIG9uIHRoZSBob3N0IHJlY2VpdmVzIHRoZSBob3QtYWRkIHJlcXVlc3Qg
YW5kDQo+ZW5hYmxlcyBGdW5jdGlvbiAxIG9uIHRoZSBob3N0Lg0KPj4gLSBBIGNyeXB0byBkcml2
ZXIgYmluZHMgdG8gRnVuY3Rpb24gMSBiYXNlZCBvbiBkZXZpY2UgY2xhc3MgYW5kIElELg0KPj4N
Cj4+IFRoZSBmaXJtd2FyZSBjb21wb25lbnQgZm9yIGVhY2ggZnVuY3Rpb24gb25seSBydW5zIGFu
ZCBpcyBob3QtYWRkZWQgd2hlbg0KPj4gbmVlZGVkLiBPbmx5IEZ1bmN0aW9uIDAgYW5kIHRoZSBj
b250cm9sbGVyIGZpcm13YXJlIHJlbWFpbiBhY3RpdmUNCj4+IGNvbnRpbnVvdXNseS4gVGhpcyBk
eW5hbWljIGNvbnRyb2wgcmVkdWNlcyBwb3dlciB1c2FnZSBieSBrZWVwaW5nDQo+dW5uZWNlc3Nh
cnkNCj4+IGNvbXBvbmVudHMgb2ZmLiBBZGRpdGlvbmFsbHksIGEgc2luZ2xlIGZ1bmN0aW9uIGNh
biBhZGFwdCBpdHMgcGVyc29uYWxpdHkgYmFzZWQNCj4+IG9uIHRoZSBhc3NvY2lhdGVkIGZpcm13
YXJlIGNvbXBvbmVudCwgZW5oYW5jaW5nIGZsZXhpYmlsaXR5Lg0KPj4NCj4+IEkgaG9wZSB0aGlz
IGNsYXJpZmllcyB0aGUgaW1wbGVtZW50YXRpb24uIExldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFu
eQ0KPj4gcXVlc3Rpb25zLg0KPg0KPlRoYW5rcyB2ZXJ5IG11Y2ghICBJIHByb3Bvc2UgYWRkaW5n
IHRleHQgbGlrZSB0aGlzIHRvIHRoZSBjb21taXQgbG9nOg0KPg0KPiAgVGhlcmUgaXMgYW4gb3V0
LW9mLWJhbmQgbWFuYWdlbWVudCBjb25zb2xlIGludGVyZmFjZSB0byBmaXJtd2FyZQ0KPiAgcnVu
bmluZyBvbiBmdW5jdGlvbiAwIHdoZXJlYnkgYW4gYWRtaW5pc3RyYXRvciBjYW4gZGlzYWJsZSBm
dW5jdGlvbnMNCj4gIHRvIHNhdmUgcG93ZXIgb3IgZW5hYmxlIHRoZW0gd2l0aCBvbmUgb2Ygc2V2
ZXJhbCBwZXJzb25hbGl0aWVzDQo+ICAodmlydGlvLW5ldCwgdmlydGlvLWNyeXB0bywgTlZNZSwg
ZXRjKSBmb3IgdGhlIG90aGVyIGZ1bmN0aW9ucy4NCj4gIEZ1bmN0aW9uIDAgaW5pdGlhdGVzIGhv
dHBsdWcgZXZlbnRzIGhhbmRsZWQgYnkgdGhpcyBkcml2ZXIgd2hlbiB0aGUNCj4gIG90aGVyIGZ1
bmN0aW9ucyBhcmUgZW5hYmxlZCBvciBkaXNhYmxlZC4NCj4NCj5JIHByb3Zpc2lvbmFsbHkgYXBw
bGllZCB0aGlzIHRvIHBjaS9ob3RwbHVnLW9jdGVvbiwgYnV0IHdpbGwgYmUgaGFwcHkNCj50byB1
cGRhdGUgdGhlIHRleHQgaWYgbmVjZXNzYXJ5Lg0KPg0KDQpUaGFuayB5b3UuIFRoZSBjb21taXQg
bG9nIGxvb2tzIGdvb2QuIEkgaG9wZSBubyBmdXJ0aGVyIGFjdGlvbiBpcyByZXF1aXJlZCBmcm9t
DQpteSBzaWRlLg0KDQpTaGlqaXRoDQo=

