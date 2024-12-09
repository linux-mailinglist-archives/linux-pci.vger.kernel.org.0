Return-Path: <linux-pci+bounces-17948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F5D9E9934
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA16F1887C97
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744041B422E;
	Mon,  9 Dec 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMTluxto"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FE1B0430
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755415; cv=none; b=tHGI+Tb4HuQnbfGArYydwtF6gCrr+oFsqzrLAsrkXBN+OW5gwmjvI/DBjXiM51Eq05unyx7LS4wZKyiMNqH+n7cUheA1JmrVtQasd/Zy7WbVIv8A938lFXJeUhwYTMzC+hVtOEXAWK3eEgh+NAue+35xddt7QKfsJfOBxb5MAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755415; c=relaxed/simple;
	bh=3kpzFE999dM/LdU4l6E7NdZxHYnVLgDEogjvJDWyJLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAHHUFu+4GlDD/+c/lrsrpTEAG56+qwmqdY6qlPUMXi/afbtCOxheLoCNa6F4PjfW+EJ73zHjgo57cWMlshHFFTd3UHrcAzjmFdqZXtugSuN9ACu2n3/HTCNq03QYrfdqzyYYwh948PGxpRkQvgfEl/X6AIqt4FAvNwU+OIurnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VMTluxto; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-725dbdf380aso1274680b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733755413; x=1734360213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cPKil53zJMQTuGu7JP6g+ZjxO5tZnTK+oPeNDzMy0CM=;
        b=VMTluxtoqWjUeMZ1/12qw9zQDsmu096Nk3jQG4v8h7krPUZaDy2WLfOZyVfCPtFPth
         owMK91waSZr4l/zwrvDRv7G8k/YRDIyyGUF4Q0s9ElFfYcPlA7eNoVpoAWT/hSMj7CVM
         EoC+gl+/8VEuX9e5iHxGyhEgjAco0tTtDbN6ja8W8+ir2uNJOtFoQBgK4maUb+P3eUod
         Awwtx51BZRJGsJfKpQAsnRnlh/e1Ygxv7GF2ZwAmX9/VTh0frNb9Jao/ZyZOJUVbPS1W
         vJNh6rF/rxCfdOEwoXE+NZt9eFhQTVuDP31g3Vx+IrFEOei9Z2z3N1nvBF2GOJxYatvJ
         gSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733755413; x=1734360213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPKil53zJMQTuGu7JP6g+ZjxO5tZnTK+oPeNDzMy0CM=;
        b=PqEFI9ejfBuuMdvEsFZFv5Ny+WEeQQ3Qi+42wBTVgAjsS0mOiVhGEMdhh6bdFD5yvJ
         x9ji/E/49XRNDS6VafjZMtyeIcvTAhW9AJC0QPbNuYkPW02rhB7G2+7pEIiRJXuVLjF0
         27zlMATD4kR0Xt/ckP01/W+tdS/SaMxU25LPwbswYfLlGsGnOs2kHq6qFsFoIy0Tcy04
         G1+IbMs7wL/AavUijOPc1mzR+wsdGuWOjijKq6yf5w0oNCdW6FmGQPdSwe1vwXU8WDee
         5JA+84aL6uDzGvXggh5YgaXB7wgpDnFc5DQXLHUbsHYzN66U/eNrq6JVSRKwy+f3zKSy
         ufAg==
X-Forwarded-Encrypted: i=1; AJvYcCWpCwqlZO+pJevrrwkuRZ0Px8FHD5ZPPhVghRqx5kYE3bZwLPgTKOJ/gEqsLit1DBmSeGHj0PMMESk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu09B4Fuq2AIQ0ag9K8rfIxD18l+fm7G8QV5oHjH5Z5bNfNKik
	AL1WqqFH7ncJ5c/QTvsD1G/C8Agt7Jlah6NEufIVF8T+lMdEII5M+IfoqVcG5w==
X-Gm-Gg: ASbGncvChXlmf3uD6dU4KJWuUJ0qRyq7vwvxrH4iR77CNih+/n00QdiaeCZ1L1brGEm
	KpKVm4DIfjEDRJBBX3BofKoRCiPIbCspq7nu4Sq6zgdgRubK+7evUrjicCdqbqzV/h9LPXP9Ull
	2RMi1/F7jl+a1GIpdWXVQIOU1PDjPEtgUAZ/+iyjpIMu2xSqfmUlHyrSApAXjeIFrfSImQbrNy4
	fBPcb6379r2Vu+tBS2BZMbW5UBYHYrGQisOWPh38+f/ATUEbmL4pZ37iVWc
X-Google-Smtp-Source: AGHT+IFhDJY8qBSudpuC5SW1dvlmPLuMBxgm32mHRvomRt0QePig1p1TQxqzGAM1xjiCsccNrl5yhw==
X-Received: by 2002:a05:6a00:1990:b0:726:f7c9:7b1e with SMTP id d2e1a72fcca58-7273cb1adb0mr934437b3a.13.1733755413078;
        Mon, 09 Dec 2024 06:43:33 -0800 (PST)
Received: from thinkpad ([120.60.142.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7260adb61acsm1233305b3a.94.2024.12.09.06.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:43:32 -0800 (PST)
Date: Mon, 9 Dec 2024 20:13:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241209144314.ow2qgrhiwr23qw6g@thinkpad>
References: <20241205232900.GA3072557@bhelgaas>
 <20241206014934.GA3081609@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206014934.GA3081609@bhelgaas>

On Thu, Dec 05, 2024 at 07:49:34PM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 05, 2024 at 05:29:00PM -0600, Bjorn Helgaas wrote:
> > On Sat, Nov 23, 2024 at 02:31:13PM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Nov 22, 2024 at 04:20:50PM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > > > > PCI core allows users to configure the D3Cold state for each PCI
> > > > > device through the sysfs attribute
> > > > > '/sys/bus/pci/devices/.../d3cold_allowed'. This attribute sets
> > > > > the 'pci_dev:d3cold_allowed' flag and could be used by users to
> > > > > allow/disallow the PCI devices to enter D3Cold during system
> > > > > suspend.
> > ...
> 
> > > We did attempt to solve this problem in multiple ways, but the
> > > lesson learned was, kernel cannot decide the power mode without help
> > > from userspace. That's the reason I wanted to make use of this
> > > 'd3cold_allowed' sysfs attribute to allow userspace to override the
> > > D3Cold if it wants based on platform requirement.
> > 
> > It seems sub-optimal that this only works how you want if the user
> > intervenes.
> 
> Oops, I think I got this part backwards.  The patch uses PCI PM if
> d3cold_allowed is set, and it's set by default, so it does what you
> need for the Qualcomm platform *without* user intervention.
> 
> But I guess using the flag allows users in other situations to force
> use of NVMe power management by clearing d3cold_allowed via sysfs.
> Does that mean some unspecified other platforms might only work
> correctly with that user intervention?

The 'unspecified platforms' would be Android devices making use of NVMe, which
is not a reality now but a possibility in the future. But even when it happens,
it won't be a problem for Android as it has userspace knobs to control the power
state of the storage devices (as like how it controls UFS power states today).

UFS Reference:

'/sys/bus/platform/devices/*.ufs/spm_lvl' documented in:
Documentation/ABI/testing/sysfs-driver-ufs

- Mani

-- 
மணிவண்ணன் சதாசிவம்

