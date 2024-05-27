Return-Path: <linux-pci+bounces-7881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 307058D086F
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A5F1F23312
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83817E8E6;
	Mon, 27 May 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="RUJNBcj8"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1317E901
	for <linux-pci@vger.kernel.org>; Mon, 27 May 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826983; cv=none; b=OKjeeAqsye0uhL/BRS1ymooiI7yWhEiKQJqWZJuS2HuKw5fLloZWjZ2P+VvLkpBjwglDSjfdosvbAUzcsqu2iU3wnoOVqP5FMspIsHt2X8XXxiQ3NYG6QJ+chvs1Y0CLSmnD/WpNtmPyLuU5S6Na7MrHKDAIhp9NlNb7/abOXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826983; c=relaxed/simple;
	bh=9vVGeDun9UwLSECd0uw4BUkwGcTRMCNqdrDsHGkEMG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9l0XSma9lhwAYu1a569LX02XxPzplU5i1RC+7NhPHocMwTjpJzX02f2g8eNtyE9xAnmK+1Rcov6PNR+ZvsyY5rlEGDRO0Xy92UiAz+I2ecd0kT8QHeq/dl0gvm8eZ6GNfvcJcwwqbIBBMoTQas3qKvYBruPZ9pDk8fvXvMqbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=RUJNBcj8; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 52C8E2873CF; Mon, 27 May 2024 18:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1716826977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ou1zvoIwOOZRJhdFWE0S0JdVFjcE63Tk1RiQiTxZzs=;
	b=RUJNBcj8QgbHWIB5nGKieOQP71wf6AQFocIzu07OYzKKW7M/7CpsvmJ4/IOQ+pD0RDI43D
	4SgTEGm956DETmohbYZ1hj30yy/AdB0VD+OIp2qKLbAyq1rn3WO0/KYYHI4UzhicOFevqg
	O3NHRLtUGKHKF8s0Yy0XshBvjwbOaQo=
Date: Mon, 27 May 2024 18:22:57 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH pciutils v2 rediff] pcilmr: Fix margining for ports with
 Lane reversal
Message-ID: <mj+md-20240527.162248.20107.nikam@ucw.cz>
References: <20240527152255.35571-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527152255.35571-1-n.proshkin@yadro.com>

Hi!

> Current implementation interacts only with first Negotiated Link Width
> lanes even when Maximum Link Width for the port is bigger than that and
> Lane reversal is used. Utility in such situation may try to margin lane
> which is not used right now and erroneously fail with
> 'Error during caps reading' message. Fix that behaviour.
> 
> Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>

Thanks, applied.

				Martin

