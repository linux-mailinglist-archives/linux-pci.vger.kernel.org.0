Return-Path: <linux-pci+bounces-4985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDAC886A44
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 11:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5409B2124A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B22338DDD;
	Fri, 22 Mar 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9RK6UfB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB294383B4
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103355; cv=none; b=Ob55xvp60qNXE1X5d5hO1OR7YdSLPBWXd3cltUUTs1x//JTOvoTTSj2MxLjAGFO9A8FacEhgwHqhRQuBfFbt+J9FFLRa1Pz8LU6MFRey+10KR5XpMU42I+gjGbtyIznv7+3Vd0NLBOL04h8hdErcH9odG53sD3m2AMjR2If/urE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103355; c=relaxed/simple;
	bh=p71xayBqlEgukbvsyJHytzKGhoKcKr2khcxhmtYu9co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSiwXXwUI8Syg2DBCBZ9eLZ+Oqft1OWfdyweUfnt3cU+glMFXvsL6jLrFoX2sI94PNKI0rZKOnXmUynpYIRy4FPGG/z+ResIFICaFaMlZFiyWZetoVgIkzqwQ6zSvtg/YaDr9I7LgIdkcxcxxxJNQ6Z6L6ZsgSPFdwuTmsYSYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9RK6UfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2B7C43390;
	Fri, 22 Mar 2024 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711103355;
	bh=p71xayBqlEgukbvsyJHytzKGhoKcKr2khcxhmtYu9co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9RK6UfBwSe95SgTE/YaKPw+K7JCtF8NdS0mTtPFpHEFwBP3WvLms78cqbt8Oyycu
	 8LrtdfUKxkMLtAPwAJ+timlJpw9FvEivwet1NKpe7J3g7RqZqPorGhKK3tAZ0uimEt
	 fduJKzTOpJDBnTSDxWVdPHDza6RigfsaJHft8mXiysyQW5q3KykMldZr2URpq8fjcR
	 IEo7KkJsvpIt2IJ9ZV1RQRN1+FRUfhJdSTTMepHsOxX9WEA+56xSIM6rowr9pfYtrz
	 y6fO8IFdxWeWtrpXzFP/kzIGz1kjYBoF8CLna01x8UHgKOXtd8Yo1o0rI2Ha9JR3bc
	 BdKlcWluTfB7A==
Date: Fri, 22 Mar 2024 11:29:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <Zf1ddoNBPCb-0bJI@ryzen>
References: <20240320090106.310955-1-cassel@kernel.org>
 <20240322102025.GA3638@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322102025.GA3638@thinkpad>

Hello Mani,

On Fri, Mar 22, 2024 at 03:50:58PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 20, 2024 at 10:01:05AM +0100, Niklas Cassel wrote:
> > The current code uses writel()/readl(), which has an implicit memory
> > barrier for every single readl()/writel().
> > 
> > Additionally, reading 4 bytes at a time over the PCI bus is not really
> > optimal, considering that this code is running in an ioctl handler.
> > 
> > Use memcpy_toio()/memcpy_fromio() for BAR tests.
> > 
> > Before patch with a 4MB BAR:
> > $ time /usr/bin/pcitest -b 1
> > BAR1:           OKAY
> > real    0m 1.56s
> > 
> > After patch with a 4MB BAR:
> > $ time /usr/bin/pcitest -b 1
> > BAR1:           OKAY
> > real    0m 0.54s
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since v2:
> > -Actually free the allocated memory... (thank you Kuppuswamy)
> > 
> >  drivers/misc/pci_endpoint_test.c | 68 ++++++++++++++++++++++++++------
> >  1 file changed, 55 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 705029ad8eb5..1d361589fb61 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -272,33 +272,75 @@ static const u32 bar_test_pattern[] = {
> >  	0xA5A5A5A5,
> >  };
> >  
> > +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > +					enum pci_barno barno, int offset,
> > +					void *write_buf, void *read_buf,
> > +					int size)
> > +{
> > +	memset(write_buf, bar_test_pattern[barno], size);
> > +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> > +
> > +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
> > +
> > +	return memcmp(write_buf, read_buf, size);
> > +}
> > +
> >  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >  				  enum pci_barno barno)
> >  {
> > -	int j;
> > -	u32 val;
> > -	int size;
> > +	int j, bar_size, buf_size, iters, remain;
> > +	void *write_buf;
> > +	void *read_buf;
> >  	struct pci_dev *pdev = test->pdev;
> > +	bool ret;
> >  
> >  	if (!test->bar[barno])
> >  		return false;
> >  
> > -	size = pci_resource_len(pdev, barno);
> > +	bar_size = pci_resource_len(pdev, barno);
> >  
> >  	if (barno == test->test_reg_bar)
> > -		size = 0x4;
> > +		bar_size = 0x4;
> >  
> > -	for (j = 0; j < size; j += 4)
> > -		pci_endpoint_test_bar_writel(test, barno, j,
> > -					     bar_test_pattern[barno]);
> > +	buf_size = min(SZ_1M, bar_size);
> >  
> > -	for (j = 0; j < size; j += 4) {
> > -		val = pci_endpoint_test_bar_readl(test, barno, j);
> > -		if (val != bar_test_pattern[barno])
> > -			return false;
> > +	write_buf = kmalloc(buf_size, GFP_KERNEL);
> > +	if (!write_buf)
> > +		return false;
> > +
> > +	read_buf = kmalloc(buf_size, GFP_KERNEL);
> > +	if (!read_buf) {
> > +		ret = false;
> > +		goto err;
> 
> This frees read_buf also. Please fix that and also rename the labels to:
> 
> err_free_write_buf
> err_free_read_buf

This was intentional since kfree() handles NULL perfectly fine.
(I was thinking that it would just add extra lines for no good reason.)

Do you think that there is any point in having two labels in this case?


Kind regards,
Niklas

> 
> - Mani
> 
> >  	}
> >  
> > -	return true;
> > +	iters = bar_size / buf_size;
> > +	for (j = 0; j < iters; j++) {
> > +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> > +						 write_buf, read_buf,
> > +						 buf_size)) {
> > +			ret = false;
> > +			goto err;
> > +		}
> > +	}
> > +
> > +	remain = bar_size % buf_size;
> > +	if (remain) {
> > +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
> > +						 write_buf, read_buf,
> > +						 remain)) {
> > +			ret = false;
> > +			goto err;
> > +		}
> > +	}
> > +
> > +	ret = true;
> > +
> > +err:
> > +	kfree(write_buf);
> > +	kfree(read_buf);
> > +
> > +	return ret;
> >  }
> >  
> >  static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
> > -- 
> > 2.44.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

