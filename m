Return-Path: <linux-pci+bounces-4969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7B28855F0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 09:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C39E285068
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D71BDE5;
	Thu, 21 Mar 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DflblPt7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030B1B274
	for <linux-pci@vger.kernel.org>; Thu, 21 Mar 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711010736; cv=none; b=VCIRmufTuQ9c+N1Ui5P3J7ql0QUr2wAsfjgAGhckRRIR8iOGv0wgPk9vQ+6PiJmjpB/7VTx3hSFD4voIbc0r8fKUJTJi4M1aPC+Du7H6AZJ2QPmK7HXVpN8RhH2yOx/euPySxjSgPllzLBsflSa4m6DxaC//yybPu6A6Hl3D5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711010736; c=relaxed/simple;
	bh=OkbI4o4rlNUdHuIRDroe+qoCSdKDMDtLUyHOdkrHHy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR9zrGHJzWXNDGB/Yo3ODoAS5Ih9jGeQ945SDp8pu0obAoe0Bd3mpJmg4Y8m1N3rPyEnyn6CYfsWWB/tMWdyV9SpwlEU9LvhWoQtch4yP/dIMGPgZGAI4InnpJW0iBDE6yMQClWr7HO44pEF7QW1Wn4Z4J9uiaPXi6lZkTAAr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DflblPt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BF3C433F1;
	Thu, 21 Mar 2024 08:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711010735;
	bh=OkbI4o4rlNUdHuIRDroe+qoCSdKDMDtLUyHOdkrHHy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DflblPt7H66xxDlN0N1ikk21ah4U8QaNjOqF36p3/Tuvh0DCuprxcvhKXdRG9/+58
	 BqRKht6TfDCq7Bp5f3S3HneBd356PZFGQBtEXN7/yp17M+sDTkZexwVD3r4FKpqkyM
	 q4GWbOsbyPJKdngovbQ8mM8NuKpeaWLZ+vcevrifyqG+oefcgMRaNj+96MeuHS/Jth
	 kryiuuSW/Xvf2aAKHBQ6PGN48vPfSIuYIydAbs+oBlgKnJn6J9enFZq/x6i9Pb5WIP
	 k5wOfakLKNJCXutFruc+HNVwvtZwFrUHthSNO3KcvXrltHKE4exUHQVm8LWSjO/5m3
	 wmGPxgq75ALFw==
Date: Thu, 21 Mar 2024 09:45:31 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <Zfvzq5eQs90n1IUz@ryzen>
References: <20240320090106.310955-1-cassel@kernel.org>
 <4cb86057-f252-4f48-8b76-6cb0d8de2ec4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cb86057-f252-4f48-8b76-6cb0d8de2ec4@linux.intel.com>

Hello Kuppuswamy,

On Wed, Mar 20, 2024 at 08:53:12AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi,
> 
> On 3/20/24 2:01 AM, Niklas Cassel wrote:
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
> 
> Why 1MB  limit?

Could you please clarify your concern?

A BAR could be several GB, so it does not make sense to always kmalloc()
a buffer that is of the same size of the BAR.
(Therefore we copy in to a smaller buffer, iterating over the whole BAR.)

So we have to chose a max limit that we think is likely to succeed even
when the memory is fragmented, and something that will work on embedded
systems, etc.

The highest BAR size used by pci-epf-test is by default 1MB, so 1MB
seemed like a reasonable max limit. (Since we use min(), if the BAR is
smaller than 1MB, the buffer we allocate will also be smaller than 1MB.

Since we allocate two buffers, we are in the worst case allocating 2x 1MB,
so I don't think that it is reasonable to have a higher max limit.

If you are using a _very_ resource contained system as RC (and EP) to test
the pci-epf-test driver, you have probably reduced the default BAR sizes
defined in pci-epf-test to something smaller already, so 1MB seemed like
a reasonable max limit.


Kind regards,
Niklas

> 
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
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

