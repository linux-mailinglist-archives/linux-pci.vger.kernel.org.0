Return-Path: <linux-pci+bounces-43834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CDCE94D2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E983B300419B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B4E2D7DD7;
	Tue, 30 Dec 2025 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ltv95GZN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09612D837C
	for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089212; cv=none; b=UWmHc/U6y8eV+cBoNDxsehTVlijNv2Y81lBuqebJ5Mb0kjgTJOu/9xdnYVEniJypNEq7Jir2SRnbZa5S2DLJ98AHVtXz6FCmOMpgqzTjMXEpymyyE7c/sSqCkZZRvgoEgvnmHcfcPdH3A5C087xZBtjn5eF6gjlC0P1Rrzclb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089212; c=relaxed/simple;
	bh=o+QAyah/e9NJS11NX3XpsKORay4rz45Nrje/xC1EopM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGOlTQqwcxHfKQrdIG6crVzLiBiTU94s5ss/Bn81VrcjBCe1+m7PvBXYGYwr9iA1nBEeJYJGwr1QX3DqOVJpuXTNCVuz8PB9q8V7g63hSPDywRfxV793s07LRTXaisNkiih5DuE3pM+Ag+MfiwQxPGAmWS3h2dKldg6o0jCBX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ltv95GZN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5942b58ac81so8057594e87.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Dec 2025 02:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767089206; x=1767694006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+QAyah/e9NJS11NX3XpsKORay4rz45Nrje/xC1EopM=;
        b=Ltv95GZNWAEx0oXOQTeLtPV46YRu/oJJ/l+UEVNWfT/PQvD++X64mQfXJLpHPe9ZpB
         2n3RbKvQ5ZkAYFOsWQztym05Vipr0l5K5Yx54kRQoQ5p7AQHga3TSzDZMonsCcUln6N6
         ZMzYppOtl4F4lpLXPDLtqvyNCFylD7HEAhcOfBXD/D+BOJXtFj7VmHxY01yJCT02nrEE
         9/v/dUE0D8fDiFVMHxsjds9eWuxZWTwJMlIfy3AYymzHsdtvuAvXblAZfpvb3hkKIkEY
         dZ99r4s7HuVypAwgzPfsEuiAcu6woy9WeB3Q6hzjotjE99Z0jApj5Hti162BevmJ8GYW
         Pz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089206; x=1767694006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+QAyah/e9NJS11NX3XpsKORay4rz45Nrje/xC1EopM=;
        b=N6/jmW7/9+VipP01lezSCQj9eODj7K0XBPTBA4KLSiqCNlI52jLmTjiJqRPHzrTQmg
         5/AnK/KwazSmPpLI0vAwBMY16q9fwhsWzNVfv05oJaZ6PFpcZ0NjaGE9B0JrE8J7U6rX
         3v+7kFBKEjIkQ7w367rt8M+i44Qn5MxqIjN4H7a3m21sWeR7RLinE1A8rY5P+85kh7ms
         tUwlehUtsG6/SxjJtIIOtFX3SVIWAiraYxoIWVkAcNftSH5EdKmZ+OnJlALgtfbL39H9
         1sQCRDf7RX2TpbnozD/NlU6ZbnDy3/TMSlhsPhlB1X5o2BODgvuiAxmHcC/OaBpJBTHD
         gaag==
X-Forwarded-Encrypted: i=1; AJvYcCWQzs76ol8pIeWntyiRsQfCJTtHthqHJj5/nt7mhy5XVG8hHWZjanofsnnkbzKO2BV4p/Z+K7DS+o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCdD78/jK+p2KraGjINY8AkQHJMn8IrhU4vOUWWkfJvB0WITc
	WRkBCyIWdiRXASGs+6RSKfUbkZ/F7DwkyM0LK7RPZf6rH2Tm5RPISwnIp5Sk9GUcpaCVgof2NvL
	L8WnMbQO26T3FqJtbD8ciW6Gh+aRfdZA2v6F+Jypy4Q==
X-Gm-Gg: AY/fxX4u4AKHHCgD/J7X302ZVZeUCYhmZgce7SHCbH66LhZHhaZu3O+UQ1j9FzTC58y
	rIpfZ+iaOelyMfV3skcpwn5cBWnIFlDk15Idd2g7Vypgp5m9ULgUxaLBnoOeDMfUZ1FGVs/IjZm
	ufxZHQIL94VpgB0f3POkZC1SDLlt/aKZPmVFvjC7picgTN0DBETyax2g+oQsHJK7uMcu6Jd/jo3
	heIkh75CSAITvCqaPjvwlYcVQSCZz1kj7Hxxmi5v0nmF8+YGsfmv0+r7CTe7aCehU7p+tEhMPEF
	XG5bgTuaLRYFtSjFOISmo6bj5/ya
X-Google-Smtp-Source: AGHT+IEptJ9N0DNz+gItThuXT73C4+wuZb1+z9PtD7OBSI40hjPfReT36csaJ6oHgrtPI6VbFz+xkGhO3xEP4JLU36I=
X-Received: by 2002:a05:6512:3b9c:b0:594:34ae:1446 with SMTP id
 2adb3069b0e04-59a17deb93amr10965575e87.41.1767089206425; Tue, 30 Dec 2025
 02:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107143624.244978-1-marco.crivellari@suse.com> <20251229164059.GA65997@bhelgaas>
In-Reply-To: <20251229164059.GA65997@bhelgaas>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 30 Dec 2025 11:06:35 +0100
X-Gm-Features: AQt7F2rczV24JRCfL1l9zvRnghblqczv_JCUgmsJPUM-oL-RIqtUJrQqHU5a3u0
Message-ID: <CAAofZF45jsHo2G77MEMV4VES3HFnLQ5agH6MFGe9-yi-Me5K_A@mail.gmail.com>
Subject: Re: [PATCH] PCI: shpchp: add WQ_PERCPU to alloc_workqueue users
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 5:41=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> Squashed with similar patches [1] and applied on pci/workqueue for
> v6.20, thanks!
>
> See https://lore.kernel.org/r/20251229163858.GA63361@bhelgaas

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer

