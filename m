Return-Path: <linux-pci+bounces-27303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E5AAD0EE
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 00:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89584E7E3E
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D7219A70;
	Tue,  6 May 2025 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G1FvI18B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Yib/+zR2"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722B218580;
	Tue,  6 May 2025 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570315; cv=fail; b=m3Mwhm8vKcpvS31QELbwPraVannEirGPHGeF7r8KacuORozoSNrBE+SBr97/QBSxQmaB+x888pQEiWDsOUEdcfZLJNQsrctSllfSKywMILQWpPdFcu8asb0+0BMta4oU2LFggigI+NFcI9RxnLd/FTWDz+eavO2W0CAPtdL92pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570315; c=relaxed/simple;
	bh=4Va3DSHcZoefk2n4hgSw+ilqAFxNpcFq1EJwQQBqMpA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oHhQsPEAg3kgCk0i9+2sCifFr//mNSdIytl62g+O/TZKQbOaXCCXY7iIJyrLGoLnT8KZ83GT0HBIlMm6VEfZvdfqpI8IrWElSqXDxd37BlCsESMNeiJIG/1nYhD6bCKH2Wvjr0zBnkEO0aDA7HLh99ymqN/B+0MEDQyKle3EA1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G1FvI18B; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Yib/+zR2; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746570313; x=1778106313;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4Va3DSHcZoefk2n4hgSw+ilqAFxNpcFq1EJwQQBqMpA=;
  b=G1FvI18B/kw7Jv3OP8IQqsUFKWZJXzsI9elb941Z7ejLqe2RCzpzgxGq
   O63a5Ll5jvlzr0F261Km8sXsmGloXRGBs9+/YLuhAeE8e5oqBRnNQjz5K
   6Pr6tGwSrsq+/DhYtcxeIa7rNTXlqaIaL2G5V4FImkmTfjs6velbWnOO5
   duw33Bb8L8Y8/HxBrNXBG0qoUUrl29PhifjEHhR7tH4bOLXpJmmAwIuRy
   3W58dWdT7VO3dJfg+G267CduykQWgNVW1wp+RwxVN6XQbHEvOt98v20w/
   jl7/+Lg3FhW2unezf525XmCX4KUhkWitpcWPCOuyxn7l1YchTJZ8DyE+v
   w==;
X-CSE-ConnectionGUID: dp8C34fcQQ++CxRK3gYH5A==
X-CSE-MsgGUID: 22r/WRVJRS6+loq6CPoLCA==
X-IronPort-AV: E=Sophos;i="6.15,267,1739808000"; 
   d="scan'208";a="78993160"
Received: from mail-westcentralusazlp17010001.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.1])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2025 06:25:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCJiUuLmnmPGKVK9XBR+0pryH2gdqyN0P9BQHyIotKm5mIoqqjkmBRJGg29+Ti2Qfk6K0rAOsoKdFzSpTsAu6Gy7oGdxqVZUScuTpURo2CPqGmzySKCrON8a1QkUMF0F4Mw6xlTGm0LaeziHkgDwZW8UwexUfklvc81pkmJWynJ+p1HLJlym6p3kQYD4e4J+lVZzsLpQLTcErPA3zRmY5R415lTjBEWcVxUgg+1Q6DUE9PkLHs2xhcQefCFzdBS69F9tuAe8pruStVykYMYKcoO5FNfmU0AeZhy5rPd1a7ArO7ORq3t/WNvYf9oAgU/Seih9R0p+55UcAZRBr3zFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Va3DSHcZoefk2n4hgSw+ilqAFxNpcFq1EJwQQBqMpA=;
 b=vqo5mLI4xWJmfpfm6JVe+eWXG01e2s1Jn+vIRRrH+dGFOdjTsD+KlgfTCOUPN0oXELIMAurwRXG7q0hVQhe5QaN0VfweVPohEkfY0081VasqG9KNArjHUZmK975K2sXZEukgzceVin7P7F2/Ju/iWx3JATj0ySH0xloNX+cw2uL268nxPVHfPYUadiquj0m9Wj/5QpksmnDglspjtRwSK49NUoDWC5q/BYg+aiQoTzXeO9NEzTMlkBf1n84hbO6kxxfCMMHC+T47Tb5+BtlvXMsdoRDp1mUZsgyuLm4daIGTbnDuIse9EYK1PUtoZ/pdvEirL/GWBwtIrwhl4ar5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Va3DSHcZoefk2n4hgSw+ilqAFxNpcFq1EJwQQBqMpA=;
 b=Yib/+zR20ymJ6CKSM59BK27O2NYPiKS4es19ATpt4Lnlh4iNx0pD9MK7LuCTc5/hMe1YD4rhAXwG2FfjZ/pr39DAd95ndZa0gTD146wEmcereBovs4oi0cq3JL6LuO33JLxo1axb5a17dV+7r6dvySviIlG1YAAIFqflAdTtgpI=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by DM6PR04MB6729.namprd04.prod.outlook.com (2603:10b6:5:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Tue, 6 May
 2025 22:25:07 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.8699.031; Tue, 6 May 2025
 22:25:06 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "cassel@kernel.org"
	<cassel@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"laszlo.fiat@proton.me" <laszlo.fiat@proton.me>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "18255117159@163.com"
	<18255117159@163.com>
Subject: Re: [PATCH v2 4/4] PCI: qcom: Replace PERST sleep time with proper
 macro
Thread-Topic: [PATCH v2 4/4] PCI: qcom: Replace PERST sleep time with proper
 macro
Thread-Index: AQHbvloUv1pLnzlt90ePHDz9MuBWibPGLrkA
Date: Tue, 6 May 2025 22:25:06 +0000
Message-ID: <2691ecef7ba9ea6dcc3b98c03a31536b2fa9ec8c.camel@wdc.com>
References: <20250506073934.433176-6-cassel@kernel.org>
	 <20250506073934.433176-10-cassel@kernel.org>
In-Reply-To: <20250506073934.433176-10-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|DM6PR04MB6729:EE_
x-ms-office365-filtering-correlation-id: 74f2f388-75d9-4e73-b573-08dd8cecdadd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkRRUVRGVm42SmRMbEJBYmhIQ29xZmhTS2pDY2Y1c0d6a25JR0FZbnNKaTNZ?=
 =?utf-8?B?dEs5OWNiYXFzd1E3VzdkQnpvMWt2Zll1UlRBMnBLMkN3aUI2b3Y2Q1pUeTh6?=
 =?utf-8?B?SjJIeGpVeTF6eE1YSmRnQ1JlTzhXYjJKa2YxL0hwQ3ZwdFNCMWYzaVV3R2Rn?=
 =?utf-8?B?MFlxQU1xaUxibTVQRjhoUVFvU3VuMWMrVnFxRk9KUFlMTUthY2hhS3pCeGts?=
 =?utf-8?B?Z2JtT0FJdzJRQlBmL1pIYzFGY2pQUFFBSVFXMVZnS3RMVUpyODNGYTNoQ2VR?=
 =?utf-8?B?cndNWVZTS1prQ1N0SzRXcTdONkVVcXBYTE55OEF1YU50YUxjM0lJcG5RTGli?=
 =?utf-8?B?aFl0bGt1bVBhb1ZvVnVYdWdtSUc4QjhXSUxkY2x5ekdpb3RDRTFDVTB1eHZN?=
 =?utf-8?B?RHJJTmIvUlgvenRNUmw2WkEwbGJyMjJUUEtISjNSZkNRMFFrSW9JanptUlc4?=
 =?utf-8?B?Q01xWElCVThKcmRxYzg4RkMxT292YUVTZHFBcGZ5UURwOGVqYzNIMzRqeENt?=
 =?utf-8?B?b3o5YVFwU0RBdk5HS21FdEN1ZnRhOEx3UThCcWZMditiWXJnK2lEQ3dHdVZq?=
 =?utf-8?B?aHVrbTd0ZzNjaWdzNS9KTDhHSnlQK1gxRFVhbUN2RUd1dFlnemF0WGZVd2tW?=
 =?utf-8?B?Q0YwZ2I4bEtwUnpLZzQ5YjFFaUNqTFBkTGhVNkhtajNlbEZlRUtsc2JFRmhZ?=
 =?utf-8?B?TGt1TG9zcFppRitDL0J1cDFITFlJVEl4cFpHMW15RTlFNHUvcUEzS3FoRDdj?=
 =?utf-8?B?VEpjdld2ckdURmF5T2UzZ3IyV2ZEVXRHOHl0bEhQSkIydDdmYWRES1c0N3FI?=
 =?utf-8?B?NWJxWmR1MWM5c2NpTWwwYW45Rkpyb2VxNEIzVmNrK3NjVE9GQ3ZqeGtzVjN1?=
 =?utf-8?B?V2ZtMmVZS09zR3VMNzhKZ24zTzRCODlKZURBRFY4TkhxSjhHV3NMMEdHSlBy?=
 =?utf-8?B?Zk9WQWZ6WnNOalAzOFBoeGJaUnd2d0lMU3NxcWhKa1NjN1JaYWlVNmQ4UjAz?=
 =?utf-8?B?Y2xTZHpOSTRiZjRYWEtNTlE3U2ZreWZqZmFZOU9veXlJZGIveGZTRDc4cWRK?=
 =?utf-8?B?bUZLNHJadUQ3K3RrM2tycWRFVVN1eWNzRGg4bUdkdUlTUVk2ZVdvanQzbFBv?=
 =?utf-8?B?N3V0UUxyTzhmaWx1dW9pUVNwWGRLa0wrTFdPeHRXeWVQRkxTMzZsajdTeExs?=
 =?utf-8?B?Yy9CUTNxdU04WFppZjJzK21iM01MNjdrOEZOenoweU5Sa3o1QW5CRXZZM0Ns?=
 =?utf-8?B?ajJOUXJXYWhpRFY5ZGZNQ3M0bnJ0QksvcmQ0SUJqZmFLc0VEMkdHd2dxdUVa?=
 =?utf-8?B?RUxEZEpIUVVqQWl0a2lOdzdBTnp6b0tKK1NlYjdXYWVUWjY2bFlOaktteVNQ?=
 =?utf-8?B?aXNoMlUreGp2amxQYldFNTN6bUJFM1VrU0hMR08vdy8rem5ha3hKVTdQcEQ3?=
 =?utf-8?B?VWhOUGJHQkQ5UjY1RXJYQTI5dUVVbHFoVEpwdVgreGNTeGo3VkZlcm9aRHRa?=
 =?utf-8?B?ZHVHZkM2OWY1S2dwTFhFeVdXMyt5MFRYTzNnUWl0MkdaREZsa1BMWTdzTHFV?=
 =?utf-8?B?anpNajdUZUd1aHg4RDhoR2VNZVNLVVlDelg0R1o1aGZ6N0NieHFmOVlycXhL?=
 =?utf-8?B?d0dvS0k5eWsxQVpVZEp5SFNGYXRaRndKcU9ocU1uVExJK0Q0OFBPSFNXSzEv?=
 =?utf-8?B?SzZlOVgzMkNzcjZCaW1BdjdnVVRWT3NPQ1YvZytKYTFVcTMzZk5RNmRFZDlw?=
 =?utf-8?B?RzRydlN1eEpURnQ3ZFc1aW5yQi9SQS9tUnozUEVUL2FQWHZ4MDFiSXduK3F5?=
 =?utf-8?B?UlhTTkdCcFd0cGJ4RjUvVDB2R21HR0xIOXRKSFFIaXR4MElvbWgwQVdoSjc0?=
 =?utf-8?B?SiswaG1UR2hkRTY1K0FOVjlWVmJQVktJN1dnU2szWkhLU1R3dzRaaXBvL3Fo?=
 =?utf-8?B?U3FvcXAybXkxbzF6blBjb2pLNCtHelBMSWtxQTc3ZkVZMWFEd3RKT1ZIQVpK?=
 =?utf-8?Q?VKfaMOmoq4ySiHYOSZUo6wbCB07QDY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjl0aXhZOUM2N3AyTmdTdTcrNFYvYmdIUmViSTNtdUVYK1Q3Rk1id0FlV28z?=
 =?utf-8?B?cVpKaGZ6SUhGalV4cXFOQXpaZjUwVWJaeTBYWXIzTEYycU54UEQyZDAydzFD?=
 =?utf-8?B?bW5tVnYyU09XQldveGYrdUNvQmxhZGRUUWI0WUFUdElET2dSNkowYUlSdEpO?=
 =?utf-8?B?QlpJMkxiTU5oZERFM1BSU1VuREU0N3hYWXpCYjNUczZJMklLSk9UWXBYc0pW?=
 =?utf-8?B?ZUt1SmNrNU9Ca0dtQkdIRUE0OGh2TUhvZ0FDMW1DTlhQNzFCMVRQWHNXZ2hF?=
 =?utf-8?B?Si9ZWjd6T0VNVjRscVNPTXRwdmdFeXd6dm1TWERzMlo1MG1OaEJ2anFSK1JK?=
 =?utf-8?B?UWFqL0RQVWhJaVpNSW56TGR0T0syNFpYd2NmNlh5TmRSaEY4VWRYNGpCNVZv?=
 =?utf-8?B?NVJFejV0WTFKNXZaQUxMbjVXNnlIU1VjK01qaElDQlRZQ1JZQ2JoUk12WUlh?=
 =?utf-8?B?N3VVT1Q4TFRvckVMOVZtQlRBWU42OCsvRU15VTY3UVNNbGt5MkVZNk0relU3?=
 =?utf-8?B?TnFnVjdSaU90SDhaazVTc3lZYzE5QlpLZTZpMSs3amdhUVphSEdWdDJtNnhC?=
 =?utf-8?B?MG1vcHAyQ0VsTDhBNWNnSjJsOEE1aUwxM3A0ZWtraWVwdkRXN1Jkb2hCSnk5?=
 =?utf-8?B?bmRzWGQxTHYvYkRFam5NY3R2QjZXU3VsZCttbWp3ekhCS0VwU3RKRkVoemJn?=
 =?utf-8?B?bmtKeTIrMmNOMWpBQlBpeFExanB2cWZqK25iRWtuY0JGM3ZsYVk2Z29MREZp?=
 =?utf-8?B?ODdTOWdLTldvR0dtTEVZeFhkdEZkRy80QTJlMkQ2Ym95Mloxa0p0VVVmSzY5?=
 =?utf-8?B?WmRQeVBiaTVweHA0OCtWY1MyWUgxNnBVRnlUQm8vTUt2TFJNc09iZkVvQkJl?=
 =?utf-8?B?Q2tLdkR4cHFXY2R0S1NBODNhM1NkMkw0MG5RWDhwcUQ1ZlZnVUtuRHRuODBs?=
 =?utf-8?B?eE1lNHBDaTd5enBqcHZUckNSb2s5M3dSOWNTTzZtdjZWekdXdnA1ZGVJRnJJ?=
 =?utf-8?B?Z01vaU1wMURJWWZvQVFFckVtNGUrcjlHdUc1dFB2bnJVS09mR0JEeGl6L2hS?=
 =?utf-8?B?RjBhSDM0ME14NG1ySmhzUWFFM0hDcDFESUNWOXpKOHBBcjBlZWJKVWUzN3dl?=
 =?utf-8?B?eG96WldrdnlWM1dYZzB2VEdBcnRZYWw5cC9QZlpXZERja2RhaC96UkFzUWJQ?=
 =?utf-8?B?Tnlka0ZoYUtYZmFyVXVteDFYWENQeklrS2M3V2w2OE9YYlV5ZzM2dWMvelM0?=
 =?utf-8?B?a2RtbXJEYTVxZWhEMVlFVFk5OVcvaDhmdGhEUUVqb1ZyTGg3V0pJOWdyYmFk?=
 =?utf-8?B?UEo4TFJwL2VqdkNwT3RHOUJoazNyVnJ1emNwdVlONk5JT08wcTRXWGNobFlr?=
 =?utf-8?B?S2lIK2pnc2tXZzB3SjNvc2tKRkNRWlVQb0JpOXRxZ2lmdVliaTVsdWcxV3BN?=
 =?utf-8?B?cW9YZktnNkdKQ09CdEUvQlU2TG12UDJEeUY5K29nL0lZVHkzMW1OZ1NMejFD?=
 =?utf-8?B?MFBKYkN6dWZIVGxYUUZ6aTFFby9BR0N1c1N1MFd2NDM3NHBUU2VWSlBXUmRC?=
 =?utf-8?B?MVRmME9pV2U0Z3kzMnZQSlE0QjBxOVByZjd3WkNmV0ZYenJqZmxyYkJ1dUt5?=
 =?utf-8?B?RStVa21sNFk1NjNIRzBRTzY5SjBmUmJnMllpM1d4WnRsMjhtZmlBQnpaVTQ1?=
 =?utf-8?B?TU1wbUNsQ3B2bDJzTVA5aE1QaGdJRnBndUZ6TE5USjJpemRYSkdVUlYwSi9K?=
 =?utf-8?B?aStQTUcwUDlHL3hEYU1wM1Zpeko0RFA3WGhEZUd6c01uL3NrQ2JUclplQkJ6?=
 =?utf-8?B?YVBIcm5QVjEreVNzaFRmd3VINXFRTU9WamFWbityTE44ZVRCYTB1S2c2Vm1w?=
 =?utf-8?B?RkFHdGJvcnVDQ0NpbjNjTjlJZ09VY09RWHlmYjNYVEpWc1JnYnRVTGpEM0Fi?=
 =?utf-8?B?dklZR3RkS0FtcUZyMFdKR0RQSEpVTWxETEl5d2E4UkE2THBPU0Rwenl2aHBX?=
 =?utf-8?B?OFpJTTFpZ20vTE1pVnhVdDVCVkFSV1FuNGV2VnhqK0VvRDg5YnF1dG5WSWRB?=
 =?utf-8?B?ZExhWVcxb1FzRmw3WVlNMm53b2h2SG10TWNCQzY5endiMDZwQzBMQkxnQm1w?=
 =?utf-8?B?em54cTB4VFp2dFBIZHpvcDFYMStaMTYwMmVtQUExNnh1VUV4YzVxMFFxNU1w?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A17460BE4B56E142BB674C60F49E6419@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZTk620HNAxY9LZb+Z9OhdUHBr86n4IZeg+fEpIOANTukfpLhzOyA3L0Iprg/krr5+3xIwlfHiHd4hBR2xqLNnxK7WtQvIkoOTwFw8S1Ntu2P2TGrzKA5ba4pd+valtmUOt/Em69PX84Tq5pJ1RgJLiA9obm5h5aUFytgzQNQ+33qW/fdITr87fu1EySaPpnx7XlGDcsVIU44Vcxfd2gBdkdr4x5lskrBs5tpn0ob0bD0KlUsoTHGIoQsv4zMTg9LZTfzvEVAvECXKn/eK+hYfxz9JJ2Rv5Oqnplu1iZeehzcPea1k4Y3YLekfeOzrkoo78LJ9unJjXXHo5xRbV3ceRCOmBUMebikPKkHHQVce+foPb0YEtC6Z2EqOKJzuRAhXXExx4aTWBDlfGouDJw5klglAAfhX8PqU/ejoNxkYVY2Rsv6qDRYufZaPUg5MPKPKT0eZBQjqg3Hf7wC8rb+s1nRkEl7QFJNxNA1356HUzAHPb6hWoEQsVmQ+OMef/XCMLRa0Whgx5xufLoAsEKQnm6etm4E5FYMRL9gry3tT2dYYnvWHk+CLUU0Ei9gok4R/zY4uZz6LE2ppADofaKGjoD1rNA6DItWdhrpNxCTSbr9bIsTbliT2F3xl9rCjCPQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f2f388-75d9-4e73-b573-08dd8cecdadd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 22:25:06.8115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6UkTAh9/Q/TGo5NIAq7t5ZaFC0/XkBiPxbx54NassoQS/hkOoRxEkVHa/SyXRG8v9t8kvlcm7migq8HDaO9eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6729

T24gVHVlLCAyMDI1LTA1LTA2IGF0IDA5OjM5ICswMjAwLCBOaWtsYXMgQ2Fzc2VsIHdyb3RlOg0K
PiBSZXBsYWNlIHRoZSBQRVJTVCBzbGVlcCB0aW1lIHdpdGggdGhlIHByb3BlciBtYWNybw0KPiAo
UENJRV9UX1BWUEVSTF9NUykuDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTmlrbGFzIENhc3NlbCA8Y2Fzc2VsQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiDCoGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jIHwgMiArLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jDQo+IGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1xY29tLmMNCj4gaW5kZXggMDFhNjBkMWYzNzJhLi5mYTY4OWUy
OTE0NWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNv
bS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcWNvbS5jDQo+IEBA
IC0yODksNyArMjg5LDcgQEAgc3RhdGljIHZvaWQgcWNvbV9lcF9yZXNldF9hc3NlcnQoc3RydWN0
IHFjb21fcGNpZQ0KPiAqcGNpZSkNCj4gwqBzdGF0aWMgdm9pZCBxY29tX2VwX3Jlc2V0X2RlYXNz
ZXJ0KHN0cnVjdCBxY29tX3BjaWUgKnBjaWUpDQo+IMKgew0KPiDCoAkvKiBFbnN1cmUgdGhhdCBQ
RVJTVCBoYXMgYmVlbiBhc3NlcnRlZCBmb3IgYXQgbGVhc3QgMTAwIG1zDQo+ICovDQo+IC0JbXNs
ZWVwKDEwMCk7DQo+ICsJbXNsZWVwKFBDSUVfVF9QVlBFUkxfTVMpOw0KPiDCoAlncGlvZF9zZXRf
dmFsdWVfY2Fuc2xlZXAocGNpZS0+cmVzZXQsIDApOw0KPiDCoAl1c2xlZXBfcmFuZ2UoUEVSU1Rf
REVMQVlfVVMsIFBFUlNUX0RFTEFZX1VTICsgNTAwKTsNCj4gwqB9DQpSZXZpZXdlZC1ieTogV2ls
ZnJlZCBNYWxsYXdhIDx3aWxmcmVkLm1hbGxhd2FAd2RjLmNvbT4NCg==

