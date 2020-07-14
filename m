Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF9821FADD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 20:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgGNS40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 14:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgGNS4Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Jul 2020 14:56:25 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D38622AAB;
        Tue, 14 Jul 2020 18:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752984;
        bh=1I0jIPo3SZCaMFdDVykFs1GKYtGMomQMM+VqNQstfJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dgtA8cR+j01hdstpLlBLDb9TdhIStnYKNavj+wqqyuH3EJj3686EnGrrwRI1wqa/r
         VF70QJU9tQG0jSn0ew7XrdV2+Cb8SD31SbqLEBYFUL8biYPtSXwG+4PgmUoM3ylMSb
         vmT5ApqX+4CqbX3W0qBvhlg/FhjdDjRDJLE/SOoA=
Date:   Tue, 14 Jul 2020 13:56:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Edward Cree <ecree@solarflare.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     kbuild-all@lists.01.org, linux-renesas-soc@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [renesas-drivers:master 69/80]
 drivers/net/ethernet/sfc/efx_common.c:1232:19: sparse: sparse: incompatible
 types for operation (==):
Message-ID: <20200714185622.GA408711@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007150206.kfukZxuy%lkp@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Luc, linux-pci]

On Wed, Jul 15, 2020 at 02:02:11AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git master
> head:   541708cc1e6ad29fdb4c294831dfa855bd64487b
> commit: 428d2a440d43ba81b698ec71de5125e4aeddf752 [69/80] Merge remote-tracking branch 'pci/next' into renesas-drivers
> config: parisc-randconfig-s031-20200714 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-41-g14e84ffc-dirty
>         git checkout 428d2a440d43ba81b698ec71de5125e4aeddf752
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=parisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/net/ethernet/sfc/efx_common.c:1232:19: sparse: sparse: incompatible types for operation (==):
> >> drivers/net/ethernet/sfc/efx_common.c:1232:19: sparse:    incomplete type enum pci_channel_state state
> >> drivers/net/ethernet/sfc/efx_common.c:1232:19: sparse:    restricted pci_channel_state_t
> >> drivers/net/ethernet/sfc/efx_common.c:1308:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different base types)) @@     expected restricted pci_ers_result_t ( *error_detected )( ... ) @@     got restricted pci_ers_result_t ( * )( ... ) @@
> >> drivers/net/ethernet/sfc/efx_common.c:1308:27: sparse:     expected restricted pci_ers_result_t ( *error_detected )( ... )
> >> drivers/net/ethernet/sfc/efx_common.c:1308:27: sparse:     got restricted pci_ers_result_t ( * )( ... )

I think what's necessary here is to replace "enum pci_channel_state
state" with "pci_channel_state_t state", as in 16d79cd4e23b ("PCI: Use
'pci_channel_state_t' instead of 'enum pci_channel_state'"):

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=16d79cd4e23b

This change should be safe even without 16d79cd4e23b, so there won't
be a revlock if you make it in the renesas-drivers tree.

> vim +1232 drivers/net/ethernet/sfc/efx_common.c
> 
> 21ea21252eddb3c Edward Cree 2020-06-29  1221  
> 21ea21252eddb3c Edward Cree 2020-06-29  1222  /* A PCI error affecting this device was detected.
> 21ea21252eddb3c Edward Cree 2020-06-29  1223   * At this point MMIO and DMA may be disabled.
> 21ea21252eddb3c Edward Cree 2020-06-29  1224   * Stop the software path and request a slot reset.
> 21ea21252eddb3c Edward Cree 2020-06-29  1225   */
> 21ea21252eddb3c Edward Cree 2020-06-29  1226  static pci_ers_result_t efx_io_error_detected(struct pci_dev *pdev,
> 21ea21252eddb3c Edward Cree 2020-06-29  1227  					      enum pci_channel_state state)
> 21ea21252eddb3c Edward Cree 2020-06-29  1228  {
> 21ea21252eddb3c Edward Cree 2020-06-29  1229  	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
> 21ea21252eddb3c Edward Cree 2020-06-29  1230  	struct efx_nic *efx = pci_get_drvdata(pdev);
> 21ea21252eddb3c Edward Cree 2020-06-29  1231  
> 21ea21252eddb3c Edward Cree 2020-06-29 @1232  	if (state == pci_channel_io_perm_failure)
> 21ea21252eddb3c Edward Cree 2020-06-29  1233  		return PCI_ERS_RESULT_DISCONNECT;
> 21ea21252eddb3c Edward Cree 2020-06-29  1234  
> 21ea21252eddb3c Edward Cree 2020-06-29  1235  	rtnl_lock();
> 21ea21252eddb3c Edward Cree 2020-06-29  1236  
> 21ea21252eddb3c Edward Cree 2020-06-29  1237  	if (efx->state != STATE_DISABLED) {
> 21ea21252eddb3c Edward Cree 2020-06-29  1238  		efx->state = STATE_RECOVERY;
> 21ea21252eddb3c Edward Cree 2020-06-29  1239  		efx->reset_pending = 0;
> 21ea21252eddb3c Edward Cree 2020-06-29  1240  
> 21ea21252eddb3c Edward Cree 2020-06-29  1241  		efx_device_detach_sync(efx);
> 21ea21252eddb3c Edward Cree 2020-06-29  1242  
> 21ea21252eddb3c Edward Cree 2020-06-29  1243  		efx_stop_all(efx);
> 21ea21252eddb3c Edward Cree 2020-06-29  1244  		efx_disable_interrupts(efx);
> 21ea21252eddb3c Edward Cree 2020-06-29  1245  
> 21ea21252eddb3c Edward Cree 2020-06-29  1246  		status = PCI_ERS_RESULT_NEED_RESET;
> 21ea21252eddb3c Edward Cree 2020-06-29  1247  	} else {
> 21ea21252eddb3c Edward Cree 2020-06-29  1248  		/* If the interface is disabled we don't want to do anything
> 21ea21252eddb3c Edward Cree 2020-06-29  1249  		 * with it.
> 21ea21252eddb3c Edward Cree 2020-06-29  1250  		 */
> 21ea21252eddb3c Edward Cree 2020-06-29  1251  		status = PCI_ERS_RESULT_RECOVERED;
> 21ea21252eddb3c Edward Cree 2020-06-29  1252  	}
> 21ea21252eddb3c Edward Cree 2020-06-29  1253  
> 21ea21252eddb3c Edward Cree 2020-06-29  1254  	rtnl_unlock();
> 21ea21252eddb3c Edward Cree 2020-06-29  1255  
> 21ea21252eddb3c Edward Cree 2020-06-29  1256  	pci_disable_device(pdev);
> 21ea21252eddb3c Edward Cree 2020-06-29  1257  
> 21ea21252eddb3c Edward Cree 2020-06-29  1258  	return status;
> 21ea21252eddb3c Edward Cree 2020-06-29  1259  }
> 21ea21252eddb3c Edward Cree 2020-06-29  1260  
> 21ea21252eddb3c Edward Cree 2020-06-29  1261  /* Fake a successful reset, which will be performed later in efx_io_resume. */
> 21ea21252eddb3c Edward Cree 2020-06-29  1262  static pci_ers_result_t efx_io_slot_reset(struct pci_dev *pdev)
> 21ea21252eddb3c Edward Cree 2020-06-29  1263  {
> 21ea21252eddb3c Edward Cree 2020-06-29  1264  	struct efx_nic *efx = pci_get_drvdata(pdev);
> 21ea21252eddb3c Edward Cree 2020-06-29  1265  	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
> 21ea21252eddb3c Edward Cree 2020-06-29  1266  
> 21ea21252eddb3c Edward Cree 2020-06-29  1267  	if (pci_enable_device(pdev)) {
> 21ea21252eddb3c Edward Cree 2020-06-29  1268  		netif_err(efx, hw, efx->net_dev,
> 21ea21252eddb3c Edward Cree 2020-06-29  1269  			  "Cannot re-enable PCI device after reset.\n");
> 21ea21252eddb3c Edward Cree 2020-06-29  1270  		status =  PCI_ERS_RESULT_DISCONNECT;
> 21ea21252eddb3c Edward Cree 2020-06-29  1271  	}
> 21ea21252eddb3c Edward Cree 2020-06-29  1272  
> 21ea21252eddb3c Edward Cree 2020-06-29  1273  	return status;
> 21ea21252eddb3c Edward Cree 2020-06-29  1274  }
> 21ea21252eddb3c Edward Cree 2020-06-29  1275  
> 21ea21252eddb3c Edward Cree 2020-06-29  1276  /* Perform the actual reset and resume I/O operations. */
> 21ea21252eddb3c Edward Cree 2020-06-29  1277  static void efx_io_resume(struct pci_dev *pdev)
> 21ea21252eddb3c Edward Cree 2020-06-29  1278  {
> 21ea21252eddb3c Edward Cree 2020-06-29  1279  	struct efx_nic *efx = pci_get_drvdata(pdev);
> 21ea21252eddb3c Edward Cree 2020-06-29  1280  	int rc;
> 21ea21252eddb3c Edward Cree 2020-06-29  1281  
> 21ea21252eddb3c Edward Cree 2020-06-29  1282  	rtnl_lock();
> 21ea21252eddb3c Edward Cree 2020-06-29  1283  
> 21ea21252eddb3c Edward Cree 2020-06-29  1284  	if (efx->state == STATE_DISABLED)
> 21ea21252eddb3c Edward Cree 2020-06-29  1285  		goto out;
> 21ea21252eddb3c Edward Cree 2020-06-29  1286  
> 21ea21252eddb3c Edward Cree 2020-06-29  1287  	rc = efx_reset(efx, RESET_TYPE_ALL);
> 21ea21252eddb3c Edward Cree 2020-06-29  1288  	if (rc) {
> 21ea21252eddb3c Edward Cree 2020-06-29  1289  		netif_err(efx, hw, efx->net_dev,
> 21ea21252eddb3c Edward Cree 2020-06-29  1290  			  "efx_reset failed after PCI error (%d)\n", rc);
> 21ea21252eddb3c Edward Cree 2020-06-29  1291  	} else {
> 21ea21252eddb3c Edward Cree 2020-06-29  1292  		efx->state = STATE_READY;
> 21ea21252eddb3c Edward Cree 2020-06-29  1293  		netif_dbg(efx, hw, efx->net_dev,
> 21ea21252eddb3c Edward Cree 2020-06-29  1294  			  "Done resetting and resuming IO after PCI error.\n");
> 21ea21252eddb3c Edward Cree 2020-06-29  1295  	}
> 21ea21252eddb3c Edward Cree 2020-06-29  1296  
> 21ea21252eddb3c Edward Cree 2020-06-29  1297  out:
> 21ea21252eddb3c Edward Cree 2020-06-29  1298  	rtnl_unlock();
> 21ea21252eddb3c Edward Cree 2020-06-29  1299  }
> 21ea21252eddb3c Edward Cree 2020-06-29  1300  
> 21ea21252eddb3c Edward Cree 2020-06-29  1301  /* For simplicity and reliability, we always require a slot reset and try to
> 21ea21252eddb3c Edward Cree 2020-06-29  1302   * reset the hardware when a pci error affecting the device is detected.
> 21ea21252eddb3c Edward Cree 2020-06-29  1303   * We leave both the link_reset and mmio_enabled callback unimplemented:
> 21ea21252eddb3c Edward Cree 2020-06-29  1304   * with our request for slot reset the mmio_enabled callback will never be
> 21ea21252eddb3c Edward Cree 2020-06-29  1305   * called, and the link_reset callback is not used by AER or EEH mechanisms.
> 21ea21252eddb3c Edward Cree 2020-06-29  1306   */
> 21ea21252eddb3c Edward Cree 2020-06-29  1307  const struct pci_error_handlers efx_err_handlers = {
> 21ea21252eddb3c Edward Cree 2020-06-29 @1308  	.error_detected = efx_io_error_detected,
> 21ea21252eddb3c Edward Cree 2020-06-29  1309  	.slot_reset	= efx_io_slot_reset,
> 21ea21252eddb3c Edward Cree 2020-06-29  1310  	.resume		= efx_io_resume,
> 21ea21252eddb3c Edward Cree 2020-06-29  1311  };
> 2d73515a1ce4ef8 Edward Cree 2020-06-30  1312  
> 
> :::::: The code at line 1232 was first introduced by commit
> :::::: 21ea21252eddb3cea56845f58f87208062799bef sfc: commonise PCI error handlers
> 
> :::::: TO: Edward Cree <ecree@solarflare.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


