Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51C5491241
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 00:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbiAQXRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 18:17:41 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57868 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiAQXRk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 18:17:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1621FB810CE;
        Mon, 17 Jan 2022 23:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51069C36AE7;
        Mon, 17 Jan 2022 23:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642461457;
        bh=/H4hodNYNQX3IviAGezs1hAY921lAVGOrr7Ddgmplvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ia/UvUI844gw+WPfwhpJ6CQYqC3Io+w357Z+aGKwEsO1sO8ICYc/ENa5nKvN4o2oN
         BKj58XNTesbzhY5wein2705/CG/tTJU/xv/5yvvaY34MCqjfQe19ubqEthQho8Pehy
         id0x+GZtfWNnAE7taY4Ezoq256Sh2ElZaGHI+GLWAJpZdMun5QDEJWL+3KTDSYWBl1
         SfTMZm9mqqZr53WWoSw9yAujDqEi+P/3WPo+Nl+LTyULpCIPCDvEWKHCMOCzg3JL1Y
         2Y3gt4LF17SICawmHmm12LXg8EIxriCiWKPK61Z+b2Z1HnfKp/1aG4JT57ygcrEv2q
         nTDv54d+coBKA==
Date:   Mon, 17 Jan 2022 17:17:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: imx: disable reglator when imx6_pcie_probe fails
Message-ID: <20220117231735.GA813924@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117102137.3513439-1-xiaolei.wang@windriver.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 17, 2022 at 06:21:37PM +0800, Xiaolei Wang wrote:
> From: wrsadmin <wrsadmin@pek-xwang8-d1.corp.ad.wrs.com>

I got two copies of this.  This one changed:

  - Signed-off-by: wrsadmin <wrsadmin@pek-xwang8-d1.corp.ad.wrs.com>
  + Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

This looks like a good change.  You should also change the
"From: wrsadmin" line above because that is what "git am" uses in the
commit:

  commit 119fdfb8fb1b ("pci: imx: disable reglator when imx6_pcie_probe fails")
  Author: wrsadmin <wrsadmin@pek-xwang8-d1.corp.ad.wrs.com>
  Date:   Mon Jan 17 18:17:35 2022 +0800

Also, please run "git log --oneline drivers/pci/controller/dwc/pci-imx6.c"
and make your subject line match in capitalization and style.

Also, fix the "s/reglator/regulator" typo in subject and below and add
"()" after the imx6_pcie_probe() function name.

If you include a calltrace, remove timestamps and other non-relevant
stuff from it and indent quoted material two spaces.  But in this
case, I don't think the calltrace is useful.

The reason to do this is not to avoid a warning and the related
calltrace.  The reason is to fix the problem that *caused* the warning
in the first place.  So we should describe the underlying problem and
the fix.

> disable reglator when imx6_pcie_probe fails,
> otherwise the following calltrace will appear
> 
> [ 3.785075] ------------[ cut here ]------------
> [ 3.788142] Registering SWP/SWPB emulation handler
> [ 3.789853] WARNING: CPU: 0 PID: 7 at drivers/regulator/core.c:2257 _regulator_put.part.0+0x1bc/0x1e0
> [ 3.795680] Loading compiled-in X.509 certificates
> [ 3.803947] Modules linked in:
> [ 3.811922] CPU: 0 PID: 7 Comm: kworker/u8:0 Not tainted 5.16.0-10645-g3c750c7b6143-dirty #9
> [ 3.820393] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [ 3.826945] Workqueue: events_unbound async_run_entry_fn
> [ 3.832304] unwind_backtrace from show_stack+0x10/0x14
> [ 3.837569] show_stack from dump_stack_lvl+0x58/0x70
> [ 3.842663] dump_stack_lvl from __warn+0xd8/0x114
> [ 3.847493] __warn from warn_slowpath_fmt+0x5c/0xc4
> [ 3.852490] warn_slowpath_fmt from _regulator_put.part.0+0x1bc/0x1e0
> [ 3.858968] _regulator_put.part.0 from regulator_put+0x2c/0x3c
> [ 3.864918] regulator_put from release_nodes+0x50/0x178
> [ 3.870270] release_nodes from devres_release_all+0x80/0xd0
> [ 3.875968] devres_release_all from really_probe+0xdc/0x30c
> [ 3.881661] really_probe from __driver_probe_device+0x80/0xe4
> [ 3.887522] __driver_probe_device from driver_probe_device+0x30/0xd4
> [ 3.893991] driver_probe_device from __driver_attach_async_helper+0x20/0x38
> [ 3.901068] __driver_attach_async_helper from async_run_entry_fn+0x20/0xb4
> [ 3.908059] async_run_entry_fn from process_one_work+0x298/0x7d0
> [ 3.914188] process_one_work from worker_thread+0x30/0x510
> [ 3.919792] worker_thread from kthread+0x128/0x14c
> [ 3.924705] kthread from ret_from_fork+0x14/0x38
> [ 3.929443] Exception stack(0xc20cbfb0 to 0xc20cbff8)
> [ 3.934521] bfa0: 00000000 00000000 00000000 00000000
> [ 3.942722] bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [ 3.950922] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [ 3.957677] irq event stamp: 1207
> [ 3.961024] hardirqs last enabled at (1215): [<c0198270>] __up_console_sem+0x50/0x60
> [ 3.968974] hardirqs last disabled at (1224): [<c019825c>] __up_console_sem+0x3c/0x60
> [ 3.976911] softirqs last enabled at (1206): [<c010150c>] __do_softirq+0x2ec/0x5a4
> [ 3.984669] softirqs last disabled at (1197): [<c012ef08>] irq_exit+0x18c/0x20c
> [ 3.992021] ---[ end trace 45a52c023bf8fb33 ]---
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6974bd5aa116..f8279a15463b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1216,7 +1216,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  
>  	ret = dw_pcie_host_init(&pci->pp);
>  	if (ret < 0)
> -		return ret;
> +		goto err_vpcie;
>  
>  	if (pci_msi_enabled()) {
>  		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> @@ -1226,6 +1226,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	return 0;
> +
> +err_vpcie:
> +	regulator_disable(imx6_pcie->vpcie);

I don't know the regulator code and I couldn't figure out how
devm_regulator_get_optional() works because it passes OPTIONAL_GET in
to _devm_regulator_get(), but nothing ever checks for that, and I
couldn't be bothered to figure out what magic makes it work.

But regulator_disable() definitely dereferences its argument, and I'm
pretty sure it's possible to get here with "imx6_pcie->vpcie == NULL".

Also, it looks like the same situation with imx6_pcie->vph, so why
don't you clean that one up, too?

> +	return ret;
>  }
>  
>  static void imx6_pcie_shutdown(struct platform_device *pdev)
> -- 
> 2.25.1
> 
