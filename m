Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666416B3C16
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 11:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCJKaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 05:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjCJKaH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 05:30:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB614F0FD7;
        Fri, 10 Mar 2023 02:30:05 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32A8s9Bd030175;
        Fri, 10 Mar 2023 10:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=TCyLDs5/MOvvxxbkgCtsIGVGJ0wUr+yl7R4nt365p0w=;
 b=HSsV+IJXCx359ZnztHKO0DimQKA1dDdwplVFKG9dG+Vo77kG285rsJBn7fbV5/Oi6O1C
 DaYFk7KoBoORihFRr/yGJKgfNFyaBFOh6hWVlfdtf1SnpzWcbKehTcijf0rrKXMBJCkr
 f19falvSvEQpGIzt79E/dpL83Qy5IPUT6q4LJMbv0/d8pHBL5NnyD32trKFEDMG7lMrk
 N1FgYZM8JcpCEC+bH2FKNqHjt7z8ALtl8/zPEFCqd9PcUe37CbtGCgohX7BWVtYkL5z7
 MbAnSOrPGPCnkM+kQKYRxWdn8Ly1w7SJ28nmWTACaV3VZuvrYcktxxkv7yHqYo2JxiTo Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7p9w21sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 10:29:56 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32A8rYwd020834;
        Fri, 10 Mar 2023 10:29:56 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p7p9w21rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 10:29:55 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32A8bsqA032279;
        Fri, 10 Mar 2023 10:29:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3p6g03arrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 10:29:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32AATnSV51184054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 10:29:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7F092004B;
        Fri, 10 Mar 2023 10:29:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D10920043;
        Fri, 10 Mar 2023 10:29:49 +0000 (GMT)
Received: from localhost (unknown [9.179.4.206])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Mar 2023 10:29:49 +0000 (GMT)
Date:   Fri, 10 Mar 2023 11:29:47 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: s390: Fix use-after-free of PCI resources
 with per-function hotplug
Message-ID: <your-ad-here.call-01678444187-ext-6579@work.hours>
References: <20230306151014.60913-2-schnelle@linux.ibm.com>
 <20230308231449.GA1057317@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230308231449.GA1057317@bhelgaas>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ys4LcOQTMbqhif-Hx-DVD6d-7FgXOEhC
X-Proofpoint-GUID: jJ9xdn3ITYUNIwv7pfsbndXPMpIAWtIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=569
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303100077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 05:14:49PM -0600, Bjorn Helgaas wrote:
> On Mon, Mar 06, 2023 at 04:10:11PM +0100, Niklas Schnelle wrote:
> > On s390 PCI functions may be hotplugged individually even when they
> > belong to a multi-function device. In particular on an SR-IOV device VFs
> > may be removed and later re-added.
> > 
> > In commit a50297cf8235 ("s390/pci: separate zbus creation from
> > scanning") it was missed however that struct pci_bus and struct
> > zpci_bus's resource list retained a reference to the PCI functions MMIO
> > resources even though those resources are released and freed on
> > hot-unplug. These stale resources may subsequently be claimed when the
> > PCI function re-appears resulting in use-after-free.
> > 
> > One idea of fixing this use-after-free in s390 specific code that was
> > investigated was to simply keep resources around from the moment a PCI
> > function first appeared until the whole virtual PCI bus created for
> > a multi-function device disappears. The problem with this however is
> > that due to the requirement of artificial MMIO addreesses (address
> > cookies) extra logic is then needed to keep the address cookies
> > compatible on re-plug. At the same time the MMIO resources semantically
> > belong to the PCI function so tying their lifecycle to the function
> > seems more logical.
> > 
> > Instead a simpler approach is to remove the resources of an individually
> > hot-unplugged PCI function from the PCI bus's resource list while
> > keeping the resources of other PCI functions on the PCI bus untouched.
> > 
> > This is done by introducing pci_bus_remove_resource() to remove an
> > individual resource. Similarly the resource also needs to be removed
> > from the struct zpci_bus's resource list. It turns out however, that
> > there is really no need to add the MMIO resources to the struct
> > zpci_bus's resource list at all and instead we can simply use the
> > zpci_bar_struct's resource pointer directly.
> > 
> > Fixes: a50297cf8235 ("s390/pci: separate zbus creation from scanning")
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> The meat of this is mostly in s390, so I think it makes more sense to
> merge via that tree.  But let me know if you'd rather that I take it.

I'll take it via s390 tree. Thanks
