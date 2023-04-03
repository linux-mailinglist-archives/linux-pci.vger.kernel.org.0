Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962136D3C84
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 06:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjDCEl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 00:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDCEl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 00:41:26 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0738A4A;
        Sun,  2 Apr 2023 21:41:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so112179985edb.4;
        Sun, 02 Apr 2023 21:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680496883;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v++hfWryTr4oGjGOfz4huDJo0FNuSMUw7ZZdhA+elBM=;
        b=mKLXgQWXGu27rDKMPbp8/1EM+a28h7wkx1Y5rVwPJwd5AqRhYjs/dkIW/xCuwD1I+z
         h4qKbV2CadeJ+BH35J/O5KQNnuSK5lIxy2+qEEloEyeVKqda5KbH6uIszITTmfZV5gqE
         g4plvjfgBVjp9NMHxpSr3qcakwkNnQOU/avbZ6grPf2kAzTTnA/ubABD06CzOAgGlT/n
         ULjUxiAIRia9QIHJvhQ3T2G9LsP0BscpFQXViwp2XUMm8JTXAm1Qs0Xrd1nrCEUoazGO
         MxZlhxLzLzpJyrudHvLDXfrPetxzHZT/GdyiwszUxPRSAzIQVIstzq6ovDcvhBe+VEV4
         pqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680496883;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v++hfWryTr4oGjGOfz4huDJo0FNuSMUw7ZZdhA+elBM=;
        b=QLGQu+CriGPr+Rv3UskibSPiagyp029ujYD+CPq0fRO7w0ygHwk4iqDtaen9V66D5j
         x9SNcQGGgM0QK83zOhYUJ1ROIRk3pbKDxfKfanBp8h4IpiQV/hCQTxNoCkRrEyOha4nj
         zQZZMi2RjTqogSS7dJfJ6uwvx16LyYfQI3ssLailBCvkYtnkUJNqwtT8p5W46dF5XIKH
         Vc+4PWsrnouLqsuO0th8iJfDTAJp3d42Jna9iB1mlFYmrjWhU34D+wyK3lnL8ywGPEz6
         5IQ1mPSJz3pN8zmIUrJ2KCUVkp7OBVssRM8QHt9yblESQzkFWbU2PqiAyQG7+WOZcHsg
         BO0g==
X-Gm-Message-State: AAQBX9fpNAwUkgeveNWobrEhw+RaDvpuNZreBYqredDbIXKwIk5OiEnZ
        WY0CQlSIXuToeRQeM0usa58=
X-Google-Smtp-Source: AKy350Y5L7wIeSJO056Wm7y7gnLJ/If2CjlZeCyWbLi+OGlz0K+jIWx221uL//p96EsRTXO+tnm6VQ==
X-Received: by 2002:a17:907:724b:b0:93f:2256:fc05 with SMTP id ds11-20020a170907724b00b0093f2256fc05mr35126641ejc.55.1680496883042;
        Sun, 02 Apr 2023 21:41:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ae14-20020a17090725ce00b00947a939f6e0sm3685313ejc.77.2023.04.02.21.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 21:41:22 -0700 (PDT)
Date:   Mon, 3 Apr 2023 07:41:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, ye.xingchen@zte.com.cn,
        sergio.paracuellos@gmail.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] PCI: mt7621: Use dev_err_probe()
Message-ID: <22081108-565d-4608-97f7-6e40ca3df2b6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303231145121987818@zte.com.cn>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/ye-xingchen-zte-com-cn/PCI-mt7621-Use-dev_err_probe/20230323-114623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/202303231145121987818%40zte.com.cn
patch subject: [PATCH] PCI: mt7621: Use dev_err_probe()
config: s390-randconfig-m031-20230329 (https://download.01.org/0day-ci/archive/20230401/202304010325.2OPFvIm3-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202304010325.2OPFvIm3-lkp@intel.com/

smatch warnings:
drivers/pci/controller/pcie-mt7621.c:224 mt7621_pcie_parse_port() warn: passing zero to 'PTR_ERR'
drivers/pci/controller/pcie-mt7621.c:227 mt7621_pcie_parse_port() warn: ignoring unreachable code.

vim +/PTR_ERR +224 drivers/pci/controller/pcie-mt7621.c

ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  198  static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  199  				  struct device_node *node,
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  200  				  int slot)
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  201  {
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  202  	struct mt7621_pcie_port *port;
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  203  	struct device *dev = pcie->dev;
fab6710e4c51f4 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2020-04-13  204  	struct platform_device *pdev = to_platform_device(dev);
61f9bde6ea578f drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2019-01-04  205  	char name[10];
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  206  	int err;
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  207  
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  208  	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  209  	if (!port)
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  210  		return -ENOMEM;
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  211  
108b2f2a972454 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2020-11-23  212  	port->base = devm_platform_ioremap_resource(pdev, slot + 1);
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  213  	if (IS_ERR(port->base))
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  214  		return PTR_ERR(port->base);
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  215  
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  216  	port->clk = devm_get_clk_from_child(dev, node, NULL);
cc4e864a5ce4c1 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-05-05  217  	if (IS_ERR(port->clk)) {
cc4e864a5ce4c1 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-05-05  218  		dev_err(dev, "failed to get pcie%d clock\n", slot);
cc4e864a5ce4c1 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-05-05  219  		return PTR_ERR(port->clk);
cc4e864a5ce4c1 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-05-05  220  	}
cc4e864a5ce4c1 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-05-05  221  
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  222  	port->pcie_rst = of_reset_control_get_exclusive(node, NULL);
9873bac812f262 drivers/pci/controller/pcie-mt7621.c    Ye Xingchen        2023-03-23  223  
9873bac812f262 drivers/pci/controller/pcie-mt7621.c    Ye Xingchen        2023-03-23 @224  	return dev_err_probe(dev, PTR_ERR(port->pcie_rst),
                                                                                                                          ^^^^^^^^^^^^^^^^^^^^^^^

9873bac812f262 drivers/pci/controller/pcie-mt7621.c    Ye Xingchen        2023-03-23  225  			     "failed to get pcie%d reset control\n", slot);
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  226  
61f9bde6ea578f drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2019-01-04 @227  	snprintf(name, sizeof(name), "pcie-phy%d", slot);
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  228  	port->phy = devm_of_phy_get(dev, node, name);
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  229  	if (IS_ERR(port->phy)) {
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  230  		dev_err(dev, "failed to get pcie-phy%d\n", slot);
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  231  		err = PTR_ERR(port->phy);
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  232  		goto remove_reset;
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  233  	}
61f9bde6ea578f drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2019-01-04  234  
b27e35f91c75cf drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2020-03-13  235  	port->gpio_rst = devm_gpiod_get_index_optional(dev, "reset", slot,
b27e35f91c75cf drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2020-03-13  236  						       GPIOD_OUT_LOW);
825c6f470c62da drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2020-03-20  237  	if (IS_ERR(port->gpio_rst)) {
2bdd5238e756aa drivers/pci/controller/pcie-mt7621.c    Sergio Paracuellos 2021-09-22  238  		dev_err(dev, "failed to get GPIO for PCIe%d\n", slot);
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  239  		err = PTR_ERR(port->gpio_rst);
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  240  		goto remove_reset;
825c6f470c62da drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2020-03-20  241  	}
b27e35f91c75cf drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2020-03-13  242  
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  243  	port->slot = slot;
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  244  	port->pcie = pcie;
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  245  
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  246  	INIT_LIST_HEAD(&port->list);
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  247  	list_add_tail(&port->list, &pcie->ports);
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  248  
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  249  	return 0;
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  250  
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  251  remove_reset:
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  252  	reset_control_put(port->pcie_rst);
2d3d288f0eaf10 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2021-06-07  253  	return err;
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  254  }
ad9c87e129d139 drivers/staging/mt7621-pci/pci-mt7621.c Sergio Paracuellos 2018-11-04  255  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

