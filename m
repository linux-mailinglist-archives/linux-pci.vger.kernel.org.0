Return-Path: <linux-pci+bounces-36431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD282B86542
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 19:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9063B2176
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 17:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C2D28135D;
	Thu, 18 Sep 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlXv59gI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AC2820CB
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218076; cv=none; b=PbbWeq/myFHpNsXM5vEw0kz+A7gu+rDQJCq6/4KpASVgY+wbM9BC02eHUhX5MY5iOceXesfy6vb8Z+az/Hl2abfVUQXvs2iyiXfOyvB7vwaN3oiPjynFHD9sxHUqOe9ROU85nFcUwC8KcIbaE6EQbB8/MgZhxHmNN3gdMq1F31I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218076; c=relaxed/simple;
	bh=pyu+PEknQKVBR7WM+1Odw7v7Lj38JV9BuP14vt2oyn0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=c+jAowp98G3A8fHmkbzOYDYHNJAWM2fJ4maruoZfEtOFGGarhz4azyg2F1dlADxHw/TrJ3lIwci3H3ejPF35+zK2ft/agypQ8Zgtqv6B07GLXtILs+ujIMQHV9zJGZfXagJBOkf8MIU7OcbOaNeQcOB1ktkUmFKtsfHpWoGJ02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlXv59gI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-336dd55aae1so11981331fa.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218073; x=1758822873; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pyu+PEknQKVBR7WM+1Odw7v7Lj38JV9BuP14vt2oyn0=;
        b=DlXv59gImnQFLcoeqPcuwSBAwgPT6KtnnkHeJeN0SoIly8nTOK/EmYmHhs0FW/FH/0
         Q/e7qMPH9neA5U58EarKZMBeGU2HJ2guug16OhAL3NlCexqUSjzzdAzKUKccNVHONXDa
         ngDGKj3EmiN/9AtmQ65b+XtIcM/aplGayAJslOrG7p59D/gCdwgqZ+YIovg/rJ8Ej+QX
         w0h3nO1KKmfXhiERmW+5qQ6h4VAWFaxa+x4mJWRv2YP8wbwcG1PLZ4K/jHzgCDGghBsJ
         NpkgQg7txZidFnMjb00zWiPK4+UkkzOMWQ77MSmYnKkehLlPEDfsYXn/Cc/nK+Mrt/RK
         2zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218073; x=1758822873;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pyu+PEknQKVBR7WM+1Odw7v7Lj38JV9BuP14vt2oyn0=;
        b=UwEeGbrobOt42ntQjzKIuJqcj38GK9xD9cwJSS31fV7khn7jlquqgr/D8uWAtTqacr
         7061LJXB7CJzQFVX6wqoh2v9+4liW8lCFih3rDBv8Sl96ETxWqq8qbeX++JV6VPsyUye
         Mqb7yZBqcC62rTbjLZsAnn6/u/XNmGOrMYUk2FOCjBk03ugochqzWqbbwf4orpV8ZMqT
         FDEeDOjn4x2JTxUPPdj+pSBsEl7U89mJRImXHCa4+kD/g9iff+vSVwj3desI+81DldtO
         tnfhBRz9XEolshEr5YdZ/zWyLHN2flsLSp7JX/dySWINjYAhXdrm/xkohU3qEN36/B1k
         z/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVMNwLwJyDeOwq+ZX3krwENn+8gZfC+GLdnlHU0uwLIoqqC+Od6OP27lWe2wRe40IYe2QvAInTp6V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJkAYVmU35VoS9DfRvW+7E5xR36iPcqAXViAEqNLBVyf0C3pK
	E1suFay6KLgyY7+cEb9qkCixM+stxahD/mB9UyF6wD7/77iXjR4KZ9CFDGVjufA4YDNZTUyc+LM
	bgvgAIJWKc8sBAxLYP/GWhI4FUPWjBei1Zg==
X-Gm-Gg: ASbGncsvgOM4x15ZoPJ+Mm6jgmKJRfT9MEVBtrse+jj6lMUJAyy8ekfEZiroyhD4Mkh
	fuQjIKESoUK5b8tEfV/H6YfBNNb9DCaC74K4xoilHnVov5/3Bn+ej2XbGEcOf8UiS/3PPSxOHp6
	rqYD0O8a5enwF63ksOdxKiiwLQXjZnxgYU/KaEBNMbNDQrFliEM0sydX1wUoQVdCZMvheTDnDiw
	jsxhXuNYRefpC1r08ESFiPG1KJgPstJCkq9JF8=
X-Google-Smtp-Source: AGHT+IGWM1Kap4e+m/WrejLEWP2o8PYUi3RQ+on6TGo8+y8abvoNNR7whNgmd0+FLFUh2eGKY8FYnQXigMolH21LKSA=
X-Received: by 2002:a05:651c:3254:10b0:337:ed76:7067 with SMTP id
 38308e7fff4ca-36418ecc3d6mr989751fa.39.1758218072373; Thu, 18 Sep 2025
 10:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Thu, 18 Sep 2025 23:24:19 +0530
X-Gm-Features: AS18NWBuRfQ-UKCPiS_YSKD2LwE5CmC0UkCJ_avXXnH_mgXZ3W03kcmFYrI4-GY
Message-ID: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
Subject: How are iommu-mappings set up in guest-OS for dma_alloc_coherent
To: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi everyone.

Let's say we have a following setup :

i)
x86_64 host-os, booted up with iommu enabled and pass-through mode.

ii)
x86_64 guest-os, booted up using vfio+qemu+kvm and a pci-device attached to it.

iii)
A guest-os-device-driver calls "dma_alloc_coherent", after which the
returned dma-address / iova is programmed to the pci-device's
mmio-register.


In the above case, how are the IOMMU mappings set up during the
guest-os-device-driver's "dma_alloc_coherent" call?
Does :

a)
The VMM / KVM intercept the "dma_alloc_coherent" call, and use the
host-iommu to set up things?

OR

b)
There is no interception from VMM / KVM, but rather the guest-OS
itself has a view of the IOMMU (through the regular ACPI tables
populated during guest boot up)?

OR

c)
Anything else under the hood?


Will be grateful for clearing the haze.


Thanks and Regards,
Ajay

