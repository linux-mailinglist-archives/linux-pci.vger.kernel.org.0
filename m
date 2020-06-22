Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2064E20373E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 14:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgFVMte (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 08:49:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53912 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgFVMtb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 08:49:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MCcaSv012117;
        Mon, 22 Jun 2020 12:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=86Y9KphH0K41n9/RrH5MoRxMmMMB41/XxF9s9qLpmAE=;
 b=zEKi7+e7YVW8K5QSUnie7ncKrgSB8wUbjyIbGGOv6PE/450jxXzMxjTyYdHH/xtW6ABX
 kUnAv5X3Gf4eRTPX2Jyp06dlfxiFz/TyailpiTcJBr24C6sdxpLAp45puWjwzZkiD63t
 ULrZ+PaK7s+Og5Sa2ZTIuizRIXryNbJjOSLxkvRJ0T2wYrF8tCB+LTDLFJHpqyJvKqU9
 WOTMlrLbQV9gYY3hRRWGv+ihQWYXbvCajQJVJ8M7l5UiuuuDlecdrbVKqO9j1OhTMEzM
 CvIvCFVzw5AKYbJMXHKpI5nRTBQB6fZScGKkYf9BmFgH/PzDTvk6IPV3EYY5D9OEZIZY QA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31sebbet5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 12:47:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MCdYCI178668;
        Mon, 22 Jun 2020 12:45:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31sv1kpfgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 12:45:57 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05MCjrFW001796;
        Mon, 22 Jun 2020 12:45:53 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 12:45:52 +0000
Date:   Mon, 22 Jun 2020 15:45:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shiju Jose <shiju.jose@huawei.com>,
        James Morse <james.morse@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        helgaas@kernel.org, bp@alien8.de, lenb@kernel.org,
        tony.luck@intel.com, zhangliguang@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, wangkefeng.wang@huawei.com,
        jroedel@suse.de, linuxarm@huawei.com, yangyicong@hisilicon.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com
Subject: Re: [PATCH v11 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200622124543.GV4282@kadam>
References: <20200622120527.690-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622120527.690-1-shiju.jose@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9659 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9659 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220095
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 01:05:25PM +0100, Shiju Jose wrote:
> CPER records describing a firmware-first error are identified by GUID.
> The ghes driver currently logs, but ignores any unknown CPER records.
> This prevents describing errors that can't be represented by a standard
> entry, that would otherwise allow a driver to recover from an error.
> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
> version 2.8).
> 
> patch set
> 1. add a notifier chain for these non-standard/vendor-records
>    in the ghes driver.
> 
> 2. add a driver to handle HiSilicon hip PCIe controller's errors.
>    
> Changes:
> 
> V11:
> 1. Following modifications made by James Morse in the APEI patch
>    for the vendor error record.
>    - Removed kfifo and ghes_gdata_pool. Expanded commit message.
>    
>    Note: Kept the Signed-off-by: James Morse as he is given
>    because I am not sure the right format.

Wait, what?  He doesn't seem to have given any S-o-b in the public
thread.

Signed-off-by means that you handled a patch.  Presumably you are the
maintainer and hopefully you looked at the patch before applying it.
Signed-off-by is like signing a legal document to say that you didn't
add any Top Secrety SCO UNIXWare source code.  Reviewed-by means you
reviewed it and approve.  Acked-by means you approve the patch which
sort of means you are the maintainer or you care about it for some
reason, for example, maybe there was a debate and you like the chosen
approach.

regards,
dan carpenter
