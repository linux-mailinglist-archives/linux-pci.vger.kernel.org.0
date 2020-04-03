Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F82319D4FD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 12:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgDCKYH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 06:24:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55234 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2020 06:24:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033AMomI006005;
        Fri, 3 Apr 2020 10:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=i1ggMKgfprzTBmjTkkEMaaj/fyNdcd8zJqS5dJmvgJw=;
 b=xAvsPRmx6gh2+EBdOl3phuDMaeJVrKvTjp6xEuk3T0W/akHIREcWwUO2qd/9GBhYbnK5
 2EFUQ3ejOxz7Kx0pE0i/5o2PmxnptZ0ieBpf8ZEiopScTh80lrLHV9ZWgpg/SKIY94nw
 aH5gSrCFzm5dPel69pBlBxCI2A69Vhjvj0Kca8H+EhisfwdePicoR9G7ERosqx0w5Z3W
 zZ69uJCW7BlUXSxh71GsKZrJwKNcal1GZirX+BWZZr74ABPYJ4g0L/ccPfbVLQ6m1no0
 qLyqCjytjwLppX5hCxgmQrV8JSaH3At7sHXk3eL3DaViOBijD+rE0Fa7QzTaJ6vhqNre Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 303aqj0r6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 10:23:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033ANAt4064259;
        Fri, 3 Apr 2020 10:23:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 304sjscrgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 10:23:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033ANOPg014410;
        Fri, 3 Apr 2020 10:23:24 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 03:23:24 -0700
Date:   Fri, 3 Apr 2020 13:23:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, kbuild@lists.01.org
Cc:     Shiju Jose <shiju.jose@huawei.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, bp@alien8.de,
        james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v5 2/2] PCI: HIP: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200403102313.GD2066@kadam>
References: <24330bd8-afaa-d7ac-594c-f9fda4242400@huawei.com>
 <20200325173639.GA484@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325173639.GA484@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030090
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I've added the kbuild list because I think you have a point.

On Wed, Mar 25, 2020 at 12:36:39PM -0500, Bjorn Helgaas wrote:
> [+cc Dan]
> 

Shiju had already added me to the CC list...

> On Wed, Mar 25, 2020 at 01:55:18PM +0000, Shiju Jose wrote:
> > The HiSilicon HIP PCIe controller is capable of handling errors
> > on root port and perform port reset separately at each root port.
> > 
> > This patch add error handling driver for HIP PCIe controller to log
> > and report recoverable errors. Perform root port reset and restore
> > link status after the recovery.
> > 
> > Following are some of the PCIe controller's recoverable errors
> > 1. completion transmission timeout error.
> > 2. CRS retry counter over the threshold error.
> > 3. ECC 2 bit errors
> > 4. AXI bresponse/rresponse errors etc.
> > 
> > Also fix the following Smatch warning:
> > warn: should '((((1))) << (9 + i))' be a 64 bit type?
> > if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i))
> >      ^^^ This should be BIT_ULL() because it goes up to 9 + 32.
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> I'm glad you did this fix, and thanks for acknowledging Dan, but I
> don't think it's necessary to mention it in the commit log here
> because it won't really be useful in the future.  It's only relevant
> when comparing the unmerged versions of this series, e.g., v4 compared
> to v3.

It's the kbuild template which suggests adding the Reported-by tags but
you're right that it's not really appropriate for patches that haven't
been merged yet.  I wish there were a correct tag.  I just saw yesterday
where a maintainer insisted that someone add a Suggested-by tag and I
don't think that's appropriate either.

regards,
dan carpenter

