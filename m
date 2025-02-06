Return-Path: <linux-pci+bounces-20836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D246AA2B35C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 21:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED85163F20
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 20:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C61D5CFF;
	Thu,  6 Feb 2025 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caFWIi5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94E188CB1;
	Thu,  6 Feb 2025 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873617; cv=none; b=gYGMSnCbKgg4Vi9cahDXfwO9SgzBdUhZTZ3FD6RhCIZbMOgE3hL0SRUrTmM47yhQ3IyRFhrqmelxvwlqqjOOHlF/vPaKuAI/cUEP0HR6ZnkwtdaR3XAqe+JzpGULERe+gD1E/Lv/BmhMI+uTrrf7rjAVhNt8hjn1mQb7OZcoTU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873617; c=relaxed/simple;
	bh=sgPKDwRH/rtUBdMxUKBnDrkfhvUevPepAlFNSgD32KU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=slsnGatcCdOWxloVWSl2+09PxbFh+v1thKjgQj9tRwXi993wuBgf4IOhtXdD979ESzD/NkBiocKR2bKVSevekQjjl57eqexL9VGeCTo3L+A9vVKSVAnxCinGBrwwRxa2DKGQ/1FJKEeLqZRSiOVbFlkZcD53cY59zlwX8peG4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caFWIi5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059F4C4CEDD;
	Thu,  6 Feb 2025 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738873616;
	bh=sgPKDwRH/rtUBdMxUKBnDrkfhvUevPepAlFNSgD32KU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=caFWIi5wTSOWCnxtU6v3RNc9lBJsUgxMeiA3ACtaPT3PSfM8MNQBdxSgGqWhpEIlc
	 kXVYU8wxd9ZnS1ozYFxA/PUqrN0zQsswGCihLzPP2QvhPA/WyhI9jQGkXTK/or7fbH
	 sRv1QcY/q/VKmBAFD4oyvN/T24ew0kZtqXOQAcGtGAFeSYBMMFJxTTVIekz1uqHZ+5
	 nXyJRvCvisRIVcHMF6J8vfFZ30kevX4+a1U1F4qNzsIDTWwSxGPzaut1FrNui0lljW
	 0kzS7vqUBK8Lyvqs3ZBiG3E/HHkv4AAT8yo35hzVGKkqcwbVlWJSlrQwxVFRGgZCJ3
	 ljc1x5nFKNKTw==
Date: Thu, 6 Feb 2025 14:26:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250206202654.GA1000968@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN7PR12MB7201C9D05D5E4AB4D5D091F88BF62@SN7PR12MB7201.namprd12.prod.outlook.com>

On Thu, Feb 06, 2025 at 04:07:23PM +0000, Havalige, Thippeswamy wrote:
> > -----Original Message-----
> > From: Markus Elfring <Markus.Elfring@web.de>
> > Sent: Wednesday, February 5, 2025 8:40 PM
> > To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>; linux-
> > pci@vger.kernel.org; devicetree@vger.kernel.org; Bjorn Helgaas
> > <bhelgaas@google.com>; Conor Dooley <conor+dt@kernel.org>; Krzysztof
> > Kozlowski <krzk+dt@kernel.org>; Krzysztof Wilczyński <kw@linux.com>;
> > Lorenzo Pieralisi <lpieralisi@kernel.org>; Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>; Rob Herring <robh@kernel.org>
> > Cc: LKML <linux-kernel@vger.kernel.org>; Gogada, Bharat Kumar
> > <bharat.kumar.gogada@amd.com>; Jingoo Han <jingoohan1@gmail.com>;
> > Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
> > 
> > …
> > > +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > > @@ -0,0 +1,476 @@
> > …
> > > +static void amd_mdb_mask_intx_irq(struct irq_data *data)
> > > +{
> > …
> > > +	raw_spin_lock_irqsave(&port->lock, flags);
> > > +	val = pcie_read(pcie, AMD_MDB_TLP_IR_MASK_MISC);
> > > +	pcie_write(pcie, (val & (~mask)), AMD_MDB_TLP_IR_ENABLE_MISC);
> > > +	raw_spin_unlock_irqrestore(&port->lock, flags);
> > > +}
> > …
> > 
> > Under which circumstances would you become interested to apply a
> > statement like “guard(raw_spinlock_irqsave)(&port->lock);”?
> > https://elixir.bootlin.com/linux/v6.13.1/source/include/linux/spinlock.h#L551
>
> -Thanks for review comments, raw_spin_lock_irqsave is lightweight
> and performance oriented. 
>
> Achieves it by not performing few checks related to preemption, lock
> deprecation that was originally in spin_lock_irqsave.
>
> If you add guard around guard around the raw_spin_lock_irqsave then
> it should provide those additional safety checks.
>
> Its need is based on the environment, if you needs those
> checks/features.  We need to check the implementation/code to
> exactly see what are those. So choose to prevent my interrupt
> handler from being affected by latency pruning

IIUC, using guard() would not add any additional checks; it only helps
prevent errors like returning from the function without releasing the
lock.

That makes sense in larger functions with multiple exits, but IMO
there's no real benefit in a case like this where the function is so
short, there's only one exit, and it's completely obvious that we
lock, do something, and unlock.

I don't *really* like guard() anyway because it's kind of magic in
that the unlock doesn't actually appear in the code, and it's kind of
hard to unravel what guard() is and how it works.  But I guess that's
mostly because it's just a new idiom that takes time to internalize.

Bjorn

