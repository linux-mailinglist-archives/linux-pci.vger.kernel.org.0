Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F603711D3
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 09:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhECHF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 03:05:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43430 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhECHF0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 03:05:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1436jSSO125386;
        Mon, 3 May 2021 07:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=A2LUi98bQEsBLs6+EHyBIVyeTOOCSHH3hPDWNj+yY6c=;
 b=Bi4VLwxwlYpvLUg5nYwEXFoLf9b1AbGySJ/WjfihKqE9kJlVg5bFWkFtVIaSTGch+n/D
 VeDURr3lKTWlZZtRdai6UcdsmIlqVqnVb0ow10CkQyBTtpKosxtB16aBHzontgI56pdx
 EZC2baxfpORkyfFFv9a8YTdHuGDFpDSKh8GOZywnEHsYowFfqG/SyC84GGB9JeJw+mb0
 c+9NxwTwZdXWM1R4/YIKBICPXaHzkW88pJqUCZfmTM4owdRMj4uX/IWSHHw9JAfxY4eN
 OKN6gTA9XDqL7hPsTk26sb91j88eGe6dhbzJsyYwM03K0magBKNsM4NO2uouisbL23Lr KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 388vgbjs15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:04:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1436jDfw072686;
        Mon, 3 May 2021 07:04:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 389grqau13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:04:08 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 143747Bk155347;
        Mon, 3 May 2021 07:04:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 389grqau0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 07:04:07 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 143741qO029906;
        Mon, 3 May 2021 07:04:04 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 07:04:01 +0000
Date:   Mon, 3 May 2021 10:03:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin King <colin.king@canonical.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: mediatek-gen3: Add missing null pointer check
Message-ID: <20210503070351.GJ1981@kadam>
References: <7a512e3a-2897-ac12-ac6e-06be28735279@wanadoo.fr>
 <20210430163450.GA657994@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210430163450.GA657994@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: -HUAwuDF2LXDw3bFyBbGcmZlTdgK708b
X-Proofpoint-ORIG-GUID: -HUAwuDF2LXDw3bFyBbGcmZlTdgK708b
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030046
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 11:34:50AM -0500, Bjorn Helgaas wrote:
> On Fri, Apr 30, 2021 at 09:47:06AM +0200, Christophe JAILLET wrote:
> > Le 29/04/2021 à 13:00, Colin King a écrit :
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > The call to platform_get_resource_byname can potentially return null, so
> > > add a null pointer check to avoid a null pointer dereference issue.
> > > 
> > > Addresses-Coverity: ("Dereference null return")
> > > Fixes: 441903d9e8f0 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >   drivers/pci/controller/pcie-mediatek-gen3.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > index 20165e4a75b2..3c5b97716d40 100644
> > > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > > @@ -721,6 +721,8 @@ static int mtk_pcie_parse_port(struct mtk_pcie_port *port)
> > >   	int ret;
> > >   	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
> > > +	if (!regs)
> > > +		return -EINVAL;
> > >   	port->base = devm_ioremap_resource(dev, regs);
> > >   	if (IS_ERR(port->base)) {
> > >   		dev_err(dev, "failed to map register base\n");
> > > 
> > 
> > Nitpick:
> >    Using 'devm_platform_ioremap_resource_byname' is slightly less verbose
> > and should please Coverity.
> 
> Not a nitpick at all.  Jianjun is correct that devm_ioremap_resource()
> does check "regs" for NULL and it fails gracefully before trying to
> dereference it, so the extra check shouldn't be needed.  And most
> cases in drivers/pci/ look like this, without the extra check:
> 
>   res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
>   base = devm_ioremap_resource(dev, res);
>   if (IS_ERR(base))
>     ...
> 
> If devm_platform_ioremap_resource_byname() keeps Coverity happy, I
> think that's what we should be doing across drivers/pci/.  Coverity
> false positives are a hassle.

Smatch knows that devm_ioremap_resource() will return ERR_PTR(-EINVAL)
when we pass it a NULL.  ;)

regards,
dan carpenter

