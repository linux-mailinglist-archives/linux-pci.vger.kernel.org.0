Return-Path: <linux-pci+bounces-2911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447384520C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 08:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F301F2582B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 07:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77FA1586D2;
	Thu,  1 Feb 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+UHy42G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533A148314
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772769; cv=none; b=XEgwpX9S4kZB3bWVRbaaMblbbBndeLXt0glgSjOFGJelhbNfLrcK9X00EeCBOP/KMFppGWegHiwEb+FLPSYdjEgFB1pR/laMmTxGbbKtO/+YYsrnwHTjS4Zd8sXPgfWmBp7ahNjUUThQxRrquXBt7Whl7vn15Jaq+E0WasYJG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772769; c=relaxed/simple;
	bh=b0/Y3dCnEtFMkfn82IcFtIclV2mdgkC7gF4woGwAKDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fb1fkhjfPu8xakTRT4G5dgHYto4MSmDAjwbYnumFsrJFUpB1fjcvm/bKRfzD1qMNMMiAD4Fzx8h3LkeX8XfnB3x4KvUpG43J6l8BsqCCm9EGDXuLRoJxDWOXs2/jZynhWsRn6a7v88gOGLes4P5y60wQxqpzsIgOxBS6ZiKYlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+UHy42G; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d91397bd22so5047645ad.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 23:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706772767; x=1707377567; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0onsKGBx118DwLK3eUVC8jcPqkEh2CcejyBpvlwL4Ao=;
        b=T+UHy42G7PedQU5rlUQPWJd3vNBdA8Y3AF0jYbY35RECYWfhpwmVmnykq2khcBJsNt
         n7m8oNCfFgMhG/6M23T5rD7ixAEuMr2TviMbnaOGhW/NcECiR5aaPln/govCn3d+B3Rl
         NL2Zt1QvYbRFVNL5iNRJBGtaPNq6hpyYK89TsKVx7+YSJp0N5IazuDwj/mNecgu60P4J
         sZAcjCuTlejpuKPrfmyFX2bUHV3+TH/yixaJ3HrjsggV2Rb14vK7N1kkA4mCvHYhuwrf
         C2RZa0KZlNn9hPAJOSh7mvmNV/fm94N1xA6wU89QaeOyv4z/nYiDJ4f20G6WiKsaPSgM
         XL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706772767; x=1707377567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0onsKGBx118DwLK3eUVC8jcPqkEh2CcejyBpvlwL4Ao=;
        b=nZS2gRfNl7gKOfPUP2Jv/H6biUuchaYJxqxoqRP6X8a41GzWOsA6FydaVntD88BBAV
         4LpOEyMNcaHS141eCYMXN8fGigoiZQe6EFyUebikybpWvduc8J+7D9cYcFve0lCSFabY
         IrSua0YqJ50BLZyayNEDq7x4m6cisBZVs+WEgslo93/0NuEydzwOkEYcUsiolHFUI/F3
         /v6RpK+oBMKmtYP9h221WO6EXifuK5/blPKOm5/zgr2x5s6Xq+nqRplN8bSZJX9U9/aY
         84trAkkzcFZ/ilspX2mBXJVseAfu8IOS4Nb+yeYyMD2fXypwWGXo1b3gc/gqEEFo7FQf
         Co5Q==
X-Gm-Message-State: AOJu0Yz18GHaVUsdo6Vr7YouoAsNnkoP6Ok4PLziISNny+xCcHC1iC4B
	aq9tKHVmgrYkk34WeziocqPJB02x/r9KNuf1Aj+caLz878FVplE6b69kmOK0rQ==
X-Google-Smtp-Source: AGHT+IGkPEMJOoHv92jYWhDIuR124a5d8jEQic7WVnqPPqPzrIyXQzv7b151oWUtPhCvwcw4yLL07g==
X-Received: by 2002:a17:902:ecc1:b0:1d8:a108:2cab with SMTP id a1-20020a170902ecc100b001d8a1082cabmr4811538plh.67.1706772767532;
        Wed, 31 Jan 2024 23:32:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX/Y1vqmyq566FeaoPEopOpYDvMUl+gX1OK++6aW+3fb4ZoFXjGQGNMi/Do+C1KVacXf1j7vuKdKtWh1FBy6c9MFafeehWAgPnCZnSE8ynRj5Cpv8qMeHMIW13OGFrujel5Y3YCGLRlRHQIsaEDcKBC4MoeHcozGwqTXiR6MUD1I/MpzBFFvQ68D/RedtpXGlmNdoxAM79+1nK5QF+lfO4qBV3TmHgjiVI53S55kRN37ymdOduMLZhavCXGuyI8L5pgBhmAYe29GgduqXxZnxA7HlXVc/Q/JXPBrYaowpb4xHY68SWXIc1VqY+mZSzld0yhQvhMNjlUQJTHUgMC125G3fhR7CC4zXEk7JAddsaPvY1aIuyL8jKktQCSd1cC/X0GGNilNkjNPx0nEktlW5h3pOC1FilUd9r3tSYZJ3dcS/s2rm6GnoA0wUy8elvbpswMaN83XM33AHonMmj+Qp77iTiH
Received: from thinkpad ([117.248.5.99])
        by smtp.gmail.com with ESMTPSA id jv11-20020a170903058b00b001d8f99dbe4asm5463884plb.4.2024.01.31.23.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 23:32:46 -0800 (PST)
Date: Thu, 1 Feb 2024 13:02:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ajay Agarwal <ajayagarwal@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Chuanhua Lei <lchuanhua@maxlinear.com>
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240201073239.GA17027@thinkpad>
References: <20240131234817.GA607976@bhelgaas>
 <20240201031413.GA614954@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240201031413.GA614954@bhelgaas>

On Wed, Jan 31, 2024 at 09:14:13PM -0600, Bjorn Helgaas wrote:
> [+cc Chuanhua Lei, intel-gw maintainer, sorry I forgot this!]
> 
> On Wed, Jan 31, 2024 at 05:48:17PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 19, 2024 at 01:22:19PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > started or not, the code waits for the link to come up. Even in
> > > > cases where start_link() is not defined the code ends up spinning
> > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > gets called during probe, this one second loop for each pcie
> > > > interface instance ends up extending the boot time.
> > > 
> > > Which platform you are working on? Is that upstreamed? You should mention the
> > > specific platform where you are observing the issue.
> > > 
> > > Right now, intel-gw and designware-plat are the only drivers not
> > > defining that callback. First one definitely needs a fixup and I do
> > > not know how the latter works.
> > 
> > What fixup do you have in mind for intel-gw?
> > 
> > It looks a little strange to me because it duplicates
> > dw_pcie_setup_rc() and dw_pcie_wait_for_link(): dw_pcie_host_init()
> > calls them first via pp->ops->init(), and then calls them a second
> > time directly:
> > 
> >   struct dw_pcie_host_ops intel_pcie_dw_ops = {
> >     .init = intel_pcie_rc_init
> >   }
> > 
> >   intel_pcie_probe
> >     pp->ops = &intel_pcie_dw_ops
> >     dw_pcie_host_init(pp)
> >       if (pp->ops->init)
> >       pp->ops->init
> >         intel_pcie_rc_init
> >           intel_pcie_host_setup
> >             dw_pcie_setup_rc                        # <--
> >             dw_pcie_wait_for_link                   # <--
> >       dw_pcie_setup_rc                              # <--
> >       dw_pcie_wait_for_link                         # <--
> > 
> > Is that what you're thinking?
> > 

Right. There is no need of this driver duplicating dw_pcie_setup_rc() and
dw_pcie_wait_for_link(). Perhaps those functions were added to
dw_pcie_host_init() after this driver got upstreamed and the author failed to
take this driver into account.

But my point was, the new drivers _should_not_ take inspiration from this driver
to not define start_link() callback at the first place (unless there is a real
requirement).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

