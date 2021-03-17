Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CBC33F855
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 19:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhCQSqm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 14:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232952AbhCQSqj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Mar 2021 14:46:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C52A264F4D;
        Wed, 17 Mar 2021 18:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616006798;
        bh=SqOpvO/RT8qOcyHuJpkdFvoUeqQTFqEG+iFgR3/0gvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpLaW1fU+sIKJR1I8JpsEbyHti3M2OEaIoWq9MkAqtNBposyG0oOHYBG/Fkwo2LTN
         jEA2qwtN32xm+6ZQdCyJJcp4siXA+y/kzjR+K9yfqYS/W79bQMv/cd2CvKwhRleSS+
         JuNZbQEdAtlvJfR972GYCmAdg8QzJtR9YlQOBVS50YMEjLzm54xGvNRCdlPYTf+oGZ
         kEx0lH6wuPVpvnyLoDwvffSvRK6MU5/sJnsNeeHCfyNWNLdstWwYES+lm01zNZ9g/D
         N86fBEkV/sCoI89itJ/WcZgmhKHwwngFiHWdLHSmEBv5UoWqLJe6/fedcLynubDaXb
         hytTxhOIk/KwA==
Received: by pali.im (Postfix)
        id 183D48A9; Wed, 17 Mar 2021 19:46:35 +0100 (CET)
Date:   Wed, 17 Mar 2021 19:46:35 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        =?utf-8?B?UsO2dHRp?= 
        <espressobinboardarmbiantempmailaddress@posteo.de>
Subject: Re: [PATCH] PCI: Add Max Payload Size quirk for ASMedia ASM1062 SATA
 controller
Message-ID: <20210317184635.7ivp5qc2hfzkmukl@pali>
References: <20210317115924.31885-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210317115924.31885-1-kabel@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 17 March 2021 12:59:24 Marek Behún wrote:
> The ASMedia ASM1062 SATA controller causes an External Abort on
> controllers which support Max Payload Size >= 512. It happens with
> Aardvark PCIe controller (tested on Turris MOX) and also with DesignWare
> controller (armada8k, tested on CN9130-CRB):
> 
>   ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>   ata1.00: ATA-9: WDC WD40EFRX-68WT0N0, 80.00A80, max UDMA/133
>   ata1.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 32), AA
>   ERROR:   Unhandled External Abort received on 0x80000000 at EL3!
>   ERROR:    exception reason=1 syndrome=0x92000210
>   PANIC at PC : 0x00000000040273bc
> 
> Limiting Max Payload Size to 256 bytes solves this problem.
> 
> On Turris MOX this problem first appeared when the pci-aardvark
> controller started using the pci-emul-bridge API, in commit 8a3ebd8de328
> ("PCI: aardvark: Implement emulated root PCI bridge config space").
> 
> On armada8k this was always a problem because it has HW root bridge.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Reported-by: Rötti <espressobinboardarmbiantempmailaddress@posteo.de>

Link to Rötti's report:
https://lore.kernel.org/linux-ide/cbbb2496501fed013ccbeba524e8d573@posteo.de/T/#u

> Cc: Pali Rohár <pali@kernel.org>

Reviewed-by: Pali Rohár <pali@kernel.org>

> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/quirks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 653660e3ba9e..a561136efb08 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3251,6 +3251,11 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOLARFLARE,
>  			 PCI_DEVICE_ID_SOLARFLARE_SFC4000A_1, fixup_mpss_256);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SOLARFLARE,
>  			 PCI_DEVICE_ID_SOLARFLARE_SFC4000B, fixup_mpss_256);
> +/*
> + * For some reason DECLARE_PCI_FIXUP_HEADER does not work with pci-aardvark
> + * controller. We have to use DECLARE_PCI_FIXUP_EARLY.
> + */
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ASMEDIA, 0x0612, fixup_mpss_256);
>  
>  /*
>   * Intel 5000 and 5100 Memory controllers have an erratum with read completion
> -- 
> 2.26.2
> 
