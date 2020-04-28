Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF881BBE8F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgD1NH7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 09:07:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55216 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgD1NH7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2020 09:07:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SD2jZp028814;
        Tue, 28 Apr 2020 13:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=pDHU9M6f72WUZ/ZNWExBD4yEfNasWsxAFE00KhinmNc=;
 b=mqAjY9DCEo1NMLw75T9dtlA6mWmqn4hsaw1BnKMfD4iOfaCJ3rPoMigwbIDmQbsOF36w
 H4upoPliuTHWYi/atRbVLBJmSULIW+JhYoLzqianNfKynu7j1Ny6sW/N50uD4aJBXV/s
 EDnHS9yEFb8G//sfi4BWTjAhj/3jkE3dcUIOVO3TE+qBU5yz+ISOMn4K19jgWhppEaKL
 KXkJS6UPQPAXdkC2Jo0DDGq3YsKAfdqf6a3oSqnpkb+kdJe/nRzgUpyKW/m0iMrEKBSy
 Ikk40XtAVEwlB9UkZxckzAfLbrEaKjMJcXRFXD16eJ3R23Meg1I358M3c1tFmM7ss+cv gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30nucfyteh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 13:07:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SD1uQg029938;
        Tue, 28 Apr 2020 13:07:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30mxwyqn8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 13:07:44 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SD7gXm002218;
        Tue, 28 Apr 2020 13:07:42 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 06:07:41 -0700
Date:   Tue, 28 Apr 2020 16:07:34 +0300
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
Message-ID: <20200428130734.GF2014@kadam>
References: <20200427111044.162618-1-weiyongjun1@huawei.com>
 <cad871c8-0915-9dda-2c61-30dfb5504d23@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cad871c8-0915-9dda-2c61-30dfb5504d23@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280102
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 27, 2020 at 05:29:50PM +0530, Vignesh Raghavendra wrote:
> Hi,
> 
> On 27/04/20 4:40 pm, Wei Yongjun wrote:
> > platform_get_resource() may fail and return NULL, so we should
> > better check it's return value to avoid a NULL pointer dereference
> > a bit later in the code.
> > 
> > This is detected by Coccinelle semantic patch.
> > 
> > @@
> > expression pdev, res, n, t, e, e1, e2;
> > @@
> > 
> > res = \(platform_get_resource\|platform_get_resource_byname\)(pdev, t, n);
> > + if (!res)
> > +   return -EINVAL;
> > ... when != res == NULL
> > e = devm_ioremap(e1, res->start, e2);
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/pci/controller/dwc/pci-dra7xx.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> > index 3b0e58f2de58..7a3d12f7e7d9 100644
> > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > @@ -878,6 +878,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
                                           ^^^^

> > +	if (!res)
> > +		return -EINVAL;
> > +
> >  	base = devm_ioremap(dev, res->start, resource_size(res));
                            ^^^
> 
> I don't see why this should be devm_ioremap(). It should also have been
> devm_ioremap_resource() which does the NULL check.

It's different device pointers.

regards,
dan carpenter

