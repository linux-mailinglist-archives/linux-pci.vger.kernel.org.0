Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820C2375D54
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 01:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhEFXLK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 19:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhEFXLJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 19:11:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC94E6105A;
        Thu,  6 May 2021 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620342611;
        bh=pGwapwfIwZOhQarw96L9tvVjL5uL4dSL5MqgEDL7QV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VS40+lW6QNMPALXuZKJZKkfsBtDahDjCHJwNqZN03r9k6KqwKZ+xuvARenFSzbPD8
         2le/gXGEBrCurSqiQzGSplBT9ZoiQREwp5u3HXehJ0GBFE1lLn24VZe99Psx4F+2GL
         po33WChdPWTjY/tASJDhYyGILjoJwgIB9THQNwwuqkUdEsCjBfaHy3VXj23jzua583
         uLeOaFRu5Mx0UauIOmXTJ1NruJe+dHW1rE9hvbtR6/Wf5dOrFfbFIK7bhrjdyEt1Gx
         W3WkzxrhPqbagLj2WtWXEepVAGVp3VIhaqWfHMEI1COk4Bryru5O0REmMKmCBbtYMW
         DEyf4K3ARYSlQ==
Date:   Thu, 6 May 2021 18:10:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/42] PCI: pci-bridge-emul: Add PCIe Root Capabilities
 Register
Message-ID: <20210506231009.GA1444269@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506153153.30454-6-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 06, 2021 at 05:31:16PM +0200, Pali Rohár wrote:
> This is 16-bit register at offset 0x1E. Rename current 'rsvd' struct member
> to 'rootcap'.

"The 16-bit Root Capabilities register is at offset 0x1e in the PCIe
Capability."

Please make the commit log complete in itself.  In some contexts, the
subject line is not visible at the same time.  It's fine to repeat the
subject in the commit log.

> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Fixes: 23a5fba4d941 ("PCI: Introduce PCI bridge emulated config space common logic")
> Cc: stable@vger.kernel.org # e0d9d30b7354 ("PCI: pci-bridge-emul: Fix big-endian support")

I'm not sure how people would deal with *two* SHA1s.

This patch adds functionality, so it's not really fixing a bug in
23a5fba4d941.  I see that e0d9d30b7354 came along later and did
"s/u16 rsvd/__le16 rsvd/".

But it seems like a lot to expect for distros and stable kernel
maintainers to interpret this.

Personally I think I would omit both Fixes: and the stable tag since
these two patches (05 and 06) are just adding functionality.

> ---
>  drivers/pci/pci-bridge-emul.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
> index b31883022a8e..49bbd37ee318 100644
> --- a/drivers/pci/pci-bridge-emul.h
> +++ b/drivers/pci/pci-bridge-emul.h
> @@ -54,7 +54,7 @@ struct pci_bridge_emul_pcie_conf {
>  	__le16 slotctl;
>  	__le16 slotsta;
>  	__le16 rootctl;
> -	__le16 rsvd;
> +	__le16 rootcap;
>  	__le32 rootsta;
>  	__le32 devcap2;
>  	__le16 devctl2;
> -- 
> 2.20.1
> 
