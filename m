Return-Path: <linux-pci+bounces-27683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BFBAB63C5
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 09:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D3317541E
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 07:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08F2040A7;
	Wed, 14 May 2025 07:07:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A11F4297;
	Wed, 14 May 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206434; cv=none; b=WlcoWegsABmugWO/FRBHEaIKbH7384jYBZh/2W9h6hIZyjlulTDZCrdZqSDLwWMZhhkJ2NG9v26ytmg/GVhDcYix4oKt050p5WJqveMJl7KoAnmh8I/Wf25QlfWu2UKFn7WvfHKS0W2S1vtraNXwxHqJ2O11UqwZHNWvBv14ceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206434; c=relaxed/simple;
	bh=j7NkM323q/W5/SDb3vvGCfNpZV3+sYh3aED17kPly/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBJu3xZbmu75SpIX6lTpF383ZEowP0glpUn/WeuMqdz5KVoEi7FS2VVG0YJ19bIYE9ZfJcI3/OTEJgHmVFYlnxI71vO7qPVzdc7KRFKCVOW1jNgBAUx6RQDyJ5wkbKvWGYXSCnn/JpKD3f/x7l0XDUvGoa6PJutYJQUPjwyodcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 833D120091A7;
	Wed, 14 May 2025 09:06:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BAD3420CDBD; Wed, 14 May 2025 09:07:01 +0200 (CEST)
Date: Wed, 14 May 2025 09:07:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Move reset and restore related code to
 reset-restore.c
Message-ID: <aCRBFWHKa02Hu-ec@wunner.de>
References: <20250512120900.1870-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512120900.1870-1-ilpo.jarvinen@linux.intel.com>

On Mon, May 12, 2025 at 03:08:57PM +0300, Ilpo Järvinen wrote:
> There are quite many reset and restore related functions in pci.c that
> barely depend on the other functions in pci.c. Create reset-restore.c
> for reset and restore related logic to keep those 1k lines in one place.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Hm, could I get a:

Suggested-by: Lukas Wunner <lukas@wunner.de>

... per:

https://lore.kernel.org/r/Z7hZZNT5NHYncZ3c@wunner.de/

>  drivers/pci/Makefile        |    4 +-
>  drivers/pci/pci.c           | 1015 +----------------------------------
>  drivers/pci/pci.h           |   10 +
>  drivers/pci/reset-restore.c | 1014 ++++++++++++++++++++++++++++++++++

I'd prefer reset.c for succinctness.

That said, this patch conflicts with Mani's slot reset patches
which a lot of people seem to be interested in:

https://lore.kernel.org/r/20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org/

Maybe it's better to give Mani's series the advantage and defer
this patch here to the next cycle.


> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -69,15 +69,7 @@ struct pci_pme_device {
>   */
>  #define PCI_RESET_WAIT 1000 /* msec */

I'd move PCI_RESET_WAIT, pci_dev_wait() and
pci_bridge_wait_for_secondary_bus() to reset.c as well.

Then pci_dev_d3_sleep() is the only function which is no longer static.

Thanks,

Lukas

