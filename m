Return-Path: <linux-pci+bounces-13769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5398EFF6
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 15:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D1E1C20923
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54CE10A1E;
	Thu,  3 Oct 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnMh1dt0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A9195F28
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960735; cv=none; b=endsY1vKFdUfnsaLrTA9jndl9AvK5Csx+PliqruW6/hNelDGhJ8GcJVqqyi6CMXfhmX1tigRq1V4BgjZ4T48w7bkHR9txT9UhgOouJXgL0dquOiAFV2XXFHimcOPNbchSL9AQlGi/00OVdVgan4/SVXmFemtbNcsq3e/DvXXa+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960735; c=relaxed/simple;
	bh=ff8QEqXTuRl8aTrMgJSBItWahsqb0afKV2CvU1JI4jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMshgEDMNZpYTSHRlAIWE5R+E+oTvrWhs8EXuJ3l5CUxjw6OjdTO64l2YJ7Gz/DVi1r1xqIEbercB2bMvQzS24ogc570fFsliaZoFe0dWtXTCWRXu22vl+3r6QxcR0319/o5mMQ/baGfznWqoBxPWb2rpMfVtoQq0z1gMOJyw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnMh1dt0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-208cf673b8dso9349035ad.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Oct 2024 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727960733; x=1728565533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C6mHsvsjfcWSj072AS7/XMEU6UPY2wzfl4k2ip3bSrA=;
        b=vnMh1dt0J5l1+sYoAnMHEL7sI5e7Y3BMmLNnc8r28kBnnIkAbnu2lLtwslAceVJdBl
         ggjSlOqI1NNcd/qk9mu2dvpXGlIdbcJdvJyzlwESukINtzOncE98xcKeduDl63tihEke
         fhXY7Oka+ETKXaNB172un2CY2IW8O1ZswnhLepGZc4QMWW2PNzFjan493VXPKB2V5loZ
         bcpSuMmQP0Vg9j3bFcY7wTcbe5Z64vIngfKNFjzPLvIJ7SD0D0Kt4caJ9l5wrLhuMmNF
         spFpmqlpPP2UInBjOmLbhnEIJYCuAY2X/P+vxkd2mfUR/9a2SX5Z7uEdfjSa5Uqko9nZ
         Fwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727960733; x=1728565533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6mHsvsjfcWSj072AS7/XMEU6UPY2wzfl4k2ip3bSrA=;
        b=nj3XSAxX79sKx8w69AS4u7PdFRK5KDFxtcnNf5JBAa2zFPZvhH8uLauBmzmnfRAqIf
         qhn091XX5ekmnkCPTSYZ5hnkvO/76DdXzI/yEGc8FO5Nci/+l2NRHKpTgSqFz3Kcm3K2
         rR1lVlV5gi91kYfsM1ZRUvPW/nHsuNeWvPWaw0tELUP3oi+9DUIuiYFBab8xmcAf3wSS
         540+j/So0dbxRrAgxHZN8oo4I1WvKl+i1XtxQ5WBBTgR2CNutHlKfeiRcSPLbuTWLvmM
         ebz7g8T3ZhcP8WnIdscud8PpRNYfGt9A6mbVq4jbOfN9UL1s1cFcmZM6mu3JqW9Ctcwq
         Os1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH40ivxYVmPpCGDvgYfDqOe0Z58wWkIgeSuKJJUoaAzXum9cwAxI9pIB0DAF6gdH8NdD9iTidWAqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvLWYmkOjDP8ON6wFUfVu2b+1M+Wi4BZGxd7HhezSNheOvxLiD
	uDp5dqpxAiwsFP7YsAJzdwjh+ckraDa55zzHRi8d7rNAUXnLokTKjc784hTyLw==
X-Google-Smtp-Source: AGHT+IFiMNRJViHPU/DD+3RYl12CUB+RfeRO4cGjNA6v8ck4IRY0D+7/3WdYjPnjSKO3a+o1AHr45A==
X-Received: by 2002:a17:902:cec3:b0:20b:8341:d547 with SMTP id d9443c01a7336-20bc5a2553fmr108644835ad.26.1727960733199;
        Thu, 03 Oct 2024 06:05:33 -0700 (PDT)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefb3c71sm8495095ad.189.2024.10.03.06.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:05:32 -0700 (PDT)
Date: Thu, 3 Oct 2024 18:35:24 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <Zv6WlCuPNWRZ1Rpg@google.com>
References: <20241002181223.GA231923@bhelgaas>
 <20241002200926.GA268053@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002200926.GA268053@bhelgaas>

On Wed, Oct 02, 2024 at 03:09:26PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 02, 2024 at 01:12:23PM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 01, 2024 at 07:05:18PM +0530, Ajay Agarwal wrote:
> > > The current sequence in the driver for L1ss update is as follows.
> > > 
> > > Disable L1ss
> > > Disable L1
> > > Enable L1ss as required
> > > Enable L1 if required
> > > 
> > > PCIe spec r6.2, section 5.5.4, recommends that setting either
> > > or both of the enable bits for ASPM L1 PM Substates must be done
> > > while ASPM L1 is disabled. My interpretation here is that
> > > clearing L1ss should also be done when L1 is disabled. Thereby,
> > > change the sequence as follows.
> > > 
> > > Disable L1
> > > Disable L1ss
> > > Enable L1ss as required
> > > Enable L1 if required
> > ...
> 
> > pcie_config_aspm_link() has a comment ("Spec 2.0 ...") about the
> > configuration order, but I'd like to update that, add a section
> > reference, and make sure we do the disable in the right order.
> 
> Found some language about this in the ASPM Control description in PCIe
> r6.2, sec 7.5.3.7, Link Control.
> 
Right. Added in the next version.

> Also in sec 7.9.9.3, Root Complex Link Control, although I don't think
> Linux has any support for this register.
Right. There is no support for this reg.

