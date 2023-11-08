Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8423A7E590B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 15:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjKHOdV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 09:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjKHOdV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 09:33:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F621BC3;
        Wed,  8 Nov 2023 06:33:19 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8EQjYw007176;
        Wed, 8 Nov 2023 14:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=iVZQPSQlxOZFIinRyegJybgwuwvN5FJQ3+IaimML/+c=;
 b=OaHcGP0XZ+RG1HLCUOqf7lBEOcDfpbxjSbna+bem7P7/V7o6EGEkwbj+RlV9UBSxQ8j1
 k5IoWHAfjjqI/ER5X39hB+DuJa4krjJgKmqbJ3Eif1w1zLzrbxwAoKzrRAbP4cIKVAuJ
 ZBx7qY/tlJGsT1zpgPnuikHjF0kWN2dwaJhUY2ukge3BVUyY0xj9C2NWLiIcLP0DwZKr
 EL0sKkSZGIsOglQkb0QalgVlZ1CMZ2PW6NH9w5l61uWa/ExObiIuTfRYmNv1j/nn2dEt
 FLOqV88cPAvDi2meaMX0hnCpfCKtOzPO5PD16TZ2aezI7Uu6qhHTsckPMrCtUeui/bUG zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8bvw0m40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 14:32:36 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A8ERb35010952;
        Wed, 8 Nov 2023 14:32:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8bvw0m38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 14:32:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8E937K019252;
        Wed, 8 Nov 2023 14:32:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w23waa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 14:32:35 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A8EWWRt35848650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 14:32:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C0312004B;
        Wed,  8 Nov 2023 14:32:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 246B920040;
        Wed,  8 Nov 2023 14:32:32 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Nov 2023 14:32:32 +0000 (GMT)
Date:   Wed, 8 Nov 2023 15:32:30 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Petr Tesarik <petr.tesarik1@huawei-partners.com>
Cc:     Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231108153230.6491acaa.pasic@linux.ibm.com>
In-Reply-To: <41c0baf6-ba4d-4876-b692-279307265466@huawei-partners.com>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
        <20231103195949.0af884d0@meshulam.tesarici.cz>
        <20231108115207.791a30d8.pasic@linux.ibm.com>
        <41c0baf6-ba4d-4876-b692-279307265466@huawei-partners.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7hWnKvoaWTdQirWACccrbSjT6L0jMbwT
X-Proofpoint-ORIG-GUID: T6ZtTqmIdT7xJV2AKSQwEDoIWxM12PPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_03,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=805 mlxscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080120
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 8 Nov 2023 12:04:12 +0100
Petr Tesarik <petr.tesarik1@huawei-partners.com> wrote:
[..]
> > 
> > For the sake of simplicity let us assume we only have the min_align_mask
> > requirement. Then I believe the worst case is that we need 
> > (orig_addr & min_align_mask & PAGE_MASK)  + (min_align_mask & ~PAGE_MASK)
> > extra space to fit.
> > 
> > Depending on how the semantics pan out one may be able to replace
> > min_align_mask with combined_mask.
> > 
> > Is your point that for large combined_mask values 
> > _get_free_pages(GFP_NOWAIT | __GFP_NOWARN, required_order) is not
> > likely to complete successfully?  
> 
> Yes, that's the reason. OTOH it's probably worth a try. The point is
> that mapping a DMA buffer is allowed to fail, so callers should be
> prepared anyway.
> 
> And for the case you reported initially, I don't think there is any need
> to preserve bit 11 (0x800) from the original buffer's physical address,
> which is enough to fix it. See also my other email earlier today.

Hm. Do you mean "[PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations
with CONFIG_SWIOTLB_DYNAMIC" or a different one?

I only see "[PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations
with CONFIG_SWIOTLB_DYNAMIC" but I don't think that one takes
care of "I don't think there is any need to preserve bit 11 (0x800)
from the original buffer's physical address". But it should take care of
the corruption, I agree with that. I hope to provide review for that
patch by the end of the day.

Regards,
Halil



