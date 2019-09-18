Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6DB6F02
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 23:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbfIRVnd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 17:43:33 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:59252 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388063AbfIRVnd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Sep 2019 17:43:33 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8ILeStD002110;
        Wed, 18 Sep 2019 17:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=APeqSupOa17yJyshJEarRmRxQctnz7EtTNwsuT5TFO4=;
 b=DxycVrDL556xL+ixdMIls8i5GnjMbZWlvruCYGrYqAOzGDYjLV34CVHTaAHkJ9reEjCa
 H7W/rcec3EwpDLQLeg2yDaJV8d9XudXqxDvCfzgRRiYyD7gr6ao6NSLN63qAFO8dfqvh
 JjH9nOGbk0kdWKGfLuVxd8WEhRjl6aEb26Z8ZfdBRLce7X6HwlZGWZy3hsXhBhrK/r7W
 8yPkMWhxVqGJvq7qnDPZ3hSfhDzCiqta1VLJMao/Ac/Db1pwmXaPDTpFn3FWtFp0lReK
 j1hCX2ShK2QHJ1xqz7615yKo5iJX0Z/khQjznj3Spa6qnkxne0nx6ouWuy1hQ6Ymd1VV GQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2v3vdy82wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 17:43:32 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8ILcOTA029662;
        Wed, 18 Sep 2019 17:43:31 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2v3vdgg8ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:43:31 -0400
X-LoopCount0: from 10.166.132.54
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="398570735"
From:   <Mario.Limonciello@dell.com>
To:     <rjw@rjwysocki.net>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
        <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Ryan.Hong@Dell.com>,
        <Crag.Wang@dell.com>, <sjg@google.com>, <Jared.Dominguez@dell.com>,
        <linux-pci@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Thread-Topic: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Thread-Index: AQHVaPqcVa1BaYWKPkaPLLLTJYPQjqcyUq2A//+vI2A=
Date:   Wed, 18 Sep 2019 21:43:28 +0000
Message-ID: <346fd9ced98e40229d0cc0871ad5ed32@AUSX13MPC105.AMER.DELL.COM>
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
 <4858057.cjDlXVALXj@kreacher>
In-Reply-To: <4858057.cjDlXVALXj@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-09-18T21:43:26.4017972Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-18_10:2019-09-18,2019-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180184
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909180184
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Rafael J. Wysocki <rjw@rjwysocki.net>
> Sent: Wednesday, September 18, 2019 4:31 PM
> To: Limonciello, Mario
> Cc: Keith Busch; Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> Dominguez, Jared; Linux PCI; Linux PM
> Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into d=
eepest
> state
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Thursday, September 12, 2019 1:42:33 AM CEST Mario Limonciello wrote:
> > The action of saving the PCI state will cause numerous PCI configuratio=
n
> > space reads which depending upon the vendor implementation may cause
> > the drive to exit the deepest NVMe state.
> >
> > In these cases ASPM will typically resolve the PCIe link state and APST
> > may resolve the NVMe power state.  However it has also been observed
> > that this register access after quiesced will cause PC10 failure
> > on some device combinations.
> >
> > To resolve this, move the PCI state saving to before SetFeatures has be=
en
> > called.  This has been proven to resolve the issue across a 5000 sample
> > test on previously failing disk/system combinations.
>=20
> This sounds reasonable to me, but it would be nice to CC that to linux-pm
> and/or linux-pci too.
>=20
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > ---
> >  drivers/nvme/host/pci.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 732d5b6..9b3fed4 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
> >  	if (ret < 0)
> >  		goto unfreeze;
> >
> > +	/*
> > +	 * A saved state prevents pci pm from generically controlling the
> > +	 * device's power. If we're using protocol specific settings, we don'=
t
> > +	 * want pci interfering.
> > +	 */
> > +	pci_save_state(pdev);
> > +
> >  	ret =3D nvme_set_power_state(ctrl, ctrl->npss);
> >  	if (ret < 0)
> >  		goto unfreeze;
> > @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
>=20
> This is the case in which the PCI layer is expected to put the device int=
o
> D3, so you need
>=20
> pdev->state_saved =3D 0;
>=20
> at this point, because you have saved the config space already.
>=20
> >  		ret =3D 0;
> >  		goto unfreeze;
>=20
> And here you don't need to jump to "unfreeze" any more.
>=20
> >  	}
> > -	/*
> > -	 * A saved state prevents pci pm from generically controlling the
> > -	 * device's power. If we're using protocol specific settings, we don'=
t
> > -	 * want pci interfering.
> > -	 */
> > -	pci_save_state(pdev);
> >  unfreeze:
> >  	nvme_unfreeze(ctrl);
> >  	return ret;
> >
>=20
>=20
>=20

Thanks, I actually followed up with something along that line in a v2 sent =
out
today.  My apology you weren't in CC, but here is a weblink to it.
http://lists.infradead.org/pipermail/linux-nvme/2019-September/027251.html

