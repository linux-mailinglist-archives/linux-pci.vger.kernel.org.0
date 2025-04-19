Return-Path: <linux-pci+bounces-26261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E8FA94192
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 06:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C128A62C6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 04:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FF5149DFF;
	Sat, 19 Apr 2025 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDB0+RQp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002774DA04
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745037258; cv=none; b=r4L2WHQ1DAOUiTgwKO1Nn3yDqZkyBGm3hX99x/gdxPNi8qI2oGdgYly1sPdTKCBK14CKMHPxTFAJYRV0I+Jt6zmBUZPFHui22i47twyMs3tBMRxMKn5rnbawWq9t9fJ8G8jc0VZdHNkN3Q4VaZepeg+2jOGWjHkP1DEVLrwrp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745037258; c=relaxed/simple;
	bh=5tPkOfZzduiC15DP5jXeToXHofbdMRVLi2k4bBQyVyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gD3i/KWtYySjZ4M4Xe2iSiBbnoa4RqQGGieTfLCbJQq+afm1y3OvmO4pWMziOXDbe4OdDjEiJLh3rEpI0p9DhiEU4mahc5B9qZ6jvS7nwKI5TeDnIFwG5bBh3e4zabWkusPv1oAq0cXBJXAuei/Iz1vRdQjyIACUN48nSzTs5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDB0+RQp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376dd56f60so1807438b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 21:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745037256; x=1745642056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uXzOal0nfIQ8bFg2XccSM090HwsdWEh3UWZ58CwncMQ=;
        b=fDB0+RQpch8hXOoSok15buMXxn/nm+QDL1v36M15jEdADIffe0/mNFl0QqGmvgSS4E
         ADSGNoJQGn4FpI8flhIBQhiz2gH5WxluKeffjod+VkxTWL6bBCTVTFw/oRC3H/wFDzAI
         674hC89Mx5wqnLlrGrqsv+KMHM3zAaCvzOH+PsDnM+9AAUZEwW2VkkPZqRi2HgxAB10W
         qwO5h7Hl51a8fUu+/LSyw+/PfsZLgrCZcvtVouP4k/wScV2NJU2hrNZti7FS0XaQQigR
         4wsPq8rq+OCzvfjUaO8LPn/EQDP+0CfVSeIlNH2mXGeXpFoci/e6fpJ2VLOCjEA4DXcG
         6a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745037256; x=1745642056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXzOal0nfIQ8bFg2XccSM090HwsdWEh3UWZ58CwncMQ=;
        b=KxgslwVc15jHwSAegXflqFE/VECFc0u/yMMUUeoduuT1nQt5yGeGWT4Ucm6HG1Pft4
         n8cT3t9aUz+L6v1i7wEU75ERa2v/cpp5Ytj91zxdsLfv7k2SKq3EfsPmAkxd43STZLmh
         /d6PtXjD1x2jS8YkzT6A+WOoMXDarsHbCz9IfM3V91j/SrW1sA8oC1dYpNEz2uY5ZsjS
         fu8LzHmVKRE6y/EYni+zw25+y0a1GLxyhvAAoKkzlmB4Pya+dGhoaYm9wSj0i7VKyvAb
         EetTfQBrQfsMMZHxx5CJZYwgD/V2wEfageQDe6kwNtxXpBEG4+IogS7OfRR7idViNweQ
         BjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi/A15uimr994n9GqD1VzYi8dtb56gVkEKCvFVyYp2oZhlrm3qwcSLy729Yn+RJzbOeeZMI5IVRd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bPWu/OY3fVu4Xw24zJ6xYDJlmujorFG/0EFy3QZd3tq61JE/
	sclut58YTYFVupuiVzePg5fD6m9YZRSCPDWeDJSC3H6NqcVEiKb4DKLfPrMVBA==
X-Gm-Gg: ASbGncsI1Wp2Gl8te0okkpq2Tei62Pj+JXq8e1wUSLmmiaA6iT52QD7qq0Msz5FNtHe
	7rRjsAwf4mFndCluPlTbTmbgHgxpPhnFWqTjnUHDkBy98pPbyGAHz0I7du8t0FMXb3nDcQQTGph
	fzjkyh/If0/2dnE8T9IKdasM2zuGnItXxmj9pORbw1LR+5zAcKv5kCmoYd3tEMTPw/131HGfl3O
	n6QMC9scar69l6Cfs6rPRaEBtclM3V2MJPAbZKH5lof2iTAaNautOc44oo8lC7lxvYBE2LUO/0D
	7+qroxOismGAL+uJWI5DDh61WPkrI9ZGam9fdicjEdEHZMpy1GcX
X-Google-Smtp-Source: AGHT+IEP9iQj2KkpKrslEj+551ckgO39xK+3CJrtgDzGeG3sOciJvji42KgL9hedUsr1SldlGwzI4w==
X-Received: by 2002:a05:6a00:4606:b0:739:3f55:b23f with SMTP id d2e1a72fcca58-73dc14d3124mr5780129b3a.14.1745037256037;
        Fri, 18 Apr 2025 21:34:16 -0700 (PDT)
Received: from thinkpad ([220.158.156.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa58333sm2450467b3a.118.2025.04.18.21.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 21:34:15 -0700 (PDT)
Date: Sat, 19 Apr 2025 10:04:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling
 when allocating space
Message-ID: <xzn36fjifrwgmxpymmn6v7truzan5of37oxvvriegitnqeuwwr@cgrckqiittfh>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
 <20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
 <Z_Pw3I2xO7BMSGWW@ryzen>
 <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>
 <Z_TuIP-k1yLbjcys@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_TuIP-k1yLbjcys@ryzen>

On Tue, Apr 08, 2025 at 11:36:32AM +0200, Niklas Cassel wrote:
> On Mon, Apr 07, 2025 at 05:43:00PM +0200, Jerome Brunet wrote:
> > On Mon 07 Apr 2025 at 17:35, Niklas Cassel <cassel@kernel.org> wrote:
> > 
> > > Hello Jerome,
> > >
> > > On Mon, Apr 07, 2025 at 04:39:08PM +0200, Jerome Brunet wrote:
> > >> When trying to allocate space for an endpoint function on a BAR with a
> > >> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
> > >> size. This is expected by pci_epc_set_bar().
> > >> 
> > >> However, if the fixed_size is smaller that the alignment, the size saved
> > >> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
> > >> pci_epc_set_bar().
> > >> 
> > >> To solve this, continue to allocate space that match the iATU alignment
> > >> requirement but save the size that matches what is present in the BAR.
> > >> 
> > >> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
> > >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > >> ---
> > >>  drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
> > >>  1 file changed, 17 insertions(+), 8 deletions(-)
> > >> 
> > >> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > >> index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
> > >> --- a/drivers/pci/endpoint/pci-epf-core.c
> > >> +++ b/drivers/pci/endpoint/pci-epf-core.c
> > >> @@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> > >>  	struct device *dev;
> > >>  	struct pci_epf_bar *epf_bar;
> > >>  	struct pci_epc *epc;
> > >> +	size_t size;
> > >>  
> > >>  	if (!addr)
> > >>  		return;
> > >> @@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> > >>  		epf_bar = epf->sec_epc_bar;
> > >>  	}
> > >>  
> > >> +	size = epf_bar[bar].size;
> > >> +	if (epc_features->align)
> > >> +		size = ALIGN(size, epc_features->align);
> > >
> > > Personally, I think that you should just save the aligned_size / mem_size /
> > > backing_mem_size as a new struct member, as that avoids the risk that someone
> > > later modifies pci_epf_alloc_space() but forgets to update
> > > pci_epf_free_space() accordingly.

+1. It is always a better approach to store the aligned size during allocation
and use it while freeing. It indeed avoids the alloc/free to go unsymmetry in
the future.

> > 
> > I tried but it looked a bit silly to store that when it was only a
> > matter of calling ALIGN() with parameters we already had, and it is
> > supposed to be only used in those two functions.
> 
> Another advantage is that you could kill patch 1/3 in this series, as
> there would be no need to supply epc_features to pci_epf_free_space().
> 

Yes!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

