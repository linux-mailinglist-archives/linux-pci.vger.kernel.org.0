Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487151BC689
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 19:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgD1RYR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 13:24:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgD1RYQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2020 13:24:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SHMu2i035989;
        Tue, 28 Apr 2020 17:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=g6aKdVTY3T23iII1YYYlUR7JkfOQo1n+D3TQqoWDnbw=;
 b=tVo2VqxkHokM8pzCo43UIvhGL0KgDYoZ4gmLTYqDCEYVVhb+IdnVb9YwjcrvziqtzjrE
 gWB/4jUrEz4xgoLFYctFkB7Fu4OzvNF/nfFk8XQWsLy+l+uc9rNTVVjq9mmp6Z5K6Lxv
 M/7iLKH2/3ePjkEKq/ib6J5SDOCKncK607YfJ/xgcnRMlXam4ZIEUUFtetsBh+syqU/H
 JhHd31s68mJu2edicpSBKnFpfpk9k5y+OFO0Uwg//1F/Zfl9nlQDmsnIIieiCqN5tRmb
 Ii1aGeX4v/VuM9zNz9ji5+4qShnL0EWGxC+kyXaIYlcN94yZHkDQajYTv+HbsOc/tK0l 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30nucg1bsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 17:24:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SHMf5V024004;
        Tue, 28 Apr 2020 17:24:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30mxpghd04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 17:24:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SHNwFw018704;
        Tue, 28 Apr 2020 17:23:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 10:23:57 -0700
Date:   Tue, 28 Apr 2020 20:23:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: dwc: pci-dra7xx: Fix potential NULL
 dereference in dra7xx_pcie_probe()
Message-ID: <20200428172348.GH2014@kadam>
References: <20200427111044.162618-1-weiyongjun1@huawei.com>
 <cad871c8-0915-9dda-2c61-30dfb5504d23@ti.com>
 <20200428130734.GF2014@kadam>
 <ebb4db96-08ef-64fe-5331-291f054562ed@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb4db96-08ef-64fe-5331-291f054562ed@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280137
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Oh.  Crap.  I'm sorry.  I misread the code.

regards,
dan carpenter

