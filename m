Return-Path: <linux-pci+bounces-39330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8F9C09F70
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 21:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DC53B95C3
	for <lists+linux-pci@lfdr.de>; Sat, 25 Oct 2025 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA10A2FF155;
	Sat, 25 Oct 2025 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lZYqfy3q"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011024.outbound.protection.outlook.com [52.103.13.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA77262D14
	for <linux-pci@vger.kernel.org>; Sat, 25 Oct 2025 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761422034; cv=fail; b=OtHQl7K5d09rdUFLfjf8c0oNO1Ne/0r0O/VeKl4m+Kl3lBbD92wt2ZIt+IAHiqdTbgf+zlDTDc0Oj7G+YIXm2odn0WG6uYL70WagjTy4Azqyf4ss2pxu969IAdBCDqbbNElKfynvAPKAyWGVvg2uDXGIfhPPCYwtKQ4GGIujtB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761422034; c=relaxed/simple;
	bh=ESkJy3FzPiAPRDNSIiQQ3wVEZpJ25bQrWrR2P85No9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jB5ePocOiDFD1+kR1g7QOKGvl2Y40e210XrvU8JRhYKIfwGxVas9R9DeKlpjD+cr4vnbn8nY2CFv9d7U+dFaIy+6zi2RXR7PjaWpLSYu9tzuLemrN16rsIhK7lSLGdYP5srl7Ak9tV30pTA5uPboxUNW1MZ4iP1InsGZeKh59aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lZYqfy3q; arc=fail smtp.client-ip=52.103.13.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qav2/W0LMrEtz0IPtHbuynXFx2D3duxC7p6zvhNWkdsWVzrKir462m20P6Ctry2lue/popUKWV41DepGZf/TOA5e7N9EKTGTUlpgF5hnS1a008OjFOB5yCikm6Pz2MLlso6mSoaPGEpkcmS9fYHUIqHbrktNp8oT/ztIRkoWNgzMDDMepS5U94rvEEDuLAvYYUsHU5DHuINcyo0nxhCAS6fN26nvQiybXfjIDRfcMbKpRjIPqYpkVXoZm4SzIW/RhTwYdcliiblcwKyBEzzIMI+2BOPErjmyWESCVigOwoKFdv+DuZ9t6ZRJRTCDiN9pNBRo6OPqh4L2xwcCcEnqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFrqEooK9DLLL0EEzmoiOA3vGy9mlF/hdUlrVB5w5DE=;
 b=hb8ev2KdJK9VxlJISYwDM1RdgLbCYK9GYQVnwMnSZzr8mQjlH8f8/F8kkFFSnEN4pUy0Mo7yYIIDMLiJyuvQeAOV4zc7yvlAnobW1YSn7oSbINacwo1ZdsRTJKwMPPzKelhS2ARmcykrKG+2sL/MynfvWG9cv9VeFaxtbU9KOvEoZyf3tGC/uvUXnOOIXdoQy7k9l24VUft+GDEiL/MxycAAbTihVoLUCq/Mt4cckR/Z8dxrAmZCb1ehXvRojrm95UlhIg5USrmk1sfsQxbheFl/J4oMl2pEUigCZHmUuSsE5akuaXfiFk+NCmyY19kkK5VOUVjyeOi8y7mZhJyrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFrqEooK9DLLL0EEzmoiOA3vGy9mlF/hdUlrVB5w5DE=;
 b=lZYqfy3qgt523/AoATwj5VvsYXRJaHNwX7LyCi4J0GIQFYmLyHkCPDGFBA5rCrCkRV4wrEn57/NG437eZhtVaAd/jNEbc8V94aT7rpfKXvL3NgzNcaz6Q4fSv8IcMbHbNV+BfqUWKwv9RBORfeepHAVRW0+y4tDxbVOeOzAaHbuExE0TofLzMgnDLYOVghPuD2jAcbF611k6psDrKFTNSVlpRCQHZJnNweoqrU/rk7E8euiUG75DpClzpMsSD2v/LB+zIM+5qfmlhIb/csq5OAB7cvI80tVU4T5p529kGuAw5kSeHL8lGwFmzkNNx49IB8P4ZI5jcVdv2KlV0HyBHg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CY8PR02MB10186.namprd02.prod.outlook.com (2603:10b6:930:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Sat, 25 Oct
 2025 19:53:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9228.011; Sat, 25 Oct 2025
 19:53:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dan Williams <dan.j.williams@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>
Subject: RE: [PATCH v2 1/2] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Thread-Topic: [PATCH v2 1/2] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Thread-Index: AQHcRTgHk8X8ucVVNECxgPpWtc9917TTQ7Qw
Date: Sat, 25 Oct 2025 19:53:50 +0000
Message-ID:
 <SN6PR02MB4157A61D1497F3F205E1A845D4FEA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251024224622.1470555-1-dan.j.williams@intel.com>
 <20251024224622.1470555-2-dan.j.williams@intel.com>
In-Reply-To: <20251024224622.1470555-2-dan.j.williams@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CY8PR02MB10186:EE_
x-ms-office365-filtering-correlation-id: 5162a7bb-fb80-43a1-22c8-08de140037de
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15080799012|12121999013|19110799012|31061999003|461199028|13091999003|8062599012|8060799015|1602099012|52005399003|40105399003|440099028|3412199025|4302099013|10035399007|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Q0AtWrXWiDwnN9DS3onJ28G92c6ssvdDJLze01XfTWgK4xlV/4PSk5lniK/W?=
 =?us-ascii?Q?AE9Dha27PMAzBiek93fEckNyHbK4hGSoFNgls4P7ODsWMd5Z0055ce+1+frk?=
 =?us-ascii?Q?1nxN3gTljN+Mw77B9BpK/uUkJV1rtyyj9VPT3juf7Yngt/5jTSPeALQKc9dW?=
 =?us-ascii?Q?KlZeXueDrpGlJoPqgMJ+tclKvknWszxBa8/IUrv5QWBIcUvtMZyLqnokBsUz?=
 =?us-ascii?Q?YyiVm65J6UzxogqQEUIM42V3dDuj+7P7gNVWGkSvWDeB3bDeLf+3XBnS4x3F?=
 =?us-ascii?Q?lqlROcIKGtsA6IGxIbAAuFRoN0qF+bH9NlubR6z8Lr8Ih7Y56yw2XrphLkSW?=
 =?us-ascii?Q?8Q5UzYVWhis0EZJOlyv3Wm/iKd3LuPZvkbLqrS/alQrmJvALgJEJ23XKG1T3?=
 =?us-ascii?Q?kXAGTkBjl3pdhNCsNL6dAIVg9Rb9Upwd8paRaSxS9e7nF1jVYlIGwbAiZInw?=
 =?us-ascii?Q?TOMtwDp0mmZNOlEaNBue7+mWrtgGZnn6L7A11mHYFzeXSFErkNVc6aT923YC?=
 =?us-ascii?Q?uGPvsqU2hYABGwqtXXTcZhh3Ib7gX6ayoX6FoTuqcxJyZq7fzL65KUcGjbjn?=
 =?us-ascii?Q?8N8r8Q+XK0/k5DInUwgfBRWJdhKj/xGaXIhZrrBRt7tyzOBKB43DB/GdA/kU?=
 =?us-ascii?Q?TnYCY04tKNwuyIeW269vkJ2kaRA+71hu8zlF2dBvNynK0VY/NYeWkBr7i/Pz?=
 =?us-ascii?Q?xUyqWKO8evXYsjkCMsP0IT8TiPoY9DRQEg1/jLLfr+vsbuR+nANdMQ4z+mxB?=
 =?us-ascii?Q?Xt/h9J4igpwGvDKhk7bcP92haIp7jjF36FPTOSN0hcYSlER1P5duYLVVNG8o?=
 =?us-ascii?Q?DjyZJzO1eJw/oX+VeSkj2cTOhlDG3u716BA7Oyaa82Q48CBF/zXqBM3K7ztR?=
 =?us-ascii?Q?6R3qFbfV0aRGBD9u2n4h8xA11O7WRGPi2XMaClUx4uLSgooExoPnGJDAW5FG?=
 =?us-ascii?Q?dP+NL3HGB+9uxv5QDSByA/W+kAL26JV9LMyM3B+9XW+zwu/pxw1VBv1gBbVy?=
 =?us-ascii?Q?EV6UvRSjnvOyrnBOg5QblCWKbeUuXeO+y6fgZVloNzjRhdniD3KMZe1tMDKy?=
 =?us-ascii?Q?qn1mN3niv7QYneRCbQ0PgOUx2Hv7kt4JIO9kmoSIMIgeCW8RQZzro9l3ayQB?=
 =?us-ascii?Q?Ot885CTffK/BlnqoXOk66cI15nEE7Svo8Mqi0JIzMrE6+bmayFIEJAURLevG?=
 =?us-ascii?Q?acqKN3hrSogEC4e0q4grIb7fq7e7YUG+Cr6CtrRahvrP1MMUzlYcxmntI0Y6?=
 =?us-ascii?Q?2cgra7dsXHxJJ3TuITbOsbocpQAqCacK+oYqSPWKZ2O/dv2ACLIkxMEnqCf0?=
 =?us-ascii?Q?fD+m8lxL3rslJUIUSfcHgAy7UYa3FphXIT+AEIlqz6slXMcsORhgsQCGr+9C?=
 =?us-ascii?Q?t02nfqa/tYEzlsFdY57Q7f/Og61tQ55bd7t48B3ER9ggoQUTI2fvggTwux0Y?=
 =?us-ascii?Q?ZKuU05psLZFokmcEv35Hg2zT7DLSjp8h?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EdEygkOtABIQXIgRm3b7BTTUNeD5krGtOoxd/FfAvFmWn2j5Ws7qjk/vCDTB?=
 =?us-ascii?Q?oveXvxIu/Ozyf/Oyj6PXyQmJJ7C4y8h7fl45Af+RwbrtUg3550gWSgqhHMM6?=
 =?us-ascii?Q?NOD8VXwWXmURSUeZFYceC6NWikAoo5y1hZ0R/lvNL2R4gdYiqD9C9nvuJvuS?=
 =?us-ascii?Q?DiAca4UBzsG6o9gr1RqhU6Nx3U/1RfxJKgFlMQK55mdb1NxE7xz/gogWbZvW?=
 =?us-ascii?Q?uu3zBYnJO4VVbjzKuOHe3LGv0Z5CWTzCtJBJcyccyoc+EeiVtLR0e69aZUD+?=
 =?us-ascii?Q?x8irdmsCpLOFXh2MZdee0q1sH9OdK2d8Lyyogw7OSljy/6EOEdpPuWlULxS8?=
 =?us-ascii?Q?TnlwR96VubwSgMJYKDsK5Xbqppx8ZqjG0h7d8PdRtr0yRrZT3K8j5iepeMby?=
 =?us-ascii?Q?4heGzrlUgyxvVqGHhMZ1X9DVWVa4+lnv94f9F+mFQqkTOcRcO27CCXBZFdWt?=
 =?us-ascii?Q?OSrCfuqylaiRvNROCRbIL+k5WXaf5JfVbEplhtmSrLqLMKDCFDRwzvcwq+Lh?=
 =?us-ascii?Q?M8VKvbjX5bSlOvrgB/NexqdB8Nz9ccZmNp0iIyUzDWHQodSlQNRrD2iCZhNc?=
 =?us-ascii?Q?WdbNDcbzYjXm8NvZEEP6/j7B7lT6lvO0CZ4cxjYGDn5sbogqT3Tep6gx7D3/?=
 =?us-ascii?Q?PE1apnFT5CxPDjObRv38uj/UUQwyierWbPhbDHqAdS2Ulzi4jPVmMQaq/3Xy?=
 =?us-ascii?Q?zNiNoXER/JFdG9Z71pH3wAnT4FA/GIOHoRNYCF8BxAyhOuWDo6vmRiPqUu1R?=
 =?us-ascii?Q?4pFbu/7JvxDIhfF1FYYWNS7fVHGioOYqTXc8ViEQIWspxKOy5ga6GbVByxY4?=
 =?us-ascii?Q?rUr/3SU12UnribAze4wolerCW338CBRXRXvpglVVzGBzPZeG1jd5pNnl4bc9?=
 =?us-ascii?Q?XBvz/EZJWRhkX71N0NKYHE0iCNyJa1Gy+klC5XSQU+W++kfm4eV5Oqg4JUru?=
 =?us-ascii?Q?sPpmaMUXIobGHehEiWQUbOWGxBKjvMEGqMx+GZTyU2NiJhsPmj6+C2vJq5jH?=
 =?us-ascii?Q?0PJILRO3UDo9h2DyWDXnrdYUi9onknS/OhJ5E9f09o6dk5lAiRLT+OGWjdA6?=
 =?us-ascii?Q?95vdPcadEU8fyzapXo6gr6VNuESla0LIW6FCXGwae7BPoR4b3AM+DWm2Uo4o?=
 =?us-ascii?Q?TfKtHSJg1f42D3W5W56EQPTKb04DJ1ax7FjwmbvcWDYziWR9BPl6qWJfgmZ2?=
 =?us-ascii?Q?dedcDfY7GsRui65Qz5QWcN06xcySpvguMP63+IplpsF8h4jCRV1MTlmXP1w?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5162a7bb-fb80-43a1-22c8-08de140037de
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 19:53:50.2808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB10186

From: Dan Williams <dan.j.williams@intel.com> Sent: Friday, October 24, 202=
5 3:46 PM
>=20
> The ability to emulate a host bridge is useful not only for hardware PCI
> controllers like CONFIG_VMD, or virtual PCI controllers like
> CONFIG_PCI_HYPERV, but also for test and development scenarios like
> CONFIG_SAMPLES_DEVSEC [1].
>=20
> One stumbling block for defining CONFIG_SAMPLES_DEVSEC, a sample
> implementation of a platform TSM for PCI Device Security, is the need to
> accommodate PCI_DOMAINS_GENERIC architectures alongside x86 [2].

There's not a [2] tag anywhere below.  Presumably it should be the "Closes:=
"
link?

>=20
> In support of supplementing the existing CONFIG_PCI_BRIDGE_EMUL
> infrastructure for host bridges:
>=20
> * Introduce pci_bus_find_emul_domain_nr() as a common way to find a free
>   PCI domain number whether that is to reuse the existing dynamic
>   allocation code in the !ACPI case, or to assign an unused domain above
>   the last ACPI segment.
>=20
> * Convert pci-hyperv to the new allocator so that the PCI core can
>   unconditionally assume that bridge->domain_nr !=3D PCI_DOMAIN_NR_NOT_SE=
T
>   is the dynamically allocated case.
>=20
> A follow on patch can also convert vmd to the new scheme. Currently vmd
> is limited to CONFIG_PCI_DOMAINS_GENERIC=3Dn (x86) so, unlike pci-hyperv,
> it does not immediately conflict with this new
> pci_bus_find_emul_domain_nr() mechanism.
>=20
> Link: https://lore.kernel.org/all/174107249038.1288555.123621005021094984=
55.stgit@dwillia2-xfh.jf.intel.com [1]
> Reported-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Closes: https://lore.kernel.org/all/20250311144601.145736-3-suzuki.poulos=
e@arm.com=20
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> [michael: maintain compatibility with userspace that expects 16-bit ids]

Is the above line spurious?  It doesn't seem to belong here.

> Cc: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Tested on x86 and arm64 VMs in the Azure public cloud with
multiple Hyper-V virtual PCI devices in each VM. So covered
both the "CONFIG_PCI_DOMAINS_GENERIC=3Dn" and "=3Dy" cases.
Did manual unbind/rebind of vPCI devices multiple times so the
domain numbers would be freed and reallocated. All was good.
I did not go to the trouble of simulating a domain number
collision.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>

> ---
>  include/linux/pci.h                 |  7 ++++
>  drivers/pci/controller/pci-hyperv.c | 62 +++++------------------------
>  drivers/pci/pci.c                   | 24 ++++++++++-
>  drivers/pci/probe.c                 |  8 +++-
>  4 files changed, 46 insertions(+), 55 deletions(-)
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d1fdf81fbe1e..1ef1535802b0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1956,10 +1956,17 @@ DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_l=
ock(_T), pci_dev_unlock(_T))
>   */
>  #ifdef CONFIG_PCI_DOMAINS
>  extern int pci_domains_supported;
> +int pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max);
> +void pci_bus_release_emul_domain_nr(int domain_nr);
>  #else
>  enum { pci_domains_supported =3D 0 };
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
> +static inline int pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max=
)
> +{
> +	return 0;
> +}
> +static inline void pci_bus_release_emul_domain_nr(int domain_nr) { }
>  #endif /* CONFIG_PCI_DOMAINS */
>=20
>  /*
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 146b43981b27..64f68efaf547 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3696,48 +3696,6 @@ static int hv_send_resources_released(struct hv_de=
vice *hdev)
>  	return 0;
>  }
>=20
> -#define HVPCI_DOM_MAP_SIZE (64 * 1024)
> -static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
> -
> -/*
> - * PCI domain number 0 is used by emulated devices on Gen1 VMs, so defin=
e 0
> - * as invalid for passthrough PCI devices of this driver.
> - */
> -#define HVPCI_DOM_INVALID 0
> -
> -/**
> - * hv_get_dom_num() - Get a valid PCI domain number
> - * Check if the PCI domain number is in use, and return another number i=
f
> - * it is in use.
> - *
> - * @dom: Requested domain number
> - *
> - * return: domain number on success, HVPCI_DOM_INVALID on failure
> - */
> -static u16 hv_get_dom_num(u16 dom)
> -{
> -	unsigned int i;
> -
> -	if (test_and_set_bit(dom, hvpci_dom_map) =3D=3D 0)
> -		return dom;
> -
> -	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
> -		if (test_and_set_bit(i, hvpci_dom_map) =3D=3D 0)
> -			return i;
> -	}
> -
> -	return HVPCI_DOM_INVALID;
> -}
> -
> -/**
> - * hv_put_dom_num() - Mark the PCI domain number as free
> - * @dom: Domain number to be freed
> - */
> -static void hv_put_dom_num(u16 dom)
> -{
> -	clear_bit(dom, hvpci_dom_map);
> -}
> -
>  /**
>   * hv_pci_probe() - New VMBus channel probe, for a root PCI bus
>   * @hdev:	VMBus's tracking struct for this root PCI bus
> @@ -3750,9 +3708,9 @@ static int hv_pci_probe(struct hv_device *hdev,
>  {
>  	struct pci_host_bridge *bridge;
>  	struct hv_pcibus_device *hbus;
> -	u16 dom_req, dom;
> +	int ret, dom;
> +	u16 dom_req;
>  	char *name;
> -	int ret;
>=20
>  	bridge =3D devm_pci_alloc_host_bridge(&hdev->device, 0);
>  	if (!bridge)
> @@ -3779,11 +3737,14 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	 * PCI bus (which is actually emulated by the hypervisor) is domain 0.
>  	 * (2) There will be no overlap between domains (after fixing possible
>  	 * collisions) in the same VM.
> +	 *
> +	 * Because Gen1 VMs use domain 0, don't allow picking domain 0 here,
> +	 * even if bytes 4 and 5 of the instance GUID are both zero. For wider
> +	 * userspace compatibility, limit the domain id to a 16-bit value.
>  	 */
>  	dom_req =3D hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
> -	dom =3D hv_get_dom_num(dom_req);
> -
> -	if (dom =3D=3D HVPCI_DOM_INVALID) {
> +	dom =3D pci_bus_find_emul_domain_nr(dom_req, 1, U16_MAX);
> +	if (dom < 0) {
>  		dev_err(&hdev->device,
>  			"Unable to use dom# 0x%x or other numbers", dom_req);
>  		ret =3D -EINVAL;
> @@ -3917,7 +3878,7 @@ static int hv_pci_probe(struct hv_device *hdev,
>  destroy_wq:
>  	destroy_workqueue(hbus->wq);
>  free_dom:
> -	hv_put_dom_num(hbus->bridge->domain_nr);
> +	pci_bus_release_emul_domain_nr(hbus->bridge->domain_nr);
>  free_bus:
>  	kfree(hbus);
>  	return ret;
> @@ -4042,8 +4003,6 @@ static void hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_remove(hbus->irq_domain);
>  	irq_domain_free_fwnode(hbus->fwnode);
>=20
> -	hv_put_dom_num(hbus->bridge->domain_nr);
> -
>  	kfree(hbus);
>  }
>=20
> @@ -4217,9 +4176,6 @@ static int __init init_hv_pci_drv(void)
>  	if (ret)
>  		return ret;
>=20
> -	/* Set the invalid domain number's bit, so it will not be used */
> -	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
> -
>  	/* Initialize PCI block r/w interface */
>  	hvpci_block_ops.read_block =3D hv_read_config_block;
>  	hvpci_block_ops.write_block =3D hv_write_config_block;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..64aed8705e91 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6656,9 +6656,31 @@ static void pci_no_domains(void)
>  #endif
>  }
>=20
> +#ifdef CONFIG_PCI_DOMAINS
> +static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> +
> +/**
> + * pci_bus_find_emul_domain_nr() - allocate a PCI domain number per cons=
traints
> + * @hint: desired domain, 0 if any id in the range of @min to @max is ac=
ceptable
> + * @min: minimum allowable domain
> + * @max: maximum allowable domain, no ids higher than INT_MAX will be re=
turned
> + */
> +int pci_bus_find_emul_domain_nr(u32 hint, u32 min, u32 max)
> +{
> +	return ida_alloc_range(&pci_domain_nr_dynamic_ida, max(hint, min), max,
> +			       GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(pci_bus_find_emul_domain_nr);
> +
> +void pci_bus_release_emul_domain_nr(int domain_nr)
> +{
> +	ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
> +}
> +EXPORT_SYMBOL_GPL(pci_bus_release_emul_domain_nr);
> +#endif
> +
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  static DEFINE_IDA(pci_domain_nr_static_ida);
> -static DEFINE_IDA(pci_domain_nr_dynamic_ida);
>=20
>  static void of_pci_reserve_static_domain_nr(void)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a8..5e101ced00a5 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -650,6 +650,11 @@ static void pci_release_host_bridge_dev(struct devic=
e *dev)
>=20
>  	pci_free_resource_list(&bridge->windows);
>  	pci_free_resource_list(&bridge->dma_ranges);
> +
> +	/* Host bridges only have domain_nr set in the emulation case */
> +	if (bridge->domain_nr !=3D PCI_DOMAIN_NR_NOT_SET)
> +		pci_bus_release_emul_domain_nr(bridge->domain_nr);
> +
>  	kfree(bridge);
>  }
>=20
> @@ -1130,7 +1135,8 @@ static int pci_register_host_bridge(struct pci_host=
_bridge *bridge)
>  	device_del(&bridge->dev);
>  free:
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -	pci_bus_release_domain_nr(parent, bus->domain_nr);
> +	if (bridge->domain_nr =3D=3D PCI_DOMAIN_NR_NOT_SET)
> +		pci_bus_release_domain_nr(parent, bus->domain_nr);
>  #endif
>  	if (bus_registered)
>  		put_device(&bus->dev);
> --
> 2.51.0


