Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA01434ED1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTPSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 11:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTPSR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 11:18:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C9C06161C;
        Wed, 20 Oct 2021 08:16:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a15-20020a17090a688f00b001a132a1679bso764919pjd.0;
        Wed, 20 Oct 2021 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qujnYD+rLkj+9g54TdtVOcj/8gkq3w+B28YjXt9K1II=;
        b=ba3u1RjC7hi3s88Z6bQBlnlILlK6xxeLTntjfPO9o2PRP3bWxtBrsykTIwA0FLiq4q
         +aPIp4LAtTb6R4FcsK3ZzZZrkjrsBCPl6JQcbwqJFUIxjJ9H195GopRl0NIi8RkSGuKn
         l3Bzk8nLcO/cw8EQSu11WIwKaAGdW4XtBJb4jxacifgL5vaTpKozRnidcGjPVLzQKNPM
         3E/DzwEU2sdxz2PdbLObuWJgWdHkCjcbJcHQ/IzAlswSIlUuOTr0BmqfE4hc3XpVMkbx
         QwhUjpZN5Xk4oqH6i684JYrtsFnriJyjL8Ok4RApstA7nQLQiiP/e6W56fmI5ulz5zxH
         T30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qujnYD+rLkj+9g54TdtVOcj/8gkq3w+B28YjXt9K1II=;
        b=IW6iKUbmoQLZZ01poNTLChtalGUmQxL4Klv2kzYWnK+WPlGoX2V9PRuQDw4bCJ5H9r
         IKT1SNCuUG2kaKBFOtNPjVKfV4RKFEkiQzoHCUzGcQtDlJK/lERhDqx+Rh/42eSNwOrs
         Svr+GjzMWPeRGX+rjnuwgt8qQ2mJ8AHUrSuUxsEeDyNFRELH5JyVMV7wGsWMUuZSlTGJ
         zVCiA0+qIhfSwx8gf8X4NoV8PrN0CUWQ+Q2XQUhfCmlN26hHi82cnJN/qlkNLYBf6gf+
         T1CGpQWYB90lOzdnv6cJEkYbidOI1JA3vJ5IoycgvmsqqdSLszC4X9IfYMJkKTu+NlAc
         jksA==
X-Gm-Message-State: AOAM532LMzPRnUcxsRmN3h3doG8PjuFzM1JR70sjxyShUtzKsA8RyEL2
        i9TVUmyXOrLM50OJNhnqBvA=
X-Google-Smtp-Source: ABdhPJxMAuvyCWcSo+MFcFg8rTFeQqiVAVJiHhQX9Ni7BFVFrJmsTRJ4fAbQ1JXsU1nW5giYZhcIEQ==
X-Received: by 2002:a17:903:246:b0:13f:75bb:cabd with SMTP id j6-20020a170903024600b0013f75bbcabdmr27628plh.30.1634742962312;
        Wed, 20 Oct 2021 08:16:02 -0700 (PDT)
Received: from theprophet ([2406:7400:63:46e9:439a:b490:ed63:26a1])
        by smtp.gmail.com with ESMTPSA id lb9sm320108pjb.25.2021.10.20.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 08:16:01 -0700 (PDT)
Date:   Wed, 20 Oct 2021 20:45:53 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/24] PCI: Unify PCI error response checking
Message-ID: <20211020151553.4pu7ib6uo6pk6sr4@theprophet>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <da939a6cdb2dea96d16392ae152e1232212877d1.1634306198.git.naveennaidu479@gmail.com>
 <YXAV4bGehjAKK8XO@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXAV4bGehjAKK8XO@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/10, Rob Herring wrote:
> On Fri, Oct 15, 2021 at 08:08:44PM +0530, Naveen Naidu wrote:
> > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > causes a PCI error.  There's no real data to return to satisfy the
> > CPU read, so most hardware fabricates ~0 data.
> > 
> > Use SET_PCI_ERROR_RESPONSE() to set the error response and
> > RESPONSE_IS_PCI_ERROR() to check the error response during hardware
> > read.
> > 
> > These definitions make error checks consistent and easier to find.
> > 
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/access.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index b3b2006ed1d2..03712866c818 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -417,10 +417,10 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
> >  		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
> >  		/*
> >  		 * Reset *val to 0 if pci_read_config_word() fails, it may
> > -		 * have been written as 0xFFFF if hardware error happens
> > -		 * during pci_read_config_word().
> > +		 * have been written as 0xFFFF (PCI_ERROR_RESPONSE) if hardware error
> > +		 * happens during pci_read_config_word().
> >  		 */
> > -		if (ret)
> > +		if (RESPONSE_IS_PCI_ERROR(val))
> 
> What if there is no error (in ret) and the register value was actually 
> ~0? We'd be corrupting the value.
> 
> In general, I think we should rely more on the error codes and less on 
> the ~0 value.
> 

Thank you for the review. I'll fix this up when I send v3 for this patch
series.

> >  			*val = 0;
> >  		return ret;
> >  	}
> > @@ -452,10 +452,10 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
> >  		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
> >  		/*
> >  		 * Reset *val to 0 if pci_read_config_dword() fails, it may
> > -		 * have been written as 0xFFFFFFFF if hardware error happens
> > -		 * during pci_read_config_dword().
> > +		 * have been written as 0xFFFFFFFF (PCI_ERROR_RESPONSE) if hardware
> > +		 * error happens during pci_read_config_dword().
> >  		 */
> > -		if (ret)
> > +		if (RESPONSE_IS_PCI_ERROR(val))
> >  			*val = 0;
> >  		return ret;
> >  	}
> > @@ -529,7 +529,7 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
> >  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
> >  {
> >  	if (pci_dev_is_disconnected(dev)) {
> > -		*val = ~0;
> > +		SET_PCI_ERROR_RESPONSE(val);
> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> >  	}
> >  	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
> > @@ -539,7 +539,7 @@ EXPORT_SYMBOL(pci_read_config_byte);
> >  int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
> >  {
> >  	if (pci_dev_is_disconnected(dev)) {
> > -		*val = ~0;
> > +		SET_PCI_ERROR_RESPONSE(val);
> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> >  	}
> >  	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
> > @@ -550,7 +550,7 @@ int pci_read_config_dword(const struct pci_dev *dev, int where,
> >  					u32 *val)
> >  {
> >  	if (pci_dev_is_disconnected(dev)) {
> > -		*val = ~0;
> > +		SET_PCI_ERROR_RESPONSE(val);
> >  		return PCIBIOS_DEVICE_NOT_FOUND;
> >  	}
> >  	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
> > -- 
> > 2.25.1
> > 
> > 
