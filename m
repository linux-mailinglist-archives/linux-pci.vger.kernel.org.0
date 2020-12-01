Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CCD2C99F4
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 09:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgLAIu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 03:50:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40974 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgLAIu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 03:50:59 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B18mwc3026161;
        Tue, 1 Dec 2020 08:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=a9RTQ8k9J/aoLs6zUlZRi8FarbGaiTb59XA0HCSWTfI=;
 b=Uu2gjbHWPYeY5y7TSn8d4xWxLjTPskmKZhWkVT1IIjWCJY1Y5+mcQa83m9b8IKTuuif/
 zILGxFM50hQKBZEsPSH6qw8RzH5Wn+xh/KKib+xYdwGBEj5cozR7x5sUWrsLwO2Sthpr
 Yaq6Qh4KAk173e1wvcmGkwrRkR5+uNQdwGV+7pCTjpPuKi63OhvSBBmA6gyTA1w6dW+R
 bETME92U3X9nuHF/B5BjVLXlSiFCA9Vcf1ZnJ8HgRsDC9fuMj7ExarFzDqDvV248lS3M
 WXa1i9BakB5z+HkddZoeHfHmwpuZlvKeBJ0Dma/TdS9mTWiNrwgnDRw/teuQifqPPCdA 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 353c2asdyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 08:50:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B18fK8b063440;
        Tue, 1 Dec 2020 08:50:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3540fwk15w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 08:50:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B18oEGG021936;
        Tue, 1 Dec 2020 08:50:14 GMT
Received: from mwanda (/41.210.145.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 00:50:14 -0800
Date:   Tue, 1 Dec 2020 11:50:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     robh@kernel.org
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: [bug report] PCI: dwc: Move "dbi", "dbi2", and "addr_space" resource
 setup into common code
Message-ID: <X8YDv+bzaeXONOrt@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=3
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010058
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010059
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Rob Herring,

The patch a0fd361db8e5: "PCI: dwc: Move "dbi", "dbi2", and
"addr_space" resource setup into common code" from Nov 5, 2020, leads
to the following static checker warning:

	drivers/pci/controller/dwc/pcie-designware-host.c:337 dw_pcie_host_init()
	warn: 'pci->dbi_base' is an error pointer or valid

drivers/pci/controller/dwc/pcie-designware-host.c
   304          cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
   305          if (cfg_res) {
   306                  pp->cfg0_size = resource_size(cfg_res);
   307                  pp->cfg0_base = cfg_res->start;
   308          } else if (!pp->va_cfg0_base) {
   309                  dev_err(dev, "Missing *config* reg space\n");
   310          }
   311  
   312          if (!pci->dbi_base) {
   313                  struct resource *dbi_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
   314                  pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_res);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We set pci->dbi_base here now.

   315                  if (IS_ERR(pci->dbi_base))
   316                          return PTR_ERR(pci->dbi_base);
   317          }
   318  
   319          bridge = devm_pci_alloc_host_bridge(dev, 0);
   320          if (!bridge)
   321                  return -ENOMEM;
   322  
   323          pp->bridge = bridge;
   324  
   325          /* Get the I/O and memory ranges from DT */
   326          resource_list_for_each_entry(win, &bridge->windows) {
   327                  switch (resource_type(win->res)) {
   328                  case IORESOURCE_IO:
   329                          pp->io_size = resource_size(win->res);
   330                          pp->io_bus_addr = win->res->start - win->offset;
   331                          pp->io_base = pci_pio_to_address(win->res->start);
   332                          break;
   333                  case 0:
   334                          dev_err(dev, "Missing *config* reg space\n");
   335                          pp->cfg0_size = resource_size(win->res);
   336                          pp->cfg0_base = win->res->start;
   337                          if (!pci->dbi_base) {
                                    ^^^^^^^^^^^^^^
So this is dead code because pci->dbi_base is never NULL.

   338                                  pci->dbi_base = devm_pci_remap_cfgspace(dev,
   339                                                                  pp->cfg0_base,
   340                                                                  pp->cfg0_size);
   341                                  if (!pci->dbi_base) {
   342                                          dev_err(dev, "Error with ioremap\n");
   343                                          return -ENOMEM;
   344                                  }
   345                          }
   346                          break;
   347                  }
   348          }

regards,
dan carpenter
