Return-Path: <linux-pci+bounces-25764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F0A874FF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 02:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CE716FD39
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 00:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F14C9F;
	Mon, 14 Apr 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX8jk35o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F37E9;
	Mon, 14 Apr 2025 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744589902; cv=none; b=GYE2OyHb1YpD+ZHf6nAFA7nxNbO7/+4TGaenVPP5W0l6Y/wcq+e2TrObLmdqi8rP44UECNz2Uy2XNG96VwYwblEr/Qvw6TacF2Zbyt7fI/hi9+N1ACnAvp7kl6rhwdPGgj3x+DND+gQ5wy3NUaqQ0VLFG6wrRedW51L64bOjP+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744589902; c=relaxed/simple;
	bh=PLdQtCLGe23z3IfTtqivNiRrkXGFHpA1PPpGrIKxJv0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GKHPl3DaJqvoS13XIKS8dfJ4mSiw/GOnbymLfiak9IzOLQZhNGLOWGOOufjsUgAxB2PvgQb5moDXJqHrBbCzP5fccpbceWNRoGOw/KulhLAjvfl9fVZpM1y/CloqHvcc5W1Cd5lJbrsXZGgkSQSgOPGH0LV2rGKGL090ym9PWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX8jk35o; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af9a7717163so3941524a12.2;
        Sun, 13 Apr 2025 17:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744589900; x=1745194700; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vxbJ0IXSVP0LDPqxvoaaKIJufOTSmPuT4Avld276azk=;
        b=VX8jk35oxj7WUDLvBw4d45NDVQ7d8Kvs6r2XNLeq1TvLs6xD54GsAn0m+Qy35YfjYE
         qVFqya7mkDjHHatV1TXHBbWXzz8i0uy8iyaD4HUn7tRgBcEyv+LOXP2xGpBBkB+mpA06
         uHgjOASu8lGtKWqMmuR/J/7jY4lJiKjfm1bL/mLKu/J+bv+wba/vrScwWgvDvT4XqkOd
         DCgWc7cEHGM2tWAGs+nV+b5M4Rlm/IiAauzamyR5Da2sJZEiBi++tyoPE025648QQpt4
         LY7z7GnG5iW1SXrjOmgTxbmcXehrsGsinphLKuO/8w2BkL1UD5xwnHGfyqy6avV7XrCm
         d/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744589900; x=1745194700;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vxbJ0IXSVP0LDPqxvoaaKIJufOTSmPuT4Avld276azk=;
        b=XA+mhJ8HOJ7t3gBhekwzGrJTc8gN+dX9C8TJbch5Lc+rFAl/k2fPw2k5bx/bXcD8VE
         k9fboMVVcb6Pzvh0OqA1620MBDG/lb4LwO895xOrTGa50cO/qZPmvyQoF3avZ1lw+Ejz
         MoFcf/PbNSmXna6FMksi1Re7quFjpiaTvdYDzYxWQzX3UZCmUH90lIpgSjF5ww9OJ0AP
         lzs6yGG4flX76hl3TMwocCvskxhNfUMZCpGqzCG01P2tR9NcznSi5QDxzd5r62esQos/
         zJYHLeJZvX3ZqO/mRLzRmDCPYJiCP5haQkd9ZQaAOkmKrykpIlO5UNlgxdNM1RjQ4ZNz
         XQTA==
X-Forwarded-Encrypted: i=1; AJvYcCVZVwkFJmh+W9VuyBQwqTtMdRrhPDVosCY3qp59bXbeHlMBVxED5Zcm7n5J0pdxTMhh5ld8v0nfuvbp@vger.kernel.org, AJvYcCXI15F39GP49fqT/0moZGgbXwWInD7UQxa03g+Wh3uSxbhYqy4YIyr3QjS7fln3RDLkfG3iQAUEhQcQZXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdjbO4ComU/x5ZwPSLU3QG+K9UUZCqCxCCydz4JpCjMZ5cZB6o
	DCiWnz0dbPHv25KKdOUCH415PZ8XhupkZjbODAMmXNNcabA6/exK
X-Gm-Gg: ASbGncu41OhTpiLWx8TBCf6oJu/PNQFnAZKSdQp5pdJZxI40xqZT9x8Ufmrmf05tyD7
	5rFg4OifZYel5uenO6i7L2RzEOIlNWbMJkRxxIWrXqUqKMWBmFmr+BHeEBsro7Vx0zNKi0vRfbn
	yR2DLlnNZGHsefPBqKPvEDbZ46YOcUvL92IQ53B6T/liMimprj/TJt5p6/PdYFfZGWNKm24kM9v
	pbgHk6UyBwRk0K+KDdemZ7ISlj7kOI/E/fDuXDWCpFEEO2P83LnXOJb9txYi6T8HuJrTwZ+3/q3
	rjQPkwi9KJW3vR30ezM9zUpKY3ZJ5rmiwqy8VnhrhgJfscrfNp3v1Hc=
X-Google-Smtp-Source: AGHT+IEEFzAbbhTr2CqRQC2EXWX67Zi/ObP/lfGtdbBcj/Cn28ZDX2L3xuKmw7SqI7LIVwFGVahzBQ==
X-Received: by 2002:a17:90b:3d84:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-308236343d9mr18315626a91.14.1744589899945;
        Sun, 13 Apr 2025 17:18:19 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd171764sm10061540a91.34.2025.04.13.17.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 17:18:19 -0700 (PDT)
Message-ID: <1294b288226cba1f9bc63956720be9c0b2ac6117.camel@gmail.com>
Subject: Re: [PATCH] PCI: fix the printed delay amount in info print
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, bhelgaas@google.com, 
	mika.westerberg@linux.intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, 	lukas@wunner.de
Cc: alistair.francis@wdc.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cassel@kernel.org
Date: Mon, 14 Apr 2025 10:18:13 +1000
In-Reply-To: <f56d8794-07a1-4040-8743-0599fb488dba@kernel.org>
References: <20250412060934.41074-2-wilfred.opensource@gmail.com>
	 <f56d8794-07a1-4040-8743-0599fb488dba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-04-13 at 14:17 +0900, Damien Le Moal wrote:
> On 4/12/25 15:09, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
> > Print the delay amount that pcie_wait_for_link_delay() is invoked
> > with
> > instead of the hardcoded 1000ms value in the debug info print.
> >=20
> > Fixes: 7b3ba09febf4 ("PCI/PM: Shorten
> > pci_bridge_wait_for_secondary_bus() wait
> > time for slow links")
> >=20
>=20
> Please remove the blank line here and do not wrap the Fixes tag line.
> With that fixed, looks OK to me. So feel free to add:
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Thanks! fixed in V2.

Wilfred
>=20
> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > ---
> > =C2=A0drivers/pci/pci.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 869d204a70a3..8139b70cafa9 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4935,7 +4935,7 @@ int pci_bridge_wait_for_secondary_bus(struct
> > pci_dev *dev, char *reset_type)
> > =C2=A0		delay);
> > =C2=A0	if (!pcie_wait_for_link_delay(dev, true, delay)) {
> > =C2=A0		/* Did not train, no need to wait any further */
> > -		pci_info(dev, "Data Link Layer Link Active not set
> > in 1000 msec\n");
> > +		pci_info(dev, "Data Link Layer Link Active not set
> > in %d msec\n", delay);
> > =C2=A0		return -ENOTTY;
> > =C2=A0	}
> > =C2=A0
>=20
>=20


