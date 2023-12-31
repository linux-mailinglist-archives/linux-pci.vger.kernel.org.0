Return-Path: <linux-pci+bounces-1576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0526820B43
	for <lists+linux-pci@lfdr.de>; Sun, 31 Dec 2023 12:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6E11C20C1A
	for <lists+linux-pci@lfdr.de>; Sun, 31 Dec 2023 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AB22F4E;
	Sun, 31 Dec 2023 11:21:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809B4430;
	Sun, 31 Dec 2023 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28c0536806fso5842154a91.0;
        Sun, 31 Dec 2023 03:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704021689; x=1704626489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFsBn22TbsEIXDWM6rhjhtNrMA442HR3KGjQKwJDdfU=;
        b=AidCzgsp9p3hd7jb4tQRAiVEo/EPBlPAQ8ycpeOZ/+EAdK5SsYtQdPKg0wZHzwaF8I
         69R4ef6YDJBlAPcLplfakCh0HKjQrA0JYq/B7IXxaWHejwqIO6JOLQgodCwvxvT3x7yw
         NQXPV+AIYitnTzUgNJG/KIkYt11t2+otAj/pDMvbdRnyiGIbyXEUIR8HE1H1RpShXV9G
         IvAVSh3Up2OXiJ7IgbLJfnWiqQRyA3CPzPcOVMUrvuQjAIeK46XnHAnnpK4vdxuTNAMe
         Qvdl4jdj/mBPntU1GpOo+O8pJ/JN4vYWAPbwxLxhesQywk83s+MacObN6gp7eMX9XOht
         kUKg==
X-Gm-Message-State: AOJu0Yzs/EARwPuHefoKWPpmbUwovuPAXVwZuPZ0M8o8p2aKp3FjjeAH
	g0n6b5kFvGhyITTw+KSWXnA=
X-Google-Smtp-Source: AGHT+IGYmh0JgEncm++5erAkP8Qzi5VZlkDn0VQqhBf7rJJGZFuNdUzkXCLK4i9c+KC522rH6/7pRQ==
X-Received: by 2002:a17:903:26c3:b0:1d3:efda:2671 with SMTP id jg3-20020a17090326c300b001d3efda2671mr15719086plb.19.1704021688841;
        Sun, 31 Dec 2023 03:21:28 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id jw12-20020a170903278c00b001d4b7021ff7sm448792plb.304.2023.12.31.03.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 03:21:28 -0800 (PST)
Date: Sun, 31 Dec 2023 20:21:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: vmd: Remove usage of the deprecated ida_simple_xx()
 API
Message-ID: <20231231112127.GC3813474@rocinante>
References: <270f25cdc154f3b0309e57b2f6421776752e2170.1702230593.git.christophe.jaillet@wanadoo.fr>
 <20231213192659.GA1123825@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213192659.GA1123825@rocinante>

Hello,

> > ida_alloc() and ida_free() should be preferred to the deprecated
> > ida_simple_get() and ida_simple_remove().
> > 
> > This is less verbose.
> 
> Applied to controller/vmd, thank you!
> 
> [1/1] PCI: vmd: Remove usage of the deprecated ida_simple_xx() API
>       https://git.kernel.org/pci/pci/c/991801bc4722

Given two other similar changes:

  - https://lore.kernel.org/linux-pci/cc01721cec2d416d7bdf47086943b17ef44b7286.1702966181.git.christophe.jaillet@wanadoo.fr
  - https://lore.kernel.org/linux-pci/47a30441242c4d5f0e00555cbddd7783350ff1b2.1702966523.git.christophe.jaillet@wanadoo.fr

I moved this particular change to the same branch as the above so that
these are collected together within a single branch. And, as such:

Applied to remove-old-api, thank you!

[1/1] PCI: vmd: Remove usage of the deprecated ida_simple_*() API
      https://git.kernel.org/pci/pci/c/0eccea7150e3

	Krzysztof

