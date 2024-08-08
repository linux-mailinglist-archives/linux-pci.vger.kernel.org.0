Return-Path: <linux-pci+bounces-11515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BBF94C629
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3991C1F23D4C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 21:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681601494CF;
	Thu,  8 Aug 2024 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD0NbEAy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5FA7E1;
	Thu,  8 Aug 2024 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151193; cv=none; b=pqiw9+OsFf2N0jnfLVN93VuMTSexhcFcBLq/OVjZKB8C+q9CTNC4XDF5KXnk2KrJ89Bb3E1yumK55FIXtoSZ6fdXUssxTwyvI2M0gQQFchxk+cPUY6mQ8PQXXu0PTWimFBUwZnJXaqK95xLpPFTtsFljgJukCy4gVSXriah8Oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151193; c=relaxed/simple;
	bh=2KhSXvEi+4E0vAWvEqIBh/2CHUHT/ogt2idkJScSSbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TuT61rWHETNIv+TF5izn3hNNtyxab9M8kvOwv6adkzDmuEtaS4SUTrMobhedaWcUdRJlWX0+Szl3mmRm6JTM+0Q9FB5VWa8xKqyzqjVsz9FN5dILsoko4JNX6J/UDS+bZZU/FlsyiQ+Lai30wT/miisjI+BtfVqO8Qm2hsXNHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD0NbEAy; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fded90c41so7353521cf.3;
        Thu, 08 Aug 2024 14:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723151191; x=1723755991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=um7RbV0IrsDEC/LVZ0wcfpKaFxjLE/jsVz1wJxiXSzY=;
        b=FD0NbEAyRUUMfzywvFipJgfv7glwUf3O0w/XQRsttqO8SPGXMxMta5LB0bLRVE1rwo
         JXL+laCyZE/chqoN3tQH5FkfLBDs8UUYU0nGAjeq7p3TLZYtjOuUwfrh7jG1tJ013G59
         FDmUhvY1SWd0q/X/8BSujxQ5jAlIB1/DPoA+1Y0fjtLFxLmnERc90lisHLOqsUNW9F1T
         5sT3qfii0Ii1mdMqr/s7kv9FwSdX7gLW8w0tYqSCE4Ih0EQAKubqQolkH775WOZcErJr
         ni8sGJZu3/g233UBi/1z+BMztsF8oHVvQahGAkLNvOae0ZdqFHhvRh1CQaxFjkoVK+lx
         jCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723151191; x=1723755991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=um7RbV0IrsDEC/LVZ0wcfpKaFxjLE/jsVz1wJxiXSzY=;
        b=u15ZfXi58Prto31kgYlH6cEVDeM0dcv5UO69XvP76xcp8WX1DibpHf3fEjAbhOs8SI
         AYikdPxv5J/cU4frz3ytfsssn1NCCjwPaqA8UEj8k6cQKPqUviSEs4M7cdo92nVF3L/a
         uNQsIEjFQ6y4+kd8bU7beF00IFCeVL6x7HRebeY1d3x7eaTHZ3EUf8IQmW6jcHjaKcPY
         0sC5kqVurxNTb8/YJ/IZwTH3NK7UWRQMp5SB8Q+TPpFp+Z0Vx5U7bv/EH2s66Kw8M6Lm
         SkvseoOmRURAUFBpc9teT4CbCIqjHuP+b1H0GzY9DK3wu/xRrd4Fup29GH/I9Kj9E6WU
         Vsrg==
X-Forwarded-Encrypted: i=1; AJvYcCVPczP2oOnbhhlH+4nQaIoqBeh+dK6S4pKAvug1W9EH0TJEZgN6stllSoDiUCSpVEmcrlYvCO7z40GvGT2dHPkWfP+6aL1RcTMP4bsGPMWGxDWSWwktZ28JpyOzdbbuwDo243KtQiz8
X-Gm-Message-State: AOJu0Ywke9HsEj13hHytyPZ8QskRgU4lodkiylPF/N8/5NjCTDDVVjtb
	3RvFBQJjopNrZI9MeMFV6w4ZYRzgLT57LZGr/UsKnN29sY9vmwQgYBakRnIxnVPCWZnaSs27sCw
	WOr8RTKj6EHVgFKGb92oMBFPvKO0=
X-Google-Smtp-Source: AGHT+IFaD819WBVk/HK17CFibSNyhPA8oi6zhLiHnkKTrwjvmmTG2vkQYtM2k0e0Wn4586us8DbbN3+Lvcdm4YU02vE=
X-Received: by 2002:a05:622a:514d:b0:44f:f06a:d6f5 with SMTP id
 d75a77b69052e-451d426d4fdmr41234451cf.36.1723151190677; Thu, 08 Aug 2024
 14:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM_RzfZWns316GziuWbX-ZhO-xZm8rhssoC6tAdizGK1s3Ai+g@mail.gmail.com>
 <20240806213602.GA79716@bhelgaas>
In-Reply-To: <20240806213602.GA79716@bhelgaas>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Thu, 8 Aug 2024 18:05:54 -0300
Message-ID: <CAM_RzfYZLVTNgvML3OuBDoupcz4BxWHY3R1mUmVaskD5648x1A@mail.gmail.com>
Subject: Re: [PATCH] PCI: remove type return
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Bjorn Helgaas <helgaas@kernel.org> writes:
>
> On Tue, Aug 06, 2024 at 05:54:15PM -0300, Guilherme Gi=C3=A1como Sim=C3=
=B5es wrote:
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > On Sat, 3 Aug 2024, Guilherme Giacomo Simoes wrote:
> > >
> > > > I can see that the function pci_hp_add_brigde have a int return
> > > > propagation.
> > ...
>
> > > The lack of return value checking seems to be on the list in
> > > pci_hp_add_bridge(). So perhaps the right course of action would be t=
o
> > > handle return values correctly.
> >
> > Ok, so if the right course is for the driver to handle return value,
> > then this is a
> > task for the driver developers, because only they know what to do when
> > pci_hp_add_bridge() doesn't work correctly, right?
>
> pci_hp_add_bridge() is only for hotplug drivers, so the list of
> callers is short and completely under our control.  There's plenty of
> opportunity for improving this.  Beyond just the return value, all the
> callers of pci_hp_add_bridge() should be doing much of the same work
> that could potentially be factored out.
>
> Bjorn

Okay, then what the action that the drivers must be do when the add
bridge is failed?

