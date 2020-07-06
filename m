Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F5215827
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgGFNRi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 09:17:38 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:12246 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgGFNRh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jul 2020 09:17:37 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200706131735epoutp0426b4b9f7fb8912a92a5fc27a2193b785~fLEIxF4d53155631556epoutp04J
        for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2020 13:17:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200706131735epoutp0426b4b9f7fb8912a92a5fc27a2193b785~fLEIxF4d53155631556epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594041455;
        bh=KjGMvpbBplrRVXqi2JfJREM/WgEwIEVIJcyF61obP1Y=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=QgG4AqQwQvi8a+oN9OF0A/nuqNY7yEQRwbPFj4XSl+tyIJkR/8tvkcaXkNm5LN0gk
         tfC7cZybhg8eqKKubEZtPdiqv9i8RcznQSOm/aoCIR/SFWqcYj5yWKAHGnadzNQpmZ
         3sZqjhhLArHtHbdRQPtaq9PZQDVDbG422ngpaq6s=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200706131735epcas5p2c3fa8058bd38441969711444c0d3a646~fLEIV0Mq50184801848epcas5p21;
        Mon,  6 Jul 2020 13:17:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.C2.09475.F64230F5; Mon,  6 Jul 2020 22:17:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200706131734epcas5p344bc0069bdf4f82603bcea0412c52b79~fLEHd3mBl0599605996epcas5p3-;
        Mon,  6 Jul 2020 13:17:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200706131734epsmtrp115d12d0616111d95bce7ed0ccc340f27~fLEHdKWBY0199601996epsmtrp1e;
        Mon,  6 Jul 2020 13:17:34 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-27-5f03246fe947
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.BA.08303.E64230F5; Mon,  6 Jul 2020 22:17:34 +0900 (KST)
Received: from sriramdash03 (unknown [107.108.234.13]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200706131732epsmtip2364b290c8fa6c83414a9953a81cd06bd~fLEFeK6U90960509605epsmtip2T;
        Mon,  6 Jul 2020 13:17:32 +0000 (GMT)
From:   "Sriram Dash" <sriram.dash@samsung.com>
To:     "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>
Cc:     "'Kishon Vijay Abraham I'" <kishon@ti.com>,
        "'Shradha Todi'" <shradha.t@samsung.com>, <bhelgaas@google.com>,
        <pankaj.dubey@samsung.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20200706111708.GF26377@e121166-lin.cambridge.arm.com>
Subject: RE: [PATCH] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Mon, 6 Jul 2020 18:47:30 +0530
Message-ID: <027101d65397$cf7ef760$6e7ce620$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQIRa+BXjMtyeVOz/ELce4dgT57WJwIqUA0mAt3aYLECuy3/8gLh+aTgAbYxJMuoIXtK8A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmhm6+CnO8wd59EhZLmjIsLjztYbO4
        vGsOm8XZecfZLN78fsFusWjrF3aL3sO1Duwea+atYfRYsKnUo2/LKkaP4ze2M3l83iQXwBrF
        ZZOSmpNZllqkb5fAlTHtxE7mgmeiFWuPfWBpYJwv2MXIwSEhYCLxqNO1i5GLQ0hgN6PE4VcP
        WSCcT4wS266uZIdwPjNK/HjSwdTFyAnWMe/mdqjELkaJPw0f2UASQgKvGSWm/S0CsdkEdCXO
        3mgCi4sImEocefURrIFZ4AyjxLxbj5hBdnMKOEts3soJUiMsEC6xYv5NRhCbRUBF4unzq2A2
        r4ClxP1Z75ghbEGJkzOfsIDYzALyEtvfzmGGOEhB4ufTZawQcXGJoz97wMaLCIRJ/PxfD7JW
        QmAmh8TxK7dZIOpdJGbtP8YIYQtLvDq+hR3ClpJ42d8GZWdLXO57DjW/RGLGq4VQvfYSB67M
        YQGZzyygKbF+lz7EWj6J3t9PmCAhyivR0SYEUa0q8er2ZqiJ0hIH1p6GBqGHxNcJF5gmMCrO
        QvLYLCSPzULyzCyEZQsYWVYxSqYWFOempxabFhjnpZbrFSfmFpfmpesl5+duYgQnHy3vHYyP
        HnzQO8TIxMF4iFGCg1lJhLdXmzFeiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/SjzNxQgLpiSWp
        2ampBalFMFkmDk6pBib7ln9q586bJ69XKOZf8+lKmek6BcXnprMTDn57fUEracYRrpuegQ8K
        Zh+wlDHq/32oIyh+Qav0htoNF++/CLDczqa0iiUh6VZVy7NQLdMzZk6FFxz9xf0Yr7OmWJ94
        ZfRGT2PnKt21Kz9ZrSmUPbniytTPWbl2zhVv6t+aPV9yM+he8NXwiLJHZQXldxTOZ/ivSJsw
        eY5AZ9eJ7ztzD6bJ8iS5HzPqy7j9/oxejMdV6U+Cxg6beH9ZflEyF7e5tdL9qJ+axNLdp8RF
        3i96Mf9PcdAH1nkpIX8Wrb/RV8d57X/QqgenTgted208otVwidf2yrWn/4rbu97l/7KdcKVk
        ftxR7vYNC/ne7mGbr+KpxFKckWioxVxUnAgAoj8l2q0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSvG6eCnO8QeMNKYslTRkWF572sFlc
        3jWHzeLsvONsFm9+v2C3WLT1C7tF7+FaB3aPNfPWMHos2FTq0bdlFaPH8RvbmTw+b5ILYI3i
        sklJzcksSy3St0vgyph2YidzwTPRirXHPrA0MM4X7GLk5JAQMJGYd3M7excjF4eQwA5GiW8t
        xxm7GDmAEtISP+/qQtQIS6z89xyq5iWjxPU551lBEmwCuhJnbzSxgdgiAqYSR159BCtiFrjE
        KLFpaw8TRMcZJom3E7+zgUzlFHCW2LyVE6RBWCBU4mPbVLBBLAIqEk+fX2UEsXkFLCXuz3rH
        DGELSpyc+YQFpJVZQE+ibSNYCbOAvMT2t3OYIY5TkPj5dBkrRFxc4ujPHmaQchGBMImf/+sn
        MArPQjJoFsKgWUgGzULSvICRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnAMaWnt
        YNyz6oPeIUYmDsZDjBIczEoivL3ajPFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb/OWhgnJJCe
        WJKanZpakFoEk2Xi4JRqYFr+TYyR54200B2F3q/it/yY9+ddeSHybeOVJMtPzpOmNlSEMqS8
        bjhslNuq8u6n31XXlXd9ZgpwSKraHAoQ3xzu0HyVI5d/74TktrxMi2ubXu7aP6O6U+3pln9z
        vtXdl7rof2LNB1XpCWXXHz724lWOOta591tJydQv69s4jHQDL97jyWze+XdK9YNdq24t/1O+
        3W374qxvGUrKMnNNzb5fZnh7l+n77aDPuS7fW7bc/sN1au7WuYvX2x4tPitcz/57j/u11+at
        x/LZ2/mdeuNvXtpcF/H259THYvwn2IObpjluqf61bcXthW8mLlivcLRh9f1qximdzt0SMxtN
        Zj2xabx9+u0jBc7vTzbdav49UYmlOCPRUIu5qDgRAELBkFkQAwAA
X-CMS-MailID: 20200706131734epcas5p344bc0069bdf4f82603bcea0412c52b79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132
References: <CGME20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132@epcas5p2.samsung.com>
        <20200311102852.5207-1-shradha.t@samsung.com>
        <000d01d5fdf3$55d43af0$017cb0d0$@samsung.com>
        <a7a6a295-160a-94d6-09f9-63f783c8b28a@ti.com>
        <000001d608fb$7ab39010$701ab030$@samsung.com>
        <20200706111708.GF26377@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: 06 July 2020 16:47
> Subject: Re: [PATCH] PCI: endpoint: Fix NULL pointer dereference for -
> >get_features()
> 
> On Thu, Apr 02, 2020 at 08:01:59PM +0530, Sriram Dash wrote:
> 
> [...]
> 
> > > So the patch itself is correct though the commit log has to be
> > > fixed. You should also check if all the endpoint controller drivers
> > > existing currently provides epc_features.
> >
> > At the moment, there is no issue for existing controller drivers as I
> > can see almost all drivers are providing epc_features. But, this is
> > not a mandatory feature and some controller drivers may not have
> > epc_features implemented, may be in the near future.  But because we
> > are dealing with the configfs, the application need not bother about
> > the driver details underneath.
> >
> > IMO, the code should be fixed regardless and should not cause panic in
> > any case.
> 
> What's this patch status please ?
>

Its not in the mainline tree as of now. However, we feel its important for
the drivers not using epc_features.
 
> Thanks,
> Lorenzo
> 
> > > Thanks
> > > Kishon
> > > >
> > > >
> > > >>  drivers/pci/endpoint/functions/pci-epf-test.c | 15
> > > >> +++++++++------
> > > >>  1 file changed, 9 insertions(+), 6 deletions(-)
> > > >>
> > > >> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > >> b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > >> index c9121b1b9fa9..af4537a487bf 100644
> > > >> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > >> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > >> @@ -510,14 +510,17 @@ static int pci_epf_test_bind(struct pci_epf
*epf)
> > > >>  		return -EINVAL;
> > > >>
> > > >>  	epc_features = pci_epc_get_features(epc, epf->func_no);
> > > >> -	if (epc_features) {
> > > >> -		linkup_notifier = epc_features->linkup_notifier;
> > > >> -		msix_capable = epc_features->msix_capable;
> > > >> -		msi_capable = epc_features->msi_capable;
> > > >> -		test_reg_bar =
pci_epc_get_first_free_bar(epc_features);
> > > >> -		pci_epf_configure_bar(epf, epc_features);
> > > >> +	if (!epc_features) {
> > > >> +		dev_err(dev, "epc_features not implemented\n");
> > > >> +		return -ENOTSUPP;
> > > >>  	}
> > > >>
> > > >> +	linkup_notifier = epc_features->linkup_notifier;
> > > >> +	msix_capable = epc_features->msix_capable;
> > > >> +	msi_capable = epc_features->msi_capable;
> > > >> +	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> > > >> +	pci_epf_configure_bar(epf, epc_features);
> > > >> +
> > > >>  	epf_test->test_reg_bar = test_reg_bar;
> > > >>  	epf_test->epc_features = epc_features;
> > > >>
> > > >> --
> > > >> 2.17.1
> > > >
> > > >
> >

