Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF464ECB2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 15:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiLPOMP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 09:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiLPOMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 09:12:09 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504B36324;
        Fri, 16 Dec 2022 06:12:08 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGDhckJ008983;
        Fri, 16 Dec 2022 14:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SSx0prXKqtXXKE0mkR7Lylinu406QRa/4P16kiHqIHY=;
 b=K9Tio6rWaKuqG2SnYew/uBwa/8eiKfnR8Nuhj6VHB28lp2XlKn8HjBG4Rz6sse9qGTC0
 C3eoely3JljcOfXbvBh8ooLMeGLZaNxYT0VDyDnW34RhPeNrpaYyc2Gkp+FuqibTU1Pw
 yqzE1JfzrrTlDWXBeYs0/MI3OSZBkhMH/qQzEA2+f+aKfFQJKQqfwm4N8X7TgtZrtK0z
 oJH4iNGgBiqRVDrFcClEQteuQtCCQueHtDP6pF5r3729VUReHjcqfHUSlFvDoLQVmD2t
 OCsSkyQReNnKxseR660jpt9HzqFxf7koEbclDLlxw3bOerpLBy7SI2Ri2gieb6A3bzJq 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgsterqye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 14:11:29 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BGDjEN1016415;
        Fri, 16 Dec 2022 14:11:28 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgsterqxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 14:11:28 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGCDwmO027630;
        Fri, 16 Dec 2022 14:11:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3mf00x2bq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 14:11:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BGEBQH510027728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Dec 2022 14:11:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E5C658054;
        Fri, 16 Dec 2022 14:11:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D66AE58066;
        Fri, 16 Dec 2022 14:11:23 +0000 (GMT)
Received: from [9.160.114.181] (unknown [9.160.114.181])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 16 Dec 2022 14:11:23 +0000 (GMT)
Message-ID: <20d5b238-4c2c-6232-0251-c17b07dffbe3@linux.ibm.com>
Date:   Fri, 16 Dec 2022 09:11:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [patch V3 09/33] genirq/msi: Add range checking to
 msi_insert_desc()
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <20221213190425.GA3943240@roeck-us.net>
 <4e0a129855490febb1c57e7e979bcfb579d39054.camel@linux.ibm.com>
 <87fsdgzpqs.ffs@tglx> <e570e70d-19bc-101b-0481-ff9a3cab3504@linux.ibm.com>
 <86wn6rptdu.wl-maz@kernel.org>
 <0acb8c63-7f6c-6df6-cb40-66b265a6e6ce@linux.ibm.com>
 <86v8mbphzw.wl-maz@kernel.org> <86tu1vphs9.wl-maz@kernel.org>
From:   Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <86tu1vphs9.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p9MS-957VGoLdmSafHmocM2tMIuSZVSl
X-Proofpoint-GUID: 8mppAF6KhDxEx5xrR6U10-WQlPF5QyAy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_08,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/16/22 9:03 AM, Marc Zyngier wrote:
> On Fri, 16 Dec 2022 13:58:59 +0000,
> Marc Zyngier <maz@kernel.org> wrote:
>>
>> I'll update Thomas' patch. Once Guenter confirms that PPC is OK, I'll
>> send it out.
> 
> And FWIW, the branch is at [1].
> 
> Thanks,
> 
> 	M.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/msi-fixes-6.2
> 

FYI, your patch there mentions MSI_XA_DOMAIN_SIZE in the commit message but the code (and comment) is still returning MSI_MAX_INDEX 
