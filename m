Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506C3425D3A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 22:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhJGU3d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 16:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233343AbhJGU3c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 16:29:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8718D6103B;
        Thu,  7 Oct 2021 20:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633638458;
        bh=pJi40OGK3MkHOENwvfDUfya08Gu+S7hACOu/Sbximq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JZ6/vUvg6nj57OfAP312vFHJIgtLc1DRkaWq0Q3WnGV+EtYU9B7fRxRM3WmvUF01U
         9skzxha+SqWQmNq1hzr0kfbDlcvu0ktz4MoPs0DGBOOUt7CX+EB/vJEb7x4B41xK6a
         kiJveskpVJaG1v13leiC0ezaqcSHkO4XG5aQt1U1XtmUGEL6NT6YKBQKqjTpCpTlet
         ovc9pYUas1sMT2/RfHMneI+QpJEP1r8kTtH8WrUNLwv6dk8F82axjFv9Ed1blCUuks
         LjAoYJjp8mDFQKaFD6p9fytyO0qBjlGf3E7cbIL4y7oak//amMenKMrG8tW4Ve5A9F
         YGQrokJj+hivg==
Date:   Thu, 7 Oct 2021 15:27:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suneel Garapati <sgarapati@marvell.com>,
        Chandrakala Chavva <cchavva@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-RFC] drivers: pci: pcieport: Allow AER service only on
 root ports
Message-ID: <20211007202737.GA1263785@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007194409.3641467-1-danielwa@cisco.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please note "git log --oneline drivers/pci/pcie/portdrv_core.c" and
make your patch follow the style.

On Thu, Oct 07, 2021 at 12:44:09PM -0700, Daniel Walker wrote:
> From: Suneel Garapati <sgarapati@marvell.com>
> 
> Some AER interrupt capability registers may not be present on
> non Root ports. Since there is no way to check presence of
> ROOT_ERR_COMMAND and ROOT_ERR_STATUS registers. Allow AER
> service only on root ports.
> Otherwise AER interrupt message number is read incorrectly
> causing MSIX vector registration to fail and fallback to legacy
> unnecessarily.

Wrap to fill 75 columns.

Add blank lines between paragraphs.

Use complete sentences ("Since there is ..." is not a sentence).

Capitalize consistently ("Root ports" vs "root ports").

Use register names I can find in the spec or with grep
("ROOT_ERR_COMMAND" and "ROOT_ERR_STATUS" do not appear in the
source).

s/MSIX/MSI-X/ to match spec usage.

Also applies to code comment below.

> Signed-off-by: Suneel Garapati <sgarapati@marvell.com>

Needs to include your (Daniel's) Signed-off-by; see:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.14#n365

> Reviewed-by: Chandrakala Chavva <cchavva@marvell.com>
> Reviewed-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 3ee63968deaa..edc355971a32 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -221,7 +221,16 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> +	/*
> +	 * Some AER interrupt capability registers may not be present on
> +	 * non Root ports. Since there is no way to check presence of
> +	 * ROOT_ERR_COMMAND and ROOT_ERR_STATUS registers. Allow AER
> +	 * service only on root ports. Refer PCIe rev5.0 spec v1.0 7.8.4.

Sec 7.8.4 talks about Root Ports and Root Complex Event Collectors
together, so I would think you would treat them the same here.

> +	 * Otherwise AER interrupt message number is read incorrectly
> +	 * causing MSIX vector registration to fail and fallback to legacy.
> +	 */
>  	if (dev->aer_cap && pci_aer_available() &&
> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>  	    (pcie_ports_native || host->native_aer)) {
>  		services |= PCIE_PORT_SERVICE_AER;
>  
> -- 
> 2.25.1
> 
