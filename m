Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493353D474B
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 13:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGXKeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jul 2021 06:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhGXKeC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 24 Jul 2021 06:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6265160BD3;
        Sat, 24 Jul 2021 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627125274;
        bh=HyvcDyeDxtILEinI/b0l+BtcGGQCTrMgGW5qMF7qAfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gs3tAakSvwFUbaZk6VH3a4EGR7TCnUDFX6QrLd+X7IpvSwupxqbixhDmvZDIPQr+c
         V81ZJ/cD8i80PB6s8wYMN3Kff1SdPNzduSrOsjAjH2NrxEEuUCjAzPfCVlaXkLaq5c
         rer9WTIQlUCN0JmiXGX9PyKQbPjME9BACbPIasI5GmNfd/LK3XYDIr+Slthz5v45D9
         ntfAstGbA+ygR7BCywQr804mXnl9tbDda3ta4fuuqqWOsqW+tnvva0WPMHA+qW020m
         nZ/cwhvr377CZwqiTd0nG1cOkL48K8M6xIL1cDegWKxrqdOrubJdqV47SBXUcdV7Ba
         jsm91fsWXl4tA==
Received: by pali.im (Postfix)
        id AC301EDF; Sat, 24 Jul 2021 13:14:31 +0200 (CEST)
Date:   Sat, 24 Jul 2021 13:14:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        =?utf-8?B?UsO2dHRp?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>,
        Zachary Zhang <zhangzg@marvell.com>
Subject: Re: [PATCH 2/2] PCI: Add Max Payload Size quirk for ASMedia ASM1062
 SATA controller
Message-ID: <20210724111431.wlr7uf6ymhe7gi6u@pali>
References: <20210624171418.27194-1-kabel@kernel.org>
 <20210624171418.27194-2-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210624171418.27194-2-kabel@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 24 June 2021 19:14:18 Marek Behún wrote:
> The ASMedia ASM1062 SATA controller advertises
> Max_Payload_Size_Supported of 512, but in fact it cannot handle TLPs
> with payload size of 512.
> 
> We discovered this issue on PCIe controllers capable of MPS = 512
> (Aardvark and DesignWare), where the issue presents itself as an
> External Abort. Bjorn Helgaas says:
>   Probably ASM1062 reports a Malformed TLP error when it receives a data
>   payload of 512 bytes, and Aardvark, DesignWare, etc convert this to an
>   arm64 External Abort.
> 
> Limiting Max Payload Size to 256 bytes solves this problem.

Hello Bjorn! Is there anything else needed for merging this patch?

> Signed-off-by: Marek Behún <kabel@kernel.org>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=212695
> Reported-by: Rötti <espressobinboardarmbiantempmailaddress@posteo.de>
> Cc: Pali Rohár <pali@kernel.org>

Reviewed-by: Pali Rohár <pali@kernel.org>

> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4d9b9d8fbc43..a4ba3e3b3c5e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3239,6 +3239,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLARFLARE,
>  			PCI_DEVICE_ID_SOLARFLARE_SFC4000A_1, fixup_mpss_256);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SOLARFLARE,
>  			PCI_DEVICE_ID_SOLARFLARE_SFC4000B, fixup_mpss_256);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ASMEDIA, 0x0612, fixup_mpss_256);
>  
>  /*
>   * Intel 5000 and 5100 Memory controllers have an erratum with read completion
> -- 
> 2.31.1
> 
