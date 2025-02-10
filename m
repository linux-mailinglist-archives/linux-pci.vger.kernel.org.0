Return-Path: <linux-pci+bounces-21078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53898A2E9A2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 11:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E20167B2A
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8775E1D416E;
	Mon, 10 Feb 2025 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+QMuXop"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99AA1CD208
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739183835; cv=none; b=c2Hlm7EFK7NvBZUeeGJ40hf8RMszvb/RY35FGzboqKptvv+/Yr7uR2xzuk4ueVmEy3gHp6ysi68IqU5zfmlgiyw7Af5EbM3VardAdfmR//usxs6fpDc/1nb8fgqUfwV4clvZdrYx5O6uEw1xLKJDp5wJx50xgnJLFeLL9e/AM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739183835; c=relaxed/simple;
	bh=X2daA4b8KZBEmI/roOKQ/JNdi2WdnT0BXi6PoHlaWgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI0dWT160gS74+evr4kf4p+6EwOc7ogzsI2qbLyFy+bAfLqSYfvWiOc7eggqvHJkMnUj2H5ln64OUpuJd/6jIey0t2VMyi1JzW9em8Nw11DrxrNJuUaDLxa1rPu0Qh4FgLeFtP7SbEGmp1NTX0i1mFd+vFHHyFDkutp5MMkfiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+QMuXop; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa1d9fb990so6268218a91.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 02:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739183833; x=1739788633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ed3HwmGDccuaWYbTyHyaVTzv4wASH1XGS6TfCk4H9oo=;
        b=i+QMuXop+3T5Ds4jhR+tXfhx9arAvKL7/DPcNHwVJjE7gdp1S/ooAF+E/RE02vF9vy
         yHi1MOu4TVGXWiG6Mxfrk3W5sZR7P7LLk9vXKsVqINZF0QkZhfdDm/TwKdrrNH94KVQH
         04NBP2NtFSGzHVc/P9hFPlvZ2T/uIg/HLfTNmwavLOJ5AVuboNTXQFEI6ni26y2QQHYX
         J9fh9VbNqvDDAGW5lEHq6g4Zcvz78ZMspV2YLI1JantdTDD8pe8MEpvS/+eN2bFvQKyF
         SGSWhifzKRoU1si50CyBprvurgzIzWy0gIrjbXk/QrS7aHkMU5BOgUUH3WaWgsIhoxo5
         o07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739183833; x=1739788633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed3HwmGDccuaWYbTyHyaVTzv4wASH1XGS6TfCk4H9oo=;
        b=fezTCZFjzMD0q09Ht66MlpTz8qpkYfnKpMBvN/nN2atKsXdafP67cjwKmms2bqy3ko
         gHj5dgnANimRGdQHq0zHTFreRJsS5JWhyKBD6GUF+BplbsjrUYkWAH4mOrsGCZOT2FKl
         or/g9LsLwKGlsiJ1VctvKnbdQpJkZNs4lYXxa7b1H2OcvGQwrNaerSa3EYmShRkpFQI7
         wPi1lKcEVrhZebu7A8sTUCfwUvEzRF2++0z5r3EtluZCZurxZ18cKgJ5IjuLJgdS7+9H
         WrHGIf5voRN5NrKovZYw4GZjpXlAzPXtAzOZElAFBwuA3P146qqlFkJbFOMkStEZ6vQZ
         0PCg==
X-Forwarded-Encrypted: i=1; AJvYcCVOXjw74Zoz4BeYkT6rCc08aQY19YqGQ2WIuQTxdQPrTJ5AsNIv9kuCUvExuarAJaZePn2EI5/CaUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTGgxXacCo0EbNUZM8SdN6hi01Th6C6N+XbytFJl53NIGFmmT7
	vBlFO1V3Y4yvX+kfSH+1ocaPR89XJWYEuI7tMZg8AIL53JuQKzus9nQ/DR+cQg==
X-Gm-Gg: ASbGncu3Z8ZfQhOVH8HP6aF4/tfIFPKeCGyrFkwQP4qjdbkaNyPogKDiWqdQ5wF7+l3
	BtwUavkDcUiRWvEJdK8HtirZaAtOzLB1v4OCaqxkxLyy0x+Q5nb7tj4SLUOo0BAbuPM6buvQEVj
	V/FUH+iVBFWeedenlESW/rBhZguMPiSqTe96kJP1Eo/CfWIJNm2t/iBjRKczmDvDd6r6uvG/+LO
	xShvPzeXAADpRidN8tTlT9RgVT+qNPTA9d0tMkkDOTpFqMCSd6TgIuVMmZUzKKWE9eW1lgqu64o
	MGqLV4zl4Fx2tQ6gZRb4W0hPQuj9
X-Google-Smtp-Source: AGHT+IH+EZSozw+jru34fUmFnJ9GiwELwA5qvlNGOOzM35DgohR3W+M4Z4wp+SiWS/lt6+tMpE0BSw==
X-Received: by 2002:a17:90b:364d:b0:2ee:c4f2:a76d with SMTP id 98e67ed59e1d1-2fa24274bd2mr18771623a91.21.1739183832952;
        Mon, 10 Feb 2025 02:37:12 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa099f4dadsm8179079a91.10.2025.02.10.02.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 02:37:12 -0800 (PST)
Date: Mon, 10 Feb 2025 16:07:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bo Sun <Bo.Sun.CN@windriver.com>
Cc: Kexin.Hao@windriver.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
Message-ID: <20250210103707.c5ubeaowk7xwt6p5@thinkpad>
References: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>

On Fri, Jan 17, 2025 at 04:24:14PM +0800, Bo Sun wrote:
> On our Marvell OCTEON CN96XX board, we observed the following panic on
> the latest kernel:
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [0000000000000080] user address but active_mm is swapper
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
> Hardware name: Marvell OcteonTX CN96XX board (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : of_pci_add_properties+0x278/0x4c8
> lr : of_pci_add_properties+0x258/0x4c8
> sp : ffff8000822ef9b0
> x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
> x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
> x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
> x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
> x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
> x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
> x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
> x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
> x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
> x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
> Call trace:
>  of_pci_add_properties+0x278/0x4c8 (P)
>  of_pci_make_dev_node+0xe0/0x158
>  pci_bus_add_device+0x158/0x210
>  pci_bus_add_devices+0x40/0x98
>  pci_host_probe+0x94/0x118
>  pci_host_common_probe+0x120/0x1a0
>  platform_probe+0x70/0xf0
>  really_probe+0xb4/0x2a8
>  __driver_probe_device+0x80/0x140
>  driver_probe_device+0x48/0x170
>  __driver_attach+0x9c/0x1b0
>  bus_for_each_dev+0x7c/0xe8
>  driver_attach+0x2c/0x40
>  bus_add_driver+0xec/0x218
>  driver_register+0x68/0x138
>  __platform_driver_register+0x2c/0x40
>  gen_pci_driver_init+0x24/0x38
>  do_one_initcall+0x4c/0x278
>  kernel_init_freeable+0x1f4/0x3d0
>  kernel_init+0x28/0x1f0
>  ret_from_fork+0x10/0x20
> Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)
> 
> This regression was introduced by commit 7246a4520b4b ("PCI: Use
> preserve_config in place of pci_flags"). On our board, the 002:00:07.0
> bridge is misconfigured by the bootloader. Both its secondary and
> subordinate bus numbers are initialized to 0, while its fixed secondary
> bus number is set to 8.

What do you mean by 'fixed secondary bus number'?

> However, bus number 8 is also assigned to another
> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
> set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
> bus number for these bridges were reassigned, avoiding any conflicts.
> 

Isn't the opposite? PCI_REASSIGN_ALL_BUS was only added if the PCI_PROBE_ONLY
flag was not set:

	/* Do not reassign resources if probe only */
	if (!pci_has_flag(PCI_PROBE_ONLY))
		pci_add_flags(PCI_REASSIGN_ALL_BUS);


> After the change introduced in commit 7246a4520b4b, the bus numbers
> assigned by the bootloader are reused by all other bridges, except
> the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
> 002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
> bootloader. However, since a pci_bus has already been allocated for
> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
> 002:00:07.0.

How come 0002:00:0f.0 is enumerated before 0002:00:07.0 in a depth first manner?

> This results in a pci bridge device without a pci_bus
> attached (pdev->subordinate == NULL). Consequently, accessing
> pdev->subordinate in of_pci_prop_bus_range() leads to a NULL pointer
> dereference.
> 

Looks like it is a bug to let a bridge proceed without 'pdev->subordinate'
assigned.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

