Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAD04296DD
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJKSa2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhJKSaY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:30:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FCDC061570;
        Mon, 11 Oct 2021 11:28:24 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f21so3126896plb.3;
        Mon, 11 Oct 2021 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CKQ88c9j3ESKQlxCKVCJzIzhEW8MF9O1pZyFGKOEDrA=;
        b=oTJLSzyQmCsA6lgeeHn3VxbHP/ZOM0tZi+M/YKcnDvCFUl77KdxyP1DHUHGfghJnEl
         CXzyW7Oh+NADAL/pD0I5kOjOFjcUMNfnINCOLUbM6NF42GHYCMRmzdyxNOR/fe8EXgh+
         VUP3TfYmm/0k51dSuPgYLbN7BSgB+W2gaYslaEmh1LPGFF3PXoONvcwfSFYvr8uaiLVn
         U06MgH5wqjmgyKYO7svrg3Syld5W5Z1C9cTJbCuVC90S9NFSJvQnUL00t2nZIz42J0JP
         pN2IDRWx406mFVDwF4qdz7R7m50JVQE9XFVXtdf7ofMDZPDTyugGr0fJa4pYWELMwwtJ
         VcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CKQ88c9j3ESKQlxCKVCJzIzhEW8MF9O1pZyFGKOEDrA=;
        b=Soxlqnu20rpKhm7c+tYKePncG7GWJLBQdOsb8IlNr+GkZP5qj4wCEnvZPwO+h4MQrB
         4/QivfYxpBPXZ3SnStLHg6Qa9zr08TtcK+Ss+FHZL9XbICeCqgi79lsAOFm43eHcAC9r
         /o/uWi/OULcJuCySPbHLH/EErEknKcN5qhbiKBOUHQAr/rt8iFtaVfzndDAqGQPF5W01
         dgUfgqS5uHIbTAJUOwprXxv9s8hPXGQ0vzBukMQC+qmTFqIghgWmpD4YSI0rRa1f1l6R
         AxeZl6auE5kT+aIRtu1xMLvbUqHeIFGUL8SR20rrNqte6UYJ+yVH81vH/+w4wWlswRXp
         lAuQ==
X-Gm-Message-State: AOAM533OOAHVGX9Q0UlVOAkRyZ3wmK/1H114XKbHZmpLXs6ulIRGEAT3
        t8HPbVkfOvKhh9OBZnue9ZKGVASnCDRiRg5R
X-Google-Smtp-Source: ABdhPJxia+sjT3Qg+xTt/VNqtfY33guuOiShsseFdWJ387zSt1snrx1KhCUiVCrhs20k1oIksdC5Iw==
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr634723pjk.13.1633976903685;
        Mon, 11 Oct 2021 11:28:23 -0700 (PDT)
Received: from theprophet ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id y17sm5130041pfn.96.2021.10.11.11.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:28:23 -0700 (PDT)
Date:   Mon, 11 Oct 2021 23:58:13 +0530
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
Message-ID: <20211011182813.duescywvlkkvddjp@theprophet>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <f423dc9cc90e345680d289d5df7ff469e9b89c60.1633972263.git.naveennaidu479@gmail.com>
 <20211011180850.hgp4ctykvus37fx7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011180850.hgp4ctykvus37fx7@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/10, Pali Rohár wrote:
> On Monday 11 October 2021 23:26:33 Naveen Naidu wrote:
> > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > causes a PCI error.  There's no real data to return to satisfy the
> > CPU read, so most hardware fabricates ~0 data.
> > 
> > Use SET_PCI_ERROR_RESPONSE() to set the error response, when a faulty
> > read occurs.
> > 
> > This helps unify PCI error response checking and make error check
> > consistent and easier to find.
> > 
> > Compile tested only.
> > 
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 596ebcfcc82d..dc2f820ef55f 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -894,7 +894,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> >  	int ret;
> >  
> >  	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
> > -		*val = 0xffffffff;
> > +		SET_PCI_ERROR_RESPONSE(val);
> 
> Hello! Now I'm looking at this macro, and should not it depends on
> "size" argument? If doing 8-bit or 16-bit read operation then should not
> it rather sets only low 8 bits or low 16 bits to ones?
>

Hello o/, Thank you for the review.

Yes! you are right that it should indeed depend on the "size" argument.
And that is what the SET_PCI_ERROR_RESPONSE macro does. The macro is
defined as:

  #define PCI_ERROR_RESPONSE           (~0ULL)
  #define SET_PCI_ERROR_RESPONSE(val)  (*val = ((typeof(*val))PCI_ERROR_RESPONSE))

The macro was part of "Patch 1/22" and is present here [1]. Apologies if
I added the receipient incorrectly.

[1]:
https://lore.kernel.org/linux-pci/d8e423386aad3d78bca575a7521b138508638e3b.1633972263.git.naveennaidu479@gmail.com/T/#m37295a0dcfe0d7e0f67efce3633efd7b891949c4

IIUC, the typeof(*val) helps in setting the value according to the size
of the argument.

Please let me know if my understanding is wrong.

> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> >  	}
> >  
> > @@ -920,7 +920,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> >  			*val = CFG_RD_CRS_VAL;
> >  			return PCIBIOS_SUCCESSFUL;
> >  		}
> > -		*val = 0xffffffff;
> > +		SET_PCI_ERROR_RESPONSE(val);
> >  		return PCIBIOS_SET_FAILED;
> >  	}
> >  
> > @@ -955,14 +955,14 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
> >  			*val = CFG_RD_CRS_VAL;
> >  			return PCIBIOS_SUCCESSFUL;
> >  		}
> > -		*val = 0xffffffff;
> > +		SET_PCI_ERROR_RESPONSE(val);
> >  		return PCIBIOS_SET_FAILED;
> >  	}
> >  
> >  	/* Check PIO status and get the read result */
> >  	ret = advk_pcie_check_pio_status(pcie, allow_crs, val);
> >  	if (ret < 0) {
> > -		*val = 0xffffffff;
> > +		SET_PCI_ERROR_RESPONSE(val);
> >  		return PCIBIOS_SET_FAILED;
> >  	}
> >  
> > -- 
> > 2.25.1
> > 
