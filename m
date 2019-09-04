Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72414A7FF5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfIDKFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 06:05:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55376 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfIDKFv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 06:05:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84A48i2123240;
        Wed, 4 Sep 2019 10:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=UhETFiih4M1z3JZwuHFHUSGv1cD8t/gkARfWmTbKSss=;
 b=GireBTU7B/iEuDjR9xhOk9duhfv+VfCA9wyIt1t7xOnwsp5C+fLCPAMoYzvFSJyaSQ6t
 Ib+eym8Zowjg4JRG2d5z/6j+yNGGDH2jUM4HK0hc3zV5jsT/wDTlhSmERXT2dl620gu8
 yIEfhZIIiKCzsNMy6/UdwrBbtvh/R4vst/3hxu61zalfNJdavamuZqBDKS7nGC5Yn0LL
 U11P05u9+5DgmXuNCrKbvChQEioCvX292vCnuLKhmsLVdVa2yEn0ILOFQnvfRm/RTn8l
 uAnS7qiKH7ZsI7nkxjRS7+rocCbv9t+sW2+tS54SFWBDKaLf5XI75rIJrz/WuK8bnNWv zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2utb5yr0me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 10:05:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84A3TkJ101699;
        Wed, 4 Sep 2019 10:03:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2usu51p8rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 10:03:47 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x84A393c010257;
        Wed, 4 Sep 2019 10:03:09 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Sep 2019 03:03:08 -0700
Date:   Wed, 4 Sep 2019 13:03:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     benh@kernel.crashing.org
Cc:     linux-pci@vger.kernel.org
Subject: [bug report] PCI: Protect pci_reassign_bridge_resources() against
 addition/removal
Message-ID: <20190904100303.GD7007@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=789
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=842 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040100
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Benjamin Herrenschmidt,

The patch 540f62d26f02: "PCI: Protect pci_reassign_bridge_resources()
against addition/removal" from Jun 24, 2019, leads to the following
static checker warning:

	drivers/pci/setup-bus.c:2158 pci_reassign_bridge_resources()
	warn: inconsistent returns 'read_sem:&pci_bus_sem'.

drivers/pci/setup-bus.c
  2066          unsigned int i;
  2067          int ret;
  2068  
  2069          down_read(&pci_bus_sem);

We added some new locking here.

  2070  
  2071          /* Walk to the root hub, releasing bridge BARs when possible */
  2072          next = bridge;
  2073          do {
  2074                  bridge = next;
  2075                  for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
  2076                       i++) {
  2077                          struct resource *res = &bridge->resource[i];
  2078  
  2079                          if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
  2080                                  continue;
  2081  
  2082                          /* Ignore BARs which are still in use */
  2083                          if (res->child)
  2084                                  continue;
  2085  
  2086                          ret = add_to_list(&saved, bridge, res, 0, 0);
  2087                          if (ret)
  2088                                  goto cleanup;
  2089  
  2090                          pci_info(bridge, "BAR %d: releasing %pR\n",
  2091                                   i, res);
  2092  
  2093                          if (res->parent)
  2094                                  release_resource(res);
  2095                          res->start = 0;
  2096                          res->end = 0;
  2097                          break;
  2098                  }
  2099                  if (i == PCI_BRIDGE_RESOURCE_END)
  2100                          break;
  2101  
  2102                  next = bridge->bus ? bridge->bus->self : NULL;
  2103          } while (next);
  2104  
  2105          if (list_empty(&saved))
  2106                  return -ENOENT;

This needs an unlock.  It's not clear to me if any other clean up is
required, but possibly it's worth looking at.

  2107  
  2108          __pci_bus_size_bridges(bridge->subordinate, &added);
  2109          __pci_bridge_assign_resources(bridge, &added, &failed);

regards,
dan carpenter
