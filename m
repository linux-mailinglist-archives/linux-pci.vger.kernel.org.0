Return-Path: <linux-pci+bounces-21911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13404A3E0B6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527D13B0937
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7940220485F;
	Thu, 20 Feb 2025 16:23:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098711FECD8;
	Thu, 20 Feb 2025 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068598; cv=none; b=mnQYyM5uIxBNGkZtz0ijreI9r60OQTeEI5UDbXEevAD6Rfjf83jEfrjg+6aCqieDB/YO9jBtszhQsHBI1hyFA1g9Ondl8jlkThrC1qKnEwqL9Wg2d4OrEUZT2sTSmYgyg00mkb4hBxjYAAm8BvjskXrfM1wJAnppUJpRgvtULjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068598; c=relaxed/simple;
	bh=UV91EEUA7p1dTgOf/1BFgaJCW0c53QB7ivumCRNw6nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1N2rB/9XrfOLRivVfNRLV6ebnzUvAw8ak7AMG9vVPjOM01j2iHAYyE98KlhN77ZvFwfKT4RQzKXOUKypRyBSdRnlBV+nWOU96ht0MfKK8KdTVTWm9BJaJ0YzAhjPKYlpjWTAKN/85XyG2ABzfR4TM9Ft1yZqEpeX9Hd0GpTWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-221206dbd7eso22553015ad.2;
        Thu, 20 Feb 2025 08:23:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068596; x=1740673396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgLm1m+OvFNAJVKM8oPbqnxCJCCi3KlXydcSUynOK6g=;
        b=k79Bmwo6yQNE2b7jxwE33F+22mk1fdVx9vONrgWfFC1QgY7ajPrzunt53uY8G65aCL
         mH67egfAk44v/n1/QN04ILfZ0sMpsxxxhzujoIoDWbNbUNuXH3vFktIU03ky0Jjljwpv
         iSRuoGLE8tuR8iMFuenShJbx/+wV4t8dcA0BYF+35iyLbEIt4BLMQm9+USN2zY+iQmgJ
         GH6qCZEveWYsSxZeCJe9Xhnr1W8mGV1If2xzdC3GKdBwV4sLGj7R/eAYMwV6JdYIca7G
         5QF5pNXs6nvYG2AGnmnyBKbKD3AVJWjpqOFDmZdN54PQTWemDBHOK5Am2VFZfprhwxhF
         Sfzg==
X-Forwarded-Encrypted: i=1; AJvYcCUQlwSsmMiwTsEL/JvkHeMgbE7wc3U3HieEbL41kRGUxWlBufNf0EBVSXLKbth+Gj+4G2Esvm9zxaUd@vger.kernel.org, AJvYcCVXpk7Tz4GYknC28hDAmqnysTfAPa65QnyJZJupkFkxxftGhCxM4Metkv+2WJ/zQ+hUqGi6F76/@vger.kernel.org, AJvYcCXSP8NlpagSuxweKBdVL69KqpJ9QgN3vkt/6rTDvsGG17XEiTuOI558rTa9d21kO5noo5fkodfRGvidkRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKlxqVUGgAInMz/kN0Db5Mx370ICCXAvktmzJh5z9ijl25qLV
	JnugnOO87adg3CUSKKdmg5BqTuHINITOtufqRG0wRSlHl0dqWcOS
X-Gm-Gg: ASbGncuC/KL/VGmv075Xwv88lLtHT9d9la9lw+2TYFWQ6lKrUK6x/uiv7SDyE9Icv02
	Jr/OAF5lWrF6x5r22Jr9x83E1fbPZqKuvrchT2XtNwO5by3o7k21O0F7SJI/hN5LOzJ1Ts/9+Ab
	96JJNxgQEtZkhtFt1Lhhc9CBFrE+g+HvPJuLhzqkftSQYXt9yxDZoQqwgLRODjI3V1MM5zCi+Qj
	Bwo6B3OPMG0cxFM789ngrLbZQn/dqnpkpUGiW250Jc+GeM3QfyiAQVeAlza/BsUYXSXhG3ZpRAP
	v3itHQUyqZtHcL7ZW/l44iXc4uZiEqSPhpZHW6w+PN51x9/gSQ==
X-Google-Smtp-Source: AGHT+IGxDghjV24MGlpOLAShvGV5okwWCIIPd34UUJWTKrxs47PV8/eOQe8MU2IpkQPtA2BMbQevKQ==
X-Received: by 2002:a17:903:2307:b0:220:fe24:7910 with SMTP id d9443c01a7336-22170968867mr139817165ad.15.1740068596290;
        Thu, 20 Feb 2025 08:23:16 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d53494c0sm122756675ad.6.2025.02.20.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:23:15 -0800 (PST)
Date: Fri, 21 Feb 2025 01:23:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: lpieralisi@kernel.org, mani@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jpinto@synopsys.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix a double free in __pci_epc_create()
Message-ID: <20250220162313.GD2510987@rocinante>
References: <20250107074601.789649-1-make24@iscas.ac.cn>
 <20250114005737.GA2004845@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114005737.GA2004845@rocinante>

Hello,

> > The put_device(&epc->dev) call will trigger pci_epc_release() which
> > frees "epc" so the kfree(epc) on the next line is a double free.
> > 
> > Found by code review.

[...]
> Which kernel release did you review?  I don't see this kfree() when looking
> at the current code base per:
> 
>   https://elixir.bootlin.com/linux/v6.13-rc1/source/drivers/pci/endpoint/pci-epc-core.c#L956-L1020

I will answer my own question.  This surplus kfree() has already been
removed as part of the following commit:

  c9501d268944 ("PCI: endpoint: Fix double free in __pci_epc_create()")

Nevertheless, thank you for the patch.

	Krzysztof

