Return-Path: <linux-pci+bounces-22956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19930A4F86F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 09:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616563A57A6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000E1624CF;
	Wed,  5 Mar 2025 08:07:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13FE2E3360;
	Wed,  5 Mar 2025 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162075; cv=none; b=dVM4HdJtxbNBM1JPBHxt/FKUBsyhqatoYSs+gGx5JdswQMrmlzXsee1UiO5tUp6ijdrMNPM5ywo/HHCPc+AgWn18pp0FKb/h9ZRT23v+j4p6rVt3WpjVpcZQx/2TbqfedGgNsIRnlF22fotm1oPAE2VRUEKekzoaT14BHxWd2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162075; c=relaxed/simple;
	bh=apu10s+fJZ911Ijxj7kIStbMqlzymKqe1ad5pAatUoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6itUcaGNQg6h7VpJvVfrYTqS/z4acJKp2iBEZPmATo8Wbl8KLD5tX4tKIRGE+iPOkVPKejLlfgVv7s18poiU7vyjMxvCyeYhhPAR85fRkurA18Qve42iSvLgbrw84YSpjim8DTSDugsMODIlWMEjxzh3e9DN/jNbii4G21q2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223594b3c6dso112415535ad.2;
        Wed, 05 Mar 2025 00:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162072; x=1741766872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsivklTW2AXV/DvWE4vPkKDoYBnAOF+SydcaTbdXRsE=;
        b=aJfX8Im4FMb7dmc5MonxPneWDTvYW/cvMMw/QWhgg4v068kw51IhuKcOV2hrKeCMFg
         a9KkeuUsMAsQhtupKofBSf3dFmyZPjVgROKX6Rc1Nq+trR/4fksbzz0Xor2dugqiNeSv
         xa9IHykvjTF1aRqFg6yHYas3JTwyNGSeer2xZe8TSbJNVk19DGBzWB7LUO0r1SUKRBED
         dJO9XjkcaGgzEPI+jsuOrT4JJEOm72ZgTyvCI3KCGTUT2zV3Po40T89dY3qfyxdNcTIN
         7rsZzmIczWG/4bllxobX7ES3EbAOcL56LWmQFWsl1Ht+YWBahXr3zEEnITfYIR0AzEKm
         Ywag==
X-Forwarded-Encrypted: i=1; AJvYcCWmUL8kbMgOSRqw0G2Ca0sVcNSkvUFKDl43wJz3pNgqydomMzEmGKMg//kiZaA/RCmPcipwsJtc9dJD@vger.kernel.org, AJvYcCWyIYKkJ8T2I9Ske/X4YDVd3llF4e7sSGtNbTv6zaMWZQ1DnaubfClasE8YPFhHBA/JrEZ9FCkV4iw632Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfV+wZMNDIe6lU7WrJhNi5VCIhuQeDkBJMWgHtzcpdVnpTPuqY
	GSSc1BgmOlau6J2DNMbp/CssI70GcejFAnUO2SqwkTjFVpuV6P+mr6wU3Md6EQw=
X-Gm-Gg: ASbGncuXniJFNuLR1i6k3iUHnAfLPFp7fQdJEAsASsZZmEi13vJy8NY/3SwXgTDn4oO
	mQ+FQtYyEPPd5QAkQpMoy0OF+27eYg7tAji2UIrDEv/N79lb8Aro1XfnOTgjFpWQwf/6c2pQgZm
	jonY4Sf6n6JPAiUfcaSQoIJGgVDD+CEUGYrXthnFq592Pg7xpfJXTW0jPgcrHHaGkCMd9Tq6rBe
	Y01FP3UAALWi+WO/55z1Y3Dkf6b5iW1+cN79FmjHyMzPh4XL5NZ6SsHCSsuNAgJ3TapsNTdLWdm
	DLGeb8yCI6jdjKe9Cp/qbX5v/V2cavTksJkZ4pQj6TZA5hAi0ieX0m6hvkNIVZLLkzrykV/aTQO
	W8MU=
X-Google-Smtp-Source: AGHT+IEGVdmdmbudgucIJ5Oa63AI2sZEMBdwoKYYxzedpSNOed5sO7wx/obuA734VhDurdZMT4+6fQ==
X-Received: by 2002:a05:6a00:3d14:b0:732:2484:e0ce with SMTP id d2e1a72fcca58-73682c89e09mr3232937b3a.17.1741162071997;
        Wed, 05 Mar 2025 00:07:51 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73590058fbcsm10092225b3a.13.2025.03.05.00.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:07:51 -0800 (PST)
Date: Wed, 5 Mar 2025 17:07:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Follow-up fix for BAR hardening
Message-ID: <20250305080749.GE847772@rocinante>
References: <20250305075354.118331-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305075354.118331-2-phasta@kernel.org>

Hello,

> Fixes a bug where variables were used before being initialized.
> 
> To be squashed into commit "PCI: Check BAR index for validity"

Squashed against the existing code on the branch.  Have a look:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=devres&id=ba10e5011d05f20bd71d3f765fd3a77f7577ff34

Thank you!

	Krzysztof

