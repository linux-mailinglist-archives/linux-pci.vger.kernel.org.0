Return-Path: <linux-pci+bounces-9795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672D8927550
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 13:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951151C212DA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 11:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B820E1AC447;
	Thu,  4 Jul 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OZK3/FWa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C01AC427;
	Thu,  4 Jul 2024 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093257; cv=none; b=T4hIqg0lPYk+BMybeoIpedSk69gz+W8ObFMhCDlwvkTd1yypXZc/nh82Ah0LMvdLDQ0YHn4OeA/aVRFJCxTIxWiFiJNmUxNolcFEQMfiaewQReydBqlJKeuVnKPbs7USKIoE7EwYkHH90WMiNuGpqHSWBH/bpBQMoPsL/NI4EM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093257; c=relaxed/simple;
	bh=0t5V8hGpWOJtneO7w5BxKJ5cMBWLj2YmpoYFdgKhhJ4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qUIPj4r8kavU0F/DoXdLXz2WA1DEY9FfvgpRPKTYtGiLyvuIMCvNUziBlBYe3xKXqxD4ekyyaHA5sWAH62cekzRk4x9IbBATFFiVU1dgPRN411UJtKrdUojaZ9Z/I1MbiZJdKlyspgpG5S5JTx6E/gfk0Bk0jTvH7sfurE3JWnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OZK3/FWa; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720093225; x=1720698025; i=markus.elfring@web.de;
	bh=eHPsQyXMv+fdN2eJFWuA9EeCEwuGrpNdVdYusCYWAas=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OZK3/FWa2MGNwyWHZ8eTEIucLKs6nxHp35hxJcby7u4aCdMN14vWVHntgn+RZ7Xx
	 ITmdeyF9dMPzUPyMfjnGWTHnhiqnU+c0zsErpfa4LRCHr6lkprsDXKVrW5l3Mtm1b
	 zpZKx/c0I9s8pqwNJRBkry0k1LCRZqJbYRydcFIKY1tGdMt+cGPBMOxvfG3gR60dA
	 m5QzpJ0kWtXiVJfmoPkuA/LI+b6pcjBZBgkc2ErXvVDM5kO0f38GVIdK/WhFrsRp5
	 gfZCXnL7iIW0VeruFY7MEb9ZuoRWGOp3FNQFYADYjVr+Vc8WAreqt2ge9KOrVkPga
	 MbwpIlh7w8AEZ2zJ/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgiXO-1rvVqv2Noq-00j6Tf; Thu, 04
 Jul 2024 13:40:25 +0200
Message-ID: <54dc90df-fc31-457d-a18d-b2070b055d60@web.de>
Date: Thu, 4 Jul 2024 13:40:22 +0200
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
Cc: Jim Quinlan <jim2101024@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
References: <20240703180300.42959-3-james.quinlan@broadcom.com>
Subject: Re: [PATCH v2 02/12] PCI: brcmstb: Use "clk_out" error path label
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240703180300.42959-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wFzxrPxvHc3jR+5oeOUWhDC+27wywMwXg1v28CkwWXzxj6HqIwN
 szjygXKEBIPIAoKgUsSGWyLNCQYC30GkKqPcxUcCrO+/r0CFNzzrECeISUPYFfyWq6ldd/z
 v4OQOuCl/sVHXfnr5lXdwlf7YattVGTodwudESgn0AyCFhEAjrNx+J16OZAFrJ2h4pynXJe
 bxuNw37pFEF2n4n85ymlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VBgHkCdOBcA=;6wT380QZCi8u1Ubr53ZAKOMXK/5
 Gm8/hqXRmLIuNIxKTfLkP7GgPbEEq77t7q/gl5dq+lgTtuw2c6izvudaU7PYk8spmx+DdG3Jj
 2gnZwjZ1kQ1f8JGFMdO9K1A9CjYrJdT0nVintaSXLKzWRktf1E/wpo0ZrI2FYnGv174iX0t2X
 eMTLCqLB1kKTpDqBddQ13ygmcOhFLQpYJ1ppQGG5pwHGd++h8+R//WhNbizqDL6bfoLHCg2b7
 1THQ0+vh+ypZdfJ/OUBaIw+gUbQXyN9TIQdoStLUpoH3vFYYkPqP8fb6QLVqtVYi+vuMVheCC
 MsWeZiL5uiZdMy76KrJHD5xpPzW37zIz33tKISHYOzb1sD06UVkW1PrKjruBjsR4s6QSIk7/p
 wbo5+PysatPVYvegmurZADvnhnxG/u3DdqSQQdp/DMYO3awnxuOZj1SLimYov02zE8FWGME0U
 X38X0AVuttjqJOYamH51RYd61GBsvBxDOBPRkC+29byuZ5PiiYRKBT10l71+wgpj9iEZ++eSm
 SHaQHGweGOak+1yVexmivlLWXLsRqvNOVSjmUAs3nGrdfDB2Rc54uijqGMMjn7riRG68P+vQT
 7Q9lee5kI5yGne/YaAUlVuZUe7UBut3S81m8x3sHbkWVX9lUe/9Euv9YRTKnpBOptQTya88Fc
 mpJbRm7pu/vxoHyz3N+kEen7sRkXWSdu8d/aOq7dZWxvA3ahg4+gAs7xLcWmTH6HxzKRduoZ3
 ++eI19JUXjfiaucJpQ46wxVA94mI+Cf/qeEqjbKCl2pZz4vrud6ipEr92/ij8/lMA0XniWYoi
 T+9LMo8Ba58E50eVbcOEcZ6cEFhrVMz5qaTKdGzrciTQk=

> [-- Attachment #1: Type: text/plain, Size: 1685 bytes --]

Can improved adjustments be provided as regular diff data
(without an extra attachment)?


> Instead of invoking "clk_disable_unprepare(pcie->clk)" in
> a number of error paths, we can just use a "clk_out" label
> and goto the label after setting the return value.

* Please improve such a change description with imperative wordings.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n94

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

