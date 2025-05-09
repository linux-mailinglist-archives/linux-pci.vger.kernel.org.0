Return-Path: <linux-pci+bounces-27515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01BAB19C9
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C975437FD
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A600323817D;
	Fri,  9 May 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCj9cQ1J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C923817A;
	Fri,  9 May 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806429; cv=none; b=X8PcavGUBf2AhA5DcWq5rblb1SKbhQKX1ZKrCsoxUmn8y3urdOhtHCp/27zMmq5ZTdiApxzLZhMm9NXGXQc4Rpcom1X8V9WMoK76WVkWfA/CSulF+pjwojMXnNNGpbaImCanmPymvEv+qwRbKyuZxvUO47rrEX19+W5w/9mypi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806429; c=relaxed/simple;
	bh=KfIHN/86orJ7nKka+FJYVTfaWZnIOh2Jd1eqQpCx/P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJbtoHGjtaHrZiYqTdwhKhxOyDinls4NRiB6UsJkl6vnseUjN2uJYXAbFMkIcakFTS7whof51kIzoECw4SjYRehysQ13KyuAoKxOmaAZG8QaNlWOlGk8hQm+dQU4ozGOgiZz+e69DL3aFnWBNRffcIUpESHHwxE3aMpMzJG4uAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCj9cQ1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE25DC4CEED;
	Fri,  9 May 2025 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806429;
	bh=KfIHN/86orJ7nKka+FJYVTfaWZnIOh2Jd1eqQpCx/P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCj9cQ1JPMPcXPWQy0TEfXoK1zM7XOVSEknGtzYgKFW0dihIWuG8T5GXJIeZ1Cl4X
	 QWchwoGNG/AFG1055je1pRe/sI54BBfWbUY4JcRmde66nwE9kEICBr3X2Z3vGrdCAw
	 zC+VQP+ks+64VrrNv/WWrQg/IiuSu6sto9LjbMrtay1G+/0f4T9n/LO9gT1MVNcOTK
	 L8NO8ACl2M2wMi3rM2Udq4AIpLrJL9jOPWp08PAS1x5yKlXZC7f7QX5dfjgq5QOsnK
	 XZgsDJCO/pOkv0TNabWfltJFJA8fHdvIEvvv4d5atnHQOa34mPSVMw319kRyK6A9c7
	 I0gNNFc3DfcJw==
Received: by pali.im (Postfix)
	id 00CDC5BA; Fri,  9 May 2025 18:00:25 +0200 (CEST)
Date: Fri, 9 May 2025 18:00:25 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Hans Zhang <18255117159@163.com>, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, heiko@sntech.de, yue.wang@amlogic.com,
	neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 3/3] PCI: aardvark: Remove redundant MPS configuration
Message-ID: <20250509160025.s65aw5ix6s7533b5@pali>
References: <20250506173439.292460-1-18255117159@163.com>
 <20250506173439.292460-4-18255117159@163.com>
 <20250506174110.63ayeqc4scmwjj6e@pali>
 <8a6adc24-5f40-4f22-9842-b211e1ef5008@163.com>
 <ff6abbf6-e464-4929-96e6-16e43c62db06@163.com>
 <20250507163620.53v5djmhj3ywrge2@pali>
 <oy5wlkvp7nrg65hmbn6cwjcavkeq7emu65tsh4435gxllyb437@7ai23qsmpesy>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oy5wlkvp7nrg65hmbn6cwjcavkeq7emu65tsh4435gxllyb437@7ai23qsmpesy>
User-Agent: NeoMutt/20180716

On Friday 09 May 2025 12:38:48 Manivannan Sadhasivam wrote:
> On Wed, May 07, 2025 at 06:36:20PM +0200, Pali Rohár wrote:
> > On Wednesday 07 May 2025 23:06:51 Hans Zhang wrote:
> > > On 2025/5/7 23:03, Hans Zhang wrote:
> > > > On 2025/5/7 01:41, Pali Rohár wrote:
> > > > > On Wednesday 07 May 2025 01:34:39 Hans Zhang wrote:
> > > > > > The Aardvark PCIe controller enforces a fixed 512B payload size via
> > > > > > PCI_EXP_DEVCTL_PAYLOAD_512B, overriding hardware capabilities and PCIe
> > > > > > core negotiations.
> > > > > > 
> > > > > > Remove explicit MPS overrides (PCI_EXP_DEVCTL_PAYLOAD and
> > > > > > PCI_EXP_DEVCTL_PAYLOAD_512B). MPS is now determined by the PCI core
> > > > > > during device initialization, leveraging root port configurations and
> > > > > > device-specific capabilities.
> > > > > > 
> > > > > > Aligning Aardvark with the unified MPS framework ensures consistency,
> > > > > > avoids artificial constraints, and allows the hardware to operate at
> > > > > > its maximum supported payload size while adhering to PCIe
> > > > > > specifications.
> > > > > > 
> > > > > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > > > > ---
> > > > > >   drivers/pci/controller/pci-aardvark.c | 2 --
> > > > > >   1 file changed, 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/pci-aardvark.c
> > > > > > b/drivers/pci/controller/pci-aardvark.c
> > > > > > index a29796cce420..d8852892994a 100644
> > > > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > > > @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct
> > > > > > advk_pcie *pcie)
> > > > > >       reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
> > > > > >       reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
> > > > > >       reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
> > > > > > -    reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > > > > >       reg &= ~PCI_EXP_DEVCTL_READRQ;
> > > > > > -    reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
> > > > > >       reg |= PCI_EXP_DEVCTL_READRQ_512B;
> > > > > >       advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
> > > > > > -- 
> > > > > > 2.25.1
> > > > > > 
> > > > > 
> > > > > Please do not remove this code. It is required part of the
> > > > > initialization of the aardvark PCI controller at the specific phase,
> > > > > as defined in the Armada 3700 Functional Specification.
> > > > > 
> > > > > There were reported more issues with those Armada PCIe controllers for
> > > > > which were already sent patches to mailing list in last 5 years. But
> > > > > unfortunately not all fixes were taken / applied yet.
> > > > 
> > > > Hi Pali,
> > > > 
> > > > I replied to you in version v2.
> > > > 
> > > > Is the maximum MPS supported by Armada 3700 512 bytes?
> > 
> > IIRC yes, 512-byte mode is supported. And I think in past I was testing
> > some PCIe endpoint card which required 512-byte long payload and did not
> > worked in 256-byte long mode (not sure if the card was not able to split
> > transaction or something other was broken, it is quite longer time).
> > 
> > > > What are the default values of DevCap.MPS and DevCtl.MPS?
> > 
> > Do you mean values in the PCI-to-PCI bridge device of PCIe Root Port
> > type?
> > 
> > Aardvark controller does not have the real HW PCI-to-PCI bridge device.
> > There is only in-kernel emulation drivers/pci/pci-bridge-emul.c which
> > create fake kernel PCI device in the hierarchy to make kernel and
> > userspace happy. Yes, this is deviation from the PCIe standard but well,
> > buggy HW is also HW.
> > 
> > And same applies for the pci-mvebu.c driver for older Marvell PCIe HW.
> > 
> 
> Oh. Then this patch is not going to change the MPS setting of the root bus. But
> that also means that there is a deviation in what the PCI core expects for a
> root port and what is actually programmed in the hw.

Yes, exactly this aardvark PCIe controller deviates from the PCIe spec
in lot of things. That is why it is needed to be really careful about
such changes.

Same applies for pci-mvebu.c. Both are PCIe controllers on Marvell
hardware, but it questionable from who both these IPs and hence source
of the issues.

Also these PCIe controllers have lot of HW bugs and documented and
undocumented erratas (for things which should work, but does not).

So it is not just as "enable or disable this bit and it would work". It
is needed to properly check if such functionality is provided by HW and
whether there is not some documented/undocumented errata for this
feature which could say "its broken, do not try to set this bit".

> Even in this MPS case, if the PCI core decides to scale down the MPS value of
> the root port, then it won't be changed in the hw and the hw will continue to
> work with 512B? Shouldn't the controller driver change the hw values based on
> the values programmed by PCI core of the emul bridge?

Marvell PCIe controllers has their own ways how to configure different
things of PCIe HW via custom platform registers. This is something which
needs to be properly understood and implemented as 1:1 mapping to kernel
root port emulator. Drivers should do it but it is unfinished. And as I
already said I stopped any development in this area years ago when PCIe
maintainers stopped taking my fixes for these drivers. As I said I'm not
going to spend my free time to investigate again issues there, prepare
fixes for them and just let them dropped into trash as nobody is
interested in them. I have other more useful things to do in my free
time.

> But until that is fixed, this patch should be dropped.

