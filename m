Return-Path: <linux-pci+bounces-14219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9BF998FC5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 20:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66143283CE9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B91CEEB1;
	Thu, 10 Oct 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="edbqmpV+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011034.outbound.protection.outlook.com [52.103.13.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD31A303E;
	Thu, 10 Oct 2024 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584526; cv=fail; b=B5j8+UGYzX896X1IMoD5XeVacRew3DIl0ImMuGPCqGhEYaqw2N2Wn/KPm/aCHgSZ8I1J5LTSGu18J3AvjQzqQf6Li1wndIdt7tcJ8YMuSTci34eXFV7ROQLwqArquOlpKawVR7ea3q15qNw++9tcYntbNL4LPIw51Gr4CZ1sqgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584526; c=relaxed/simple;
	bh=l0hep0MzCGX5JwYEbX/jlTf7c6RJ+u1JWvkBNm9S4MY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gkTXAcCMzdbU3Wd4MYOEP0igQl/E0vDY4fY7Zb5lppAL3tYX6kDGOnFQP4V0RT7LZ3cVrGg4AM6csSLPRRM4OMjSegnv2B+NOhT/NtCDXq2MZ3eFBOy5QoPB+o7o1ZkW/3AbY0W7MLmB4s5ie7dv3faXLe3JPLr3ze9/9M5JLzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=edbqmpV+; arc=fail smtp.client-ip=52.103.13.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0FsynrBmZ3l1qgUbeCncBRO0W6XxlagtHbB7k7bNFCUnK0ewUDHTBnIMX6lLlCZW1zE0lnbo6qY970zTYppFZseggWAJSna5xRsh5venQkqBK/RS7UE47cRnGGkzN4dRt9B4nn/cLjDXq639PAICG4DWK6rJUvzJEGMnFomG809UKVhyz7VJyGLXsctVRCq7OQZIbIY/vbJCfC3+dHj0IkIgNJrChe6oucaPAVgRcZrm7aWNzlLRsmKsbOTNm2P+wwHL22Fv068NwftnBvsvB3SvvifnDP3ywpuirAuHB0cHoDC/v7ORAChQAD2fQt+j166rrSFa+WMgrSmK0KZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vOFvFB4NH5MpMcK1gMDsGoYRYaSGedZBSqFmn/ukgE=;
 b=pJcRZz5jVghXkgwKBDBSPIXedjM+kgm9ge6WRBSly9Byb6on5JBpOqrajJTBP7y66lKrdLUwcvbGYes5+PJHM7TwARsPGEtRcNh2QxhAk1X1dc73aL8T+EeQZzsyHbYbymx3+/iOiX++fWl/WyCIzMJydYc4T7AjsjmHQfBrQe6eWisjcMRMALvH5QQ5eGKaYqyBH49XKnQfBmuESk27s4ToXMOcjFC6Qn8At3WZXzvfXTxtrkTqfbMDxiJJEZQQphPX7/pLBu2X9N6ZZP9WSiXNuAqF5znO5+WcwTr1rTfad7/bLaklLLkihy8wDfxSvym5HlGYei3/4tVae6Jm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vOFvFB4NH5MpMcK1gMDsGoYRYaSGedZBSqFmn/ukgE=;
 b=edbqmpV+ZIOlGRikRYugvtEGJPeNOlfBonjIvP9GcifQ5imhGqnVVqZ94QkVF7s8QYlpGxvxkk41IShZyJpGOFlRDARMd18f53NB2Bo7ZkXOC3YhYTmDPzW3hTuZop3izEcegGH93qjSNR6V7rt02DwnhZjHtpPZ0+kNlBXl4VQrzzbvLOy8+2GqjUok0ytcSFZoTh3F8jIYaTtcUlftf0QVibUos//bHhxwG1MCK4vzj53CV/maCpywQLaOrT08DcOdN+v/5QTCXk9EOCVx0jCXki22X1FJa93+u1Dff519vwP+ikFN2rynJdSnmdkyG8cALFyUORT9EjHbEk8JRw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10761.namprd02.prod.outlook.com (2603:10b6:408:281::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:21:57 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 18:21:57 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>
Subject: RE: [PATCH 3/5] hyperv: Add new Hyper-V headers
Thread-Topic: [PATCH 3/5] hyperv: Add new Hyper-V headers
Thread-Index: AQHbFc4alG3etU2Zk0uJdJbM69ExvrJ/WggQ
Date: Thu, 10 Oct 2024 18:21:57 +0000
Message-ID:
 <SN6PR02MB415716A55D46E5D4F37D7DD2D4782@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1727985064-18362-4-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1727985064-18362-4-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10761:EE_
x-ms-office365-filtering-correlation-id: e6426c18-b728-4aa6-d234-08dce9586d09
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|7042599007|461199028|19110799003|8062599003|440099028|3412199025|56899033|102099032;
x-microsoft-antispam-message-info:
 FKGyeGoKjomKI97WNIf5v00JC5yGcIhzrTJqYTkufj3mW7stt63390NPQ+xdfzNpTcCknFYWFXSXqTKgj0Q2pRsRoebIC6adIiXuj8/iqd1ujbvgFSlTrFNJOtHcC/p68DyHhny/Herc4WnEAFx+fjoI7q4+dCrGoLYW3lC0SaGRMeSgrvOtgDGsFtHIqm0A7sGvSyVA1h+wSwME9R8YBYLTBqEULVsZ+cL8PidY4G+F++BRScEWWgImPuf2PjB/jfn5jAhKeDDiZfkZ0YVdQ8M9cHScAvFz9+oOyL5dEhtdvhGik9alyHHez9B0LDq94A1RtPxGJCLlgqC7HzoA3LFq+G0HOM1yKKzdph2m1F3ZwljHSZcKQ8nV66ntihVT1W+hpClytl7cHCTkutgyWgtEorTJBXwKsHca9kZPozQqEDAyh55fG1gGNQMEEV+cTEp2QLiI6htn1s1uxlXls5Gmtktzzc221YHSs3b3C0TB76Od8+KBhVBWI5YVuf+iMX/42wfvm6QXauAbRLou21oD6NnaznKfIqaVup3x4nmx2Trh8ybeAT/d/62vIx7Kzxeh+Bb863BXy0m09d5LsFfOeWqn590ZyS3MJuyP1enappNhmhdmpQbYq55KE6iRJvz1WBqkn3wAylKRnp38/NEDh/YTj6/l1pp1m5+5vDDopT9T9+E/g9pT5bD/uzPnNcLffMPNbuMm1L6s6wCShPX0OHY8ELV0eXMyu0HsM+Q=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bCvfDI4zjb9O7D9TNyLCtn+tq6o1gzMfueh5xYLe5Oa1OehE2f+WVg9EoIJa?=
 =?us-ascii?Q?E2zQ2GA8Ne334DRcFmn/az12axyhIzg2oly5HPlsUMqEZv/kZt74IO5i1A8i?=
 =?us-ascii?Q?iv+p3SaYtgEv/BeMx/a+Btvlfc1qbeUyijAjs3JVnAasnqu6TTcF97pYRkWM?=
 =?us-ascii?Q?37irQ+IZUfIvKWQGEzVm0T/IKwEjjzSvZSuqIKB/ahic0oSelYRtz6Y/sFSm?=
 =?us-ascii?Q?UqB5+kwC999kyG5OksJuctkArsInJ/3Ewsm3bcREk/0619nJcdYKLcdmChT6?=
 =?us-ascii?Q?SZ1MOdnfwEg1YdjblP56r8/UaLKg4f/DJvpGGkCGCytHzAFZXkkzIZUltiSP?=
 =?us-ascii?Q?afnq05a7MpuAunyJDivx+l5t32pQnHyQ9sN16XZ1ZgZJu0S2kFH0Iqhvegh2?=
 =?us-ascii?Q?VAL4d9O8stdGV4hnTpSTxu0odTbmEyOwzdJozqs251BDx/QCXnD429yRSww3?=
 =?us-ascii?Q?r4/pfpSqA7RRHaB23KHawcOtlo16nLI37/eTGum6fPpCpY4cq8OPUb5J5pOa?=
 =?us-ascii?Q?hc4Q4rXfBvl2Czaj6h5LX0/iyRqqEEd7jWLmHMbLP7bIgjKggDtxHqu3KdiW?=
 =?us-ascii?Q?kCIBud6bs9tApNXWDvTst2aaqzOt9YzW4kTSLjDlBSnsR0m4pH88bbIDIq0E?=
 =?us-ascii?Q?CW8ObKVw41Wei+zxYhWgOiJNlufcHx5rVXhh9pVgQ4cs7gUssVyw7zdQmatq?=
 =?us-ascii?Q?ExifalfD7qaSKt8VVqv+0jJhX2BYekiWtq0ALLGrmwfTh4kiVUJM2CO2IZ6M?=
 =?us-ascii?Q?Jn9LDZ036wr/lOYRQOrkZJJbYfZWQpDBY/zA6HoO55uhHL17nAjfjEbWx7Vm?=
 =?us-ascii?Q?jawYtEMxIOniZbcRwht8SAF27TDjkMmv5GFjDZ/lCFzDnTPmewI+NiPa2UFt?=
 =?us-ascii?Q?oXxKnTmuWkXIiCj3Ayi2LWSn/vlqSnQKnui5QD5YYKVMW2UgUterWRL0R4yF?=
 =?us-ascii?Q?tEQKB3NkwDkYafLQhIrdU7pufyD4SrXcuu6Jz82U52oOzwoKhTN0qZg2xkie?=
 =?us-ascii?Q?YV6LgIaBmKPbGaJ1dRTo5dOlhY/SeTTYyNosV8jY6clrM/DZY6dKRNB05BZD?=
 =?us-ascii?Q?PVPhn94RKMJRTAV0qE16kydDRe3tDiZ42DCx5bEAdj+Svax7kmWE3a/IC+GL?=
 =?us-ascii?Q?kb4eYGfvlhxk1Pjl75BabyuS6vt5nSEXlKttbw6t7JtIT8xGshVC/kLxEfk4?=
 =?us-ascii?Q?BGS304wfauxx879JDiPieh/JhK8FfHdms9I8LfqMeuMjnbIsFg0rTZtmhLo?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6426c18-b728-4aa6-d234-08dce9586d09
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 18:21:57.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10761

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Oct=
ober 3, 2024 12:51 PM
>=20
> Add definitions needed for privileged Hyper-V partitions.
>=20
> These files are derived from headers exported from the hypervisor code.

Could you elaborate on the naming conventions for the new files,
and the rules that govern what goes in what files? Specifically,
what is "hvgdk" vs. "hvhdk", and what are the _ext and _mini
suffixes? Even if the filenames are derived from Windows
Hyper-V source code, some explanation could be helpful. Maybe
the rules for what goes in what file could be captured in comments
at the top of each file. Or if the names are historical artifacts that
have no current value, then call that out so people like me don't try
to discern some meaning. :-)

> This is a step toward importing headers directly, similar to Xen public
> files in include/xen/interface/.

I'm not understanding this statement. The new files in this patch
are obviously following Linux kernel coding style, with Linux kernel
types, etc. I'm guessing there was a lot of "busy work" to take
Windows Hyper-V code and make it look like Linux kernel code. :-(
What would "importing headers directly" look like, and how is this
an interim step?

Also, it looks like these new files take a different approach for
instruction set architecture differences. There are inline #ifdef's
instead of the current method of having a common file, and then
architecture specific versions that include the common file. My
sense is that Linux kernel code prefers the current approach in
order to avoid #ifdef'ery, but maybe that's less practical when the
definitions are derived from Windows Hyper-V code. And with
only two architectures to deal with, the #ifdef's don't get
wild-and-crazy, which is good.

It also appears that a lot of the x86 specific definitions are *not*
under #ifdef x86, presumably because exposing those definitions
on the ARM64 side doesn't hurt anything. But some comments
on the top-level thinking and approach to architecture differences
would be helpful.

Michael

>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk.h      |   66 ++
>  include/hyperv/hvgdk_ext.h  |   46 ++
>  include/hyperv/hvgdk_mini.h | 1212 +++++++++++++++++++++++++++++++++++
>  include/hyperv/hvhdk.h      |  733 +++++++++++++++++++++
>  include/hyperv/hvhdk_mini.h |  310 +++++++++
>  5 files changed, 2367 insertions(+)
>  create mode 100644 include/hyperv/hvgdk.h
>  create mode 100644 include/hyperv/hvgdk_ext.h
>  create mode 100644 include/hyperv/hvgdk_mini.h
>  create mode 100644 include/hyperv/hvhdk.h
>  create mode 100644 include/hyperv/hvhdk_mini.h
>=20
> diff --git a/include/hyperv/hvgdk.h b/include/hyperv/hvgdk.h
> new file mode 100644
> index 000000000000..af44e8034090
> --- /dev/null
> +++ b/include/hyperv/hvgdk.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Type definitions for the Microsoft Hypervisor.
> + */
> +#ifndef _HV_HVGDK_H
> +#define _HV_HVGDK_H
> +
> +#include "hvgdk_mini.h"
> +#include "hvgdk_ext.h"
> +
> +/*
> + * The guest OS needs to register the guest ID with the hypervisor.
> + * The guest ID is a 64 bit entity and the structure of this ID is
> + * specified in the Hyper-V TLFS specification.
> + *
> + * While the current guideline does not specify how Linux guest ID(s)
> + * need to be generated, our plan is to publish the guidelines for
> + * Linux and other guest operating systems that currently are hosted
> + * on Hyper-V. The implementation here conforms to this yet
> + * unpublished guidelines.
> + *
> + * Bit(s)
> + * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
> + * 62:56 - Os Type; Linux is 0x100
> + * 55:48 - Distro specific identification
> + * 47:16 - Linux kernel version number
> + * 15:0  - Distro specific identification
> + */
> +
> +#define HV_LINUX_VENDOR_ID              0x8100
> +
> +/*
> + * Hyper-V uses the software reserved 32 bytes in VMCB control area to e=
xpose
> + * SVM enlightenments to guests. This is documented in the TLFS doc.
> + * HV_VMX_ENLIGHTENED_VMCS or SVM_NESTED_ENLIGHTENED_VMCB_FIELDS
> + */
> +struct hv_vmcb_enlightenments {
> +	struct __packed hv_enlightenments_control {
> +		u32 nested_flush_hypercall : 1;
> +		u32 msr_bitmap : 1;
> +		u32 enlightened_npt_tlb: 1;
> +		u32 reserved : 29;
> +	} __packed hv_enlightenments_control;
> +	u32 hv_vp_id;
> +	u64 hv_vm_id;
> +	u64 partition_assist_page;
> +	u64 reserved;
> +} __packed;
> +
> +/* Define connection identifier type. */
> +union hv_connection_id {
> +	u32 asu32;
> +	struct {
> +		u32 id : 24;
> +		u32 reserved : 8;
> +	} __packed u;
> +};
> +
> +struct hv_input_unmap_gpa_pages {
> +	u64 target_partition_id;
> +	u64 target_gpa_base;
> +	u32 unmap_flags;
> +	u32 padding;
> +} __packed;
> +
> +#endif /* #ifndef _HV_HVGDK_H */
> diff --git a/include/hyperv/hvgdk_ext.h b/include/hyperv/hvgdk_ext.h
> new file mode 100644
> index 000000000000..641b591ee61f
> --- /dev/null
> +++ b/include/hyperv/hvgdk_ext.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Type definitions for the Microsoft Hypervisor.
> + */
> +#ifndef _HV_HVGDK_EXT_H
> +#define _HV_HVGDK_EXT_H
> +
> +#include "hvgdk_mini.h"
> +
> +/* Extended hypercalls */
> +#define HV_EXT_CALL_QUERY_CAPABILITIES		0x8001
> +#define HV_EXT_CALL_MEMORY_HEAT_HINT		0x8003
> +
> +/* Extended hypercalls */
> +enum {		/* HV_EXT_CALL */
> +	HV_EXTCALL_QUERY_CAPABILITIES =3D 0x8001,
> +	HV_EXTCALL_MEMORY_HEAT_HINT   =3D 0x8003,
> +};
> +
> +/* HV_EXT_OUTPUT_QUERY_CAPABILITIES */
> +#define HV_EXT_CAPABILITY_MEMORY_COLD_DISCARD_HINT BIT(8)
> +
> +enum {		/* HV_EXT_MEMORY_HEAT_HINT_TYPE */
> +	HV_EXTMEM_HEAT_HINT_COLD =3D 0,
> +	HV_EXTMEM_HEAT_HINT_HOT =3D 1,
> +	HV_EXTMEM_HEAT_HINT_COLD_DISCARD =3D 2,
> +	HV_EXTMEM_HEAT_HINT_MAX
> +};
> +
> +/*
> + * The whole argument should fit in a page to be able to pass to the hyp=
ervisor
> + * in one hypercall.
> + */
> +#define HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES  \
> +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_memory_hint)) / \
> +		sizeof(union hv_gpa_page_range))
> +
> +/* HvExtCallMemoryHeatHint hypercall */
> +#define HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD	2
> +struct hv_memory_hint {		/* HV_EXT_INPUT_MEMORY_HEAT_HINT */
> +	u64 heat_type : 2;	/* HV_EXTMEM_HEAT_HINT_* */
> +	u64 reserved : 62;
> +	union hv_gpa_page_range ranges[];
> +} __packed;
> +
> +#endif /* _HV_HVGDK_EXT_H */
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> new file mode 100644
> index 000000000000..b7dd22784c96
> --- /dev/null
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -0,0 +1,1212 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Type definitions for the Microsoft hypervisor.
> + */
> +#ifndef _HV_HVGDK_MINI_H
> +#define _HV_HVGDK_MINI_H
> +
> +#include <linux/types.h>
> +#include <linux/bits.h>
> +
> +struct hv_u128 {
> +	u64 low_part;
> +	u64 high_part;
> +} __packed;
> +
> +/* NOTE: when adding below, update hv_status_to_string() */
> +#define HV_STATUS_SUCCESS			    0x0
> +#define HV_STATUS_INVALID_HYPERCALL_CODE	    0x2
> +#define HV_STATUS_INVALID_HYPERCALL_INPUT	    0x3
> +#define HV_STATUS_INVALID_ALIGNMENT		    0x4
> +#define HV_STATUS_INVALID_PARAMETER		    0x5
> +#define HV_STATUS_ACCESS_DENIED			    0x6
> +#define HV_STATUS_INVALID_PARTITION_STATE	    0x7
> +#define HV_STATUS_OPERATION_DENIED		    0x8
> +#define HV_STATUS_UNKNOWN_PROPERTY		    0x9
> +#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	    0xA
> +#define HV_STATUS_INSUFFICIENT_MEMORY		    0xB
> +#define HV_STATUS_INVALID_PARTITION_ID		    0xD
> +#define HV_STATUS_INVALID_VP_INDEX		    0xE
> +#define HV_STATUS_NOT_FOUND			    0x10
> +#define HV_STATUS_INVALID_PORT_ID		    0x11
> +#define HV_STATUS_INVALID_CONNECTION_ID		    0x12
> +#define HV_STATUS_INSUFFICIENT_BUFFERS		    0x13
> +#define HV_STATUS_NOT_ACKNOWLEDGED		    0x14
> +#define HV_STATUS_INVALID_VP_STATE		    0x15
> +#define HV_STATUS_NO_RESOURCES			    0x1D
> +#define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED   0x20
> +#define HV_STATUS_INVALID_LP_INDEX		    0x41
> +#define HV_STATUS_INVALID_REGISTER_VALUE	    0x50
> +#define HV_STATUS_OPERATION_FAILED		    0x71
> +#define HV_STATUS_TIME_OUT			    0x78
> +#define HV_STATUS_CALL_PENDING			    0x79
> +#define HV_STATUS_VTL_ALREADY_ENABLED		    0x86
> +
> +/*
> + * The Hyper-V TimeRefCount register and the TSC
> + * page provide a guest VM clock with 100ns tick rate
> + */
> +#define HV_CLOCK_HZ (NSEC_PER_SEC / 100)
> +
> +#define HV_HYP_PAGE_SHIFT		12
> +#define HV_HYP_PAGE_SIZE		BIT(HV_HYP_PAGE_SHIFT)
> +#define HV_HYP_PAGE_MASK		(~(HV_HYP_PAGE_SIZE - 1))
> +
> +#define HV_PARTITION_ID_INVALID		((u64)0)
> +#define HV_PARTITION_ID_SELF		((u64)-1)
> +
> +/* Hyper-V specific model specific registers (MSRs) */
> +
> +#if defined(CONFIG_X86)
> +/* HV_X64_SYNTHETIC_MSR */
> +#define HV_X64_MSR_GUEST_OS_ID			0x40000000
> +#define HV_X64_MSR_HYPERCALL			0x40000001
> +#define HV_X64_MSR_VP_INDEX			0x40000002
> +#define HV_X64_MSR_RESET			0x40000003
> +#define HV_X64_MSR_VP_RUNTIME			0x40000010
> +#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
> +#define HV_X64_MSR_REFERENCE_TSC		0x40000021
> +#define HV_X64_MSR_TSC_FREQUENCY		0x40000022
> +#define HV_X64_MSR_APIC_FREQUENCY		0x40000023
> +
> +/* Define the virtual APIC registers */
> +#define HV_X64_MSR_EOI				0x40000070
> +#define HV_X64_MSR_ICR				0x40000071
> +#define HV_X64_MSR_TPR				0x40000072
> +#define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
> +
> +/* Note: derived, not in hvgdk_mini.h */
> +#define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
> +#define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
> +#define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
> +		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
> +
> +/* Define synthetic interrupt controller model specific registers. */
> +#define HV_X64_MSR_SCONTROL			0x40000080
> +#define HV_X64_MSR_SVERSION			0x40000081
> +#define HV_X64_MSR_SIEFP			0x40000082
> +#define HV_X64_MSR_SIMP				0x40000083
> +#define HV_X64_MSR_EOM				0x40000084
> +#define HV_X64_MSR_SIRBP			0x40000085
> +#define HV_X64_MSR_SINT0			0x40000090
> +#define HV_X64_MSR_SINT1			0x40000091
> +#define HV_X64_MSR_SINT2			0x40000092
> +#define HV_X64_MSR_SINT3			0x40000093
> +#define HV_X64_MSR_SINT4			0x40000094
> +#define HV_X64_MSR_SINT5			0x40000095
> +#define HV_X64_MSR_SINT6			0x40000096
> +#define HV_X64_MSR_SINT7			0x40000097
> +#define HV_X64_MSR_SINT8			0x40000098
> +#define HV_X64_MSR_SINT9			0x40000099
> +#define HV_X64_MSR_SINT10			0x4000009A
> +#define HV_X64_MSR_SINT11			0x4000009B
> +#define HV_X64_MSR_SINT12			0x4000009C
> +#define HV_X64_MSR_SINT13			0x4000009D
> +#define HV_X64_MSR_SINT14			0x4000009E
> +#define HV_X64_MSR_SINT15			0x4000009F
> +
> +/* Define synthetic interrupt controller model specific registers for ne=
sted hypervisor */
> +#define HV_X64_MSR_NESTED_SCONTROL		0x40001080
> +#define HV_X64_MSR_NESTED_SVERSION		0x40001081
> +#define HV_X64_MSR_NESTED_SIEFP			0x40001082
> +#define HV_X64_MSR_NESTED_SIMP			0x40001083
> +#define HV_X64_MSR_NESTED_EOM			0x40001084
> +#define HV_X64_MSR_NESTED_SINT0			0x40001090
> +
> +/*
> + * Synthetic Timer MSRs. Four timers per vcpu.
> + */
> +#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
> +#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
> +#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
> +#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
> +#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
> +#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
> +#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
> +#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
> +
> +/* Hyper-V guest idle MSR */
> +#define HV_X64_MSR_GUEST_IDLE			0x400000F0
> +
> +/* Hyper-V guest crash notification MSR's */
> +#define HV_X64_MSR_CRASH_P0			0x40000100
> +#define HV_X64_MSR_CRASH_P1			0x40000101
> +#define HV_X64_MSR_CRASH_P2			0x40000102
> +#define HV_X64_MSR_CRASH_P3			0x40000103
> +#define HV_X64_MSR_CRASH_P4			0x40000104
> +#define HV_X64_MSR_CRASH_CTL			0x40000105
> +
> +/* NOTE: derived, not in hvgdk_mini.h */
> +#define HV_X64_MSR_CRASH_PARAMS		\
> +		(1 + (HV_X64_MSR_CRASH_P4 - HV_X64_MSR_CRASH_P0))
> +
> +#define HV_IPI_LOW_VECTOR	 0x10
> +#define HV_IPI_HIGH_VECTOR	 0xff
> +
> +struct hv_reenlightenment_control {
> +	u64 vector : 8;
> +	u64 reserved1 : 8;
> +	u64 enabled : 1;
> +	u64 reserved2 : 15;
> +	u64 target_vp : 32;
> +}  __packed;
> +
> +struct hv_tsc_emulation_status {	 /* HV_TSC_EMULATION_STATUS */
> +	u64 inprogress : 1;
> +	u64 reserved : 63;
> +} __packed;
> +
> +struct hv_tsc_emulation_control {	 /* HV_TSC_INVARIANT_CONTROL */
> +	u64 enabled : 1;
> +	u64 reserved : 63;
> +} __packed;
> +
> +/* TSC emulation after migration */
> +#define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
> +#define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
> +#define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
> +#define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
> +#define HV_EXPOSE_INVARIANT_TSC		BIT_ULL(0)
> +
> +#endif /* CONFIG_X86 */
> +
> +struct hv_get_partition_id {	 /* HV_OUTPUT_GET_PARTITION_ID */
> +	u64 partition_id;
> +} __packed;
> +
> +/* HV_CRASH_CTL_REG_CONTENTS */
> +#define HV_CRASH_CTL_CRASH_NOTIFY_MSG		 BIT_ULL(62)
> +#define HV_CRASH_CTL_CRASH_NOTIFY		 BIT_ULL(63)
> +
> +union hv_reference_tsc_msr {
> +	u64 as_uint64;
> +	struct {
> +		u64 enable : 1;
> +		u64 reserved : 11;
> +		u64 pfn : 52;
> +	} __packed;
> +};
> +
> +/* The maximum number of sparse vCPU banks which can be encoded by 'stru=
ct hv_vpset' */
> +#define HV_MAX_SPARSE_VCPU_BANKS (64)
> +/* The number of vCPUs in one sparse bank */
> +#define HV_VCPUS_PER_SPARSE_BANK (64)
> +
> +/* Some of Hyper-V structs do not use hv_vpset where linux uses them */
> +struct hv_vpset {	 /* HV_VP_SET */
> +	u64 format;
> +	u64 valid_bank_mask;
> +	u64 bank_contents[];
> +} __packed;
> +
> +/*
> + * Version info reported by hypervisor
> + * Changed to a union for convenience
> + */
> +union hv_hypervisor_version_info {
> +	struct {
> +		u32 build_number;
> +
> +		u32 minor_version : 16;
> +		u32 major_version : 16;
> +
> +		u32 service_pack;
> +
> +		u32 service_number : 24;
> +		u32 service_branch : 8;
> +	};
> +	struct {
> +		u32 eax;
> +		u32 ebx;
> +		u32 ecx;
> +		u32 edx;
> +	};
> +};
> +
> +/* HV_CPUID_FUNCTION */
> +#define HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS	0x40000000
> +#define HYPERV_CPUID_INTERFACE			0x40000001
> +#define HYPERV_CPUID_VERSION			0x40000002
> +#define HYPERV_CPUID_FEATURES			0x40000003
> +#define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
> +#define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
> +#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES	0x40000007
> +#define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
> +#define HYPERV_CPUID_ISOLATION_CONFIG		0x4000000C
> +
> +#define HYPERV_CPUID_VIRT_STACK_INTERFACE	 0x40000081
> +#define HYPERV_VS_INTERFACE_EAX_SIGNATURE	 0x31235356  /* "VS#1" */
> +
> +#define HYPERV_CPUID_VIRT_STACK_PROPERTIES	 0x40000082
> +/* Support for the extended IOAPIC RTE format */
> +#define HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE	 BIT(2)
> +
> +#define HYPERV_HYPERVISOR_PRESENT_BIT		 0x80000000
> +#define HYPERV_CPUID_MIN			 0x40000005
> +#define HYPERV_CPUID_MAX			 0x4000ffff
> +
> +/* HV_PARTITION_PRIVILEGE_MASK */
> +#define HV_MSR_VP_RUNTIME_AVAILABLE			BIT(0)
> +#define HV_MSR_TIME_REF_COUNT_AVAILABLE			BIT(1)
> +#define HV_MSR_SYNIC_AVAILABLE				BIT(2)
> +#define HV_MSR_SYNTIMER_AVAILABLE			BIT(3)
> +#define HV_MSR_APIC_ACCESS_AVAILABLE			BIT(4)
> +#define HV_MSR_HYPERCALL_AVAILABLE			BIT(5)
> +#define HV_MSR_VP_INDEX_AVAILABLE			BIT(6)
> +#define HV_MSR_RESET_AVAILABLE				BIT(7)
> +#define HV_MSR_STAT_PAGES_AVAILABLE			BIT(8)
> +#define HV_MSR_REFERENCE_TSC_AVAILABLE			BIT(9)
> +#define HV_MSR_GUEST_IDLE_AVAILABLE			BIT(10)
> +#define HV_ACCESS_FREQUENCY_MSRS			BIT(11)
> +#define HV_ACCESS_REENLIGHTENMENT			BIT(13)
> +#define HV_ACCESS_TSC_INVARIANT				BIT(15)
> +
> +/* HV_PARTITION_PRIVILEGE_MASK */
> +#define HV_CREATE_PARTITIONS				BIT(0)
> +#define HV_ACCESS_PARTITION_ID				BIT(1)
> +#define HV_ACCESS_MEMORY_POOL				BIT(2)
> +#define HV_ADJUST_MESSAGE_BUFFERS			BIT(3)
> +#define HV_POST_MESSAGES				BIT(4)
> +#define HV_SIGNAL_EVENTS				BIT(5)
> +#define HV_CREATE_PORT					BIT(6)
> +#define HV_CONNECT_PORT					BIT(7)
> +#define HV_ACCESS_STATS					BIT(8)
> +#define HV_DEBUGGING					BIT(11)
> +#define HV_CPU_MANAGEMENT				BIT(12)
> +#define HV_ENABLE_EXTENDED_HYPERCALLS			BIT(20)
> +#define HV_ISOLATION					BIT(22)
> +
> +#if defined(CONFIG_X86)
> +/* HV_X64_HYPERVISOR_FEATURES (EDX) */
> +#define HV_X64_MWAIT_AVAILABLE				BIT(0)
> +#define HV_X64_GUEST_DEBUGGING_AVAILABLE		BIT(1)
> +#define HV_X64_PERF_MONITOR_AVAILABLE			BIT(2)
> +#define HV_X64_CPU_DYNAMIC_PARTITIONING_AVAILABLE	BIT(3)
> +#define HV_X64_HYPERCALL_XMM_INPUT_AVAILABLE		BIT(4)
> +#define HV_X64_GUEST_IDLE_STATE_AVAILABLE		BIT(5)
> +#define HV_FEATURE_FREQUENCY_MSRS_AVAILABLE		BIT(8)
> +#define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE		BIT(10)
> +#define HV_FEATURE_DEBUG_MSRS_AVAILABLE			BIT(11)
> +/*
> + * Support for returning hypercall output block via XMM
> + * registers is available
> + */
> +#define HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE		BIT(15)
> +/* stimer Direct Mode is available */
> +#define HV_STIMER_DIRECT_MODE_AVAILABLE			BIT(19)
> +
> +/* HV_X64_ENLIGHTENMENT_INFORMATION */
> +#define HV_X64_AS_SWITCH_RECOMMENDED			BIT(0)
> +#define HV_X64_LOCAL_TLB_FLUSH_RECOMMENDED		BIT(1)
> +#define HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED		BIT(2)
> +#define HV_X64_APIC_ACCESS_RECOMMENDED			BIT(3)
> +#define HV_X64_SYSTEM_RESET_RECOMMENDED			BIT(4)
> +#define HV_X64_RELAXED_TIMING_RECOMMENDED		BIT(5)
> +#define HV_DEPRECATING_AEOI_RECOMMENDED			BIT(9)
> +#define HV_X64_CLUSTER_IPI_RECOMMENDED			BIT(10)
> +#define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED		BIT(11)
> +#define HV_X64_HYPERV_NESTED				BIT(12)
> +#define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
> +#define HV_X64_USE_MMIO_HYPERCALLS			BIT(21)
> +
> +/* HYPERV_CPUID_ISOLATION_CONFIG.EBX bits. */
> +#define HV_ISOLATION_TYPE				GENMASK(3, 0)
> +#define HV_SHARED_GPA_BOUNDARY_ACTIVE			BIT(5)
> +#define HV_SHARED_GPA_BOUNDARY_BITS			GENMASK(11, 6)
> +
> +/* HYPERV_CPUID_FEATURES.ECX bits. */
> +#define HV_VP_DISPATCH_INTERRUPT_INJECTION_AVAILABLE	BIT(9)
> +#define HV_VP_GHCB_ROOT_MAPPING_AVAILABLE		BIT(10)
> +
> +enum hv_isolation_type {
> +	HV_ISOLATION_TYPE_NONE	=3D 0,	/* HV_PARTITION_ISOLATION_TYPE_NONE */
> +	HV_ISOLATION_TYPE_VBS	=3D 1,
> +	HV_ISOLATION_TYPE_SNP	=3D 2,
> +	HV_ISOLATION_TYPE_TDX	=3D 3
> +};
> +
> +union hv_x64_msr_hypercall_contents {
> +	u64 as_uint64;
> +	struct {
> +		u64 enable : 1;
> +		u64 reserved : 11;
> +		u64 guest_physical_address : 52;
> +	} __packed;
> +};
> +#endif /* CONFIG_X86 */
> +
> +#if defined(CONFIG_ARM64)
> +#define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE	BIT(8)
> +#define HV_STIMER_DIRECT_MODE_AVAILABLE		BIT(13)
> +#endif /* CONFIG_ARM64 */
> +
> +#if defined(CONFIG_X86)
> +#define HV_MAXIMUM_PROCESSORS	    2048
> +#elif defined(CONFIG_ARM64) /* CONFIG_X86 */
> +#define HV_MAXIMUM_PROCESSORS	    320
> +#endif /* CONFIG_ARM64 */
> +
> +#define HV_MAX_VP_INDEX			(HV_MAXIMUM_PROCESSORS - 1)
> +#define HV_VP_INDEX_SELF		((u32)-2)
> +#define HV_ANY_VP			((u32)-1)
> +
> +union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
> +	u64 as_uint64;
> +	struct {
> +		u64 enable : 1;
> +		u64 reserved : 11;
> +		u64 pfn : 52;
> +	} __packed;
> +};
> +
> +/* Declare the various hypercall operations. */
> +/* HV_CALL_CODE */
> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE		0x0002
> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST		0x0003
> +#define HVCALL_NOTIFY_LONG_SPIN_WAIT			0x0008
> +#define HVCALL_SEND_IPI					0x000b
> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX		0x0013
> +#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX		0x0014
> +#define HVCALL_SEND_IPI_EX				0x0015
> +#define HVCALL_CREATE_PARTITION				0x0040
> +#define HVCALL_INITIALIZE_PARTITION			0x0041
> +#define HVCALL_FINALIZE_PARTITION			0x0042
> +#define HVCALL_DELETE_PARTITION				0x0043
> +#define HVCALL_GET_PARTITION_PROPERTY			0x0044
> +#define HVCALL_SET_PARTITION_PROPERTY			0x0045
> +#define HVCALL_GET_PARTITION_ID				0x0046
> +#define HVCALL_DEPOSIT_MEMORY				0x0048
> +#define HVCALL_WITHDRAW_MEMORY				0x0049
> +#define HVCALL_MAP_GPA_PAGES				0x004b
> +#define HVCALL_UNMAP_GPA_PAGES				0x004c
> +#define HVCALL_CREATE_VP				0x004e
> +#define HVCALL_DELETE_VP				0x004f
> +#define HVCALL_GET_VP_REGISTERS				0x0050
> +#define HVCALL_SET_VP_REGISTERS				0x0051
> +#define HVCALL_DELETE_PORT				0x0058
> +#define HVCALL_DISCONNECT_PORT				0x005b
> +#define HVCALL_POST_MESSAGE				0x005c
> +#define HVCALL_SIGNAL_EVENT				0x005d
> +#define HVCALL_POST_DEBUG_DATA				0x0069
> +#define HVCALL_RETRIEVE_DEBUG_DATA			0x006a
> +#define HVCALL_RESET_DEBUG_SESSION			0x006b
> +#define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
> +#define HVCALL_GET_SYSTEM_PROPERTY			0x007b
> +#define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
> +#define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
> +#define HVCALL_RETARGET_INTERRUPT			0x007e
> +#define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
> +#define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
> +#define HVCALL_CREATE_PORT				0x0095
> +#define HVCALL_CONNECT_PORT				0x0096
> +#define HVCALL_START_VP					0x0099
> +#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
> +#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
> +#define HVCALL_DISPATCH_VP				0x00c2
> +#define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
> +#define HVCALL_MAP_VP_STATE_PAGE			0x00e1
> +#define HVCALL_UNMAP_VP_STATE_PAGE			0x00e2
> +#define HVCALL_GET_VP_STATE				0x00e3
> +#define HVCALL_SET_VP_STATE				0x00e4
> +#define HVCALL_MMIO_READ				0x0106
> +#define HVCALL_MMIO_WRITE				0x0107
> +
> +/* HV_HYPERCALL_INPUT */
> +#define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
> +#define HV_HYPERCALL_FAST_BIT		BIT(16)
> +#define HV_HYPERCALL_VARHEAD_OFFSET	17
> +#define HV_HYPERCALL_NESTED		BIT(31)
> +#define HV_HYPERCALL_REP_COMP_OFFSET	32
> +#define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
> +#define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
> +#define HV_HYPERCALL_REP_START_OFFSET	48
> +#define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
> +
> +/* HvFlushGuestPhysicalAddressSpace hypercalls */
> +struct hv_guest_mapping_flush {
> +	u64 address_space;
> +	u64 flags;
> +} __packed;
> +
> +/*
> + *  HV_MAX_FLUSH_PAGES =3D "additional_pages" + 1. It's limited
> + *  by the bitwidth of "additional_pages" in union hv_gpa_page_range.
> + */
> +#define HV_MAX_FLUSH_PAGES (2048)
> +#define HV_GPA_PAGE_RANGE_PAGE_SIZE_2MB		0
> +#define HV_GPA_PAGE_RANGE_PAGE_SIZE_1GB		1
> +
> +#define HV_FLUSH_ALL_PROCESSORS			BIT(0)
> +#define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
> +#define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
> +#define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
> +
> +/* HvFlushGuestPhysicalAddressList, HvExtCallMemoryHeatHint hypercall */
> +union hv_gpa_page_range {
> +	u64 address_space;
> +	struct {
> +		u64 additional_pages : 11;
> +		u64 largepage : 1;
> +		u64 basepfn : 52;
> +	} page;
> +	struct {
> +		u64 reserved : 12;
> +		u64 page_size : 1;
> +		u64 reserved1 : 8;
> +		u64 base_large_pfn : 43;
> +	};
> +};
> +
> +/*
> + * All input flush parameters should be in single page. The max flush
> + * count is equal with how many entries of union hv_gpa_page_range can
> + * be populated into the input parameter page.
> + */
> +#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) / \
> +				sizeof(union hv_gpa_page_range))
> +
> +struct hv_guest_mapping_flush_list {
> +	u64 address_space;
> +	u64 flags;
> +	union hv_gpa_page_range gpa_list[HV_MAX_FLUSH_REP_COUNT];
> +};
> +
> +struct hv_tlb_flush {	 /* HV_INPUT_FLUSH_VIRTUAL_ADDRESS_LIST */
> +	u64 address_space;
> +	u64 flags;
> +	u64 processor_mask;
> +	u64 gva_list[];
> +} __packed;
> +
> +/* HvFlushVirtualAddressSpaceEx, HvFlushVirtualAddressListEx hypercalls =
*/
> +struct hv_tlb_flush_ex {
> +	u64 address_space;
> +	u64 flags;
> +	struct hv_vpset hv_vp_set;
> +	u64 gva_list[];
> +} __packed;
> +
> +struct ms_hyperv_tsc_page {	 /* HV_REFERENCE_TSC_PAGE */
> +	volatile u32 tsc_sequence;
> +	u32 reserved1;
> +	volatile u64 tsc_scale;
> +	volatile s64 tsc_offset;
> +} __packed;
> +
> +/* Define the number of synthetic interrupt sources. */
> +#define HV_SYNIC_SINT_COUNT (16)
> +
> +/* Hyper-V defined statically assigned SINTs */
> +#define HV_SYNIC_INTERCEPTION_SINT_INDEX 0x00000000
> +#define HV_SYNIC_IOMMU_FAULT_SINT_INDEX  0x00000001
> +#define HV_SYNIC_VMBUS_SINT_INDEX	 0x00000002
> +#define HV_SYNIC_FIRST_UNUSED_SINT_INDEX 0x00000005
> +
> +/* mshv assigned SINT for doorbell */
> +#define HV_SYNIC_DOORBELL_SINT_INDEX     HV_SYNIC_FIRST_UNUSED_SINT_INDE=
X
> +
> +enum hv_interrupt_type {
> +	HV_X64_INTERRUPT_TYPE_FIXED		=3D 0x0000,
> +	HV_X64_INTERRUPT_TYPE_LOWESTPRIORITY	=3D 0x0001,
> +	HV_X64_INTERRUPT_TYPE_SMI		=3D 0x0002,
> +	HV_X64_INTERRUPT_TYPE_REMOTEREAD	=3D 0x0003,
> +	HV_X64_INTERRUPT_TYPE_NMI		=3D 0x0004,
> +	HV_X64_INTERRUPT_TYPE_INIT		=3D 0x0005,
> +	HV_X64_INTERRUPT_TYPE_SIPI		=3D 0x0006,
> +	HV_X64_INTERRUPT_TYPE_EXTINT		=3D 0x0007,
> +	HV_X64_INTERRUPT_TYPE_LOCALINT0		=3D 0x0008,
> +	HV_X64_INTERRUPT_TYPE_LOCALINT1		=3D 0x0009,
> +	HV_X64_INTERRUPT_TYPE_MAXIMUM		=3D 0x000A,
> +};
> +
> +/* Define synthetic interrupt source. */
> +union hv_synic_sint {
> +	u64 as_uint64;
> +	struct {
> +		u64 vector : 8;
> +		u64 reserved1 : 8;
> +		u64 masked : 1;
> +		u64 auto_eoi : 1;
> +		u64 polling : 1;
> +		u64 as_intercept : 1;
> +		u64 proxy : 1;
> +		u64 reserved2 : 43;
> +	} __packed;
> +};
> +
> +union hv_x64_xsave_xfem_register {
> +	u64 as_uint64;
> +	struct {
> +		u32 low_uint32;
> +		u32 high_uint32;
> +	} __packed;
> +	struct {
> +		u64 legacy_x87 : 1;
> +		u64 legacy_sse : 1;
> +		u64 avx : 1;
> +		u64 mpx_bndreg : 1;
> +		u64 mpx_bndcsr : 1;
> +		u64 avx_512_op_mask : 1;
> +		u64 avx_512_zmmhi : 1;
> +		u64 avx_512_zmm16_31 : 1;
> +		u64 rsvd8_9 : 2;
> +		u64 pasid : 1;
> +		u64 cet_u : 1;
> +		u64 cet_s : 1;
> +		u64 rsvd13_16 : 4;
> +		u64 xtile_cfg : 1;
> +		u64 xtile_data : 1;
> +		u64 rsvd19_63 : 45;
> +	} __packed;
> +};
> +
> +/* Synthetic timer configuration */
> +union hv_stimer_config {	 /* HV_X64_MSR_STIMER_CONFIG_CONTENTS */
> +	u64 as_uint64;
> +	struct {
> +		u64 enable : 1;
> +		u64 periodic : 1;
> +		u64 lazy : 1;
> +		u64 auto_enable : 1;
> +		u64 apic_vector : 8;
> +		u64 direct_mode : 1;
> +		u64 reserved_z0 : 3;
> +		u64 sintx : 4;
> +		u64 reserved_z1 : 44;
> +	} __packed;
> +};
> +
> +/* Define the number of synthetic timers */
> +#define HV_SYNIC_STIMER_COUNT	(4)
> +
> +/* Define port identifier type. */
> +union hv_port_id {
> +	u32 asu32;
> +	struct {
> +		u32 id : 24;
> +		u32 reserved : 8;
> +	} __packed u;
> +};
> +
> +#define HV_MESSAGE_SIZE			(256)
> +#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
> +#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
> +
> +/* Define hypervisor message types. */
> +enum hv_message_type {
> +	HVMSG_NONE				=3D 0x00000000,
> +
> +	/* Memory access messages. */
> +	HVMSG_UNMAPPED_GPA			=3D 0x80000000,
> +	HVMSG_GPA_INTERCEPT			=3D 0x80000001,
> +
> +	/* Timer notification messages. */
> +	HVMSG_TIMER_EXPIRED			=3D 0x80000010,
> +
> +	/* Error messages. */
> +	HVMSG_INVALID_VP_REGISTER_VALUE		=3D 0x80000020,
> +	HVMSG_UNRECOVERABLE_EXCEPTION		=3D 0x80000021,
> +	HVMSG_UNSUPPORTED_FEATURE		=3D 0x80000022,
> +
> +	/*
> +	 * Opaque intercept message. The original intercept message is only
> +	 * accessible from the mapped intercept message page.
> +	 */
> +	HVMSG_OPAQUE_INTERCEPT			=3D 0x8000003F,
> +
> +	/* Trace buffer complete messages. */
> +	HVMSG_EVENTLOG_BUFFERCOMPLETE		=3D 0x80000040,
> +
> +	/* Hypercall intercept */
> +	HVMSG_HYPERCALL_INTERCEPT		=3D 0x80000050,
> +
> +	/* SynIC intercepts */
> +	HVMSG_SYNIC_EVENT_INTERCEPT		=3D 0x80000060,
> +	HVMSG_SYNIC_SINT_INTERCEPT		=3D 0x80000061,
> +	HVMSG_SYNIC_SINT_DELIVERABLE	=3D 0x80000062,
> +
> +	/* Async call completion intercept */
> +	HVMSG_ASYNC_CALL_COMPLETION		=3D 0x80000070,
> +
> +	/* Root scheduler messages */
> +	HVMSG_SCHEDULER_VP_SIGNAL_BITSET	=3D 0x80000100,
> +	HVMSG_SCHEDULER_VP_SIGNAL_PAIR		=3D 0x80000101,
> +
> +	/* Platform-specific processor intercept messages. */
> +	HVMSG_X64_IO_PORT_INTERCEPT		=3D 0x80010000,
> +	HVMSG_X64_MSR_INTERCEPT			=3D 0x80010001,
> +	HVMSG_X64_CPUID_INTERCEPT		=3D 0x80010002,
> +	HVMSG_X64_EXCEPTION_INTERCEPT		=3D 0x80010003,
> +	HVMSG_X64_APIC_EOI			=3D 0x80010004,
> +	HVMSG_X64_LEGACY_FP_ERROR		=3D 0x80010005,
> +	HVMSG_X64_IOMMU_PRQ			=3D 0x80010006,
> +	HVMSG_X64_HALT				=3D 0x80010007,
> +	HVMSG_X64_INTERRUPTION_DELIVERABLE	=3D 0x80010008,
> +	HVMSG_X64_SIPI_INTERCEPT		=3D 0x80010009,
> +};
> +
> +/* Define the format of the SIMP register */
> +union hv_synic_simp {
> +	u64 as_uint64;
> +	struct {
> +		u64 simp_enabled : 1;
> +		u64 preserved : 11;
> +		u64 base_simp_gpa : 52;
> +	} __packed;
> +};
> +
> +union hv_message_flags {
> +	u8 asu8;
> +	struct {
> +		u8 msg_pending : 1;
> +		u8 reserved : 7;
> +	} __packed;
> +};
> +
> +struct hv_message_header {
> +	u32 message_type;
> +	u8 payload_size;
> +	union hv_message_flags message_flags;
> +	u8 reserved[2];
> +	union {
> +		u64 sender;
> +		union hv_port_id port;
> +	};
> +} __packed;
> +
> +/*
> + * Message format for notifications delivered via
> + * intercept message(as_intercept=3D1)
> + */
> +struct hv_notification_message_payload {
> +	u32 sint_index;
> +} __packed;
> +
> +struct hv_message {
> +	struct hv_message_header header;
> +	union {
> +		u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
> +	} u;
> +} __packed;
> +
> +/* Define the synthetic interrupt message page layout. */
> +struct hv_message_page {
> +	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
> +} __packed;
> +
> +struct hv_x64_segment_register {
> +	u64 base;
> +	u32 limit;
> +	u16 selector;
> +	union {
> +		struct {
> +			u16 segment_type : 4;
> +			u16 non_system_segment : 1;
> +			u16 descriptor_privilege_level : 2;
> +			u16 present : 1;
> +			u16 reserved : 4;
> +			u16 available : 1;
> +			u16 _long : 1;
> +			u16 _default : 1;
> +			u16 granularity : 1;
> +		} __packed;
> +		u16 attributes;
> +	};
> +} __packed;
> +
> +struct hv_x64_table_register {
> +	u16 pad[3];
> +	u16 limit;
> +	u64 base;
> +} __packed;
> +
> +union hv_input_vtl {
> +	u8 as_uint8;
> +	struct {
> +		u8 target_vtl : 4;
> +		u8 use_target_vtl : 1;
> +		u8 reserved_z : 3;
> +	};
> +} __packed;
> +
> +struct hv_init_vp_context {
> +	u64 rip;
> +	u64 rsp;
> +	u64 rflags;
> +
> +	struct hv_x64_segment_register cs;
> +	struct hv_x64_segment_register ds;
> +	struct hv_x64_segment_register es;
> +	struct hv_x64_segment_register fs;
> +	struct hv_x64_segment_register gs;
> +	struct hv_x64_segment_register ss;
> +	struct hv_x64_segment_register tr;
> +	struct hv_x64_segment_register ldtr;
> +
> +	struct hv_x64_table_register idtr;
> +	struct hv_x64_table_register gdtr;
> +
> +	u64 efer;
> +	u64 cr0;
> +	u64 cr3;
> +	u64 cr4;
> +	u64 msr_cr_pat;
> +} __packed;
> +
> +struct hv_enable_vp_vtl {
> +	u64				partition_id;
> +	u32				vp_index;
> +	union hv_input_vtl		target_vtl;
> +	u8				mbz0;
> +	u16				mbz1;
> +	struct hv_init_vp_context	vp_context;
> +} __packed;
> +
> +struct hv_nested_enlightenments_control {
> +	struct {
> +		u32 directhypercall : 1;
> +		u32 reserved : 31;
> +	} __packed features;
> +	struct {
> +		u32 inter_partition_comm : 1;
> +		u32 reserved : 31;
> +	} __packed hypercall_controls;
> +} __packed;
> +
> +/* Define virtual processor assist page structure. */
> +struct hv_vp_assist_page {
> +	u32 apic_assist;
> +	u32 reserved1;
> +	u32 vtl_entry_reason;
> +	u32 vtl_reserved;
> +	u64 vtl_ret_x64rax;
> +	u64 vtl_ret_x64rcx;
> +	struct hv_nested_enlightenments_control nested_control;
> +	u8 enlighten_vmentry;
> +	u8 reserved2[7];
> +	u64 current_nested_vmcs;
> +	u8 synthetic_time_unhalted_timer_expired;
> +	u8 reserved3[7];
> +	u8 virtualization_fault_information[40];
> +	u8 reserved4[8];
> +	u8 intercept_message[256];
> +	u8 vtl_ret_actions[256];
> +} __packed;
> +
> +enum hv_register_name {
> +	/* Suspend Registers */
> +	HV_REGISTER_EXPLICIT_SUSPEND				=3D 0x00000000,
> +	HV_REGISTER_INTERCEPT_SUSPEND				=3D 0x00000001,
> +	HV_REGISTER_DISPATCH_SUSPEND				=3D 0x00000003,
> +
> +	/* Version - 128-bit result same as CPUID 0x40000002 */
> +	HV_REGISTER_HYPERVISOR_VERSION				=3D 0x00000100,
> +
> +	/* Feature Access (registers are 128 bits) - same as CPUID 0x40000003 -
> 0x4000000B */
> +	HV_REGISTER_PRIVILEGES_AND_FEATURES_INFO		=3D 0x00000200,
> +	HV_REGISTER_FEATURES_INFO				=3D 0x00000201,
> +	HV_REGISTER_IMPLEMENTATION_LIMITS_INFO			=3D
> 0x00000202,
> +	HV_REGISTER_HARDWARE_FEATURES_INFO			=3D 0x00000203,
> +	HV_REGISTER_CPU_MANAGEMENT_FEATURES_INFO		=3D 0x00000204,
> +	HV_REGISTER_SVM_FEATURES_INFO				=3D 0x00000205,
> +	HV_REGISTER_SKIP_LEVEL_FEATURES_INFO			=3D 0x00000206,
> +	HV_REGISTER_NESTED_VIRT_FEATURES_INFO			=3D 0x00000207,
> +	HV_REGISTER_IPT_FEATURES_INFO				=3D 0x00000208,
> +
> +	/* Guest Crash Registers */
> +	HV_REGISTER_GUEST_CRASH_P0				=3D 0x00000210,
> +	HV_REGISTER_GUEST_CRASH_P1				=3D 0x00000211,
> +	HV_REGISTER_GUEST_CRASH_P2				=3D 0x00000212,
> +	HV_REGISTER_GUEST_CRASH_P3				=3D 0x00000213,
> +	HV_REGISTER_GUEST_CRASH_P4				=3D 0x00000214,
> +	HV_REGISTER_GUEST_CRASH_CTL				=3D 0x00000215,
> +
> +	/* Misc */
> +	HV_REGISTER_VP_RUNTIME					=3D 0x00090000,
> +	HV_REGISTER_GUEST_OS_ID					=3D 0x00090002,
> +	HV_REGISTER_VP_INDEX					=3D 0x00090003,
> +	HV_REGISTER_TIME_REF_COUNT				=3D 0x00090004,
> +	HV_REGISTER_CPU_MANAGEMENT_VERSION			=3D 0x00090007,
> +	HV_REGISTER_VP_ASSIST_PAGE				=3D 0x00090013,
> +	HV_REGISTER_VP_ROOT_SIGNAL_COUNT			=3D 0x00090014,
> +	HV_REGISTER_REFERENCE_TSC				=3D 0x00090017,
> +
> +	/* Hypervisor-defined Registers (Synic) */
> +	HV_REGISTER_SINT0					=3D 0x000A0000,
> +	HV_REGISTER_SINT1					=3D 0x000A0001,
> +	HV_REGISTER_SINT2					=3D 0x000A0002,
> +	HV_REGISTER_SINT3					=3D 0x000A0003,
> +	HV_REGISTER_SINT4					=3D 0x000A0004,
> +	HV_REGISTER_SINT5					=3D 0x000A0005,
> +	HV_REGISTER_SINT6					=3D 0x000A0006,
> +	HV_REGISTER_SINT7					=3D 0x000A0007,
> +	HV_REGISTER_SINT8					=3D 0x000A0008,
> +	HV_REGISTER_SINT9					=3D 0x000A0009,
> +	HV_REGISTER_SINT10					=3D 0x000A000A,
> +	HV_REGISTER_SINT11					=3D 0x000A000B,
> +	HV_REGISTER_SINT12					=3D 0x000A000C,
> +	HV_REGISTER_SINT13					=3D 0x000A000D,
> +	HV_REGISTER_SINT14					=3D 0x000A000E,
> +	HV_REGISTER_SINT15					=3D 0x000A000F,
> +	HV_REGISTER_SCONTROL					=3D 0x000A0010,
> +	HV_REGISTER_SVERSION					=3D 0x000A0011,
> +	HV_REGISTER_SIEFP					=3D 0x000A0012,
> +	HV_REGISTER_SIMP					=3D 0x000A0013,
> +	HV_REGISTER_EOM						=3D 0x000A0014,
> +	HV_REGISTER_SIRBP					=3D 0x000A0015,
> +
> +	HV_REGISTER_NESTED_SINT0				=3D 0x000A1000,
> +	HV_REGISTER_NESTED_SINT1				=3D 0x000A1001,
> +	HV_REGISTER_NESTED_SINT2				=3D 0x000A1002,
> +	HV_REGISTER_NESTED_SINT3				=3D 0x000A1003,
> +	HV_REGISTER_NESTED_SINT4				=3D 0x000A1004,
> +	HV_REGISTER_NESTED_SINT5				=3D 0x000A1005,
> +	HV_REGISTER_NESTED_SINT6				=3D 0x000A1006,
> +	HV_REGISTER_NESTED_SINT7				=3D 0x000A1007,
> +	HV_REGISTER_NESTED_SINT8				=3D 0x000A1008,
> +	HV_REGISTER_NESTED_SINT9				=3D 0x000A1009,
> +	HV_REGISTER_NESTED_SINT10				=3D 0x000A100A,
> +	HV_REGISTER_NESTED_SINT11				=3D 0x000A100B,
> +	HV_REGISTER_NESTED_SINT12				=3D 0x000A100C,
> +	HV_REGISTER_NESTED_SINT13				=3D 0x000A100D,
> +	HV_REGISTER_NESTED_SINT14				=3D 0x000A100E,
> +	HV_REGISTER_NESTED_SINT15				=3D 0x000A100F,
> +	HV_REGISTER_NESTED_SCONTROL				=3D 0x000A1010,
> +	HV_REGISTER_NESTED_SVERSION				=3D 0x000A1011,
> +	HV_REGISTER_NESTED_SIFP					=3D 0x000A1012,
> +	HV_REGISTER_NESTED_SIPP					=3D 0x000A1013,
> +	HV_REGISTER_NESTED_EOM					=3D 0x000A1014,
> +	HV_REGISTER_NESTED_SIRBP				=3D 0x000a1015,
> +
> +	/* Hypervisor-defined Registers (Synthetic Timers) */
> +	HV_REGISTER_STIMER0_CONFIG				=3D 0x000B0000,
> +	HV_REGISTER_STIMER0_COUNT				=3D 0x000B0001,
> +
> +	/* VSM */
> +	HV_X64_REGISTER_VSM_VP_STATUS				=3D 0x000D0003,
> +};
> +
> +/*
> + * Arch compatibility regs for use with hv_set/get_register
> + */
> +#if defined(CONFIG_X86)
> +
> +/*
> + * To support arch-generic code calling hv_set/get_register:
> + * - On x86, HV_MSR_ indicates an MSR accessed via rdmsrl/wrmsrl
> + * - On ARM, HV_MSR_ indicates a VP register accessed via hypercall
> + */
> +#define HV_MSR_CRASH_P0		(HV_X64_MSR_CRASH_P0)
> +#define HV_MSR_CRASH_P1		(HV_X64_MSR_CRASH_P1)
> +#define HV_MSR_CRASH_P2		(HV_X64_MSR_CRASH_P2)
> +#define HV_MSR_CRASH_P3		(HV_X64_MSR_CRASH_P3)
> +#define HV_MSR_CRASH_P4		(HV_X64_MSR_CRASH_P4)
> +#define HV_MSR_CRASH_CTL	(HV_X64_MSR_CRASH_CTL)
> +
> +#define HV_MSR_VP_INDEX		(HV_X64_MSR_VP_INDEX)
> +#define HV_MSR_TIME_REF_COUNT	(HV_X64_MSR_TIME_REF_COUNT)
> +#define HV_MSR_REFERENCE_TSC	(HV_X64_MSR_REFERENCE_TSC)
> +
> +#define HV_MSR_SINT0		(HV_X64_MSR_SINT0)
> +#define HV_MSR_SVERSION		(HV_X64_MSR_SVERSION)
> +#define HV_MSR_SCONTROL		(HV_X64_MSR_SCONTROL)
> +#define HV_MSR_SIEFP		(HV_X64_MSR_SIEFP)
> +#define HV_MSR_SIMP		(HV_X64_MSR_SIMP)
> +#define HV_MSR_EOM		(HV_X64_MSR_EOM)
> +#define HV_MSR_SIRBP		(HV_X64_MSR_SIRBP)
> +
> +#define HV_MSR_NESTED_SCONTROL	(HV_X64_MSR_NESTED_SCONTROL)
> +#define HV_MSR_NESTED_SVERSION	(HV_X64_MSR_NESTED_SVERSION)
> +#define HV_MSR_NESTED_SIEFP	(HV_X64_MSR_NESTED_SIEFP)
> +#define HV_MSR_NESTED_SIMP	(HV_X64_MSR_NESTED_SIMP)
> +#define HV_MSR_NESTED_EOM	(HV_X64_MSR_NESTED_EOM)
> +#define HV_MSR_NESTED_SINT0	(HV_X64_MSR_NESTED_SINT0)
> +
> +#define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
> +#define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
> +
> +#elif defined(CONFIG_ARM64) /* CONFIG_X86 */
> +
> +#define HV_MSR_CRASH_P0		(HV_REGISTER_GUEST_CRASH_P0)
> +#define HV_MSR_CRASH_P1		(HV_REGISTER_GUEST_CRASH_P1)
> +#define HV_MSR_CRASH_P2		(HV_REGISTER_GUEST_CRASH_P2)
> +#define HV_MSR_CRASH_P3		(HV_REGISTER_GUEST_CRASH_P3)
> +#define HV_MSR_CRASH_P4		(HV_REGISTER_GUEST_CRASH_P4)
> +#define HV_MSR_CRASH_CTL	(HV_REGISTER_GUEST_CRASH_CTL)
> +
> +#define HV_MSR_VP_INDEX		(HV_REGISTER_VP_INDEX)
> +#define HV_MSR_TIME_REF_COUNT	(HV_REGISTER_TIME_REF_COUNT)
> +#define HV_MSR_REFERENCE_TSC	(HV_REGISTER_REFERENCE_TSC)
> +
> +#define HV_MSR_SINT0		(HV_REGISTER_SINT0)
> +#define HV_MSR_SCONTROL		(HV_REGISTER_SCONTROL)
> +#define HV_MSR_SIEFP		(HV_REGISTER_SIEFP)
> +#define HV_MSR_SIMP		(HV_REGISTER_SIMP)
> +#define HV_MSR_EOM		(HV_REGISTER_EOM)
> +#define HV_MSR_SIRBP		(HV_REGISTER_SIRBP)
> +
> +#define HV_MSR_STIMER0_CONFIG	(HV_REGISTER_STIMER0_CONFIG)
> +#define HV_MSR_STIMER0_COUNT	(HV_REGISTER_STIMER0_COUNT)
> +
> +#endif /* CONFIG_ARM64 */
> +
> +union hv_explicit_suspend_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 suspended : 1;
> +		u64 reserved : 63;
> +	} __packed;
> +};
> +
> +union hv_intercept_suspend_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 suspended : 1;
> +		u64 reserved : 63;
> +	} __packed;
> +};
> +
> +union hv_dispatch_suspend_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 suspended : 1;
> +		u64 reserved : 63;
> +	} __packed;
> +};
> +
> +union hv_x64_interrupt_state_register {
> +	u64 as_uint64;
> +	struct {
> +		u64 interrupt_shadow : 1;
> +		u64 nmi_masked : 1;
> +		u64 reserved : 62;
> +	} __packed;
> +};
> +
> +union hv_x64_pending_interruption_register {
> +	u64 as_uint64;
> +	struct {
> +		u32 interruption_pending : 1;
> +		u32 interruption_type : 3;
> +		u32 deliver_error_code : 1;
> +		u32 instruction_length : 4;
> +		u32 nested_event : 1;
> +		u32 reserved : 6;
> +		u32 interruption_vector : 16;
> +		u32 error_code;
> +	} __packed;
> +};
> +
> +union hv_register_value {
> +	struct hv_u128 reg128;
> +	u64 reg64;
> +	u32 reg32;
> +	u16 reg16;
> +	u8 reg8;
> +
> +	struct hv_x64_segment_register segment;
> +	struct hv_x64_table_register table;
> +	union hv_explicit_suspend_register explicit_suspend;
> +	union hv_intercept_suspend_register intercept_suspend;
> +	union hv_dispatch_suspend_register dispatch_suspend;
> +	union hv_x64_interrupt_state_register interrupt_state;
> +	union hv_x64_pending_interruption_register pending_interruption;
> +};
> +
> +#if defined(CONFIG_ARM64)
> +/* HvGetVpRegisters returns an array of these output elements */
> +struct hv_get_vp_registers_output {
> +	union {
> +		struct {
> +			u32 a;
> +			u32 b;
> +			u32 c;
> +			u32 d;
> +		} as32 __packed;
> +		struct {
> +			u64 low;
> +			u64 high;
> +		} as64 __packed;
> +	};
> +};
> +
> +#endif /* CONFIG_ARM64 */
> +
> +struct hv_register_assoc {
> +	u32 name;			/* enum hv_register_name */
> +	u32 reserved1;
> +	u64 reserved2;
> +	union hv_register_value value;
> +} __packed;
> +
> +struct hv_input_get_vp_registers {
> +	u64 partition_id;
> +	u32 vp_index;
> +	union hv_input_vtl input_vtl;
> +	u8  rsvd_z8;
> +	u16 rsvd_z16;
> +	u32 names[];
> +} __packed;
> +
> +struct hv_input_set_vp_registers {
> +	u64 partition_id;
> +	u32 vp_index;
> +	union hv_input_vtl input_vtl;
> +	u8  rsvd_z8;
> +	u16 rsvd_z16;
> +	struct hv_register_assoc elements[];
> +} __packed;
> +
> +#define HV_UNMAP_GPA_LARGE_PAGE		0x2
> +
> +/* HvCallSendSyntheticClusterIpi hypercall */
> +struct hv_send_ipi {	 /* HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI */
> +	u32 vector;
> +	u32 reserved;
> +	u64 cpu_mask;
> +} __packed;
> +
> +#define	HV_X64_VTL_MASK			GENMASK(3, 0)
> +
> +/* Hyper-V memory host visibility */
> +enum hv_mem_host_visibility {
> +	VMBUS_PAGE_NOT_VISIBLE		=3D 0,
> +	VMBUS_PAGE_VISIBLE_READ_ONLY	=3D 1,
> +	VMBUS_PAGE_VISIBLE_READ_WRITE	=3D 3
> +};
> +
> +/* HvCallModifySparseGpaPageHostVisibility hypercall */
> +#define HV_MAX_MODIFY_GPA_REP_COUNT	((PAGE_SIZE / sizeof(u64)) - 2)
> +struct hv_gpa_range_for_visibility {
> +	u64 partition_id;
> +	u32 host_visibility : 2;
> +	u32 reserved0 : 30;
> +	u32 reserved1;
> +	u64 gpa_page_list[HV_MAX_MODIFY_GPA_REP_COUNT];
> +} __packed;
> +
> +#if defined(CONFIG_X86)
> +union hv_msi_address_register { /* HV_MSI_ADDRESS */
> +	u32 as_uint32;
> +	struct {
> +		u32 reserved1 : 2;
> +		u32 destination_mode : 1;
> +		u32 redirection_hint : 1;
> +		u32 reserved2 : 8;
> +		u32 destination_id : 8;
> +		u32 msi_base : 12;
> +	};
> +} __packed;
> +
> +union hv_msi_data_register {	 /* HV_MSI_ENTRY.Data */
> +	u32 as_uint32;
> +	struct {
> +		u32 vector : 8;
> +		u32 delivery_mode : 3;
> +		u32 reserved1 : 3;
> +		u32 level_assert : 1;
> +		u32 trigger_mode : 1;
> +		u32 reserved2 : 16;
> +	};
> +} __packed;
> +
> +union hv_msi_entry {	 /* HV_MSI_ENTRY */
> +
> +	u64 as_uint64;
> +	struct {
> +		union hv_msi_address_register address;
> +		union hv_msi_data_register data;
> +	} __packed;
> +};
> +
> +#elif defined(CONFIG_ARM64) /* CONFIG_X86 */
> +
> +union hv_msi_entry {
> +	u64 as_uint64[2];
> +	struct {
> +		u64 address;
> +		u32 data;
> +		u32 reserved;
> +	} __packed;
> +};
> +#endif /* CONFIG_ARM64 */
> +
> +union hv_ioapic_rte {
> +	u64 as_uint64;
> +
> +	struct {
> +		u32 vector : 8;
> +		u32 delivery_mode : 3;
> +		u32 destination_mode : 1;
> +		u32 delivery_status : 1;
> +		u32 interrupt_polarity : 1;
> +		u32 remote_irr : 1;
> +		u32 trigger_mode : 1;
> +		u32 interrupt_mask : 1;
> +		u32 reserved1 : 15;
> +
> +		u32 reserved2 : 24;
> +		u32 destination_id : 8;
> +	};
> +
> +	struct {
> +		u32 low_uint32;
> +		u32 high_uint32;
> +	};
> +} __packed;
> +
> +enum hv_interrupt_source {	 /* HV_INTERRUPT_SOURCE */
> +	HV_INTERRUPT_SOURCE_MSI =3D 1, /* MSI and MSI-X */
> +	HV_INTERRUPT_SOURCE_IOAPIC,
> +};
> +
> +struct hv_interrupt_entry {	 /* HV_INTERRUPT_ENTRY */
> +	u32 source;
> +	u32 reserved1;
> +	union {
> +		union hv_msi_entry msi_entry;
> +		union hv_ioapic_rte ioapic_rte;
> +	};
> +} __packed;
> +
> +#define HV_DEVICE_INTERRUPT_TARGET_MULTICAST		1
> +#define HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET	2
> +
> +struct hv_device_interrupt_target {	 /* HV_DEVICE_INTERRUPT_TARGET */
> +	u32 vector;
> +	u32 flags;		/* HV_DEVICE_INTERRUPT_TARGET_* above */
> +	union {
> +		u64 vp_mask;
> +		struct hv_vpset vp_set;
> +	};
> +} __packed;
> +
> +struct hv_retarget_device_interrupt {	 /* HV_INPUT_RETARGET_DEVICE_INTER=
RUPT
> */
> +	u64 partition_id;		/* use "self" */
> +	u64 device_id;
> +	struct hv_interrupt_entry int_entry;
> +	u64 reserved2;
> +	struct hv_device_interrupt_target int_target;
> +} __packed __aligned(8);
> +
> +/* Data structures for HVCALL_MMIO_READ and HVCALL_MMIO_WRITE */
> +#define HV_HYPERCALL_MMIO_MAX_DATA_LENGTH 64
> +
> +struct hv_mmio_read_input { /* HV_INPUT_MEMORY_MAPPED_IO_READ */
> +	u64 gpa;
> +	u32 size;
> +	u32 reserved;
> +} __packed;
> +
> +struct hv_mmio_read_output {
> +	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
> +} __packed;
> +
> +struct hv_mmio_write_input {
> +	u64 gpa;
> +	u32 size;
> +	u32 reserved;
> +	u8 data[HV_HYPERCALL_MMIO_MAX_DATA_LENGTH];
> +} __packed;
> +
> +#endif /* _HV_HVGDK_MINI_H */
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> new file mode 100644
> index 000000000000..64407c2a3809
> --- /dev/null
> +++ b/include/hyperv/hvhdk.h
> @@ -0,0 +1,733 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Type definitions for the Microsoft hypervisor.
> + */
> +#ifndef _HV_HVHDK_H
> +#define _HV_HVHDK_H
> +
> +#include <linux/build_bug.h>
> +
> +#include "hvhdk_mini.h"
> +#include "hvgdk.h"
> +
> +/* Bits for dirty mask of hv_vp_register_page */
> +#define HV_X64_REGISTER_CLASS_GENERAL	0
> +#define HV_X64_REGISTER_CLASS_IP	1
> +#define HV_X64_REGISTER_CLASS_XMM	2
> +#define HV_X64_REGISTER_CLASS_SEGMENT	3
> +#define HV_X64_REGISTER_CLASS_FLAGS	4
> +
> +#define HV_VP_REGISTER_PAGE_VERSION_1	1u
> +
> +struct hv_vp_register_page {
> +	u16 version;
> +	u8 isvalid;
> +	u8 rsvdz;
> +	u32 dirty;
> +	union {
> +		struct {
> +			/* General purpose registers
> +			 * (HV_X64_REGISTER_CLASS_GENERAL)
> +			 */
> +			union {
> +				struct {
> +					u64 rax;
> +					u64 rcx;
> +					u64 rdx;
> +					u64 rbx;
> +					u64 rsp;
> +					u64 rbp;
> +					u64 rsi;
> +					u64 rdi;
> +					u64 r8;
> +					u64 r9;
> +					u64 r10;
> +					u64 r11;
> +					u64 r12;
> +					u64 r13;
> +					u64 r14;
> +					u64 r15;
> +				} __packed;
> +
> +				u64 gp_registers[16];
> +			};
> +			/* Instruction pointer (HV_X64_REGISTER_CLASS_IP) */
> +			u64 rip;
> +			/* Flags (HV_X64_REGISTER_CLASS_FLAGS) */
> +			u64 rflags;
> +		} __packed;
> +
> +		u64 registers[18];
> +	};
> +	/* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
> +	union {
> +		struct {
> +			struct hv_u128 xmm0;
> +			struct hv_u128 xmm1;
> +			struct hv_u128 xmm2;
> +			struct hv_u128 xmm3;
> +			struct hv_u128 xmm4;
> +			struct hv_u128 xmm5;
> +		} __packed;
> +
> +		struct hv_u128 xmm_registers[6];
> +	};
> +	/* Segment registers (HV_X64_REGISTER_CLASS_SEGMENT) */
> +	union {
> +		struct {
> +			struct hv_x64_segment_register es;
> +			struct hv_x64_segment_register cs;
> +			struct hv_x64_segment_register ss;
> +			struct hv_x64_segment_register ds;
> +			struct hv_x64_segment_register fs;
> +			struct hv_x64_segment_register gs;
> +		} __packed;
> +
> +		struct hv_x64_segment_register segment_registers[6];
> +	};
> +	/* Misc. control registers (cannot be set via this interface) */
> +	u64 cr0;
> +	u64 cr3;
> +	u64 cr4;
> +	u64 cr8;
> +	u64 efer;
> +	u64 dr7;
> +	union hv_x64_pending_interruption_register pending_interruption;
> +	union hv_x64_interrupt_state_register interrupt_state;
> +	u64 instruction_emulation_hints;
> +} __packed;
> +
> +#define HV_PARTITION_PROCESSOR_FEATURES_BANKS 2
> +
> +union hv_partition_processor_features {
> +	u64 as_uint64[HV_PARTITION_PROCESSOR_FEATURES_BANKS];
> +	struct {
> +		u64 sse3_support : 1;
> +		u64 lahf_sahf_support : 1;
> +		u64 ssse3_support : 1;
> +		u64 sse4_1_support : 1;
> +		u64 sse4_2_support : 1;
> +		u64 sse4a_support : 1;
> +		u64 xop_support : 1;
> +		u64 pop_cnt_support : 1;
> +		u64 cmpxchg16b_support : 1;
> +		u64 altmovcr8_support : 1;
> +		u64 lzcnt_support : 1;
> +		u64 mis_align_sse_support : 1;
> +		u64 mmx_ext_support : 1;
> +		u64 amd3dnow_support : 1;
> +		u64 extended_amd3dnow_support : 1;
> +		u64 page_1gb_support : 1;
> +		u64 aes_support : 1;
> +		u64 pclmulqdq_support : 1;
> +		u64 pcid_support : 1;
> +		u64 fma4_support : 1;
> +		u64 f16c_support : 1;
> +		u64 rd_rand_support : 1;
> +		u64 rd_wr_fs_gs_support : 1;
> +		u64 smep_support : 1;
> +		u64 enhanced_fast_string_support : 1;
> +		u64 bmi1_support : 1;
> +		u64 bmi2_support : 1;
> +		u64 hle_support_deprecated : 1;
> +		u64 rtm_support_deprecated : 1;
> +		u64 movbe_support : 1;
> +		u64 npiep1_support : 1;
> +		u64 dep_x87_fpu_save_support : 1;
> +		u64 rd_seed_support : 1;
> +		u64 adx_support : 1;
> +		u64 intel_prefetch_support : 1;
> +		u64 smap_support : 1;
> +		u64 hle_support : 1;
> +		u64 rtm_support : 1;
> +		u64 rdtscp_support : 1;
> +		u64 clflushopt_support : 1;
> +		u64 clwb_support : 1;
> +		u64 sha_support : 1;
> +		u64 x87_pointers_saved_support : 1;
> +		u64 invpcid_support : 1;
> +		u64 ibrs_support : 1;
> +		u64 stibp_support : 1;
> +		u64 ibpb_support: 1;
> +		u64 unrestricted_guest_support : 1;
> +		u64 mdd_support : 1;
> +		u64 fast_short_rep_mov_support : 1;
> +		u64 l1dcache_flush_support : 1;
> +		u64 rdcl_no_support : 1;
> +		u64 ibrs_all_support : 1;
> +		u64 skip_l1df_support : 1;
> +		u64 ssb_no_support : 1;
> +		u64 rsb_a_no_support : 1;
> +		u64 virt_spec_ctrl_support : 1;
> +		u64 rd_pid_support : 1;
> +		u64 umip_support : 1;
> +		u64 mbs_no_support : 1;
> +		u64 mb_clear_support : 1;
> +		u64 taa_no_support : 1;
> +		u64 tsx_ctrl_support : 1;
> +		/*
> +		 * N.B. The final processor feature bit in bank 0 is reserved to
> +		 * simplify potential downlevel backports.
> +		 */
> +		u64 reserved_bank0 : 1;
> +
> +		/* N.B. Begin bank 1 processor features. */
> +		u64 acount_mcount_support : 1;
> +		u64 tsc_invariant_support : 1;
> +		u64 cl_zero_support : 1;
> +		u64 rdpru_support : 1;
> +		u64 la57_support : 1;
> +		u64 mbec_support : 1;
> +		u64 nested_virt_support : 1;
> +		u64 psfd_support : 1;
> +		u64 cet_ss_support : 1;
> +		u64 cet_ibt_support : 1;
> +		u64 vmx_exception_inject_support : 1;
> +		u64 enqcmd_support : 1;
> +		u64 umwait_tpause_support : 1;
> +		u64 movdiri_support : 1;
> +		u64 movdir64b_support : 1;
> +		u64 cldemote_support : 1;
> +		u64 serialize_support : 1;
> +		u64 tsc_deadline_tmr_support : 1;
> +		u64 tsc_adjust_support : 1;
> +		u64 fzlrep_movsb : 1;
> +		u64 fsrep_stosb : 1;
> +		u64 fsrep_cmpsb : 1;
> +		u64 reserved_bank1 : 42;
> +	} __packed;
> +};
> +
> +union hv_partition_processor_xsave_features {
> +	struct {
> +		u64 xsave_support : 1;
> +		u64 xsaveopt_support : 1;
> +		u64 avx_support : 1;
> +		u64 reserved1 : 61;
> +	} __packed;
> +	u64 as_uint64;
> +};
> +
> +struct hv_partition_creation_properties {
> +	union hv_partition_processor_features disabled_processor_features;
> +	union hv_partition_processor_xsave_features
> +		disabled_processor_xsave_features;
> +} __packed;
> +
> +#define HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS 1
> +
> +union hv_partition_synthetic_processor_features {
> +	u64 as_uint64[HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS];
> +
> +	struct {
> +		u64 hypervisor_present : 1;
> +		/* Support for HV#1: (CPUID leaves 0x40000000 - 0x40000006)*/
> +		u64 hv1 : 1;
> +		u64 access_vp_run_time_reg : 1; /* HV_X64_MSR_VP_RUNTIME */
> +		u64 access_partition_reference_counter : 1; /*
> HV_X64_MSR_TIME_REF_COUNT */
> +		u64 access_synic_regs : 1; /* SINT-related registers */
> +		/*
> +		 * Access to HV_X64_MSR_STIMER0_CONFIG through
> +		 * HV_X64_MSR_STIMER3_COUNT.
> +		 */
> +		u64 access_synthetic_timer_regs : 1;
> +		u64 access_intr_ctrl_regs : 1; /* APIC MSRs and VP assist page*/
> +		/* HV_X64_MSR_GUEST_OS_ID and HV_X64_MSR_HYPERCALL */
> +		u64 access_hypercall_regs : 1;
> +		u64 access_vp_index : 1;
> +		u64 access_partition_reference_tsc : 1;
> +		u64 access_guest_idle_reg : 1;
> +		u64 access_frequency_regs : 1;
> +		u64 reserved_z12 : 1;
> +		u64 reserved_z13 : 1;
> +		u64 reserved_z14 : 1;
> +		u64 enable_extended_gva_ranges_for_flush_virtual_address_list : 1;
> +		u64 reserved_z16 : 1;
> +		u64 reserved_z17 : 1;
> +		/* Use fast hypercall output. Corresponds to privilege. */
> +		u64 fast_hypercall_output : 1;
> +		u64 reserved_z19 : 1;
> +		u64 start_virtual_processor : 1; /* Can start VPs */
> +		u64 reserved_z21 : 1;
> +		/* Synthetic timers in direct mode. */
> +		u64 direct_synthetic_timers : 1;
> +		u64 reserved_z23 : 1;
> +		u64 extended_processor_masks : 1;
> +
> +		/* Enable various hypercalls */
> +		u64 tb_flush_hypercalls : 1;
> +		u64 synthetic_cluster_ipi : 1;
> +		u64 notify_long_spin_wait : 1;
> +		u64 query_numa_distance : 1;
> +		u64 signal_events : 1;
> +		u64 retarget_device_interrupt : 1;
> +		u64 restore_time : 1;
> +
> +		/* EnlightenedVmcs nested enlightenment is supported. */
> +		u64 enlightened_vmcs : 1;
> +		u64 reserved : 31;
> +	} __packed;
> +};
> +
> +#define HV_MAKE_COMPATIBILITY_VERSION(major_, minor_)	\
> +	((u32)((major_) << 8 | (minor_)))
> +
> +#define HV_COMPATIBILITY_21_H2
> 	HV_MAKE_COMPATIBILITY_VERSION(0X6, 0X9)
> +
> +union hv_partition_isolation_properties {
> +	u64 as_uint64;
> +	struct {
> +		u64 isolation_type: 5;
> +		u64 isolation_host_type : 2;
> +		u64 rsvd_z: 5;
> +		u64 shared_gpa_boundary_page_number: 52;
> +	} __packed;
> +};
> +
> +/*
> + * Various isolation types supported by MSHV.
> + */
> +#define HV_PARTITION_ISOLATION_TYPE_NONE            0
> +#define HV_PARTITION_ISOLATION_TYPE_SNP             2
> +#define HV_PARTITION_ISOLATION_TYPE_TDX             3
> +
> +/*
> + * Various host isolation types supported by MSHV.
> + */
> +#define HV_PARTITION_ISOLATION_HOST_TYPE_NONE       0x0
> +#define HV_PARTITION_ISOLATION_HOST_TYPE_HARDWARE   0x1
> +#define HV_PARTITION_ISOLATION_HOST_TYPE_RESERVED   0x2
> +
> +/* Note: Exo partition is enabled by default */
> +#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION                    BIT(=
8)
> +#define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED                    BIT(=
13)
> +#define HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED
> BIT(19)
> +#define HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE                   BIT(=
22)
> +
> +struct hv_input_create_partition {
> +	u64 flags;
> +	struct hv_proximity_domain_info proximity_domain_info;
> +	u32 compatibility_version;
> +	u32 padding;
> +	struct hv_partition_creation_properties partition_creation_properties;
> +	union hv_partition_isolation_properties isolation_properties;
> +} __packed;
> +
> +struct hv_output_create_partition {
> +	u64 partition_id;
> +} __packed;
> +
> +struct hv_input_initialize_partition {
> +	u64 partition_id;
> +} __packed;
> +
> +struct hv_input_finalize_partition {
> +	u64 partition_id;
> +} __packed;
> +
> +struct hv_input_delete_partition {
> +	u64 partition_id;
> +} __packed;
> +
> +struct hv_input_get_partition_property {
> +	u64 partition_id;
> +	u32 property_code; /* enum hv_partition_property_code */
> +	u32 padding;
> +} __packed;
> +
> +struct hv_output_get_partition_property {
> +	u64 property_value;
> +} __packed;
> +
> +struct hv_input_set_partition_property {
> +	u64 partition_id;
> +	u32 property_code; /* enum hv_partition_property_code */
> +	u32 padding;
> +	u64 property_value;
> +} __packed;
> +
> +enum hv_vp_state_page_type {
> +	HV_VP_STATE_PAGE_REGISTERS =3D 0,
> +	HV_VP_STATE_PAGE_INTERCEPT_MESSAGE =3D 1,
> +	HV_VP_STATE_PAGE_COUNT
> +};
> +
> +struct hv_input_map_vp_state_page {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u32 type; /* enum hv_vp_state_page_type */
> +} __packed;
> +
> +struct hv_output_map_vp_state_page {
> +	u64 map_location; /* GPA page number */
> +} __packed;
> +
> +struct hv_input_unmap_vp_state_page {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u32 type; /* enum hv_vp_state_page_type */
> +} __packed;
> +
> +struct hv_opaque_intercept_message {
> +	u32 vp_index;
> +} __packed;
> +
> +enum hv_port_type {
> +	HV_PORT_TYPE_MESSAGE =3D 1,
> +	HV_PORT_TYPE_EVENT   =3D 2,
> +	HV_PORT_TYPE_MONITOR =3D 3,
> +	HV_PORT_TYPE_DOORBELL =3D 4	/* Root Partition only */
> +};
> +
> +struct hv_port_info {
> +	u32 port_type; /* enum hv_port_type */
> +	u32 padding;
> +	union {
> +		struct {
> +			u32 target_sint;
> +			u32 target_vp;
> +			u64 rsvdz;
> +		} message_port_info;
> +		struct {
> +			u32 target_sint;
> +			u32 target_vp;
> +			u16 base_flag_number;
> +			u16 flag_count;
> +			u32 rsvdz;
> +		} event_port_info;
> +		struct {
> +			u64 monitor_address;
> +			u64 rsvdz;
> +		} monitor_port_info;
> +		struct {
> +			u32 target_sint;
> +			u32 target_vp;
> +			u64 rsvdz;
> +		} doorbell_port_info;
> +	};
> +} __packed;
> +
> +struct hv_connection_info {
> +	u32 port_type;
> +	u32 padding;
> +	union {
> +		struct {
> +			u64 rsvdz;
> +		} message_connection_info;
> +		struct {
> +			u64 rsvdz;
> +		} event_connection_info;
> +		struct {
> +			u64 monitor_address;
> +		} monitor_connection_info;
> +		struct {
> +			u64 gpa;
> +			u64 trigger_value;
> +			u64 flags;
> +		} doorbell_connection_info;
> +	};
> +} __packed;
> +
> +/* Define synthetic interrupt controller flag constants. */
> +#define HV_EVENT_FLAGS_COUNT		(256 * 8)
> +#define HV_EVENT_FLAGS_BYTE_COUNT	(256)
> +#define HV_EVENT_FLAGS32_COUNT		(256 / sizeof(u32))
> +
> +/* linux side we create long version of flags to use long bit ops on fla=
gs */
> +#define HV_EVENT_FLAGS_UL_COUNT		(256 / sizeof(ulong))
> +
> +/* Define the synthetic interrupt controller event flags format. */
> +union hv_synic_event_flags {
> +	unsigned char flags8[HV_EVENT_FLAGS_BYTE_COUNT];
> +	u32 flags32[HV_EVENT_FLAGS32_COUNT];
> +	ulong flags[HV_EVENT_FLAGS_UL_COUNT];  /* linux only */
> +};
> +
> +struct hv_synic_event_flags_page {
> +	volatile union hv_synic_event_flags event_flags[HV_SYNIC_SINT_COUNT];
> +};
> +
> +#define HV_SYNIC_EVENT_RING_MESSAGE_COUNT 63
> +
> +struct hv_synic_event_ring {
> +	u8  signal_masked;
> +	u8  ring_full;
> +	u16 reserved_z;
> +	u32 data[HV_SYNIC_EVENT_RING_MESSAGE_COUNT];
> +} __packed;
> +
> +struct hv_synic_event_ring_page {
> +	struct hv_synic_event_ring sint_event_ring[HV_SYNIC_SINT_COUNT];
> +};
> +
> +/* Define SynIC control register. */
> +union hv_synic_scontrol {
> +	u64 as_uint64;
> +	struct {
> +		u64 enable : 1;
> +		u64 reserved : 63;
> +	} __packed;
> +};
> +
> +/* Define the format of the SIEFP register */
> +union hv_synic_siefp {
> +	u64 as_uint64;
> +	struct {
> +		u64 siefp_enabled : 1;
> +		u64 preserved : 11;
> +		u64 base_siefp_gpa : 52;
> +	} __packed;
> +};
> +
> +union hv_synic_sirbp {
> +	u64 as_uint64;
> +	struct {
> +		u64 sirbp_enabled : 1;
> +		u64 preserved : 11;
> +		u64 base_sirbp_gpa : 52;
> +	} __packed;
> +};
> +
> +union hv_interrupt_control {
> +	u64 as_uint64;
> +	struct {
> +		u32 interrupt_type; /* enum hv_interrupt_type */
> +		u32 level_triggered : 1;
> +		u32 logical_dest_mode : 1;
> +		u32 rsvd : 30;
> +	} __packed;
> +};
> +
> +struct hv_stimer_state {
> +	struct {
> +		u32 undelivered_msg_pending : 1;
> +		u32 reserved : 31;
> +	} __packed flags;
> +	u32 resvd;
> +	u64 config;
> +	u64 count;
> +	u64 adjustment;
> +	u64 undelivered_exp_time;
> +} __packed;
> +
> +struct hv_synthetic_timers_state {
> +	struct hv_stimer_state timers[HV_SYNIC_STIMER_COUNT];
> +	u64 reserved[5];
> +} __packed;
> +
> +union hv_input_delete_vp {
> +	u64 as_uint64[2];
> +	struct {
> +		u64 partition_id;
> +		u32 vp_index;
> +		u8 reserved[4];
> +	} __packed;
> +} __packed;
> +
> +struct hv_input_assert_virtual_interrupt {
> +	u64 partition_id;
> +	union hv_interrupt_control control;
> +	u64 dest_addr; /* cpu's apic id */
> +	u32 vector;
> +	u8 target_vtl;
> +	u8 rsvd_z0;
> +	u16 rsvd_z1;
> +} __packed;
> +
> +struct hv_input_create_port {
> +	u64 port_partition_id;
> +	union hv_port_id port_id;
> +	u8 port_vtl;
> +	u8 min_connection_vtl;
> +	u16 padding;
> +	u64 connection_partition_id;
> +	struct hv_port_info port_info;
> +	struct hv_proximity_domain_info proximity_domain_info;
> +} __packed;
> +
> +union hv_input_delete_port {
> +	u64 as_uint64[2];
> +	struct {
> +		u64 port_partition_id;
> +		union hv_port_id port_id;
> +		u32 reserved;
> +	};
> +} __packed;
> +
> +struct hv_input_connect_port {
> +	u64 connection_partition_id;
> +	union hv_connection_id connection_id;
> +	u8 connection_vtl;
> +	u8 rsvdz0;
> +	u16 rsvdz1;
> +	u64 port_partition_id;
> +	union hv_port_id port_id;
> +	u32 reserved2;
> +	struct hv_connection_info connection_info;
> +	struct hv_proximity_domain_info proximity_domain_info;
> +} __packed;
> +
> +union hv_input_disconnect_port {
> +	u64 as_uint64[2];
> +	struct {
> +		u64 connection_partition_id;
> +		union hv_connection_id connection_id;
> +		u32 is_doorbell: 1;
> +		u32 reserved: 31;
> +	} __packed;
> +} __packed;
> +
> +union hv_input_notify_port_ring_empty {
> +	u64 as_uint64;
> +	struct {
> +		u32 sint_index;
> +		u32 reserved;
> +	};
> +} __packed;
> +
> +struct hv_vp_state_data_xsave {
> +	u64 flags;
> +	union hv_x64_xsave_xfem_register states;
> +} __packed;
> +
> +/*
> + * For getting and setting VP state, there are two options based on the =
state type:
> + *
> + *     1.) Data that is accessed by PFNs in the input hypercall page. Th=
is is used
> + *         for state which may not fit into the hypercall pages.
> + *     2.) Data that is accessed directly in the input\output hypercall =
pages.
> + *         This is used for state that will always fit into the hypercal=
l pages.
> + *
> + * In the future this could be dynamic based on the size if needed.
> + *
> + * Note these hypercalls have an 8-byte aligned variable header size as =
per the tlfs
> + */
> +
> +#define HV_GET_SET_VP_STATE_TYPE_PFN	BIT(31)
> +
> +enum hv_get_set_vp_state_type {
> +	/* HvGetSetVpStateLocalInterruptControllerState - APIC/GIC state */
> +	HV_GET_SET_VP_STATE_LAPIC_STATE	     =3D 0 |
> HV_GET_SET_VP_STATE_TYPE_PFN,
> +	HV_GET_SET_VP_STATE_XSAVE	     =3D 1 | HV_GET_SET_VP_STATE_TYPE_PFN,
> +	HV_GET_SET_VP_STATE_SIM_PAGE	     =3D 2 |
> HV_GET_SET_VP_STATE_TYPE_PFN,
> +	HV_GET_SET_VP_STATE_SIEF_PAGE	     =3D 3 |
> HV_GET_SET_VP_STATE_TYPE_PFN,
> +	HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS =3D 4,
> +};
> +
> +struct hv_vp_state_data {
> +	u32 type;
> +	u32 rsvd;
> +	struct hv_vp_state_data_xsave xsave;
> +} __packed;
> +
> +struct hv_input_get_vp_state {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u8 input_vtl;
> +	u8 rsvd0;
> +	u16 rsvd1;
> +	struct hv_vp_state_data state_data;
> +	u64 output_data_pfns[];
> +} __packed;
> +
> +union hv_output_get_vp_state {
> +	struct hv_synthetic_timers_state synthetic_timers_state;
> +} __packed;
> +
> +union hv_input_set_vp_state_data {
> +	u64 pfns;
> +	u8 bytes;
> +} __packed;
> +
> +struct hv_input_set_vp_state {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u8 input_vtl;
> +	u8 rsvd0;
> +	u16 rsvd1;
> +	struct hv_vp_state_data state_data;
> +	union hv_input_set_vp_state_data data[];
> +} __packed;
> +
> +/*
> + * Dispatch state for the VP communicated by the hypervisor to the
> + * VP-dispatching thread in the root on return from HVCALL_DISPATCH_VP.
> + */
> +enum hv_vp_dispatch_state {
> +	HV_VP_DISPATCH_STATE_INVALID	=3D 0,
> +	HV_VP_DISPATCH_STATE_BLOCKED	=3D 1,
> +	HV_VP_DISPATCH_STATE_READY	=3D 2,
> +};
> +
> +/*
> + * Dispatch event that caused the current dispatch state on return from
> + * HVCALL_DISPATCH_VP.
> + */
> +enum hv_vp_dispatch_event {
> +	HV_VP_DISPATCH_EVENT_INVALID	=3D 0x00000000,
> +	HV_VP_DISPATCH_EVENT_SUSPEND	=3D 0x00000001,
> +	HV_VP_DISPATCH_EVENT_INTERCEPT	=3D 0x00000002,
> +};
> +
> +#define HV_ROOT_SCHEDULER_MAX_VPS_PER_CHILD_PARTITION   1024
> +/* The maximum array size of HV_GENERIC_SET (vp_set) buffer */
> +#define HV_GENERIC_SET_QWORD_COUNT(max) (((((max) - 1) >> 6) + 1) + 2)
> +
> +struct hv_vp_signal_bitset_scheduler_message {
> +	u64 partition_id;
> +	u32 overflow_count;
> +	u16 vp_count;
> +	u16 reserved;
> +
> +#define BITSET_BUFFER_SIZE \
> +
> 	HV_GENERIC_SET_QWORD_COUNT(HV_ROOT_SCHEDULER_MAX_VPS_PER_C
> HILD_PARTITION)
> +	union {
> +		struct hv_vpset bitset;
> +		u64 bitset_buffer[BITSET_BUFFER_SIZE];
> +	} vp_bitset;
> +#undef BITSET_BUFFER_SIZE
> +} __packed;
> +
> +static_assert(sizeof(struct hv_vp_signal_bitset_scheduler_message) <=3D
> +	(sizeof(struct hv_message) - sizeof(struct hv_message_header)));
> +
> +#define HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT \
> +	(((sizeof(struct hv_message) - sizeof(struct hv_message_header)) / \
> +	 (sizeof(u64 /* partition id */) + sizeof(u32 /* vp index */))) - 1)
> +
> +struct hv_vp_signal_pair_scheduler_message {
> +	u32 overflow_count;
> +	u8 vp_count;
> +	u8 reserved1[3];
> +
> +	u64 partition_ids[HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT];
> +	u32 vp_indexes[HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT];
> +
> +	u8 reserved2[4];
> +} __packed;
> +
> +static_assert(sizeof(struct hv_vp_signal_pair_scheduler_message) =3D=3D
> +	(sizeof(struct hv_message) - sizeof(struct hv_message_header)));
> +
> +/* Input and output structures for HVCALL_DISPATCH_VP */
> +#define HV_DISPATCH_VP_FLAG_CLEAR_INTERCEPT_SUSPEND	0x1
> +#define HV_DISPATCH_VP_FLAG_ENABLE_CALLER_INTERRUPTS	0x2
> +#define HV_DISPATCH_VP_FLAG_SET_CALLER_SPEC_CTRL	0x4
> +#define HV_DISPATCH_VP_FLAG_SKIP_VP_SPEC_FLUSH		0x8
> +#define HV_DISPATCH_VP_FLAG_SKIP_CALLER_SPEC_FLUSH	0x10
> +#define HV_DISPATCH_VP_FLAG_SKIP_CALLER_USER_SPEC_FLUSH	0x20
> +
> +struct hv_input_dispatch_vp {
> +	u64 partition_id;
> +	u32 vp_index;
> +	u32 flags;
> +	u64 time_slice; /* in 100ns */
> +	u64 spec_ctrl;
> +} __packed;
> +
> +struct hv_output_dispatch_vp {
> +	u32 dispatch_state; /* enum hv_vp_dispatch_state */
> +	u32 dispatch_event; /* enum hv_vp_dispatch_event */
> +} __packed;
> +
> +#endif /* _HV_HVHDK_H */
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> new file mode 100644
> index 000000000000..46938b664f0c
> --- /dev/null
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -0,0 +1,310 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Type definitions for the Microsoft Hypervisor.
> + */
> +#ifndef _HV_HVHDK_MINI_H
> +#define _HV_HVHDK_MINI_H
> +
> +#include "hvgdk_mini.h"
> +
> +/*
> + * Doorbell connection_info flags.
> + */
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_MASK  0x00000007
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_ANY   0x00000000
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE  0x00000001
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_WORD  0x00000002
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD 0x00000003
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD 0x00000004
> +#define HV_DOORBELL_FLAG_TRIGGER_ANY_VALUE  0x80000000
> +
> +/* Each generic set contains 64 elements */
> +#define HV_GENERIC_SET_SHIFT		(6)
> +#define HV_GENERIC_SET_MASK		(63)
> +
> +enum hv_generic_set_format {
> +	HV_GENERIC_SET_SPARSE_4K,
> +	HV_GENERIC_SET_ALL,
> +};
> +
> +enum hv_scheduler_type {
> +	HV_SCHEDULER_TYPE_LP =3D 1, /* Classic scheduler w/o SMT */
> +	HV_SCHEDULER_TYPE_LP_SMT =3D 2, /* Classic scheduler w/ SMT */
> +	HV_SCHEDULER_TYPE_CORE_SMT =3D 3, /* Core scheduler */
> +	HV_SCHEDULER_TYPE_ROOT =3D 4, /* Root / integrated scheduler */
> +	HV_SCHEDULER_TYPE_MAX
> +};
> +
> +enum hv_partition_property_code {
> +	/* Privilege properties */
> +	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			=3D 0x00010000,
> +	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES		=3D
> 0x00010001,
> +
> +	/* Resource properties */
> +	HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING		=3D
> 0x00050005,
> +	HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION		=3D
> 0x00050017,
> +
> +	/* Compatibility properties */
> +	HV_PARTITION_PROPERTY_PROCESSOR_XSAVE_FEATURES		=3D
> 0x00060002,
> +	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE		=3D 0x00060008,
> +	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY		=3D
> 0x00060009,
> +};
> +
> +enum hv_system_property {
> +	/* Add more values when needed */
> +	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE =3D 15,
> +};
> +
> +struct hv_input_get_system_property {
> +	u32 property_id; /* enum hv_system_property */
> +	union {
> +		u32 as_uint32;
> +		/* More fields to be filled in when needed */
> +	};
> +} __packed;
> +
> +struct hv_output_get_system_property {
> +	union {
> +		u32 scheduler_type; /* enum hv_scheduler_type */
> +	};
> +} __packed;
> +
> +struct hv_proximity_domain_flags {
> +	u32 proximity_preferred : 1;
> +	u32 reserved : 30;
> +	u32 proximity_info_valid : 1;
> +} __packed;
> +
> +struct hv_proximity_domain_info {
> +	u32 domain_id;
> +	struct hv_proximity_domain_flags flags;
> +} __packed;
> +
> +/* HvDepositMemory hypercall */
> +struct hv_deposit_memory {	/* HV_INPUT_DEPOSIT_MEMORY */
> +	u64 partition_id;
> +	u64 gpa_page_list[];
> +} __packed;
> +
> +struct hv_input_withdraw_memory {
> +	u64 partition_id;
> +	struct hv_proximity_domain_info proximity_domain_info;
> +} __packed;
> +
> +struct hv_output_withdraw_memory {
> +	DECLARE_FLEX_ARRAY(u64, gpa_page_list);
> +} __packed;
> +
> +/* HV Map GPA (Guest Physical Address) Flags */
> +#define HV_MAP_GPA_PERMISSIONS_NONE	       0x0
> +#define HV_MAP_GPA_READABLE		       0x1
> +#define HV_MAP_GPA_WRITABLE		       0x2
> +#define HV_MAP_GPA_KERNEL_EXECUTABLE	       0x4
> +#define HV_MAP_GPA_USER_EXECUTABLE	       0x8
> +#define HV_MAP_GPA_EXECUTABLE		       0xC
> +#define HV_MAP_GPA_PERMISSIONS_MASK	       0xF
> +#define HV_MAP_GPA_ADJUSTABLE		    0x8000
> +#define HV_MAP_GPA_NO_ACCESS		   0x10000
> +#define HV_MAP_GPA_NOT_CACHED		  0x200000
> +#define HV_MAP_GPA_LARGE_PAGE		0x80000000
> +
> +struct hv_input_map_gpa_pages {
> +	u64 target_partition_id;
> +	u64 target_gpa_base;
> +	u32 map_flags;
> +	u32 padding;
> +	u64 source_gpa_page_list[];
> +} __packed;
> +
> +union hv_gpa_page_access_state_flags {
> +	struct {
> +		u64 clear_accessed : 1;
> +		u64 set_accessed : 1;
> +		u64 clear_dirty : 1;
> +		u64 set_dirty : 1;
> +		u64 reserved : 60;
> +	} __packed;
> +	u64 as_uint64;
> +};
> +
> +struct hv_input_get_gpa_pages_access_state {
> +	u64  partition_id;
> +	union hv_gpa_page_access_state_flags flags;
> +	u64 hv_gpa_page_number;
> +} __packed;
> +
> +union hv_gpa_page_access_state {
> +	struct {
> +		u8 accessed : 1;
> +		u8 dirty : 1;
> +		u8 reserved: 6;
> +	};
> +	u8 as_uint8;
> +} __packed;
> +
> +struct hv_lp_startup_status {
> +	u64 hv_status;
> +	u64 substatus1;
> +	u64 substatus2;
> +	u64 substatus3;
> +	u64 substatus4;
> +	u64 substatus5;
> +	u64 substatus6;
> +} __packed;
> +
> +struct hv_input_add_logical_processor {
> +	u32 lp_index;
> +	u32 apic_id;
> +	struct hv_proximity_domain_info proximity_domain_info;
> +} __packed;
> +
> +struct hv_output_add_logical_processor {
> +	struct hv_lp_startup_status startup_status;
> +} __packed;
> +
> +enum {	/* HV_SUBNODE_TYPE */
> +	HV_SUBNODE_ANY		=3D 0,
> +	HV_SUBNODE_SOCKET,
> +	HV_SUBNODE_CLUSTER,
> +	HV_SUBNODE_L3,
> +	HV_SUBNODE_COUNT,
> +	HV_SUBNODE_INVALID	=3D -1
> +};
> +
> +struct hv_create_vp {	/* HV_INPUT_CREATE_VP */
> +	u64 partition_id;
> +	u32 vp_index;
> +	u8 padding[3];
> +	u8 subnode_type;
> +	u64 subnode_id;
> +	struct hv_proximity_domain_info proximity_domain_info;
> +	u64 flags;
> +} __packed;
> +
> +/* HV_INTERRUPT_TRIGGER_MODE */
> +enum hv_interrupt_trigger_mode {
> +	HV_INTERRUPT_TRIGGER_MODE_EDGE	=3D 0,
> +	HV_INTERRUPT_TRIGGER_MODE_LEVEL	=3D 1,
> +};
> +
> +/* HV_DEVICE_INTERRUPT_DESCRIPTOR */
> +struct hv_device_interrupt_descriptor {
> +	u32 interrupt_type;
> +	u32 trigger_mode;
> +	u32 vector_count;
> +	u32 reserved;
> +	struct hv_device_interrupt_target target;
> +} __packed;
> +
> +/* HV_INPUT_MAP_DEVICE_INTERRUPT */
> +struct hv_input_map_device_interrupt {
> +	u64 partition_id;
> +	u64 device_id;
> +	u32 flags;
> +	u32 base_irt_idx;
> +	struct hv_interrupt_entry logical_interrupt_entry;
> +	struct hv_device_interrupt_descriptor interrupt_descriptor;
> +} __packed;
> +
> +/* HV_OUTPUT_MAP_DEVICE_INTERRUPT */
> +struct hv_output_map_device_interrupt {
> +	struct hv_interrupt_entry interrupt_entry;
> +} __packed;
> +
> +/* HV_INPUT_UNMAP_DEVICE_INTERRUPT */
> +struct hv_input_unmap_device_interrupt {
> +	u64 partition_id;
> +	u64 device_id;
> +	struct hv_interrupt_entry interrupt_entry;
> +	u32 flags;
> +} __packed;
> +
> +#define HV_SOURCE_SHADOW_NONE		    0x0
> +#define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
> +
> +struct hv_send_ipi_ex { /* HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI_EX */
> +	u32 vector;
> +	u32 reserved;
> +	struct hv_vpset vp_set;
> +} __packed;
> +
> +typedef u16 hv_pci_rid;		/* HV_PCI_RID */
> +typedef u16 hv_pci_segment;	/* HV_PCI_SEGMENT */
> +typedef u64 hv_logical_device_id;
> +union hv_pci_bdf {	/* HV_PCI_BDF */
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 function : 3;
> +		u8 device : 5;
> +		u8 bus;
> +	};
> +} __packed;
> +
> +union hv_pci_bus_range {
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 subordinate_bus;
> +		u8 secondary_bus;
> +	};
> +} __packed;
> +
> +enum hv_device_type {		/* HV_DEVICE_TYPE */
> +	HV_DEVICE_TYPE_LOGICAL	=3D 0,
> +	HV_DEVICE_TYPE_PCI	=3D 1,
> +	HV_DEVICE_TYPE_IOAPIC	=3D 2,
> +	HV_DEVICE_TYPE_ACPI	=3D 3,
> +};
> +
> +union hv_device_id {		/* HV_DEVICE_ID */
> +	u64 as_uint64;
> +
> +	struct {
> +		u64 reserved0 : 62;
> +		u64 device_type : 2;
> +	};
> +
> +	/* HV_DEVICE_TYPE_LOGICAL */
> +	struct {
> +		u64 id : 62;
> +		u64 device_type : 2;
> +	} logical;
> +
> +	/* HV_DEVICE_TYPE_PCI */
> +	struct {
> +		union {
> +			hv_pci_rid rid;
> +			union hv_pci_bdf bdf;
> +		};
> +
> +		hv_pci_segment segment;
> +		union hv_pci_bus_range shadow_bus_range;
> +
> +		u16 phantom_function_bits : 2;
> +		u16 source_shadow : 1;
> +
> +		u16 rsvdz0 : 11;
> +		u16 device_type : 2;
> +	} pci;
> +
> +	/* HV_DEVICE_TYPE_IOAPIC */
> +	struct {
> +		u8 ioapic_id;
> +		u8 rsvdz0;
> +		u16 rsvdz1;
> +		u16 rsvdz2;
> +
> +		u16 rsvdz3 : 14;
> +		u16 device_type : 2;
> +	} ioapic;
> +
> +	/* HV_DEVICE_TYPE_ACPI */
> +	struct {
> +		u32 input_mapping_base;
> +		u32 input_mapping_count : 30;
> +		u32 device_type : 2;
> +	} acpi;
> +} __packed;
> +
> +#endif /* _HV_HVHDK_MINI_H */
> --
> 2.34.1
>=20


