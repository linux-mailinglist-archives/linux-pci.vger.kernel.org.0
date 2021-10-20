Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF153434EC3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhJTPPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 11:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTPPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 11:15:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062EEC06161C;
        Wed, 20 Oct 2021 08:13:22 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c4so15756269pgv.11;
        Wed, 20 Oct 2021 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nMEsOmoLIE03X0FEz1y57WbkFMuY6Pnj05lXdP5SXsk=;
        b=kOp9YmMFWMdxdBRR28gPoWRp1qUf1yXPEpvnyRze9W5hQeVyLVudcV4nW47Ob3EeWY
         3CPMRo3WlOgu3WtGibMuSt6NxpctXgWAoo6HDKg/ifmKRC19+HZyvyeZw7RlBJzLHylX
         PWPxc+ckCH9veExv1O/A2AMC7s4c2Kr255TsRNfvHRx6VfwJthUlBIG5jHla6eGyTNj9
         e3VyJVZvr1mEuvlfGcyIwwmuSuvc/hNgbYSZy7icesmFsCHu9U43CmQET35wlAcEryx7
         MxGFXsyz/q2dZt7g2Sk4o7LH+OJ0/fR0ylcnwNA6QlWcGBi8uhAsc4kVfnoa4vx+eyu6
         P7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nMEsOmoLIE03X0FEz1y57WbkFMuY6Pnj05lXdP5SXsk=;
        b=7RM2XVcYle288FpW4Q5xHhjo0jSuc6nNcXIaBgoX+qY4r2pGb/NnscqJ/BkvLnvSf9
         15cFPrW/n5BruuMyMeBtMFh1ndd+/urD7MDBqA2wV7JciGVTSF4xOrEUytIOHsY8T2t0
         eqUgQyn5Wq5cqck9j6qMneA+MfJX5rcgXKkVPoM2y6TTG/Ox43ei3hYZ+vtOEIqMTgbT
         2YtQ0OfwNnqboy4KnP66fyvQQnfpIgD6MxVJE5n4zHUscRBqku6pHRcp1CNBJxKaG3Hg
         pF9Rcezfbhv+gdvkXv7k4xUumAlTXWZCJKPb5f9hvBDVqzLrCxlBjsRBSmRl5y4zQmqZ
         JeEA==
X-Gm-Message-State: AOAM532Y/U5nc0b0xQyHBUbBCLSzbnXgm2qqnrJhXOUH/mowSBIcb951
        Y0ENTub5P/P0VQiZyblZZVm7MWamEWaHvg==
X-Google-Smtp-Source: ABdhPJyT1Dpx5ytuFQBG1GcteoPGwMW77UosJ0q6tZ2985YqbQZ9ShKJIAfaSsUJpJcOXOnf9ai8Hg==
X-Received: by 2002:a63:f817:: with SMTP id n23mr40868pgh.250.1634742801348;
        Wed, 20 Oct 2021 08:13:21 -0700 (PDT)
Received: from theprophet ([2406:7400:63:46e9:439a:b490:ed63:26a1])
        by smtp.gmail.com with ESMTPSA id n9sm5097115pjk.3.2021.10.20.08.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 08:13:20 -0700 (PDT)
Date:   Wed, 20 Oct 2021 20:43:09 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/24] PCI: Set error response in config access
 defines when ops->read() fails
Message-ID: <20211020151309.gklnsksd7ce6b3q6@theprophet>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <b913b4966938b7cad8c049dc34093e6c4b2fae68.1634306198.git.naveennaidu479@gmail.com>
 <20211020135208.zgm2gvhqd7ukb57m@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211020135208.zgm2gvhqd7ukb57m@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/10, Pali Rohár wrote:
> On Friday 15 October 2021 19:58:17 Naveen Naidu wrote:
> > Make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value with error
> > response (~0), when the PCI device read by a host controller fails.
> > 
> > This ensures that the controller drivers no longer need to fabricate
> > (~0) value when they detect error. It also  gurantees that the error
> > response (~0) is always set when the controller drivers fails to read a
> > config register from a device.
> > 
> > This makes error response fabrication consistent and helps in removal of
> > a lot of repeated code.
> > 
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  drivers/pci/access.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> > index 46935695cfb9..b3b2006ed1d2 100644
> > --- a/drivers/pci/access.c
> > +++ b/drivers/pci/access.c
> > @@ -42,7 +42,10 @@ int noinline pci_bus_read_config_##size \
> >  	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
> >  	pci_lock_config(flags);						\
> >  	res = bus->ops->read(bus, devfn, pos, len, &data);		\
> > -	*value = (type)data;						\
> > +	if (res)									\
> > +		SET_PCI_ERROR_RESPONSE(value);			\
> > +	else										\
> > +		*value = (type)data;						\
> 
> Hello! Just one small comment. It looks like that in this patch is
> broken alignment of backslashes on the end of lines. Prior this patch
> backslashes on all lines were at the same column. With this patch they
> are not.
>

Thank you for spotting this. I apologise for this. I did not configure
my editor properlly so I couldn't recognize this error. But I'll fix
this when I send the v3

> >  	pci_unlock_config(flags);					\
> >  	return res;							\
> >  }
> > @@ -228,7 +231,10 @@ int pci_user_read_config_##size						\
> >  	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
> >  					pos, sizeof(type), &data);	\
> >  	raw_spin_unlock_irq(&pci_lock);				\
> > -	*val = (type)data;						\
> > +	if (ret)								\
> > +		SET_PCI_ERROR_RESPONSE(val);			\
> > +	else									\
> > +		*val = (type)data;						\
> >  	return pcibios_err_to_errno(ret);				\
> >  }									\
> >  EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
> > -- 
> > 2.25.1
> > 
