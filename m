Return-Path: <linux-pci+bounces-18094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B579EC5EC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 08:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0E428126C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E12770B;
	Wed, 11 Dec 2024 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqXLx55g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A8F1C549C
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903287; cv=none; b=H900aOlDgDy/nSzlnXAC+bc8zS08cw8poHUhkjH7k/xKmfGPu3MeO1L4PA+EK6o4sggyXlTv5oCpHuvQAumtwYdaySRL2WjmDSUvNmy/GwEufJRSHzsymgNs9uIUhVvsvbSfST226/+rqMfyWi/rZwIVXdvNXo6nfRSf0GpTWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903287; c=relaxed/simple;
	bh=FL0ECQxCvQ32p81Mcm1ddqDNtG56JuJQDXNqTmoIIxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjGMm5oL9cwRpqDoLpcG+BjoWH4XJpC1K7a1LBw6yVuk9PwCkaCJ6D7i5iQL2B+EWiGCgG9OHHy94COJbq5zomkFp4fziBp/BLAXITHRiV+T8S/6m2013Kcl//a5GWWW/K1Uwl0lf3+OI711IpdNehQ5RGpmCnBfidDhvKyGLS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cqXLx55g; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216281bc30fso44226895ad.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 23:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733903286; x=1734508086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=We1H/O/5JSivIAPtQ7Na6FEoBB6GPBDqGbOj3m5VHPI=;
        b=cqXLx55g1B8IVj5yBnGQDPfJMBJCe5vhyGbf3jJnKO1dZZRIQjcS+HhrE5aHspIw3u
         l59ZweYgg/b8GHEUr/luWaWymkqC+/abKjrd5A088oNDC3ctsFAtNkfhgBtuy+7MInv5
         fhj/MgyM6Cxr8S/Z6Z5s1VwVm0/1StqlOOWE/euRRD58/yulMHOsroHvuN0GP8ys5HkM
         5h5HZuVjAMfTRaYxAzb5HEM/kx1Nk3KWmwVDKfhGhb/GPGEk5XhtFyLcPx6mHa5ksu/C
         UlxSG3hSTWgAgYO7v4gybK0hbrnMVGHFNg8Pim91SkDTpV08/OkRBamh7kf19eF5YSuI
         FFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903286; x=1734508086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=We1H/O/5JSivIAPtQ7Na6FEoBB6GPBDqGbOj3m5VHPI=;
        b=v/6uA8qkWABLADXJDEp7OkCFB9NCP9G6xwzLEnEc/hDGjB4cF6ZzAoBIfWs60wP91m
         pRHizJaihnNa0vJ+w+fSreVy54NVul+9lVI+b1bijP5RS8ck53whe2ZxGSFpYCTnPk7Q
         lSB1H0+T2dQwzUO+Y9IQ6pJR3rzqJk1oFaykkyQcUzwnNgGRHRc/iPltepOyAIomIiQe
         g67b0ZLYQBErofaUAfdfdR2Gx7YpR8SP0Nc5dfsIf67jpApUTi9UGHhEfB9affPOJYi0
         sLhVVK/ubUEu5uI6ElbOoqhGe9bU1wji1g2aS4lpw3kJwALXK8h29bHzwKZY0cSGHVns
         +kkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnQqMWHJuHHi+d2SVo3CGCNv7SLgrV+7dqT/5RisH4hH1MCbIPh639R9bnv9CNaFbEx9Bo/m+slAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1bJGIlOLOqyAToYVspF+TnXODlbU+T6X6c3/qKYg8MTgiOLv
	/UTLmGdZN03mrBT31iPX7X6+BHAkK/unqUT4erk3TWqRclC1CDS2yYjYjkxSGA==
X-Gm-Gg: ASbGncu6ukpXV1Knq+yvJdo/Lws31O/dmkXAeLjBfY6cji6OwUzDIKQ8Uyi84ev6C1R
	SJCe3wNLOa7JsxTy6yX0/WDNgFx6b2+y/6wdctcFHDiBu4K7S7l++kKDE84+Uzx2grQZL37gfeQ
	v3zRBdgwNf5TvWjAR8xkxx/CGndRSnnzIQPOKuuxfIt5OhtQmPPoW/cHwAZhwzsP4T8DHQd5mtm
	YcmzYemQVIYUJVxgi133SikOsbDdU6QVlkvTAuWtZQlZ5eIcbLziN9+iMxNGO8=
X-Google-Smtp-Source: AGHT+IEhrzTztU1j5OzMUP/bR3EXig9yjni9/ZYqzhtDD5dvE1u59b6+6zz4qP3utDEKyerb33yjlg==
X-Received: by 2002:a17:903:2284:b0:215:4a4e:9260 with SMTP id d9443c01a7336-21778536d17mr31649505ad.14.1733903285776;
        Tue, 10 Dec 2024 23:48:05 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21641f46e17sm53537855ad.221.2024.12.10.23.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 23:48:05 -0800 (PST)
Date: Wed, 11 Dec 2024 13:17:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] misc: pci_endpoint_test: Fix the return value of
 IOCTL
Message-ID: <20241211074757.byc5jqpgfe3otjh7@thinkpad>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-3-manivannan.sadhasivam@linaro.org>
 <ccd1587a-0368-4bde-9c72-4f10393c58b0@kernel.org>
 <20241129163024.dvz2ojldopeoyr6c@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241129163024.dvz2ojldopeoyr6c@thinkpad>

On Fri, Nov 29, 2024 at 10:00:30PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 29, 2024 at 07:51:30PM +0900, Damien Le Moal wrote:
> > On 11/29/24 18:24, Manivannan Sadhasivam wrote:
> > > IOCTLs are supposed to return 0 for success and negative error codes for
> > > failure. Currently, this driver is returning 0 for failure and 1 for
> > > success, that's not correct. Hence, fix it!
> > > 
> > > Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Closes: https://lore.kernel.org/all/YvzNg5ROnxEApDgS@kroah.com
> > > Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Looks OK to me.
> > 
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > 
> > One nit below.
> > 
> > [...]
> > 
> > >  static void pci_endpoint_test_remove(struct pci_dev *pdev)
> > > diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> > > index 470258009ddc..545e04ad63a2 100644
> > > --- a/tools/pci/pcitest.c
> > > +++ b/tools/pci/pcitest.c
> > > @@ -16,7 +16,6 @@
> > >  
> > >  #include <linux/pcitest.h>
> > >  
> > > -static char *result[] = { "NOT OKAY", "OKAY" };
> > >  static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
> > >  
> > >  struct pci_test {
> > > @@ -52,63 +51,65 @@ static int run_test(struct pci_test *test)
> > >  		ret = ioctl(fd, PCITEST_BAR, test->barnum);
> > >  		fprintf(stdout, "BAR%d:\t\t", test->barnum);
> > >  		if (ret < 0)
> > > -			fprintf(stdout, "TEST FAILED\n");
> > > +			fprintf(stdout, "NOT OKAY\n");
> > >  		else
> > > -			fprintf(stdout, "%s\n", result[ret]);
> > > +			fprintf(stdout, "OKAY\n");
> > 
> > Maybe replace all this "if (ret < 0) ... else ..." and all the ones below with
> > something a call to:
> > 
> > static void test_result(int ret)
> > {
> > 	fprintf(stdout, "%sOKAY\n", ret < 0 ? "NOT " : "");
> > }
> > 
> > or simply with the call:
> > 
> > 	fprintf(stdout, "%sOKAY\n", ret < 0 ? "NOT " : "");
> > 
> > to avoid all these repetition.
> > 
> 
> Sounds good to me. Will incorporate in next version, thanks!
> 

Maybe not. This test is converted to Kselftest in successive patches, so no need
to simplify it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

