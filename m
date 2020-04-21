Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F5C1B2937
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDUORq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 10:17:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45008 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUORq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 10:17:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LECY4a104265;
        Tue, 21 Apr 2020 14:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=oHJJeMeEitJWhYOtSOQBtkL1oqbm06+IIBMBk4mBv7Y=;
 b=zbtxGlAOt4Jp9+5YjYI3YuE4nKiBoEva27demuki1LrUSF5meK+cir2ZLWjLlZrEEg30
 gwHuyPLiWGdaa3AYxvji1hu4Ue31uY4Ow2jh3nFeT+4e1+uuifJalGFEHHRT9WQSk5Uc
 Mw3Ho86k30Dza2SalgiD0SVfyuHC6EBOm7iTkRhIThL7T+6lr5zuI0ZCdSQEK4tfoofA
 IjnvydiWhcO6FSH13MCmvtBrezep39Z2m/R4qkwMFdB1XJcMDiiDUsEDD17qi0HtmaWi
 p9SQd0wOmxBjTd3RDImlji+qsOtYJ6daX5bmiA51dGh/EnY36zMK+R4ZsZHtJc0tcCwH +Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30fsgkw7ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 14:14:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LE7awx163772;
        Tue, 21 Apr 2020 14:12:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30gb9046eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 14:12:37 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03LECUmh018270;
        Tue, 21 Apr 2020 14:12:30 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 07:12:29 -0700
Date:   Tue, 21 Apr 2020 17:12:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        james.morse@arm.com, helgaas@kernel.org, lenb@kernel.org,
        tony.luck@intel.com, gregkh@linuxfoundation.org,
        zhangliguang@linux.alibaba.com, tglx@linutronix.de,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com, yangyicong@hisilicon.com
Subject: Re: [RESEND PATCH v7 1/6] ACPI / APEI: Add support to queuing up the
 non-fatal HW errors and notify
Message-ID: <20200421141220.GC2682@kadam>
References: <ShijuJose>
 <20200421132136.1595-1-shiju.jose@huawei.com>
 <20200421132136.1595-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421132136.1595-2-shiju.jose@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210112
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 21, 2020 at 02:21:31PM +0100, Shiju Jose wrote:
> @@ -1346,6 +1467,12 @@ static int __init ghes_init(void)
>  	else
>  		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
>  
> +	rc = ghes_gdata_pool_init();
> +	if (rc) {
> +		pr_warn(GHES_PFX "ghes_gdata_pool_init failed\n");
> +		goto err;

There probably should be some clean up on this error path.

> +	}
> +
>  	return 0;
>  err:
>  	return rc;

regards,
dan carpenter

