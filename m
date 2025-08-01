Return-Path: <linux-pci+bounces-33277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD07B17F8E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 11:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C926916235E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCFB21CFF6;
	Fri,  1 Aug 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRCmxn4n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7F1A76DE;
	Fri,  1 Aug 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041642; cv=none; b=fPYR9abU94AJRGQcEoFD4Ee2okB5+7rn3wXBMvq6LMnTdbZY7GezU/NJ+WtZlLQt2cFUVLML60E1DSpMDVH3mMRAVoul3NHCWOZ1Hkfuf3SJvIyiPqEdZZLOhrmzs58ep/xVBupVQ/B336QeCEKVGi7GBfMVOLoEjDjKz2Kb1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041642; c=relaxed/simple;
	bh=BMntt7/aru1tXJivT6Bbb/N8lgR4/vQlo8pUtzmlNNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKX4eqafHhTgENAezl9JT8SPq+p62bW8/M5k83EUt4sRcsmKn3bVmDVCnZIMESHbS3KTvsE+hkP2yOCk/TC/bBpvKTBy4DS/1sziWSp9saft9fCLjaEgmXiDfEQIOnS+uf6oA6WEpFzEHfg5BscMik61YCLXQSi9CyRmiUCKdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRCmxn4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC484C4CEE7;
	Fri,  1 Aug 2025 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754041641;
	bh=BMntt7/aru1tXJivT6Bbb/N8lgR4/vQlo8pUtzmlNNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRCmxn4njKU3sJ695x1FfbE19HUDyG20lp/Dq0VOYikHH0qwCDShuwa6up4RoRaHq
	 tbdlxX9qw0rjuykrA8mofJQe8CpLTXLap00+KCYJXPHAGml3zCaTr4gZeUyh5xTVV0
	 qcP7hOG4zhUKWTxq1O1Mm6N2uwWnOJ4sTX8GyFWJMsQopE9lH2JDmQhXVrQgB3xNd7
	 015UL392LIrYzqbs5gzYg0yU2Mk6wS3iKrantn2RvMEPiVRntn8+OATcso4lnoEq9o
	 scyte6/IIAs7dIrKFyC//TG8y1vIh8nE3VsvGs7s2ksDQ6O05l2lKy0fsKT5nBMIkH
	 hHxUWv2ZwCFJA==
Date: Fri, 1 Aug 2025 15:17:09 +0530
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
Message-ID: <ofsbfhor5ah3yzvkc5g5kb4fpjlzoqkkzukctmr3f6ur4vl2e7@7zvudt63ucbk>
References: <20250731183944.GA3424583@bhelgaas>
 <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
 <vf65usnffqzlkgijm72nuaslxnflwrugc25vw6q6blbn2s2d2s@b35vjkowd6yc>
 <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a155e45-f723-4eec-81d3-2547bfe9a4e9@cixtech.com>

On Fri, Aug 01, 2025 at 05:25:51PM GMT, Hans Zhang wrote:
> 
> 
> On 2025/8/1 16:18, Manivannan Sadhasivam wrote:
> > EXTERNAL EMAIL
> > 
> > On Thu, Jul 31, 2025 at 09:01:17PM GMT, Arnd Bergmann wrote:
> > > On Thu, Jul 31, 2025, at 20:39, Bjorn Helgaas wrote:
> > > > On Thu, Jul 31, 2025 at 07:38:58PM +0200, Gerd Bayer wrote:
> > > > > 
> > > > > -  if (size == 1)
> > > > > -          return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> > > > > -  else if (size == 2)
> > > > > -          return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
> > > > > -  else if (size == 4)
> > > > > -          return pci_bus_read_config_dword(bus, devfn, where, val);
> > > > > -  else
> > > > > -          return PCIBIOS_BAD_REGISTER_NUMBER;
> > > > > +  if (size == 1) {
> > > > > +          rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
> > > > > +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> > > > > +          *val = ((*val >> 24) & 0xff);
> > > > > +#endif
> > > > 
> > > > Yeah, this is all pretty ugly.  Obviously the previous code in
> > > > __pci_find_next_cap_ttl() didn't need this.  My guess is that was
> > > > because the destination for the read data was always the correct type
> > > > (u8/u16/u32), but here we always use a u32 and cast it to the
> > > > appropriate type.  Maybe we can use the correct types here instead of
> > > > the casts?
> > > 
> > > Agreed, the casts here just add more potential for bugs.
> > > 
> > 
> > Ack. Missed the obvious issue during review.
> > 
> > > The pci_bus_read_config() interface itself may have been a
> > > mistake, can't the callers just use the underlying helpers
> > > directly?
> > > 
> > 
> > They can! Since the callers of this API is mostly the macros, we can easily
> > implement the logic to call relevant accessors based on the requested size.
> > 
> > Hans, could you please respin the series based the feedback since the series is
> > dropped for 6.17.
> > 
> 
> Dear all,
> 
> I am once again deeply sorry for the problems that occurred in this series.
> I only test pulling the ARM platform.
> 
> Thank you very much, Gerd, for reporting the problem.
> 
> Thank you all for your discussions and suggestions for revision.
> 
> Hi Mani,
> 
> Geert provided a solution. My patch based on this is as follows. Please
> check if there are any problems.
> https://lore.kernel.org/linux-pci/CAMuHMdVwFeV46oCid_sMHjXfP+yyGTpBfs9t3uaa=wRxNcSOAQ@mail.gmail.com/
> 
> Also, please ask Gerd to help test whether it works properly. Thank you very
> much.
> 
> 
> If there are no issues, am I sending the new version? Can this series of
> pacth 0001 be directly replaced?
> 

What benefit does this helper provide if it simply invokes the accessors based
on the requested size? IMO, the API should not return 'int' sized value if the
caller has explicitly requested to read variable size from config space.

- Mani

> 
> 
> 
> The patch is as follows:
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index ba66f55d2524..2bfd8fc1c0f5 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -89,15 +89,25 @@ int pci_bus_read_config(void *priv, unsigned int devfn,
> int where, u32 size,
>                         u32 *val)
>  {
>         struct pci_bus *bus = priv;
> +       int rc;
> +
> +       if (size == 1) {
> +               u8 byte;
> +
> +               rc = pci_bus_read_config_byte(bus, devfn, where, &byte);
> +               *val = byte;
> +       } else if (size == 2) {
> +               u16 word;
> +
> +               rc = pci_bus_read_config_word(bus, devfn, where, &word);
> +               *val = word;
> +       } else if (size == 4) {
> +               rc = pci_bus_read_config_dword(bus, devfn, where, val);
> +       } else {
> +               rc = PCIBIOS_BAD_REGISTER_NUMBER;
> +       }
> 
> -       if (size == 1)
> -               return pci_bus_read_config_byte(bus, devfn, where, (u8
> *)val);
> -       else if (size == 2)
> -               return pci_bus_read_config_word(bus, devfn, where, (u16
> *)val);
> -       else if (size == 4)
> -               return pci_bus_read_config_dword(bus, devfn, where, val);
> -       else
> -               return PCIBIOS_BAD_REGISTER_NUMBER;
> +       return rc;
>  }
> 
>  int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
> 
> 
> 
> Best regards,
> Hans
> 
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

