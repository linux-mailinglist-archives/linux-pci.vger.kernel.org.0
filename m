Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6147BEA9D8
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 05:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfJaER1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 00:17:27 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:62780 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfJaER1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Oct 2019 00:17:27 -0400
X-Greylist: delayed 1412 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Oct 2019 00:17:26 EDT
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9V3pPas026516;
        Wed, 30 Oct 2019 22:53:53 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by mx0b-00010702.pphosted.com with ESMTP id 2vxwfmcbdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Oct 2019 22:53:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6/ertpqdUcnbSJYWuEwXxMXkUesyrAhjuxUUBpmHikRR+T7lou2tEj4fmyrS27lN1zmcBpLvO3n7r7R7JVzwjXM66qy4AgB9jUViv1btS3Fv6YVzOH42ei/E/kaVMrc5O1yxRdT1gwC4q9ppQTIWO898xmCq50LysruSi3pjd1l/nQlG9C0JB+oOjaK83GYPBnWCzxiv+X47/DdknQLJQILX4B+dki8fPtc3LMpNcCUaWvYiN8unfjUJ5eRux/rLPytr0KdiMXOifYH/4I6szGvhnpJvCfiltgvj+WEl5dlBGUH9HjWAbEyKz/mkHI0Jv7/DAPO5a+9l+s+P7/0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzNZdWBMlHwwGB5QGrqKHY87NXJiwV3f+/4OMxcESms=;
 b=Nk/7K0We0kEpbix/dwV/14oKx2E+/SqVaWjlh7S+NlU0S8U90TVhk/YhvEcA1WJ1HBreTDVchzEakrywbNDCRhthArb1tBblrjb8Tpx5J1Obe1K26RwHHAEfdOn2G91+xIl4t1iqsRotAHgvPJgHkis3UkjvZIt+0M3eBzVtWcRQbAn6YsmvXMK1gh/d1BQndbyb5isgHe+lJCYCc4GxIqSk1qDmxeGlbdocSNRDjn0spL4EkH21pGR2LNCT8pXdHlOawabNZidom/meEnpsl1+LkVmTxiyaY29c0pGZJn8DRHENtmkSKPHVo2H9gYSDa9BhLOLBG7XOANZcjKobSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzNZdWBMlHwwGB5QGrqKHY87NXJiwV3f+/4OMxcESms=;
 b=HmlvMcw+UGfDeL4DIA8I9MmT9h7tkJ/wFzrCtvPRN0kgZHfFvmVhY2mS/p38MUMzqsbuqZMaspev618fQUJnnuCSZWN1Ze0gCVx3Ox4cDo7TkuEBkUYn4WLcuh8erL22aQty9xjaDBkZ0FLXE4SexoXw4EZMkCzzw1z6gSECma4=
Received: from MN2PR04MB6255.namprd04.prod.outlook.com (20.178.245.75) by
 MN2PR04MB5727.namprd04.prod.outlook.com (20.179.23.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.18; Thu, 31 Oct 2019 03:53:50 +0000
Received: from MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::18bf:7f31:7697:b853]) by MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::18bf:7f31:7697:b853%7]) with mapi id 15.20.2387.028; Thu, 31 Oct 2019
 03:53:50 +0000
From:   Kar Hin Ong <kar.hin.ong@ni.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: "oneshot" interrupt causes another interrupt to be fired erroneously
 in Haswell system
Thread-Topic: "oneshot" interrupt causes another interrupt to be fired
 erroneously in Haswell system
Thread-Index: AdWPm6PR1RqDULWNQ4axnrJI8tA/7w==
Date:   Thu, 31 Oct 2019 03:53:50 +0000
Message-ID: <MN2PR04MB625541BF4ADC84690B5C45E9C3630@MN2PR04MB6255.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.164.74.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe035d86-b019-4d59-de4f-08d75db5f0cc
x-ms-traffictypediagnostic: MN2PR04MB5727:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR04MB5727816974E328FCDBE8AB0AC3630@MN2PR04MB5727.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02070414A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(71200400001)(256004)(316002)(81166006)(110136005)(25786009)(71190400001)(450100002)(8936002)(6116002)(33656002)(81156014)(2201001)(2906002)(8676002)(3846002)(66446008)(66476007)(64756008)(66946007)(66556008)(76116006)(14454004)(478600001)(52536014)(966005)(2501003)(486006)(476003)(7696005)(74316002)(6306002)(6436002)(9686003)(186003)(6506007)(26005)(86362001)(99286004)(305945005)(5660300002)(66066001)(102836004)(7736002)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5727;H:MN2PR04MB6255.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zrg40whaHsHHB6ezfCiVOkSbOutsMS0P4KOm5ZTFbSO5ZvCLnwYTIt5I4loNdJC+HoqRWPK0nEjbetgmvUSSDY1ZgmCJK4nO9A7JlWG8A03LwPEn+fEgfAiQ5GsJDH8YAbEN9BzV8zG9A9y9fJBtT3exosGviob+MquRIvMpFFywefaPha0KFRW7nInIhlPXc5jdWcWza2693OB8lb32cK43+P7iLaJuPIIiJLtgJDQKsB5Dh2mvUqgTkyc+DT+0PLbsRZ+gBfXy9yHKGQemWqRlAMfz7W+hOFH4pae0KerkSv0KxGQUpyto1JPzqXtVdGAMza1UbPUXeX25WJ8uy80G0yuuO3HJv8ZiEEjWS0Xz3Z9cPUznAKqZnoxNbYIgQl3aOkOg3piKV7wtSlXxShK61gbog5WsHVVSpNaPkJj0cdooZix6uJMj7R8OisThr0ACCeQLnAlCcxjOAY4FAPCNeQhU4Bz2JRynBWaeeFE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe035d86-b019-4d59-de4f-08d75db5f0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2019 03:53:50.5636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: knPYv2yGQcy5kPLvtMpgYo1zhnyskB9PgDvHExSW5jQoFTaxyU/y1NFpx15hK+MZN2yrOuXoViFF5xpjASEjEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5727
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-31_01:2019-10-30,2019-10-31 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 mlxlogscore=822 suspectscore=0
 phishscore=0 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 bulkscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910310036
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I've an Intel Haswell system running Linux kernel v4.14 with preempt_rt pat=
ch. The system contain 2 IOAPICs: IOAPIC 1 is on the PCH where IOAPIC 2 is =
on the CPU.

I observed that whenever a PCI device is firing interrupt (INTx) to Pin 20 =
of IOAPIC 2 (GSI 44); the kernel will receives 2 interrupts:=20
   1. Interrupt from Pin 20 of IOAPIC 2  -> Expected
   2. Interrupt from Pin 19 of IOAPIC 1  -> UNEXPECTED, erroneously trigger=
ed

The unexpected interrupt is unhandled eventually. When this scenario happen=
 more than 99,000 times, kernel disables the interrupt line (Pin 19 of IOAP=
IC 1) and causing device that has requested it become malfunction.

I managed to also reproduced this issue on RHEL 8 and Ubuntu 19-04 (without=
 preempt_rt patch) after added "threadirqs" to the kernel command line.

After digging further, I noticed that the said issue is happened whenever a=
n interrupt pin on IOAPIC 2 is masked:
 - Masking Pin 20 of IOAPIC 2 triggers Pin 19 of IOAPIC 1 =20
 - Masking Pin 22 of IOAPIC 2 triggers Pin 18 of IOAPIC 1 =20

I also noticed that kernel will explicitly mask a specific interrupt pin be=
fore execute its handler, if the interrupt is configured as "oneshot" (i.e.=
 threaded). See https://elixir.bootlin.com/linux/v4.14/source/kernel/irq/ch=
ip.c#L695 =20
This explained why it only happened on RTOS and Desktop Linux with "threadi=
rqs" flag, because these configurations force the interrupt handler to be t=
hreaded.

From Intel Xeon Processor E5/E7 v3 Product Family External Design Specifica=
tion (EDS), Volume One: Architecture, section 13.1 (Legacy PCI Interrupt Ha=
ndling), it mention:
"If the I/OxAPIC entry is masked (via the 'mask' bit in the corresponding R=
edirection Table Entry), then the corresponding PCI Express interrupt(s) is=
 forwarded to the legacy PCH"

My interpretation is: when kernel receive a "oneshot" interrupt, it mask th=
e line before start handling it (or sending the eoi signal).=20
At this moment, if the interrupt line is still asserting, then the interrup=
t signal will be routed to the IOAPIC in PCH, and hence causing another int=
errupt to be fired erroneously. =20

I would like to understand if my interpretation is make sense. If yes, shou=
ld the "oneshot" algorithm need to be updated to support Haswell system?

Thanks.
Kar Hin Ong

