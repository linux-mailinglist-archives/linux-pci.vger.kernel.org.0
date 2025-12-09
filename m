Return-Path: <linux-pci+bounces-42831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 490B0CAF383
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 08:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21679300AFC3
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB2D27055D;
	Tue,  9 Dec 2025 07:55:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44022CBD9;
	Tue,  9 Dec 2025 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765266926; cv=none; b=M9R3I/nXAiZbJAEREtLfODnxD4/a3df29F858xis8Nr4Rg18c7KvokNBTqOy4qzjk+1IeCf7ji3Bt/rKz10WU2t6orRqj/6RmHCjk9brl7RMfyO1emhhRJuWrSzN42YsjMrOCHn/4GvKwZiNCam1e/fLKlJgbp/3yS7WMQLm7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765266926; c=relaxed/simple;
	bh=RVnjF02fjyxrSceT6UO9XusuvKhaQe+a2td0jjbaRWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5BAKOGUaFZ5dAHjpacBT6HyM4RwrhjNq8gbfF7wJnNY1JYDYBzsmjy6HoBCloI3PXk9zs30rxzwkdrDYaPvbNQSPZAKenR7fG95nJ4rnf0MkfkCb1OmTPTnURz1g/cT+/dTp364cQaqIkYq9irtV0oAXCNJyGN2JsVBLvx4O0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 7799C2C02B8E;
	Tue,  9 Dec 2025 08:45:12 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 44FE51D2C5; Tue,  9 Dec 2025 08:45:12 +0100 (CET)
Date: Tue, 9 Dec 2025 08:45:12 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Darshit Shah <darnshah@amazon.de>
Cc: Jonthan.Cameron@huawei.com, bhelgaas@google.com, darnir@gnu.org,
	feng.tang@linux.alibaba.com, kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	nh-open-source@amazon.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	Keith Busch <kbusch@kernel.org>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 1/1] drivers/pci: Decouple DPC from AER service
Message-ID: <aTfTiBy1GoJIFqtJ@wunner.de>
References: <aSnWyePbCKPvjpKq@wunner.de>
 <20251208112545.21315-1-darnshah@amazon.de>
 <20251208112545.21315-2-darnshah@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208112545.21315-2-darnshah@amazon.de>

[cc += Keith, Olaf; start of thread is here:
https://lore.kernel.org/all/20251208112545.21315-1-darnshah@amazon.de/
]

On Mon, Dec 08, 2025 at 11:25:45AM +0000, Darshit Shah wrote:
> According to [1] it is recommended that the Operating System link the

Minor stylistic issue:  We generally refer to the latest spec revision,
the reference at [1] doesn't mention the title of the Implementation Note
and personally I find it easier to read the commit message if references
are provided inline, so I'd recommend:

    According to PCIe r7.0, sec 6.2.11, "Implementation Note: Determination
    of DPC Control", it is recommended that ...

> +++ b/drivers/pci/pcie/portdrv.c
> @@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>  	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +	    (host->native_aer || pcie_ports_dpc_native))
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	/* Enable bandwidth control if more than one speed is supported. */

Somewhat tangential, I note that the pci_aer_available() check results
in DPC not being handled by Linux if pci=nomsi is specified on the
command line.  However PCIe r7.0 sec 6.2.11.1 explicitly mentions
use of INTx for DPC, suggesting that MSI support is not required.

Either case, your change looks reasonable to me, so:

Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas

