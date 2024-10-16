Return-Path: <linux-pci+bounces-14651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60A9A0AF7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 15:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD25D1F26489
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C354208D6C;
	Wed, 16 Oct 2024 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7Aw0Ng7"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F111E492
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083917; cv=none; b=jifJXW3swiem1l4wrhuMixPQwCSKhJrTMG9rRDF7iXl0PyHbhFL3J4iYmJfdhMMPjkMXlpTGJp3jXY2QLPhZ6x+g52QQsYJAa8PcH/41LgYmsaeEY83KUlxHCrs/8Ll1lgI+h2uWYjRX22Aq3UsfAXeV5yRW1LWxtjx+rBSHB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083917; c=relaxed/simple;
	bh=SKvM6CdR+oyJ0Yu3NB75uyOzcADdnJSBpDgOLrDQ6k8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ud4lEbUBU/Kj1iQ8iF5KwpZ1SzN9B0svLf9jq0O6pQ60fCQjqFlv9fHbTE7xrE+FsypUQUvqMaQ5/59CDeuWleUeJCIVlGct2+HXgETd7QKdk5lDC7kyE8fYBn+Iy+DObKgBxT6l3Oa10Dy/3mnT0CX1RyGEjsFt2N/9y7C3F1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7Aw0Ng7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729083914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACVXk1eqVCYcihZ6o/19CXkIxiC5+iHoehaaXe8KMYM=;
	b=P7Aw0Ng7FMrsMGYo0RfVXP8lgVOro3kWFU7Nk9ODIpwTfWJMjlfTyP5XooRNn21axMpPo/
	tYexIb/t9TsPmO/6rkB5kOMJdYHMpnxCL/3nsNI1uzZwkBCH/SEmt7W7BsoNdOJpBMuoBM
	dhK64EVH7PKXOlo5k68nw1QP0+qHu28=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-Ke2AcQd6O--uVJI6pb2EuA-1; Wed, 16 Oct 2024 09:05:13 -0400
X-MC-Unique: Ke2AcQd6O--uVJI6pb2EuA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d67fe93c6so1858908f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 06:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729083912; x=1729688712;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACVXk1eqVCYcihZ6o/19CXkIxiC5+iHoehaaXe8KMYM=;
        b=P2BIyodoS3tmctk1VWtfCk9z3JVV5rOunscCxWgLdkcKAlpUha6ufwbBD74Xc+VNc2
         ci43f84EzznR2rmwB3vJFCEzlmG90SlyNvubYX8lF+ncIva2dOP7mCgn1ux/kwUMhwAf
         /olkuLEPAc6sMfucd9IKZzPjZ0VlY6fTkkGwMxr0WvmXVp/uy3E5lS7RVWzFhQ0F2YiV
         RSc2G/4WwiUJ5gOLk5Chd43oDfpzpj+4x2+MqG/Ory45AfsiQdUsdWmTbPJtvJHfCKK2
         HJ8aqq5YtH/ghaTsc1vNlVdEWQ+a4D6g6myavfH3r897u0i1FQdS7nk9sFmH/YEawBCC
         COhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcBQK7ToWhbGdItXqZ72H67v0n/6uD9gdV3Wv+HGekZYswRf2atwld0cbPgx2hE/+pGIC57V1Ta0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6IrJeZXpZyiWGZfe0tneXiEsQFkH67cm6R27EsC+RCHxBbl+x
	/ZvP5vp+L4zAd6EDNGKB/WKTEEL2Fs5to8zv8eF5/OtKIq/gqINMq+Vj+ftCsp0PavM7Ymh+eC1
	pP5AoM5ZA15yRtte8f5BrmZ7c5l+koleOvGvt5InlDjoWrd8wqoZXqmPPOPgcb8vavsf7
X-Received: by 2002:a5d:53d0:0:b0:37c:d2f3:b3b0 with SMTP id ffacd0b85a97d-37d551d5113mr11285550f8f.23.1729083911915;
        Wed, 16 Oct 2024 06:05:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWDUPb62QGiZV3FoX7Zj6XqFuD7zwRWksL6H+UbI0V181nFzohNZUjYzU07DPoUgxKqp4c4A==
X-Received: by 2002:a5d:53d0:0:b0:37c:d2f3:b3b0 with SMTP id ffacd0b85a97d-37d551d5113mr11285533f8f.23.1729083911527;
        Wed, 16 Oct 2024 06:05:11 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf818esm4280091f8f.84.2024.10.16.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:05:11 -0700 (PDT)
Message-ID: <1cf314b3e91779e3353bbcaf8ad13516a00642e3.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: Convert pdev_sort_resources() to use resource
 name helper
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Oct 2024 15:05:10 +0200
In-Reply-To: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com>
References: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 15:00 +0300, Ilpo J=C3=A4rvinen wrote:
> Use pci_resource_name() helper in pdev_sort_resources() to print
> resources in user-friendly format.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
> =C2=A0drivers/pci/setup-bus.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 23082bc0ca37..071c5436b4a5 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev
> *dev, struct list_head *head)
> =C2=A0	int i;
> =C2=A0
> =C2=A0	pci_dev_for_each_resource(dev, r, i) {
> +		const char *r_name =3D pci_resource_name(dev, i);
> =C2=A0		struct pci_dev_resource *dev_res, *tmp;
> =C2=A0		resource_size_t r_align;
> =C2=A0		struct list_head *n;
> @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev
> *dev, struct list_head *head)
> =C2=A0
> =C2=A0		r_align =3D pci_resource_alignment(dev, r);
> =C2=A0		if (!r_align) {
> -			pci_warn(dev, "BAR %d: %pR has bogus
> alignment\n",
> -				 i, r);
> +			pci_warn(dev, "%s: %pR has bogus
> alignment\n",
> +				 r_name, r);

Why do you remove the BAR index number, don't you think this
information is also useful?

One could also consider printing r_align, would that be useful? Note
that there is a similar pci_warn down below in line 1118 that does
print it. Would you want to change that pci_warn()-string, too?

P.

> =C2=A0			continue;
> =C2=A0		}
> =C2=A0


