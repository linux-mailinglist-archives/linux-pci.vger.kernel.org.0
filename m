Return-Path: <linux-pci+bounces-4302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A886DE4A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 10:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853851F28066
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BF32EB0E;
	Fri,  1 Mar 2024 09:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA1SLuBa"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006706A037
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285390; cv=none; b=gTLPlLV2snYUeBQk5MUOn22IS89j57jmt2k+bAUJXkCtjH7FGFyU9jMy2hk/9C1WV0UZXS4HOhYqiUVpuBZDk9/HEkh4kG5QTDgJlny263sebJ7zNlR62k9hLm1ft1s0b4ozo1vEbnkmQIfC4ZsN7jLGw07SudBTOj33OuIHSHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285390; c=relaxed/simple;
	bh=xUzguapjnO/ASwX7eqgiIKisU9asefIceRf+xZr60sc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kdVGrknkUdFCM2aIFYoIFv3gbdWnJ8aAMJyswBYTCZnaNCUDCwP/+Zfha6IqRL9X3r6pO2gLeeEyaF+cfcfpzKXtz9IiyVCpcqI3R9dRKBnDz5nokwUsYXQYy2TiM+qLTmmCgqAhXQPSu41nT+J2K0fuYRWo5Bc1ux2MiuRwIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IA1SLuBa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709285387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUzguapjnO/ASwX7eqgiIKisU9asefIceRf+xZr60sc=;
	b=IA1SLuBaRaRGNsSzGT2q0VCgKpmVjX3B7ofavwjISEk7gdPLCkF58s1ViWwOS0nRLk+tCR
	f6JvU4RfPm8Hh0lz99J+LwcAuYdLoXjFQPl5UQzV5pumtmzkEbSq9jdB+71vZB9ktDQozJ
	a1mcAqQ3eDFmW5j87DkTil1yWc+g/dM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-ZXnWKU9OMmyaU3Epj00lsg-1; Fri, 01 Mar 2024 04:29:46 -0500
X-MC-Unique: ZXnWKU9OMmyaU3Epj00lsg-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dcdb00ff6e0so612824276.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 01:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285386; x=1709890186;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUzguapjnO/ASwX7eqgiIKisU9asefIceRf+xZr60sc=;
        b=hEDTqLTllwM24VCyjFa+2NXmOD3B0kz+JDQ8XVEreqfIEP4dwcUKWbYIrrzKaK7RQt
         CI4TBcAHsI8/8e3TD1mJkQaecPeNHlCqiiuvtXBslr6xeocZ46dw7ZbG3xjq76negyZ0
         AJ1bfxpet+tN4k894Gur0KEYI/XVokTzw087ITg/mxYEGdJmtQHSOzXpjhY1DCHjPVS+
         gU0Bg4xnPUmo6yDt6WjYIkVD1H8b1wzXIWgh7ur0jsOSZi8N5hbYiOk0z5N+eSQ7e0E5
         C8fXMqM0MKwybpAub5MCNs3bRGD6rQTuDH0dfO9CMaIr4WblfUF4FKS8IDVqFB7xoAIn
         KGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCULYgJRmqST4tSzZXcIPt8W2mEEk5OYJPZ5bKnD9FSuHpkh68DvcK/0CZgrkrXafH0gk0KgPAAH8hGi7PZTB2H4HWi5D45Zq8C5
X-Gm-Message-State: AOJu0Yw829jxCMqptNYc4BPni2aGOWkiiqzbO+084JCWJ9az5gT9HY2y
	hiwerwuBUnCSNjFE/JFnFIIVvubEAEyTHPNBoZiCOiKEg+yjR0WYB83lbxhSaCgXBOGHlHHtDni
	xcBCHXa6ZaUMuECn8uV0mY23PAINfJY/znSxwT+uxoV6aal4/EAonS/22Ew==
X-Received: by 2002:a25:820a:0:b0:dcc:8617:d6da with SMTP id q10-20020a25820a000000b00dcc8617d6damr764225ybk.4.1709285386078;
        Fri, 01 Mar 2024 01:29:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2RdbWeJU69WfSLJ6KahAECor/gofhdJ9ItLhUg99VOwuO3lZOaOjqitHJwv+Y3BImlFdLbQ==
X-Received: by 2002:a25:820a:0:b0:dcc:8617:d6da with SMTP id q10-20020a25820a000000b00dcc8617d6damr764203ybk.4.1709285385721;
        Fri, 01 Mar 2024 01:29:45 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87dc3000000b0042dac47e9b4sm1549107qte.5.2024.03.01.01.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:29:45 -0800 (PST)
Message-ID: <7158e09386f0345d2e87ea5433dabf38db027971.camel@redhat.com>
Subject: Re: [PATCH v3 00/10] Make PCI's devres API more consistent
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Fri, 01 Mar 2024 10:29:42 +0100
In-Reply-To: <20240229205715.GA362688@bhelgaas>
References: <20240229205715.GA362688@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 14:57 -0600, Bjorn Helgaas wrote:
> On Thu, Feb 29, 2024 at 09:31:20AM +0100, Philipp Stanner wrote:
> > @Bjorn:
> > Hey Bjorn, are we good with this series? Any more wishes or
> > suggestions?
>=20
> Sorry, haven't had a chance to go through it yet.=C2=A0=20
>=20
> FWIW, I just tried to apply these on top of pci/devres, but it failed
> here:
>=20
> =C2=A0 Applying: PCI: Add new set of devres functions
> =C2=A0 Applying: PCI: Deprecate iomap-table functions
> =C2=A0 Applying: PCI: Warn users about complicated devres nature
> =C2=A0 Applying: PCI: Make devres region requests consistent
> =C2=A0 Applying: PCI: Move dev-enabled status bit to struct pci_dev
> =C2=A0 error: patch failed: drivers/pci/pci.h:811
> =C2=A0 error: drivers/pci/pci.h: patch does not apply
> =C2=A0 Patch failed at 0005 PCI: Move dev-enabled status bit to struct
> pci_dev
>=20
> Haven't investigated, so maybe it's some trivial easily fixed thing.

For me, based on Linus's master, this applies with the previous series.

It seems to me that this issue only exists on linux-next, the reason
being that git searches for struct pci_devres in line 811, but on
linux-next, because of previous additions, the struct moved to line
827, and poor git can't find it anymore.

I could fix that and provide a v4.


P.


>=20
> Bjorn
>=20


