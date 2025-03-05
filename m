Return-Path: <linux-pci+bounces-22998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF3BA506C1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 18:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3A47A2349
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE6198A0D;
	Wed,  5 Mar 2025 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMNp8BNR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CEA95C;
	Wed,  5 Mar 2025 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196973; cv=none; b=kKtiMTFgYwQ5aQyj2OsVxKeySkFVltzmmsHK7Ays+CzLbWidXCPe+PelHZVWgw4f2Pp0GOq8dcUbzPEnXO4sUweDo5C2f/Pj2p1tlu8J04XZmRYaPGGqJjl+MC1rNbsSo6++ipzYX2P3/OAt3YRcbCCoS7SaYO435WN9wYK3/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196973; c=relaxed/simple;
	bh=y6VDarEa69IP9AO/jDl/jnWlZ5owUB+loKEniZ9wFi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YHHGciAF2kB0ylRZ6FFoHekJJq1N+P0WgDj0JAh40pQWvPyAX/Sy+TkVLE+JN10Yh6U7rSpUsggRdG60gfeaEwgu7EPphvy9axKwLU3AUsghLcX/f0mW5bCYJO7FKq6/vhr1X3BleYV75wwsFZjZCbSbgbi3rwROwl58+GkhFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMNp8BNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B511CC4CED1;
	Wed,  5 Mar 2025 17:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196972;
	bh=y6VDarEa69IP9AO/jDl/jnWlZ5owUB+loKEniZ9wFi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fMNp8BNRUPit57f1u4QJFEANzKOPLWArJZzWfQTg7XsghQj88Xkg9jAHcvyYTGAlN
	 QRjb4ZZomQZkvxfzkCO8xfIAub1QzpYCTK5AkdEN88WIatNF/ybKLtPBmhv7+hLpGV
	 HfBs4TsNoRFcspSwp3xNA35BEyCag9yL9Kk0IWw1AGbvV4YP2hwQuaizClZID7CxT6
	 HJC8+NtTCPAGVxrUip4Eq8+xHCQOq+1QsfUwpLK0yRTwL/pAS/7xfVINycp03vdVlv
	 M2tOncj0SfaZVRS9TuGK9BK2Mme52IGWoNlw5tANSB1XDarxQUr/muwkVT7P6K4xt1
	 OT0gi7Hw6VJyw==
Date: Wed, 5 Mar 2025 11:49:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Chen <peter.chen@cixtech.com>
Subject: Re: [PATCH] PCI: pci_ids: Add Cixtech P1 Platforms vendor and device
 ID
Message-ID: <20250305174931.GA304679@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305063018.415616-1-hans.zhang@cixtech.com>

On Wed, Mar 05, 2025 at 02:30:18PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add Cixtech P1 (internal name sky1) as a vendor and device ID for PCI
> devices so we can use the macro for future drivers.

See note at top of file:

   *      Please keep sorted by numeric Vendor ID and Device ID.
   *
   *      Do not add new entries to this file unless the definitions
   *      are shared between multiple drivers.

Include this patch in a series that shows multiple drivers using it
and mention those drivers in the commit log.

Update the subject line to match the existing style (use "git log
--oneline include/linux/pci_ids.h"):

  PCI: Add Cix Technology Vendor and Device ID

> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> ---
>  include/linux/pci_ids.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1a2594a38199..531b34c1181a 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -200,6 +200,9 @@
>  #define PCI_DEVICE_ID_COMPAQ_THUNDER	0xf130
>  #define PCI_DEVICE_ID_COMPAQ_NETFLEX3B	0xf150
>  
> +#define PCI_VENDOR_ID_CIX               0x1f6c
> +#define PCI_DEVICE_ID_CIX_SKY1          0x0001

This is not sorted by Vendor ID.

>  #define PCI_VENDOR_ID_NCR		0x1000
>  #define PCI_VENDOR_ID_LSI_LOGIC		0x1000
>  #define PCI_DEVICE_ID_NCR_53C810	0x0001
> 
> base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
> -- 
> 2.47.1
> 

