Return-Path: <linux-pci+bounces-6066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788F489FF5D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204DB28598C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C921C168DC;
	Wed, 10 Apr 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asZwmk2j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219017F375;
	Wed, 10 Apr 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772144; cv=none; b=TMnurK8r3TwszRij71Jz9GtRZ7ESnKLVXWxFn/jcLk2eLlRPofgMRpbxesu6HQgi+LAHc+37xns4LveWjEtfQuBMueJNBFS5iXzdjbQSXw9Jg1ckM5WdyaEd7LGydjyjvhnw/jJXETURU8FxUFXuF1qED7krqShDNjxQEvrfoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772144; c=relaxed/simple;
	bh=SF0DOlftT3bvJ0SugCbfUTQk4ZqES+e+ba2nfAdU5cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5tpXDpY/B0P0PNiHPto64fe9hyDxJRgLMgQIjrdjZYH3LgI/Kw1AospFu0aJLI0+VjB/N+v0vaKPL/iK6NXKg1wWMEur7XZVKSQkrYeNWOXM+0neFvyZPg3urk6hx8ZZTUsY92y1SLS92R9ynHqZDJdo0mXUz+Sj8VmUkitawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asZwmk2j; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-343c891bca5so4514479f8f.2;
        Wed, 10 Apr 2024 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712772141; x=1713376941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HcBD/gKktJyzAHMEF27IwG0hfzD4wEUK2R8iNqn8Xg=;
        b=asZwmk2jCrQOWcwtgICnNdiyYcch6HRQjY67E1RLruO32wssYNXJ3nFD6G3HUiLcIC
         /UG+d1QkA5ZjzzeRMUJfQQWglwjCefxBZA/CggJJi+H7+UMBrbMkFnKy/PLxUpFw7XpH
         QwzJOL9UeBklVtPqF9jQw7cnyuMkPpcXY0PQJePEYazhiZYXBr7fMap7I8oHScs2xFBd
         +vMM9bqr70NVl72GMIjY+yuED4AyWgXwRCTXcs7orkDeQiAmxXTAeEbH8Hbiu/DskccE
         A6MTK3d+tgT0kTQdqPLXTLxolMUHC4truneUxQYUSxRZnPZ73ZTzmVeO0TTlH1AwaBc/
         MSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772141; x=1713376941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HcBD/gKktJyzAHMEF27IwG0hfzD4wEUK2R8iNqn8Xg=;
        b=C54Rg8eXyH9cBWdgK2q3NM/y0pCPOms2TmEPiaiv9xcMwJkRMr++a/C4OqRnRISLdJ
         twrxNJ0DmZu3w78Vj/tSf6rWYF5DPe9lqtPurZWI4bc6rckknD2tv7rahHLhW7pEFT/S
         gpiEsQdx/S8I4kI8rMT/jKvasNLv5HChHoWklTMs3UUlLAba1NKPSdf1KPeyyqDIbxn9
         MOZxSWJWYl2xZKeU50F0VzlkvWkneoSXjaR01oi1XSbTq4EkIQWaqfW9atYROpeDUWj1
         nhK2fmL1k35Y59Je+as69LmwT7Sp3RQAg9qGcr4D9Kv/j/Pqzl9YaVTGOSCoINnKMUKL
         d2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmprwWU7lNPqV40XJtnGyJSLdcKYJdkzWNjB1knQJIAcc9+9VFVbpm6SLfBl9Am1HtsPijne3HtB2Ov1fPUr6YgNJ88ncW2BZHpYgZLoKsUISri/5Ga1LkdeEx74anKt7x
X-Gm-Message-State: AOJu0Yxj5SrqCA+A+YNNlnJMRh4UNLsOcZpzULjln2T3rKkA+jXMh70K
	wmSH6rGIdITkTbgteCQKfIx0JVl/f/+Tb1AnVU0MNSHmMFr+vMQn/TEhXXuBYP8ZEggzivwUv9W
	FdWQQiarm2IbtqZYuuBXeZQTNtiY=
X-Google-Smtp-Source: AGHT+IEMPhmw4jFoob0u+AdokmDvVGexr2AbVomA7M1ZzA9cQShiyIp9A6OVmF3K+AJBAGwQGfnGYOJa+WN76UkFDV8=
X-Received: by 2002:a5d:62c4:0:b0:33e:7f51:c2f9 with SMTP id
 o4-20020a5d62c4000000b0033e7f51c2f9mr2562437wrv.49.1712772141370; Wed, 10 Apr
 2024 11:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org> <ZhZC1kKMCKRvgIhd@nanopsycho>
 <20240410064611.553c22e9@kernel.org> <ZhasUvIMdewdM3KI@nanopsycho>
 <20240410103531.46437def@kernel.org> <c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
 <20240410105619.3c19d189@kernel.org>
In-Reply-To: <20240410105619.3c19d189@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 10 Apr 2024 11:01:44 -0700
Message-ID: <CAKgT0UepNfYJN73J9LRWwAGqQ7YPwQUNTXff3PTN26DpwWix8Q@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, pabeni@redhat.com, 
	John Fastabend <john.fastabend@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andrew Lunn <andrew@lunn.ch>, Daniel Borkmann <daniel@iogearbox.net>, 
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 10 Apr 2024 10:39:11 -0700 Florian Fainelli wrote:
> > > Hm, we currently group by vendor but the fact it's a private device
> > > is probably more important indeed. For example if Google submits
> > > a driver for a private device it may be confusing what's public
> > > cloud (which I think/hope GVE is) and what's fully private.
> > >
> > > So we could categorize by the characteristic rather than vendor:
> > >
> > > drivers/net/ethernet/${term}/fbnic/
> > >
> > > I'm afraid it may be hard for us to agree on an accurate term, tho.
> > > "Unused" sounds.. odd, we don't keep unused code, "private"
> > > sounds like we granted someone special right not took some away,
> > > maybe "exclusive"? Or "besteffort"? Or "staging" :D  IDK.
> >
> > Do we really need that categorization at the directory/filesystem level=
?
> > cannot we just document it clearly in the Kconfig help text and under
> > Documentation/networking/?
>
> From the reviewer perspective I think we will just remember.
> If some newcomer tries to do refactoring they may benefit from seeing
> this is a special device and more help is offered. Dunno if a newcomer
> would look at the right docs.
>
> Whether it's more "paperwork" than we'll actually gain, I have no idea.
> I may not be the best person to comment.

Are we going to go through and retro-actively move some of the drivers
that are already there that are exclusive to specific companies? That
is the bigger issue as I see it. It has already been brought up that
idpf is exclusive. In addition several other people have reached out
to me about other devices that are exclusive to other organizations.

I don't see any value in it as it would just encourage people to lie
in order to avoid being put in what would essentially become a
blacklisted directory.

If we are going to be trying to come up with some special status maybe
it makes sense to have some status in the MAINTAINERS file that would
indicate that this driver is exclusive to some organization and not
publicly available so any maintenance would have to be proprietary.

