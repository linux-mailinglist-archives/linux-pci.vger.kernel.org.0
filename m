Return-Path: <linux-pci+bounces-23294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EBBA58F45
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 10:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8B23AB44C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BA8224AEB;
	Mon, 10 Mar 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPzoClya"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5F2236EE
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598347; cv=none; b=fsRZKxnQkValwlj6mfbPQUmFwn4Clk8VlFkIZdvYCp3XyOYVWXvHikYeXMllwflTXXLR2c96FTESKb33q1Y1PY0TwwYJ9w1gMPYG2kyVXCSnV3rWd9V8hZrqk7vbQFLj2Y/6Q9T5DxyDK66Hb10vz88cP04lLg+J8v25BSSmF8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598347; c=relaxed/simple;
	bh=Q4ov0hqhUBU6/dtze0mAP4Jt+xCZxf/vXDOLoky+mE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ali631hZ6tndh+uTuZEwXCE5Ld8otTDsJs2v/xjjZaDMB5ngCry/625FOdKzR/EmM4TpeAmQ9xswiAGIQ2pTett6Fojpf7zCDD3DbMl5DAzZXzpEAliSheIihfCCpiUxNjd8eK4cRdEGoAGt62HH5McQ/Myfax9yEIEIjVRYnG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TPzoClya; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso9350395e9.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 02:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741598343; x=1742203143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gw9uo2UGV9pXBzzfPEqR3Z6FkjVJEPW0TDCmW3LQ7xc=;
        b=TPzoClyajS6hXlf32MYI5h+ftnUqG0LxaOSVo7FfMrz3rbxecJMzZjQgRaPw6E9COa
         ne7sajSbdAGBaWpuKKgi3q758bvJot4joTeWv9a73sJFiOthvlPOw2Vei6O6dTMHFB5U
         Rz+X9waUFXOMySNc6L5AYVGFJUuo4qqUbIt4hWTc6xw17Saeo5R07XM/O8tJuklUGmkW
         PDX+IUwpMfxVv4613RNjj3X84EmlJC/GBBQnmkFPTLiV3K4GPs2NbzC/YFlN4MJhThZk
         0/wryOmeBKvhD6wmq/6dnEjg7EC8tUTEBY/Liy5/8zSpYh2BwaNIHchbzdOXxka87Izv
         zlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598343; x=1742203143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw9uo2UGV9pXBzzfPEqR3Z6FkjVJEPW0TDCmW3LQ7xc=;
        b=v+tfkuBOnvpoZlpNPJ+77enefdgySRBFo/HAAJ0d99teyXqwDMtfH59fv8SdLcM9ah
         3lBMRt17N7uVrY1swgG0TbyaaULn7JkjtA7RomOI+hmjIWtUo+MI0/i+y60Kw4bTZdIQ
         HzTE/40SgOqOyKTsDH+bWfHUVXy9bIjtWAzXucjf0EEMMLJyfZxbBuCgGeNfsIjMF1k1
         n4ZTvx3Ihz3bAT24PS/ePSqTDnTx94vGepm2rvthLQUhl41fX5YXeFfZcikMbrR1i9MU
         jrv2qtkQq2Yegqv3uD7c7XAi/9sXHH9M0ffIYCYh1mi9wPHH0K2ilz3iv690WSYL/BNb
         4Rpg==
X-Forwarded-Encrypted: i=1; AJvYcCXCnbaScYoeB0WadyTL5+eUd5NqMutwUgztOPeB6Mc5HOXz/R1cUi1nF1cl96p5roQCcBOlpAX6tnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MpiQpa9Cu9l/5t2C3CldThDl+ERIcSfiyTCSt09ZKpzeeoWb
	+zY40di6gkHaA1+8l0H1vMj0DWMelvMILYLT2ne1meGq/KsPDXDbH8oMF66C+FU4S4fXH/UGzHO
	j
X-Gm-Gg: ASbGnctv3mjzDDyh9EM+SNkm5zwN1DQBnIf5bTgDPqC7dl5T23tuBmg7lgGu4cBtQ51
	irNbMB48vglt/KcaBOpjRJ9N4+ZsIZbh6nTEubwxtTBSDf7qbhXzNibO25l57elYCQTX5aln5+s
	RDedsj7RWR+tvJk9PSxpWHUbkCsahXcc0i1WCMHmPu2TFXFhT1u9xmddy/xMRAB0qy1T4PfJ80f
	53DojnaL5zBaV+6h6tKiRYhTUmh9MjearIA3smAJMEFhWly6TXpyW3oL3aOEyeeM8gPAkElfzbF
	eXJ44ehRb5wEKHafyz9yaTc/HLe4n0zTssJuVxKAvArD+yN9dQ==
X-Google-Smtp-Source: AGHT+IGnzybh4oz21D+ZjyNjJtY6PO4HIlJjUsb/iVcBoqaFbpdK7tNiMClRT+pvPsoRYvRVxf/63w==
X-Received: by 2002:a05:600c:35d0:b0:43c:fabf:9131 with SMTP id 5b1f17b1804b1-43cfabf93b7mr9902455e9.29.1741598343478;
        Mon, 10 Mar 2025 02:19:03 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43cfc02e8bfsm8732865e9.1.2025.03.10.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 02:19:02 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:18:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: phasta@kernel.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: Check BAR index for validity
Message-ID: <0eda35f7-51dc-4479-9d1d-65b930ed49f4@stanley.mountain>
References: <20250308210720.GA469242@bhelgaas>
 <809eab4e8563d12d2d1f26195cff32bde05c299d.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <809eab4e8563d12d2d1f26195cff32bde05c299d.camel@mailbox.org>

On Mon, Mar 10, 2025 at 08:54:54AM +0100, Philipp Stanner wrote:
> > > 
> > >     626                 return;
> > >     627 
> > >     628         legacy_iomap_table = (void __iomem
> > > **)pcim_iomap_table(pdev);
> > >     629         if (!legacy_iomap_table)
> > >     630                 return;
> > >     631 
> > > --> 632         legacy_iomap_table[bar] = NULL;
> > >                 ^^^^^^^^^^^^^^^^^^^^^^^
> > > Leading to a buffer overflow.
> 
> Leading to a *potential* buffer overflow.
> 

Smatch is doing cross function analysis in this case.  Smatch knows
that pcim_iounmap_regions() is fine but the bug is when this is
called from pcim_iomap_regions().

drivers/pci/devres.c | pcim_iounmap_regions | pcim_remove_bar_from_legacy_table | PARAM_VALUE | 1 | bar | 0-5
drivers/pci/devres.c |   pcim_iomap_regions | pcim_remove_bar_from_legacy_table | PARAM_VALUE | 1 | bar | 0-15

But, that raises a different question because you would expect
the map and unmap functions to loop over the same bars.

regards,
dan carpenter


