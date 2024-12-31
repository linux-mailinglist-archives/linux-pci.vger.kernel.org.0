Return-Path: <linux-pci+bounces-19135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFF09FF15B
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 19:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4D07A15E2
	for <lists+linux-pci@lfdr.de>; Tue, 31 Dec 2024 18:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF85192B85;
	Tue, 31 Dec 2024 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jms04nY3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11C186607
	for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735671091; cv=none; b=gQDLfhEFB2vh3l/49AZliIWRk4vxPyf3Hh5Wc8D54Z5PbmskehhaHoCLnWa4skIKDT+JWRbH27ugK2gbw5Mco/+OnFZzh/kn1Z7rsZnq1kkJI5xrot0l1imU8FTX/tW6T73fbNDJ5Exf0bkBmnQ9XenZcs+8trgHgk6wJnp3qyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735671091; c=relaxed/simple;
	bh=azU98vO31SNIAZBhQsgizDHYDGJVyVDcLdRUF835Ap8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCVvd5vWYJC7DJ4KIEE7JAfe+csnWX9jppq2nTrjmZp/8i6w63haYb6gB8BiaX6neiGRZLs4bPG6C1op6XaiMEyeDhMCM+mAj/6Ubz3cIiBxivjxLvnVlf/t/+NtL0VC0h+rdelrzY2oCjqmt4N08nxBbcHSfyZbe5Kf5NXeGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jms04nY3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21634338cfdso196283345ad.2
        for <linux-pci@vger.kernel.org>; Tue, 31 Dec 2024 10:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735671089; x=1736275889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E334ZcZ7CwPkqPg976DHkaYzDYOWts3xcgbUbSOfEho=;
        b=jms04nY3UcaoGMBvugECOE7KsBMMwHgWNqj7mkZ/hSNKXfWAMqp8tLxMKthWJGKQvt
         vXJq5gnRwurnCVCyKXhhzTt9XkPsDBrm6rUr6HgoWwgtpmUDMeUBKpO4IsYgG23K0FSW
         S7wKdFeCVLL3EdR+ph9d44+uhEEHViwIsGSKWYeznzyE7l5ikAAOIrAjCS1+IdhjgJIZ
         m48PmtV7PozNLurKJr7s+KeHHXQVXZoig79kjUfzvMskoFpM+W2gW7mjJ7RaUszCl2bN
         2Ji7W7+AfcNruRKgLWvEhgq4EWYQgLgJ1N1+Qkn2H/0n1/G/trjENhRb9+LniS9i37ul
         x3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735671089; x=1736275889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E334ZcZ7CwPkqPg976DHkaYzDYOWts3xcgbUbSOfEho=;
        b=D4ZjWOOqTeMSqby04MlFzXRQzv8jhrkfgknWPQfrXn45OrHe4h1XXMo9nlE7KVEPFh
         PR9cBQuYNnU1i7Jopb/LRssXi0BpmrL8eR+q6H9zTd+CBzBy1+3e9Pz7f/HVVkqw8XS9
         8bLqAXdTJYTqw0rTGcqFJAF1Ba68enFoUleULOioBAEEXPWpzi773g8bl75FvxuKjvI+
         D4NqJ335IJESK0YINCIdQQ6EJ1N/Nz8yYIDlfMbfbJdQMjC8Wxq/HRkRgBlNTsm9YyZv
         UnbH0WyrcrWJdml6AqYcFhqRVJHIMbz9/m3aMjIdUlmS/pMk4K83CagD3bDGBcVwQ/wz
         a5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGg/Lyjkgp6lqupicvTeSZIhLTzm/nWFe3vFxsR9L/lB3DW8qlyOYUHqTBujztx6aR5ZrNslqhA5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+CfEg0DdT9ytsZtk/PcIKX90vJzXv3dvL+Pk6nEauDDpuxF2
	Z4FtAbqOjf7QIr3KX99bdcv9S9EhojBaKq9NSbmtkc6Mh6YXVSotz0IeqGr3lw==
X-Gm-Gg: ASbGncsJeZamV/4YvccUDUwDhuzr9Mwt15fiaY67LaE3FxwZuCxdTfCJSO/xlZfjxBM
	2ryTc4IWgR3M9vZ7WC02E5GJ8mYsMkDpe0rZSgF8AKJOHzPPKfdEmPw+is2joP1TkbA7+eYAe08
	6ZcYJcZXfQ7I6nIEt/34Ukmru+HA7UvfshbxD2WYHUNp8VJlHpT33xu6tEeZMf9oC4otyFgny2w
	/tpaM7pkSZeSmppf/dAY2FKDUwgN8JpzW8UqTSD+OlFPN0bjWWf6asb2JeKRxnJtuPgQw==
X-Google-Smtp-Source: AGHT+IGwVGbLmDVZpt6B+0AieoEIml+NQ87VsD3igzaQnYjjX3XsoInBdqw8aBrZMCZea0xS3EiNZA==
X-Received: by 2002:a17:903:1105:b0:215:a3fb:b4d6 with SMTP id d9443c01a7336-219e6e8c5a0mr582168825ad.8.1735671089132;
        Tue, 31 Dec 2024 10:51:29 -0800 (PST)
Received: from thinkpad ([117.193.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04c54sm197507815ad.236.2024.12.31.10.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 10:51:28 -0800 (PST)
Date: Wed, 1 Jan 2025 00:21:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v4 1/3] misc: pci_endpoint_test: Fix the return value of
 IOCTL
Message-ID: <20241231185121.yiakwbdrzdxrqydg@thinkpad>
References: <20241231131341.39292-1-manivannan.sadhasivam@linaro.org>
 <20241231131341.39292-2-manivannan.sadhasivam@linaro.org>
 <Z3Qii43XSnxvc4pp@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3Qii43XSnxvc4pp@ryzen>

On Tue, Dec 31, 2024 at 05:57:47PM +0100, Niklas Cassel wrote:
> On Tue, Dec 31, 2024 at 06:43:39PM +0530, Manivannan Sadhasivam wrote:
> > IOCTLs are supposed to return 0 for success and negative error codes for
> > failure. Currently, this driver is returning 0 for failure and 1 for
> > success, that's not correct. Hence, fix it!
> > 
> > Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Closes: https://lore.kernel.org/all/YvzNg5ROnxEApDgS@kroah.com
> > Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 250 +++++++++++++++----------------
> >  tools/pci/pcitest.c              |  51 +++----
> >  2 files changed, 148 insertions(+), 153 deletions(-)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 5c99da952b7a..7d3f78b6f854 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -169,43 +169,47 @@ static void pci_endpoint_test_free_irq_vectors(struct pci_endpoint_test *test)
> >  	test->irq_type = IRQ_TYPE_UNDEFINED;
> >  }
> >  
> > -static bool pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
> > +static int pci_endpoint_test_alloc_irq_vectors(struct pci_endpoint_test *test,
> >  						int type)
> >  {
> > -	int irq = -1;
> > +	int irq;
> >  	struct pci_dev *pdev = test->pdev;
> >  	struct device *dev = &pdev->dev;
> > -	bool res = true;
> >  
> >  	switch (type) {
> >  	case IRQ_TYPE_INTX:
> >  		irq = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_INTX);
> > -		if (irq < 0)
> > +		if (irq < 0) {
> >  			dev_err(dev, "Failed to get Legacy interrupt\n");
> > +			return -ENOSPC;
> > +		}
> > +
> >  		break;
> >  	case IRQ_TYPE_MSI:
> >  		irq = pci_alloc_irq_vectors(pdev, 1, 32, PCI_IRQ_MSI);
> > -		if (irq < 0)
> > +		if (irq < 0) {
> >  			dev_err(dev, "Failed to get MSI interrupts\n");
> > +			return -ENOSPC;
> > +		}
> > +
> >  		break;
> >  	case IRQ_TYPE_MSIX:
> >  		irq = pci_alloc_irq_vectors(pdev, 1, 2048, PCI_IRQ_MSIX);
> > -		if (irq < 0)
> > +		if (irq < 0) {
> >  			dev_err(dev, "Failed to get MSI-X interrupts\n");
> > +			return -ENOSPC;
> 
> From the pci_alloc_irq_vectors() kdoc:
>  * Return: number of allocated vectors (which might be smaller than
>  * @max_vecs), -ENOSPC if less than @min_vecs interrupt vectors are
>  * available, other errnos otherwise.
> 
> So pci_alloc_irq_vectors() can return errors different than ENOSPC,
> and in that case, you will overwrite that error.
> 

Ack.

> 
> > @@ -442,9 +444,12 @@ static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
> >  	val = wait_for_completion_timeout(&test->irq_raised,
> >  					  msecs_to_jiffies(1000));
> >  	if (!val)
> > -		return false;
> > +		return -ETIMEDOUT;
> >  
> > -	return pci_irq_vector(pdev, msi_num - 1) == test->last_irq;
> > +	if (!(pci_irq_vector(pdev, msi_num - 1) == test->last_irq))
> 
> if (pci_irq_vector(pdev, msi_num - 1) != test->last_irq) ?
> 
> Or perhaps even:
> 
> ret = pci_irq_vector();
> if (ret < 0)
> 	return ret;
> 
> if (ret != test->last_irq)
> 	return -EIO;
> 

Ack.

> 
> Otherwise, this looks good to me:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

