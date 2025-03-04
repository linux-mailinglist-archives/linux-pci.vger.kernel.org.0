Return-Path: <linux-pci+bounces-22849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 019C9A4E25A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415B7188870E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E86127C142;
	Tue,  4 Mar 2025 14:57:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE60627935A;
	Tue,  4 Mar 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100238; cv=none; b=AAkSOj/RUyXq6IB7XCU9R/UuT9/ryh4hy/wLT6B2wekLcmbZg7H5DgKLL/qQI0m6BLPqqJX5cVguJeNZr+wN+2zvsioCwpVo32Z8oQE4+iYYUlzl5vRK2g1N0zpvjv+04dXpslTm2g+4j4jzxrrc3kVnMRyaanfYz168gNrjsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100238; c=relaxed/simple;
	bh=x1CoI5BgFiS3Owp5p1mD+l1Q9+YlbNW4fVkZBG1ygbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/UysQV4P5Nwe4x4y18B9CNcW1cOhKapwkbGAsxituHaeYtTOtEs0RjFpu0xHPszo/v1bmxbQ/s4+zYBqxv25qR66xDRQUzPMR7izlayl6cpIc+edYWzZlaRfgIU7leAmMixcYhAwjmnFRrxuhtXLTuyvPJ72Dwri4sQHpQtuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8670fd79990so2174947241.3;
        Tue, 04 Mar 2025 06:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100234; x=1741705034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnx0gcUzGjGC6Jmsd1CoV+gv4tw/ToY0SgPfV1Ikf3c=;
        b=bo4gx59NtGFcyB3XsAtkLhwkURZ/JIn1S1lJ2RZe24WNDPTS3RfTwkA8OYktvgmOqI
         VbMXYSAjwRIjoSM4WKy/J3ANU/14Kvyg4Yz4oVzPlMpi99oMFGgFlof7OpA85XjlrZ1v
         XaYnpFIuGUW8l8Mn7vpsa3Ueq9KphEACv/32p31l3D0xZUiYC1hRutBzkS41tQR3jyhW
         P3TiJ01CsPyyJVopdFGpGdiPY4Gtefi7SEsmG8oNeT2AN3y++A4OdpIeCX5G1kGgVRs8
         sywZwOXRwt8SMQ+giYvZe1ur1XegRscRvBLOOX10YkUfLI6TKHylam+h0y/KhJIP04w8
         X5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFFJo9yOZTO61uy/1x58+zqCTscJUreJ/EPBh3UD35ACfNzIYshGZ1bFast/uE3y5vRJEE3btUlikU3i0=@vger.kernel.org, AJvYcCUJFIdznuWB/As86r4/P6GZiRfCFK9NpZZUpQjioV+IlEUhFHSo47E3bQ7Gqr/R89kKo7yQo/MQfWXX@vger.kernel.org, AJvYcCWFaJM9hUqBKzFvkH7fyA5PAHcgkDfgaoHzhb9/kfAcN1UOjP5bURWOUiuSI/GX0Mylyh3a8FsvFwCVMoNPZKANeQ==@vger.kernel.org, AJvYcCXvyvdi1z0eAvg8IWMmqDi6bDjf9dkjtkM9zPkApc2fb5bOYHksMkyW2Pj6cIJxAd7R188XlOPJYhgfCNqKkGogdcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkxID0NhasrsCmQkUTAkMdlaIMo6BIUNo/Mh73Y2VBeafxDCU
	fz98cxDPwhN6/Bih/ulvKR8580fcHRv5FJCh+4dymVANaOKcrjHyvvxHpN26
X-Gm-Gg: ASbGnctOrPcmLNaXN/tjI7hu19GDV4m6u2hb93ft9QPDRgUNgq1FuqbwQHSPTk8CwR/
	BF9kEuoBMjU7Tqu0M8xqMsh2C2v5107MSy+90uRw1k/sLd78w2zsP3JctkeeXt+28ZhmqsXSD/B
	KUVdIsmZtt32uA7QYJDtyDy0EjdUhDKTfnY+NTYxH/uWHuGP1W8B0sjhn3MkAxCK9pDUFORzr3B
	JIef7jUqUwmx6uggdL6ZfZJQy5jdPbrz8y2KKiIdS8DKID2SUf3voRo5xnd/NIUah7JxQh6oOVT
	4B1Yf5b9Lzh2TAFiznMuMTzthuPdfcv8ccARASfe7beBI99EAJ7lo9cZ0r+Q+wTKAiojU84ml2v
	Ymn9hFo0=
X-Google-Smtp-Source: AGHT+IEvgn6ehT30BZbeKFHQWWEjO2KSYu1Wgtk15cF0fx7ifrHdaALThSfwaugd/Uj+xUfo2dgZzQ==
X-Received: by 2002:a05:6102:3346:b0:4bb:e14a:944b with SMTP id ada2fe7eead31-4c044ee23d6mr10543904137.20.1741100234161;
        Tue, 04 Mar 2025 06:57:14 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c16ba4f676sm2014309137.21.2025.03.04.06.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:57:13 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86b2e0a227fso2391229241.2;
        Tue, 04 Mar 2025 06:57:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVStgJU6BIZpmcddXV2OLPQBDS5X8OhTDvLzFuU7ru81ldXn9ImzW6HsjmF1rnzEFNlOnSsBU2ASwasthA=@vger.kernel.org, AJvYcCWCfsiq4VujOiusWTfeIpfqrqMfM2OnRRyDKq3uPqfOf5qHq8S5104uH/P1uzoyL/fSdC3uUr6o2m4zG/rpZOwdpg==@vger.kernel.org, AJvYcCWlxk+GsN0ZW2+w4ndfcSYOsRKcVY42uONxci0ivl2kbzfcXPR4Nf5XaBNNTgpD53rg8Z8rH9jtclHP@vger.kernel.org, AJvYcCXoPX2gBY6QX2hBHUr11XhFBBk/jjfCoOwSkwEL9THCrXlRTa91EB17A++PuP5A5zyXjfRumIxiZKIvipwjVSPINAM=@vger.kernel.org
X-Received: by 2002:a05:6102:3346:b0:4bb:e14a:944b with SMTP id
 ada2fe7eead31-4c044ee23d6mr10543879137.20.1741100233150; Tue, 04 Mar 2025
 06:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221131548.59616-1-shradha.t@samsung.com> <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com> <Z8XrYxP_pZr6tFU8@debian> <20250303194647.GC1552306@rocinante>
In-Reply-To: <20250303194647.GC1552306@rocinante>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Mar 2025 15:57:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWens9ZZrjNH1Bd2AN3PJEP1KSUGdiJcBCt0uPGH_GiiA@mail.gmail.com>
X-Gm-Features: AQ5f1JqCho8yfOlMgARNkOLJkO3vQy-dmfB5AhRkVmxo4nrVO_CH507OBRi_NRQ
Message-ID: <CAMuHMdWens9ZZrjNH1Bd2AN3PJEP1KSUGdiJcBCt0uPGH_GiiA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, Shradha Todi <shradha.t@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, Jonathan.Cameron@huawei.com, 
	a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org, 
	18255117159@163.com, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com, 
	will@kernel.org, mark.rutland@arm.com, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

(CC corrected)

This patch is now commit 1ff54f4cbaed9ec6 ("PCI: dwc: Add debugfs
based Silicon Debug support for DWC") in pci/next (next-20250304).

On Mon, 3 Mar 2025 at 20:47, Krzysztof Wilczy=C5=84ski <kw@linux.com> wrote=
:
> [...]
> > > +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> > > +{
> > > +   char dirname[DWC_DEBUGFS_BUF_MAX];
> > > +   struct device *dev =3D pci->dev;
> > > +   struct debugfs_info *debugfs;
> > > +   struct dentry *dir;
> > > +   int ret;
> > > +
> > > +   /* Create main directory for each platform driver */
> > > +   snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(de=
v));
> > > +   dir =3D debugfs_create_dir(dirname, NULL);
> > > +   debugfs =3D devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > > +   if (!debugfs)
> > > +           return -ENOMEM;
> > > +
> > > +   debugfs->debug_dir =3D dir;
> > > +   pci->debugfs =3D debugfs;
> > > +   ret =3D dwc_pcie_rasdes_debugfs_init(pci, dir);
> > > +   if (ret)
> > > +           dev_dbg(dev, "RASDES debugfs init failed\n");
> >
> > What will happen if ret !=3D 0? still return 0?

And that is exactly what happens on Gray Hawk Single with R-Car
V4M: dw_pcie_find_rasdes_capability() returns NULL, causing
dwc_pcie_rasdes_debugfs_init() to return -ENODEV.

> Given that callers of dwc_pcie_debugfs_init() check for errors,

Debugfs issues should never be propagated upstream!

> this probably should correctly bubble up any failure coming from
> dwc_pcie_rasdes_debugfs_init().
>
> I made updates to the code directly on the current branch, have a look:

So while applying, you changed this like:

            ret =3D dwc_pcie_rasdes_debugfs_init(pci, dir);
    -       if (ret)
    -               dev_dbg(dev, "RASDES debugfs init failed\n");
    +       if (ret) {
    +               dev_err(dev, "failed to initialize RAS DES debugfs\n");
    +               return ret;
    +       }

            return 0;

Hence this is now a fatal error, causing the probe to fail.
Unfortunately something fails during cleanup:

    pcie-rcar-gen4 e65d0000.pcie: failed to initialize RAS DES debugfs
    ------------[ cut here ]------------
    WARNING: CPU: 3 PID: 36 at kernel/irq/irqdomain.c:393
irq_domain_remove+0xa8/0xb0
    CPU: 3 UID: 0 PID: 36 Comm: kworker/u16:1 Not tainted
6.14.0-rc1-arm64-renesas-00134-g12c8c1363538 #2884
    Hardware name: Renesas Gray Hawk Single board based on r8a779h0 (DT)
    Workqueue: async async_run_entry_fn
    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
    pc : irq_domain_remove+0xa8/0xb0
    lr : irq_domain_remove+0x2c/0xb0
    sp : ffff8000819b3b10
    x29: ffff8000819b3b10 x28: 0000000000000000 x27: 0000000000000000
    x26: ffff00044011d800 x25: ffff80008053294c x24: ffff000441740400
    x23: ffff0004413a30f0 x22: ffff0004413a3130 x21: ffff0004413a3130
    x20: ffff8000815c0ec8 x19: ffff0004415f8240 x18: 00000000ffffffff
    x17: 6775626564205345 x16: 0000000000000020 x15: ffff8000819b37b0
    x14: 0000000000000004 x13: ffff8000813e9dd8 x12: 0000000000000000
    x11: ffff0004404b6448 x10: ffff800080e85400 x9 : 1fffe00088334301
    x8 : 0000000000000001 x7 : ffff0004419a1800 x6 : ffff0004419a1808
    x5 : ffff000441349030 x4 : fffffffffffffdc1 x3 : 0000000000000000
    x2 : ffff0004403e0000 x1 : 0000000000000000 x0 : ffff00044134f630
    Call trace:
     irq_domain_remove+0xa8/0xb0 (P)
     dw_pcie_host_init+0x394/0x710
     rcar_gen4_pcie_probe+0x104/0x2f8
     platform_probe+0x64/0xbc
     really_probe+0xb8/0x294
     __driver_probe_device+0x74/0x124
     driver_probe_device+0x3c/0x158
     __device_attach_driver+0xd4/0x154
     bus_for_each_drv+0x84/0xe0
     __device_attach_async_helper+0xac/0xd0
     async_run_entry_fn+0x30/0xd8
     process_one_work+0x144/0x280
     worker_thread+0x2c4/0x3cc
     kthread+0x128/0x1e0
     ret_from_fork+0x10/0x20
    ---[ end trace 0000000000000000 ]---

Worse, the PCI bus is still registered, so running "lspci" causes an Oops:

    Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000004
    Mem abort info:
      ESR =3D 0x0000000096000004
      EC =3D 0x25: DABT (current EL), IL =3D 32 bits
      SET =3D 0, FnV =3D 0
      EA =3D 0, S1PTW =3D 0
      FSC =3D 0x04: level 0 translation fault
    Data abort info:
      ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
      CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
      GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
    user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000483b53000
    [0000000000000004] pgd=3D0000000000000000, p4d=3D0000000000000000
    Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
    CPU: 3 UID: 0 PID: 707 Comm: lspci Tainted: G
W6.14.0-rc1-arm64-renesas-00134-g12c8c1363538 #2884
    Tainted: [W]=3DWARN
    Hardware name: Renesas Gray Hawk Single board based on r8a779h0 (DT)
    pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
    pc : pci_generic_config_read+0x34/0xac
    lr : pci_generic_config_read+0x20/0xac
    sp : ffff8000825cbbf0
    x29: ffff8000825cbbf0 x28: ffff0004491c4b84 x27: 0000000000000004
    x26: 000000000000000f x25: ffff0004491c4b80 x24: 0000000000000040
    x23: 0000000000000040 x22: ffff8000825cbc64 x21: ffff8000816fb4f8
    x20: ffff8000825cbc14 x19: 0000000000000004 x18: 0000000000000000
    x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
    x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
    x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
    x8 : 0000000000000000 x7 : ffff000442c653c0 x6 : ffff8000805163d0
    x5 : ffff8000804f3334 x4 : ffff8000825cbc14 x3 : ffff800080531990
    x2 : 0000000000000004 x1 : 0000000000000000 x0 : 0000000000000004
    Call trace:
     pci_generic_config_read+0x34/0xac (P)
     pci_user_read_config_dword+0x78/0x118
     pci_read_config+0xe4/0x29c
     sysfs_kf_bin_read+0x8c/0x9c
     kernfs_fop_read_iter+0x9c/0x19c
     vfs_read+0x24c/0x330
     __arm64_sys_pread64+0xac/0xc8
     invoke_syscall+0x44/0x100
     el0_svc_common.constprop.0+0x3c/0xd4
     do_el0_svc+0x18/0x20
     el0_svc+0x24/0xa8
     el0t_64_sync_handler+0x104/0x130
     el0t_64_sync+0x154/0x158
    Code: 7100067f 540002a0 71000a7f 54000160 (b9400000)
    ---[ end trace 0000000000000000 ]---
    note: lspci[707] exited with irqs disabled
    note: lspci[707] exited with preempt_count 1

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

