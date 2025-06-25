Return-Path: <linux-pci+bounces-30613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FD7AE7F43
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D3017CE3F
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9493276037;
	Wed, 25 Jun 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC5+MBtM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3ED7D3F4;
	Wed, 25 Jun 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847371; cv=none; b=GhpAEREL3ssIisOb7Ec3iTSKcLM6eaNoB8taRS56GvAJR+mmmWkbaQRRVomk07hhzBrRsuNdvfzGbxpfmYqLqecFj64gg7UHQcVEiRX5nYJRlAgvkCON9SwaGGPnCqqQqnuFBi/XEoUCQ+3EmGeI2bGxBxpNRd+DInuije9NLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847371; c=relaxed/simple;
	bh=+/qduDCOUlNU6dPw4M1+ZnpE3nxnSrlWF35phykoJh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p56p/KHy0iy7k6OgcnZjO/0FnXadp6YYDWcbjMsK++Pik7OIWtevAwfAoAAqZbTO1o5EHS3nDjOlLHaFTcwiOwf/e3yUbuK6vsLxZC6DfQWkV3u/ZEwzwYkQxTvM5AwHui/3hw/44+AIYG+wVRPUO6ec+ix08WEzlRo86yGA0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC5+MBtM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b7f41d3e6so7715551fa.1;
        Wed, 25 Jun 2025 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750847368; x=1751452168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM3c9e5wSrfbRp9c9ZXczT6HCLXxNZCoTjQg0rj1vTQ=;
        b=bC5+MBtMCAN95VXjOrbOYQvPQH7UBup62DG5nzbFQB9qMpeRjEBbhS3TGFCW2pUVem
         kX/X5TBfPoHFSnOdXLMSRFVLClbWp7rTCLJKQWv/ex/28RnFvC3ZjcCfjih9ob+GmAnK
         8Z0Iret0j+x1mRP1qqkYQt5DpD0ZmhwddDVa8yiNh1MzQwZS1/EAOEfnooeBA3ND7O4Z
         DURj2ZYz1kTeBC980I++xFz4TZPbheB4Xu5VLbybVcjBIPgD1p1uWv00tiVlmePRd6GJ
         GOD9q9k3LZlBRneHQmYA2m7AD45c45EWTqpWNuuSJf7nD7+6QXgr6+Ny7BkX4RYHvY6J
         fYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750847368; x=1751452168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM3c9e5wSrfbRp9c9ZXczT6HCLXxNZCoTjQg0rj1vTQ=;
        b=Bs8gqtG86g3l1qM8XJhp2bsPn16s5li9aTFAbDN2O/65gIXKFQx3HocGDj2OsGVmiV
         b8PldVagQ9XZeGIwUrIQJz1p5NRUwH5Iyup6P47YaJiw1OpHPgCO44lKIW1dSfk/0Wln
         zG89l9qKssxVwVhVnKJjFGR8XYLJF8Wv5fOt/Tnb7dc56w8T/BeblltZGl7tWMddzz5U
         5e0+sdYa5e3UOWH2qNEuVQJz+BOPbWAkHdgcHl5KTSM1d6Ds1PGjnoQcJ9XX/F1/EILs
         4mFDJYCtW4Izc8wieKuoyvKuYordsJfO8oBR+9JlLxyRZspaVvREZX86pdsVbs4mFkd2
         yprQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLRpAD7CuuSN3/WZvy5Q78VbnhG1s2Ya1Qg2ynPg2uQufPPzon6uCA8xXsxxS+Ak8Nbrs398h5NwSsoQ4=@vger.kernel.org, AJvYcCXuLPUEx1qsQN2nthWIUVYVf2wepeSB3cZI5FbxFqwRIAIzdek2umY78AaiRrI0//Nqch7c6Q7IsvuJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxqeI9sWvFtTVdqb94jiwOD9MMgccIsLZfoR0Q8+bVoaywKjMIU
	bTap3Q4jfLnJY3x5SSYXPH+tWHLlWlcAyw1zEQ9ikHQ4xLwXJtAlOh5axCA+OPvH57f9tjUjYHB
	p2hFARnqzltyG+UUo4CS7HbtWrq8Zr4E=
X-Gm-Gg: ASbGnctOi/1tCsUcPSlX+VvUmXgubji4Kq3rI+BdXUuz+IIvBO/6btrPVtK++QDBNzY
	mgXmhMv7IDSka/IrhU89PNOz3mzXlH+30ZS/44Z93ZzJj6imudEbu1BCgdQVZxn1zJZRrWRVemP
	K0zu05RNiBi22+T4mddUn9F8xnMZVZN40jHB02tThSGPzQr4YmxQsA4p1nKlzB2eZqGMfbbXSB3
	tEUNg==
X-Google-Smtp-Source: AGHT+IFISN04ZOP18U0BKlCxvkOJLYyUdh/QH55alVYxrtxt/fMmb4vhG3jM4eVCBtZWmrfJCiVn1slL8U5TmhYuF/g=
X-Received: by 2002:a2e:a604:0:b0:32a:666e:e087 with SMTP id
 38308e7fff4ca-32cb965406cmr15521691fa.10.1750847367449; Wed, 25 Jun 2025
 03:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619185041.73240-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250619185041.73240-1-akshayaj.lkd@gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 25 Jun 2025 15:59:14 +0530
X-Gm-Features: Ac12FXzi8juwawXHmcXVfoX0UqAOsQsrMRwCnymJ4_SABUZhj6JZg91TE-X7X_8
Message-ID: <CAE3SzaR=tXp4nKfVC7AGzh2U2fdWqVNeNeZJs-bDws+tej-f=Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/AER: Add error message when AER_MAX_MULTI_ERR_DEVICES
 limit is hit during AER handling
To: bhelgaas@google.com, helgaas@kernel.org, mani@kernel.org, 
	manivannan.sadhasivam@linaro.org, kwilczynski@kernel.org, 
	mahesh@linux.ibm.com, oohall@gmail.com, ilpo.jarvinen@linux.intel.com, 
	Jonathan.Cameron@huawei.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	lukas@wunner.de
Cc: shuah@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Is there any feedback on the patch?

Thanks,
Akshay
On Fri, Jun 20, 2025 at 12:21=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail.=
com> wrote:
>
> When a PCIe error is detected, the root port receives the error message
> and the threaded IRQ handler, aer_isr, traverses the hierarchy downward
> from the root port. It populates the e_info->dev[] array with the PCIe
> devices that have recorded error status, so that appropriate error
> handling and recovery can be performed.
>
> The e_info->dev[] array is limited in size by AER_MAX_MULTI_ERR_DEVICES,
> which is currently defined as 5. If more than five devices report errors
> in the same event, the array silently truncates the list, and those
> extra devices are not included in the recovery flow.
>
> Emit an error message when this limit is reached, fulfilling a TODO
> comment in drivers/pci/pcie/aer.c.
> /* TODO: Should print error message here? */
>
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
>
> Changes since v1:
> - Reworded commit message in imperative mood (per Shuah=E2=80=99s feedbac=
k)
> - Mentioned and quoted related TODO in the message
> - Updated recipient list
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

