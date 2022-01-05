Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C54859D1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 21:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbiAEUMc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 15:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbiAEUMb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 15:12:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80249C061245;
        Wed,  5 Jan 2022 12:12:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F837B81DAA;
        Wed,  5 Jan 2022 20:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3BEC36AE0;
        Wed,  5 Jan 2022 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641413548;
        bh=aoT7jaRko+6ZGLXRm+aXf3D/to9iVhBzT5qX2rl90Ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U01p7xAKIWH5sQG9+hCQuJf9tTjh8wjX3EBhSkvrzUqDUUG75BstHi9HzCzBFhSdi
         QhMHGH/srOcsUTUMMxlFiQHtbIzN3Jlc0um1wtgAnRKLim7rIAhCBgtc6We+w5y78J
         LMxBTysLSz8r7+Ug+QhiCYyp3YSvMG8wc9M3PK+tpF1yEhMuVKouBjg1jC5luASCsK
         VTcAxu+TtSTluAH69ZnLVUFx4rnEnEU97a5nZlsq2/12F/9uyoJOdO+dTcFwM+GigK
         br5BJWpDn2R85xCbtvcA33idFhcH2DzSAmV81fbz43QPK9N1jIYvCrvsegW4ZnIHER
         uMByyRs80SKTQ==
Date:   Wed, 5 Jan 2022 14:12:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Lukas Wunner <lukas@wunner.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/portdrv: Skip enabling AER on external facing ports
Message-ID: <20220105201226.GA218998@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105060643.822111-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 05, 2022 at 02:06:41PM +0800, Kai-Heng Feng wrote:
> The Thunderbolt root ports may constantly spew out uncorrected errors
> from AER service:
> [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed

No timestamps needed here; they don't add to understanding the
problem.

> The link may not be reliable on external facing ports, so don't enable
> AER on those ports.

I'm not sure what you want to accomplish here.  If the errors are
legitimate and the result of some hardware issue like a bad cable, why
should we ignore them?  If they're caused by a software problem, we
should figure that out and fix it.

Does this occur on a specific instance of possibly flaky hardware?

You mention a spew of errors; do you think this is a single error that
we fail to clear correctly?  Or is it really many separate errors?

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/portdrv_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index bda630889f955..d464d00ade8f2 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -219,7 +219,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>  
>  #ifdef CONFIG_PCIEAER
>  	if (dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer)) {
> +	    (pcie_ports_native || host->native_aer) &&
> +	    !dev->external_facing) {
>  		services |= PCIE_PORT_SERVICE_AER;
>  
>  		/*
> -- 
> 2.33.1
> 
