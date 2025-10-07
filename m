Return-Path: <linux-pci+bounces-37659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DA3BC0E07
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 11:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDBF3C206B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC7C2566E9;
	Tue,  7 Oct 2025 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="alhuDt7s"
X-Original-To: linux-pci@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB270158874;
	Tue,  7 Oct 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830078; cv=none; b=jV6B8xfc6xUAEBhvWdQg93/i2A/A1Z3OFCZKPcitU/JjPBhpCcmmpLSAeDpBZor8aBgNtOjJRXo8m0kVzllnFDSDu5ucCvhBnzmyJ51B1LbeMzcqJ9949Y4G9MZjSKy+np+UI1v5KpBYUU+PT5xNsdbAKKWSw2r5mPfr+JZSFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830078; c=relaxed/simple;
	bh=Yl0b5wauRFDcVVfHTZ0ZzZ4C2ktVgGqGYjCXELOnT48=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dbGIb7wGXE3QpKRa29vy80ES4+QnAUJkF8kKNDGBVtLX5NgU82PgZWWcCDQn+rYd3nT+arAUOvXVQX/KS7QUz40HfmTIYgHSXZQwaiSErPqHz1ZeHeP9NhBfX5R+JBTsjvZejKlBhjx8CYdeR8dEr/+KgKrcrXQQCKOLbVASyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=alhuDt7s; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=X13BoCz3JYAX7vIvmjbaXJVqzeYJjE6+iBmJX/F4R0M=; t=1759830075;
	x=1760434875; b=alhuDt7sPMVPtfAANGwlazFLZmOtclQCT7HAgwx7o5BL9OboEqmR4V0Xve7nr
	lvay+HIAIKn3EjSf6YY8Wby4ffRxseFnkB6Bk8UnyNkL06ptLCqES9liuroiQlKfGVnoCXt+pHuNL
	C8Sy5zl7HdD22XY9iJ4CptUe22rl3Ae3xUreDkZuK3lPt8UCY6lwVzpJ0Bm5E0EE7fRTAXkxF8ehn
	Tpq49PGE0a6FwH6MHwOdx78OZpTROFNkomVEQfUd02mUdy7P6neeRCT3wkKxHA9WTFnOq636zEVB2
	+v8zoH98Q0x+AdedHjuysL5JcNU35dtqkJRS3aq59URXOwBBkg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v64C0-00000001yfz-0Fim; Tue, 07 Oct 2025 11:41:12 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v64Bz-00000001VNO-3RwC; Tue, 07 Oct 2025 11:41:12 +0200
Message-ID: <46382bc6cab2196a79780a946bee96dde402ae31.camel@physik.fu-berlin.de>
Subject: Re: [RFC PATCH 3/5] m68k: amiga: Allow PCI
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Daniel Palmer
 <daniel@thingy.jp>
Cc: linux-m68k@lists.linux-m68k.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 07 Oct 2025 11:41:11 +0200
In-Reply-To: <CAMuHMdWDfNgUUh-uU7ZFKmmAccEMqDdfDpwRXQYmwjMG6O_Trg@mail.gmail.com>
References: <20251007092313.755856-1-daniel@thingy.jp>
	 <20251007092313.755856-4-daniel@thingy.jp>
	 <CAMuHMdWDfNgUUh-uU7ZFKmmAccEMqDdfDpwRXQYmwjMG6O_Trg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Geert,

On Tue, 2025-10-07 at 11:37 +0200, Geert Uytterhoeven wrote:
> Hi Daniel,
>=20
> On Tue, 7 Oct 2025 at 11:33, Daniel Palmer <daniel@thingy.jp> wrote:
> > The Amiga has various options for adding a PCI bus so select HAVE_PCI.
> >=20
> > Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>=20
> Thanks for your patch!
>=20
> > --- a/arch/m68k/Kconfig.machine
> > +++ b/arch/m68k/Kconfig.machine
> > @@ -7,6 +7,7 @@ config AMIGA
> >         bool "Amiga support"
> >         depends on MMU
> >         select LEGACY_TIMER_TICK
> > +       select HAVE_PCI
> >         help
> >           This option enables support for the Amiga series of computers=
. If
> >           you plan to use this kernel on an Amiga, say Y here and brows=
e the
>=20
> This doesn't make much sense without upstream support for actual
> PCI host bridge controllers.

Isn't this what patch 5 does?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

