Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD167E46D9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 18:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjKGRZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 12:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjKGRZV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 12:25:21 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D932101;
        Tue,  7 Nov 2023 09:25:19 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7GZhEa020682;
        Tue, 7 Nov 2023 17:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=3etUmHlLQoqkujeMpctTSui817APH+WOGe3bUcUWroU=;
 b=ObmbUZhiaRKd/RiPTFKyzWd3y/wu1zATeU6YMLSaoh36onMNYSAvzwabFU++4KXt69K1
 BNmH5Idi/zQDgIUPp+ge5AboPc7TNeA3wB33SVVlxZgTefIDsNkc3jbBsbAqOKEa6uRI
 54sObPMnq3Rfd97qLIfiv/nT0vdKc4HDBkWYcIihtO6o6rZvaokyqx0GAs5XlR3oGW4m
 JuwTgWXF/FZuBaLgCbOnGdRcaVMIcmHO4UzJ3jbc4aQuJH4UNB7WVbmZjCQ9XJZmfzub
 qsrJCxehLHtrWWL3y/vljlHjvqxiOXwL1TA+zLoONjna2hfzciof50G7r08N/dmtWH0B Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7rw2a9a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 17:24:56 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7HKR3P007621;
        Tue, 7 Nov 2023 17:24:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7rw2a94k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 17:24:55 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7H8vpN012797;
        Tue, 7 Nov 2023 17:24:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u609stjb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 17:24:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A7HOdL540501948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 17:24:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 273EE20043;
        Tue,  7 Nov 2023 17:24:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED0E520040;
        Tue,  7 Nov 2023 17:24:38 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.152.224.212])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Nov 2023 17:24:38 +0000 (GMT)
Date:   Tue, 7 Nov 2023 18:24:37 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
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
Message-ID: <20231107182437.06632f6e.pasic@linux.ibm.com>
In-Reply-To: <20231106074243.GA17777@lst.de>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
        <20231103171447.02759771.pasic@linux.ibm.com>
        <20231103214831.26d29f4d@meshulam.tesarici.cz>
        <20231106074243.GA17777@lst.de>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rlOMfE6v9Jv1K1zh90qVbbSrtVVgtlIr
X-Proofpoint-GUID: p1cNH5AcjioJZXwoiozkBShsYX00e0kl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_08,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 mlxscore=0
 mlxlogscore=596 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070142
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 6 Nov 2023 08:42:43 +0100
Christoph Hellwig <hch@lst.de> wrote:

> > 1. hardware which cannot handle an unaligned base address (presumably
> >    because the chip performs a simple OR operation to get the addresses
> >    of individual fields);  
> 
> There's all kinds of weird encodings that discard the low bits.
> For NVMe it's the PRPs (that is actually documented in the NVMe
> spec, so it might be easiest to grasp), but except for a Mellox
> vendor extension this is also how all RDMA memory registrations
> work.

Thanks Christoph! So for NVMe in certain contexts the low
bits of addresses get discarded, but in other contexts the high bits
of addresses get discarded and the low bits need to remain the same
after the bounce (and that's why we need commits 36950f2da1ea ("driver
core: add a min_align_mask) and 1f221a0d0dbf ("swiotlb: respect
min_align_mask").

Does that sound about right?

Regards,
Halil
