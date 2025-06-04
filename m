Return-Path: <linux-pci+bounces-28937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E26ACD7AE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 08:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E4F3A767F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CC6263C6A;
	Wed,  4 Jun 2025 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IelnpEic"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B0262FEB
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749016908; cv=none; b=VB3UdnNpuzFWInt2RCTvOqG8syyvCsA85T3j8jh97zNYGbg6r9WVuVGgP9sgQJKHDHhAvZrjIt5xhp2JjIzKg/sgbcsNtV3foOwS3FEafSknilLlQzPLeibpfR3ikv3xWG/cEmRG+WienPq0Blln1k0v0jqGdCL9XLSZtIyU4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749016908; c=relaxed/simple;
	bh=OTfj5VgHFZ5gbh9tkYj67lK1g1D5j4ylUMJ/45wngNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/iG5fitxNCU0xgbT0glp06IzaBWpQ2Q1Ofwhrd68HwuB/FFK74RxL7efhopM9P7bl2qLuc5Q73zgWAXE2z7FtykrGj8655nt7kibQoUpv/y3/Hx47FlWoxbH7x0y9+CrktFw7OM9wVmus2iSMqSd3xzFwF6CTM+maKcwra7qa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IelnpEic; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a510432236so1867779f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 23:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749016904; x=1749621704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=js3ePkAFRXu2bd4kJEDMYhddIA3XtbtOgMVgKzlYv50=;
        b=IelnpEicNQ8mjcrzJGFV7DLQVuoojkiEqIgUF+Nuxo4MTV1TYP7XtHh4LyrqVGiOvY
         XF+C3v3QofQCSlDFeW/nz5nJCcvELjORNfYfqjtkKvYZv9IWKzezJpCltKn4GV1iWnog
         rWkQkO3hAxNRzhiZV8sBr63LBFsFL87v/5TahTkzbPy63uHR788zaTJ5TOhffRV/t7Xz
         gnha9wL/aqQe68Z5GCYXBJk4w8f0++5w/geuXqX9OQhn5v6yfk5xFEhCnf/biu1tmwZd
         OU4NEaeu0cOhmwpyGpaJ6NFHX9cL98ls6tJmkSzOdepfTL4iMM5oRgXE5QXc9+yWuovq
         2XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749016904; x=1749621704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js3ePkAFRXu2bd4kJEDMYhddIA3XtbtOgMVgKzlYv50=;
        b=GHpr/qDl2+NAhwsYp33AtUJqgo1+j+r85pDlafGzyZeQyn09odxeyQayzphjv642NJ
         PwkodpHOdGKfeNUkstYqC/RpZCipdkuCWL+DJGcBpmMTIgoYqgcgvBpgzvA84mochVRz
         oLQ0YZzG/Bsw7qy7y6FstwkfDHFETQQOWwbUWU2CwmsSAE5d0TBK9ooFAc7I4ADzGt1W
         HJLdZvsb/BxM4Xe/mc9laeJdN4/HWn4wJUG8NfjfEvfCP0nQ7b9ZQ7DTk7pAaTMnD3J5
         8s/Sf2ut4ltfCBqsnofthsvyhJP3/wzG8sVZvWb8PQIWz1p7Ucp8jZAFqHxcQJwmt76n
         MpDw==
X-Forwarded-Encrypted: i=1; AJvYcCWr33248uO5ySz7I7LsB8FYrbOKH9dGShuqn6Wuf1OivvOlaqz2YIRnnHp+1QP99QzVhB530twBk58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYC3+V2RG6JHZNsC5AcUXRV4lbcd4/oKkL+eOoMAjL8kVmr0w
	7ZLeIl+zcfVTiHvqr20Yjr2F8XoZxeJ+NxRO0M7En6TvyaX7xQ2eGYHqhLtT6jFJXR8=
X-Gm-Gg: ASbGnct0Ze35slYxbeUPYKIIa9dB7ZNSXRGBBWn7ef9EPcqqAGRjHjD2at54G4oCbMK
	Eat4Xdm15wP+1iCxnLVHXwxqHSGm0nWNSoZ03x0tR9TJ0601PCw5GBcU3NmWm4hJ8jYtTcBvsF8
	O/sk5+vqqaQPR+dYugREi26IVQaSt7tuLBF+O9ictXdRCxWtMlfmUtOuv8PbrkHMwNRKj1fqdJo
	0+hYeWsOBk3pEvb5e5VPj1Ou4fDFUr7CAfu4xblU721PeC2S0chQDuCrzgsC9bNsUdyBcbtIcG5
	wUL/56Rg8tXpfW8jg1+D3CXGn3c1hZEQtaU/K+yv/AJGiTRssC5+NV699lRXEXHiefY=
X-Google-Smtp-Source: AGHT+IHggEMVfIpJ7Xv+hdE4EzIhRVMoFlT3x2R6JtIQQe6ubsLLxsK+lqCkT6TBd/hsKH6MzgQovA==
X-Received: by 2002:a05:6000:2082:b0:3a4:dfa5:325e with SMTP id ffacd0b85a97d-3a51d8ef828mr998998f8f.10.1749016904364;
        Tue, 03 Jun 2025 23:01:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4efe6c9d4sm20798221f8f.38.2025.06.03.23.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 23:01:43 -0700 (PDT)
Date: Wed, 4 Jun 2025 09:01:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
	bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
	Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
	yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org,
	colyli@suse.de, uaisheng.ye@intel.com,
	fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL
 errors
Message-ID: <aD_hQ7sKu-s7Yxiq@stanley.mountain>
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-4-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603172239.159260-4-terry.bowman@amd.com>

On Tue, Jun 03, 2025 at 12:22:26PM -0500, Terry Bowman wrote:
> +static struct work_struct cxl_prot_err_work;
> +static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
> +
>  int cxl_ras_init(void)
>  {
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	int rc;
> +
> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	if (rc)
> +		pr_err("Failed to register CPER AER kfifo (%x)", rc);

This shouldn't return rc;?

> +
> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work);
> +	if (rc) {
> +		pr_err("Failed to register native AER kfifo (%x)", rc);
> +		return rc;
> +	}
> +
> +	return 0;
>  }

regards,
dan carpenter


