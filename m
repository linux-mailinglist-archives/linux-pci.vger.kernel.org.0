Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D41526533
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 16:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381456AbiEMOsR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381469AbiEMOsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 10:48:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA937A89;
        Fri, 13 May 2022 07:48:11 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DEgBoh005087;
        Fri, 13 May 2022 14:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=s0WN2+DMgoJiF82+YJyYinfUJAknvVrSPwJB+rRF9gQ=;
 b=NaAVK5d3kh+qI2QaPxZIOumP4yRyhotiYkUL+ZvN/2Mb+vkB3yFZMjCBsJ/o5/1QUl3O
 qBuniOO5j/JUZm93E6UBMJKqJInnUXusv+6oHn8ps/JQnJy8J0WHFQLhbnFSPJgGknBn
 XDfrlc0H95gSIYedaVd5J/xeXccn9SrsVwKbZe2QAiTmT+cCzyDOKc5y/nJ95S4uNIu7
 tR7UkCo30QQofjT/i/klMD061X35ctogoR5+jRTYUv0/XQ+VYqXlvdsworvmohVw/bVw
 q/PmsStj2yCN3Sr4aiFl0+673qK7r/XL0xyjtKTtluPpIIjWHzNnLh/7G7oTOCoW5Pqa sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1sasg4yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 14:48:06 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24DEhCti007397;
        Fri, 13 May 2022 14:48:05 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1sasg4xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 14:48:05 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24DEhDPR029087;
        Fri, 13 May 2022 14:48:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3fwgd8xw6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 14:48:03 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24DElaBA22872536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 May 2022 14:47:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E14A611C04A;
        Fri, 13 May 2022 14:47:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6391A11C04C;
        Fri, 13 May 2022 14:47:59 +0000 (GMT)
Received: from sig-9-145-187-37.de.ibm.com (unknown [9.145.187.37])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 May 2022 14:47:59 +0000 (GMT)
Message-ID: <e0509c905b25f2fbd4edb33928bd0f57f1b0ef1b.camel@linux.ibm.com>
Subject: Re: [PATCH RESEND v5 1/4] PCI: Clean up pci_scan_slot()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Fri, 13 May 2022 16:47:59 +0200
In-Reply-To: <20220513140723.GA947754@bhelgaas>
References: <20220513140723.GA947754@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t1w7uGj-nGGZKoUEgGqr151EM79LEoyh
X-Proofpoint-GUID: wP6AhWUfDf8XmTpqUNVK3Nxwg3MHzNzd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=584 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2022-05-13 at 09:07 -0500, Bjorn Helgaas wrote:
> On Thu, May 12, 2022 at 04:56:42PM +0200, Niklas Schnelle wrote:
> > On Thu, 2022-05-05 at 10:38 +0200, Niklas Schnelle wrote:
> > > While determining the next PCI function is factored out of
> > > pci_scan_slot() into next_fn() the former still handles the first
> > > function as a special case. This duplicates the code from the scan loop.
> > > 
> > > Furthermore the non ARI branch of next_fn() is generally hard to
> > > understand and especially the check for multifunction devices is hidden
> > > in the handling of NULL devices for non-contiguous multifunction. It
> > > also signals that no further functions need to be scanned by returning
> > > 0 via wraparound and this is a valid function number.
> > > 
> > > Improve upon this by transforming the conditions in next_fn() to be
> > > easier to understand.
> > > 
> > > By changing next_fn() to return -ENODEV instead of 0 when there is no
> > > next function we can then handle the initial function inside the loop
> > > and deduplicate the shared handling. This also makes it more explicit
> > > that only function 0 must exist.
> > > 
> > > No functional change is intended.
> > > 
> > > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > 
> > Friendly ping :-)
> 
> Thanks and sorry for the delay.  I'm off today for my daughter's
> wedding reception but will get back to it next week. 

No worries, have a great day and congratulations!

>  Just to expose
> some of my thought process (and not to request more work from you!)
> I've been wondering whether b1bd58e448f2 ("PCI: Consolidate
> "next-function" functions") is really causing us more trouble than
> it's worth.  In some ways that makes the single next-function harder
> to read.  But I guess the hypervisor special case is not exactly a
> "next-function" thing -- it's a "keep scanning even if there's no fn
> 0" thing.
> 
> Bjorn

Yeah I do see your point. Let's discuss next week.

