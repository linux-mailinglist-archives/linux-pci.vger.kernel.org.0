Return-Path: <linux-pci+bounces-5950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD689DF5F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEFD1F23E98
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15213D538;
	Tue,  9 Apr 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="M8RQIUlD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768813D50F
	for <linux-pci@vger.kernel.org>; Tue,  9 Apr 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676952; cv=none; b=U4hbiKflT16RMI0w6NhfQKNugcyfhziVBI54u6P/1HlxWEhHFDHwjBrlaI/4f91oKh4uEjvml1IntZKJW+JBMITHM4Pr8EGTZ1FW01VLC17C8UktAp2lV1P8DTdtulCXNTYY9C3bMIy/hoKUBjJ7xZlOrIqAhw98sSYfn4cqcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676952; c=relaxed/simple;
	bh=0pjTPnekrZ6Mo2O3A8pGX4AK75zIDzNbFZm+tv/AiyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+8VkL+2+9mWk5ncmKkvZ4OmZtUjwgsjYmpobsHfV6FCi+K+6I/Qn3IldUwoWxrI/7usVFyQ15oP53IaCTLVIBsJYTnaEAiyMG01mHo2MW91Kif0xHNssEcXgP6nkl6CqPSX3yvBe1z9Jr9f84ymNjmPmV0RolZxRfuvDe65cnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=M8RQIUlD; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso25445341fa.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Apr 2024 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712676948; x=1713281748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nARArI/JGxcqeVSW+91I3DRTdX+G+3rkUWRdOGuyuMs=;
        b=M8RQIUlDboOKc3mYlmgZamgiQC/aqLQdEjingQuXqsMIhm0B833yg2d/kFvFgYpdcs
         uI+RCkeL7K7XLOF/96xLDwC4TbsVVRzLdv3icLl0LbRBslasba4tb2KPocIze+zr9O24
         tGobTO82QFpSI01PDd9R/PIqqdqEHl3XFIhJxdf+MiL+I2oPBRvjlk2cSkwsLYvgqoR/
         YW58TtOa+ApGdF7yexxbzbmvIHajgQlMIMa9jTil8T4fJg2HAARCZpAsJmdTktmgwkRc
         qXPZOxCylHAAHTn1sCxK5OWt2JuGhCGFF2KvvdtpBvYSXePb/br+ec+iNyk53+5Z65uH
         WihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676948; x=1713281748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nARArI/JGxcqeVSW+91I3DRTdX+G+3rkUWRdOGuyuMs=;
        b=MhebNyvUYfK3TLhoA51ADkOwD5BNABOzKSxcPJi1wy5KAE++/7lRjYmPz2xGiQtpZy
         Ya1j8EbQSfVtnSMzSazPe6JjBhafbt14l81+CB/HZRCdkaVR82nN5E/LaQkoC1S7C4n2
         lwC22wM0V39N8T4gXW+TeNF8DR9yku/X6rh3/nIRlI4MDUDee8CkIOJDzhSmMyFQrrh2
         cl1Jjf4Gdx28z9aEArXsOp3PrN8jdcds++Tr3ZG+Jl6wxs3ZxbCyqSUEPIq+CMiqE9k3
         hnCgcmbs5c9X0LGE5wBaM7LXESQ+dY1JFfdmFvOP7E6a4M2fCXplpLQsF/3ug/y/PRHK
         pYQA==
X-Forwarded-Encrypted: i=1; AJvYcCUcMJM7iX4u+gYVp0Iletlr5wqN0RS3f1eJrJ8tYq6qw+/OqBZlxYwpDs4YM9YQgKphD+0nV53WK7K1889MKmfqrHoxEi6w/np7
X-Gm-Message-State: AOJu0YwD/Y6HkCDXQ4LIdYLBOqdGzhfUOHZgF2tEMFrU8+BnTwFqSpvd
	rtxqruEsjHue6VWOEl3+oHdCrLxeHjpJJCDFFnSQrf1CYy3yW65TVlNO3AI+BiQAGmy8RWHXJzf
	vYLSTj9wh7//6dAtVd1e245Am+xLDTf2j/iZSaA==
X-Google-Smtp-Source: AGHT+IGYR0H515M8Yuyw6jAM8maTiRT7zQOgLaut79Nmzv6VqTS4JpTG+pUsMdsTdhL2wX5eqAgRDApWqIUOQCBytW4=
X-Received: by 2002:a2e:b8c3:0:b0:2d8:a814:583d with SMTP id
 s3-20020a2eb8c3000000b002d8a814583dmr166320ljp.30.1712676947967; Tue, 09 Apr
 2024 08:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325131624.26023-1-brgl@bgdev.pl> <6b63d5d2-5f30-4fbd-a872-91f32dc32c87@gmail.com>
In-Reply-To: <6b63d5d2-5f30-4fbd-a872-91f32dc32c87@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Apr 2024 17:35:36 +0200
Message-ID: <CAMRc=McWdU-=MoGe+yVnj4OKzM-2D9KUZnQuj0MmtxDG10e3kw@mail.gmail.com>
Subject: Re: [PATCH v6 00/16] power: sequencing: implement the subsystem and
 add first users
To: Xilin Wu <wuxilin123@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 5:03=E2=80=AFAM Xilin Wu <wuxilin123@gmail.com> wrot=
e:
>
> I tested the patchset on SM8550 and it does give me working WiFi. However=
 I
> seethe following warnings during boot.
>
> [    5.973011] mhi mhi0: Requested to power ON
> [    6.597591] mhi mhi0: Power on setup success
> [    6.597631] sysfs: cannot create duplicate filename '/devices/platform=
/soc@0/1c00000.pcie/pci0000:00/0000:00:00.0/resource0'
> [    6.597634] CPU: 7 PID: 154 Comm: kworker/u32:5 Tainted: G S          =
       6.9.0-rc1-next-20240328-g955237c9980c #1
> [    6.597635] Hardware name: AYN Odin 2 (DT)
> [    6.597637] Workqueue: async async_run_entry_fn
> [    6.597645] Call trace:
> [    6.597646]  dump_backtrace+0xa0/0x128
> [    6.597649]  show_stack+0x20/0x38
> [    6.597650]  dump_stack_lvl+0x74/0x90
> [    6.597653]  dump_stack+0x18/0x28
> [    6.597654]  sysfs_warn_dup+0x6c/0x90
> [    6.597658]  sysfs_add_bin_file_mode_ns+0xdc/0x100
> [    6.597660]  sysfs_create_bin_file+0x7c/0xb8
> [    6.597662]  pci_create_attr+0xb4/0x1a8
> [    6.597665]  pci_create_resource_files+0x64/0xd0
> [    6.597667]  pci_create_sysfs_dev_files+0x24/0x40
> [    6.597669]  pci_bus_add_device+0x54/0x138
> [    6.597670]  pci_bus_add_devices+0x40/0x98
> [    6.597672]  pci_host_probe+0x70/0xf0
> [    6.597673]  dw_pcie_host_init+0x248/0x658
> [    6.597676]  qcom_pcie_probe+0x234/0x330
> [    6.597677]  platform_probe+0x70/0xd8
> [    6.597680]  really_probe+0xc8/0x3a0
> [    6.597681]  __driver_probe_device+0x84/0x170
> [    6.597682]  driver_probe_device+0x44/0x120
> [    6.597683]  __device_attach_driver+0xc4/0x168
> [    6.597684]  bus_for_each_drv+0x8c/0xf0
> [    6.597686]  __device_attach_async_helper+0xb4/0x118
> [    6.597687]  async_run_entry_fn+0x40/0x178
> [    6.597689]  process_one_work+0x16c/0x410
> [    6.597691]  worker_thread+0x284/0x3a0
> [    6.597693]  kthread+0x118/0x128
> [    6.597693]  ret_from_fork+0x10/0x20
> [    6.597698] ------------[ cut here ]------------
> [    6.597698] proc_dir_entry '0000:00/00.0' already registered
> [    6.597710] WARNING: CPU: 7 PID: 154 at fs/proc/generic.c:375 proc_reg=
ister+0x138/0x1d0
> [    6.597713] Modules linked in:
> [    6.597714] CPU: 7 PID: 154 Comm: kworker/u32:5 Tainted: G S          =
       6.9.0-rc1-next-20240328-g955237c9980c #1
> [    6.597715] Hardware name: AYN Odin 2 (DT)
> [    6.597716] Workqueue: async async_run_entry_fn
> [    6.597718] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [    6.597719] pc : proc_register+0x138/0x1d0
> [    6.597721] lr : proc_register+0x138/0x1d0
> [    6.597723] sp : ffff800081e3b9a0
> [    6.597723] x29: ffff800081e3b9a0 x28: 0000000000000000 x27: ffffddb2a=
28eabe0
> [    6.597725] x26: ffff3425c9ada5c0 x25: ffffddb2a2d4eef0 x24: ffff3425c=
9ada540
> [    6.597726] x23: 0000000000000004 x22: ffff3425c7b1822c x21: 000000000=
0000004
> [    6.597727] x20: ffff3425c7b18180 x19: ffff3425c9adaec8 x18: fffffffff=
fffffff
> [    6.597729] x17: 3040636f732f6d72 x16: 6f6674616c702f73 x15: ffff80008=
1e3b910
> [    6.597730] x14: 0000000000000000 x13: 0a64657265747369 x12: 676572207=
9646165
> [    6.597731] x11: fffffffffff00000 x10: ffffddb2a27c4fb0 x9 : ffffddb29=
f5d7528
> [    6.597733] x8 : 00000000ffff7fff x7 : ffffddb2a27c4fb0 x6 : 80000000f=
fff8000
> [    6.597734] x5 : 0000000000000358 x4 : 0000000000000000 x3 : 00000000f=
fffffff
> [    6.597736] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff3425c=
5ce0000
> [    6.597737] Call trace:
> [    6.597737]  proc_register+0x138/0x1d0
> [    6.597739]  proc_create_data+0x48/0x78
> [    6.597741]  pci_proc_attach_device+0x84/0x118
> [    6.597743]  pci_bus_add_device+0x5c/0x138
> [    6.597744]  pci_bus_add_devices+0x40/0x98
> [    6.597745]  pci_host_probe+0x70/0xf0
> [    6.597746]  dw_pcie_host_init+0x248/0x658
> [    6.597748]  qcom_pcie_probe+0x234/0x330
> [    6.597749]  platform_probe+0x70/0xd8
> [    6.597750]  really_probe+0xc8/0x3a0
> [    6.597751]  __driver_probe_device+0x84/0x170
> [    6.597752]  driver_probe_device+0x44/0x120
> [    6.597753]  __device_attach_driver+0xc4/0x168
> [    6.597754]  bus_for_each_drv+0x8c/0xf0
> [    6.597756]  __device_attach_async_helper+0xb4/0x118
> [    6.597757]  async_run_entry_fn+0x40/0x178
> [    6.597759]  process_one_work+0x16c/0x410
> [    6.597760]  worker_thread+0x284/0x3a0
> [    6.597761]  kthread+0x118/0x128
> [    6.597762]  ret_from_fork+0x10/0x20
> [    6.597763] ---[ end trace 0000000000000000 ]---
>
> This probably only occurs when the relevant drivers on compiled as built-=
in.
> Similar behavior has been noticed before as well:
>
> https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/#mdee=
ca9bc8e19458787d53738298abcfff443068a
>
> Thanks,
> Xilin
>

Thanks for the report. The reason for this was populating the platform
devices before the bridge device was fully added. In case of loadable
modules this meant the pwrctl probe would be deferred long enough for
that to complete so I didn't see it but with pwrctl built-in this
would trigger the problem. I fixed it locally and will resend with
that addressed.

Bart

