Return-Path: <linux-pci+bounces-31797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EE8AFEFDD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 19:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7EF581572
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 17:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A91EF1D;
	Wed,  9 Jul 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXhKqJrq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F792144CF;
	Wed,  9 Jul 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082206; cv=none; b=FsJHiyfil5G4gmKPkM0GOAlSZ58x28f5c2zg8dmdm1OiU98ABr5c2I9FqatK5O9Vq3faBC3kG6R2tzbV5FLuiEFOYiA6oskBEluFPnRjRUnE/Z4gySkzqwTRRMRjr8XrS/XOwC9dLrfx1IAhLicPm8zTFIrXPPOdj4VCqidBO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082206; c=relaxed/simple;
	bh=EOj2lMga9i8OFABYK+OrsxlcZW0fasgfoQmLIBdlGY8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cE5ppIto5PrpWbCady/T0dTMSvCu6J8m57DfwaXejd5SJtm0rr1438+EiyvdnkCz0amtCzM543FXlU/bSoDpHlIrRJ9C51zGbnv81wkVnEVXakBDLZLjNqQ3u2ZKGQAyO59JtzKbmJIHtfSle3dV6yim6pAX2ylDqSWnlKzydmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXhKqJrq; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7490cb9a892so117581b3a.0;
        Wed, 09 Jul 2025 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752082204; x=1752687004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOj2lMga9i8OFABYK+OrsxlcZW0fasgfoQmLIBdlGY8=;
        b=RXhKqJrquwJ1EwRbXIFveBdUSzLxwREkOUkoDYY4nv+oYo3rDH3mLBq4eVwW7ZrSQH
         h5jf2aDwtvf0BUMTZKvj9BOh5YcZVZgGV7g0w0N0wIzOtPsvUpm9Q6QipJg/UQrIpO3b
         ZEPauRLWJwpgVVP7uCauGPg/0zPJcR03z+LWeorv2aq8jgRFnqvRU8ojgOCtD/SgiugL
         n5YOEHg/LtT8s1rW6mlkyu1wA+PuP9JcBAc43IJSesjhfrAB4ZXLYjbq2qkGTh3H0MzS
         V7BLPPGHTydcZiU2qHhavtiNgXfO8nY/cL4CSmhkOync7Wv8pfGg4ObNP39cD36Fkt9z
         to8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752082204; x=1752687004;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOj2lMga9i8OFABYK+OrsxlcZW0fasgfoQmLIBdlGY8=;
        b=hH2PLSluVUf72JJIeIkawBjBOjBMKZ2ywOm68HMlqbnd4fOGzrnh6BwnEwJuyxQn5y
         261Ic9ZOffuZ6+G9x9fJZ9d9GAKFQWIX/L2/pCFCIZalI/aWuqh2hFVARW2C+5qhpZ8b
         2ywDab9wGD4Idw7QpA5SA6JnbOGpMzIGUnxyW7Hj9uk+pUn6SO0TR7zN6NCBqExGi8N3
         21tDGHCDWshjV2GkyOM/U5P2+2gzlrsaGzmvrzbAje/ohX1dWij3D2o/bEw3SUqNxDiZ
         AuKYm1XBp2f9VI7ObaN9pOYtus025eIH3CwhoFaNPP63mhxRqADPcKrocwikJBMTfXkX
         /5aA==
X-Forwarded-Encrypted: i=1; AJvYcCUHv55rMqDtwe5mjO93zmdjj3uz69p/txgdFnLlKpGIdAhL1XL6NOiq5987NGIJIMB5g3qRzvA0npzI@vger.kernel.org, AJvYcCWBNviX7E5M5qb9v7jYCHGEZbEkdcQqQs45V7QzFE8silwdpGbbmP84qBZjaUxEFoQ542Hne42eCvkGw0wdow4=@vger.kernel.org, AJvYcCWYuQbbPY5zR5H08Yk+0Xgm63HJ+6h2vhpqJLUbtclQSSH0S+R1/mw007hIVlDiJOyQRoPytDO58aGF@vger.kernel.org, AJvYcCWnDWQDg+QfeeXG0nADY5jI9IOyeDzKAZwTsoKbM6XonIcoFaEnBhx0ZRdV9YwvmO+0wmJvnh9J@vger.kernel.org
X-Gm-Message-State: AOJu0YynZkpenkyceDtZsa9g710DsxpeSFtEd7K3oNJPKlxMk1DCwaAe
	b4/TyMzMgSjhDIrIFHU75YjD2HmoaonZABFEPFkact6JlAJ3HClIMbP96CbxeHZTgH4=
X-Gm-Gg: ASbGncvAT/tJJi+zEhCjkgGLLzosnoEz5XziVkFcJYxU6lo4GaT/gTaLVbp1m3tW0NR
	VLPJj/fzuwgT0PiTR0whwuasq4UMR+g5ndrh1eiW5hldRyDtow7FjhJNy7pKhrvN9uvEClz8XZ5
	kTVYB90wtf8mkz/5x0HyvTWEj4WfloIcrkNafro2jNjVAMxYpmMKFc6HROZTHuSwhm2FL9KWxRR
	0cVOuSZrMNRJr4OG02UltcD4ql1yDNVCcpdFuHQI07TO65Jh82u6cHITZR6klGDyrlQMuHTFomV
	9WhA0nMRtQRUnLqAs7MUpYJLQNk//7lvIMsBLYsqH9BP936GdsvxgVlLTDgWLFoMgk8N0sggo/C
	Pvn8=
X-Google-Smtp-Source: AGHT+IEoFN970f2Vz3fFerySBIi17puKzAo07Z7Kh48d+A/W1u5hYXGzjL22Gwcfkwgr1/kvAHijhg==
X-Received: by 2002:a05:6a20:d8a:b0:220:3024:3d05 with SMTP id adf61e73a8af0-22fb444fe14mr912911637.16.1752082204448;
        Wed, 09 Jul 2025 10:30:04 -0700 (PDT)
Received: from [127.0.0.1] ([116.206.223.154])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b39c64f4e51sm3548305a12.36.2025.07.09.10.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 10:30:04 -0700 (PDT)
Date: Wed, 09 Jul 2025 23:00:00 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Instability_in_ALL_stable_an?=
 =?US-ASCII?Q?d_LTS_distro_kernels_=28IRQ_=2316_be?=
 =?US-ASCII?Q?ing_disabled=2C_PCIe_bus_errors=2C_a?=
 =?US-ASCII?Q?th10k=5Fpci=29_in_Dell_Inspiron_5567?=
User-Agent: Thunderbird for Android
In-Reply-To: <2cq6jeywii5fscozazz2epugh6zflcpfbo4ffhjt2lyk76cq4m@vg2jcsmlhtho>
References: <20250705195846.GA2011829@bhelgaas> <9D9D9375-1BD0-46EA-9E85-47A2D8325F98@gmail.com> <2cq6jeywii5fscozazz2epugh6zflcpfbo4ffhjt2lyk76cq4m@vg2jcsmlhtho>
Message-ID: <FB89ECA8-93E2-4015-8DCF-6D362A53D825@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,=20

I was actually a bit distracted by the things caused by the Automatic Part=
itioning of Fedora=2E I'll inform that in Fedora Bugzilla=2E=2E=2E anyway=
=2E

I realised that making the modules will take 8-9 hours, I didn't even have=
 much of a success (because all the modules didn't properly load, particula=
rly the firmware-N=2Ebin files couldn't be found)=2E=20

But I'll try to recompile the kernel, I'll just have to give it overnight =
time=2E

Bandhan

