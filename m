Return-Path: <linux-pci+bounces-36349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C200B7D4FE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C03916B126
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C932FBDF0;
	Wed, 17 Sep 2025 12:18:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2822FBDE7
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111481; cv=none; b=mtvERg2OHNrDJM7WKyGazykdqm7jS+4g9Jt6V+sHckIFVnFrEEilO6HnF5c1FMVK38RglgsA7FLIACbEcGlaLQn5g0VGUHFBjVqQK/bECkOzp4KvDeA3Co+2YfpOaXyqmCisNNVfN/ZESUfo/+XmXdJE9QeOotacZyfs0Yu6uDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111481; c=relaxed/simple;
	bh=xO496SbJdfEtkCws1FbF83Z0k5siGcyeLu3sGNRxv3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKvLEp7+VTuHTIenDillYrfyW/eAqmRH083PXEmNu4rCMsvRFLqD34KhoEAMImdwRBVsZ0WyWe7sVrLM7xT0wUiwwFhv7iZF9qkDEEBBKeksMybAJiZcIr30MYuJgOe/iesyJyj86nYpNwYs3E3t4RJ8/6yUkEq728w05ROvoas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26488308cf5so29093365ad.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 05:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758111478; x=1758716278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qh6YKvpPZBYGWe3t71eAmIBGoHDeTgKtZLWMs8wLOpw=;
        b=ghrzLRrHB81BUyHpMGrS9cjnbxxYzbGI99je2dVN5LFgPM4XeMl6wOAbznY3IrqeDS
         FgyczeZuzAVbaW9tg9DDEOxX3N+gC7Uo64kTgGr2puG+2W2nGMhStBw2REi6OszBW2aP
         P8TnJJpWhjOdTpZeDNv03OsSJnTF21eob/84gOYi/WDUHrrBJWzlDLpe4o9eruneiZgT
         yWppbnDYWbrZgebtYgqS7oP0K1lO8VUEbnhQdtiWj/9qFEMl1tw5wm1P089FuYWianh3
         wOGbuT3Z8792cL/pzqYOoPJHNB+cTi2xdvfLP6UtqiyZ3oYfQYKZy+0O8BUj6Fj0rOx8
         Ekxg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7YZWlDfNH44NIaqoXYeWQMRot1I5izCxtfNYjcfaFmizY+COUzXeLBKgKdcKMn344lqMnQAA0Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5voIvaNLUKVBNTa2/ozAjRn3v4a743BDIXW6gowxFrMVljOc
	1YNqkh9amYaRzoE6db5B8jQZtviPpZ2Hv1fkZYFpV1KlLG/D5n9wkOyU
X-Gm-Gg: ASbGncssYfuF6MZXxaF90P57AaE8O4i56gwAfIU0U6aPtNqfexHLs4NBh9g/RmWf8vI
	/FLv2re/OGPSQIRC5Qib2rzeF3rD2Zbjs8JaUlth7MYhZZuXjbyJbs/2VFNnMBrwXjx1GfkISgI
	T4yFj5oyiwTOS3i3JE3PLT24kan3LZQlyUQDF8adw79rkKwXUQz5RuMRVY1vT+w13C+PgodACdG
	Qf18jAwuUwFEarvePJ/K8c8PT8UlNGqD0yMu3JUzf0fGDhauqa993Iinyar7S4r/Abeke745tMk
	vM+Z1Zg8ASHgtq66VGGjXcfZgZGUFU2eQGdgoflQRREm1zBNTi/d3lQfCo0W4bBzrvN3wTB9vjB
	eCPq+P+i1GcKHqMU0Fik/G5j3vQWp7q6/8CICpmJ7ejrfcSWtvoQEJjQGWU/n+hs6UZrF
X-Google-Smtp-Source: AGHT+IFpRhe8C2eqHknsEA/6M29fXs1KT5C9GKAJTC/cuu7MNv6bqjnevGYoR/ytjGumv0S3im1n5w==
X-Received: by 2002:a17:902:cccc:b0:263:3e96:8c1b with SMTP id d9443c01a7336-268138fdc59mr20672725ad.33.1758111478500;
        Wed, 17 Sep 2025 05:17:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-267c9996c93sm50384435ad.122.2025.09.17.05.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:17:57 -0700 (PDT)
Date: Wed, 17 Sep 2025 21:17:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250917121755.GB792199@rocinante>
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas>
 <aMnmTMsUWwTwnlWV@kbusch-mbp>
 <20250917083422.GA1467593@rocinante>
 <CADvopvYGtqLzm5m4yhXLih7SuSSuw4RtRhBCiXob+rXsMP5fSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvopvYGtqLzm5m4yhXLih7SuSSuw4RtRhBCiXob+rXsMP5fSA@mail.gmail.com>

Hello,

> Thank you all for the helpful responses!

Thank you for working on this! 

I am sorry that we took time to get this merged.

[...]
> I will prepare a v8 with that change, thanks again!

Feel free to add:

Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

While at it.

Thank you!

	Krzysztof

