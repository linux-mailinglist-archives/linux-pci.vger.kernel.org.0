Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0970D49130A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 02:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiARBA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 20:00:26 -0500
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:3937
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229568AbiARBAZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jan 2022 20:00:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnppKnpPY+VzoaIYI2H+6W+C0sCOLUFQ0ebvLZczpYqAOCbIHlRVtKGavHYgm2jXqUOKjLNFTdpWG43CasVWBFhqM0xJ0ctF8HtWZkQu/99LxFm+4bCXj5uzAuGQTYVNeF6FNRaw88BroZ8sYAjx/uru+cc7oFAFmoEhhgBUoyDSYmieG5oZPMu0S8Uk7RmK7VUlFb55OCmYLCJKdnoBHO/qbmlhdFepU5Dd8hPELLxyQk+nq8aw1ozyv/ylu+saYRrl4NrXlSl1sTqszT7bb3oEGV2xVdaNpOSWLDvz5tLurfuvDsZGsXiQEbYl2ctuP0kuFFuBuLBHLQmO5+zuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwnF2HDcg40cdAZNtskMnDNh5BwGFw3H/zT/SjvrJLE=;
 b=To4GiwU7ZuqpvULtu7Ga5SX3KpAwUp33gKg2EInDHbHpzjw7sT587NXHWAOq+HtjN/czGU7PyxdX211w+AADszj9FGYkWxhyvDsCJOCRyvfii27Eg7wIqUQHaFwxn+uwMDae+3g+spLlSY/0xe+p4mbOahU6TTVY9IT1RdsshtuPsGQE63lpnB32uVF1qLEWnoT59PuGiR4TmepCI5uGk2wBFNZ9mrSeS757ZDo9m8bQbEIdVMrmH6mzi2f6LTKNjHLZzBki/ymr9ljZub6FiC230/g5XeZSurElcQidw0o5SJY5Woj7+f1qAgvGSpTcf6RoaFiJT0eLHJ8XblYfSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwnF2HDcg40cdAZNtskMnDNh5BwGFw3H/zT/SjvrJLE=;
 b=Qa9QgGnlgKgz77FM+4HBse9suGVCEBsQMDWmbY2fYTn9b+2nG7gj+6iHZX6BC30nU342ZvefljvVCafuVcP8qox6Nx5rK0LjGa3VXMsCTF7HfZF5R6GNwW0/2dcznafrfJjtYTSs78bFoqa7ggRcTjsiGpi4eZcPoxoAtxrFCCM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 01:00:22 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508%4]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 01:00:22 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Xiaolei Wang <xiaolei.wang@windriver.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pci: imx: disable reglator when imx6_pcie_probe fails
Thread-Topic: [PATCH] pci: imx: disable reglator when imx6_pcie_probe fails
Thread-Index: AQHYC4wjv5XbyQ8ZAUS3D93Oe1LZeqxn2bmAgAAar8A=
Date:   Tue, 18 Jan 2022 01:00:22 +0000
Message-ID: <AS8PR04MB86764CA226DC42B8F81482DF8C589@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220117102137.3513439-1-xiaolei.wang@windriver.com>
 <20220117231735.GA813924@bhelgaas>
In-Reply-To: <20220117231735.GA813924@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e926263-7276-4a24-dddf-08d9da1de7e8
x-ms-traffictypediagnostic: AS8PR04MB8465:EE_
x-microsoft-antispam-prvs: <AS8PR04MB8465F4F12F69496F516096818C589@AS8PR04MB8465.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:302;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4VkBMly/r19JIU++XVSXMIwN/xNEGVCL52sewnbwMJWx6waPNIimqwVpHmeFd4RHJpVckv7vQoYK71Fc5U2VYDgXVFbxv5VVKpkB4as6gpLnHSs52NWeLyUjoR7l12UcbLaCuj7rzGGrys9xSfibtrok+ALqH673qF9Vq85XMW8MBZzE/ETAkqqP1eeSpJqKIuADhbD6B/D21GAjrG1gG2SiWMDE7XPFBDXjuu3mjwtmTq3UExnjF6r28vcBc6QlCwR64zUM7eN1E2IrindUXkLoZUFt4HqReeAURU60jqp6pipCnfVVwJCwuAJOB7OTuf9Yi5c1XRKdMQ1K3ggZ1XcXR5CDOCpT4vdZBYtCfXqsmMhZk+yQ1C3YYAq/sH5X1Kcyxqhoo4uImG5nXLYNtMLtD38dKLZPkzM/rw7a/pt12mKUaySSK/fksFTTkUqPRNTY0V9+3PvT/dInuDHbL4NZqYMyi8xenHesojRn2OcEOGklUXbd+64Ifzca7PnnEKVWiKLEnCRdcXEq4yxBbzU5g5QXRU1iz9gyQtoFDyrdYYoQcVOmWejHbE8Fr+D5JJLCb8xR3j+v/CcevgAvkMoxZLNj9GiNjcWLGHoXYeUljl92F+kF6u3rMetNXMN6Pp4f9sxEXngMi+j2EaojAizPWsnhT4UdzLx7NGaW6TuoFRvW5RBOKVKnWXx8Lgf0rhz98ZlNqYSqxrV9CWn8V57wGbDFTpjXys0pJzALRWMyjxRr9AkZIkHNzG5oOqfv6Pw2BE15lJqP6F3JMZXv/pW2N4XbJwdMGngr9+Eu8jn4yZRH0ScC2D2ayP3gfSf0TFPFsS/eG6YUx0Ba5F0h6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(66476007)(71200400001)(66446008)(9686003)(64756008)(45080400002)(8936002)(44832011)(66556008)(54906003)(76116006)(8676002)(186003)(66946007)(508600001)(33656002)(2906002)(966005)(55016003)(122000001)(86362001)(38070700005)(52536014)(5660300002)(110136005)(53546011)(7416002)(4326008)(7696005)(38100700002)(83380400001)(316002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r4mXV4Dbq2bYVhhmeUmWDWUC/pLa+QDOKt103PLGukiB2zhDOMbt+KUDxgU5?=
 =?us-ascii?Q?encfCXqp+p7fAse1Bk7THTLqGNkIBlPG2PxdwHvHEO77aZ4gmQSVKe7V3DVw?=
 =?us-ascii?Q?uNyHys7B8KIrj5GUaQnWyClh6svq/kPnttK57HpFpuF7vTd0eQs6Qy3DcAxE?=
 =?us-ascii?Q?oUfAl3Lo6jwdfrqwWIkw+BayKbFp/SmS0jDMVYmqIS1RqRl5OPn2cUJQ9gLG?=
 =?us-ascii?Q?MVvr7KkfeIs8p9FTVkA9yXpPWc44IXWb1Tkl4Gih8IplBR6QOZ1UrpcMCupJ?=
 =?us-ascii?Q?p7qdVHnC3EcFDWHUjOMB8oCwWddMKc7kXV+1HpONqPGUCemmvBOjNsA6tBv+?=
 =?us-ascii?Q?ZeBBlkyOd94MZnf5+cmUX40ce3zQb+kLhHzMu//gj9XnhH8tANVhvPqFi3GC?=
 =?us-ascii?Q?mxo9/gDNFqq1JC4cANKfUS0vjBSssvyLlaLNdkmsRiblptmwDk00srMT55ot?=
 =?us-ascii?Q?nWzILU9oD/cbdrAVYgW93AU4qDl7GmhDkRClAubfHyzCxxLvBIptnO1MsZD2?=
 =?us-ascii?Q?YbKiCb8iOwB1PqiV2XmkbweJcIZZr2As+G4pqWT0L8eek5IENmiMHUwhEIqm?=
 =?us-ascii?Q?EEpDraK87lQBoTGsOCYEgsvzcLRiX4UWHtwgS0N//0JY7xg6zsO5atQIESk5?=
 =?us-ascii?Q?8ibBXDnHVIgiCKSIsC7Kbk9c3LkJQtGcy/yQQnV9n5Vm3xQppyrUwCqmuOzh?=
 =?us-ascii?Q?7QLjYQz6pYK3dtVRzhumdHBDgQp+lsFeG6Z3FJ6p4d6t5CNqUvb5yjdgKqfT?=
 =?us-ascii?Q?RTECsZnLYyQNBbVU1iRz42ZIGx8JmeJRMKolsrUtYU/DzP/zgqR/geiyZZNu?=
 =?us-ascii?Q?kKDmi5n7SY1Eao8ovB6eoaOPqJe4NIxbSJoFMBmF9PlWq3D3Lqu8uYutlaSI?=
 =?us-ascii?Q?QSiaEB56fzV+My7QlQfz3yp/ROUolyzNIikpmsTzEk+LmN3JeK1fx3LCvXIF?=
 =?us-ascii?Q?pCSENQgPgW/SEBBD+UNffh4PTElsPukHeCeSPmrpnr0eeiUCNfTel6Rmn4xq?=
 =?us-ascii?Q?S/twhQj85LNfSUEGjVIV0HZm64mY2RXciO3W5b2OYJyDA46aqII0qUTv+2D1?=
 =?us-ascii?Q?DOwHB9vZTVl3w6ZUOxa/57jacSKQ/pZdWmeQ0wLpP07wBQLK1VOaBPPu7GZu?=
 =?us-ascii?Q?niNmQbRaO3L3syjhqlhQ6+qXPWyGSsDqKvL5Bi5DQSkku0rfjVPoyxRTm1Ul?=
 =?us-ascii?Q?51L/p5kej/Oz2hHarNvR91HBicEAiqO3uiKsUFDq45/HxCIRf5sYXMeHaSa6?=
 =?us-ascii?Q?HP+VBhDMD2+eLC8fS3fyaoQsBbBS4iXUnuN6aDbxmFt8ThiysU1JqRa+1usn?=
 =?us-ascii?Q?ImvO1uPjm8zzWwTKXqoC1HdRR1/kbagpTE/HgTnm3IaiOUdbr2IKCs8nJGx0?=
 =?us-ascii?Q?+r/cy1JeTLUylAcjnDTeyvkyW9bN/WKgq33E2a9LEc3Ofw0zr4eAxgmmblXx?=
 =?us-ascii?Q?2v/mIC1kF0qBmmaTr1pIID/bc9I9jx2mSfxenLQHaMryxUf94wwZugD9QwqT?=
 =?us-ascii?Q?c2Kbq8y5ZLImEJDOK5ilVXBWR4/E6pAobzXOU1bLbFsMOmOSPbwF9HPJRGbl?=
 =?us-ascii?Q?A+IQkXO+1Ebi8buu3E2KC1PzxTrnsojfRUM5pRG9m7O1zZqS5c/6AtblMpBc?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e926263-7276-4a24-dddf-08d9da1de7e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 01:00:22.8402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VFIxLaN8UqhbpB9mnrwbr4JEDYOWE+ZrkHTPf9ktf3wSOudXRFGE3VVNekZuECLyilV+zirFMu9yHb1Fdwa4FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8465
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, January 18, 2022 7:18 AM
> To: Xiaolei Wang <xiaolei.wang@windriver.com>
> Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; l.stach@pengutronix.de;
> lorenzo.pieralisi@arm.com; robh@kernel.org; kw@linux.com;
> bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] pci: imx: disable reglator when imx6_pcie_probe
> fails
>=20
> On Mon, Jan 17, 2022 at 06:21:37PM +0800, Xiaolei Wang wrote:
> > From: wrsadmin <wrsadmin@pek-xwang8-d1.corp.ad.wrs.com>
>=20
> I got two copies of this.  This one changed:
>=20
>   - Signed-off-by: wrsadmin
> <wrsadmin@pek-xwang8-d1.corp.ad.wrs.com>
>   + Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>=20
> This looks like a good change.  You should also change the
> "From: wrsadmin" line above because that is what "git am" uses in the
> commit:
>=20
>   commit 119fdfb8fb1b ("pci: imx: disable reglator when
> imx6_pcie_probe fails")
>   Author: wrsadmin <wrsadmin@pek-xwang8-d1.corp.ad.wrs.com>
>   Date:   Mon Jan 17 18:17:35 2022 +0800
>=20
> Also, please run "git log --oneline drivers/pci/controller/dwc/pci-imx6.c=
"
> and make your subject line match in capitalization and style.
>=20
> Also, fix the "s/reglator/regulator" typo in subject and below and add "(=
)"
> after the imx6_pcie_probe() function name.
>=20
> If you include a calltrace, remove timestamps and other non-relevant
> stuff from it and indent quoted material two spaces.  But in this case, I
> don't think the calltrace is useful.
>=20
> The reason to do this is not to avoid a warning and the related calltrace=
.
> The reason is to fix the problem that *caused* the warning in the first
> place.  So we should describe the underlying problem and the fix.
>=20
> > disable reglator when imx6_pcie_probe fails, otherwise the following
> > calltrace will appear
> >
> > [ 3.785075] ------------[ cut here ]------------ [ 3.788142]
> > Registering SWP/SWPB emulation handler [ 3.789853] WARNING: CPU:
> 0
> > PID: 7 at drivers/regulator/core.c:2257
> > _regulator_put.part.0+0x1bc/0x1e0 [ 3.795680] Loading compiled-in
> > X.509 certificates [ 3.803947] Modules linked in:
> > [ 3.811922] CPU: 0 PID: 7 Comm: kworker/u8:0 Not tainted
> > 5.16.0-10645-g3c750c7b6143-dirty #9 [ 3.820393] Hardware name:
> > Freescale i.MX6 Quad/DualLite (Device Tree) [ 3.826945] Workqueue:
> > events_unbound async_run_entry_fn [ 3.832304] unwind_backtrace
> from
> > show_stack+0x10/0x14 [ 3.837569] show_stack from
> > dump_stack_lvl+0x58/0x70 [ 3.842663] dump_stack_lvl from
> > __warn+0xd8/0x114 [ 3.847493] __warn from
> warn_slowpath_fmt+0x5c/0xc4
> > [ 3.852490] warn_slowpath_fmt from
> _regulator_put.part.0+0x1bc/0x1e0 [
> > 3.858968] _regulator_put.part.0 from regulator_put+0x2c/0x3c [
> > 3.864918] regulator_put from release_nodes+0x50/0x178 [ 3.870270]
> > release_nodes from devres_release_all+0x80/0xd0 [ 3.875968]
> > devres_release_all from really_probe+0xdc/0x30c [ 3.881661]
> > really_probe from __driver_probe_device+0x80/0xe4 [ 3.887522]
> > __driver_probe_device from driver_probe_device+0x30/0xd4
> [ 3.893991]
> > driver_probe_device from __driver_attach_async_helper+0x20/0x38
> > [ 3.901068] __driver_attach_async_helper from
> > async_run_entry_fn+0x20/0xb4 [ 3.908059] async_run_entry_fn from
> > process_one_work+0x298/0x7d0 [ 3.914188] process_one_work from
> > worker_thread+0x30/0x510 [ 3.919792] worker_thread from
> > kthread+0x128/0x14c [ 3.924705] kthread from
> ret_from_fork+0x14/0x38 [
> > 3.929443] Exception stack(0xc20cbfb0 to 0xc20cbff8) [ 3.934521] bfa0:
> > 00000000 00000000 00000000 00000000 [ 3.942722] bfc0: 00000000
> > 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 [
> > 3.950922] bfe0: 00000000 00000000 00000000 00000000 00000013
> 00000000
> > [ 3.957677] irq event stamp: 1207 [ 3.961024] hardirqs last enabled at
> > (1215): [<c0198270>] __up_console_sem+0x50/0x60 [ 3.968974]
> hardirqs
> > last disabled at (1224): [<c019825c>] __up_console_sem+0x3c/0x60 [
> > 3.976911] softirqs last enabled at (1206): [<c010150c>]
> > __do_softirq+0x2ec/0x5a4 [ 3.984669] softirqs last disabled at (1197):
> > [<c012ef08>] irq_exit+0x18c/0x20c [ 3.992021] ---[ end trace
> > 45a52c023bf8fb33 ]---
> >
> > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
[Richard Zhu] Thanks for Bjorn's kindly help firstly.
Hi Xiaolei:
Thanks for your patch.
There is already a patch issued by Fabio refer to this kernel dump problem.
https://patchwork.kernel.org/project/linux-pci/patch/20220106103645.2790803=
-1-festevam@gmail.com/
Then, I prefer to update the fix by the following codes refine
 patch-set in next step.
https://patchwork.ozlabs.org/project/linux-pci/cover/1641368602-20401-1-git=
-send-email-hongxing.zhu@nxp.com/

Best Regards
Richard

> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > b/drivers/pci/controller/dwc/pci-imx6.c
> > index 6974bd5aa116..f8279a15463b 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1216,7 +1216,7 @@ static int imx6_pcie_probe(struct
> > platform_device *pdev)
> >
> >  	ret =3D dw_pcie_host_init(&pci->pp);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto err_vpcie;
> >
> >  	if (pci_msi_enabled()) {
> >  		u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_MSI); @@
> > -1226,6 +1226,11 @@ static int imx6_pcie_probe(struct
> platform_device *pdev)
> >  	}
> >
> >  	return 0;
> > +
> > +err_vpcie:
> > +	regulator_disable(imx6_pcie->vpcie);
>=20
> I don't know the regulator code and I couldn't figure out how
> devm_regulator_get_optional() works because it passes OPTIONAL_GET
> in to _devm_regulator_get(), but nothing ever checks for that, and I
> couldn't be bothered to figure out what magic makes it work.
>=20
> But regulator_disable() definitely dereferences its argument, and I'm
> pretty sure it's possible to get here with "imx6_pcie->vpcie =3D=3D NULL"=
.
>=20
> Also, it looks like the same situation with imx6_pcie->vph, so why don't
> you clean that one up, too?
>=20
> > +	return ret;
> >  }
> >
> >  static void imx6_pcie_shutdown(struct platform_device *pdev)
> > --
> > 2.25.1
> >
