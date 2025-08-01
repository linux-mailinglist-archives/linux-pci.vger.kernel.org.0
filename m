Return-Path: <linux-pci+bounces-33281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57650B18074
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 12:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A273BCDB9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 10:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9085D2367A3;
	Fri,  1 Aug 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL/TpJyK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93A21FF46;
	Fri,  1 Aug 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045666; cv=none; b=Ib64AnTmbIQ+8dFHBgcOUFLQGUmd02GhBAFN30TCB9qHf64JLpJcZIh1trde+8BS8gRi8YCRNet7DGSlUMSuTtQ3nG23B1G20Efy7tV8ClnGdxx7QlyVFl7JjAFYtfdzm5JeRPP/sfFdZ7WN/LntCbIU9XVlySlJRPpHh5FBDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045666; c=relaxed/simple;
	bh=myYzSNwriZvRpDEj3FcEmXCvVm+biUXHDxD1/ueZ1sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrLuFS15aBpscgu0eUjxCdyBsCI7GhInE4SJFnVl4nTPUe5bEpejBPSCoxM+Yrdvx+pALLpAyjVsQVcu4k0cWw3osp+MQ1NF3JZOge8+ZUhjhVKpR9xKZGv2x7Ubb9BP+UNjBg4VVozdSsLTso/9TbobaG0qz2nP2MKzlTzZ/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL/TpJyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22A6C4CEE7;
	Fri,  1 Aug 2025 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754045665;
	bh=myYzSNwriZvRpDEj3FcEmXCvVm+biUXHDxD1/ueZ1sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uL/TpJyKQhIJA/0KdOdHeoi0LXzUVubKbL63Nx09oLARYcmuutnvDcaBMjuPKK/Wn
	 2SVcGcwsD3HU7zDy+63soWReEM5VVbLEj9thpVu6xgrovUgOt2ls0vls9ZfUrBvVfT
	 4aYVdDGBNqFYhK1ufL+Zn/MQSnhoHj9hj3VXsjZ0Ks3ZQ3E+HvOQpbWyH3GizjvKIG
	 oQDvmPqg/tuFiCkOQxVn/Be8MfOg/8WjJp2G3sMSPxdtYaryHce1D3JWT8D5QmAGUf
	 D19IVFXoPYA7snPLUdaCtdfBbyvzoOPcZcq0W7DcU5n9AETnD2q6CBNi3k4xNxZ5by
	 NrIZV97nL0rTQ==
Date: Fri, 1 Aug 2025 16:24:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Gerd Bayer <gbayer@linux.ibm.com>, Hans Zhang <18255117159@163.com>, bhelgaas@google.com, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, jingoohan1@gmail.com, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-next <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, geert@linux-m68k.org
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Message-ID: <cu7qdbwmnixqjce4aetr5ldwe3sqoixgq4fuzmzajzphjdywqq@yw6ojbgeqktm>
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
 <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
 <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8ffdd21-9000-40c2-9f4d-4d6318e730b5@cixtech.com>

On Fri, Aug 01, 2025 at 06:06:16PM GMT, Hans Zhang wrote:
> 
> 
> On 2025/8/1 17:47, Manivannan Sadhasivam wrote:
> > EXTERNAL EMAIL
> > 
> > On Fri, Aug 01, 2025 at 05:25:51PM GMT, Hans Zhang wrote:
> > > 
> > > 
> > > On 2025/8/1 16:18, Manivannan Sadhasivam wrote:
> > > > EXTERNAL EMAIL
> > > > 
> > > > On Thu, Jul 31, 2025 at 09:01:17PM GMT, Arnd Bergmann wrote:
> > > > > On Thu, Jul 31, 2025, at 20:39, Bjorn Helgaas wrote:
> > > > > > On Thu, Jul 31, 2025 at 07:38:58PM +0200, Gerd Bayer wrote:
> > > > > > > 
> > > > > > > -  if (size == 1)
> > > > > > > -          return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> > > > > > > -  else if (size == 2)
> > > > > > > -          return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> > > > > > > -  else if (size == 4)
> > > > > > > -          return pci_bus_read_config_dword(bus, devfn, where, val);
> > > > > > > -  else
> > > > > > > -          return PCIBIOS_BAD_REGISTER_NUMBER;
> > > > > > > +  if (size == 1) {
> > > > > > > +          rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> > > > > > > +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> > > > > > > +          *val = ((*val >> 24) & 0xff);
> > > > > > > +#endif
> > > > > > 
> > > > > > Yeah, this is all pretty ugly.  Obviously the previous code in
> > > > > > __pci_find_next_cap_ttl() didn't need this.  My guess is that was
> > > > > > because the destination for the read data was always the correct type
> > > > > > (u8/u16/u32), but here we always use a u32 and cast it to the
> > > > > > appropriate type.  Maybe we can use the correct types here instead of
> > > > > > the casts?
> > > > > 
> > > > > Agreed, the casts here just add more potential for bugs.
> > > > > 
> > > > 
> > > > Ack. Missed the obvious issue during review.
> > > > 
> > > > > The pci_bus_read_config() interface itself may have been a
> > > > > mistake, can't the callers just use the underlying helpers
> > > > > directly?
> > > > > 
> > > > 
> > > > They can! Since the callers of this API is mostly the macros, we can easily
> > > > implement the logic to call relevant accessors based on the requested size.
> > > > 
> > > > Hans, could you please respin the series based the feedback since the series is
> > > > dropped for 6.17.
> > > > 
> > > 
> > > Dear all,
> > > 
> > > I am once again deeply sorry for the problems that occurred in this series.
> > > I only test pulling the ARM platform.
> > > 
> > > Thank you very much, Gerd, for reporting the problem.
> > > 
> > > Thank you all for your discussions and suggestions for revision.
> > > 
> > > Hi Mani,
> > > 
> > > Geert provided a solution. My patch based on this is as follows. Please
> > > check if there are any problems.
> > > https://lore.kernel.org/linux-pci/CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpBfs9t3uaa=wRxNcSOAQ@mail.gmail.com/
> > > 
> > > Also, please ask Gerd to help test whether it works properly. Thank you very
> > > much.
> > > 
> > > 
> > > If there are no issues, am I sending the new version? Can this series of
> > > pacth 0001 be directly replaced?
> > > 
> > 
> > What benefit does this helper provide if it simply invokes the accessors based
> > on the requested size? IMO, the API should not return 'int' sized value if the
> > caller has explicitly requested to read variable size from config space.
> > 
> 
> Dear Mani,
> 
> This newly added macro definition PCI_FIND_NEXT_CAP is derived from
> __pci_find_next_cap_ttl. Another newly added macro definition,
> PCI_FIND_NEXT_EXT_CAP, is derived from pci_find_next_ext_capability. The
> first one has no return value judgment, while the second one has a judgment
> return value. So, pci_bus_read_config is defined as having an int return
> value.
> 

Sorry, my previous reply was not clear. I was opposed to returning 'u32 *val'
for a variable 'size' value. The API should only return 'val' of 'size' ie. if
size is 1, it should return 'u8 *val' and so on. It finally breaks down to
calling the underlying accessors. So I don't see a value in having this API.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

