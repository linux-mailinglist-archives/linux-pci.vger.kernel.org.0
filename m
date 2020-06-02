Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B3B1EC03B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgFBQlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 12:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBQlL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 12:41:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE38C05BD1E;
        Tue,  2 Jun 2020 09:41:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so1721066pjb.5;
        Tue, 02 Jun 2020 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dkUX8aic7LWkaq+DlQPnbFi8QT9tEsByVD1eipCxzd4=;
        b=lz2GUi0ccDoIOpBqplTXpIOZcooPZ1CTsmPa1SmrKIv4BdpAB60wTbrjOT9VRSW702
         LQqdZyIHGXQFUMnWWuMGn1sCs5JnpnScy16C/txKAzLF6F2L1QBi5VkmJUcCdrT+eKuu
         /Z1saBnMfgd4gGjp9Gvhy45V5MHFZncrMFrdwq7UD5bY6MFrQuARtxid0TAloItyIFRW
         w7Sr4nHBrCbJ4KZVt7yi4Tz+mRjMgvA8tC1v16XKkzKtHn0n0df0STzNQuuZOKRffYGG
         ADoa9WkRMQCiJp0tNf0rxn/1Q/kN0CpIQpK7jC+w3Zucj057RS95MOELPRsVBD/UjYH4
         C0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dkUX8aic7LWkaq+DlQPnbFi8QT9tEsByVD1eipCxzd4=;
        b=BRfA3HphqAxM8JqqXk8QzL7SJ/7WD5XbqBVSgk+T9GgbqP8DjJiB5FubRtPFP0kYii
         Z5CeZul0w14586Ia0313iT3NVh0pr6/qO1+DK1LbLvPRDrG/1J7OrgLhG5v8XwutPOzY
         shwZOVf4clRodwI1XmStvvS4VbyWzOj0OlSkNajW7gQ/RDKLrVq43WuCYq8iAyA0mJQ/
         NST2NGkO0iyzLSEouso/fMJopIssfxK31Efatm1kErAuYltoUvzuOeu52g4Nkj54o0lt
         b+b1XZ2N7o3pOXR/W0mVMgenNRQK9SDZUaWfelS/sI+8PgZLs3pEQyCIU+ypxsXT+Tdr
         rD8g==
X-Gm-Message-State: AOAM533ItbU0FrWduslY+STBZnf/Z3ePw83gvzOtn4zE+viR8iTbb78S
        bjbt6E+pp01eRLJeemXcid+pMZKbSrU=
X-Google-Smtp-Source: ABdhPJxL4FNKXRux2cF3cT03h4s7Nd30BsadvZYkeOHvfFOq8nnCg9mn9HPnzFPaEy3GN8TKKcE+3w==
X-Received: by 2002:a17:90a:f198:: with SMTP id bv24mr59552pjb.206.1591116070341;
        Tue, 02 Jun 2020 09:41:10 -0700 (PDT)
Received: from localhost ([162.211.223.96])
        by smtp.gmail.com with ESMTPSA id f29sm2752960pgf.63.2020.06.02.09.41.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 09:41:09 -0700 (PDT)
Date:   Wed, 3 Jun 2020 00:41:03 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     tjoseph@cadence.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        toan@os.amperecomputing.com, ley.foon.tan@intel.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v1] PCI: controller: convert to
 devm_platform_ioremap_resource_byname()
Message-ID: <20200602164103.GB6169@nuc8i5>
References: <20200601143345.24965-1-zhengdejin5@gmail.com>
 <202006020223.1gKcICcv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006020223.1gKcICcv%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 02, 2020 at 02:13:23AM +0800, kbuild test robot wrote:
> Hi Dejin,
> 
> Thank you for the patch! Perhaps something to improve:
>
Yes, you are right, I should not modify this file drivers/pci/controller/pcie-xilinx-nwl.c.
I will sent the patch v2. Thanks very much!

BR,
Dejin

> [auto build test WARNING on pci/next]
> [also build test WARNING on tegra/for-next rockchip/for-next v5.7 next-20200529]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Dejin-Zheng/PCI-controller-convert-to-devm_platform_ioremap_resource_byname/20200601-223757
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: x86_64-allyesconfig (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 2388a096e7865c043e83ece4e26654bd3d1a20d5)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> drivers/pci/controller/pcie-xilinx-nwl.c:783:25: warning: variable 'res' is uninitialized when used here [-Wuninitialized]
> pcie->phys_breg_base = res->start;
> ^~~
> drivers/pci/controller/pcie-xilinx-nwl.c:778:22: note: initialize the variable 'res' to silence this warning
> struct resource *res;
> ^
> = NULL
> 1 warning generated.
> 
> vim +/res +783 drivers/pci/controller/pcie-xilinx-nwl.c
> 
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  773  
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  774  static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  775  			     struct platform_device *pdev)
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  776  {
> adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas       2016-10-06  777  	struct device *dev = pcie->dev;
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  778  	struct resource *res;
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  779  
> 213cf573e1a8b2 drivers/pci/controller/pcie-xilinx-nwl.c Dejin Zheng         2020-06-01  780  	pcie->breg_base = devm_platform_ioremap_resource_byname(pdev, "breg");
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  781  	if (IS_ERR(pcie->breg_base))
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  782  		return PTR_ERR(pcie->breg_base);
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06 @783  	pcie->phys_breg_base = res->start;
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  784  
> 213cf573e1a8b2 drivers/pci/controller/pcie-xilinx-nwl.c Dejin Zheng         2020-06-01  785  	pcie->pcireg_base =
> 213cf573e1a8b2 drivers/pci/controller/pcie-xilinx-nwl.c Dejin Zheng         2020-06-01  786  		devm_platform_ioremap_resource_byname(pdev, "pcireg");
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  787  	if (IS_ERR(pcie->pcireg_base))
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  788  		return PTR_ERR(pcie->pcireg_base);
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  789  	pcie->phys_pcie_reg_base = res->start;
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  790  
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  791  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> cd00f084ed1d50 drivers/pci/host/pcie-xilinx-nwl.c       Lorenzo Pieralisi   2017-04-19  792  	pcie->ecam_base = devm_pci_remap_cfg_resource(dev, res);
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  793  	if (IS_ERR(pcie->ecam_base))
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  794  		return PTR_ERR(pcie->ecam_base);
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  795  	pcie->phys_ecam_base = res->start;
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  796  
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  797  	/* Get intx IRQ number */
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  798  	pcie->irq_intx = platform_get_irq_byname(pdev, "intx");
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  799  	if (pcie->irq_intx < 0) {
> adf9e284b4f76d drivers/pci/host/pcie-xilinx-nwl.c       Bjorn Helgaas       2016-10-06  800  		dev_err(dev, "failed to get intx IRQ %d\n", pcie->irq_intx);
> 5fd4bf6a659e45 drivers/pci/host/pcie-xilinx-nwl.c       Fabio Estevam       2017-08-31  801  		return pcie->irq_intx;
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  802  	}
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  803  
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  804  	irq_set_chained_handler_and_data(pcie->irq_intx,
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  805  					 nwl_pcie_leg_handler, pcie);
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  806  
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  807  	return 0;
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  808  }
> ab597d35ef11d2 drivers/pci/host/pcie-xilinx-nwl.c       Bharat Kumar Gogada 2016-03-06  809  
> 
> :::::: The code at line 783 was first introduced by commit
> :::::: ab597d35ef11d2a921e0ec507a9b7861bcb44cbd PCI: xilinx-nwl: Add support for Xilinx NWL PCIe Host Controller
> 
> :::::: TO: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> :::::: CC: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


