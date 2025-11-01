Return-Path: <linux-pci+bounces-40010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 314E3C27C9E
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 12:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A3BC34A8FA
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B16129B217;
	Sat,  1 Nov 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcHjwK2P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F4F26ED58
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761995987; cv=none; b=GRAVViECTqEqwlW5/Js6iHxjKbubZo0m3T9XtFm+VTS18eZ0U0oAMNNGtUOQ2l0eL27CVLEApOXaSZngaVquID414IFvW4YMqJtjDYudZsR9fR8lHooYSp3b0qxZLc2+h/9miprqOvVGUqYDcgAB8+uJqHe+rWssYyktS9B9m/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761995987; c=relaxed/simple;
	bh=XsoXTmpAkK0IC/tFVkUo8vTWFMZmLGSAwPHjrFQDMQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSO7ltuR6cKvQDGlAaA4VFRA0YRnZEpDDk89Qz/Ybq5A2BBZpSbNoV2kjh0U1o07IYZHroJ66F7ZHwFb9npyWDmFJ5R1AMCVIwdHIghm4WcM3rXxIV18kayE/5dZ0aDvBfLFcmxHRLtgV5F4JjZB22hSLVCYzdEV3Uzygh6r3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcHjwK2P; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso5630027a12.1
        for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761995983; x=1762600783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VA9/GYZqPtmMozVN89uR4Q0aoS5m99Ji3OBPgu1mZyE=;
        b=kcHjwK2PaMoKKVW20qyDWew3UDxdeivvtVquRaWWeRKoskzbLpLV1H+LCPRS5w07vc
         w/UQIm0w++hetfEZOlSMSyJreGhztGbHMc3nM7qWSLQhFbx8E3wAChfhvew+vqeP0Xme
         JJiFCNYoS6wP2OTcFl6/UWdGVesv1nxDzpI5E0CgNn3eEGUu8EoXySCWYjo2nyglg22S
         JuNr+DdtL0HWE+phr8G/YIamySO1+b4FA90e9fhRPcwLFtAzew4VQ+yxP9ny8JUt9XsK
         PWxjVRzDMs8x+uNq+KAhC6hhu0um3A6MvNI6KqVTVhPufdoBccBPriZmr+n3dVDz/o9E
         yfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761995983; x=1762600783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VA9/GYZqPtmMozVN89uR4Q0aoS5m99Ji3OBPgu1mZyE=;
        b=XS2+H7WlgcLgHp5lIi8RJxFzSd2MoBL69PW6dd9JOMtMRztcEZbZofSjnfsEHa84IR
         oMW5mjskoPxpF+weXXueRoBjAH5FPFeCTcnNmFzAu2GQMlZvjB4eNdkWC80GapIr0Jfg
         q2hyqYN2JUd3rs5dNb325M9qrwMsmRHEtc7QZ+pmbMY6hRTW9frAElHydYgonHfPTwF4
         h70ijHkxEPkAy6376NumHwzduvWKzJw8Su6V6PlVY4LtYNjPigS3UTAnj/CGTn2tqiNi
         SMnJUe/OG32HXhSNmOaaLb9y2TGiks06wOGemoxoCnTkr3RA9p4D6B1doFbxCxd6POEa
         46Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWAN3Vv/zFYCEaf+tymPEbr6Cxypvb0lWJZ2rFB0F/tElX/Mlc71hKEo3krgd9cdoESo0D2Ktroa6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DBXZHmNvQMeaCKwn1/9jLDw2SzLT+YBgGhCTZEyvQD2e/BSm
	qm9/JpEm6w98y6b2zN6BxiKNOSH4h7wctaEtSC0JwTpi4e5RuKHEF3VcO2rM7SAbTJSZUEetgda
	sn2xKKrdsf4WZdLgxDdKx1vDxP3CMwoQ=
X-Gm-Gg: ASbGnctdEvkPjPOP/Ip6aaq7hEcnYHUfFtUojhjs9FoOKQh4prix8uCbCKiR1/nFumD
	1iEA0IDn0M7UEMNxcWDPX4E5Dn5Q8m+YAlXEJOBcISc2xgWbrk9V3h8crnVAhDm9MlneKTEVSq6
	gz2Ji0ZWFIQ09mhCb3GKQ7zO3DCe23/7OguiQPd6L5ePm2gKZsUwo+hr5TgzDTrzJ4J44sJu/Z9
	uYdLiXKZgMdUp+7rHwyNmMVB2VI3VHYx1SFyc29tY3+MPPFg/343lwgCYBX5IQ5DnlhrA==
X-Google-Smtp-Source: AGHT+IEQEHTI7whxk9fnli4P3xU5KyTR7FJHxqf2wRSXKBIIgvmPQ5NPDMPaydsHGdsnaMf8venN81CtsI73mU47/Pw=
X-Received: by 2002:a05:6402:210b:b0:640:9997:a229 with SMTP id
 4fb4d7f45d1cf-6409997ae92mr1067104a12.3.1761995983045; Sat, 01 Nov 2025
 04:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 1 Nov 2025 16:49:25 +0530
X-Gm-Features: AWmQ_bmpT_2mcSjzejdSRAZS_z3Z3YCstTId1JiavKjLthWXyNA8r6zVYPZ7wSg
Message-ID: <CANAwSgTMc=FcOi4=vPCUytMMg5dZO7QU4m6D=6V8RZ9hSDxn4A@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] PCI: dw-rockchip: add system suspend support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jingoo Han <jingoohan1@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian,

On Wed, 29 Oct 2025 at 23:27, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> I've recently been working on fixing up at least basic system suspend
> support on the Rockchip RK3576 platform. Currently the biggest open
> issue is missing support in the PCIe driver. This series is a follow-up
> for Shawn Lin's series with feedback from Niklas Cassel and Manivannan
> Sadhasivam being handled as well as some of my own changes fixing up
> things I noticed.
>
> In opposite to Shawn Lin I did not test with different peripherals as my
> main goal is getting basic suspend to ram working in the first place. I
> did notice issues with the Broadcom WLAN card on the RK3576 EVB.
> Suspending that platform without a driver being probed works, but after
> probing brcmfmac suspend is aborted because brcmf_pcie_pm_enter_D3()
> does not work. As far as I can tell the problem is unrelated to the
> Rockchip PCIe driver.
>
Well, I gave it a try on Radxa Rock 5b,
I am observing the falling warning.

PM: noirq suspend of devices failed

alarm@rockpi-5b:~$ sudo systemctl suspend
[sudo] password for alarm:
alarm@rockpi-5b:~$ [  459.301536][ T6149] wlan0: deauthenticating from
78:d2:94:85:bb:b2 by local choice (Reason: 3=DEAUTH_LEAVING)
[  459.383823][ T6056] r8169 0004:41:00.0 enP4p65s0: Link is Down
[  459.384568][ T6056] r8169 0004:41:00.0: disabling bus mastering
[  459.862229][ T6291] PM: suspend entry (deep)
[  459.935040][ T6291] Filesystems sync: 0.072 seconds
[  459.941444][ T6253] (NULL device *): loading
/lib/firmware/6.18.0-rc3-3-ARM64-GCC/intel/ibt-12-16.sfi failed with
error -20
[  459.943775][ T6253] (NULL device *): loading
/lib/firmware/6.18.0-rc3-3-ARM64-GCC/intel/ibt-12-16.ddc failed with
error -20
[  459.945047][   T59] (NULL device *): loading
/lib/firmware/6.18.0-rc3-3-ARM64-GCC/arm/mali/arch10.8/mali_csffw.bin
failed with error -20
[  459.946854][ T6253] (NULL device *): loading
/lib/firmware/6.18.0-rc3-3-ARM64-GCC/iwlwifi-8265-36.ucode failed with
error -20
[  459.953052][ T6291] Freezing user space processes
[  460.001306][ T6291] Freezing user space processes completed
(elapsed 0.047 seconds)
[  460.001993][ T6291] OOM killer disabled.
[  460.002341][ T6291] Freezing remaining freezable tasks
[  460.004202][ T6291] Freezing remaining freezable tasks completed
(elapsed 0.001 seconds)
[  460.004953][ T6291] printk: Suspending console(s) (use
no_console_suspend to debug)
[  460.070242][ T6253] nvme 0000:01:00.0: save config 0x00: 0xa808144d
[  460.070261][ T6253] nvme 0000:01:00.0: save config 0x04: 0x00100406
[  460.070272][ T6253] nvme 0000:01:00.0: save config 0x08: 0x01080200
[  460.070281][ T6253] nvme 0000:01:00.0: save config 0x0c: 0x00000000
[  460.070291][ T6253] nvme 0000:01:00.0: save config 0x10: 0xf0200004
[  460.070300][ T6253] nvme 0000:01:00.0: save config 0x14: 0x00000000
[  460.070309][ T6253] nvme 0000:01:00.0: save config 0x18: 0x00000000
[  460.070319][ T6253] nvme 0000:01:00.0: save config 0x1c: 0x00000000
[  460.070328][ T6253] nvme 0000:01:00.0: save config 0x20: 0x00000000
[  460.070337][ T6253] nvme 0000:01:00.0: save config 0x24: 0x00000000
[  460.070346][ T6253] nvme 0000:01:00.0: save config 0x28: 0x00000000
[  460.070355][ T6253] nvme 0000:01:00.0: save config 0x2c: 0xa801144d
[  460.070364][ T6253] nvme 0000:01:00.0: save config 0x30: 0x00000000
[  460.070373][ T6253] nvme 0000:01:00.0: save config 0x34: 0x00000040
[  460.070383][ T6253] nvme 0000:01:00.0: save config 0x38: 0x00000000
[  460.070392][ T6253] nvme 0000:01:00.0: save config 0x3c: 0x0000016d
[  460.274027][ T6253] iwlwifi 0002:21:00.0: save config 0x00: 0x24fd8086
[  460.274058][ T6253] iwlwifi 0002:21:00.0: save config 0x04: 0x00100406
[  460.274080][ T6253] iwlwifi 0002:21:00.0: save config 0x08: 0x02800078
[  460.274102][ T6253] iwlwifi 0002:21:00.0: save config 0x0c: 0x00000000
[  460.274124][ T6253] iwlwifi 0002:21:00.0: save config 0x10: 0xf2200004
[  460.274146][ T6253] iwlwifi 0002:21:00.0: save config 0x14: 0x00000000
[  460.274168][ T6253] iwlwifi 0002:21:00.0: save config 0x18: 0x00000000
[  460.274189][ T6253] iwlwifi 0002:21:00.0: save config 0x1c: 0x00000000
[  460.274210][ T6253] iwlwifi 0002:21:00.0: save config 0x20: 0x00000000
[  460.274232][ T6253] iwlwifi 0002:21:00.0: save config 0x24: 0x00000000
[  460.274253][ T6253] iwlwifi 0002:21:00.0: save config 0x28: 0x00000000
[  460.274275][ T6253] iwlwifi 0002:21:00.0: save config 0x2c: 0x10108086
[  460.274296][ T6253] iwlwifi 0002:21:00.0: save config 0x30: 0x00000000
[  460.274318][ T6253] iwlwifi 0002:21:00.0: save config 0x34: 0x000000c8
[  460.274340][ T6253] iwlwifi 0002:21:00.0: save config 0x38: 0x00000000
[  460.274361][ T6253] iwlwifi 0002:21:00.0: save config 0x3c: 0x00000183
[  460.274917][ T6300] r8169 0004:41:00.0: save config 0x00: 0x812510ec
[  460.274927][ T6300] r8169 0004:41:00.0: save config 0x04: 0x00100403
[  460.274937][ T6300] r8169 0004:41:00.0: save config 0x08: 0x02000005
[  460.274947][ T6300] r8169 0004:41:00.0: save config 0x0c: 0x00000010
[  460.274957][ T6300] r8169 0004:41:00.0: save config 0x10: 0xf4100001
[  460.274967][ T6300] r8169 0004:41:00.0: save config 0x14: 0x00000000
[  460.274977][ T6300] r8169 0004:41:00.0: save config 0x18: 0xf4200004
[  460.274987][ T6300] r8169 0004:41:00.0: save config 0x1c: 0x00000000
[  460.274996][ T6300] r8169 0004:41:00.0: save config 0x20: 0xf4210004
[  460.275006][ T6300] r8169 0004:41:00.0: save config 0x24: 0x00000000
[  460.275016][ T6300] r8169 0004:41:00.0: save config 0x28: 0x00000000
[  460.275026][ T6300] r8169 0004:41:00.0: save config 0x2c: 0x012310ec
[  460.275036][ T6300] r8169 0004:41:00.0: save config 0x30: 0x00000000
[  460.275045][ T6300] r8169 0004:41:00.0: save config 0x34: 0x00000040
[  460.275055][ T6300] r8169 0004:41:00.0: save config 0x38: 0x00000000
[  460.275065][ T6300] r8169 0004:41:00.0: save config 0x3c: 0x00000197
[  460.285117][ T6253] iwlwifi 0002:21:00.0: PCI PM: Suspend power state: D3hot
[  460.287498][ T6300] r8169 0004:41:00.0: PCI PM: Suspend power state: D3hot
[  460.287631][ T6296] pcieport 0004:40:00.0: save config 0x00: 0x35881d87
[  460.287644][ T6296] pcieport 0004:40:00.0: save config 0x04: 0x00100507
[  460.287651][ T6296] pcieport 0004:40:00.0: save config 0x08: 0x06040001
[  460.287658][ T6296] pcieport 0004:40:00.0: save config 0x0c: 0x00010000
[  460.287664][ T6296] pcieport 0004:40:00.0: save config 0x10: 0x00000000
[  460.287671][ T6296] pcieport 0004:40:00.0: save config 0x14: 0x00000000
[  460.287677][ T6296] pcieport 0004:40:00.0: save config 0x18: 0x00414140
[  460.287683][ T6296] pcieport 0004:40:00.0: save config 0x1c: 0x00000000
[  460.287689][ T6296] pcieport 0004:40:00.0: save config 0x20: 0xf420f420
[  460.287696][ T6296] pcieport 0004:40:00.0: save config 0x24: 0x0001fff1
[  460.287702][ T6296] pcieport 0004:40:00.0: save config 0x28: 0x00000000
[  460.287708][ T6296] pcieport 0004:40:00.0: save config 0x2c: 0x00000000
[  460.287714][ T6296] pcieport 0004:40:00.0: save config 0x30: 0x00000000
[  460.287720][ T6296] pcieport 0004:40:00.0: save config 0x34: 0x00000040
[  460.287727][ T6296] pcieport 0004:40:00.0: save config 0x38: 0x00000000
[  460.287733][ T6296] pcieport 0004:40:00.0: save config 0x3c: 0x00020197
[  460.299895][ T6296] pcieport 0004:40:00.0: PCI PM: Suspend power state: D3hot
[  460.311927][ T6291] rockchip-dw-pcie a41000000.pcie: Timeout
waiting for L2 entry! LTSSM: 0x12
[  460.311935][ T6291] rockchip-dw-pcie a41000000.pcie: PM:
dpm_run_callback(): genpd_suspend_noirq returns -110
[  460.311950][ T6291] rockchip-dw-pcie a41000000.pcie: PM: failed to
suspend noirq: error -110
[  460.328691][   T57] pcieport 0004:40:00.0: restore config 0x2c:
0x00000000 -> 0x00000000
[  460.328706][   T57] pcieport 0004:40:00.0: restore config 0x28:
0x00000000 -> 0x00000000
[  460.328714][   T57] pcieport 0004:40:00.0: restore config 0x24:
0x0001fff1 -> 0x0001fff1
[  460.329363][ T6299] iwlwifi 0002:21:00.0: restore config 0x3c:
0x00000100 -> 0x00000183
[  460.329558][ T6299] iwlwifi 0002:21:00.0: restore config 0x10:
0x00000004 -> 0xf2200004
[  460.329643][ T6299] iwlwifi 0002:21:00.0: restore config 0x04:
0x00100000 -> 0x00100406
[  460.341978][ T6291] PM: noirq suspend of devices failed
[  460.352925][ T6303] xhci-hcd xhci-hcd.7.auto: xHC error in resume,
USBSTS 0x401, Reinit
[  460.352937][ T6303] usb usb5: root hub lost power or was reset
[  460.352941][ T6303] usb usb6: root hub lost power or was reset
[  460.517043][   T56] xhci-hcd xhci-hcd.8.auto: xHC error in resume,
USBSTS 0x401, Reinit
[  460.517056][   T56] usb usb7: root hub lost power or was reset
[  460.517060][   T56] usb usb8: root hub lost power or was reset
[  460.833660][ T6291] OOM killer enabled.
[  460.834002][ T6291] Restarting tasks: Starting
[  460.835432][ T6291] Restarting tasks: Done
[  460.835846][ T6291] random: crng reseeded on system resumption
[  460.837377][ T6291] PM: suspend exit
[  460.838167][ T6291] PM: suspend entry (s2idle)
[  460.976541][ T6291] Filesystems sync: 0.138 seconds
[  460.978668][ T6291] Freezing user space processes
[  460.980928][ T6291] Freezing user space processes completed
(elapsed 0.001 seconds)
[  460.981607][ T6291] OOM killer disabled.
[  460.981954][ T6291] Freezing remaining freezable tasks
[  460.997394][ T6291] Freezing remaining freezable tasks completed
(elapsed 0.014 seconds)
[  460.998116][ T6291] printk: Suspending console(s) (use
no_console_suspend to debug)
[  461.041501][ T6299] nvme 0000:01:00.0: save config 0x00: 0xa808144d
[  461.041520][ T6299] nvme 0000:01:00.0: save config 0x04: 0x00100406
[  461.041530][ T6299] nvme 0000:01:00.0: save config 0x08: 0x01080200
[  461.041540][ T6299] nvme 0000:01:00.0: save config 0x0c: 0x00000000
[  461.041549][ T6299] nvme 0000:01:00.0: save config 0x10: 0xf0200004
[  461.041559][ T6299] nvme 0000:01:00.0: save config 0x14: 0x00000000
[  461.041568][ T6299] nvme 0000:01:00.0: save config 0x18: 0x00000000
[  461.041577][ T6299] nvme 0000:01:00.0: save config 0x1c: 0x00000000
[  461.041586][ T6299] nvme 0000:01:00.0: save config 0x20: 0x00000000
[  461.041595][ T6299] nvme 0000:01:00.0: save config 0x24: 0x00000000
[  461.041604][ T6299] nvme 0000:01:00.0: save config 0x28: 0x00000000
[  461.041613][ T6299] nvme 0000:01:00.0: save config 0x2c: 0xa801144d
[  461.041622][ T6299] nvme 0000:01:00.0: save config 0x30: 0x00000000
[  461.041632][ T6299] nvme 0000:01:00.0: save config 0x34: 0x00000040
[  461.041641][ T6299] nvme 0000:01:00.0: save config 0x38: 0x00000000
[  461.041650][ T6299] nvme 0000:01:00.0: save config 0x3c: 0x0000016d
[  461.211199][ T6307] r8169 0004:41:00.0: save config 0x00: 0x812510ec
[  461.211220][ T6307] r8169 0004:41:00.0: save config 0x04: 0x00100403
[  461.211233][ T6307] r8169 0004:41:00.0: save config 0x08: 0x02000005
[  461.211246][ T6307] r8169 0004:41:00.0: save config 0x0c: 0x00000010
[  461.211257][ T6307] r8169 0004:41:00.0: save config 0x10: 0xf4100001
[  461.211269][ T6307] r8169 0004:41:00.0: save config 0x14: 0x00000000
[  461.211294][ T6297] iwlwifi 0002:21:00.0: save config 0x00: 0x24fd8086
[  461.211298][ T6307] r8169 0004:41:00.0: save config 0x18: 0xf4200004
[  461.211311][ T6307] r8169 0004:41:00.0: save config 0x1c: 0x00000000
[  461.211327][ T6297] iwlwifi 0002:21:00.0: save config 0x04: 0x00100406
[  461.211333][ T6307] r8169 0004:41:00.0: save config 0x20: 0xf4210004
[  461.211350][ T6297] iwlwifi 0002:21:00.0: save config 0x08: 0x02800078
[  461.211355][ T6307] r8169 0004:41:00.0: save config 0x24: 0x00000000
[  461.211372][ T6297] iwlwifi 0002:21:00.0: save config 0x0c: 0x00000000
[  461.211379][ T6307] r8169 0004:41:00.0: save config 0x28: 0x00000000
[  461.211395][ T6297] iwlwifi 0002:21:00.0: save config 0x10: 0xf2200004
[  461.211401][ T6307] r8169 0004:41:00.0: save config 0x2c: 0x012310ec
[  461.211417][ T6297] iwlwifi 0002:21:00.0: save config 0x14: 0x00000000
[  461.211421][ T6307] r8169 0004:41:00.0: save config 0x30: 0x00000000
[  461.211439][ T6297] iwlwifi 0002:21:00.0: save config 0x18: 0x00000000
[  461.211445][ T6307] r8169 0004:41:00.0: save config 0x34: 0x00000040
[  461.211461][ T6297] iwlwifi 0002:21:00.0: save config 0x1c: 0x00000000
[  461.211468][ T6307] r8169 0004:41:00.0: save config 0x38: 0x00000000
[  461.211483][ T6297] iwlwifi 0002:21:00.0: save config 0x20: 0x00000000
[  461.211487][ T6307] r8169 0004:41:00.0: save config 0x3c: 0x00000197
[  461.211505][ T6297] iwlwifi 0002:21:00.0: save config 0x24: 0x00000000
[  461.211527][ T6297] iwlwifi 0002:21:00.0: save config 0x28: 0x00000000
[  461.211550][ T6297] iwlwifi 0002:21:00.0: save config 0x2c: 0x10108086
[  461.211574][ T6297] iwlwifi 0002:21:00.0: save config 0x30: 0x00000000
[  461.211596][ T6297] iwlwifi 0002:21:00.0: save config 0x34: 0x000000c8
[  461.211618][ T6297] iwlwifi 0002:21:00.0: save config 0x38: 0x00000000
[  461.211644][ T6297] iwlwifi 0002:21:00.0: save config 0x3c: 0x00000183
[  461.224517][ T6297] iwlwifi 0002:21:00.0: PCI PM: Suspend power state: D3hot
[  461.224566][ T6307] r8169 0004:41:00.0: PCI PM: Suspend power state: D3hot
[  461.224614][ T6299] pcieport 0004:40:00.0: save config 0x00: 0x35881d87
[  461.224622][ T6299] pcieport 0004:40:00.0: save config 0x04: 0x00100507
[  461.224629][ T6299] pcieport 0004:40:00.0: save config 0x08: 0x06040001
[  461.224636][ T6299] pcieport 0004:40:00.0: save config 0x0c: 0x00010000
[  461.224642][ T6299] pcieport 0004:40:00.0: save config 0x10: 0x00000000
[  461.224649][ T6299] pcieport 0004:40:00.0: save config 0x14: 0x00000000
[  461.224655][ T6299] pcieport 0004:40:00.0: save config 0x18: 0x00414140
[  461.224661][ T6299] pcieport 0004:40:00.0: save config 0x1c: 0x00000000
[  461.224667][ T6299] pcieport 0004:40:00.0: save config 0x20: 0xf420f420
[  461.224673][ T6299] pcieport 0004:40:00.0: save config 0x24: 0x0001fff1
[  461.224680][ T6299] pcieport 0004:40:00.0: save config 0x28: 0x00000000
[  461.224686][ T6299] pcieport 0004:40:00.0: save config 0x2c: 0x00000000
[  461.224692][ T6299] pcieport 0004:40:00.0: save config 0x30: 0x00000000
[  461.224698][ T6299] pcieport 0004:40:00.0: save config 0x34: 0x00000040
[  461.224705][ T6299] pcieport 0004:40:00.0: save config 0x38: 0x00000000
[  461.224711][ T6299] pcieport 0004:40:00.0: save config 0x3c: 0x00020197
[  461.236873][ T6299] pcieport 0004:40:00.0: PCI PM: Suspend power state: D3hot
[  461.247945][ T6291] rockchip-dw-pcie a41000000.pcie: Failed to
receive PME_TO_Ack
[  461.258929][ T6291] rockchip-dw-pcie a41000000.pcie: Timeout
waiting for L2 entry! LTSSM: 0x12
[  461.258937][ T6291] rockchip-dw-pcie a41000000.pcie: PM:
dpm_run_callback(): genpd_suspend_noirq returns -110
[  461.258952][ T6291] rockchip-dw-pcie a41000000.pcie: PM: failed to
suspend noirq: error -110
[  461.276608][ T6303] iwlwifi 0002:21:00.0: restore config 0x3c:
0x00000100 -> 0x00000183
[  461.276655][ T6302] pcieport 0004:40:00.0: restore config 0x2c:
0x00000000 -> 0x00000000
[  461.276683][ T6302] pcieport 0004:40:00.0: restore config 0x28:
0x00000000 -> 0x00000000
[  461.276714][ T6302] pcieport 0004:40:00.0: restore config 0x24:
0x0001fff1 -> 0x0001fff1
[  461.276805][ T6303] iwlwifi 0002:21:00.0: restore config 0x10:
0x00000004 -> 0xf2200004
[  461.276908][ T6303] iwlwifi 0002:21:00.0: restore config 0x04:
0x00100000 -> 0x00100406
[  461.289977][ T6291] PM: noirq suspend of devices failed
[  461.302571][ T6298] xhci-hcd xhci-hcd.7.auto: xHC error in resume,
USBSTS 0x401, Reinit
[  461.302581][ T6298] usb usb5: root hub lost power or was reset
[  461.302585][ T6298] usb usb6: root hub lost power or was reset
[  461.425101][ T6307] xhci-hcd xhci-hcd.8.auto: xHC error in resume,
USBSTS 0x401, Reinit
[  461.425111][ T6307] usb usb7: root hub lost power or was reset
[  461.425115][ T6307] usb usb8: root hub lost power or was reset
[  461.746324][ T6291] OOM killer enabled.
[  461.746666][ T6291] Restarting tasks: Starting
[  461.748345][ T6291] Restarting tasks: Done
[  461.748757][ T6291] random: crng reseeded on system resumption
[  461.749533][ T6291] PM: suspend exit
[  461.809104][ T6056] Realtek Internal NBASE-T PHY r8169-4-4100:00:
attached PHY driver (mii_bus:phy_addr=r8169-4-4100:00, irq=MAC)
[  461.810148][ T6056] r8169 0004:41:00.0: enabling bus mastering
[  461.989335][ T6298] r8169 0004:41:00.0 enP4p65s0: Link is Down
[  464.915207][ T6311] r8169 0004:41:00.0 enP4p65s0: Link is Up -
1Gbps/Full - flow control rx/tx
[  465.527599][ T6149] wlan0: authenticate with 78:d2:94:85:bb:b2
(local address=a4:6b:b6:06:5c:8e)
[  465.529749][ T6149] wlan0: send auth to 78:d2:94:85:bb:b2 (try 1/3)
[  465.543850][ T6298] wlan0: authenticated
[  465.545190][ T6298] wlan0: associate with 78:d2:94:85:bb:b2 (try 1/3)
[  465.555534][ T6298] wlan0: RX AssocResp from 78:d2:94:85:bb:b2
(capab=0x31 status=0 aid=1)
[  465.560431][ T6298] wlan0: associated

Thanks
-Anand

> Changes since PATCHv3:
>  * https://lore.kernel.org/linux-pci/1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com/
>  * rename rockchip_pcie_get_ltssm to rockchip_pcie_get_ltssm_status_reg
>    in a separate patch (Niklas Cassel)
>  * rename rockchip_pcie_get_pure_ltssm to rockchip_pcie_get_ltssm_state
>    in a separate patch (Niklas Cassel)
>  * Move devm_phy_get out of phy_init to probe in a separate patch
>    (Manivannan Sadhasivam)
>  * Add helper function for enhanced LTSSM control mode in a separate patch
>    (Niklas Cassel)
>  * Add helper function for controller mode in a separate patch
>    (Niklas Cassel)
>  * Add helper function for DDL indicator in a separate patch
>    (Niklas Cassel)
>  * Move rockchip_pcie_pme_turn_off implementation in a separate patch
>  * Rebase to v6.18-rc3 using new FIELD_PREP_WM16()
>  * Improve readability of PME_TURN_OFF/PME_TO_ACK defines (Manivannan Sadhasivam)
>  * Fix usage of reverse Xmas (Manivannan Sadhasivam)
>  * Assert PERST# before turning off other resources (Manivannan Sadhasivam)
>  * Improve some error messages (Manivannan Sadhasivam)
>  * Rename goto labels as per their purpose (Manivannan Sadhasivam)
>  * Add extra patch for dw_pcie_resume_noirq, since I've seen errors
>    during resume on boards not having anything plugged into their PCIe
>    port
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Sebastian Reichel (9):
>       PCI: dw-rockchip: Rename rockchip_pcie_get_ltssm function
>       PCI: dw-rockchip: Support get_ltssm operation
>       PCI: dw-rockchip: Move devm_phy_get out of phy_init
>       PCI: dw-rockchip: Add helper function for enhanced LTSSM control mode
>       PCI: dw-rockchip: Add helper function for controller mode
>       PCI: dw-rockchip: Add helper function for DDL indicator
>       PCI: dw-rockchip: Add pme_turn_off support
>       PCI: dw-rockchip: Add system PM support
>       PCI: dwc: support missing PCIe device on resume
>
>  drivers/pci/controller/dwc/pcie-designware-host.c |  13 +-
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c     | 220 ++++++++++++++++++----
>  2 files changed, 198 insertions(+), 35 deletions(-)
> ---
> base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
> change-id: 20251028-rockchip-pcie-system-suspend-86cf08a7b229
>
> Best regards,
> --
> Sebastian Reichel <sebastian.reichel@collabora.com>
>
>

