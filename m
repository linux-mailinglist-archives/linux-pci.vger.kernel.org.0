Return-Path: <linux-pci+bounces-8790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA5E9085F4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61168B254B2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8740D18413D;
	Fri, 14 Jun 2024 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETp5A1ma"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA143185093
	for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352930; cv=none; b=A+SkA6/LUGCK673OmHSNuNdkuCv32lfqi5r7w1Hu8ikXk4PtqsgWkza58K9m19yCDpE40yCphlm8cltbY/PNWGhH0BQkN8/04wQOxch+plcRvt8KR+YXLPFK/BILz4jtm7WYoBouoedcQ3ppPotM+IHXuOUX7lrq6PIge9oKx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352930; c=relaxed/simple;
	bh=+U6u6oHwgoeea95K+ELmfRv1oi19gd8QmUZw4bs+x3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2j92vo5LUQvkHHtEFBaPZg+3/jcke/zOpJBE0hA72teWakpNqUp2jo9iOxgqWks8BUdiFYywATfmBHFTslWMuevscBa4XLD6leB4ubbukh+yl6JnIgLJh0PZMopCS5GlF72yZZTPZyVSYZcWYTdQQR5BZTrAfFmJlnHL2Hn36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETp5A1ma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718352927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+U6u6oHwgoeea95K+ELmfRv1oi19gd8QmUZw4bs+x3k=;
	b=ETp5A1ma3I0kKb4Dkz+lsZtoHZC3WHIW2sTidoPo9aVOMfMATZROp0Q4zwoFOOr8+2uJqO
	VUFybPNdrUcWhGD8ZGfUdkdOPfKLNHef2hRd/I0xmzp+ySe8d7JaSt7hvnwWzNcxzwVcZ7
	IHxCglw6NGZAFwt2kGR3j3x1xwuGQZc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-0mSWntG4Nfu07bG2JDPYow-1; Fri, 14 Jun 2024 04:15:26 -0400
X-MC-Unique: 0mSWntG4Nfu07bG2JDPYow-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ebe771d008so3018371fa.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 01:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352924; x=1718957724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+U6u6oHwgoeea95K+ELmfRv1oi19gd8QmUZw4bs+x3k=;
        b=YuSX79OmFk4j7w+/xrhL8zDAxp+r3VO+94W+Oz60mRoCVQ3n+jWVTu0czexo4FLfyB
         qjSwd60UakLzh4KgxYQpLxO3iTzCXJIEauwQkg9+PGs7kW/4phI/63KXOowILqKUEKbC
         cQsJwm1ummmGQaXQh8J4NB8Vz5jYtlPj+nPsKkCjq72Mr/hUPkW0eaNJhdDys0r2Tfsa
         9G6Uvf5biFtomOXpyBtiZnqtNMRtpLLLjbzyhy1Eu4tL7sZox0QsGl7duTkM0aI60Mis
         oZFbrnQ+MYmYJxXSjweIZ7t+E0zl1ZRhuznuwMlco3/s2dbj6eiMa0whbUS9CVotLE6+
         PWxg==
X-Forwarded-Encrypted: i=1; AJvYcCU5CI5ZW2mLWnAgPIKEXSu1QicfZUlpn5yYWu0kZ7zfXGORVjtYLD3h8Ywsv+YqGRC3xtm++SshsI+BNoUMcullgmtU/7+rqUZA
X-Gm-Message-State: AOJu0YyCjMxa0triUHxjxYaS4JS+OL5u/kH0LPYp5FS+adlaRLqyl4MW
	uBsASxqnG7Soe+ucmeZpIegbeLjpoRfeDqFIGvaDggIluTSnCoSbJ/HcXpBexdRY4NPS2+158Vw
	UIx0xR6ZrlgigkTjFAE9no1QPEuTVduHkO2QnFY5BMYJ7Td8WDIaAIr3ceURNvz09bA==
X-Received: by 2002:a19:520c:0:b0:52c:9f10:947a with SMTP id 2adb3069b0e04-52ca6e56a5fmr1341216e87.1.1718352924523;
        Fri, 14 Jun 2024 01:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwnIjU6dq4qRlzWQDBdnh4stXDr2ytBrb+EVi+jPLU5m8J7sXt/GESIh+foWt4ZaUGAu8U4A==
X-Received: by 2002:a19:520c:0:b0:52c:9f10:947a with SMTP id 2adb3069b0e04-52ca6e56a5fmr1341191e87.1.1718352924101;
        Fri, 14 Jun 2024 01:15:24 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad082sm3590791f8f.59.2024.06.14.01.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:15:23 -0700 (PDT)
Message-ID: <105f167697e4421237884ebece1cf9a28293c762.camel@redhat.com>
Subject: Re: [PATCH v7 09/13] PCI: Give pcim_set_mwi() its own devres
 callback
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
 linux-pci@vger.kernel.org
Date: Fri, 14 Jun 2024 10:15:22 +0200
In-Reply-To: <17445053-18a1-a56d-79d0-3b3d3ecab033@linux.intel.com>
References: <20240605081605.18769-2-pstanner@redhat.com>
	 <20240605081605.18769-11-pstanner@redhat.com>
	 <17445053-18a1-a56d-79d0-3b3d3ecab033@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 20:19 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 5 Jun 2024, Philipp Stanner wrote:
>=20
> > Managing pci_set_mwi() with devres can easily be done with its own
> > callback, without the necessity to store any state about it in a
> > device-related struct.
> >=20
> > Remove the MWI state from struct pci_devres.
> > Give pcim_set_mwi() a separate devres-callback.
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0drivers/pci/devres.c | 29 ++++++++++++++++++-----------
> > =C2=A0drivers/pci/pci.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> > =C2=A02 files changed, 18 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index 936369face4b..0bafb67e1886 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -361,24 +361,34 @@ void __iomem
> > *devm_pci_remap_cfg_resource(struct device *dev,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
> > =C2=A0
> > +static void __pcim_clear_mwi(void *pdev_raw)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pci_dev *pdev =3D pde=
v_raw;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pci_clear_mwi(pdev);
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * pcim_set_mwi - a device-managed pci_set_mwi()
> > - * @dev: the PCI device for which MWI is enabled
> > + * @pdev: the PCI device for which MWI is enabled
> > =C2=A0 *
> > =C2=A0 * Managed pci_set_mwi().
> > =C2=A0 *
> > =C2=A0 * RETURNS: An appropriate -ERRNO error value on error, or zero
> > for success.
> > =C2=A0 */
> > -int pcim_set_mwi(struct pci_dev *dev)
> > +int pcim_set_mwi(struct pci_dev *pdev)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pci_devres *dr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dr =3D find_pci_dr(dev);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!dr)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D devm_add_action(&pde=
v->dev, __pcim_clear_mwi, pdev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret !=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D pci_set_mwi(pdev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret !=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0devm_remove_action(&pdev->dev, __pcim_clear_mwi,
> > pdev);
>=20
> I'm sorry if this is a stupid question but why this cannot use=20
> devm_add_action_or_reset()?

For MWI that could be done.

This is basically just consistent with the new pcim_enable_device() in
patch No.11 where devm_add_action_or_reset() could collide with
pcim_pin_device().

We could squash usage of devm_add_action_or_reset() in here. I don't
care.

P.


>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dr->mwi =3D 1;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return pci_set_mwi(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(pcim_set_mwi);
>=20


