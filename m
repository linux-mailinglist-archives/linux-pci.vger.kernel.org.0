Return-Path: <linux-pci+bounces-1194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4428B819477
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 00:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C835CB24E14
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F251E3D0CC;
	Tue, 19 Dec 2023 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdwvhUAb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D83D0C7
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3d0faf262so17181935ad.3
        for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 15:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703027991; x=1703632791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naZ4uMi790EFZrPqxgBl4T+4PPnrRSn0penDYmzHk9o=;
        b=GdwvhUAbftyTZR4/QO015ijWX+BLu6ra0U9I4P0TIMAIlY8Mr7m3AYdFWCfmeQzl8T
         Zgv+Scl9uUKYR+drw7hcpJqo3EQB1WW7Z+fWxR+ggY2pEMIxjdWe1QWDJMMdO7IQMKk1
         1qC5T4GNWzHTUwxuSho132MSjSyLnkt5NCuVowEFWoO6ZWW9DKMyzHw2ULBL2Xvwfv73
         70zW9a6vFElwq6Y8Z7iY46oWs2zTkGxFh4IIWaWMzpLlV7kPrJaqILuL06YOEq9H8ESN
         4yW1MMYfCYMs7a/diL8hFUTwIEf2L7UY0YHhYxFwGBU03Mqcx20Xdu0ZRv4QfUYbczaB
         97rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703027991; x=1703632791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=naZ4uMi790EFZrPqxgBl4T+4PPnrRSn0penDYmzHk9o=;
        b=jPbXog/3rbJL2vI0dhxkXgakq0sqn3JzYtSttqjrAk4MXVQyE9wZSYO7LVjuHANCH5
         N3HoK13Vl4W1b0bCou7WJfzt34PMLeFowX7YbO3E7ekPwxl685LSsvM36yVkRVlN3f06
         QsajVLSnrIGREWTzJB44GpfGwzRnYzIQGPFsz2eyWGB2qwLlFomqeFYDhzup4Reo/gTd
         GX3aB4lPd6oaB/SRGVP1s9CNskb03TOdBhUtu+6M93ODLCssmEmS84pRJdODj0IQXHwk
         WcMnKjdyGoPb7hcezHrcE2GKsiz8w4srgu/2Fgo7OFbzQENrLSmY03l6I3YQMUhSoFUK
         AC0Q==
X-Gm-Message-State: AOJu0Yz2KVYiGs+9xNszc4CHUF1Kv2D8ZzxoftYODz+Lw9r/t7QLjKyH
	XA2xF/TRkqHmtrVnT852GfWIelAyfu51ZR29VVaBlA==
X-Google-Smtp-Source: AGHT+IEgUTTRw6pkK9hBeHFtUPbceIAdQWGR/C2DNbsS2pByg4eq1LDlboS74Ab4n/Roe9nvBssmLNvSnUq5gRcHd2Y=
X-Received: by 2002:a17:902:7d8a:b0:1d0:9471:808d with SMTP id
 a10-20020a1709027d8a00b001d09471808dmr16814587plm.93.1703027990701; Tue, 19
 Dec 2023 15:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org> <ZYIWHjr0U08tIHOk@google.com>
In-Reply-To: <ZYIWHjr0U08tIHOk@google.com>
From: Esther Shimanovich <eshima@google.com>
Date: Tue, 19 Dec 2023 18:19:39 -0500
Message-ID: <CAK5fCsA0ecsWeQgV-gk=9KCkjDMcgaBj8Zh6XP8jAam-Cp0COA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

> Maybe use PCI_VENDOR_ID_LENOVO and move the check first - it is cheaper
> than string comparison. In general, symbolic constants are preferred to
> magic numbers.

That makes sense! Will do.

> Actually, do we really need to check DMI given the checks below?

I was advised by Rajat Jain to check DMI. This is the reasoning he
gave me: "I'm not certain if you can use subsystem vendor alone
because, subsystem vendor & ID are defined by the PCI device vendor I
think (Intel here). What if Intel sold the same bridges to another
company and has the same subsystem vendor / ID."
To me it seems like each company in practice has a different subsystem
ID, but I don't know enough to confirm this 100%. If you are confident
that the subsystem IDs are sufficient, let me know and I'm happy to
switch them.
I'd appreciate some more insight on this before I remove the DMI checks!

>
> > +
> > +     /* Not all 0x15d3 components are external facing */
> > +     if (dev->device == 0x15d3 &&
>
> Again, maybe PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE?

Oh! I missed that. Will use, thanks!

