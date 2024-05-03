Return-Path: <linux-pci+bounces-7059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B642A8BB5B6
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 23:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6C41C2261C
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 21:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454464F88C;
	Fri,  3 May 2024 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8Xs22E9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBEB364AC;
	Fri,  3 May 2024 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771773; cv=none; b=SMVU8epPK9UgfE1vbEoS9y/dqmFr4QLdTqflAe95F4HdKBSxcFbfRchcaM331GBTTqUVfPCptvNK/Hza9fSnxPoFvG1HG/cbxjzIRTbABa1O1aTUEF1b7pKHdIxcquSpPiYHdDKzEe74geSOZL0FhiIbzt/4qvy13XQ/jp4QV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771773; c=relaxed/simple;
	bh=JrWewF09aX2ijWD80QIE7qhm6ZU78qN80094QqAXHSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E6mrRe69tFSy6jq5S9q4J1dUqtBxpucy8XDZ4yd+EXeu+p+rGTOE2GfZlP6YAUshJprdMB1/Rhi0ifPc2L17+CksqZ2NpE3YJGkCz7m7gvxG18FGv+T86hDiGsD3q5Byvh01yJdMlIWm4lyv2SM4HIaoMRq/g45loD+3S6CJGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8Xs22E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72379C116B1;
	Fri,  3 May 2024 21:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714771772;
	bh=JrWewF09aX2ijWD80QIE7qhm6ZU78qN80094QqAXHSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=s8Xs22E9gFYl1Gh78dc4GAhrFOO9yPPaQM/6k31Y2/49yPjDoQ186Af6rKXWhB7BE
	 d8IBJFI/s2eSGPJXLp/5vh6zDLW0Na6RWBUaQPC9xg1x/ML7/4yavN+ivF7jBWTNCi
	 6jEdmO+AemcwnTJa2ZagkmYbnVreUCNmO99B+M4p0g3hM7mVdiGlM0ReHnzfkMqSr/
	 S75cludNd+CgjElPuT/okLbvR+bgrSMnJRiHyMmHX3t0tnXq6rQEPR6HBmJXpo19RM
	 Blo55aSMlAqWjzc1C81+d0EMQOyllbUK3sYpUQvPiGBgoCh7+WJHHdincHRJi9L43L
	 FNFHNt7JD/N1A==
Date: Fri, 3 May 2024 16:29:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] check returned value of pci_hp_add_bridge()
Message-ID: <20240503212930.GA1605242@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714762038.git.namcao@linutronix.de>

On Fri, May 03, 2024 at 09:23:18PM +0200, Nam Cao wrote:
> ...

> Nam Cao (4):
>   PCI: shpchp: bail out if pci_hp_add_bridge() fails
>   PCI: pciehp: bail out if pci_hp_add_bridge() fails
>   PCI: hotplug: document unchecked return value of pci_hp_add_bridge()
>   PCI: hotplug: remove TODO notes for sgi_hotplug
> 
>  drivers/pci/hotplug/TODO         | 12 +++++-------
>  drivers/pci/hotplug/pciehp_pci.c |  9 +++++++--
>  drivers/pci/hotplug/shpchp_pci.c |  9 +++++++--
>  3 files changed, 19 insertions(+), 11 deletions(-)

I applied the last two (the TODO updates) to pci/hotplug for v6.10,
thanks!

