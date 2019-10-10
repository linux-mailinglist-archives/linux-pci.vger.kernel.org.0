Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DED3119
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2019 21:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfJJTFP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Oct 2019 15:05:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726907AbfJJTFP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2019 15:05:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9AInmke003534;
        Thu, 10 Oct 2019 15:05:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vj9n1sjdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 15:05:01 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9AInnSp003570;
        Thu, 10 Oct 2019 15:05:00 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vj9n1sjcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 15:05:00 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9AIpi5i011947;
        Thu, 10 Oct 2019 19:05:02 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 2vejt7cxgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 19:05:02 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9AJ4xH553346728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 19:04:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE725AC05F;
        Thu, 10 Oct 2019 19:04:59 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A34FFAC05E;
        Thu, 10 Oct 2019 19:04:59 +0000 (GMT)
Received: from localhost (unknown [9.41.179.186])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Oct 2019 19:04:59 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, bhelgaas@google.com
Subject: Re: [RFC PATCH 2/9] powerpc/pseries: fix bad drc_index_start value parsing of drc-info entry
In-Reply-To: <1569910334-5972-3-git-send-email-tyreld@linux.ibm.com>
References: <1569910334-5972-1-git-send-email-tyreld@linux.ibm.com> <1569910334-5972-3-git-send-email-tyreld@linux.ibm.com>
Date:   Thu, 10 Oct 2019 14:04:59 -0500
Message-ID: <87y2xsifqc.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=442 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910100160
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> The ibm,drc-info property is an array property that contains drc-info
> entries such that each entry is made up of 2 string encoded elements
> followed by 5 int encoded elements. The of_read_drc_info_cell()
> helper contains comments that correctly name the expected elements
> and their encoding. However, the usage of of_prop_next_string() and
> of_prop_next_u32() introduced a subtle skippage of the first u32.
> This is a result of of_prop_next_string() returns a pointer to the
> next property value which is not a string, but actually a (__be32 *).
> As, a result the following call to of_prop_next_u32() passes over the
> current int encoded value and actually stores the next one wrongly.
>
> Simply endian swap the current value in place after reading the first
> two string values. The remaining int encoded values can then be read
> correctly using of_prop_next_u32().

Good but I think it would make more sense for a fix for
of_read_drc_info_cell() to precede any patch in the series which
introduces new callers, such as patch #1.
