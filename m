Return-Path: <linux-pci+bounces-45144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 916AAD3973A
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 15:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0A613009412
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jan 2026 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107EC32F77B;
	Sun, 18 Jan 2026 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opIhMi+z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7EA50094E;
	Sun, 18 Jan 2026 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768747627; cv=none; b=bnIb/fgdt0ZwMQx7TLG5Kdw2QhgSToyrxc//iB8lQVVOPlxhtjjQKTYiM2WXwYmymmUaHTxK9QMfo0ElhYL4B/RSjnYRBEtvK0qitmckzhGFc0kfgEbR6sd2SFrs3KSBBch85+V8YcatHL2zxHsG1ubo0IXeoIQ/z2le0DhCIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768747627; c=relaxed/simple;
	bh=+u4ZywIxm13pYgPgV73WmGC0axm5In10Llu2B9AHUPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LNKQsN9lM0OtPjvOK5hXvmDZlS9O+iqhmACqZaSQ/yGOkemyCQ8Y09R2c+iEx05jdHV4G95FQ05iv2bFVtbG7sBXRurLcSQ8YFi29eSeDTnUSKJ5GQUD68TWnADYU+gs4zudeXr8khOmLVQIJwAAmcFNiZBBC/w75xoJ+R7mtbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opIhMi+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E75C116D0;
	Sun, 18 Jan 2026 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768747627;
	bh=+u4ZywIxm13pYgPgV73WmGC0axm5In10Llu2B9AHUPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=opIhMi+ziLUGWUvz516R7fsTDj24WsFDmqjMk+GmC3YIVtY0sGQm//bxdq8IJRjBl
	 0SQr4aS8Nq2QKhAEPjAlBE1umXKC5UnQS+VVBrTEHlBNXn9KYrcj5KL9dcyca0e85P
	 7Rz1AugxyWjmZUmkFmhDFqQIGujxreWu6RcB7VV/AKjfdmHXSBsdf5puILzKwiUT/H
	 4kgrI5uqrjmzrNRBf/LZqX1cr5b1FaGqAxOKEVPEOL18mGiHQE1Jcu8RIaqBCdoIsI
	 YyHDVCfJ5JcP6rSs6G0XluMDNDDOAzpiM/HM6rpcviELAjTiIhkjZAEmFhQKXRg1Yl
	 jF3BBP/MlxNxw==
From: Thomas Gleixner <tglx@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/6] irqchip/gic-v5: Code first ACPI boot support
In-Reply-To: <aWy9T3VDyXpVG41z@lpieralisi>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
 <aWy9T3VDyXpVG41z@lpieralisi>
Date: Sun, 18 Jan 2026 15:47:03 +0100
Message-ID: <87sec30yhk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jan 18 2026 at 12:00, Lorenzo Pieralisi wrote:
> I have noticed you pulled this seris into tip (thanks !) - there
> is a strict dependency on ACPICA patches in [6] though as I tried
> to convey with the paragraph above and dependencies below:
>
> prerequisite-message-id: <12822121.O9o76ZdvQC@rafael.j.wysocki>

Duh. I completely missed that.

> I don't know what's best/easier to handle this dependency but it is there,
> I don't want it to cause you any trouble so I reported it as soon
> as I noticed.

I zap it from my tree for now until that's sorted.

Thanks,

        tglx

