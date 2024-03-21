Return-Path: <linux-pci+bounces-4970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C345885727
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 11:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D251F21D40
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 10:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774E55782;
	Thu, 21 Mar 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9q0lhMO"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E121A55C3B
	for <linux-pci@vger.kernel.org>; Thu, 21 Mar 2024 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711015923; cv=none; b=b9UZk9gTOZAGwuNcP4DFIbQdEvJQ7FeMguXeumOYbivGcUbHHDsVwg5q83Mk7IHe623gWL7iZE5RqA8n8e7H5o5mCHjHVA0PTIb5JEbR4qWpMGvJPk9jO3qTa0fSgIa1p0G8mH3IzSnAKE5x71SDEYyDZUVKcpNn4/2cZuyBrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711015923; c=relaxed/simple;
	bh=R7CHpPDE3eO0+xpzoW7CV8qpbp6aH9gxIDGRIDgmy5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Puv2fpK9tdeaianosbLFN0qP5idSfKfLaumi1Ro4i0ZHvl40YnDMjAlcEJay/SKkZCFyZD+snkvCp6a/9ZgfHb4zZRPeCi2zOSKFuZI9psyi2GRPOxFp9sN9EBRK6eLfyC6epT/UENTgvGWXDPemM56Wc+MY+/6EclV9pEHmCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9q0lhMO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711015920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSICzrK/Gb+kcW2nq4Q49G+3Fr2xve4He7DZI7kTjs0=;
	b=Q9q0lhMOY9ObUmQLKNjJnbZFouQQ6ZMvIY2tfYmdEJT9AarDmcHqXVKHbpsNwtbns+Vqzk
	yGZR2qZ82yX0m+eGDCFRF21vuB2Jm2w0DUKFXQL7o6TRecgbYu9xNQeUGMUK7zRlvKiPme
	Td2pVH803j8suN4GNiXA81m36ZepFC0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-hq9Po5YHO_K_u03YX0KF1g-1; Thu, 21 Mar 2024 06:11:59 -0400
X-MC-Unique: hq9Po5YHO_K_u03YX0KF1g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29df3d9c644so629439a91.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Mar 2024 03:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711015918; x=1711620718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSICzrK/Gb+kcW2nq4Q49G+3Fr2xve4He7DZI7kTjs0=;
        b=jAVdrjJuaFPeD08hzt9Ur+t45MkSf1JY7+s6g3Mv631RToajnpDJK1rH7vlk5pCdBg
         DQY1VRkmURz/FdPM5kkNghpdL8e0UnJjhzHWE5PAsSAv7JEFClFsXKMPhCt6xF3USBOY
         WdNXcDj3vBOmTVmrnDtRAFhCVGRsf4uhMKflVjazhg5H1ecK1qfC7FpAw/1nFe2LUVUJ
         t2SHlvJhCkrC1aFZPJYHT53mz3YIGbIJVsirSjN6CIWsnX6HHrDqI81MJ49c+yvc4EfK
         lhgdXAhLPZ5y35BspOCjRDp1FklsyK5ha7Q+yP+Fx+Ng2fweKHT3HPH3LtkH66wQnGT3
         OgcQ==
X-Gm-Message-State: AOJu0YxyWGycMdnRj/apI8Aa/Ek0JE/LbIhP5EWO8Kd5V7ocs9Byj0FE
	ZflOyJpL1ZrO1VR7zE69y5ss1yLNDcB8GEucjUPoIjWKg1XLWznZM70sT/QovzabYpjcLC7MT65
	WNpXim+yld1buEbCuxB44DmelfDZhWw2Clmf6sseKkMCFviwJOLnK3eEC4fqt+ZhKr9nrzCb8bD
	iYj0rUnmVeZjVgYQGOauHkKHhHvD9quFratbvZsBOn1yU=
X-Received: by 2002:a17:90a:4d83:b0:29d:faf2:43d with SMTP id m3-20020a17090a4d8300b0029dfaf2043dmr5242492pjh.21.1711015917762;
        Thu, 21 Mar 2024 03:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6lHbSs7zWw0q5Wh8rmHNIjXqB46F8LIC85hika7+qZSmfFBFMIZT5IACc+puO2Mt0+EggUUkrLnaLhPHD/vQ=
X-Received: by 2002:a17:90a:4d83:b0:29d:faf2:43d with SMTP id
 m3-20020a17090a4d8300b0029dfaf2043dmr5242480pjh.21.1711015917440; Thu, 21 Mar
 2024 03:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGVVp+WDQXvFB2xEs=8pU02qseVHCWJvEVv5RRZFQnHbJFa=cw@mail.gmail.com>
 <20240320024647.GA1254126@bhelgaas>
In-Reply-To: <20240320024647.GA1254126@bhelgaas>
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 21 Mar 2024 18:11:46 +0800
Message-ID: <CAGVVp+WPJZO50=-egr+67x9uePf3y4LS-85iCT_aEtSf=LASZw@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 0 PID: 226 at drivers/pci/pci.c:2236 pci_disable_device+0xf4/0x100
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:46=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Wed, Mar 20, 2024 at 10:16:06AM +0800, Changhui Zhong wrote:
> > On Wed, Mar 20, 2024 at 12:30=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > On Tue, Mar 19, 2024 at 03:34:56PM +0800, Changhui Zhong wrote:
> > > > repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
> > > > branch: master
> > > > commit HEAD:b3603fcb79b1036acae10602bffc4855a4b9af80
> > >
> > > Where's the rest of this?  I don't see "WARNING: CPU: 0 PID: 226 at
> > > drivers/pci/pci.c:2236" in the snippet below.  Please include or post
> > > the complete dmesg log.
> > >
> > > Is this reproducible?  If so, how?  And is it a regression?
> >
> > it reproduceible=EF=BC=8CI can trigger it every time on my server=EF=BC=
=8Cbut I'm not
> > sure if it is a regression=EF=BC=8C
>
> Great, it's always easier if it's easily reproducible.  Can you please
> try an older kernel, e.g., v6.8?
>

I tested v6.8 and v6.7 both triggered this issue,
and not trigger this issue on v6.6


