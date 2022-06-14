Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F854A371
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 03:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiFNBJM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 21:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiFNBJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 21:09:11 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB55FE0;
        Mon, 13 Jun 2022 18:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655168949; x=1686704949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gsoeYOsbvRCi17dnXg7ZWq6E9sbFe1z05x9jk5lkIBg=;
  b=pKL8KKveJKgbcy5RYQnHTpQGz1nfjLI0GZMNCnUYEHBO1DBdjQwBN/yb
   7h8bYwsLlm88h7s1aAVZOK7Jd3bZEobQRyh44WavMvbmWVuUnd6U0Znek
   zPOrMu6yQUWuiPjQwxeUS7Unp+lIVzmwzoo6ftNb2Ku+v+D6gLm90opzE
   2u4dnG3lnz9gRtEz35KtgVQd8yBe50pe0miB0hfroA/VhEKCwCexDkhh9
   y/+QrGHCdPRrIdPLWiKBkEcs0c8o9By/58zeJ8hnPcdytlXM5NwWzuVT/
   EC3dMVKhhvMsLA9aHpIOYKAoYzamDlBaayzlT7AfrrlG/khftfMRy2yyV
   g==;
X-IronPort-AV: E=Sophos;i="5.91,298,1647273600"; 
   d="scan'208";a="203047431"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 09:09:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvndYvjfT0cHW3i3ssIdNVgraFRY1d3BJT+ky+0GVD/Xzf0n1tSiAZ9zRweQ3EgzJEQQ3K2cMaeVGnSGk3wsGwWuV6ezLRMKILCAoOPkrWqHvjqzotvcQRuIZW42luqnwdrkW0QiFYaTTvfAn7bgijTFVCUkPJ+8xFAUt3yhti8jWciza0dw0K6LkBaZ2+MrUqfuOE1EwjYKqoqOXqCHGDhSbRyXibcxaF6PBasOXYNGZ6F5qWvMcQOfxt9LmjTsll76X21BssR9HeeZ9m5FLW2G6prKC5LsREqK/OPoICYu/Vpb7/giy3/0KzTHhg6h/c+DSxbu4IQoRjlhnEQ2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSCh7LpsihoTXE3t593PubiC7301nq7p7q95AFFNixs=;
 b=S3I2YD8YBtIH0snOyWb+bgcguMbFk1EP2yfQPY3BQAWEOLgX5Bf+t05fy9dwq+Mo7FpJ/Fsz2eysyQuJT3je9krS21LSIG7bY15AJb417CzYcIqDwyIz4Xzy+BzH2N/lEjVlpaNzIqgLuDPJph06evGcPA7layWvuOhoWGZohUtphtfHwMFpU+xUafW7coeQyMoIjcig/ROoV0PnQYsllhtUu6tLv3sOXWxfZkGhmLm9Us8KZJxcpFCra6lCnegpYZMchxZqfbKWEgFE4O4gfMTKhoROI6RGcIaQOJSPkbhqLTqiNIt21X57UH56SCKqNalzrrgQqZarlInHCrGuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSCh7LpsihoTXE3t593PubiC7301nq7p7q95AFFNixs=;
 b=BZ5p+ly77J/rMGPmajtKm5RseYAZBCBRCeW/RkV2qMSfQI+FsePGS9G8SqA1wOgYK1ShP7IhKyKREfwjvfWul7/aMIFm0DfcLf0gADZTuogn89Bfi59xWL7v01vHoigCwWiWD7oU5rwXRBDqbPfV4ZulI7lVLVBsRL1/F02sWrM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5207.namprd04.prod.outlook.com (2603:10b6:a03:ce::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.19; Tue, 14 Jun 2022 01:09:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 01:09:07 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Thread-Topic: blktests failures with v5.19-rc1
Thread-Index: AQHYfFwe8PMwMXtEZEqIJFDj8WJWFa1IXnmAgAACxQCAADBSgIAAJ8QAgAEp9oCABDqugA==
Date:   Tue, 14 Jun 2022 01:09:07 +0000
Message-ID: <20220614010907.bvbrgbz7nnvpnw5w@shindev>
References: <20220609235329.4jbz4wr3eg2nmzqa@shindev>
 <717734c9-c633-fb48-499e-7e3e15113020@nvidia.com>
 <19d09611-42cc-5a81-d676-c5375865c14c@nvidia.com>
 <20220610122517.6pt5y63hcosk5mes@shindev>
 <YqNZiMw+rH5gyZDI@kbusch-mbp.dhcp.thefacebook.com>
 <CAHj4cs9G0WDrnSS6iVZJfgfOcRR0ysJhw+9yqcbqE=_8mkF0zw@mail.gmail.com>
In-Reply-To: <CAHj4cs9G0WDrnSS6iVZJfgfOcRR0ysJhw+9yqcbqE=_8mkF0zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2b9de5d-1318-496e-27a6-08da4da27b60
x-ms-traffictypediagnostic: BYAPR04MB5207:EE_
x-microsoft-antispam-prvs: <BYAPR04MB520710D52882119D0FB1121FEDAA9@BYAPR04MB5207.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oENhPUoO54xCovLU+xAYyA/fazfwegmuEkFnMgcKoPCCgbV/IhMBGLIXrMXejr3zRFTSxn79nKZVITno8Ipl5dhNFJPP7pzndqsdMTKnqYPkbefcQtoyUuASLdWcLHWG2psmTogQDgG1G+jf5aG4PQzBReBrqWtNL5leo8mIBjPOsFLV6AlD1RYAudOnMUsfO8SRmtq+3hl+mek+yYVIb3nPiRBoqWr9vVn4ohaYQkd7YLnHCpKkyVVWvMgN8MFEuBlNQzcVVJ3CAOuH48fDEjQJzq8fj3Srv9S/3YwGyW/j7LN+/X3iGzTEcyzDM+yCbmWoGoJe7tD2OWXNaRG2T98AUd06x1568bwgwUjwNvDsku7xR1r1e0Sw6cBVKIayx/NCtgVJ6wJavLWVZwFG8JYSQGu4GfO+KRz6ovB+SG3lncJBnqMkaOnQvkRmNmjjD5TJdBab9NSNYoWXbOCWekYIy1uHYQ+Ph5LFGYd/yBhcwJbZ0aQKCzD61wOD6ooMbit9oSFOML9uNtORKtGDv2nesUPzXaymu3UFbkppKv8cAfa/6pqhJbe+oHKnFScmgzf754b8rte8rVKhItrlbBfUEty0M1QRp/MiJyKo7mtp4fCDkT74tTm1J5MThaUiAdMgMtF8gHTrhjz4iM8iAX7XCggWAGTpOjyNgF9PMH+fUd5Xk9VzzKtQx4TWiDNoy+PXbtNAluok7B+un5jLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(44832011)(508600001)(5660300002)(8936002)(66556008)(66946007)(4326008)(66476007)(91956017)(8676002)(122000001)(316002)(6916009)(64756008)(38070700005)(6486002)(9686003)(26005)(6512007)(71200400001)(2906002)(1076003)(6506007)(186003)(86362001)(53546011)(76116006)(33716001)(83380400001)(66446008)(54906003)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GTvDubeEk6rq9ngVca/yVLONn/+GMyGq/3wvUloCX2pcSvFelQVlkwlx7toP?=
 =?us-ascii?Q?uqmfTBIUFd5t4JT5YX3lOMb2nyWD4h1+wMUzooCGbv/8+zNxT64RZ2hKLvHi?=
 =?us-ascii?Q?VfTGvDLw9mMxh3bR43lKVLW8R86zruyJ4rbSRmyJji5jd+fVg9tJIIXdbLRS?=
 =?us-ascii?Q?/vdKJUPh82j4xsyEHgpjk24evXL9oHdlAWlftduPCgHDLZLGUoX/QAWTQuOL?=
 =?us-ascii?Q?8IIg+jYt8nX1F7M2L8uWOYiTRXRtTpnJCJO/GPrRXIOo2NhbKAHRQdB8PrA2?=
 =?us-ascii?Q?D289/BldbbumMkXJPDc66p9RKN4edr5ZWdgLtJ9/H6QW933V8QVAxg+y+u4m?=
 =?us-ascii?Q?aFhRU/H6MPVlXC2h6WpyFAc08APckQIoOI3UK/AThyhLV57qagfeky+V2i8Q?=
 =?us-ascii?Q?paK8xVOWwUhDKkDHSo3Jkp9JGbc5ORNFHWcKuq7V+zp1267xVw0KQ8p3lNzj?=
 =?us-ascii?Q?+9jLTOXhek6Pur6A3f6oZh5T0gDUUWaVNpiUoinT1+5mL0WTetid++ATuY0L?=
 =?us-ascii?Q?/mqbndZ1LZZl6rTfC7UiEvs3Nmm/PxLGDkKkQcngDoFpC+pldk2G21nO+5IM?=
 =?us-ascii?Q?Bs2H8kDtOXeD6cCBGl4LsFPwG6csut9bnqxWVHG7iEdclz0D4C2ryLr6/6XH?=
 =?us-ascii?Q?ESMg9h+7oMy7qKW0QpgPXD2qWd+aqYFnn/x22XuRKT6YlYBlidOqbX3wZPdY?=
 =?us-ascii?Q?5BwLmIyM1wvTunohuO31dy2Kf8L0ZKa6Tyo/dJSXAqOEDJ/OuDceXPGOwKs5?=
 =?us-ascii?Q?ElFLwAO+gjI3R1VCYdOh/5l3aGT9AfIqDd41b/C2jY7t7rzc3kK83inOu4FU?=
 =?us-ascii?Q?gE+pv6bJGzDS0ZatLraJN3ox+IO1edqLpO+M9cKarTs5CKLv5NS+0Us5j3Ap?=
 =?us-ascii?Q?07UzYiQZqB3+MVYtWL0TZXq+3G85bPyfG1n3YfSo15bF9F6KPPmc1Ac79U2W?=
 =?us-ascii?Q?g/cI/DNw4IJFJjdnbNnmYSHV0ZwU4Sz6XKBjUYc/56BpqXgB1ip1gPBCXnPW?=
 =?us-ascii?Q?KoVOz/JfbD0LxKMt38J2YgJaU3qirZqwBBnKpOUvr4g4vBK4iL57xyZ86OSM?=
 =?us-ascii?Q?3eGJm//JeOwLjJPOB5JXwbntoh3CfSSc7msYKcSilzM5HPsaAcsfZX+6XZUH?=
 =?us-ascii?Q?jJlIqicybes9UKmg1YgcR5SCU2JwJzBBKOViaW92PRUJ0iigt2Xh9fhcx/ad?=
 =?us-ascii?Q?3b81AEEGMIfxdSKuMDT5fhnTJBtqe1uQdJiWuoGXhX21sg3P/UAtLLHZN1T8?=
 =?us-ascii?Q?s0oUUZgnMrzFwefld8PU0xuFIC+iGutK2ztw4zx0lcTI2mwviCFxgU+6WrpN?=
 =?us-ascii?Q?Pw7fIadiO9MEnJjIrMbV9taRNT1t4HBfXeGbyBHQRobUbbiG9F+N/P835Eep?=
 =?us-ascii?Q?pnGc2ZvyiooZZrL2q4WBhQlrbyKUR+51PnEOhgqqvlMNtHtO+RxsBglQLBDl?=
 =?us-ascii?Q?2Tx8W5CMQHUFf5YoAt7Phm3tCQ5h6YXgqeVTDVCTuJpxe/vujO8SEHL5eX1Q?=
 =?us-ascii?Q?hPxyLNQ6MN07gkRf1FKUqbgjngdbC1tKRGZNvell3hJmglEN3V1L0T953O2y?=
 =?us-ascii?Q?v2H5q4ZxfZP/hMRXvvMSIVfTQnDQCEXYXndy9QwVXqSHJDVl7RFNs5wyPK8h?=
 =?us-ascii?Q?dn8LWSdjwt2jJkc+2miSKKF5mcpFcjLUk5asir9Wp8CuBFgDqoFOBMPCQWhw?=
 =?us-ascii?Q?+xs3yBrwKYnN8LkvXd2xF4aMpkYhx/FrqSJC5sog9B330w5yjz7zvp/X5GB4?=
 =?us-ascii?Q?uCqlhSUVeZ2qiwiwhPTzx4zHjGAukSqCKNNP4KjcBWXm7phob0W3?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB2490C0234AB94FA11C88B3D5BE2B32@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b9de5d-1318-496e-27a6-08da4da27b60
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 01:09:07.5973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4g0aLlXojGpPsQY/hhWvwwkdPsBKqXEhWcdDpI73Kkl364Zv3A/BIjqVVF2KTSR62z3FM0hybRp9mOz8wqBVSvsZVD2t69vHV6xGlRaA89I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5207
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

(CC+: linux-pci)

On Jun 11, 2022 / 16:34, Yi Zhang wrote:
> On Fri, Jun 10, 2022 at 10:49 PM Keith Busch <kbusch@kernel.org> wrote:
> >
> > On Fri, Jun 10, 2022 at 12:25:17PM +0000, Shinichiro Kawasaki wrote:
> > > On Jun 10, 2022 / 09:32, Chaitanya Kulkarni wrote:
> > > > >> #6: nvme/032: Failed at the first run after system reboot.
> > > > >>                 Used QEMU NVME device as TEST_DEV.
> > > > >>
> > > >
> > > > ofcourse we need to fix this issue but can you also
> > > > try it with the real H/W ?
> > >
> > > Hi Chaitanya, thank you for looking into the failures. I have just ru=
n the test
> > > case nvme/032 with real NVME device and observed the exactly same sym=
ptom as
> > > QEMU NVME device.
> >
> > QEMU is perfectly fine for this test. There's no need to bring in "real=
"
> > hardware for this.
> >
> > And I am not even sure this is real. I don't know yet why this is showi=
ng up
> > only now, but this should fix it:
>=20
> Hi Keith
>=20
> Confirmed the WARNING issue was fixed with the change, here is the log:

Thanks. I also confirmed that Keith's change to add __ATTR_IGNORE_LOCKDEP t=
o
dev_attr_dev_rescan avoids the fix, on v5.19-rc2.

I took a closer look into this issue and found The deadlock WARN can be
recreated with following two commands:

# echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/rescan
# echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/remove

And it can be recreated with PCI devices other than NVME controller, such a=
s
SCSI controller or VGA controller. Then this is not a storage sub-system is=
sue.

I checked function call stacks of the two commands above. As shown below, i=
t
looks like ABBA deadlock possibility is detected and warned.

echo 1 > /sys/bus/pci/devices/*/rescan
  kernfs_fop_write_iter
    kernfs_get_active
      atomic_inc_unless_nagative
      rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP) :lock L1 for "rescan"=
 file
    dev_rescan_store
      pci_lock_rescan_remove
        mutex_lock(&pci_rescan_remove_lock)           :lock L2

echo 1 > /sys/bus/pci/devices/*/remove
  kernfs_fop_write_iter
    remove_store
      pci_stop_and_remove_bus_device_locked
        pci_lock_rescan_remove
          mutex_lock(&pci_rescan_remove_lock)         :lock L2
        pci_stop_and_remove_bus_device
	  pci_remove_bus_device
	    device_del
	      device_remove_attrs
		sysfs_remove_attrs
		  sysfs_remove_groups
		    sysfs_remove_group
		      remove_files    .... iterates for pci device sysfs files including =
"rescan" file?
			kernfs_remove_by_name_ns
			  __kernfs_remove
			    kernfs_drain
			      rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP): lock L1

It looks for me that the deadlock possibility exists for real, even though =
the
race between rescan operation and remove operation is really rare use case.

I would like to hear comments on the guess above. I take the liberty to CC =
this
to linux-pci list. Is this an issue to fix?

--=20
Shin'ichiro Kawasaki=
