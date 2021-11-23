Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58845A721
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 17:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbhKWQIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 11:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237505AbhKWQIl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 11:08:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C24A60F5D;
        Tue, 23 Nov 2021 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637683533;
        bh=kcHpi8ivx7eLkLHxbekvu3Gh077UkkQwxsDTgos8HUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TaDZKgozPNL84cJyUE4n++h980RZMACP4l02SYu0edzo0d/SwgbFzUGEbUO1mmpWH
         ZyGSmCYZL9WROf5z1UCe4G8jrP52fFmoTuihbmpl0q6yYZ1PRMJonAHVxfxOqEmnMB
         +E2I1ilevmd3IN0uxPikDFuS6znSg0DcFMKR/2BRyZ8vL25JKabA3vhJFt3lP/qGKU
         tcqK+IgK+XGAgbllYyPgPm7Zyor7iwZ1xbhoafW1i1Cov3I9rTgBJ2HuwQY/6fg2ZY
         0Y9ckVkIamyPF/7cvljlyWkiUdFczldkVGa9fKNhd3OlvWuGaG7y8kvNKFfepIcieR
         NDzCR7yaALARQ==
Date:   Tue, 23 Nov 2021 10:05:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fan Fei <ffclaire1224@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove device * in struct
Message-ID: <20211123160531.GA2225123@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637533108.git.ffclaire1224@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 23, 2021 at 04:38:34PM +0100, Fan Fei wrote:
> Remove "device *" in structs that refer struct dw_pcie or cdns_pcie. 
> Because these two struct contain a "struct device *" already.
> 
> Fan Fei (4):
>   PCI: j721e: Remove cast of void* type
>   PCI: tegra194: Remove device * in struct
>   PCI: al: Remove device * in struct
>   PCI: j721e: Remove device * in struct
> 
>  drivers/pci/controller/cadence/pci-j721e.c |  14 ++-
>  drivers/pci/controller/dwc/pcie-al.c       |  10 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c | 109 +++++++++++----------
>  3 files changed, 69 insertions(+), 64 deletions(-)

Your "Prefer of_device_get_match_data()" series applies cleanly on my
"main" branch.

But this series doesn't apply cleanly on "main" (v5.16-rc1) or on top
of the "Prefer of_device_get_match_data()" series.

Can you rebase to apply on v5.16-rc1 or, if there are conflicts with
the previous series, on top of that previous series?

Bjorn
