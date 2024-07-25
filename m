Return-Path: <linux-pci+bounces-10785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C3393BFDF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 12:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D13BB21977
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A69198E85;
	Thu, 25 Jul 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAO+P9u9"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426C197A76
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903150; cv=none; b=AonWvaItn5qkOaz4K5Ya9DavVoIXsOvCzWGLbdGJ0tAKWC5GX1J0r4oSZPU2H43TPMqEZjsyTdc91UAgqtqdB+EIV5EPWQE1mey5FkG8x5jqF/MlMNuMF/eU7MZtwnq/x/62KtXVSejOGcPoWETsxrBnGXHyMWyOVQcycFe15Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903150; c=relaxed/simple;
	bh=p4YZq8MicH9fL/9yWPmj8mJdLwD5aH6J6ICVlx9dNbM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsfwcWpgDvzjppUG38n7qcs913D5RKXMdPZvCwjLKSwgUt+GvLAJMoiP+H5XytxCxpOQ55876MakS3b24NhpeNPO6KOXS15ghl9b3m8gM7MzIm+4cO4Ony6mnSyqgMToa4OGwVQTqdNJYzYLt4nq6vBGfHZ0kI3mihjT8oX/f4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAO+P9u9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721903146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZEREL8+YySrb9tj6znhlhD3I3mrmgkhOAZ20QmvKMqA=;
	b=LAO+P9u9IgBYMVqXp8eAO07Vn3yIzzOTRGMjQHqa9SIRpFIsWvDv7BUh/zrQbuxUv7XP7m
	IfFyskSDBe5+P9zR+6zSfeDIl+o5Txd4eaqyAxhL8vXiy9qnn19WLC3biwIOeg7zRzXBqg
	Twkr9vCaunBbVc2leeMs+nxty7SkUWE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-HZVlblhLORaNTN-u-4Yn2g-1; Thu, 25 Jul 2024 06:25:45 -0400
X-MC-Unique: HZVlblhLORaNTN-u-4Yn2g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42808f5d32aso100735e9.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 03:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903144; x=1722507944;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZEREL8+YySrb9tj6znhlhD3I3mrmgkhOAZ20QmvKMqA=;
        b=ZuUngGSmRijJGAa09FD5iYH4tMiZvvvoa4IgDBcFCC+3iWpMfhP5tzXZmZ6/6w9ms1
         8hLHmuc/v1zkxyQ9NqHJL7U0mVrhsE6++ab1x2UgKoklTZAerfor5R2mU0kLMLHLZvWb
         gQmCrKaRfkqGVD5jNmV9f9xHyZofltUo7wVUVXEbaSQPeLGLWGNm3oC/QnRp+Z8QaCOL
         Uxt9BtV6ERHvIyaOxdrPXxCGwDMcZl2jhfMqLLVe9DPc4PvyG43Lt+znI5mYBEaqCLyr
         4U19PIczJZ26Bw5fke7H8T7aRuaI9WiCrdmdnlD5gFal4QX4wS2BD1jPtggD75ZmFDCm
         AGyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCnt59l+p6PBKKC+zBM8OOLg94mAqjAAdPSHoTredtq18R2Ooigzn+YyOCvwPCkLdqnHQWEhP6IssadIP7SLZgGcVl5pXHbWLw
X-Gm-Message-State: AOJu0Yz2EUg9Yt2glQGEi0BZh0KMDzd9UHJfHEKukpVIzu5KD3eCYzuC
	9XBk2OlnFzK0Y9PTALRFhoEwCp3FW9fQaWkUwwZwndBS7WXB1ZU6+XWnJHpiie7oHQqSdSDHZCP
	YLA3WK+vj6eb2P4XIaYH5o9valS0WWfwpJg9PTD711SBW7zXBJX39jfExAQ==
X-Received: by 2002:a05:6000:1faf:b0:368:4c5:af3 with SMTP id ffacd0b85a97d-36b34d30e5bmr865739f8f.8.1721903144042;
        Thu, 25 Jul 2024 03:25:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAcuvXPUcmtp8FQtArctIyV+aWe4scfyfVhBCOlijOAVdjObA83QcvfKCEFZHHHyT9aXb8cQ==
X-Received: by 2002:a05:6000:1faf:b0:368:4c5:af3 with SMTP id ffacd0b85a97d-36b34d30e5bmr865730f8f.8.1721903143603;
        Thu, 25 Jul 2024 03:25:43 -0700 (PDT)
Received: from pstanner-thinkpadp1gen5.fritz.box (200116b82d135a0064271627c11682d8.dip.versatel-1u1.de. [2001:16b8:2d13:5a00:6427:1627:c116:82d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427fc95707esm35940515e9.0.2024.07.25.03.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:25:43 -0700 (PDT)
Message-ID: <cb95352f5eabe17b56a0debf2564b09097b1c23f.camel@redhat.com>
Subject: Re: REGRESSION with pcim_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-pci@vger.kernel.org"
	 <linux-pci@vger.kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Jul 2024 12:25:42 +0200
In-Reply-To: <f0653852-0ae8-4b7d-b01c-3170b22490ff@kernel.org>
References: <b8f4ba97-84fc-4b7e-ba1a-99de2d9f0118@kernel.org>
	 <f0653852-0ae8-4b7d-b01c-3170b22490ff@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-24 at 14:13 +0900, Damien Le Moal wrote:
> On 7/24/24 1:56 PM, Damien Le Moal wrote:
> >=20
> > Commit 25216afc9db5 ("PCI: Add managed pcim_intx()") is causing a
> > regression,
> > which is easy to see using qemu with an AHCI device and the ahci
> > driver
> > compiled as a module.
> >=20
> > 1) Boot qemu: the AHCI controller is initialized and the drive(s)
> > attached to
> > it visible.
> > 2) Run "rmmod ahci": the drives go away, all normal
> > 3) Re-initialize the AHCI adapter and rescan the drives by running
> > "modprobe
> > ahci". That fails with the message "pci 0000:00:1f.2: Resources
> > present before
> > probing"
> >=20
> > The reason is that before commit 25216afc9db5, pci_intx(dev, 0) was
> > called to
> > disable INTX as MSI are used for the adapter, and for that case,
> > pci_intx()
> > would NOT allocate a device resource if the INTX enable/disable
> > state was not
> > being changed:
> >=20
> > 	if (new !=3D pci_command) {
> > 		struct pci_devres *dr;
> >=20
> > 		pci_write_config_word(pdev, PCI_COMMAND, new);
> >=20
> > 		dr =3D find_pci_dr(pdev);
> > 		if (dr && !dr->restore_intx) {
> > 			dr->restore_intx =3D 1;
> > 			dr->orig_intx =3D !enable;
> > 		}
> > 	}
> >=20
> > The former code was only looking for the resource and not
> > allocating it.
> >=20
> > Now, with pcim_intx() being used, the intx resource is *always*
> > allocated,
> > including when INTX is disabled when the device is being disabled
> > on rmmod.
> > This leads to the device resource list to always have the intx
> > resource
> > remaining and thus causes the modprobe error.
> >=20
> > Reverting Commit 25216afc9db5 is one solution to fix this, and I
> > can send a
> > patch for that, unless someone has an idea how to fix this ? I
> > tried but I do
> > not see a clean way of fixing this...
> > Thoughts ?
>=20
> This change works as a fix, but it is not pretty...
>=20
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 3780a9f9ec00..4e14f87e3d22 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -466,13 +466,22 @@ static struct pcim_intx_devres
> *get_or_create_intx_devres(struct device *dev)
> =C2=A0int pcim_intx(struct pci_dev *pdev, int enable)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pcim_intx_devres *res;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 pci_command, new;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D get_or_create_intx_devres(&=
pdev->dev);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!res)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -ENOMEM;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_read_config_word(pdev, PCI_COMM=
AND, &pci_command);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (enable)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 new =3D pci_command | PCI_COMMAND_INTX_DISABLE;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (new !=3D pci_command) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 res =3D get_or_create_intx_devres(&pdev->dev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!res)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM=
;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res->orig_intx =3D !enable;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __pcim_intx(pdev, enable);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 res->orig_intx =3D !enable;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pci_write_config_word(pdev, PCI_COMMAND, new);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0}

Thanks for the report and the fix.

Please let me take a look into this. Might take a day.


Regards,
P.


>=20
>=20


