Return-Path: <linux-pci+bounces-34078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE4B270FC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 23:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9FD5E657E
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DE427A916;
	Thu, 14 Aug 2025 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGVqUrRT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB976279DB4;
	Thu, 14 Aug 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207716; cv=none; b=Q/wVqfrGEwKWZrW67tFZ0I13rzmvdwKmojoF29M16YTfVreTfluQXtZ/wsHAEZLsvQj11HYwvAXb1zI4Mq3BTXPTnpLZMyWis0yNWgmTlphysWUVIrh9vyUT3QDgqiwWpx92rL83yLR46oxMf2RREDYAq4ZRWk27GdWi00h7lqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207716; c=relaxed/simple;
	bh=VpoePV0SvnpAqZTJ/bpqTsi9FHbgTr56J13rH7hPneY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sV3XFMIVQtViBT+Z7v6j1bYN1p79BUuuWfGqy0ghYtXl1m5BHe1qbdm3DtVx+B4LbNz+J9rcx1NkmDZeX2zbUAw96T75gyqws1xqJdx0ld6me6SiyiRpnOkbnpY3aT2K5112ZjWVQyUJQMTLX6U0quQX8UgK6NZlYOj3mGXKZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGVqUrRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B3BC4CEED;
	Thu, 14 Aug 2025 21:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755207716;
	bh=VpoePV0SvnpAqZTJ/bpqTsi9FHbgTr56J13rH7hPneY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UGVqUrRTz3c5ThZbRTmp2+7/Pop/uSRyOPB3/De34Anabuk4YEgHBCWhMMymTERJv
	 us2sTXt83bYpvtN8qfEnSaMpRWwtseasQLWtinWZhXDc9OSECyusWAgmxHbRxclSf+
	 TaXp5hwowU/Aj10Jgp368wXszdB6ZPNSII93pQKHmhKGX4WV+bmyf05xWw/tcoBKzn
	 LE+TnYEZP0ha6m1t7ISFZx9cScMac2u9DbwOB9wYEZhqUyGiJRdxMtSyJ6dvnapVxq
	 R+Dg/Iac226SmmuS29nbvKuQTi5/SCQdPuquOsz/VEiNv3ZOf/RRkwqaLwLq/3WnzF
	 1Rj8NbQztAZHg==
Date: Thu, 14 Aug 2025 16:41:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/13] PCI: cadence: Split PCIe EP support into common
 and specific functions
Message-ID: <20250814214154.GA350532@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813042331.1258272-5-hans.zhang@cixtech.com>

On Wed, Aug 13, 2025 at 12:23:22PM +0800, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> Split the Cadence PCIe controller EP functionality into common
> ibrary functions and functions for legacy PCIe EP controller.

s/ibrary/library/

> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep-common.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Cadence
> +// Cadence PCIe endpoint controller driver common
> +// Author: Manikandan K Pillai <mpillai@cadence.com>

This *looks* like mostly a code move from pcie-cadence-ep.c to
pcie-cadence-ep-common.c.  If that's the case, make this patch *only*
a move (no code changes or whitespace changes as in
cdns_pcie_ep_start()).  And say in the commit log that you're only
moving, not changing, the code.

Also preserve the author from pcie-cadence-ep.c if that's the case.

I do look a little sideways at the // comments since the pcie-cadence*
files are basically the only users in drivers/pci/ (except for the
ibmhp driver that is ancient and basically dead).

Bjorn

