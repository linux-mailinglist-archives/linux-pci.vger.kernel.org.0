Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9786F7E815B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 19:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbjKJS13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 13:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346523AbjKJS04 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 13:26:56 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB7D0BE;
        Fri, 10 Nov 2023 01:23:27 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA9DJHD019415;
        Fri, 10 Nov 2023 09:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=HznTsQNl47/GQCrKjB/UG3RtaDQ6QdkoTZ2WIS6q3HA=;
 b=sgmKbhIMOjGnIze4wT/YBq4hk8KJotdGY/Eh4G72tNuNZKNW4Wx8q1Nrmxf+rPeyU/S/
 4x90FWCue82TNGraPd2rBczxw+rOLPUp/8wpVB6Cs1FpNfeD+H22/XzNkv68k6i7ltNK
 nJXpsjt626Xro8OXMsDR53mvx2nQgttEljiWjSnvAL9wYTX6sBKzfth2slrjmgW/QwtI
 w5j3SWmFLBug1T8b8xCQkLUfCRKdriVA8UIlNoUN59vdsn68W5Qem73gbVU83sFK3nqP
 1EMPCEDCaaM/SxlxKIt8T6bMEFfK/oCGO9R6EXDfKpvY7PYmtNro0+1slGBWRtgIyDoe LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9h71s7q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:22:52 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AA9DW8S021570;
        Fri, 10 Nov 2023 09:22:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9h71s7pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:22:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA74s4i004132;
        Fri, 10 Nov 2023 09:22:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w219vjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 09:22:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AA9MmQn28639904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:22:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87BF420043;
        Fri, 10 Nov 2023 09:22:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FF5A20040;
        Fri, 10 Nov 2023 09:22:47 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.21.196])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
        Fri, 10 Nov 2023 09:22:47 +0000 (GMT)
Date:   Fri, 10 Nov 2023 10:22:45 +0100
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
Message-ID: <20231110102245.6ac971b9.pasic@linux.ibm.com>
In-Reply-To: <7a4f87c3-b3c6-42c5-9200-8eb56d1c8530@huawei-partners.com>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
        <20231103195949.0af884d0@meshulam.tesarici.cz>
        <20231108115207.791a30d8.pasic@linux.ibm.com>
        <41c0baf6-ba4d-4876-b692-279307265466@huawei-partners.com>
        <20231108153230.6491acaa.pasic@linux.ibm.com>
        <7a4f87c3-b3c6-42c5-9200-8eb56d1c8530@huawei-partners.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oOuHQySkKhSqp4kaUhZWxxdqq2tOxfSE
X-Proofpoint-ORIG-GUID: IIwt0OJc9stJoXlryv475MX4u7tTtuFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_05,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 8 Nov 2023 15:45:49 +0100
Petr Tesarik <petr.tesarik1@huawei-partners.com> wrote:

> On 11/8/2023 3:32 PM, Halil Pasic wrote:
> > On Wed, 8 Nov 2023 12:04:12 +0100
> > Petr Tesarik <petr.tesarik1@huawei-partners.com> wrote:
> > [..]  
> >>>
> >>> For the sake of simplicity let us assume we only have the min_align_mask
> >>> requirement. Then I believe the worst case is that we need 
> >>> (orig_addr & min_align_mask & PAGE_MASK)  + (min_align_mask & ~PAGE_MASK)
> >>> extra space to fit.
> >>>
> >>> Depending on how the semantics pan out one may be able to replace
> >>> min_align_mask with combined_mask.
> >>>
> >>> Is your point that for large combined_mask values 
> >>> _get_free_pages(GFP_NOWAIT | __GFP_NOWARN, required_order) is not
> >>> likely to complete successfully?    
> >>
> >> Yes, that's the reason. OTOH it's probably worth a try. The point is
> >> that mapping a DMA buffer is allowed to fail, so callers should be
> >> prepared anyway.
> >>
> >> And for the case you reported initially, I don't think there is any need
> >> to preserve bit 11 (0x800) from the original buffer's physical address,
> >> which is enough to fix it. See also my other email earlier today.  
> > 
> > Hm. Do you mean "[PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations
> > with CONFIG_SWIOTLB_DYNAMIC" or a different one?
> > 
> > I only see "[PATCH 1/1] swiotlb: fix out-of-bounds TLB allocations
> > with CONFIG_SWIOTLB_DYNAMIC" but I don't think that one takes
> > care of "I don't think there is any need to preserve bit 11 (0x800)
> > from the original buffer's physical address".  
> 
> Yes, I mean only this patch. I want to fix memory corruption fast, while
> waiting for more feedback on my understanding of the alignment masks.
> What I'm trying to say is that your specific use case may not even need
> a bigger allocation if the page alignment should be interpreted differently.
> 
> Again, thank you for your in-depth inspection, because it's not totally
> clear how the various alignment parameters should be interpreted. It's
> difficult to write correct code then...

I fully understand. Thanks for tackling this. We decided to go with a bug
report and not with a fix because of the very same reasons: lack of
clarity on how certain things are supposed to work. Let us see how
the discussion develops. :)

Regards,
Halil

> 
> Petr T

