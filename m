Return-Path: <linux-pci+bounces-42369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F77C979E7
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 14:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6CC3342A75
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695832DC336;
	Mon,  1 Dec 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pDG6imcK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201232C8B
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596006; cv=none; b=MfNSPM40I7vUeozyIG38HwNZgVXqTGnWfRtsBt/JpfyP54po9mElt4RBehoLNpl+YMEmfAtUxRTQL4tzNvhzR3OFBafmBIvqG8zzf7f3sZDn2jfx8MS0Ba9n4vYNNGlos4DFUEHhYnI5sYdyOwwCdKp05jGgs44IJnT/Jsf1Zm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596006; c=relaxed/simple;
	bh=Qzg/Qa4X0fghhHDxtpfN3T32cZ/jefJmrSSpJzHtNqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP24p5FrsTk/I8ez6poWTBKmOWczBd1jydMvazfpyQVTWLh002H4fAWIdn94hBIVzVD3w5HrPeylCEytseQPLL8dmcG7E+zJvdcdt785MrgcW7A+DLWq1p/HnR6NVflzPtrm2WwQgNypgNFwFUcL4Ge/vk1YStp9eR5WzrvDqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pDG6imcK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so5302334b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 01 Dec 2025 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1764596004; x=1765200804; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6/zDtzLQ3mrDGsn5l6i06J8GNek6GlWuIZEcOWe0BHY=;
        b=pDG6imcK4GqOOmXjVUDPQy0NE/YFO2IfS2EsZ/Hlm/OFId2TMHSGZizybkCoDh0RSy
         T6X+63+lT5YJJ+EgT1iSfGLDL0lbYqoVzG9uTwfqvtLq3EQIeDa5w1e+ROHMt8HbVACI
         pKxPnQ4LK0xspm8Mw7O5UzA9jmOOQs5PBuLXgqPa1zM04O2oSOCu43PN5eHbXdpPCiU6
         /M3jbqJFU0Q2jCHM94If43uPS1IFRNryN5Iggidj3GPozbVj0tAyF9mbnajN71//hM2r
         F5jnFxBUw7RBNi6J3dD9Lmk5jhBZ9F2mCxliFlIPJvrZgQ3yF2YtrcyveQrosRbKHqIj
         /cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764596004; x=1765200804;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/zDtzLQ3mrDGsn5l6i06J8GNek6GlWuIZEcOWe0BHY=;
        b=IKO96Si0z/CNWvAXpoVs1mmBxuto72Gy+uM5pKZsqPH5If71MR+Imi9OnYGTAM7+6D
         mejBE8/yvLdan2P/VOiCpr9M7L657Eo3DJPMAxASTZAGTcExq82hL1vzQvNPZrAgJDTr
         PaSxrLd+DrnJMPVcOThkENuUnnTgSZTJgYiS/TXsYhLbUoQ+nHy+B2BTUeffkh33R85x
         f2BxCMCgXuJnMjCxhjHfTvbqyJucbsTX4Yn5GXfgU4Q9R/TK+yRUurtb7ihxa6bZzcci
         rAY2xiT/BssqwVlqOC08x8z09HdEBC1DYErkgxnHpQYpIuuh9kR7Bgb+GDBaKR8mDVcf
         WeUA==
X-Forwarded-Encrypted: i=1; AJvYcCWKmoyST5/Poalnsg5FxV6RF4VbdzCvdhyt2NKSujtnA17rHIYlT/fQtyNRh6dHrOIoAuLJem8SJqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHT7jkFgpJtP++JG4QmGTqr8FPfC23TzDEL7uXaNUnl43361jM
	GhJLMmEVH7XLHW/DqFW/cYm72i9O9PfpSBAE9OViRlR30NE4/mHLCKOuJXvg91V9on0=
X-Gm-Gg: ASbGncsevEpAPtxGetxTEQpkCfOV4K9zny0EpD0DcP64yNkTY6Ebfywv7IfyPWMyzoS
	n2f3XoiWh1/OoggFDj0Sbj/J7c2jYQR3NVZcQ6I/TFwbQWgA6Rty2AlLaIYDM+aryGwDVsY/UmT
	DT+X3EEijrqpwsi8idKBHDbZbjN3lNVZvt+H2rOXiM0vHbbLCPhGg08uvO/OCDbGeAg7w/ZPnL3
	KAMds444uzgQ3umK23CtGtYqVJis4f3Y8zPHLE931vGkljnHMqFV0/1qK94fgokZ+QJr3X/MkJa
	nnNSV69CLb+FW0C647TyaGd+/yEJBO0pgzF/CX4VneFUlvCn4XgySziavEc1bR5LLu060ye5QU7
	+/CXTENx9ol58QDQhETC1da9jyC9+je3NPjT0ahcXgHPEeKgVL1SzCBBDjA65CczOxeJLpRY4sh
	Zqfzj78hk+cdzdlvKV8cufH/fHGENl
X-Google-Smtp-Source: AGHT+IHKFtSw/hePVAblgBz7XowJWwPF88SK94EexlhYEAxjFsftk5tagEj2K8x0BHP2JoIqJWGmSA==
X-Received: by 2002:a05:7022:41:b0:11b:b1ce:277a with SMTP id a92af1059eb24-11c9d8482b1mr22957607c88.28.1764596003940;
        Mon, 01 Dec 2025 05:33:23 -0800 (PST)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb057cb0sm72909407c88.9.2025.12.01.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 05:33:23 -0800 (PST)
Date: Mon, 1 Dec 2025 19:03:09 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: huyuye <huyuye812@163.com>
Cc: ajones@ventanamicro.com, anup@brainfault.org, aou@eecs.berkeley.edu,
	atishp@rivosinc.com, bhelgaas@google.com, catalin.marinas@arm.com,
	conor.dooley@microchip.com, dfustini@tenstorrent.com,
	haibo1.xu@intel.com, lenb@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, rafael@kernel.org, robert.moore@intel.com,
	samuel.holland@sifive.com, tglx@linutronix.de, will@kernel.org,
	dai.hualiang@zte.com.cn, deng.weixian@zte.com.cn,
	guo.chang2@zte.com.cn, liu.qingtao2@zte.com.cn,
	wu.jiabao@zte.com.cn, lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn
Subject: Re: [PATCH v7 08/17] ACPI: pci_link: Clear the dependencies after
 probe
Message-ID: <aS2ZFdMFMwdlLHA2@sunil-laptop>
References: <20240729142241.733357-9-sunilvl@ventanamicro.com>
 <20251201130757.7032-1-huyuye812@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251201130757.7032-1-huyuye812@163.com>

On Mon, Dec 01, 2025 at 09:07:55PM +0800, huyuye wrote:
> Hi, sunilvl
> 
> Based on the above patch, I understand that you previously resolved dependencies between Link devices and PCI Host Bridges by calling acpi_dev_clear_dependencies(device). I would like to ask: on RISC‑V platforms, if we need to manage dependencies between multiple PCI Host Bridges, could this be addressed by adding a call to acpi_dev_clear_dependencies(device) at the end of the acpi_pci_root_add enumeration function?
> 
> Initialization order dependencies can be defined via the ACPI _DEP method in the DSDT. For example, if host bridge B depends on host bridge A, bridge B should not be enumerated until bridge A is fully initialized.
> 
Yes, that should work.

Regards,
Sunil

