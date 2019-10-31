Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE16DEB5ED
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 18:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfJaROy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 13:14:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33618 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728547AbfJaROy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Oct 2019 13:14:54 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VH9qjc037811;
        Thu, 31 Oct 2019 13:14:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxwmqg5mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 13:14:41 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9VH9s6A037847;
        Thu, 31 Oct 2019 13:14:38 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxwmqg5j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 13:14:37 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9VHCsd8004419;
        Thu, 31 Oct 2019 17:14:33 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 2vxwh612nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 17:14:33 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9VHEWwa46727486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 17:14:32 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C1F813605E;
        Thu, 31 Oct 2019 17:14:32 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E22CA13604F;
        Thu, 31 Oct 2019 17:14:31 +0000 (GMT)
Received: from localhost (unknown [9.85.136.151])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 17:14:31 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, bhelgaas@google.com
Subject: Re: [RFC PATCH 1/9] powerpc/pseries: add cpu DLPAR support for drc-info property
In-Reply-To: <9f7906d9-ef9b-4aa0-a5d6-428f19060919@linux.ibm.com>
References: <1569910334-5972-1-git-send-email-tyreld@linux.ibm.com> <1569910334-5972-2-git-send-email-tyreld@linux.ibm.com> <871rvkjuoz.fsf@linux.ibm.com> <9f7906d9-ef9b-4aa0-a5d6-428f19060919@linux.ibm.com>
Date:   Thu, 31 Oct 2019 12:14:31 -0500
Message-ID: <87h83oltvs.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310169
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> On 10/10/19 11:56 AM, Nathan Lynch wrote:
>> As an aside I don't understand how the add_by_count()/dlpar_cpu_exists()
>> algorithm could be correct as it currently stands. It seems to pick the
>> first X indexes for which a corresponding cpu node is absent, but that
>> set of indexes does not necessarily match the set that is available to
>> configure. Something to address separately I suppose.
>
> I'm not sure I follow?

Don't worry about it for this patchset, it's just something I noticed
when reviewing. I'm wondering why the cpu add algorithm doesn't work
more like the one for memory, which actually queries the platform for
connector status via dlpar_acquire_drc(). It's possible I'm
misunderstanding something though. Like I said, I think it's something
to address separately if there is indeed an issue.
