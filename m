Return-Path: <linux-pci+bounces-21131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA76A2FE1D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 00:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E923A4A1C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 23:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D2253F17;
	Mon, 10 Feb 2025 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sf80Nv9r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF81B85FD;
	Mon, 10 Feb 2025 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228609; cv=none; b=utcb+4+5a0r1wauAsGBwU2qY3cXm+KM6eTcDcqG6n9S1udlRbNkIiAg4zk2xpBjaF5TIgydAO6NiR8sj1/9Ex2JjwagK8SmzD/mAIWCFjfRuLqOe5Oxn3ip2GCok8HrkysEhhoQ5UqcYrL5OK5Pwn8PzMPv6wXnYdGRWrcDh3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228609; c=relaxed/simple;
	bh=6UlHl/0c8/etRCnPbCWlR9BLr2AyA3Da//0TswrwiLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWOSzOvf46LDwdk8d2sR81fst7PgBLwPE24GIboiweh1DIIZ+oZZai9fD5wqVaM5fqySGkjFJGIM5hkZj6MQY8D0lSLeQbvGZurIwhnpGTBFAsORmSMT27DRtL2qD4I7maosXCOplwS1smuSg44KKteY6qiFXsB/qAqMQXcrroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sf80Nv9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7D6C4CED1;
	Mon, 10 Feb 2025 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739228608;
	bh=6UlHl/0c8/etRCnPbCWlR9BLr2AyA3Da//0TswrwiLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sf80Nv9rIs+QV+kwhZ/0tZ1N8O2ybpQcJCEzAMrFpsI8IN3A+ulA8hj0f2yXWvD7b
	 6iS5Mh11Zf/wCMJgfop+7F+xVhFsf8zbix5//5nsSz+ZrLIg6QhDFpgq1ySwDTRt3Q
	 NQO0Db1LGOiid5ZD46VXcHBSRzLl3N9L+X0BQcUI2vPKRk4APik5Nit8Kmeaj5EuR+
	 wZLIZMJDIoTK8N+3ZNFm+G+bbVksmYL3yz35nTXWI0ZEeqaptqQPGDIcnHwGJIrkRh
	 k9Cg5bakgi/35Rsid7dg7RvBFwpxWrVuLi4JcSEGJTLvINTjqJtSWpfyCtzyiNA9pn
	 5zl5L3FrtJh3w==
Date: Mon, 10 Feb 2025 16:03:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: bhelgaas@google.com, skhan@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pci: Fix flexible array usage
Message-ID: <Z6qFvrf1gsZGSIGo@kbusch-mbp>
References: <20250210132740.20068-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210132740.20068-1-purvayeshi550@gmail.com>

On Mon, Feb 10, 2025 at 06:57:40PM +0530, Purva Yeshi wrote:
> Fix warning detected by smatch tool:
> Array of flexible structure occurs in 'pci_saved_state' struct
> 
> The warning occurs because struct pci_saved_state contains struct
> pci_cap_saved_data cap[], where cap[] has a flexible array member (data[]).
> Arrays of structures with flexible members are not allowed, leading to this
> warning.
> 
> Replaced cap[] with a pointer (*cap), allowing dynamic memory allocation
> instead of embedding an invalid array of flexible structures.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a7..648a080ef 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1929,7 +1929,7 @@ EXPORT_SYMBOL(pci_restore_state);
>  
>  struct pci_saved_state {
>  	u32 config_space[16];
> -	struct pci_cap_saved_data cap[];
> +	struct pci_cap_saved_data *cap;
>  };

I don't think this is right. Previously the space for "cap" was
allocated at the end of the pci_saved_state, but now it's just an
uninitialized pointer.

