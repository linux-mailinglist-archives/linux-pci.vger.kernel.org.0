Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC944FEF2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhKOHEZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhKOHEQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:04:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28088C0613B9;
        Sun, 14 Nov 2021 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QUscPiuxtDZPYfLpRZ8JxbCcmQo5e5fIT8pTN4kW5UI=; b=WOGWTe7CunTbSrrCkhb+YUEqdr
        jvh3qoBzsLT4SRByBv48cDZ0hKXDtUNC9D9Kaz01v+N+DMvizFcogDOa3LwZjJNn/Fe4QPn436Sll
        Fb4i7WMjMFi+ODyexQ6MBdse9wFUrCfe7sxi50X+aJPyJrlSjPiWrpp5phTdQleC/X7ab9OdqYYe2
        p0O9s6w35+K7UtKwGKgEwIHj8NF7xsQUkGSSAJ4I5F7ZDD9GJd1JeaCd86AwlbIfQH47tTRx+sAZ1
        +1E9fiEFxXdN61A8tRIqmCy5rODVi7UlVjvkv+E/CpsdjTTiJHsEZ8cgqMl+Y+n0gKwGZr0EQB40W
        b+3osgrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmVzR-00ETqz-M9; Mon, 15 Nov 2021 07:01:17 +0000
Date:   Sun, 14 Nov 2021 23:01:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/4] PCI/ASPM: Do not cache link latencies
Message-ID: <YZIFvZzdajJf3iTU@infradead.org>
References: <20211106175305.25565-1-refactormyself@gmail.com>
 <20211106175305.25565-3-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106175305.25565-3-refactormyself@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 06, 2021 at 06:53:03PM +0100, Saheed O. Bolarinwa wrote:
> The latencies of the upstream and downstream are calculated within
> pcie_aspm_cap_init() and cached in struct pcie_link_state.latency_*
> These values are only used in pcie_aspm_check_latency() where they are
> compared with the acceptable latencies on the link.
> 
> - remove `latency_*` entries from struct pcie_link_state.
> - calculate the latencies directly where they are needed.
> 
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a6d89c2c5b60..9e74df7b9dc0 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -66,9 +66,6 @@ struct pcie_link_state {
>  	u32 clkpm_default:1;		/* Default Clock PM state by BIOS */
>  	u32 clkpm_disable:1;		/* Clock PM disabled */
>  
> -	/* Exit latencies */
> -	struct aspm_latency latency_up;	/* Upstream direction exit latency */
> -	struct aspm_latency latency_dw;	/* Downstream direction exit latency */
>  	/*
>  	 * Endpoint acceptable latencies. A pcie downstream port only
>  	 * has one slot under it, so at most there are 8 functions.
> @@ -392,7 +389,8 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
>  
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -	u32 latency, l1_switch_latency = 0;
> +	u32 latency, lnkcap_up, lnkcap_dw, l1_switch_latency = 0;
> +	struct aspm_latency latency_up, latency_dw;
>  	struct aspm_latency *acceptable;
>  	struct pcie_link_state *link;
>  
> @@ -405,14 +403,23 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  	acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
>  
>  	while (link) {
> +		/* Read direction exit latencies */
> +		pcie_capability_read_dword(link->pdev, PCI_EXP_LNKCAP, &lnkcap_up);
> +		pcie_capability_read_dword(pci_function_0(link->pdev->subordinate),

Please avoid the overly long lines.
