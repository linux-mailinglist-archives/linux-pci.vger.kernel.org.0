Return-Path: <linux-pci+bounces-22643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B4A49C67
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 15:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55AA7A30F0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE226FDBE;
	Fri, 28 Feb 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPw65C+N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FDF26E94D;
	Fri, 28 Feb 2025 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754198; cv=none; b=O2qIqLt82YxvYBaWK8CcPdu9Vn3TyD69E2jhTJB+mGuJOX6c4qvL9BVfTD9MN1tAtX2Gr1mPWIrub6aw+Ni/ZhvFqgTtufZpPBG7IGXPU8aF2CXuJs6SGtx/sQWSJjXO+tTzp7KZaS4tSJETxPdQAvWjHgNMPkxnMb5eLexlqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754198; c=relaxed/simple;
	bh=3T7vsRWKLTCraBlCKVdrwE+VFUJiIKlGyZVgIMWmYQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chs4L3p4XYuG4wA908UxcNZ4FvWLEDHwgyBhzdLJkZdn/Kk+JaPFcxXklftig9/nOz0orTS7m/Bgk7IKuoxgFq5Zz4Tsm1txQtHiBAqbdYDJkQ4AyIPRG5K7jt2d1c0HLhh2vMkqo4VGcNGUjxg1HZzW6Nv8sR1Q+ODyqzOT3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPw65C+N; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5fe87fd0a47so544064eaf.2;
        Fri, 28 Feb 2025 06:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740754195; x=1741358995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+mNGsx9k8BYOvf5M//YOrV9w6h6DAZxVOm7B77umBY=;
        b=CPw65C+NpB21IfZCS65/psgAhkdbrJk2ouwfGDYz/YpVf3eOacO9pyIWEN0ynG84+f
         kq6/KBB3VYgzk9u1Ol3JL/UpWGGFlnDUHlsk6SvM8aTF7zVqrKH3u/aAaunQCTnbgb5r
         38Hlgwmd1S32xVQRBPkT15rgHQLx4Dgx8/jKUw92UtxvMBKHd1z8ARuz++foGNCfGVBH
         MXfrC/u03qjyYH7vDHkO+2ihP7KkMgx/7AIn+KfNnH2OI5y1Gy7qYcS4hpAtNLUYjEW4
         viUO7rEPuDgmAC1u4YI+h71i8f8lsasHmroigDS9yvvhws8oyCVhdiMAsAzADDtq67QT
         jEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740754195; x=1741358995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+mNGsx9k8BYOvf5M//YOrV9w6h6DAZxVOm7B77umBY=;
        b=UUGskEHSh2WzZZuvf8ELQmO8k9fUtQgcZupO+VYC7+dAVtixYzPGmagZjc1VCzEFSq
         HKVmVoi3KOo3uaUGUCrMRceAL8oy+ZN1NIylkCwNUYtxhHBalI9SKYmm0vme4BOjafBO
         jlpG7O2FwUS+oIZVlvs6TE5qSl0OKvWO0iP6a4cj4k6WR10osxM6Zg9qi9gSc0g35Obd
         hIVq2LVaF2hng+Jd+bWa3W4Ip8WONKyiVnAp6i4zfoD3rupIqyb7/KXTNNYwr9P7qECb
         stXnXH7TYq5n59THaTpkn8Ug3QpJPb7W9iCbs/VUqOGsL6FTGaGzdMMbTZHz99bihBn4
         IKKw==
X-Forwarded-Encrypted: i=1; AJvYcCUX9MFrKCVfri9SZl/dOrC6hrs42oakaDozR2l4GAqMmsaK2Jf2d8dER5k4vLH9p1iOFPn5XMmmF0QNPyEH@vger.kernel.org, AJvYcCXHGn89MH3J2jrMebf/BCVW9i8JAICkyw7pWFNvhAoAIoq0MEiZOO31hmEImp0ilazjxReHSQ4RsJhA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0nNemzSBEV46QgWj26lVq3C8sqfpRvqBSPH/rlzQz5092Pyai
	Gn/3hnD6m/qRXPUllf3VJ/z8Eu4Pexxr9HkYGJXNl9kCvnhtGJmy/dap21uBd+DlNznOkINQaWC
	MovhpXS9Gx2cS4jL7BPJ6LSrqDL0aIjt3
X-Gm-Gg: ASbGncvmP1xqcPhqc8q9OO89xqRk8SsLtj/Gq5/leiE5ptQgNf5FIJxX+swsjX1uVW9
	k6u5pYZpyw8uS59QO5CVKgzgr1veVhyRcXu3GTdyuXvpU7TF7KTcnBXor453aRpthWtJpPEOECG
	1c4FF23VE2ag==
X-Google-Smtp-Source: AGHT+IGEnn60FcFR2pIf9E54P2sohtprC377BVbB7Z7tsIFGGCYKkuRziZyDPnIqAPk50ASdDx5e1aUTt4oe+31fYYM=
X-Received: by 2002:a05:6808:178a:b0:3f5:50d4:1a96 with SMTP id
 5614622812f47-3f5584f7017mr2196729b6e.8.1740754195412; Fri, 28 Feb 2025
 06:49:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHhAz+gUOK4Bn5ijO0H1b5=EtvD5W4GpOTtjP0--yVToNpkEDA@mail.gmail.com>
 <20250227160448.GA597390@bhelgaas>
In-Reply-To: <20250227160448.GA597390@bhelgaas>
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Fri, 28 Feb 2025 20:19:44 +0530
X-Gm-Features: AQ5f1Jp462UoXhMky_kstQZ6GOcRVkNoC8pJcv6-U-HmRm3ooIzaLNMXGvx1wRM
Message-ID: <CAHhAz+j46nus_rGJ72rZ86UyzL+AM_HBCivjpZEx3T0thOxqAQ@mail.gmail.com>
Subject: Re: pci: acpi: Query on ACPI Device Tree Representation and
 Enumeration for Xilinx FPGA PCIe Endpoint functions
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:34=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Feb 27, 2025 at 07:25:32PM +0530, Muni Sekhar wrote:
> > Hi all,
> >
> > I am currently working on a project involving a Xilinx FPGA connected
> > to an x86 CPU via a PCIe root port. The Xilinx FPGA functions as a
> > PCIe endpoint with single function capability and is programmed to
> > emulate the Soundwire Master controller. It can be dynamically
> > reprogrammed to emulate other interfaces as needed. Essentially, the
> > FPGA emulates an interface and connects to the CPU via the PCIe bus.
> >
> > Given this setup, the BIOS does not have prior knowledge of the
> > function implemented in the Xilinx FPGA PCIe endpoint. I have a couple
> > of questions regarding this configuration:
> >
> > Is it possible to define an ACPI Device Tree representation for this
> > type of hardware setup?
> > Can we achieve ACPI-based device enumeration with this configuration?
>
> If the FPGA is programmed before BIOS enumerates PCI devices, the FPGA
> would look just like any other PCI device, and BIOS would be able to
> read the Vendor ID and Device ID and would be able to size and program
> the BARs.
Yes, the FPGA is programmed with this Soundwire IP before the BIOS
enumerates PCI devices.
We need to port the Soundwire driver
(https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/drivers/soundwire/qcom.c)
 to the x86 platform.

Since x86 platforms typically do not use device trees, and the
Soundwire IP is implemented in the FPGA, how can we emulate device
tree functionality or use a different mechanism to pass hardware
configuration to the driver? Specifically, how can we handle the
following API calls on an x86 platform?

   ret =3D of_property_read_u32(np, "qcom,din-ports", &val);
   ret =3D of_property_read_u32(np, "qcom,dout-ports", &val);
   ret =3D of_property_read_u8_array(np, "qcom,ports-offset1", off1, nports=
);

static const struct of_device_id qcom_swrm_of_match[] =3D {
{ .compatible =3D "qcom,soundwire-v1.3.0", .data =3D &swrm_v1_3_data },
{ .compatible =3D "qcom,soundwire-v1.5.1", .data =3D &swrm_v1_5_data },
{ .compatible =3D "qcom,soundwire-v1.6.0", .data =3D &swrm_v1_6_data },
{ .compatible =3D "qcom,soundwire-v1.7.0", .data =3D &swrm_v1_5_data },
{ .compatible =3D "qcom,soundwire-v2.0.0", .data =3D &swrm_v2_0_data },
{/* sentinel */},
};

Basically, how can we define ACPI tables for functions implemented in
an FPGA that connects to the system via PCI?


>
> So I assume the FPGA is not programmed before BIOS enumeration, the
> FPGA doesn't respond at all when BIOS or Linux reads the Vendor ID,
> and you want to program the FPGA later and make Linux enumerate to
> find it.
>
> From Linux's point of view, this is basically a hot-add of a PCI
> device.  If the Root Port supports hotplug and you have pciehp enabled
> (CONFIG_HOTPLUG_PCI_PCIE=3Dy) and if the FPGA comes out of reset and
> brings up the PCIe link after being programmed, it all might "just
> work."  You can also force a complete re-enumeration by writing a
> non-zero value to /sys/bus/pci/rescan.
>
> I'm not sure why you would need ACPI or a device tree to be involved.
> ACPI and device tree are ways to tell the OS about devices that do not
> have a native enumeration protocol.  PCI devices (like the programmed
> FPGA) do support native enumeration, so generally we don't need ACPI
> or device tree descriptions of them.  PCI host bridges have a
> CPU-specific bus on the upstream side and a PCI bus on the downstream
> side, so they are not themselves PCI devices, and we do need ACPI or
> device tree descriptions for them.
>
> If you have something that doesn't work like you expect, can you post
> a complete dmesg log and any user commands you're using to program the
> FPGA?
>
> Bjorn



--
Thanks,
Sekhar

