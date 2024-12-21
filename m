Return-Path: <linux-pci+bounces-18935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844D69FA21C
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 20:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB5F163E27
	for <lists+linux-pci@lfdr.de>; Sat, 21 Dec 2024 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848AC15C140;
	Sat, 21 Dec 2024 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="g+qXg2pq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831063B9;
	Sat, 21 Dec 2024 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734808746; cv=none; b=p+VCnpIg0AVsPfEgsU0R1oK6gA5iuSchcH0pmyXQVHDtxU5UgRkNN98Q2TpieWEuoClT9+NE6QvBV43uCkRTG9OcG0gje76VGxDsq+LLAiNLQfaHq2nufDoWREh/Wdu6qRMQElfs0/CvJzcKmL4hBJCjOsmvrSNYSWYIzNEpA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734808746; c=relaxed/simple;
	bh=f0HpRvQ0hioTHIw4WD65hnzsgzz9OYIVi/fd6K4Vcqs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nWHoZAlEttCvsN8bNTny1mVLDuazYnPuulXpbXRhrhVzq7JMuaD/6Aac41QQbVB6H4HbCvLHEewx1WgqIotAZhHXf8nQflw+5tdm9hdjOuusVesVp0tCqTafJRrFussni+OUNUYA1039t3QfY2M6nCLycCWR+ZLY5armA9rfBTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=g+qXg2pq; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1734808710; x=1735413510; i=markus.elfring@web.de;
	bh=f0HpRvQ0hioTHIw4WD65hnzsgzz9OYIVi/fd6K4Vcqs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g+qXg2pqsqrZFMUJdTKl6y4Q6sZnrz3AgM5vBbJ6o58vp2tM/1buu1ux7hsPQ0Hq
	 krmh0xrxLj4cCRir1ltBCHggnXDGXQrLBztlgrIsiGMfAXkjSRDDSNomE8wCzr+Cd
	 z38pyzC3RYi9MRqmA6uH3lGtvuWjf/BDJq1dfVs6oL3Glf/eDt3zNOw5546M0SuHS
	 a80erqhxqBYihqSJap7qfHndCATa+LIJrksxDEWzUEFdyfsFGrIV9O9i/ojL1HO/L
	 MEcsHsopUMMkFjgcP2a68P1FWsmtocDRE768uLGKUjB3aun8sJ4jPTnZpa+tTsiNO
	 AgKoeo3FaHJZINb1BQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.93.29]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1t1F1l0s2Z-00TwaB; Sat, 21
 Dec 2024 20:18:30 +0100
Message-ID: <61237444-4c0e-40c6-b478-dc997e49cfa9@web.de>
Date: Sat, 21 Dec 2024 20:18:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mohamed Khalfella <khalfella@gmail.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Niklas Cassel <cassel@kernel.org>, Wang Jiang <jiangwang@kylinos.cn>
Cc: LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
References: <20241221030011.1360947-1-khalfella@gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Set RX DMA channel to NULL aftre freeing
 it
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241221030011.1360947-1-khalfella@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gh2i4qqIYS7pQ6O/4i/OrhruRpx3sWNiuxkTN6OcwXmA6aHbDlw
 lnqseai/2Wg2FBeaNRrTUC5V7jPLVyWZcV+F8d1oebFU6hPiJnHTvhq5etJjAZ7PcRIcy/Y
 vPL1N3VWAZ6vd88uRhNJiEizEuWcbFnQ62WIwfUOStHhk5ledzSwINp4ViDFB7amE4R1PRz
 XVJDzHSo8dKrau+87ojpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XhhpjUITr5c=;acn6/cFvYIJ4ps0Fc5wOeBJBqS4
 7GdqvCfXw+rK6JYRBQef65b2xw8ZErd8Nvt38GiEsSDNe1PrybWJ0f36bgGoTuoTR0+Mz5Iyr
 PFPo5+brSwZUiln2qealxD/wlpL8CCmZCQ4ez3+r3kHoOBTut7sBmdKmtM+eYDmR/VE7U0fFH
 DEGkb0SWId8hX3joP3kbYKPKi8j2j1RzhXBcLHuQKmST6/jUTPkH2+mnhyRPbZXYfWEFRHXPe
 95Xt73QsYUl7MnAyFy0l8HJSNgqYt6R/H3XjYUdwM5aqyPJYRa2iovJPoZHcRufpBQ6ps3iUF
 T2lWZibfRzeWT379RIxBed1F/m8ABMrJpP5mEHYtR0UAEcgbsGhoPssHOu0vempOCHFSPFAMh
 6Hp7lLS14HA4JrVBOVwx0pSIo7b4t2ZCUAEWueHcgf0znMBPEXKsZWW/M1rgVBs62gNSLXLGG
 5NNpYvhczQRYX7E8OqdbeALrUJJIgtvf38EfJ5K/M5JkdNofjULEJzUY5HXmNdFeXZCqYcu1u
 RmZmhRek7Fs2pAtQ6WWsuvZM6ac7f3lhiAx62nl+ekZ6Sle3MzPpXU/YGCdjAyB9EKArSPvD6
 EtnI+lpa4YvsQyl/rO/64GZTTQLpsv9LaIXNmZ/1LpyrYpyJdxCUjtYJ2Wa6GMmfXStpitIci
 GLXywZ5gZsvQkCbtoD9pMHKWAPQrVKIQ06e/07+4XHq89+N3cbbCGbVyBzFVrATLbaW7/h2KO
 lz2+ixf0rp1Qj2A+2s9hxJVxmpT90Z2dVsa8nuZLtAWYkoO+x60SzZesqMommDlmegN9mvLL8
 OLM4D8BowfDL76PO0twmSguxxw60dWrruw/EsnnjgkPFkmQnXDae60oHfPWa2sSGpm2i1JzVq
 LDpa0vYuE/OTT+6rwwHvz8wImK6+lmEQt9gP+4tOpHSs7ttFgmFaLE8wTJwpJ6cey/TlSuuFP
 1Mue3j/BSIbn9aRB4X/LCI1CYgx3SyuTVXZ8nipgPPB6rr3n6bIA6zfBQ3ejlJFjjckh0mSRb
 QWvdjdzBsnCr7uVdT3lTE/D3rYVEcEJrgo010FIkCwXTAmGa1wZe6oyCNU9fFrrOqRwUCMvtA
 KYingSRl4=

> Fixed a small bug in pci-epf-test driver. =E2=80=A6

Please avoid a typo in the summary phrase for the final commit.

Regards,
Markus

