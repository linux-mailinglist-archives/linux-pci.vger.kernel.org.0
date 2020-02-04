Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A55151C44
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2020 15:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgBDOdO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Feb 2020 09:33:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60978 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgBDOdN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2020 09:33:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014ENEvJ174913;
        Tue, 4 Feb 2020 14:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=pt2dhiYXg1N/Fuw4ZspxpERuJ9G0f6yoC8gPPXAvscc=;
 b=kffE1qec3euoQJxKNleY2033qTlUsqCITkCLMS3EGZvyvDdufuyHS5ABue8wxStJCnSK
 833owxFAnzfVG4w4RbpeOtZ6AXOXocFWTLDJy0K/LBx23keJERPQQ0/XSjR8vIPlSXSj
 lzC5E3lG9EFMWYZjKHitNeLDQt+/9g6oEycsBKOfwK6WnxyvSmTo/86b/5pCAJ4x4Uqv
 Zdj7y+wiUEpQT25mKcpOZ4pmuE1SVLL4O0X5ttn7gRir1xa7zVkVpwE+ybUgUk2F8vzg
 SaDAKMhXRlSItv0q9wxPEc/aod+IE5NdS2BJ1gHeon1GUkZfczB2gPPAaDn7S//BNfEX cQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xwyg9k7m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 14:31:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 014EOVJZ164778;
        Tue, 4 Feb 2020 14:31:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xxw0x3vqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Feb 2020 14:31:58 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 014EVsda006815;
        Tue, 4 Feb 2020 14:31:54 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 06:31:54 -0800
Date:   Tue, 4 Feb 2020 17:31:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Shiju Jose <shiju.jose@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, helgaas@kernel.org, lenb@kernel.org,
        bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com, Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH v3 2/2] PCI: HIP: Add handling of HiSilicon HIP PCIe
 controller's errors
Message-ID: <20200204143142.GQ11068@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203165122.17748-3-shiju.jose@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002040102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9520 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002040102
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shiju,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Shiju-Jose/ACPI-APEI-Add-support-to-notify-the-vendor-specific-HW-errors/20200204-073736
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/pci/controller/pcie-hisi-error.c:234 hisi_pcie_handle_one_error() warn: should '((((1))) << (9 + i))' be a 64 bit type?

# https://github.com/0day-ci/linux/commit/71688ac6d222c137b66a707f8a6fdf28b48e1942
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 71688ac6d222c137b66a707f8a6fdf28b48e1942
vim +234 drivers/pci/controller/pcie-hisi-error.c

71688ac6d222c1 Yicong Yang 2020-02-03  228  	p += snprintf(p, end - p, "]\n");
71688ac6d222c1 Yicong Yang 2020-02-03  229  	dev_info(dev, "\nHISI : HIP : PCIe controller error\n");
71688ac6d222c1 Yicong Yang 2020-02-03  230  	dev_info(dev, "%s\n", buf);
71688ac6d222c1 Yicong Yang 2020-02-03  231  
71688ac6d222c1 Yicong Yang 2020-02-03  232  	dev_info(dev, "Reg Dump:\n");
71688ac6d222c1 Yicong Yang 2020-02-03  233  	for (i = 0; i < HISI_PCIE_ERR_MISC_REGS; i++) {
71688ac6d222c1 Yicong Yang 2020-02-03 @234  		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
                                                                            ^^^
This should be BIT_ULL() because it goes up to 9 + 32.

71688ac6d222c1 Yicong Yang 2020-02-03  235  			dev_info(dev,
71688ac6d222c1 Yicong Yang 2020-02-03  236  				 "ERR_MISC_%d=0x%x\n", i, err->err_misc[i]);
71688ac6d222c1 Yicong Yang 2020-02-03  237  	}
71688ac6d222c1 Yicong Yang 2020-02-03  238  

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
