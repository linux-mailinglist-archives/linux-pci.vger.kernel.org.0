Return-Path: <linux-pci+bounces-34903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3527B37F28
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906483A71B9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAF827B337;
	Wed, 27 Aug 2025 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIbdNKKV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129214E2F2;
	Wed, 27 Aug 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288018; cv=none; b=oVK8dFE9FKb87kObl+w836m8fDfLpoJZzCa4sZpZDIiICWHYGQbqqRYHI2LcJCljW4zUV3zOiHmhAPcvgQaFy7rhQmi07ZaFbxbHrjFeNzckLSsMtwGYmpAbXDsjNQ73esYlV6hQUWiGVYRz0WOUaklgshXqMVE+wSr3qxahjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288018; c=relaxed/simple;
	bh=5aI+ZYSsvVHdVPxVjk6qUnENbFixEsJ8O+5Z840nd7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imEEwl6deQ2cyDPFIEyUhac8E0fETkACd94IhoYzRa9Kkhef54OeUL46i6KmURAZ5ukVm1m1cmAizCs7sHRErwrquq7BSF5eZ8mZn+vAobVz4TC0bjZOoBavIDOrqvoZFd7aioBdumoUuaZK3wb+B/Giv/ibOwbHeVsgx4RXPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIbdNKKV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77053017462so2813688b3a.1;
        Wed, 27 Aug 2025 02:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756288016; x=1756892816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7p7UvIT2kbM0WGZWywrLeb5TTjPgS/NtsEDB+2LTAY=;
        b=eIbdNKKVFYPmrSwI8XaWqjcC8oVfNa9duoNnKRCK+TM/rK/imACCxxMMSTfxe6Pqij
         rVuos8cwDvZGc5lxKAVbTrzEuFMYF91RlU1K9aW3dzGZgqL08ysC6kgRgH0qIZEygO0Q
         CyWh3N5V9bznCv2GwRxdFWtMd3VBaF70QnIYOdDu1o50EVdhifBpy1W7YJvvHgwD2Ecl
         KXS7gKy1+sI8c5iOYGlThBJ7AhXXPGOEorjFsgKczsy++tIQzVGmscAXL/IYoMXb8QBs
         MML0y7ASz6nRHLATOlJ0pEnErTZO1vH97Wz/SBVIDugGX1eDUtyC6lGVVAiyrqKo547P
         tEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756288016; x=1756892816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7p7UvIT2kbM0WGZWywrLeb5TTjPgS/NtsEDB+2LTAY=;
        b=gyecgJT+ZSwAQcQ/2Fpn+7NIXkJDTzmwi/60lQl1n+BrIuKElEORQQVdezA9P7Edg5
         zHSi2iPNznVcxssiiJ0yrTycr1llthpUg56LAEytc8G90sqjuc2c3BKJpXT5J8yzUD7B
         z/amZyfu8nEWnn7DwAleF8tv2IJZ2eWM0Yprvnch3i23Gec8MhoqZCjzNbN0GhcQufNJ
         Gy9ozYCw3XWSM9BOr1sKh2/AVCCWuyCjNoVVqd3HtoNPNQrIGUYesIpZjOgrgnNXpOPC
         ewzj7G+TuwI/SYTQLdHE0wKPdiCWQ9zv+2IVInih07LrlDeRFt6S5kT6+PKAglvmvCdZ
         Tlhg==
X-Forwarded-Encrypted: i=1; AJvYcCVJVM+Q6IV9rJJo9gnliqQMCPjzxvxL10Q38k0lUK3yEHia2qKVs44h8w3z8GuK9pzpK5U308jW2J28uwQ=@vger.kernel.org, AJvYcCXb5Jo/m6Ou78snLLBQTy5lSVRAe3akBcwET0eVMv0D8AZJFAnmcTEEt9yuBDxzYMkW5zGO+4keluVy@vger.kernel.org, AJvYcCXrZkdAx5cMIiUr0BnnrUDMqXFsifEFKdPEtBrcQiXaODTHpv2m6tq0TGVdSEBhikA3z/7O8ps6MKad6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK00fjGz8YVZ6tmTT7kgscVd7SrkRJ6tjcLze4aXNd6BO4ikJF
	chLJ9bfnF0sBJTx8piCT+t7YCDoQ3LPHAMXVj3BCNmUyvO64Eo7ZoMLB
X-Gm-Gg: ASbGncscuNbp1z6/Sev30Kbcspb8oEYZqINaMKZBviGMEGs+ArQ7UNaZYCCllz+DS8D
	P0BFH9kx1M7dDGYxJyAaSiYPgQ0swT2BwX36NhS0CzNx43qvdhq0hyRZrjCGDPqh1vErZPHJpfO
	my3UnQ6EzlLXX+4V6xcvZcBhzh6DuUSGdWnjMt/9+ZXYVJTFMAN8uJCVWD0t6K+hDm1GHndOVRQ
	wwA+VG/lebasCwaTUpY5tUjL2kubqjwH7qKBT15kU0mhemvzS4Bilim2wp8kqQ3LVGaqq9Fmi8F
	bMVBlf460zcOFax1AdisVMZnHWNs6RB11gu30Ybijb3Ug4q2R3xK5fnWh2icSuv+vjoVgqi5uit
	0qKLIHkw0YV1DKCO/3KlDCw==
X-Google-Smtp-Source: AGHT+IH6p+lVA5i3KfX5nEoaE5M6ccLfYaUU2KaTPzY7Y4H0Kd4S8ErOqIIwrh3SiJTeHpTk/ERWjQ==
X-Received: by 2002:a17:902:e783:b0:246:d98e:630 with SMTP id d9443c01a7336-246d98e09c1mr117662375ad.44.1756288016411;
        Wed, 27 Aug 2025 02:46:56 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-246687b0b04sm117749355ad.44.2025.08.27.02.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 02:46:56 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:45:50 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Inochi Amaoto <inochiama@gmail.com>, 
	Anders Roxell <anders.roxell@linaro.org>, regressions@lists.linux.dev, linux-next@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Jonathan Cameron <Jonathan.Cameron@huwei.com>, Juergen Gross <jgross@suse.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, arnd@arndb.de, 
	dan.carpenter@linaro.org, benjamin.copeland@linaro.org
Subject: Re: [PATCH v2 2/4] PCI/MSI: Add startup/shutdown for per device
 domains
Message-ID: <laatjr7p5zyp6ubzei2ogytgtfpbnlcmxjccbrqilfttrld3c7@csfx4wgqovg4>
References: <20250813232835.43458-1-inochiama@gmail.com>
 <20250813232835.43458-3-inochiama@gmail.com>
 <aK4O7Hl8NCVEMznB@monster>
 <db2pkcmc7tmaozjjihca6qtixkeiy7hlrg325g3pqkuurkvr6u@oyz62hcymvhi>
 <qe23hkpdr6ui4mgjke2wp2pl3jmgcauzgrdxqq4olgrkbfy25d@avy6c6mg334s>
 <20250827004719.GA2519033@ax162>
 <CA+G9fYsAxq-RmU7fVSDQ8_B2Hm5NY7Q7=DUnqcpnt8BOtd0dUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsAxq-RmU7fVSDQ8_B2Hm5NY7Q7=DUnqcpnt8BOtd0dUA@mail.gmail.com>

On Wed, Aug 27, 2025 at 01:47:14PM +0530, Naresh Kamboju wrote:
> On Wed, 27 Aug 2025 at 06:17, Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Wed, Aug 27, 2025 at 07:28:46AM +0800, Inochi Amaoto wrote:
> > > OK, I guess I know why: I have missed one condition for startup.
> > >
> > > Could you test the following patch? If worked, I will send it as
> > > a fix.
> >
> > Yes, that appears to resolve the issue on one system. I cannot test the
> > other at the moment since it is under load.
> 
> I have built on top of Linux next-20250826 tag and the qemu-arm64 boot test
> pass and LTP smoke test also pass.
> 
> >
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 

Thanks for your tag, can you resend you tag to the following url?
I have sent a fix patch here. Thanks.

https://lore.kernel.org/all/20250827062911.203106-1-inochiama@gmail.com/

Regards,
Inochi

