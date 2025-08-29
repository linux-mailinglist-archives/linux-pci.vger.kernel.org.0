Return-Path: <linux-pci+bounces-35160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE27B3C595
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 01:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC9AA615C7
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 23:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088362737F3;
	Fri, 29 Aug 2025 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4j0UBEf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A620B22;
	Fri, 29 Aug 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756509921; cv=none; b=bEbjGDqNZYkp8kSwNoGbkVd6wfy8x+gVtzYdR/zX3gqA3VfAAmpSjVcoFphAi4mHK7O3HO/wAf0q7HMn5q2ry6UkwzNulPmLjeWDm8gZ1K9E2YbIOtRs5AL1G1LuE58j0OMI2OPJ9/5ToshhwDhuds2g3caDHQ88+yYjSxg+Kss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756509921; c=relaxed/simple;
	bh=xOARidgJ3p32Bj+AdZtwaYeOnJ/JF4sjM+YUAdG2zag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOjQjda4YR3ejO8aM+ld55FRgMEp4RfQoMX/ZQjpYWqtCKXOhGtpk1BhVFpmVHfxdbM+vUqt2sfFO8hE21434ae4ct0spQk9pYWtIILEprDeWIHhkEOahJTIe0+/Bscur1fAJ2S9VurxjDtmTu34L5KTuZ2dS7OR5SwUzHbXirA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4j0UBEf; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61e27fee909so386403eaf.3;
        Fri, 29 Aug 2025 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756509919; x=1757114719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oD8JqPOQqmYe3P5iUXgZlViA+A6aXFi+Sm0h/jvEQ9E=;
        b=G4j0UBEfTc/JrljQTT1mrJs5xsL4FjHoqmdAVBa8PJZO8mre20IQacg1VLKxkCziC/
         k+wnJAtSMVfjEGw1ivgu72KfWLeT7fG4VWpN9BPXIQVKPnbGkydUd+wvuhj5QP1+m2bv
         LqNNRV5nFsxmKQw1VEpArhlr3rLa3w1J7I7bRf+eyqDOYxneVyc3h1MnrarSahT4HV9Z
         2+Lyg2JLX90lhfCbsmFPIp6DDw1fFMR00ncmDRYvXXsYf0uCXO7/HDNps2cQ9iCwv4fQ
         CFQYm1ybSH1gd5FlJxCCou5mqDbVdsdEeTn9dZIbmrfuhTivKv7Cxhuvz4DtegzOIQmI
         1kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756509919; x=1757114719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oD8JqPOQqmYe3P5iUXgZlViA+A6aXFi+Sm0h/jvEQ9E=;
        b=dcih0cfqwiw48pCpAS9dLGPzCMWYIkKWo4j5swuvyTZ+nivR3aK4G9bdcQTWYMZnbb
         faIaCna1KQxWyUAvR1s1ankM4ieGNWmPCPsH+dZbXqBNJRQ8kcwuHVmCbToyqXCzHwxm
         mYzuFjQJI3k89HCPN+7x9kLyaF40nHbaBwnTYY0tc/JVWXSYKSEa9bNoVC1DwIYuWz4Q
         o1O7CNK5QPNwv3zf7D9MCMy2y2TyfJxlcf4PMxaqvjzLnfZ2LpfhLoIoxGntDHwVqKCa
         zBSs2ETYvnAyF/wRMxI7yn74L75BaZ2s5CNFbT3C/i9tTjok9OkzyJIVkE3cs/mJduYe
         vaUA==
X-Forwarded-Encrypted: i=1; AJvYcCUaNi0Aytbp5K1clzPtArrJEjbbQNLN27o8Jmz5uaXi3VSIwYlJDPEL/RyfJouStWEAW0HG+heTbqM=@vger.kernel.org, AJvYcCWcSExw+XNC8gOG7LR71qYqijrNPucIaLCvPRAaf0NjEdPsa2CaOEiZWLVZXlS3S4vFrKeWR138WvVm@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8T9r69Nd4GKvMxzs8a/FrjjC6cgFWE/myXSY8Tt2B5a11/T6
	FseB2GFvEXpDSG+61AXwHXvyeZt0ZZJwbQJ2mYGbXNNlXY6Ui83sIZbaJ6dns+qoQMJLQhvJdrL
	ExZqlukPOUYolbi1kDqrxDcxGe2TRwVM=
X-Gm-Gg: ASbGnctKKL9ufHYeIfAE7ixji8umJ8vZ50HfgIqzCaIukZCm9yJ8n1ApmQ4d9tFixNI
	uTkAuvlKR9hov3l2bFwFJsw3I+3d0gKXLZlDAcx4yPSW2qPgtE6OZGSc8J/DGGURVefVFFKASCz
	d5ChL67jvXhWiRDmAufKgcg68dZavdKQ0IiYJ4kESP67YPgXfZP6y/oKRi4r3W9/BsktMwnDcAE
	UxhTRashzFeBltFj3ZD7xBMyQkRKPWc+2FyBqRBkCzS8v3c2woSppY4f8jjrCuFVCwejRv3f916
	odjY
X-Google-Smtp-Source: AGHT+IHaij0sVaJ6ogaPQCO9IKBgADMM0ztIHx86w8groy7y8g8JAMnXJW1JkHtngSu5rwitc9gzhu/qbDgn8SocPoM=
X-Received: by 2002:a05:6808:23c3:b0:437:e679:79c with SMTP id
 5614622812f47-437f7ceafe3mr137481b6e.12.1756509919345; Fri, 29 Aug 2025
 16:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756451884.git.lukas@wunner.de> <42726e2fd197959d6228d25552504353ffb53545.1756451884.git.lukas@wunner.de>
In-Reply-To: <42726e2fd197959d6228d25552504353ffb53545.1756451884.git.lukas@wunner.de>
Reply-To: linasvepstas@gmail.com
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Fri, 29 Aug 2025 18:25:08 -0500
X-Gm-Features: Ac12FXzU95lbyYwfEX8tEnCZZpSB4eS1i5zDWjaJAsRdUyyG8eFVpBZdfMozsGI
Message-ID: <CAHrUA364QSpcJOu=96JV-3hR9G5M0FSUPNhb4AspULAcXvQP6w@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI/ERR: Amend documentation with DPC and AER specifics
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Terry Bowman <terry.bowman@amd.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 2:41=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> +   On platforms supporting Downstream Port Containment, the link to the
> +   sub-hierarchy with the faulting device is re-enabled in STEP 3 (Link
> +   Reset). Hence devices in the sub-hierarchy are inaccessible until
> +   STEP 4 (Slot Reset).

I'm confused. In the good old days, w/EEH, a slot reset was literally turni=
ng
the power off and on again to the device, for that slot. So it's not so muc=
h
that the device becomes "accessible again", but that it is now fresh, clean
but also unconfigured. I have not studied DPC, but the way this is worded
here makes me think that something else is happening.

-- Linas

