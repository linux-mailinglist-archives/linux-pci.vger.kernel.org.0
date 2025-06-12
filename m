Return-Path: <linux-pci+bounces-29566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60676AD7832
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415543AB46F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462AD29A30A;
	Thu, 12 Jun 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1IueeP8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C9289819;
	Thu, 12 Jun 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745587; cv=none; b=u+2J/zWRLLTtcimkL1Ep85V3BZWjDpam9xONzAyA+UeUgzgDzmhuUInkEhj51eacbjfzmxHGLcb0Ea4II7TWBWjcG8RlAg8duqoBG+g3PShTFdkjb5nTAoVIUJqUyShGLNMru6EcfdOUN7ed/FBJS7SeFFp6xhlI7npfm+YZRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745587; c=relaxed/simple;
	bh=NQ6xQrI6xRICauGqmG8+811qPY6OBMasjJDZZOhrqWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+vJhDGQxrlOuokpDjfLcHwwjP0GvHnaccd7R+dxufJS0Hek/al/mNR0d1cY+ovyvNTBO6zlOCdIyjFnK6TD5RE14L2PUnCP9qhtcu4L/c68czrF31Bi96uiy41hS9j9mJY7Ua6nQoeGrR1J+f11Brc2BujWPVWNxFa5E+mRl7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1IueeP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83750C4CEEA;
	Thu, 12 Jun 2025 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749745586;
	bh=NQ6xQrI6xRICauGqmG8+811qPY6OBMasjJDZZOhrqWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1IueeP8MhSNKemYeDzcGE0Lzkp370T8632GFkXCOrak1MTq79qxrOqwn1ERM0b9P
	 1uLfjqz8995hI0bTDZPmNR50uTnKW0QmLb1cKdZ4L8+3adol0w1GzlcLcfHMHKcmXh
	 dvHfTIwIyiIgWQeI1sY9RIkygnJoWBgDH8khXd5T/GvPZrTePF3yq5VxcgIxRHydgD
	 FOodfpIls9T5qZVVSSc9GkHyC1FmavV9KiTQGxRV+WI4fmu9y3SljFkCaW8HhsdS2h
	 eusepCYgFYvhinVmC9+B2FV+Ku57PSfl+pH/vaa9w1URli1JOKFGCauX27Jyxc6GQV
	 dERmHBodm3Onw==
Date: Thu, 12 Jun 2025 21:56:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 10/11] PCI: dwc: Print warning message when
 cpu_addr_fixup() exists
Message-ID: <hwtjbhqeckzicoqfd5go25ag7kpubjaosvhufx7qc6jtfnwkof@x3vb274rtpwq>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
 <20250313-pci_fixup_addr-v11-10-01d2313502ab@nxp.com>
 <v77jy5tldwuasjzqirlwx45zigt6bpnaiz67e4w7r2lxqrdsek@5qzzobothf5r>
 <aEr3nGCqRuyIwA37@lizhi-Precision-Tower-5810>
 <az74rxjpfahjwmz7fg5agn47org7arpblariuauujhovkaieha@d6r2yp23vqan>
 <aEr9+NQA6o0ypSuy@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEr9+NQA6o0ypSuy@lizhi-Precision-Tower-5810>

On Thu, Jun 12, 2025 at 12:19:04PM -0400, Frank Li wrote:
> On Thu, Jun 12, 2025 at 09:38:32PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jun 12, 2025 at 11:51:56AM -0400, Frank Li wrote:
> > > On Thu, Jun 12, 2025 at 08:16:03PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Mar 13, 2025 at 11:38:46AM -0400, Frank Li wrote:
> > > > > If the parent 'ranges' property in DT correctly describes the address
> > > > > translation, the cpu_addr_fixup() callback is not needed. Print a warning
> > > > > message to inform users to correct their DTB files and prepare to remove
> > > > > cpu_addr_fixup().
> > > > >
> > > >
> > > > This patch seem to have dropped, but I do see a value in printing the warning to
> > > > encourage developers/users to fix the DTB in some way. Since we fixed the driver
> > > > to parse the DT 'ranges' properly, the presence of cpu_addr_fixup() callback
> > > > indicates that the translation is not properly described in DT. So DT has to be
> > > > fixed.
> > >
> > > This patch already in mainline with Bjorn's fine tuned at when merge.
> > >
> > > 	fixup = pci->ops ? pci->ops->cpu_addr_fixup : NULL;
> > >         if (fixup) {
> > >                 fixup_addr = fixup(pci, cpu_phys_addr);
> > >                 if (reg_addr == fixup_addr) {
> > >                         dev_info(dev, "%s reg[%d] %#010llx == %#010llx == fixup(cpu %#010llx); %ps is redundant with this devicetree\n",
> > >                                  reg_name, index, reg_addr, fixup_addr,
> > >                                  (unsigned long long) cpu_phys_addr, fixup);
> > >                 } else {
> > >                         dev_warn(dev, "%s reg[%d] %#010llx != %#010llx == fixup(cpu %#010llx); devicetree is broken\n",
> > >                                  reg_name, index, reg_addr, fixup_addr,
> > >                                  (unsigned long long) cpu_phys_addr);
> > >                         reg_addr = fixup_addr;
> > >                 }
> > >
> > >                 return cpu_phys_addr - reg_addr;
> > >         }
> > >
> > > I have not seen this "dev_warn(pci->dev, "cpu_addr_fixup() usage detected. Please fix your DTB!\n");"
> > >
> >
> > This patch is supposed to add this warning and nothing else.
> 
> We can forget this one. Can help check doorbell patch if you have time
> 
> https://lore.kernel.org/imx/202506101649.UpwblcVd-lkp@intel.com/T/#t
> 

I'm going through the queue. Will get to it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

