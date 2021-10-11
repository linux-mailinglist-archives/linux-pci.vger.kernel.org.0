Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C9429703
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhJKSns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhJKSnr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Oct 2021 14:43:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A37F60EB1;
        Mon, 11 Oct 2021 18:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633977707;
        bh=OUpsvaa2Ww8kOdRdhRMnEsW/y3JxO0MjIcQCoVLgCz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASGTHeGvamJWUEwSAeRjQDib2OtvfxkhIFCDCwT5tnO2iFyGAoiMCJFQtqRkE0eG8
         dpmHYWzcNuADcklKZPise08Y0u7QIlVOy2c/3Ri7yj6XIAAlg6OyikBlYNYC5BLyOG
         PLazxCWmheZqDqaL/TKGcBOlJRA0JWDG8Ujmd2+RMR8O9goVoNsoxV2GZ4q8UgDOHp
         /lmRda7U4NHhiwMkcChPALtVMFxGTLs+cBOFUhXfQif4KZrEptMlklYraHbIzEhEjT
         mKey+azEelJu+Dx7KPpl/7vF8QP7MYStdPRDoT9vv1PRuLzKE8O7k0BPO7+P5g6Fgc
         EnwlapTByzZBw==
Received: by pali.im (Postfix)
        id 04A9A7C9; Mon, 11 Oct 2021 20:41:44 +0200 (CEST)
Date:   Mon, 11 Oct 2021 20:41:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:PCI DRIVER FOR AARDVARK (Marvell Armada 3700)" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 09/22] PCI: aardvark: Use SET_PCI_ERROR_RESPONSE() when
 device not found
Message-ID: <20211011184144.qcbmif7hvzozdgzw@pali>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <f423dc9cc90e345680d289d5df7ff469e9b89c60.1633972263.git.naveennaidu479@gmail.com>
 <20211011180850.hgp4ctykvus37fx7@pali>
 <20211011182526.kboaxqofdpd2jjrl@theprophet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011182526.kboaxqofdpd2jjrl@theprophet>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 11 October 2021 23:55:35 Naveen Naidu wrote:
> On 11/10, Pali Rohár wrote:
> > On Monday 11 October 2021 23:26:33 Naveen Naidu wrote:
> > > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > > causes a PCI error.  There's no real data to return to satisfy the
> > > CPU read, so most hardware fabricates ~0 data.
> > > 
> > > Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
> > > read occurs.
> > > 
> > > This helps unify PCI error response checking and make error check
> > > consistent and easier to find.
> > > 
> > > Compile tested only.
> > > 
> > > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > > ---
> > >  drivers/pci/controller/pci-aardvark.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > index 596ebcfcc82d..dc2f820ef55f 100644
> > > --- a/drivers/pci/controller/pci-aardvark.c
> > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > @@ -894,7 +894,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > >  	int ret;
> > >  
> > >  	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
> > > -		*val = 0xffffffff;
> > > +		SET_PCI_ERROR_RESPONSE(val);
> > 
> > Hello! Now I'm looking at this macro, and should not it depends on
> > "size" argument? If doing 8-bit or 16-bit read operation then should not
> > it rather sets only low 8 bits or low 16 bits to ones?
> >
> 
> Hello o/, Thank you for the review.
> 
> Yes! you are right that it should indeed depend on the "size" argument.
> And that is what the SET_PCI_ERROR_RESPONSE macro does. The macro is
> defined as:
> 
>   #define PCI_ERROR_RESPONSE           (~0ULL)
>   #define SET_PCI_ERROR_RESPONSE(val)  (*val = ((typeof(*val))PCI_ERROR_RESPONSE))
> 
> The macro was part of "Patch 1/22" and is present here [1]. Apologies if
> I added the receipient incorrectly.
> 
> [1]:
> https://lore.kernel.org/linux-pci/d8e423386aad3d78bca575a7521b138508638e3b.1633972263.git.naveennaidu479@gmail.com/T/#m37295a0dcfe0d7e0f67efce3633efd7b891949c4
> 
> IIUC, the typeof(*val) helps in setting the value according to the size
> of the argument.
> 
> Please let me know if my understanding is wrong.

Hello! I mean "size" function argument which is passed as variable.

Function itself is declared as:

static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where, int size, u32 *val);

And in "size" argument is stored number of bytes, kind of read operation
(read byte, read word, read dword). In *val is then stored read value.
For byte operation, just low 8 bits in *val variable are set.

Because *val is u32 it means that typeof(*val) is always 4 independently
of the "size" argument.

For example other project U-Boot has also pci-aardvark.c driver and
U-Boot has for (probably same) purpose pci_get_ff() macro, see:
https://source.denx.de/u-boot/u-boot/-/blob/v2021.10/drivers/pci/pci-aardvark.c#L367

I'm not saying if current approach to always sets 0xffffffff
(independently of "size" argument) is correct or not as I do not know
it too! I'm just giving example that this PCI code has very similar
implementation of other project (U-Boot) which sets number of ones based
on the size argument.

So probably something for other people to decide.

Anyway, I very like this your idea to have a macro which purpose is to
explicitly indicate error during config read operation! And to unify all
drivers to use same style for signalling config read error.

> > >  		return PCIBIOS_DEVICE_NOT_FOUND;
> > >  	}
> > >  
> > > @@ -920,7 +920,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > >  			*val = CFG_RD_CRS_VAL;
> > >  			return PCIBIOS_SUCCESSFUL;
> > >  		}
> > > -		*val = 0xffffffff;
> > > +		SET_PCI_ERROR_RESPONSE(val);
> > >  		return PCIBIOS_SET_FAILED;
> > >  	}
> > >  
> > > @@ -955,14 +955,14 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > >  			*val = CFG_RD_CRS_VAL;
> > >  			return PCIBIOS_SUCCESSFUL;
> > >  		}
> > > -		*val = 0xffffffff;
> > > +		SET_PCI_ERROR_RESPONSE(val);
> > >  		return PCIBIOS_SET_FAILED;
> > >  	}
> > >  
> > >  	/* Check PIO status and get the read result */
> > >  	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
> > >  	if (ret < 0) {
> > > -		*val = 0xffffffff;
> > > +		SET_PCI_ERROR_RESPONSE(val);
> > >  		return PCIBIOS_SET_FAILED;
> > >  	}
> > >  
> > > -- 
> > > 2.25.1
> > > 
