Return-Path: <linux-pci+bounces-31521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD78AF8F5A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 12:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044E31C42F4F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD712EACE9;
	Fri,  4 Jul 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON3aeeq0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0234288C1C;
	Fri,  4 Jul 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623270; cv=none; b=Ls76LAYS5IuWtLkCjhpQmA6hoYE1X+pzhc8JE8rj8KohNVkCRa0p369RjaTiEi9cclKp3UV3FKiK4T5dO0hyqfF4nU0xy7h7dhwP/Zf56yH+S7UZZo04PrHaI8JAxN2mcCwg3dfmAjsVBc6o94enqKpD4+GpoNnNwF63xi5Qy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623270; c=relaxed/simple;
	bh=Cjcwlr07oXFOeUDkk0S4U3uYMwLzNl+Ks+4KvR9bZSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS9u1WIrQjF2cWSp/bAXfnwowzWFiayynjwQmD25D9l7EvzBq9vHvME3mWn3QZchyCTuEQ5oMjCq4H+ZR1RWBQburf7dmclHw3NkdSlOT22wbJ/8d39z1sljByxfmackpVCKWqMEMRKDuzezD+eoMBGm9MIAjBoCn2y/xkdMhh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON3aeeq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6080BC4CEF0;
	Fri,  4 Jul 2025 10:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751623270;
	bh=Cjcwlr07oXFOeUDkk0S4U3uYMwLzNl+Ks+4KvR9bZSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ON3aeeq0xJcW4IWX1NUx5rgTfwRr31J1wY4T2+o8Z5Dc0jzzojoTNr16Iedf2wPJd
	 5Fn8sUjJ7We9Twz1fDKPbVfPSHWCFaOId9SKVtzIS+8WdMONWg1r3da8USzBPi8aWX
	 4SeUKBhZT0X6dOuRc9jXRw8zZ1ppD3zRt/qKqoXR0sqJdzqoFPq44/FLSlnFKKfd/F
	 wJu6C6h08fKwKBWyE3h/kPUO6bM8WIiaSCGjefThb8CFjjJfCXdbIcc0T1Z8YIOmCS
	 q7RYflnZPGBQomUFkGSlVfIjcXIp35zu44gMz6XLLJHHBI+e0NVxhHbpAmKSZQSi18
	 p6EiKjaZ0bR5w==
Date: Fri, 4 Jul 2025 12:01:02 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 00/31] Arm GICv5: Host driver implementation
Message-ID: <aGemXoMHE2Y7msSk@lpieralisi>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703164743.00004f3e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703164743.00004f3e@huawei.com>

On Thu, Jul 03, 2025 at 04:47:43PM +0100, Jonathan Cameron wrote:
> 
> > ---
> > Changes in v7:
> > - Added CDDI/CDDIS/CDEN FIELD_PREP(hwirqid) for instruction preparation
> > - Fixed IST/DT/ITT L2 size selection logic for 64K PAGE_SIZE
> 
> Hi Lorenzo,
> 
> I took another look, particularly focused on this aspect and it all looks good to
> me.  Thanks for making these last minute changes.

Thank you for pointing them out - it is good we managed to make them.

> No more RBs from me but that is just down to my lack of confidence that I know my way
> around the spec well enough. It's not anything to do with the content of your series!

I am grateful you took some time to go through the series - you helped
me fix some issues, that's was very useful !

Thanks,
Lorenzo

> Thanks
> 
> Jonathan
> 
> 
> > - Reordered some ITS error paths according to review
> > - Link to v6: https://lore.kernel.org/r/20250626-gicv5-host-v6-0-48e046af4642@kernel.org

