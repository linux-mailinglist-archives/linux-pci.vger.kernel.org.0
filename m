Return-Path: <linux-pci+bounces-42717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFDCAA2E7
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 09:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C3D73028597
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AF821FF2A;
	Sat,  6 Dec 2025 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="LgrnXvlM"
X-Original-To: linux-pci@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E6B652;
	Sat,  6 Dec 2025 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765009915; cv=none; b=g7Ds0VM8CVnyP6Jnn5jIbqduJDWBd9nz2PZc806kwPS/zcXFZZ2xsTnYtKqg8KrS22g5Kg8hzV5vx2lEd4xXefsJzM83mU8zHvV0uGB6YMQ23KU5mnKN9LX5ycL67eRrY4+JTCRU+Nm3HackNA6+8KOG3wKaVHZEm8JyjX7X1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765009915; c=relaxed/simple;
	bh=08ZsXFz4hHa7LT1bTlI4TKyqbZe+hNf3FwiBU79Yw/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GkHruLKZSPEDrdkGu3o3Oahp+5M8vVs5O9scReX/jJkDG3VtH4hCCHZ9Qh2U7rcI9jIWh8vjPh0mtWj3lRM0mykpkXKPO7QnbVa90yrooZvOhOB2jrkc9eCeBAgSzOpXtcRa63rJw5x6CLlHXw9EWTmR7DOd819rpHEj3p0YyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=LgrnXvlM; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=K7rCJSrOmAjxL1902WxL5KVCXKfi90yvheFx2FGvzLk=; t=1765009911;
	x=1765614711; b=LgrnXvlMV7ZmIKSKnqW8UfwV4AleBpMm+YV4Cc+7JhQEPfQdfoUT3xR4Cx+2N
	aFrjm9NTaZnwCAVJoxaTJA90ZfJCB7OHTq5hSVf1DNxBPyw6SCJnzjjOUY60EEU6z4RmOc8D+vCue
	8qwzwiXopw4euSz3soPbTcPzthV8szJou3VCZtM+C+CESe6ZFnKpbv29QnOLOO3vea5nwhs9jxw6i
	a72jzaEiYqFJelb1YadjcXH1bJnUQ5g3oPObOttKN7vCnA3uRMqQnrULixePn36ZC/AD0lXujBXu1
	+RnCYuhE5cqrcHUAdnX8m5HIiHapUuGa9Af3YiLFYv8tNx6TXg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vRnhf-000000016Ku-27kJ; Sat, 06 Dec 2025 09:31:43 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vRnhf-00000002rF7-16sP; Sat, 06 Dec 2025 09:31:43 +0100
Message-ID: <f419b6d8a36e43c90e1875da5fb67a7f2a18a219.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] PCI: Fix PCI bridges not to go to D3Hot on older RISC
 systems
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, =?ISO-8859-1?Q?Ren=E9?= Rebe
	 <rene@exactco.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Helgaas
	 <bhelgaas@google.com>, riccardo.mottola@libero.it
Date: Sat, 06 Dec 2025 09:31:42 +0100
In-Reply-To: <alpine.DEB.2.21.2512050237490.49654@angie.orcam.me.uk>
References: <20251202.174007.745614442598214100.rene@exactco.de>
	 <05c588754dcb83badaec6930499392fdd26be539.camel@physik.fu-berlin.de>
	 <20251202.180451.409161725628042305.rene@exactco.de>
	 <alpine.DEB.2.21.2512050237490.49654@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Sat, 2025-12-06 at 01:07 +0000, Maciej W. Rozycki wrote:
> On Tue, 2 Dec 2025, Ren=C3=A9 Rebe wrote:
>=20
> > > Is there actually a justification to restrict the use of D3 to ARM64,
> > > PPC64 and RISCV? What about MIPS, LoongArch or s390x?
> >=20
> > Because the ones I picked are more modern, and thus more likely to
> > work. MIPS is very old. [...]
>=20
>  How old is "very old?"

I've got two desktop and one embedded Loongson MIPS systems at home (not Lo=
ongArch)
and these are very recent (made in the 2020s). The desktop systems already =
come with
PCI Express slots.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

