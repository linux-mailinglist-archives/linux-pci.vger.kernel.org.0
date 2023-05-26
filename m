Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC5711F41
	for <lists+linux-pci@lfdr.de>; Fri, 26 May 2023 07:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjEZFhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 01:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEZFhK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 01:37:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20387195
        for <linux-pci@vger.kernel.org>; Thu, 25 May 2023 22:37:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f68fc6b479so3791245e9.2
        for <linux-pci@vger.kernel.org>; Thu, 25 May 2023 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685079425; x=1687671425;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ia3v36xyxfeQr6pILyLNKr3HLDKWkSOuXI6pXCcmms8=;
        b=kucb3530+RUZHNakYlOYNSOANPpXsGweBVE/tmqX8I+1/Rdnb1u8jALqxnNjj+PoX9
         KqEWuQDqt/vt47WKgLZbCH3gIvMQgJ9w7FwfgWRmvZlHVtX31kCW5E9jbvvPpNA7yJur
         1yxQZtVJYcPcEWDNpZkIeiWmWW4qmkp1RNc/wlRJlVXUzGSOEzIf4RX96bD6ibct+dGy
         Yud2wd3Q6RVs31CY1UIxg1Cy1SN/W7H8pEF9nqcsvs9/wHhTrDANN3h3hSR82LO0Vy+f
         /msz0UmVNXSvofffMaYcvFW8A7slw84RiipIVuBt4IioivW6kH2xdrPjzTE/l9Q67qHs
         HfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685079425; x=1687671425;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ia3v36xyxfeQr6pILyLNKr3HLDKWkSOuXI6pXCcmms8=;
        b=DC9CHN/dT0N4uo2MWOo6ttYhapv0+9BkSvaik3SNqzIa9VHpqCx2yl+jfLwGJT66Sq
         jKd9+vOF0UUMustqI3s3dNkBEO1oV7fEeDNNjnalB5CzcloeF8cbO79I8rjSK6wTmdoy
         1p9xR4aeq3FLx7yxc+jZIj6PFg8Iw0Kpw+apKL5V841SlcqfiTSpkMyLJAJBhkZn/LkJ
         g5sGOcHGm7X44uO54QaDhuyWgfwI+cwWLghhsyJlNpLX9klh7NIGwLMlXnZxAWM5HpZN
         TuNSvos9qmn2Tdi6UUGq2AfD6jQTD9bra80+rx7KHhabGznVvjze2l9gjNjL53bwhRgM
         binA==
X-Gm-Message-State: AC+VfDwWYQUaSngHiSjJTKuLNKJhNzjt7TRi0a0BsYdgw9roL7hLtsaJ
        7Hlp9Iq1JdPPtfzWCUv1bONmCw==
X-Google-Smtp-Source: ACHHUZ4VDHwDx1+fbg+8sv7LJMh4u+NScozxoFmaJKEhbzXLrM9hzN36CzLmtOZqp62PGO2/8cJeGw==
X-Received: by 2002:a1c:7918:0:b0:3f1:98bd:acec with SMTP id l24-20020a1c7918000000b003f198bdacecmr423621wme.11.1685079425585;
        Thu, 25 May 2023 22:37:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y12-20020a1c4b0c000000b003f4290720d0sm7503569wma.47.2023.05.25.22.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 22:37:04 -0700 (PDT)
Date:   Fri, 26 May 2023 08:37:00 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, bhelgaas@google.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        bharat.kumar.gogada@amd.com, michals@amd.com,
        nagaradhesh.yeleswarapu@amd.com,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: Re: [PATCH v3 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <af5890b4-f084-48ad-adc2-3a664788f63e@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519105901.2399452-4-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thippeswamy,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thippeswamy-Havalige/Move-and-rename-error-interrupt-bits-to-a-common-header/20230519-190203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230519105901.2399452-4-thippeswamy.havalige%40amd.com
patch subject: [PATCH v3 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
config: loongarch-randconfig-m041-20230521
compiler: loongarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305261250.2cs1phTS-lkp@intel.com/

New smatch warnings:
drivers/pci/controller/pcie-xilinx-dma-pl.c:562 xilinx_pl_dma_pcie_init_irq_domain() warn: passing zero to 'PTR_ERR'
drivers/pci/controller/pcie-xilinx-dma-pl.c:600 xilinx_pl_dma_pcie_setup_irq() warn: unsigned 'port->irq' is never less than zero.

Old smatch warnings:
drivers/pci/controller/pcie-xilinx-dma-pl.c:576 xilinx_pl_dma_pcie_init_irq_domain() warn: passing zero to 'PTR_ERR'

vim +/PTR_ERR +562 drivers/pci/controller/pcie-xilinx-dma-pl.c

3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  551  static int xilinx_pl_dma_pcie_init_irq_domain(struct pl_dma_pcie *port)
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  552  {
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  553  	struct device *dev = port->dev;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  554  	struct device_node *node = dev->of_node;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  555  	struct device_node *pcie_intc_node;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  556  	int ret;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  557  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  558  	/* Setup INTx */
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  559  	pcie_intc_node = of_get_child_by_name(node, "interrupt-controller");
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  560  	if (!pcie_intc_node) {
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  561  		dev_err(dev, "No PCIe Intc node found\n");
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19 @562  		return PTR_ERR(pcie_intc_node);

PTR_ERR(NULL) is success.

3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  563  	}
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  564  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  565  	port->pldma_domain = irq_domain_add_linear(pcie_intc_node, 32,
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  566  						   &event_domain_ops, port);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  567  	if (!port->pldma_domain)
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  568  		return -ENOMEM;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  569  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  570  	irq_domain_update_bus_token(port->pldma_domain, DOMAIN_BUS_NEXUS);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  571  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  572  	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  573  						  &intx_domain_ops, port);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  574  	if (!port->intx_domain) {
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  575  		dev_err(dev, "Failed to get a legacy IRQ domain\n");
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  576  		return PTR_ERR(port->intx_domain);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  577  	}
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  578  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  579  	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  580  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  581  	ret = xilinx_pl_dma_pcie_init_msi_irq_domain(port);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  582  	if (ret != 0) {
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  583  		irq_domain_remove(port->intx_domain);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  584  		return -ENOMEM;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  585  	}
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  586  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  587  	of_node_put(pcie_intc_node);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  588  	raw_spin_lock_init(&port->lock);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  589  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  590  	return 0;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  591  }
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  592  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  593  static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  594  {
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  595  	struct device *dev = port->dev;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  596  	struct platform_device *pdev = to_platform_device(dev);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  597  	int i, irq;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  598  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  599  	port->irq = platform_get_irq(pdev, 0);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19 @600  	if (port->irq < 0)
                                                            ^^^^^^^^^^^^^
unsigned isn't less than zero.  Presumably other checkers have already
complained about this...

3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  601  		return port->irq;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  602  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  603  	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  604  		int err;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  605  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  606  		if (!intr_cause[i].str)
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  607  			continue;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  608  
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  609  		irq = irq_create_mapping(port->pldma_domain, i);
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  610  		if (!irq) {
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  611  			dev_err(dev, "Failed to map interrupt\n");
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  612  			return -ENXIO;
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  613  		}
3edd32a3a46e2d Thippeswamy Havalige 2023-05-19  614  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

