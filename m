Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4307E0634
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 17:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjKCQP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjKCQP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 12:15:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAC31BC;
        Fri,  3 Nov 2023 09:15:20 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3GB9JQ022682;
        Fri, 3 Nov 2023 16:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=UEmzL8XnnUaSYukwC2RWAV78gJR5Gq/WShP3uUMaefY=;
 b=IZB4gCH1AFkBYkejgH4U/VpHccDCdOf8SQJK2zwLODwI+3jf40e12QZ1H+UN22ES/VnJ
 DtX9ZGdGvuDcW5AUiknnQQK8dVM+zfSNwkzMZPz+Qeh71SxQ/RbSgm7cygSxo7jOROJp
 WdYJrwZ1mmgFo5z1pfLH42gz+pCU1aZplGJuJM6RlEnrfY+2FvFyXPATwiLVu4ODZmzO
 QCEx1a/baWFPb2UOrfjG2T+1dMOLOZzsNuOQ0th9/gz3NRYH8t+MoSs6eIDUc+zKC+rH
 1gEgw/rm6W09rsiitjoL9Fwi037P/UnA0Dp3jJlxL/RQqO9HtVBXwMVJ1/Jh6FqGoY2x ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u537tapjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 16:14:57 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3GBDet022992;
        Fri, 3 Nov 2023 16:14:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u537taphk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 16:14:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3FxRvg031377;
        Fri, 3 Nov 2023 16:14:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1fb2pjks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 16:14:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A3GEoC035455286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 16:14:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46B5A20043;
        Fri,  3 Nov 2023 16:14:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6033D20040;
        Fri,  3 Nov 2023 16:14:49 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.179.14.202])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri,  3 Nov 2023 16:14:49 +0000 (GMT)
Date:   Fri, 3 Nov 2023 17:14:47 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20231103171447.02759771.pasic@linux.ibm.com>
In-Reply-To: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zVtfq5E679MMAd25-Nm87Mk6HV4xfH4X
X-Proofpoint-ORIG-GUID: hf0ETBIVG9xLaDgnyh543ISyW9uQVwEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 03 Nov 2023 16:13:03 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> The reason for 1) is a bit more convoluted and not entirely understood
> by us. We are certain though that the function swiotlb_find_slots()
> allocates a pool with nr_slots(alloc_size), where this alloc_size is
> the alloc_size from swiotlb_tbl_map_single() + swiotlb_align_offset(),
> but for alignment reasons some slots may get "skipped over" in
> swiotlb_area_find_slots() causing the picked slots to overrun the
> allocation.
> 
> Not sure how to properly fix this as the different alignment
> requirements get pretty complex quickly. So would appreciate your
> input.

Let me post a more detailed analysis of why do we observe
swiotlb_area_find_slots() considering the slot with the
index 0 invalid in our particular case, and how does that
relate to the whole "alignment" complex.

Currently there are three distinct mechanisms that dictate the "alignment":
a) min_align_mask (introduced by 36950f2da1ea ("driver core: add a
   min_align_mask))
field to struct device_dma_parameters"))
b) alloc_size >= PAGE_SIZE which requires "page alignment"
c) alloc_aligned_mask.

In our case min_align_mask == 0 and a) is thus not applicable, because b) and
c) we end up with iotlb_align_mask = 0x800. And because orig_add & 0x800 ==
0x800 but pool->start & 0x800 == 0 and the slot at index i is skipped over. The
slot 0 is skipped over because it is page aligned, when !!((1UL << PAGE_SHIFT)
& orig_addr) 

Let us note that with the current implementation the min_align_size mask, that
is mechanism a) also controls the tlb_addr within the first slot so that:
tlb_addr & min_align_mask == orig_addr & min_align_mask. In that sense a) is
very unlike b) and c).

For example, if !min_align_mask, then tlb_addr & (IO_TLB_SIZE - 1) is always 0,
even if the alloc_size is >= PAGE_SIZE or if alloc_aligned_size is non 0.

If with b) and c) the goal is that the swiotlb buffer shall not stretch over
more pages or address space blocks of a size dictated by alloc_aligned_mask
then, that goal is accomplished. If however the goal is to preserve the offsets
modulo some exponent of 2 dictated either by PAGE_SHIFT or by alloc_aligned
mask, then that goal is not reached. 

But there is more to it! In the beginning there was b), or more precisely in the
olden days for mapping_size >= PAGE_SIZE we used to allocate properly page
aligned bounce buffers. That is tlb_addr & (~PAGE_MASK) == 0 regardless of what
orig_addr & (~PAGE_MASK) & (IO_TLB_SIZE - 1) is. That first got borked by
commit 1f221a0d0dbf ("swiotlb: respect min_align_mask") and then it did not get
fixed by commit 0eee5ae10256 ("swiotlb: fix slot alignment checks").

Let us also note that if more than one of the above mechanisms are applicable,
then for the slot selection the idea is apparently to go with the strictest
"alignment requirement", while for the offset within the slot only a) matters
(if applicable, i.e. min_align_mask != 0), which may appear strange if
not thoroughly documented.

In our opinion the first step towards getting this right is to figure out what
the different kinds of alignments are really supposed to mean. For each of the
mechanisms we need to understand and document, whether making sure that the
bounce buffer does not stretch over more of certain units of memory (like,
pages, iova granule size, whatever), or is it about preserving offset within a
certain unit of memory, and if yes to what extent (the least significant n-bits
of the orig_addr dictated by the respective mask, or something different).

Thank you for your help in advance!

Regards,
Halil and Niklas
