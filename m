Return-Path: <linux-pci+bounces-22870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF853A4E66C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C101B40906
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB00020DD4C;
	Tue,  4 Mar 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b="Fe4MPNMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7D25F99E
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104576; cv=pass; b=uoN1YUF2X5D3c3j6a1amgmQ76O2DVrx9A1JFl6cj88+NEhZ/fJyj6dY207uKR4RvoDzB9kxLjnjrqW/iy7J8xnKc+puSwApyIuOTr90q65vlaa3mdrBRvvuC2hYFLHi8x67ROKDqyz6Cud8O7xznd6TADUPDFAt6juwnXeOWL5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104576; c=relaxed/simple;
	bh=pv7JhxNl2I28whP9+adbwP3IvdPyCk6EghnFcKHSLq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuwwIpBLlf1QKZyMfL0LereX/3ApjW3aksrjOQE7qFSNJKT7TWJNBi/v0lIBTm53Iqsuw/0Yw3LxHHWNUkdctV7Wo7TFPfSBkA4Aymds00e6TXi80VZmRWFCsHIJ6LU1Phmm38MCfhEotODqMU1XfluWKrOqB5xocEfEAEr+loY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=Fe4MPNMk; arc=none smtp.client-ip=209.85.222.46; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id A2CF440CECAA
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 19:09:32 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gZq2gnzzG1H9
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 19:08:19 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 9CF5A4272B; Tue,  4 Mar 2025 19:08:05 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=Fe4MPNMk
X-Envelope-From: <linux-kernel+bounces-541263-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=Fe4MPNMk
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id B548E42465
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:21:54 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 91D4C2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:21:54 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A8F1891BE2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD21F0E5A;
	Mon,  3 Mar 2025 09:21:42 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FDC1487F4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993699; cv=none; b=V/cQepjUEyOUj1llPf4HhT6QixTzMYhOP3kmVSOIQPKc4OB6qCegmXm4vWWYduZkxpS1Cejqsape5chD/fNz6+FxQBJuHzkNQbboopSnzIdcxSGr8gdpD4WcQQI3Wr9Jo7C1rzPCEHPMTMpM+UJhlo1V6kGf9Ej9Drn3TnBtwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993699; c=relaxed/simple;
	bh=pv7JhxNl2I28whP9+adbwP3IvdPyCk6EghnFcKHSLq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Caku+a+fHRra6BLTMwYdd/L7/PVQquun7iRyx3jvNSsFuh8K4A7Hyn1ys2ddS2K0X2qFPgY+GIyQ31GkmDWnpVTAv2dxliWaj2rnbNxAz/k1i/zP1Pu3kJ5mfeqan+ochP3fnbVYTvetru60024Y0gbfah9sxzb40AIZ39aq54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com; spf=pass smtp.mailfrom=qtec.com; dkim=pass (2048-bit key) header.d=qtec.com header.i=@qtec.com header.b=Fe4MPNMk; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtec.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8671441a730so1619958241.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google; t=1740993696; x=1741598496; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nAeXWNkuPZBt1nYKfkioC0KxXx+i2L54nyTk7vpYv0Y=;
        b=Fe4MPNMk65VWMwDTVoVbm44SCgEeM0RqEDsMk9XX7DwXL3BNTC0rlTaBBpXCpq5RI6
         Ly0SKdi+ioooUzBJ2TRNB440+biEwvdcK7EDbY2aMJNu2l4MfVLamte1Uq+HRxA0QBgJ
         dS7oE9TIXHmLGp+l/54eku17Rqe0n5h6hKFUBqvVmyYjSsuhPKZs5QG/UATUDsgN4EJK
         S+wG072fuZQ9/dChJsYluPWVr2QRCHISBtNavf0tji5dO9eQGIcztn9ctFY07bCTQgQP
         iNeOzx97L87ISFbwTrbEHPjDWXbdRXipL58GXMPnzuOn91svCU6WD1vZ3fBRhDYe5UaJ
         uE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993696; x=1741598496;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAeXWNkuPZBt1nYKfkioC0KxXx+i2L54nyTk7vpYv0Y=;
        b=oUVqNlzu01D7w7chL3wtIsfoWEs16yAD2CsGmF9MBQX3R69JaTLFwDoN2tFbWSKvlA
         twlRlBG6dlh1qmsegK6iSE9khyhRJvWGVZ7Q5ynFd/TsWgxiD6rZULsMggVPigXFnT0Z
         4oguuqp7+l1XMnVSKtrrIE+DW9eZcLu89myC5bb+BLaVGXatKYVXARqTiZ/KD9EC9q0g
         c791uPzxrDDEeKeRAXmcPOMwf/8H6NR9iC8I7r07xEOqsX3IBEZCu547Gndyeg8eb325
         HGj6BkufkZdjyFTP+IoZZ8AUvN3HknYj39oQifLWFmKGaVzi8b87J23bnEpmLD0tCDo/
         txfg==
X-Forwarded-Encrypted: i=1; AJvYcCXfcD8NQ52QxTW/gYEMx8jv5HfJsXmUU0vvbKVHfreHq8VAPEfcC2TYDVvdT7t2S/NNW/vI+oSJWl+rzkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSf1jUtdvn1xn1NqTkJwd2c7s8er1yTfHarqcyE100Gt8WIaG
	EOLSufPvDTc3y0XnogQGJKqFkjJmYpLvMiytMg+TGncXc4CNwC6mVTMSzWW5DhrUtJVlCWwAXpW
	OZpP5cDf4jeglfN7Ou8VivBXEZEwQmWx8Nq9DYg==
X-Gm-Gg: ASbGncuaapOVDAfO6cL+ipFNPYd2NwobMZxSxoj5S8SVK3rYGkJPXyT7CnNCePSDlXv
	2ZmdgbNWsB9tchZ3jzVMtPyddo5KGnk4t0rsk6Alqwm+B1+EaCa3bjZbTjktoec+2i0Cw7Elwdl
	ILPLsooZfNhz4onoF7fMB146v+
X-Google-Smtp-Source: AGHT+IFZbG2eyoSsPmw+ur7eqkya0lr99VJq5r7PqD3pp3CraBkFznVj3MvpZxxCJ8G8DlJOSQmNVFqoW7d+QViHpa8=
X-Received: by 2002:a05:6102:3f89:b0:4bb:f1f0:1b34 with SMTP id
 ada2fe7eead31-4c044857a38mr8417315137.2.1740993696264; Mon, 03 Mar 2025
 01:21:36 -0800 (PST)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local> <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com> <Z78uOaPESGXWN46M@gmail.com>
In-Reply-To: <Z78uOaPESGXWN46M@gmail.com>
From: Rostyslav Khudolii <ros@qtec.com>
Date: Mon, 3 Mar 2025 10:21:25 +0100
X-Gm-Features: AQ5f1Jo0EX3pEM_GVM8NTI1LcFTTbxuaz98gbzh7kKRC0tNKU0-DotXfKkWTSrk
Message-ID: <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
To: Ingo Molnar <mingo@kernel.org>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gZq2gnzzG1H9
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709307.64416@I9Etc2rXNNThJyUsST9Afg
X-ITU-MailScanner-SpamCheck: not spam

Hi,

> Rostyslav, I would like to ask you, do you have patches / updates for
> enabling the EnableCf8ExtCfg bit for AMD 17h+ family? I could try to
> adjust my lspci changes for new machines.

Pali, sorry for the late reply. Do I understand correctly, that even
though you have access to the ECS via
the MMCFG you still want the legacy (direct IO) to work for the
debugging purposes? I can prepare a
simple patch that will allow you to do so if that's the case.

>
> So what is the practical impact here? Do things start breaking
> unexpectedly if CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled?
> Then I'd suggest fixing that in the Kconfig space, either by adding a
> dependency on ACPI_MCFG && PCI_MMCONFIG, or by selecting those
> must-have pieces of infrastructure.
>

Ingo, thank you for the reply.

The way I understand the access to the PCI ECS (via raw_pci_ext_ops)
works, is the following:
1. If CONFIG_ACPI_MCFG or CONFIG_PCI_MMCONFIG are enabled - set the
raw_pci_ext_ops to use
    MMCFG to access ECS. See pci_mmcfg_early_init() / pci_mmcfg_late_init();
2. If CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled - set the
raw_pci_ext_ops to use
    the 'direct' access to ECS. See pci_direct_init(). The direct
access is conditional on the PCI_HAS_IO_ECS
    flag being set.

On AMD, the kernel enables the ECS IO access via the
amd_bus_cpu_online() and pci_enable_pci_io_ecs().
Except those functions have no desired effect on the AMD 17h+ family
because the register (EnableCf8ExtCfg),
they access, has been moved. What is important though, is that the
PCI_HAS_IO_ECS flag is set unconditionally.
See pci_io_ecs_init() in amd_bus.c

Therefore I was wondering whether we should add support for the 17h+
family in those functions to have
the direct access work for those families as well.

Regarding your suggestion to address this in the Kconfig space - I'm
not quite sure I follow, since right now the kernel
will use raw_pci_ext_ops whenever access beyond the first 256 bytes is
requested. Say we want to make that
conditional on CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG, does it also
mean then we want to drop support
for the 'direct' PCI IO ECS access altogether?

Best regards,
Rostyslav


