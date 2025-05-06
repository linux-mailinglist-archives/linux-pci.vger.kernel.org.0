Return-Path: <linux-pci+bounces-27283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0703AAC8B2
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 16:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D0B3B0B94
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D72836BF;
	Tue,  6 May 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ccm8KxW9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B52836A4;
	Tue,  6 May 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543107; cv=none; b=YiPwJKxtgCudKV0gO+8wFajptqlOtR7OlAiERvPJunBd1VZBuADJcYR9IguueQ/sfBJXiRr9Uz2bR2+Ql8nQ55ipY/h0VSE6kFBnzcXpjLvsljMcLj8cUsNqNW3Fc1CncYxywPRPrsgTIBqc/5ZZoIAFMfitcqMMsBYEIvR8qUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543107; c=relaxed/simple;
	bh=bPzrf6CYkuyb9QFQu94A3pCiefvXzHNYvJacb6bhD9g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sw/BTge/xuNeND59E1uMJJgkjUixhYa+i7IFOnZwIKQ6ZfxyccMjVsauSPRBSAdJA25dWn4v4ZTpOhbNFWewDWLkA1VCZgBlklV+u+KiDLiEH5ADA7FPmAIr6TY3KgqztG0K4B+27jtCCl5ZCztdYTWSsEqjhe3uM9Y7AXKED30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ccm8KxW9; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1746543102; x=1746802302;
	bh=LLO17FglWgYSVBW2cYDBU2hPFlvOAFb4nPLQLayDh9U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ccm8KxW9LC7iFnHe38StTvImk0UJjsJhNM/yP14IzScKDGNntYNqyapZijEE0K2/6
	 9mU/IZHZRZ1ViPMHaNWTgk6SiV8KyKinklKvCTqqLFp/lrZasWyBTqgV3tK/a0oBqw
	 aP5TzCcZvfF8jhcHDxzPfJNmS9osqwI3aIoPWaMJjMlLdsMMj5/yKgZAFnUK6oJNnX
	 xciJ1qkjdgjFCcaPXw6ro2dhLJ2ARZOlXlwYGzJXYSaS+/fKMnmKED3f42dMxAdo32
	 1Q7TPNzCuKuhNgXTxsfPF4ctIAnHjSeQcFrsf5h5NkgRDS2AMeofnFeHl3dqWiDar5
	 NnJa5CL86Tq9Q==
Date: Tue, 06 May 2025 14:51:39 +0000
To: Niklas Cassel <cassel@kernel.org>
From: Laszlo Fiat <laszlo.fiat@proton.me>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Krishna chaitanya chundru <quic_krichai@quicinc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] PCI: dwc: Link Up IRQ fixes
Message-ID: <-6f4j_eknGQJZqqLhxH5YFUXv6uIumEfiFbaPQXGPoQYpWZUrt2y8gx6gqw_mM0leAv7U3znZbcHtlmKKdt1xZVt0ASVpH0pBIoMChf0Iwk=@proton.me>
In-Reply-To: <aBodwvmG6ENM7haH@ryzen>
References: <20250506073934.433176-6-cassel@kernel.org> <aBodwvmG6ENM7haH@ryzen>
Feedback-ID: 130963441:user:proton
X-Pm-Message-ID: 5ad6aa2b5e02d5ecce87cb33b4d947670322600f
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


-------- Original Message --------
On 06/05/2025 16:33, Niklas Cassel <cassel@kernel.org> wrote:

>  On Tue, May 06, 2025 at 09:39:35AM +0200, Niklas Cassel wrote:
>  > Hello there,
>  >
>  > Commit 8d3bf19f1b58 ("PCI: dwc: Don't wait for link up if driver can d=
etect
>  > Link Up event") added support for DWC to not wait for link up before
>  > enumerating the bus. However, we cannot simply enumerate the bus after
>  > receiving a Link Up IRQ, we still need to wait PCIE_T_RRS_READY_MS tim=
e
>  > to allow a device to become ready after deasserting PERST. To avoid
>  > bringing back an conditional delay during probe, perform the wait in t=
he
>  > threaded IRQ handler instead.
>  >
>  > Please review.
>  >
>  >
>  > Kind regards,
>  > Niklas
> =20
>  Hello Laszlo,
> =20
>  Since you have a RK3588 based board, sending a Tested-by
>  tag on testing patches 1-2 makes sense.
> =20
>  However, patches 3-4 are for Qualcomm based boards.
>  I'm not sure if you also have a Qualcomm board at your disposal.
> =20
>  If you don't, Manivannan can probably drop your Tested-by tags
>  on patches 3-4, but it might be good to know until next time.

Hello Niklas,

You are right, I only have a Rockchip based board, which I have tested on.=
=20
Mannivan should drop my Tested-by tags on the qcom patches. My mistake, I a=
m sorry.

> =20
>  Thank you for testing!
>
You are welcome! Thank you for making my board work again.

Bye,

Laszlo


