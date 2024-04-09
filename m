Return-Path: <linux-pci+bounces-5976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D789E4BB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 23:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E961F23185
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346F158864;
	Tue,  9 Apr 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhYFTx5j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700E28562A;
	Tue,  9 Apr 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712696770; cv=none; b=iWLKJbZwvfiKRCxNtiCSzDNb0dhqY0eq3wZno4P3BhdVmJxcQHR2ppAo5yMAjWn+RUlocT8uY7Gnvj38qcKdDFo2onSF5UBXsxItyybsJQ2WFt70bRbk9z2CcWd1H31CRaCdv7hc27GjWWm8TDV4XKRhwKpIwQhgFJfNudOiUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712696770; c=relaxed/simple;
	bh=6z1+RdCcqb/CBTYitm+BtQkT5A1/JzJsiQV8l07KZ6o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KpDLoyoU1/Nbu9lKI0NYw4rwYpPF5WKaCny3JPqQyD9alifAIR3NkGKcGFztcJkAr2KV8elt7rfKmTfD8InGCzdUvvPQRTQErgsz1ndlg4afvo/2hSaJohdK8ZBMkI9itKq4lW4rroLOu3r8G485b4hgbbLYTamDaN0VmzfApik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhYFTx5j; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78a2a97c296so351857385a.2;
        Tue, 09 Apr 2024 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712696767; x=1713301567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiiaHNmJsReIJo5FVxsSThVW7lNMMSYq5RIKd+Z8MPg=;
        b=MhYFTx5jt1432Xoh6tetjHeRrjkwOksZnlAOMYJac42OTDnclPnslRDsCL7iJaM652
         a+wBtSpRykkBnL8xqA/k0jRjzGmEZYOBHLmrye1BTjjPUzR0wraKDjSz8PU+UyfGe7Xh
         XfsILerENZvDrWnc5dRy5hW7uOSdjetZO8z0g0KdHy+NYmW/LzyenMtEXacwbAM8HYD0
         lyBCnN68dBC5v+zHTbwY3NCIgbTlNpQWzC4TTMtXoeoa/libEc3Ly5ehXflhVcq5DibA
         wQBuBQO1OVW6N4zbmqyuCP/420oqJ8xEyhlvsDlMGXgBjJYtQg8kqBu0DDcTHZ/1alPw
         7yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712696767; x=1713301567;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EiiaHNmJsReIJo5FVxsSThVW7lNMMSYq5RIKd+Z8MPg=;
        b=LIaIKrHwRsPdtHZgVFVAEau8Gb3NbdN2EHuxkB0+QndmTwlfZnRrkUicqNk18G7an2
         Hzz/XRQRluUuLBDAjF0Kd3bM1T2prn4FQ35sidLIIdPjTct/GNHWu8FTtJSuyEmK7U7f
         Vxwxpp1Rn03OVtZXSLEbEH8roWh6dUA45BBoGbnbxNi2MZXWdKkHutEz2TsG4kqJ1WXv
         Iv/hY1/bBtsBITfvqRnRlAtAMIF985ZW6PwjVYgA5HAZrCM/rlGrtGR2+Di0+XRf0VL1
         NbMIjYit+JVYBJMyRcrn7hiBISO8t96Ep8aU0B647523hogAVoPdDA/Kg0mKO4O9Xl3m
         Co2A==
X-Forwarded-Encrypted: i=1; AJvYcCWI3yM2u9+sSKKgxsPcABxA6gAiye9QtXcvV+7rpMUOVUf77T4S+ZIIjsFX+ZP8INrcZUqSl+sYh0+w6ySiDcEgDM/UYeydnJaXY+khnY3SmurMudxw7I2V6QmhSipMPYKW
X-Gm-Message-State: AOJu0YyM/+GXLimvinN6RqPyyX2VyuEXYOgH0H/rgLkMk+jv5jMl+icj
	YPLkkSbuBc1PB+GqV5c2cz3OTcm70U2jkdsKpvnPRuWQJi2hTdlX
X-Google-Smtp-Source: AGHT+IGRCjM3Wztikucl9H4B8RXePYAYxBhfjiF2FaTYXzsdrz6I9+iPcOkSwkQYid4Jg9kxZ1aEcw==
X-Received: by 2002:a05:620a:1113:b0:78d:74f8:a333 with SMTP id o19-20020a05620a111300b0078d74f8a333mr943344qkk.27.1712696767188;
        Tue, 09 Apr 2024 14:06:07 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a166700b0078d671c943fsm2093400qko.45.2024.04.09.14.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:06:06 -0700 (PDT)
Date: Tue, 09 Apr 2024 17:06:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 pabeni@redhat.com, 
 John Fastabend <john.fastabend@gmail.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Edward Cree <ecree.xilinx@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, 
 netdev@vger.kernel.org, 
 bhelgaas@google.com, 
 linux-pci@vger.kernel.org, 
 Alexander Duyck <alexanderduyck@fb.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <6615adbde1430_249cf52944@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240409135142.692ed5d9@kernel.org>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 03 Apr 2024 13:08:24 -0700 Alexander Duyck wrote:
> > This patch set includes the necessary patches to enable basic Tx and Rx
> > over the Meta Platforms Host Network Interface. To do this we introduce a
> > new driver and driver and directories in the form of
> > "drivers/net/ethernet/meta/fbnic".
> 
> Let me try to restate some takeaways and ask for further clarification
> on the main question...
> 
> First, I think there's broad support for merging the driver itself.
> 
> IIUC there is also broad support to raise the expectations from
> maintainers of drivers for private devices, specifically that they will:
>  - receive weaker "no regression" guarantees
>  - help with refactoring / adapting their drivers more actively
>  - not get upset when we delete those drivers if they stop participating
> 
> If you think that the drivers should be merged *without* setting these
> expectations, please speak up.
> 
> Nobody picked me up on the suggestion to use the CI as a proactive
> check whether the maintainer / owner is still paying attention, 
> but okay :(
> 
> 
> What is less clear to me is what do we do about uAPI / core changes.
> Of those who touched on the subject - few people seem to be curious /
> welcoming to any reasonable features coming out for private devices
> (John, Olek, Florian)? Others are more cautious focusing on blast
> radius and referring to the "two driver rule" (Daniel, Paolo)?
> Whether that means outright ban on touching common code or uAPI
> in ways which aren't exercised by commercial NICs, is unclear. 
> Andrew and Ed did not address the question directly AFAICT.
> 
> Is my reading correct? Does anyone have an opinion on whether we should
> try to dig more into this question prior to merging the driver, and
> set some ground rules? Or proceed and learn by doing?

Thanks for summarizing. That was my reading too

Two distict questions

1. whether a standard driver is as admissible if the device is not
   available on the open market.

2. whether new device features can be supported without at least
   two available devices supporting it.

FWIW, +1 for 1 from me. Any serious device that exists in quantity
and is properly maintained should be in-tree.

In terms of trusting Meta, it is less about karma, but an indication
of these two requirements when the driver first appears. We would not
want to merge vaporware drivers from unknown sources or university
research projects.

2 is out of scope for this series. But I would always want to hear
about potential new features that an organization finds valuable
enough to implement. Rather than a blanket rule against them.


