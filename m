Return-Path: <linux-pci+bounces-6038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E432F89FC47
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141D01C2171C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60EB16F266;
	Wed, 10 Apr 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/4A8qiR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7516F264;
	Wed, 10 Apr 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764632; cv=none; b=QLjJ7CtuUeZhtIWbAYJ8Go4LccVoEeCe70SD5AFZcU5Id42il377hje8O5xCpv2Gt5XmKaL8h240uy247GtAkLCgYqfhA3GRGaE25kzjpYg33uJvXdbX8VLbTu6PkiE0EoTCuCBzakSdT8TvCPuJ9dHcVbzUR5Vx1LmOQWOtwog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764632; c=relaxed/simple;
	bh=hm8DXi9iNej36872WOw7ngnCKk1oF/OYrdDzBrYyFug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kk7Z2ThDXK0Cd84crM08RerZ8ZM9NAdJeLZX+xkOHI3oonIqZVFvrRqCr1Ew1h/InFmhcEG/bNpFGGaSnf8kZcRYX83O58E5/YwIva8LafE30TcXWkwYCE+hqK88H3j3FTColenUJhsDIt/Y04JqszrhVG4ns/O94rpevC2Hc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/4A8qiR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3462178fbf9so931037f8f.1;
        Wed, 10 Apr 2024 08:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712764629; x=1713369429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDmE0PyuwVApDK9lCw057eM05JQxQyJj1I6OK2rpFdw=;
        b=d/4A8qiR+QLAa2Upp7DKAELkPg5qY/2drLgYyD90TJfNsJJfp+VOLVzQVGKnj9Pyfb
         R7+H9gfKp6lESqwV3GD2EEKnK7eT4uECXY1HNxDFghS3ebw/7nno4Zr4T4BEgSdrfxXs
         HoWyeJPvxOPaiLonZZX50/XoQNkzVT4ehiqtluTU5QFlFgZSCmlqIt3WjgHybH2Pgu/c
         jn6GRA2k6jr2lVrJLFAMhs7xpO/dx7r15bHGXogrwjYBs9hBf52gWK1FXruK0ZbAhdBt
         HBwRwAKA4fnLCXj85oQ8Cf8sxxsWMsQrjaosW80NKB9cR4Pt8bSC78g+PYzfCiH7O0y9
         2HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764629; x=1713369429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDmE0PyuwVApDK9lCw057eM05JQxQyJj1I6OK2rpFdw=;
        b=UW6/np3/8SugyAXhJMZ6xNNn9530NitejDi/ikG+vNvMDreEMRTJhPDWkAKjUPdYiO
         cQU7Qd+krnvXjfM6OmwFQU6/QkeC9iv/OV9zijJVHi/QlleF1LQGjVf6XhhmqdALPmO1
         cVrAgZE8V4qfQUCS2MODjVxRYJvUOpgCLoyVK2HVRYsL5bULhBd2djLSnLA2lv+Qa7fs
         M0WsIrD9R/Q13djOTkPxSKy1dcuj5aMJMnnr+19l9+Opv89VLQxFdK/M8WMpXfkFmxo0
         lRuBa+AqSMOou6FyK9D58UXPM/CL9TTIL86kVtk1Ug7yCcWJc8Hc+vGID7QhTgSlB+iD
         WZBg==
X-Forwarded-Encrypted: i=1; AJvYcCXf4d7l6ajL8o8H/qUVyj0dZrlPauHKPFhEJPtnAwcyaEoikaRqxyMHytvlHelZDYy+cQRNLPDZH3Z3MmdXGcxbYt5Zo58jdfc8Ti4x/ky4oEMfxF0XY4wN7FydxMFfgdje
X-Gm-Message-State: AOJu0Yx28SofwoKYMfNQfgFcNZj3RAinohAGrjAkGlGqH8r9LN8kyi4S
	SK2ocpdwKk32pqV4sKVDtHXGYtMirk86y1C7bYfUn/p3rBCLvQ8HGTiTlhzLr5OaFA/bNfprB01
	dmYzP1cp9PlbQwmp736pGzd+jLZk=
X-Google-Smtp-Source: AGHT+IH/oeulYx1XVv1Z3auyKq3gKDR6pMFcF5pyq6/MbW0ULuRjsr2OOK8nH1U47rlr5mjIvcmm+720erwXhJhggLo=
X-Received: by 2002:a05:6000:18af:b0:343:734e:73d1 with SMTP id
 b15-20020a05600018af00b00343734e73d1mr4086237wri.37.1712764628554; Wed, 10
 Apr 2024 08:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org> <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
In-Reply-To: <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Apr 2024 08:56:31 -0700
Message-ID: <CAKgT0UcVnhgmXNU2FGcy6hbzUQZwNBZw0EKbFF3DsKDc8r452A@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, 
	John Fastabend <john.fastabend@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 4:42=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > What is less clear to me is what do we do about uAPI / core changes.
>
> I would differentiate between core change and core additions. If there
> is very limited firmware on this device, i assume Linux is managing
> the SFP cage, and to some extend the PCS. Extending the core to handle
> these at higher speeds than currently supported would be one such core
> addition. I've no problem with this. And i doubt it will be a single
> NIC using such additions for too long. It looks like ClearFog CX LX2
> could make use of such extensions as well, and there are probably
> other boards and devices, maybe the Zynq 7000?

The driver on this device doesn't have full access over the PHY.
Basically we control everything from the PCS north, and the firmware
controls everything from the PMA south as the physical connection is
MUXed between 4 slices. So this means the firmware also controls all
the I2C and the QSFP and EEPROM. The main reason for this is that
those blocks are shared resources between the slices, as such the
firmware acts as the arbitrator for 4 slices and the BMC.

> > Is my reading correct? Does anyone have an opinion on whether we should
> > try to dig more into this question prior to merging the driver, and
> > set some ground rules? Or proceed and learn by doing?
>
> I'm not too keen on keeping potentially shareable code in the driver
> just because of UEFI. It has long been the norm that you should not
> have wrappers so you can reuse code in different OSes. And UEFI is
> just another OS. So i really would like to see a Linux I2C bus master
> driver, a linux GPIO driver if appropriate, and using phylink, just as
> i've pushed wangxun to do that, and to some extend nvidia with their
> GPIO controller embedded in their NIC. The nice thing is, the
> developers for wangxun has mostly solved all this for a PCIe device,
> so their code can be copied.

Well when you are a one man driver development team sharing code
definitely makes one's life much easier when you have to maintain
multiple drivers. That said, I will see what I can do to comply with
your requests while hopefully not increasing my maintenance burden too
much. If nothing else I might just write myself a kernel compatibility
shim in UEFI so I can reuse the code that way.

The driver has no access to I2C or GPIO. The QSFP and EEPROM are
shared so I don't have access directly from the driver and I will have
to send any messages over the Host/FW mailbox to change any of that.

> Do we need to set some ground rules? No. I can give similar feedback
> as i gave the wangxun developers, if Linux subsystems are not used
> appropriately.
>
>        Andrew

Yeah, I kind of assume that will always be the case. Rules only mean
something if they are enforced anway. Although having the rules
documented does help in terms of making them known to all those
involved.

Anyway, I have already incorporated most of the feedback from the
other maintainers. The two requests you had were a bit more difficult
as they are in areas I am not entirely familiar with so I thought I
would check in with you before I dive into them.

One request I recall you having was to look at using the LED framework
for the LEDs. I think I have enough info to chase that down and get it
resolved for v2. However if you have some examples you would prefer I
follow I can look into that.

As far as the PCS block does it matter if I expose what the actual
underlying IP is or isn't? My request for info on what I can disclose
seems to be moving at the speed of bureaucracy so I don't know how
long it would take if I were to try to write something truly generic.
That said if I just put together something that referred to this as
pcs-fbnic for now, would that work for making this acceptable for
upstream?

