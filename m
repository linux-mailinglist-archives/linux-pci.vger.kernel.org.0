Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85047E2FE
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2019 21:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbfHATGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 15:06:31 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:61870 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727616AbfHATGa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2019 15:06:30 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71J4bAL008217;
        Thu, 1 Aug 2019 15:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=B1v8JXwk0MuhGn3zEyy1ZSeANdg/4igk7l7QlSKuk6o=;
 b=FL5OT1u4MzN+kdMELLtrlDJFmqr4LivW+U/3hZd/NSO5PcMqO1fT/rl7NZmaWhX4qUal
 4SdqDjS3R4pEf/6ZD8e/JX5hQ44/SLTLvdFMAyE//bpDJd35P9w4Qbr/lHbyQKeqjpEL
 SOt6gk+d21SN2Z5t43ZefJP4zCOUwsw9/sW5rhDPPXtaVYJqico5j0/BxB5J5ON8s849
 KfDsRZ9bRh/+u5/VhtHQFMqed0OmeSnpkP7dTTlRph+B5bdbyR9WBmc9GTaH5RjfC9tb
 orA5LUZTB1nEpnXdlhET+wOEk/+9RSWUv0zBKy1xwu9XY2b6pWwaH8CpWcPJdylLDjNV sg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2u3vrb2m6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 15:06:28 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71J3O9W136383;
        Thu, 1 Aug 2019 15:06:28 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 2u45a08kum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Aug 2019 15:06:28 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="355632777"
From:   <Mario.Limonciello@dell.com>
To:     <kai.heng.feng@canonical.com>, <rjw@rjwysocki.net>
CC:     <linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mika.westerberg@linux.intel.com>, <helgaas@kernel.org>
Subject: RE: [PATCH] ACPI: PM: Fix regression in acpi_device_set_power()
Thread-Topic: [PATCH] ACPI: PM: Fix regression in acpi_device_set_power()
Thread-Index: AQHVR/gLL0tkuMFPkka1OwBGYwDZZ6bmI6kAgACEsAA=
Date:   Thu, 1 Aug 2019 19:06:25 +0000
Message-ID: <9cdfa1cd722e48a789a114a3d805cdfa@AUSX13MPC105.AMER.DELL.COM>
References: <4199592.UtrPOv3ZmA@kreacher>
 <27715F95-E729-4EF5-B2BA-03BA3C87AE29@canonical.com>
In-Reply-To: <27715F95-E729-4EF5-B2BA-03BA3C87AE29@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-08-01T19:06:23.8715385Z;
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
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010198
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908010199
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Thursday, August 1, 2019 1:11 AM
> To: Rafael J. Wysocki
> Cc: Linux ACPI; Linux PM; Linux PCI; LKML; Mika Westerberg; Bjorn Helgaas=
;
> Limonciello, Mario
> Subject: Re: [PATCH] ACPI: PM: Fix regression in acpi_device_set_power()
>=20
>=20
> at 07:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>=20
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in
> > special cases") overlooked the fact that acpi_power_transition() may
> > change the power.state value for the target device and if that
> > happens, it may confuse acpi_device_set_power() and cause it to
> > omit the _PS0 evaluation which on some systems is necessary to
> > change power states of devices from low-power to D0.
> >
> > Fix that by saving the current value of power.state for the
> > target device before passing it to acpi_power_transition() and
> > using the saved value in a subsequent check.
> >
> > Fixes: f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in
> > special cases")
> > Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Reported-by: Mario Limonciello <mario.limonciello@dell.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Tested-by: Mario Limonciello <mario.limonciello@dell.com>

>=20
> > ---
> >  drivers/acpi/device_pm.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/acpi/device_pm.c
> >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/acpi/device_pm.c
> > +++ linux-pm/drivers/acpi/device_pm.c
> > @@ -236,13 +236,15 @@ int acpi_device_set_power(struct acpi_de
> >  		if (device->power.flags.power_resources)
> >  			result =3D acpi_power_transition(device, target_state);
> >  	} else {
> > +		int cur_state =3D device->power.state;
> > +
> >  		if (device->power.flags.power_resources) {
> >  			result =3D acpi_power_transition(device, ACPI_STATE_D0);
> >  			if (result)
> >  				goto end;
> >  		}
> >
> > -		if (device->power.state =3D=3D ACPI_STATE_D0) {
> > +		if (cur_state =3D=3D ACPI_STATE_D0) {
> >  			int psc;
> >
> >  			/* Nothing to do here if _PSC is not present. */
>=20

