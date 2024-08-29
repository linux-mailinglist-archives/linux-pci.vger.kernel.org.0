Return-Path: <linux-pci+bounces-12412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B721E963DFC
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 10:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC07F1C21FD2
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8B14B96F;
	Thu, 29 Aug 2024 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="oo4+77sq"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437822339
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918711; cv=fail; b=tdmAP1hJBOEHl41QGR1kwgkxgn2Gr8uDztv2az3XEkSlyjLQct8hCJl5PM/g5MXJWvdliwUIE97/mHbIai7uiFcL7WvYgVZBh69weNgkOQ8xXPJqcXk31aX/EME06gZgHzAJ3WAkxo5lRjJKQNT9eA/9tAiz1wT0NYBvNu6RTL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918711; c=relaxed/simple;
	bh=2EfEI399zGknc2dc+obX0o9nWvGk773SoOUyiySc/J8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NQVwMBWezWiWPN/E5L7stdCZIQW+Svma+I3igEwyaAeDOTqrp52pDpyxz2gSgOsVa+7xZ+DKqYwwqzdkFRpr8WhhCLJe1b6jsyFn4sN776BNdZsXBymHE1hmrXO7nNy8t11zB0nbvqFDz1Ucg4SYFa8b1KllT/o/OIR36vYYJdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=oo4+77sq; arc=fail smtp.client-ip=68.232.159.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1724918707; x=1756454707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2EfEI399zGknc2dc+obX0o9nWvGk773SoOUyiySc/J8=;
  b=oo4+77sqEJuc64l1hSu37XXBCmDxnMsmpF6rEQbyYCi4fFQ9SGDqrfDw
   kAgPWCgc5okepJqccI7auB93PGfvfKqXSBP5ZiB2g+cvzR1PQZF8iJecQ
   AtzVnUeCbJGOFtp5LZxT2/vCj86VW1gWiunv7BQxTRq69DiALT9MePRPY
   IO7ysqeipBluew9CKdk7JkvsitrY1hpKPP3yvLBToOqPLh9gqiNN3o0eh
   D2FP3bMLbdqpAXSfC1UPuJAA4rkD0DMduLLP1KlRdHWUpHwViGUecFPo/
   KY0/cgAOKbeyP4z39els1CFLsDBCb3U8/l5c9+mvEtf/VnTo0avn8C1U7
   A==;
X-CSE-ConnectionGUID: Sns9W2G1QcO+h0Guri+oQQ==
X-CSE-MsgGUID: hs3koCyZT0+vGAML1iJFhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="129346721"
X-IronPort-AV: E=Sophos;i="6.10,185,1719846000"; 
   d="scan'208";a="129346721"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 17:03:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4yCsRjetos4C5fCGlBihwT0ODsE+IyxV8x5EkQnolLs26q9ejIG2cAfDzJD7Myl4JQvJbeNtRTl11PUp7IuPtUO8FDJgVYhkFDtR8WrU66bWg5kA+Na3FN7hMK/vRmLP7SLw69gwJtDsVW0DGWYhmzVEEexFXKVwI2iveJiTCP1D8ZCJFdJnhYCIuM0kFKfEraVB7E12GMyVrHVrceAlQZd0IXE6W9zTTnVZqgE8FemNXTq6X2164edu+trRno6iy/R+B4oF2vS/XNflukUBeu1zQlnyHG7/FqgSAlf0cA3SQLXE4FHEUpLxFusNiYxgwAAJyLQY7Ny7ax13VHLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EfEI399zGknc2dc+obX0o9nWvGk773SoOUyiySc/J8=;
 b=PMMRGwePAjGZtBoeRaj1sJWEKtL6t/Ou0E4CPuOerm3sdVHQMvBOQYNMRapei5ApyPj1yN9OR/A8bkJpjxKq3ChgKTASp5loH+ZWGv4EycQqZw0htVrjr7SESr88DCvpxKOoqFtBilkpMNyPvMTMe4saDulBTVV/HKz7adyqEOydrhAODjQp3fcGpLQWF0u3gSApvYydKLhJwly0WRLjkCK9sFdBnnX9eeYvQg6I3AGBF9RAsLsnx8ZuVob6+A8igUT5811q6cOl15NufjDHgetiFSR8qEnz7R9LV2gKOeikDTTU/Ws25vQ3zKc9/eOTNQrPthpUgJsSxziD9OkJpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYRPR01MB13342.jpnprd01.prod.outlook.com (2603:1096:405:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 08:03:51 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%3]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 08:03:51 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	=?utf-8?B?J0tyenlzenRvZiBXaWxjennFhHNraSc=?= <kw@linux.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [RFC PATCH v1] Export PBEC Data register into sysfs
Thread-Topic: [RFC PATCH v1] Export PBEC Data register into sysfs
Thread-Index: AQHax4L+i4Kp4u4qEEmK0TgyfRRzXbHv4xSAgAkfqVCART+n0A==
Date: Thu, 29 Aug 2024 08:03:51 +0000
Message-ID:
 <OSAPR01MB71825F612653E9893662C789BA962@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>
 <20240710110519.GA3949574@rocinante>
 <OSAPR01MB718231921A414BE66FDFA555BAA22@OSAPR01MB7182.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSAPR01MB718231921A414BE66FDFA555BAA22@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9OWQzYzExNTEtMjk5MS00YjA5LWI2MjYtYzlhN2UxMjFl?=
 =?utf-8?B?MmY0O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTE2VDA2OjI1OjA2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYRPR01MB13342:EE_
x-ms-office365-filtering-correlation-id: 84548ece-047e-44be-fa77-08dcc8011e9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0tCdVFnSzZhbkNxeFloZ0NGQzBSOXZma015U25maDZKb0JSS1QzVmt6TDRO?=
 =?utf-8?B?QkU1WFBDcXpybHRLZVBtWGdiL2dDVVliWWdTNjNOUWkzZ3NJMHB6OE5iSzlN?=
 =?utf-8?B?YStCVnJIQmxMMmVCUXphR1VOU1pyRVpzRzZmYnM2QUlZUVhFRWh3Uy9lMVZR?=
 =?utf-8?B?eHRhWXFWM0tMMitSRisyOWo0U0M0Z09YRUpNV3RPNHhXV3lQZHRta050ZHJB?=
 =?utf-8?B?YU5jb29tSTRqSzJRZWdXZmxWQ1VNdG82TjFBM01xMkFMU3diN01lT2IyNkkr?=
 =?utf-8?B?OWhSNnd4STlEMXRhUlMyck8wRXcxK3hRYnRLc0JMQkdtamV5VEpkeVhubll1?=
 =?utf-8?B?WjFDZlMvZTJLM0FPR3N6TGZFRm9zemZRYmdpSHM0N1kwWk0zdzc0WWphQ2Zo?=
 =?utf-8?B?NzJsQ3pDdjd5cGlZMURSN1l1TEsxN3ZQRnM0VWptc01pdzA3RndvVzdJSTI1?=
 =?utf-8?B?M1R1b3M4OWVTdlJza3ZUNzZRcW5rd3BiTWo5Q3FWWjdpSERXQ1YrVjBIMExK?=
 =?utf-8?B?ZDBOcW9HVjE1MjNQQ3o4Y1k3K25RcFdoZENGeFBGTU9WSGlQZnU3blpWUmJ2?=
 =?utf-8?B?OTRvWEJ2S0o4d1l0eDcwNnQ1eXNYdGF2aS8zSjRZVjNveHphT2VoMEE5VTJ6?=
 =?utf-8?B?SUF5ZUJBWHFUcUpQS2lKVFlHYnA2YTQwMnRMazZXTGNuQ2N6aStxbWFBVnhv?=
 =?utf-8?B?ZTdYM0sxZnh2S1JsU01NcmhjbFh0OUsrenJRS2xHOEY2QUtFenh5SGxhWDI2?=
 =?utf-8?B?eE5nS0RFQU1aL01UbkdyUXl1ZVUzemg4UWhMcnJEellSZW91cGpOaFBIT0NH?=
 =?utf-8?B?Z1NPZFBNVU1SQkJwWlozWlFWRE9FakVvWkFKTk1YeU9sL0RBMEEvT0x1TGpU?=
 =?utf-8?B?L0U2blhGa3JyYnc3UFgvUVEzazFuVVZpSEdLVkZ1NzU5MFU1RU0yNkhjVjdS?=
 =?utf-8?B?TXgxcnp6dWFqUStsVDVsWFR1U21IZk9vV1h5ekN2UE5DR3UxTlNON296WmFz?=
 =?utf-8?B?ZURHYnh5TC9wVEhxMnNZRGd1dEw4VGkzTEhmb2pycmRZUmhUQURpeGZQQ0p0?=
 =?utf-8?B?WTlUYXYvR3FsR0JGUVp0bDNNc3djWnRwaUdRQzNHRDY5a1UwVzRzd0VZQVJp?=
 =?utf-8?B?QXQzMzVWZ1BvbVFwNFREcWxZZ1JSRkU3Y1VQT05taEhLNzJqQkl2UUZNQ3p0?=
 =?utf-8?B?SUord1NCU2xuMTluUWtWOFZWNlZjS0UzY1FWcWpjZkM2U2xRT2EyRWREazFo?=
 =?utf-8?B?c3AyLzczQkdmNjArUlNDeUMyK0xoWDUwV2NvL1RUZnNoRzRTenRQL1h1WWZU?=
 =?utf-8?B?d0s0bHg4dXNaQVRkTlRlSFJMTklBaktKY1o4MXQyN2xNa28wbVduMlNnRGNi?=
 =?utf-8?B?akh6M0FxOHEyYTJFSTdDTmpsRGRjeERCakZwRkFkbkJYNkNkUjRJT2plTTZK?=
 =?utf-8?B?Rjh6U2lkM2Z6UkdVMDR5VzloYy9VaEw4ZTVWQVM1eE5qUzhmRHRROXZ6Sktk?=
 =?utf-8?B?ZXYyMkU1N0FWT3lyUjRtVVUyQkgwZDdaSmV2MUdzaUZ1Y1dKYkNFamVKWE40?=
 =?utf-8?B?TGZNY2kzek8wUlFOekhjb2tLdmFkWGV4a2FLUzgzREFmcmM3em9kcGg3WHJy?=
 =?utf-8?B?UnczdWk5U3hwSVEwR0FXc2VIeWpLOTU2YlhPUVBuWS9aRXNwNk5QYlJ4eTJV?=
 =?utf-8?B?bjBhZ0xyTzJpNXBpUmVZZG1neUNyUXR3YlI4c05VVXEyd2ZVY1diVkRYK2Nw?=
 =?utf-8?B?aFRJU0pVMER0Ylg1TEpKcUtCZVhmLzJ2R1NsTHVMNU4zV0QrLysvKzR3dFZk?=
 =?utf-8?B?OGxIV3RoTEJrVGpWUmYrMXdzQUVRcTRjOVBSZTVabWtNaU1vMU5MVnZORGdY?=
 =?utf-8?B?VmhhVE54Q3VyKzdIUGhObHBCTy9XbDUrOXQ4NXVnTk1jaXlla2NkRzY1YjFG?=
 =?utf-8?Q?44zQ/wmGtKs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0lha3VxRFU4K3FMemJtK3E4elRkQ0VGTEwrT1ZpQzhzT1ZHdGN5VWxDQ2t2?=
 =?utf-8?B?U29XdURlZFc4ZVhCOGRMNEczc1VlRGVpK1F2VFhnR2w3WDQ1Y2VIeHdWZFF1?=
 =?utf-8?B?Snc4Q05KcFB0bmJRSUthK3o5dG50ampSckFWa1FkSzkwNGYwbmFOWWtwVGZr?=
 =?utf-8?B?UTJqaEtyWXRiRWVYZnY2TTJYMmNzcXVLcjNIN1BFNW9NSG15TDNlRVBqSG5s?=
 =?utf-8?B?emtaM3YwaUtGVlJ3MFhSVllNZ2tzWTdULzV5NnlwZnVJTGdzbTZrVFQrdkZ1?=
 =?utf-8?B?eXV0ZW5JaFpCZzhrc2FFc3hvcjJMVVFrWHV6aXp6N1k4S0twbGRVQVBIcGFH?=
 =?utf-8?B?cWorc0d3aG1qU2lvZzE1ZkNYU2RKZlVXc0MxSEk5QTZnVTM2b2hkT2NrK0h1?=
 =?utf-8?B?Y2xZYmJVdks5SlRZYzJmMkRzKzJDdVFHVk5aNGpSNUdZdkpWRmdkSGczZGdQ?=
 =?utf-8?B?U1REZjllTy9NRGZERFdrL0RpMG9tMm1qQUZ3NWRPVitiT1ROR1RyS05LWEk4?=
 =?utf-8?B?b09wY0RmRXQ2L2hJL2EvOGNPWDltQUpFU00xU2FIa2dtZDZqUlBwYmZVSGFY?=
 =?utf-8?B?QjIyOGZpOU81TFhZUXlQTUJZWEN4RmlXSXlRTG9vb3dOZGVPbi92Vll6cmVk?=
 =?utf-8?B?dWVvL2lDNi9uc1BFSnFJTmJRb0Vockt2eGRtR1JVT0ZZM0RIQVBuem5FWDBW?=
 =?utf-8?B?UEtWL2YvOVNvbTAxT3BCeWI0WmFPaDRFbzdCYXVleHBESlNRc0YyNzJVWWYy?=
 =?utf-8?B?aFBIRkszUGR0TS9hTG9haG5iYnl6cFlmT2ZIcktManMrajZiZkdDY1lpSkZi?=
 =?utf-8?B?N3NDRzZGNHVzeDlsbUFLWGFINEwzTEZJMTVHVm10aTVwbGpTdlgrWFZzYWtK?=
 =?utf-8?B?aGNNeFJXZkhCV2hWMU1sMUIzQmpSSUg2MEtBbEk0S3FQSkRNSEpuR1VFSzdk?=
 =?utf-8?B?aFNsZnFIU3ladkRwbC9zcFdjRjI2ZXRGSEsrQmdweHdVdGd6Nmp5RXFmVHgy?=
 =?utf-8?B?VHJBS0NPcGdtUTM0VEJmQmxYd2cxM3djbUFEVitEYWZ3MGNrMmUyQ1FGdnF4?=
 =?utf-8?B?NTY4U2lROUZyME0wOEJucXZjdlk5WXFoMEkwQ2xiRGdtakk1VUx3MzlMVVN3?=
 =?utf-8?B?azZkd3lNTHNyK1RSRFI0dncvemVBN2IreWFDWDl0blBGMVZSNXRrelBrU1My?=
 =?utf-8?B?d29TNGdFc0dwbEF6c3MwNGRKVStzbTZKV1BJVnBldXNpN3RkakxMUHVQR1hU?=
 =?utf-8?B?Z3JQK20vVHR5U0x4cWVrRmdOZWNqdDdnRENEQlNNZU0rbXNNMDVyZ0pxZWV4?=
 =?utf-8?B?TzRyeWozYm9nQ29Bb1FSN1MrL1BnMXhtTlZ4V1FqbUZIMjNCaWgyeHJ6anR6?=
 =?utf-8?B?QW9hVXZQOTlGeDN1RUJ0dml0bHU5OTZJNUdBc1RLZURBS3NRaWlLd3hxYnhN?=
 =?utf-8?B?c1ZEZVdFSnkzRTBmeC9KUnlqT2tLKzVwRmJSOVRWejJMeGNWS09ieU00dm04?=
 =?utf-8?B?V3VzTUFIOVNzSEREUk5LVUEzRnJ4QjNoeXJKNVFIUldwM2R6ZjUvWmloL2U5?=
 =?utf-8?B?NTJsOTdvdGFjNGZWbU1zWmNkaTUxQVQ2YjUwWUx3TXRRdXpNM0FsRFNQdWp5?=
 =?utf-8?B?R3hyeHVqanVLMzhwZzF4NXlFZE1BYWxSVFN4L1lHdVZvYnpnQ01aOTBLNHFK?=
 =?utf-8?B?eFlmQ0YzeVZkdGNZYWNJN2hsWUorZ1FPMEwzRkJxblltWXNUYllKa1VwZXZh?=
 =?utf-8?B?NVRNVk1nczdwWFdtR3hGakpWYUM4QVhSU2REQ21jTzVKTXdWOG40TFZIWktz?=
 =?utf-8?B?S3pGVEI3U3YwK3BnMkpQOS8ybThpSHhaMmo1RnBmMk0vcTZUMFVNZFdCTk9T?=
 =?utf-8?B?UjlYdXhISVByYnNpcXJQS3ppM2hHbjB2UjdIUGY5bFFnbDRIQmJ4N2dqK3Vs?=
 =?utf-8?B?THRiWnBReis0aVlvc1FRN2RJbnlRTTFHeFlVR2ZIRUZHYmxVN0ZCaTFRbTFP?=
 =?utf-8?B?RTJJV2phOTBrWkxna2RUUnYrYmhaM2VvVFRkb1NNaHFKZk4xejFYUWp1eCtr?=
 =?utf-8?B?MWNYNUVYMXRoNC9qbnlzaE5FWk1RQStRK09QamhGYlplL2drZG8yd1pHVzNq?=
 =?utf-8?B?cCtXUldlOVdoUjkvUklOVEphR2pZNm5oQUhHMjU3d1ZnWnlKaTNHVnpxYW1M?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3KIvwIWeJDqmUJuXnJLVya2TO5fdcgf0OL23m/lNhZsC1pTaH+a+1QBe3bsZUNK9IZn2HvF2SkAQuz98lHX5V8LdnjrH5eiF60+T3y85woTNvT7AUVW8U09kprlcjcLtjJzURO7/vMUF08cM52kYq+Xahw9BQDZfrcFyZGqeB39Xb4PiXP5dNwbMVQU+yV2Cibk83aUqZ4kaXo53jRx4cTVTE/pa7U/wJQWu9KtBw3GUAbAYb4e8T+zZVRwpyWgjw2Lj8F3srvEWMJeZ1mNsqPxwlLQlAMcjFwHbAsVZxj41lKoES9qgMLD9JP/9mUPe8eq6SGjC0KPRvzmY0Oym9H9PuTVISCs2UZdTWsAaCQqCpvlzK0Xdg80UG7k7zM0N4a+vrc0kop8FlwakE2wgOeVFt/UhJb5aU5RKQ1lLI3S4QFsBD+Pq3uR9gQ9AS9FfHDEGVfdjzYwrxmp9WTfu7KoQtA4/iyID63/GzirkjmUHjy2C0uT4oSGI/A5fXg2TPj4EYecmAv6yNlko6P/ENmXYnlRScr4vObLxbYMvq+PAU0vuWiu/CzSRyRv0Ps0FZA0Kvq83o0p3rxhy+E/02uOqdaZHNeArzO8ZMO1aZyihFWEZLtWtKp8VBYbqq7py
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84548ece-047e-44be-fa77-08dcc8011e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 08:03:51.3444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YSSfdFGSRXnAxNEsps+XIirPJgrHSdK0g3s3+c+aBj8aSCu9cM0mjJJbljuR0h5VkpsT8rittWiXgGxaGg1RTfZTyPXWi+OVuwrDCfsYvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13342

SGVsbG8sIEkgaG9wZSB0aGlzIGVtYWlsIGZpbmRzIHlvdSB3ZWxsLg0KDQpQbGVhc2UgbGV0IG1l
IGtub3cgaWYgdGhlcmUgaXMgYW55dGhpbmcgSSBzaG91bGQgZG8gdG8gZ2V0IHRoaXMgZmVhdHVy
ZSBtZXJnZWQuDQpJJ2QgYXBwcmVjaWF0ZSBpdCBpZiB5b3UgY291bGQgdGFrZSBhIGxvb2sgd2hl
biB5b3UgaGF2ZSBhIGNoYW5jZS4gDQpJJ20gaGFwcHkgdG8gYW5zd2VyIGFueSBxdWVzdGlvbnMg
eW91IG1pZ2h0IGhhdmUuDQoNClRoYW5rcy4NCg0KS29iYXlhc2hpIERhaXN1a2Ugd3JvdGU6DQo+
IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPiB3cm90ZToNCj4gPiBIZWxsbywN
Cj4gPg0KPiA+IFsuLi5dDQo+ID4gPiBQQ0llIGRldmljZXMgY2FuIHNpZ25pZmljYW50bHkgaW1w
YWN0IHRoZSBvdmVyYWxsIHBvd2VyIGNvbnN1bXB0aW9uDQo+ID4gPiBvZiBhIHN5c3RlbS4gSG93
ZXZlciwgb2J0YWluaW5nIFBDSWUgZGV2aWNlIHBvd2VyIGNvbnN1bXB0aW9uDQo+ID4gPiBpbmZv
cm1hdGlvbiBoYXMgdHJhZGl0aW9uYWxseSBiZWVuIGRpZmZpY3VsdC4gVGhpcyBpcyBiZWNhdXNl
IHRoZQ0KPiA+ID4gJ2xzcGNpJyBjb21tYW5kLCB3aGljaCBpcyBhIHN0YW5kYXJkIHRvb2wgZm9y
IGRpc3BsYXlpbmcgaW5mb3JtYXRpb24NCj4gPiA+IGFib3V0IFBDSSBkZXZpY2VzLCBjYW5ub3Qg
YWNjZXNzIFBCRUMgaW5mb3JtYXRpb24uIGBsc3BjaWAgaXMgYQ0KPiA+ID4gc3RhbmRhcmQgdG9v
bCBmb3IgZGlzcGxheWluZyBpbmZvcm1hdGlvbiBhYm91dCBQQ0kgZGV2aWNlcy4NCj4gPg0KPiA+
IFdpbGwgeW91IGFsc28gYmUgbWFraW5nIGNoYW5nZXMgdG8gdGhlIHBjaXV0aWxzIHByb2plY3Qg
dG8gZXhwb3NlIHRoaXMNCj4gPiB1c2luZyB0aGUgbHNwY2kgdXRpbGl0eT8NCj4gPg0KPiBZZXMs
IEknbSBjb25zaWRlcmluZyBtYWtpbmcgY2hhbmdlcyB0byB0aGUgcGNpdXRpbHMgcHJvamVjdCB0
byBleHBvc2UgdGhpcw0KPiBpbmZvcm1hdGlvbiB1c2luZyB0aGUgbHNwY2kgdXRpbGl0eS4NCj4g
DQo+ID4gVGhhdCBzYWlkLCB3ZSBhbHJlYWR5IGV4cG9zZSAiY29uZmlnIiBzeXNmcyBvYmplY3Qs
IHdvdWxkIHVzaW5nIGl0DQo+ID4gd29yayB0byBvYnRhaW4gdGhlIGRhdGEgeW91IG5lZWQ/DQo+
ID4NCj4gSSBjb25zaWRlcmVkIHJlYWRpbmcgZnJvbSBhIGNvbmZpZyBmaWxlLCBidXQgc2luY2Ug
dGhpcyByZXF1aXJlcyB3cml0aW5nIHRvDQo+IGNvbmZpZ3VyYXRpb24gc3BhY2UsIEkgZmVlbCBp
dCB3b3VsZCBiZSBiZXR0ZXIgdG8gaW1wbGVtZW50IGl0IGluIGEga2VybmVsIGRyaXZlci4NCj4g
DQo+ID4gPiArc3RhdGljIHNzaXplX3QgcGJlY19zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwgc3Ry
dWN0IGRldmljZV9hdHRyaWJ1dGUNCj4gKmF0dHIsDQo+ID4gPiArCQkJIGNoYXIgKmJ1ZikNCj4g
PiA+ICt7DQo+ID4gPiArCXN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2ID0gdG9fcGNpX2RldihkZXYp
Ow0KPiA+ID4gKwlzaXplX3QgbGVuID0gMDsNCj4gPiA+ICsJaW50IGksIHBvczsNCj4gPiA+ICsJ
dTMyIGRhdGE7DQo+ID4gPiArDQo+ID4gPiArCWlmICghcGNpX2lzX3BjaWUocGNpX2RldikpDQo+
ID4gPiArCQlyZXR1cm4gMDsNCj4gPg0KPiA+IFRoaXMgaXMgbm90IG5lZWRlZCwgSSBiZWxpZXZl
IHRoZSAiaXNfdmlzaWJsZSIgY2FsbGJhY2sgZm9yIHRoaXMNCj4gPiBzcGVjaWZpYyBhdHRyaWJ1
dGVzIGdyb3VwIGNoZWNrcyBmb3IgdGhpcyBhbHJlYWR5Lg0KPiA+DQo+ID4gPiArCXBvcyA9IHBj
aV9maW5kX2V4dF9jYXBhYmlsaXR5KHBjaV9kZXYsIFBDSV9FWFRfQ0FQX0lEX1BXUik7DQo+ID4g
PiArCWlmICghcG9zKQ0KPiA+ID4gKwkJcmV0dXJuIDA7DQo+ID4NCj4gPiBJdCB3b3VsZCBiZSAt
RUlOVkFMLCBjdXN0b21hcmlseS4gIEkgc3VwcG9zZSwgdGhlIC1FTk9UU1VQUCBvciAtRU5PU1lT
DQo+ID4gY291bGQgZG8gdG9vLCBidXQgbW9zdCBvZiB0aGUgb3RoZXIgUENJIHN5c2ZzIG9iamVj
dHMgcmV0dXJucyAtRUlOVkFMDQo+ID4gYmFjayB0byB0aGUgdXNlcnNwYWNlIHRvIGluZGljYXRl
IHRoYXQgc29tZXRoaW5nIGlzIHdyb25nLg0KPiA+DQo+ID4gPiArCWZvciAoaSA9IDA7IGkgPCAw
eGZmOyBpKyspIHsNCj4gPg0KPiA+IERvZXMgdGhpcyAweGZmIG5lZWQgdG8gYmUgZG9jdW1lbnRl
ZD8gIFNvbWV0aGluZyBzcGVjaWZpYyB0byB0aGUgUEJFQw0KPiA+IGZlYXR1cmU/DQo+ID4NCj4g
VGhpcyBhc3N1bWVzIHRoZSBtYXhpbXVtIHZhbHVlIG9mIHRoZSBpbmRleCwgYnV0IHRoZSBtYXhp
bXVtIHZhbHVlIGlzIG5vdA0KPiBzdGF0ZWQgaW4gdGhlIHNwZWNpZmljYXRpb25zLiBTaW5jZSBE
U1IgaXMgYW4gOC1iaXQgcmVnaXN0ZXIsIHRoZSBtYXhpbXVtIHZhbHVlDQo+IGlzIGFzc3VtZWQg
dG8gYmUgMHhmZiBhbmQgc2V0IGFzIHRoZSBsb29wIGNvdW50Lg0KPiBXb3VsZCBpdCBiZSBiZXR0
ZXIgdG8gZGVmaW5lIGl0IGFzIGEgY29uc3RhbnQ/DQo+IA0KPiA+ID4gKwkJcGNpX3dyaXRlX2Nv
bmZpZ19ieXRlKHBjaV9kZXYsIHBvcyArIFBDSV9QV1JfRFNSLCAodTgpaSk7DQo+ID4gPiArCQlw
Y2lfcmVhZF9jb25maWdfZHdvcmQocGNpX2RldiwgcG9zICsgUENJX1BXUl9EQVRBLA0KPiA+ICZk
YXRhKTsNCj4gPiA+ICsJCWlmICghZGF0YSkNCj4gPiA+ICsJCQlicmVhazsNCj4gPg0KPiA+IFdl
IHNob3VsZCByZXR1cm4gYW4gZXJyb3IgaGVyZSwgc29tZXRoaW5nIGxpa2UgLUVJTlZBTCBwZXJo
YXBzLg0KPiA+DQo+ID4gPiArCQlsZW4gKz0gc3lzZnNfZW1pdF9hdChidWYsIGxlbiwgIiUwNHhc
biIsIGRhdGEpOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArCXJldHVybiBsZW47DQo+ID4N
Cj4gVGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4NCj4gSSB3aWxsIGZpeCBhbnkgZXJyb3JzIG9y
IHVubmVjZXNzYXJ5IHByb2Nlc3NpbmcgaW4gdGhlIG5leHQgcGF0Y2guDQo+IA0KPiA+IEhvdyBm
cmVxdWVudGx5IGRvIHlvdSB0aGluayB0aGlzIG5ldyBzeXNmcyBvYmplY3Qgd291bGQgYmUgYWNj
ZXNzZWQ/DQo+ID4gSXQncyBub3QgdW5jb21tb24gZm9yIHRoZSBQQ0kgY29uZmlndXJhdGlvbiBz
cGFjZSBhY2Nlc3MgdG8gYmUgc2xvdw0KPiA+IGZvciBzb21lIGRldmljZXMuDQo+ID4NCj4gTXkg
Y3VycmVudCBhc3N1bXB0aW9uIGlzIHRoYXQgaXQgaXMgYWNjZXNzZWQgd2hlbiBsc3BjaSBpcyBy
dW4sIHNvIEkgZG9uJ3QgdGhpbmsNCj4gaXQgaXMgYWNjZXNzZWQgdmVyeSBvZnRlbi4NCj4gDQo+
ID4gVGhhbmsgeW91IQ0KPiA+DQo+ID4gCUtyenlzenRvZg0KPiANCj4gVGhhbmsgeW91IQ0K

