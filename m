Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87B3467B88
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382027AbhLCQkQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 11:40:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49192 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhLCQkP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 11:40:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85C8362C27
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 16:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3260C53FCD;
        Fri,  3 Dec 2021 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638549411;
        bh=FnKY7zwY29SynQoTMhar9z9ddGBRTPm9WLwkqGGh7Ls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=A9AzCcBKM584B3fDa1CcH6vgn25J/A9Y9LhgerUlW9Ek0kQ8aNaaOk5oJpJRxGBUQ
         yNZxDdKKhBEa6w/5m4Opv+IAkgUmUMeMyJgL4511At9rV4AVWpKU5735+uh6CTqmE6
         9y1DiAD49oUY/BPXE7b0jzfyCIZmhk+IMdVfSrWmHhS8Ot+PnYQUKzZTEw6ud8wJNG
         arTHyPjTDVSxcyeZ8ThYcZ0ZI1i22KpryZFcgWIHta+JMVJ1BMg4j4QpqzhETodEOi
         l8VmjSbZpzfjzBkSoZMioyUoJhSby9hNYeKXeHn38u7y1+yz/6F/6mvcYeUcbXzjX8
         iHWzyT78sCutQ==
Date:   Fri, 3 Dec 2021 10:36:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 01/11] PCI: pci-bridge-emul: Add description for
 class_revision field
Message-ID: <20211203163649.GA3004204@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211130172913.9727-2-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 06:29:03PM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> The current assignment to the class_revision member
> 
>   class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
> 
> can make the reader think that class is at high 16 bits of the member and
> revision at low 16 bits.
> 
> In reality, class is at high 24 bits, but the class for PCI Bridge Normal
> Decode is PCI_CLASS_BRIDGE_PCI << 8.
> 
> Change the assignment and add a comment to make this clearer.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/pci/pci-bridge-emul.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index db97cddfc85e..a4af1a533d71 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -265,7 +265,11 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
>  {
>  	BUILD_BUG_ON(sizeof(bridge->conf) != PCI_BRIDGE_CONF_END);
>  
> -	bridge->conf.class_revision |= cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
> +	/*
> +	 * class_revision: Class is high 24 bits and revision is low 8 bit of this member,
> +	 * while class for PCI Bridge Normal Decode has the 24-bit value: PCI_CLASS_BRIDGE_PCI << 8
> +	 */

Can you please re-wrap this comment so it fits in 80 columns like the
rest of the file?

I'd do something with the assignment, too.  It's hard to read when it
wraps, especially since at 80 columns it splits the "<<" in half.

I assume from the commit log that this is purely a readability change,
not a fix, right?

> +	bridge->conf.class_revision |= cpu_to_le32((PCI_CLASS_BRIDGE_PCI << 8) << 8);
>  	bridge->conf.header_type = PCI_HEADER_TYPE_BRIDGE;
>  	bridge->conf.cache_line_size = 0x10;
>  	bridge->conf.status = cpu_to_le16(PCI_STATUS_CAP_LIST);
> -- 
> 2.32.0
> 
