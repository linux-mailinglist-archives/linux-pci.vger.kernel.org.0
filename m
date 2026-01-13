Return-Path: <linux-pci+bounces-44663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E65D1AF97
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAD8B3021E7F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422135B150;
	Tue, 13 Jan 2026 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSg1KQaV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B935A94E;
	Tue, 13 Jan 2026 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331404; cv=none; b=WtJZL3dxWdKBucy5Qeo0l2/JOQA+f89ivbZYldh591XmuEcsdvvTVErjduRSorPE3lE/9x4v7NogxEQxRtZI+TBUrF5rc41TcR+yLy/ZPtSDkv/mXm01GKzkKYgHoe62gwWmrBBwjH0KcJX6vgrr1fn3eh7A7sTChBfR0UnSGxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331404; c=relaxed/simple;
	bh=Mb5dhqcO+iX8x72O1BFzmQUPWPaRi8jqKNevCzviSJs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k3dOCAgnhkM7ebxCQ9vkiWFH3RcMSEncj+/rz77xfVPZzQXcCiNQksULPFotTOO0kSJ/Gu5FwwAuT3PABn75LmINzIUZpBtYvhjHqxUCefl9nF8LqIYCuYuUcUXvJSWItc1b4TmOg+7WERKuE/1roOwYCrAOKWsVqc0hRMBh7kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSg1KQaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54682C116C6;
	Tue, 13 Jan 2026 19:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768331404;
	bh=Mb5dhqcO+iX8x72O1BFzmQUPWPaRi8jqKNevCzviSJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NSg1KQaV7CDovf9sacQUkYobmRkQSPSm50dYUM9iYGgA8+ZK5jYpsJA+z4BCedGb8
	 RuG/2VCKXoMfHViPfkxqt4Pmu60Km8f104Am/QcwymswlDO2hUmyrk1EQb2o0KCChQ
	 UsRvqzUUgjgFqcKAjGwspMGCSTd1+utfJ0Fyql0K2b/bJu2boLo9/HarpPra5KlyOh
	 YHmWc+DB0zQPnr8Pw/pw6aUDiALWAlrR94v5K0Kj/MxSp2t6T1fcgLjc8F92iIdy8Z
	 w1hYDCB5WlZMQB7NJ3CpOkkU5LDE4qSkDgEYnMCC+GmHAZYBqdjuN3osFgrsTm/Vpd
	 WEgbGHaY6mJFQ==
Date: Tue, 13 Jan 2026 13:10:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Li Ming <ming.li@zohomail.com>
Cc: dan.j.williams@intel.com, linux-pci@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/IDE: Fix reading a wrong reg for unused sel
 stream initialization
Message-ID: <20260113191003.GA776139@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111073823.486665-1-ming.li@zohomail.com>

On Sun, Jan 11, 2026 at 03:38:23PM +0800, Li Ming wrote:
> During pci_ide_init(), it will write PCI_ID_RESERVED_STREAM_ID into all
> unused selective IDE stream blocks. In a selective IDE stream block, IDE
> stream ID field is in selective IDE stream control register instead of
> selective IDE stream capability register.
> 
> Fixes: 079115370d00 ("PCI/IDE: Initialize an ID for all IDE streams")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Dan, I assume you'll take this?  It looks like you've merged
everything to do with ide.c.

> ---
>  drivers/pci/ide.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index f0ef474e1a0d..26f7cc94ec31 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -168,7 +168,7 @@ void pci_ide_init(struct pci_dev *pdev)
>  	for (u16 i = 0; i < nr_streams; i++) {
>  		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
>  
> -		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CTL, &val);
>  		if (val & PCI_IDE_SEL_CTL_EN)
>  			continue;
>  		val &= ~PCI_IDE_SEL_CTL_ID;
> -- 
> 2.34.1
> 

