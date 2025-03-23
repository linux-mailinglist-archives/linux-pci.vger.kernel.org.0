Return-Path: <linux-pci+bounces-24460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E0CA6CF59
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 13:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084413A96BF
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD9D5CB8;
	Sun, 23 Mar 2025 12:51:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8E8D51C;
	Sun, 23 Mar 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742734265; cv=none; b=T9s4KTo4YXq0hMBjp3+50HswF793yWaOP+siNH91RKX/1uD1kR/XvLcXzNC5Z/bz+C+FwMLmoNUrIkRpD0QgcNRhl2ppkon+ijgWDiND8feLKBeIsNZYvpZ228mpAN6RMBowLdw2Ikv11jNxlx1vscK/rgJkuQMKCvHPqbKhMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742734265; c=relaxed/simple;
	bh=BhF8gcfapWyM4aGiOj/iWMLe48MJ73X2c6jX8fS/T2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cb0VjQ2I3BcK8+naWirsQi6zRwoy2e4ZxyL+2sCI8CogJ9pcVi8utRfC2vHBkud/IlBnn011tFDZ7XR5vz1wDh19ono7MZnHnNK8kYeg8ZiuEbfKB7VZxaWqNwVsrj5/URHnTJT+OGngKC79Ka/rEkJjUIshtF+LAZcVaTYFKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22548a28d0cso55156075ad.3;
        Sun, 23 Mar 2025 05:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742734263; x=1743339063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swiakFE0BnbY2gdpf+4Mq3owvw/sqrogLFaAdc3fltg=;
        b=gbSfx/ObMkmRqKQGmStIj8jL3kd1tjxgcvbYBeh00Fwpl2UFaMrb4rpxfpnV3p3B8T
         HJLcADSXWUcKcvUKRT6JfYzlqM6wFq4pj/u8XwjEPpyy77U0opHcXT1MIJJXWrP5IbSf
         8p97Dah6sfe/6oT7nUayLFvzbc/5BGMiwAjJIwChCs2xBfmhK4Bs4Jp9oB0MyxNhqc29
         vEyX9MiL7Qd9WCdSWYsCEWgIZ4+HB7b4hqR8ftnx7DitNXpEt5mJyiLsXxsf3OE47obX
         RGmgYua6k/kJVxzi1ot2Ht0ZscV7Ty0ejxgT6Re/dpUqt4U7Sf50rpFaOVeFQuuelJlb
         UQLA==
X-Forwarded-Encrypted: i=1; AJvYcCUzJxF0lqUumBqCnGKrCYWiLuCMxSSNVlGItfHhKhr/uHJ+bErsMD7XAlc08ANaposJBvAmLSAsK8KJ@vger.kernel.org, AJvYcCVPujmCtFbiLnxjowp9wappcpB3U9oVBoEoHLXaWQLAIVLc7TSBK5p+jpl67azNXyDL2OaXEKBm8eLGc/Xv@vger.kernel.org, AJvYcCWv2yYoHytrk4virGYEdZVK0en9/YdyHV3FUfiiyMTLQ62c7EZJHuIob2x0j3EfKfXFz4kcdsrEGuc2@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSdXhAqavRnivKx3ImeJSiLrmTAr5hQWm5z5YuLT3wcEbr0eY
	46aX0OUqKKPgA2hIdADJa5fTiZQBrue1CINR9FMkOkfWlZ4R3ETgfZv19nocaSU=
X-Gm-Gg: ASbGncv0yTkrOAp04Pt5JLniOj47tm+XJ4d8CkLtXXsiBh+hg8CwftAYecZucL6Uv6l
	xAMADg6tj3E7F7tThWaK1OkiYosiiTVHP3UB0aI0LrOOH0f6bqqpRCs2PAaQB8w0DJ+gWrNXM3T
	W3Vx346R8vk+foTz9AqIJndTVjNO4TBqqotxm1aTzrR3F2Zwsdk4i2a/iSWIp138kg/33s71pwg
	+dnJPyY4oToUSf4tq9J2ylH4ITEq4c0SojUyNaUEbH7t7Clt1BCdZNKZgu1jB+yJ3BgdL6RDbxq
	pADyLp83eGO0oyxaaVh6avGlobTEWXewlEj+pfwNQ+F6LV3V5x1+I914hSh//KLqP/V6wSz/4uP
	0Z/o=
X-Google-Smtp-Source: AGHT+IGtYS6hIcWqAZuSsZKMB4lCtvBiGtoQUPK7C7dOnn0+dCiK477pjuBz5dzjBas1XzjyQaQK4A==
X-Received: by 2002:a17:902:d2d1:b0:224:24d5:f20a with SMTP id d9443c01a7336-22780e231a1mr178479015ad.48.1742734263537;
        Sun, 23 Mar 2025 05:51:03 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811baf19sm51204155ad.149.2025.03.23.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 05:51:03 -0700 (PDT)
Date: Sun, 23 Mar 2025 21:51:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH] PCI: xilinx-cpm: Add cpm5_csr register mapping for
 CPM5_HOST1 variant
Message-ID: <20250323125101.GI1902347@rocinante>
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

The subject says "cpm5_csr" but here we say "cpm_csr", I think it's only
the latter?  Let me know, so I can update the branch correctly.  Maybe both
things are correct.  I am just double-checking.

Thank you!

	Krzysztof

