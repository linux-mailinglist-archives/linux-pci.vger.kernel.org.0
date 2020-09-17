Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1B26E78C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 23:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgIQVqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 17:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgIQVqU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 17:46:20 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C9A52075B;
        Thu, 17 Sep 2020 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600379179;
        bh=zo5IC2jIlre8hbgTo0lgZ3+BBebVpjFZK/pyzQThpCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QRABPe31OdFIcP1Adp+Go/KGvk5BZpyB8yraljjmn7widkROv8EeUjPAiXcT8n8/C
         jvwVLFp/oQz3aP57zFfNwJretxHQXzyorBMam4Lf77sW4a8MSx2As1TonnzsypyWCo
         g1DXL/rDM+UXW2ZSJXgONOjDhRNtxjm0mM4H5bfw=
Date:   Thu, 17 Sep 2020 16:46:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] [-next] PCI: endpoint: Using plain integer as NULL
 pointer
Message-ID: <20200917214618.GA1740746@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80895f7465719edb3aa259e907acc4bc3217945c.1600378209.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 11:30:27PM +0200, Gustavo Pimentel wrote:
> Fixes warning given by executing "make C=2 drivers/pci/"
> 
> Sparse output:
> CHECK   drivers/pci/endpoint/pci-epc-core.c
>  drivers/pci/endpoint/pci-epc-core.c: note: in included file:
>  ./include/linux/pci-ep-cfs.h:22:16: warning:
>  Using plain integer as NULL pointer
> CHECK   drivers/pci/endpoint/pci-epf-core.c
>  drivers/pci/endpoint/pci-epf-core.c: note: in included file:
>  ./include/linux/pci-ep-cfs.h:31:16: warning:
>  Using plain integer as NULL pointer
> 
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

I like this one.

Applied to pci/misc for v5.10, thanks!

> ---
>  include/linux/pci-ep-cfs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci-ep-cfs.h b/include/linux/pci-ep-cfs.h
> index f42b0fd..6628813 100644
> --- a/include/linux/pci-ep-cfs.h
> +++ b/include/linux/pci-ep-cfs.h
> @@ -19,7 +19,7 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group);
>  #else
>  static inline struct config_group *pci_ep_cfs_add_epc_group(const char *name)
>  {
> -	return 0;
> +	return NULL;
>  }
>  
>  static inline void pci_ep_cfs_remove_epc_group(struct config_group *group)
> @@ -28,7 +28,7 @@ static inline void pci_ep_cfs_remove_epc_group(struct config_group *group)
>  
>  static inline struct config_group *pci_ep_cfs_add_epf_group(const char *name)
>  {
> -	return 0;
> +	return NULL;
>  }
>  
>  static inline void pci_ep_cfs_remove_epf_group(struct config_group *group)
> -- 
> 2.7.4
> 
