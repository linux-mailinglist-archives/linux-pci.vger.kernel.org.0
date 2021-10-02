Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A25A41FCF1
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhJBQHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 12:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhJBQHQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Oct 2021 12:07:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0823A61B20;
        Sat,  2 Oct 2021 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633190730;
        bh=0e21ahfOw7r9mIE1wd2YEhuy9T9s5lMvl3ukZGlKlIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C2lMaDbRMp4ezW0He9nWcaSKuFIEL+PgcCu4VSxfCy1eKDQNM2oQ3YQEHlks+ci3+
         h8FeVwPBTkHBH4Y7/wrPKsv7FolviFsOu+J3cgcXhAeuUDPwlfyDR1zGxd+IpjeYaa
         P6C1rLbqHyqrLRWTeOLNJZAkf24FLoHr7HRQrygLhiBiknia5SlxdU/akZRVOFqP7B
         QoJetbvYxflJAOFPfvPiTu1Sk7kJTBKyJOktv++SnYi0KJPIdjEwr65YpehuYICVhi
         hASLI/28Qrnc7h2bmRschC5RjOnAJVQCneaEYYe3Sm9/zZxBHSOUiHwQEGk/lkgQoA
         8MUXRDSX4/Weg==
Date:   Sat, 2 Oct 2021 11:05:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 01/13] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Message-ID: <20211002160528.GA971430@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211001195856.10081-2-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 09:58:44PM +0200, Marek Beh�n wrote:
> From: Pali Roh�r <pali@kernel.org>
> 
> Define a macro PCI_EXP_DEVCTL_PAYLOAD_* for every possible Max Payload
> Size in linux/pci_regs.h, in the same style as PCI_EXP_DEVCTL_READRQ_*.
> 
> Signed-off-by: Pali Roh�r <pali@kernel.org>
> Reviewed-by: Marek Beh�n <kabel@kernel.org>
> Signed-off-by: Marek Beh�n <kabel@kernel.org>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/uapi/linux/pci_regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e709ae8235e7..ff6ccbc6efe9 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -504,6 +504,12 @@
>  #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
>  #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
>  #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_128B 0x0000 /* 128 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_256B 0x0020 /* 256 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_512B 0x0040 /* 512 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00a0 /* 4096 Bytes */
>  #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
>  #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
>  #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
> -- 
> 2.32.0
> 
