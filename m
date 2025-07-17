Return-Path: <linux-pci+bounces-32467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9301BB097DA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 01:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D34CA617D7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 23:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860E2522A7;
	Thu, 17 Jul 2025 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8YGUGNi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA2B25229D;
	Thu, 17 Jul 2025 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794866; cv=none; b=ox1uE+BASqwFrXglqAu8ppAbC7sgIBAP83jneDFI///KItTs5MZjutnxrFD/F/5hUJIp1x9NVrjtV0iXESGf9qbnvgMuMOywVhBLRpchizAlN2WNXiu2jEAsUs7ZIOGidSZd+MbHNy1XcwKv72YEKZ/rT5FrVdk++sDadH90VrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794866; c=relaxed/simple;
	bh=p0MagdDdWIYiV7kWUeC2SQBLjV/Zj1bBydkf6E4DF48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h3baBivQsr9jwZbk2ZdQeUwZsfnaP8VDnbwL9YuULbQnMh8pMpT0DlirqFcnVCJeQZSHII8ObrPFwNXjlvZ/yxkQ0AM8DiBcSm8NmKlrmynNls3bN4Jzfmz3VJ6GQ7c8X0DfwHrnjODb7iFWbIzGcI1JGsnpfdtklAuKPDIKJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8YGUGNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E97C4CEE3;
	Thu, 17 Jul 2025 23:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794866;
	bh=p0MagdDdWIYiV7kWUeC2SQBLjV/Zj1bBydkf6E4DF48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a8YGUGNiC15dATsGZXMiATuiAhkjO0M3CLSjwT8Rp/2WernKImAKFMQMYzp0OvLf3
	 4kpfh8Umx4A6GNKQUrp+McM4MBz2/KqbUIPkiYDHHBFY3p7y/ab73Rr4sDqffWKOEu
	 Yo06aJEGc574l31kabrqte/6LZiW/u9Sa+ZUoQFh0cPiJOW5piWGJw3/su3xH7d5c5
	 DA4T/kX9OZht1pMiANvQlIbDjE7FNZqeJX3qjrDY6XRJShCh/rlrKO3HyCOW4denS/
	 1a2a9wIgWhJf7b9Ftun+015iWSiluo831KNm7SfotdOSjeW4YyeDe9K/FM5ElJApk7
	 zo34Hk2Oq9wnw==
Date: Thu, 17 Jul 2025 18:27:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH v3 5/6] PCI: pnv_php: Fix surprise plug detection and
 recovery
Message-ID: <20250717232745.GA2662794@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171044224.1359864.1752615546988.JavaMail.zimbra@raptorengineeringinc.com>

On Tue, Jul 15, 2025 at 04:39:06PM -0500, Timothy Pearson wrote:
> The existing PowerNV hotplug code did not handle surprise plug events
> correctly, leading to a complete failure of the hotplug system after
> device removal and a required reboot to detect new devices.

> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -4,12 +4,14 @@
>   *
>   * Copyright Gavin Shan, IBM Corporation 2016.
>   * Copyright (C) 2025 Raptor Engineering, LLC
> + * Copyright (C) 2025 Raptor Computing Systems, LLC

Just to double-check that you want both copyright lines here?

