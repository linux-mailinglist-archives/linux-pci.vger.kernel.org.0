Return-Path: <linux-pci+bounces-30703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F7AE9AF6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E237A4CA8
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4C18035;
	Thu, 26 Jun 2025 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="ofz7wlQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5EC21ABC9
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932846; cv=fail; b=lmijUu7qzyOyY/F8BlQ29kMLTn4PMEIWd2B4QkMMXuXeVZZcJ3UV/2Z0vDcxQvUW92TU/8PscarhtYBg1A2VCd/c6czc+KQUKtBe1lBEShaI8HGnqM3FrW18hVpDHBCWIY2RFJkR7GevxzE0ukMRs7nOvsVdhRkBedFYuuvKAdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932846; c=relaxed/simple;
	bh=eLIqupg6WDr6vCYTIzfUt7N+nkxPIek3GLGQFOtnKSc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q8JlWb0NvFVDmwVvutJG1377SnhnMbm0kzD1X0LZrxUVPfUdoH9irnXRDU/kihNYRg7RVufDrqOdTA1ErkniGCIZktR6OtD8JrbLNjRzUMichEG5AWhT/fkSqcaBtVjkfS15kkMAvrgQRRMjgRx8lEKFcbF9drGxj44iUDE8uXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=ofz7wlQk; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpkoCVIcd1sh0DxpNsUgy8LrzHIB0tP4d+FV0R6DnHp5Um2MECFAiF9Tpj3DR/TiFd60VfHBeVlY0CYQZk3m+Qo/QWcRrn9eKJ80qJcPcNa2eeE17ZNVJreaPGfr/kYPgNvVjC8Jljfr/DcYpA4aHutJhL0NPV0sZo2SJTf8l/KV2kH2+O4oHxMVGaT9XermgY/BZHmJCJQ/8YvmJTEvKsaquv3sv6vqzhFJ4VoKCiO7wzz4bX3G4wF5f35a0M16Y1HOuc3kFnVPSSklsKTxvfre523MR6mLaQ5QIPiIRnSIQ+hEklZDVmZzhjkmT6imvdfEz3tZjJtS8rKtvz/WRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24g2sZTVs5djeCdLL9NQ/44JGexn21rKTUVHrc6Qjw4=;
 b=Rfgz6b5NmyyOdCjEzFWfws/G8nWgIzON1nNRXRIvJJKSMQolG48NhfZV6/vMUt+DNyXeX4168WSxEw3qTHOD2a66nmTfqzi+oBpnre/il2P/Mru6MBuwm+VM+MoIU9D4go09s60u36s/hPIQL+IvEDJkrcuDX3FEJ4HSjB7iV+/GNhCk9RRFxHOtGiq5SyBQ4U8h7vqL7hYshm9/RDGRr8K8pakgiAvQ6oBi2+eF9AA14/nh0UV8GO206FeqOtiR2g9wU2BE2ZUcoD7ppJzjCrReznWo/k65XwDFTFi2LA5dj1Vit7pGWU0s37cmklfwzO2rqbY5r/bzb22/U+N3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24g2sZTVs5djeCdLL9NQ/44JGexn21rKTUVHrc6Qjw4=;
 b=ofz7wlQkHDCjLm1kz0/F1zE0YwYaRyvAyCmu3UzVh8jhC8aS9MW4ArJ9GS1vNiMbnBtOtNZuhjAWyGjvbGy8XVbDG68opyj2o6a33BPFPjkTAR6cS4Yi0UkGJlSCW+GgVTELbvqQgt3kWWBm0y7Ws8ZTFWROOMX3wIRDTGMNZuX/wnm9iGKh41vcBThASeM9vS8VekjOSdhqa087jVpYgQ2O3U2D0GttMPKUx/AHl9KQ//y03Q4Y12Ae8SvOjgyT+sWJnMweRgzOAzLrkNP/l83n0ZOfQSNRu3LEwkiWrYLuSWkP/DHZE3LqI9LVNj2jr8nU6rSxo0NEvFfGawfxMg==
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com (2603:10a6:20b:4e8::10)
 by PA4PR07MB7245.eurprd07.prod.outlook.com (2603:10a6:102:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 10:14:01 +0000
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::ac1a:46d3:bbd7:ab11]) by AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::ac1a:46d3:bbd7:ab11%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 10:14:01 +0000
From: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: pci_probe called concurrently in machine with 2 identical PCI devices
 causing race condition
Thread-Topic: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Thread-Index: Advmgv6S7GDW7X3MS1+pFxVcKASISg==
Date: Thu, 26 Jun 2025 10:14:00 +0000
Message-ID:
 <AS4PR07MB85085806C2BF5CC518D52808937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8508:EE_|PA4PR07MB7245:EE_
x-ms-office365-filtering-correlation-id: b12a2850-10ce-410f-5c92-08ddb49a2bdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SaPjZbUQhkcYZ/150VTjM439lZ7TrITfHmMi2XdQEwrPd2Fb9od6JTPUAwNi?=
 =?us-ascii?Q?cOQJoYp36oeDxbKqXldKL3YiwiLhlAAZIMskKwYR3w+6LQecx9FahAZVfr2T?=
 =?us-ascii?Q?BobmCjUxrgm5KwwYaeEmqiyoeBAmTA9IQSLEQOM+gNfMWtw5qAsusvKzbBnz?=
 =?us-ascii?Q?ojm+YZTmCKh6l0JWHHqOQJiCxXpfkzvV0CXzk+EiAh00vsPJgl5PfjWaEsFy?=
 =?us-ascii?Q?eIuVsHG7l0Xrf0oyI5k/M/WshO/NUAyhjXLbK1nLzKlzfDa/w7J6eeoDbP6S?=
 =?us-ascii?Q?qwjTF+uCyhxNWF0WS5v1mbuSytdMbRa3tgSdH+RK5ZKGwqznPgVeZbF8G+Nd?=
 =?us-ascii?Q?RW4ddGL7rVBM0LPCg3rk/brGtUYjUlAy1tHDYaoaP3wXRU9WGNBCOZd6jZvm?=
 =?us-ascii?Q?UBYYxXhb0yKtcDCzpCCoc7vrQUMWBldBSwCzRAByq3BWL+B0qMbQykGUO4w0?=
 =?us-ascii?Q?AT+S9ojXnAfCMq2poCWLlkRkH1wRis9QhFSMDJhhbph9MM2LydR52F+aOgQN?=
 =?us-ascii?Q?BhCcMRg4RjvzLqAoQ+OA/4gcX6wVxQJmj+gdl0BDOlkaDXAw9DyQIyxJm7IF?=
 =?us-ascii?Q?IU0NxUAvSp2eJ45L3HL61Fzkax4pXjS84guFy2fn948LAu1s6mUO4NuP5Ahh?=
 =?us-ascii?Q?APGz/ifWUnx4sFCNZ2TNBF4D57AGNe6lW7r4OdvbGwX7gyTKowWTNYGqTZgr?=
 =?us-ascii?Q?LOX6j3aiooE+jQogZCWtCqES0GNpeh5erKXV3e8SVUBnUv1qX735OKOyoF5o?=
 =?us-ascii?Q?hCXReeKg5b1hkThf/G2Qw3cGq5GS5d/neIfISvRHtmEkqf/2upDDt4dp+Djp?=
 =?us-ascii?Q?aB3jlsLuJeC+qiqABVEledKAytEDOB8hKaHeOaODhCJSFa6gh33EV2Yzf6zL?=
 =?us-ascii?Q?a5gM9USwLY+UQL1z1yzC0oSY1KGpIMc6WbwuouWdqmqVc0JEXIRtLn/Enum6?=
 =?us-ascii?Q?GFR3bLF1Fij18TjG2dd0txmtRSNDAcb29Q/FFbcMLcT3avuBlyaHWsxIzVNb?=
 =?us-ascii?Q?djR/lAY/bLPXRUJxbDgJNjvhVnphSM1jF3SNtahvsFZB0WvovaBgUrF58tXq?=
 =?us-ascii?Q?iVF1BgH5aky1UHAVShE/AfN0AI+Nvf19Wyp+eANS40T01GUG2NnicsGeIBtX?=
 =?us-ascii?Q?oe/6N5acRyKGKW5kkt54x5ujMeDYqjUq1A3nxY2SRWlN1t8F8ZpC4KTkTPmn?=
 =?us-ascii?Q?V67ZxPtxNnGPaxXpUUATzLebNuXj1udH/EWaV+/GFdhyffT1l0mwhfIz3gmG?=
 =?us-ascii?Q?+3QnVPpyC/epgisJZj1QB62C872QAyOCs8ogix2flALAUNO9nT17kMQa+1mz?=
 =?us-ascii?Q?sI1M6iWYA2n1sv4FLQhHbJJRlp8GeSrt6la0joIq6Ukht7vo7BT0Tb8E/H+r?=
 =?us-ascii?Q?lLSondxfNFe19YfgwjxsvEgh0Lo3ditatKkxz87bDXReP0cyTeYSZFRVLBGW?=
 =?us-ascii?Q?FyblyicUREAHkCPDaaeNaVCBXKa0+JHHTIOp19XQqlpCT09ZOpG9DQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8508.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RkV3WvjtNRxA4gvpI6drA/4AD0xdskqfSaQTiwBrQRZ8uA2vTw4uuqFPlwuA?=
 =?us-ascii?Q?8CxlZwTlg4kJgKy6rjIsKFxSNLtSIAxattrmyUKvHHOrXnEHIJAqhDvp5uNC?=
 =?us-ascii?Q?nsXuTe/wtj98Gh84NrDeo7unVbkOlwa42bFH4j/7T3Tzhl9Cv/RTn7J/2ZkN?=
 =?us-ascii?Q?FSGsqv9E3nDPDMTDYu/V1Zt/Zmbsca4nVuWCUF9nUpJExs5avx6ACzM0tuoJ?=
 =?us-ascii?Q?22evSBtQCICoFSvZ4/wG6yjaVBET4OKEm9pmkdQjoDhJ0o+fpUDrXGAu2zB6?=
 =?us-ascii?Q?LWD/jrdgUnC9khYzQAVVmGnzjy2UMSNZpPGgv1UOEvWtHf4mne5nrCxfxcAt?=
 =?us-ascii?Q?WKurQbMX0HHIhWYSQnlMIdGUMu1MxEoutnLrUX2BZy+7sI5BvlzID7GtiHfJ?=
 =?us-ascii?Q?e5i9fpjnx8lI95Gxcx9v63M1vUQcHxLXhHsNpmqkPhWlyVFmg+FWvmkipbI6?=
 =?us-ascii?Q?+4AW8+XTCXr5X3NY5nsamKmEerozbtPyUiWDpsPGzjmomGaqUyA3hHT9p1V4?=
 =?us-ascii?Q?cslK+fiOa9fvZ42XvTupPdu54GafvK7cw2xpUr0sTIwSYoWuM8ZtsXpG1A+f?=
 =?us-ascii?Q?UPe8teiKS5jfxe3dpTzB1UI/OgG5SvDOR88txorHxaypOQf0f/T4NyuF/Vd7?=
 =?us-ascii?Q?CnB4RKPeAi0mpP8hb6u9h+AhuvGpVomIO6xs6OGD3pc8SsA32UDC9urvJBov?=
 =?us-ascii?Q?JBq2J1u6CuqfLjl1IG5dR2qa2XEqLGsinnSOEwBU89vy0K9gCVAaIlOA/Im5?=
 =?us-ascii?Q?ZKP+SvDVQh+cbxadoAZ42BarHJmy2DC2+zoJehk+WodKMNvHVV+lw8M90/Hm?=
 =?us-ascii?Q?GZqNM6l4vG4YYP894PrBwBESjQb6zGEzU5auMCKukhkbZ+XCu5yJthksYXzL?=
 =?us-ascii?Q?5bzHZrIC2y61x0kShPum7d4mhKUj1g1ller192lCt8djsjWs8lAkYQLgdVea?=
 =?us-ascii?Q?48uE5VRgZUTcoyiRD6vC8NotOhx/Y/jJ4soGYvPywiFhRSUE8MWWe6iuz43Z?=
 =?us-ascii?Q?NzPCOyg4C1R6oXwVH79+vjcL2C3XRMZBQZlfJebWJznISKnk9Jm+huC7hePC?=
 =?us-ascii?Q?bVFRhC3rnvOwpzcJmb9b6A72GUMNJ5MkBk3E7LGTMCsTMZ3ARFHHefndWjs9?=
 =?us-ascii?Q?mtqPwggdT8ugxhs3deCaLaYfyBtpHdPm+3HI4aqJZJEYnOX74AQt0rNTvdp5?=
 =?us-ascii?Q?Pdcji5CbHWeHYCDw+B0FH2G3IXp3YniXkfED1OQXQ75qLoh+rpXMYCTUKr0u?=
 =?us-ascii?Q?YMK4QX/RcbGJSX828/jukN/Vfil6kxh1Nhem9nTfOK7nMIaZ8xSlQRUsfuqi?=
 =?us-ascii?Q?oSZJwRCadZlZWbCmRQG7X6uy0Hy2THHOL3XTV/W/f8QC40Xz5hrHLx0HVNHC?=
 =?us-ascii?Q?6FABVqABiZNytmynWaQTd0wWb3bV+zxOBk9+6zF9DiCPE9bnKe/Mn9BXQLR4?=
 =?us-ascii?Q?3+Xt/Y0laTBD346ymmANl0JpPZdD9Z66gFc44GMvsIaMsF+y09INRfclbopS?=
 =?us-ascii?Q?v/YThYi7ZHY+xV5uU6O5vHFrNtEhNRwTIxccGVds0YMg1v2XtQ3T8RHO/H20?=
 =?us-ascii?Q?wSA24uTZu4vQnWZKuhbwFBe7MTviMke7uDPsY3PS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8508.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12a2850-10ce-410f-5c92-08ddb49a2bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 10:14:00.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKSw6hLmS8kZHDy9+1oTjtH0ZA4c36h5tVmPE8VSmA1ZUuLN4HWwwUs44CEgQ3QjfCTTMntJ9MBsRPsr3YAatf3JVGHKxuI/2m3YW5QW3p0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7245

Hi kernel community,

We have one specific problem related to Linux PCI subsystem.

We have a device with 2 identical NPUs, so 2 identical PCI devices sharing =
the same 3rd party driver. Our problem is that _pci_probe of this driver is=
 called concurrently from 2 kernel threads. It happens more frequently when=
 kernel debug logs are enabled in GRUB, appr. every 20th or 30th reboot of =
the device.

I am writing this mail because it's possible this is generic issue of Linux=
 PCI subsystem which may affect more people/companies - please correct me i=
f I am wrong.

When digging for this in driver's source and Linux kernel source, I found t=
his place in pci_call_probe:

    if (cpu < nr_cpu_ids)
        error =3D work_on_cpu(cpu, local_pci_probe, &ddi);
    else
        error =3D local_pci_probe(&ddi);

This was added in 0b2c2a71 in 2017. Quoting part of commit message:

    PCI: Replace the racy recursion prevention

    pci_call_probe() can called recursively when a physcial function is pro=
bed
    and the probing creates virtual functions, which are populated via
    pci_bus_add_device() which in turn can end up calling pci_call_probe()
    again.
 <end of quote>

So the fix is specifically related to devices with multiple VFs. But does t=
his take into account the setup with 2 separate, but otherwise identical PC=
I devices? Is it possible this can occur in any machine with 2 identical PC=
I devices?

Snippet from dmesg (unfortunately, I am not sure how much I can share):

[   76.586492] linux-kernel-bde (154): DO_NOT_COMMIT: in _pci_probe at 2627
[   76.586494] linux-kernel-bde (154): DO_NOT_COMMIT: ctrl addr before: 000=
0000000000000, _ndevices: 0
[   76.586497] linux-kernel-bde (154): DO_NOT_COMMIT: ctrl addr after: 0000=
0000f24dc905, _ndevices: 0
[   76.595735] linux-kernel-bde (4688): DO_NOT_COMMIT: _devices at 00000000=
f24dc905, sizeof(*_devices): 472
[   76.603415] linux-kernel-bde (154): DO_NOT_COMMIT: ctrl->dev_type set to=
 256
[   76.628884] linux-kernel-bde (4688): DO_NOT_COMMIT: dev->device: 8854
[   76.644076] linux-kernel-bde (4688): DO_NOT_COMMIT: in _pci_probe at 262=
7
[   76.661176] linux-kernel-bde (4688): DO_NOT_COMMIT: ctrl addr before: 00=
00000000000000, _ndevices: 0
[   76.679854] linux-kernel-bde (4688): DO_NOT_COMMIT: ctrl addr after: 000=
00000f24dc905, _ndevices: 0

I checked sources of several drivers for various PCI devices, but none of t=
hem seem to assume probe callback can be called from multiple threads.
Output of uname -a:
Linux Dut-A 6.1.128-13-amd64 #1 SMP PREEMPT_DYNAMIC Thu Jun 12 07:22:21 UTC=
 2025 x86_64 GNU/Linux

Regards,
Jozef

