Return-Path: <linux-pci+bounces-35425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA75B43229
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C414E3A5548
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B9D25B1D2;
	Thu,  4 Sep 2025 06:16:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEB227563
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966601; cv=none; b=ZjvRLCbJnxdUsDR2hqeQ6Sxu+/I3MUl0pqUw5RYG2rdgsvUOs8L+s7sTWORMUhcqTD21WxFWuspncEcHSNzYMvZfISmQvAzTDifARR/ZlwKo4OOBIbMMaBUFV2qaU/iMn7lzyLIkPvjtqOmq9yXqhdXzFmYIKMzKfJKg+L3KD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966601; c=relaxed/simple;
	bh=Xp6FHyec7/CuPyCG/Jkvm+maJKe5uOXKo+K0fx2mh2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gk7aSXMUW1rAmtjjtduQBhzJap9t1dMeyflJKlQdIOK5eQ3xCmW+cdEDyXA/xJ3GT9C5aXnR7rPwtCqjPRKc0HRCga10mVotQ9UWEQzxxPwQ9pp8qA7JKeZJ1PlO3/6ri5hOKyud+Cg+D1QR77mmjQpImUP9XM7ETrWhmBsMAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 354A320091B5;
	Thu,  4 Sep 2025 08:16:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1C33F402D8B; Thu,  4 Sep 2025 08:16:29 +0200 (CEST)
Date: Thu, 4 Sep 2025 08:16:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>,
	Terry Bowman <terry.bowman@amd.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH] PCI/AER: Print TLP Log for errors introduced since PCIe
 r1.1
Message-ID: <aLkuvb5v4LuVJuyU@wunner.de>
References: <5f707caf1260bd8f15012bb032f7da9a9b898aba.1756712066.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f707caf1260bd8f15012bb032f7da9a9b898aba.1756712066.git.lukas@wunner.de>

On Mon, Sep 01, 2025 at 09:44:52AM +0200, Lukas Wunner wrote:
> +++ b/include/uapi/linux/pci_regs.h
> @@ -776,6 +776,13 @@
>  #define  PCI_ERR_UNC_MCBTLP	0x00800000	/* MC blocked TLP */
>  #define  PCI_ERR_UNC_ATOMEG	0x01000000	/* Atomic egress blocked */
>  #define  PCI_ERR_UNC_TLPPRE	0x02000000	/* TLP prefix blocked */
> +#define  PCI_ERR_UNC_POISON_BLK	0x04000000	/* Poisoned TLP Egress Blocked */
> +#define  PCI_ERR_UNC_DMWR_BLK	0x08000000	/* DMWr Request Egress Blocked */
> +#define  PCI_ERR_UNC_IDE_CHECK	0x10000000	/* IDE Check Failed */
> +#define  PCI_ERR_UNC_MISR_IDE	0x20000000	/* Misrouted IDE TLP */
> +#define  PCI_ERR_UNC_PCRC_CHECK	0x40000000	/* PCRC Check Failed */
> +#define  PCI_ERR_UNC_XLAT_BLK	0x80000000	/* TLP Translation Egress Blocked */
> +
>  #define PCI_ERR_UNCOR_MASK	0x08	/* Uncorrectable Error Mask */
>  	/* Same bits as above */

I've realized that I inadvertently introduced a gratuitous blank line here.
Bjorn, you may want to remove that from commit dab104c81cba on pci/aer.
My apologies for the inconvenience!

Thanks,

Lukas

