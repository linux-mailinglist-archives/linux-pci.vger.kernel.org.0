Return-Path: <linux-pci+bounces-22341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E914EA4408B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 14:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF85166518
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1772690D7;
	Tue, 25 Feb 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me/tWsXB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF120B213;
	Tue, 25 Feb 2025 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489378; cv=none; b=D2OMI++Cu/RH+OYlr8SWx5TfuecyttCBvGRNqlHGagTuypSSqIg2EgcNTvOFZLurNs4QV8FARkhI5/npX2GYXKb6UHUbkdsltNvaBKy1k2ZE7/jUcyLPhliLRNKhhrGwqLagHkjgRw1oeWZRh1bZrGu5V75+bgtk2Qqy+q5x4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489378; c=relaxed/simple;
	bh=xebKsClSpiGJgFYUEhLrX3k3fPwdXQfBamfK8FLRr8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R01WcO19zV9pUwHC1MdG029y/fHGCxN3kI+om55klK8dzLBKaikz59KASwEJKICtX/K2QI6K7dTSj/Lh0MiY7T+2izTBsr1zVYh4pF8+PU//+cBRfYN/XKeP/rkVM5S2XAKtWPQNzPK6I6GuA4qCeRccjmiMtQfsXQIdLSku9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me/tWsXB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5461cb12e39so5390785e87.2;
        Tue, 25 Feb 2025 05:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740489375; x=1741094175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yhzYhqcZ0u+9Qey41WN8C1X1Cv3m1W92EYrnC/bc1E=;
        b=Me/tWsXBJ9t3xUGjK4KJ+LrD8fZQihLUBfwxI65xUh0xQZOIWECtJpfwkWgvpxuCJL
         7tOJ9l39Ax+iqSPj8VT1UJZ7vLYurdwd29vcKzMTR9CepdVE7TGLgAMw8vsoLmln0tAJ
         x+HKr2bCUAKyTgpb82NyHc5q9WYwB+hO6GYf2BwFZS3KmEc7N9sNhlQcjfmjH6JRJuid
         ETco3K2DqYMgVeB6dekGxQlvpPtjOo5tBcyWgCVtZPPsdG2us0WGsap09/fKTic6/nw+
         gMCYupFDVu5I9UrzNa++AooLRvULUf8+nc5E9FLQLYXsrkDyglDHd9kEhUIsytKMAQdh
         ILHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740489375; x=1741094175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yhzYhqcZ0u+9Qey41WN8C1X1Cv3m1W92EYrnC/bc1E=;
        b=m9mlcX/KfBek9Zi8Ai8PCU6mRQ5bNXhWRhGeBXJEMLohfMRQIIy791tIHvfKbcm3g2
         /bLs/FPIQaXM1DfIkK8/b2NMJUsqKBNEll/8dxN9t54keAYlOa1J7JH2vJd180/Gylpn
         bbEYRdzDRSnabUYGyha3w5r3XW4ExRpUsk9iBTwlyjNtT8Z9mL52fjXW8upp/zMCPe7H
         WCLHP5E8qPI/kSPg8qkZJRyZfPvy8s53pg/k4O70DXAd+L5WbWUgBFRe2MbsmRS49Vjx
         5337UHoRRsxamX998qAFkSfjN9tApZyXbE5OSWiP1cfpRw/WaV5n8JoL1iqfXToiKFVC
         Oyjw==
X-Forwarded-Encrypted: i=1; AJvYcCUBZwGKy0LyLDWqGPmvWs6EhnKFtDlpjwjwrduPRBjWwkx91hDcfyyTa3Co74qMCbqHR7i0ARvoPbGcTtQ6@vger.kernel.org, AJvYcCV+73yKjGuLf6ROo5NlD6Hb0kwgyQcQilurW+4ybubha4ZVAEHJdBUuRD7h6qRMnPhLRKaj/7jP9vsC@vger.kernel.org
X-Gm-Message-State: AOJu0YzYu0eS8rsE98/t4P+/iDYcprcFox15ypG89/w/amRwbW40L9ve
	P3rrg+omOPHZF2xFpXBQn2LKvGgk3LGqhk7aSDrQMtWdPm8aGtIlteCX78I/vGdRkncTBXtOtDp
	45jpTTC1FDqddyg9EbKcEw36okg==
X-Gm-Gg: ASbGncs9NtlWKPjbcTakxcd5ks78KVz/kFdkkARIWUhsb5/TwSs5Oi9cpLBokMcUVP4
	6ExAQfWzqk+D0iC06iSiBfAFup6Aq/2XMfO3VpAOVJJHB62Nlvm6bIGtGpc55fZOnmjb1NGrKcF
	KQlzbTJUQ=
X-Google-Smtp-Source: AGHT+IHZD37TRQdeOLKhUhrNZM5rGVP80rGFnhiNLLy62hwtki8xxWAer67VvhIKFDb2Fj6lIFpjYt/ZBIDtcPG2Dw8=
X-Received: by 2002:a05:6512:6ce:b0:545:441:52d2 with SMTP id
 2adb3069b0e04-54838ef4c73mr7761428e87.23.1740489374516; Tue, 25 Feb 2025
 05:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVVV9tHH1M2bOnwqCJCQ8OjNFGjuQB7R-fY7JHHD5tQHoA@mail.gmail.com>
 <20250224195423.GA473540@bhelgaas>
In-Reply-To: <20250224195423.GA473540@bhelgaas>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Tue, 25 Feb 2025 18:46:02 +0530
X-Gm-Features: AQ5f1Jpa03K69kEgEFPOkIOv7GmmUMgdCFEj1cGoDijTqSNxJvZtameW7_EW_ok
Message-ID: <CAMciSVX3X=DxLU0tfj4rG5WPaS5BCUDcMp2MYWBitT0ecEH+ig@mail.gmail.com>
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 1:24=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Feb 25, 2025 at 12:29:00AM +0530, Naveen Kumar P wrote:
> > On Mon, Feb 24, 2025 at 11:03=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > On Mon, Feb 24, 2025 at 05:45:35PM +0530, Naveen Kumar P wrote:
> > > > On Wed, Feb 19, 2025 at 10:36=E2=80=AFPM Bjorn Helgaas <helgaas@ker=
nel.org> wrote:
> > > > > On Wed, Feb 19, 2025 at 05:52:47PM +0530, Naveen Kumar P wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > I am writing to seek assistance with an issue we are experienci=
ng with
> > > > > > a PCIe device (PLDA Device 5555) connected through PCI Express =
Root
> > > > > > Port 1 to the host bridge.
> > > > > >
> > > > > > We have observed that after booting the system, the Base Addres=
s
> > > > > > Register (BAR0) memory of this device gets reset to 0x0 after
> > > > > > approximately one hour or more (the timing is inconsistent). Th=
is was
> > > > > > verified using the lspci output and the setpci -s 01:00.0
> > > > > > BASE_ADDRESS_0 command.
>
> > ...
> > I booted with the pcie_aspm=3Doff kernel parameter, which means that
> > PCIe Active State Power Management (ASPM) is disabled. Given this
> > context, should I consider removing this setting to see if it affects
> > the occurrence of the Bus Check notifications and the BAR0 reset
> > issue?
>
> Doesn't seem likely to be related.  Once configured, ASPM operates
> without any software intervention.  But note that "pcie_aspm=3Doff"
> means the kernel doesn't touch ASPM configuration at all, and any
> configuration done by firmware remains in effect.
>
> You can tell whether ASPM has been enabled by firmware with "sudo
> lspci -vv" before the problem occurs.
>
> > > > During the ACPI_NOTIFY_BUS_CHECK event, the lspci output initially
> > > > showed all FF's, and then the next run of the same command showed
> > > > BASE_ADDRESS_0 reset to zero:
> > > > $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> > > > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > >
> > > Looks like the device isn't responding at all here.  Could happen if
> > > the device is reset or powered down.
> >
> > From the kernel driver or user space tools, is it possible to
> > determine whether the device has been reset or powered down?  Are
> > there any power management settings or configurations that could be
> > causing the device to reset or power down unexpectedly?
>
> Not really.  By "powered down", I meant D3cold, where the main power
> is removed.  Config space is readable in all other power states.
>
> > > What is this device?  What driver is bound to it?  I don't see
> > > anything in dmesg that identifies a driver.
> >
> > The PCIe device in question is a Xilinx FPGA endpoint, which is
> > flashed with RTL code to expose several host interfaces to the system
> > via the PCIe link.
> >
> > We have an out-of-tree driver for this device, but to eliminate the
> > driver's role in this issue, I renamed the driver to prevent it from
> > loading automatically after rebooting the machine. Despite not using
> > the driver, the issue still occurred.
>
> Oh, right, I forgot that you mentioned this before.
>
> > > You're seeing the problem on v5.4 (Nov 2019), which is much newer tha=
n
> > > v4.4 (Jan 2016).  But v5.4 is still really too old to spend a lot of
> > > time on unless the problem still happens on a current kernel.
>
> This part is important.  We don't want to spend a lot of time
> debugging an issue that may have already been fixed upstream.
Sure, I started building the 6.13 kernel and will post more
information if I notice the issue on the 6.13 kernel.

Regarding the CommClk- (Common Clock Configuration) bit, it indicates
whether the common clock configuration is enabled or disabled. When it
is set to CommClk-, it means that the common clock configuration is
disabled.

LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-

For my device, I noticed that the common clock configuration is
disabled. Could this be causing the BAR reset issue?

How is the CommClk bit determined(to set or clear)? and is it okay to
enable this bit after booting the kernel?

>
> Bjorn

