Return-Path: <linux-pci+bounces-22923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DAEA4F1AF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 00:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C8216DD5B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A72120AF69;
	Tue,  4 Mar 2025 23:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mT5CTYi/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1AF1EBA1C
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131783; cv=none; b=DfvC6b49LkX32her4++yFDqFzx5s1W5c6HOexbOtXpSYWh8AMyRbYjCjHSLkD/3yKsQKpLljdWX9e7nR2d9bCYbkMz9pRDhRpxYSeeYM+pcxRl/y8LVDpKIxY4JKkMG0aqkEyuJLjnmyL9tww54At7v3vBuQ+Ekw81eIi+RldfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131783; c=relaxed/simple;
	bh=PGljKmEC+rYlkoiNEcNP4+ysPRRNXcQQ0SWc7Zb3v2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK/clLxw/lyyYgxLRJLH0HtikybbLRGv3Gif1cewO66OZpNzwcv+yBMXc4O6ua93it9aY4mqyxcbDKKjrLu5n3gVAB0ksIOd8qMdPY3CrQsRbHO5UzrQJyc9OQ/LKRqM5sPsaFGkSwF58ETxEvDZ68m3GI4xsIpx6Ij6DwR4VrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mT5CTYi/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abf538f7be0so606487566b.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 15:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741131779; x=1741736579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W4txxMC+w7P+Pl/NtO19DerwN/cnYbZloqtqs+zb3k=;
        b=mT5CTYi/Es2c+fJ7SUUThUpc15yF6JfxWVKu896Tb0VTsTe2PDonEz1Wik1kYoqtz0
         0R/4uf4Sv5bvWYMp8QOxaqehdWA7ejEsQgVAvQHgz49eVybgX0XIuagP4lBrJT/30Vyv
         8Ik4prHHbQ5NY7QUPloPhuh46WGr+mlXoTcjlKX8pIYz2XF7MEXWe54BkzPyDrbIuVA9
         XoXk+HQaogE2Cykcxd0BfYb1D82wJVscH1bdY5xHjpNvl0TNUaqReysNcE3vd9iwgg0m
         Lmm671XOQ044Fagscp6z+G9Oh9dTSYoZNdApnuveLCt2oTRD+tUOwxLwH7mz7ldYB6Jv
         CncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741131779; x=1741736579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W4txxMC+w7P+Pl/NtO19DerwN/cnYbZloqtqs+zb3k=;
        b=xScPbdcPhXmpa2hZ5YBzHG/QVbJFKH6HDVLZyHXBnnsBFMpVmLu+ZQioSeIRSt7ycG
         VMzbf1n2drAySPpKcHG3eo/vNEIxN/jyC8FF3l9Zq65+wCcvXqjpXO/DalT69Kol8np6
         QyUYtvyp+Jzon3VDa+58prwSNhdW4XgbGuk0+dpeopFCRGie/bX9bGOoMBF1iU1uIRyK
         vk1EAaOcNARb/LL3Uxk6CTGpMs5HJoOxNergijRn1cilg0nGwLpcCCaPQYidFX7QP8Gx
         Qi12dIMuCxn69r9OIaa4/fx57B5agVEkX7d2YdGk41DQTJCS8fsjCraa/AZ/XTMrdEls
         HVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzPYTIjbayvlR6WxP+TgJATZ/IyegANh8ZKGwnCRibplSrl7u6AP1GfP89GgPHqsqfiCpQiuMv3FE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZhhUmil9+A2vLfde3KVtlaTT9fAzbqCP3kqNUOcxm7hGYdV9
	o6M2Ki7dzyKs8AgMT4nta/7R8fa4c3Yq1h0ffwvXLQ8zLKmfE44fspIK406wyPFfnUqZcsbAz6u
	xEcmWolVHbqgj/Oo0q8wZz48CmuxclWmsPXJn
X-Gm-Gg: ASbGnctXBqKa8DUc0E/YJwW8okReIqLBSngkSi1wr41yeuAxj4gxO/yHDcqkbOoYf04
	pLGCMCQ9BL1cpJSdyBXaizsZpKFaXUEZu1Om/Nf9eWsqK8y8sVI+qOZNqLXdRkamzU3idDxs9EH
	7N2qHuz8rF2qUulpPLzC+bIt/7AGK89OA9ec46vYGcAg7GxZDuExpB7og4
X-Google-Smtp-Source: AGHT+IHHlr/mz65ZtSCBqhLDuDRmwm9iu+5k+atdaUbuTaovSfCj12cYfdFwl7Bdt1W8NCCmifHgWaqtyD1wRHIV77A=
X-Received: by 2002:a17:907:3f15:b0:ac1:509:79b1 with SMTP id
 a640c23a62f3a-ac20d8bc9a1mr97845966b.20.1741131779329; Tue, 04 Mar 2025
 15:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-6-pandoh@google.com>
 <20250131145515.000049f9@huawei.com>
In-Reply-To: <20250131145515.000049f9@huawei.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 4 Mar 2025 15:42:48 -0800
X-Gm-Features: AQ5f1Jp6Pg7X7T7jMy2hjGSZ2tMwmW-qUmtcwotfmLIYCvbZfq7ps_st_Xxfg6o
Message-ID: <CAMC_AXXFyxWtbjKt+6KXJu7nDL+7ofV=ibp3z5Ki4Fcp5zJ2Lg@mail.gmail.com>
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 6:55=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> So if I follow correctly.  We count irqs for any error type and
> then mask whatever was set on one that triggered this rate_limit check?
> That last one isn't reported other than via a log message.
>
> Imagine that is a totally unrelated error to the earlier ones,
> now RASDaemon has no info on it at all as the tracepoint never
> fired.  To me that's a very different situation to it knowing there
> were 10 errors of the type vs more.
>
> I'd like to see that final trace point and also to see a tracepoint
> that lets rasdaemon etc know you cut off errors after this point
> + rasdaemon support for using that.

Your understanding is correct. I get your point and will try to
address this when I send out the IRQ ratelimiting series.

Thanks,
Jon

