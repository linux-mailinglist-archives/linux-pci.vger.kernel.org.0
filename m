Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01D169B26A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 19:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBQSiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 13:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQSh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 13:37:59 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056A7144BA
        for <linux-pci@vger.kernel.org>; Fri, 17 Feb 2023 10:37:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H53UPiK5tXlQrvcED++D+Cs7OQUqyOWrxosc6XE0hjWgtodjPPvO8ivndO3uBI3a42MeWUwVAwtuoko8QA12EHsguPxJOYNSjIaIs/JSGRhy1uRyPg8jnCyJ3Ifoc8weqn7l8ajWCUC9Grn2KvYn0WGsDY7gCaAp4DHtZJmBzqYH8tnIuvqyGgpjlFnYXakeMyiO9ejKjH/7nAiVI0hUqYVcYJUKzWiQZG3QiBFdSFFeyg5sSht47nq4Ymqhibp/Qw51bnkWI5DzeWaAaUTXsfhZ2RDc42YRp6dlCeZW9MHnhk8VNXPxfzDY4to4uidvW393OV/7F7OkLeUHgO5DpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sip5wlEPsutcc5MIoU0IRugEuc8MCaV8LgqZ16xiFjA=;
 b=loxEfpStbIEAqx9eLQjEp3srEgZOerDydM3hlJItY6kwWSHbvgJc1jqXWjm73o/KQ9cs0+esxnvLU5Hos5EzPn7WsopzZTu0Vo8ya7s1wv/GN/aEPPCSMuh856tIgFSEN1K3Zr7QZu0xjBZMktaFDmcUpoad0sHAUnjcoPYhi0oI/9rXTx1Hkrfek67pU97uZRtKFh6VyNxDZqMtmfWzk9MydDCQtbnMI4SROrbTTFrKnKyt0SW2D6kYIrUwvxOohW0MTViOEoDbMmg/VH4v5gptn7QsPOYbhLDOInaf4ZtPs07dVaoY4Hkq8kLaOcNQo1PVEBiNFK4O/A9DLjKDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sip5wlEPsutcc5MIoU0IRugEuc8MCaV8LgqZ16xiFjA=;
 b=2tkDFNkDX7g3cNYpET4apOpb0vJk4hrJDV+mXwm9tAPwnaf9xa5o960VrVeRNkXlEDoHi7glGFsax/P9NyVz41e64mD6O7DoqocKzJq6Q4isUDI93i/E4MVwwxAEPexIP8j34LN/jHgyBj57VnWIxb8mGD+WYZQliiDJln48c0g=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 18:37:54 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41%5]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 18:37:54 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Anatoli Antonovitch <a.antonovitch@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Thread-Topic: [PATCH] PCI/hotplug: Replaced down_write_nested with
 hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Thread-Index: AQHZJ3DXL7eY3Cafj0qvjYdTo4M4O66nFDQAgADLBICAAKPyAIAD8CKAgCC1eACABls8AIAAKq8g
Date:   Fri, 17 Feb 2023 18:37:54 +0000
Message-ID: <BL1PR12MB51445CE9642195E9DEBC9CB8F7A19@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <1d474514-4d28-d41f-52cd-972ca7e3fc1d@amd.com>
 <20230217160358.GA3404296@bhelgaas>
In-Reply-To: <20230217160358.GA3404296@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-17T18:37:51Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ef57497f-684e-4b16-9007-5b92709297a3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-17T18:37:51Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 96c9e9b0-7d37-42c4-88a9-2b65f2146ec3
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB7743:EE_
x-ms-office365-filtering-correlation-id: 34aef32b-3b8a-49c5-8ce6-08db11161508
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6wK5wRwy37bLoND6UiJz8+d7+QV5D8cpjfJ4ymXyQ0FcAtvoxcrQPW4SWYEMCONY7OtdyzaAHFGAU60w/62R66ezFD96onne8ggGkmxAeoTzJ9UE1gtzv3NbtPK56aP8D6bFZhsrckzvWW7euAzy/k9LdeoydAC3s7I4hUz4tGPBwSRN6ucjZOrA5NA2sXVVX3XLrnCMp4oxILdz8qdLpQ07sPD0Out2agSwipiE+hYQLnfPxOwrGDVz/B8tTOpm5Q+ZUpAvgFO7pYqfWTyd7SExwlYamsPKR+X7A+3HH9mbWJXR8YZSvykl0TUGCbBav63YHGH0mFPsBDbudCDLtfIAOzU2WtJ5VymJvXfb+iAsC8rLweYqV118m3GndKz8vZyNEmx8KqQSK9BVje8B3g3yE8CRjwCRTwjjFcbOfZRiTNHXUkhHEIWjzFhRhQHtoXihFJDJHEg6jqH6T/6lz1TcOtK4cK3rPedawFjzZ5la0vZhM8WQDkdg3k8U+3iume/Rkrx1igr5I9QNS+5sIx5e57E+QRqTub++/OXLtxlSVNgQ7TIUKj4E2+lFVe+C/ODKlELB3CMjFRIS4a0OXKBfLdgYQdXK5R+K/AplUzCAo0s6dlW+7RQMdxK1FNY857ru0Sajc1RYobOrVjbKznFjf7UCls+Mvgv8voyiwjfyNraShQ1KpSk/LKSHBI4nsuOslunbAsaqzGsf7bZ8Aw1mpenhI6rLp/Sjs0lJHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199018)(55016003)(8936002)(2906002)(6506007)(53546011)(38100700002)(186003)(26005)(9686003)(122000001)(71200400001)(38070700005)(54906003)(5660300002)(110136005)(33656002)(6636002)(316002)(478600001)(41300700001)(83380400001)(4326008)(86362001)(66946007)(64756008)(66476007)(66446008)(66556008)(76116006)(8676002)(52536014)(966005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2Qzhygj0/nHEHhrqOikJlJlPUmQjAbS12kHWWg/GItsFWOnoeFF8OpT0WTQ?=
 =?us-ascii?Q?iYnOhUn8qRk3csJDfrBtt6xAJkuTsBpFofcckVdxH8lAjh8OieKnFU9jTv+N?=
 =?us-ascii?Q?JUwjsHNDQdzEPnfi6H9Ws0Buyz1g+IYsfyC7j2L1mdpBumYP+yZHbbIU42IY?=
 =?us-ascii?Q?Rk77KubOCrWk45D4BDxl3Ujj+6fZlc++FVvMZUO403LeGxhIwDIY4v9MKkk6?=
 =?us-ascii?Q?7jp82ZPswXDYYgYDKG62g09YexxIVY8fTXPqEVsQkkBC4Elc3sMK/Ic/0Zrq?=
 =?us-ascii?Q?gB35zZJ4W6ZSexiZuBtt3jQE4IvayMS1HWn6WOXua2WvYEv/FknTc+sshMtV?=
 =?us-ascii?Q?un4Knbw1dxlzDX3SPPTQtdkb9zI9ozcGniYtsSz7xllq9v+hncbHaW9IQ3JI?=
 =?us-ascii?Q?gp4UmFIPESuoufHLtXLxP5ap672+poCfDnusced7ImToOiNz4wkVHARJ8sL5?=
 =?us-ascii?Q?CRn/kbyn29ELsFEsSOZ6PL1NZU18hdBhI+2S+NSu62jVh8pFWWvEl7vHzXO/?=
 =?us-ascii?Q?VGQ66LPdEzJBH8B79XZWT/JGvzeWpU0cVkNjVMlWae6yquK7KZEil4t/TFfc?=
 =?us-ascii?Q?PGuENEPe6gow3JBkEcucO9UBzR/opeosK1cSLS9/NsdH7MrEXje+iDv9mLFH?=
 =?us-ascii?Q?zcRe+UywvBT1uPrkQTeIM+p1RYuWc9AnJdv1mBR0ESrqXORBchuCOUuaoA0w?=
 =?us-ascii?Q?VfrdBGHTc6LjXvvuahgz207THsHWxbS5gPXo2cZ2gO9G00fO0/aIBcP38/iN?=
 =?us-ascii?Q?bqxfV7nF3QAjZT2/aclLvhAgce/ODwQDNAXBvMn8fMfizIL53ipucMc23ahJ?=
 =?us-ascii?Q?Cmc6hdCCuAcV4ZlQaXkmvAMh9QawlhxiyW1SyxrbwxNm8lL82kF9zF8ittGS?=
 =?us-ascii?Q?yUbZ6StZ06UmMSeFmRgOY/auWSltquENTVkmW6CTGJi6opQv94my+cRRm2Se?=
 =?us-ascii?Q?CWD3heMLMFeZ4V9P/oLj7DqIg0meZvV4ih0SVwoV/dD+1LlK0yYiopA8mvky?=
 =?us-ascii?Q?LtsQ+Nq/2PuZJb27xMFQ4vFQrDDerSDevvGqYVqDOEXdictT/iaD5RQ4RzjJ?=
 =?us-ascii?Q?D0x0QX7Q3hAzHWm095zmQ+mBTEoYTx+WZ8Qv+/FM0zR87hNwOcAZF6cfF8/J?=
 =?us-ascii?Q?ZwWYHIlh9iz0swFxrHH7+Uw/vaCa7F3iLbJIPY7wBgd8psQz/5qMgUQ7bJ2o?=
 =?us-ascii?Q?VnxWmINrCNDSZ5XxPjRW3woUfMuRICJB8QK49/0pqAkg7NHDGDyO35hsIQVL?=
 =?us-ascii?Q?tA/nbwyCMlWaKgS3hvt10Z+gM5Z6rTgldrO1Ozq8jeV61GJIHkapDM31biyF?=
 =?us-ascii?Q?O/jIceBQZk0cBqeOeKnIJhQRzbV5WS8GV2g57n6hqUFf09q80/gc8KmVhxuB?=
 =?us-ascii?Q?8EPZowCfANGxN8MIT0s+f9+DNBBJrZ6gDFWC6cOoDrveeAIBek/mn1yyaM+b?=
 =?us-ascii?Q?mEersWasP1nd0BizogN0ONw7ATMj1G3SHNaI9qJGKF6qdE5oKhsdqZv2psB/?=
 =?us-ascii?Q?9krYYHF1puHRYuS/bCa0KvI/8t8FZA9Kn5d7p/x9eYhd/YAaryV7cpUiwcrx?=
 =?us-ascii?Q?xc5CqIJMLlchlkLgFy4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34aef32b-3b8a-49c5-8ce6-08db11161508
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 18:37:54.2266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QiB5RIMbFMnzCD7NTD0medf8AXJgfTAlNzehajIkPm84VMlgmgvSILH0+/CDTbeID+nm+h6+OoH7dbuGUPH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, February 17, 2023 11:04 AM
> To: Antonovitch, Anatoli <Anatoli.Antonovitch@amd.com>
> Cc: Lukas Wunner <lukas@wunner.de>; Anatoli Antonovitch
> <a.antonovitch@gmail.com>; linux-pci@vger.kernel.org;
> bhelgaas@google.com; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] PCI/hotplug: Replaced down_write_nested with
> hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
>=20
> On Mon, Feb 13, 2023 at 09:59:52AM -0500, Anatoli Antonovitch wrote:
> > Hi Lukas,
> >
> > Can we revisit the patches again to get a fix?
> > The issue still reproduce and visible in the kernel 6.2.0-rc8.
>=20
> > On 2023-01-23 14:30, Anatoli Antonovitch wrote:
> > > I do not see a deadlock, when applying the following old patch:
> > > https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d73
> > > dab4b6.1595329748.git.lukas@wunner.de/
>=20
> This old patch would need to be updated and reposted.  There was a 0-day
> bot issue and a question to be resolved.  Maybe this is all already resol=
ved,
> but it needs to be posted and tested with a current kernel.

Lukas, can you resend that patch?  We can test it.

Alex

>=20
> > > after merge for the kernel 6.2.0-rc5, and applied the alternative pat=
ch:
> > > https://patchwork.kernel.org/project/linux-pci/patch/3dc88ea82bdc0e3
> > > 7d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de/
>=20
> This one is on track to appear in v6.3-rc1:
> https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=3D74f=
f8864c
> c84
>=20
> > > I have uploaded the merged patch and the system log for the upstream
> > > kernel.
> > >
> > > Anatoli
> > >
> > >
> > > On 2023-01-21 02:21, Lukas Wunner wrote:
> > > > You're now getting a different deadlock. That one is addressed by
> > > > this old patch (it's already linked from the bugzilla):
> > > >
> > > > https://lore.kernel.org/linux-pci/908047f7699d9de9ec2efd6b79aa752d
> > > > 73dab4b6.1595329748.git.lukas@wunner.de/
> > > >
> > > >
> > > > If you apply that patch plus the new one, do you still see a deadlo=
ck?
