Return-Path: <linux-pci+bounces-6568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD78AE5F8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 14:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10891F21AC7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0233983CD6;
	Tue, 23 Apr 2024 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="Io4gy5f5"
X-Original-To: linux-pci@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0A7D3E3
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875165; cv=none; b=C8qldc6u/OfLNlKWwCrNfVPmocAQDBCNlxcZgnktqPBZoer/MVnQh9/wbnf6aG3S5bLHPI3iqjTOthuH21jgbWs4pXaUVR+e4Xr66WhJcUao+dMIcgzPhLcA6VwzyNaXE5ShZzQvc50X/zAl0Q16DuHVXCOHnev/4PQ0h89tbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875165; c=relaxed/simple;
	bh=bnfEfpZqPvL2/TnpwFImtycTEzh6haxKSGL0xicGb4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAVpP6RSsap7a+9ME9EZqpQDmOAaJFf0Xa7YFOMi2Mb2trL6Hzg265hwUiO6Y9N8UPpfsGXYDSOgq1XpbuYu/NE4PPSBs2ckVcGl+mmG/OoDyDPDywbfnlZZkA86y/HBfVdU8IciBLc2QcCI3lfv4rcK46uJJYUSKfkjl0YxbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=Io4gy5f5; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: from albireo.ucw.cz (albireo.ucw.cz [91.219.245.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: smtp-albireo)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 8805D1C0080
	for <linux-pci@vger.kernel.org>; Tue, 23 Apr 2024 14:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1713875160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UzZGrs7Gl6jkkCB+C7T/pARPle+7G99i5Pew37R9UM=;
	b=Io4gy5f5DxwzTmsSNIjb0yjpA6Vhw5N5FpDYpUiaIDKr+jXGZs+8PROjCyPwRfY8GbtRxR
	sEBnhDfvklSQcNkIPiQewXtQNHZONbgqI/6vdyrxF1OmUM3KkOteKwiHJh3yFXw/YUIQrs
	lJJVoHJadlayU2ulu0I1Sk65p9RkTkQ=
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id 1C3F7AC2835; Tue, 23 Apr 2024 14:26:00 +0200 (CEST)
Date: Tue, 23 Apr 2024 14:26:00 +0200
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils v2] ls-ecaps: Correct the link state reporting
Message-ID: <mj+md-20240423.122538.98992.albireo@ucw.cz>
References: <20240422111447.143973-1-aik@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422111447.143973-1-aik@amd.com>

Hi!

> PCIe r6.0, sec 7.9.26.4.2 "Link IDE Stream Status Register defines"
> the link state as:
> 
> 0000b Insecure
> 0010b Secure
> 
> The same definition applies to selective streams as well.
> The existing code wrongly assumes "secure" is 0001b, fix that for both
> link and selective streams.
> 
> While at this, add missing "Selective IDE for Configuration Requests Enable".
> 
> Fixes: 42fc4263ec0e ("ls-ecaps: Add decode support for IDE Extended Capability")
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
> Changes:
> v2:
> * fixed memory and RID base/limit values parsing
> * added missing "IDE for Configuration Requests Enable"
> * fixed the example

Fine, but please update the commit message to include the fix of base/limit.

					Martin

