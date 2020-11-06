Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC83E2A90F4
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 09:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgKFIEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 03:04:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60808 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFIEq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 03:04:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A683xbP066041;
        Fri, 6 Nov 2020 08:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=OQ/5L/oc4/wCEiOu/3QR8Botu+fEhl2YqoR8s63vgq4=;
 b=CNrVNUJ30cGBaOtmhh6Svsq0E66IlgCSnOP7mcFcG8v39OSujJAC/B17S1eOk7Fsr5Ql
 tTqVAldVfjyPNOwjsA/M7p8hrhtwMD3QIldcFo/TV3/XtqdOpSI01bZf3/yVJiIIiB85
 NNhOvfLmrf60unt7H6y5XdUGSbtYxdAVFNfKgkSDWQzdK2zh5zgCN3Dnw/Uk/FiA5uWu
 RCZc+zb2uGJy0tjWeVqv+6knLMZFDkAWo3ru/aA9+MH87zSLp2Usv2/1b8AnUv+M19jO
 peMLpcRKiaC17yfSkwZDdoX7/wbAh7XVg0KjfkyEIWVZbwr2khGEN5z2NSqI2siijkLt jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34hhvcqqu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 08:04:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A67tqTY124113;
        Fri, 6 Nov 2020 08:04:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34hvs23x2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 08:04:30 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A684SoJ007269;
        Fri, 6 Nov 2020 08:04:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Nov 2020 00:04:27 -0800
Date:   Fri, 6 Nov 2020 11:04:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: fix a potential uninitentional integer overflow
 issue
Message-ID: <20201106080419.GC29398@kadam>
References: <20201007123045.GS4282@kadam>
 <20201105222430.GA499522@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105222430.GA499522@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060057
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 05, 2020 at 04:24:30PM -0600, Bjorn Helgaas wrote:
> On Wed, Oct 07, 2020 at 03:33:45PM +0300, Dan Carpenter wrote:
> > On Wed, Oct 07, 2020 at 12:46:15PM +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > The shift of 1 by align_order is evaluated using 32 bit arithmetic
> > > and the result is assigned to a resource_size_t type variable that
> > > is a 64 bit unsigned integer on 64 bit platforms. Fix an overflow
> > > before widening issue by using the BIT_ULL macro to perform the
> > > shift.
> > > 
> > > Addresses-Coverity: ("Uninitentional integer overflow")
> 
> s/Uninitentional/Unintentional/
> Also in subject (please also capitalize subject)
> 
> Doesn't Coverity also assign an ID number for this specific issue?
> Can you include that as well, e.g.,
> 
>   Addresses-Coverity-ID: 1226899 ("Unintentional integer overflow")
> 
> > > Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/pci/pci.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 6d4d5a2f923d..1a5844d7af35 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -6209,7 +6209,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> > >  			if (align_order == -1)
> > >  				align = PAGE_SIZE;
> > >  			else
> > > -				align = 1 << align_order;
> > > +				align = BIT_ULL(align_order);
> > 
> > "align_order" comes from sscanf() so Smatch thinks it's not trusted.
> > Anything above 63 is undefined behavior.  There should be a bounds check
> > on this but I don't know what the valid values of "align" are.
> 
> The spec doesn't explicitly say what the size limit for 64-bit BARs
> is, but it does say 32-bit BARs can support up to 2GB (2^31).  So I
> infer that 2^63 would be the limit for 64-bit BARs.
> 
> What about something like the following?  To me, BIT_ULL doesn't seem
> like an advantage over "1ULL << ", but maybe there's a reason to use
> it.

The advantage of BIT_ULL() is that checkpatch and I think Coccinelle
will suggest using it.  It's only recently where a few people have
complained (actually you're probably the second person) that BIT() is
sort of a weird thing to use for size variables.

regards,
dan carpenter
