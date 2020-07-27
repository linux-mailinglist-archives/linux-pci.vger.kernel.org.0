Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59B422EB0D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgG0LTy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 07:19:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59688 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgG0LTx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 07:19:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RBBYiH119212;
        Mon, 27 Jul 2020 11:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=GfJTnqT6BhQ/M2Xytx+6owaLNIlOW3C5+XpAE9DT+B4=;
 b=sfz08+4+I45rrwZpzGPpSiOdAYQzgQQipQKYBSEgZebBhiNMxYvxS7jEeLK8txvM1cxI
 Qi6vEua2IlfJhqVEKITIF01ojfppUEp4zGXqD+wI+KdIl26n4B5UOAaPJ6aEt8Wjelpy
 0feJQluh3DKWKFrISpEV5WVezphv5SyW8CzmPKrFiWWsAzSfIrdTG01iYsVuPREUQ+eE
 MdqJRVb4jsbwvIa48N2rZXsSjafQetHvVlOWDe8zYsTgPP7JL9WfSG4YucCdcJgQ7S97
 cSD8QPS9hXYhxGuxB5DeKpLWExG1QFLq7WjiXWSQHSD4bTdgQOR8EjX5oGamU3dfjzGm Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1j8xd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 11:19:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RBCdEh170990;
        Mon, 27 Jul 2020 11:19:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32hu5seth7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 11:19:50 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06RBJnNW015969;
        Mon, 27 Jul 2020 11:19:49 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 04:19:49 -0700
Date:   Mon, 27 Jul 2020 14:19:43 +0300
From:   <dan.carpenter@oracle.com>
To:     kishon@ti.com
Cc:     linux-pci@vger.kernel.org
Subject: [bug report] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
Message-ID: <20200727111943.GD389488@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9694 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=3 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270083
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Kishon Vijay Abraham I,

The patch 82d8567259b1: "PCI: cadence: Use "dma-ranges" instead of
"cdns,no-bar-match-nbits" property" from Jul 22, 2020, leads to the
following static checker warning:

	drivers/pci/controller/cadence/pcie-cadence-host.c:322 cdns_pcie_host_map_dma_ranges()
	warn: ignoring unreachable code.

drivers/pci/controller/cadence/pcie-cadence-host.c
   296  static int cdns_pcie_host_map_dma_ranges(struct cdns_pcie_rc *rc)
   297  {
   298          struct cdns_pcie *pcie = &rc->pcie;
   299          struct device *dev = pcie->dev;
   300          struct device_node *np = dev->of_node;
   301          struct pci_host_bridge *bridge;
   302          struct resource_entry *entry;
   303          u32 no_bar_nbits = 32;
   304          int err;
   305  
   306          bridge = pci_host_bridge_from_priv(rc);
   307          if (!bridge)
   308                  return -ENOMEM;
   309  
   310          if (list_empty(&bridge->dma_ranges)) {
   311                  of_property_read_u32(np, "cdns,no-bar-match-nbits",
   312                                       &no_bar_nbits);
   313                  err = cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
   314                                                     (u64)1 << no_bar_nbits, 0);
   315                  if (err)
   316                          dev_err(dev, "IB BAR: %d config failed\n", RP_NO_BAR);
   317                  return err;
   318          }
   319  
   320          list_sort(NULL, &bridge->dma_ranges, cdns_pcie_host_dma_ranges_cmp);
   321  
   322          resource_list_for_each_entry(entry, &bridge->dma_ranges) {

That static checker is complaining that we only use the first entry in
the list.  This is often intentional so I have normally just silence
these..

   323                  err = cdns_pcie_host_bar_config(rc, entry);
   324                  if (err)
   325                          dev_err(dev, "Fail to configure IB using dma-ranges\n");
   326                  return err;

But in this case, it's possible that it wasn't intentional.  Anyway, I
figure you know the answer instantly since the code is new so hopefully
it's not too much bother.

   327          }
   328  
   329          return 0;
   330  }

regards,
dan carpenter
