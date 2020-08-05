Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7F23D140
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgHET6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 15:58:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60268 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbgHEQnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Aug 2020 12:43:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075ARU1C060186;
        Wed, 5 Aug 2020 10:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=0Ivf4+Arbx6SbDkNF5h5BBDWwD9RCtfGRW85wmjcgwY=;
 b=GHhV5qqQE/RqWjh9yRfoxmGrPGOI8TDhL2f+KgdDGwUStOfZyjHnuchrlSHXhuFk165+
 o5gByIz+nz0EhVNv3S4QvsPEJ6DDZhEH8DYztaFg9+oSHKmdJycqR3wybBPWvNWInjv7
 9t7w7VEKpXQ7oNt3jh08SNBMdLUKtDQTBYRguoOGl55a1WwT4EIzqBFtldOC3XE75QNH
 oEAnRfT5rC31WdGQ2vnzEhmCuut2ojYOZb+AacZaPpzUMU1GV+Ob6+PTa3Psi7bS6KbQ
 2shA0Esfy2CyNSOIsZ0neYGNL9dAIgTlhR3lOuXXiKNc76jkjTKWKgTK2eD/gDF8FHeH 9A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32pdnqckaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 10:27:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075AIxZV038778;
        Wed, 5 Aug 2020 10:27:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32pdhdyvu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 10:27:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 075ARStB001626;
        Wed, 5 Aug 2020 10:27:28 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 03:27:28 -0700
Date:   Wed, 5 Aug 2020 13:27:22 +0300
From:   <dan.carpenter@oracle.com>
To:     bharat.kumar.gogada@xilinx.com
Cc:     linux-pci@vger.kernel.org
Subject: [bug report] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200805102722.GA490427@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=3 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050087
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bharat Kumar Gogada,

The patch 0189e6fb2c46: "PCI: xilinx-cpm: Add Versal CPM Root Port
driver" from Jun 16, 2020, leads to the following static checker
warning:

	drivers/pci/controller/pcie-xilinx-cpm.c:557 xilinx_cpm_pcie_probe()
	error: uninitialized symbol 'bus_range'.

drivers/pci/controller/pcie-xilinx-cpm.c
   537  static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
   538  {
   539          struct xilinx_cpm_pcie_port *port;
   540          struct device *dev = &pdev->dev;
   541          struct pci_host_bridge *bridge;
   542          struct resource *bus_range;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^

   543          int err;
   544  
   545          bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
   546          if (!bridge)
   547                  return -ENODEV;
   548  
   549          port = pci_host_bridge_priv(bridge);
   550  
   551          port->dev = dev;
   552  
   553          err = xilinx_cpm_pcie_init_irq_domain(port);
   554          if (err)
   555                  return err;
   556  
   557          err = xilinx_cpm_pcie_parse_dt(port, bus_range);
                                                     ^^^^^^^^^
Never initialized.

   558          if (err) {
   559                  dev_err(dev, "Parsing DT failed\n");
   560                  goto err_parse_dt;
   561          }
   562  
   563          xilinx_cpm_pcie_init_port(port);
   564  
   565          err = xilinx_cpm_setup_irq(port);
   566          if (err) {
   567                  dev_err(dev, "Failed to set up interrupts\n");
   568                  goto err_setup_irq;
   569          }
   570  
   571          bridge->dev.parent = dev;

regards,
dan carpenter
