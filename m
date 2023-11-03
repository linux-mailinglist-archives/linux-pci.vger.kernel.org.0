Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865607E0554
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjKCPNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjKCPNn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 11:13:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB80D4C;
        Fri,  3 Nov 2023 08:13:40 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3FDArR030442;
        Fri, 3 Nov 2023 15:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=2/xZnlZ+ucI9Waeln15/C3RKn69MzEa4w98I3fYs/hc=;
 b=alE8dRvvymuJDYttfomP10HXtwoQvFK4yJt1K79Wl56uRckxeZcTirzfvN60mU3ek8tp
 EzAMnF80b7jQSsNE+oQAHwoCk3JNYhcT/ZJenCXG9gDRfnXYIdiW8i8ZCsZy0eq6z1Cy
 YDQ3V/VU8pjBhmd0o6CiBIBQi1ESW5a7+rl5AKKsZV2EtsxxzTMfYN0d+Nszz4TrUW/h
 QW0w2LmG6TjukPWb6r/LspthLggBYYpbdlVDh0jAUrUOZe8jM4c5W3ty/1bHLE9slk4V
 L2PaCtKlGeKPPZdvJ/JDMgcrXNtP1D6Kx4iYfxyGXTZ2Kkth82uFXH2UvEqQZeVmNhGI ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u52qk9nd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 15:13:10 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3EpQNK024366;
        Fri, 3 Nov 2023 15:13:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u52qk9nc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 15:13:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3CXctD011588;
        Fri, 3 Nov 2023 15:13:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1e4membs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 15:13:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A3FD48D43319970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 15:13:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1A622004B;
        Fri,  3 Nov 2023 15:13:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 197E520040;
        Fri,  3 Nov 2023 15:13:04 +0000 (GMT)
Received: from [9.171.80.107] (unknown [9.171.80.107])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 15:13:04 +0000 (GMT)
Message-ID: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
Subject: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Date:   Fri, 03 Nov 2023 16:13:03 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PDrjGHDB-1y7uLi7HrHzWA5y2VJSOn9l
X-Proofpoint-GUID: jZm5FHjZrqrJ7-_fuauJStM2EFLpdVLM
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_14,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Swiotlb Maintainers,

With s390 slated to use dma-iommu.c I was experimenting with
CONFIG_SWIOTLB_DYNAMIC but was getting errors all over the place.
Debugging this I've managed to narrow things down to what I believe is
a memory corruption issue caused by overrunning the entire transient
memory pool allocated by swiotlb. In my test this happens on the
iommu_dma_map_page(), swiotlb_tbl_map_single() path when handling
untrusted PCI devices.

I've seen this happen only for transient pools when:
*  allocation size >=3DPAGE_SIZE and,
*  the original address of the mapping is not page aligned.=20

The overrun can be seen clearly by adding a simple "tlb_addr +
alloc_size > pool->end' overrun check to swiotlb_tbl_map_single() and
forcing PCI test devices to be untrusted. With that in place while an
NVMe fio work load runs fine TCP/IP tests on a Mellanox ConnectX-4 VF
reliably trigger the overrun check and with a debug print produce
output like the following:

software IO TLB:
	transient:1
	index:1
	dma_get_min_align_mask(dev):0
	orig_addr:ac0caebe
	tlb_addr=3Da4d0f800
	start:a4d0f000
	end:a4d10000
	pool_size:4096
	alloc_size:4096
	offset:0

The complete code used for this test is available on my
git.kernel.org[0] repository but it's bascially v6.6 + iommu/next (for
s390 DMA API) + 2 trivial debug commits.

For further analysis I've worked closely with Halil Pasic.

The reason why we think this is happening seems twofold. Under a
certain set of circumstances in the function swiotlb_find_slots():
1) the allocated transient pool can not fit the required bounce buffer,
and
2) the invocation of swiotlb_pool_find_slots() finds "a suitable
slot" even though it should fail.

The reason for 2), i.e. swiotlb_pool_find_slots() thinking there is a
suitable bounce buffer in the pool is that for transient pools pool-
>slots[i].list end up nonsensical, because swiotlb_init_io_tlb_pool(),
among other places in swiotlb, assumes that the nslabs of the pool is a
multiple of IO_TLB_SEGSIZE

The reason for 1) is a bit more convoluted and not entirely understood
by us. We are certain though that the function swiotlb_find_slots()
allocates a pool with nr_slots(alloc_size), where this alloc_size is
the alloc_size from swiotlb_tbl_map_single() + swiotlb_align_offset(),
but for alignment reasons some slots may get "skipped over" in
swiotlb_area_find_slots() causing the picked slots to overrun the
allocation.

Not sure how to properly fix this as the different alignment
requirements get pretty complex quickly. So would appreciate your
input.

Thanks,
Niklas

[0] bounce-min branch of my git.kernel.org repository at
    https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git


