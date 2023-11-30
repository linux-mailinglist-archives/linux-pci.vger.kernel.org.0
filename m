Return-Path: <linux-pci+bounces-280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AF67FEDB2
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 12:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68AA1C20A45
	for <lists+linux-pci@lfdr.de>; Thu, 30 Nov 2023 11:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5B3C09C;
	Thu, 30 Nov 2023 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jm6GAGYD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kudyVAjb"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA2DD54
	for <linux-pci@vger.kernel.org>; Thu, 30 Nov 2023 03:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701343354; x=1732879354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VazTUKDBxnBbr6P/yBuArJG22hoTnQUelUCgXNHHdUk=;
  b=Jm6GAGYDm3M4isk9Huu8Yh8jfJkH86RaTRJf2P413yMLscC/d3NA0pts
   1X4WO+FfX3QRT2WqGgA2rshJBc4Yy4oUCkU8Q7YHdhAQxivs3yX996A7B
   Pp2q4JsHlgbtbvzJ0J7pKEpW4ep5oc3ItyFdXQEm5kuLFgi2BTweTf4X+
   WKaGL5/VOTsfm6+kf/H/AP7JwltqrlzNXMl8ie3l8rh6VtFDuvzX3Qz8U
   L5sGkGJkF6OL40Dj3Dk9bMdbIg1KRcp0mWWtV1mbh3gYMcKGdNY2tmVdM
   oBudf5nVzALjlbqxxnghF7s/5zSH9+oUjYugyvVju4nVsPbrFbbxmbE0v
   Q==;
X-CSE-ConnectionGUID: +MA6wgQbQz2sTb1H11gbuA==
X-CSE-MsgGUID: RUtO5RraRGacB50fNbvdVg==
X-IronPort-AV: E=Sophos;i="6.04,237,1695657600"; 
   d="scan'208";a="3852324"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2023 19:22:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDuCodsBB7yYmTajWjDy4T9wrEGSigbYwZaA+Pmwe6J2knH64iZT/jaEIGwpSst5BCTpdvRB0KcGkU/PjaVfSWoEymSaDkZTnIJsItiZYEtfz8C3kBSUeF+cZqZxvq4o8azif0F79vI+x4BwsF30H6RPwnd0A+ZyI7bDzdAL3TPOUhwlFuDy7+gnLQCK7vgCZy+sLRRpKSaWyYA0+qf+ra7ZjQ1dz4NmEYgljf0bSLA78EMPvq8DXXUL2RA6HvyhPQNb0xWOVeoA6zqIDr3WoR3jANhqOjDOVaen8nHOQZFQRaJjvVNpr049y8oisn/sv5QV0/P2xD9rNRDjAHi7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VazTUKDBxnBbr6P/yBuArJG22hoTnQUelUCgXNHHdUk=;
 b=mYzUMh0bUwdlgWjmdwiUTchWD8B6Z1Iwsl82pN6gwDoaRcW868PSf4zaQTUqByEqMroFOOoL+bbqx2L5VdkvdDR4kANPNeoX9HM2yQzZdCIArtM+dFNi2ulGYalFRkeGpE0cjkNqdb2fLyiWnEv2eOVOAqe+NJNFWLSDAeYD95Y/t7qbBRYXfilXs6ZMQ1OexhLKB+ldDlVTeYE3p3YKnQVQj9NXIT3s3W+FTNn4fAKJKPnDy/eObmviKLPfXa7z2yS5dooqYPiwEPNlGd9Lg1ihiO9iaIAUMOTTCPR+ZrM5OO6oHFfxdTTJue04fFg86RXBj4optdNS4Xte389wyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VazTUKDBxnBbr6P/yBuArJG22hoTnQUelUCgXNHHdUk=;
 b=kudyVAjb5tfmD3qQj/tM61npzWmtV0vT32WeZKyD+UrXKIb8g1DKv2UHZeY5/Du78RbFS3C2jD7x3CjoiiyWXxrbH9FMGYnfqhIfsdi4OBtcSOgTd9In0uH4/syns7QdJ9UL8DVfCBmbRPYhNrB6qEpC9UTN/pPBJys8/oe4o2g=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB7077.namprd04.prod.outlook.com (2603:10b6:610:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 11:22:31 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 11:22:31 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Topic: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Index: AQHaIiIryDDmjYJXQUiqpuEqK4O7WLCRLOCAgABGvQCAAAxigIAA60IAgABPfQA=
Date: Thu, 30 Nov 2023 11:22:30 +0000
Message-ID: <ZWhwdkpSNzIdi23t@x1-carbon>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
 <ZWYmX8Y/7Q9WMxES@x1-carbon> <ZWcitTbK/wW4VY+K@x1-carbon>
 <20231129155140.GC7621@thinkpad> <ZWdob6tgWf6919/s@x1-carbon>
 <20231130063800.GD3043@thinkpad>
In-Reply-To: <20231130063800.GD3043@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB7077:EE_
x-ms-office365-filtering-correlation-id: 73120539-f360-4cc3-743e-08dbf196a485
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WdQe7pH9Ot8/suThpnQoZ4dk+z+P6L4m3NtX5me2Dk4YeZ2UMo9NgCcP0giBDUy6ndjTUbMCLGl8DlKL79orpRsdIgGsj1LrOfRsQXI2+K1CWJDP4vKjQRd8sVmczLD2QG7HO676JeuUpYjDLTOE8Is1TEmD0WPYwCtIxnCJMBYNq1VNKYTxCmnCQf606420ACCGetah8M31oe75qoUgD4r0Dw+fbtdiBZn8DpRqktyguk+ru7C50hvMmKnANN4rn2dU6BJHDY+bdDkLTCaawtuM47VvpPDCTldBSnMYP6Jc9JIEAfIu3aJZbpeCE0upvuZQSCugnOufMsLrZH/OZrn2sPdjcVcViSh6FhZ2dcLouFduoNQJsM50jsa9ljZyv9hWRJ3rHXFI82PJ1Qpc5wqpbzGoS4u4AfQ4IIgNrCgSrKlv5EAzaW7QXBuUE9cJlj9n8i+pPlNCsuBwyAZQjKIgRRvm/dQ3udFe2/tUrSemi0ivN3LS0PqH7EnlXrBzUpGlndGU47D9jaO1nNlXfqAW6yoaMmh1rmkiTb7KmGVbBIv21P75GeKcSNm8G3kiAbfu0yEYdFCLUVZGbOiPm5CF1LG0qIRD/3KRy835vMRs6vl5+CNtaqUQ4cUn+erBgVBiRsgtDVVUm+3WwaJLEYSpSmbiPYQYNrngpEUR6p5afrDjMod+Fh8geM1w6OxKsj74QrPcONCLsvP4PlBiJg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(366004)(346002)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(2906002)(33716001)(6506007)(71200400001)(6486002)(478600001)(4326008)(8936002)(8676002)(86362001)(6916009)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(91956017)(26005)(82960400001)(83380400001)(122000001)(9686003)(6512007)(202311291699003)(38100700002)(41300700001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CKCY8ZpM+pHSlJf6OAQEyxyxQLeyD/9uQK4oHiBTm9F/tH5HIRf+RdSnfnvD?=
 =?us-ascii?Q?Srh7tup4JPHclCcJKSxk3a1FHkhSdlw+KGPFvGuA46IxxyTyKaB+RYwDdSPX?=
 =?us-ascii?Q?YPxUfieMKJ9BVHXBfy6Slz044ok9cU/XhX5D9zzjDhlDIQbUitlxuP/mMjUh?=
 =?us-ascii?Q?4uIrRbOi6p/Qcx5NoSIp1LgA2+2IlY3syOSwz1JX2PJSCQWeLofvRo4emVK5?=
 =?us-ascii?Q?HOgrgnJxG7l84pJMLWR55ZSAgr8/16J7mKCjirI0JEpIH8+jfY2Tg6b1eOI3?=
 =?us-ascii?Q?kjdLtDcIxhDMc0oGrk2m8MzRJYBtpAjWHS8qj0rILUctauwKpIYTpFuEBqE8?=
 =?us-ascii?Q?qpt9TNbP88q696hq9Mx4AB2fRlC3BoJtD64qb60V7eRDkQzbXnRbPun3gXhb?=
 =?us-ascii?Q?VJgEo6DOKx5cNou+iaG1t/nh0xgx4mZiJ1RA3I/z7ekQ430s3cXVrzkkjzFU?=
 =?us-ascii?Q?863Y7KLy0N6uCP1iJE/xG30PKUpdlOiVyUk/BZkek+U4b39+9DUqmkmqCXzK?=
 =?us-ascii?Q?/wwQtOy0iOSaYmcbxXWaYiCHvu/LyGAW8nKuEU8RtKWIpYIsv5JurGsbpFG5?=
 =?us-ascii?Q?O2VN30TBE6OF83Cn2S3wYSp01KA/1FbgvOq/DOpCrjgbW/vcPJ2tYW/a/qtp?=
 =?us-ascii?Q?i4Z+Lvc28XLvaTCVUI/kUMGgy/JNY3xwOw7MbZw9/wJpHq8gaIoC0SWk4JiR?=
 =?us-ascii?Q?2bABqN+OAkPpUT7qZjoHZGvk8pMSK47VQVuK2xdugrE/HxsY++V1D1dIi8OK?=
 =?us-ascii?Q?sIdkwkqvpGp1iOCmU/K4Rp3qBFkt2a7qFH8M6iycShXMpwSySfFwZWV1fayH?=
 =?us-ascii?Q?++uhK7a+l5qlVxD3cMwzjc4z6hRO+4VjzjvVg6YtB5ev9Io216BvQxdCVhGM?=
 =?us-ascii?Q?YIz1X1/aylFvC3PPqNQeNhPdQMiVNNdp9rRZQJf9jvOgGvMLt9WRLaT8701X?=
 =?us-ascii?Q?GFI2xtgGmFkS9HDDPpuSyhculB/JxkEQdpOIMVnMh0KI0W7n6Z1TQ+RoK176?=
 =?us-ascii?Q?o/3EVSQYTvHSD1Eep1WpHUGQ84zHqB6uI4EmSgchAe54DEDhi7qMOtXjUrcI?=
 =?us-ascii?Q?rWDvw0ScrheRf803Fyt1iaBEhU9VKuRNKDOBtG0Pm9nNumhRNktJHLMkTlWX?=
 =?us-ascii?Q?dEkR4BQFpgiMecjqHforGBY+Q7ryRS/pWDB8HQiK1JItd38aQpfy5BF5DKoP?=
 =?us-ascii?Q?757iCBJcXaLcLq+VWjbBKgBxg6OCnf8DSuAtxiupTz0QVORzLtgErg69Si0D?=
 =?us-ascii?Q?UrIw68qGYkdTLv0Kssy+SyWM63BaqVaalQCsA8PBQIx6K+6Rj54bbQ32tEv4?=
 =?us-ascii?Q?EtzEHxo9dUTre07zdmsiK8VZG07UA0AtWe3RM8WAQ1jclmpJxJZJXWIv7yDg?=
 =?us-ascii?Q?QRy7g//TPGqcamWooqtcS7HecNaPQY0HbHNaKeyq3eJXS2jImTZGZ+EHF7iU?=
 =?us-ascii?Q?BNL5VlSO6Xr9rlnLvjX2/NK82i0oJJKzd42AjkZsnoCWhfBY/i5qtnsQ5gwI?=
 =?us-ascii?Q?HVsuSftK/+Ri0C/L5owe3Ja1LXApqE0Te4zPUpl5KJ8fwFC2+G20NVU+ySdl?=
 =?us-ascii?Q?YaZUKXRAP+mJIOvMo+ME20ExIn0QgQPyB09RzTMGKhI63XV1lRL5BWtzXlqJ?=
 =?us-ascii?Q?Nw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <546F045448BEC74A976349B66E306877@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SP0vnNnSpzuIAemO6j4EqSv5lUBSbO/tizaHrsHjUKd0QM8jnZVIeOiJGkVpQMSCSZBuxU7wTk65oV0yhOQpeLmvtR7Uuv0JO0zIWMT+LH2aC/zEdrD+OoQNaSeMXM55dp2bmsYhw07CBQuPDOcegN7wxGudoOTtpURwWGC5+1V5rFW/ZxrKnTOzuCdDpSU1OH8dqMiuR69bSU+BMUKQkXQHYUtg5F+It6lBfrkO9xllGJdF/vMF5BB/N2MhwRa4JQFoQu9c4lAuV1lErwfMi1AVmFEsqQa/+JyiycQvJq+hq1RZJYMm7I0iFioHxB3octvBItWjioL5BrkATjrimbTiOoke2hmfwwjBoraJIHKSMcH0Y6KaJbk4qbVvseGMs7OUqT9XROo3+iGkzvHUfg3kxWv633tPwQoEC+zY3mXXgthM4wvBE9fHEn0N5yxiuRRE5zvl/Ra9MaoaxIpVLkUnL3/g3c0XJaDbxT67D9S34X2OEVwxQtuPSuGNvumUxQcq5CflSNkpL0LHgZwiGE60OqmU/HFmvC4Fzdl4NGe8txvcSzTGW4abNfQNAQ4c847Nz5GMqJZpitYVthywoF0mLtgTgb3YcNCUcM8vYQ4sS98ddIvuT6GYE5PaRHNfXEhBkuQutBbhnTbEj92TZyBF14RNJI5L+vCkJlGoxkmwle2rXA1bc0Ahi45Q9kqcRbULEl8khcXNLogIUaptJs4cFOon+fzHPrU0xTPACT0BRynd/W+AgxEIN6socvQ0H/04BX4dC5SU0fO0veeWvzCQ1C0Dx04HCEH1BeBRUf0xNTGqtLqYfnRD7HIlBDLO7e4BtVcgskaONDxDgbatMVfyP+KvN/RdEd3f19VVRPHCg6WSYWBeaRFhgGgES9ho
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73120539-f360-4cc3-743e-08dbf196a485
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 11:22:31.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRifIpL8HirxvoAJK/bBgeJiWuOmHkBfKSvqrNrUMHAHJb/HzSRx0p0LQZztGKrfhH2F4xr+wg39iAEurVQN9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7077

On Thu, Nov 30, 2023 at 12:08:00PM +0530, Manivannan Sadhasivam wrote:
>=20
> Looking at this issue again, I think your statement may not be correct. I=
n the
> stop_link() callback, non-core_init_notifier platforms are just disabling=
 the
> LTSSM and enabling it again in start_link(). So all the rest of the
> configurations (DBI etc...) should not be affected during EPF bind/unbind=
.

Sorry for confusing you.

When toggling PERST on a driver with a core_init_notifier, you will call
dw_pcie_ep_init_complete() - which will initialize DBI settings, and then
stop/start the link by deasserting/asserting LTSSM.
(perst_assert()/perst_deassert() is functionally the equivalent to start_li=
nk()/
stop_link() on non-core_init_notifier platforms.)


For drivers without a core_init_notifier, they currently don't listen to PE=
RST
input GPIO.
Stopping and starting the link will not call dw_pcie_ep_init_complete(),
so it will not (re-)initialize DBI settings.


My problem is that a bunch of hardware registers gets reset when receiving
a link-down reset or hot reset. It would be nice to write all DBI settings
when starting the link. That way the link going down for a millisecond, and
gettting immediately reestablished, will not be so bad. A stop + start link
will rewrite the settings. (Just like toggling PERST rewrites the settings.=
)


Currently, doing a bind + start link + stop link + unbind + bind + start li=
nk,
will not reinitialize all DBI writes for a driver.
(This is also true for a core_init_notifier driver, but there start/stop li=
nk
is a no-op, other than enabling the GPIO irq handler.)

What this will do during the second bind:
-allocate BARs (DBI writes)
-set iATUs (DBI writes)

What it will not redo is:
-what is done by dw_pcie_ep_init() - which is fine, because this is only
 supposed to allocate stuff or get stuff from DT, not actually touch HW
 registers.
-what is done by dw_pcie_ep_init_complete() - I think this should be done
 since it does DBI writes. E.g. clearing PTM root Cap and fixing Resizable
 BAR Cap, calling dw_pcie_setup() which sets max link width etc.



I guess the counter argument could be that... if you need to re-initialize
DBI registers, you could probably do a:
stop link + unbind EPF driver + unbind PCIe-EP driver + bind PCIe-EP driver
+ bind EPF driver + start link..
(But I don't need all that if I use a .core_init_notifier and just toggle
PERST).

Of course, toggling PERST and starting/stopping the link via sysfs is not
exactly the same thing...

For me personally, the platform I use do not require an external refclk to
write DBI settings, but I would very much like the HW to be re-initialized
either when stopping/starting the link in sysfs, or by toggling PERST, or
both.

I think that I will just add a .core_init_notifier to my WIP driver,
even though I do not require an external refclk, and simply call
dw_pcie_ep_init_complete() when receiving a PERST deassert, because I want
_all_ settings (DBI writes) to be reinitialized.
(If we receive a PERST reset request, I think it does make sense to obey
and actually reset/re-write all settings.)

A sysfs stop/start link would still not reinitialize everything...
I think it would be good if the DWC EP driver actually did this too,
but I'm fine if you consider it out of scope of your patch series.


Kind regards,
Niklas=

