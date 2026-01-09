Return-Path: <linux-pci+bounces-44318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD1DD070BA
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 04:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6735300CAF6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 03:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D1236A73;
	Fri,  9 Jan 2026 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5oxOSI6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B3C8F0
	for <linux-pci@vger.kernel.org>; Fri,  9 Jan 2026 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767930804; cv=none; b=an4V3+4js/9xVdsmoXspyj8SYZK1DIxssxi8k0lVtiL+Ahrb6U5+wOA7eDRb12kcynQl+1B4l3RpLQvXrpQhTXA3kjP7viXkEXM6bKgFiVUexqy/9q2s7ncLgEPrTFVwx5DPPYh0pjKUqYQo2u8oFEWOVlP8KJyDxR1mg6fiNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767930804; c=relaxed/simple;
	bh=cjzf1hezxDWR12VFZVi9i8a61PH/8bIfFWYxzgThCic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JezdFfIFI7mV5fE2uxpZiRocLj0i5F6AJS1iwChw4S95vhIXaOCMmjBLvU4immli+gUj/587xuOeThiiT+0qMMD7RuxVydq4bD+Wp5l4B+xcrxkopXVW7q5XJgJHUCJ5g/N+KCrx+Tp55DtIrjGlrH+DLjMwmlpQ0YsbCWtPH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5oxOSI6; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso2888774b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Jan 2026 19:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767930803; x=1768535603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+Aa2YGg7UhZCDl66L6h+JyJSb8ah/8nQF29Auvd56Q=;
        b=T5oxOSI6i2ZQqvTjeqE3fRjMGUz6yJgOosZfFTd79hRy1+BVyKctGUcnYLGAB1TUED
         G9hiqGCRxgXY4oK1MN3eVq833nEBBzJLRreIsO8yH2nXMatJXFwG49RCwB7mSZbUGL8H
         MZm8AyFQ1dG2r1/TyW87UJa0W53gYtOP82XvrPVPxMdrkZioQHo1b/3Fo6T5zH6KnVOX
         wp/TeQMNg/mDW4eTkE1gcsYzlCkrlj+1XGXyo+yLyau+7jKUwgmAmvAdW6pHyZNIfTG0
         gUhm7Z+NVLKoxZUGF/3eBLEAgCQ13oTXAeri4rDa9Y2Dtv2pFOL9ztS/DlgaIrp/wXhd
         BFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767930803; x=1768535603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+Aa2YGg7UhZCDl66L6h+JyJSb8ah/8nQF29Auvd56Q=;
        b=RwmtFcDS41d/esOjYpFTR830UHDVgn8+hsNlg/pu+cHp2LgmFUi9A1/IzwYNudHkZa
         JU2QWNxIQPL0md9A80L9mPxWBT17tNCEJjXd5njsqenQnQAiyTp3kKezjPuxoXjV37eF
         df0oip+OOmT7oKDJB+jOBqp8opZaEqb3PdM0PRWtSne5iateZEtx3o19PKohsaY/vxmU
         KZyE+m9OIQE81BJXfvl1/OSyQcBBsKMXQ3rL+g9c0Be7oxNJ6tL6GiWqhjpi/UX/DM8K
         miNoKI2UjBUITamPzbBtLx580IjVjZDo5K9KzxgKVmym5PQk5Ltg4BmC0GWS0Zfj3YuC
         DQuA==
X-Forwarded-Encrypted: i=1; AJvYcCV5mrvsxS8/OrYrv4ZmTy/wQ/xUETJ90riPNoL4zQMgsOO5oVNLL4K7r3IvkJnekWS54/uYV6FuBTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJgYjNfc4ePnvMTGU9KVfDdPutqLX44fHfkzMOCt3T8wMISkGj
	tu7J8L1LrxegjgGGN2NyOIPfp8NGUjVcRL//d2RolqqQUXmZ/HBbPzb0z/dRyPWKSEM=
X-Gm-Gg: AY/fxX4pnS/UixqNX4Ut/BjopXmh5heT3pUPOyMq04QwW6ZBMJcip5pAQVNstMV9sXB
	ubJTmAfrL86yiGVrfMVuEE5049B7eKlAA4jOr7UXgvkrZHJ8oBOeOXALIQm0uEdMkDyEZVXpH/q
	bGqNRjkzYiYf6RUDAC7nlAXpeRL8/KizY0NkTMhkhIaUzN71oUnW07iT8DfjUcbhd/z+mb907GW
	tPdsekDJHMk66o0iLTP0N2wil7EM2CX+YHBRWH8IjtdH9xl3l7Zfog22AoqbEI0x4sJzFl0QDQm
	CqvJvNavNOw4dbPi6Kya9O8TSDk+tsxRoTuBeWmoAEYX0L/mPimhiwFVfnWY+T55MptOAazs9HN
	HCYItdCS1IXft3DW5kGcQRcp6wr2Luqh5MhNFmxnRYkuyVnuTtq6B5wwtY8V596X1lrFzp3tEgi
	kUDfbGQCk=
X-Google-Smtp-Source: AGHT+IG3DbwcRlj4uCjp94O1bayt9ny/rytFl1TUbZvGzdohtEHLlfp1Gg9vbixfjueHNe9CAYoQWQ==
X-Received: by 2002:a05:6a21:32a5:b0:366:14ac:8c6a with SMTP id adf61e73a8af0-3898f9b549cmr8446525637.64.1767930802586;
        Thu, 08 Jan 2026 19:53:22 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2acdsm90501745ad.89.2026.01.08.19.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:53:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 18C0643A9037; Fri, 09 Jan 2026 10:53:14 +0700 (WIB)
Date: Fri, 9 Jan 2026 10:53:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 2/3] Documentation: tracing: Add PCI controller event
 documentation
Message-ID: <aWB7qtKhzbEoY8pJ@archie.me>
References: <1767929389-143957-1-git-send-email-shawn.lin@rock-chips.com>
 <1767929389-143957-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tfncDExG7J/FagGI"
Content-Disposition: inline
In-Reply-To: <1767929389-143957-3-git-send-email-shawn.lin@rock-chips.com>


--tfncDExG7J/FagGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 11:29:48AM +0800, Shawn Lin wrote:
>  Documentation/trace/events-pci-conotroller.rst | 41 ++++++++++++++++++++=
++++++

Missing toctree entry in Documentation/trace/index.rst.

> +Available Tracepoints
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +pcie_ltssm_state_transition
> +-----------------------

Please match section underline length.

> +**Example Usage**:
> +
> +    # Enable the tracepoint
> +    echo 1 > /sys/kernel/debug/tracing/events/pci/pcie_ltssm_state_trans=
ition/enable
> +
> +    # Monitor events (the following output is generated when a device is=
 linking)
> +    cat /sys/kernel/debug/tracing/trace_pipe
> +       kworker/0:0-9       [000] .....     5.600221: pcie_ltssm_state_tr=
ansition: dev: a40000000.pcie state: RCVRY_EQ2 rate: 8.0 GT/s

Wrap above example snippets in literal code block (use double colon).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--tfncDExG7J/FagGI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaWB7pQAKCRD2uYlJVVFO
o5mFAP9FeIBElbvGhzGEGTxXvKkxEhBsgv2Q43GHm7uX5DykmwD+J0p7viA36u/v
No484hOhG6lBW2aezEIzjzxuZ2BVBg0=
=UMJa
-----END PGP SIGNATURE-----

--tfncDExG7J/FagGI--

