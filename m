Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0658156D8E6
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 10:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiGKIw4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 04:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiGKIwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 04:52:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6A13CE5;
        Mon, 11 Jul 2022 01:52:16 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26B7fa6R010452;
        Mon, 11 Jul 2022 08:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BhyO2WRLnC/DTMynWyqxIUjvX2BCdvDD3VYAHU2VgLI=;
 b=WKkU/Dbh2NMa0q6cSAUlJ5OufWRIUKUHAX2yu+WhmIl8sdCfp2+/04PUJHM3VGKxlD+q
 HxXyiGozoMJICzgoBUBNk94a0rIJtQ5DEnxIV+PaMb3qUREWjUP0tqAtcbI4RCZ33dkN
 ygiKCRg4w/3jbyHekjLBtJ97jEB39yUDR53A0yE9+M3vl4tfpyzSVzomKOlAPr8EPqfI
 2JzZhxBnPrdULK2JaprfMOVDnKGMKAf9JG6n/vABx9EA8qpTiWSmuyiiIIZ+LcWhaZPX
 FVlirVkM8B2WmkjDyoxehfgWnC0LpU/yBOHSywMK7TJd1gO53YlibPp6LEqHLwiGGxKd vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h83ffnaj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:52:14 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26B87Noa025095;
        Mon, 11 Jul 2022 08:52:13 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h83ffnaht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:52:13 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26B8oG4O032417;
        Mon, 11 Jul 2022 08:52:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3h71a8jf25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 08:52:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26B8q79R23724402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 08:52:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE8FD5204E;
        Mon, 11 Jul 2022 08:52:07 +0000 (GMT)
Received: from sig-9-145-46-98.uk.ibm.com (unknown [9.145.46.98])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 443E75204F;
        Mon, 11 Jul 2022 08:52:07 +0000 (GMT)
Message-ID: <4d6275a5c1a77ae827845a5189875673eb1429ff.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/5] PCI: Clean up pci_scan_slot()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 11 Jul 2022 10:52:06 +0200
In-Reply-To: <03fff591-63e1-2dab-06d5-1fac242c248f@linux.ibm.com>
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
         <20220628143100.3228092-2-schnelle@linux.ibm.com>
         <17c30662-7285-0e1a-91fb-071fa2cfc733@linux.ibm.com>
         <7741c617519b786750fbe04029fbb6295c8d6c85.camel@linux.ibm.com>
         <03fff591-63e1-2dab-06d5-1fac242c248f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e9qlD7q8Kmrq1RpmyCR6YO1IP36AXcxw
X-Proofpoint-ORIG-GUID: AVjGl7sb1aNxfCbxEqW9R6F1gzZlXcx5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_13,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015 mlxlogscore=875
 suspectscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2022-06-30 at 16:50 +0200, Pierre Morel wrote:
> > > 

> 
> On 6/30/22 15:48, Niklas Schnelle wrote:
> > On Thu, 2022-06-30 at 14:40 +0200, Pierre Morel wrote:
> > > On 6/28/22 16:30, Niklas Schnelle wrote:
> > > > While determining the next PCI function is factored out of
> > > > pci_scan_slot() into next_fn() the former still handles the first
> > > > function as a special case. This duplicates the code from the scan loop.
> > > > 
> > > > Furthermore the non ARI branch of next_fn() is generally hard to
> > > > understand and especially the check for multifunction devices is hidden
> > > > in the handling of NULL devices for non-contiguous multifunction. It
> > > > also signals that no further functions need to be scanned by returning
> > > > 0 via wraparound and this is a valid function number.
> > > > 
> > > > Improve upon this by transforming the conditions in next_fn() to be
> > > > easier to understand.
> > > > 
> > > > By changing next_fn() to return -ENODEV instead of 0 when there is no
> > > > next function we can then handle the initial function inside the loop
> > > > and deduplicate the shared handling. This also makes it more explicit
> > > > that only function 0 must exist.
> > > > 
> > > > No functional change is intended.
> > > > 
> > > > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >    drivers/pci/probe.c | 38 +++++++++++++++++++-------------------
> > > >    1 file changed, 19 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > > index 17a969942d37..b05d0ed83a24 100644
> > > > --- a/drivers/pci/probe.c
> > > > +++ b/drivers/pci/probe.c
> > > > @@ -2579,8 +2579,7 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
> > > >    }
> > > >    EXPORT_SYMBOL(pci_scan_single_device);
> > > >    
> > > > -static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
> > > > -			    unsigned int fn)
> > > > +static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
> > > >    {
> > > >    	int pos;
> > > >    	u16 cap = 0;
> > > > @@ -2588,24 +2587,26 @@ static unsigned int next_fn(struct pci_bus *bus, struct pci_dev *dev,
> > > >    
> > > >    	if (pci_ari_enabled(bus)) {
> > > >    		if (!dev)
> > > > -			return 0;
> > > > +			return -ENODEV;
> > > >    		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
> > > >    		if (!pos)
> > > > -			return 0;
> > > > +			return -ENODEV;
> > > >    
> > > >    		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
> > > >    		next_fn = PCI_ARI_CAP_NFN(cap);
> > > >    		if (next_fn <= fn)
> > > > -			return 0;	/* protect against malformed list */
> > > > +			return -ENODEV;	/* protect against malformed list */
> > > >    
> > > >    		return next_fn;
> > > >    	}
> > > >    
> > > > -	/* dev may be NULL for non-contiguous multifunction devices */
> > > > -	if (!dev || dev->multifunction)
> > > > -		return (fn + 1) % 8;
> > > > +	if (fn >= 7)
> > > > +		return -ENODEV;
> > > > +	/* only multifunction devices may have more functions */
> > > > +	if (dev && !dev->multifunction)
> > > > +		return -ENODEV;
> > > >    
> > > > -	return 0;
> > > > +	return fn + 1;
> > > 
> > > No more % 8 ?
> > > Even it disapear later shouldn't we keep it ?
> > 
> > The "% 8" became unnecessary due to the explicit "if (fn >= 7)"
> > above.
> > The original "% 8" did what I referred to in the commit message with
> > "It [the function] also signals that no further functions need to be
> > scanned by returning 0 via wraparound and this is a valid function
> > number.". Instead we now explicitly return -ENODEV in this case.
> 
> Yes it goes with it.
> With this code next_fn returns -ENODEV for fn = 8 instead of previously 
> returning 1. (If I am right)
> 
> With the previous code, did we assume that next_fn is never called with 
> fn > 7?
> I guess yes as we test pci_ari_enabled first and without ARI we do not 
> have more than 7 more functions. is it right?
> 
> For what I think this new code seems better as it does not make the 
> assumption that it get called with fn < 8.
> 

The fn value in this case iterates through the least significant 3 bits
of the geographical PCI address so yes this limits it to 7 functions.
My main qualm with the old code was that returning 0 for the end is
ambiguous because that is also a valid devfn.

