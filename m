Return-Path: <linux-pci+bounces-28385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2D5AC32DB
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 09:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414553B8EED
	for <lists+linux-pci@lfdr.de>; Sun, 25 May 2025 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9AB19DF99;
	Sun, 25 May 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCF96fdi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C6198E63
	for <linux-pci@vger.kernel.org>; Sun, 25 May 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748159905; cv=none; b=FvZiWQyIXBfdlKAs3bCpCu7Y7/QeRSVIAD0WD4rogr0WUsO6oOn+xj6mkDi0k6ukkss63G2uASuBT8G0Rj8FIoS0JG2lFbTlCagXjtmRrVDyRd6o4bjDSxsqyCVjx54ewv5Fxq4gwyC/UYRRt11VZm7u1A7wXrLaSiWuy8qcyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748159905; c=relaxed/simple;
	bh=f3j4XWibVHV4tRvZckwAtdzTdZVe7JCXa8Aund97Tw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okdOQTCZIF57JeZQC1cAI2cwcsChjH2dFzMMkMvMIl4gF8S3v+M/1MheCJQsI7KL94pn2uzDOqS8miSoCIzfeajmyznWf1+e4UDTp/jd1ziTr5UiOdng6YS0lUKpCcIRdme73XmsfTWtJIoRl39cNj95IqvskVyyORq3jsZP6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tCF96fdi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33677183so7232815ad.2
        for <linux-pci@vger.kernel.org>; Sun, 25 May 2025 00:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748159903; x=1748764703; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qnO1NuGahzG2mdNmPSvD3Tqb2hXBIfduG76mUpbTku8=;
        b=tCF96fdivfNMrORqpN/d1KfCd5M+1Wyt0W2UZwhmuZPhfiLyGmwiTYJW180TWbcpRq
         Q50uXGTbv+lpcascPGagrdXm/wjaLZOutsMqVpLgdMt6ZHw3WTYdzwJvko2u9lwUFJhW
         DRMIL4IIkd1pbDp4QFtpfvrm7cNiOErdUg8VFs91JYxwOmli/YdgNYZt4uTrYQ5a1ibu
         UBqnYaHYqPjgaZt2cm0WaCqB+tR88WiMIx4JsyHxgO+cFJgS6m7bUQw/oBefk7uUkNO0
         mZxGURpFaSLjWyEgyDv1HwC638hcs8avjTu1k5dfmCI9aKdTF6ewtsgELxIArtnCGqVd
         2pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748159903; x=1748764703;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnO1NuGahzG2mdNmPSvD3Tqb2hXBIfduG76mUpbTku8=;
        b=ESKm/lkGLtcNAGz4RNpIcdSEY3WJ6MRwWlsDiovh0HMM/stHsuWuDynPH+hduRMM0i
         OvEi12pOJ4ldLsXgYcAY4cPU6LcOJs4otq43Fk8vAAPi6d4FHB6PfmhYeBrE+okRLoit
         hy99WWm0vylFP9pKG4s0/vQzsyIYjCgTLISny6AJUIRoY/she7tVUl/4QNyr/GSDiMs5
         chGN9WH4wWukYmm+RruUwLXX7egO+z3A7r7LfjzRC+Mcbum4kD3soM+4RDjlDy2RLN2a
         2c4eA6cInVrFzUXpbrgPImEtdIoYmEEqjytrjcgLxzA3H2iRnO3HqjMpJrr9BwHDkJ4V
         SI4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9J2qAWEWOYuZ99uAJO2tvJPO2V1htz2DeHu3v1urk9UW4auMsA/AMVRRJD/10htwIlKiwb36S1DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdlWY2+tjqpfaKlIOtPw/5kMGEvtuMxULz0gkGoUYVdiNgr/W
	ieUKKfKvLVoi2UufRZVBcKOTOJztSrx5vj5nfUlioR+QsrDT6AR0JZDVd9morzr2/unlgcqXps5
	n5MQ=
X-Gm-Gg: ASbGncugnpffmXrkM/VywMCd3dur4L2anXVo0VGF4nlOGx9CdQomkmh2952BxKZoWbb
	4KxGTDMP25egFutKnwInPOq2/eikwRLGpqrNXXf4WAlBFK4/KeXJL6yUUultfaYOE1jV9kofSPo
	pXowrgsTmRKha64AWpWjHvBfLDljNFdziqvaLrzrvVvCALoxLOaoR5O/boESSvVz1NJ+Lmh0HTr
	xALG2uVvChP3q6BRon3WW4mbjbb81PtX8XN9RI32wX8GaAiO7j2qW0HjWAO8ixIT6wLfNeF0pzm
	NrOTJLuv2F817DTUH32iyndFoy7GIUDegQGChqs7yfpHVe4SaU/8WfPietG1qmk=
X-Google-Smtp-Source: AGHT+IEMRT41ZFTlA+yA9dc7yj6AJ8N+9zXv3PwdNNtc5ynVweV7/6bTw2xvTml3M2T3hjsotCoDwA==
X-Received: by 2002:a17:902:d2c1:b0:223:5a6e:b2c with SMTP id d9443c01a7336-23414f57f54mr86739865ad.17.1748159902787;
        Sun, 25 May 2025 00:58:22 -0700 (PDT)
Received: from thinkpad ([120.56.207.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2344797f610sm5331785ad.119.2025.05.25.00.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 00:58:22 -0700 (PDT)
Date: Sun, 25 May 2025 13:28:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cassel@kernel.org, wilfred.mallawa@wdc.com
Subject: Re: [PATCH 1/2] PCI: Save and restore root port config space in
 pcibios_reset_secondary_bus()
Message-ID: <qujhzxzysxm6keqcnjx5jvt5ggsoiiogy2kpv4cu5qo4dcfrvm@yonxobo7jrk7>
References: <20250524185304.26698-1-manivannan.sadhasivam@linaro.org>
 <20250524185304.26698-2-manivannan.sadhasivam@linaro.org>
 <aDLFG06J-kXnvckG@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aDLFG06J-kXnvckG@wunner.de>

On Sun, May 25, 2025 at 09:22:03AM +0200, Lukas Wunner wrote:
> On Sun, May 25, 2025 at 12:23:03AM +0530, Manivannan Sadhasivam wrote:
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4985,10 +4985,19 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> >  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> >  	int ret;
> >  
> > -	if (host->reset_slot) {
> > +	if (pci_is_root_bus(dev->bus) && host->reset_slot) {
> > +		/*
> > +		 * Save the config space of the root port before doing the
> > +		 * reset, since the state could be lost. The device state
> > +		 * should've been saved by the caller.
> > +		 */
> > +		pci_save_state(dev);
> >  		ret = host->reset_slot(host, dev);
> 
> Nit:  Capitalize terms as the PCIe Base Spec does, i.e. "Root Port".
> 

Ack.

> "The device state" is ambiguous as the Root Port is a device itself
> and even referred to by the "dev" variable.  I think what you mean
> is "The Endpoint state".
> 

Yes! Will fix them while applying, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

