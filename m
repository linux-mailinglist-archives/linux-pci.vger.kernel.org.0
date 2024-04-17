Return-Path: <linux-pci+bounces-6364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E7E8A884F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59BC1F21234
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 15:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C931411CF;
	Wed, 17 Apr 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkmuN7W/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91913C668
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369517; cv=none; b=mKT5JCPwNCnGGantnBK6HoiZjSXY074xzC5XEbkMqhaKNO4NhZHHcjiC/jJVyCZDtdBppHWza4IRjq1LY6bsyPfBmAohHCYLxZ1dBho3NdOE8veaOIofPdHy7RVleizlnqFBhVUowjhobVKbqR7Y/lJNQ7kI1F7slmaZ1sDaZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369517; c=relaxed/simple;
	bh=pvA0mFk0NvYqm4vWA6Mh6GtDnWdSs24KzP4zM38KY88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/arlV84AIVo5YrgGxlKoljfAMgdOAc89Q2bK9cU7C/fTM9kyxJTh+58d2w30mDVSzfOJ2xImdynsjT0HDLLN1OfDfbXDIHiUxf16fi39c3zBTBNonfjpNqOpB195R2Rh6nD4L5vGj6dT0LpiGQQt7CLM7NhcqQVxaWxxC1GoSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkmuN7W/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2b1cd446fso45374965ad.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713369515; x=1713974315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BdnwETq+WZjVtPKF3IdADpXtuPL9XXXXm0JPj1tbHnw=;
        b=mkmuN7W/ZcghfmsgVFh5+m0Sn5GTzSVc++aAGRWNMR65zZHUax80Akrefj/GO1y4WW
         Isus492zxMxM/xWIyCSXssEN9FdttQFfZ5js5Lhl6ZR3cBr4t0yvd3ZEIQxS3u4+43oo
         vqsfuVE7umR8jwO9ss5n9Z0P91k0RmwaKvds/+UJrWh9KBDucpqLXgnLnD34uJf71VFF
         Y76zPx/IHNtc7BpaT6CIzyD68NO4qv41+3ig6QNWonP7TO+4ZhAfE5/quyVn+riXgObL
         jPbqE2nfrdZ5ZxLcGeAg8WtBW9sw4iGBGvjaa3ATWYVRlNZ/yzx4KouF97H5Q6GuhIXs
         kRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713369515; x=1713974315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdnwETq+WZjVtPKF3IdADpXtuPL9XXXXm0JPj1tbHnw=;
        b=DmxnitRJ0rK5ZIznq4GvoBcKHqWW3hdIQbyW9Xnlqo7OLI745cZHnwkdu9MvjzUUWJ
         Gxcd1PHtUR+BQq0vmKDIaH9Bj7XRO5gpbZjiZv/S5ySrUpL/DJHciAwk3WnZDyzz3eKn
         RMJrieTe495eseNqyaY4gVemz7PBlpWdu2rl9kqqkEsHinQofV3SKFvprQxrF197BOcU
         YRaJCU3MiCqwZgWuYIF3jpMBLdoo3fNTTiBo0u0SG+enw6NHQtHIRINZpIGYQ5e8u07e
         F8Q/7IfFOih1DNYSMaORYezmzbtxLxReSWGIKA4ku3ZOE1n8F1nljxjmTK+ByEpJR+Mn
         eu3g==
X-Forwarded-Encrypted: i=1; AJvYcCXMTvlmG1TVpV5G1RfIr1zPwt+T3PRc1ebt5e9nRp5su9nx8nN0BjolU3JffBD68axr3WiVojNbQXsLBR2Otx1KhGwX5cl02XlK
X-Gm-Message-State: AOJu0YzcikSnxA31bEPOxJOOS4NbuP4WtSekMl6zvUEuOdREaOC/RKM7
	+syuuGQD+EsPBIcPZZTBKvI2PB2oZCgmwtAaRa9CY8OidmK6q8IBqbR6Wwg8xg==
X-Google-Smtp-Source: AGHT+IFLRlUjL8HHA3VPDuQ6gmYdZYmLMWMXjeOSyOP3ybDkdGIR6RAb8MaetpjJSSs0Gcn9oZWWhQ==
X-Received: by 2002:a17:902:da88:b0:1e3:e1ff:2e79 with SMTP id j8-20020a170902da8800b001e3e1ff2e79mr21366261plx.45.1713369514555;
        Wed, 17 Apr 2024 08:58:34 -0700 (PDT)
Received: from thinkpad ([120.60.54.9])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e49bce9d40sm4956264pln.128.2024.04.17.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 08:58:34 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:28:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: endpoint: Remove "core_init_notifier" flag
Message-ID: <20240417155828.GB15187@thinkpad>
References: <024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain>
 <Zh_s3WdFURyll54l@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh_s3WdFURyll54l@ryzen>

On Wed, Apr 17, 2024 at 05:38:05PM +0200, Niklas Cassel wrote:
> On Wed, Apr 17, 2024 at 03:47:48PM +0300, Dan Carpenter wrote:
> > Hello Manivannan Sadhasivam,
> > 
> > Commit a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier"
> > flag") from Mar 27, 2024 (linux-next), leads to the following Smatch
> > static checker warning:
> > 
> > 	drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> > 	error: we previously assumed 'epc_features' could be null (see line 747)
> > 
> > drivers/pci/endpoint/functions/pci-epf-test.c
> >     734 static int pci_epf_test_core_init(struct pci_epf *epf)
> >     735 {
> >     736         struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >     737         struct pci_epf_header *header = epf->header;
> >     738         const struct pci_epc_features *epc_features;
> >     739         struct pci_epc *epc = epf->epc;
> >     740         struct device *dev = &epf->dev;
> >     741         bool linkup_notifier = false;
> >     742         bool msix_capable = false;
> >     743         bool msi_capable = true;
> >     744         int ret;
> 
> We check pci_epc_get_features() in ->bind(), which comes before ->core_init()
> so in practice, this shouldn't be able to be NULL here.
> 

Right.

> 
> >     745 
> >     746         epc_features = pci_epc_get_features(epc, epf->func_no, epf->vfunc_no);
> >     747         if (epc_features) {
> >                     ^^^^^^^^^^^^
> > epc_features can be NULL
> 
> We should probably just chge this to:
> 
> """
> if (!epc_features)
> 	return some_error;
> 
> msix_capable = epc_features->msix_capable;
> msi_capable = epc_features->msi_capable;
> """
> 
> Such that we don't need another check further down for linkup_notifier.
> 

No. We should just remove this NULL check since the check is already present in
bind().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

