Return-Path: <linux-pci+bounces-43967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DD7CF0D1E
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 12:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE6F6300A879
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABBD259C84;
	Sun,  4 Jan 2026 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="qSTlFfgE"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20B1EC01B;
	Sun,  4 Jan 2026 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.56.97.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524612; cv=none; b=lMBmtg9BHTvi+GN9ZNiAOXG3dJIF5V8G3iJMWraZLnTMudCzm1VSuOxloaLV0rxCm/Y4tLdPb3LZKAJeP8vnMtQODcEWYUSpKd7nUgv08IO37MbPaeXJR2ep0urf6vrt/L3k2JwbJvDYf78cwtJTZzvvegF2uA/4uDQAJboX9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524612; c=relaxed/simple;
	bh=JuI5z2DNpzyVus0RGN6NPdalqJIuSjCbuR30Oboo6B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGy3mVRyQmPnvRid2x5Y+DSPZcu1lm4yDPw9p7vbXgFnZy1J76fhs0m1JpU49xJh3MCMqOR5ImiXt1ahQNvBaKOHV3g3QqtUK47Y/IHPoFQEaA7zivnYLm+ldt76W2AgynJ6GNQfeQZN0hiYl+QOEST73gkZZecujIKL46smzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=qSTlFfgE; arc=none smtp.client-ip=149.56.97.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id C03343E8F3;
	Sun,  4 Jan 2026 11:03:23 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 199C140081;
	Sun,  4 Jan 2026 11:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1767524602; bh=JuI5z2DNpzyVus0RGN6NPdalqJIuSjCbuR30Oboo6B8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qSTlFfgEViCLoEn2fLV4q7LVuFjflNyyJa/FYb5oNt+jolwGPmPZuFPAUydbv4hgN
	 Ux4OEiIcrFgvOIdpF+3rJDGmGO7W5MRM58Gi/fSBVzhtr/xmUm9jd0BNNkDMVsN4G6
	 OUfZzCVo8/OXLnQczX3DrE7dtOnfa5pAncH+mYj0=
Received: from [198.18.0.1] (unknown [203.175.14.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 982A242B18;
	Sun,  4 Jan 2026 11:03:17 +0000 (UTC)
Message-ID: <9ddf7822-eda7-4c6c-9240-31ab1c4708c3@aosc.io>
Date: Sun, 4 Jan 2026 19:03:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: loongson: Override PCIe bridge supported speeds
 for older Loongson 3C6000 series steppings
To: liziyao@uniontech.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: niecheng1@uniontech.com, zhanjun@uniontech.com, guanwentao@uniontech.com,
 Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lain Fearyncess Yang <fsf@live.com>,
 Ayden Meng <aydenmeng@yeah.net>, Xi Ruoyao <xry111@xry111.site>,
 loongarch@lists.linux.dev
References: <20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 199C140081
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[liziyao.uniontech.com:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[uniontech.com,aosc.io,vger.kernel.org,live.com,yeah.net,xry111.site,lists.linux.dev];
	FREEMAIL_ENVRCPT(0.00)[live.com,yeah.net];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Ziyao Li,

在 2026/1/4 18:00, Ziyao Li via B4 Relay 写道:
> From: Ziyao Li <liziyao@uniontech.com>
> 
> Older steppings of the Loongson 3C6000 series incorrectly report the
> supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
> only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
> up to 16 GT/s.
> 
> As a result, certain PCIe devices would be incorrectly probed as a Gen1-
> only, even if higher link speeds are supported, harming performance and
> prevents dynamic link speed functionality from being enabled in drivers
> such as amdgpu.
> 
> Manually override the `supported_speeds` field for affected PCIe bridges
> with those found on the upstream bus to correctly reflect the supported
> link speeds.
> 
> This patch was originally found from AOSC OS[1].

Thanks for the patch. Looping loongarch.

Best Regards,
Mingcong Bai

