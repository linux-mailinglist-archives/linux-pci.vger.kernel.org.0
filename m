Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043F95250B9
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 16:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355250AbiELO5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 10:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355261AbiELO46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 10:56:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5C62110;
        Thu, 12 May 2022 07:56:54 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CDEieF013709;
        Thu, 12 May 2022 14:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OMTehq1XmIz0jvyyrlNCokWf0qJnSvtY2n6I6yV8cJU=;
 b=NCTUgIcBSMWOc7AaVGbIEUo6PV5zTQvVZ+74j7YKZaPgFzNz/WPkC8zumY/vxFaWuz8G
 uJUKseaWoMzbGLjzF5zPTK46VFvbynTDjs3dnsMhy1di8NjbE2VuXVFTioIHdmPcRDtX
 bjr8mUaMCPjHz7q6cmBtJ4KmDyi7TipfQ3Qfxpk3GahiqOQXR/aVO3Hs7UtHrPbi4pVL
 NdUQucyBR6Hg/XcvTI/ickt4bF89EwwN5khFPVDcDozThdtJphafNiHIHXyfleGkUWj4
 fo7JcpokzedK+t0kK7CczxAwLLjLOmJqd6pqlwerucEzG6F1KntfIjKVgwexe+XyOYws 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g12xytts5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 14:56:50 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24CEmPGL016086;
        Thu, 12 May 2022 14:56:50 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g12xyttrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 14:56:50 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CEnoCX013435;
        Thu, 12 May 2022 14:56:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3g0ma1gyjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 14:56:47 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CEuijo47776016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 14:56:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6440611C04C;
        Thu, 12 May 2022 14:56:44 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7E1B11C04A;
        Thu, 12 May 2022 14:56:43 +0000 (GMT)
Received: from sig-9-145-9-18.uk.ibm.com (unknown [9.145.9.18])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 14:56:43 +0000 (GMT)
Message-ID: <f34130034637278c9999cf6d430be558cb0c2318.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND v5 1/4] PCI: Clean up pci_scan_slot()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Thu, 12 May 2022 16:56:42 +0200
In-Reply-To: <20220505083839.1315705-2-schnelle@linux.ibm.com>
References: <20220505083839.1315705-1-schnelle@linux.ibm.com>
         <20220505083839.1315705-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fOs3S_ad3T-Zy_kK72KB4445G0h2S1dR
X-Proofpoint-ORIG-GUID: e6GeGN562Lkekf1wksfaStG8ZKiR2OpF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_10,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=473 spamscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205120067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2022-05-05 at 10:38 +0200, Niklas Schnelle wrote:
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

Friendly ping :-)

