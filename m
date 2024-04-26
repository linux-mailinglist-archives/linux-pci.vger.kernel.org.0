Return-Path: <linux-pci+bounces-6694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E28B3C21
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 17:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AFC1F21274
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37849148FE1;
	Fri, 26 Apr 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h7PHiu1v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D00149C7B
	for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147140; cv=none; b=nXhh5mrbqhTxKKzzDBR719uMELBfwgeJsxGpMyo8PhntfO8hrFiSWHLEiSLUcOsN58cF65RvJ+uv76mF6JVukv7lDiqPzO1wh+RnKDt0kUKuP6LgBvrF1O1CiTiOiPDli+fHmUAu63ZXFwa+ULg4yR5S+RZOyvAkdZzTJ0LIUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147140; c=relaxed/simple;
	bh=p/0DKubwSqncuszHr4u0YEli5l6ZqQLbw+QHZ08ddVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQ9KafQVkBMLqYUc1ag3ofzq5FiWAJnWVkfQ12trThy1tISszmBVjxCh1ndgj61LYnJEbjDubWz831xHexDQPs1odfjQ2Rs4Gco5a6Jx56hPtAhPOOKUGQTNBcGlTAQbxrXrYW5XCOVTXIn2+PRdlUm2rRW1aGs9GrMCxucte7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h7PHiu1v; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4dedcd1821eso130894e0c.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2024 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714147137; x=1714751937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p/0DKubwSqncuszHr4u0YEli5l6ZqQLbw+QHZ08ddVM=;
        b=h7PHiu1vgM8DDosVZNErQyADNkAe9MNRGVia9ZWA6nXnPliRuX61Olnynob+KX1gav
         5tYmo7sdcWQekko3QoevJblcl2ydZ0I+vy7kUYKoR22/Gn+c94XLRf0gwXrIwMc5jKlT
         1UZ6XPCq4kfByjg98Toj1erd16VxCa/bmrCSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714147137; x=1714751937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/0DKubwSqncuszHr4u0YEli5l6ZqQLbw+QHZ08ddVM=;
        b=SpiG/TIOFwkjmCI6RvYL7bCf548ulMsDTsjor0DrMRu8Ns6pcrq2jc9eYkJ6bN9ikJ
         r5b+wgKd+En2Go7Oknw8OSnnuTkHvuZ2VgTbtvTxrQWvPNGPGQ9lN4E0hnvy+nV+md/R
         S26xWHnk61omoFcnnTMrYWva4zPP5lVRba3vwzX18/JEg0wPhBrOTn1PniuXvev5rrdJ
         sMKlUUp2wZk7vEKlThZ2jrm5rX9KlP9bUUe0ebw3SKpiTDrp4A62Od21bicm4OzOEujJ
         IiPKf42IdkXekhLnF5pCmlpyIub/8UUDLNi54zeuX75EOKdqlWs+3oiC5bmThy4Wi6Ug
         gd+w==
X-Forwarded-Encrypted: i=1; AJvYcCUvnI52wJbIaDZuRfWLEZxlRYt0MmCjeYcX1RiRTZtPG/sL3Pyq0FC0aRDP30K6pRVqvRu8+0or0bfqtGtb5e3c8Gr7ImvKRaa2
X-Gm-Message-State: AOJu0YyErYEwqEusoUu8O1YT30gqxNKY8BnARz8Zs0urip5Cmf/z0JFP
	QUGtnf/R/3G4bx5R3JgurYVEQ1/ves2yJosRD7kSRLLBvtykHn6Gy/Je8cY9Dx9RqL/EANbZKj3
	kgUs/hEKQ1iz3llhepfy/l5cg8/ych8hQM9PB
X-Google-Smtp-Source: AGHT+IGRy0gu7DJBvWKqWoz9wMaZQl6qm+9GyPL+x14BBkTcpVqF+6SVukjVmu4uMkeojXS8ScmMTTt9kUPIJCorAGg=
X-Received: by 2002:a05:6122:4113:b0:4bd:32c9:acb with SMTP id
 ce19-20020a056122411300b004bd32c90acbmr3187376vkb.7.1714147137594; Fri, 26
 Apr 2024 08:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Y6NJGz6f8hE4kRDUTGgCj+jddUyHeD_8ocFBkARr7w90jmBw@mail.gmail.com>
 <20240416050353.GI112498@black.fi.intel.com> <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com> <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com> <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com> <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com> <20240426045207.GI112498@black.fi.intel.com>
In-Reply-To: <20240426045207.GI112498@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Fri, 26 Apr 2024 11:58:46 -0400
Message-ID: <CA+Y6NJHzr7x-0S0fbgKJyRjvHMSrbyBNert83g_qVZDS=2wA2g@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

> This way you can identify the xHCI (well and NHI) that are not behind
> PCIe tunnel so that should mean they are really part of the host system
> (being soldered or plugged to the PCIe slot or so). If I understood
> right this is what you were looking for, correct?

Yes! Thank you for the explanation.

