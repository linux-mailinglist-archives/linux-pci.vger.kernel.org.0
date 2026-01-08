Return-Path: <linux-pci+bounces-44267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE24D02558
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 12:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B704931C4E02
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B7346E56;
	Thu,  8 Jan 2026 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJNpHkms"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECB3502B0
	for <linux-pci@vger.kernel.org>; Thu,  8 Jan 2026 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862590; cv=none; b=ltoQpEYgfEJBX8P03nuvlk2sDQ6hWeyJDhGivFpQzZ780PVYwwAwNYgTsa9tckSxnDYEMjCr2iAyFMyLASqI8MkFBgxA+Z5vGNQg0z2ufp69UzyfMSwZ3L8j0aR90C0gkMpwoAoJVKAxsjp8JxpfBVoJF1MbsfYxbCMGpjqKTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862590; c=relaxed/simple;
	bh=8b9Iz5Wz4YPC/2CjXeOQRUuM5WC3H8/Bll6gVLI3r+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3WB/gRHLO22BmcSV6/VXztYUfEnaGzWIMV1+Lo3vWyncyp4jFNMRoQS2lkPbsI4FZ/44zTuJKpnEXFT/X380YJG6l3Gd5g60Br5rc1ueioOsLbnZewEsSMKxcJ72qB+grRJrxsLhAtt+pg0ANZIAfkW4U894KjhwV8AXwt3asM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJNpHkms; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47755de027eso17341775e9.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 00:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767862576; x=1768467376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGDJX7M6xo517LZvqyR0ibyOmlrZ1q54/VzLvtp/isA=;
        b=dJNpHkmsEXL/ia6f59KYliwAAhfjblIiOTCJ/zneKW/uAKzosF4FQYR4LFxqivg6Ou
         I0aRp3zfhisi8/N0BgKqIxnfsn/POjS4FT44PAw5q7wis/Xnbj2aMwiFjVA8HCzm0ngu
         RZ8z8LEllJMWrfD/6iV93Ssb8CyCgo/AMmmn3M8k5Kb/2woUv/53LTwPxMk0u0b9zuWB
         /hvIx7rOm307H9NnZfZV0jBymqDzaFlVEtETIhQk+PMl5yUySHA4kPRHNR2B5HCJUksK
         QXa9A+Fsy7h1lBFQ9tLgw34ajIYIINh0cDBwpfxRCcCa2qzyAC2kGxjoNyu4wxTph1oM
         fVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767862576; x=1768467376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jGDJX7M6xo517LZvqyR0ibyOmlrZ1q54/VzLvtp/isA=;
        b=Mg25eIXEw/hQs+ubK1bKydyp8VoDCZlC2MDewujFr252pmPhxm4oVbR4T4ztS4Hx1y
         Bx+Sv5wHfgW5+jVTGnC8ecW1aZ/40b9tqG4lwhl5GuqAKoT8Do+22pZOquFLPvbcpryN
         zfoTBpLn55hVLqzUmOu26qsUbGbrEGEo8gwYkwvP4tUDk6E97QHV437eQrIMlfU1CIuk
         TO+RaeuIMys3hz+PBx+0lCb6nGnQKLoxUecuZz+g9wWPnspfmjAtxMjnuKduJLIH1OKZ
         jd092vR/p9GsKHI/3+Q/17BG0cCJxN2HX5ezH11DADh+ruq7GyPm3zl0nw62IoW+Z/m/
         nrQg==
X-Forwarded-Encrypted: i=1; AJvYcCWrA6dVX6iLP9/gtb06qvkdavMgL5hIwZOSP7qYkEeSdDe3TicTJLrjS08BZS+pyJYTP24I0kFvHX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPGYIbgbFXEiKiHZ19w3ovOHzaNrNyUtDvIPtvc48lmGHXJyPc
	lv9Qp80HkQtu3xHKowuoDqiE48Xpj70XoCRNdmxSzfXaKxWsJNzCqImm
X-Gm-Gg: AY/fxX5uR2nhC/gRUHSOnUzKvjl7Wqh4Y5OrfTFE3qN8SB/g0WyaaGSGHkOSjX1Vi9o
	/5sx1V7LdSy5GGMviN8Do8s81RUkmCQ8ZBT80JhssmnYsfujdLDTA4Zv28uKbq4S7w+d8Sa2LRK
	OPn90QNr3IbYq2oEqydIyafYIy+RGI7sTOtG/C48OhNsi1vBEfaO4E51ttEMgZA2hVFGyD3TiHv
	kDu40a/NjMfHl6BcnDXUQHTG4C6Vd75IQLmgN06+DPycz1fRTlBrb5s8dPMkVNtxHIl4gmfU6Kw
	52U/wbw/PlNNf8n5j5Dv/jZDETcGBTFv3uWfD85dZAW6TZJoSfXRRYmmgGz+C6PpxVmf+9Tv8EB
	f4OTLvgdu+o3G0SY6JqPbXSVdW/A3LLjtxQVNc5/YQGrP+jMi0AIUqgg97gnXS3ed6x4H+3RRFa
	LvSfUzoKmNsWsDyqJffw9k2DFUDjQrFditLrMoBTHsqiHJFWdYk/PorZVnXRhU2bc=
X-Google-Smtp-Source: AGHT+IG7K7RnsQA6msImn+HFw42dCZzuW/6tNNrFqAtAiUVG2Vb71xM9FgjkGHt00Jc0xWoY7O9mnQ==
X-Received: by 2002:a05:600c:630f:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-47d84b38534mr60337905e9.26.1767862576313;
        Thu, 08 Jan 2026 00:56:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8702534dsm36882665e9.2.2026.01.08.00.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:56:16 -0800 (PST)
Date: Thu, 8 Jan 2026 08:56:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ziming Du <duziming2@huawei.com>
Cc: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>
Subject: Re: [PATCH v3 3/3] PCI/sysfs: Prohibit unaligned access to I/O port
 on non-x86
Message-ID: <20260108085611.0f07816d@pumpkin>
In-Reply-To: <20260108015944.3520719-4-duziming2@huawei.com>
References: <20260108015944.3520719-1-duziming2@huawei.com>
	<20260108015944.3520719-4-duziming2@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Jan 2026 09:59:44 +0800
Ziming Du <duziming2@huawei.com> wrote:

> From: Yongqiang Liu <liuyongqiang13@huawei.com>
> 
> Unaligned access is harmful for non-x86 archs such as arm64. When we
> use pwrite or pread to access the I/O port resources with unaligned
> offset, system will crash as follows:
> 
> Unable to handle kernel paging request at virtual address fffffbfffe8010c1
> Internal error: Oops: 0000000096000061 [#1] SMP
> Call trace:
>  _outw include/asm-generic/io.h:594 [inline]
>  logic_outw+0x54/0x218 lib/logic_pio.c:305
>  pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
>  pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
>  pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
>  sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
>  kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
>  vfs_write+0x7bc/0xac8 fs/read_write.c:586
>  ksys_write+0x12c/0x270 fs/read_write.c:639
>  __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
> 
> Powerpc seems affected as well, so prohibit the unaligned access
> on non-x86 archs.

I'm not sure it makes any real sense for x86 either.
IIRC io space is just like memory space, so a 16bit io access looks the
same as two 8bit accesses to an 8bit device (some put the 'data fifo' on
addresses 0 and 1 so the code could use 16bit io accesses to speed things up).
The same will have applied to misaligned accesses.
But, in reality, all device registers are aligned.

I'm not sure EFAULT is the best error code though, EINVAL might be better.
(EINVAL is returned for other address/size errors.)
EFAULT is usually returned for errors accessing the user buffer, a least
one unix system raises SIGSEGV whenever EFAULT is returned.

	David

> 
> Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port resources")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> ---
>  drivers/pci/pci-sysfs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7e697b82c5e1..11d8b7ec4263 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -31,6 +31,7 @@
>  #include <linux/of.h>
>  #include <linux/aperture.h>
>  #include <linux/unaligned.h>
> +#include <linux/align.h>
>  #include "pci.h"
>  
>  #ifndef ARCH_PCI_DEV_GROUPS
> @@ -1166,12 +1167,20 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  			*(u8 *)buf = inb(port);
>  		return 1;
>  	case 2:
> +		#if !defined(CONFIG_X86)
> +			if (!IS_ALIGNED(port, count))
> +				return -EFAULT;
> +		#endif
>  		if (write)
>  			outw(*(u16 *)buf, port);
>  		else
>  			*(u16 *)buf = inw(port);
>  		return 2;
>  	case 4:
> +		#if !defined(CONFIG_X86)
> +			if (!IS_ALIGNED(port, count))
> +				return -EFAULT;
> +		#endif
>  		if (write)
>  			outl(*(u32 *)buf, port);
>  		else


