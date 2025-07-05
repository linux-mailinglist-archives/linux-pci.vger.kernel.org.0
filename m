Return-Path: <linux-pci+bounces-31568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E88AFA097
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9161C21FF0
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 15:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94798136349;
	Sat,  5 Jul 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwwnuMcm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DE2CA9;
	Sat,  5 Jul 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751727660; cv=none; b=DHwa8tazWReL0aOKy3LcQoNaJkx/hbitjrZWRkhjZtEQdLgP5eV5XV2IHCXQf7FbSh57xO9SSJMUz5xTYFU6UhWzj77ys4vDr9+fq7MuNNLXjDL29gIm0umvN/0DD+/WxYzhUmX6E7z5CEuirXvTWcCvxomTWWLFy5LJvH5eTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751727660; c=relaxed/simple;
	bh=bmyz+ArMe/pYFA0OKFDVTvv8JlB0sqSRRAFjNg1EWUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8msmEmK6LTH6IjbA5UhylWuvjq8i9BeUn7MGfhv+QGOI1xzeeI6DVQkyVljosADqFUsb2F9yCdSpxiDKRJYS097/x34YJnlQxVmrEmp1uzgtsCmSZWj7FFTz6veMmlSPZB2SpmDNPDwV3x0Yd4QVEIZ29r17zadC65QFSmMJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwwnuMcm; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-70e3c6b88dbso11314277b3.0;
        Sat, 05 Jul 2025 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751727658; x=1752332458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSoy42jE8oSTsRV8nhC5XWMdIM4lCHhuTojjQ5lYN7Q=;
        b=NwwnuMcmPkQsv7zyqmiZDDcrQ22vSekexNGo2osGjWxaoez2aPX6od527FJ/vfxWff
         e5x+E7KFUsn/5rrjkUUrt1rdrIGLtsmnpazMU0dt94zfK8uNSOo7pRKR7sovffJNYws/
         lMCnEKe8coBbXiqQWxnf8XK0OWqUtqEjeQfrCubqc4KQmz0f7VNOHxbC/s7gV673+IKu
         TPDrkkhXhv55wJqOC7Ze5FayQXHZd7rFD/gdMTl6ZiicuO8gt9dXySaWiAB4kG8Qy33T
         oa4NZdQ3L3Sf9iC8IXgG9+xYkbJPUk9cWyOCajeLc0mWB+z4bR+gSLtkOVy6ef/Y+X0i
         LT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751727658; x=1752332458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSoy42jE8oSTsRV8nhC5XWMdIM4lCHhuTojjQ5lYN7Q=;
        b=tWF9/t6uxkpiUpbtDkWwfv8fq+f00dXmdnFHQtlZTUZYOxIC9njPBTr5EtczhDkNR/
         MNngC3VIfsank37SoXA6HB6DYSIN/KGOEbd+NeqJASP535iWl1PF2ooBlcslMPH0CjL/
         Bi0Ql3tPanJr0VwOB9cLd4OrGTHXoclUOBh3ndxeiJvimm51AOPCJNlfQiL7+7V4hz2r
         rbQV+HCj7NVyJf2eYir0JV1n3UKbp5b4a+JjvWEbq6nuxi/SfnxdqUyNl+1h0NhMfSRa
         YRNvxQpg4yJ64ftMAvyCAnc87wX+gAlGZGpZwX6erK2XCEdusvmYW3VWWl+XXfOhQDI4
         wPbA==
X-Forwarded-Encrypted: i=1; AJvYcCVRcclsV9vlNdzSSKr3WBLbGNRPsV+/Ol7qJUVJb6buaKB6YM9qsUinF6nMNmgC74WphCsWwXhjcY2a@vger.kernel.org, AJvYcCXBPB4TdDAdKxZWPw2LdW2eCAem0qM3cajmy/Jfd+5oRagNXfOmWLREdWxHig6dsUUBMjhQlUoA@vger.kernel.org, AJvYcCXYa8gKEiIJSrHaXnGr3E1kRWliLgQHeuLJxL0atG6Erp8NAoQA9O3x4+/LszIWsP5EIJt6HOSOmM3X@vger.kernel.org, AJvYcCXbfbwmhd4RBeHVdhkDj6KxLLa4H0KTEc0vhUzltdLSd1YxdN57WXKo12kFzB073n1xBoiBUC121wECqNzYf7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM48yvy8I/4613IJv+l5ZQxNAZP4RidRXlwBy2XFeW3CRUswaX
	160fPOx6T2HdNwH8SqgufTviUFCVViV7e/i6p0cn8qikeCLyz1IRDTKmYVk1oxOExWpdQsWnuuD
	qMT7Ac0R+4axHxC5k0fmuhHGs3uvl4+E=
X-Gm-Gg: ASbGncsRRqibVFe+aDxMPgNWhWrNSCJYn5cubMx1mPhz6qLtyvuSV0EYELbZsmVL20G
	hnVC8rT9cH44a2T23pouT6onQkSZcdehg+LiloOsX0MjT2OAiKabw11yvanmPRae+bQ+Twzjrjl
	hdfVP2VQzBU0eSbddKf6w4l5wwJ7mdLyhl1GPM8IMetKdYTw==
X-Google-Smtp-Source: AGHT+IHwNGLhGtdbfnWLVGJVusTre3vOxTxJKxjsn9yuE6owvpAXDFW41hV64HRaaDHx5FjdBgIq01PfFHw8A7cM/R4=
X-Received: by 2002:a05:690c:4a05:b0:711:406f:7735 with SMTP id
 00721157ae682-7176c9f94c5mr31300827b3.13.1751727657667; Sat, 05 Jul 2025
 08:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <B0A6D9B4-086F-4D58-8284-485B9FF4B31A@gmail.com> <20250705135020.GA2006390@bhelgaas>
In-Reply-To: <20250705135020.GA2006390@bhelgaas>
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Date: Sat, 5 Jul 2025 20:30:46 +0530
X-Gm-Features: Ac12FXxu3GajXzRL8jbJqYv42LXNHTyi6qR_NX0yFSQpcNrZEs4Tg0ZYynZacQA
Message-ID: <CAEmM+QjHnU0h3HtWH8AXP05k2dTYozu81eRxn45HVEUSRG8jLw@mail.gmail.com>
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The dmesg log (the older one) is present here:
https://gist.githubusercontent.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d8=
32a16180/raw/78460e6931a055b6776afe756a95d467913d5ebd/dmesg.log

The newer dmesg log includes the first line and is not overwritten by
the ring buffer (used pci=3Dnoaer in this case):
https://gist.githubusercontent.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d8=
32a16180/raw/78460e6931a055b6776afe756a95d467913d5ebd/updated-dmesg
 (The newer one doesn't have the error recorded).

You should check out the older dmesg, the quoted line was taken from
there verbatim, including any additional details.

Bandhan

On Sat, Jul 5, 2025 at 7:20=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Sat, Jul 05, 2025 at 01:00:23AM +0530, Bandhan Pramanik wrote:
> > Hi everyone,
> >
> > Here after a week. I did my research.
> >
> > I talked to some folks on IRC and the glaring issue was basically this:
> >
> > > [ 1146.810055] pcieport 0000:00:1c.0: AER: Uncorrectable (Fatal) erro=
r message received from 0000:01:00.0
>
> Where is the complete dmesg log from which this is extracted?
>
> > This basically means that the root port (that 1c thing written with
> > colons) of PCIe is the main problem here.
> >
> > One particular note: this issue can be reproduced on the models of
> > this same laptop. Therefore, this happens in most if not all of the
> > laptops of the same model.
> >
> > For starters, the root port basically manages the communication
> > between the CPU and the device. Now, this root port itself is
> > reporting fatal errors.
> >
> > This is not a Wi-Fi error, but something deeper.
>
> Devices that support AER have extra log registers to capture details
> about an error.  A device that detects an error sends a PCIe Error
> Message upstream to a Root Port.  The Root Port generates an
> interrupt, which is handled by the aer driver.  In this case, the
> 01:00.0 device detected an error and sent an ERR_FATAL message
> upstream, and the 00:1c.0 Root Port received it and generated an
> interrupt.  The ERR_FATAL message doesn't contain any details about
> the error itself, so the aer driver looks for the AER registers in the
> 01:00.0 device and logs those details to the dmesg log.  Normally
> there would be a few lines after the one you quoted that would include
> those details.
>
> Bjorn

