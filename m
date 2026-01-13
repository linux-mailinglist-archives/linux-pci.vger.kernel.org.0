Return-Path: <linux-pci+bounces-44595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B41D17B42
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8B6630476A4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6BC3815EE;
	Tue, 13 Jan 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oANqp7Gf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70313806B8;
	Tue, 13 Jan 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297044; cv=none; b=D0aJLALJcP8DO/W243mAWTAcbUkRTuCogEmFeU1LtFbMiREQI47ArkXFTHgfERJ7D6ysTQ0Y7vC1KdsLDu8YReVKnWiTHjGTMqv4ZcAluc5CUehmBrTLLgWynHq4WSTOJBwkSfWXlj0r2ObcVZihia9+uaUZ8n9CLK/ozUBnr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297044; c=relaxed/simple;
	bh=MQpO1he/TA2OH7HM+Qp6ShsyJLTSwamdYNi4C0k7rmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D9xlp63w9sOSIXVGGmYguYOEBkzWlo6L4QzneHzphBlQowk7FTnWf5bq8qRYWmiQJb4ZbI18zy81FOWX2i4C1NZ4jdmgnrKknxBKqV7UMYl7oPD3VWhQlLY2jbfXyMrAENKLZYvtCQoCRTLIy5xnPLeocMJnvJzB9u2sAKKQ+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oANqp7Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854ABC2BC86;
	Tue, 13 Jan 2026 09:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768297044;
	bh=MQpO1he/TA2OH7HM+Qp6ShsyJLTSwamdYNi4C0k7rmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oANqp7GffSJApYVClv+vGIE3m7dVxTrPczfQFtJDDYC7lx2Y+9H0ZtJomWFkZo7qM
	 4LKVu8r3th0VU6hTHMrYhLx4x64X9VSV6L5N3b3RFNUpmJG8zFZvQ4/K9MLcYUOtIP
	 nAas/yVakBU4LcSlcxYHYOo0uv/tQssuFJK0EEiBsifHhQwisr+eEOYdBrZDtyBjLl
	 sGefnbwi/9tpKzHaZylzmP3s3C8CbGCOIZW+Q8OG+LMpqbLUJVn/XOrMYnwCoKMluv
	 1eX9d2PP3XQEkN1yTIUiajXuWETT+5uKrJ1Zk0YeXSotW83kzu8riuMoLpqhi3CS0j
	 tFB7wndU8JvYg==
From: Thomas Gleixner <tglx@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/7] irqdomain: Add parent field to struct irqchip_fwid
In-Reply-To: <aV6Yi+N+lCEekshX@lpieralisi>
References: <20251218-gicv5-host-acpi-v2-0-eec76cd1d40b@kernel.org>
 <20251218-gicv5-host-acpi-v2-3-eec76cd1d40b@kernel.org>
 <20260105120108.00002016@huawei.com> <aV4gH/yHaOmOtK0J@lpieralisi>
 <20260107100452.00004b6f@huawei.com> <aV6Yi+N+lCEekshX@lpieralisi>
Date: Tue, 13 Jan 2026 10:37:20 +0100
Message-ID: <87sec9etv3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 07 2026 at 18:31, Lorenzo Pieralisi wrote:
> On Wed, Jan 07, 2026 at 10:04:52AM +0000, Jonathan Cameron wrote:
>> Agreed. Let's see what Thomas prefers (i.e. make the decision his problem ;)
>
> Thomas do you have any preference on the matter please ? It is not a big deal
> either way I'd just like to respin promptly (provided the rest of the series
> does not require further changes other than the ones Jon suggested and I
> addressed) if possible please.

Hiding the NULL parameters in helpers is perfectly fine. I agree with
Jonathan to make the name of the new helper more intuitive, but other
than that this looks sane.

Thanks,

        tglx

