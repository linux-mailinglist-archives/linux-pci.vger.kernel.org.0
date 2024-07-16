Return-Path: <linux-pci+bounces-10383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1DD932F9A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 20:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119561F23D14
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 18:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D41A00EF;
	Tue, 16 Jul 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OJYmjMbi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7754BD4
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152945; cv=none; b=fnxbsFUo+iGRKo3xFYw8itsI+pNDeoTTigM4GBmOXM2rkNOWCFKLMNxWrSdRbBQBzw1oiCv8aI4NZRfo6sKhSt5juRn7f8A0eCbPRwHN6sf+m/vXI/fVKBmQyoNQnV12GjwdMucCc0TnNdnMLTVUfEzLp1JIkNOgUNbV/dCZhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152945; c=relaxed/simple;
	bh=AXDvP7/UmEbrryVE943UNdrWU5PiS7V0l28WHbhrZ9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6rua8llfm3Ajsbhz16ge2kgTuRHB4jPYo3dcpYsmq2r9Q4r6Q65RLgIgDpKhc5udtsQpEWO2UNEHAX3VNUkbD5ikfy6tzh1EH6lGea/atoD/iF2IMjSXk2SIxOKdHrrs+Pm9HeVdCR4jWI5SWcN0rKC7FG9f+rMm0tYwPPO47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OJYmjMbi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a79a7d1a0dbso477548366b.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721152941; x=1721757741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IOCx9jSH+Kwj05EqOSaKkaYB3+Y38iYxRASkxIAb7vg=;
        b=OJYmjMbikrnLvLsOUBd0j1e/VTgzKmXJWpBwCC1H7ryMIKlsxOeRq6mlCEaQD5UwvJ
         YnKHDzp4qT4Ce1i3DWBb+ByQ5i1c98StrGuCaI+gHjOC9+2eNVcXUMMOOzZRyQjt6e8s
         zPYdoDNkuxtYAMfZS2ZSkPW1+CEpPKqlJl0Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721152941; x=1721757741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOCx9jSH+Kwj05EqOSaKkaYB3+Y38iYxRASkxIAb7vg=;
        b=pFSOb2EhfpQxmmzpLdO1EdMShnFjstcBiycYzVIB+dpU7KZ0DhCJXjzwhEChf7uQ0Q
         0SdP1haVOruFJy9lDQS3Vhslx4PCGa1sP4ne+OvU/CnNXIm2uA/fxoNNSHty3AsDrmN1
         ewdOq2mKn8h2BWG3JbQzKRq8AyTo+m6wJj4+D+wc19X821/j3jcSYlxnl6ni7+DwcQ0l
         h7WrtIHWRl97JOVe+nEjfPLJ7zdh1K3SqaH/2pvTfCMwpOqKvccuA1lcZIdx1/k3hP6X
         j56dt9CVfTrAIlfawOPp8VlppsQhGcUcBicQYuDd5Ke4nByzu//bn+l6kpVRIP8PjwN1
         Iy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZvYPkerzt7QxhI4CNC0MZueUbeYTLtcnP/0SqtpaBRkXQ/ymLZbhV8L0bMgsrjFvH7UdBiRf0777Bif0Zho5uKByDyU6paFz4
X-Gm-Message-State: AOJu0YxN8Xolxt1ZPuhi5O0u8fFr9QE0L7orUScuqjc/4Ewb/QrdNo4t
	IsfIZnVyA2USOcEEvPQjidNSF7HonDxfp2JufPPGjRvUAsHD5fbZrp276jHXiSWIuJPOJsLwVEW
	767ozhA==
X-Google-Smtp-Source: AGHT+IFy58IVMuBxejZ4Alquwg3WxvtbC6fpCcAdw57cuAiEKbn5OT0OtSxY+jnM7rldMRM9R7NcOw==
X-Received: by 2002:a17:906:b148:b0:a79:7f16:8fba with SMTP id a640c23a62f3a-a79eaa5b725mr175391066b.59.1721152940409;
        Tue, 16 Jul 2024 11:02:20 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc822b36sm341293466b.223.2024.07.16.11.02.19
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:02:19 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58b966b41fbso7382197a12.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 11:02:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUStl4F6CgSaSQeIwK8U/kSKgSEgcKCvnS4FByzRvwEPha5nXHmdypW2ohzDRVeuTp9u/ggshAVQm7JNrY0WR2VJ1nrK5Kvn9V1
X-Received: by 2002:a05:6402:2106:b0:582:ca34:31b1 with SMTP id
 4fb4d7f45d1cf-59eeef3d862mr2165623a12.16.1721152939113; Tue, 16 Jul 2024
 11:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20240716080418.34426-1-manivannan.sadhasivam@linaro.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 11:02:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxiAvNJejbpMbn_CMYzU97uHFPiRmYQ5Gaxw56UyK8sA@mail.gmail.com>
Message-ID: <CAHk-=wjxiAvNJejbpMbn_CMYzU97uHFPiRmYQ5Gaxw56UyK8sA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Check for the existence of 'dev.of_node' before
 calling of_platform_populate()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 01:04, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> -       if (IS_ENABLED(CONFIG_OF) && pci_is_bridge(dev)) {
> +       if (IS_ENABLED(CONFIG_OF) && dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
>                 retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
>                                               &dev->dev);

I think you should just drop the IS_ENABLED(CONFIG_OF) check entirely.

afaik, dev_of_node() already returns NULL if CONFIG_OF isn't set.

So the bug was literally that you based the decision on something
pointless that shouldn't be there at all.

                Linus

