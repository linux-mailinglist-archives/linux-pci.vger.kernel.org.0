Return-Path: <linux-pci+bounces-27759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D48AB760C
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 21:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2620189819B
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFCD38DD8;
	Wed, 14 May 2025 19:42:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4BA2920B5;
	Wed, 14 May 2025 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251746; cv=none; b=j+4hMQg0JQhLbyV2V8Vaju854ORGzxAioBXFlYQ9c+YoIGFj+vqh+xq1M6xYZQhm3TUfBn0eISvipX1cSaGV0TagVAKjG18hV3ax3PfxjNF1VbLlM3fT3lUY3DD1BOhNBrZwBPQyhOf1ulB2+NnXy+7MmUu+cGX1n6rG6AY4w1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251746; c=relaxed/simple;
	bh=Vj4fabamFDyKiwQgDUjjkQXPLrCwbSVOfhoUjOl/bfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK5QI6H53nzC399TA2H8mu7wuGvBeYnUFViP3dvIuCsld2xdYrlT/h5D5OZDZQdzIs0yK1Z/ae7E2I7gi3JbHt7dglmQ36VFLwMumIB6ac+b2jIDdwpHIQLVozdUAm7jYXkyLk7LAxjRUkG+0Y5xtuLb0esaFeaiK+4eRmZw1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A5D802C06844;
	Wed, 14 May 2025 21:41:42 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C067120CDF7; Wed, 14 May 2025 21:42:14 +0200 (CEST)
Date: Wed, 14 May 2025 21:42:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krzysztof Wilczy??ski <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Message-ID: <aCTyFtJJcgorjzDv@wunner.de>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
 <174724335628.23991.985637450230528945.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174724335628.23991.985637450230528945.b4-ty@kernel.org>

On Wed, May 14, 2025 at 05:28:33PM +0000, Krzysztof Wilczy??ski wrote:
> > The commit 0238f352a63a ("PCI/bwctrl: Replace lbms_count with
> > PCI_LINK_LBMS_SEEN flag") remove all code related to
> > pcie_bwctrl_lbms_rwsem but forgot to remove the rwsem itself.
> > Remove it and the associated info from the comment now.
> > 
> > 
> 
> Applied to bwctrl, thank you!
> 
> [1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
>       https://git.kernel.org/pci/pci/c/256ab8a30905

This is now an individual commit on the bwctrl branch, but Ilpo
requested to squash it with the other commit already on that branch...

   "Bjorn, this should be folded into the original commit I think."

...because that other commit breaks the build:

https://lore.kernel.org/r/3840f086-91cf-4fec-8004-b272a21d86cf@paulmck-laptop/

Thanks,

Lukas

