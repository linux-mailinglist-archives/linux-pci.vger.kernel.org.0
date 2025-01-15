Return-Path: <linux-pci+bounces-19888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E246BA1235B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 13:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36528188C5F4
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8DA2475CD;
	Wed, 15 Jan 2025 11:59:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6512475C2;
	Wed, 15 Jan 2025 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942399; cv=none; b=sUka4ABTXvXwP8mdxy6BaIam/GQgU+c/ytfgVDtLkDvqugcuw5FMp6OWKe72cTdZI8860lUJwIebtm8cOlVSPD6JUuNxId74zz6pCZ9ZYpHcKwnPwzh24QxmNVyXbtOrv/yiFy8Dutf3+SLM8z1kvYck5xwzzA7U7HXkUTRLhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942399; c=relaxed/simple;
	bh=uu7FQ3cPZjg4d+uUkKZ9ANJeKHAYcBg/bMYcNn3L1K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgcQbLwVNj//Fj8+Q9a4bcZHirAkhcy92rHi4GjTTYbMHMNkgLDn+2azsCQh6APSY26u1OXdBXu92wMayJ/psK1udgGwog0sXh1CK26D1ADnt9jQxPv5pSFLFB5sZKADUs1uWECHouvgkbcWe/loX5qb1Nj51qT9F46/zdmOL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21670dce0a7so144007825ad.1;
        Wed, 15 Jan 2025 03:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736942397; x=1737547197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ji4ZRGH2kPrJsqx8Lgy2uMik8J76Yl4+y7+1qgYG/E=;
        b=WcZdmTRrE+5HNBtoRsCUB9CsHIUgQnkShJ+SSlQ5CyEkEN2FxLD6RjhdDNNbd1fXac
         LV0bh0qiZxJ6FQT8c9ZLsUOiFA0JHeUCc7VYGjrQcRn3db1ZRDQvC5fNySNQzr/3boRG
         lMGGUdcqahLKjXlJyJ1/G3bragH237jwoJNyuHFsFqEJUQAtySDWeuMztNwZjSXQjArw
         2zTLp1MNXBDTd6fL8uiyeetJc6qopxDa2EsBvpqUSvajUGOS67B23uPXonPs8/59smfH
         YYNMo8UkVOXR8IXSntVabF+hOJ9eX9+UGl7DcUCw/MWDQs4n21nKgAnlWLqsCyvsaUO9
         jC1w==
X-Forwarded-Encrypted: i=1; AJvYcCV43q66YwKRH/wSVx7E6whTCMoadb2K1KXQJvLJA7axzjj5DJS050ZKheg5xmdDitsXLpYeXGTBPZn9YOM=@vger.kernel.org, AJvYcCWC9fipte/ciAooAYTMOVR3vany+Y1YZkpAPORD5jksBnA9zob8t67ci0WPZ2pnfNXYVlOJXATkEn7x@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgbjp72qyZQnGuxs0Q7Ti9wquSR6NDy2jWULRqzPNegJttOOUM
	Imidke2XCa5f6rdS9ZItYSvS3S2LdwU6VdvOzXzcuUtDlPHcDH7w
X-Gm-Gg: ASbGncs+eypTYaQdv3qzX8rqbY310M7nWpzLQ1dIgB7wqgPvRCO8VkLp8ilYi7S/w7R
	w1SUkQbEeG0SpzBEu54WM4FgzNvToLAJEYh1JDgkLn9xzeFPf3KRxb0xeJczcKryOaXdjhqln9q
	v/JvY81gDe+T/fgPUNBTKL6tDNavP8QJJdKM8f1PkGVkFaW6qmCfpR1n4cjgxXPACzLQ3ZfNTK+
	qJ9cwXXBGZ6L02HgYfg3i0g2YEWAyPdXxT7Fa67shxsbxd5MY/fglqCXHp5sNR4yYemm5MPqdsV
	2hfZ/Ye1KGTisQc=
X-Google-Smtp-Source: AGHT+IH30ty9BNCVE+OgmUhbQpEkv9OO/ZtaU+EI1rKgnEhl++waPLE9uUFOjCtxjOvUB4B8nYNyeQ==
X-Received: by 2002:a17:902:d2d2:b0:212:55c0:7e80 with SMTP id d9443c01a7336-21a83f672bfmr378687695ad.20.1736942397163;
        Wed, 15 Jan 2025 03:59:57 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31d5047fd3sm9393427a12.64.2025.01.15.03.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:59:56 -0800 (PST)
Date: Wed, 15 Jan 2025 20:59:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] PCI: Avoid putting some root ports into D3 on TUXEDO
 Sirius Gen1
Message-ID: <20250115115954.GQ4176564@rocinante>
References: <20250114222436.1075456-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114222436.1075456-1-wse@tuxedocomputers.com>

Hello,

> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") sets the
> policy that all PCIe ports are allowed to use D3.  When the system is
> suspended if the port is not power manageable by the platform and won't be
> used for wakeup via a PME this sets up the policy for these ports to go
> into D3hot.
> 
> This policy generally makes sense from an OSPM perspective but it leads to
> problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with a
> specific old BIOS. This manifests as a system hang.
> 
> On the affected Device + BIOS combination, add a quirk for the root port of
> the problematic controller to ensure that these root ports are not put into
> D3hot at suspend.

Applied to pci-fixup for v6.14, thank you!

	Krzysztof

