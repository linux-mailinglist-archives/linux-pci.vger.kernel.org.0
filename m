Return-Path: <linux-pci+bounces-18946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A519FA84A
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 22:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9418864A3
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B344E186E20;
	Sun, 22 Dec 2024 21:22:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6A17BB16;
	Sun, 22 Dec 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734902543; cv=none; b=IrMCvSyEXktRxs6Mp+FsCP5+wXsCwWiDy04CFCY6owt90oadbvZS7S2fMyZsQx25d+yBUi0R2YEMA3rRNNwIFKVAkpZuJm5NbBrT5kY0jUpV2A/bhHtoBTd+XQaKufbRrDZ82G7OxJiEQe53sQQeCp4H3NzI5nY59Uub8Jj9W/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734902543; c=relaxed/simple;
	bh=D8e6u+1WXiayE9hpxr0ulNB1HpqqydUCpGtpxtLcL4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrLFFIS4Rgddp5ad7nlH9iNay9X36hN9ikS+T+N3xZKqv+I5ZuBP0YZV2L8VnxBmfKGw0FP4RuACYqMjfKrHu9ObaDdKMDX04Ax7chJ68dGnVhkcJqPRpold3NwyZD6kv6md5hxVNKmykIgSJQn5pydaY4nihmydtu8fTxvrngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21634338cfdso45855645ad.2;
        Sun, 22 Dec 2024 13:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734902540; x=1735507340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCyXJTn5O0w6RVHyB04pDHMovkP6nSZd9njxzOGgosM=;
        b=q7mmlPMafl4Q//0RNOOeHE919+dO93MMcg9lcnJFOKnYa/B58BSNDxJMh//WXFanSa
         i+NcD43rH0vlBsSP5R8ItYR+PxW9j+HUxnwMG0SK2FbjslvmNtpmwxH4s18tRDJyOfzo
         lxn+BWOl25nPDFAaUKuT9GD+IMsbUMXBPrnreL29UndGpPFr2blBfUQWnzjdGF3kemky
         anT9zYZ3CjUzpk1/MedASxt253FcMRLWvLf7KrKJ2QIufr0L5/FE80xVHPHltGBMe4ct
         BygLDbUckmHshRcBh7LFLQJprb4lKGUKX1L+apLbeRajTTDKWQYN2okezDA0eTvuzg5H
         j+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCX07xzo3t55H8A/ngmM4vvtdUGjznvAk+wGm1sW2ryLCETREYASJYvmAmo2PDU7wHl95aZXK5vUlTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2S8o4ExweSZYS4JI+TknaIvlLTPeBDy6uAMcD0S6/XxqwN/t
	PUzew4+VNuV4xUNKHovt9NAmxa2vzBoYSWEgAUrE5VwFCJXo8W/0tpT24WXC
X-Gm-Gg: ASbGncsVsn8bFgZHvj729tDsWyS8kbg+zWSYyKAUy+nwcwuDa1zYHfT1VnaZXRj5I1q
	p+Ic4hZq1ccOEK34eY5rRV8WmXwNvV5Unt2/DTwDoAUPtJv5oLt7+1FIHfN5MnBeqp2BH+E0flX
	K+S7m+qrX44ODuSusJNFzkOlI3fi9UnUWJDnO3765vwUCZt3KkW1rxXrUDv9AUQMDlFl7jEcSev
	tmyRTWMLuULlgoky92fuiVTPvA8ZhSUyhr/3tf47zx2kvputBCDDfVmtk6oQuPkA0muxmz5kFNX
	V5AUjOzzb8ILlDU=
X-Google-Smtp-Source: AGHT+IGQMrMICexi0zylVB0B6mpokDxxZo9chJvohbJHIXq0PyC/YIv6DLAA+xqMN1RAwTb7Ji08Sw==
X-Received: by 2002:a17:902:d4c9:b0:215:7447:ebf0 with SMTP id d9443c01a7336-219e6ebea30mr115828525ad.29.1734902540438;
        Sun, 22 Dec 2024 13:22:20 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9631d1sm61016295ad.42.2024.12.22.13.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 13:22:19 -0800 (PST)
Date: Mon, 23 Dec 2024 06:22:18 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 11/15] PCI: don't include 'pm_wakeup.h' directly
Message-ID: <20241222212218.GA3352524@rocinante>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
 <20241118072917.3853-12-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118072917.3853-12-wsa+renesas@sang-engineering.com>

Hello,

> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.

Applied to misc, thank you!

[01/01] PCI: Don't include 'pm_wakeup.h' directly
        https://git.kernel.org/pci/pci/c/cd3e4149e2f6

	Krzysztof

