Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1815C7E548B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 11:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbjKHKxR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 05:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbjKHKxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 05:53:00 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23547C6;
        Wed,  8 Nov 2023 02:52:46 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8AjBmp006482;
        Wed, 8 Nov 2023 10:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y6n9Wq/1lf6ns5MR5hkNe3aObEjXjSgg3FSfX8KTZQs=;
 b=j9YzRz0uUiZGyCnQWMsCL8++tgBaXnTK6G5twhpJ8v4h4EcIAI3KGQ6aOd73/6KJ9LUf
 Vs0MSWfIUztqahWCSZOtYN/+VLzO8ImiOHbaLXA7IUimQvIn3FWD5ni05QDvY6E7AEhf
 HewSIQRWIkWkx0UklD6gmf8l24ZUrCh/fKaaMCskdWcUrpKZ6/SB0PYgdSULgChTWhFQ
 oxZCRkuzcYGDuph7aYI2Suh46WYA512dzTN9KlgVMSlEZbTJC2mBcWY+TlB6tG6UM84u
 pFznS6nqlPSn2CtSqSexw3MgEQ/cGGDnAbv35lZG2fZ1NQzlH8Uk9AmB7Ss2q5jgFkqQ Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u88uqrf9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 10:52:16 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A8AjQxd009025;
        Wed, 8 Nov 2023 10:52:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u88uqrf7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 10:52:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88V7pS019256;
        Wed, 8 Nov 2023 10:52:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w23v4ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 10:52:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A8Aq9eM41484886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 10:52:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40B2420043;
        Wed,  8 Nov 2023 10:52:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E87A520040;
        Wed,  8 Nov 2023 10:52:08 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Nov 2023 10:52:08 +0000 (GMT)
Date:   Wed, 8 Nov 2023 11:52:07 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231108115207.791a30d8.pasic@linux.ibm.com>
In-Reply-To: <20231103195949.0af884d0@meshulam.tesarici.cz>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
 <20231103195949.0af884d0@meshulam.tesarici.cz>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qK8Ky8dtByMWS9pE01Wz3idCdL0ui5So
X-Proofpoint-ORIG-GUID: LT_y2TRDzFp56vukj3DHi7MXpkTZAqPi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080090
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Nov 2023 19:59:49 +0100
Petr Tesařík <petr@tesarici.cz> wrote:

> > Not sure how to properly fix this as the different alignment
> > requirements get pretty complex quickly. So would appreciate your
> > input.  
> 
> I don't think it's possible to improve the allocation logic without
> modifying the page allocator and/or the DMA atomic pool allocator to
> take additional constraints into account.

I don't understand. What speaks against calculating the amount of space
needed, so that with the waste we can still fit the bounce-buffer in the
pool?

I believe alloc_size + combined_mask is a trivial upper bound, but we can
do slightly better since we know that we allocate pages.

For the sake of simplicity let us assume we only have the min_align_mask
requirement. Then I believe the worst case is that we need 
(orig_addr & min_align_mask & PAGE_MASK)  + (min_align_mask & ~PAGE_MASK)
extra space to fit.

Depending on how the semantics pan out one may be able to replace
min_align_mask with combined_mask.

Is your point that for large combined_mask values 
_get_free_pages(GFP_NOWAIT | __GFP_NOWARN, required_order) is not
likely to complete successfully?

Regards,
Halil




