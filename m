Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1502187240
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 19:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbgCPSZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 14:25:57 -0400
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:14605
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731967AbgCPSZ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 14:25:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwqwlzeJuowGgQGUPYjSHVGIjH8++2Idl1jOqCF+CNBsKtrAoZFNEaBVGvoMLuKezeFK7zC8kinTEuc3sC3UrCVxVlgyHVcBnPF5TuLyfRScy038TQzKb7eSjWq6d599lCQDFTc+YOtPCZR+gBbFjorV/UyNTPrQSozQX9TUjFDSJEdz4se1cvZmeMPo1EyuD+lzaUns1Sc/lFb7TiePDPzUQbpFTxv4V6NMxM1J+058m4X337eOXQRAXndnEwO3v3nUgs5OTx0j3X8qqHMtW6YtHzc+08KcEUU7mf7lxznP0tKmMWrYRRGRUZBsAaGGwRaYY6oF7ft3Q74EJXjzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAjI2+im1fr1WIe/urQakdwNi3y0+B5Ana/RFZBap6M=;
 b=nw2ekY1EXvHVQKjqqcB43pqbQXUjw9wAQtFAAsGpJiaRXVd6lqoQMH11tuvRfhbkkD3gNsuFLaEitsejdJvPrwO/kqLcUsUCgezCVbEqWR9aQ3H3kW50PuXyF4hG3p+GTzTBzFUNAFocIPjtfy2sx0jURBMJn8MGE21a4EN19aryo4bjWExu5vgEOEZsAYrCm6fFAQZLksdn9SKNDdVL/0ovhbztdBSoIk4JLj4org1uzqG4RAE8srjMZ96HG2RZP1wg0z9gxUznncP915E6xrwYltEdL5R6UdD4c2fqnv4WqvsQDCBsIkR05uarAQmc9A9E7MJVR78hzIgFasEAnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAjI2+im1fr1WIe/urQakdwNi3y0+B5Ana/RFZBap6M=;
 b=UIIt7o0YgLNVQVVvaAbZilrGOfw1E44n3pEF3iOF0fkq0klmRTBsHjvqc3AUMCp7BZq7V5t9cl9WT81BqQR9ikPygquDQ5lberotmUAoOfZcGFvjSZ+E9KPbcb/rM1G+uMwFmTA9/kSswZFgty8QA2Xsn/0j5JvEjzwmI9g6jNs=
Received: from DM5PR06MB3132.namprd06.prod.outlook.com (2603:10b6:4:3c::29) by
 DM5PR06MB2491.namprd06.prod.outlook.com (2603:10b6:3:58::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Mon, 16 Mar 2020 18:25:53 +0000
Received: from DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569]) by DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569%7]) with mapi id 15.20.2814.007; Mon, 16 Mar 2020
 18:25:53 +0000
From:   "Hoyer, David" <David.Hoyer@netapp.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: RE: Kernel hangs when powering up/down drive using sysfs
Thread-Topic: Kernel hangs when powering up/down drive using sysfs
Thread-Index: AdX6C4g8wtFnF4AzTBuWtW2g0jlmPgBs/g+AAAATa4A=
Date:   Mon, 16 Mar 2020 18:25:53 +0000
Message-ID: <DM5PR06MB31328A7B4E1A95A8C5E5E3E092F90@DM5PR06MB3132.namprd06.prod.outlook.com>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
 <20200316181959.wpzi4hkoyzpghwpw@wunner.de>
In-Reply-To: <20200316181959.wpzi4hkoyzpghwpw@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGhveWVyXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctOTA2NDJhOGQtNjdiMy0xMWVhLWIwNzctOGMxNjQ1?=
 =?us-ascii?Q?MTE0MjYwXGFtZS10ZXN0XDkwNjQyYThmLTY3YjMtMTFlYS1iMDc3LThjMTY0?=
 =?us-ascii?Q?NTExNDI2MGJvZHkudHh0IiBzej0iMjYzNSIgdD0iMTMyMjg4NTY3NTE3ODIw?=
 =?us-ascii?Q?OTU5IiBoPSI0ekpUNklVNE9BOW1VWXRPeEhJUjJ3ZGRSQTA9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFDUUVBQUFm?=
 =?us-ascii?Q?dUw1U3dQdlZBWk9BUmNpT1N1TjVrNEJGeUk1SzQza0dBQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFH?=
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
x-originating-ip: [216.240.24.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dda7c15-b3df-4b67-323d-08d7c9d7762b
x-ms-traffictypediagnostic: DM5PR06MB2491:
x-microsoft-antispam-prvs: <DM5PR06MB2491174F7D8458FE27B89D5F92F90@DM5PR06MB2491.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(199004)(478600001)(54906003)(316002)(64756008)(76116006)(66446008)(66556008)(71200400001)(66476007)(52536014)(66946007)(33656002)(5660300002)(26005)(186003)(2906002)(4326008)(7696005)(86362001)(6916009)(81156014)(81166006)(8676002)(8936002)(53546011)(9686003)(6506007)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB2491;H:DM5PR06MB3132.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQh34Ido1Kato/7mNACw/EsLtMJetbaA33909ziSE8JrNI2grgz8dlFLyFYYWiMxobJtRFDek2egNCG6YSnITBcpjSkbFoVRC2rjNKCqGamOUj1S9hi1htAUOV56X7+MQdxckqvu9QBEbZwBO9IsWOiTVTSdWcUgRilKUoS1L8OZ0cG6+qwongi/yJKBBkd7iZ5Z0ZaAT6xo3z374wyXds/ryTVTq0weaF65zcry0ECfTzSHU/QnCDSSmGmT1GeWjKxw7FgwbyYSXttJ9sli+B7De/1hrhRdM+IDSoKk2a7ZQm3Cuh2KE0/YE0wn2H2t76zDQbQIZbWQjv8ERSkzEJUY40YMnX7k7WSktSfhi/u9m54wOnaKUbunmTYlssvowgZhqVtPPIqyuN3VjA4y2M5nEkElTEIYYKVEytYEC3HXvYKQE4/zHdMfIZ9pfDq2
x-ms-exchange-antispam-messagedata: eO4nkRnHPL94hwyIpV9/sXRsXm/R1aucW6SzOxHraQkBBw2HmL2YxC5Ns6GXqwzRR7lICTypQgHT2FnQoZnfF2LuWzA3jmna7q9kC06bs5P1piuyCSCXNEX+JtlaHhxkfi/sLi21rHUVZzOvD9a/qw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dda7c15-b3df-4b67-323d-08d7c9d7762b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 18:25:53.2699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NABFI2EuZjM5q17fivyncnCIcRuH1vcbLELdZilY1FjhaC2UZ4ZreOo33xtal80xamwnDouE3Ox1JFA66Q/fyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB2491
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We were not sure about the return just a few lines up so we did not add the=
 2 lines.
I will try what you suggested to better understand why we are getting the e=
xtra interrupt.

I am not as familiar with submitting a "proper patch" and ask that you do i=
t if you would be so kind.

-----Original Message-----
From: Lukas Wunner <lukas@wunner.de>=20
Sent: Monday, March 16, 2020 1:20 PM
To: Hoyer, David <David.Hoyer@netapp.com>
Cc: linux-pci@vger.kernel.org; Keith Busch <kbusch@kernel.org>
Subject: Re: Kernel hangs when powering up/down drive using sysfs

NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.




On Sat, Mar 14, 2020 at 02:19:44PM +0000, Hoyer, David wrote:
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -637,6 +637,8 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>         events =3D atomic_xchg(&ctrl->pending_events, 0);
>         if (!events) {
>                 pci_config_pm_runtime_put(pdev);
> +               ctrl->ist_running =3D false;
> +               wake_up(&ctrl->requester);
>                 return IRQ_NONE;
>        }

Thanks David for the report and sorry for the breakage.

The above LGTM, please submit it as a proper patch and feel free to add my =
Reviewed-by.  Please add the same two lines before the "return ret" a littl=
e further up in the function.

If it's too cumbersome for you to submit a proper patch I can do it for you=
.


> We've instrumented the code and we do see that pciehp_ist() runs=20
> twice, once exiting with IRQ_HANDLED and then again with IRQ_NONE.
> We believe that is due to the timing differences.  Adding debug in=20
> here changes the timings enough that the hang goes away, so we are=20
> having troubles proving this 100% at the moment.  But just based on=20
> code inspection, if pciehp_ist() exits with the IRQ_NONE case, then=20
> nothing will ever set ist_running=3Dfalse until a subsequent hotplug=20
> event happens that causes the IRQ_HANDLED case to run.  (We were able=20
> to prove that will cause things to "unhang" and progress at that point=20
> - if you're hung and you remove a drive, the slot status change will=20
> then unstick things.)

The question is, why is pciehp_ist() run once more.  Most likely because an=
other event is signaled from the slot.  Try adding a
printk() at the top of pciehp_ist() which emits ctrl->pending_events to und=
erstand what's going on.

Thanks,

Lukas
