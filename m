Return-Path: <linux-pci+bounces-13841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C15990BD5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293C42813AF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BDE1E3CDD;
	Fri,  4 Oct 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5v5X70R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F581E3CB7
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066041; cv=none; b=tD7xU3/pM4xzrL+QL8KPvpYhPjRjzVtsUm+i7PFvCmxKKcz3KuywflA/55kLo8MVVLHbXHK4wBmeykq4pcDkMdaWEfHqp39nNo70zjVp22N6djcUdp/HKqtuh90cb8MfT36jty5ylb9895w2+vjtYBlYHDhdgdLR5zTccdY7HcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066041; c=relaxed/simple;
	bh=aruBzAbgGyDLvNdyYyUYUDqwXLp+aDDU7/rjdmjJPOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAQSCqB2dzzW85/WtaN9VPRk57nniuT40GF5QT48k8oYXeJAc4qaZgzBR5pd5smxzSQQfcsCMqJl1VdwCBsWgI3jTDc5pfVT1P4smU4TwntyIfZKuxXY4rkBzSfEUELn3D0jtWXwjE3tINGf7NriD1849IrippV6lkxXvxM1XI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5v5X70R; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e232e260c2so21193497b3.0
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2024 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728066039; x=1728670839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxZ9GRq9hydhmsp/AV+MwY8TnrnCoM+LlwN7QJWM4Sg=;
        b=W5v5X70RiwEb5j0gryIYLyVdPkzod05qjJQjJVcaEyb2QmX/QZQvlSW8a5S4nI29gi
         Z4smQ/gIUQkYf/FCgLjp2Rft//wAswN/JV5xxoaqDvvYZETrwp9gMhdEartiSlP4abZa
         vEI0jDKskCA8AfGrtj27svZ/vWJ9BaHOyhnB3clJ/xrKDuMC7+alRdmMDC5ZN+TarxhX
         QZDM7pHDK4rgQcFQdm62wt8UtQlkCH2B6VlC9Giow450HJi5VIAwAv8nLIH/pJNs1Db0
         pMGRd1hwHedxXWYJGVZ2AOnyeqCmqBdcWdK8qN3PpIAutrZAya/Oy5Zo02zuNbDVt/Js
         bs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728066039; x=1728670839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxZ9GRq9hydhmsp/AV+MwY8TnrnCoM+LlwN7QJWM4Sg=;
        b=OiSFJ3tKx17J0+xfMTxarlu8+npfto3kKD3+O1C1Hi7gn93krKyLX93QsoAI247iN+
         sMmgxtt4WgaALWQ9eQP9VHglw3UYXSfPwP+htjsglbVZBQNqUYVJ4IKkMvfaR1qTqwwn
         pcllL9WcCfjXCYqkxBT8ZCpSeZ0nqQDbhLrKeCmyRi1jN7DIC0TGGkmL8JS8kqan4/n5
         z8DI5d0TQ8pwDTa+5gUjtURPJnSKSV9ai10E8B5a28KjJx8BeUCFoSSC7BF2C2g1/H8D
         U6GlELwK+6afgXH8GeKyGE0fItCgdNFPj9LiG5+Tvgvy7QlovqE5AevCngBql7MrVFZ3
         jYWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMLYkLTlE1F4dqRM90yN85KgPXP506XVfAYZiwbo+AC0f6oQyZdD96dtBA2u+GRbSMvjbP3nCZYxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/LkfUbir8XUK4B2VUS9fossykxVDdLRQcKXUttaJFUMdjmj5
	78F1onIvRAip1uOE0DThSNUOSqcJSDAzhv3JkMfBwkHFgIXxC5k27XtIjZxh7e2qtUBr7znZvzJ
	B3rpaBel/Kc/TsBT2owUIkZE7DYLRP6DI
X-Google-Smtp-Source: AGHT+IE4XvEqr49BxYA4bpL2FbKKS8WZoiYdk3yeNzanGs1dJXGDFF699hPtlakI1p12XejLN9JkEaCERU+dAmb1yIw=
X-Received: by 2002:a05:690c:2b8b:b0:6be:2044:9367 with SMTP id
 00721157ae682-6e2c6ff8f4amr26952107b3.15.1728066039230; Fri, 04 Oct 2024
 11:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfBBTsmKYf5FT-pxLfM-C1EgdrKKhQU43OhMDBz2ZPtKcxaLQ@mail.gmail.com>
 <20240930192834.GA187120@bhelgaas> <CALfBBTv3_4_x3aXfoDgQ93LCAbfC-2djnfwbHS+hqmOff8+8+g@mail.gmail.com>
 <CALfBBTtdtzL4TatBOOzc=c+k9YdNDPd=UPppbo5U5fuK+YscvQ@mail.gmail.com>
 <Zvw9SnYICUvbDhuZ@kbusch-mbp.mynextlight.net> <CALfBBTtxJB1BQkSZ=RBKCiZKNeTxsJHAZ50jdBUjNSmOf79NWw@mail.gmail.com>
In-Reply-To: <CALfBBTtxJB1BQkSZ=RBKCiZKNeTxsJHAZ50jdBUjNSmOf79NWw@mail.gmail.com>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Fri, 4 Oct 2024 23:50:28 +0530
Message-ID: <CALfBBTuhUcdBAQgKFhGP+9gMqEthA_dOE6V3RGn6HTZm7nNBYg@mail.gmail.com>
Subject: Re: pcie hotplug driver probe is not getting called
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,


The platform I am working on is rtl simulation of pcie switch(Gen6)
with a backdoor mechanism to trigger the HotPlug event.

Tried following patches independently to have both hotplug and dpc
driver register and handle respective events.

https://patchwork.ozlabs.org/project/linux-pci/patch/20231223212235.34293-2-mattc@purestorage.com/
https://patchwork.kernel.org/project/linux-pci/patch/20240108194642.30460-1-mattc@purestorage.com/#25680870

Tried following

- Trigger hot removal and add, the event is triggered and respective
msi in /proc/interrupt increments and kernel logs the event(dmesg)
- Trigger hot removal and add, the event is triggered and respective
msi in /proc/interrupt increments and kernel logs the event(dmesg)
- Trigger DPC using "DPC software trigger" in DPC control register

The kernel hangs, the console is non-responsive.

Can dpc and pciehp co-exist and handle the events?


On Thu, 3 Oct 2024 at 20:22, Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> Thanks Bjorn,
>
> Enabled "No Command Completed Support" in switch firmware init, now Timeouts are not seen now.
>
> I had question about "DPC",  DPC driver probe is not invoked though down stream port advertises dpc extended capability.
>
> Does kernel expects uefi/bios to pass some _OSC flag for kernel to invoke dpc driver probe?
>
> On Tue, 1 Oct 2024, 23:49 Keith Busch, <kbusch@kernel.org> wrote:
>>
>> On Tue, Oct 01, 2024 at 11:39:33PM +0530, Maverickk 78 wrote:
>> > I was able to trigger an interrupt, the pciehp_isr was triggered and
>> > there are "Timeouts" while processing the hotplug,
>> > I suspect this is due to the slowness of the simulation platform, is
>> > my assumption correct?
>>
>> That usually means the slot does not generate software notification, but
>> for whatever reason decided not set the "No Command Completed Support"
>> in the slot capability structure.
>>
>> > [26599.580420] pcieport 0000:02:01.0: pciehp: pending interrupts 0x0001 from Slot Status
>> > [26599.580575] pcieport 0000:02:01.0: pciehp: Slot(0): Button press: will power on in 5 sec
>> > [26599.593768] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x17e1 (issued 42213 msec ago)
>> > [26599.598920] pcieport 0000:02:01.0: pciehp: pciehp_set_indicators: SLOTCTRL 80 write cmd 2c0
>> > [26605.104802] pcieport 0000:02:01.0: pciehp: pciehp_check_link_active: lnk_status = 2025
>> > [26605.104840] pcieport 0000:02:01.0: pciehp: Slot(0): Link Up
>> > [26605.109616] pcieport 0000:02:01.0: pciehp: pciehp_get_power_status: SLOTCTRL 80 value read 16e1
>> > [26605.126589] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x16e1 (issued 5528 msec ago)
>> > [26606.458516] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x12e1 (issued 1327 msec ago)
>> > [26606.458554] pcieport 0000:02:01.0: pciehp: pciehp_power_on_slot: SLOTCTRL 80 write cmd 0
>> > [26606.475509] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x12e1 (issued 1344 msec ago)
>> > [26606.481024] pcieport 0000:02:01.0: pciehp: pciehp_set_indicators: SLOTCTRL 80 write cmd 200
>> > [26606.618088] pcieport 0000:02:01.0: pciehp: pciehp_check_link_status: lnk_status = 2025
>> > [26606.674790] pci 0000:03:00.0: [abcd:0000] type 00 class 0x000000 PCIe Endpoint
>> > [26606.725288] pci 0000:03:00.0: BAR 0 [mem 0xf8000000-0xf9ffffff]
>> > [26607.867503] pci 0000:03:00.0: 63.014 Gb/s available PCIe bandwidth, limited by 32.0 GT/s PCIe x2 link at 0000:02:01.0 (capable of 1024.000 Gb/s with 64.0 GT/s PCIe x16 link)
>> > [26608.386085] pci 0000:03:00.0: vgaarb: pci_notify
>> > [26608.491596] pcieport 0000:02:01.0: distributing available resources
>> > [26608.491637] pcieport 0000:02:01.0: PCI bridge to [bus 03]
>> > [26608.495947] pcieport 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
>> > [26608.513041] pcieport 0000:02:01.0:   bridge window [mem 0xf8000000-0xf9ffffff]
>> > [26608.521771] pcieport 0000:02:01.0:   bridge window [mem 0xfe200000-0xfe3fffff 64bit pref]
>> > [26608.647492] pcieport 0000:02:01.0: pciehp: Timeout on hotplug command 0x12e1 (issued 2167 msec ago)
>> > [26608.652270] pcieport 0000:02:01.0: pciehp: pciehp_set_indicators: SLOTCTRL 80 write cmd 1c0

