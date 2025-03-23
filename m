Return-Path: <linux-pci+bounces-24459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB69A6CF52
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 13:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8270164CF6
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A05CB8;
	Sun, 23 Mar 2025 12:48:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B938F53AC;
	Sun, 23 Mar 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742734116; cv=none; b=sJ17vJqI8eOa6Ms8pwQ+KR/lsU5RJsWEQkkUpIkUYCnrh2cCafe5qmPAf33+DiSH2MBG9bIzAxid8UYJjjw5OOE7LDfeiq5Jml9Q/p6REmvvYYWxCNj8n40NYs/Ct8PFccOVP06WJoFFg+2nUZFx28Rz8aJpA5DBPzCtCWXKiyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742734116; c=relaxed/simple;
	bh=a0+qoeuda5zWh+pfVnoTAYbgPlSDuaArlLMLULtYw8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R64bbLRPvo0WRpKE1pPlksmyQBQ5Icofqa2W6t1bp74ct0JzAysmxUByaYh8trHhM2GIv7iuuLmP+jTCQjdx5lNm1DRAlwHk2lZ2hg+rV/H0wxWKZkMu284dGlfnD/ttSWdVBAoIYV07M0O88BlJj85my3DmvuDi8ds1iyBwlGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223a7065ff8so51777525ad.0;
        Sun, 23 Mar 2025 05:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742734114; x=1743338914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ15ZWfXGGDPkVxu1GG0aJdwP2EX3/6tO0+vE/fdnZA=;
        b=pIturziCddlUf/k1bZVAhrSlYs+0lzL6lfPgv6XCrVDSQeVrhgvM3a5weo8kbZOPga
         EeAEUjImBG0n7VaBnsy2BPENhB/C3+w670Qgn5qRD+Cf5iXt+HxyH46MGT6RMO8nit+K
         +gJQMlGrGNbhJqyCSelKYN0TQ0IM3xKPsJk7ErMlAl6k2LaPMORRRjoxovW0fbWYL0Q7
         6AGSjHz+oPxmDrEGwwk2Bj/jXjRyFRRN5v/hn6GNau3epndZ8FMQXrmi4P//wFUTK1HR
         vMKzCtjvWaYjUQeAMCn+GN/9ofQnu8o/9wbkjGerjwNwr6TViA/Zolq1+MuJQTU5Q3LP
         4PPw==
X-Forwarded-Encrypted: i=1; AJvYcCUUbAMEZQ/3wfOqQP2zp04f+1EedHVo0IDFKLezb9QL0+40JnuzV4gjhtf0AyorwEha+VUFoXJEjoQkD39O@vger.kernel.org, AJvYcCWZ5gHbtd4CxlN1qp0mU4qoqDNeFF6p6ht0vTl6VHBSLS5LU3i0t+jqqzFDQ3qZuwtbNdr1Zmwrm1ty@vger.kernel.org, AJvYcCWdKxMBgZ+OAs1ykEXPbvp45lTj1mOrzR4aFXvZroW7DDbGXDBPtYoJKgXB3U4vtfIQfMUEhzDn07av@vger.kernel.org
X-Gm-Message-State: AOJu0YwkSokabrzFiDGDhhNvoTo6HRLLHJuMwhNQevTdgoLWfWguPQdf
	PYMpwvLYVJUkn5FfBgkEwavo+3UC0PnH1wmcS4TG7HnPaarWj/pSWb3GNDNqHGg=
X-Gm-Gg: ASbGncvPSA2azSIYu/k3pIZFBlGGFABRcfW6Ak1qA+PhuQ8ffFygeTps0sd1I1vc0hx
	WuLCPQwaBq9SVywmnL93FXSFmFN7Q3SDt+gYddUJ+gfIoDKMoG3Pf0eSr94N2F5/Mow1tyAUb5o
	Ydk9WMK6/dtcudedLR1H+kwDHrMViUnuZG/z6TfBWXHRrt4E8Ib7rQPEcSQBHC87rst/s5t2gOD
	gulF/bln2txf5lG73VGy0yVimUyN7vx0g++f9iKWhP0onKrCVcJVZ798WKMjcx1QDn09Ut/M0Zz
	rnlUotWYEtT+/1UrLwyFq+EVbmfV/OoyU8CMC4RsFORqb9TqskksRr/RshjU6ig0RWdCbCWJSQO
	96eo=
X-Google-Smtp-Source: AGHT+IGkUtLp2+sVTWOMcJHU+9Aw7k1CDOu9D1e9BoEYoKWrT/2KRSTvblidpiTG4s6erRJ0MZrx2g==
X-Received: by 2002:a17:902:f68d:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-22780dae2bfmr130638025ad.26.1742734113941;
        Sun, 23 Mar 2025 05:48:33 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811da97esm50660125ad.192.2025.03.23.05.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 05:48:33 -0700 (PDT)
Date: Sun, 23 Mar 2025 21:48:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH] PCI: xilinx-cpm: Add cpm5_csr register mapping for
 CPM5_HOST1 variant
Message-ID: <20250323124832.GH1902347@rocinante>
References: <20250317124136.1317723-1-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317124136.1317723-1-thippeswamy.havalige@amd.com>

Hello,

> This commit updates the CPM5 variant check to include CPM5_HOST1.
> Previously, only CPM5 was considered when mapping the "cpm_csr" register.
> 
> With this change, CPM5_HOST1 is also supported, ensuring proper resource
> mapping for this variant.

Applied to controller/xilinx-cpm, thank you!

	Krzysztof

