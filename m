Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832491874CB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 22:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbgCPVfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 17:35:22 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:61056
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732567AbgCPVfV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 17:35:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxzqFn/8R3+Up4Ev9lmlIgys7f3fFLz5i6hzXsPoGbfI4uztw9M40faDE6hxsvpdO+cAOt6mAtbHypmIRuNcMo1EmDpaVu0deajSHFJQ7e4FrdViINloiA7ioMmtd6i88A8b2XbwLeNK0B5QHUaBwmeKfr8pCt0cU81FszkseqGLER2Csl4IWjgCV+G5ZIFx7fa/YOClvusXmfsb7PIC2qkJwrs70EoalRGLGN7517aEiG8oZwgksfTlurYxOzXK6jPVO+6sPWyKVDLIyfaIggfCC+oDvSRJNipUEVOsisuifCR9w270U/NPNTuzS0c11eGzhkRyiEq2HWKh4UcLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmLoF2Seeoxlj92yBzVmYXywgfo8cOPotBrnGs/LJrk=;
 b=T05Ec0RQ2bqYmWHO/V1cT1kY/G1L3hF+/pRLWxKC7k3sk52WMTnIwyKdmk/qeblusDkyii4+MDEjNy6lx/kNrJQZ16s2kUj1+gPrMTzmy9PHmPW/xNfF5JmhpeF5ja+USN7MgQ9fyfeAsSv5Sg6b3We1h5Z44lF0ywLugBxH2F3tTIkK//zRz7xhBK4b2tVdWpes85WXP+dfzSYJrWutbJhQ6ECiDwP+SLIJVnLzoPVXLQfd8j6rvuLlZ+SpmXTAy2HQKRgkqptn+FLn4eiajor6upsYUH4Qo9YsUNcPGGxGxH9alKzzBJ37bFM3BdRL8yGGgGe2xikv28Shp4wonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmLoF2Seeoxlj92yBzVmYXywgfo8cOPotBrnGs/LJrk=;
 b=pg/msxIuubHuS8AzwZrD4hkvSzj3Sq1wB1AKPWq0GFggi68do4SGsgw5e7gtlwNjV1WlghUqRIgEkPAe5Sp74Fy58FtglBiZV6+KENiZ5MGgw/pMHZnyihHVEr3/y8vGP0ko4JjWPxk6eS6OvESNFTl2Ja28RHbolZRcqAY04A4=
Received: from DM5PR06MB3132.namprd06.prod.outlook.com (2603:10b6:4:3c::29) by
 DM5PR06MB2698.namprd06.prod.outlook.com (2603:10b6:3:3f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Mon, 16 Mar 2020 21:35:17 +0000
Received: from DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569]) by DM5PR06MB3132.namprd06.prod.outlook.com
 ([fe80::f5cb:1d29:98a6:2569%7]) with mapi id 15.20.2814.007; Mon, 16 Mar 2020
 21:35:17 +0000
From:   "Hoyer, David" <David.Hoyer@netapp.com>
To:     "Hoyer, David" <David.Hoyer@netapp.com>,
        Lukas Wunner <lukas@wunner.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: RE: Kernel hangs when powering up/down drive using sysfs
Thread-Topic: Kernel hangs when powering up/down drive using sysfs
Thread-Index: AdX6C4g8wtFnF4AzTBuWtW2g0jlmPgBs/g+AAAATa4AABqE2sA==
Date:   Mon, 16 Mar 2020 21:35:17 +0000
Message-ID: <DM5PR06MB31328F1D3AFC3A1192CD1CE592F90@DM5PR06MB3132.namprd06.prod.outlook.com>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
 <20200316181959.wpzi4hkoyzpghwpw@wunner.de>
 <DM5PR06MB31328A7B4E1A95A8C5E5E3E092F90@DM5PR06MB3132.namprd06.prod.outlook.com>
In-Reply-To: <DM5PR06MB31328A7B4E1A95A8C5E5E3E092F90@DM5PR06MB3132.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZGhveWVyXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctMDVlMjBmYTUtNjdjZS0xMWVhLWIwNzctOGMxNjQ1?=
 =?us-ascii?Q?MTE0MjYwXGFtZS10ZXN0XDA1ZTIwZmE3LTY3Y2UtMTFlYS1iMDc3LThjMTY0?=
 =?us-ascii?Q?NTExNDI2MGJvZHkudHh0IiBzej0iNTA2NyIgdD0iMTMyMjg4NjgxMTU4MTA1?=
 =?us-ascii?Q?NjYzIiBoPSJLWktta1JXTzdxZnBKV2ZDdTdDZGJKbkJ1Y0E9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFDUUVBQUEv?=
 =?us-ascii?Q?Mmp2STJ2dlZBU3RhRENLb2hmZ2hLMW9NSXFpRitDRUdBQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFI?=
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
 =?us-ascii?Q?QVFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David.Hoyer@netapp.com; 
x-originating-ip: [216.240.24.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98e14c60-1e1d-4557-8246-08d7c9f1ebaf
x-ms-traffictypediagnostic: DM5PR06MB2698:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR06MB26987DD35CA62A1A90BF565C92F90@DM5PR06MB2698.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(199004)(86362001)(4326008)(6506007)(53546011)(52536014)(7696005)(26005)(2906002)(186003)(76116006)(66946007)(8676002)(64756008)(66556008)(66476007)(66446008)(33656002)(478600001)(5660300002)(81156014)(81166006)(2940100002)(55016002)(9686003)(316002)(54906003)(110136005)(71200400001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB2698;H:DM5PR06MB3132.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zA7UI7VibX7ZpewtA1dY+gY4F+ELUojWET96hFny7BBwgeQvT+2RPkitSxFu6KZx1xijmn03pB4RNtAyzmC8mZyzgw04Nrr+1avY5uMxp6VVFx9I3UvgplAi8Vq53kZK6y9i7uDFXDYeSzmqlgzpIG8VnDOU2c9fL3sQJXf8F9f2TG9/cG5kFdowjBL+ged9EgyC9hq6eyg6bZL4RxW7iNr7HK44sPYlaoQ2vZaER7bpZrfa+bCe74tJl9r/OOQJRU8V5W4/MYsCqeMT9pq/603TxiG0++UNxzDX+hjSoRQiHORlaVNdIn+2yL+X2HgC1MxvdHwza+HZq5MPjzgCmlW0/Uv0vNh44cR9LAOyp8EMpcCGeAu9al4SD/WVUomxZNbR6zXFqHzcnCLpemsTe+AeJ9tX7wRonVQTpQAVQq/SoKXHosjBwOMIAE09Lpqs
x-ms-exchange-antispam-messagedata: XaglWg7Oe5uALaaFxcHbLd1bm/RLfpTm0WyIlHoVY4WZBIcYjLTY5TYk+N67GcJfpg+cBkYI5qQiXpMYxxDloCC2RKzPNCwJ3797atIvaZ7Xe73iZ0ulsTJtWtX+t265fbvgQ91DHc+CnsPPDbrKcQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e14c60-1e1d-4557-8246-08d7c9f1ebaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 21:35:17.3894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23/tGlo388JTENWy1MjRosBdZ7m0LwTag1x9350BdVmMFDTqLCDd6YPZ0gNLLVXJs3YlrV7xNZzR4dIhNX/OAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB2698
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I ran the suggested experiment.   The first interrupt is reporting non-zero=
 pending event (either 0x08 or 0x1000 depending on power up or power down).=
   The second interrupt is always zero.   So it sounds like we are getting =
an interrupt indicating work complete.

Power up:
Mar 16 21:10:15 eos-a kernel: pending events x8
Mar 16 21:10:15 eos-a kernel: pciehp 0000:66:09.0:pcie204: Slot(9): Card pr=
esent
Mar 16 21:10:15 eos-a kernel: pci 0000:6f:00.0: Max Payload Size set to 256=
 (was 128, max 256)
Mar 16 21:10:15 eos-a kernel: iommu: Adding device 0000:6f:00.0 to group 70
Mar 16 21:10:15 eos-a kernel: pcieport 0000:66:09.0: BAR 13: no space for [=
io  size 0x1000]
Mar 16 21:10:15 eos-a kernel: pcieport 0000:66:09.0: BAR 13: failed to assi=
gn [io  size 0x1000]
Mar 16 21:10:15 eos-a kernel: pcieport 0000:66:09.0: BAR 13: no space for [=
io  size 0x1000]
Mar 16 21:10:15 eos-a kernel: pcieport 0000:66:09.0: BAR 13: failed to assi=
gn [io  size 0x1000]
Mar 16 21:10:15 eos-a kernel: pci 0000:6f:00.0: BAR 0: assigned [mem 0xe0b0=
0000-0xe0b03fff 64bit]
Mar 16 21:10:15 eos-a kernel: pcieport 0000:66:09.0: PCI bridge to [bus 6f]
Mar 16 21:10:15 eos-a kernel: pcieport 0000:66:09.0:   bridge window [mem 0=
xe0b00000-0xe0bfffff]
Mar 16 21:10:15 eos-a kernel: pcieport 0000:66:09.0:   bridge window [mem 0=
x3ac00c000000-0x3ac00dffffff 64bit pref]
Mar 16 21:10:15 eos-a kernel: pending events x0
Mar 16 21:10:16 eos-a kernel: vfio-pci 0000:6f:00.0: enabling device (0100 =
-> 0102)
Mar 16 21:10:16 eos-a kernel: pcieport 0000:64:00.0: can't derive routing f=
or PCI INT A
Mar 16 21:10:16 eos-a kernel: vfio-pci 0000:6f:00.0: PCI INT A: not connect=
ed
Mar 16 21:10:16 eos-a kernel: vfio_ecap_init: 0000:6f:00.0 hiding ecap 0x19=
@0x178

Power down:
Mar 16 21:10:47 eos-a kernel: pending events x10000
Mar 16 21:10:47 eos-a kernel: iommu: Removing device 0000:6f:00.0 from grou=
p 70
Mar 16 21:10:48 eos-a kernel: pending events x0

-----Original Message-----
From: linux-pci-owner@vger.kernel.org <linux-pci-owner@vger.kernel.org> On =
Behalf Of Hoyer, David
Sent: Monday, March 16, 2020 1:26 PM
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org; Keith Busch <kbusch@kernel.org>
Subject: RE: Kernel hangs when powering up/down drive using sysfs

NetApp Security WARNING: This is an external email. Do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.




We were not sure about the return just a few lines up so we did not add the=
 2 lines.
I will try what you suggested to better understand why we are getting the e=
xtra interrupt.

I am not as familiar with submitting a "proper patch" and ask that you do i=
t if you would be so kind.

-----Original Message-----
From: Lukas Wunner <lukas@wunner.de>
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
> to prove that will cause things to "unhang" and progress at that point
> - if you're hung and you remove a drive, the slot status change will=20
> then unstick things.)

The question is, why is pciehp_ist() run once more.  Most likely because an=
other event is signaled from the slot.  Try adding a
printk() at the top of pciehp_ist() which emits ctrl->pending_events to und=
erstand what's going on.

Thanks,

Lukas
