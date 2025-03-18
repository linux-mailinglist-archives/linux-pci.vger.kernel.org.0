Return-Path: <linux-pci+bounces-24041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44446A673BC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 13:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF053B71C0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B15D20C000;
	Tue, 18 Mar 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRFgTD5b"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC3320B204
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300481; cv=none; b=vGpb3MSCAQaw6HJESx001aUb2utlTQkGv5LqfuLr5+pQX3TYt9USdIMW0n31QTzaeYpplYiM6Buq4BzhskKa0N9Q8gfIgC16BxnW+ft7hn49rLe9wNBx1/XlSX4F4pK3RBSSoSt4idx96ePIh3T5c4LDERHGtb8misvAyTJX32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300481; c=relaxed/simple;
	bh=PEOho3mxJkzAPXe0fWAi/WRTM0HsCB29b4iFjxeQFas=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uvm/ieIQ2tuX9uIBqM/0smBtf/izQOQo+PiYEZ4MsBDm2hpw16K21VPcSbe+qmo+fpmMFRnOJRXfNvdbRd6WqD1T9Torq4tvzBPs95CetsqhbnhDbZDdsRf6r6Z/N6LN7ezFTifKxxMWxl5YJf8ipc1jEVcbkbznzMlMXUj81oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRFgTD5b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742300478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhhFr4l2vI9LJA1A6kjAKN0mfUZ99Bab74KjDm91CcE=;
	b=dRFgTD5b9V3V8TaNsnFdhEfm14xwyqTsoKVZ3ocJyPi19muSkP4TzNhN+h3fUUwntRnEV8
	JUXzJidSxmWVk//nreO4woU8Ry6dZT/eHmgzFl+XfX8Zp3LVMdjuj3OKlKdzXN9xE/jsdK
	XzESibGiPHWfeTPB1MSN3gAlXs2q4Qg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-TO5hYCEgOjuRX5_yZdQDMg-1; Tue, 18 Mar 2025 08:21:17 -0400
X-MC-Unique: TO5hYCEgOjuRX5_yZdQDMg-1
X-Mimecast-MFC-AGG-ID: TO5hYCEgOjuRX5_yZdQDMg_1742300476
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac297c7a0c2so429186466b.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 05:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742300476; x=1742905276;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhhFr4l2vI9LJA1A6kjAKN0mfUZ99Bab74KjDm91CcE=;
        b=BSVKDA+x+iyWNe8K6EEj0eZ/oifZr28ofEb9Je/vxxkiPghC+AcdsqHYYZ7OTaDIAZ
         NkKnJwR0+CksF1IqQFClDl6tMVPO6GSf37ajstpLNBMGmgw3pcdk1pF85hrM9s+zdW4t
         Y8Xv4Hv6ZnToIm8NC6b6x0oVtQxb81Y0iHAYLLfi7+adjzgpK1OSF2vGzie6eTeIMwE/
         SDDA0ynBLoKPKTUXL2ZBQzKcGC4Pm93ita/PQVeLIX9N16kX3BvDQin9SZDd+UPLLoGJ
         eMYbwZy5y6HCITcapGLyAJledjl/J9Q7nGuAletaSNpLqVV2DLmk/FvP2XqJClOFklpQ
         sL4w==
X-Forwarded-Encrypted: i=1; AJvYcCWUgy9X1TpBVLzMXlfqx5+h7R1/j3cXkJPspX80T/as5HfjPdk5RenDlVQz+nrKOqcXXLSzFqqX9LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziI727xzyGBGyeuKqWCV/NMnPWBwYi84a0UsZJvL1UFTUmNzwJ
	NLYv3SHj0SsQaKiPHP59+8kP4y8km05QGTfxuOblztG3ROoInMiudJgKINlBWysEJUI///HTs00
	a9cWJgVUA2IAr9RG+5d2wcC7puZ/fcZDLzM1++76X8oSIH7KhuMEDYdBB6g==
X-Gm-Gg: ASbGncvw4jO3WIoqN1b8u0v683nxfNMmhi3/T3ZKo7Q1KqNXTS6XIiNvb82zhoVb1JI
	5ea6zivglvLa6DVI2V9t8lav+zVNkhs8lwPCSSVbBdmAmiSSQ6do35bkF7MXhMHy29XqaC9YySP
	6eofsQIzcqY09RrSGXPSZYIOBhsmP3CWAFBwsi7XaMS02VuWgqdUA3wqMZS91UX3wTTkW8P9LV+
	ozCOIplyRwjRWcxyuATCs7hizB1gEjDAEm55JR+HduoBYT2J3LDf+GDCeqF9kKTTHgFHMTife0q
	1ZKS+9LWesOh6Ga5csUDSYw2nkD7U3OJOTH5iy1UzyAfpItVnX1tqOIDkARCUkybu0YvmP9qR4m
	F0iB2IPV3p+elPnID6Ogt6ZhzkPwhwZx/J5k8MRHYeL+1yS8UXPI=
X-Received: by 2002:a17:907:1ca5:b0:ac3:47b1:d210 with SMTP id a640c23a62f3a-ac38d552aa7mr415063066b.39.1742300475760;
        Tue, 18 Mar 2025 05:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8b7vYW7kKObT+hlOwRJc2vA3dRrUIWytcgZqXUp/m1iOSxyN5NhZITY3nlGVypU4loUGSjQ==
X-Received: by 2002:a17:907:1ca5:b0:ac3:47b1:d210 with SMTP id a640c23a62f3a-ac38d552aa7mr415058366b.39.1742300475281;
        Tue, 18 Mar 2025 05:21:15 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2d5b:6600:11f7:ef82:cebd:8734? (200116b82d5b660011f7ef82cebd8734.dip.versatel-1u1.de. [2001:16b8:2d5b:6600:11f7:ef82:cebd:8734])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a49825sm833427066b.160.2025.03.18.05.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:21:14 -0700 (PDT)
Message-ID: <0292a3331a61a77fb05d44ba6d298baaf8a7265a.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, Alex Williamson
 <alex.williamson@redhat.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Date: Tue, 18 Mar 2025 13:21:13 +0100
In-Reply-To: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-07 at 16:03 +0200, Ilpo J=C3=A4rvinen wrote:
> __resource_resize_store() attempts to release all resources of the
> device before attempting the resize. The loop, however, only covers
> standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
> assigned, pci_reassign_bridge_resources() finds the bridge window
> still
> has some assigned child resources and returns -NOENT which makes
> pci_resize_resource() to detect an error and abort the resize.
>=20
> Change the release loop to cover all resources up to VF BARs which
> allows the resize operation to release the bridge windows and attempt
> to assigned them again with the different size.
>=20
> As __resource_resize_store() checks first that no driver is bound to
> the PCI device before resizing is allowed, SR-IOV cannot be enabled
> during resize so it is safe to release also the IOV resources.
>=20
> Fixes: 91fa127794ac ("PCI: Expose PCIe Resizable BAR support via
> sysfs")
> Reported-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>=20
> v2:
> - Removed language about expansion ROMs
>=20
> =C2=A0drivers/pci/pci-sysfs.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index b46ce1a2c554..0c16751bab40 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1578,7 +1578,7 @@ static ssize_t __resource_resize_store(struct
> device *dev, int n,
> =C2=A0
> =C2=A0	pci_remove_resource_files(pdev);
> =C2=A0
> -	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +	for (i =3D 0; i < PCI_BRIDGE_RESOURCES; i++) {

I, just recently, fixed a similar bug (assuming it is one in this
particular case here) [1].

I think it would be great if someone who has the knowledge could
improve the documentation in linux/pci.h where those constants are
defined.

PCI_STD_NUM_BARS is even defined in a different header, hinting at a
different background.


P.

[1] https://lore.kernel.org/all/20250312080634.13731-2-phasta@kernel.org/


> =C2=A0		if (pci_resource_len(pdev, i) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 pci_resource_flags(pdev, i) =3D=3D flags)
> =C2=A0			pci_release_resource(pdev, i);
>=20
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b


