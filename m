Return-Path: <linux-pci+bounces-35395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7E7B427A4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 19:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2ACD4E3869
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54C31AF2E;
	Wed,  3 Sep 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vIhii5/4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726942D4B52;
	Wed,  3 Sep 2025 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919454; cv=none; b=cs4lLEDglDXdqFsPYRXqtAcUZJrU6IzCzHBGtEaaH95llA1cNoVHbbIM9hgb1BpApeJu4P12LWqVqk8k0OUAJBzhpnJQ3pjZMw3/6yPXXofTkLmCJV2Yid0BjOrnP3f9Dk4Y6WjHeYLWjylAkePfazCSah3wxLf3r6Fkzo6Ju3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919454; c=relaxed/simple;
	bh=fLuqSAPV5wSjtTIGF/DwaJYWgJhPU9kjtRiI0sYj4qA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WzkmSObmQ+9Rq0UyPHyZKzhwrdsvbGjDIVjdr+sQroslLyELtrKFUeOTAfN3bs/ey6UAiGO0XVvhXjFowVAzcNae2a39hhl62DOoFqhJevq0cqas8ozKLN1+feonx0JVGD38ACC0C2yTqZQYJmIWBly521mX4Dup/oARjk6JNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vIhii5/4; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756919445; x=1757524245; i=markus.elfring@web.de;
	bh=fLuqSAPV5wSjtTIGF/DwaJYWgJhPU9kjtRiI0sYj4qA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vIhii5/48wKnO7kk+EdTsvr0h7gM6WBi0u8ZNthQ2V7hJpe8Xb/UGc9wONZ+Znaf
	 7Pkgd2pj8wBjABmxZLyBdB7XyTILnLnulobFG2Xgr+GdVa344ok4HMZnZaNk7HDAJ
	 u6rVoDFi65C+LC/f+YANqbsLjBM8dLxsKfWje1t9yO4Q90h1bzSvOMKYLwhTjUQGZ
	 t3Hjey+a06NDLymStucaTUUyQ8lrLDJ3tLu4Tvu/fISr2YcK5HgvnWDVZEj24fEv8
	 viPZRnoe4GUEyxrxLCPlCrJfpGgil7jjRivjQOe/+HJ3whQ7LMEbSZpBa2ZOJSwZl
	 ygWfdbUWI4qegE4fXA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.225]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1uQRcm0FqX-00xN5X; Wed, 03
 Sep 2025 19:10:45 +0200
Message-ID: <14f774db-2f44-49f3-bb02-7d4033675b04@web.de>
Date: Wed, 3 Sep 2025 19:10:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>, imx@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Richard Zhu <hongxing.zhu@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Trent Piepho <tpiepho@impinj.com>
References: <20250903135150.2527259-1-linmq006@gmail.com>
Subject: Re: [PATCH] PCI: imx: fix device node reference leak in
 imx_pcie_probe
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250903135150.2527259-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jogpiOwnRJCCSx9ze+nNG+5f9IS3la51icG7IOx8k1elYl1/Q36
 tbh4XXjVbwMkhTlGHlLodny7Rp+bpEL4ehP1xCR6Qz3G2bXKMzoxbm3sEgJUksnJJ1C7KHl
 Heov7yDl/uuoGD67Os9DqAEg64REeokQUq4/P89E50lXArsJ+i7Af+KyNPd7Mhz0NqBvVGs
 m9jfntakm461kj4FnSGgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JwLOkV3kG50=;lxX1e4gktR2E3a+91vB57R/y3O4
 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

> Add missing of_node_put() after of_parse_phandle() call to properly
> release the device node reference.

How do you think about to increase the application of scope-based resource management?
https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/of.h#L138


> Found via static analysis.

Which concrete software tools would be involved for this purpose?


How do you think about to append parentheses to the function name
in the summary phrase?

Regards,
Markus

