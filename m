Return-Path: <linux-pci+bounces-19319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB30A01BC6
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 21:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948E13A2DF8
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 20:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEAA14F9F8;
	Sun,  5 Jan 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nOzAyYM2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCEA84D29;
	Sun,  5 Jan 2025 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736108839; cv=none; b=NO1UT6qG0PTxI40XjepSHBVhJfDNrRHKo/6uwnhNfz0MXjG7a5uAKVQig5CdhYxJv51q0dqeXUuwY5JbBY/vSpko+RM1+71TXWdY5OPpw69sEZ/daxpVQOcORbhcQhAcyovB0V/HKtZpW4jaTQNqbd0K7sDLdCgK6kHKE5NYurU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736108839; c=relaxed/simple;
	bh=58qULRVWr9hMZr3lET2E5PRUQ6delVmmtebNxc4U1Ak=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DcqU2y44ownvfKQdz3H/QLrOuYDzgJiBrjIJiYRiOzexor5yncOabdL8UtLUeCRzerhiq9u1L/kpjEZAY6MUlH+B7uZtbwJl+I43hfRxhOgYR2Bnwlzlau6tT9l/z/aY+J6ItKQWPf3Idwv+xZVBV4VNMJorXcL+YgHrtvfe5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nOzAyYM2; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1736108812; x=1736713612; i=markus.elfring@web.de;
	bh=58qULRVWr9hMZr3lET2E5PRUQ6delVmmtebNxc4U1Ak=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nOzAyYM2Wd+o3EHPjCc8esCdiAbFZ99wmWKg7egl8wdxorkhiouCs1L1FUl+JoXu
	 WngslhfF7SgKzUB1U8sFUAONFMYHKZJ9jFGvectnGSr5GvxZvRI2+iZN50LXF3h4t
	 IC/SJCB94FOZnED4IlQLhcCiWC5TEhaEvlzyPBKYIDBOcb11xneS91AK0iGQIrhYZ
	 vNWOdBANDi0xgG86nivtvEWLzjbXLgt4U45ZwNWjifXeYxYiIkUp1cyHAsaHroBBq
	 E7f+6yDx/+faty6li15AFCRa30Igu8LjBkdrBt24duRm/P/V0PrMeH32qyqleVRdO
	 HhRPVsAkB7TtWtdX7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.17]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3Ez3-1tThjC3Ra1-002A81; Sun, 05
 Jan 2025 21:26:51 +0100
Message-ID: <c80c06f6-d283-4687-bf32-9b6be19c8257@web.de>
Date: Sun, 5 Jan 2025 21:26:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-pci@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Thierry Reding <treding@nvidia.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20250105105927.276661-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] PCI: fix reference leak in pci_register_host_bridge()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250105105927.276661-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BcMa+aPchTM4skFyDan+jVpxs55rFWi9hblbLBBlgcKaAHqjcpj
 IO3FjpVjn2RdPwF7y9zhLu5PrsetejA0N+nf7GEflNtmvaARxxpQ4NxsBtiSKE8IhGfKdD8
 9qh5RaiyiL5+TveMWJAx4FSf7/8Tr0LkLi4bXKr7GsN5MFurUXPBGOTq4y9GGDt414uZx0u
 SjfE0CMuaBSCeFNYAYemA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X2y37VtCzfY=;6ktzJ0o4sivRgNOTNzjKBdSQPr6
 XkV9iOC9ZSpZAuaIegsllKSGMSCF9I5EmfGcGkR3JeaO6UFQMwz45d8i3Pc0rmf96SD2rSDhJ
 c1dGyjgz5tWEwpjc0cLot88N2dmxyjgJqIp6dFLlwJHryVIZv9rTCn97ePMQYKOQzuRGNeAjI
 fmqhr3EWPs5wqhlJosiAxwss0KRdc8EH/ZLX4Z33crWkfvziP15hwDeCc95zz533MV/G0NWMN
 cJNm71e7r3WMbZeCKCGtmHecNDw2H8TPp/h+xFJu+wMT0KRny8lwSXzlxTkiy6OKx1u79a8kt
 0Ri6w4LMOsan6kS9ouHxywBazTdgv3Z6jQKjQ/fnshzxAvul8y+jeph3YG4t83hI1fcdUi9dC
 QyZfmc3KHR3FFFJRwAAER6nmNRac2qC5AdHffBIy9ieuVibHiJVy6HrdA2MwEcy89a3l2uMhi
 ohAIOi3klJSm3+lm6I5f61ymGBDhTjcdYNPyN/5cNzSRNmVeGDeojxgssnOq6hQONX1ANkVJu
 r4axPg6PofmgjzvCu9iSzPxOhIhJdYiyU9Fnlu8+fsuBBwKwDI0nIi45m/kJT16dMnm8Dyk4C
 U9egBF+uj5GlIc4iNT3Sd/z9Y+fhozva3WqXejESqALwaNTvBShWf5/AmtEvscnEbZe+3DXmX
 5+uJI3gMB9LxIhfvXqYzn4tBWZNccbch3uXTayxiSzBaVMyYxX/sqW5myGBUaxykzppzyDBr0
 rtChrOuLhGsT17LA5bDCgz8pZD8xITzhYqkC3R7xdC38TKiRfN11Ikl+yJngG/UgqG8gEdXyp
 2h2pdihKGNhpA7jAwH1npoBvwO2Sf3JrF0vssHzEYznqJPlikeo8rdAGOjhzHMGVGOTV+4PH1
 tx8bjb5jdgjM5rU8eLLxdUk+H9FrCJpF3UiLAf8TY5E35q/whmA2N1zZFXdMiMRFovDbTPmSJ
 mEdygt5365vIz4Vvg+UzBG9mLZEQu31cOEFdJ8upCzKD+furbHSa4M5ZEDWzKrFvVSNVpN+Yg
 tr0DHXO8HfpdHKnSgG7g0TosjeHP1i2q0E+Tu+jD8tDEWt1mEhNnVPGCNgh1DBoJWW/mzVZnj
 n9LZtSNsQ=

> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
>
> device_register() includes device_add(). As comment of device_add()
=E2=80=A6

I doubt that the information from the second description paragraph is help=
ful
for this issue.


> Found by code review.

Would you become interested to check how many similar control flows
can still be detected by the means of automated advanced source code analy=
ses?

Regards,
Markus

