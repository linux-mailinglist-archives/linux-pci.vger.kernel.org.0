Return-Path: <linux-pci+bounces-43831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8F4CE9409
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 10:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E74EA300EA2C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A55225BF13;
	Tue, 30 Dec 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV7uJWpQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1A10A1E
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087947; cv=none; b=l+zsuq6RY5XGgKrdogIC7m7key0PuDlYi6FGPkgERzKmaxUr+hK2sHaTlieCy+K/9UO+sPW/pe4079yYiRsOf2bOJ/imMYm5cjC75t9/33qmfM5MWwtHZ5BXt7qsvObyR0g0Dus/6kcgOEQ3UHf2WMXtkbsbagSwcCfzIs77tQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087947; c=relaxed/simple;
	bh=5+t1VR+8bEkPlG5HnO7JhjgFVDNxvRfB5AN8v38A5gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2UefXFVOjP3YaFvyt+hU8eHQuZ97G84jlw7m1ziUmrB+qbZw4wP6bdO/SxOAKERkD/CM9E77isjsv7miBXyUTWBburj9+zTft0tp3vrDeNS9lq1YhefAXqPaHhAaxv90wsoBLV9WwOWRzWED5e7u+fxuGLj+kSbz8mEjarvPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV7uJWpQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso121024885ad.3
        for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 01:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767087945; x=1767692745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8I94f5g+4BvkV/OT91Besy+nUclkwg5/qSM8dD/UW8=;
        b=EV7uJWpQuEBxccsanZcbVI5f9Aq/2o+9SnVRBmJvtUDPDbPE/82g15zfI8vntvAXsf
         k1YzKjJTLZdqkaoldFINnkoJIDMUeD5fbR7REuoGpqTiXpXCtIgrIgpAFnV7qszI/Fja
         INWXeFF6xEaMzpW4nLZi2Wsdb9GeUok8utzjhLSMH8QI2ZHAdcN9CeWtxAqTUlIHqyJ7
         JjU4ePsWCgWOh+f5dY79nUgLqkzCfKTpL6tPSmJ+/hNc87yNK+VMz2zzISjV4Rf9qgb6
         aZxVga+hiaKpN2PD63EJMTAhGPsrq5VZFasMlXcEg5zujMn9oxyYilNiwU7AJWnlmYfM
         IOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767087945; x=1767692745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8I94f5g+4BvkV/OT91Besy+nUclkwg5/qSM8dD/UW8=;
        b=iwgTc7FnHsMWiRBtc4bFGGvKc7iIv+nrlzlv6k2e66RR1SxXoSQLBPwACp5L7+mCuE
         0qcgy8p9XAZzsjPk+7CddPDymGqLbRHydkXSh+ORIz10M0AWH40UJ0kmg3wfj+09rXQP
         t4MpVx+Jfpt80VMyNJ2o4qQRNTW71BTBvKGTSPkl/vQBNJYZDr/8QxB8PUuPSQGG4w3/
         nBZdaLr2An6u1h1Uj6wp+19nad9hVGxr0U1wEXUcO9NdWZaOryjqDYPun4djw+bxGi2B
         33oO/gwZ+FxoigYmDBGJscTO05EyU+mmrexlin1WTBzpopwjjkEEyGo4kr2TjmeT+Nl+
         zA1g==
X-Forwarded-Encrypted: i=1; AJvYcCVeEJiBVxusmukd26XdKgmrYWNSCnVXc4F/nqKDCJEAZ4dDYkUNMKOt9WULhzfpfmgOxR+8JYvKzQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0WLc2UhMF1izXM4btwtga7ZfP2gefUvoJnUayCfpimaw2fUa
	uFfYYpjjX4gKtaBbA8rk6IfQ6jGaEHQJRE8wTHnW1rh1jDGWuVtU3JzL
X-Gm-Gg: AY/fxX7A7DVuE6k5DxyoGd3UDAdK0a9rfUXCnnyIELZx+Im+SH+xO9h6Qpx5XAefHom
	1SDV4wd3TzI9IHBYgMmNxZLAm/FotpwOE46EAo6emFFcYuyPI1jh2lPwSwHUIRELAqh36YlTHS1
	/NeCPoLgyQz1GG8JewEq9shCynAJSugIzUGueq04I53xWW1pGZW6Ocy76C3IXiy/sP5hagrtuaI
	/iFKEBdouGjpwuAwBAIzihAQz2zRElqffwBJQGDNG+Yjr3aHdKXRXcXejgOprMt0u6TT55Mp0I/
	OGdIn17hse5tD/7yTI4Ib5a7VDE0mkzqMM1AAOd4iKKkWPSAqwhnvF556DfrV4QI5kRPOW2IJtf
	XMAiHY42mkwOoHhO93RRZRgu7j4j7N2zKUG9unlu7BZaHLSzKfawErlAeyYD7GAJoe80K3XQknb
	sgYac8MTx0DpNrd67Z/Zgr
X-Google-Smtp-Source: AGHT+IE85Y4rp7SUKHMI2JAjXBFbWm19WRLI6qKg3u9wvrJS/1dFWPxb2nULIjwZhZNf6ZdMmnqGWQ==
X-Received: by 2002:a05:7022:6722:b0:119:e56b:c73d with SMTP id a92af1059eb24-121722a761amr31279749c88.2.1767087945116;
        Tue, 30 Dec 2025 01:45:45 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm125580754c88.4.2025.12.30.01.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 01:45:44 -0800 (PST)
Date: Tue, 30 Dec 2025 17:45:39 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Han Gao <rabenda.cn@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2042/2044 PCIe
 Root Ports
Message-ID: <aVOfBNP3vy4Q52bZ@inochi.infowork>
References: <20251225100530.1301625-1-inochiama@gmail.com>
 <20251226163031.GA4128882@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226163031.GA4128882@bhelgaas>

On Fri, Dec 26, 2025 at 10:30:31AM -0600, Bjorn Helgaas wrote:
> On Thu, Dec 25, 2025 at 06:05:27PM +0800, Inochi Amaoto wrote:
> > Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> > states for devicetree platforms") force enable ASPM on all device tree
> > platform, the SG2042/SG2044 PCIe Root Ports breaks as it advertises L0s
> > and L1 capabilities without supporting it.
> > 
> > Override the L0s and L1 Support advertised in Link Capabilities by the
> > SG2042/SG2044 Root Ports so we don't try to enable those states.
> > 
> > Inochi Amaoto (2):
> >   PCI/ASPM: Avoid L0s and L1 on Sophgo 2042 PCIe [1f1c:2042] Root Ports
> >   PCI/ASPM: Avoid L0s and L1 on Sophgo 2044 PCIe [1f1c:2044] Root Ports
> > 
> >  drivers/pci/quirks.c    | 2 ++
> >  include/linux/pci_ids.h | 2 ++
> >  2 files changed, 4 insertions(+)
> 
> 1) Can somebody at Sophgo confirm that this is a hardware erratum?  I
> just want to make rule out some kind of OS bug in configuring L0s/L1.
> 

Hi Bjorn,

I have asked for the Sophgo staff, and they already confirmed this 
hardware errata.

Regards,
Inochi

