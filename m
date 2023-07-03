Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8827461BF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGCSC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 14:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGCSCz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 14:02:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151F7B3;
        Mon,  3 Jul 2023 11:02:54 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363I1nJF013926;
        Mon, 3 Jul 2023 18:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ViaCQboEoqoC1SxuFuQ30JlPi06Gs9yRXq7q20ZtG4E=;
 b=sTKnqVi1WUkJzL8CUNH3LwutDmQYgTW1r4nLtDAQyzdCEgDUMNicRZ/KYatTR8vcqqpI
 6qWPfYUcg3S3BfHT3goEaxHh3ZGO+FsH2ItVr7LTe3xvg6EvK0zTnAR9vwy7pw0Svr3J
 WUHCJA37fYcUmv3csObOt15qwJobfLdt1rSiKQs4Tpx9WdTgGbJf5x9TDjAakeI2xjID
 z6kvwnZOjIYLcV9dc7vUhpDlqCJyiWLBhrg+DUjLygPzJGbENFwhQlIEW5E0xHRi2rkt
 ue4S/W8Kj6TbCXn+Dtj5WRBxgycWYTdufTx2jLcsb7p4ls5tbipggGopG2iWqmxb79ZL 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm38jr0sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 18:02:47 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363I2f5U016328;
        Mon, 3 Jul 2023 18:02:46 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm38jr0rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 18:02:46 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 363GLNg3003348;
        Mon, 3 Jul 2023 18:02:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rjbdds4e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 18:02:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 363I2fNs48103788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jul 2023 18:02:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB47120040;
        Mon,  3 Jul 2023 18:02:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4458F20043;
        Mon,  3 Jul 2023 18:02:41 +0000 (GMT)
Received: from [9.171.84.180] (unknown [9.171.84.180])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jul 2023 18:02:41 +0000 (GMT)
Message-ID: <9778740b9e07b9bb92b86bf13b8f6329485ae418.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/2] PCI: Handle HAS_IOPORT dependencies
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Jul 2023 20:02:40 +0200
In-Reply-To: <20230703174233.GA529479@bhelgaas>
References: <20230703174233.GA529479@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FXqH1HfRaoUJLIigdsyDJGERQZbnKhCL
X-Proofpoint-ORIG-GUID: I21vbk60RnZzvBfSJdz-AacyCLSAczYl
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2023-07-03 at 12:42 -0500, Bjorn Helgaas wrote:
> On Mon, Jul 03, 2023 at 03:52:53PM +0200, Niklas Schnelle wrote:
> > Hi Bjorn,
> >=20
> > This is a follow up to my ongoing effort of making the inb()/outb() and
> > similar I/O port accessors compile-time optional. Previously I sent thi=
s as
> > a complete treewide series titled "treewide: Remove I/O port accessors =
for
> > HAS_IOPORT=3Dn" with the latest being its 5th version[0]. Now about hal=
f of
> > the per-subsystem patches have been merged so I'm changing over to stand
> > alone subsystem patches. These series are stand alone and should be mer=
ged
> > via the relevant tree such that with all subsystems complete we can fol=
low
> > this up with the last patch[1] that will make the I/O port accessors
> > compile-time optional.
>=20
> Is the merge plan for each subsystem to merge this separately?  I
> acked these so they could be merged along with all the tree-wide
> changes.

Hi Bj=C3=B6rn,

Yeah this went back and forth a little, sorry about that. With the
Kconfig introduction of HAS_IOPORT merged about half of the original
patches have been merged via subsystem maintainers or are at least
sitting in linux-next already.  Arnd was anticipating that he'll pick
up some left overs but at the moment the simplest is for subsystems to
pick the patches up themselves ideally and if small enough for v6.5
still.

Thanks,
Niklas

>=20
> > As for compile-time vs runtime see Linus' reply to my first attempt[2].
> >=20
> > Other than rebasing on current master there are no changes to these
> > two patches for the PCI subsystem.
> >=20
> > Thanks,
> > Niklas
> >=20
> > [0] https://lore.kernel.org/all/20230516110038.2413224-1-schnelle@linux=
.ibm.com/
> > [1] https://lore.kernel.org/all/20230516110038.2413224-42-schnelle@linu=
x.ibm.com/
> > [2] https://lore.kernel.org/lkml/CAHk-=3Dwg80je=3DK7madF4e7WrRNp37e3qh6=
y10Svhdc7O8SZ_-8g@mail.gmail.com/
> >=20
> > Niklas Schnelle (2):
> >   PCI: Make quirk using inw() depend on HAS_IOPORT
> >   PCI/sysfs: Make I/O resource depend on HAS_IOPORT
> >=20
> >  drivers/pci/pci-sysfs.c | 4 ++++
> >  drivers/pci/quirks.c    | 2 ++
> >  2 files changed, 6 insertions(+)
> >=20
> >=20
> > base-commit: a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
> > --=20
> > 2.39.2
> >=20

