Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64117E46CF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 18:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjKGRZB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 12:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjKGRZA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 12:25:00 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAB2101;
        Tue,  7 Nov 2023 09:24:58 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7H2u15018218;
        Tue, 7 Nov 2023 17:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=FwHBIMvjBC+wJGhIitQ/XRmZQN7ARfRJ6C0OEowiUGM=;
 b=FlzGnviMq9nzFCcQXnaBji8CYkUYl7o6o7uz8VLEfMBoc8M/5HGn07OfuHwyy2tRA5zK
 QxNa9q1dNxzV1y2g546Vm5XyGiLWI5FewE2F0EU2jLvZtbqwn2gRC4eNRxEanQcplaKK
 S4fSi6As9gDP9JrZrBJp2nK0JsJp2Gx6s0YaQCqUpoHfc8iUe/sPWPSh0HNEIXk1xc7d
 5wK9ABTe5IJexv/nOL1zwuq+0qzMVDXT5QXVRO0RHBFvg7ABJ8A3UaksP/Au9vbznv+y
 sjSp8wV+BlOxHOdGYA+cDMAla1SUn8R1LbuFF9a2mrQeOLBH9boJik8YdyjeyQLQUXfd Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7s151fer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 17:24:27 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7H3FSN019994;
        Tue, 7 Nov 2023 17:24:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7s151fe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 17:24:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7GC3uM008058;
        Tue, 7 Nov 2023 17:24:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61skj4fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 17:24:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A7HOMsQ36634998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 17:24:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B1AE2004E;
        Tue,  7 Nov 2023 17:24:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 225C920043;
        Tue,  7 Nov 2023 17:24:22 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Nov 2023 17:24:22 +0000 (GMT)
Date:   Tue, 7 Nov 2023 18:24:20 +0100
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
        Halil Pasic <pasic@linux.ibm.com>,
        Jianxiong Gao <jxgao@google.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231107182420.0bd8c211.pasic@linux.ibm.com>
In-Reply-To: <20231103214831.26d29f4d@meshulam.tesarici.cz>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
        <20231103171447.02759771.pasic@linux.ibm.com>
        <20231103214831.26d29f4d@meshulam.tesarici.cz>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ntoIlwwjXi1JcsmQB2W8lRjw7m2YNgUF
X-Proofpoint-ORIG-GUID: AeNn3w8sEoDV-_x_DBa6D1PS1Ihcojhc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_08,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070142
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Nov 2023 21:50:53 +0100
Petr Tesařík <petr@tesarici.cz> wrote:

> > In our opinion the first step towards getting this right is to figure out what
> > the different kinds of alignments are really supposed to mean. For each of the
> > mechanisms we need to understand and document, whether making sure that the
> > bounce buffer does not stretch over more of certain units of memory (like,
> > pages, iova granule size, whatever), or is it about preserving offset within a
> > certain unit of memory, and if yes to what extent (the least significant n-bits
> > of the orig_addr dictated by the respective mask, or something different).  
> 
> 
> Seconded. I have also been struggling with the various alignment
> constraints. I have even written (but not yet submitted) a patch to
> calculate the combined alignment mask in swiotlb_tbl_map_single() and
> pass it down to all other functions, just to make it clear what
> alignment mask is used.

Can you cc me when posting that rework?

> 
> My understanding is that buffer alignment may be required by:
> 
> 1. hardware which cannot handle an unaligned base address (presumably
>    because the chip performs a simple OR operation to get the addresses
>    of individual fields);

I'm not sure I understood this properly. What is "base address" in this
context? Is for swiotlb "base address" basically the return value
of swiotlb_tbl_map_single() -- I referred to this as tlb_addr previously?

If yes, I understand that  satisfying 1 means satisfying 
tlb_addr & combined_mask == 0, where combined_mask describes the
combined alignment requirement (i.e. combined_mask == min_align_mask |
alloc_align_mask | (alloc_size < PAGE_SIZE ? 0 : (PAGE_SIZE-1)). Does
that sound about right?

Can we assume that if 1. then the start address of the mapping
that is orig_addr needs to be already aligned?

> 
> 2. isolation of untrusted devices, where no two bounce buffers should
>    end up in the same iova granule;
> 
> 3. allocation size; I could not find an explanation, so this might be
>    merely an attempt at reducing SWIOTLB internal fragmentation.


Assumed I understood 1 correctly, I think we are missing something.

4. preserve the n (0 <= n <= 31) lowest bits of all addresses within the
mapping.

Was it just 1, 2 and 3 then we wouldn't need the whole offsetting
business introduced by commit 1f221a0d0dbf ("swiotlb: respect
min_align_mask"). Let me cite from its commit message:

"""
    Respect the min_align_mask in struct device_dma_parameters in swiotlb.
    
    There are two parts to it:
     1) for the lower bits of the alignment inside the io tlb slot, just
        extent the size of the allocation and leave the start of the slot
         empty
     2) for the high bits ensure we find a slot that matches the high bits
        of the alignment to avoid wasting too much memory
    
    Based on an earlier patch from Jianxiong Gao <jxgao@google.com>.
"""

Do we agree, that 4. needs to be added to the list? Or was it supposed
to be covered by 1.?

AFAIU 4. is about either (tlb_addr & combined_mask) == (orig_addr &
combined_mask) or about (tlb_addr & min_aling_mask) == (orig_addr &
min_align_mask). And I would like to know which of the two options it is.

Cc-ing Jianxiong.


> 
> I hope other people on the Cc list can shed more light on the intended
> behaviour.

