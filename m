Return-Path: <linux-pci+bounces-14483-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313E99D462
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 18:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF441F22DDA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1E41ADFE4;
	Mon, 14 Oct 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDUxPsA9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAA1AE877;
	Mon, 14 Oct 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922340; cv=none; b=W/TO5ZpvbYjYvL6LaQg4DyZfC22csHIqSMl6ad0y3S91dNryxuwVGa7ymDcW5/1gjFhs82XTHXp2SEQi0N3ArAwOoyc0jdhCYbYVjv3a2EBabX4fMgz3FXln7uoGANNIYJuaU9hdjpq1XH1jJhFcT36NnC1Pyh3N6CVhfTGu16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922340; c=relaxed/simple;
	bh=CNQKNS7OhsQgnN3fePRrd6scDroWpGznlODW8JB/rec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZK+PF4XJsthbkII76uhYFL+j0XZGwgCTuLOPuP8yIzsMoFx5/JOhJhIErkqXu5Qf637qnIr8eRe54DjXKPUw2XFBBjMPGqaXurJLgn14+ELbdGqJUmZQvN5ip2HkGhmZX9DKTxegSxw0kpz/GkHmVQtA9fLWGtkJu9uukm+lbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDUxPsA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C84DC4CEC3;
	Mon, 14 Oct 2024 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728922340;
	bh=CNQKNS7OhsQgnN3fePRrd6scDroWpGznlODW8JB/rec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BDUxPsA9L/tXK4xVJHmoEmiHMhF05lzzvEw5BaHrKJidOno/mDRQglK3Fn2YQN5nm
	 UaflyB9fO0ZxoswFXKanc+t1PPSOWY66b1WLR0PqOfrae26m5G588HOobH40SM6vIk
	 nYZkd+UupLCYD181WsoUU+F2O4sForXKsM1eBJ0p0GxgqgVCB0J2/I996Cuw+8sxn+
	 udTz6qtNytrySRZmC5rD4uvIIqIQ3dE2sdUA2KwSHn5UYdwpOBvFGJPpknEKhAIHI1
	 6fPU0VL1tvpXVfxSi/akK5wkMypAKPUYcfxmgK6JGobUyibD4B71jKp16DbAlu8IQb
	 OJ3hORCcAYxhw==
Message-ID: <4c33a9ad-fbdb-42ca-aff7-e50420c1347e@kernel.org>
Date: Mon, 14 Oct 2024 11:12:18 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/VGA: Don't assume only VGA device found is the boot
 VGA device
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Luke D . Jones" <luke@ljones.dev>
References: <20241014152502.1477809-1-superm1@kernel.org>
 <CADnq5_PCHZtmGN4Frknz+10xVMypwpDuW7_kYbTmvihcayCPew@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CADnq5_PCHZtmGN4Frknz+10xVMypwpDuW7_kYbTmvihcayCPew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/2024 10:45, Alex Deucher wrote:
> On Mon, Oct 14, 2024 at 11:25 AM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The ASUS GA605W has a NVIDIA PCI VGA device and an AMD PCI display device.
>>
>> ```
>> 65:00.0 VGA compatible controller: NVIDIA Corporation AD106M [GeForce RTX 4070 Max-Q / Mobile] (rev a1)
>> 66:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Strix [Radeon 880M / 890M] (rev c1)
>> ```
> 
> For clarity, the iGPU is not a VGA class device.  The "primary" should
> not have any dependency on the VGA PCI class, but I'm not sure how
> exactly the kernel handles this case.  In this case, the primary
> should be the iGPU which is not a VGA PCI class device.

I think if this code change to vga_is_boot_device() causes problems for 
anything older we'll probably need to add some helper that counts how 
many PCI VGA class devices are there on the system and change it to 
something like:

if (multiple_vga && !boot_vga)

> 
> Alex
> 
>>
>> The fallback logic in vga_is_boot_device() flags the NVIDIA dGPU as the
>> boot VGA device, but really the eDP is connected to the AMD PCI display
>> device.
>>
>> Drop this case to avoid marking the NVIDIA dGPU as the boot VGA device.
>>
>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
>> Reported-by: Luke D. Jones <luke@ljones.dev>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3673
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/vgaarb.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>> index 78748e8d2dba..05ac2b672d4b 100644
>> --- a/drivers/pci/vgaarb.c
>> +++ b/drivers/pci/vgaarb.c
>> @@ -675,13 +675,6 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
>>                  return true;
>>          }
>>
>> -       /*
>> -        * Vgadev has neither IO nor MEM enabled.  If we haven't found any
>> -        * other VGA devices, it is the best candidate so far.
>> -        */
>> -       if (!boot_vga)
>> -               return true;
>> -
>>          return false;
>>   }
>>
>> --
>> 2.43.0
>>


