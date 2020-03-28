Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9018419685F
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 19:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgC1SXH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 14:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgC1SXG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 14:23:06 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91AE20714;
        Sat, 28 Mar 2020 18:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585419786;
        bh=8KVtWbHfRZ3opBauij0EWHKvBbnIHSNho1ulpgXw6M8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qzaTJUy+rNxzgBPuakNTSMQtPAJjFBbHhP13EcWT6xaGQSfJLPmlxHY+UlnEPHHq6
         soky3StB8Zs+LpF1SnINOaesn0imUUSVkko+E1QSKrw6SrxOIVdVe48QUvm+UarsNe
         avXffE+boyvhRhedk58xRefuBGgSBKpHK6MjFAME=
Date:   Sat, 28 Mar 2020 13:23:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/edr 4/10] drivers/pci/pcie/err.c:168:28: error: use of
 undeclared identifier 'service'
Message-ID: <20200328182304.GA70832@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003290223.P0IbgBYa%lkp@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 29, 2020 at 02:09:30AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/edr
> head:   3a4c9f97543f0dbf580dd3646164e829ba08e600
> commit: d9dbf5828770b236fcae3cc866d844fe360174d0 [4/10] PCI/ERR: Remove service dependency in pcie_do_recovery()
> config: x86_64-defconfig (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 0fca766458da04bbc6d33b3f9ecd57e615c556c1)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout d9dbf5828770b236fcae3cc866d844fe360174d0
>         # save the attached .config to linux build tree
>         COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/pci/pcie/err.c:168:28: error: use of undeclared identifier 'service'
>                    status = reset_link(dev, service);

My merge error, sorry.  This is on a test branch (pci/edr), not in my
-next branch yet.

>                                             ^
>    1 error generated.
> 
> vim +/service +168 drivers/pci/pcie/err.c
> 
> 2e28bc84cf6eec Oza Pawandeep              2018-05-17  148  
> d9dbf5828770b2 Kuppuswamy Sathyanarayanan 2020-03-23  149  void pcie_do_recovery(struct pci_dev *dev,
> d9dbf5828770b2 Kuppuswamy Sathyanarayanan 2020-03-23  150  		      enum pci_channel_state state,
> d9dbf5828770b2 Kuppuswamy Sathyanarayanan 2020-03-23  151  		      pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> 2e28bc84cf6eec Oza Pawandeep              2018-05-17  152  {
> 542aeb9c8f930e Keith Busch                2018-09-20  153  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> 542aeb9c8f930e Keith Busch                2018-09-20  154  	struct pci_bus *bus;
> 2e28bc84cf6eec Oza Pawandeep              2018-05-17  155  
> bfcb79fca19d26 Keith Busch                2018-09-20  156  	/*
> bfcb79fca19d26 Keith Busch                2018-09-20  157  	 * Error recovery runs on all subordinates of the first downstream port.
> bfcb79fca19d26 Keith Busch                2018-09-20  158  	 * If the downstream port detected the error, it is cleared at the end.
> bfcb79fca19d26 Keith Busch                2018-09-20  159  	 */
> bfcb79fca19d26 Keith Busch                2018-09-20  160  	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> bfcb79fca19d26 Keith Busch                2018-09-20  161  	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> bfcb79fca19d26 Keith Busch                2018-09-20  162  		dev = dev->bus->self;
> 542aeb9c8f930e Keith Busch                2018-09-20  163  	bus = dev->subordinate;
> bfcb79fca19d26 Keith Busch                2018-09-20  164  
> 542aeb9c8f930e Keith Busch                2018-09-20  165  	pci_dbg(dev, "broadcast error_detected message\n");
> b5dfbeacf74865 Kuppuswamy Sathyanarayanan 2020-03-27  166  	if (state == pci_channel_io_frozen) {
> 542aeb9c8f930e Keith Busch                2018-09-20  167  		pci_walk_bus(bus, report_frozen_detected, &status);
> 6d2c89441571ea Kuppuswamy Sathyanarayanan 2020-03-23 @168  		status = reset_link(dev, service);
> 
> :::::: The code at line 168 was first introduced by commit
> :::::: 6d2c89441571ea534d6240f7724f518936c44f8d PCI/ERR: Update error status after reset_link()
> 
> :::::: TO: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> :::::: CC: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


