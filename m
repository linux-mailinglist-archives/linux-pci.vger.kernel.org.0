Return-Path: <linux-pci+bounces-40591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 805DEC40FB4
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 18:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3542121F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C532E68C;
	Fri,  7 Nov 2025 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="qoGasUuB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015C1A9F96;
	Fri,  7 Nov 2025 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535421; cv=none; b=SdrwyvyvhkB2qnfbI8Xzmbe/+5i/V5n7FfZcoqb0kfIhZqzl6+IdqBOy9ktNSxiMXb8uw3YAHnZuXYBEsx9NyuEMBmZKTo/G+KwFZpRfwLYwD5rYVEabn9yNsHppVbNVVtVlkpBtm7pO5lP/i4+t6tB+oOi2PM6/ptPpRT43RAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535421; c=relaxed/simple;
	bh=Q4iZVFIWDajlVqYZQyoAIORebj7pus8kKZIBIi+Th0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oB+64EBl+pmDfJmuJV+rM4M1loiWpx5994l+Cj6/eWYRoRthTiyhgwnePl4qhecVhVotlIrhikgslw2hNRXjERXqO9fzefCDLdXeSL59xe4WreeY1pCU7Oz7BckmUEANAL65n1wr7oS+TKhz8rNV1I/IEuAd9eF1olrcwRPNdHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=qoGasUuB; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762535395; x=1763140195; i=spasswolf@web.de;
	bh=SKEK1JrL+/0p/+OIRqKOxtvvs0duYiZVtOLyFdp51kU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qoGasUuB8tzthdF3u/5mI57zW8Fq1BTps/LxqkECusiEnpRjJBvUMrhlOUXN8rrL
	 OpimuGMrRvHPheBhqPdsnKc4PYqJOqqQyGjBju0xQDZ+ivJ/dEcBsThyiYQi3ZmiR
	 r5VLkX9XRySWrHRies3jX+kUNJlXaRIC79T7sYygp/oIK7NnQf7umKev8e+JonONE
	 lTg7P8RJDcCmZqSVDIoxBECjNXfOET2XBOmPeQVEQq4V31t9LMqb6Rlfiazt4IPwE
	 Uk3zRy525fADCR6XtcJo3n7r9SWQSPb8rQ+0TWHEJ7Z1psWdo0VRRpTSaeanwo6e7
	 hVtNBIvMTpyD9OVEwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUtg-1vZeeL01cc-00Oi0K; Fri, 07
 Nov 2025 18:09:55 +0100
Message-ID: <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de>
Subject: Re: [REGRESSION 00/04] Crash during resume of pcie bridge
From: Bert Karwatzki <spasswolf@web.de>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>, spasswolf@web.de
Date: Fri, 07 Nov 2025 18:09:53 +0100
In-Reply-To: <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
References: <20251006120944.7880-1-spasswolf@web.de>
		 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
		 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
		 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
		 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
		 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
		 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
		 <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
		 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de>
		 <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
		 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org>
	 <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QLOBqZlUoVkFkBzybM3FNXJ8fgpyENig0SB6XsCI12/QxXFEKx4
 V2xRXZBzSPdWgNW4d25HB8up32yn8VQEBeoETymJgm8g4nGdPnAka0DRAyt0e9l8fNXOwL2
 YI5iLAU3bRcYaRtFSnvY8Mmuv9hgB4IJeJxG6zOwRaC9n0sHZcIoiwx6y8JDGrBkLk2Y2Jw
 gtvJ5eCvN4tYPpOlQozfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ImZ0DGL/Uw4=;kMMHkIJJ1hrfkaJf5lBJ1vo+zKU
 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
 3ziyOKsvS9qpdd/fI=

Am Freitag, dem 07.11.2025 um 14:09 +0100 schrieb Bert Karwatzki:
>=20
> Testing:
> v6.12			booted 13:00, 7.11.2025 no crash after 1h, 890 GPP0 events, 287 =
resumes
>=20
>=20
> Bert Karwatzki

v6.12 crashed after 2h, 946 GPP0 events and 499 resumes. So there's no bas=
e
for a bisection.=C2=A0

But the crash from v6.14.11 gave this error in netconsole:

2025-11-06T19:17:34.967439+01:00 T370;[drm] PCIE GART of 512M enabled (tab=
le at 0x00000081FEB00000).
2025-11-06T19:17:34.967439+01:00 T370;amdgpu 0000:03:00.0: amdgpu: PSP is =
resuming...#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-11-06T19:17:34.967588+01:00 T12;pci_bus 0000:03: Allocating resources=
#012 SUBSYSTEM=3Dpci_bus#012 DEVICE=3D+pci_bus:0000:03
2025-11-06T19:17:35.143353+01:00 T370;amdgpu 0000:03:00.0: amdgpu: reserve=
 0xa00000 from 0x81fd000000 for PSP TMR#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+=
pci:0000:03:00.0
2025-11-06T19:17:35.226021+01:00 T370;amdgpu 0000:03:00.0: amdgpu: RAS: op=
tional ras ta ucode is not available#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci=
:0000:03:00.0
2025-11-06T19:17:35.237386+01:00 T370;amdgpu 0000:03:00.0: amdgpu: SECURED=
ISPLAY: securedisplay ta ucode is not available#012 SUBSYSTEM=3Dpci#012
DEVICE=3D+pci:0000:03:00.0
2025-11-06T19:17:35.237386+01:00 T370;amdgpu 0000:03:00.0: amdgpu: SMU is =
resuming...#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-11-06T19:17:35.237386+01:00 T370;amdgpu 0000:03:00.0: amdgpu: smu dri=
ver if version =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw pr=
ogram =3D 0,
version =3D 0x003b3100 (59.49.0)#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:000=
0:03:00.0
2025-11-06T19:17:35.237386+01:00 T370;amdgpu 0000:03:00.0: amdgpu: SMU dri=
ver if version not matched#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:0=
0.0
2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: SMU: re=
sponse:0xFFFFFFFF for index:6 param:0x00000000 message:EnableAllSmuFeature=
s?#012
SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: Failed =
to enable requested dpm features!#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:00=
00:03:00.0
2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: Failed =
to setup smc hw!#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:03:00.0
2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: resume =
of IP block <smu> failed -121#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:0=
3:00.0
2025-11-06T19:17:35.509600+01:00 T370;amdgpu 0000:03:00.0: amdgpu: amdgpu_=
device_ip_resume failed (-121).#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000=
:03:00.0
2025-11-06T19:17:36.114889+01:00 C8;INFO: NMI handler (perf_event_nmi_hand=
ler) took too long to run: 35.314 msecs
2025-11-06T19:17:36.114889+01:00 C8;perf: interrupt took too long (275880 =
> 2500), lowering kernel.perf_event_max_sample_rate to 1000
2025-11-06T19:17:37.930799+01:00 C4;INFO: NMI handler (perf_event_nmi_hand=
ler) took too long to run: 152.914 msecs
2025-11-06T19:17:37.930799+01:00 C4;perf: interrupt took too long (1194640=
 > 344850), lowering kernel.perf_event_max_sample_rate to 1000
2025-11-06T19:17:38.939845+01:00 C14;INFO: NMI handler (perf_event_nmi_han=
dler) took too long to run: 197.312 msecs
2025-11-06T19:17:38.939845+01:00 C14;perf: interrupt took too long (154152=
1 > 1493300), lowering kernel.perf_event_max_sample_rate to 1000

These 4 lines have not been recorded previously, so perhaps I have to look
for a NULL pointer dereference in an error path:

2025-11-06T19:17:42.571252+01:00 T1896;ACPI Error: AE_TIME, Returned by Ha=
ndler for [EmbeddedControl] (20240827/evregion-301)
2025-11-06T19:17:42.571252+01:00 T1896;ACPI Error: Timeout from EC hardwar=
e or EC device driver (20240827/evregion-311)
2025-11-06T19:17:42.571252+01:00 T1896;ACPI Error: Aborting method \x5c_SB=
.PCI0.SBRG.EC.BAT1.UPBS due to previous error (AE_TIME) (20240827/psparse-=
529)
2025-11-06T19:17:42.571252+01:00 T1896;ACPI Error: Aborting method \x5c_SB=
.PCI0.SBRG.EC.BAT1._BST due to previous error (AE_TIME) (20240827/psparse-=
529)=20


Bert Karwatzki

