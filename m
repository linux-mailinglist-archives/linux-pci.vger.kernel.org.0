Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD7315500
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 18:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhBIRZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 12:25:33 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43676 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhBIRZ0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 12:25:26 -0500
Received: by mail-wr1-f49.google.com with SMTP id z6so22873870wrq.10;
        Tue, 09 Feb 2021 09:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4UpteF9FRAi4Lict6Jo0G0PAyOOY1t7OFU8ICZLlrWU=;
        b=X6w+jZ6IVwm+MyxEorO/YZsBoyZ4chJtCj5bbN97NGzycXs31OcvfNcZuaQeVRWzUU
         0C5TRrRJUVHE6hzS37sekMWBreP+8FoBVsxGg7cP8tQCc3fl/3LIKxsR4n1gxRPts7ik
         3fcaprYWX0XV+pqrffXCOtpGdo/ydyUTenAWq9ycfTqCgc92uxE+HWtp7K6BbezsxR9M
         HSwmdDnsbZgYVH20vAOgM1w0jfj3oD5fuyqm0fd1FKIWojzhF3iJct3pHZZoe7HgdBJ1
         h5MvDd2GaGZiAqbpkSJnpUSwcjk+jKFocWwodf4kw9/BePMRb/Ktxmoaa5eSXnWmnqUg
         lc7w==
X-Gm-Message-State: AOAM5310ZVlokOhn1QSq5aUEEAP08BNsp0F63a5rJgBS1FnsKig6oWvd
        4Ji+ACu1wjMqLYnu7UZyEJpBNBF2zMC4S4W1
X-Google-Smtp-Source: ABdhPJyGMQ1urNhCBippyPBIN4KwVwyW0K5zNfW3lbzz0rTCXrZwc5BTrcwutx5qGpYpxipp581BDg==
X-Received: by 2002:adf:a501:: with SMTP id i1mr13852390wrb.149.1612891473332;
        Tue, 09 Feb 2021 09:24:33 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id l10sm38463537wro.4.2021.02.09.09.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:24:32 -0800 (PST)
Date:   Tue, 9 Feb 2021 18:24:30 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RESEND v4 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YCLFTjZQ2bCfGC+J@rocinante>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
 <bba090c3d9d3d90fb2dfe5f2aaa52c155d87958f.1612390291.git.gustavo.pimentel@synopsys.com>
 <YB9EDzI7mSrzXUUB@rocinante>
 <DM5PR12MB18354765D69889F2CD6E4D89DA8F9@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YCHBAmFAOv/Joqp5@rocinante>
 <DM5PR12MB18350F331485A6FF36ED28DADA8E9@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR12MB18350F331485A6FF36ED28DADA8E9@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gustavo,

[...]
> > The code in question would be (exceprt from the patch):
> > 
> > [...]
> > +static int dw_xdata_pcie_probe(struct pci_dev *pdev,
> > +			       const struct pci_device_id *pid)
> > +{
> > +	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
> > +	struct dw_xdata *dw;
> > [...]
> > +	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
> > +	if (!dw->rg_region.vaddr)
> > +		return -ENOMEM;
> > [...]
> > 
> > Perhaps something like the following would would?
> > 
> > void __iomem * const *iomap_table;
> > 
> > iomap_table = pcim_iomap_table(pdev);
> > if (!iomap_table)
> >         return -ENOMEM;
> > 
> > dw->rg_region.vaddr = iomap_table[pdata->rg_bar];
> > if (!dw->rg_region.vaddr)
> > 	return -ENOMEM;
> > 
> > With sensible error messages added, of course.  What do you think?
> 
> I think all the improvements are welcome. I will do that.
> My only doubt is if Bjorn recommends removing the 
> iomap_table[pdata->rg_bar] check, after adding the verification on the 
> pcim_iomap_table, because all other drivers doesn't do that.

Good point.  I only found two drivers that do this extra check:

  https://elixir.bootlin.com/linux/v5.11-rc7/source/drivers/crypto/ccp/sp-pci.c#L203
  https://elixir.bootlin.com/linux/v5.11-rc7/source/drivers/net/ethernet/amd/xgbe/xgbe-pci.c#L252

Bjorn, do you think that there is some likelihood that the table might
be missing a mapped address for a given BAR?

I don't think that is the case, but should it be the case, then perhaps
adding a small wrapper that would take a BAR and do all the verification
internally might be a good idea.

Krzysztof
