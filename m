Return-Path: <linux-pci+bounces-24032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F35A67118
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 11:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD37421099
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709BC207E11;
	Tue, 18 Mar 2025 10:21:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB0207E0D;
	Tue, 18 Mar 2025 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293292; cv=none; b=MdgM/2G71AX16hpqnkJh5XaYabc78AWLLG8jtFw8u3UcxXK6aQi7hA6K2o5K1qRz1wkYBQw9WHWCb8g2TxF7UcALESU9VluWk0w+I9iDRWczbad2BrBAYtzCK0IEgn7b7Q1MSRGGd/f3hOfGBNkuokgAK+hUhPj2fcUi6AJSUmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293292; c=relaxed/simple;
	bh=7mox+rQP13cKtgejtr8ZU+eh1fVDo3WnCxArWV3DXRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDzypAzGioiIBBVx0qlTvrib4NTG/EwdvB1XpBsuAgxe5U1YH4yieVpUSBbQES0r56xbFWybtiHqhFzDANbtubxuck7/pJPpUwljcOCpfLjpuf34WQ4d3PmIQtDCiuBkN2LtTCcME2S9w0i5fI5m9GCNl9myJyzHQlrnfrkfxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523effaf7ecso2554298e0c.3;
        Tue, 18 Mar 2025 03:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293288; x=1742898088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QoDmWe/UGb3lnwkGClfcGSqUWh6tLGvw+A6qxymrSxM=;
        b=cOT/nasUuV8QJnY1dOW58u2tHZ9zsaLPqD7zFmYQgDapPCveRl1xtOYHrq/SZ8TtAs
         BhPYzbJKnqanls3N3PeaZJ24fbrkMxBFLTk9D3MmponrnWX0y3+qg7dSi2AjMYRgWgr6
         ZltxO9e86OU9GIgzM5tg4kWBg2abouQfk2fiW2CveggwBql7hdqCvKcTne0DDHzXAtCY
         mjalzhfLzqjj2/9pSbojR5bst8ABC5aibbvrviG0sA5xCdV6LxbV7Ak9fKgZ8VTkNOyn
         EGws0zkItbNdeJ943JcWv/43G/wba8sCy5C85pNgPtew3Dz9Yphv/kpkgGR7DU0yRNeX
         crEA==
X-Forwarded-Encrypted: i=1; AJvYcCU7P8nwKPf7rjr6+fXdRDEzoy1Nl/o0NlOfKLGYGXIZ1NPM3S3OPS6XVdtVTjO6UFpv/R/PhqFz1uiJGWzK@vger.kernel.org, AJvYcCVzqoE0ub7PDa4Lx7HRH/VK/cD7HwwS0lar8J8E1/OPGGeNK93xXORXHz8LzAtOm8ZCr6RPLn3V9vpZ@vger.kernel.org, AJvYcCX49Q2yvcMd26I73EJyxJ4GthS8V2ML4uu1XRxHae0IdM6bcT0oHMMNrS3BLtamQqH6lh1Nsy9JGN0M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9dkDtyedZaQetV2cd9nr+Dn2kFFMkknYxL+wQMssJ8CaeWQgP
	/MvHWh9NdKmjNSi6hVM3MC9roR0O40myy/Nup2gq5SJ6d1ppNq7oOL9L4Oa4
X-Gm-Gg: ASbGncu/3c7KBuXYHu/7kaRUEHEfwshrFr6NJnSZFuvQo4o40DsIPyzIg80nJLwtjiH
	xY3ZOJIMUjtmY4zgsusYlQZUneXRlq3j7CnAF+S7sj3UOJ/Vk8F4Mboi5p1xURIvB+xYS5ay9w/
	BKEHJhNXe6rWmoG0wTsdXEuT/d1r25AU57Mq6a1HRp189nqnu9GCGeCKDwE4RafiTcJwFgmTPJR
	uTI5CO9eiwM1b97W5zAUpUDP8okZwU6nmi+JcJGqJyo+yoU+XEUwJNrnS0q0ppC+5XB4gyRRlY8
	rueVllE/HgXABp7HjFNB69Pou6FMdrzYiVoi+MK+9sa0pnXZoC2Kmk009dpkxuCGhsfPDTt4V3v
	/gxLB6bFwVAo=
X-Google-Smtp-Source: AGHT+IG15bLsJHlNASDftZy3Ras1S6N5mgYYQYbL1tH6/FBmsXn1RAA94zUq4dQ2yNmksMWX3/PW5w==
X-Received: by 2002:a05:6122:1797:b0:523:763b:3649 with SMTP id 71dfb90a1353d-524499e6376mr9098898e0c.6.1742293288577;
        Tue, 18 Mar 2025 03:21:28 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a71e866sm1943059e0c.48.2025.03.18.03.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:21:28 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5241abb9761so2388218e0c.1;
        Tue, 18 Mar 2025 03:21:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb+Idi/iIotZR8kTvWyVFH5wd8aYoh43iekEdeUcqV5GQWJnGNPcZGXE3I70jfolKmYgWNgItXOwLNWCuN@vger.kernel.org, AJvYcCWo1tw/PvTrNxkmGGy9nkFgMYeYYgsjxU/a6nf9OjJVvv6naRFEnrPiBRcnx74P1s0o8b2FGnvJAYWW@vger.kernel.org, AJvYcCXdbFL/+/KAXAYEoKU5Y6mcXogSbZRSJVDJozBp6/qXV+Ynv5YDmxFL3hmY783HXJmXaj+yseBuydNK@vger.kernel.org
X-Received: by 2002:a05:6102:3912:b0:4c2:ffc8:93d9 with SMTP id
 ada2fe7eead31-4c38313e0b2mr11168666137.9.1742293287761; Tue, 18 Mar 2025
 03:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228093351.923615-1-thippeswamy.havalige@amd.com> <20250228093351.923615-4-thippeswamy.havalige@amd.com>
In-Reply-To: <20250228093351.923615-4-thippeswamy.havalige@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Mar 2025 11:21:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQ+pPg_bsPq_MXOe_Q8QkEVy6amZdXvsn3BK4+2NOFBA@mail.gmail.com>
X-Gm-Features: AQ5f1JqmIotS6ImEBxMg6HmFpsq89vT0syujgjflVP7WgI6KVWcnVzr7cYeS4Kg
Message-ID: <CAMuHMdUQ+pPg_bsPq_MXOe_Q8QkEVy6amZdXvsn3BK4+2NOFBA@mail.gmail.com>
Subject: Re: [PATCH v15 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com, 
	bharat.kumar.gogada@amd.com, jingoohan1@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Thippeswamy,

On Fri, 28 Feb 2025 at 10:35, Thippeswamy Havalige
<thippeswamy.havalige@amd.com> wrote:
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
>
> The Versal2 devices include MDB Module. The integrated block for MDB along
> with the integrated bridge can function as PCIe Root Port controller at
> Gen5 32-GT/s operation per lane.
>
> Bridge supports error and INTx interrupts and are handled using platform
> specific interrupt line in Versal2.
>
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

Thanks for your patch, which is now commit e229f853f5b277a5
("PCI: amd-mdb: Add AMD MDB Root Port driver") in pci/next.

> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -27,6 +27,17 @@ config PCIE_AL
>           required only for DT-based platforms. ACPI platforms with the
>           Annapurna Labs PCIe controller don't need to enable this.
>
> +config PCIE_AMD_MDB
> +       bool "AMD MDB Versal2 PCIe Host controller"
> +       depends on OF || COMPILE_TEST

AFAIK, AMD Versal2 is an ARM64 SoC, so this should depend on (at least)
ARM64 || COMPILE_TEST, too.  If there's ever gonna be an ARCH_VERSAL
symbol, it could be used as a dependency instead.

> +       depends on PCI && PCI_MSI
> +       select PCIE_DW_HOST
> +       help
> +         Say Y here if you want to enable PCIe controller support on AMD
> +         Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on
> +         DesignWare IP and therefore the driver re-uses the DesignWare core
> +         functions to implement the driver.
> +

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

