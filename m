Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F781B2969
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 16:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDUOZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 10:25:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52444 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUOZx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 10:25:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LECPuf104152;
        Tue, 21 Apr 2020 14:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KH7JSrOcrG0YkK05NQHdKXeBwOzqSpU/M/EkFRPsDJU=;
 b=OFLiLckynNhGGR/eAiiEYrtmckqtERtrg3zbWlTXTubdUgYeX6D8zCfogsqLvU5hIMy1
 nLESg71meqYz9dk8pt5Qxsf7x3FWIDchid7Dtuu1yrZ98A4heR6OSFHEg5OV0XTDhEaY
 fKD+nKPUYNw093M51+HnMNsMQ49lg+6lVI2UAntsxguELIUpy20Ju5GDDeobCplLYtlD
 yGZwDSjp4c4r1lfz0Wix1mQzL901RpGgx0gwIfNaS0+2Arvnv6SoV1fh/Z2QVwXEw61S
 LyM+gtTLd5DFsWH6iHv/mYHG0a8GiWPzsSjhrhWXe9WVxZIO9EfGj/JpAySuPxAtmXb2 WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30fsgkw880-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 14:16:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LEBd5o143244;
        Tue, 21 Apr 2020 14:14:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30gb3sa2jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 14:14:39 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03LEEaDS007921;
        Tue, 21 Apr 2020 14:14:36 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 07:14:35 -0700
Date:   Tue, 21 Apr 2020 17:14:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        james.morse@arm.com, helgaas@kernel.org, lenb@kernel.org,
        tony.luck@intel.com, gregkh@linuxfoundation.org,
        zhangliguang@linux.alibaba.com, tglx@linutronix.de,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com, yangyicong@hisilicon.com
Subject: Re: [RESEND PATCH v7 4/6] ACPI / APEI: Add callback for ARM HW
 errors to the GHES notifier
Message-ID: <20200421141426.GD2682@kadam>
References: <ShijuJose>
 <20200421132136.1595-1-shiju.jose@huawei.com>
 <20200421132136.1595-5-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421132136.1595-5-shiju.jose@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210112
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

On Tue, Apr 21, 2020 at 02:21:34PM +0100, Shiju Jose wrote:
>  static BLOCKING_NOTIFIER_HEAD(ghes_event_notify_list);
> @@ -670,12 +692,7 @@ static void ghes_do_proc(struct ghes *ghes,
>  			pr_warn(GHES_PFX "ghes event queue full\n");
>  			break;
>  		}
> -
> -		if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> -			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
> -
> -			log_arm_hw_error(err);
> -		} else {
> +		{
>  			void *err = acpi_hest_get_payload(gdata);

This is ugly.  Just move the "void *err;" declaration to the top of the
function so we can delete this block.

>  
>  			log_non_standard_event(sec_type, fru_id, fru_text,
> -- 

regards,
dan carpenter
