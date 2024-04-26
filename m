Return-Path: <linux-pci+bounces-6686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B49F8B31A3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 09:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DF71F21456
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740113C838;
	Fri, 26 Apr 2024 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajCoFuxz"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34113C3F0
	for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2024 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117512; cv=none; b=uHFLm5xuFpFtU0dUUaqGiggBZgTE2TIweyZQ82x6RD4HRM8xAH5hVeWMD08vkDsYn9pPCM3dCbHbcUz5Dk2XrsJP2Sc5K3xro5Hr1FkyhbXTwmkAlNa4psDTInEq3D+kTvY06Et79Zu1G09BzeCEGbPha1y+8z9Oe5kuegOy/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117512; c=relaxed/simple;
	bh=rUd+NDHbSv3c2fwov86iAf1+ncoc84+vbeTpHpltIo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIumIUkE7KonkLgCyTQHvQAW+e8AXFZJKRH/dfyHbGY6rYNbKGbP0GdFk42TyRY+kTLkYvIBv2f6fkOCxgCT/tXRQAWqhKFW+SFtX9I7Ka2HQgF0J+jph1wWYms2cmt/BubA/X5FekIcwF/gOgVGKPsq9xtheJuflCiNyokgTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajCoFuxz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714117510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUd+NDHbSv3c2fwov86iAf1+ncoc84+vbeTpHpltIo0=;
	b=ajCoFuxzW0GCZywPfev17TU6RO3q8rjYN+D6xG3oFfdEi9qoj95XZvtG3EBznwF9/2GLgI
	1xzE+tmnZZ4hN80afJTAPTwB+AJp0W0HqiBTM9kg5/ldo3RrbXe+lhMdG+2Y1BBgxIIXsG
	eCZFLy+BiDNhd/YjBEyHZoEI/b6AOnE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-05lr7en7PvuXigGA4xJ8Tg-1; Fri, 26 Apr 2024 03:45:08 -0400
X-MC-Unique: 05lr7en7PvuXigGA4xJ8Tg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43a3632d56aso7870371cf.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Apr 2024 00:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714117508; x=1714722308;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rUd+NDHbSv3c2fwov86iAf1+ncoc84+vbeTpHpltIo0=;
        b=oX05JeFtfF72VSl9smvRaWfBUBGQ9blDAbCum/WgqYO5VQB7UkJGJayB8j8ArWNMui
         Ul4gJZx2Jd0zQAwM6MNuk37CK3RF0StsEDRClWrfhP1Ga0Rw/mlf/T6bXPSSiL0s/auz
         EjR1ju4VFvs04lq9YoDYKuzeYdKgTjnzoSNhE6fT868Nfy+EQZCajo+YwdIjcylkYHSS
         pjOhDqfX7ReGMXKYpsppWq5xTdbPM9Ra2qtAH8/abUnzU2AY89MubZP9obHNOmIhTa8C
         7k2x1zZJbKEnuUfjMp3fw2R0nSTrLj3fWDTjgwMPv4jyDAwWEkK+UkBShv/LYRuGD10z
         kYTg==
X-Forwarded-Encrypted: i=1; AJvYcCUQBeXF44FfRYSf+mSrBbyM55CyR97hV5PcZxJlfubx95axRwD59RXHwRp5mXv0NomQg5jQNly8VFcx234MF9i3VgEP3wbxEW2v
X-Gm-Message-State: AOJu0Yxgu5zfeAVTVz+WxNATFUj0yDpZ9mg6SnJ7spLRlNCRXdKhMjcl
	tpiMhc00p+9SSCsO/nXgzrCBTfyCTP/SkzbJBM9iO4eNfdLgVrZjqGZNs3cnbPPFojglaGMNMtA
	brSk1sPmhAxJcPC9jJWylwVQpzVYAeVNNZZUNqO3+nQtxutag/dcocSYbdA==
X-Received: by 2002:a05:620a:1998:b0:790:b14a:f3b2 with SMTP id bm24-20020a05620a199800b00790b14af3b2mr268130qkb.0.1714117508221;
        Fri, 26 Apr 2024 00:45:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBpIQQ4Cw0i6lKebwdcfxqWo1Ele2lBbNOsET58txmVyPf0uijghKM0MhFbnu1UARMdDHjxg==
X-Received: by 2002:a05:620a:1998:b0:790:b14a:f3b2 with SMTP id bm24-20020a05620a199800b00790b14af3b2mr268091qkb.0.1714117507816;
        Fri, 26 Apr 2024 00:45:07 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a15aa00b0079061110054sm5937871qkk.13.2024.04.26.00.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 00:45:07 -0700 (PDT)
Message-ID: <e36256905e924df9690202671e1797d6214592df.camel@redhat.com>
Subject: Re: [PATCH v6 04/10] PCI: Make devres region requests consistent
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Fri, 26 Apr 2024 09:45:04 +0200
In-Reply-To: <20240424201236.GA504035@bhelgaas>
References: <20240424201236.GA504035@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 15:12 -0500, Bjorn Helgaas wrote:
> On Mon, Apr 08, 2024 at 10:44:16AM +0200, Philipp Stanner wrote:
> > Now that pure managed region request functions are available, the
> > implementation of the hybrid-functions which are only sometimes
> > managed
> > can be made more consistent and readable by wrapping those
> > always-managed functions.
> >=20
> > Implement a new pcim_ function for exclusively requested regions.
> > Have the pci_request / release functions call their pcim_
> > counterparts.
> > Remove the now surplus region_mask from struct pci_devres.
>=20
> This looks like two patches; could they be separated?
>=20
> =C2=A0 - Convert __pci_request_region() etc to the new pcim model
>=20
> =C2=A0 - Add pcim_request_region_exclusive()
>=20
> IORESOURCE_EXCLUSIVE was added by e8de1481fd71 ("resource: allow MMIO
> exclusivity for device drivers") in 2008 to help debug an e1000e
> problem.=C2=A0 In the 16 years since, there's only been one new PCI-
> related
> use (ne_pci_probe()), and we don't add a user of
> pcim_request_region_exclusive() in this series, so I would defer it
> until somebody wants it.

Alright, sounds reasonable to me.
Since pcim_request_region_exclusive() can be dropped we can also omit
separating this patch to begin with I'd say.

P.


>=20
> Bjorn
>=20


