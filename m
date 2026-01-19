Return-Path: <linux-pci+bounces-45179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB00D3AAD0
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 14:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7FA309DFB3
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB936E485;
	Mon, 19 Jan 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUysENTJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DE36A01D;
	Mon, 19 Jan 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830858; cv=none; b=AvkT+rq4siinR4N+F9lCXoCxk3gvksIvaKbT8WABbbgUVGx5w+2fCxf6piiwFuDXX//fOOHqgjIvB/I5HIAPJNc+Y0OptuyX9m759LGJfMC6SHXBKdnbhBpNshUStrYG9fmim0fvb2oDMVxXqQ6vRWc4FYVMU5C3nj4BOCiLTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830858; c=relaxed/simple;
	bh=SiLkNegzwVOS8KFzTjVbFGARwmNVM8mZyLGGXaoRFFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UQOKKyGVQrkBXN1SMvAFfvgBPtDz7HLUwDMf5q0bMvYkSYRSOKlwCgX8HyeUjnWrbFrfk25pmYI0B7P/kGfr5j2s3j+aHqjKwufS8e5I3WMiQeL3Ygvl/xvD89o2TvqUgAehHh/E5bzVE18UhcEU9pBunTxklCAwmy4Rjmxh0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUysENTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8632C116C6;
	Mon, 19 Jan 2026 13:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768830858;
	bh=SiLkNegzwVOS8KFzTjVbFGARwmNVM8mZyLGGXaoRFFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PUysENTJaUbMeVPtwCKTuqd3PhnLrtsfQKopFTDYHiq0dSLxeJx8FjhicT9s97h0+
	 bpgqkAZKN8WeyirGgFR8stccMhmeOMjZTsE8VHmZ3pIlXwc9oaIk9Y8XC6RBIRJQ/0
	 pIUHUU+FQoVLoKvXlKhH2O+kw3MIrqaxrxq0yhRTzHM3Y2EBzyDhKzwRuaD1bH6CXv
	 yHko3ZjFLIFxEOHBdn/IfBtiwLSPUAeG1aXdEq7l2nKpnWDIx0Z4bjoaqFzAoU+Gb5
	 U03/1exMrICy/sSVnZnZ7BWmVCDxqomCs1g6uS6CH1jrnxktOBhxQQndF4Cmsgyvoh
	 TsLXZQVfTKXdA==
From: Thomas Gleixner <tglx@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/6] irqchip/gic-v5: Code first ACPI boot support
In-Reply-To: <aW3pALPxn4i9fiDO@lpieralisi>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
 <aWy9T3VDyXpVG41z@lpieralisi> <87sec30yhk.ffs@tglx>
 <aW3pALPxn4i9fiDO@lpieralisi>
Date: Mon, 19 Jan 2026 14:54:14 +0100
Message-ID: <87pl751zeh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 19 2026 at 09:19, Lorenzo Pieralisi wrote:
> On Sun, Jan 18, 2026 at 03:47:03PM +0100, Thomas Gleixner wrote:
> I think the simplest way to sort this out is for this series to go via
> the ACPI tree if that's OK for Thomas, given that the ACPICA code will
> go via the ACPI tree anyway and there are other dependencies on it there
> I assume (this series is fairly self-contained).

I'm fine with that

Acked-by: Thomas Gleixner <tglx@kernel.org>

