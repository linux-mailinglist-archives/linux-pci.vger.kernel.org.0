Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA7EA821
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 01:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJaAPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 20:15:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbfJaAPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2019 20:15:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V08ACf081901;
        Wed, 30 Oct 2019 20:15:40 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyj02d1q3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 20:15:40 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9V06vUS032465;
        Thu, 31 Oct 2019 00:15:39 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2vxwh6cw87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 00:15:39 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V0Fc0V33030524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 00:15:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E6D0B2065;
        Thu, 31 Oct 2019 00:15:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2604B2066;
        Thu, 31 Oct 2019 00:15:37 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.78.123])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 00:15:37 +0000 (GMT)
Subject: Re: [RFC PATCH 0/9] Fixes and Enablement of ibm,drc-info property
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mpe@ellerman.id.au, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nathanl@linux.ibm.com
References: <20191001200229.GA64312@google.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <414bd2c2-474d-29e0-30f4-2c7f96ac6f25@linux.ibm.com>
Date:   Wed, 30 Oct 2019 17:15:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001200229.GA64312@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910300218
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/1/19 1:02 PM, Bjorn Helgaas wrote:
> On Tue, Oct 01, 2019 at 01:12:05AM -0500, Tyrel Datwyler wrote:
>> There was an initial previous effort yo add support for the PAPR
>> architected ibm,drc-info property. This property provides a more
>> memory compact representation of a paritions Dynamic Reconfig
>> Connectors (DRC). These can otherwise be thought of the currently
>> partitioned, or available, but yet to be partitioned, system resources
>> such as cpus, memory, and physical/logical IOA devices.
>>
>> The initial implementation proved buggy and was fully turned of by
>> disabling the bit in the appropriate CAS support vector. We now have
>> PowerVM firmware in the field that supports this new property, and 
>> further to suppport partitions with 24TB+ or possible memory this
>> property is required to perform platform migration.
>>
>> This serious fixup the short comings of the previous implementation
>> in the areas of general implementation, cpu hotplug, and IOA hotplug.
>>
>> Tyrel Datwyler (9):
>>   powerpc/pseries: add cpu DLPAR support for drc-info property
>>   powerpc/pseries: fix bad drc_index_start value parsing of drc-info
>>     entry
>>   powerpc/pseries: fix drc-info mappings of logical cpus to drc-index
>>   PCI: rpaphp: fix up pointer to first drc-info entry
>>   PCI: rpaphp: don't rely on firmware feature to imply drc-info support
>>   PCI: rpaphp: add drc-info support for hotplug slot registration
>>   PCI: rpaphp: annotate and correctly byte swap DRC properties
>>   PCI: rpaphp: correctly match ibm,my-drc-index to drc-name when using
>>     drc-info
>>   powerpc: Enable support for ibm,drc-info property
>>
>>  arch/powerpc/kernel/prom_init.c                 |   2 +-
>>  arch/powerpc/platforms/pseries/hotplug-cpu.c    | 117 ++++++++++++++++------
>>  arch/powerpc/platforms/pseries/of_helpers.c     |   8 +-
>>  arch/powerpc/platforms/pseries/pseries_energy.c |  23 ++---
>>  drivers/pci/hotplug/rpaphp_core.c               | 124 +++++++++++++++++-------
>>  5 files changed, 191 insertions(+), 83 deletions(-)
> 
> Michael, I assume you'll take care of this.  If I were applying, I
> would capitalize the commit subjects and fix the typos in the commit
> logs, e.g.,
> 
>   s/the this/the/
>   s/the the/that the/
>   s/short coming/shortcoming/
>   s/seperate/separate/
>   s/bid endian/big endian/
>   s/were appropriate/where appropriate/
>   s/name form/name from/
> 
> etc.  git am also complains about space before tab whitespace errors.
> And it adds a few lines >80 chars.
> 

I'll fix all those up in the next spin.

-Tyrel
