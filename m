Return-Path: <linux-pci+bounces-31505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A75AF89C1
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 09:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F455883A9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780827CB04;
	Fri,  4 Jul 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PTeay4dG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483E27A101
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614921; cv=none; b=hnKmk913kEBrQRo1eMq4jBvpO+4yiCuQ4r8wJJ9V7yg5hI1awcBTBP8lNV8YDwzTmqKA/U8InFJXb5Obl6tbPr0uv1MzJS17Qm41iP+REcp3x1kC4DK3QFHkBLQhDOzHjykYneWMo1Xg1bkh9jxIQ0OxkQaa1RGBMRmanjs0ye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614921; c=relaxed/simple;
	bh=ZU/GI74q8CYc+4uxPZ3famiEgwCI2Cd/zxvHpn0VDXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgeXMrrtBIeF/Yk4YYE0tncs2WIxwnZA7cOykDiHTPkNfY950jJnx9s+TdqGNQ3krhhEV9mAX/J/ZXtI2O9fHAUjmus2FNkpVnNPY4TBzLVSkdV12zVgU/y8LedCEYshm1UuHhUz9LiaV5ul0aM5A9lEldAaNDZvto6NBaLlDNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PTeay4dG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b6da713f2so1075751fa.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Jul 2025 00:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751614918; x=1752219718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU/GI74q8CYc+4uxPZ3famiEgwCI2Cd/zxvHpn0VDXA=;
        b=PTeay4dGQd0jMrkNDiea68A0zMriShzP3dR5rRDIFwfR0oUtJOrhZgzKhBni17Ffc2
         Fli0mdU9dZQJcPyjoCT1Amo9doUGd2Z9v2h/R76wRoEOkvG3w8ey/4fVfHCHO7plsyUq
         swwgO4L63wrksTLbwQZR6Y4Ti/tf2xEWCEeFdAf1EMCte39nkKzAwG74SrCeYHYWYpZd
         UR5sJxZMRvfGK5WPDWHinJjz4QuGFfgLRJFPKxXzZ+pbCpVwcjFnA4wvEDk3dRgXIbrE
         4z+cTorJhAX9mqDCgo2E0k7IiWBXAkaTcdMTo58YqcNDRPffex6BdJHoyvf9XSgcKhxr
         m9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751614918; x=1752219718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZU/GI74q8CYc+4uxPZ3famiEgwCI2Cd/zxvHpn0VDXA=;
        b=WquHUzmAMGYtPoXbs+UPrIl8BD5p2Ay25F6ifenA0xgIz1jOQjd1lIuGej0ogWySbT
         y7gHe25DNaRRzBlZ8M0s5A7PCMQTPtx7ehzOoXr/HoYgvESri11n2RuC2Ky/t386fbOI
         ESWFSqGrHXo/9EvYeQG3r155JnlKScV9OrAcSUcoXhFglbJaArXC3Kc/W7QCoFn72QS2
         +heV3Rg2QvDCSytXdEZFZukmRLEB062HmJdOEthMsH166TgBP2dvRclXe5XMvbil1GAR
         OlybnOhCG6juGJbrYO3g0+i9RbUdePcxJ/lkxj505cz3vKEuuTATQcFk1+n7aUDKZkS7
         qapA==
X-Forwarded-Encrypted: i=1; AJvYcCXwbxd8siLchUDF3vGQNnhc3OXX5mhxevBOS5YRBwhT4JxH0NpdiWmnf4Xz5LuzJ5Gn6U3L44qVloY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT/EXczT/wLSg4xme6tx8Xn7cGv9Z5rsHaQQGQW+Fek3UF0HFh
	p7qWTQS+r1CeNM4cdFbKuDa08/YUZtBNYA0MAvfn2h/N9SDaqHfIaaIDHhfmREg7o2dBScvDxwt
	NmFVyKxcbrCy+sWykkcDWAVAoqwXwHPPvdGZt16G+zg==
X-Gm-Gg: ASbGncv9aTSeZUhhc0VFLG5CXT7YMSEoUPBCFa8anraEvXLysTXy/rqxwlGRfI2H6gd
	Tc/PjlRqbwi/JAg0U1y2C+rUho/ApB/C6uEI+T3l2GvFf0QEI4hHfLHw6EXxRWuTSNvYam9nShF
	BYjzpsG0DykdaCuWJWQ27UpRWAKOPkRdK+q2MoOj/qHXwu3jo1OFdd58F93f4A
X-Google-Smtp-Source: AGHT+IE3uywphxdB/hgrGdClLGMEDafSpYMGMbgzUpKHzptOOdooBFzvpx420YP2PAZqld8Hm+pbqS2RYe1dK7NZ3eg=
X-Received: by 2002:a2e:a99f:0:b0:30b:d156:9ea2 with SMTP id
 38308e7fff4ca-32e962d5136mr1478751fa.0.1751614917893; Fri, 04 Jul 2025
 00:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702155112.40124-1-heshuan@bytedance.com> <aGYkx4a4eJUJorYp@sunil-laptop>
 <CAKmKDKksSTrT=wMBpnqGupe4WRnHosYZLunw0FdVbhW_dyym+A@mail.gmail.com> <r7fgb5xrn6ocstq6ctq4q7r4o2esgh4rqr44c3u234kcep6thk@bge2vzl33ptb>
In-Reply-To: <r7fgb5xrn6ocstq6ctq4q7r4o2esgh4rqr44c3u234kcep6thk@bge2vzl33ptb>
From: He Shuan <heshuan@bytedance.com>
Date: Fri, 4 Jul 2025 15:41:46 +0800
X-Gm-Features: Ac12FXyDQukuHY5FB-0tXjb3qsjlMtbnAerUDAyQxsD0jYsZK2sVM1WeS67ZI-U
Message-ID: <CAKmKDKm_5TXKafWVVMoRdj8Zp=up7YXQ=-CMO=VDHg6KLw-dTQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC 0/1] PCI: Fix pci devices double register
 WARNING in the kernel starting process
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>, bhelgaas@google.com, cuiyunhui@bytedance.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mani,

Thanks for your comments.

>But in your case, looks like the PCI device is available somehow before
>pci_proc_init() gets executed. Now, it is not very clear to me how the device
>becomes available at this point. It might be due to some other issue. But in
>anycase, I think we need to get rid of calling pci_proc_attach_device() from
>pci_proc_init() as I don't see a reason to call this function from two
>different places. pci_bus_add_device() should be the one calling this function
>as it is the one adding the PCI device.
Got it. I need to figure out why the PCI device is available already before
pci_proc_init() is executed. (Actually I didn't change too much source code yet,
basically running my test based on the upstream code).

>Ironically, I do see a similar pattern for sysfs also. Maybe there is (or was) a
>reason to create these files from two different places?
Yes, I see the sysfs register confusion (pci_create_sysfs_dev_files) from
pci_sysfs_init() and pci_bus_add_device() as well. There do have concurrence
protection through pci_bus_add_device() paths, so I agree that function
pci_proc_attach_device and pci_create_sysfs_dev_files should be called
from pci_bus_add_devices().

Anyway, it appears there is a great deal of work/effort needed before
making this part clear. :(

Bests,
Shuan

