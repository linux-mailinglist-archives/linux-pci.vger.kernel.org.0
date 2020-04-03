Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FD119D953
	for <lists+linux-pci@lfdr.de>; Fri,  3 Apr 2020 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbgDCOmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 10:42:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCOmw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2020 10:42:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033EdkGe080956;
        Fri, 3 Apr 2020 14:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8eB0Qd/qSpv4suW6hmEbSPGr2zS14DHLjEQLihL5FII=;
 b=F7s6ITqDEGwCwkoP4gQrmD2rjt61Qh61UUkTPSstfgD+GphjGzKCbWsdOMU/0vv53JJ0
 8bbQlQGagNefPhDfsrovTnd53hpWZy+ILwtbJIiUK095qbeMt8weizhFHt0QISUTHGZo
 V1I2XzXS4dIaI0Fef1DcrIOTjQhOLIm1YV8oJcezT3CZjyaQUm9G1jqU2YW9DutdoUp+
 Ek+IK2KE3RVMudvT+bAn4EBdia1RSZrAyJRU/O47kzThnN05vpy6C5uKHLBbdJAGl58i
 Tex7Cn5Mb5ouZbfHr0wsbsJx5/iYTCrVieiUd++bhcKcQZ8jieO4ahyDyG0X10bomGyY 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 303cevheuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 14:41:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033EcVxG187246;
        Fri, 3 Apr 2020 14:41:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 302g4xkkn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 14:41:49 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 033EfjPT022150;
        Fri, 3 Apr 2020 14:41:45 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 07:41:44 -0700
Date:   Fri, 3 Apr 2020 17:41:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild@lists.01.org, Shiju Jose <shiju.jose@huawei.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com
Subject: Re: [PATCH v5 2/2] PCI: HIP: Add handling of HiSilicon HIP PCIe
 controller errors
Message-ID: <20200403144129.GH2066@kadam>
References: <20200403102313.GD2066@kadam>
 <20200403133303.GA213756@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403133303.GA213756@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030130
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 03, 2020 at 08:33:03AM -0500, Bjorn Helgaas wrote:
>
> Adding tags for every reviewer or bot comment seems like overkill.

I think style comments are their own reward but people should get credit
for bug fixes.

I also think Reviewed-by is pretty useless.  We could get rid of it, and
only count reviews which fix bugs.  ;)

regards,
dan carpenter

