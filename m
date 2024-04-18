Return-Path: <linux-pci+bounces-6400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD728A9400
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 09:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53DB1C215BF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 07:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B771B20;
	Thu, 18 Apr 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuNnMXTQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F016A342
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425431; cv=none; b=bKyGZo7atX15pc1LYiU42b1dcsrz480KHDEEsvZlYTfWGjzrC4F3BFYtp1GCuL25NuO0br8RzLm4Vw21wwVshq4/buGR6H9Y7xZWRLcK7bZdhaNi4o/Zc/s8bxgnqRUYoDB8u+0PuDSykIj0zeUKtbzoYaRFyMwjLR9G1BdhIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425431; c=relaxed/simple;
	bh=jo84Ctj+EJCX1GrpA4pW6fdXW7pDWtjFx80MeyJrxQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9OdIu6LXLpO4dPAys4N+4WgOwm89ZQkXkXyjeat+8KMTyYEVQzt5wLQq8TgBvPCgOl8gRKGwkSmLY6UDHjDxHSyZvERc+2qsIjSrI6aXSgpzay9HjGcbUKEQ77NFgOxaPZzRuoKmhmYeIBeVxAWP0ZzUnJNyTOApmNwtkQAGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BuNnMXTQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c3aa8938so4366935ad.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713425429; x=1714030229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9KH/0gX4nuEqY5M5Shgab8r86I8FtVQ44AsXqRTnb4U=;
        b=BuNnMXTQIDEJKUWx/2aFeg9hs86yWeNWfbs9fWr3NUfPHz4ZZ6bsaUF0AwI6OSZdKW
         F9glOIhvsv4vQJ07yZg9yCaGrqNkPqhqn/h9XqDhKRHTUUL+fKC4sITH+Lg9It1tW8l4
         oJG7wbB9Yx+x9VFci1TsNejc+PCU5kI4LOLHFtXneaM5Ofuif9XgNPWbIXnvEM1d7vxU
         rZCgh2An6ORg8y5C92Io7bsjGO+q5+Md0itODxUk1boEmMTwvs5+2H9dM3dq22v7l6AF
         ccBpLM7YHwXqcqEf321Ml0GflvY6gqVnLkwWWIyZMZzzzlqCAVJCkuh+9g/iRvKT1XHj
         cbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425429; x=1714030229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KH/0gX4nuEqY5M5Shgab8r86I8FtVQ44AsXqRTnb4U=;
        b=nyoKuroGqDFf+ToY4AQMfeENFqLkcnF3hoC93DGKMrQg45rtHN9dlPqsEj1o+6RVLn
         N8NKG4GMEHMhz0cSy1DziK3OZ5tAcRR6l9N4+FZgF3wcIb+TcxD0f//+1oI4XBfneRK8
         rkK4afvGoMDC25cAdZ0VjUBPpAJ13SXkkAbLD78tJakrfULXPpu4FEqT2mf86ktd1pws
         nQujWpjPFA+8jIPfoeJhY2ceGjvC2/+H6GSSXboiwrhZsr0kFpKMA1jv9wrsHmyOWM+f
         POQ+RR+R/NIbZVIpF/LPkkC7MwxyrKnPdcmemwadF8T+HvERB82FtCi49zAnI0wZDfS2
         dSVw==
X-Forwarded-Encrypted: i=1; AJvYcCUR2qkarOe2kR7z3bsPpOLLzcgzFVZWyY7rUsSYis6KEYT62ASHZAikPe0FEnW5vERhzqSJDlkJGmduoyJfpgczJkh5fStg3Hdy
X-Gm-Message-State: AOJu0Yyj/agV5/4G7Sk2CgO++is/zTvw/+zj+ml3KexRELAAhjou+K3p
	Jxyh0j6l1udB2mIAs1Rz2Kr002cyv/QALYS7F+rOE+FCgNwKab5gF6MxWt1ZnA==
X-Google-Smtp-Source: AGHT+IFWMS7B+eevMfCZ0tH7FwXVvT82Lh4Zn0V4gbiALK6EFJmnT/7oWMZI+ml4e2wBetkcVDGhUg==
X-Received: by 2002:a17:902:da85:b0:1e1:6850:f823 with SMTP id j5-20020a170902da8500b001e16850f823mr2668391plx.13.1713425428965;
        Thu, 18 Apr 2024 00:30:28 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id j23-20020a170902759700b001deecb4f897sm837286pll.100.2024.04.18.00.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:30:28 -0700 (PDT)
Date: Thu, 18 Apr 2024 13:00:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <20240418073023.GA4331@thinkpad>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
 <20240418054319.GB2861@thinkpad>
 <ZiDB18w4bnUCSH7D@ryzen>
 <20240418065308.GG2861@thinkpad>
 <ZiDITzuUXsTZ7U4T@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiDITzuUXsTZ7U4T@ryzen>

On Thu, Apr 18, 2024 at 09:14:23AM +0200, Niklas Cassel wrote:
> On Thu, Apr 18, 2024 at 12:23:08PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Apr 18, 2024 at 08:46:47AM +0200, Niklas Cassel wrote:
> > > On Thu, Apr 18, 2024 at 11:13:19AM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Apr 17, 2024 at 07:49:45PM +0200, Niklas Cassel wrote:
> > > > > On Wed, Apr 17, 2024 at 10:47:25PM +0530, Manivannan Sadhasivam wrote:
> > > > > > Instead of getting the epc_features from pci_epc_get_features() API, use
> > > > > > the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> > > > > > the NULL check is already performed in pci_epf_test_bind(), having one more
> > > > > > check in pci_epf_test_core_init() is redundant and it is not possible to
> > > > > > hit the NULL pointer dereference. This also leads to the following smatch
> > > > > > warning:
> > > > > > 
> > > > > > drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> > > > > > error: we previously assumed 'epc_features' could be null (see line 747)
> > > > > > 
> > > > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > > Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > 
> > > > > I think you forgot:
> > > > > Fixes: a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier" flag")
> > > > > 
> > > > 
> > > > No, that's not the correct fixes tag I suppose. This redudant check is
> > > > introduced by commit, 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer
> > > > core initialization") and this commit removes the redundant check (fixing smatch
> > > > warning is a side effect). So if the fixes tag needs to be added, then this
> > > > commit should be referenced.
> > > 
> > > Well, you have a Closes: tag that links to a bug report about a smatch
> > > warning that was introduced with 5e50ee27d4a5 ("PCI: pci-epf-test: Add
> > > support to defer core initialization").
> > > 
> > > So if you want to reference another commit, then you should probably
> > > drop the Closes: tag.
> > > 
> > 
> > Then checkpatch will complain... But I think I can keep the two tags? One is for
> > fixing the redudant check and another is for the smatch warning reported.
> 
> Yes, I think so too.
> 
> You can have Fixes: to the commit that introduced the redundant check,

That is 5e50ee27d4a5.

> since this was obviously not the correct thing to do, and then perhaps
> just mention commit 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to
> defer core initialization") somewhere in the commit log.

You mean a01e7214bef9 here?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

