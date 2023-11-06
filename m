Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53107E1DEF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 11:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjKFKJF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 05:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjKFKJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 05:09:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95FD1BF;
        Mon,  6 Nov 2023 02:08:59 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A69GR0M022738;
        Mon, 6 Nov 2023 10:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=r+aarlL2H82YLzRQAyKOowUBNf7+/61K2JZ3ILC5APA=;
 b=lswr8Tggtlt6v32NsjakaA+fjX2D3IPSntIob56AFlmx2oSl9QAVS8MxMUmhl/A9mx4A
 /R366vAKFm78uaAjO32knr5UVtX6juEtLrZnJErdECUc13ddd0mI3zVifm1/J1V7g2cT
 VsG9VPyMHoqdZygCRXaRvKPA4ZhzNl64Pt5sQK2RNcY/g+jPenujQoVIkRxSHCs0fwYk
 LTwz6YYsFWTgihuDkjzcBRtTfAGwmS5f8HY24zPGISIhhs+gl7o4V/8eJSCii+76SuTC
 lPIQ0cyhF6ov+4sDNwUigL8d2nN3xPkw3Kn7oA/wvO4IC+wxZLFRvE71wvvs7mW8InfJ Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6uj0n521-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 10:08:28 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A69Gefb024600;
        Mon, 6 Nov 2023 10:08:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6uj0n514-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 10:08:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A67qrbe007992;
        Mon, 6 Nov 2023 10:08:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u60ny8kq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 10:08:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6A8N4422020764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 10:08:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B77B20076;
        Mon,  6 Nov 2023 10:08:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9255720075;
        Mon,  6 Nov 2023 10:08:22 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.171.62.82])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
        Mon,  6 Nov 2023 10:08:22 +0000 (GMT)
Date:   Mon, 6 Nov 2023 11:08:20 +0100
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
Message-ID: <20231106110820.2bc70130.pasic@linux.ibm.com>
In-Reply-To: <20231103214831.26d29f4d@meshulam.tesarici.cz>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
        <20231103171447.02759771.pasic@linux.ibm.com>
        <20231103214831.26d29f4d@meshulam.tesarici.cz>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uIaTFOuqP_nB6juhOpnD6g8sASr2ro47
X-Proofpoint-GUID: vlRs8r-Z4w7NX1o3vr7N-vTbSUM_1Wgm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_08,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxlogscore=802 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Nov 2023 21:50:53 +0100
Petr Tesařík <petr@tesarici.cz> wrote:

> >[...]
> > In our case min_align_mask == 0 and a) is thus not applicable, because b) and
> > c) we end up with iotlb_align_mask = 0x800. And because orig_add & 0x800 ==
> > 0x800 but pool->start & 0x800 == 0 and the slot at index i is skipped over. The
> > slot 0 is skipped over because it is page aligned, when !!((1UL << PAGE_SHIFT)
> > & orig_addr)   
> 
> Wait. These mask values can quickly become confusing. Do you mean
> iotlb_align_mask == 0xfff?

I mean iotlb_align_mask == 0x800. Because of  
iotlb_align_mask &= ~(IO_TLB_SIZE - 1);
in line 994 masks away the 0x7FF part
(https://github.com/torvalds/linux/blob/d2f51b3516dade79269ff45eae2a7668ae711b25/kernel/dma/swiotlb.c#L994C2-L994C41)
what remains of 0xfff (when PAGE_SHIFT == 12). My idea was to write 
0x800 differently with a reference to PAGE_SHIFT, because for a
larger PAGE_SHIFT we end up with a different pattern and thus
requirement, but didn't really think it through properly because
even (1UL << (PAGE_SHIFT- 1)) (which is for PAGE_SHIFT == 12
0x800) does not tell the full story. Because all bits in the
interval [PAGE_SHIFT,IO_TLB_SHIFT)  matter and not just the most
significant one (for PAGE_SHIFT == 12 and IO_TLB_SHIFT == 1 there is
just one).

Shame on me! Sorry for the confusion!

Regards,
Halil
