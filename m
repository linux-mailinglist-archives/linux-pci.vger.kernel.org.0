Return-Path: <linux-pci+bounces-16791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D99F9C912C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 18:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F28C4B36A0D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0837418BBAA;
	Thu, 14 Nov 2024 17:15:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAE18A6DD;
	Thu, 14 Nov 2024 17:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604533; cv=none; b=DMB7m8XwBMc9dtfgR09U08fU8sPnQgfyR6vpu7SiUn9dMkRMsudDaqG1ntGzjIDTGPKCwJ1GeNg64IDGsqLmDfTVuHFQjYPBguXBf/ZXNc/p5nrE+ZN67LD2Pg18UpkVrqskLxk8LfeTdjWEGgYT94oRWU/VbZexr1nSwCK6ZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604533; c=relaxed/simple;
	bh=OIAZ3ZNJiKMo8wuHkF4ZKAGVauGHtAc7AemOqtsOiEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vjypr9tVowNn57Xt7sjE5FFHmxp2RC0VEG8jWbcwy/cjaM/3bKfY4IoG8asDhMcpMY/3uy4QdY6cyDbYTJ/PjY5rjMx0RERvPkRZR+bFlued7fs9DwSSKscjA0Djo8MkJ8g9a/zS2R075/qyZEE9ft3PYoNZwuh5+NjFN0T1uSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2114214c63eso8298215ad.3;
        Thu, 14 Nov 2024 09:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604532; x=1732209332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1bc4cftDd3GrDfuwAEH+cZhcJcP5YbIzynrAshbXD8=;
        b=A+a26IEytj9sHOxdg5S4tsi3He7LwHe/uOU3yGB1WHC/OgL/bIePuHPXzHVQzoiLkF
         SUdWQUxqmnIP94f9fyZCnO3oC14P36/I1Of9UgGJq4b+I7ZwL8KeHRhpdCBcRPgusx0M
         aRjv/baZ7lOkgEmd3D5t66PS9MYZNDnh8ANtzE8n2bVsrFr0xAOwDx7uhnkWPOgRQEVZ
         xMfwDXA9scX8g06Hy59aIWHHb2Wi9Kh5+nG9ILLLd8xESVZZ9OnnJhuay6Pn67QpB0bM
         SxIeZYw2F4h8cI1G1b42vrKPtutImTVPwci9VIbb92MrE4arMjt18/dPGKPcGGFNGhcu
         oDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNfHqhLsbucqPMADTGFKUUDix5qwEU95/BqW/KV2lA0jxFhYooAWxsA7L/Rkalg4r7rChLpyQogGzZqY8=@vger.kernel.org, AJvYcCXosz4zVNWUtQbXIl01auPnPSG+FgIub37fVhuT4dEQqIGGvlG8D4N9+CtLsKpeG4NJcnSZ4Psbf4kf@vger.kernel.org
X-Gm-Message-State: AOJu0YwAo5f+pSN3nM4SRs5hoU/53IbzZPTQBmXAy4wkLTZ33CQ8yI4p
	SHMdN/O1HVHvWhrJDX8HPUX73h+Yx3OJrdrIK2OtVzn0FG4rwgSX
X-Google-Smtp-Source: AGHT+IGt6zglfauvsdXQ3tfSgkYILbhvxz1Lk/mT8uX7FefciAUaDaL0uL+PwL1j62IU7Ifr++1/Ng==
X-Received: by 2002:a17:903:230b:b0:20b:9062:7b16 with SMTP id d9443c01a7336-211834e6c2amr338905305ad.9.1731604531733;
        Thu, 14 Nov 2024 09:15:31 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c2c97dsm13147165ad.25.2024.11.14.09.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:15:31 -0800 (PST)
Date: Fri, 15 Nov 2024 02:15:29 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix pci_epc_map map_size doc string
Message-ID: <20241114171529.GA1489806@rocinante>
References: <20241114161032.3046202-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114161032.3046202-1-rick.wertenbroek@gmail.com>

Hello,

> Because some endpoint controllers have requirements on the alignment of
> the controller physical memory address that must be used to map a RC PCI
> address region, the map PCI start address is not necessarily the desired
> PCI base address to be mapped. This can result in map_pci_addr being
> lower than pci_addr as documented. This results in map_size covering the
> range map_pci_addr..pci_addr+pci_size.
> 
> The old doc string had pci_addr twice instead of map_pci_addr..pci_addr.
> Replace the erroneous doc string to reflect the actual range.

Applied to endpoint, thank you!

[01/01] PCI: endpoint: Fix pci_epc_map map_size kerneldoc string
        https://git.kernel.org/pci/pci/c/36b25d04a9fe

	Krzysztof

