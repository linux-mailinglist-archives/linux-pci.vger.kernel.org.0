Return-Path: <linux-pci+bounces-20585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77579A23D60
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 12:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B7A3A5C63
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5C71C2309;
	Fri, 31 Jan 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="TGYvLFuq";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ulrvyLRr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B52AD11;
	Fri, 31 Jan 2025 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738324709; cv=fail; b=ZE4K0msGKPZIk8WHqzrHE7rJjK19p4EZoLcc9U0W/BFzBVQd4wb38tRKXZ4XXGqV0Z1h/pq0gIXadmuYBLfkYsdCm3kpveb+pbLfKW9UfxrSbnkN+lsWuN9boqdqy3xWXLGpRoGpTNa0JQwOE/vEe3U7HpPcQ+AySgKKp7qIuog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738324709; c=relaxed/simple;
	bh=Yu1xyphznvMkJmg/WD+nVhVb8IxvfjAc0HQ40Ws75Ts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bEayU0x1+ODIXrisWMnrzOyjERtK91ASDwlQfi99opwjMxODgb1bVWxJ78ELkruh6OYfXhPOh+RFuglFNzxP+Caw/GvYMUMX5lE0lTLF9Iv+9EKJnrEUZrpmDxl4onr91Q9jQHoqRgmIXP+RgWqj3JnaFfsn1Y9Dyc8GzrBqI2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=TGYvLFuq; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=ulrvyLRr; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7sgve029477;
	Fri, 31 Jan 2025 03:58:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=CaGWnd6mw/Hp7FTfNun7lywHxpy4tU2l6rK4i9y0Ayg=; b=TGYvLFuqwQFv
	TyP2D7ZxSrFz6bhtARTV9Gj2dzFl+AHBbhjiTrH6vFqCKULszajhbsMSoFGtlsvZ
	Eey7dB6L/Pi6QmIF4WUb0PtPquR4+pyEW3/xNGJX2mDAVEKaePs02O0N1keH4BPp
	sovPpLhAXY4Kv+v7yXhClTcDJwQMdDp4egHInHdCUCV9GAXcEJ0XAaM7Rib69PQ3
	jqIqVx486qkhfAZcL2rNOOFFNi0ik7Hnu0xAqsTPZ4ObYydWsNMQcbN+ZKSeNE8I
	wPfNE9r+FtqR0RW4ASCOgmtEoZjVIwvMp9a/zRKDogb4WU4yVV18InY4ax6jgrgo
	zIfV+FTdiQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 44gf8cu2gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 03:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOtXy9O8WmkJoePSTsJ4rYO2g1O6AV0BLepnn0MFiKsiJBcwe3mmhGb0DUHLGB1dmv5yToUbbqgXksbXL0bDfx9OBiQQWqpvTfM4S1UY95zobU2RouxnIxRWqijoxiOcNyRSLv3+E4ccA1C0nWSv4gPef69c7MgB3spJp9+ltT3dgmvVOrfqhOIJrX7lR40D0al4EpfYNMtkeChhevWpmxl+GkumwNl5fkdgpuBLZL8ZtaRkbqy3p3iTyOwxvyNTeoL5+gLMX1uTw/JrMYqzMf6tGpwo/U2KxRN4j4WrKdkf4nsleYw6+IotIJKOZE5CSbjVnbX0yrqbtCpsaH2LYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaGWnd6mw/Hp7FTfNun7lywHxpy4tU2l6rK4i9y0Ayg=;
 b=KxtN9f6+ogb092Nh/JUuNR9AzRf8LHPaIzprUfXiWEmZbShd1Nr5yuvpnRbhlYV94wvuijfLTuxzlViF6EPk5a5jlCYzJoC1Pwo9wZhjnXWSFJNh+XpfMmhQ6UghtaJDCbNPf+VuD7nsi3eLI7Bx5sOB8GG0UVO6L665FEZWv6UKz28mxpQs+IJinJ3cXKrfCfJK4ONAFcB07rnQkhDAWYXcB8R88opwAaCwFXv3/U6bW6EndfikjprlINnP0LNQmYJohcXJfnndWrpIXNqHsz5utZ5mcBlF+vDKE48WhlAltqUgoJzJo8EpsFqyTBp5Mo7PZIrP0SwocQsGfWbE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaGWnd6mw/Hp7FTfNun7lywHxpy4tU2l6rK4i9y0Ayg=;
 b=ulrvyLRraP8Qi5l2H8E5elOnvUkIGF9Y02on4eTVbeL2lnX3qjALc3YDh/k9Tzce2/TsIzP6euAYK7yr6j/wOAPZ7bzwGy4Ym0nsw/9kU+7RvoLFdWahslMNpQJO9rMXkoi9HCZasLQDQWwShoIuJCuUf304IkXy5Vc2zdpV2Jg=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by DS7PR07MB7720.namprd07.prod.outlook.com
 (2603:10b6:5:2c4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 11:58:08 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::d517:a32:d647:386c%5]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 11:58:07 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] pci: cdns : Function to read controller architecture
Thread-Topic: [PATCH] pci: cdns : Function to read controller architecture
Thread-Index: AQHbc9dkPe/t53rtZE2/3AwJ6A7zhw==
Date: Fri, 31 Jan 2025 11:58:07 +0000
Message-ID:
 <CH2PPF4D26F8E1C5FA4D55D4271BA4F6F0DA2E82@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250131114516.2501350-1-mpillai@cadence.com>
In-Reply-To: <20250131114516.2501350-1-mpillai@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXG1w?=
 =?us-ascii?Q?aWxsYWlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVl?=
 =?us-ascii?Q?LTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy05ZjgxZmMzYS1kZmNhLTExZWYtYTM2?=
 =?us-ascii?Q?OC1jNDQ3NGVkNmNlZTVcYW1lLXRlc3RcOWY4MWZjM2ItZGZjYS0xMWVmLWEz?=
 =?us-ascii?Q?NjgtYzQ0NzRlZDZjZWU1Ym9keS50eHQiIHN6PSI1ODI2IiB0PSIxMzM4Mjc5?=
 =?us-ascii?Q?ODI4MzgzNTM2NzkiIGg9InZpdGQ5Nkt1cVk5V0lOaGxJcU1HUnlzbmVIbz0i?=
 =?us-ascii?Q?IGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VB?=
 =?us-ascii?Q?QUdBSUFBQVBUeFppMTNQYkFXMTAxNWtCaXVacWJYVFhtUUdLNW1vS0FBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQVlBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVlRQnpBRzBBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone:
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?bmdBQUFITUFid0IxQUhJQVl3QmxBR01BYndCa0FHVUFYd0JqQUhBQWNBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCUUFB?=
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
 =?us-ascii?Q?VUFlUUIzQUc4QWNnQmtBSE1BQUFBa0FBQUFHQUFBQUdNQWJ3QnVBSFFBWlFC?=
 =?us-ascii?Q?dUFIUUFYd0J0QUdFQWRBQmpBR2dBQUFBbUFBQUFBQUFBQUhNQWJ3QjFBSElB?=
 =?us-ascii?Q?WXdCbEFHTUFid0JrQUdVQVh3QmhBSE1BYlFBQUFDWUFBQUFGQUFBQWN3QnZB?=
 =?us-ascii?Q?SFVBY2dCakFHVUFZd0J2QUdRQVpRQmZBR01BY0FCd0FBQUFKQUFBQUFBQUFB?=
 =?us-ascii?Q?QnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWXdCekFBQUFMZ0FBQUFB?=
 =?us-ascii?Q?QUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBWmdCdkFISUFkQUJ5?=
 =?us-ascii?Q?QUdFQWJnQUFBQ2dBQUFBQUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFa?=
 =?us-ascii?Q?UUJmQUdvQVlRQjJBR0VBQUFBc0FBQUFBQUFBQUhNQWJ3QjFBSElBWXdCbEFH?=
 =?us-ascii?Q?TUFid0JrQUdVQVh3QndBSGtBZEFCb0FHOEFiZ0FBQUNnQUFBQUFBQUFBY3dC?=
 =?us-ascii?Q?dkFIVUFjZ0JqQUdVQVl3QnZBR1FBWlFCZkFISUFkUUJpQUhrQUFBQT0iLz48?=
 =?us-ascii?Q?L21ldGE+?=
x-dg-rorf: true
x-dg-paste:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|DS7PR07MB7720:EE_
x-ms-office365-filtering-correlation-id: 4b34688b-fc6e-41e1-ad40-08dd41ee869d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ssj1FVoZxT9DUEitaUkIQQNP/vxaCWuNNZ5ZyRlKkpYJIkbaFtgWA0nHi+A3?=
 =?us-ascii?Q?HCYkvrx0s8L0VZNdV72XpfHNUEx6lxxO/zYMMlA+okNu7RLXaHpJOphMxVaJ?=
 =?us-ascii?Q?l4Wm4sv5Z4sERrURTS4DdACdPtAfBlnl5Zbsb+jozAC38Fn8U0pXsLpq3BO5?=
 =?us-ascii?Q?lI85mpwY/wRfZ12ipVM9mSKnLYuTgd5Koz6GakOGfWKMXGYyd9TIITyLJDZw?=
 =?us-ascii?Q?S+4iVVnHRba+En8WEBAJsg2Pu+Hei9sw6J472EnHOyXqb3SXw5F1232jOmNz?=
 =?us-ascii?Q?5uqKfX4/HIdw8VS1wAu5EV7fPCYNPFU5IyPfVMVC7CQK3oyUM5Q6JaKcRGpr?=
 =?us-ascii?Q?pQPgVbzr2gJpjc+6i0zwWr6RT+Rz1zBoEmbpvGKbn2LeHx4R8wsTlMeY0U6+?=
 =?us-ascii?Q?Iw7pq5QaQfzNdfibTwLXXEjHbhmA8yC9dBt4eNSyZNqaAEcu1g8Gon37G14a?=
 =?us-ascii?Q?SVHoDsoi7g4eO+0DzG0iRSgv4m+eDioFXVssNUZDEZ6WbJ33zrtTJluPilgo?=
 =?us-ascii?Q?9BuypEjl9DpaV08B9h0BJLuDQD2/lWL3G55QGHyZFmKSho9M/tWmkIRZ4pqH?=
 =?us-ascii?Q?EMiHm2mZeeEWVStbu57/22k9E4wrRQjpLhxWuhkhlbeT9+jSUW7/GU0Xyoi8?=
 =?us-ascii?Q?7HNpxxyMI+l94t0Jw7cfLECwIq8a5j6dKDwCYZdTRs6dCpWk9J2mcV6qXkMK?=
 =?us-ascii?Q?V3x+oHYg0d9jVWSfiqhlGCf0TsfrZWcmyZUiNNMuzs8IcCVZPvig/qdAF1jA?=
 =?us-ascii?Q?bT/DgkNoo/j8uZVIsxjZ2CbIbkHZn54/Eh/axU8KSmNS1tSdnR0t5FV8UM1S?=
 =?us-ascii?Q?6DYWyEq4X3ryHthyVwIt1UcSx/cvFvmR0xYq5XwQTUYiSCDVO5X5Fs7D5uug?=
 =?us-ascii?Q?S4k8f/k27iv7+h1b48HH54WvCC8S3iYLEMu6SSgwYDYgYmtSEfdV6EV2Vrtl?=
 =?us-ascii?Q?bn8I0zACgDAjJ/y6YKh/k6S9cG7HVX+xkXwPubWQTjroIhL3yny33zIsxxpp?=
 =?us-ascii?Q?zAuNPUY2xUJWgFEdnzyIqSHzxAOLy9CxSxJULyrpBlFvqMUykVPY955isZv+?=
 =?us-ascii?Q?0rZiyOdT9eTf+k4HQyFCQzhi7xoLcIWsbu/YaUYDMyK6qLMTZsFopgPma+UQ?=
 =?us-ascii?Q?/UQprm9L2ze5wx3PKhwhRfOgqxAdK9dxU0AYnsIu16Emnbeppx7RAKdCYp7c?=
 =?us-ascii?Q?SmPYyDG6y4gJx3oLk7O41ked2Pu4Slu/317k7nyzzpKh30kI9wjRD3mNUFex?=
 =?us-ascii?Q?ufpHZUV+if8591gzr0P6yyd7HErLP8hkuktNar84dBhd3QowkfxOPxZfy7FC?=
 =?us-ascii?Q?0ZG92pfgGILcpBZrh1GkiueYbE7F8tb43e5YXyfl623o+UPWLcCWUrdr08zQ?=
 =?us-ascii?Q?7y3E3HpwkFgWAtQ25/5srYM+IaN/E73WAmnM6b/rSs+qdVz6JT+xuJPEi0lE?=
 =?us-ascii?Q?ay1MSum+2uLGVPWPgxj2HxIS7cdnEWcx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qEcGZd5Qhe9vMmnrn7XdY00i+spB/XQWrbxWoEltluai9YSN+FrklIditRiQ?=
 =?us-ascii?Q?LV6dCmRdyuEj4YW+9R9TOzqIkKJ+MVG4CtVYDFnECbsv6SmX0WfqEdWD9UfB?=
 =?us-ascii?Q?Lb5Pk8l4+tku1sYej++DkMwENdytMU+EulP8o7VUoSK18ASB5W4N5s6o9tmq?=
 =?us-ascii?Q?rhh2ArOaeItm3nU5wuNzJSFg+jP0R+3YmavUIASXhJNNrqoS/rleSQyxcdoT?=
 =?us-ascii?Q?iNU4xVbCn1CtDY58XucuWTe/Yp4sU28hvTuV6BI8hGi+siTXMkGSCg21WjWW?=
 =?us-ascii?Q?1YZy0UsMVodUUGaZY3ouaHIvKhi/5dljVLxbtsLmyNWfZc1HMXzs0gyLwYZz?=
 =?us-ascii?Q?3yiTlSxmP+HQaA3G15hNpl5kEYWneqnV3nuUPMuRQeFBoq93Ay54htXHMaOC?=
 =?us-ascii?Q?/YHgCAKAyzN9uRbYGoz33GtZ4nQDIXzGI4qmBhZUG//lxwNgq9pZQBxRKVRB?=
 =?us-ascii?Q?aJ0Nknnkt0KUgUrtcSYu5+VNw3xzzXUA9gnZY6PFDpiA743gB1yDiGf8lk+g?=
 =?us-ascii?Q?orS4moAsz23/0F4T6ZJhkOEpWPoAcPvfRChhyWhCqKUv5GzumpUBbNao5i/x?=
 =?us-ascii?Q?4ND5JEK0IJar9Nllj0ktqDZ3RUDlKCPmA7UALi2LCfIbJStwj2nmkyBwgsxb?=
 =?us-ascii?Q?4yzsH38kKpZjJ+c0xn50wRyjjVxMjO7GTWZukam0WS36ZDiOGtl7WkoyYVB/?=
 =?us-ascii?Q?L8ut2kCLqtSI0BRIaOMNwZCIuwGfYhZrGqZnLbMNjxx6o6HlnGHJ79LvbMql?=
 =?us-ascii?Q?w8kwYFbe3YJtcZFMd9mv9+bCLA3dpZftYl6v0BpGCm6WmBbh4wNqJhDj2LtX?=
 =?us-ascii?Q?qmx32hVmiBtJlto5LMauPlcWb//QUdH2mfRDHFNy29c/1xWZFq+TPCiVXLZE?=
 =?us-ascii?Q?/IFnEaHOiVk8eBf00YK3PGqQSoKdzDAOWwasYLcA9AlKUZPuPOuq/fn61/8K?=
 =?us-ascii?Q?Q2h+AN7q35IGj8tqbMLwyCDWfMY22/CsTLhHPcjlpYHC2fdNQsH8yQRXeV8r?=
 =?us-ascii?Q?xczuR42bS3wxkdTV80j77fVERYxgKlFzk2MQrlJDl8rpD41ir6s4CSIfXQeC?=
 =?us-ascii?Q?foxCHWJKl4GQGqfuGVIkFtxYnRnWlaCKfDKmf0Y+deiCzZY6s6mmjyn8eHGz?=
 =?us-ascii?Q?pWFYkWsRKl5ijzBiTgp+UZKecJeL3d+wFbAEZYd4V+2eh+dF4vhvCEQmxUM0?=
 =?us-ascii?Q?CltSPgZ8f8gDi2bzb7oEDu5cA9RohaZVxnyKYr/RP63q9jYJjQ3HPAZliNHR?=
 =?us-ascii?Q?oCUMa3wxfLqnhurQjYW3ZWTeqrwa14iADEsMkW25vT7ZH6DTaGaNYdOSlETD?=
 =?us-ascii?Q?5zyW4HOEkhnUha0265CW4gLqVhSKmKjKz8ZyYVD2OcDdQOvn/jQyO6Es1qjy?=
 =?us-ascii?Q?Y1FJkzmy8OZEDbblpa8nIumghrjY+9O2tH7eiQfJFXT8f80AKmEIT2YtNPTy?=
 =?us-ascii?Q?vhpi2y9SJdQT9eaX0Mw9FKLfiIKKc2W2Tzs3oOAyZh6gRvIHxUc2eIp+lEgO?=
 =?us-ascii?Q?8LMfSJnZSq9hGN+nGZ5ZpmbSHtPd3MDZjEjxJ8eA22Ey7twMURG8lVLHxtB0?=
 =?us-ascii?Q?idB0o1F/32h233iVTQJ0reL084gZHz5cPY3tHBm3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b34688b-fc6e-41e1-ad40-08dd41ee869d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 11:58:07.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZyVkvxS+stRCliTF63fgUWEfRhsYJdQcOrvXNbV6lSdG+AJzEZZSG3YYpm9Hi9Z+0EDaLGXjc+GcFIhtTX7LY5NxLSt2TTlqx80/iJbtQ9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7720
X-Proofpoint-GUID: Y6dB9S_dGw2YE8j1KvPuexx3UIOenZ89
X-Proofpoint-ORIG-GUID: Y6dB9S_dGw2YE8j1KvPuexx3UIOenZ89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2501310091

Add support for getting the architecture for Cadence PCIe controllers
Store the architecture type in controller structure.

Signed-off-by: Manikandan K Pillai <mpillai@cadence.com>
---
 .../controller/cadence/pcie-cadence-plat.c    | 20 +++++++++++++++++++
 drivers/pci/controller/cadence/pcie-cadence.h |  8 ++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/p=
ci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb9..d1cfb9847b7c 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -37,6 +37,24 @@ static const struct cdns_pcie_ops cdns_plat_ops =3D {
 	.cpu_addr_fixup =3D cdns_plat_cpu_addr_fixup,
 };
=20
+static void cdns_pcie_ctlr_set_arch(struct cdns_pcie *pcie)
+{
+	/* Read register at offset 0xE4 of the config space
+	 * The value for architecture is in the lower 4 bits
+	 * Legacy-b'0010 and b'1111 for HPA-high performance architecture
+	 */
+	u32 arch, reg;
+
+	reg =3D cdns_pcie_readl(pcie, CDNS_PCIE_CTRL_ARCH);
+	arch =3D FIELD_GET(CDNS_PCIE_CTRL_ARCH_MASK, reg);
+
+	if (arch =3D=3D CDNS_PCIE_CTRL_HPA) {
+		pcie->is_hpa =3D true;
+	} else {
+		pcie->is_hpa =3D false;
+	}
+}
+
 static int cdns_plat_pcie_probe(struct platform_device *pdev)
 {
 	const struct cdns_plat_pcie_of_data *data;
@@ -74,6 +92,7 @@ static int cdns_plat_pcie_probe(struct platform_device *p=
dev)
 		rc->pcie.ops =3D &cdns_plat_ops;
 		cdns_plat_pcie->pcie =3D &rc->pcie;
=20
+		cdns_pcie_ctlr_set_arch(&rc->pcie);
 		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
@@ -101,6 +120,7 @@ static int cdns_plat_pcie_probe(struct platform_device =
*pdev)
 		ep->pcie.ops =3D &cdns_plat_ops;
 		cdns_plat_pcie->pcie =3D &ep->pcie;
=20
+		cdns_pcie_ctlr_set_arch(&ep->pcie);
 		ret =3D cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
 		if (ret) {
 			dev_err(dev, "failed to init phy\n");
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/co=
ntroller/cadence/pcie-cadence.h
index f5eeff834ec1..2d9ecd923220 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -16,6 +16,13 @@
 #define LINK_WAIT_USLEEP_MIN	90000
 #define LINK_WAIT_USLEEP_MAX	100000
=20
+/*
+ * Read completion time out reset value to decode controller architecture
+ */
+#define CDNS_PCIE_CTRL_ARCH		0xE4
+#define CDNS_PCIE_CTRL_ARCH_MASK	GENMASK(3, 0)
+#define CDNS_PCIE_CTRL_HPA		0xF
+
 /*
  * Local Management Registers
  */
@@ -305,6 +312,7 @@ struct cdns_pcie {
 	struct resource		*mem_res;
 	struct device		*dev;
 	bool			is_rc;
+	bool			is_hpa;
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
--=20
2.27.0


