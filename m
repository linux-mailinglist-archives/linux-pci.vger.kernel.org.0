Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632BD5795A0
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbiGSIyk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 04:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbiGSIyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 04:54:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74FA10561;
        Tue, 19 Jul 2022 01:54:37 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26J73udP014321;
        Tue, 19 Jul 2022 01:54:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pfpt0220;
 bh=43NylK9vU9jEIhVd4w7Tv6pt6V3Rf4VRjNPWeqLM19w=;
 b=hOhbvbGhCK9wixtr9u8WqQEAzY2xIbqrOsph5/caovAEO3QtwhyJ6/n1pFdFJ10IROgO
 sXx1pe+f/QxKkh4gZungFj5YBatQ7xx2DXLycVQX1MiX5gkA9CntbcEMvMh3GFMXTtz6
 +WRXWa+eqHuElJIVyqhEuu7EjOeO5NL/hA8XJuGY667wW93AIJb0kcyAPmaMGNI/gUWQ
 7TXOUeU/nPHnnBE0wP5K1vnNBJ2CiaUnVuN3dPV4Rgif2lja5INKU6+Z4ZqOxoG4XpaD
 f8PXY9WF+W4e/P+Yxzy/e3VwkWYtBKo7u3dWD6tGuT0ODz6KjztMmboNna3cunhf4MRN Iw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3hdqw18ae8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 01:54:19 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jul
 2022 01:54:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jul 2022 01:54:18 -0700
Received: from proliant-dl360 (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 48A5C3F70A2;
        Tue, 19 Jul 2022 01:54:17 -0700 (PDT)
Date:   Tue, 19 Jul 2022 01:54:17 -0700
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Issues with A3720 PCIe controller driver pci-aardvark.c
Message-ID: <20220719085417.GA25397@proliant-dl360>
References: <20210723221710.wtztsrddudnxeoj3@pali>
 <20220216200940.fwdwk5rcb4zq6dyg@pali> <20220710112108.jegpz4khfsrb4ahd@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220710112108.jegpz4khfsrb4ahd@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: lc6VoWLx7hvIIWFfqxTgFgE5bZYFvCW7
X-Proofpoint-GUID: lc6VoWLx7hvIIWFfqxTgFgE5bZYFvCW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_22,2022-07-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 10, 2022 at 01:21:08PM +0200, Pali Rohár wrote:
> + Other people from Marvell active on LKML.
> 
> Could you please look at this issue and give us some comment? It is
> really critical issue which needs to be solved.
> 

Hi Pali,

Thank you for reaching me out. I hope I can help.
I don't work directly over Armada A3720 nor knowing anyone from team.
Unfortunately, this means I have no access to the data/code you are
looking for. Nevertheless, I have escalated this problem internally.
I believe this should help to get to right people which can investigate
patch/issue and do actual work.

Kind regards,
Wojciech.

> On Wednesday 16 February 2022 21:09:40 Pali Rohár wrote:
> > + Bharat, Veerasenareddy and Wojciech from Marvell
> > 
> > Hello! Could you please look at this email and help us with this Marvell HW issue?
> > 
> > On Saturday 24 July 2021 00:17:10 Pali Rohár wrote:
> > > Hello Konstantin!
> > > 
> > > There are issues with Marvell Armada 3720 PCIe controller when high
> > > performance PCIe card (e.g. WiFi AX) is connected to this SOC. Under
> > > heavy load PCIe controller sends fatal abort to CPU and kernel crash.
> > > 
> > > In Marvell Armada 3700 Functional Errata, Guidelines, and Restrictions
> > > document is described erratum 3.12 PCIe Completion Timeout (Ref #: 251)
> > > which may be relevant. But neither Bjorn, Thomas nor me were able to
> > > understood text of this erratum. And we have already spent lot of time
> > > on this erratum. My guess that is that in erratum itself are mistakes
> > > and there are missing some other important details.
> > > 
> > > Konstantin, are you able to understand this erratum? Or do you know
> > > somebody in Marvell who understand this erratum and can explain details
> > > to us? Or do you know some more details about this erratum?
> > > 
> > > Also it would be useful if you / Marvell could share text of this
> > > erratum with linux-pci people as currently it is available only on
> > > Marvell Customer Portal which requires registration with signed NDA.
> > > 
> > > In past Thomas wrote patch "according to this erratum" and I have
> > > rebased, rewritten and resent it to linux-pci mailing list for review:
> > > https://lore.kernel.org/linux-pci/20210624222621.4776-6-pali@kernel.org/
> > > 
> > > Similar patch is available also in kernel which is part of Marvell SDK.
> > > 
> > > Bjorn has objections for this patch as he thinks that bit DIS_ORD_CHK in
> > > that patch should be disabled. Seems that enabling this bit effectively
> > > disables PCIe strong ordering model. PCIe kernel drivers rely on PCIe
> > > strong ordering, so it would implicate that that bit should not be
> > > enabled. Which is opposite of what is mentioned patch doing.
> > > 
> > > Konstantin, could you help us with this problem?
