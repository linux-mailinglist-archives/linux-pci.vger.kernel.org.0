Return-Path: <linux-pci+bounces-20029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A081AA14932
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 06:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD52188D795
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 05:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083311F7574;
	Fri, 17 Jan 2025 05:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSsaLtcp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214ED8C11
	for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737091559; cv=none; b=OIMKim9HJoNiTSZ+E2EoAuEanrvHRqsdn1TdyfoRgghnVFXmOi6h0vmgiIyWmgO/P6waDX9BrldY8rWJh3BDC320CAI5BdYME4Yb3l0dvs1n21Ux17dzvV+aH6lTnJCjrgLomjSS84ZDTqmayQo3ItaMJZPmLGg4kReY+zsQdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737091559; c=relaxed/simple;
	bh=DGgHReRoxV/+DmamGVoxWAyOfGnMynXqub0Abuj3F4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4v/BncUfUZEHZ9FukKgkKU80+yqtHF+udc50gPGfOS5StOQyBxVLvLreap2cViyTtnZzdfaSp7hZ23BTMHnzyO9+62nH2AKgVT+O4lJFua+DNVboBJ10a+HeQMjkfbzuF7aeCw4/2PinmLGp3amoB5MEnmCgXm/I/feo87f4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PSsaLtcp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso10453015e9.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 21:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737091555; x=1737696355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pgp2+IMXxJqntfEcanaBoZCtUVslmuF+HfybjYKMqH8=;
        b=PSsaLtcp9/7l1mCRevhmjLIT9wr1OZLjIRDhZ6mW91Q6pws+vA+aVMbeWETapsxuqt
         dBP9jVmHIiTfuBV57jkzeuFMPscfvWot5BqCfcNhxE9t8M6ppJAIaVIJtjzS0sEt5UDF
         HFe6Ib1xs9C/MxLibePOh47f3Uu6v6sKjxX/M2v9KK1LLv85qO5ZU4DQ/gVaJjMjEQ9G
         ddeZYgX3VZnX56GPgJUlB56QaTx/LAVthGxDBlsU2AoIIuBHphTryxzPVS9ey7N4R2HE
         1eiOaNXqovDZ2aMPAWFSRcEzQCZaNkkzOoEfPDhxQc5NC0hx88wLMapP+RNJDkh8/+XZ
         AT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737091555; x=1737696355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pgp2+IMXxJqntfEcanaBoZCtUVslmuF+HfybjYKMqH8=;
        b=FK3w0Gj80++i3llClyu7THWPboV9CyDRsXKg5yzndaeCKGaPKBn+GcsNJssaeeY9ZJ
         xAbHE/CGPzLuczm52qnK9fGdEEFfYmBIcaVwzfuaNzPkKcVxmtlpHz0u27LvUMk+tWkO
         mR/oevcn2ke9XE8c7Hoz9RYZ36G8YhjF0ArXRHLsHUDVilOo71+HQNq7Ma6l6n6Z0RO6
         NULkrNIUnHFQ0xG8lP5KmYzfEoh90fe6gNzYJB/1fd19Z114j8aujQBjcVWL/31/rI0Z
         uz4vE52ZtyQO6HjdI95THf5y86CrmjMyzTzEMZB/gbVTsvCQuzi/AdB9WW3N4fQ7M154
         QxcA==
X-Forwarded-Encrypted: i=1; AJvYcCXfafavBivndNwq1RQgWlWwjnGab3di1rXNLppNsGBV1PA8mm1pK0JsfmTicsY8MbeVF4XnyfV3LWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZ9eq1FQz7oxHYD12onded2ekfcH/rvfS3Xka5Vuyzlaa5Vgd
	Ek5ddIk8vFwFB+8uuOgiovx3MjctHgLc2YTbsGcyJ0Y5C1n3xijj5AkW/PZnGWA=
X-Gm-Gg: ASbGncs3fP6wxXRy7pPnyNMturnUx8TW6UatNYhA0/5WAjCKzb8hPdxcMBB4pm73EUT
	Gt2wcxmnqiV4LV+eRhotJ1huIlPu6YSU+/HhtxLdWMr5TPhHu2TwheOu9meL98iFYNRB5G9zcU+
	AEM4LOys02Hc30Iht+F4ZirXRprVgVmILAO/lesifRB9ufIvw8xJfCzv6chxKKk7YIjSlPTZPNp
	rb/qSzH/IljAuw4VCEPDCk0EZBHz8aij8YpHCl3YpL0O6PJMZLP+u6JIQp3+Q==
X-Google-Smtp-Source: AGHT+IHv7DJAAYThC9GNwDlLUZxVW1EfKgbU1RsWLT2vIWkxB/JLRBW88SN+q/9DKAm8e5HkbQzR7g==
X-Received: by 2002:a05:600c:3b29:b0:434:fe4b:be18 with SMTP id 5b1f17b1804b1-438913ef951mr9742005e9.18.1737091555500;
        Thu, 16 Jan 2025 21:25:55 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322a838sm1501717f8f.48.2025.01.16.21.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 21:25:54 -0800 (PST)
Date: Fri, 17 Jan 2025 08:25:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: Fix ternary operator that never returns 0
Message-ID: <b0d6ea82-c979-447a-9e63-0dbdbf23d411@stanley.mountain>
References: <20250116172019.88116-1-colin.i.king@gmail.com>
 <20250116224944.283e14fb@pumpkin>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116224944.283e14fb@pumpkin>

On Thu, Jan 16, 2025 at 10:49:44PM +0000, David Laight wrote:
> On Thu, 16 Jan 2025 17:20:19 +0000
> Colin Ian King <colin.i.king@gmail.com> wrote:
> 
> > The left hand size of the ? operator is always true because of the addition
> > of PCIE_STD_NUM_TLP_HEADERLOG and so dev->eetlp_prefix_max is always being
> > returned and the 0 is never returned (dead code). Fix this by adding the
> > required parentheses around the ternary operator.
> > 
> > Fixes: 00048c2d5f11 ("PCI: Add TLP Prefix reading to pcie_read_tlp_log()")
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  drivers/pci/pcie/tlp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> > index 9b9e348fb1a0..0860b5da837f 100644
> > --- a/drivers/pci/pcie/tlp.c
> > +++ b/drivers/pci/pcie/tlp.c
> > @@ -22,8 +22,8 @@
> >  unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc)
> >  {
> >  	return PCIE_STD_NUM_TLP_HEADERLOG +
> > -	       (aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
> > -	       dev->eetlp_prefix_max : 0;
> > +	       ((aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
> 
> You can remove the extra set around the condition itself as well.
> They are a good hint the writer doesn't know their operator
> precedences :-)

Please leave them as-is...  I obsolutely do not remember the operator
precedences between & and ? and I have to look it up every time I see
it.

regards,
dan carpenter


