Return-Path: <linux-pci+bounces-32379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F34C7B08BB0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 13:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28425864E9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F94428D8F8;
	Thu, 17 Jul 2025 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JRBirgXZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA629AB09;
	Thu, 17 Jul 2025 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751529; cv=none; b=WFI99RKRp+OQAY7z82rZOY2zpvBbRkA5CBCn8AOYKq1gT0mFJ+Ke9n1F1uxIX7dS1VVSBO9DH0UdSWqS8BBDqxK1huo6XmTaz8qbdK1+VyVz7Kx2IVKfz9mlNH4kDkOVQZVpAsQUNkk0kJ8l2A2y5U0XeKR5JB1KbV9fvLskeg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751529; c=relaxed/simple;
	bh=Ek8SEy/ppCz6vbUwMxdK1UcJgzVgbohCN9XGEqKf3x0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PZL1JWDITCiLaAHpxbA5O7C++XN2+2qu3RfPy3PYUtIsHyGfWqWf6Emblxs+49zR1gi8v96MQR64xQVzjt8iRhW0m5n5vciZzbz895ARQZcpUbU1lJAG5BO6uQcpqRQ2uhjpwX5owD80b1XeRw6NB30Ov6I37DnxYucfDwstPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JRBirgXZ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752751498; x=1753356298; i=markus.elfring@web.de;
	bh=8OcPZ0Ucw1okByzNGmf7IO+mBf7QUuTP6TAjK8en5rw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JRBirgXZoqHs7ciKoNImLi5fWfh040hoVidCtoyw7bfo0YpnUyoc5mRg/t1M4qGz
	 47bnJr9RNYBGdQH66Y9zI2CyYoR5Q0onmFRs/mAGq7Q2JDPWzguSHOy3VQvYTXAYH
	 C/hF1HmD4KJy5Ey7KJju4zC+t4DrFwrrv7h2eYgjK6+MhLI6JFsoAvl8XOuRsrso2
	 dpd5nhMOy40yN32CitPJEPKXeiTVtnZ6oFghlG5f4fuO9j/RiKuYvxA5gyqJlCLNt
	 BFzC18ft3viZkmHS99vfgQFrWnFF8K2hppa5MDGBOSf+SSKIZuIplH2+1Up9Ss9r4
	 nDiXUZG8j+HRwDEARg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.185]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8kAN-1uYDs032o5-00EyOC; Thu, 17
 Jul 2025 13:24:57 +0200
Message-ID: <fe0d27b2-cc86-4681-b089-b214afbbd3fc@web.de>
Date: Thu, 17 Jul 2025 13:24:56 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Toan Le <toan@os.amperecomputing.com>
References: <20250708173404.1278635-7-maz@kernel.org>
Subject: Re: [PATCH v2 06/13] PCI: xgene-msi: Drop superfluous fields from
 xgene_msi structure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250708173404.1278635-7-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FgQynEO40w9zI3vDeDUCbwgqIxMItoKDVDQm4BSC3xqahQfs1Zk
 nbQ+37U9hYGSSCcrHfGt5XPJycP9qZi+0hXezt0JQCAxiVmQqO/9KQpeG8VFL1XJe0VAeLW
 dMwwsmuhfGxZB1Ov8rmspCQ8eF7Y/oIrRDoFfkY9Op73xyl+juCJcg273FcGrWyc+GjHTCH
 FfvEPpOEOYUvA6xSVFtGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AeAtWUZA79U=;q+ItQTMz043vZWcIX4O0CV2z6CD
 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

=E2=80=A6
> +++ b/drivers/pci/controller/pci-xgene-msi.c
=E2=80=A6
> @@ -214,7 +212,7 @@ static void xgene_irq_domain_free(struct irq_domain =
*domain,
>  	mutex_lock(&msi->bitmap_lock);
> =20
>  	hwirq =3D hwirq_to_canonical_hwirq(d->hwirq);
> -	bitmap_clear(msi->bitmap, hwirq, msi->num_cpus);
> +	bitmap_clear(msi->bitmap, hwirq, num_possible_cpus());
> =20
>  	mutex_unlock(&msi->bitmap_lock);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&msi->bitmap_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.16-rc6/source/include/linux/mutex.h#L2=
25

Regards,
Markus

