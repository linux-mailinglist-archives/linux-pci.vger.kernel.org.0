Return-Path: <linux-pci+bounces-40525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0678DC3CBE7
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 18:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C7F188519C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBB34D937;
	Thu,  6 Nov 2025 17:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="n3jgQyNj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2D32C327
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449110; cv=none; b=nRxVqrBETXPaqAp5GcKoDdu2AVZZOsCbN8BKvNZ2I99A1b7cfxrTzHKfXqLw5eVbi+FGF1xMljZDdYGRsH8J8JyWgJu9Ovw2FZJJxz2X1lToiRBXrsWrMX0TY8uRr/ol8MOiOFN+rv+QdUamRxFY7YIlFD6ExNhO4STKkQiP2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449110; c=relaxed/simple;
	bh=pBncupXbWkCVN1fOd+MWv1n3EGow7Y78ZsUbGG2oPVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMkbaklaMByiUxkiiUpEu2+jv1mXQwL7svPmgHoNchngy1CpLgozTNZrtcgvz630Rc5l5FP3qC5TqLH72n9WDf+RTZjBWyRt8gBVqtU16N8MlYrLiwYJJ/jT9m5PN5AYBZ2R5IcJZFm8hDOGvErvpNU6bQD0qcooqeSeJf4RDz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=n3jgQyNj; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7ea50f94045so21245216d6.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 09:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762449106; x=1763053906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKXFhe1XgNsEqIm7n3PyjdJL5U3TbOb6yB6jqMWUHW0=;
        b=n3jgQyNjKBrhEYmKfs/HF2geSjgYhKEq/bvuMz+VOrujjHOqwIquqimWN0g+HE9GkX
         g7dmaS/0I1VcZDwOhuzZ0E3s5jszR4aejv/zhci+5kjtZtUSDfgGLxTqvNV9wNtwkgJg
         6c9UswPNUOIZVbs3MFqSmpIuVfRf/GqLVnhfCIi8kEDITV4xJUZU/Gk8hyDWxDBQeb1Q
         TF3fuiUrV247AzlODSNdJnDB6KUl7bt75G73tPjEtWNk1CY+o+PSVjVPKoBBsusmYdKo
         5TsdrLz12KzkYH0lCQyZROfKzU44EOxioSd/znx5IlpYFdiuUNkIFgBdp0QuPvzYk12P
         omgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449106; x=1763053906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKXFhe1XgNsEqIm7n3PyjdJL5U3TbOb6yB6jqMWUHW0=;
        b=ItwB76605h6ijboRBLU0f7Q33NFzf6RWdVExSAtKqxvHGETuK5SdXV/gjOX5HPyCag
         V3ctfSvT9ReD2XwlEDEkSOJDdG8fleE/fkqRES6kJL8ZRaSaSWxX3cABD5ui64llSsAV
         AEgixHmyE4H7NbKHe0tSs9fyGmoJaRMtktf0KsZF1FBStBy4e1GiRg0nHS/Mve2Jq7A0
         lURjeu7QQuaDMgI8hGLJBQ14qrW8TzenkGM69nfl6L4h1Ade9kt9XlHNfDZ9gLlbS6m6
         L7VA8UDY2Vgl0VoYssrKviUV4HXJX2c26elTwR0K0GAhC7M3/em5foBgFHJzaLHbVSUc
         2/wg==
X-Forwarded-Encrypted: i=1; AJvYcCVryEBucxWF05M1/ugCgU6SmwREFlvHuOWJfI9ZHOEmvAsEpWPatTsI65WgTsB+r2JPBw321FutyGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUQx8VR7eECrm9wyqCnqkvOpQQ5h5vBGszsSVoTrvShVu/9YP
	EZUnn341AnAejyo5pB7aPYyZe+h8oNhzt327DQBKZKuZ/lIPuJi8pfZuvlmRSjutlow=
X-Gm-Gg: ASbGncvR13Zo6u0LWmGU7Q28XDuOuFXlFwRGTOEXZZ+T2Q46RtebrrSEmXbmMx7mu2V
	JWUl4wGiIVvF77DvVbp+qP1sj8tRZCowedb2xmwN5VQ5zJOyICpiEHRmQsnpMP/BHxrXswSXu2o
	KXR434TJxfmJ1ajPxGyp/oTNsuLCE0A1DBN5RqyhqBKKKTrowTNrHJ8+Q1TOPAQM4GVMm2JSTle
	USOBgI0zvRLi6te8BrRPldht1iZXpY3J83VJMAxTZqVOip7Lph956lAEwo8VREBor6cMmo+IItB
	ez+ODeVcL2sFqSty9SR+on/nR6dOAC/4WkF49v25ZhzyI5DC37dRfn/b3zayAPcbm/Qx4/yeO8U
	plmpOiGVfB5dzw5aeqmlLdtCzHcwqSActIUTF7rr29s7CvkvrGS1HJrFeH6kjgbCJ/6p1uUT2vE
	GthhtAP8JqnsaecRdtkHv2lJUhDivFEFmGYUqDRnEx+a8QZeyToS2tTVWmg6E=
X-Google-Smtp-Source: AGHT+IGtpHAhkhHyR6o5AHtiwz5cY+ehhjfBP8n5EpJqyPwP3g9GbLdMDu/RgBohpPPk3DUjCzmC2Q==
X-Received: by 2002:a05:6214:62e:b0:880:53a8:404d with SMTP id 6a1803df08f44-88082834ec4mr51601596d6.3.1762449106390;
        Thu, 06 Nov 2025 09:11:46 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829ca35csm22268686d6.35.2025.11.06.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:11:45 -0800 (PST)
Date: Thu, 6 Nov 2025 12:11:42 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
Message-ID: <aQzWzp4DdSqTj9Hc@gourry-fedora-PF4VCD3F>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
 <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>
 <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>

On Wed, Nov 05, 2025 at 05:26:01PM -0500, Gregory Price wrote:
> On Wed, Nov 05, 2025 at 02:03:31PM -0500, Gregory Price wrote:
> > On Wed, Nov 05, 2025 at 12:51:04PM -0500, Gregory Price wrote:
> > > 
> > > [    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
> > > [    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22
> > > 
> > > Probe order issue when CXL drivers are built-in maybe?
> > > 
> > 
> 
> moving it back but leaving the function seemed to work for me, i don't
> know what the implication of this is though (i.e. it's unclear to me
> why you moved it from point a to point b in the first place).
> 
> (only tested this on QEMU)

also tested on Zen5 systems and others.  Seems stable to me.

~Gregory

