Return-Path: <linux-pci+bounces-13658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456798AC04
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662071C234CE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB377198E93;
	Mon, 30 Sep 2024 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ff6xXL05"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FA2B9A5
	for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720593; cv=none; b=nlvbJagDUGElOghq9I5fxPwq97xxg0OXcRtGw/9YpV6V74y74B1ObOfmgL1znPrmv0Cq3Hs5OhiICOhcLE6Wi9jRPWijHpBDGWNei+Sg33W1VHBiJRbmFzlDHNaME/2x+p03imEgrnVL0T9izXOcnd6hCggUY/foMVqKbSN5Ku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720593; c=relaxed/simple;
	bh=JWzDaD4gnfuZZ55OyRg88I+Uq/fwGy15VXJDyUQsijs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7y1gBP86aOJB6ah178ux3enONA/fHlQ8m2LeDTgQlVCX+yl8I/9gxKUIcLgw14Ol3PMumJH4mwkOK2bPMVsHCFimdSt6vYoc4QRYev8rZZ39OGY79bnIfvZzxyDW4VOyHpFVGnnZhJNBRxeWTkZ2qCdX2SDyrD4/q7fRMs6hgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ff6xXL05; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71116d8504bso2951715a34.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2024 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727720591; x=1728325391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWzDaD4gnfuZZ55OyRg88I+Uq/fwGy15VXJDyUQsijs=;
        b=ff6xXL05YKP68Mi8hk/py+xcxwrB5Fe7dVtLwDCOv9vcMpRTMV7IfDoyz4JlA8t8+Z
         7k8/5ii7jcvWN89aJYIOdOk/ksCMp35WJ9TIgTIujb7ryyjkcyst0SEmplcwXzRNc1cR
         5V8ag+YduiIwgXp/NWUC2dtd0UkyQ19DaZPiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720591; x=1728325391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWzDaD4gnfuZZ55OyRg88I+Uq/fwGy15VXJDyUQsijs=;
        b=mDIySRJHTg9RpwaLXz6AFLv/ujQa51+wZInAeC1KJ3d2QKdXINdeyY0ItcXE3Zqguu
         Crx2YoBLH98QN9TNc8nW3rcT4h4/gcxVXlVEZVPc4rc0cdYfhSWuZAPh67Jn9LHRQgkT
         YagSwpysGVYqfa4WwPh4M+2jMEOhUuUm0Ho/WC3OA8QjYQn3JNBf11FcAoWGGoqWdPoA
         /xMTmv9SAw5C7q5OhG5Wtqk+jcQT9Wx6MH3oXMX+DuZL500D7MN/XBY1y7fEWkXtzcVH
         WMwHNGCEp8JVrrtM0tsQE7CYLcSJ2xT6dNLWXGs1Ck1u8ivtIv3YBsQQCqOWWi2vWiOd
         CC5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkSxss9PPBpGpT9YSU8/322IORjg5+LIjz7qkvCpPZdFXqIZV624nXe5IjMvzC3ab111phRcQXlqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBiq2RRAHIb8jlSnDJoPPLn66WR2mL3SW/7JuvQH+Ek19KRwjj
	eoSQRbhV9cnoLIlXl8prtIo8MQQTJxV6GmvEclNNPFxuDQ5q+Fmo6qBXJ4jzhfKPaYJiaIe4W4g
	4T8BAEJgNgVZB/lIYWd8CKubhr3bqGebrnQiC
X-Google-Smtp-Source: AGHT+IEa7PyDDTTEYOgSvCL8wcTYdFJzQ6xeqQh0FfcrTyWPVWg/k95QEjmZ5s68+65kdVi38bWTLm8OVVjNPcrmKeY=
X-Received: by 2002:a05:6871:546:b0:277:cb9f:8246 with SMTP id
 586e51a60fabf-28710bb0f11mr8656866fac.38.1727720591656; Mon, 30 Sep 2024
 11:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824042635.GM1532424@black.fi.intel.com> <20240824162042.GA411509@bhelgaas>
 <CA+Y6NJEm8UH5H1zE1Kgz9sKcv2xKKUzR5n=xNdOqyBYocyyCgg@mail.gmail.com>
In-Reply-To: <CA+Y6NJEm8UH5H1zE1Kgz9sKcv2xKKUzR5n=xNdOqyBYocyyCgg@mail.gmail.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Mon, 30 Sep 2024 14:23:00 -0400
Message-ID: <CA+Y6NJG7aJszmMG_N3HfnmeMFaAsz9g+XvuQyvzgquah3Jr4NQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rajat Jain <rajatja@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

Just a friendly ping! I see that this may have gotten lost in the mix.

Have we addressed your main concerns? How would you want me to reword things?

This is the latest patch in this series:
https://lore.kernel.org/all/20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org/
Thank you!
Esther

