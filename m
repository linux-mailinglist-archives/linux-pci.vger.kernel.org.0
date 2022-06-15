Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0F54C72C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 13:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348332AbiFOLJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 07:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243002AbiFOLJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 07:09:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4DC37AA8;
        Wed, 15 Jun 2022 04:09:14 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F95ooP026200;
        Wed, 15 Jun 2022 11:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=vH3lrqCSiULojReWOfFkIe62Krf/DPmG9XlKf4rkj38=;
 b=SMWCYcsWhridLRkvwocwuaPUqxAWVMsREWYkFr8CJmPMcITKmeJzSilV/EkdPHHkg6K2
 NbGRK4p+Njob0xSzpH4DxS5EJkATsYaH9xVVMkkNWoo/NnG1AXOqq1UEae+EgkFBpydJ
 M06Xci4yRKLQGjoRHnHbijoUFWKumSbPQoLJbIAx305gL1wjDg8Kb6zzcL6/dGebhnAD
 Suoc1AkOOE+a5phF2cBajCPhJxiGyh/4zo3ZJkNIY6Vk3fCkCwKwV/fM/spjd2+898yG
 9IbtVm20FD5DkndNFDUebW4rH47IWF8x/r2KhBOUyT6ZW4Vc31AMeXwL9CCSa+nLP1XJ RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpp6jg1sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 11:09:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25FB9ASU011773;
        Wed, 15 Jun 2022 11:09:10 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpp6jg1rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 11:09:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25FB6fGp021976;
        Wed, 15 Jun 2022 11:09:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3gmjajdq9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 11:09:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25FB957B19267938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 11:09:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 298EE11C05C;
        Wed, 15 Jun 2022 11:09:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD75D11C052;
        Wed, 15 Jun 2022 11:09:04 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jun 2022 11:09:04 +0000 (GMT)
Message-ID: <9c2069d590bed05d82d60f49deef5796c73d5022.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND v5 1/4] PCI: Clean up pci_scan_slot()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Jun 2022 13:09:04 +0200
In-Reply-To: <20220602103016.1499031-2-schnelle@linux.ibm.com>
References: <20220602103016.1499031-1-schnelle@linux.ibm.com>
         <20220602103016.1499031-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3yNoGPxSgtDt6_X4h6RFUEU47DwYR5Uz
X-Proofpoint-ORIG-GUID: SWeAplfMQmk1mVfDcpIsUYs8IOlj5545
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_03,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=416 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2022-06-02 at 12:30 +0200, Niklas Schnelle wrote:
> While determining the next PCI function is factored out of
> pci_scan_slot() into next_fn() the former still handles the first
> function as a special case. This duplicates the code from the scan loop.
> 
> Furthermore the non ARI branch of next_fn() is generally hard to
> understand and especially the check for multifunction devices is hidden
> in the handling of NULL devices for non-contiguous multifunction. It
> also signals that no further functions need to be scanned by returning
> 0 via wraparound and this is a valid function number.
> 
> Improve upon this by transforming the conditions in next_fn() to be
> easier to understand.
> 
> By changing next_fn() to return -ENODEV instead of 0 when there is no
> next function we can then handle the initial function inside the loop
> and deduplicate the shared handling. This also makes it more explicit
> that only function 0 must exist.
> 
> No functional change is intended.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/probe.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 

Just a friendly ping, I resent last week but this is still the same
PATCH as originally sent on May 5.

