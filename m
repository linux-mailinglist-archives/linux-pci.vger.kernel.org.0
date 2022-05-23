Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84917530BCE
	for <lists+linux-pci@lfdr.de>; Mon, 23 May 2022 11:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiEWIl0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 May 2022 04:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiEWIlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2022 04:41:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A786413;
        Mon, 23 May 2022 01:41:05 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24N8LPC5001298;
        Mon, 23 May 2022 08:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pxBN4qd2Ox8ZyLMxExL1i3qx0MaG8nHVRbGAtGIlZ5Q=;
 b=r9jcFozH9ZYNP6y1NQuLpp1Ol778rYWh9S2ZFyYUC68UqVitrfS+bGGDmfck/lCZOQdb
 m14/UXjLwN5h9X61xQLmrGRkEKmWLW7+rdwflF/i5OMlHkbC/9J/gDiWDBCk0bEJyvPg
 MeTdPg8/UNa2TIuAAYn7c440WC3ACoP1TDP/aYjceBdT5KgLzhWGQ/ebEIhLNoMsJbaz
 CrWaluMXEUyA2YJ0ihX7Vgkh/I3xt88JW1JCGwyr9It98/HpA7onqSyrJOqZsF7u9TkI
 EtDRNtD/kb1PmBMdMG1YEAEIlf3jLAqyXBI6sY1Oq/4URYhAYKINU+xwAtrK9s8xOn5S +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g7a3ryftf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 08:40:59 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24N7vawt028878;
        Mon, 23 May 2022 08:40:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g7a3ryft1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 08:40:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24N7fNpZ001898;
        Mon, 23 May 2022 08:40:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3g6qq92fbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 08:40:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24N8er8B51773894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 08:40:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B51C85204E;
        Mon, 23 May 2022 08:40:53 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6B4F55204F;
        Mon, 23 May 2022 08:40:53 +0000 (GMT)
Message-ID: <26e53653b06e6045ef94f2c5f9c10e333821f186.camel@linux.ibm.com>
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
Date:   Mon, 23 May 2022 10:40:53 +0200
In-Reply-To: <20220513140723.GA947754@bhelgaas>
References: <20220513140723.GA947754@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oiYVEcXeUU0nn-6MTTh1kgwana7kjaKx
X-Proofpoint-ORIG-GUID: fQ9j2cjFyKKG-q4izm0OY682iSR6rOu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_03,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=946 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230045
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
> wedding reception but will get back to it next week.  Just to expose
> some of my thought process (and not to request more work from you!)
> I've been wondering whether b1bd58e448f2 ("PCI: Consolidate
> "next-function" functions") is really causing us more trouble than
> it's worth.  In some ways that makes the single next-function harder
> to read.  But I guess the hypervisor special case is not exactly a
> "next-function" thing -- it's a "keep scanning even if there's no fn
> 0" thing.
> 
> Bjorn

I've thought again about your comment. Personally what I like about
b1bd58e448f2 ("PCI: Consolidate "next-function" functions") is that it got rid of the next_fn function pointer complication. I agree though that on the other hand it removed a nice separation between the ARI and traditional cases. So I'm thinking maybe we should bring that part back. I think my patch as is makes it easier to see the equivalence to the existing code but then we could add a patch on top and turn it into the below, it's a bit more verbose but very easy to follow.

static int next_ari_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
{
…
}

static int next_trad_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
{
	if (fn >= 7)
		return -ENODEV;

	/* only multifunction devices may have more functions */
	if (dev && !dev->multifunction)
		return -ENODEV;

	return fn + 1;
}

static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
{
	if (pci_ari_enabled(bus)) {
		return next_ari_fn(bus, dev, fn);
	}
	return next_trad_fn(bus, dev, fn);
}


