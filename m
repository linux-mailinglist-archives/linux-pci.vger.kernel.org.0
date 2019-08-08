Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A88A86B15
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 22:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404329AbfHHUGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 16:06:13 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:53166 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404070AbfHHUGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 16:06:12 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78Jt2df030495;
        Thu, 8 Aug 2019 16:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=spsW3iJj1C+z5+hobnJKI3JF6/CSZLZhsxP1rFK06xI=;
 b=Rq2ekKxw0YDYt1yk99p2KNKEQVqEbzNWb8vDtd6+ZUlk/Im71MAXiuc3oHmiLLFf3+Jy
 8NtlzD8iI03JsZ1Y+t5Oq7bI9DOYFdSikBrLry+sJ94Kl9bNWkjATEmE4mW00X6yJbog
 i6rBs8cPIKHw5zcWI95B33Juh3pJfFDrEoMEYxyrquQvLGUoJGJMKiNw5xG+k0d1cJc1
 3+ZUxNKfpn6hEszW4+rFx8XXKcWoL8lxdWGsetuVeUy9nOWu65CsIaAFQNLTbMJsi7ce
 5gEcxylft/2Z15fgcZIUJOspVF+PDiXyYm/hvbVRzv3dDqGgyN7Ff9A1ryP9VLigL+No oA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2u8qf08sys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 16:06:11 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78JrOQL100095;
        Thu, 8 Aug 2019 16:06:11 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 2u8q3cu1c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 16:06:10 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="841637776"
From:   <Mario.Limonciello@dell.com>
To:     <helgaas@kernel.org>, <rafael@kernel.org>
CC:     <rjw@rjwysocki.net>, <linux-nvme@lists.infradead.org>,
        <kbusch@kernel.org>, <kai.heng.feng@canonical.com>,
        <keith.busch@intel.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rajatja@google.com>, <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
Thread-Topic: [PATCH v2 2/2] nvme-pci: Allow PCI bus-level PM to be used if
 ASPM is disabled
Thread-Index: AQHVTdGT69rR0fb3wUCKiH74wnB2qabxltQAgAAR1ICAAEDdAP//rTHA
Date:   Thu, 8 Aug 2019 20:05:48 +0000
Message-ID: <707af7109fee4942a4ba8eebbee6cde8@AUSX13MPC105.AMER.DELL.COM>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain> <1921165.pTveHRX1Co@kreacher>
 <1870928.r7tBYyfqdz@kreacher> <20190808134356.GF151852@google.com>
 <CAJZ5v0h=nz8yXwOOGBUB9m1GtJPOqBwtNK7zXPNMJjzPhMWd9w@mail.gmail.com>
 <20190808183954.GG151852@google.com>
In-Reply-To: <20190808183954.GG151852@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-08T20:05:47.1803865Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080177
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080177
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> This is more meaningful to you than to most people because "applying
> the standard PCI PM" doesn't tell us what that means in terms of the
> device.  Presumably it has something to do with a D-state transition?
> I *assume* a suspend might involve the D0 -> D3hot transition you
> mention below?
>=20
> > The reason for doing that was a (reportedly) widespread failure to
> > take the PCIe link down during D0 -> D3hot transitions of NVMe
> > devices,
>=20
> I don't know any of the details, but "failure to take the link down
> during D0 -> D3hot transitions" is phrased as though it might be a
> hardware erratum.  If this *is* related to an NVMe erratum, that would
> explain why you only need to patch the nvme driver, and it would be
> useful to mention that in the commit log, since otherwise it sounds
> like something that might be needed in other drivers, too.

NVME is special in this case that there is other logic being put in place
to set the drive's power state explicitly.

I would mention that also this alternate flow is quicker for s0ix
resume since NVME doesn't go through shutdown routine.

Unanimously the feedback from vendors was to avoid NVME shutdown
and to instead use SetFeatures to go into deepest power state instead
over S0ix.

>=20
> According to PCIe r5.0 sec 5.3.2, the only legal link states for D3hot
> are L1, L2/L3 Ready.  So if you put a device in D3hot and its link
> stays in L0, that sounds like a defect.  Is that what happens?
>=20
> Obviously I'm still confused.  I think it would help if you could
> describe the problem in terms of the specific PCIe states involved
> (D0, D3hot, L0, L1, L2, L3, etc) because then the spec would help
> explain what's happening.

Before that commit, the flow for NVME s0ix was:

* Delete IO SQ/CQ
* Shutdown NVME controller
* Save PCI registers
* Go into D3hot
* Read PMCSR

A functioning drive had the link at L1.2 and NVME power state at PS4
at this point.
Resuming looked like this:

* Restore PCI registers
* Enable NVME controller
* Configure NVME controller (IO queues, features, etc).

After that commit the flow for NVME s0ix is:

* Use NVME SetFeatures to put drive into low power mode (PS3 or PS4)
* Save PCI config register
* ASPM is used to bring link into L1.2

The resume flow is:

* Restore PCI registers

"Non-functioning" drives consumed too much power from the old flow.

The root cause varied from manufacturer to manufacturer.
The two I know off hand:

One instance is that when PM status register is read after the device in L1=
.2
from D3 it causes link to go to L0 and then stay there.

Another instance I heard drive isn't able to service D3hot request when NVM=
E
was already shut down.


