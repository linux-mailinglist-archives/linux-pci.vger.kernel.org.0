Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B237AAF4
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhEKPmj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 11:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:40000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhEKPmj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 May 2021 11:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E16E60C3D;
        Tue, 11 May 2021 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620747692;
        bh=/EPbcYfji1lEHhTEH1Bcafubtr2dJNCMyzbjwXE3Z9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T+KUSYpr/3SdAc4eDxgD611IL580M2UtrGzNDnTe6NbJCFTwAvnRtUA6Jhn/jT3V9
         nw6XL9xkdvxmpKFM0G68+NLNkCcYdIuEQsqjXCPSO7YeQunEAI/1BMYd4nL1Kzxvzs
         VPvRSKDLTDpiU7lyxVXhfDPHEzsy3WHaavoacIXI8N3UXQDeuOGrj6/gQsqeA8uyyi
         s2CrOFVYAB436oaRrL/NgCecY6rXQGFK/l+QQGUJ9s9G1DXV2m2RIvMxuF9SzCqPry
         FofHJ5tzf/s+6dr4OKgbZIVOsL7EBzbHLg7lRQrrcnEjwzIMD2HgwWdMCAjpOondyp
         tkKlyJG/JHQGQ==
Date:   Tue, 11 May 2021 10:41:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] MAINTAINERS: Add Krzysztof as PCI host/endpoint
 controllers reviewer
Message-ID: <20210511154130.GA2379240@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210511150003.1592-1-lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 11, 2021 at 04:00:03PM +0100, Lorenzo Pieralisi wrote:
> Krzysztof has been carrying out PCI patches review for a long time and
> he has been instrumental in driving PCI host/endpoint controller drivers
> improvements.
> 
> Make his role official.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Krzysztof Wilczyński <kw@linux.com>

Great, thanks for all your work, Krzysztof!

Love how your subject contains all the relevant information,
Lorenzo :)

Applied to for-linus for v5.13, thanks!

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f..9755bf97658d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14110,6 +14110,7 @@ F:	drivers/pci/controller/pci-v3-semi.c
>  PCI ENDPOINT SUBSYSTEM
>  M:	Kishon Vijay Abraham I <kishon@ti.com>
>  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +R:	Krzysztof Wilczyński <kw@linux.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/endpoint/*
> @@ -14158,6 +14159,7 @@ F:	drivers/pci/controller/pci-xgene-msi.c
>  PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
>  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>  R:	Rob Herring <robh@kernel.org>
> +R:	Krzysztof Wilczyński <kw@linux.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
> -- 
> 2.26.1
> 
