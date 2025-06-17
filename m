Return-Path: <linux-pci+bounces-29972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F13CADDC41
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 21:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2013E40254C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 19:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E5128AAEE;
	Tue, 17 Jun 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImeXYWeH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F625A334;
	Tue, 17 Jun 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750188287; cv=none; b=P5W1I0wWXjGc7AojWSpX8O9Hoq+cR0N8hoNexZm29tp+HbTaUUvD1Df8IqWY650xjYNji7JbLA87FSVEm2VmEjOAO/rWVRlOnpolMV/Xl9nnzbkY9RFqdpf32deCewFIZtIfVH/lI7uD3xfEvXDj6ju/+5g/NDVZFr+k9DEpoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750188287; c=relaxed/simple;
	bh=NVq4bJPC87OrYBibcu75PkM9np1jsYMAmLgnABHikSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmtdXZpRWvm6Ed+haDdchdsXYdGSg0bk/r6ashFETW4dc9ukky8pjfrK1e2qedmirHWy1lsiNT1uE5kCssSQXqXG5zVvfkcOXeSerx4vdwKqD1TPia8PEWUp6/+8crZ6p5UGLq4wYflE0561CWuVZVNHbMrfn60lGUVWCRT/pEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImeXYWeH; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b595891d2so24723201fa.2;
        Tue, 17 Jun 2025 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750188284; x=1750793084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E32c5RFJYZM9jGHfnakeuQyDnVaI0nCOfN94RWXfGg8=;
        b=ImeXYWeHzbWK/6T64P04Z7GsR9qixETPEM5A5vV773LVJPLNn9/XFj62uxMZPp6b92
         5WFKh+sdD1x/f4rw4fZbBinqUvkLblwGeEPbdq17pdZX4dIxwVJYdqyYcLv0755sgm0y
         xbpoopgfjPKs+9dPnJcJoSD/NDcESv/dGzx7XDjZyLP1L0XTpwak3NHGETtnIM/KFU0c
         yudg9WDGABTh7ADl4WXnR7zEQNbNj1Hib9fC1hrvks0Kc9rSvEpmvZ/sxyEXKjVDw+XB
         IVtVCaa+yw+MLQ6UOo8R/x9m+nDy8OVybiWp+GNl+HSvIfP+R36QKiltqmGCRrnUaEeD
         DoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750188284; x=1750793084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E32c5RFJYZM9jGHfnakeuQyDnVaI0nCOfN94RWXfGg8=;
        b=vN7k2qa76dHpTFWmX5vfTebvnnJwvbt27rokgkn6Kptc0bOM7lUDEEckxrLTFZYKUQ
         t2KzD1joZyL1UEtjjOv9co2zRagJnbCP5puK5U/lsuVMgzWVdb/Zr4kcTVloDkZLNIHp
         Lc0amNd01MXTNSU93njDYvDWm8XHr2jj1/3oZqEMIOf3fv4NPyv2TgZu3RoU2S8N87um
         reES1K0XM/CYpOJZ3GcQPbHMij830LZC8pd3fpwfK55UYyM7CKtWvVYeK1SlsI7frbP6
         vei/gezSuiRYTZvtaS6i6tvO5yq0OKPSJSGHUw5E9F1zeVUtnqJHfXX+98fDlxFSQkOk
         J7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZpTU1gMJvU7/vXg19tQUzHocBAjzOD1Dr3A6tCkY6D29+/xjgsOwM2nSfSFhjIyEjUSQ7MNZJpItXIRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqvv7PAFzhsFHDtSoRAyiON+MbP/vBRJwGGwigYQQDcuo4QpU
	A7xnkUWIJnB7O9mlDkB0K7CjubUy9PIQDjt8Poo78DRE2tDlIS3364DKLJv2AfTmz4D0HWekfLW
	wxa/aSllgZUpL90jIfeX1wFFF9GGTBOo=
X-Gm-Gg: ASbGncvxCtA/jRnvIcyEF1Jba2fgQeXNI5Mt12hreAOhLRYEjfEEnZKOrURnjGHyaAw
	cPYfYXE28GgVstBjpfxeYPa9Whe7Bj7wkUPWdBiM/fOJZbGUqR/PzNZW0KRTk9PKGGeAAqgoK02
	rkGgOWW/7bsvnCcG3uwaxbyZSShDNRI9dV/9kuY20iItlpW0kCBVwcm19vzz9uSvikkGiFMmrVF
	824
X-Google-Smtp-Source: AGHT+IFeRRlJdOkye1DoYPuZQXVCJZ7xvW17k3+gX3t97yT6MSy+jL3T4341z4P2POOFHfKv7hcx6jPqIsON6JTSFy4=
X-Received: by 2002:a05:651c:1987:b0:32b:3cf5:7358 with SMTP id
 38308e7fff4ca-32b4a5c4531mr50932491fa.28.1750188283483; Tue, 17 Jun 2025
 12:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611190056.355878-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250611190056.355878-1-akshayaj.lkd@gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 18 Jun 2025 00:54:32 +0530
X-Gm-Features: AX0GCFvvyCqvsVdhQnKmvJkfpZXnjkosl0Jz_b3GjAbl1DeOvvB5c6_D1FCMHu0
Message-ID: <CAE3SzaQS66-vbwKe18i=fMGa-B+JZ4P=za=bOTutoTxOMwANKA@mail.gmail.com>
Subject: Re: [PATCH] PCI/AER: Add Error Log in case when AER_MAX_MULTI_ERR_DEVICES
 limit hit during AER handling.
To: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, 
	Jonathan.Cameron@huawei.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	kwilczynski@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com, 
	karolina.stolarek@oracle.com, lukas@wunner.de, pandoh@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:31=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail.=
com> wrote:
>
> When an error is detected at a PCIe device and the root port receives the
> error message, the threaded IRQ handler aer_isr traverses down the
> hierarchy from the root port and keeps on adding those pcie devices on
> which error has been recorded into the e_info->dev[] array for
> respective error handling and recovery. The e_info->dev[] array has size
> AER_MAX_MULTI_ERR_DEVICES which currently has been defined as 5.
> This change adds an error message in case this limit is hit.
>
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
>
> Testing:
> =3D=3D=3D=3D=3D=3D=3D=3D
> Verified log in dmesg on QEMU.
>
> 1. Following command created the required environment. As mentioned below=
 a
> pcie-root-port and a virtio-net-pci device are used on a Q35 machine mode=
l.
> ./qemu-system-x86_64 \
>         -M q35,accel=3Dkvm \
>         -m 2G -cpu host -nographic \
>         -serial mon:stdio \
>         -kernel /home/akshayaj/pci/arch/x86/boot/bzImage \
>         -initrd /home/akshayaj/Embedded_System_Using_QEMU/rootfs/rootfs.c=
pio.gz \
>         -append "console=3DttyS0 root=3D/ pci=3Dpcie_scan_all" \
>         -device pcie-root-port,id=3Drp0,chassis=3D1,slot=3D1 \
>         -device virtio-net-pci,bus=3Drp0
>
> ~ # mylspci -t
> -[0000:00]-+-00.0
>            +-01.0
>            +-02.0
>            +-03.0-[01]----00.0
>            +-1f.0
>            +-1f.2
>            \-1f.3
> 00:03.0--> pcie-root-port
>
>
> 2. Kernel bzImage compiled with following changes:
>         2.1 CONFIG_PCIEAER=3Dy in config
>         2.2 AER_MAX_MULTI_ERR_DEVICES set to 0
>         Since there is no pcie-testdev in QEMU, it is impossible to creat=
e
>         a 5-level hierarchy of PCIe devices in QEMU. So we simulate the
>         error scenario by changing the limit to 0.
>         2.3 Log added at the required place in aer.c.
>
> 3. Both correctable and uncorrectable errors were injected on
> pcie-root-port via HMP command (pcie_aer_inject_error) in QEMU.
> HMP Command used are as follows:
>         3.1 pcie_aer_inject_error -c rp0 0x1
>         3.2 pcie_aer_inject_error -c rp0 0x40
>         3.3 pcie_aer_inject_error rp0 0x10
>
> Resulting dmesg:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.380534] pcieport 0000:00:03.0: AER: enabled with IRQ 24
> [   55.729530] pcieport 0000:00:03.0: AER: Exceeded max allowed (0) addit=
ion of PCIe devices for AER handling
> [  225.484456] pcieport 0000:00:03.0: AER: Exceeded max allowed (0) addit=
ion of PCIe devices for AER handling
> [  356.976253] pcieport 0000:00:03.0: AER: Exceeded max allowed (0) addit=
ion of PCIe devices for AER handling
>
>  drivers/pci/pcie/aer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 70ac66188367..3995a1db5699 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1039,7 +1039,8 @@ static int find_device_iter(struct pci_dev *dev, vo=
id *data)
>                 /* List this device */
>                 if (add_error_device(e_info, dev)) {
>                         /* We cannot handle more... Stop iteration */
> -                       /* TODO: Should print error message here? */
> +                       pci_err(dev, "Exceeded max allowed (%d) addition =
of PCIe "
> +                               "devices for AER handling\n", AER_MAX_MUL=
TI_ERR_DEVICES);
>                         return 1;
>                 }
>
> --
> 2.43.0
>
Gentle reminder.

Thanks,
Akshay.

