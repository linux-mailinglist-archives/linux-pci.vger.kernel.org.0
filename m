Return-Path: <linux-pci+bounces-10384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE59C932FB3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 20:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4171C20EEF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A161A01A6;
	Tue, 16 Jul 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OlsXrQcT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4C111AA
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153334; cv=none; b=Yp0m+44WYbVQhiry6u/LF4DoA/0YZ/wib5ouqtC0zp9wBeV3gXrjY+JCxJJ5eDqLLeGKlGUmfU/zwYLSDK7wQeWoYRXDjq43QbnSXAWtf3Sc3Mm4Lv7+d5RzS1c4NKda9SQUaaTQE7sLdwWlm7jTZdF05/j6mJOrdHvqV8rlu38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153334; c=relaxed/simple;
	bh=qhvpW9ySp0c3Q3YTMvLYSq349/2CtNUgGU8+Fc3TzLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYmiP9rV65C6BU/zw081NcGSmyBgc11xjmGDC6/OWNUI0OD/DJOwXjKVrTJJkXdlwLfYGqgTfE3LTQTrfkd3yeHpgFWOuGFWFNCxMKlOrKJmnkIxjta16rZkjnUu+w55esI6QU60JlQgLf6hdObsYnjBsCGnfV05xhsoy+p6mIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OlsXrQcT; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e976208f8so6345766e87.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721153330; x=1721758130; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KOjYz7yaXpRDTT5QSfg/sdBFbTuHViu6MqiHwYD6nv8=;
        b=OlsXrQcTw3YmwbV8vUTIhDfhRjflVdUKWDMGcYEC/b4EW3A8bh0e4CTU+nbdNfyKpT
         VxOBMPXukfUG/bVrPyvYQuf2eVOrfc3OYQqbY/0jnqVGY6BCoJqh2aGZTv3M33vfmT+G
         Dck2ys6z68rHiFzrAiSagq7p8uqWwxqDrahYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721153330; x=1721758130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOjYz7yaXpRDTT5QSfg/sdBFbTuHViu6MqiHwYD6nv8=;
        b=i/UIlSYGBQ1d5QsuuSm/k4E8FqnsEWfxNrhvYmI7K71aUrlWpO3xr4u7+WONzmrz2e
         Ewsd2xf7wGnbETWBLLYy3Q+JgDpb5+kFY1DsN3XXok/UaygMmnpd38lZnOyfIOukbDZc
         SEDsacCz5ij1T0sM0IjPzv67FLBRDfWvOselW9ZbsBcdytTteLiAKnMTKD4kGJOS0twl
         nvm1Q+/hylpByM1ize4aaILb/ezLjbBfNuPKGb2/ji2Iv1G1nvUm1l+ZtxDLxKdhI/tJ
         o9JVLxLtlHHPQh3a5ZdPuKJ6H7WW8nT0MbvRwR9NJJ4ryUc/HxydGBEOrZorakKBXYrP
         Fi/w==
X-Forwarded-Encrypted: i=1; AJvYcCVKtI4t8xlJlanQZk0CWvgTtE3b6/DM+7VqdnNKda18AO86n70u7uwuNT/XMS3qW2doTGsY215Oxd9xe80OusYRLDgxf0MmwQmD
X-Gm-Message-State: AOJu0Yypdcyv5zmqnxNiF3dVAIxf0vIFsAwxfX2GhwZp4eZIzDHvkBuH
	risqQDyisq+CO4ycyLpNsNtSU9JRGVsiUiTLdN43KKD7n8HS+ZpD+pjfS9H7RrwQMX6i+Xly299
	DE5jzrg==
X-Google-Smtp-Source: AGHT+IFa6JfXfn2kHhNPEuDEenkEQVhUubLwvm6wbZe3UIulowzS24gBn2wF4iYEuw3vKb+yb+dSnQ==
X-Received: by 2002:a05:6512:104e:b0:52c:d70d:5ff8 with SMTP id 2adb3069b0e04-52edef1039cmr1817712e87.1.1721153330346;
        Tue, 16 Jul 2024 11:08:50 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed25396edsm1204567e87.293.2024.07.16.11.08.49
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 11:08:49 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eedebccfa4so40180081fa.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 11:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9XE0k2SoQ+joDvcE4822nIrrE+7vH6u6FD+nvmMSNrk5akPc/tP4bC2MVfxVG1QYOX3jERBY54rNmC6MWu2OLWnullSVELs5L
X-Received: by 2002:a2e:9acd:0:b0:2ee:56b0:38e3 with SMTP id
 38308e7fff4ca-2eef4184785mr22070261fa.24.1721153329186; Tue, 16 Jul 2024
 11:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl>
In-Reply-To: <20240716152318.207178-1-brgl@bgdev.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 11:08:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
Message-ID: <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 08:23, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Let's remove the public menuconfig entry for PCI pwrctl and instead
> default the relevant symbol to 'm' only for the architectures that
> actually need it.

This feels like you should just use "select" instead.

IOW, don't make PCI_PWRCTL_PWRSEQ a question at all. Instead, have the
drivers that need it just select it automatically.

It's much better to ask people "do you have hardware XYZ" that they
can hopefully answer, and then we enable all the things that hardware
needs.

In contrast, asking people "do you need support for ABC?" when they
don't know what ABC is is _not_ helpful.

IOW, when you write Kconfig entries, your rules should be:

 - NOTHING is ever enabled by default, unless it's an old feature that
was enabled before and got split out (so that "make oldconfig" gives a
working kernel)

 - you NEVER ask questions that normal people can't answer.

For example, we have *way* too many questions that come about because
some developer went "I don't know what the answer is, I'll just make
it a Kconfig option". And I absolutely *HATE* those questions. Dammit,
if the developer doesn't know, then a user sure as hell doesn't
either.

I tend to keep on harping on Kconfig issues, because I really do think
that it's one of the biggest hurdles for normal users to just build
their own kernels. We make the rest of the build system pretty damn
simple, with a simple "make" and then as root "make modules_install
install".

But the Kconfig phase is a complete disaster, and it's because kernel
developers don't seem to think about users.

              Linus

