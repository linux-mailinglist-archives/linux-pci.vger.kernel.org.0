Return-Path: <linux-pci+bounces-25544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E19A81F9F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 10:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92BA881C10
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747C25B683;
	Wed,  9 Apr 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDDH68S3"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933125A648
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186867; cv=none; b=EUHntZ6bGBiVi83lKn9nXpL5GeE6xxW1WHmfmzxY6mWRhALUr15r/i5qXZaMm52cLeNe+wwxVRhVG2E0m0ii7/qWmWkqw1LgSy7MkB1Rr4XvXwKXuhR/51nhYdjYHczdUyHkZ1Fcb+1mEqNVD+c1BcUxm8iSh/g8RzORcvaZye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186867; c=relaxed/simple;
	bh=yPtsBjYSLkAPrCZiTss+NrJJGezTaQbSZTYzCNiC8N4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PxGixnPFt6WDtkpQB8OokW/BpOWqHeFHjs8rkS+ete8ArzO8hAuFPysuU7fBhbDfkMmMB2DmkHpHOSh7xhvzLOrsu/H24vtPgdCY6JgFAvosKRfgEb5ZGik4dr03fdsllXaH0AvnmmA5pLncHZ8vt/R/ulIirJQG9BDqZFaqkAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDDH68S3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744186864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yPtsBjYSLkAPrCZiTss+NrJJGezTaQbSZTYzCNiC8N4=;
	b=JDDH68S3DQVBWm3y4MUO+NITGxD/kIpN2g5FhukBvEJL1T7jrfjFpt0WHaJb8ia263oOdF
	QwKKUbgRsaaW1DRUFL+f07wOwQuiGiS38FzwYjTp5Zey5Selu0Qvc18BfJTE0FrDCZZsRl
	z9Ojgg1Qo+9666coeQLQLzkjRIvpxRs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ue9BewVbPX2R55z9mjtqIQ-1; Wed, 09 Apr 2025 04:21:03 -0400
X-MC-Unique: ue9BewVbPX2R55z9mjtqIQ-1
X-Mimecast-MFC-AGG-ID: ue9BewVbPX2R55z9mjtqIQ_1744186862
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7369b559169so4788884b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 01:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744186862; x=1744791662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPtsBjYSLkAPrCZiTss+NrJJGezTaQbSZTYzCNiC8N4=;
        b=wCQl73W2CwUiUYaLgdn1G/Zr4hXFBTNIDHK4aQIRN2znu9M16qoI3Go9TsxSXc/+Lk
         usrpSbv41teRhQGqk2oVl4AijlOtlp8xaU2sRE7azsTOXmo3/Ju29+IKEOiebHq8GeYW
         yCQsXe9mkX9r+iVvWnghrD55SuL6uTZMgLTexu8+C0881obIaqm19jfMx38GNdzs6Ztf
         4/5nuf40Sic0alqZtu3wIpxB4k/x+HiMf+OOPiJ3C6KCapmV9UPoCf16W97RENeRex1X
         ahsIHYgyOWNYZWfDyyQR/Quwi46l7xToaPPhz1K3rX8bGUH6GXOXfOvXboGJ/BA3WXNM
         uP7A==
X-Forwarded-Encrypted: i=1; AJvYcCUeKCL2fRkoJJ8AkURkqZxg/7vsxStZipcovu0Qx4Fsm4kojBE6YH7Gv+SmgnhUssXDsQ7YufROMOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQIkHI+hIyMexvgIYk3TkS/a4qptgAKkfXUB6+Z7NwPKnzD06X
	VBPiPMyCWqNtxhVFt9xy6dewDCfZzFVV5ZekJO7hWisJQPkPnxfU73yKzF7pgMVS0saOyAfv4Ij
	SFPCcixMUCj4hBG+Ntr4SY0i83baU2CRipuP4Yk7FbdQeBU+sake2DHoFcg==
X-Gm-Gg: ASbGncvRnbDjSqNA3UycbAb8yEijS++7Uth0dlJWDusG+Fb+5mgeusyCCyUVMrnhtIH
	xwM6K5qEuL2ixExpcQLJERs0Ni2FwN7pma1zBwwjvylXRHyyyfTzUap8nqjLigZqw9YoQYlKOvz
	D5kgxPacaxh0ViJ8SHlU6frMlpgShDoXGbS3STmxczWxeu57uukTKRrJa7FnuMoL8DzxBq3kxw5
	mTZFU2SYLi47K+5SWCXmVTbVnvLpgRhW3HYy4ed94uKA9vAgjN2MOeJIZXMVEFUm3wVzCcCIK+e
	d9xKHy/fLNb8lIKjoIoI7yR04qttVx+iq2dMyQ==
X-Received: by 2002:a05:6a20:9f4b:b0:201:4061:bd94 with SMTP id adf61e73a8af0-2015aec70dcmr2663678637.19.1744186862421;
        Wed, 09 Apr 2025 01:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAdC8ZOoLIsWMuTKkgVixwpNFmJg4t2tF+Bs6s3GQA8caDDKDF7hIvBuRiacHAa2qdet6aIQ==
X-Received: by 2002:a05:6a20:9f4b:b0:201:4061:bd94 with SMTP id adf61e73a8af0-2015aec70dcmr2663635637.19.1744186862052;
        Wed, 09 Apr 2025 01:21:02 -0700 (PDT)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf2eb3sm660285a12.24.2025.04.09.01.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 01:21:01 -0700 (PDT)
Message-ID: <f2ec6ba36845c96e9fb9a2dc465d9066948bbe4f.camel@redhat.com>
Subject: Re: [PATCH 0/2] PCI: Remove pcim_iounmap_regions()
From: Philipp Stanner <pstanner@redhat.com>
To: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, Mark
 Brown <broonie@kernel.org>,  David Lechner <dlechner@baylibre.com>, Damien
 Le Moal <dlemoal@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Yang Yingliang
 <yangyingliang@huawei.com>,  Zijun Hu <quic_zijuhu@quicinc.com>, Hannes
 Reinecke <hare@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,  Li Zetao
 <lizetao1@huawei.com>, Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org
Date: Wed, 09 Apr 2025 10:20:46 +0200
In-Reply-To: <20250327110707.20025-2-phasta@kernel.org>
References: <20250327110707.20025-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-27 at 12:07 +0100, Philipp Stanner wrote:
> The last remaining user of pcim_iounmap_regions() is mtip32 (in
> Linus's
> current master)
>=20
> So we could finally remove this deprecated API. I suggest that this
> gets
> merged through the PCI tree. (I also suggest we watch with an eagle's
> eyes for folks who want to re-add calls to that function before the
> next
> merge window opens).
>=20
> P.
>=20
> Philipp Stanner (2):
> =C2=A0 mtip32xx: Remove unnecessary PCI function calls
> =C2=A0 PCI: Remove pcim_iounmap_regions()

Can this go in for the next merge window, Bjorn?

P.

>=20
> =C2=A0.../driver-api/driver-model/devres.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0drivers/block/mtip32xx/mtip32xx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++----
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 -----------------
> --
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A04 files changed, 2 insertions(+), 31 deletions(-)
>=20


