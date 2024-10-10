Return-Path: <linux-pci+bounces-14186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A259983EA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 12:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7436283B0B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755241BF818;
	Thu, 10 Oct 2024 10:38:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AC1BE85C;
	Thu, 10 Oct 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556700; cv=none; b=MvnIglUFYdQImQEUOW0uc+dYqV1zPK9qeaBFiNjBfvq2eUsMhzRTqCbySSuiaVAzWMDVu3UDlcBoqqNzgpjrl0nvUWM8fcVTORmcnZ8RJl+44zPYF8qgbSYGI3mlRfuSqFk9cE/v8KG4ATe+ddi8uzYPIJA7dMJYc8ykvf+NsgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556700; c=relaxed/simple;
	bh=Lw2O3ETbAIU9U+j++V3wo4W6gSAUAgo61UBoQRWxMu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dmbhv/GOYTjppzgZckAZdKiGQEQBpFCnl8TsmDw7BvlBt9gyQ0ix+yKRNks/QuO3kBuytAvZ6etQUC4cLX0/Zv7tQnaD9vTfOe0nox2hKGgXT0qfUxDZMN7PuaJfd8LPURle2rwnCBMQarmJSVYr384VLe+IBcHmoXaPqLWzeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6980228023E98;
	Thu, 10 Oct 2024 12:38:08 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 532204A310D; Thu, 10 Oct 2024 12:38:08 +0200 (CEST)
Date: Thu, 10 Oct 2024 12:38:08 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gregory Price <gourry@gourry.net>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
	bhelgaas@google.com, dave@stgolabs.net, dave.jiang@intel.com,
	vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] PCI/DOE: Poll DOE Busy bit for up to 1 second in
 pci_doe_send_req
Message-ID: <ZweukOWeqFy8vd4W@wunner.de>
References: <20241004162828.314-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004162828.314-1-gourry@gourry.net>

On Fri, Oct 04, 2024 at 12:28:28PM -0400, Gregory Price wrote:
> Polling on the PCI DOE Busy Bit for (at max) one PCI DOE timeout
> interval (1 second), resolves this issues cleanly.

Nit: s/issues/issue/

> Subsqeuent code in doe_statemachine_work and abort paths also wait

Nit: s/Subsqeuent/Subsequent/

> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -149,14 +149,26 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  	size_t length, remainder;
>  	u32 val;
>  	int i;
> +	unsigned long timeout_jiffies;

Nit: Reverse Christmas tree.

With that addressed,
Reviewed-by: Lukas Wunner <lukas@wunner.de>

