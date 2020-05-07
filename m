Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F391C83CC
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgEGHsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 03:48:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHsi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 03:48:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0477VU52004482;
        Thu, 7 May 2020 03:48:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s2g5012j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 03:48:36 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0477Vx5P006325;
        Thu, 7 May 2020 03:48:35 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30s2g50115-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 03:48:35 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0477jQ1T020750;
        Thu, 7 May 2020 07:48:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 30s0g64crh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:48:33 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0477mVS58323580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 07:48:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19C02AE051;
        Thu,  7 May 2020 07:48:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB142AE045;
        Thu,  7 May 2020 07:48:30 +0000 (GMT)
Received: from oc5500677777.ibm.com (unknown [9.145.155.163])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 07:48:30 +0000 (GMT)
Subject: Re: [RFC 1/2] PCI/IOV: Introduce pci_iov_sysfs_link() function
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
References: <20200506211018.GA454697@bjorn-Precision-5520>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <e62d9d62-528f-ac1a-671f-4da2d2e88641@linux.ibm.com>
Date:   Thu, 7 May 2020 09:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506211018.GA454697@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_04:2020-05-05,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070055
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/6/20 11:10 PM, Bjorn Helgaas wrote:
> On Wed, May 06, 2020 at 05:41:38PM +0200, Niklas Schnelle wrote:
>> currently pci_iov_add_virtfn() scans the SR-IOV bars, adds the VF to the
>> bus and also creates the sysfs links between the newly added VF and its
>> parent PF.
> 
> s/currently/Currently/
> s/bars/BARs/
> 
>> With pdev->no_vf_scan fencing off the entire pci_iov_add_virtfn() call
>> s390 as the sole pdev->no_vf_scan user thus ends up missing these sysfs
>> links which are required for example by QEMU/libvirt.
>> Instead of duplicating the code introduce a new pci_iov_sysfs_link()
>> function for establishing sysfs links.
> 
> This looks like two paragraphs missing the blank line between.
> 
> This whole thing is not "introducing" any new functionality; it's
> "refactoring" to move existing functionality around and make it
> callable separately.
You're right I'll keep it in the subject for easier reference
if that's okay with you.
> 
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> With the fixes above and a few below:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Thank you for the very quick and useful feedback.
I've incorporated the changes and will resend with the PATCH prefix.
If/when accepted what tree should the first patch go to?

And yes I plan to let the second patch go via the s390 tree.
> 
>> ---
>>  drivers/pci/iov.c   | 36 ++++++++++++++++++++++++------------
>>  include/linux/pci.h |  8 ++++++++
>>  2 files changed, 32 insertions(+), 12 deletions(-)
>>
... snip ...
