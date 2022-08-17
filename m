Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CF1596991
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiHQG2H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Aug 2022 02:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiHQG2G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Aug 2022 02:28:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ABC7AC23
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 23:28:04 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H6H6f9023201;
        Wed, 17 Aug 2022 06:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=b3c+T/I8VRN99OAtLfw36601faUhtTknvvWcypz9uCc=;
 b=LPv8GAQZktEHbFfobUM9FCicQsCJotogmIcZhvWtvtsGJQnWfB8jyEi2Bwd/vS9/ebfl
 dIwW+Gmc+lGM7rMWTT9KKkYrl2FxcRyGljivASo9XbMl8kAowCZddWkMI9MYYwzQRI1Q
 FzNG7lYmtZTY/NJQu8L4pa/KbtZPxTmkFfilC9jX9OqBZ8cjj9ZcxlqlOTa45Qta88WF
 B3S34pryFPiTDUyzaZXlRSNHFILWYlO7a3KtRTIbUflub/kiaauvn6PBzoNIGNiUaBHD
 0n0bNcQfmBmCuobVizTeG5VaNEM3drSfTIzDMah1ywzMwZWfECHFsxWy2Wjbr7IP78TY KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0tx1g6yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 06:27:54 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27H6LZ1A005580;
        Wed, 17 Aug 2022 06:27:54 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0tx1g6xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 06:27:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27H66VYT026302;
        Wed, 17 Aug 2022 06:27:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3hx3k9c288-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 06:27:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27H6RnZQ20840814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 06:27:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A243A4040;
        Wed, 17 Aug 2022 06:27:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18F7DA404D;
        Wed, 17 Aug 2022 06:27:48 +0000 (GMT)
Received: from in.ibm.com (unknown [9.43.50.103])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 17 Aug 2022 06:27:47 +0000 (GMT)
Date:   Wed, 17 Aug 2022 11:57:44 +0530
From:   Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] MAINTAINERS: Remove myself as EEH maintainer
Message-ID: <20220817062744.gpd33ykw5jja7ql5@in.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20220806085301.25142-1-ruscur@russell.cc>
 <87lervcn9o.fsf@mpe.ellerman.id.au>
 <CAOSf1CHtmSPSbW-KiL7svks2sXO4KEx9hZteHJjRvvfqcb6YoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CHtmSPSbW-KiL7svks2sXO4KEx9hZteHJjRvvfqcb6YoQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0wafaeaC8eibPkJIYKXP2KV5kFBwxNDe
X-Proofpoint-ORIG-GUID: yV8qLBXMaVG82w0570J-i4E-2TXM2yva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_04,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-08-11 17:19:47 Thu, Oliver O'Halloran wrote:
> On Thu, Aug 11, 2022 at 4:22 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Russell Currey <ruscur@russell.cc> writes:
> > > I haven't touched EEH in a long time I don't have much knowledge of the
> > > subsystem at this point either, so it's misleading to have me as a
> > > maintainer.
> >
> > Thank you for your service.
> >
> > > I remain grateful to Oliver for picking up my slack over the years.
> >
> > Ack.
> >
> > But I wonder if he is still happy being listed as the only maintainer.
> > Given the status is "Supported" that means "Someone is actually paid to
> > look after this" - and I suspect Oracle are probably not paying him to
> > do that?
> 
> I'm still happy to field questions and/or give reviews occasionally if
> needed, but yeah I don't have the time, hardware, or inclination to do
> any actual maintenance. IIRC Mahesh was supposed to take over
> supporting EEH after I left IBM. If he's still around he should
> probably be listed as a maintainer.

Yes, I am still around. I am currently looking into the EEH and will be
glad to take over the maintenanership of EEH for powerpc. Please feel
free to add me as maintainer for EEH.

Thanks,

-- 
Mahesh J Salgaonkar
