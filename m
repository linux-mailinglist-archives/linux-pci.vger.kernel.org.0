Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397202E2489
	for <lists+linux-pci@lfdr.de>; Thu, 24 Dec 2020 07:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgLXGEA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Dec 2020 01:04:00 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51830 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgLXGD7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Dec 2020 01:03:59 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201224060314epoutp012e08d9c4843849021886a64a4ac579e7~TkcttWqmZ1571215712epoutp01G
        for <linux-pci@vger.kernel.org>; Thu, 24 Dec 2020 06:03:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201224060314epoutp012e08d9c4843849021886a64a4ac579e7~TkcttWqmZ1571215712epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1608789794;
        bh=pugVbrIktDR451e/CFaYW+UN8OF55rTbO/3+HSOplXY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=ruF0xuHdR5aUKn26MzLGSQSNiRhb0mU0lUZYBScDf76m+HvQ9lwbB3pB6o6S0Z8Fg
         QZYeTpMsBYWtTJRxSBDf97F3jPuRHHFI4hQ9deUc9j1jT0Nwvo0B1MOWQIAFcgm+aR
         hgIrnW047DVPKTVWx7Sll5hMoiOFFNMKs9WxIJoE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20201224060312epcas5p30a9b993a98e2a90bb163cae9c8bb1fa2~TkcrawTn91936419364epcas5p3l;
        Thu, 24 Dec 2020 06:03:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.6C.50652.02F24EF5; Thu, 24 Dec 2020 15:03:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20201224055037epcas5p2218eec841b2336f25c9e1fd75fbb5373~TkRssfq462924929249epcas5p2c;
        Thu, 24 Dec 2020 05:50:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201224055037epsmtrp2aaa50c945d85f84436006814bab4d863~TkRsrtreU0103201032epsmtrp2W;
        Thu, 24 Dec 2020 05:50:37 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-14-5fe42f202537
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.AC.13470.D2C24EF5; Thu, 24 Dec 2020 14:50:37 +0900 (KST)
Received: from shradhat02 (unknown [107.122.8.248]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20201224055033epsmtip1ad5ccb829235927285b570222c4427d4~TkRo-_zfx0255402554epsmtip1E;
        Thu, 24 Dec 2020 05:50:33 +0000 (GMT)
From:   "Shradha Todi" <shradha.t@samsung.com>
To:     "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kishon@ti.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <pankaj.dubey@samsung.com>,
        "'Sriram Dash'" <sriram.dash@samsung.com>
In-Reply-To: <20201223203403.GA320059@bjorn-Precision-5520>
Subject: RE: [PATCH v2] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Thu, 24 Dec 2020 11:20:30 +0530
Message-ID: <096301d6d9b8$b440be00$1cc23a00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHOFva8Guq/R8Jw43oBy2JTBKpOfAKJ6izDqgLzgjA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7bCmpq6C/pN4g3OfBSyWNGVYvDqzls3i
        wtMeNovLu+awWZydd5zN4s3vF+wWi7Z+Ybe4sZ7dgcNjzbw1jB4LNpV6bFrVyebRt2UVo8fx
        G9uZPD5vkgtgi+KySUnNySxLLdK3S+DKmPCym7nglHDF9ntCDYxLBboYOTkkBEwk9k7YzNbF
        yMUhJLCbUeLnwv9MEM4nRokpK9sYIZxvjBLTL+xghWlZtf8OVMteRonmGR+YIZwXjBIzP/1n
        BqliE9CReHLlD5gtIqAlcfzgfrBuZoHzjBK7r7KD2JwC1hL3p5xlArGFBaIkZi18CVbPIqAq
        se/vBzCbV8BSouf7d3YIW1Di5MwnLBBz5CW2v53DDHGRgsTPp8tYIXZZSTw4tpUZokZc4uXR
        I+wgx0kILOSQ2HTnNyNEg4vEtH1/oWxhiVfHt7BD2FISn9/tZYOw8yWmXngKtIwDyK6QWN5T
        BxG2lzhwZQ5YmFlAU2L9Ln2IsKzE1FPrmCDW8kn0/n7CBBHnldgxD8ZWlvjydw8LhC0pMe/Y
        ZdYJjEqzkHw2C8lns5B8MAth2wJGllWMkqkFxbnpqcWmBUZ5qeV6xYm5xaV56XrJ+bmbGMFJ
        SctrB+PDBx/0DjEycTAeYpTgYFYS4b3E/zheiDclsbIqtSg/vqg0J7X4EKM0B4uSOO8Ogwfx
        QgLpiSWp2ampBalFMFkmDk6pBqY9ebdXe0Xo3OWtMM++t20j+9q9rzece+t56QPr5dsvfn2r
        PbtGJCv9S1pN4CV7F+aNT4xmZs6fGHxsW4rM58eWnSdl1nJMf1xzZWmB9bQ6j4OpG1fq/bR+
        9jHBxl2ljpdZsKps3qJ/txrFT9oLJ35bU+db2NTHI98QpL336sfCJR9iv855K1Uo9etS1Znl
        205/Xumwe8GZ3FvBvgb3ZL8aGL5gDm/NCg5TDZXm6Pqq+mHms4cbbiw3Cujse3TtUGrz82cr
        y3Nc9+1S0t79uPLQpB2Jqy43/SiKLJvr0nl/UtJF5zbTtqlOnsKpmSY7X2SWSU4sS384d7n4
        hhyFm5VZWv7dG6zqPKKEWQNtGh8rsRRnJBpqMRcVJwIAAuF1krkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTldX50m8wZWb6hZLmjIsXp1Zy2Zx
        4WkPm8XlXXPYLM7OO85m8eb3C3aLRVu/sFvcWM/uwOGxZt4aRo8Fm0o9Nq3qZPPo27KK0eP4
        je1MHp83yQWwRXHZpKTmZJalFunbJXBlTHjZzVxwSrhi+z2hBsalAl2MnBwSAiYSq/bfYeti
        5OIQEtjNKHHkwkt2iISkxOeL65ggbGGJlf+es0MUPWOUOHCyEyzBJqAj8eTKH2YQW0RAS+L4
        wf2sIEXMAtcZJdp+XIQa28MosXzeLrCxnALWEvennAXrFhaIkFhwezEbiM0ioCqx7+8HsEm8
        ApYSPd+/s0PYghInZz5h6WLkAJqqJ9G2kREkzCwgL7H97RxmiOsUJH4+XcYKcYSVxINjW5kh
        asQlXh49wj6BUXgWkkmzECbNQjJpFpKOBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLz
        czcxgmNLS3MH4/ZVH/QOMTJxMB5ilOBgVhLhvcT/OF6INyWxsiq1KD++qDQntfgQozQHi5I4
        74Wuk/FCAumJJanZqakFqUUwWSYOTqkGpowNflMWHLK6d+iKOZuwjkHqK/+pPD/aTYOvllV9
        vDZNdf6u2F8/wh/X7mOd9FiiQFDP4XphTHXE1zC3JN3IXcL+N3ZIWUXeCH3x8PcTn8Mpi1+Z
        CD0sWdLus/ZlYYyPanmYtFS+oKrI152ZVz+a/NTwk+Wzi9BVPlfmfHHXquDfF/d1hXPet2TM
        TOMonf8zdveC+Sv0G6eXPbDz/nuyWMY4/mts2P+fvT1m7EEJVjkuxbxB/L9e39jKVKxcWmL+
        MenGy6xtq9Lu6fNPurVOrDbSiHmfipjpwX/LKx0/5bHXr/7xWLRx0ZHzgkk7Zu87EaFvzxyR
        yvB7CcfuCa32Owp0ItdOE26ZuXZjJEuUEktxRqKhFnNRcSIArB4E4RwDAAA=
X-CMS-MailID: 20201224055037epcas5p2218eec841b2336f25c9e1fd75fbb5373
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201223203408epcas5p3909fa2bbaa075ae7253f720c7fca7685
References: <CGME20201223203408epcas5p3909fa2bbaa075ae7253f720c7fca7685@epcas5p3.samsung.com>
        <20201223203403.GA320059@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Subject: Re: [PATCH v2] PCI: endpoint: Fix NULL pointer dereference for -
> >get_features()
> 
> On Fri, Dec 18, 2020 at 09:15:16PM +0530, Shradha Todi wrote:
> > get_features ops of pci_epc_ops may return NULL, causing NULL pointer
> > dereference in pci_epf_test_bind function. Let us add a check for
> > pci_epc_feature pointer in pci_epf_test_bind before we access it to
> > avoid any such NULL pointer dereference and return -ENOTSUPP in case
> > pci_epc_feature is not found.
> 
> Can you add a Fixes: tag to identify where this broke to help people
decide
> where to backport the fix?
> 

Thanks for the review. Sure we will add the Fixes tag and respin this patch.

> > Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> > v2:
> >  rebase on v1
> >  v1:
> > https://protect2.fireeye.com/v1/url?k=6193fa90-3e08c3dd-619271df-0cc47
> > aa8f5ba-a79111ee2c1d1660&q=1&e=a9ee1ef7-2713-4099-8d06-
> 738532d78b26&u=
> > https%3A%2F%2Flore.kernel.org%2Fpatchwork%2Fpatch%2F1208269%2F
> >
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> > b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 66723d5..f1842e6 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -835,13 +835,16 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> >  		return -EINVAL;
> >
> >  	epc_features = pci_epc_get_features(epc, epf->func_no);
> > -	if (epc_features) {
> > -		linkup_notifier = epc_features->linkup_notifier;
> > -		core_init_notifier = epc_features->core_init_notifier;
> > -		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> > -		pci_epf_configure_bar(epf, epc_features);
> > +	if (!epc_features) {
> > +		dev_err(&epf->dev, "epc_features not implemented\n");
> > +		return -EOPNOTSUPP;
> >  	}
> >
> > +	linkup_notifier = epc_features->linkup_notifier;
> > +	core_init_notifier = epc_features->core_init_notifier;
> > +	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> > +	pci_epf_configure_bar(epf, epc_features);
> > +
> >  	epf_test->test_reg_bar = test_reg_bar;
> >  	epf_test->epc_features = epc_features;
> >
> > --
> > 2.7.4
> >

