Return-Path: <linux-pci+bounces-43140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD72CC46AE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAFEC30448C7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 16:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C812324B2C;
	Tue, 16 Dec 2025 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qnyGd0ve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ijWQ+/No"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD031DD90;
	Tue, 16 Dec 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903703; cv=none; b=W8eCq9XAjmXKjTaohi/XtZr4F2BrZMJfOGkHNbbnSq3qL4WMojU0g7NnjjkjTqd6ig0CfYGqr+Ptpi9cy5NljDlSNHj/riFcevf1gP0JS4CiRr+DLfxt/duW92tSEYzLHyWymLFk48oMc+v2zOC+ajUwzjfG9XUas3+3VeiW1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903703; c=relaxed/simple;
	bh=V5OgrptaKFnNxflnBjl6dkyuuukgriltToUavMw9yRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BtEdPRRzXwUSegAEzKwUu0gpURX9WZlfTjPG96TCd371JLMgOuoGOJePFo7RsnNYQvm2YX/xZyFVS8wR4rmuZ8/TfzD3MG7M/5Dh9bG2bue6ZOQuPgV2mKSxWFSzFqwcs+hunoet8gOVYRhPxZNcWN+CKAX6O6mtGPt0ds7dxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qnyGd0ve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ijWQ+/No; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765903698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CVnbEVT0IZfaX/eD0iTQdcyViqtp48r8KW4lzy2QT4=;
	b=qnyGd0veOq64ju6I9h6rrEmNHr0eoMrJycx/B1L09/jnyjtqv6UWdej+5sp6Vj/hCQ/rbh
	EvhrMFOn9ixH5Hjb/GszxCk8HCNKXSZ0S6aOJeQC+6yyisr9TBIq9MroGivGm2TN9++K5s
	oi2irZjMhmwDi9U/OUezbikT2SNF592O7b4tTgtmV0tOVRyi6sdU5OGY3dTnnNDRDeFkeM
	kGLyxETqsVDDzR3rlY8vmOyeMSBno7G341zaj+M5bePe60Nlsqa2fW8DCDi2Pc3AIyiNFR
	P6x2QiyJ/zY+rOoYQyXBObfpUfnLkmdAujn04YARtfGbNzgCiTFw8bRrGfSZng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765903698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CVnbEVT0IZfaX/eD0iTQdcyViqtp48r8KW4lzy2QT4=;
	b=ijWQ+/NoIqviqx+myZtq96YW7VY8uzfwt8/9Wkek4IuGGPg6YI9BEFxs+MYYnfzJGd2FoF
	6ZenQQTGD8luBIAg==
To: Yang Zhang <zhangz@hygon.cn>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, bhelgaas@google.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Yang Zhang <zhangz@hygon.cn>
Subject: Re: [PATCH] X86/PCI: Prioritize MMCFG access to hardware registers
In-Reply-To: <20251216100332.6610-1-zhangz@hygon.cn>
References: <20251216100332.6610-1-zhangz@hygon.cn>
Date: Tue, 16 Dec 2025 17:48:16 +0100
Message-ID: <87qzsucqzz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 16 2025 at 18:03, Yang Zhang wrote:
> However, the current kernel code forces the use of the IO Port method for
> PCI accesses with domain=0 and offset less than 256. The IO Port method is
> more like a legacy from historical reasons, and its performance is lower

That code has a reason and if you would have taken the time to go back
in the git history and to read the related discussions in the LKML
archive then you could provide a proper explanation and not some
handwaving "like a legacy".

> than that of the MMCFG method. We conducted comparative tests on AMD and
> Hygon CPUs respectively, even without considering the impact of indirect
> access (IO Ports use 0xCF8 and 0xCFC), simply comparing the performance of
> the following two code:
>
> 1)outl(0x400702,0xCFC);
>
> 2)mmio_config_writel(data_addr,0x400702);
>
> while both codes access the same register. The results shows the MMCFG
> (400+ cycle per access) method outperforms the IO Port (1000+ cycle
> per access) by twice.

That's a known fact and has been discussed many times on LKML. See the
archive for details.

> Through PMC/PMU event statistics within the AMD/Hygon microarchitecture,
> we found IO Port access causes more stalls within the CPU's internal
> dispatch module, and these stalls are mainly due to the front-end's
> inability to decode the corresponding uops in a timely manner.

Interesting analysis.

> Therefore the main reason for the performance difference between the
> two access methods is that the in/out instructions corresponding to
> the IO Port access belong to microcode, and therefore their decoding
> efficiency is lower than that of mmcfg.

It's known forever that inb/outb are significantly slower not only due
to the micro code magic, but also because IO port instructions are
serializing against IO port instructions. See SDM/APM, it's documented.

> For CPUs that support both MMCFG and IO Port access methods, if a hardware
> register only supports IO Port access, this configuration may lead to
> illegal access. However, we think registers that support I/O Port access
> have corresponding MMCFG addresses.

We think? Either you know or not. By specification the MMIO config space
covers the complete config space from 0 to 4095.

> Even we test several AMD/Hygon CPUs with this patch and found no
> problems, we still cannot rule out the possibility that all CPUs are
> problem-free, especially older CPUs.

If you've had read the mailing list archives and the git history then
you would know for sure that there are systems out there which have
issues with accessing the lower config space via MMIO.

> To address this risk, we have created a new macro, PREFER MMCONFIG,

That's not a macro. That's a config switch, no?

> allowing users to choose whether or not to enable this feature.

Also please read and follow

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

> +config PREFER_MMCONFIG
> +        bool "Perfer to use mmconfig over IO Port"
> +        depends on PCI_MMCONFIG
> +        help
> +          This setting will prioritize the use of mmcfg, which is superior to
> +          io port from a performance perspective, mainly for the following reasons:
> +          1) io port is an indirect access; 2) io port instructions are decoded
> +          by microcode, which is more likely to cause CPU front-end bound compared
> +          to mmcfg using mov instructions.
> +
> +          For CPUs that support both MMCFG and IO Port access methods, if a
> +          hardware register only supports IO Port access, this configuration
> +          may lead to illegal access. Therefore, users must ensure that the
> +          configuration will not cause any exceptions before enabling it.

Q: How is that supposed to work for distros?
A: Not at all.

The right thing to do here is:

    1) Have a control variable, which determines the MMIO preference

    2) Make this control default to false (backwards compatible)

    3) Provide a command line option to enable/disable MMIO preference

    4) Optionally allow the setup code to enable MMIO preference based
       on e.g. CPU family/model cut-offs or some other reasonable method
       which prevents a default on for the reportedly affected systems
       (See LKML).

Thanks,

        tglx

