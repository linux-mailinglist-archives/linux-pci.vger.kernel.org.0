Return-Path: <linux-pci+bounces-32336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4FFB08079
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF0B582490
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069C28A1F5;
	Wed, 16 Jul 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FSz1fcKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C461C26A0DF
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704723; cv=none; b=DhyeFT80jQNWBerfUeLeHNuGzVX+asZpCJcHDKGyGqAzPGCDYOrPxGSCuVJll3+WajYCKy911cyLqcom4zhJWlgPgy/8N18qIsLOvYVcsYPrCQRYMzmvaD8Ar72wkfA/ITfxfz4mmqMl8JZPcus87hCX07aYuFc7nnItVNvBeyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704723; c=relaxed/simple;
	bh=oZuh26iOTA3ERNW2NE3pui2MltuT4r+wNttdePHurfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJlvmwzFPqEWLJ6P8Gb8phCoA51DUoKEq1UUIklHB3e9koAEfiuqvSA4kapzEv66gGJQaVh3BS+7ub9AIP8pBsc4rqhVI+EyfWOWUB2eKf4Wr28fGWe/TFr8VRyZDbwDr7/J6jnKv1p4Lx4HmWcEf8cyhnX8WBkL63cK/bMQsZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FSz1fcKs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3121aed2435so374394a91.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752704721; x=1753309521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhHtsrisAm1TD+wB7FG+SIYPIUgcXpj9jh2KYAYBvgg=;
        b=FSz1fcKsi/u10DVwMLA5drdZaXY7um3aivIhrVGqgY6iKvjghcpdGwOVK2YBmtFGTu
         mmNgu6LOKI3l5xKk9VIlYdH5rZ+f7ngDfdQ/KLwyylJ0pO8Pgmpb45CbCaeidgM+MQM9
         cSCDk6Zb44G4oFelXM1xMxHwHBmGyDs3SqW/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752704721; x=1753309521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhHtsrisAm1TD+wB7FG+SIYPIUgcXpj9jh2KYAYBvgg=;
        b=sdOBxRCjvwlvi1QHQf3kasddvcx7f4sZqfhb+ysw5SoydMgw1fULBY4ur/mBFc5P7S
         Mt7KHyfPaU5fmqdt7Gi4CLxndEss5QPWaj2TDv8GzvWEtpAFNnJnF2gXoHX2friCPa4p
         hveo2erAUETO9ckus3c16/GdkWnp/5OA9dpDZRGnT6JKBqOxOwMmvOrvLnw4bPR/3IrL
         sKd378+KKzNPgnZSbna+UAz3tOMOLRW/Xc6VDjNzAy39HXhVzWZYW67nzgtFYrmWAdxb
         MxtGZJavNN5cP29AmzUb8vV8+qCPFfsUutBcq0nQMlr0ZCG45fsFaDsTNePwC1BFFSb7
         yhlg==
X-Forwarded-Encrypted: i=1; AJvYcCXyq3yr5jaU10KjCq3Jps3j5LzY1wBdAWzLIylUEQbslnJ73SP2pPaG4e/EpNri0M95ocdbgZBwdDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9B5nrmntbkHkneGLBcWu/P5VpAOWblsy/5f3kC+csNAwJvjf/
	DHU4dVGySxcRt/T1UmIHnkpGW6vzkcFfm72C3ZK2EkFoXu6Y5gb4qq4RUD8CuRZXhA==
X-Gm-Gg: ASbGncuiuYiPWXoZxka/OKVTGC8xNhFPOFRJBQyHdxBWiQj0tSMWuTIr/ZeEoleIFD+
	JXxZ9NzijMRH/l2k7s7Oz6IoeG0aVcuqTt40IAn/Par0mQQzJLG3j/8PkzB71MrhXuXVSclJGNz
	IqLr7QxdgnOhFJr8tE/Kh1EpJC1gLb2QPTu7CYqTSnPg49lKFUB4dv/siFDkLq5EF0ujwbm4ioj
	oxeGtFe8VXuuw0ddupjS1qe8syA9Gumb2whlxNos0klbhQsiiSUAnIkyFpOEtX2upgpPBArGHeA
	OnMMTz6+JnAS6nuRafkgU67jHjzbMmbdeiFcfj8SRLWCNxEame5bQ8h2h4uZ9y9NYGwBaHJKxoA
	etQItFmQ81TdDOXcMoWdZO/pcOXUAgZ8frPYY/6OxcUTpNwMimP1fyXiHdrw=
X-Google-Smtp-Source: AGHT+IHqzQ4p9upHg8ZJ6UFR7/+avGiS90D6xyNA8ohw41tdTjIaHUs9wHZaUtjeEqzUJuPA+j2A7Q==
X-Received: by 2002:a17:90b:2584:b0:311:df4b:4b81 with SMTP id 98e67ed59e1d1-31caf8ef446mr760115a91.25.1752704721051;
        Wed, 16 Jul 2025 15:25:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:cc53:25f:edba:bd66])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31caf828a0esm185075a91.42.2025.07.16.15.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 15:25:20 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:25:18 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
Message-ID: <aHgmzpNzMTL2alhp@google.com>
References: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
 <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>
 <aHbGax-7CiRmnKs7@google.com>
 <cnbtk5ziotlksmmledv6hyugpn6zpvyrjlogtkg6sspaw5qcas@humkwz6o5xf6>
 <aHfXrT_rU0JAjnVD@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfXrT_rU0JAjnVD@google.com>

On Wed, Jul 16, 2025 at 09:47:41AM -0700, Brian Norris wrote:
> (2) Even after resolving 1, I'm seeing pci_free_host_bridge() exit with
>     a bridge->dev.kboj.kref refcount of 1 in some cases. I don't yet
>     have an explanation of that one.

Ah, well now I have an explanation:
One should always be skeptical of out-of-tree drivers.

In this case, one of my endpoint drivers was mismanaging a pci_dev_put()
reference count, and that cascades to all its children and links,
including the host bridge.

Once I fix that (and the aforementioned problem (1)), it seems my
problems go away.

I'll let a v2 soak in my local environment, and unless I hear some news
from Bartosz about OF_POPULATED to change my mind, I'll send it out
eventually.

Brian

