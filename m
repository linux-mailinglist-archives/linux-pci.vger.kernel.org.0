Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB91D7993
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbfJOPRk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 11:17:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:17771 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732997AbfJOPRk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 11:17:40 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191015151737epoutp01f821ed51d7d10b5f6328203716304f42~N2wSPLORr0930609306epoutp01X
        for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2019 15:17:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191015151737epoutp01f821ed51d7d10b5f6328203716304f42~N2wSPLORr0930609306epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1571152657;
        bh=HwwCMG3Slkrqg6W0EmHIdu35ZbygqMvpKm10wWbYt4Y=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rYl6++DoUW8iKM6c3QwSNIXudMUTCIuF4kSjuh7I/gNNn6H8N38nfgd8KFVACYvmb
         xJglzPuFd+T2vI7oYDEyy1nufDwe1gF+xxhLJTRjd6ayi6l5rxJ1D+lXmZjYf0RIm3
         KBebe0kmq6OM3/Cp7L+FVcAfEHY+dWE/va6imURE=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191015151736epcas5p4db9b92c4831c38d474d5568ec8479c8e~N2wQ8FXsQ0831108311epcas5p4n;
        Tue, 15 Oct 2019 15:17:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.46.04660.013E5AD5; Wed, 16 Oct 2019 00:17:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20191015151735epcas5p3390f7c0955a628a4fe552e6a20ab2aa1~N2wQl59831352013520epcas5p3d;
        Tue, 15 Oct 2019 15:17:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191015151735epsmtrp14157eb16a7a9f0042156fd58eccb8756~N2wQg1LEo2243022430epsmtrp1h;
        Tue, 15 Oct 2019 15:17:35 +0000 (GMT)
X-AuditID: b6c32a4a-5f7ff70000001234-dd-5da5e3105446
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.1E.03889.F03E5AD5; Wed, 16 Oct 2019 00:17:35 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191015151734epsmtip2cae995d66b1a126b012d07d80cb566a1~N2wPBXUru2664726647epsmtip2S;
        Tue, 15 Oct 2019 15:17:34 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Christoph Hellwig'" <hch@infradead.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <andrew.murray@arm.com>,
        <lorenzo.pieralisi@arm.com>, <gustavo.pimentel@synopsys.com>,
        <jingoohan1@gmail.com>, <vidyas@nvidia.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>
In-Reply-To: <20191015090547.GA7199@infradead.org>
Subject: RE: [PATCH v3] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Date:   Tue, 15 Oct 2019 20:47:32 +0530
Message-ID: <000e01d5836b$ac871190$059534b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI32j4iOCLbX1pxMrCw4/raoiQM8gHGBYnvAqR4VLEBamEVbwI4vguWplZSofA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7bCmuq7A46WxBhu3c1k0/9/OanF210JW
        iyVNGRa77nawW5yesIjJYsWXmewWl3fNYbM4O+84m8Wb3y/YLa5t53Xg8lgzbw2jx85Zd9k9
        Fmwq9di8Qsujt/kdm0ffllWMHlv2f2b0+LxJLoAjissmJTUnsyy1SN8ugSvj6rYXzAWfuCs2
        T3/A1MB4jbOLkZNDQsBE4tyhJvYuRi4OIYHdjBITf72Hcj4xSqw/doMFwvnGKNF9YB8LTMum
        K5OYIBJ7GSX2/D3FCOG8ZpTYueM5I0gVm4C+xLkf81hBbBEBXYmzC1+AFTELdDNJbHjcztbF
        yMHBKWAk0dLIBVIjLBAuMWv1G3YQm0VAVWLHvv1MIDavgKXEv5vnmCFsQYmTM5+AXcEsIC+x
        /e0cZoiLFCR+Pl0GtctPoqWtnx2iRlzi5dEjYP9ICExml2htuQbV4CLx6ft0RghbWOLV8S3s
        ELaUxMv+Nig7X+LH4knMEM0tjBKTj89lhUjYSxy4MocF5AFmAU2J9bv0IZbxSfT+fsIEEpYQ
        4JXoaBOCqFaT+P78DNRaGYmHzUuZIGwPid1XZ7JMYFScheS1WUhem4XkhVkIyxYwsqxilEwt
        KM5NTy02LTDKSy3XK07MLS7NS9dLzs/dxAhOX1peOxiXnfM5xCjAwajEwzvh6tJYIdbEsuLK
        3EOMEhzMSiK881uWxArxpiRWVqUW5ccXleakFh9ilOZgURLnncR6NUZIID2xJDU7NbUgtQgm
        y8TBKdXAqPPIzdZfX01yi8ziZZFRtqHVO5cxxq6x3RC32GN5gZDUQlPtacvF31RfS2C7qPTV
        MT2vf8ols9sJaxqu6rTHyzKqP31W8PjP0ylmy3jY/3Qt/+C5WXaytZB3cUsM/8xrnJfvSr0U
        Ni+v3Xx4641N0nxNLB0iyXZVu74LxzRanbhwZuNOEWYtJZbijERDLeai4kQA7iITb1sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvC7/46WxBluPaFs0/9/OanF210JW
        iyVNGRa77nawW5yesIjJYsWXmewWl3fNYbM4O+84m8Wb3y/YLa5t53Xg8lgzbw2jx85Zd9k9
        Fmwq9di8Qsujt/kdm0ffllWMHlv2f2b0+LxJLoAjissmJTUnsyy1SN8ugSvj6rYXzAWfuCs2
        T3/A1MB4jbOLkZNDQsBEYtOVSUxdjFwcQgK7GSUmvnrBBpGQkZi8egUrhC0ssfLfc3aIopeM
        Es8vPAErYhPQlzj3Yx5YkYiArsTZhS8YQYqYBaYySaxc/Y0ZogPI2br2LpDDwcEpYCTR0sgF
        0iAsECpxe/J0RhCbRUBVYse+/UwgNq+ApcS/m+eYIWxBiZMzn7CAtDIL6Em0bQQrZxaQl9j+
        dg4zxHEKEj+fLoO6wU+ipa2fHaJGXOLl0SPsExiFZyGZNAth0iwkk2Yh6VjAyLKKUTK1oDg3
        PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4ArW0djCeOBF/iFGAg1GJh/fF9aWxQqyJZcWVuYcY
        JTiYlUR457csiRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK59/LFJIID2xJDU7NbUgtQgmy8TB
        KdXA6Gj4tGn94gvml7+fbpWtsks2Letf2lagbxCwZym/35q+5k/Vt54ET2KZ/uHJq7PVAal/
        W6Ze5X2YE3fIVFXqiF8lY8Aym9A32c+rKvWL7ga++ZIXt1Am4vVDWfG0jQ/Wb5wwuz6ZWdRP
        nis0V5n/uEhFrpR+3qew8pbfhrnTfV128XuksloosRRnJBpqMRcVJwIAbuF34LwCAAA=
X-CMS-MailID: 20191015151735epcas5p3390f7c0955a628a4fe552e6a20ab2aa1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1
References: <CGME20191015025933epcas5p1f0891dacc13648559ed8e037e49ee5b1@epcas5p1.samsung.com>
        <1571108362-25962-1-git-send-email-pankaj.dubey@samsung.com>
        <20191015081620.GA28204@infradead.org>
        <068001d58336$a76ed970$f64c8c50$@samsung.com>
        <20191015090547.GA7199@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: 'Christoph Hellwig' <hch@infradead.org>
> Sent: Tuesday, October 15, 2019 2:36 PM
> To: Pankaj Dubey <pankaj.dubey@samsung.com>
> Cc: 'Christoph Hellwig' <hch@infradead.org>; linux-pci@vger.kernel.org;
linux-
> kernel@vger.kernel.org; bhelgaas@google.com; andrew.murray@arm.com;
> lorenzo.pieralisi@arm.com; gustavo.pimentel@synopsys.com;
> jingoohan1@gmail.com; vidyas@nvidia.com; 'Anvesh Salveru'
> <anvesh.s@samsung.com>
> Subject: Re: [PATCH v3] PCI: dwc: Add support to add GEN3 related
equalization
> quirks
> 
> On Tue, Oct 15, 2019 at 02:28:00PM +0530, Pankaj Dubey wrote:
> > Is this something mandatory?
> >
> > As we discussed during first patch-set here [1] with Andrew, we have
> > need of this patch (along with some other stuffs, which will be sent
> > soon), to clean up our internal driver and make it ready for upstream.
> > As of today we have some internal restrictions where we can't make it
> > to upstream along with this patch.
> 
> We don't add code to the kernel without actual users.

OK, but do we think the current driver has only code which is being used by
some user?
At least I can see current driver has some features which is not being used
by any current driver.  

I will leave this call up-to the maintainers.
IMO, This being an DWC H/W IP feature, for me it makes sense to have it in
DWC controller driver as long as it does not break any existing
functionality, irrespective of actual user is present or not. 

