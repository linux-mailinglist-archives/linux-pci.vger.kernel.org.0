Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9899542A900
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 17:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhJLQBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbhJLQBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 12:01:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37C8C061570;
        Tue, 12 Oct 2021 08:59:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so2235498pjb.1;
        Tue, 12 Oct 2021 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s85hH8OlLfuG7m34y2PmbBUsXhbTPJy7qKvzLqHFuts=;
        b=ofP+Z3s8eNEGO0B0FIO5AIpuQRG7ug6PZNOQMbIWV4jHXgS1f3BTb0Xmmt3E0cls31
         qNFD2XKWvC4KziFheNgPS8sM2gDcndB0XgHmrRy/JY7gB0rAvtBOWMCD3QBCQcGDCnAT
         JBpBQm9+CBJS0iMHD4/YbsDp7SjrmnmdHc4vpv+s9GkR7/Pf8cWD2A+SOafAfUsiBjyp
         QhwuNauwgjxrods43SCJYjs+x3rrbeica31XQgZsvqhup3mDnMTX9P7jpzWAZ6f5Nklq
         a2eKVT78ozWjtCugjbXefdNEIkHme+9n45bc6f+VOQN/559OOaxq1wF4NoG+J8ATFOiz
         RzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s85hH8OlLfuG7m34y2PmbBUsXhbTPJy7qKvzLqHFuts=;
        b=K8aSBv1j//SeWBVN0s4EW628eQ0IRS1h9ifb0MSys82khaeK94wxdhwG2V5T6gIqQy
         FOEuIu6ylO0rHd/lKRAvV4XkUD3RHQgorr0VcmvqHhtZUqZRQvd62jTw7L8ErC/sp0gG
         gUFCm0nlXi+H5N9tEJk2QcWQWXQ2sk9KiouYtJ5Ho7sgO9W54BxYv1hb+sxfACFRalRd
         TkvguALuS+c45/cRqpVzis43YWS/mC9fQ+eZGak+G7Wh+2CZTuHO0hpgZADpHbBGcrnL
         6DTCmgUQXw8Kj4qXdu/Vnjn6DMMgtYx6tFwmVdD0ZozLqIjZY5ags3hatKlwMv0OvIcz
         rtKQ==
X-Gm-Message-State: AOAM533Q8QWusAbu4V6g3tS0XaoyVXGl5170fzMyxBebH8rOEGT+d4W6
        YyloHqkY5YSKlEun7qXQaqE=
X-Google-Smtp-Source: ABdhPJzJIZzu89Nsz/KDsuCTNqduOueDbscNAqrLgQ6duvBVxEA3fN2vSGJiQKc150Dvkr3qQbubqw==
X-Received: by 2002:a17:902:d202:b0:13a:709b:dfb0 with SMTP id t2-20020a170902d20200b0013a709bdfb0mr30570200ply.34.1634054386055;
        Tue, 12 Oct 2021 08:59:46 -0700 (PDT)
Received: from theprophet ([2406:7400:63:cada:3b09:6c3b:61f5:2cfd])
        by smtp.gmail.com with ESMTPSA id i128sm11576268pfc.47.2021.10.12.08.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 08:59:45 -0700 (PDT)
Date:   Tue, 12 Oct 2021 21:29:28 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
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
Message-ID: <20211012155928.3nuyzgrgvyjm2v3r@theprophet>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <f423dc9cc90e345680d289d5df7ff469e9b89c60.1633972263.git.naveennaidu479@gmail.com>
 <20211011180850.hgp4ctykvus37fx7@pali>
 <20211011182526.kboaxqofdpd2jjrl@theprophet>
 <20211011184144.qcbmif7hvzozdgzw@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011184144.qcbmif7hvzozdgzw@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/10, Pali Rohár wrote:
> On Monday 11 October 2021 23:55:35 Naveen Naidu wrote:
> > On 11/10, Pali Rohár wrote:
> > > On Monday 11 October 2021 23:26:33 Naveen Naidu wrote:
> > > > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > > > causes a PCI error.  There's no real data to return to satisfy the
> > > > CPU read, so most hardware fabricates ~0 data.
> > > > 
> > > > Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
> > > > read occurs.
> > > > 
> > > > This helps unify PCI error response checking and make error check
> > > > consistent and easier to find.
> > > > 
> > > > Compile tested only.
> > > > 
> > > > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/pci-aardvark.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > index 596ebcfcc82d..dc2f820ef55f 100644
> > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > @@ -894,7 +894,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > > >  	int ret;
> > > >  
> > > >  	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
> > > > -		*val = 0xffffffff;
> > > > +		SET_PCI_ERROR_RESPONSE(val);
> > > 
> > > Hello! Now I'm looking at this macro, and should not it depends on
> > > "size" argument? If doing 8-bit or 16-bit read operation then should not
> > > it rather sets only low 8 bits or low 16 bits to ones?
> > >
> > 
> > Hello o/, Thank you for the review.
> > 
> > Yes! you are right that it should indeed depend on the "size" argument.
> > And that is what the SET_PCI_ERROR_RESPONSE macro does. The macro is
> > defined as:
> > 
> >   #define PCI_ERROR_RESPONSE           (~0ULL)
> >   #define SET_PCI_ERROR_RESPONSE(val)  (*val = ((typeof(*val))PCI_ERROR_RESPONSE))
> > 
> > The macro was part of "Patch 1/22" and is present here [1]. Apologies if
> > I added the receipient incorrectly.
> > 
> > [1]:
> > https://lore.kernel.org/linux-pci/d8e423386aad3d78bca575a7521b138508638e3b.1633972263.git.naveennaidu479@gmail.com/T/#m37295a0dcfe0d7e0f67efce3633efd7b891949c4
> > 
> > IIUC, the typeof(*val) helps in setting the value according to the size
> > of the argument.
> > 
> > Please let me know if my understanding is wrong.
> 
> Hello! I mean "size" function argument which is passed as variable.
>

Thank you for explaining! Now I understand what you mean :), Apologies
for not being not understanding this beforehand.

> Function itself is declared as:
> 
> static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where, int size, u32 *val);
> 
> And in "size" argument is stored number of bytes, kind of read operation
> (read byte, read word, read dword). In *val is then stored read value.
> For byte operation, just low 8 bits in *val variable are set.
> 
> Because *val is u32 it means that typeof(*val) is always 4 independently
> of the "size" argument.
> 
> For example other project U-Boot has also pci-aardvark.c driver and
> U-Boot has for (probably same) purpose pci_get_ff() macro, see:
> https://source.denx.de/u-boot/u-boot/-/blob/v2021.10/drivers/pci/pci-aardvark.c#L367
> 
> I'm not saying if current approach to always sets 0xffffffff
> (independently of "size" argument) is correct or not as I do not know
> it too! I'm just giving example that this PCI code has very similar
> implementation of other project (U-Boot) which sets number of ones based
> on the size argument.
>

I am not sure too, if we would like to have something like pci_get_ff()
which sets the return mask based on the size.

If we were to have something like pci_get_ff(), I can think of one
problem, some of the functions such as pci_raw_set_power_state() which
checks for errors does not have a "size" argument. An excerpt from that
function is as follows:
  static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
  {
    pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
        if (pmcsr == (u16) ~0) {

For these functions we wont be able to use pci_get_ff(), I mean we could
definitely put the responsibility onto the programmers to write down the
correct size. But that might lead to mistakes, I guess?

Then for those cases, we might need to maintain both the
SET_PCI_ERROR_RESPONSE macro and the pci_get_ff() functions, which then
means that we might not have the same style for signalling config read
error.

I am pretty new to kernel development, so I am sure that whatever I said
above might be totally wrong. If so, please correct me :)

> So probably something for other people to decide.
> 
> Anyway, I very like this your idea to have a macro which purpose is to
> explicitly indicate error during config read operation! And to unify all
> drivers to use same style for signalling config read error.
> 

Thank you :D, I think I'll wait for other people to chime in here with
their opinions and then I'll redo the patch with whatever will be
decided.

Thank again for the detailed reply.

> > > >  		return PCIBIOS_DEVICE_NOT_FOUND;
> > > >  	}
> > > >  
> > > > @@ -920,7 +920,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > > >  			*val = CFG_RD_CRS_VAL;
> > > >  			return PCIBIOS_SUCCESSFUL;
> > > >  		}
> > > > -		*val = 0xffffffff;
> > > > +		SET_PCI_ERROR_RESPONSE(val);
> > > >  		return PCIBIOS_SET_FAILED;
> > > >  	}
> > > >  
> > > > @@ -955,14 +955,14 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> > > >  			*val = CFG_RD_CRS_VAL;
> > > >  			return PCIBIOS_SUCCESSFUL;
> > > >  		}
> > > > -		*val = 0xffffffff;
> > > > +		SET_PCI_ERROR_RESPONSE(val);
> > > >  		return PCIBIOS_SET_FAILED;
> > > >  	}
> > > >  
> > > >  	/* Check PIO status and get the read result */
> > > >  	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
> > > >  	if (ret < 0) {
> > > > -		*val = 0xffffffff;
> > > > +		SET_PCI_ERROR_RESPONSE(val);
> > > >  		return PCIBIOS_SET_FAILED;
> > > >  	}
> > > >  
> > > > -- 
> > > > 2.25.1
> > > > 
