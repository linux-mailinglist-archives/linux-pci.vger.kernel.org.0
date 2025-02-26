Return-Path: <linux-pci+bounces-22448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFAFA46417
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 16:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84AE07A33C4
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91FB2222CB;
	Wed, 26 Feb 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ+aUmnG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF199194AF9;
	Wed, 26 Feb 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582471; cv=none; b=pW07g3wvLEv7U8Pr5/jtlfNLLJew7IQnUVDIZAoCGskiZuqm9K7iY8HATHN8YxljURob9/XyevRKNue4ntOUChoVlLIO37MSeaqmVzpLInRECfP+4idctgLwHt8l1l5v+v93Ukfu0AjQheAZxB9jpGizK+DAkHiX4SmA/pYo6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582471; c=relaxed/simple;
	bh=B9XcjEPM+jhCbMj4W001+uMUwpvu1a7JWj4XEnZFlac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFenPevJVxF5TlGd6qhkpQ8C3rH0tCgxN+PC6F/fmkd3kkPb/qTJk0LQXudJIyxqzLnNz1cHQUmHzA/OURtKFL4vHi+uJG90a+C29XId3yzjh7fMJmwdZgy0f4IlUucbkTeZccUj9IYQ4Nuuu3qUF+bUxw37yEpp0SclnllUBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ+aUmnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130D7C4CED6;
	Wed, 26 Feb 2025 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740582471;
	bh=B9XcjEPM+jhCbMj4W001+uMUwpvu1a7JWj4XEnZFlac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZ+aUmnGf45RfCarvX357sQ0Upo/AdKZqHhBt4oOqwP8TPtAfjR6zWOS8m3TuOSAU
	 UY7ZgRODLPPOjC1epR1nf8EdlAkZ7DV+R3o92iqNS+rakx5GYMAm7rjdoRPaJr0wT2
	 XJRto9IdXDtU21j80XiD6UnO/7j9w6+g/mRdRXpuJdk5Z91fAkR+xsFEWe2jG2MZU+
	 /BXkBXe4NieukmbhY0hKKiYMychTz4bvorcVf+kvl0WDZPfyjNlqpb4TjhsDbVqepN
	 qeNXv68dlFM2vWFvVAJ3tGv9G9L7ZUv2zDvsqbo9JmIWhpXJPNCKzD7sHWj2QTND+s
	 O3oEvGjOQUOyA==
Date: Wed, 26 Feb 2025 16:07:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, "bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <Z78uOaPESGXWN46M@gmail.com>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>


* Rostyslav Khudolii <ros@qtec.com> wrote:

> > My understanding, based on the above info, is that ACPI should be 
> > used. The direct register enablement is still possible for 
> > backwards compatibility, if needed.
> >
> > I think your observation proves a good point. The registers were 
> > moved starting in Zen. But this is not an issue on modern OSes 
> > since ACPI is used by default.
> 
> This is my understanding too. However, what is the desired behavior 
> on Zen if the CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are both 
> disabled? ECS should not be possible since the registers were moved, 
> right? If that's the case then, at the very least, it would be great 
> to have a warning message.
>
> > For your specific issue, I think we should determine if there is a 
> > configuration or a firmware problem.
> 
> To give a bit more context: I am porting the kernel which works on 
> the AMD Ryzen™ Embedded V1000-based device. On that system, it seems 
> like the firmware doesn't disable IO access to ECS (which is wrong), 
> hence we have never experienced this issue before. Now, the 
> R2000-based device's firmware disables IO access to ECS (correctly) 
> and that's when the issue starts to happen.

[ Sorry about the late reply. ]

So what is the practical impact here? Do things start breaking 
unexpectedly if CONFIG_ACPI_MCFG and CONFIG_PCI_MMCONFIG are disabled? 
Then I'd suggest fixing that in the Kconfig space, either by adding a 
dependency on ACPI_MCFG && PCI_MMCONFIG, or by selecting those 
must-have pieces of infrastructure.

Thanks,

	Ingo

