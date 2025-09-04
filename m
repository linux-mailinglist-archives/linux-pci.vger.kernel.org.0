Return-Path: <linux-pci+bounces-35481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68392B44881
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237743BA3C9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B01C2C0286;
	Thu,  4 Sep 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vqKCdK6O";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Agrt92AC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F52BEFF9;
	Thu,  4 Sep 2025 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757021364; cv=none; b=td3MOGb9ay8x4Nly4m/SO6EreApQ8UVbQhWvUTGv8HwiJkB+xKa06NnEe2KiSjTcaz5+4cm5XAmwhdHuZvOqVhY5+CvQu7m+ibUfJ7CNgZDJjlcPQ7sJKgboa3d4CqBiqY2ymWdcIwZxDo0VFy1zUcYycMAcNk2pN3FEm4Y/FEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757021364; c=relaxed/simple;
	bh=fScXVv76m2mKBKx4ebn1H7Q/CThhzFVySUmCsTiVyHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESE/j71ZCDDLSAOmbe3pPWS4yfqDDEMEPTCpdVpFPlDP1AZYJ3qXYgFEmk2JSoJCQE21BAus0IdQ5OGzMC/h3KqPHgnlu/g2dyzhmqm4L1xS5NFNIIjxL5F+fN12mTzi+nnks+NAsABrUJLUAXIdVX2/WxCUxti2Ci12a4jBG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vqKCdK6O; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Agrt92AC; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cHt0J2Yj9z9t6m;
	Thu,  4 Sep 2025 23:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757021360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qgCy5hEX6SEax4DnBF030MM5fVg7BhEB4QGlPjHTqY=;
	b=vqKCdK6Oij1e2VHcDOdExh+kVg98BbdqxdJ8pMB0klfCOCtzkzxXh9e/0P5YIF7YlX3JS0
	TgMlLg7GoQ9NfcDE6qUiLrJvp6Jul8+//luRVAIIABu8AwYtZKkqLJNXCLgm8wo2hGUZny
	fKARcKEVIweMhdt4hHn3mjpAzbZWbKsOzSAxPKiIxEr/4ECFg7MDJjutngrCanmY7imaQ1
	sNZulTQN5JT/d5z8MrgpzXX5vh21P2/OqopjrAyffU7Co0cdFiqU9tVICy4hYhnO2J5gm5
	5xGB5htYs8FhqkEEOsHKabAf1gAa+8LFGEd+P8unp1J0gZ9wRUf0Q22Y3HWj2w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Agrt92AC;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <62584e30-72ab-49df-bfaa-9730679b2dbe@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757021358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qgCy5hEX6SEax4DnBF030MM5fVg7BhEB4QGlPjHTqY=;
	b=Agrt92ACPZ25Mi0vxCNLxulxcG0BbutZvVHHhJhOt7XgPK1scax+L6Nmna4vl6h7JAh+x+
	PysFC4nowHUeTK0IUGtAmNrudExosikyQt+FqILNLvIFt6+o7VxpVkrrRqPGMTKkS2/hXM
	I8tmqF4ml8Ko0H7dmfstY7dEvX2fujyx+cfXoiy825H7diGBEQVcQmn2lcQyWIRbbnuvRH
	DzZDmZKPtY039Mj28OQnsmJKqwnhQUQsxfwb6H3DPsFZxroCMNwpOzG8Ik2kF2vviEspuv
	nAfK8prPAVBqSdMxxrEkC2grvRMJ7AFZouFAIn/DmzD68ZWuozB7gVrp31F5tg==
Date: Thu, 4 Sep 2025 23:29:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Wang Jiang <jiangwang@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>
References: <20250904023753.494147-1-marek.vasut+renesas@mailbox.org>
 <b3d5773d-c573-4491-b799-90405a8af6a9@kernel.org> <aLmGBYOVevP5hH0X@ryzen>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aLmGBYOVevP5hH0X@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 13dcbb0edfde5df60c7
X-MBO-RS-META: sewnssyio4q88ui38z5rntywakq5zocz
X-Rspamd-Queue-Id: 4cHt0J2Yj9z9t6m

On 9/4/25 2:28 PM, Niklas Cassel wrote:

Hello Niklas,

[...]

> pci_epf_alloc_space() works like this:
> If the user requests a BAR size that is smaller than the fixed-size BAR,
> it will allocate space matching the fixed-size.
> 
> As in most cases, having a BAR larger than needed by an EPF driver is
> still acceptable.
> 
> However, if the user requests a size larger than the fixed-size BAR,
> as in your case, we will return an error, as we cannot fulfill the
> user's request.
> 
> I don't see any alternative other than your/Damien's proposal above.
> 
> Unfortunately, all EPF drivers would probably need this same change.

It seems that pci-epf-ntb and pci-epf-vntb only use BAR0 (BAR_CONFIG) 
and BAR0+BAR1 (BAR_CONFIG and BAR_DB) , so those should be OK on this 
controller. NVMe EPF also seems to use only BAR0 and it specifically 
handles fixed size BAR. It seems everything that is in the tree so far 
managed to sidestep hitting fixed-size BAR4 problems on this hardware, 
except for the test driver.

