Return-Path: <linux-pci+bounces-27785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B5AB85FC
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1CBA00C37
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1CF29995B;
	Thu, 15 May 2025 12:09:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F82989B8;
	Thu, 15 May 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310972; cv=none; b=LsWrJ4VNjn+8IKCkAO5Dm49cNGn1fApL9nzmqo1RJT8//l1xhBufdvwzXSlZsCakzimSlOooTCsFFTZejSBX7sdGFbHOBqhKV7+unHt8+OBeB9DTB9TiaSzUStqhYy9pJX/S2JNQL9X+MnzpIUOA8jsOdLsm5zAo6A85x/X05jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310972; c=relaxed/simple;
	bh=5YSTM2cg0G+we0OL+Krxk1NE3KwiMAQeiNzwu890rPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFYhvy+AKWtC7idy8wGGj3YMo/EAR8AGzf/PLgls/Vs6AWtrgr6P2nCpPCZIsLe+wxDWKnrQ3BtQA7V4C5dojrZWjT7r6AxMTZRQ0KXHdnjy9bp2C+nll3mQRSKi4kvKCkFWlalCg7NuCXoBJOQrGcOok2EzrBSFSpH41NHx4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 84AC32C06846;
	Thu, 15 May 2025 14:08:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7673B26E80; Thu, 15 May 2025 14:09:25 +0200 (CEST)
Date: Thu, 15 May 2025 14:09:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krzysztof Wilczy??ski <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Message-ID: <aCXZdfOA8bme-qra@wunner.de>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
 <174724335628.23991.985637450230528945.b4-ty@kernel.org>
 <aCTyFtJJcgorjzDv@wunner.de>
 <20250515084346.GA51912@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515084346.GA51912@rocinante>

On Thu, May 15, 2025 at 05:43:46PM +0900, Krzysztof Wilczy??ski wrote:
> Done.  Squashed with the first commit from Ilpo, see:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=bwctrl&id=2389d8dc38fee18176c49e9c4804f5ecc55807fa

Awesome, thank you!

> Let me know if there is anything else needed.

Actually, two small things:

- That patch on the pci/bwctrl topic branch is still marked "New"
  in patchwork, even though it's been applied:
  https://patchwork.kernel.org/project/linux-pci/patch/20250422115548.1483-1-ilpo.jarvinen@linux.intel.com/

- Version 1 of the same patch is likewise marked "New", even though
  it's been superseded:
  https://patchwork.kernel.org/project/linux-pci/patch/20250417124633.11470-1-ilpo.jarvinen@linux.intel.com/

Unfortunately I can't update it myself because I'm not the submitter.
(Ilpo could do it if he has a patchwork.kernel.org account.)


Something unrelated (only if you feel like doing it):

On the pci/enumeration branch, Bjorn queued up a revert which was
waiting to be ack'ed by AMD IOMMU maintainers:
https://lore.kernel.org/r/20250425163259.GA546441@bhelgaas/

In the meantime the ack has arrived:
https://lore.kernel.org/r/aCLv7cN_s1Z4abEl@8bytes.org/

So the remaining housekeeping items are:

- Add Jörg's Acked-by to commit e86c7278eba8 on pci/enumeration
- Remove the "XXX" marker from the subject line
- Remove "Needs AMD IOMMU ack" from the commit message

Again, only if you feel like doing it.  No urgency.

Thanks,

Lukas

