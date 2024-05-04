Return-Path: <linux-pci+bounces-7074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6748BBC75
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 16:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81C52826D3
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 14:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BEB1097B;
	Sat,  4 May 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSJfzeQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB081DDC9
	for <linux-pci@vger.kernel.org>; Sat,  4 May 2024 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714833300; cv=none; b=L38+O5VrFFwe0rY+Hmcc/4crbCwPkhv0PpXlKyW6ky9HgmHujsoXwzE33HOPBWqjVLB9YU+G/J/8bwacRDoKIb5jWTS/0C+Sg9NCiAsrbOdAKNDDlISTPzopCjAY2tWUuw5J7NrS4n1vwZR6ENBEWs6/5BlswX/UbAs6LSvr7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714833300; c=relaxed/simple;
	bh=Af0mMd94wFv/G3aroqYOBQbbfSYxV+CEPY5Q4696uPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2zunetclPOlvHJvA2p43gCsnF0Ln8xBjhFbJVaynzpiTDy3P4sEokyh3v/azOyB39O0DGWjSmMu83or6pJsj+BLxOZTT9psyrx3aN0I7ESYT688FOlQ+jbFckmrOJI8GoFFPQvtuwbUa02rEhyM5SUQymhULpos0Yvq99NcJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oSJfzeQk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so439647a91.0
        for <linux-pci@vger.kernel.org>; Sat, 04 May 2024 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714833298; x=1715438098; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nyy4LAyZP8KI7OlTDf5aFBKGQGzQXhfEPllp0seEmvc=;
        b=oSJfzeQkTEZzwO6Qskj7G9bh5Fz0rFNrDaNOMC/AJ2qiu4x2j9WV01OxT3cqsni9Hs
         Lf0acsq9AxfPqoiMvrmjnBQ9hHcois/OPaIJADkDKUfFpJkjhnu4HNVX9au4GXAUoVa+
         n4ODCof7iEPQRWFpVqopTRGuPvd8eazJp+KPCW9s2NzTwx+RDDGNrzDD6ThFsKZkKkBZ
         eXiExQew1ZPNqrF/wUYjaFL7i8sFJo8FUOrDowvyYriNDaATF3Ei2doG7vlV4sRSAcno
         4xrQbZZHsF7x9IHzjEjjLFQ+q+Uegf1XEbV5CgZFqovYsBtk2msPZZHVF5CRZw4NGFLp
         VD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714833298; x=1715438098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nyy4LAyZP8KI7OlTDf5aFBKGQGzQXhfEPllp0seEmvc=;
        b=hmKqiDAeJw2NOThqFKjngFOjMEqrGK00KjEf3JviJ6M+vtDNpSjB78v+GVfeZz3STX
         0zsJ+xFJYfqzqU9+1mVEkoteAOumlx2ksOaec2//0D21GcxEsKDnjHy/s586YNy5d8dg
         XObx/ZQ9mYWRSEK+vYSOWyRbAwyCqyN7NbWzYu1Ot5my0Myl1DH20CVO0M5wDvmNWMxj
         lCblOwTsrZsH7erqOg1CURdkaQpKj6NK01txT2I6BJo/KJkRCoVtTLc4mtYaCe3YQCuL
         L8tapRP0kMGoTqW6ABepah1HmBBTM1W6FrRVC9BerianNf/vjZEze5+ccyzW3Fb06ced
         myLw==
X-Forwarded-Encrypted: i=1; AJvYcCXug8O+Iij4dJE/AHOe2q0CqtDXR7lg1x43F7FNIIe6YnK2je2cUjJ35aeSg0APi9vkXW059wkj08f54pwTxPy9iInONgyFI5Dd
X-Gm-Message-State: AOJu0YzTlCzQM8pGoNiS/bEChE37By4IWmPpCbayaQ3J7g9xgmfbnvV5
	snmLPoX622M84x00T4XPI+TKNTCOu7BkLM+n9KqthGOZl7WwH/hr+gCTONfENQ==
X-Google-Smtp-Source: AGHT+IFLJpkIWp664Q1AnicCGjVOM6mGx2zz2Fal7CAa1UmOK9iw/lO+qdeiT0TOpiREqZwrqDYCJA==
X-Received: by 2002:a17:90a:db55:b0:2ac:23ec:6a57 with SMTP id u21-20020a17090adb5500b002ac23ec6a57mr4986731pjx.39.1714833297560;
        Sat, 04 May 2024 07:34:57 -0700 (PDT)
Received: from thinkpad ([220.158.156.193])
        by smtp.gmail.com with ESMTPSA id st12-20020a17090b1fcc00b002a5d62a7e75sm6877476pjb.52.2024.05.04.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 07:34:56 -0700 (PDT)
Date: Sat, 4 May 2024 20:04:51 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <20240504143451.GA4315@thinkpad>
References: <20240322164139.678228-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322164139.678228-1-cassel@kernel.org>

On Fri, Mar 22, 2024 at 05:41:38PM +0100, Niklas Cassel wrote:
> The current code uses writel()/readl(), which has an implicit memory
> barrier for every single readl()/writel().
> 
> Additionally, reading 4 bytes at a time over the PCI bus is not really
> optimal, considering that this code is running in an ioctl handler.
> 
> Use memcpy_toio()/memcpy_fromio() for BAR tests.
> 
> Before patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 1.56s
> 
> After patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 0.54s
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes since v3:
> -Use scope-based resource management __free attribute from cleanup.h to
>  avoid overly verbose gotos and labels for error handling.
> -Added a comment related to why we allocate a buffer of max 1MB.
>  (kmalloc() default upper limit is usually 4 MB on ARM and x86.)
> 
>  drivers/misc/pci_endpoint_test.c | 54 +++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 705029ad8eb5..bf64d3aff7d8 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/crc32.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
>  #include <linux/io.h>
> @@ -272,31 +273,60 @@ static const u32 bar_test_pattern[] = {
>  	0xA5A5A5A5,
>  };
>  
> +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> +					enum pci_barno barno, int offset,
> +					void *write_buf, void *read_buf,
> +					int size)
> +{
> +	memset(write_buf, bar_test_pattern[barno], size);
> +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> +
> +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
> +
> +	return memcmp(write_buf, read_buf, size);
> +}
> +
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j;
> -	u32 val;
> -	int size;
> +	int j, bar_size, buf_size, iters, remain;
> +	void *write_buf __free(kfree) = NULL;
> +	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
>  
>  	if (!test->bar[barno])
>  		return false;
>  
> -	size = pci_resource_len(pdev, barno);
> +	bar_size = pci_resource_len(pdev, barno);
>  
>  	if (barno == test->test_reg_bar)
> -		size = 0x4;
> +		bar_size = 0x4;
>  
> -	for (j = 0; j < size; j += 4)
> -		pci_endpoint_test_bar_writel(test, barno, j,
> -					     bar_test_pattern[barno]);
> +	/*
> +	 * Allocate a buffer of max size 1MB, and reuse that buffer while
> +	 * iterating over the whole BAR size (which might be much larger).
> +	 */
> +	buf_size = min(SZ_1M, bar_size);
>  
> -	for (j = 0; j < size; j += 4) {
> -		val = pci_endpoint_test_bar_readl(test, barno, j);
> -		if (val != bar_test_pattern[barno])
> +	write_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!write_buf)
> +		return false;
> +
> +	read_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!read_buf)
> +		return false;
> +
> +	iters = bar_size / buf_size;
> +	for (j = 0; j < iters; j++)
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> +						 write_buf, read_buf, buf_size))
> +			return false;
> +
> +	remain = bar_size % buf_size;
> +	if (remain)
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
> +						 write_buf, read_buf, remain))
>  			return false;
> -	}
>  
>  	return true;
>  }
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

