Return-Path: <linux-pci+bounces-10041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3992CA35
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 07:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B587428198A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F09B24A08;
	Wed, 10 Jul 2024 05:43:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065D3C39;
	Wed, 10 Jul 2024 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590207; cv=none; b=kneGuPqUnGueSBp+Cfl8N6dpP+sI3aFNzEXV0XWJHz/ssVG4ShHMKp+x3Q45umj/vk3oTnL72jy5oWd3MoQqQB29Xlbe+vz3Hbg9j/p8qi8FK0o836YP1EEyePrcXcv4hfWJnM8MnFnRDUdB1c/J2PNXLxGVS8FUJ7bjJYjtIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590207; c=relaxed/simple;
	bh=5dh2BM5kmusIF/emCATu6OKJF3a52TlVjNE7020QT0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI2l0ihBTf5B95rR9fnG4+T6mqBJJMk0vRNZd46BM5WjvxgnYGwRSSgTV3J8Ca65XoPz1tDJaVq+cwxxcd+XhsfXjicwJcKvdr2hlS8cjOyiQx3uM3RIltLuG+NLmuZsFAYMXAjBAnqxJGOmIH9hWDfLqIYjCsJAUvlYYHmNGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb0d88fd25so3025965ad.0;
        Tue, 09 Jul 2024 22:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720590205; x=1721195005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG2UsJ19/k/VCkkO2JedqMRmNYp6nm/WZ7sVX+CbtOw=;
        b=aoj+fDfIkMsn7e0BvNTzcSgzG3HCS2++9PeDGgzuaqruqoNF1rPk4ltfOzx3AWOB7C
         tMWhPQYF+kHMps6uXWupLGcUldU/YgdCkqhWlBNBq2sjjEV0gp61bnMp84aGKBjIvvSi
         7Ml3Mv1rdg+1fydafBKTp85jkGClc8y77JMHRqdiOS6oosJBfrneEvizhWnHG0MdWQSV
         TPOaZhIm1iF/9dZFo1j0rRAkC3/kuXXRe4rHB1kYzEmIqjgcNmO9jZsINe+wQty/Yk0m
         iRL2B5wjX06ls+n33l2xksKTmfL4l1Agcyc/MrLWJVy4f98ZWC6Oc2AGHxtfn62AqJjJ
         izPg==
X-Forwarded-Encrypted: i=1; AJvYcCUXjYkVdqdqcYffaOi63xf94RujYObB3D0u1ZjcA36k/u4DOl6F3KsA7YW5cWNZm8GSin6frHqviEs44lTi0Pw2HeY9O6gvvxO/8iYrGcpjjFarKhoBaOZpACgbF7i8VET3DW/tsBwgFtPPacMh9wYxsklDg4oIjgohnlx2ya/RUHJhv0/0Tw==
X-Gm-Message-State: AOJu0YyZDDswbbzb/hVyJTsc7AAqb8J6EDxyelvwT0X2rZNYfTXC/0Z+
	/mMoaJ4jCzC3DRRHpsLu8bR8g4UpEQkdMQ0d0FlCXz+gdwCbn0OnwczrEnURrCw=
X-Google-Smtp-Source: AGHT+IFe/bQ14uIzohPNP8ZGjEv1nOW827IvMmY9fB+n2PcsmRtGUNgfl4Zi3BEYozS4OnDo5N563w==
X-Received: by 2002:a17:902:ec87:b0:1fa:2b11:657d with SMTP id d9443c01a7336-1fbb7fbe431mr66342375ad.10.1720590205188;
        Tue, 09 Jul 2024 22:43:25 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6c48sm25166755ad.152.2024.07.09.22.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 22:43:24 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:43:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: dan.carpenter@linaro.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org
Subject: Re: [PATCH 2/3] PCI: qcom: Prevent potential error pointer
 dereference
Message-ID: <20240710054322.GA3763187@rocinante>
References: <20240708180539.1447307-1-dan.carpenter@linaro.org>
 <20240708180539.1447307-3-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708180539.1447307-3-dan.carpenter@linaro.org>

Hello,

[...]
> > Only call dev_pm_opp_put() if dev_pm_opp_find_freq_exact() succeeds.
> > Otherwise it leads to an error pointer dereference.
> > 
> > Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> 
> Applied this patch ontop of linux-next tag, next-20240709.
> 
> Booted fine on dragonboard-845c HW.

Thank you for testing!

I took the liberty and added your Tested-by: tag to the relevant commits
on our controller/qcom branch.

	Krzysztof

