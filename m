Return-Path: <linux-pci+bounces-31618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AFDAFB3A4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 14:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF60A17919C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 12:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E629B224;
	Mon,  7 Jul 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIF0cr7H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6929B20D;
	Mon,  7 Jul 2025 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751892819; cv=none; b=O+7OWA9bxhlfdFEWjtwrOx3SO9kTctEz1rJrE9aWJhfIWsKiF+CJasL+Lu0gkcEZOxMAVjjijtLgwY/v5ROeOmZK3+xKhgCB7treGFOWwv7FRmqXzsAv1tGdf/Mekuq2OtP/PMob3uYCsNoyACNtAPXLNSvpguNDn2AwjOrDNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751892819; c=relaxed/simple;
	bh=0zsqKpFLkYF347gg9OTLh6+35fp5gqeJ2+m+BHifrMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trcg2UxSqk2H6Z6FoKqOgxyjhWP9ADspcYssZ5Hv+Bh8JynRkaz81voKDNxRLsUNihtRuGLBYukxnGCP8vO1WHVfapgL981btwMTTj12Ct7Y0sK2pgkTcWPT87MI9l5wHIi+9z1aT8rALY59KR2+rf9ksnywxtxs2XqtEtHzko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIF0cr7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CB1C4CEE3;
	Mon,  7 Jul 2025 12:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751892817;
	bh=0zsqKpFLkYF347gg9OTLh6+35fp5gqeJ2+m+BHifrMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HIF0cr7HzgvyPWG+D8fDA1gPhCAnxkqTfy4qJPVPcrOKTNs9DIvtfeHsCWT19Gyzs
	 eW1O1nTjYUS6rC5OArn1Z3OVAPqaE5GfKiWFsCknewCCCeMNMyvZGdvkahHpbp28Il
	 xvY//YUpRNKRZGxtw4Y/x/qV2t+dqE6XVq/V+WDZ4iNTZI0VjpCc2E35vbXlLsvhiK
	 +zXvpferAZle6lYYrBPRRFh3L639hm+MhLT7edA3nwjB+VmQwiiw72rmZw3YdzjIbX
	 A5J/EpNprXRvKAeuhtOEfJUiROsU2bScq5YMnmsTPyklIhg/KpWtMczFAwyWreAKxW
	 osGkmuWcUFrDA==
Message-ID: <4ef523a2-48b3-45e9-94da-7811e1bfae76@kernel.org>
Date: Mon, 7 Jul 2025 14:53:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] agp/amd64: Check AGP Capability before binding to
 unsupported devices
To: Andi Kleen <ak@linux.intel.com>, Lukas Wunner <lukas@wunner.de>
Cc: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ben Hutchings <ben@decadent.org.uk>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ahmed Salem <x0rw3ll@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org
References: <b29e7fbfc6d146f947603d0ebaef44cbd2f0d754.1751468802.git.lukas@wunner.de>
 <aGbaNd3qCK3WvAe-@tassilo>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <aGbaNd3qCK3WvAe-@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andi,

On 3-Jul-25 21:29, Andi Kleen wrote:
> 
> I suspect these days it would be also reasonable to drop it this old
> hack.
> 
> If any of these old chipsets are still missing I would rather adds its
> PCI-ID.
> 
> There will be certainly not any new unknown ones for these old CPUs.

Right, I plan to submit a patch to disable the probing of unsupported
devices by default. I'll likely even do so today.

But that is not entirely without a risk of regressions and atm this
is causing a regression (breaks flicker free boot) in 6.16-rc# .

So I think we should move forward with Lukas' fix dor 6.16 and then
my patch to disable probing of unsupported devices by default can
be merged into linux-next .

Regards,

Hans


