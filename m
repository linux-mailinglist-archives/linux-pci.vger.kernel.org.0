Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84D563606
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiGAOn2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiGAOnH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 10:43:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2201114;
        Fri,  1 Jul 2022 07:42:48 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261EMjir002604;
        Fri, 1 Jul 2022 14:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uyWJEummehwzc0wqCJ2uwFIV2Y5jSghhAfoFZA7XG1g=;
 b=HBz1DGmE5k4hmSG///y6N17ss14zIJRDERZ+6NWkuOy6XYnuRuX/WWeVjNGL4nEMXKez
 58gY4zZEjKBBLIpJNBrQX77pqgp87K6TDWqVnUqLIWW+b2DGz0AxDRBO4SFH5WFke4/1
 nsyMyEDcHVUMkK9SAL5n9Amw8/dMz0OT9xS+WyPCrWSKtb+IUQZkGBgx0B+XmMqG/xaj
 sKwgyoYSDxwJaxzS8GD9jFbKd7uVTDWbOTllaZmYjvbDbwoM4gYMHVFkj2wXQfU2weah
 rtpRnfgolbeN4hlF8s3kStUs0eAUBDi5q8OlxUlbxwzlM9yMB1/PVXx+W0QTV9Sb2HQf LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h22mw0pw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 14:42:45 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 261EMlBa002672;
        Fri, 1 Jul 2022 14:42:44 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h22mw0pvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 14:42:44 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 261EKnsS023962;
        Fri, 1 Jul 2022 14:42:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3gwsmhycea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 14:42:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 261EgdoW22544782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 14:42:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11B8DAE04D;
        Fri,  1 Jul 2022 14:42:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C2CCAE053;
        Fri,  1 Jul 2022 14:42:38 +0000 (GMT)
Received: from sig-9-145-161-31.de.ibm.com (unknown [9.145.161.31])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 14:42:38 +0000 (GMT)
Message-ID: <ec7b4f2ad9f1cfb6ad47e9476b11127ecb24a9f7.camel@linux.ibm.com>
Subject: Re: [PATCH v6 4/5] PCI: Extend isolated function probing to s390
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Jul 2022 16:42:38 +0200
In-Reply-To: <90996285-9ae3-0030-a5e3-a3f1bfa23088@linux.ibm.com>
References: <20220628143100.3228092-1-schnelle@linux.ibm.com>
         <20220628143100.3228092-5-schnelle@linux.ibm.com>
         <90996285-9ae3-0030-a5e3-a3f1bfa23088@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hAEhURQexcZrhd5fEISYsMF1jKiQ9yPg
X-Proofpoint-ORIG-GUID: jA-tqPmvu7yEOhqBN6Yg0M-MkSCQZmYE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=786 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2022-06-30 at 14:45 +0200, Pierre Morel wrote:
> 
> On 6/28/22 16:30, Niklas Schnelle wrote:
> > Like the jailhouse hypervisor s390's PCI architecture allows passing
> > isolated PCI functions to an OS instance. As of now this is was not
> > utilized even with multi-function support as the s390 PCI code makes
> > sure that only virtual PCI busses including a function with devfn 0 are
> > presented to the PCI subsystem. A subsequent change will remove this
> > restriction.
> > 
> > Allow probing such functions by replacing the existing check for
> > jailhouse_paravirt() with a new hypervisor_isolated_pci_functions()
> > helper.
> > 
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   drivers/pci/probe.c        | 2 +-
> >   include/linux/hypervisor.h | 8 ++++++++
> >   2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index a18e07e6a7df..156dd13594b8 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -2667,7 +2667,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
> >   			 * a hypervisor which passes through individual PCI
> >   			 * functions.
> >   			 */
> > -			if (!jailhouse_paravirt())
> > +			if (!hypervisor_isolated_pci_functions())
> >   				break;
> >   		}
> >   		fn = next_fn(bus, dev, fn);
> > diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
> > index fc08b433c856..33b1c0482aac 100644
> > --- a/include/linux/hypervisor.h
> > +++ b/include/linux/hypervisor.h
> > @@ -32,4 +32,12 @@ static inline bool jailhouse_paravirt(void)
> >   
> >   #endif /* !CONFIG_X86 */
> >   
> > +static inline bool hypervisor_isolated_pci_functions(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_S390))
> > +		return true;
> > +	else
> > +		return jailhouse_paravirt();
> 
> I would spare the else,

I don't have a preference for either style so sure.

> 
> Another remark, shouldn't it be the last patch?

Either way should work. Without the last patch we don't try to probe
and without this patch the probing wouldn't find the function. I think
I'll keep the order to keep the PCI subsystem changes together and
because I feel trying to probe without that working is worse than not
probing.

> 
> otherwise LGTM
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>

Thanks for taking a look!

> 
> 
> > +}
> > +
> >   #endif /* __LINUX_HYPEVISOR_H */
> > 


