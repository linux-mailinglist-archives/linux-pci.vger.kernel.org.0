Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE22D127D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 14:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgLGNtE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 08:49:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGNtE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 08:49:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7DjDgO183242;
        Mon, 7 Dec 2020 13:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=eMEYMqDt8G33DaXn37O/xyZGtPanrTBCXAREgEoR+wc=;
 b=gmBC9yXBF2QcVdGEueArpKKipuFdQ0YkVdUrCf8ucrtkHzhU7RGvnk3l591cLMxgzIZV
 CvQH18+MXJCHPcxwx0/zH+hSSw6iAV3p58HKDdknixk3l67Sj7LgbL2sPjEz2JBLdBMf
 zb9qZVdzJuiwx989sCp+FySQ86ACHCsK3jfV5Y6h2ctNblcgiwXmb+L95xTJEktjHicK
 DIFZk8Qm3SQBTmcWUdTs82WD0M0CgZcQAvul+OD4np2m1Ndn4+oggQjDExOWISPxtR+W
 k3reh3eKFGC+RzJlFK1TxAnmC8VYuWiNonWKskxEBSh14nSRmp0eyfufrzAmYqjcT6vm xQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35825kwbp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Dec 2020 13:48:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7DkRpQ124483;
        Mon, 7 Dec 2020 13:48:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 358m3wceh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Dec 2020 13:48:21 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B7DmKqP025342;
        Mon, 7 Dec 2020 13:48:20 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 05:48:19 -0800
Date:   Mon, 7 Dec 2020 16:48:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linus.walleij@linaro.org
Cc:     linux-pci@vger.kernel.org
Subject: [bug report] PCI: faraday: Add clock handling
Message-ID: <X84ym2SmBOwQBojL@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9827 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=3 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9827 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070088
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Linus Walleij,

The patch 2eeb02b28579: "PCI: faraday: Add clock handling" from May
15, 2017, leads to the following static checker warning:

	drivers/pci/controller/pci-ftpci100.c:496 faraday_pci_probe()
	warn: 'p->bus_clk' isn't an ERR_PTR

drivers/pci/controller/pci-ftpci100.c
   443  
   444          /* Retrieve and enable optional clocks */
   445          clk = devm_clk_get(dev, "PCLK");
   446          if (IS_ERR(clk))
   447                  return PTR_ERR(clk);
   448          ret = clk_prepare_enable(clk);
   449          if (ret) {
   450                  dev_err(dev, "could not prepare PCLK\n");
   451                  return ret;
   452          }
   453          p->bus_clk = devm_clk_get(dev, "PCICLK");
   454          if (IS_ERR(p->bus_clk))
   455                  return PTR_ERR(p->bus_clk);
                               ^^^^^^^^^^^^^^^^^^^
We ensure that "p->bus_clk" is not an error pointer here.

   456          ret = clk_prepare_enable(p->bus_clk);
   457          if (ret) {
   458                  dev_err(dev, "could not prepare PCICLK\n");
   459                  return ret;
   460          }
   461  
   462          p->base = devm_platform_ioremap_resource(pdev, 0);
   463          if (IS_ERR(p->base))
   464                  return PTR_ERR(p->base);
   465  
   466          win = resource_list_first_type(&host->windows, IORESOURCE_IO);
   467          if (win) {
   468                  io = win->res;
   469                  if (!faraday_res_to_memcfg(io->start - win->offset,
   470                                             resource_size(io), &val)) {
   471                          /* setup I/O space size */
   472                          writel(val, p->base + PCI_IOSIZE);
   473                  } else {
   474                          dev_err(dev, "illegal IO mem size\n");
   475                          return -EINVAL;
   476                  }
   477          }
   478  
   479          /* Setup hostbridge */
   480          val = readl(p->base + PCI_CTRL);
   481          val |= PCI_COMMAND_IO;
   482          val |= PCI_COMMAND_MEMORY;
   483          val |= PCI_COMMAND_MASTER;
   484          writel(val, p->base + PCI_CTRL);
   485          /* Mask and clear all interrupts */
   486          faraday_raw_pci_write_config(p, 0, 0, FARADAY_PCI_CTRL2 + 2, 2, 0xF000);
   487          if (variant->cascaded_irq) {
   488                  ret = faraday_pci_setup_cascaded_irq(p);
   489                  if (ret) {
   490                          dev_err(dev, "failed to setup cascaded IRQ\n");
   491                          return ret;
   492                  }
   493          }
   494  
   495          /* Check bus clock if we can gear up to 66 MHz */
   496          if (!IS_ERR(p->bus_clk)) {
                    ^^^^^^^^^^^^^^^^^^
This check can be deleted, no?

   497                  unsigned long rate;
   498                  u32 val;
   499  
   500                  faraday_raw_pci_read_config(p, 0, 0,
   501                                              FARADAY_PCI_STATUS_CMD, 4, &val);
   502                  rate = clk_get_rate(p->bus_clk);
   503  
   504                  if ((rate == 33000000) && (val & PCI_STATUS_66MHZ_CAPABLE)) {
   505                          dev_info(dev, "33MHz bus is 66MHz capable\n");
   506                          max_bus_speed = PCI_SPEED_66MHz;
   507                          ret = clk_set_rate(p->bus_clk, 66000000);
   508                          if (ret)
   509                                  dev_err(dev, "failed to set bus clock\n");
   510                  } else {
   511                          dev_info(dev, "33MHz only bus\n");
   512                          max_bus_speed = PCI_SPEED_33MHz;
   513                  }
   514  
   515                  /* Bumping the clock may fail so read back the rate */
   516                  rate = clk_get_rate(p->bus_clk);
   517                  if (rate == 33000000)
   518                          cur_bus_speed = PCI_SPEED_33MHz;
   519                  if (rate == 66000000)
   520                          cur_bus_speed = PCI_SPEED_66MHz;
   521          }
   522  
   523          ret = faraday_pci_parse_map_dma_ranges(p);
   524          if (ret)
   525                  return ret;
   526  
   527          ret = pci_scan_root_bus_bridge(host);
   528          if (ret) {
   529                  dev_err(dev, "failed to scan host: %d\n", ret);
   530                  return ret;
   531          }
   532          p->bus = host->bus;

regards,
dan carpenter
