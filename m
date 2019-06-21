Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28774EFD4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 22:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfFUUHu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 16:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfFUUHu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 16:07:50 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D792620673;
        Fri, 21 Jun 2019 20:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561147669;
        bh=0Q6eZ4Ns3hj441z/4FACxfCJGnJCj66TT2wHjPxYctg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w12K6GV4LF55nMlAjG9W/joMJeEznA7KRY71x5SZcW2XB4nR+PJFqakBok/wlrgHG
         nYpbqoSRuLL8VhvujyBxBGPbRQU93aCmU8NJ9xkoSNggqoMdCB1sHK+dhhnGDgK83I
         7xFhB8jxLq7ZN4mQks70fur8MCtaQaCQnLyJEMNw=
Date:   Fri, 21 Jun 2019 15:07:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/4] pci: Do not auto-enable PCI reallocation when _DSM
 #5 returns 0
Message-ID: <20190621200747.GD127746@google.com>
References: <20190615002359.29577-1-benh@kernel.crashing.org>
 <20190615002359.29577-3-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615002359.29577-3-benh@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  PCI: Don't auto-realloc if we're preserving firmware config

On Sat, Jun 15, 2019 at 10:23:58AM +1000, Benjamin Herrenschmidt wrote:
> This prevents auto-enabling of bridges reallocation when the FW tells
> us that the initial configuration must be preserved for a given host
> bridge.

"Prevent auto-enabling ..." to follow usual style of imperative mood in
commit logs.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/pci/setup-bus.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 0cdd5ff389de..049a5602b942 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1684,10 +1684,16 @@ static enum enable_type pci_realloc_detect(struct pci_bus *bus,
>  					   enum enable_type enable_local)
>  {
>  	bool unassigned = false;
> +	struct pci_host_bridge *hb;

Conventional variable names are "bridge" or "host".

>  	if (enable_local != undefined)
>  		return enable_local;
>  
> +	/* Don't realloc if ACPI tells us not to */

I'd drop the comment, since there might be other mechanisms, e.g., DT,
someday.

> +	hb = pci_find_host_bridge(bus);
> +	if (hb->preserve_config)
> +		return auto_disabled;
> +
>  	pci_walk_bus(bus, iov_resources_unassigned, &unassigned);
>  	if (unassigned)
>  		return auto_enabled;
> -- 
> 2.17.1
> 
