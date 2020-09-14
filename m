Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF9269530
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 20:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgINSwh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 14:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgINSwg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 14:52:36 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778DA217BA;
        Mon, 14 Sep 2020 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600109555;
        bh=CU1t68cKWYnowy/iGgKToIJRkFD59ac63VwupC44nRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AMlrSYpMNzqTx9g8elTHqdpy6EgGwjp9cBOabRykU9Beva2R3m6hlyB5KC2blJcGp
         hPuzXOtzhDhZap0rdxTetHoijFm5drVNKD9jDIQ22Ij7jNqbL1ClQ3nHfUB+7MrFqc
         X7zOqGA/CLoFPPZkVdD2nBllO8b5q1XkknOcHqjE=
Date:   Mon, 14 Sep 2020 13:52:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        You-Sheng Yang <vicamo.yang@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Offset Client VMD MSI/X vectors
Message-ID: <20200914185234.GA1297816@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914173255.5481-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jon,

This refers to "MSI/X" (subject, commit log of this patch, as well as
other recent patches).  I don't know if that means what the spec calls
"MSI-X", or if you mean something like "MSI or MSI-X" (there is one
reference in vmd.c to "MSI/MSI-X").

I'd sort of rather avoid adding "MSI/X" to the PCI lexicon because of
this ambiguity.

If it's not important to the meaning or if it's clear from context
that "MSI" is a generic term for "either MSI or MSI-X", I'm ok with
using that.

Bjorn

On Mon, Sep 14, 2020 at 01:32:55PM -0400, Jon Derrick wrote:
> Client VMD platforms have a software-triggered MSI/X vector 0 that will
> not forward hardware-remapped MSI/X vectors from the sub-device domain.
> This causes an issue with VMD platforms that use AHCI behind VMD and
> have a single MSI/X vector mapping to vector 0. Add an MSI/X vector
> offset for these platforms.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/controller/vmd.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index f69ef8c89f72..f8195bad79d1 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -53,6 +53,12 @@ enum vmd_features {
>  	 * vendor-specific capability space
>  	 */
>  	VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP	= (1 << 2),
> +
> +	/*
> +	 * Device may use MSI/X vector 0 for software triggering and will not
> +	 * be used for MSI/X remapping
> +	 */
> +	VMD_FEAT_OFFSET_FIRST_VECTOR		= (1 << 3),
...
