Return-Path: <linux-pci+bounces-29561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497DDAD77BC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6433B22BE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53D8299AB5;
	Thu, 12 Jun 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu1eX2+y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FFD299A9C;
	Thu, 12 Jun 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744523; cv=none; b=DJ6lr3xxZeFMfrELEjtETS7Uedw73Af6GPQF1huEpBwZnoTkCEl2vF7u8EpppSW35PxYTjp88DBjDlwpiUUw2fmdBb+n4aW/ww+lrrvzqPpoSexGTXLDPCLlwnYFlw1up9K2PutMDMKZ2vqti1gLe4CwsszihzJu+Qnggm2iVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744523; c=relaxed/simple;
	bh=7+b3JmMUKKzZHXO8vtquG03ptonMmn+AG6H+hfCo32c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5xFf9FUnxZXfQcm5M/EIq6WId+1i0d6Jz8k/Fzf05MxbIA/m2anwVsURt7vF4LExxXxzNwcH30vv1pQfhDRsdUQUsHH0mzWAB8ihKgfhPZMyEG5S9p7kt+R7YNr8mj0zmr/DWLpZoYH9LIl+xTwgr67xzx1t9P9V45WrWzzFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu1eX2+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62BAC4CEEB;
	Thu, 12 Jun 2025 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749744523;
	bh=7+b3JmMUKKzZHXO8vtquG03ptonMmn+AG6H+hfCo32c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yu1eX2+yaTkbsl/d4yM4lfN2qNWWfjohdrJaOUTEURh2W67frVLVNJ9rRCgFxQrZf
	 ndFlg8mMHcvOcqS4PhqSjZpEbYibip25n9/WMXx9yOX9Qth3pi9r1Ayvek6EEAdSHv
	 dpNwxRCRDKpCbTYgUBrbAGwJ94lvMUwnRRjqgU+jxCip+i+JE/KLG2QPyM/zn8B4rJ
	 Q8E6oTzwL6dbMpRzg3e6H8iuHtrL7hK+9Sl08Ggg407bIOdcfokMKeKs+14qTtTgx8
	 HyWxtWvtY4MFq9igWIknEFRf4dzrpbgGHF6GMIobafqVsAe1ZXwkLzRnaepfDdulDX
	 7aP4hDoAddGvQ==
Date: Thu, 12 Jun 2025 21:38:32 +0530
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
Message-ID: <az74rxjpfahjwmz7fg5agn47org7arpblariuauujhovkaieha@d6r2yp23vqan>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
 <20250313-pci_fixup_addr-v11-10-01d2313502ab@nxp.com>
 <v77jy5tldwuasjzqirlwx45zigt6bpnaiz67e4w7r2lxqrdsek@5qzzobothf5r>
 <aEr3nGCqRuyIwA37@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEr3nGCqRuyIwA37@lizhi-Precision-Tower-5810>

On Thu, Jun 12, 2025 at 11:51:56AM -0400, Frank Li wrote:
> On Thu, Jun 12, 2025 at 08:16:03PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Mar 13, 2025 at 11:38:46AM -0400, Frank Li wrote:
> > > If the parent 'ranges' property in DT correctly describes the address
> > > translation, the cpu_addr_fixup() callback is not needed. Print a warning
> > > message to inform users to correct their DTB files and prepare to remove
> > > cpu_addr_fixup().
> > >
> >
> > This patch seem to have dropped, but I do see a value in printing the warning to
> > encourage developers/users to fix the DTB in some way. Since we fixed the driver
> > to parse the DT 'ranges' properly, the presence of cpu_addr_fixup() callback
> > indicates that the translation is not properly described in DT. So DT has to be
> > fixed.
> 
> This patch already in mainline with Bjorn's fine tuned at when merge.
> 
> 	fixup = pci->ops ? pci->ops->cpu_addr_fixup : NULL;
>         if (fixup) {
>                 fixup_addr = fixup(pci, cpu_phys_addr);
>                 if (reg_addr == fixup_addr) {
>                         dev_info(dev, "%s reg[%d] %#010llx == %#010llx == fixup(cpu %#010llx); %ps is redundant with this devicetree\n",
>                                  reg_name, index, reg_addr, fixup_addr,
>                                  (unsigned long long) cpu_phys_addr, fixup);
>                 } else {
>                         dev_warn(dev, "%s reg[%d] %#010llx != %#010llx == fixup(cpu %#010llx); devicetree is broken\n",
>                                  reg_name, index, reg_addr, fixup_addr,
>                                  (unsigned long long) cpu_phys_addr);
>                         reg_addr = fixup_addr;
>                 }
> 
>                 return cpu_phys_addr - reg_addr;
>         }
> 
> I have not seen this "dev_warn(pci->dev, "cpu_addr_fixup() usage detected. Please fix your DTB!\n");"
> 

This patch is supposed to add this warning and nothing else.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

