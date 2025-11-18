Return-Path: <linux-pci+bounces-41503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28DC69D85
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 15:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 781CE346DEB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837CA34D927;
	Tue, 18 Nov 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gzDSz+t8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2193115B5;
	Tue, 18 Nov 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475051; cv=none; b=SmNBuhIqVVCBMb2YC8XMh+EO3RECdlm7F7LtfrJFS4mrZEXWnEMEo58QnlmLdBYr0JrmdHMiTQghtDflI2tZCo/Hro5t0Lu08RKwM8hWMfZf27gQNWw9BeMoX+lrvniBHVuJcPe+BXXhlJAyF10gOgZsxGWdyIiZyloMB+TwVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475051; c=relaxed/simple;
	bh=KQ625rAMNORnM/wvTGLNBjB5LaLAlN08QsB0CW73NX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsOQdlzxvWxwfNww3niLhbAkigJWbojpPZWXRaLZPusKWfHSwdDXKhVDsK96OebH8j437Q9XNAoz6qQvrdamQLaGtVfE+RQk7iLkU8os/K2s043O3OPjnNxwZQ3AsQZ4qGKZX7PcKdwAuAypHGZ/auYdO+2VmTbKrCcWkZ2FGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gzDSz+t8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C2FF40E016E;
	Tue, 18 Nov 2025 14:10:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kqE8OtHje236; Tue, 18 Nov 2025 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763475036; bh=9GD8fqgyRaRKCE/AY0roMXTzEL0vi/2D0Y4+wcNO0K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gzDSz+t8y2W5ztKUxB2zKC8hvXpqWlIHWrKM18Ov/M9poPe8ZwILXR5W4V078i0Hu
	 l4fmG0sRIkNQPQCqUlkbpQ2RjFB7rV9NkkMZrVIMhJJYeNyhbinqJsA/xixzgr7IKI
	 QXfvIexTR17HxrYdZhGNzG93BEJgwLPzUpEzLSm0jWgfJ8JP665GEPVVKuAI5vGqvT
	 7GyF4Hm5Ez28zvH6SDR6ltfmuWLFLAXxb6v20g5vA8qZagWUJrql3QLi7G0MipLw5/
	 FT2qwDh4Ppd874MfgFEG0u4EGA6VUFIl9fICW8s/REdigd6f0t1OwASPOYdsCtm8rL
	 27XQsNZV3tfqueCpE0JSzzW/OGl2OLxQO7Cc6Qj5+qLQJ7oPcgJ7NG2rFqnb+d90JY
	 fKQkPBZactJdMwq6fpj9mh+8Q/DdSgRUQB4g4notdOEV2pRqsIfZa+Rebhwm0Xo+G9
	 vZZzZYrzIqrIsPTx3GmmgconK0RAqYSUJZ4EjGEw0W/ZdxAOujIerrllTGeDYUmQYg
	 sNRkw/GC8OPfjVfBjygiG3NqN2BRgM8JErLCmf9msXk3TKh5Ytm8BpVUM2jsgbBkzM
	 fgR1Ooth9wlGU+wGUdaWKFPZH7/4U8p7VH6uY/Ih7++wGDSLbQxTbv+DbWXuQ42pWV
	 YR8PsAW4U6JF9zUXCnPZyn+k=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 2BDBD40E0216;
	Tue, 18 Nov 2025 14:10:09 +0000 (UTC)
Date: Tue, 18 Nov 2025 15:10:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: tony.luck@intel.com, akpm@linux-foundation.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, osandov@osandov.com,
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, kernel-team@meta.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND v5] vmcoreinfo: Track and log recoverable hardware
 errors
Message-ID: <20251118141002.GEaRx-Oge8ZxtR4Vzi@fat_crate.local>
References: <20251010-vmcore_hw_error-v5-1-636ede3efe44@debian.org>
 <vpilvvscosdl4o4cvbmtsrrp4btfwr5iidywmuiawfrgtlcwrr@ubtdbxfqyqpu>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpilvvscosdl4o4cvbmtsrrp4btfwr5iidywmuiawfrgtlcwrr@ubtdbxfqyqpu>

On Tue, Nov 18, 2025 at 05:01:47AM -0800, Breno Leitao wrote:
> Do you know what is the right tree for this patch?
> 
> I am wondering if it should go through Kdump, x86 or RAS/MCE tree?

I can take it if akpm wants me to...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

