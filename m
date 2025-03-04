Return-Path: <linux-pci+bounces-22805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1AA4D406
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62154188DEAC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D125B1F4E47;
	Tue,  4 Mar 2025 06:44:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190B1487DD;
	Tue,  4 Mar 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070697; cv=none; b=OVC9WT23w9vxiZG4E3FBXgWeCuEuygE6Os4qDP3dfmwbV+SX5bUPzoOmYA519j8GXRuoQVF3I7u52BwK8aA6XqjPR9/GMNKeRO5Rk6oZMRx7oVR1Q8O3v420DpyR7G6ktAuhYt1HmSbSUlsheIlhnhOOC+5Fqj2kScrOfXPTwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070697; c=relaxed/simple;
	bh=CKmhCwChjYX0WnRaI3mh9Oz+ZEy7hRLTy56Sg3qI4g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK2LYi95FZJJShRDrkTa2qeSRni4GLRKZ8QtSQsqO27ZorfTdN5IDIp4EirEnJgQd5Nepk2HE9wCD66TdMuYBTz0PL4zBu+KOhCmtVkGiVBgpxixB3SoENhTnO3tgWv+3u74LQsDHzCyu2v2nnDE+CiLU2zHXjFfi2F4zqKMM78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22385253e2bso62616665ad.1;
        Mon, 03 Mar 2025 22:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070695; x=1741675495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/NqaLvRye4Cq0LyeXwhNE1kNW2vwV2kBs1us3jXtWU=;
        b=AregjSHUBSdQhpCnuq3ZuDB4O/SjcRKP79vdvECPgLA4X1ZNoqKVqhF6Jdj7QhMajO
         FwXZHT3NDpBqBwNWPkrNYh2vjrnWzBcufLtUa/sKPP9NA12xuqe/YinqcJwVcPPuAJH6
         fkchhEbSRdhyY2+kebAX8Ri+AgLAHgFkRr0Oa8wVRZlg7SDYU7D6iTnKuq32MUEvroa4
         YNPoPqlyDPXdiPdX2ra6SclxskEpLkNx5oW9Px2WoZE3f5yi2+g36YrTwa8SSdkkAFZB
         mPwqOySilbN+iRet2/LKcpvMsfXcHCoEA6e8mdYdKW8LGKTy4hDoEomQzAimfPxTWUNT
         DN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsu6bxSE+Mh3DhBBx48x2eGpUqh40ngWf2sscL9c5RFVDwvZI+ZbTJzdAuGS1VXEx4Xo6gbm8HOFaGm/wlhaMq+A==@vger.kernel.org, AJvYcCV/o11uGUnPwZO5LFYwHKVK7hTBMnNkmFO7Hq6rFQw93vkop7+hTv/fwSNF1g0E0mebSJlamD06SDcFsTs=@vger.kernel.org, AJvYcCX4Fi0sh+L6185YNiY3d1flocZ9CRoMYbdgBbK1iuDwedYeI+sWzFULp5zrc5cZPKlhE06DrU3IUMAE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx1z8xRAiFIsl62PhDicGS4yojm9jR+Z8YnwP+1qRvDyudjbV8
	1E/cZf/1S1GF5wtsjyE7n7B0PvE4lpqPYVP4EA/aYqoK5ywQbbR9
X-Gm-Gg: ASbGnct7h6kvb5sb7s+ymiKMJ3UsFHBcsP2hLiPZ9e8Lq+3yl/sj4nPEceT8GW3J5ow
	SAY9eawHNEfjg4dnLpwJN+AGL70wbx3neKRLweT2lzJHNr9azfB+aNk3lOD6KV9ELc4qhmDM8MA
	gc/Q4JLhs0kkjwZt4Jekj9ltJqRery5uG8pfXVwIpTV9qkFIGyuCehcxfMZi8KT6mK6WrpxVu1A
	AuuirwcsWmgDQ3maeZQTSkQVPXpzHzpsWiSX8DPB00RLIcCdb2EW9Dqf12QycCQ+0rA887O1jdc
	1bxkF0BOBE1AF/P/gKUkekisG+nCAgA4rFJQ3mFBNqUf/6AerBFtz0t6p2xqiiPo+RtrnAxXqly
	gf3w=
X-Google-Smtp-Source: AGHT+IHubZ3OFPwp+4oYsLj435L9jVCvESdk0kEc9gOPZuvwk4jvcIWYRz8EL7NQ2ybDdZ4+kOA+fA==
X-Received: by 2002:a17:903:244d:b0:216:69ca:770b with SMTP id d9443c01a7336-22368f73bbcmr222052325ad.12.1741070695120;
        Mon, 03 Mar 2025 22:44:55 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c5cc6sm88516415ad.112.2025.03.03.22.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:44:54 -0800 (PST)
Date: Tue, 4 Mar 2025 15:44:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Fan Ni <nifan.cxl@gmail.com>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250304064452.GA2615015@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
 <Z8XrYxP_pZr6tFU8@debian>
 <20250303194647.GC1552306@rocinante>
 <Z8YWILtSbQnvVqbF@debian>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8YWILtSbQnvVqbF@debian>

Hello,

[...]
> > > What will happen if ret != 0? still return 0? 
> > 
> > Given that callers of dwc_pcie_debugfs_init() check for errors,
> > this probably should correctly bubble up any failure coming from
> > dwc_pcie_rasdes_debugfs_init().
> > 
> > I made updates to the code directly on the current branch, have a look:
> > 
> >   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=1ff54f4cbaed9ec6994844967c36cf7ada4cbe5e
> > 
> > Let me know if this is OK with you.
> 
> It looks good to me.
> 
> Feel free to add,
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Will do.  Thank you.

	Krzysztof

