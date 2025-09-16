Return-Path: <linux-pci+bounces-36218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8026B58C11
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 04:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24707B25A9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 02:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D622AE7F;
	Tue, 16 Sep 2025 02:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Oofwz7+U";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Oh+q3ja7"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4022686353
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 02:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991411; cv=fail; b=GZw0OoTMiWI6CBKV2K+k7TCTayOv6P2ErwO+PtaDMonjl50w93Q+XpYl5hSB/HB3OpHkGwDwWC+3bhp3X9DZnwvQOec2tGdybLwdsVbo1JEWzwc6o3UELN3wyUjGt+7rPHXVxQd1lTOiqoJINmQplOzZElYXBdymoxGFzN1lUhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991411; c=relaxed/simple;
	bh=trrrFE8jw0gL0qtp51YJLwYySs9OwFcVRbDpTwcoQZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c5iaXxMLv3mQvQdXGPM3yqS/tNxnDcW5/gFXFC4uFmutkDZCX0BqC6PMiqQRMPmYTXE7uE0qOZe4/HPe1IHspGMBBSl5yt4Ektp6xkzA2t/3N1mQCZkfEjDRt4Gqd2xbDJStsBt0ECGpDhA1Wk6Z0belQC9xVGChVX6Zot1F8cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Oofwz7+U; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Oh+q3ja7; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757991410; x=1789527410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=trrrFE8jw0gL0qtp51YJLwYySs9OwFcVRbDpTwcoQZg=;
  b=Oofwz7+U6L/Miy+dfZLYkTVsNXUKDAz2QOUxAR5+mn/XK+3aYTr7K6B1
   NVCT7QbX3tlcz8rW9bbNoROKlt/d4LaVwMm8ysbMVZPGxAGpGWzz8rp79
   Up9LZNHVDsZqZZOACYm8kE2+zG+DlVWgPeVtCE1OCXS7z+pMtXFYrAJ2q
   5NLaXllYgZeNAvA4QYbYAcan/JtBrmcDmeyeJAgFNc4DgbsXmpZqlFkGS
   SWk6je0u4uY8DcS6cAbVP7rDxAAHS5M0/WBXdRwoxdVZx4XuRQeD5XfXP
   R2221fvXWehe54NueCr7ZZXtbH+eNycC3c9xKmozQY1TVG5Q/BPWigYWo
   w==;
X-CSE-ConnectionGUID: n8SDtyjVTOWmPE4Fd30irQ==
X-CSE-MsgGUID: QlwJ4TvkSfeQZJcEgMPMzg==
X-IronPort-AV: E=Sophos;i="6.18,267,1751212800"; 
   d="scan'208";a="118666064"
Received: from mail-northcentralusazon11012059.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.59])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2025 10:56:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGl4gMCMuM6bvO7MscvADDVjdr+lkq7cZz6BpMxvzdudtbvATxoI8+OCyhCJNxqf9DMSRssnh9TFUZ6JFbiyWvSFzWRiyYO2QBwfdE0SGXdpcDG+6WIHQ6IdvNELuNSqBxgzgcBWHhtaljdWcOqBtQb2vpYfmeaU6haT7CDYY+QBoymtDAzCRyEH9VtEfR3tJ2vW4r6zNUgAX5hnDgHQqIwcLg2eMqr4nIxSUEdbv5SRgM3U1N1k6nEMuQJNlTni88T0Hqu/+PZadmUkCQ6jBgmhjpPghM8U+8ovZW++pOGev6ybdOM3/cCExD7G+2X2Om5KpGRULspnIkI3rfmckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trrrFE8jw0gL0qtp51YJLwYySs9OwFcVRbDpTwcoQZg=;
 b=V5ny0DHsojZKfoI/EL69Yz+3NvUx9Qv0Bc99pv/+p5sQlhXM35z8///pHltuyYvJS10YJg1FTyfGypHzVJCPi2zLq1mcpcMhJCMzBlw3keRIihdyoisEQTeZwza2Te7ftTbfdevb/5EZ3d/z0TMIIdga/rvfHez62DBHi+akYaCtNqnMAXaViYt3O6hYy3XDVMXlzLfSkkFiDJLNcuLwyCAxD1uZS1+ZjV/k5ca7eyhhdCeBlH9/DkMB3YnxB4SK4QY/fLL0xWtOTLg+Z+cztmsWzw5siAzEQndqZYvuMXusomeT8V1FbbyHNhq7pA0wscyvXuKYpwg726cp/OSaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trrrFE8jw0gL0qtp51YJLwYySs9OwFcVRbDpTwcoQZg=;
 b=Oh+q3ja7wFy/YFLq8mbRvW4Iaehzm0B0KmFJj9fpXrHKQi0e/OfpgC5R+ve37X7FaKiQoxByfU9rqyWmViWHca/+8aC0zWJLq+FwPZVP8k4B9mcd/gfoCGMqGJ67hydTtjUEvQ4wV9W/MCH7W+qDdQ7LrLRWZbiHYcCERB7Wd+8=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7472.namprd04.prod.outlook.com (2603:10b6:a03:294::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 02:56:47 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 02:56:46 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, Niklas
 Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
Thread-Topic: [PATCH v2] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
Thread-Index: AQHcJHIEIZQiUY+UdEC7PxfTgh2LKbSQpn6AgAR7sIA=
Date: Tue, 16 Sep 2025 02:56:46 +0000
Message-ID: <hc5iinz4tn6qr5rdb22ththj3hgxnaibmivyjmpmx6xah4ynji@trazkhurddih>
References: <20250913054815.141503-1-shinichiro.kawasaki@wdc.com>
 <20250913062901.GC1992308@rocinante>
In-Reply-To: <20250913062901.GC1992308@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7472:EE_
x-ms-office365-filtering-correlation-id: 35bd7b50-959d-4608-098e-08ddf4ccacf0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021|27256017;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3FEMzhleHMyaEc5SVZoZXhJa2kwd0JmWVd0ZkVsSEpybFc2M2plc1p0UDJF?=
 =?utf-8?B?MGtta090dUF5ZWdETG05cXJrQktHdlFzbWZsei9HVVFzSGN4WkxSRGwzTWIw?=
 =?utf-8?B?SjZmVWl3Uis2YlhUNTNkMHRKZHF6VExseXlldkg1SnhpK1VBeVpISGlXSFVt?=
 =?utf-8?B?NG93RHdkSWNQVk9SZ2szeHlZTVlWMkxWNzI0clcxSCsxVDBQNlFpQk0vaGlm?=
 =?utf-8?B?MDZtRlhFWTVpcWhXWUtERWszWTVBSTZhdHNIVGRMYWp4SXNjcThleFg4RCt3?=
 =?utf-8?B?aU1LSk9rNHJaVVdVdHhSeUxqenJrbnVZeXVXbzRZVm5ZajhPNzJnTy9BblJt?=
 =?utf-8?B?bkhsaXRlZmxTVXhyR2RHSEpOcjJDckNLU0JSTytpS2VLQW10L0VobmVnZFFP?=
 =?utf-8?B?K3ZrQTFmVDF1ZEU1Y2ZiNEZWUzRlVU5tNVNmbjVZZmRDUGhIQXQvYTUxV1Q4?=
 =?utf-8?B?ckxtTG1Qd0tjd3E4bWxMRVpncUxoRWcyVDk0OXc4bHFhaHRMSnhCUjE5QTd4?=
 =?utf-8?B?dXJ6dk1QSTFLeEkwbDB0RUhHaTRsYmRyVWJMVG82WjcrUFJleXFqR1AxcXIr?=
 =?utf-8?B?RU5wYnNVMkVsK0g2bUhCRTZsQzRXQTZvWE5tQzU4R1Y3ZnNzalRPZVFOWFE4?=
 =?utf-8?B?WHZOTHpoYW9OVHp5ckNPUWFzVFpYelJxdkh5ZU81MExPM2pnR0Nac29KTlRr?=
 =?utf-8?B?SW1ralU0RERkcEJyR1B1WFBjOSs3QkY0YXBiL1ZkUUxqZER0K1hnU0M1U2JG?=
 =?utf-8?B?RkcvS2hTYytoNCtVcXZtSUwvSWprcU1yd04rRzFZTVRPeDA2SzdOYTJTY0li?=
 =?utf-8?B?R2pCbHJNK2dLYzgxTnNjQmtzd3NuSktHMEMvcE1SdlAvTnZsd2Q0UHVjZ1B0?=
 =?utf-8?B?OE9NbmQyQ0I1eWxXaDVVSHp0NFN4VGczQnhaRjRYMklFWTBPQ3V2T1FiNzFs?=
 =?utf-8?B?ZXBYbk1BWjlURk9LVmdsYnBFQys0SERRUlJPbG9uSjNsd29iQ1VQd285ZXV5?=
 =?utf-8?B?ckxSSHlMTjlKVHRvT254WWhBZlZtaFJ6bGNZUnZxRVNDNVFXeEhKMitIdW9X?=
 =?utf-8?B?V2luT1AzSmR1Q0IrajdDLzJ4bVltVUx0bmJOSWh3R3hkaGJnUFppNVlRTFdx?=
 =?utf-8?B?Ylc1RDBXR2dYK1lKeEJCYnpjbFhGeHdybGwvTkZxTGNBN3NEdTVDc2FwajRv?=
 =?utf-8?B?YnY0NThmd3ZLQy9adzJ6eWIyQXozd0k1Q1pRM21oYjdIQ3dLdVAwcHVINkUy?=
 =?utf-8?B?V2Z6WG13YTQ3ZHVaRkhWbGRFc3B6NUx6WlEwa1pBWjhad29UNitNcTIzbkJV?=
 =?utf-8?B?cmp4QzN3VFZMS3FnakhrV0RheTJzaVB0WFpaZzdBeS84eVpzMnBPTStZa09P?=
 =?utf-8?B?bjRMWmV5RmhPOFU3WnlRTVQvQmZRUGxGdzBXdEhXRVN6bVRVUFV4ckp3K2xD?=
 =?utf-8?B?dTg2ek94UzNLYXZDaEN5Y2UzbzZ0ZW05bldpUHlMT2R6Q2FTM2sxWi8rOGJE?=
 =?utf-8?B?RHBFZDZRZnBOdnJnNkNIdWR1Sk9Lb2hzeklnM01DSTdRVHZkOXhYK1FYZGJB?=
 =?utf-8?B?UlJoMzlwWUJqZldmSTlJT0dsY3kxZHpEY0w5bFduRHdvanNtV0pWWldFaVJ0?=
 =?utf-8?B?SWhXMllPRCszV3IwNStNaHNIOFNzakplbVVyWGRIcWVwdFMrb3NEd2dWbFY0?=
 =?utf-8?B?ekZ1c0swK0xBWlVTV1owM0paS1lmcHlwbDVtbTVmY0pwa24rYzRJNnZTSDd0?=
 =?utf-8?B?algxUHR0RXFiaENBemxENDlEZmNLWk53ZVBRRDhzU2FFUVNycUxFNDI1OUUv?=
 =?utf-8?B?R0xGZXUrNGhJZ3NjTDdURWNiL285RWNnU1lkcHdBcjJsUERKT00zUUVQU0Rz?=
 =?utf-8?B?cVE4T056VXdlcjhNenhiVW1QTjd3QU4xSW5aVzVlRHR2Rkplckd5c1lldjJn?=
 =?utf-8?B?QTArNXlTb0xQTkViUXkySEMreVBLckdCeVZlTkRhQ1htUHlYWnZEVEZ2NXlR?=
 =?utf-8?B?czBSUmtvTmdZUlZYWTV4TjhNdFhqVEt4S2xhRUlZMjQwTUpROWwvTVIxZFYx?=
 =?utf-8?Q?Zw5cWl?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1NGUzIvOGZhZ2g3WmlSWEdBdElxL09tY1hJTnB6VEZad1Z6dTFHSnAvL21a?=
 =?utf-8?B?MFpBemR2UXFxcDRwYk5Md2I1dHNsbUI4VDlNcC9sY2hra2hoT0k0NjN0RWk5?=
 =?utf-8?B?ZFNZdjk3aW1ndGsxWUVKK3ZGT2xnTlhtWG1KSHhFZEN0bys5cW9kSEJvaW5n?=
 =?utf-8?B?VU1KZndzdWdIeXVsYzlramtaTmRZb3oxTFcvL3lHRVhJNGRPbHo0cFhKaXFO?=
 =?utf-8?B?ekxpNFJqZm1Ob1RldGJSa29wKzdiNjI4V040MmtIVk9FeU9wWGZCNzUyV3Nm?=
 =?utf-8?B?SmdIcXdtNlJtNUh2ZGJkd092REV0KzQ2S3QyQUUrR01sZSszeHMyYkRoUS9K?=
 =?utf-8?B?M3lmUHVTVnI4cmtkcHp6b3FUeU5aYWJZdEJWNGdRa1BOamM2NVVWaW9rMFM4?=
 =?utf-8?B?K1dxb0k0OFFHQklKa3ZISENweVp3RUVxOHp3R1RrRGk3ZGFyOG5qSHlJQjVi?=
 =?utf-8?B?Y1RKOE1uVkNjOFZFZG9FU0FMVXh1dGo0bGo4VDRKZ0pITlBjTlFrNnpkbDNJ?=
 =?utf-8?B?L09xN1JYL3ZpNUNSQk1ZaUY2MzhlekFTOHUxWHlSWmkzTDVua1A4bzYramQw?=
 =?utf-8?B?bTBwc3lMbkxMZERKN21yRy84M09MNThyMGRmdHV3dVVFVHVBTisvdzF2TGM4?=
 =?utf-8?B?YUJuUTB0OWFVNXY5cDQvRXpMc1RqZ1R3RDdOSjBzZXFINEMzREVBMURsUTla?=
 =?utf-8?B?MHVUeDBZL2hETE1LTmdTMkFMZTNaYmJBTDFKOUNpSG9DTnp6eDkySEdaeU14?=
 =?utf-8?B?OFVienl1VUgyUnl5WG1JQkRvWDgvdVUwZENhRVFkSGlqaUFjQ1dNRm51L3Fh?=
 =?utf-8?B?NGt1b29CSVR4eDJLTVVTRlBDQzRscmhhM1JBaTdMc0VLWGlvbU02OVd1ZTJk?=
 =?utf-8?B?eHBycU52VVdDVU00Wm1NdTI0M3dCYytJWk9hZ01uNVBlQjh0amNTV25veExF?=
 =?utf-8?B?d0hsSHVLcUJ2YkZLM0J2UTZ1OFJxVmV2ZTJBcWVZeUxFYXpCUVMrZUZxcHc3?=
 =?utf-8?B?enUwQnhabUtCN2hSQ1pRZSt6Nm1seVJqNTh2QTN3T21lVkZ4dDRLcytCc09L?=
 =?utf-8?B?Wm1paytyQnpYRDlsSjVlK3RsVVFlRy9xSWhRUUgzQ2NOaFZTUlBIQXZPNmZK?=
 =?utf-8?B?OHRFVTVFcW5FNlhCTUp5NVo2WGlCY01RVVZMMWp0N1d5ZjQ1N3lLSDJEUFgx?=
 =?utf-8?B?OW9kbTlTSDl1RXg0djd0akQvaDZVRkd6dnBWb0VSZVFvbGZFZG5WbHFGMTNW?=
 =?utf-8?B?M3RkUnVNQ2VlYkw1aktId0xCL0dEYzRCVHp6QUZ0cTRKbklyNVRRcUJHdzVu?=
 =?utf-8?B?UlhjaVk3RFpXL2VweHV0MlBZbUUyNXRSMVp4YVNrcytIYUVXWGw5d2dkWmFV?=
 =?utf-8?B?TlNXblNCaFJVQ1pmNWZTemdGNnlVNU00NEkxMlNCakthUkpQazF2Y2FyeVli?=
 =?utf-8?B?ZmJ4NDZ1T2dxbnhjQk12L0YvN1VvQnI5RGFpNXUvUnBLeHdMRVk5bEp2SjFU?=
 =?utf-8?B?bEpCT2MveHB6dlp6ODMrUUdnUDdMR3o1cVNLQjFqTFBWdE1LdEVxNnJQU0x2?=
 =?utf-8?B?QjhWUGhiK1dZZktmUVhRTmVHYUNZM1kxMlMyU2dRMkdKdDg2NkJla2lhbVJw?=
 =?utf-8?B?WS9aY0YzT3ZQZmhNQ0V0dENwbkRySW5JdnpxLzJLYlZLcW9NVG9WaGV0WkN6?=
 =?utf-8?B?bEplalBRa0l3ZGF6bEY4OGJvbnphUDg4ekgxUHUzSlRBYkwyc1JCRlpUQS9J?=
 =?utf-8?B?Ni9RaXBQcWpiczd1eGF5MmIxUXRTVW1DNjVSMk1VdG9Ia1pvWW0wTE00cnIz?=
 =?utf-8?B?eE9keDl4eEszUXNjZm1VWlVhQXpTa1lkS3FZUDR4S0liZE9LSXMyL0w0cG1V?=
 =?utf-8?B?Z0Q5VGN3by9uamZId01qQzhoVFlXeGpFSWplQnBHejd2T0d1TmlORjEydEY0?=
 =?utf-8?B?bGV3WFNPTVBVZXVyN2pST3pHdEdHYzVVRStHMWZjNkVvUGlCM3RlWFRwUkNQ?=
 =?utf-8?B?T3VUcURYSmVnaXhWYWo2ZWsyOUpGM0F2YkxPbUE2NE05Qkd3Mkl0MVlZVW5p?=
 =?utf-8?B?bWNBZHpYMnRoMjVra2JRT1NaTjk3YmcySll2cTJYaUE3MzlNZFYxTUFMVlJx?=
 =?utf-8?B?aWI0bVNWVXdTbHFybG1jM1psZWd4alJXUHl0bEFaNjh6algrZE0xVnVlajVl?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <212135AFEF1D9D41BDD26CCA990AFA01@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g98QyAOEjhX3DA8uksYYp8AsibdclwTwcTOJTaL1cXR7m4ZGhbV1E8S4sVkzzNZQfmZkvEJFTgctmOey+phDYhS+fzF5fjpFVglawS7SntYft9F4l6XI2aFz4ZoLCB1Q0iOc46pdTXef2WztjNkf+fiAiA5rd+/B2CKPZibyNUoF5bYhYKKtLW2NZqiIC3oomohx+1MhdjYAXnHLWmkvKk1MwbeUnegZDAN/zLuutPLdRZfRjUWDgrTY+YeRqhIXnpcA6mtapo13BF1ZXzKHQ1GMLi+/ejZUBKrqXXCL1Ny1RIVDAd2OjDW/j11PPjoQ8DV35l1rAd/WF7k5qV2n96x0xTRb7xwin6m+djw4Sm6uFe1+vuZQjRKXG7H/sluHUsPvvpApnnOozRQqbqVtWQir+Sm15JEeMyBcaWuGiHWMdp3AiQ6wOfMYZOBCnawyedjZZYzJJV7u0kCjtV7g6KFXK3jJfOmjaLVQqfwD3eASYRHi3OMjV6EtsD2ODf0xNWUoiQCv4dHumL8Wj1m06mwvYQ19hdUDkyqGFobCovM5pjaBexCPcckI1Sm7Tt0jXPKGLGb/FsZ/eVPtfP7dgkHusfIZgVrHCUuWdzgPd7cSXkqNTUtW6sC/eSWeW72a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bd7b50-959d-4608-098e-08ddf4ccacf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 02:56:46.7957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5JZt25nrgma1lTqbJ/V2E60E5hlXIidPqrPl3DzeLc2P17Rtj7BKafaJwlkOQOMajOkrtyIOMvwscezmYTL1RUUdlYInj6wX2v1MsdnZIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7472

T24gU2VwIDEzLCAyMDI1IC8gMTU6MjksIEtyenlzenRvZiBXaWxjennFhHNraSB3cm90ZToNCj4g
SGVsbG8sDQoNCkhlbGxvIEtyenlzenRvZiwNCg0KPiANCj4gPiBXaGVuIGVuZHBvaW50IGNvbnRy
b2xsZXIgZHJpdmVyIGlzIGltbWF0dXJlLCB0aGUgZmllbGRzIGRtYV9jaGFuX3R4IGFuZA0KPiA+
IGRtYV9jaGFuX3J4IG9mIHRoZSBzdHJ1Y3QgcGNpX2VwZl90ZXN0IGNvdWxkIGJlIE5VTEwgZXZl
biBhZnRlciBlcGYNCj4gPiBpbml0aWFsaXphdGlvbi4gSG93ZXZlciwgcGNpX2VwZl90ZXN0X2Ns
ZWFuX2RtYV9jaGFuKCkgYXNzdW1lcyB0aGF0IHRoZXkNCj4gPiBhcmUgYWx3YXlzIG5vbi1OVUxM
IHZhbGlkIHZhbHVlcywgYW5kIGNhdXNlcyBrZXJuZWwgcGFuaWMgd2hlbiB0aGUNCj4gDQo+IFNp
bXBseSBzYXlpbmcgdGhhdCB0aGUgZmllbGRzIGNhbiBiZSBOVUxMLCB3aGljaCBjYW4gbGVhZCB0
byBhIHBhbmljIG9uDQo+IGFjY2VzcyBpbiBzb21lIGNhc2VzLCBhbmQgaGVuY2UgaXQncyBwcnVk
ZW50IHRvIGNoZWNrIGZvciB0aGUgbm9uLU5VTEwNCj4gdmFsdWVzLCB3b3VsZCBiZSBzdWZmaWNp
ZW50Lg0KPiANCj4gV29yZGluZy13aXNlLCB3aGV0aGVyIHRoZSBkcml2ZXIgaXMgaW1tYXR1cmUs
IG1hdHVyZSwgb3IgbWlkZGxlLWFnZWQsIGl0J3MNCj4gY29tcGxldGVseSBpcnJlbGV2YW50IGhl
cmUuDQoNCkkgc2VlLCBJIHdpbGwgcmV2aXNlIHRoZSBjb21taXQgbWVzc2FnZSBwZXIgeW91ciBj
b21tZW50IGFuZCBwb3N0IHYzLiBUaGFua3Mh

