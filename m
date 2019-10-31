Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3521EA820
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 01:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfJaAP0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 20:15:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3518 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbfJaAP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2019 20:15:26 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V087NJ074577;
        Wed, 30 Oct 2019 20:15:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxwmpqshg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 20:15:14 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9V08Agg074652;
        Wed, 30 Oct 2019 20:15:11 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vxwmpqsh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 20:15:11 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9V06uAJ010694;
        Thu, 31 Oct 2019 00:15:10 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2vxwh8mws5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Oct 2019 00:15:10 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V0F95G54067600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 00:15:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 461F8B205F;
        Thu, 31 Oct 2019 00:15:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55F3CB2066;
        Thu, 31 Oct 2019 00:15:08 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.160.78.123])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 00:15:07 +0000 (GMT)
Subject: Re: [RFC PATCH 2/9] powerpc/pseries: fix bad drc_index_start value
 parsing of drc-info entry
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, bhelgaas@google.com
References: <1569910334-5972-1-git-send-email-tyreld@linux.ibm.com>
 <1569910334-5972-3-git-send-email-tyreld@linux.ibm.com>
 <87y2xsifqc.fsf@linux.ibm.com>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <955a666f-1d99-6dd0-014d-6323e744da93@linux.ibm.com>
Date:   Wed, 30 Oct 2019 17:15:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87y2xsifqc.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=709 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910300218
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/10/19 12:04 PM, Nathan Lynch wrote:
> Tyrel Datwyler <tyreld@linux.ibm.com> writes:
>> The ibm,drc-info property is an array property that contains drc-info
>> entries such that each entry is made up of 2 string encoded elements
>> followed by 5 int encoded elements. The of_read_drc_info_cell()
>> helper contains comments that correctly name the expected elements
>> and their encoding. However, the usage of of_prop_next_string() and
>> of_prop_next_u32() introduced a subtle skippage of the first u32.
>> This is a result of of_prop_next_string() returns a pointer to the
>> next property value which is not a string, but actually a (__be32 *).
>> As, a result the following call to of_prop_next_u32() passes over the
>> current int encoded value and actually stores the next one wrongly.
>>
>> Simply endian swap the current value in place after reading the first
>> two string values. The remaining int encoded values can then be read
>> correctly using of_prop_next_u32().
> 
> Good but I think it would make more sense for a fix for
> of_read_drc_info_cell() to precede any patch in the series which
> introduces new callers, such as patch #1.
> 

Not sure it matters that much since everything in the series is required to
properly enable a working drc-info implementation and the call already exists so
it doesn't break bisectability. It ended up second in the series since testing
patch 1 exposed the flaw.

I'll go ahead and move it first, and add the appropriate fixes tag as well which
is currently missing.

-Tyrel
