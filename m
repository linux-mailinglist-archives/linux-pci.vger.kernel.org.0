Return-Path: <linux-pci+bounces-39936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A21EC257C0
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 15:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7230D467242
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B673A221FB6;
	Fri, 31 Oct 2025 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+HIh9uA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D921FF25
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919423; cv=none; b=Y8I18QL6fYrw81o60dgIYl4JocwAV71+2EX8HY+6VxAVdbRVOem0dk76Rgp/JTvp1iIWevzFzHgRDdGIdKt0euBSGXl4/mMDYW6xwjL9DrokfR8GdNLDG6hf0oGAMirotFvNY2hKdj/2qAxTVDhK//ZtCzuyTMjVqCPnJByblvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919423; c=relaxed/simple;
	bh=hU03scWT2TBWEDpj0udnvu7A8uCjKH3s5GuOe7329so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJOGuKc5/Y7yNkGNiUjg3YMHYIJPRy0oQKinpJsm31hLNPhCex6ev8hcBJSTm4CrHfKMtm42hpaT+aAE+E6GKC10DVE8t21GvUxAPvKs/V4sCF/daRmhvd8HAw2YbrLZ1I/3jflLQDGFUGzKAt4KXHcIvrKA6m61ugsCnk0l3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+HIh9uA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64080ccf7e4so635445a12.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761919420; x=1762524220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj8s1wnUATyl/Io36KEtToNI7y6NAciHE7SXMDsNhyY=;
        b=j+HIh9uA281eXI2DX08iiSA4NoYh2x2UjL1oRCXnrEuM3C2zf40jUrcKBEoknKkJzH
         rYMaEINecY9453MdY5cnctn8yh+kK3Z9g/4s367QoANsSzlRuXo5YoHJTffHjr5sZpU2
         z+dte5kXnbuJmjjjwS3DMhNHthnzzGC79TVguAA3i+l+cfVXkamvaxw6TJzFA5fdPhu9
         I8KcZ6HIt8lJu0k3AmxaZZOuTnQ+MCZTS3NaNFTeWCqKokQHPCaRwEnyoxNF6FbAot95
         cfFlR+B23cwx15vmfru3QSE304fKjqQdVqE3jjFO3S5V+AKU7hlFVGDjjXGPK7LrJ1ey
         K/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761919420; x=1762524220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rj8s1wnUATyl/Io36KEtToNI7y6NAciHE7SXMDsNhyY=;
        b=F7Tht+ZdqRCswmMyPIWwBIq1PcUYWRwPxIecSqB7pAQT/MW15AAKf7DrFTsvtGE7u4
         BgVfxfUXNmkJMpNO9j8GDjOHrnsJtEae526k1wK3XmD33ZQSIiZXw/0kp8FsarHbtjTX
         z31VDxHgNjBokvSyTRSHV8dTNrtZsTSPCZHc2Az4Ev0DbmS6c8pPPPAALjzvE9F4wnsx
         TLC6JjfcVcdbYf00Nsw3Y7gv+pz8Yl/Qt0c3fb6lE5lzzhApklRDiaQcwA1kg/ketK0p
         CF4vV5hxKXZ906siDI+uySX/8Te5+g4zcLhYZN1T0lFWZWLV42wBOLFPzMkq/63+aCNN
         R2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxkdNUGRoYImYOJWft8zpPiZDd9pGKeHIwodjVagyvGWO4cpg2z2i+xDjf0a/rvD4SZFQyb5vRP1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1+7rIRMiy7LvD8D9EZ3rvVTEPicywAHXfMiPHn++rAA08SxA
	BGRpOyKKu4c7iypDyThLvmlA8DANgKwW3EsHCcFLNI2TmndbaVCu1cmNZ8QMoaWBcwnDf0gQbaV
	NLeomELGZAHs4iEqhfmhaEO0Lhxtje6k=
X-Gm-Gg: ASbGncv8E5O54obEhyokU0Jr8a5HsjxyB3Ielugf8dscEUeKNn8a+PP6upayvk7oz/h
	UOxQSiuMlFnaoOOn7gCky2JDje8sV9rmmkL316+7tgygL4B+Z+s7IS32szk5ZvYWiYIq2DlZ4gE
	JXK1iXTJSj4nWuHu3YNzVOjMhYI1EMLengAHMuuipBsM9MV2tlgzNy7/hcHdIJqhIXSt0v3/blM
	y69dDpPh141RQmspIIX9b5U2pghHJkxwwLAeBemWEO5JsBJno3WmAYXbBg=
X-Google-Smtp-Source: AGHT+IFFEnMjDFLH3xr8fEIyqOPBV7EY4VCIK4pS6uE8BEVFtTPJxx3MWiLabn3HLkuRrI1ocxVTpieowo++InLDHHw=
X-Received: by 2002:a05:6402:1e90:b0:639:fca4:c471 with SMTP id
 4fb4d7f45d1cf-6407704da9fmr2381667a12.28.1761919419979; Fri, 31 Oct 2025
 07:03:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027145602.199154-1-linux.amoon@gmail.com>
 <20251027145602.199154-3-linux.amoon@gmail.com> <ukgkfetbggzon4ppndl7gpitlsz7hjhzhyx3dgxqhdo52exguy@bqksd7d27lpy>
In-Reply-To: <ukgkfetbggzon4ppndl7gpitlsz7hjhzhyx3dgxqhdo52exguy@bqksd7d27lpy>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 31 Oct 2025 19:33:23 +0530
X-Gm-Features: AWmQ_bk2RE7HwEI0_pE9LFbkkRWOVq0EH46VuMrlsLHx-lzP_lVcojMP9zLP-UY
Message-ID: <CANAwSgTECOAoKeJS_=HxkkTP4OJvYu5xGQxY__Auh81v3QT=-w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: dw-rockchip: Add runtime PM support to
 Rockchip PCIe driver
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Manivannan

Thanks for your review comment.

On Fri, 31 Oct 2025 at 14:09, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Mon, Oct 27, 2025 at 08:25:30PM +0530, Anand Moon wrote:
> > Add runtime power management support to the Rockchip DesignWare PCIe
> > controller driver by enabling devm_pm_runtime() in the probe function.
> > These changes allow the PCIe controller to suspend and resume dynamically,
> > improving power efficiency on supported platforms.
> >
>
> Seriously? How can this patch improve the power efficiency if it is not doing
> any PM operation on its own?
>
I could verify that runtime power management is active

[root@rockpi-5b alarm]# cat
/sys/devices/platform/a41000000.pcie/power/runtime_status
active
[root@rockpi-5b alarm]#  find /sys -name runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/pci_bus/0004:41/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00.0/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00.0/net/enP4p65s0/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00.0/net/enP4p65s0/enP4p65s0-3::lan/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00.0/net/enP4p65s0/enP4p65s0-2::lan/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00.0/net/enP4p65s0/enP4p65s0-1::lan/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00.0/net/enP4p65s0/enP4p65s0-0::lan/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00.0/mdio_bus/r8169-4-4100/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00.0/mdio_bus/r8169-4-4100/r8169-4-4100:00/power/runtime_status
/sys/devices/platform/a41000000.pcie/pci0004:40/0004:40:00.0/0004:41:00.0/mdio_bus/r8169-4-4100/r8169-4-4100:00/hwmon/hwmon11/power/runtime_status

Well, the powertop shows that the runtime power management is enabled
on Radxa Rock 5b,

PowerTOP 2.15     Overview   Idle stats   Frequency stats   Device
stats   Device Freq stats   Tunables   WakeUp
>> Good          Wireless Power Saving for interface wlan0
   Good          VM writeback timeout
   Good          Bluetooth device interface status
   Good          NMI watchdog should be turned off
   Good          Autosuspend for unknown USB device 2-1.3 (8087:0a2b)
   Good          Autosuspend for USB device USB 2.0 Hub [2-1]
   Good          Autosuspend for USB device Generic Platform OHCI
controller [usb1]
   Good          Autosuspend for USB device xHCI Host Controller [usb8]
   Good          Autosuspend for USB device Generic Platform OHCI
controller [usb4]
   Good          Autosuspend for USB device EHCI Host Controller [usb2]
   Good          Autosuspend for USB device xHCI Host Controller [usb6]
   Good          Autosuspend for USB device EHCI Host Controller [usb3]
   Good          Autosuspend for USB device xHCI Host Controller [usb5]
   Good          Autosuspend for USB device xHCI Host Controller [usb7]
   Good          Runtime PM for PCI Device Intel Corporation Wireless
8265 / 8275
   Good          Runtime PM for PCI Device Rockchip Electronics Co., Ltd RK3588
   Good          Runtime PM for PCI Device Rockchip Electronics Co., Ltd RK3588
   Good          Runtime PM for PCI Device Realtek Semiconductor Co.,
Ltd. RTL8125 2.5GbE Controller
   Good          Runtime PM for PCI Device Rockchip Electronics Co., Ltd RK3588
   Good          Runtime PM for PCI Device Samsung Electronics Co Ltd
NVMe SSD Controller SM981/PM981/PM983

PowerTOP 2.15     Overview   Idle stats   Frequency stats   Device
stats   Device Freq stats   Tunables   WakeUp
              Usage     Device name
              1.1%        CPU use
            100.0%        Radio device: rfkill_gpio
            100.0%        runtime-rockchip-gate-link-clk.712
            100.0%        PCI Device: Realtek Semiconductor Co., Ltd.
RTL8125 2.5GbE Controller
            100.0%        runtime-rockchip-gate-link-clk.717
            100.0%        runtime-rockchip-gate-link-clk.714
            100.0%        runtime-rockchip-gate-link-clk.489
            100.0%        runtime-a40000000.pcie
            100.0%        runtime-a40800000.pcie
            100.0%        runtime-rockchip-gate-link-clk.718
            100.0%        runtime-rockchip-gate-link-clk.706
            100.0%        runtime-rockchip-gate-link-clk.708
            100.0%        PCI Device: Intel Corporation Wireless 8265 / 8275
            100.0%        Radio device: btusb
            100.0%        runtime-fcd00000.usb
            100.0%        PCI Device: Samsung Electronics Co Ltd NVMe
SSD Controller SM981/PM981/PM983
            100.0%        Radio device: rfkill_gpio
            100.0%        runtime-fc000000.usb
            100.0%        Radio device: iwlwifi
            100.0%        PCI Device: Rockchip Electronics Co., Ltd RK3588
            100.0%        PCI Device: Rockchip Electronics Co., Ltd RK3588
            100.0%        PCI Device: Rockchip Electronics Co., Ltd RK3588
            100.0%        runtime-rockchip-gate-link-clk.711
            100.0%        runtime-fc400000.usb
            100.0%        runtime-rockchip-gate-link-clk.704
            100.0%        runtime-rockchip-gate-link-clk.701
            100.0%        runtime-rockchip-gate-link-clk.716
            100.0%        runtime-rockchip-gate-link-clk.707
            100.0%        runtime-rockchip-gate-link-clk.709
            100.0%        runtime-rockchip-gate-link-clk.719
            100.0%        runtime-xhci-hcd.1.auto
            100.0%        runtime-feb50000.serial
            100.0%        runtime-rockchip-gate-link-clk.715
            100.0%        runtime-rockchip-gate-link-clk.710

> Again, a pointless patch.
I implemented a .remove patch to ensure proper resource cleanup,
which is a necessary step for successfully enabling and managing
runtime power for the device.
>
> - Mani
Thanks
-Anand

