Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF53130972
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2020 19:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAESuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jan 2020 13:50:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgAESuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jan 2020 13:50:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 005Io5De175297;
        Sun, 5 Jan 2020 18:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=gsncbubOefzMjpNxvtBbqDd4IlCJMaQw8LhlLqFhzcI=;
 b=W4PEXBlLF5EqhZSLWgUcQxAW4CD98pPiwzxNwu6g2e/zOsZ4X5NVfB4uTAZYvQYqlvP3
 c/m9llSbc1NfwVrEdlX3D+1sZDqmHVvDz7aaw73/+5JcMj+tbTgwxbuevvryMVX8x5ut
 lJzG78VYSENTivkNooudU+jXTRQGOAYg75FhBvsQhyZgDdYtf/5e2hmEdBwJI0zaw1rQ
 VZiLfS4BREJ6QotsDd0fLbAfGqWKW5ERo3KHNb6oRaiQEpyaRyGiuG9ERJN8gyLLHdRo
 92uwUr3q12DSPGRjMpum7xtbeCz9gZPcR6lijnM/86g5TGYvae3n7SnzOE9c9QXYJuUN tA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xakbqbgsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Jan 2020 18:50:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 005InL23144648;
        Sun, 5 Jan 2020 18:50:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xb4uypsuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Jan 2020 18:50:04 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 005Io4Q3010320;
        Sun, 5 Jan 2020 18:50:04 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Jan 2020 10:50:03 -0800
Date:   Sun, 5 Jan 2020 21:49:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        rgummal@xilinx.com,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: Re: [PATCH 2/2] PCI: Versal CPM: Add support for Versal CPM Root
 Port driver
Message-ID: <20200105184953.GF3889@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576842072-32027-3-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001050173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9491 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001050173
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bharat,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Bharat-Kumar-Gogada/Adding-support-for-versal-CPM-as-Root-Port-driver/20191223-193219
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/pci/controller/pcie-xilinx-cpm.c:330 xilinx_cpm_pcie_init_irq_domain() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
drivers/pci/controller/pcie-xilinx-cpm.c:338 xilinx_cpm_pcie_init_irq_domain() warn: passing zero to 'PTR_ERR'

# https://github.com/0day-ci/linux/commit/f107713acb796e598f16a23b33af74fa382921b2
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout f107713acb796e598f16a23b33af74fa382921b2
vim +/PTR_ERR +330 drivers/pci/controller/pcie-xilinx-cpm.c

f107713acb796e Bharat Kumar Gogada 2019-12-20  320  static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie_port *port)
f107713acb796e Bharat Kumar Gogada 2019-12-20  321  {
f107713acb796e Bharat Kumar Gogada 2019-12-20  322  	struct device *dev = port->dev;
f107713acb796e Bharat Kumar Gogada 2019-12-20  323  	struct device_node *node = dev->of_node;
f107713acb796e Bharat Kumar Gogada 2019-12-20  324  	struct device_node *pcie_intc_node;
f107713acb796e Bharat Kumar Gogada 2019-12-20  325  
f107713acb796e Bharat Kumar Gogada 2019-12-20  326  	/* Setup INTx */
f107713acb796e Bharat Kumar Gogada 2019-12-20  327  	pcie_intc_node = of_get_next_child(node, NULL);
f107713acb796e Bharat Kumar Gogada 2019-12-20  328  	if (!pcie_intc_node) {
                                                            ^^^^^^^^^^^^^^^

f107713acb796e Bharat Kumar Gogada 2019-12-20  329  		dev_err(dev, "No PCIe Intc node found\n");
f107713acb796e Bharat Kumar Gogada 2019-12-20 @330  		return PTR_ERR(pcie_intc_node);
                                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
(This means success).

f107713acb796e Bharat Kumar Gogada 2019-12-20  331  	}
f107713acb796e Bharat Kumar Gogada 2019-12-20  332  
f107713acb796e Bharat Kumar Gogada 2019-12-20  333  	port->leg_domain = irq_domain_add_linear(pcie_intc_node, INTX_NUM,
f107713acb796e Bharat Kumar Gogada 2019-12-20  334  						 &intx_domain_ops,
f107713acb796e Bharat Kumar Gogada 2019-12-20  335  						 port);
f107713acb796e Bharat Kumar Gogada 2019-12-20  336  	if (!port->leg_domain) {
f107713acb796e Bharat Kumar Gogada 2019-12-20  337  		dev_err(dev, "Failed to get a INTx IRQ domain\n");
f107713acb796e Bharat Kumar Gogada 2019-12-20  338  		return PTR_ERR(port->leg_domain);
f107713acb796e Bharat Kumar Gogada 2019-12-20  339  	}
f107713acb796e Bharat Kumar Gogada 2019-12-20  340  
f107713acb796e Bharat Kumar Gogada 2019-12-20  341  	return 0;
f107713acb796e Bharat Kumar Gogada 2019-12-20  342  }

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
