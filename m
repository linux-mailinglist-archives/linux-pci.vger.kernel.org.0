Return-Path: <linux-pci+bounces-4797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF787B663
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 03:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5006287193
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907AE1FB4;
	Thu, 14 Mar 2024 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZbP1Od/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60721C06
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710382821; cv=none; b=YYyBKJrhOO7lI/QDABXL368EjoRg7VOVSafR0yXFY8iMmqHQ2XApwkwFkD1/2GuEeRi8Y0lzSurJUJ6GI0Xa4DwSQDm1b3ez4CS15XHknAAedPa3pMPIacYj5/t9JFZeiXp9cJ2ByAynI8SdyIyRZ2aHRRVivP/L7v5GxwOfCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710382821; c=relaxed/simple;
	bh=OmqyQCIg1sRu0/gg1O6gGmaazvFemsZSsS7q1/4JwB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VmCA1NYwBV4mNJYjHHgDQF16D0+gvBk19cMy3foL8YGEPSU59HNWj/tGL6WJ3Tu4WtDRRfm0Y8LasTXA3FgjnqoFS7Uu4kQ2qJSlv6Uyyg8HxZtfB2vfKS3wxPje43YpfiKOqtOoJAMIPi4gDnum9CX1pWCfdcg1GSx6SUyjbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZbP1Od/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7883e1e01daso19775085a.3
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 19:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710382819; x=1710987619; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OVQhFyv5qn2W/0ulb609aeDnAw8FOd2mrE6Qsjjs8wE=;
        b=hZbP1Od/90pYAWf4Vz62NEEd/uFYZxD7zhJYHwHiL4J4YIkdTyp7jCrgES0RCLzWMu
         JEA6tAgIeuyyAGrS41yiHIMzypnCdwIfEoBInp63b8Lx4iipzLSD8b6zENYpDthqob/e
         mqBaVVy5KgoLr4LzkyU0P6vCTLaLOCUCgA0s6dANdNd69dSjEjEe9Oib6dIXbqmpDz4c
         jJi0YxY4EA548ZGzLdgP2WFnkqKlDvaxU4AW7kW75VlJ8D42mnqqDxBO8fTWlHMPO4mL
         x3jzqxqZvnhHP+EP2IJIEuj7luhPtG0Ien2dPV4YtBEFKgh/u8wNBHLr4OApQP72JhFw
         1QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710382819; x=1710987619;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVQhFyv5qn2W/0ulb609aeDnAw8FOd2mrE6Qsjjs8wE=;
        b=ltpR/A1s5ARb0dc8PWskznXyrijr+jXWUHj/jJl6M9fLABblIsMi231pvsAtIdNBri
         jJ3k81gSwCKVygdOMAbLFYUC4ay//C7XP1/MLgwDJ2m4kAl6RNiHLBfV369TP/TYlTRJ
         RyLLkDkk1SporYDYb9P3jOWtCEdtTJltjHgHJFm7HwiNMCxTMAqoPRFmR3/UFg0pKqk8
         pZU6+kLjzZI/A3q5KQ2Iea46lgjRocgbC4/PxApOOS9EOO2ZuMVXMx/aSINeObhHmmEf
         xX33hHDyqtaoaV4I2QES6J76lAdYdT9mJqwIdGO8VjqT7UyBhyGgIUUoAjh/KJXOFNBN
         2Wsw==
X-Gm-Message-State: AOJu0Yw2HTXSF48NPOwAks2YZo+pnYW6dJv/idenTarmUV725Q70U9ln
	bfO7VaKeoT8Il/7XYejOBwDPgkxh3n1c//oQoGYQ3JCJXKY333dL7lyHgDYUtnvrOQ==
X-Google-Smtp-Source: AGHT+IHyUQlNf7oVnDlKBd43U4q/e/pPwQmEX2kBl5QZ3s+lPOt+WW92Wh41p/qNE2u1R3lrYV250A==
X-Received: by 2002:a05:620a:4089:b0:788:728a:2d64 with SMTP id f9-20020a05620a408900b00788728a2d64mr703098qko.2.1710382818841;
        Wed, 13 Mar 2024 19:20:18 -0700 (PDT)
Received: from zijie-lab ([2620:0:e00:550a:e7a1:321b:1b99:1b12])
        by smtp.gmail.com with ESMTPSA id m26-20020ae9e71a000000b0078822c45424sm225072qka.127.2024.03.13.19.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 19:20:18 -0700 (PDT)
Date: Wed, 13 Mar 2024 21:20:16 -0500
From: Zijie Zhao <zzjas98@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, chenyuan0y@gmail.com
Subject: [drivers/pci] Possible memleak in pci_bus_set_aer_ops
Message-ID: <ZfJe4GZGpEQq7WIa@zijie-lab>
Reply-To: zzjas98@gmail.com
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear PCI Developers,

We are curious whether the function `pci_bus_set_aer_ops` might have a memory leak.

The function is https://elixir.bootlin.com/linux/v6.8/source/drivers/pci/pcie/aer_inject.c#L297
and the relevant code is
```
static int pci_bus_set_aer_ops(struct pci_bus *bus)
{
	struct pci_ops *ops;
	struct pci_bus_ops *bus_ops;
	unsigned long flags;

	bus_ops = kmalloc(sizeof(*bus_ops), GFP_KERNEL);
	if (!bus_ops)
		return -ENOMEM;
	ops = pci_bus_set_ops(bus, &aer_inj_pci_ops);
	spin_lock_irqsave(&inject_lock, flags);
	if (ops == &aer_inj_pci_ops)
		goto out;
	pci_bus_ops_init(bus_ops, bus, ops);
	list_add(&bus_ops->list, &pci_bus_ops_list);
	bus_ops = NULL;
out:
	spin_unlock_irqrestore(&inject_lock, flags);
	kfree(bus_ops);
	return 0;
}
```

Here if the goto statement does not jump to `out`, the `bus_ops` will be assigned with `NULL` and then `kfree(bus_ops)` will not free the allocated memory.

Please kindly correct us if we missed any key information. Looking forward to your response!

Best,
Zijie

