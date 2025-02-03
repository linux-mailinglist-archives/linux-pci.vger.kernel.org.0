Return-Path: <linux-pci+bounces-20657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05761A25D9E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 15:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871D13AD9F9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2623D20AF6A;
	Mon,  3 Feb 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="qFU+Dtjq";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="M+M19SKB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B13209F58;
	Mon,  3 Feb 2025 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593902; cv=fail; b=D1UmE3NnlaWsolJIagZYTFWFGd5iNKLeHPaWb1dqdzRI8JnHg0mFNFVHYD9cQQbWQzXBbEs1Av+JPV5ZwijPjZFOIXIZ/hIEOVySSxzqW09CaUo2PO4vXSzRL66BMWgEbHNac/qc+WHylMfEVQ92v48GpB/i/vqYPhPo7aelXsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593902; c=relaxed/simple;
	bh=3IWxPcLwgvhYadgjMHwhiFx6BbHGmuS30ABc1JnICoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J/KoVMx7IZKVdYmk/KltAeExk0H/rlmvHWr/RlyWtdPhwj2npVTPdb7vnvzyvm1hVWz9v5FxWawtnz31S5mNYeHNWi1647DaUZIK2Dn8E0+tgibD2Vtts7RG8eQ2A7nc/bzLeKQ0kEIC6pzHnRmEKFQtHlJTEalgtnC2UhyDiPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=qFU+Dtjq; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=M+M19SKB; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513AjAN6027280;
	Mon, 3 Feb 2025 06:04:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=e8YVVb3EGudIjJanKvJRmOHk9mFHVoK0+R0X3gyhjO0=; b=qFU+DtjqVD34
	IwFVlKXlfOPuac934/CvBfDMsDNf3avDVFVU9Gspd0rUowt/A8yqP6NL5VL4ZPkl
	nbWAY++PF0557fJKEkCltFGOiM5GIGokTGuJQGBm1nC0LZXRh07XYENt3JWTfMy4
	hmK4jjXeRDrTIilp3ZaPUVJuSelbXtMN9NAS360xefA8/bMu9O3eljFHqMCj/R98
	DXzFm4HjVCsJaER5ZhVjeetP8CVQrHOkGMGsTztip2FigKYDynp4m9nipTxAFo/g
	7NxDyispdZyUuVGKOGlCDLKsT4EmuF84Y6otagTNrVIDPd2994Wd+EdoItaLtMoQ
	AXChnTa1gw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013059.outbound.protection.outlook.com [40.93.20.59])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 44hg2xddrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 06:04:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LORQLbl1hJLN3SUKLBJoLclU6mUe5U8xMGvxiUZfx9ttR+suo40Ec/VMSAIVFEETS+TE3TRKCWHwabCVozcUXzX1nI9ehqBQY4n4ck5zJWSUhzCy7FlzZRGGi559SrT54kNhZCVA0VoA0s0LK4WurojTSkt3gy64dT/Cepi9w8RaJjG3BfqrlDXIJrKUCHhclAz8HwWHnM2NmsZL/zgtgrLHh3NdDVbRcyZBmJitUcBfs6bu/0VX09ubysg29rciFXcBEv4ZlM2N7liyOsKDmuoK7/bemWD8AUaL/8cUOTFOxShhzc0NwcXJWocQBGm2sDl9lGK/hhCbXZBzduA37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8YVVb3EGudIjJanKvJRmOHk9mFHVoK0+R0X3gyhjO0=;
 b=OujmCnJ5qA03Ng1mNI5HsJGnotlO+d1ODec36FYOUay+1+j+PIJALbG9z8XpvtPzGcRNuv4yaIun/cd0BkAZQsOMoBXr7tmcHdqXgwjUH2nCPKrb4iKgYVorF7F7RAiFJ73gnUqkzLvF3K6/z64+ac6hALS8W92bss9RMTd8NxoIba11t4PCY9OVptxSM4iMfVngJDLtVevxVoSP6NkbkjK5zxNgkBX22CXFbo5vcRA2ZtTZ7gv22rtZMMjDHeE6uJvaLomb53Yp0c1b8s0I6KSuH7SZMNexDex9fq3NGExQd39nrv1ZKIsPOwMu5y3iIiE40AIKJxlgHKUY+CkR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8YVVb3EGudIjJanKvJRmOHk9mFHVoK0+R0X3gyhjO0=;
 b=M+M19SKBYYa3+7uKTJslKcvH7ht7rZFtqhV0ZyKbrmvOk/cuOiQ72GAmwTbavtioPMad12N+LuI96XAixaT5chDd9EEQmwj0NHqjZzijNmbAcpMtkL9nnDq9/7cxbiQ+VGUxUoB2NKVAPzAQD5SB20Emw+4HzAQSrtPo3Me0yQw=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by DS0PR07MB11071.namprd07.prod.outlook.com
 (2603:10b6:8:1fd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 14:04:17 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 14:04:17 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pci: cdns : Function to read controller architecture
Thread-Topic: [PATCH] pci: cdns : Function to read controller architecture
Thread-Index: AQHbc9dkPe/t53rtZE2/3AwJ6A7zh7MxNvyAgARnm0A=
Date: Mon, 3 Feb 2025 14:04:17 +0000
Message-ID:
 <CH2PPF4D26F8E1C25BF05614F8C8293EECDA2F52@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1C5FA4D55D4271BA4F6F0DA2E82@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250131183835.GA688678@bhelgaas>
In-Reply-To: <20250131183835.GA688678@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iZjZhNzFlOS1lMjM3LTExZWYtYTM2?=
 =?us-ascii?Q?OC1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcYmY2YTcxZWItZTIzNy0xMWVmLWEz?=
 =?us-ascii?Q?NjgtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI2MzQ2IiB0PSIxMzM4MzA2?=
 =?us-ascii?Q?NTA1NDQzNzc3NDYiIGg9Im02d291Ry9ZeVNYQlVPcUx0c2VTZmF3MWdiWT0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUdBSUFBQ1N6OEdCUkhiYkFXRURCTWtwOXVKTllRTUV5U24yNGswS0FBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQUFzQmdBQW5BWUFBTVFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFRQUJBQUFBaEZWOHlRQUFBQUFBQUFBQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?akFHRUFaQUJsQUc0QVl3QmxBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFB?=
 =?us-ascii?Q?YVFCaEFHd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BWkFCdUFGOEFkZ0Jv?=
 =?us-ascii?Q?QUdRQWJBQmZBR3NBWlFCNUFIY0Fid0J5QUdRQWN3QUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQVl3QnZBRzRBZEFCbEFHNEFkQUJmQUcwQVlRQjBB?=
 =?us-ascii?Q?R01BYUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUhBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVlRQnpBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?bmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhBQWNBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdkFIVUFj?=
 =?us-ascii?Q?Z0JqQUdVQVl3QnZBR1FBWlFCZkFHTUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJB?=
 =?us-ascii?Q?QUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpB?=
 =?us-ascii?Q?QmxBRjhBWmdCdkFISUFkQUJ5QUdFQWJnQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFB?=
 =?us-ascii?Q?QUFuZ0FBQUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3QnFBR0VBZGdC?=
 =?us-ascii?Q?aEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFjd0J2QUhV?=
 =?us-ascii?Q?QWNnQmpBR1VBWXdCdkFHUUFaUUJmQUhBQWVRQjBBR2dBYndCdUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCekFH?=
 =?us-ascii?Q?OEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFjZ0IxQUdJQWVRQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQXhBRUFBQUFBQUFBSUFBQUFBQUFBQUFn?=
 =?us-ascii?Q?QUFBQUFBQUFBQ0FBQUFBQUFBQUNrQVFBQUNnQUFBRElBQUFBQUFBQUFZd0Jo?=
 =?us-ascii?Q?QUdRQVpRQnVBR01BWlFCZkFHTUFid0J1QUdZQWFRQmtBR1VBYmdCMEFHa0FZ?=
 =?us-ascii?Q?UUJzQUFBQUxBQUFBQUFBQUFCakFHUUFiZ0JmQUhZQWFBQmtBR3dBWHdCckFH?=
 =?us-ascii?Q?VUFlUUIzQUc4QWNnQmtBSE1BQUFBa0FBQUFCd0FBQUdNQWJ3QnVBSFFBWlFC?=
 =?us-ascii?Q?dUFIUUFYd0J0QUdFQWRBQmpBR2dBQUFBbUFBQUFBQUFBQUhNQWJ3QjFBSElB?=
 =?us-ascii?Q?WXdCbEFHTUFid0JrQUdVQVh3QmhBSE1BYlFBQUFDWUFBQUFFQUFBQWN3QnZB?=
 =?us-ascii?Q?SFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY0FCd0FBQUFKQUFBQUFBQUFB?=
 =?us-ascii?Q?QnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCekFBQUFMZ0FBQUFB?=
 =?us-ascii?Q?QUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWmdCdkFISUFkQUJ5?=
 =?us-ascii?Q?QUdFQWJnQUFBQ2dBQUFBQUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFa?=
 =?us-ascii?Q?UUJmQUdvQVlRQjJBR0VBQUFBc0FBQUFBQUFBQUhNQWJ3QjFBSElBWXdCbEFH?=
 =?us-ascii?Q?TUFid0JrQUdVQVh3QndBSGtBZEFCb0FHOEFiZ0FBQUNnQUFBQUFBQUFBY3dC?=
 =?us-ascii?Q?dkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFISUFkUUJpQUhrQUFBQT0iLz48?=
 =?us-ascii?Q?L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|DS0PR07MB11071:EE_
x-ms-office365-filtering-correlation-id: c6ece4bd-7c1a-42ec-63a0-08dd445ba606
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?edIXqeDM7TDuNWl5f1zSfGFIU/GqwryRCMtpq6q55yqnYaOdQpxBh2yyewZq?=
 =?us-ascii?Q?q8af/tQkY/ThQIjfntExU+sPiq5BtKPX7OseKHXDsxxwybKmdUptHFHGL2zU?=
 =?us-ascii?Q?qT7xBk/peVnTmWsviRgacGxXUWxpe8wWrcBsglBR4vcpL6WdZc/uFbDHthTy?=
 =?us-ascii?Q?cOOslJYOcoPaaNNsH5FqjGdU+kj6lWPULpzXtaECC2swGXzvpP5Bk+E1Y6By?=
 =?us-ascii?Q?vJeCxDL94ZalAA71lB7W5zr0U3XjFSKuXRcL4bO3GCtIeQwt7zUk8SHXOnNT?=
 =?us-ascii?Q?/8cFMD5XRThEv0dbFVGbqxgdF/0DArM9gVk2Ws8DN9xCwp6iUp/sEQ0qHhDr?=
 =?us-ascii?Q?iO8kYUwkiAv+TJeUTO9oqyfzllNZsbS4wrAO/Sz7MakndumwQOScKU8VseLq?=
 =?us-ascii?Q?Ef6Ifg8XhTtgPOzJHWAJw6jXyOh8KTWYcPMuWEfl7nKlJhTWayLmzVJq/Tzo?=
 =?us-ascii?Q?087ffwZzoH2sx7xR1Niw2vSO82JwsHKonjsV/pjVYT4808oU2oZKiY4QLSLe?=
 =?us-ascii?Q?7YbnGI31JYAUwfTepv6TQ4SLMQHv9bYzlDBHiGDy2Ot0zaP7NfQmR1W8ADj7?=
 =?us-ascii?Q?iMz747mP+WJO33q4NJz5M6RkOOsnV5k7Q9ODoOgfcTh3pKOok0Bb7hbXZsZg?=
 =?us-ascii?Q?QJW32rG6T68dIDT5yg6AIvChMcjPXe1xOBBDcUqn6NtVU1FeqSUmAb8P2Zx3?=
 =?us-ascii?Q?GTFpAJ5atrJsAD43gzSoTZKgEZiA2Or1rpaPe9BHHg0ISYF2/CXjKDSi+bOZ?=
 =?us-ascii?Q?TyrjNGxMJk9Uc0Cvw9qjFdMdbPa3/FqLWyT8VwFBs+HWXHanb/vvascdBLC0?=
 =?us-ascii?Q?6yOmLlRDXwuFeWlBgWcPK1GJhsUwvfVqqLTs55XT50NJx4os2KAdcxB6ch8Z?=
 =?us-ascii?Q?aoWlm4n58R8Y9cG1XSof5+y+zVmcEAlsS8n2vbJBURX9O3Aa6XOV+qQFRiLP?=
 =?us-ascii?Q?pcfg4ZadA361DjIDAIThFi4+51H3rUPU+Yj3j9ofQ5MTn8rn+TR0rnYT9FKs?=
 =?us-ascii?Q?xYAGlyEJWx8p6WJsrT9EFoKIlByZcAXF5vNxGH4OaN/uSbLKdrpepmJQNMtm?=
 =?us-ascii?Q?He33T6C2yUejItY/32lVxf1Yg7PlAwbRrJN/xW4gnZfL3rrgIu8B+rTBnIIH?=
 =?us-ascii?Q?nrJewkoQWO4UxzEJI/Nvw56caVt/s4+rdQFaucC+V8ApV6wqqIbiX+JD8RmB?=
 =?us-ascii?Q?pIpxDtlWH6HzXia0u5INimTOBrL9dtmPGnTLDFmvpkQAlcQQzAxnZj4gkRdg?=
 =?us-ascii?Q?vrPEsnhy8uY2BV6AhSz+s0pD4N5Zy60SUf2yZ/9MdhTey7iTyfIrLzfLp+kM?=
 =?us-ascii?Q?SP4LTcs58p1D8Vte4AQ8PES8HmORH4P/rJSh1FG8VoN206zSVX5FeUw+epCz?=
 =?us-ascii?Q?1uJksqaAGb987Lntu/3OTj1/+WLfxO5c9mE/a/Rh1i1dba38Yg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lQhdEXEmiXwTXOIjwMCUknx9YnPjXtRrlbya16GOc15L2eIB+ZIeUGiILTqp?=
 =?us-ascii?Q?WRvoXfvkWvB5GjvPBNUiLqpS2njEolOqH0jTdZMw5m4qvmY7BKo/mjNXN4YN?=
 =?us-ascii?Q?H6EuiFzNLUGfYhIjt3wmYoE9BZ1iF+GLHBuGThqedJINdd+dfCYMuD8KrKuX?=
 =?us-ascii?Q?+VZf9Qx4aMgcN5AUR501RpTIbODsP6aYmwF5lZyXM/jQb2u4KJr4U4+MFCiu?=
 =?us-ascii?Q?RDGnvCNvKsvoeTGqQ0I5JHQjh0J8KbbmuMXdg9k9pTASaEqVXcc1aputf8hA?=
 =?us-ascii?Q?0ncWWiWRUNWZhkcIrxM6p1Mox3QRjBVHnM0D6BY+WxLPn5FCkV6UbrVJHYxg?=
 =?us-ascii?Q?l8Y94YzIcF3jkJHFiMgZO/F/h0vqDkX7SmsXPJKgyGyLsQCOE9J/1/yqDZw3?=
 =?us-ascii?Q?oiALb49GLRMs7HWHYGoBeuFjlAekOXmKwI81GbNSgmyuu0ESyAXlNlelojiJ?=
 =?us-ascii?Q?SLZng/48Ol8jM89cqDC3W4znZcLY0nel6RqX1g/rcLn86qSv809WXTAS5rlY?=
 =?us-ascii?Q?0yGMiOgJQLMpW4BIEqTftS9nr0/ieq+uLIOdXpwu5jUk+C/VJv2OWuTXzTov?=
 =?us-ascii?Q?Uuy91Pt9wC//Ser712/Il7F9gDGCVHFBKOMf9AAmsei5kkMwM4xrMDaHxK1d?=
 =?us-ascii?Q?sHLLdjy1OI8xnNsHxTT1v0v1hwdZ/8oXpJJIJm4wbWprsDQDr8Np28gfQblk?=
 =?us-ascii?Q?7ioaWVJgiG92CFnYNwqPjMO76KayJxc8/0AdRh5O4UvIEdZRQq1BQzV205W2?=
 =?us-ascii?Q?HnLEMu3a+f5sZJQ6P+R6YN1ywykeyOaJ5mqRtzXeMxHgnlhZh7rPNobo5SP6?=
 =?us-ascii?Q?rMM802o9sqObXb2HMQd1BrFyuZoy1kTyqoP1Z5qKbONMPSq+Bz+/Mt37CjW8?=
 =?us-ascii?Q?ZAmPPMxzA0BaAqZRh+c/VumtOE7tbFXHwhPzCdYHGV7JlW211mvQVoMycNby?=
 =?us-ascii?Q?djvoJHVyQ1NnULVCLM5Mcqj94dXLEmOSbjfzzRMzC7Ovb9drh2PJyN4OOPMU?=
 =?us-ascii?Q?AG2R5XAooctUq+GF4rwd52rK27qO7xyb7FbINxI7ireQlI640R0gcEj35bat?=
 =?us-ascii?Q?KYNZsS1Qvl6c01WTquYYFGKBsKBTFUHwydAlpLavG8Q6yKfR5uwJIV8fgTYr?=
 =?us-ascii?Q?1geUpfmH8kScqAIxiAK0HhaG43tlGdbZ4YE8Zc3uu4H1hRIUbSoMphmNcVrY?=
 =?us-ascii?Q?jURguO/+A8dVmYTEAHDyxHRWdHsCdaB8Wu8QoQVOPPyZRLOhNTQzsTEJg6rj?=
 =?us-ascii?Q?Sd2jKafJA905ELLDc4kBc3opRB8wHaTi+YLU8KZS0heEh84iJCpvBPL14KIn?=
 =?us-ascii?Q?qPI8hF3+zZBnRmtDJNZ5+eefLx+2Bvga8pVJDPj+rixGRuImxz9YznnndH+7?=
 =?us-ascii?Q?16J0SO/G307A8qGgOjKUVHyx7CM7f97VR8r+mJEfhR1FL35zhxB3sYRX8i6w?=
 =?us-ascii?Q?6pTxiPrZHlNKUpAXyrXlVNz6zD+2qt6JbxVa09GByzPeAGKYoq5j5ms+7vXB?=
 =?us-ascii?Q?s4bfCQQed7noRtOuaH1wd1P75bZ76WggLZWGdCWkovyxvsJr1WzNeXuwTZCa?=
 =?us-ascii?Q?q/VBMxkRFCK6YTWW61QqGWY0fLWEzxVsRziqn2v6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ece4bd-7c1a-42ec-63a0-08dd445ba606
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 14:04:17.4345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4bOlcJRdR04wOxRg5/eYA8ilQGS4itRTt7PSOtDNq1H+yAojAFpIZh2dOgQ29yE5Y9O2yHW2xk+Fg+KXQW5SrSFRqsC4/3jprLTMbyY7wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR07MB11071
X-Proofpoint-ORIG-GUID: jXN0BKAcVR1sLmL8fqu_40nczu9xjYmB
X-Proofpoint-GUID: jXN0BKAcVR1sLmL8fqu_40nczu9xjYmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030103

Would like to change the design to get the architecture value from dts, usi=
ng a bool hpa
And store this value in the is_hpa field in the struct as given.

There would be support for legacy and High performance architecture in diff=
erent files
And the difference would be basically the registers they write and the offs=
ets of these=20
registers. The function names would almost be similar with the tag hpa, emb=
edded in
the function name.=20

Would this be an acceptable design for support of these new PCIe cadence co=
ntrollers ?=20


>Look at previous subject lines for changes to these files and follow the p=
attern.
>
>On Fri, Jan 31, 2025 at 11:58:07AM +0000, Manikandan Karunakaran Pillai
>wrote:
>> Add support for getting the architecture for Cadence PCIe controllers
>> Store the architecture type in controller structure.
>
>This needs to be part of a series that uses pcie->is_hpa for something.  T=
his
>patch all by itself isn't useful for anything.
>
>Please post the resulting series with a cover letter and the patches as
>responses to it:
>
>https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/gi=
t/t
>orvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=3Dv6.13*n333=
__;I
>w!!EHscmS1ygiU1lA!AkA94rjfoiZElA3AKt_SRyFA74hygGR-
>X7t7_oZzijqCt3Ojr_UVL2Q9RLTXs4juahroWPLzA6CJFZI$
>
>You can look at previous postings to see the style, e.g.,
>https://urldefense.com/v3/__https://lore.kernel.org/linux-
>pci/20250115074301.3514927-1-
>pandoh@google.com/T/*t__;Iw!!EHscmS1ygiU1lA!AkA94rjfoiZElA3AKt_SRyFA7
>4hygGR-X7t7_oZzijqCt3Ojr_UVL2Q9RLTXs4juahroWPLzuNTbmWU$
>
>> +static void cdns_pcie_ctlr_set_arch(struct cdns_pcie *pcie) {
>> +	/* Read register at offset 0xE4 of the config space
>> +	 * The value for architecture is in the lower 4 bits
>> +	 * Legacy-b'0010 and b'1111 for HPA-high performance architecture
>> +	 */
>
>Don't include the hex register offset in the comment.  That's what
>CDNS_PCIE_CTRL_ARCH is for.  It doesn't need the bit values either.
>
>Use the conventional comment style:
>
>  /*
>   * Text ...
>   */
>
>> +	u32 arch, reg;
>> +
>> +	reg =3D cdns_pcie_readl(pcie, CDNS_PCIE_CTRL_ARCH);
>> +	arch =3D FIELD_GET(CDNS_PCIE_CTRL_ARCH_MASK, reg);
>
>Thanks for using GENMASK() and FIELD_GET().
>
>> +	if (arch =3D=3D CDNS_PCIE_CTRL_HPA) {
>> +		pcie->is_hpa =3D true;
>> +	} else {
>> +		pcie->is_hpa =3D false;
>> +	}
>> +}
>
>> +/*
>> + * Read completion time out reset value to decode controller
>> +architecture  */
>> +#define CDNS_PCIE_CTRL_ARCH		0xE4
>
>Is this another name for the PCI_EXP_DEVCTL2 in the PCIe Capability?
>Or maybe PCI_EXP_DEVCAP2?  If so, use those existing #defines and the
>related masks (if it's DEVCAP2, you'd probably have to add a new one for t=
he
>Completion Timeout Ranges Supported field).
>
>There's something similar in cdns_pcie_retrain(), where
>CDNS_PCIE_RP_CAP_OFFSET is apparently the config space offset of the PCIe
>Capability.
>
>> +#define CDNS_PCIE_CTRL_ARCH_MASK	GENMASK(3, 0)
>> +#define CDNS_PCIE_CTRL_HPA		0xF

