Return-Path: <linux-pci+bounces-11713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E7F953A85
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 21:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA4A1F24D82
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182676026;
	Thu, 15 Aug 2024 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rhfhnvka"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7E74402
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748762; cv=none; b=FMFXA/z+/r+LON0cNvL5saS2szDMN3lKVdf13pYZfi8SRXxrWUdzGJyy9GZc361etNEUofgfSKKkvBhjVU0HroBcP/V2MaocMjiDRJx7TRhUJFJX+kFtlUFEe1x2Q5HzcwS2tPRCMlg5mi56SUpsxvFutViJLZtiQO6JhBdPU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748762; c=relaxed/simple;
	bh=JWTK8FGShNYT2lN877/l3UqBYwVjKrQjVP5pV6Uvu6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B21tw2waqYDPQ8UoZFqY+1EUvhfcoz/cYe04LZJ6d3alYgDTsSIKbpAhIz1LDz6WRtEomOS7Ve5dkm26jne24RUunk3Qqx8wX6PqTw/ip93RPqvMoIj/HT+pDBMyyCgkRW/op5xUMfFu3FBdpCr79AR1QtwAlN7AB9iTaHfZACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rhfhnvka; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2701a521f63so199865fac.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723748760; x=1724353560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWTK8FGShNYT2lN877/l3UqBYwVjKrQjVP5pV6Uvu6w=;
        b=Rhfhnvkap/bhvZz1Heu/K0/lbWrksk56IRwLZ8DV9tYDzOmpvtaLtQzUOUDbGkncL1
         EzDNllGAbi3/bhrYS0Eg3q/CZRsBoTjRC9NUNBAUhF73sRjB0Sc9nJ9bRt5KWr05dPsI
         1/P/HD6haGOjCc8g++a12S0PTJ+MisuoQLmQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723748760; x=1724353560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWTK8FGShNYT2lN877/l3UqBYwVjKrQjVP5pV6Uvu6w=;
        b=rcUia5aq46PFEici9NJ95VpYp4mCJEdErp5F/s8PqI8jNLf3lxkIlRfvyEUPIJY+Dn
         mWBLsLK8sYTOWv+j/Prr0XNwg+6plZ4hpmTqeiP40MNfP/GIeMmiUcOuTY4jJog8vDX7
         mYBM+igWdQmBbiNXBi1TFX4PfYFYAXKLcH1kdFTqZsoYpfRE+acGZFI+0M0R3T1JdIA+
         67O/3cFq7EcR+wQqVtZ7An4goje8Q7ei1/h0YzXhhEhIMpVbswmCJrvzOeCZLvj91BXI
         5BqmMvnBmRfQexkx/jn2bb1yR16JPhzTDhG36+8RFDVVTo2zQZ5HvVM2jipa0+GACHsM
         7PVw==
X-Forwarded-Encrypted: i=1; AJvYcCVOaJd4dr7hL7OaBU+KqlSaa1V0pg7Lor7ITKwxDtIoKKqAVWawbhh+sHOEC34kgpTM3wEI87ojInkH7JAlr35x2tZHADixLPS0
X-Gm-Message-State: AOJu0YwgDcR4WP+65QsxcWqTR/2CKu8k32pbVZNCKpfjCEuta6HiZQbs
	cNtce0VD04mAlyHUuHbnErN1uKYmK9DWh3U9z3vz7gU1TNsjU8ZNeQYtmZG3EsPtAWDKxcnWZsi
	nvDzN5W4vEPvpwP6BkXqHrkl+KOTqMV2/9iNN
X-Google-Smtp-Source: AGHT+IFI6hSc7AGc/sW2JQfBUY/KniMDdNgoq1mzxNAQkecM/83LRUyAO4Lxl0MBqVBAVhpmGep+xg8wQQC8nX9vvQM=
X-Received: by 2002:a05:6870:d609:b0:260:fd64:60f2 with SMTP id
 586e51a60fabf-2701c34a69cmr661045fac.8.1723748760099; Thu, 15 Aug 2024
 12:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org> <20240815095928.GE1532424@black.fi.intel.com>
In-Reply-To: <20240815095928.GE1532424@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Thu, 15 Aug 2024 15:05:49 -0400
Message-ID: <CA+Y6NJGncpn4+UjgNavU0gAcChJZ9dji9_sBmMr85oJ5Eo79cQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Detect and trust built-in Thunderbolt chips
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 5:59=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Esther,
>
>
> I now managed to test this on my test systems:

Amazing! Thank you for the testing! And also for the continual prompt
responses. It is very much appreciated.

I incorporated all your minor comments (debug lines and comment
deletion) and added the commit lines. Submitting the third patch now!

