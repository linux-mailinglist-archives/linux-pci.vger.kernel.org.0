Return-Path: <linux-pci+bounces-33270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B5FB17E17
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 10:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6F0547366
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 08:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0A1E9B08;
	Fri,  1 Aug 2025 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2kdb0Xx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB85B21A;
	Fri,  1 Aug 2025 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036301; cv=none; b=X7ZhL+pX6b3iucVPoTIpiE1LNC4QT1GDkKilzOSjVIeBCHPx4IMBuklltPK1VDvJUWTkedfpgTykbWsqJKMaV+uskFIxb0pPDsPNgR+GO2Qtfs8fFMN2JREBDMbjZy5va/F1yoodqiZ9UQPI512s1ETkyo+MoIXkYXBgD2JqYdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036301; c=relaxed/simple;
	bh=JnkQ2/vbKfyK5CDvDWWWWI6SqQ8kiXkH1PuRY4rnMHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iko70OSI74ihd8eMZRTg08aQqQTYPTxBQT33QH++ckC1eEGM2buPJSKVKHjC9kpzDjRX7WuhbiYchhBT/MVnsJqerzl635jEhak+UnjbeEyr0Mp7t0I9IhVYifRj3Llmb9TLdg7TzcwkO8d2WTV8nu6kqD0Fv2D6I6IhjAOMVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2kdb0Xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92ADC4CEE7;
	Fri,  1 Aug 2025 08:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754036300;
	bh=JnkQ2/vbKfyK5CDvDWWWWI6SqQ8kiXkH1PuRY4rnMHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2kdb0Xx0d2Fin2+BEaLJD7QrTyhvFIg/v7FCEAXHicfoza3NSGZ3NakSwiMkQiNn
	 04Or4YsHG12ianVg4GS3qgps0xwBwcied+Ry7+dju9UQ67exTa9K0gKGZmw9DPHnfA
	 xSEAHPz+G59mDOZYcF3L/v1yjVDbxqvMBmsDL3VhF82dEhjX9ndE4dA9MfcaGGW8gk
	 K+VsmzmGsEPWsaqd0I+HU4mPBYWmRrHLZU3sLDOddnbKzAR1LXMU398/8WBGAhBc/B
	 dMI1nAbkdWhHFN03AMuA4Dnd0EOIM/39l+/0kkpU1jR0lRAA9u+T187tA/uTZO0DV9
	 Ykefemp7rQkxA==
Date: Fri, 1 Aug 2025 13:48:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, 
	Hans Zhang <18255117159@163.com>, bhelgaas@google.com, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	jingoohan1@gmail.com, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-next <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Message-ID: <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>

On Thu, Jul 31, 2025 at 09:01:17PM GMT, Arnd Bergmann wrote:
> On Thu, Jul 31, 2025, at 20:39, Bjorn Helgaas wrote:
> > On Thu, Jul 31, 2025 at 07:38:58PM +0200, Gerd Bayer wrote:
> >>  
> >> -	if (size == 1)
> >> -		return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> >> -	else if (size == 2)
> >> -		return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> >> -	else if (size == 4)
> >> -		return pci_bus_read_config_dword(bus, devfn, where, val);
> >> -	else
> >> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> >> +	if (size == 1) {
> >> +		rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> >> +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> >> +		*val = ((*val >> 24) & 0xff);
> >> +#endif
> >
> > Yeah, this is all pretty ugly.  Obviously the previous code in
> > __pci_find_next_cap_ttl() didn't need this.  My guess is that was
> > because the destination for the read data was always the correct type
> > (u8/u16/u32), but here we always use a u32 and cast it to the
> > appropriate type.  Maybe we can use the correct types here instead of
> > the casts?
> 
> Agreed, the casts here just add more potential for bugs.
> 

Ack. Missed the obvious issue during review.

> The pci_bus_read_config() interface itself may have been a
> mistake, can't the callers just use the underlying helpers
> directly?
> 

They can! Since the callers of this API is mostly the macros, we can easily
implement the logic to call relevant accessors based on the requested size.

Hans, could you please respin the series based the feedback since the series is
dropped for 6.17.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

