Return-Path: <linux-pci+bounces-22755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EFBA4BD69
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 12:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221691895337
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688101F1516;
	Mon,  3 Mar 2025 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="asHTr+0J"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF51E1DFD95;
	Mon,  3 Mar 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999812; cv=fail; b=KeF0iDwVa1y5zz+rFuyUCTRQVzqu6I6XVVv5bKkBU47EsAgbf2nyteaQZuRvTkjH9ofThl3UCqp35a3ZnOEt/lmgxoGB74xysUWF1VMiXTtIbGyE/JnWDBrIKloGqQ0MaLILwh2yTCXeGKZHzWPITG5jWEjLJn0WUHnucGAGrro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999812; c=relaxed/simple;
	bh=7A0EDs3Ha6pvos5JYw1iBnWcQ+U0oA9ExDTXDjcbz0o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+jSlN/sLzVXNsQuJthm+66jIx+eQRtgqpCST1y/Yx43O7j49vXvtKH/QnPrz9PIE4WjWbqc5/++YrNAJJGSayAuWF92cRr0dYhXvIccyJyuiajzE9RFkzpkNPhBFqOUBFdOEBMt9OL0qauyo/4Y8um2mhgW2E80TQNrDaKZ9iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=asHTr+0J; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8DxQSBVI4FaPF+Jz42LLRMe4Dk+2TjZLA9yIVTr0w79SSO5JTVgiY5YKVImmeeC1j6suxnj+L4oBWhIMuWHWQ7hDkRnCViaFR0c/2Pc6MknGEY9Tl3KOZBWWJlV7BCZbDevmrKOZFQ2eBSZ/+JyD1Uw2kEwf5wUQKG+RygEoHD6W935DN82zW1GxXPw4UpfVyfxV5dOdnWPSbYBkGTF96pXXzpgJopMyeiH+EiRuCcMHaO6M0kZv0gA8vf12USi31XLClpsspNI5rOm52lBh/0ZRUBsZg7vl/IyzAKApOFe6DjDwvb3oetUOmvIm8puKoXhlckSXFR/GGnODBzG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAodrB1ax04/aad+OCYHJCK4vGEqFRXyEznCz0Jwx/c=;
 b=eX5HEfun99ScU0N2ZXvYFcFztw8H1ZSFlJwzPbz0mKU7tg0677o08AICS6dR6/Si5Ubr2XJ87wmInp3HWxjvy5sUW2fAS6mZMbbjVlYX35EqCCWrqpSMJMKlKbnYL0NyWNjyzXOSsDg72j6fD3JHCpBsvG5dXTeoafMbjWTRaaymVPuk+k22B+HqEH3w755qzq22KnmPKy0op4qWVUNJEUgoygPxm8d7pwLr0FCjSKH+fERWA1+9da8Lk87awD4JM+HQ8NmiUoOEEg/iZS+zNF9iUzYbAfilFEZLnICLV/WRem/VDBMP3b+Rc2yXfmogqsl8nHODXFztFdgMt7MR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAodrB1ax04/aad+OCYHJCK4vGEqFRXyEznCz0Jwx/c=;
 b=asHTr+0JQAFcYf0nk/eNMBQfNvn8GUxDnCtAhC9/ogU2FxH+1h8Mc9DX4GmS6xpBTzxTkk2WnYzWdP0alzSnZKF46lmjUs/Xj+fCU0oK7AV0v8AvD14pm4jsAHRT6Qk5DNluPKsLRMSGPws0ruo+vlH1dnMz2g7pQB/efd4t5lQ=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 11:03:27 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8466.024; Mon, 3 Mar 2025
 11:03:27 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>
Subject: RE: [PATCH v15 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH v15 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbicP5GBKeL5PhOk2mHqOVUrF9IrNhMfYAgAAQyWA=
Date: Mon, 3 Mar 2025 11:03:27 +0000
Message-ID:
 <SN7PR12MB7201C0E60127BE7743E0C80F8BC92@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250228093351.923615-1-thippeswamy.havalige@amd.com>
 <20250228093351.923615-4-thippeswamy.havalige@amd.com>
 <20250303095800.GC1065658@rocinante>
In-Reply-To: <20250303095800.GC1065658@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=01774df2-9daa-4a63-8c18-e00206bfc8b1;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-03T10:58:05Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|IA0PR12MB7506:EE_
x-ms-office365-filtering-correlation-id: ddf4e604-dbec-4495-751a-08dd5a4306a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?63eKmxRX7Bgc+xL34S79/nzdQEeD1hnamMLRVGCGo/ADPOMySyi3g5kTnq?=
 =?iso-8859-2?Q?5Fgfpt9nGLskGNE3hZ6ijcGtjwYWF6WvgLc3R6ZNDHfWrJ4EsEeKN5f79U?=
 =?iso-8859-2?Q?d/+Fg4f8eHyvulnVK1dwd7l6h+sS+mZOoZGFSq3TKmagftDAjzO+aThOBi?=
 =?iso-8859-2?Q?daYlzBEncL10TkdQXIVrTHeKFBAkhMZToTRGMKCB0O9Vp7EunElDE9TvxG?=
 =?iso-8859-2?Q?OmkD3X55BBEWgD3CPqx3ss2YKdP0hakKXwxMfujMTfPhXVuYc0SRxLccen?=
 =?iso-8859-2?Q?fVVM1493FPIM9LxTAmMC0+JZJeAv4J64MZSQM3CzrWkZcXSBbr6JgCUnsK?=
 =?iso-8859-2?Q?yWb9qYnLV+b5FCaEKO96Y9MbCZ1+7CSL7kvzOzuyyA9O5JjAXxqOCRw2A/?=
 =?iso-8859-2?Q?uJdkOMXFCnqDsXRr5BlmXbDIACYsGXr85XVmc9A3sqP2plyqnthL2CV2kE?=
 =?iso-8859-2?Q?bWnrzWA3nNMTobhCT8W9T32/EtetjkPYlfmSM2pfBNST5EhOL+yS1ol/Tc?=
 =?iso-8859-2?Q?DzyaNPceOAoYBmqzZ/DbU7VSoQI5VUOpJTqUr3WhfpExocEYRN2K/Ckhty?=
 =?iso-8859-2?Q?oiqZYrgiyWrf8nH4ZV4WvmmArczlC8NoouV3dEWyReAEozgsVkPKORJQcO?=
 =?iso-8859-2?Q?vjr6YB4QAtI6KZbnY5oDJrcc9h4s6Kt15gTKOlHx+ynIq2uXrJ+BFMpuwk?=
 =?iso-8859-2?Q?908e4Zagx4AfcwSleoIQfW8iq10saog/z6rsiIADZ1wymd2LarCBJIW29Q?=
 =?iso-8859-2?Q?1J+hDAl7jGxq2bXeTlhY+mvdxvQivpMO78hDs+Moq0yZ3jjnCeYs0PxisK?=
 =?iso-8859-2?Q?8jW4ndJ/Bte8lg1jTvclllhhJG3v922RXbaI/eVBDDwCcsem1TcASogfPb?=
 =?iso-8859-2?Q?7EWxKeNZVRyqVTm8KrGRoiWuoU9oPZ2gVLB+7qiyQTD0upPPYDZ6H6XjKN?=
 =?iso-8859-2?Q?IJHNkESdGLteHtco6g29u10PAMFqqtBCi8xm4QDsWlzKBuyBpoFWncyj8f?=
 =?iso-8859-2?Q?IBS2BlCOO4tPmETBfvpRzqFIJuPVCuPMSnKtqtc5ZXRtJuG0FCu4tAJNh8?=
 =?iso-8859-2?Q?0WRoTLngij1J3/MzqXjwAV7jU/0jvYOL2vFR+UdsHFKi//s7mgsA/fu7X/?=
 =?iso-8859-2?Q?xVkVtlJztR6yI/kEJpByABeZ7Gsfxmu25OdTeF3W7Muilj5neHRy/8HqSt?=
 =?iso-8859-2?Q?QTAq4rlMAZ+Mov5d2WqwTcWp9d9rlR5bozCaGndGacfKYlAtIIN4y7Cb+U?=
 =?iso-8859-2?Q?3pAGo8RikqQkRr5ssyimK4Wf7fcEFOXVG43bWLSL87dDGRSVvfh061W5HZ?=
 =?iso-8859-2?Q?2gLD/I0ABvIy6t3lXN/cqNgzORnTV4BRHEUr6Xja9XZs6VUoLpDuoNmcj/?=
 =?iso-8859-2?Q?FOGCwcm80r3XyCI9w1v28nYaGEuP4CF+tfg3O+40ZNZRZvzusvj8b0za/5?=
 =?iso-8859-2?Q?ysL2qoMLQFLCpWZCLHGTNE6lv+r0nYJAzd00KqAU/0y/mPTsyCUNKCPnBP?=
 =?iso-8859-2?Q?UAYo/xfIeCFGAxcUbbW2+V?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?YfLqbFQS//N/YIjI79DyFAWhMiktzXAVvlzY7LvycWvmbS4foSjQctb7AY?=
 =?iso-8859-2?Q?P7re2bIfjMwdVap1xQTPxsk0D7YHi4t/xaQ7akISuNFCfr3bQ2X+NAqHkQ?=
 =?iso-8859-2?Q?KU6lKK6jJzz48TZFm64HUP/MTOt3IEVcVx+/dFkSwumOWSB8pfR1aZ7nQj?=
 =?iso-8859-2?Q?wfn5svQvHKeJu//hKibyjLkPt7CaDSysYMo+Ku9VlHiQYGXVpoxzR3g3Kb?=
 =?iso-8859-2?Q?wNimaiKAMXo7UdRrdXhXvWJUcmjsBGYVC0kTPfGDbIXcZ4/5kJfW1736m5?=
 =?iso-8859-2?Q?6orZ0Df9ikokBe7v3B9NRiuEpj2sJmprKjvZ0wX/P9rRfuH92ALGQky9gJ?=
 =?iso-8859-2?Q?+2NakMlcHFOyURHvu3YZppklPU16ujAXjO7ybIOBNYBVORsV4B3HL08zoC?=
 =?iso-8859-2?Q?KC1g9hetDX5p7kGspKhNqz6ZzWTHtZT9JMx57vxdGmOQqrtnAZlA0Ij1uc?=
 =?iso-8859-2?Q?BLTURk2kgISlAR6WXg+fJtDamUeIhH/1Rf1nhtoUdS/lhpcA6tO3K3gkkh?=
 =?iso-8859-2?Q?qr4CitGEjA2d+TWsnje2OvRcT4JgKcgafzWZDCd01m/cK+VTQ/ll3AtQes?=
 =?iso-8859-2?Q?vGdBblGOk8FCqStHckrsLArq+hMOSdVgBPth6WTA5hMwZxMOYXChFjX9U/?=
 =?iso-8859-2?Q?HWheqVJ25SAnJ8GeseR+/JVFlJ9mlu+eHFjDM1JKHdYh/TyhKIozLtLEFa?=
 =?iso-8859-2?Q?yJJ3zO4njzNNf6wujUJV7aQM5+rS/wwVyWY60JXt0SD1MtsEQx53VDlfeu?=
 =?iso-8859-2?Q?tyhFOjJLRwQhLRHXZ4rRrzK8q9GcePJ9+JRmtsXZQ+O+6s7pRCIZAMCDII?=
 =?iso-8859-2?Q?5hXSHgZXo5GuKWhXIIHEeYQOykCJVWsB377+IvgFsR7vsStfmCeBg3jj0t?=
 =?iso-8859-2?Q?OYvkmfFxcU+RAsQOygsu7kkwID3rut8gwZ4hsv53ZuSR+e6YS39hC2idbu?=
 =?iso-8859-2?Q?SivxaVlNcq+qaJhxcklS/Je8pZUYgHBFkrqBuDSmjOds07OpbytKQTzR06?=
 =?iso-8859-2?Q?1iJVUm4Is1FOLBlO/KBm0tJlqR7YOKY1/c6vGY3uG/PDIqEjWtwHEytlsU?=
 =?iso-8859-2?Q?YYXjbAxdSfm7OSFzjTAwkLnOPYNT3f6Ws80RydNm9Hfbcr4L6yubbbd7DN?=
 =?iso-8859-2?Q?Gh21iHIsdnwifH8u/UNaS8PnEFpru0pzc/sSF53Y0e3laBS6g3lflalDT8?=
 =?iso-8859-2?Q?qm/l9IU8XmvJUmY/5chGdo/g1NEB6hOq+MiuqVvzpGyOFplC6dy/ErqhDX?=
 =?iso-8859-2?Q?FehBjuLkLk2zu/HsTI9BfuAmsvos+pyOl/Oz4C+LI8C7gjRaHZizDN5SGC?=
 =?iso-8859-2?Q?DUDewXNEUGuj8TdOu/fCFYjAslEkkaU/JcDfn3wCKGEv/ImqXhQc44ZdEg?=
 =?iso-8859-2?Q?Gdj6Vkkq+b/30KtqI6LGeUj/YE971nOyOytDby4HikA/dfAGxth/MUTEei?=
 =?iso-8859-2?Q?xxZHGLoZG4CEeFzMGwbpRJgxUDggapBJUWXWv7zMk77zNQv8X5cuBd4ZLf?=
 =?iso-8859-2?Q?kHzGrYm4ouVkcpyJ381b3/LjKH0UZfsqXVmauQO3KWKspPPiF9g17MS0Ga?=
 =?iso-8859-2?Q?r1AfrLcECWGkSqsY4BNVbKtwYDZUjjJ5JYhyoH/dUq4GxbIeD0OXoCi01r?=
 =?iso-8859-2?Q?7utbsn0LGlxmU=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf4e604-dbec-4495-751a-08dd5a4306a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 11:03:27.6723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0sQRX2BKj1jNkEkWv9GV2kh3pUtk1OCryTmqrzp9Iz4lAB3lkAzIPm9pTx6+vgJlGLff8QJd5iBBIsR0sxDOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Wilczy=F1ski <kw@linux.com>
> Sent: Monday, March 3, 2025 3:28 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>;
> jingoohan1@gmail.com
> Subject: Re: [PATCH v15 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
>
> Hello,
>
> [...]
> > +           err =3D devm_request_irq(dev, irq,
> amd_mdb_pcie_intr_handler,
> > +                                  IRQF_NO_THREAD, intr_cause[i].sym,
> pcie);
> > +           if (err) {
> > +                   dev_err(dev, "Failed to request IRQ %d\n", irq);
> > +                   return err;
> > +           }
> > +   }
>
> Out of curiosity: would exposing error values be of any benefit to the us=
ers of
> the driver?  So, perhaps:
>
>   if (err) {
>       dev_err(dev, "Failed to request IRQ %d, err=3D%d\n", irq, err);
>       return err;
>   }
Thanks for reviewing. Yes, this would help to understand the error details =
here.
>
> Thoughts?
>
>       Krzysztof

