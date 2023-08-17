Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590F777F673
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350860AbjHQMa0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350881AbjHQMaB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:30:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E3271B;
        Thu, 17 Aug 2023 05:30:00 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37HCSH3T025387;
        Thu, 17 Aug 2023 12:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=4HzpTP7FNAMT9uAwevK5G07vm/QGlG2BcywlhBGJw0k=;
 b=kLbh0EqSZ3cxQ8J3HT6c4Ii69Yjo3mtmRNluD0vhG3ZRincOTTO2MgpDdcTl/62uFcFF
 6RdF68p56IRPV9nF1kEsHPbdebc6EGt/aX9a41LKTd2hwm0g/mVP4GbPUY0Lc3CS8ozy
 ZaBPMFNIZEB2ctUGM4JOjP5CBu+Lzyvf9jgKsUPfasqkHSlhy9QPDPbptLZyMbPIjNjR
 DNTHXLqR+TbPf9pb09Ryk38uBPeLdIiuuiaHDqYDfkTPJKk60kaysIoJRBF7BELyXZnS
 gipZnQWtdVmEazaGUh1OsFLrMacEJR86hSYVz0E22nMeSvf/z2twcmEhqvo3P3i+4fbo lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shkgn05wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 12:29:56 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37HCOM0o011665;
        Thu, 17 Aug 2023 12:29:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shkgn05wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 12:29:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37HAZDd2018869;
        Thu, 17 Aug 2023 12:29:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq41wdpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 12:29:54 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37HCTrBb3080734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 12:29:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB1B958068;
        Thu, 17 Aug 2023 12:29:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9671C58061;
        Thu, 17 Aug 2023 12:29:53 +0000 (GMT)
Received: from localhost (unknown [9.61.129.82])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 17 Aug 2023 12:29:53 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>, mahesh@linux.ibm.com
Cc:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] powerpc/rtas: Rename rtas_error_rc to
 rtas_generic_errno
In-Reply-To: <87zg2q5fs9.fsf@mail.lhotse>
References: <169138864808.65607.6576358707894823512.stgit@jupiter>
 <877cpxdksx.fsf@mail.lhotse>
 <xzsx7qc3el674iyy2lsn3adm7j2vh5xj6cjaqxgjm6lwcjiz5u@evoqbrvhqf26>
 <87zg2q5fs9.fsf@mail.lhotse>
Date:   Thu, 17 Aug 2023 07:29:53 -0500
Message-ID: <87o7j5zwam.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TeqLM47v-5tkhNdGU3T38VRBt8JITo02
X-Proofpoint-GUID: 1YuDwTWJIanuaxXs99mqFgTHlJm_V3fe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_05,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308170109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:

> Mahesh J Salgaonkar <mahesh@linux.ibm.com> writes:
>> On 2023-08-15 13:52:14 Tue, Michael Ellerman wrote:
>>> Mahesh Salgaonkar <mahesh@linux.ibm.com> writes:
> ...
>>> > diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
>>> > index 3abe15ac79db1..5572a0a2f6e18 100644
>>> > --- a/arch/powerpc/include/asm/rtas.h
>>> > +++ b/arch/powerpc/include/asm/rtas.h
>>> > @@ -202,7 +202,9 @@ typedef struct {
>>> >  #define RTAS_USER_REGION_SIZE (64 * 1024)
>>> >  
>>> >  /* RTAS return status codes */
>>> > -#define RTAS_BUSY		-2    /* RTAS Busy */
>>> > +#define RTAS_HARDWARE_ERROR	(-1)  /* Hardware Error */
>>> > +#define RTAS_BUSY		(-2)  /* RTAS Busy */
>>> 
>>> Are the brackets necessary?
>>
>> During v5 changset I received offline review comment to add brackets,
>> hence continued here as well. I can take it away if Nathan is fine with
>> it.
>
> OK. I can't think of a context where the brackets are useful, but I'm
> probably just not thinking hard enough. I don't really mind adding them,
> I was just curious what the justification for them was.

It was my (mistaken) suggestion -- they're not needed.
