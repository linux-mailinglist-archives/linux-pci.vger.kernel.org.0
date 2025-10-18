Return-Path: <linux-pci+bounces-38566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4993BEC9DD
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2ED3F34EDC2
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 08:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61172882C9;
	Sat, 18 Oct 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uXY6Imyg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FB27A900;
	Sat, 18 Oct 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760775880; cv=none; b=rnd7RyzXAGM9XiSDHBGz6iDEeKwCT53EhKvS4BEybe9LuJPJCjrImJrXzzxss4jDyzwL4OOruiJM9w3v7oGeDa66+KvuLWLf7SozGS/ONIXaMZS2CVoWSnsBvncaCVhX/5O1EZAduBdfzRzUzrnYPSQ67lfXN3tajjfuO9rb5Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760775880; c=relaxed/simple;
	bh=92ymbbMbWyUmWkf6KKDAInPLxG2URoDTrvYKf2kuR1Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=csqAPQAPtMyrzteNTD3PaEBbRIrX1QgVhlq0OowMMZQUBnYJNBuK1cDjdE4sRqCyFVjz1u6SHVh+6PW2ko7IZXcVm+Mc1et2VOSWjzKQrWUZp/6j7KfXQ9vGrh+8Tfxfq7gGkiH3IBg+X3na7+zwrtZkuCf4XgXqfIYWGQhY+nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uXY6Imyg; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760775870; x=1761380670; i=markus.elfring@web.de;
	bh=NTSJcIip4slSfQKeTkp3Dp4azbYaqSdBSI5VLt+OaF4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uXY6Imyg1cE+lL7vjv9rYl7++pDS+Yi/qUzSPvlfyM/glNKn2Yd6T21DQ0l6uVFm
	 gTYYV4NEK9qLO/9y7Tygalqt8kmPSnh/pcrntdfzmo+TtQxsPhwrt9lOe6PhfdxwH
	 zN47Ke7zDGs9+S1QV9YRFLHNS6iwEFxEoKV9h1o6GF9UcTOPMqtq/EmJVn5I/Rr4L
	 OZ0eOBix3T/je851Zr1A7dgbd2Z7+eZBLJQbB/pk1tiirJgwdjjo6m9tdf8P3zhHE
	 3pV32bw3V3DbLL8upkX76rDhnpjz5SEq8p6v8/EV58nlxQvvurK746NKuL95gXFED
	 W3vOkoAsbazIHUWDjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MECCd-1v25k31HzZ-003bkH; Sat, 18
 Oct 2025 10:24:30 +0200
Message-ID: <b362115c-6853-4047-b4c2-aad97ccf8c31@web.de>
Date: Sat, 18 Oct 2025 10:24:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Xie <kevin.xie@starfivetech.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20251017161425.7390-1-linux.amoon@gmail.com>
Subject: Re: [PATCH] PCI: starfive: Propagate dev_err_probe return value
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251017161425.7390-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PJB6On6iKIRiQjjXlcPIyeu/1qYjZuVrA8BESWLqdFhx5LfSCkh
 Ff2NWAl4gyIYPtiKfbNgeRdYQ8uV+9+5c9sdJGBVKunErYbxpo4xIS2nWjqzq01j1dWYaFl
 wpPNuOSczF+2xtLIWL3Yv0a2MmNDIiadrTHj7ZGqqVYvrczfKk4PYb9jpS8TxCJmUpudbQF
 cdSV42tEkFbm/PMvaXvRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RwdT+YtRpEQ=;mYAd1D6/V5wf5nzlN9yX4kHH9h5
 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
 psCC/p2l/hgxRhABhq5dDqHMg67R7Lad6PM=

> Ensure that the return value from dev_err_probe() is consistently assigned
> back to return in all error paths within starfive_pcie_clk_rst_init() and
> starfive_pcie_enable_phy() function. This ensures the original error code
> are propagation for debugging.

I find the change description improvable.


I propose to take another source code transformation approach better into account.
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5031-L5075

Example:
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/pci/controller/plda/pcie-starfive.c#L171-L187

	ret = dev_err_probe(dev, reset_control_deassert(pcie->resets),
			    "failed to deassert resets\n");
	if (ret)
		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);


How do you think about to achieve such a source code variant also with the help of
the semantic patch language (Coccinelle software)?

Regards,
Markus

