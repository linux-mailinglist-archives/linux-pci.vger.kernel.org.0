Return-Path: <linux-pci+bounces-16612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1126A9C65D6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 01:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61121B27905
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 23:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B45521A4DB;
	Tue, 12 Nov 2024 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGO4PHGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9831FCC7B;
	Tue, 12 Nov 2024 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453686; cv=none; b=TZPKKKr4VbDTLICrQMud4OXn8MxtrRwXBsqVgDpgKJXRyUZ9UnzgzWhwrW0E/8cv+nFMiTHAwNe5TWyDGgCkzlrbwQcOkM9yPkathC+kRLZG9fJ4uBcDx2wRJgQMX3LMjP2oxtwJHPT1ESN9bN7nguE6EJtnlzH7Xnf5Ev4ZTFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453686; c=relaxed/simple;
	bh=pf5m812P4MpW8rpJVvllGJLZbUndrZP5mDpwz5bvzQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjrYJIxMEVfkds5QiT9RTOX/sWeP5lozoj3d52GEXXUWpkc+4+NejykB0m1yUf84IlzzlxIcM75Xh0mUY8V0eJ5oPDq2vzejULYMOhgVba4SJnKcgR7caN850sPzzsziKkjEOHp/AiC0YEOOOgYWrT2bGwgvn92GeyvJolkKVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGO4PHGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F084C4CECD;
	Tue, 12 Nov 2024 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731453685;
	bh=pf5m812P4MpW8rpJVvllGJLZbUndrZP5mDpwz5bvzQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGO4PHGYreJ8XxVHinU3igucwMCbUdi18QBVZzLsJfUEpNlXATUHnb8tGnJkEOyfe
	 dgOMrh5LUehS/d982NRoNjRW2gmZ3ztSBIWQ5EruxZpI8VRJkLqTlpuh6l5TA/6Bgd
	 8f5ZOe23ZvXY1SUp7hhAEiLe4Hf4W6vMkkvnJcu5JgezAxqwEBCK4wztiq4vqlZeFQ
	 kOHEisXaMWl/rXhUWGHT+4K6FKrbJ06g6TCog2kTzk1It/UBD5o7nakcTZHO/vrBgo
	 A1yeVjscWK5CJmKD0/eSo47aA2vPxH8504HdCki/ZVLfgCYZVtOQ8RmAgLOnMPAeo3
	 K3cVluZFr5CIA==
Date: Tue, 12 Nov 2024 17:21:22 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI: pwrctl: Add power control driver for qps615
Message-ID: <sfygtqch7ldrvtfdfumwmejkekv2j2hcoqemu4ne3bvejqdpdd@dons6axfbywx>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-6-29a1e98aa2b0@quicinc.com>
 <qyoh5vsdcih7vs3aq3ltw3dxkxqe6jdpugh64i2hyjm2in7bl3@okblag6jl4gv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qyoh5vsdcih7vs3aq3ltw3dxkxqe6jdpugh64i2hyjm2in7bl3@okblag6jl4gv>

On Tue, Nov 12, 2024 at 09:51:42AM -0600, Bjorn Andersson wrote:
> On Tue, Nov 12, 2024 at 08:31:38PM +0530, Krishna chaitanya chundru wrote:
> > QPS615 is the PCIe switch which has one upstream and three downstream
> > ports. To one of the downstream ports ethernet MAC is connected as endpoint
> > device. Other two downstream ports are supposed to connect to external
> > device. One Host can connect to QPS615 by upstream port. QPS615 switch
> > needs to be configured after powering on and before PCIe link was up.
> > 
> > The PCIe controller driver already enables link training at the host side
> > even before qps615 driver probe happens, due to this when driver enables
> > power to the switch it participates in the link training and PCIe link
> > may come up before configuring the switch through i2c. To prevent the
> > host from participating in link training, disable link training on the
> > host side to ensure the link does not come up before the switch is
> > configured via I2C.
> > 
> > Based up on dt property and type of the port, qps615 is configured
> > through i2c.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 

Sorry, while I think this looks okay, this patch still does not compile.

Trying to compile this code with either clang 14 or 17 I still get the
following error:

  CC [M]  drivers/pci/pwrctl/pci-pwrctl-qps615.o
In file included from drivers/pci/pwrctl/pci-pwrctl-qps615.c:6:
In file included from ./include/linux/delay.h:13:
In file included from ./include/linux/sched.h:13:
In file included from ./arch/arm64/include/asm/processor.h:29:
In file included from ./include/linux/cache.h:6:
In file included from ./arch/arm64/include/asm/cache.h:43:
In file included from ./arch/arm64/include/asm/cputype.h:228:
In file included from ./arch/arm64/include/asm/sysreg.h:1129:
./include/linux/bitfield.h:166:3: error: call to '__bad_mask' declared with 'error' attribute: bad bitfield mask
  166 |                 __bad_mask();
      |                 ^
./include/linux/bitfield.h:166:3: error: call to '__bad_mask' declared with 'error' attribute: bad bitfield mask
2 errors generated.
make[5]: *** [scripts/Makefile.build:229: drivers/pci/pwrctl/pci-pwrctl-qps615.o] Error 1
make[4]: *** [scripts/Makefile.build:478: drivers/pci/pwrctl] Error 2
make[3]: *** [scripts/Makefile.build:478: drivers/pci] Error 2
make[2]: *** [scripts/Makefile.build:478: drivers] Error 2
make[1]: *** [/home/bjorn/sandbox/kernel/sm8150/Makefile:1946: .] Error 2
make: *** [Makefile:224: __sub-make] Error 2

This is caused by the way you invoke u32_replace_bits()

Regards,
Bjorn

