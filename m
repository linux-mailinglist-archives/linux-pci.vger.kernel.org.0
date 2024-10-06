Return-Path: <linux-pci+bounces-13886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DAE991CFB
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 09:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5988B21F0B
	for <lists+linux-pci@lfdr.de>; Sun,  6 Oct 2024 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84D914A4DF;
	Sun,  6 Oct 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hMCOXAZn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2122572;
	Sun,  6 Oct 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728200433; cv=none; b=kYMUGXad1/9vhH+xBfTexIipVakLx3jYyCisgjD2WIil/rkjNbLQQ1J/vwSWdgsXDNQfixDuEp2WxK6bnjKpXTCj4Tikgsg16ZlZJvKSJ89Zw+5BmpWF5ZiqA6/yf+FrhpEwq8kFqi88HqFkQvI1dkmCEqcklvZQhDcJSp5xZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728200433; c=relaxed/simple;
	bh=7ZExBx80upkW38+A/QbU+fsXFVRR42HeioQR1cxjbXo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hsO9YwHu2EaboRrK2X2atMUWhSNDS2KkIo/mtTlyaNWkNUc2sbiEhJ8gaS+NNWNI7TraKpdkBaWaKjNdq8JgOqudrOG0CX1KAkE78CmxnOiw58NYgU1cQ7/Kk+OJkoYX3qSHss0x+GQxHhD8Y1aqasV0sj4QdE4JTNAMliXJiyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hMCOXAZn; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728200367; x=1728805167; i=markus.elfring@web.de;
	bh=lW2NTtgSXR6HN9BJzUyHvkd+FTWE/RFYjn0L0MqlDJ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hMCOXAZn0Mc2FptfnJ69avOE9ggRZroODv7EErk5yqVZf8QJmhNkqQbcOtM1OOnZ
	 iFVkX33DlOUH6PfBwVFi9ynZSE1DkRmfZ6pTmC/RtXCvEwYSokAK1c86a0g4QN+eN
	 JGk5TTfIxVj4hT1//4v24B8LyGmD2p5u0csDpYloBUNMa9b4Pbb6NFH/E3ecnta2e
	 ZiESI4sTBcPKph0mk1T92Ia62jAf8MgEaUZWyfTSqXtuCoa1cyAjMX+8wK8HqkHft
	 8iVEHGmxUbICPbrWvrmqSwM7E1EeTR1cRC832ty8scRTUWHBUqjBDtmtlejbD8FkE
	 eSMOrHs+v5W6fu/v2A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4bUq-1sxtYf2PVm-002EF8; Sun, 06
 Oct 2024 09:39:27 +0200
Message-ID: <821a7417-4f2a-42ed-9616-88a0c145fa5d@web.de>
Date: Sun, 6 Oct 2024 09:39:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Ni <nichen@iscas.ac.cn>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Niklas Cassel <cassel@kernel.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20240918074401.2221146-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] PCI: dw-rockchip: Remove redundant dev_err()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240918074401.2221146-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Dn8EbyryMmfD0vIqg7CFb0Wxfi+mHdb2k6EuNRXBVwNOdnB349N
 2g/hgfR+OFAa1LzJFlZjyjT7KhWdQoRnpzGBbOZtxvolIOfALpnj6cKp/GAv0xf0bFPoSdv
 98N5JmSV8KLVv2+FM2buSbvYzBMV3LQw1B8KsqvAZwtSKrDnNUnSeSXL1YzRHci4R8mDcB/
 poHEUR0cQNJucwNhVmdPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MqY4sJMuk/s=;+zeb/3QHhcrQ5aN2iJwONFikDQW
 0f/GQBICASExoEQer8hJzfZMEEckAM7eMl/7WzQDnWC2qF2/eb+8GqsnT6Js3FCbcfShzmRJy
 R/P1hMVDHmh9DbOxgpgpOwVGZQRfiK6+H+xNl+N1ZPoL8VyqGIgNFJYHyYSIq6PchiEOQW4tZ
 f/e26lgMHJoY5NexKVW/FNrGDmp1o3CHbHO9vu4vwOQdLBKUfEbEMg3SIThEuh96zU5/ok/mV
 YIsUzF3xSJsA1d3NksiY3E9PwTUz3dsro1kZxrPIes0bk0VofrA7tGfYRmAqVTanjlLHjFmzG
 VSzXPZPG+Lx3nVQgO+yW3hQVkjbcfZUAV8nOxq13PfDB1spp5eJZbDYkZJcMuciosC5pB26XH
 yDUM494ihHpMWhibJwv6yJyLuBkwObsoKNWpL4+uKQt0wGllHPgeKSXRSiWmUG46NyGZ4mTNn
 VptyrZiKEhGE9uH8fkprEh6Nz0EV/OwgmMuqm6j3KRAB5m1zqVYeqICUuKTDKIsoo4DDaEOQl
 dOnhILsv4Dm3p25QGVHxE0z9FFYZy+wifAwIat6I+FFctn3YKVnbc9nt0n7tH7U5qb9GimQi+
 CwyR20NrQWEPT/NAljaJBJUPbJpZjOUPDSdZ41rnKktQiEUvEE5YedbHy9S20+0zanQiCxvcV
 9IvRIhj3lF2TCXJSLFQpgikIYYiBnYwKcsjj6GQkXGek8VADF3j/GWQRHZ9ZwQm0dbUUe4lj4
 flcoMggTdGM7WBaJFgdkt6nanBMi9BhC9KJTn0xFM+IdBGuv7Cm+V1R8EsI0h9V0/6TinsGaE
 BKlDFigzOdRtFnXIw+0i7v8A==

> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from platform_get_irq_byname()
> function as it is going to display an appropriate error message in case

           call?


> of a failure.


Were any static source code analysis tools involved in the detection
of the presented change possibility?


By the way:
Such a patch can be generated also by the means of the semantic patch
language (Coccinelle software) for example.

Regards,
Markus

