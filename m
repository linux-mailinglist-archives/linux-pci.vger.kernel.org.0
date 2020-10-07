Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A27285F42
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 14:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgJGMeX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 08:34:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59144 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgJGMeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 08:34:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097CTfeg068683;
        Wed, 7 Oct 2020 12:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=zfRpUmFdpQCTso0em57C+RfmRphvB3ppoW0Mb2JBIFA=;
 b=FlwDhldIThrx9SvZ4+mmvr+WsTRsTmNb29z2YT/24vrTG2AfqxarvrNrwXGEExxop2fx
 p+t2BRSC6DnkL+ohey50qloUHihjeyH3S9WiJwnwegI/SlWhkB8krG7RvS48lmA82quc
 SXfgNyL5hjvwjVaKzQi+KCoR1VRJSajax+n8ZPXPYy1bGEq3rqVx9HBmCmHCICcTQVQA
 BjxuQamKMUSTz/zKK/X7OwvxEgTrTuo4hoDF5bdPdH94qEg97ICKkLcufSHjzWZyZmof
 3vQ5ZXycmof9D9YeQC7R2ilqxMrUsvwEMIJguWdRKQleGz6WWPdPF3AriYXRHrk55/BU aA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33xhxn1ck9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 12:34:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097CVR0h193191;
        Wed, 7 Oct 2020 12:34:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33yyjh5a7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 12:34:07 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 097CY4EF009867;
        Wed, 7 Oct 2020 12:34:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 05:34:03 -0700
Date:   Wed, 7 Oct 2020 15:33:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: fix a potential uninitentional integer overflow
 issue
Message-ID: <20201007123045.GS4282@kadam>
References: <20201007114615.19966-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007114615.19966-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070086
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 07, 2020 at 12:46:15PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The shift of 1 by align_order is evaluated using 32 bit arithmetic
> and the result is assigned to a resource_size_t type variable that
> is a 64 bit unsigned integer on 64 bit platforms. Fix an overflow
> before widening issue by using the BIT_ULL macro to perform the
> shift.
> 
> Addresses-Coverity: ("Uninitentional integer overflow")
> Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d4d5a2f923d..1a5844d7af35 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6209,7 +6209,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  			if (align_order == -1)
>  				align = PAGE_SIZE;
>  			else
> -				align = 1 << align_order;
> +				align = BIT_ULL(align_order);

"align_order" comes from sscanf() so Smatch thinks it's not trusted.
Anything above 63 is undefined behavior.  There should be a bounds check
on this but I don't know what the valid values of "align" are.

regards,
dan carpenter

