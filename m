Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B270189D95
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 15:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgCROGu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 10:06:50 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:6128
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgCROGu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 10:06:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajLtb1x0MjQe/yxgOv9lmDES3LuJKTT6uxKr6tUf+hDFHhJlSoy7mxRwWl2nnnZQO1dUJREQSLrnJjZOs0aSbZ8d1LlaPEb3aH1CyIhlALWRYduAwoyBhQh9sfSVSfeSv8AHBcDh57l7VSsjdnKC+tVV2p1AfPvELnMksBB9QP71+vYoqBf6hi7C1Z6ICjN87OyIfyOLtFx7oTCGv2M+3+fl+2vAH0PwW/Fp2kXK+vd14/0eN5TQ74J0sYApvMjWc+STD1P1kPHDPehozFnekhmP8hbmmc1qvloXKB2qsGzr2LNCOLWnGhpHTrDRsPR2hpaemfX+Xeg7gE72IdhnUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNATl1Pefm9KgGdKQyYqtyFGMBOh8OqU8ALKhKoPDdQ=;
 b=C5aIosRfKBBWlDacLn0UvqMxJCIb0X4g87HCsDsXCCcWonmNs3jeCkv8sU9O3/tcbmfnXoYHwS5bg04S5d6pQeqbDc8B9p5zXNt5QGcwbUeHCnPINS43KgDdWsF/KGSoRtKba5tH/mRxI4kdJfb5bA3kBD+d1QCAImlvMgwOn0UoZ/PEvWY+joUlEYHMezUdR+6t3rFi3keLJ87NGxBdCfjuqSSsV7viRQIL/AXM0yp8OjqdJQEaeO+w2vSO/FbkZedRCMqEmeJ4WRu18nmNzUaMFYGnanktdRJmanNnbQDRTQmLvPM2L0YBjIMbZcX0C6+6iMPoTrggpiKw84FPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNATl1Pefm9KgGdKQyYqtyFGMBOh8OqU8ALKhKoPDdQ=;
 b=iKynpjX2rklhRHtUQwzrrgd8wjzMkreu560Bv8Gkf1KKQp06EpVRbsNuEGHZrQVwTmpXnY7v3j78bA4UstoeaxhnVR/5MJjo/rTOOpN6PBE4ErEUMQem1RrvRklCLOtpdtdvQz+JKEY5JMKDauT87tHbAe+8Og/LJWFyJHeCVeE=
Received: from DM5PR06MB3132.namprd06.prod.outlook.com (2603:10b6:4:3c::29) by
 DM5PR06MB2716.namprd06.prod.outlook.com (2603:10b6:3:48::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Wed, 18 Mar 2020 14:06:47 +0000
Received: from DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569]) by DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569%7]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 14:06:47 +0000
From:   "Hoyer, David" <David.Hoyer@netapp.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: RE: Kernel hangs when powering up/down drive using sysfs
Thread-Topic: Kernel hangs when powering up/down drive using sysfs
Thread-Index: AdX6C4g8wtFnF4AzTBuWtW2g0jlmPgBs/g+AAAATa4AAVuDUgAAEwxFg
Date:   Wed, 18 Mar 2020 14:06:47 +0000
Message-ID: <DM5PR06MB313267860FFF00AF343B830892F70@DM5PR06MB3132.namprd06.prod.outlook.com>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
 <20200316181959.wpzi4hkoyzpghwpw@wunner.de>
 <DM5PR06MB31328A7B4E1A95A8C5E5E3E092F90@DM5PR06MB3132.namprd06.prod.outlook.com>
 <20200318114945.uqnexcmltfin3mvc@wunner.de>
In-Reply-To: <20200318114945.uqnexcmltfin3mvc@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGhveWVyXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYjJlOWE4Y2UtNjkyMS0xMWVhLWIwNzgtOGMxNjQ1?=
 =?us-ascii?Q?MTE0MjYwXGFtZS10ZXN0XGIyZTlhOGQwLTY5MjEtMTFlYS1iMDc4LThjMTY0?=
 =?us-ascii?Q?NTExNDI2MGJvZHkudHh0IiBzej0iMTc2MCIgdD0iMTMyMjkwMTQwMDU1MDA1?=
 =?us-ascii?Q?NDYxIiBoPSJMNU5hOHhrL3pMYmM4dXgwM0RhU0hKVkNJWGs9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFDUUVBQUFW?=
 =?us-ascii?Q?NlVOMUx2M1ZBVDBqWHNlWTl6d3hQU05leDVqM1BERUdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDMEF3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQVdVWFc0QUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBWkFC?=
 =?us-ascii?Q?eUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQVl3QmZBR01BZFFCekFIUUFid0J0?=
 =?us-ascii?Q?QUY4QVlRQnVBSGtBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHVUFjZ0J6QUc4QWJnQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFE?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFj?=
 =?us-ascii?Q?d0IwQUc4QWJRQmZBSEFBYUFCdkFHNEFaUUJ1QUhVQWJRQmlBR1VBY2dBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4QWN3?=
 =?us-ascii?Q?QnpBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpRQnRBR0VBYVFCc0FGOEFZUUJrQUdRQWNnQmxBSE1BY3dB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUdBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David.Hoyer@netapp.com; 
x-originating-ip: [216.240.24.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24e69e0a-9930-4907-c369-08d7cb4598f8
x-ms-traffictypediagnostic: DM5PR06MB2716:
x-microsoft-antispam-prvs: <DM5PR06MB2716EAE74368095392EB4D7F92F70@DM5PR06MB2716.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(66946007)(64756008)(33656002)(66446008)(66556008)(54906003)(66476007)(86362001)(71200400001)(5660300002)(6916009)(186003)(52536014)(966005)(7696005)(53546011)(6506007)(4326008)(55016002)(81166006)(9686003)(81156014)(8676002)(8936002)(316002)(76116006)(26005)(2906002)(478600001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB2716;H:DM5PR06MB3132.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aES/0UUMkZXtiHL+b3BuqOBJvwa2cx9qIaCqbW7UahwmR5BO9t3j7negxEOuCBDMh8zHgTyPZ61jMCE0+ZtmbU8IJs9Ra/HGORzyhZx1Z4xy8JQq78x3WjYKmaeoJznISzofjP8eeEQF7HKSHSX1q/BiPxcUGvB8MZJtICSBbIIbzbBQGQ+SYWrc7lIXoZBYe/lrgXNH83doQUklhtdOEEq3hb5cNBlU8gu35lm/j0ma7g87TRXfpudJwS0DBQ9QusoKxvZJJOnICw6hKv58hjcW+q55nhlDxPdRcDBQlYioAcX2zRvOGq5OBHvce1GWH81tbOMkYM2oMJ3nkGWVE66IJbqZScyyS0I7ChzxX4GYqnwIuZRc87YowCxP0yHKsqH4VB+/kFLac0/m6pSLb4CsIdd17hxQ7tKGZPn7C6x/dUKwYlJ+8XaNDJCbPdHKfHuUkDmNa0JMoL8HJxfi5KRnqW7+6ONwWXJGueRrmIq4/5VsbpoNxCRM+UDRq5Gw7GsaQz7kZxgE4/DoVMV9n8TwJa7rsfc6e3ZTG6whaMPz0gOhEvmLxDnphF/pHN1+
x-ms-exchange-antispam-messagedata: roiVkqsHvIM4F1CtQkait1LHeeRyFkhTpWw1UIWEx/vuVrNLbmt9N03JJOFqvqKoHN3/9QPDYnCcWVOba0Ss7x3YGoPy+o8ZkLQfSzXUDRGnbr+XaVGA4ppO70m+ljLsjIv/NihUNrVazWpJ8fb59g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e69e0a-9930-4907-c369-08d7cb4598f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 14:06:47.5036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/N8WABceub3CPhs+GoqNTBeDFSdm2Bb0l1HEHsuWREWgmYbeRZDkVcThsK1DN4wSWOFZVCDYoEpOIZXv/4Ouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB2716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you for the information and for submitting the patch.   I will review=
 this so that I can do this better in the future.   I appreciate all the he=
lp!

-----Original Message-----
From: Lukas Wunner <lukas@wunner.de>=20
Sent: Wednesday, March 18, 2020 6:50 AM
To: Hoyer, David <David.Hoyer@netapp.com>
Cc: linux-pci@vger.kernel.org; Keith Busch <kbusch@kernel.org>
Subject: Re: Kernel hangs when powering up/down drive using sysfs

NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.




On Mon, Mar 16, 2020 at 06:25:53PM +0000, Hoyer, David wrote:
> I am not as familiar with submitting a "proper patch" and ask that you=20
> do it if you would be so kind.

I've just submitted a patch to address this issue.  Does it work for you?

The term "proper patch" is just kernel slang for a patch which can be appli=
ed with "git am" by the PCI maintainer, Bjorn Helgaas.

Such a patch can be generated with "git format-patch" and sent out with "ms=
mtp" or "git send-email".

There are some formal requirements which the patch needs to satisfy, they a=
re listed here:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html
https://www.kernel.org/doc/html/latest/process/development-process.html
https://marc.info/?l=3Dlinux-pci&m=3D150905742808166

Never mind all these details if you do not intend to submit patches yoursel=
f.  In this case, I introduced this embarrassing mistake, so it's my job to=
 provide a solution if you don't want to.

Thanks for all the debugging work you have done and once again sorry for th=
e breakage.

Lukas
