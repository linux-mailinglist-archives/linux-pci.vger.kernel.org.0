Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F113B96BF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhGATsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 15:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233671AbhGATsl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 15:48:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 558336137D;
        Thu,  1 Jul 2021 19:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625168770;
        bh=JojscTv4rJz7rLg1H0xFJT4opmHXJRbrVBHCt+0GBx8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Cwqd8JAebD5mpCCmmOL4SYvZqtsOrtNDokB1ZrlBeeegWptFOf99u3bhR0aQWrAlk
         Mf1zshpIectrgmDrUZp+0NATCv/aTN3mCMzDJJaF6xu0iYdg+/GDSU1PSRmSLkchgp
         1U81FvJ95twCUs3ihDLNQ6v3Nx3SnyBHBEIerImdbnUgyTfc9AT9Bj2YGtS7iPyCEs
         mMO9YVJBuMEXiFnyqzUjo9dWHlSScqUVfNL+CwHQxYn2KZ+SCAQf3ldWPuuVYo2xND
         3eYtJdsxYxuHubu6NdEND6EbnLDXwrDB2gU+9ASff0EvbWm+Ny7LT9jLjCyKAxgaay
         f1swrGHt+5ZCg==
Date:   Thu, 1 Jul 2021 14:46:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joyce Ooi <joyce.ooi@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ley Foon Tan <lftan.linux@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Replace Ley Foon Tan as Altera PCIE
 maintainer
Message-ID: <20210701194609.GA83537@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701065247.152292-1-joyce.ooi@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 01, 2021 at 02:52:47PM +0800, Joyce Ooi wrote:
> This patch is to replace Ley Foon Tan as Altera PCIE maintainer as she
> has moved to a different role.
> 
> Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>

Applied to pci/misc for v5.14, thanks!

I also dropped the rfi@lists.rocketboards.org address since it seems
to be dead.  If it's fixed, let me know and we'll keep it.

> ---
>  MAINTAINERS |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 66d047d..7693c5b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14148,7 +14148,7 @@ F:	Documentation/devicetree/bindings/pci/aardvark-pci.txt
>  F:	drivers/pci/controller/pci-aardvark.c
>  
>  PCI DRIVER FOR ALTERA PCIE IP
> -M:	Ley Foon Tan <ley.foon.tan@intel.com>
> +M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> @@ -14353,7 +14353,7 @@ S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
>  PCI MSI DRIVER FOR ALTERA MSI IP
> -M:	Ley Foon Tan <ley.foon.tan@intel.com>
> +M:	Joyce Ooi <joyce.ooi@intel.com>
>  L:	rfi@lists.rocketboards.org (moderated for non-subscribers)
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
> -- 
> 1.7.1
> 
