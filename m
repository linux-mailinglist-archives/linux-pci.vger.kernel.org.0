Return-Path: <linux-pci+bounces-20938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8113A2CCB2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 20:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5048F16BFFA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB09198831;
	Fri,  7 Feb 2025 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gx+BIpAH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045818C930
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957198; cv=none; b=qUqPw4MPjnp0mmcMH7OSwWrkjI4K/nUl/njmW3lAmlz4+HqnHA0q/zjoFCB+kn0oEYfIEbR3EytwJwjh8SXBn/sVWGQTFjOG0Ib7QWer1zaPMMg/AVTmqU6JTScAvaBGJvwdORP4YpfnihY3di7EWukJ7F2m02yHf5PcGXmWAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957198; c=relaxed/simple;
	bh=s68IMjEbM4K+2/scksXJORrf7isnIwyyzdntKTO/ea0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQliKF6eCeqsl5T4I5IPx9rJ2PzfzbZy5AZuWMGUZYOq70uvoW2qz+keWlAYdkcaWG0dh6iPRAE8JAPRQLF4O11qTQsIMTZtuhzbbWNhicWKTkM2+TPIb48HXKeBfCr1gayoELmaAagvHMkaUb0+snnu9EDhnC5ONCBBB0hGaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gx+BIpAH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46c8474d8daso19051271cf.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 11:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738957194; x=1739561994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoCXaz7FZACGfE1FRe1gWStT7EUpURyoBtQiate1bg4=;
        b=gx+BIpAHAJvejz7jTsL32KD8GaArD9zgssrqvClGHnTpcGmwzeIEvI/SK5tYVIgPSO
         FHLV9/iGzu8w8SBqERyoHqaOycd5GzB+BXLxg1ZR2T82GtzsZdm5kJe/e4rerriMr+BW
         RD3o/T79ExaUPEYLzmj+t73FgYG15gg4+d8uETCdxvZUzsOmsvh32LzQDekNfsuHLem3
         6f92nu9gIy2AYBLF97k40PjxU8vkrL2pfOC4J8kgeRKRz9Foi4M1nCN5XkOM65p5SxMs
         x59ihCuep+bSoUYHZxaI/Z32G2BNFHFyIlV5qdDDz13LDomI4FYIq5wNcijCcZkTjsok
         JhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957194; x=1739561994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoCXaz7FZACGfE1FRe1gWStT7EUpURyoBtQiate1bg4=;
        b=sUjyLq4spMNgywEavo4WkxZUazSu3a9iIABUwzHBHFJ1V38WkseJY+Km/0dkrkoIia
         ybFPEf5vfIjY+CpFhl4m+grFZC3AY0z54YdYtX0TWZ4649SfOCNAUf2jOePugj2FeCZz
         0LGvOMwn9eImSJXZ3AAX2Ow40fBbYYPjnVHqrXAFB8zEjNCeLFFVaataPD1Kwc7Mgpbj
         6UaFg8qiDxYtkBbiDFtDQG1VCxdtsVw3Np0MdA4+EYM604YxxplOZW14eqjTuIE0yYSq
         hajaYt3HRefT0fKUAfSyIUE7EPoMtbYBVuqojvLgFZjGNoY/MiNBql/E02ojyKMsLOi4
         jweQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyM9lXHOJkmtFo39SwG3CJwfS+r51ePPkRHh9B/JKDx/TnPceRS4bfhhIy2dwRdPgLtzAIPhasJAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbr/XQ4YFSoaqxOAORwrcFxjhCz1b4S95234RpRaXKJcrb7WPF
	pPDX1AW5AChX45IY65GRxuzPr+E24E7Uer2qIkklVKb8sJJ6uYud+hOD7udLPJc=
X-Gm-Gg: ASbGncst/Y2t/QBiNu0soviTRq2z90jeYFLRLngx2wwUZ6OcoCJLF3gP3usWBjn1/kV
	I5FZG5g0eLyiNqEwCmC+eeyYLewKy0ziy+p6Sbv1mnUX/7UUHt4HLgok3lkKCUHadNDT8XkiGKX
	/kP8iWRK7HLF7hr7Ohf7JuIQNScG+cBeaiasG2pgiv7IJssnOWT+7xcp7Vqd621+zVWwfu4lPH8
	QVs86GijdbFdRKjQAg5QP/Ro8jKhRicFRfZt6cPQ+Sfs/wW+IF2D/BfZId/cGavFAdgBBoLQzXq
	ue4ihFgKKhopMvyJ8ItHMBiiYB3GK4G2yc6aN4HGvwPKs4CIeWi4z56xVSBaQFmxQ/9FoFDVHg=
	=
X-Google-Smtp-Source: AGHT+IFM4XYo7Sj0iZNNa5Y9RLAXbsSkxk7abPcbr2zA4DPL877A+xt+JaTMpBqXgKQnFgS8Cf3yJQ==
X-Received: by 2002:ac8:7f55:0:b0:46e:541b:c80e with SMTP id d75a77b69052e-471679ee853mr72470601cf.20.1738957193702;
        Fri, 07 Feb 2025 11:39:53 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492a856fsm20177991cf.28.2025.02.07.11.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:39:53 -0800 (PST)
Date: Fri, 7 Feb 2025 14:39:51 -0500
From: Gregory Price <gourry@gourry.net>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 08/16] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
Message-ID: <Z6Zhh9MVjee4dGr5@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-9-terry.bowman@amd.com>
 <Z6W2hFI7UsEslB3U@gourry-fedora-PF4VCD3F>
 <6749f386-4bd0-4395-9ad4-a9663fac9bc1@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6749f386-4bd0-4395-9ad4-a9663fac9bc1@amd.com>

On Fri, Feb 07, 2025 at 01:08:35PM -0600, Bowman, Terry wrote:
> 
> >> +
> >> +		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
> >> +		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
> > Mostly an observation - this kind of comparison seems to be coming up
> > more.  Wonder if an explicit set of APIs for these checks would be worth
> > it to clean up the 3 or 4 different comparison variants i've seen.
> >
> > Either way
> >
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> >
> > ~Gregory
> Do you recommend moving dev_is_cxl_pci() to pci library as is? Thanks for 'Reviewed-by:`. Terry

I'd have to go look around and see how much the PCI_EXP_TYPE items are
being used for comparison and how - I was just commenting internally on
this patch set.  If this set is the only place it's being used (so far)
then it's probably not worth extra work yet.

~Gregory

