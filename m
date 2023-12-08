Return-Path: <linux-pci+bounces-697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0080AAD3
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 18:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44A11F21216
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C4C39AF7;
	Fri,  8 Dec 2023 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="GzVmg7Yf"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A33AD
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 09:30:58 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id DB02328C059; Fri,  8 Dec 2023 18:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702056656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okpHR3kEU9KFvkt4nvLsZJjTscSjLMsE+fX4VTRvtZU=;
	b=GzVmg7YfG7fE+lQTZYoLVYnqqd+ASCkyR1GSfezpgBwHTfmB72UUQofgAZRDvSR4mS+Xf+
	c3EugCp7CRnqXsFx2WOkV91FVPZtuO5seomrTqnRIGvqFXWjwrdGsroEmDp+eQufyrXrbY
	v1I5e98YPVHyrXW9TnE1kUQLubAuq5U=
Date: Fri, 8 Dec 2023 18:30:56 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH 00/15] pciutils: Add utility for Lane Margining
Message-ID: <mj+md-20231208.173005.29014.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208091734.12225-1-n.proshkin@yadro.com>

Hello!

> PCIe Gen 4 spec introduced new extended capability mandatory for all
> ports - Lane Margining at the Receiver. This new feature allows to get an
> approximation of the Link eye margin diagram by four points. This
> information shows how resistant the Link is to external influences and can
> be useful for link debugging and presets tuning.
> Previously, this information was only available using a hardware debugger.
> 
> Patch series consists of two parts:
> 
> * Patch for lspci to add Margining registers reading. There is not much
>   information available without issuing any margining commands, but this
>   info is useful anyway;
> * New pcilmr utility.
> 
> Margining capability assumes the exchange of commands with the device, so
> its support was implemented as a separate utility pcilmr.
> The pcilmr allows you to test Links and supports all the features provided
> by the Margining capability. The utility is written using a pcilib, it is
> divided into a library part and a main function with arguments parsing in
> the pciutils root dir.
> Man page is provided as well.
> 
> Utility compilation and man page preparation are integrated into the
> pciutils Makefile, so run make is enough to start testing the utility
> (Gen 4/5 device is required though).
> Utility was written with Linux in mind and was tested only on this OS.

Thanks for your contribution. The utility will need some cleanups,
but overall I will be glad to accept it.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

