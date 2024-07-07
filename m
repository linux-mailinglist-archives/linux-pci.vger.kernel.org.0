Return-Path: <linux-pci+bounces-9898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E0C929961
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 20:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D1E1F20FD7
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jul 2024 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E957888;
	Sun,  7 Jul 2024 18:56:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECCB1E529;
	Sun,  7 Jul 2024 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720378611; cv=none; b=mM+7KdZmAFCKdayEUyS0kp4wfXPPkGTwKCzP9N3Zr2aVtobTcXEcVHTTDZc37XgY6tFmdnbMc6kkhbuxC86oLENwISaEoBI3sVjXl9I13svUlSbfntQDv97Ine2lCrGo5qvdTcjL65MnSiFwLUFMxRYG5SfDmfFovsXES8dDGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720378611; c=relaxed/simple;
	bh=WwA+gBa6WmaJrf+U9hWzrMFbTeN1iGQqbO34ilR7CWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0CEu/rc3gy0lZCC54dbTA4KJcBpHtPjAiRs5a61qg4V4h9xqGJc8q8hFZsXdoglWQCv2pmjBngxSz+/PrngEUhtbWDARx9C9Id/6lscy7DQseTQ+I+eCmNz+eKKmH1h/PKXKQQ8RIjEzy4saeNZDLyvAZ1rrnJn0rMEkYBxPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1F1F3300097A2;
	Sun,  7 Jul 2024 20:47:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0A37AD3DEB; Sun,  7 Jul 2024 20:47:43 +0200 (CEST)
Date: Sun, 7 Jul 2024 20:47:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
Message-ID: <Zoriz1XDMiGX_Gr5@wunner.de>
References: <20240707183829.41519-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707183829.41519-1-spasswolf@web.de>

On Sun, Jul 07, 2024 at 08:38:28PM +0200, Bert Karwatzki wrote:
> If of_platform_populate() is called when CONFIG_OF is not defined this
> leads to spurious error messages of the following type:
>  pci 0000:00:01.1: failed to populate child OF nodes (-19)
>  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> 
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Reported-by: Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Closes: https://lore.kernel.org/all/20240702173255.39932-1-superm1@kernel.org/
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>

