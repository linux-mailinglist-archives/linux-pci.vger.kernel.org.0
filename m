Return-Path: <linux-pci+bounces-27180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C3AA9A91
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 19:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0C43A5CD7
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D426C390;
	Mon,  5 May 2025 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnVW0EaO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE4126B978
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466270; cv=none; b=ufbCunIyx3aEgAOEjo+OP5s8MkPbCM/V0C49Z5zjCFR7aebwaRqcabm/8NDGbtUVULz7qzTw1uaczYsfCz049ZfZ0VRiBQhSR6wDOZTbCKG/1pTW2lCEtBBpLG6zhbK7qCKTP1ZSXhrxsmCnDuYtPkGUhuN1RkPFNqUSPHm4pcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466270; c=relaxed/simple;
	bh=mUop/LB2PyEZxafvDtzmC6J52m3TFkDR8pVKOV0YheE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T5htMsCuwhWW0xV3eYtw78TRl1o2HWKXp8Bfa2ZvzqPkPjPNhcWSmhWPGTuLaDMLzCiKlt5/Zd6HWCC8XFiwmPry4vaWnkkhqyywYnLNpxlqd5Dwu0dxcKetlPS+1ECdKttgpUCUwOrD8YB2jZ9i2/EZsHXm9XZV7j4chXdnioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnVW0EaO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4196DC4CEEF;
	Mon,  5 May 2025 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746466269;
	bh=mUop/LB2PyEZxafvDtzmC6J52m3TFkDR8pVKOV0YheE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GnVW0EaOxB3kCS6GyN+V2URPftjGt89mGxP8R+X72q0UEaOOkwMEi7e2M/RKU7zWJ
	 QrhfKbvJQtsWhUVmaz1V3lJO9XDj9yiRAwq3VQutejNtMhP77MDSVpUlLprUeOwB5O
	 fGIiE/7rgCemrCAaKMlETBUQAPgnP3mjSNdAuw6iVt1/1MSBiW7RR5VyuEW6Yoilq4
	 oc/ox3jZLDZYJS9/AgGuzE+bmZAXKdFYmnmGR2GceF+qHuT9LfZlfqprsTh3sT4e0Y
	 EGM0AchSfUE3orbAi90SH08BiVW5j/1kdIg9LUwAPPRptaL0uE3J6VSGY951ygg1Ih
	 WK0fpBvzywhGQ==
Date: Mon, 5 May 2025 12:31:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: Re: [PATCH v3 7/8] PCI: vmd: Add support for second rootbus under VMD
Message-ID: <20250505173107.GA983255@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122085215.424736-8-szymon.durawa@linux.intel.com>

On Fri, Nov 22, 2024 at 09:52:14AM +0100, Szymon Durawa wrote:
> Starting from Intel Arrow Lake VMD enhancement introduces second rootbus
> support with fixed root bus number (0x80). It means that all 3 MMIO BARs
> exposed by VMD are shared now between both buses (current BUS0 and
> new BUS1).
> 
> Add new BUS1 enumeration and divide MMIO space to be shared between
> both rootbuses. Due to enumeration issues with rootbus hardwired to a
> fixed non-zero value, this patch will work with a workaround proposed
> in next patch. Without workaround user won't see attached devices for BUS1
> rootbus.

s/rootbus/root bus/

> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 208 ++++++++++++++++++++++++++++++-----
>  1 file changed, 180 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 6d8397b5ebee..6cd14c28fd4e 100755
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -26,6 +26,7 @@
>  #define VMD_RESTRICT_0_BUS_START 0
>  #define VMD_RESTRICT_1_BUS_START 128
>  #define VMD_RESTRICT_2_BUS_START 224
> +#define VMD_RESTRICT_3_BUS_START 225

You're just following the pattern here, which makes sense.  But these
are apparently bus numbers, which are typically written in hex, so it
would be nice to convert them all so we don't have to convert.

>  #define PCI_REG_VMCAP		0x40
>  #define BUS_RESTRICT_CAP(vmcap)	(vmcap & 0x1)
> @@ -38,15 +39,33 @@
>  #define MB2_SHADOW_OFFSET	0x2000
>  #define MB2_SHADOW_SIZE		16
>  
> +#define VMD_PRIMARY_BUS0 0x00
> +#define VMD_PRIMARY_BUS1 0x80

The above are bus numbers; the below are register offsets.  Would be
nice to separate them with a blank line since they are semantically
different.

I don't understand the difference between VMD_RESTRICT_3_BUS_START and
VMD_PRIMARY_BUS1.  Maybe one is the default Primary Bus Number of the
Root Ports after a reset?

> +#define VMD_BUSRANGE0 0xc8
> +#define VMD_BUSRANGE1 0xcc
> +#define VMD_MEMBAR1_OFFSET 0xd0
> +#define VMD_MEMBAR2_OFFSET1 0xd8
> +#define VMD_MEMBAR2_OFFSET2 0xdc
> +#define VMD_BUS_END(busr) ((busr >> 8) & 0xff)
> +#define VMD_BUS_START(busr) (busr & 0x00ff)

Would be nice if VMD_BUS_END/VMD_BUS_START were defined with
GENMASK(); then we could use FIELD_GET() below to extract them.

Nit: indent these bus numbers and offsets so the values line up like
the other #defines.

> +	 * Starting from Intel Arrow Lake, VMD devices have their VMD rootports
> +	 * connected to additional BUS1 rootport.

This doesn't quite make sense.  Root Ports can't be connected to
another Root Port.  I think you mean "Root Ports on the additional
root bus".

