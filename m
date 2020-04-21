Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285C61B295E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Apr 2020 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgDUOX1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Apr 2020 10:23:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55356 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDUOX0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Apr 2020 10:23:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LEIQx0026976;
        Tue, 21 Apr 2020 14:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=f5aD8pgWxHxEjz1LLkoXGH2rZZdsFggSpF7wYFrWCWY=;
 b=Xy+usVnFqGUdDjFYo5QUR0SsJ3tzjlYNPORyjkjkZmuFM6q649ZXrqY7sfHNVwZKNbNB
 72wtfij5+qDue9f3mrbgQzMutyuzBGqSe6wuggv2XICc+MQ+PzdthIRlNHM/MO9l+7lt
 8RxaRRU8+rqAaWQCxVQFH0KkoiM2d+rKQ/Cv5iYZVacQ5EpP/ssslH3d5SOCl2KMUdvG
 H9Qn44LhPoF6Q7qGmBnDXl1fC4AyuTOAzn253EuA6FOTie+IyJr1UOQlEBtu977jtqcM
 QFlzm+hDzJM4o8bRvSJ9d2eJo4gtsu49ogWnQYS3nG6/eU2t2DEDpmKpih5mFxnKvVyt wQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30grpghq9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 14:22:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LEHdfh162816;
        Tue, 21 Apr 2020 14:20:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30gb3sacrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 14:20:29 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03LEKPro011373;
        Tue, 21 Apr 2020 14:20:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 07:20:25 -0700
Date:   Tue, 21 Apr 2020 17:20:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, bp@alien8.de,
        james.morse@arm.com, helgaas@kernel.org, lenb@kernel.org,
        tony.luck@intel.com, gregkh@linuxfoundation.org,
        zhangliguang@linux.alibaba.com, tglx@linutronix.de,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        tanxiaofei@huawei.com, yangyicong@hisilicon.com
Subject: Re: [RESEND PATCH v7 6/6] PCI: hip: Add handling of HiSilicon HIP
 PCIe controller errors
Message-ID: <20200421142014.GE2682@kadam>
References: <ShijuJose>
 <20200421132136.1595-1-shiju.jose@huawei.com>
 <20200421132136.1595-7-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421132136.1595-7-shiju.jose@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=2 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=2 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210112
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 21, 2020 at 02:21:36PM +0100, Shiju Jose wrote:
> +static int hisi_pcie_error_handler_probe(struct platform_device *pdev)
> +{
> +	struct hisi_pcie_error_private *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->nb.notifier_call = hisi_pcie_notify_error;
> +	priv->pdev = pdev;
> +	ret = ghes_register_event_notifier(&priv->nb);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s : ghes_register_event_notifier fail\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int hisi_pcie_error_handler_remove(struct platform_device *pdev)
> +{
> +	struct hisi_pcie_error_private *priv = platform_get_drvdata(pdev);
> +
> +	if (priv)
> +		ghes_unregister_event_notifier(&priv->nb);

Delete this NULL check.  The remove function isn't called on stuff which
hasn't been allocated.

The "never free things which haven't been allocated" rule is a good rule
to keep in mind because it makes error handling so much simpler.

> +
> +	kfree(priv);
> +
> +	return 0;
> +}

regards,
dan carpenter
