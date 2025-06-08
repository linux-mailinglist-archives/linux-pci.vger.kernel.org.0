Return-Path: <linux-pci+bounces-29170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A3AD1278
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 15:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DA2169674
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C520FA98;
	Sun,  8 Jun 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LoZYQdkC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KrMKRpNQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708C28F5;
	Sun,  8 Jun 2025 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749390240; cv=none; b=KiRysHEf8rL4D13Mm2xakE3fL5Y/XTEMTsCQfZO1IfaB7yOhH44DX7nsgpgcb5UP059fgsND1GucQTuEUduQbwTC+m3wGFCHbhBOJvvJVZD89l1wleMyWDKA3QtlysPl2ZJ2PnOZdZqqc6D8zZptOxTDqlLj8JH0+RdVZO56S94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749390240; c=relaxed/simple;
	bh=oDuz/z5LlZRZpaTjhzgz+X1f65Mj/eD3ZtAEzlBUKg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjF0SdOYBiavoOS2owJBtD0PAj4pG+q1EZkKLp6cMzMiQAgIc6iPM/sGsHwb2Q12a+0PCn+a1YEtcMlSAf65Pb3eBGfYYyOgzH2pbeNAYASSVug0Jh1cfrqpCZu3oar7JHziVVI7c9fYB0IJ/c2aDsk5WdDE18sD7Obwieiy+zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LoZYQdkC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KrMKRpNQ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bFbqw2Sq6z9sSQ;
	Sun,  8 Jun 2025 15:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749390236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMN6Z9J6jhZFiusb8bVANtIUUu6PEMf6Cx193x6RDXY=;
	b=LoZYQdkCjuzH1R8XYJZpDsAL7cv4rdZ+6gpOmEfxC0uWC1vy/qSQ5jNKQbrobFGIM2n6He
	IHZ9hLEjZve3Jn2/lmEY12WCe8yX2zNMN4Hm/Ekw3N0eGgpfmuIAb21oUZifjEPgDLDg5y
	paEconR+nPv7B5ZRP6KwCa1yzq2mSkiwA6xbZN0bs7GQWnzxzKA36fV2ld2T9P7qEQr2cT
	/geTTiUiayiIu0GPjTvcyyW/+xjr3QzmsTFEEsBtvNxzAEhCiyZLNGuHHLS32k11Q3Q/xF
	4GHhCcad8o35MpNMZZzc2m3tOqPrwxAnQ5G6IG9sErfNgYflgqdUNIuUflIIng==
Message-ID: <bf1be30c-da2f-4e1e-be39-e96ffc3d2079@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1749390234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMN6Z9J6jhZFiusb8bVANtIUUu6PEMf6Cx193x6RDXY=;
	b=KrMKRpNQB5viW0yOOHU9Qzn4BPWNu9Ig2yyYoJhi9jb2ixG1CxMyDiOZEbepGRfmP7Hfj0
	p4NktB+BfKjUxvoZcoP5Tg6iaUerlof4aJV8c38z281J0QOi5myYlViSpEpzPvwqAnrxn7
	n7xt+98yStKjMuOI3QEK5ZnomNWhuJ1tLaa0pB4/0UKVAPbZM1RTbaGCkYNpdQyWJT+lE/
	fkbZwnl2HpD9afOsww6ErmZyoi4L2ZDsHw5I/W26hdZP3sHMjG1f2ibXsZlOU9pw4rcBUH
	iR+8f5wbQ90Rj3qROAhXXMoswMBbC4QM0NU1NM9+ziHJfnk+ewc/3qgcdrsEFw==
Date: Sun, 8 Jun 2025 15:43:51 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI/pwrctrl: Fix double cleanup on
 devm_add_action_or_reset() failure
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f60c445e965ba309f08c33de78bd62f358e68cd0.1749025687.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f60c445e965ba309f08c33de78bd62f358e68cd0.1749025687.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a975acc8e4c3cc6345f
X-MBO-RS-META: nff8ta19ws7gi9e1wef11u38kgjhgfg3
X-Rspamd-Queue-Id: 4bFbqw2Sq6z9sSQ

On 6/4/25 10:38 AM, Geert Uytterhoeven wrote:
> When devm_add_action_or_reset() fails, it calls the passed cleanup
> function.  Hence the caller must not repeat that cleanup.
> 
> Replace the "goto err_regulator_free" by the actual freeing, as there
> will never be a need again for a second user of this label.
> 
> Fixes: 75996c92f4de309f ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # V4H Sparrow Hawk

Thanks !

