Return-Path: <linux-pci+bounces-18597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B19F48A5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 11:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9513188AFD7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D541DFD91;
	Tue, 17 Dec 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b="IV8JmQr/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1E1DF965;
	Tue, 17 Dec 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430265; cv=none; b=NGkhL5wCUoNrsjQ/j3ZGgtkmPsfvIkcUj+2+jhPBiQXFLUOgp9MSe636RdZz6QbtJA40zhQJo6uZLuTypJDD0BXNAEV5DeeIKoj1tK9+vwwgEXzmm+MHJNtQjEoF0Kn9PLWy2MFZFM/MdlH68vAu5fX63KF7TjSSEf1mBDnDh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430265; c=relaxed/simple;
	bh=/oUlnT65CiHFNt+hOJDtGb+quRODf091Ygv8JBVnF9U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhQmHzN1dIq6mnOca4oQyE3r7zjanR0ioZZlwXfCNI2cITIoojAG/GeUtr8Ye4hzsis8lPWMoaHLxnsQTEljrC+osL+s1JZ/De5l/kYGd57Tw4/XFC7DI1h+mGH/RIhxaqTrePi4brtEpwwzKwBT3mNcwfl+nlP7olI0EUtzZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com; spf=pass smtp.mailfrom=hughsie.com; dkim=pass (2048-bit key) header.d=hughsie.com header.i=@hughsie.com header.b=IV8JmQr/; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hughsie.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hughsie.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hughsie.com;
	s=protonmail2; t=1734430252; x=1734689452;
	bh=/oUlnT65CiHFNt+hOJDtGb+quRODf091Ygv8JBVnF9U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=IV8JmQr/SJ/3AgSzwnfQztEw2eLPMwo/EPgCrr83CIIYggiBOQ4ZAdHpB4nO6tZ4x
	 1mT7ERKaQWFqUeWgE5fIQTuIWYGrQfpZoSK2Q5MhIcnb13afZ/ZnKt2h5PtElkzKX1
	 yW5767uz0u46Ypu7FsMcJ1ZIrDtGpcUX4oGCUUNUl+w76EyR75qHI2HW2LcQZNkPA3
	 u+kVoAFzU1U7hcAfhDT1o84kbTSblLULluCyRYUUlwlfs/arzbglwj66bnO+I91q9j
	 Ha3efU9hvsZZCBHH333bUARJQX6JFBXtacyYXIidaikLoVHRGrcaSmUBrlfKc4fOZ1
	 96FsmlYV0W9Bg==
Date: Tue, 17 Dec 2024 10:10:47 +0000
To: Werner Sembach <wse@tuxedocomputers.com>
From: Richard Hughes <richard@hughsie.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Richard Hughes <hughsient@gmail.com>, ggo@tuxedocomputers.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some Ryzen chips
Message-ID: <C9ewaxwQKbro-b58prMr4pYnBsbGXBokgIk3OMYfT2OTCUPqSKeabS2ED02pN44ukBu88wjq1JCzyc4Rb9KHK5qce8L1WufgA27O3NKmTvA=@hughsie.com>
In-Reply-To: <2b762f16-fe50-4dec-8f3f-dfe21977d807@tuxedocomputers.com>
References: <20241209193614.535940-1-wse@tuxedocomputers.com> <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com> <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com> <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com> <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com> <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com> <6a809349-016a-42bf-b139-544aeec543aa@tuxedocomputers.com> <20cfa4ed-d25d-4881-81b9-9f1698efe9ff@amd.com> <vVLu9MdNWVCG96sN3xqjkmMVQpr_1iu61hX0w0q5dSQtFBi9ERc3b6hSoCjobPSTNgkIp3PBheheyUlayhMeQjShsx62zNqxWnPsrHt-xaM=@hughsie.com> <2b762f16-fe50-4dec-8f3f-dfe21977d807@tuxedocomputers.com>
Feedback-ID: 110239754:user:proton
X-Pm-Message-ID: 7e792bc0d1ed839d878d160d47e0a6b701b10039
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, 16 December 2024 at 23:37, Werner Sembach <wse@tuxedocomputers.c=
om> wrote:
> - AfuEfix64.efi <bios>.bin /p /r /capsule -> overwrites nothing
> I tried to explain fwupd and the requirements to our contact at the ODM, =
but
> just got the unhelpful reply to use the command above.

Can you name the ODM? I think essentially all the ODMs are uploading [valid=
] capsules to the LVFS now. If it helps, it's the same capsule needed for t=
he LVFS as for the Microsoft WU (Windows Update) process and all ODMs shoul=
d be intimately familiar with those requirements.
=20
> Do you know how these AfuEfix64.efi flags are passed over to the capsule =
flash
> process? Then it might be possible to implement them in fwupd too.

The capsule, as expected by LVFS and WU, is actually a single *signed* bina=
ry that contains the flasher binary and the payload all wrapped up into one=
. The only time I've seen AfuEfix64.efi in use is for the system preload, a=
s done in the factory.

Richard.


