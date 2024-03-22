Return-Path: <linux-pci+bounces-5003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E79886FB2
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37241C20A18
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5164C601;
	Fri, 22 Mar 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAW4GuC/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217B45BE4
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120681; cv=none; b=aq3NaJ++LIW8ZDuLiEIkk3rDpiUQkhilwkpEpLyPdRc9F5DZIkw3wzHkQqpuyfRsMfWzRfr0xOzeWQ+DomWYGg7VRXB3+LeMxyqdT+iOlnD6otkSroKGqmdte4N66sEplbAO+6H1i9wW936UedRYcGzF3GuxM1qI8fDIetDcA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120681; c=relaxed/simple;
	bh=oBtIPmRrgDEv2PezVK5CopIbE+YdxGViG9eUJe5cejQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOelp2MkoE9nUUpoQJG6Oiw2cTuc0fqzGSGWb2ZYb50vQunJaTXFJBJOsccwPrIKLKdd5bvlGyPM+Rw5kCiSHGHOOpvTcs/c6fpxLQWq5DEQaTJgTBAqonqVCPtLxW/2YazISlX28f4vBq28qlfk6qBX9QC/JG0eeaPoXzak3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAW4GuC/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dde26f7e1dso16072555ad.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711120679; x=1711725479; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EhWlIRKzWt70tt8gB6f9zBQZ8tLBQy3RuFwhdRAOKrc=;
        b=YAW4GuC/c4zGHv/G6n0tufChyophloIZD/B9t+lbNM8+rSf+BwyQCYOnQqKZBXDMYl
         gCuW7t5rsGENP7wdc5O9RYCewFiwmU54UJ9+Wdx3nGQ1HvJtycCPLF7Zis5JUZyaW5eP
         7lQF4CdPndaUkEjav1Jrc9CNXRSzz0kv8xfA23sqsMIibIwsKxsDWbJDLsvkGcpmEtwf
         PpWovojhAcSJQLhqaSjiKp61UbyanBenzOIueHFOT3NfJkfCCXG4vqZ+yGw80YcWtuGZ
         A5JurPi40wl3J3G8+OhsVHYbTI90nAPl1Je3AtB49l2d+4vR7FuNhUx+vY+CBvFIvswI
         ms3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120679; x=1711725479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhWlIRKzWt70tt8gB6f9zBQZ8tLBQy3RuFwhdRAOKrc=;
        b=ud74KRD+XsoIzP90tCwZW6YoyhbbSOyrF9U+lPtsFd2neYZTC8RZGd/iXns8x4IPc9
         6yrVqLaSGIlAu94fdTjab78TtIaQySG8lmn2XJCJVNmOlNdi1k+e4P7GG4kSF23x8LDv
         U1lP5WHmJApex/IggK9GuHK3VZ3ooKNmesnehbqVNTG7qUpk9ikjx88HiuxZnQC92awV
         KRQhBsj5CXHzy2mhEr1/MjM0adVx/NrIowm0PjBslZ03ExMdOwN14dY+Slv96Kz7R6C6
         0GMU5BDI11m97BBYdhqTqCd6lsExhYLHoIA9A5/Xo48+juGixmLXdZVNZw8f/y/PZJ1b
         ybAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTD7ZwxNy7s6X7AyfruF+qURsJKszCtBSTImAwR+ZhYNPDYSqe7eQNz63ynolYIHg0POR2UUQqeTlRPwE2qzoclyD/Ad8LNjPJ
X-Gm-Message-State: AOJu0YwyYWADZibK9Lh2B54D9iJDCUrkyUhxFGLXmeZIjgZ6KoKAL5BH
	jHw+2xidwvragQVJ+ROkXbm2mQQ7W4HZKi3Y7bvK2IxttfOFRMIAtYaVFGJwhlfDYFZ1XPT3PQ8
	=
X-Google-Smtp-Source: AGHT+IF9cpaMzwNXppDpeoYK6C0MgyTWSRE/b2qANEgRW1zFu2eBEJhphDGBaOw4ueIxCjTq5+DqlA==
X-Received: by 2002:a05:6a20:da82:b0:1a3:a7db:711c with SMTP id iy2-20020a056a20da8200b001a3a7db711cmr1700237pzb.9.1711118731106;
        Fri, 22 Mar 2024 07:45:31 -0700 (PDT)
Received: from thinkpad ([103.28.246.103])
        by smtp.gmail.com with ESMTPSA id k26-20020aa790da000000b006e6b634980esm1724372pfk.49.2024.03.22.07.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:45:30 -0700 (PDT)
Date: Fri, 22 Mar 2024 20:15:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <20240322144527.GA3774@thinkpad>
References: <20240320090106.310955-1-cassel@kernel.org>
 <20240322102025.GA3638@thinkpad>
 <Zf1ddoNBPCb-0bJI@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf1ddoNBPCb-0bJI@ryzen>

On Fri, Mar 22, 2024 at 11:29:10AM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Fri, Mar 22, 2024 at 03:50:58PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 20, 2024 at 10:01:05AM +0100, Niklas Cassel wrote:
> > > The current code uses writel()/readl(), which has an implicit memory
> > > barrier for every single readl()/writel().
> > > 
> > > Additionally, reading 4 bytes at a time over the PCI bus is not really
> > > optimal, considering that this code is running in an ioctl handler.
> > > 
> > > Use memcpy_toio()/memcpy_fromio() for BAR tests.
> > > 
> > > Before patch with a 4MB BAR:
> > > $ time /usr/bin/pcitest -b 1
> > > BAR1:           OKAY
> > > real    0m 1.56s
> > > 
> > > After patch with a 4MB BAR:
> > > $ time /usr/bin/pcitest -b 1
> > > BAR1:           OKAY
> > > real    0m 0.54s
> > > 
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > > Changes since v2:
> > > -Actually free the allocated memory... (thank you Kuppuswamy)
> > > 
> > >  drivers/misc/pci_endpoint_test.c | 68 ++++++++++++++++++++++++++------
> > >  1 file changed, 55 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > index 705029ad8eb5..1d361589fb61 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -272,33 +272,75 @@ static const u32 bar_test_pattern[] = {
> > >  	0xA5A5A5A5,
> > >  };
> > >  
> > > +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > > +					enum pci_barno barno, int offset,
> > > +					void *write_buf, void *read_buf,
> > > +					int size)
> > > +{
> > > +	memset(write_buf, bar_test_pattern[barno], size);
> > > +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> > > +
> > > +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
> > > +
> > > +	return memcmp(write_buf, read_buf, size);
> > > +}
> > > +
> > >  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> > >  				  enum pci_barno barno)
> > >  {
> > > -	int j;
> > > -	u32 val;
> > > -	int size;
> > > +	int j, bar_size, buf_size, iters, remain;
> > > +	void *write_buf;
> > > +	void *read_buf;
> > >  	struct pci_dev *pdev = test->pdev;
> > > +	bool ret;
> > >  
> > >  	if (!test->bar[barno])
> > >  		return false;
> > >  
> > > -	size = pci_resource_len(pdev, barno);
> > > +	bar_size = pci_resource_len(pdev, barno);
> > >  
> > >  	if (barno == test->test_reg_bar)
> > > -		size = 0x4;
> > > +		bar_size = 0x4;
> > >  
> > > -	for (j = 0; j < size; j += 4)
> > > -		pci_endpoint_test_bar_writel(test, barno, j,
> > > -					     bar_test_pattern[barno]);
> > > +	buf_size = min(SZ_1M, bar_size);
> > >  
> > > -	for (j = 0; j < size; j += 4) {
> > > -		val = pci_endpoint_test_bar_readl(test, barno, j);
> > > -		if (val != bar_test_pattern[barno])
> > > -			return false;
> > > +	write_buf = kmalloc(buf_size, GFP_KERNEL);
> > > +	if (!write_buf)
> > > +		return false;
> > > +
> > > +	read_buf = kmalloc(buf_size, GFP_KERNEL);
> > > +	if (!read_buf) {
> > > +		ret = false;
> > > +		goto err;
> > 
> > This frees read_buf also. Please fix that and also rename the labels to:
> > 
> > err_free_write_buf
> > err_free_read_buf
> 
> This was intentional since kfree() handles NULL perfectly fine.
> (I was thinking that it would just add extra lines for no good reason.)
> 
> Do you think that there is any point in having two labels in this case?
> 

I know that NULL is ignored, but that's not an excuse to call kfree() for
non-existent memory (for code sanity). Please create separate labels.

- Mani

> 
> Kind regards,
> Niklas
> 
> > 
> > - Mani
> > 
> > >  	}
> > >  
> > > -	return true;
> > > +	iters = bar_size / buf_size;
> > > +	for (j = 0; j < iters; j++) {
> > > +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> > > +						 write_buf, read_buf,
> > > +						 buf_size)) {
> > > +			ret = false;
> > > +			goto err;
> > > +		}
> > > +	}
> > > +
> > > +	remain = bar_size % buf_size;
> > > +	if (remain) {
> > > +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
> > > +						 write_buf, read_buf,
> > > +						 remain)) {
> > > +			ret = false;
> > > +			goto err;
> > > +		}
> > > +	}
> > > +
> > > +	ret = true;
> > > +
> > > +err:
> > > +	kfree(write_buf);
> > > +	kfree(read_buf);
> > > +
> > > +	return ret;
> > >  }
> > >  
> > >  static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
> > > -- 
> > > 2.44.0
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

