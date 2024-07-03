Return-Path: <linux-pci+bounces-9755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DD5926883
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 20:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EDB1F21938
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF1183092;
	Wed,  3 Jul 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DLfBixoZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853A17A5B0;
	Wed,  3 Jul 2024 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720032373; cv=none; b=utBiooD3ITGPss6/rUKiWrphNBwSFMKpTyuurOC5U8slCPQJLOMAe3lhS21vLaXgTsLu95qyJ+NBGukKuJ6kQTQbWZGcvYn3OuKoH7t48H5rwydy37vuzvTjmOf/lu4KpQzhSCXWB+Z1dFT5yyE+ayTbBrxNuz1WMd/oSvwoE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720032373; c=relaxed/simple;
	bh=kPIX61siZctF08qrEZVgtqzW6Cn2xm9fmIbovyzSQkY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qo59QUuSzbKX671IAFDm7NWJgPKaHB4hZCUmIOWFrVH3Vb5AzK5Hv6spK26KGKEtymkaieDc8QetrhwUcbC9Pnwze091NIMgcYr9N7fxfJid/av08bL3721ojPBLD+Sm7uNBq++0tzEOxSAsZ9v107eehb0mHwN5w5E3HG0/INI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DLfBixoZ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720032342; x=1720637142; i=markus.elfring@web.de;
	bh=Mp/RJoiuH5JiTbBnMyafiYmkXjelrGaI3F8h2g29e0c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DLfBixoZfSzfhAqQhaJRZxKMEWBeWNTs/I4tZy8GLj92Uz4CuoE5BaMRKt0w8YB2
	 kdfa2rSjMsn+COXpIqnbYMeODqSvQ0ghCP/51fvflpO4HKp2XtTlPWFZ+u8ELzDZq
	 U/2lhOAG4vjFLanfW9RDCFQyCqFYAw6ywSq6kiV2LQodarS/jfks/cQdRlirzCyVQ
	 3l0pZS3yOlct3FokXtKQbWK/2q/g6L5xsTQtoHuGQfwc7CDDVZbHY9UbBWkw3A3rn
	 NWcpF3SK5EAur9DKh3eOzvl5ZSl0Z80JDR9pMPRlewAEMU+p+mVBngtvZcV/q1NvT
	 xUi05W/X9Dzmk4hO1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGWe-1sYSv93Y2s-003ArN; Wed, 03
 Jul 2024 20:45:41 +0200
Message-ID: <f90b597d-1e0f-497f-b092-3cb4d5f9602d@web.de>
Date: Wed, 3 Jul 2024 20:45:34 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 Cyril Brulebois <kibi@debian.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Stanimir Varbanov <svarbanov@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
References: <20240628205430.24775-3-james.quinlan@broadcom.com>
Subject: Re: [PATCH 2/8] PCI: brcmstb: Use "clk_out" error path label
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240628205430.24775-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:36kGwr4RXLOs7Zyisb/7KuH3H8Liv9r7JcDTXD8/jLwpnjgF0hH
 ol9kafgktAzGSLXOI3u5n7KJwetN6a6FrYF/Jlck0Kaqr7ZIa3D2cxTdXotpITGEgELkEbx
 Ok9BtNlxZWTd7R5H4q8//sqNHFG5vJ+9F0lZSo/ZhRSfhcGi+DcEVOrSsy1m/UXQsdITxE3
 7yGSt0qlFVPzxzuxYp49g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dIV3an7U1FA=;Q2jgiRBuBnX9GKqS3FEqNVzp5+N
 C/B5fQgLI3Dq6OBVYywgdc8zmgY8Tbshr6GC5ABogV2TiRu8LV0IoWb0qODMaFmZHeP3SElDo
 Odz6hJ2XS6X9ej5kETmc7DSstPmdOzjaFe4YhElbJkzqXogvXPbXcRc0X/RjhLmiyRoDBA3MD
 zwS7xgsGla/hcSKFgCZ2hA0NX+Uxc6BfG9TW3zZ+kQ//UvoIyrajsDg2j8ZqMk+bqxEeO0x9d
 RPxru1IVjrJAJPij7i0nkk9qx1zviVPBKUBZNErlY9PG3sRs3jl8AksGvqpd67Ot3IFrDPJTb
 NBa/Xv87Go/P5Xciu9GsVtOtkWxExZj5NLJKMBulNQLKd1oVTUXVwLCunBrR9p005jy18W9D5
 81Yb/H2X1B3IV8/fH3eziMG4ZMIfQ984jZhbUIWazfg90CNdW8VON+/a5RTpGRMiBYqUghlZA
 /JPMw062527JCKPcHS/Dj2MUlue883ilzlStgUNlzwa1G1lVv6KtxQ0fBV0cmqc5MLb6tizhK
 DdsowquqwXFn1wp7VYm72yz3wE8E+DOz7lQ8nx+xW55t4DKl55Mstitt9wr4WCauuOCcDBBqh
 gmx1dz3aans2fVrAjZZV/H70EmV/AcAefhFkf1aUYRYj7GRSOWPAb+0gfi/RLzDnGgND34ij1
 fif0V37vWJMlWk6oOE2Bz72qsDziw3125EIwPx7d7Y5koPLphLLTnyFIBOQ/+yBy7poCCYMsw
 JLZKnjDxWCSYGzBakul3szcE1vDTYjql48Cpu7xXeo7K47FqIA8TmavQvsLFZnGYNUnpBToMh
 sQmL+nRzgiuBMOIc6HDaTdEUfhU5vBdLOEMm2fCkk7C9s=

> [-- Attachment #1: Type: text/plain, Size: 1600 bytes --]

Can improved adjustments be provided as regular diff data (without an extr=
a attachment)?


> Instead of invoking "clk_disable_unprepare(pcie->clk)" in
> a number of error paths.

* Can a wording approach (like the following) be a better change descripti=
on?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n45

  Add a jump target so that a bit of exception handling can be better reus=
ed
  at the end of this function implementation.

* How do you think about to use a summary phrase like
  =E2=80=9CUse more common error handling code in brcm_pcie_probe()=E2=80=
=9D?



=E2=80=A6
> +++ b/drivers/pci/controller/pcie-brcmstb.c
=E2=80=A6
>  	ret =3D reset_control_reset(pcie->rescal);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +		goto clk_out;
> +	}
>
>  	ret =3D brcm_phy_start(pcie);
=E2=80=A6

Does this software update complete the exception handling?

Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=9C=
Cc=E2=80=9D) accordingly?


=E2=80=A6
> @@ -1676,6 +1677,9 @@ static int brcm_pcie_probe(struct platform_device =
*pdev)
>
>  	return 0;
>
> +clk_out:
> +	clk_disable_unprepare(pcie->clk);
> +	return ret;
>  fail:
=E2=80=A6

I suggest to add a blank line before the second label.

Regards,
Markus

