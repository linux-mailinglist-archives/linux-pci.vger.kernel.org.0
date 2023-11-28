Return-Path: <linux-pci+bounces-229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4DF7FC06E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 18:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 268B5B21147
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061CF39ACF;
	Tue, 28 Nov 2023 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o5uH5XjM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RJjCWYID"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E19F1B5
	for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 09:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701193317; x=1732729317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZtufQ9f0KWyeRe4lnUikblak7nJchU9GzjZy6K+Fog0=;
  b=o5uH5XjMzLHZ+YaXYHVdwWMpnWi2CzApGXgB4SWiVWu2FreenbBiPCrg
   qAVuNMqEBjrEfbMtBkc00UMx2tKIPQHyQou2gZSh/d0SWGt7TMSt0AILa
   ynrqGMb4m4pq3rlbx8Z+gz4vVBkvsjhC8fLjrwZME+Cp157IeH420Putn
   estxO7Q56w2+CGqaU5H+6xicW8ZekcX7bQ1Z7b0TxHQuLVKk1W7557YCD
   qVMKgD4OgP8qMfQCtc37s4tww0XcFjYoUOgFYBKL8ZFITXZ20HYukOBD1
   k1cS54wA4rMGrVht9unNxCN/mmCvtn4GNn5jNYD62L8f9JQ4sUA04BmF7
   w==;
X-CSE-ConnectionGUID: mVicT0Q7SVuRyXvQj9UP5w==
X-CSE-MsgGUID: p/sYsF71S/SetnNlfY0FzA==
X-IronPort-AV: E=Sophos;i="6.04,234,1695657600"; 
   d="scan'208";a="3553219"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 01:41:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdgMN2qDBThoJY2Bz5bP7lkwLxS7o2dhve7JGsxelIj0Ys5OHRduZy9L3Fl8r9rvyN/jDv1BMcaKKArXwttWU+bSJUbFfdvh191fR8Eu/XpDOWF4/jEL4seILej4mRb4tNpioBtz33fkSoYd/co45moV1qo/R5anRz+t88L02PVnCE1vtCMT0LDTDB84gjUDR7nM1v6Mx/z+zfMv36mJ1WcPFEaQr0SSgyQAZt3SOHHE6Oly4pqmUwiHkwQRt6Q1tZ51a8daMpjBkxTTJCGPECvSXv8xROqDZtPd0ejGla6UO+ZFMhKETHE1BDPkLed92RzfVBlcmKjnVlphzk8FVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqFi3ACjBWktYTe3jBVndeP1dGjeUCJ9Y83cqEmVrOY=;
 b=BvZFlCBj3HN2zX8N+MViShnZEOrT7pc2IYgwpOFenwuj0178mIP9NqGAmfKMPl2N4tuXiX50tTaGCEKYKcXWEYWoeVCrRFCeG35OwzdKe3a4rqX0KM2Iq2w+KLSqW0jXQmZpYoPKE8yvYaKJNVPAwzLj9rEJtndrWp4rMMBL9ttRw50sXIAUKX9ujrEmWS9c0SwTuoT/Bo5VyN1vMKCwRf4yx40uLhFQNtIxLFhFKWz25KLN6rl8FD2gADaLFnaiNNHQAj+WbUIAuXe8DnaApiS6mDXYAO3kA5Bt3F30wjsjKqpEBZhfS5B1WEskLnZY5BW9Wk5AsWW7TYfah87lKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqFi3ACjBWktYTe3jBVndeP1dGjeUCJ9Y83cqEmVrOY=;
 b=RJjCWYIDLnDGxkc7G7kLz9SZWF86XmPG1yG3nfOOGsYEYhl8mymJKf2rQRyNcRNox78iix9PRurhq9s4pzDZrPtF4tK1b96ZQGPpGEFnbejlWGTdbK9m5ll99UeAdoVWk9QMjGm4fDN8JaY3jsPo3QBG5VrdzRAX56VMgUAB8Kc=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SA1PR04MB8885.namprd04.prod.outlook.com (2603:10b6:806:375::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 17:41:52 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 17:41:52 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Topic: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Thread-Index: AQHaIiIryDDmjYJXQUiqpuEqK4O7WA==
Date: Tue, 28 Nov 2023 17:41:52 +0000
Message-ID: <ZWYmX8Y/7Q9WMxES@x1-carbon>
References: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SA1PR04MB8885:EE_
x-ms-office365-filtering-correlation-id: e3651358-9428-46dc-97b6-08dbf0394e77
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wz2O5gTmbOxOxji6wvZSMAijZVB7nzx7CtnGl/w9i6Tl9nzlbVnb0E7nV+FM8ZUI3XJwsolMnDb2wZvtr8sAa8HwxRwjDd04a7bJrhwTzmiuLwhG2n60QfPWJlqEtkCv38QRb9ObR2MaAge//3YOuqklATyfvmH3N5ONbjFMryxEo9rHXi0uGT++T7Ey5ruTiaaprnWMMo5J9O1jd1jKfRhsdStddp8f6NOl4e1Frt8mBP1ocaqEqvTqwJndAESBluMjDQJQmQ5b9CVzMcck8+s33Ts3M891C2aKmszMLJmpHJZThwNMrgDBQEZBi8FLDp+oDcP7LkJbrw9hrs1WcOYn33c7AGu6KV7PCnD+xM12bKNslkfJwkwWq1y/r9V1d7VyFYeJ6+yr2Ccsqgtsb1eOdUAbxdkYA8hHE+Y3OoFiswW5v5Es5Kx5eka7+ET64iD+jR/mznxGwBCty1mA31yHiomHtFjoHPQVrkH/RpAd75eUC1BvPByhChlsNIHKrgbjRk1fp3ySuwQyH+zo1uuLSyx/K+KRpCYELeFzuf8wvs0v8L7qYhGYtTfV0dl+/5I9tlKz2CC+A431J7pdMUWdz3CRe4vX1O2TvcqzTtpGyQt9r7pddH9CyXbj5GnG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66946007)(38070700009)(76116006)(66556008)(64756008)(91956017)(66476007)(54906003)(82960400001)(66446008)(38100700002)(122000001)(86362001)(71200400001)(6506007)(26005)(9686003)(6512007)(6486002)(316002)(2906002)(6916009)(83380400001)(478600001)(33716001)(8936002)(4326008)(5660300002)(41300700001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fyc7NXv5n7L8OlbNPocOmirUiWoPLkzsliId6nQv3DTThMZrhIjU1NBVJajN?=
 =?us-ascii?Q?Xrm5ASRsulKm/MMG+cedmu7rnJ8mpoESmMGMwG6rYF/Gl5Mqk58ms/16JxKS?=
 =?us-ascii?Q?LnsDNCdLvC37DxqHaSLG54rBEoLMs2IZ5+NPEU27n/czaMYd0MsvQhCKlkrD?=
 =?us-ascii?Q?TYJ35z84lcti682FWFlxTXIrHKFy6UAYbR2Wplaf1w5aVpdQsiGYcm2lBzUR?=
 =?us-ascii?Q?rYRhiR/KeOLFXfH5je0hH1HYR2iafrE3Q1QW9u7HOkKtRiWO1C1/OcYqF3HZ?=
 =?us-ascii?Q?vvKo3468MOpSspRPpcgLxDhD07czIGyGwy1YgFACGdmpFNhxJnUIoIGmxR/w?=
 =?us-ascii?Q?mMS1rZXGwEeskF2MG1ZzfjP8CFrB5mIPRz09JuDOwQSOmv+/9YYKObjAR0JA?=
 =?us-ascii?Q?clCk9uWiLgpE4QalPmzmjwIi8aHpCfBIIAORZRHBVKDKyJ3/HvHBLRg8U/Jg?=
 =?us-ascii?Q?L+fEdgOhlGUxAWeBRUAdfuibLRVJ09TKq5wSIB3zoHvOzEEMdiOhUx6LW+wC?=
 =?us-ascii?Q?rrHB4j4uui8VZp7fUX47IY6T6b6IlZFcJoTAgaQeBala8yr7ChA4pf/mo9DH?=
 =?us-ascii?Q?+ggz7ZDdGQUdSStG+BHWFmzAtO3CnUk9xM6Ft0Az0KosxJwxV8SKj828c5Tv?=
 =?us-ascii?Q?N3xq8ooXkeYvGOSBu709LExwbjm6kNSGDgTC/v5jGsmoTqgkwrQSFWemg03x?=
 =?us-ascii?Q?a4rRGDhOeDNdf+D2zDurAEweD+0PDNQL1ggdUehmm/IzmvJfMeRrMyFSwdVP?=
 =?us-ascii?Q?jtgaBM/oHGVOglm2nhMQuV5KFIHnLb7GZfiUSmBxQaL1Mxg+7n6s3IrOwx6f?=
 =?us-ascii?Q?RnfNLyp+QLIrB1HtDwNxLYiPF+jCdiuXzsHOw1p/AbLM36li1kfRN98VuVlF?=
 =?us-ascii?Q?e2qnSl+bvhwy8ZkgeWpjlcLQBOV2s6DALa0440jrk3muZ7hUNrRusV3jOJje?=
 =?us-ascii?Q?2PdirRhfR458OpG4PhX2Lw3S7dBKTVFvIIv9y5pMqpo10EbqGt97CVFAugg/?=
 =?us-ascii?Q?s9dTvbilrvoKkQUXa+p92Y70PwDBNpqgY3r3KN4EzIIBkhKr5OsgPazHOpTy?=
 =?us-ascii?Q?Y3mJuahWR8ZwhN5f1NJ9b0GTiV8iWr7MX0Pcj1XJ1t4VKGk0qEwfnoyDmui8?=
 =?us-ascii?Q?iQ/LMWlHFDxvQ6vwnjCexs4J7rooCsdWowcLbKuxc/Aezz3KH+zZRJOmr3vd?=
 =?us-ascii?Q?lWIQP5GKIY2uO9uKYO/qaI6SNRUd1M/bzj/oBbuzUXp+rJcK//BSVELt2i54?=
 =?us-ascii?Q?GuMfPh/1L8kf5L7v/qmCJ6OnSaq6kyA25FhJb+75lpdSJmv0e4TrdBVfDPsi?=
 =?us-ascii?Q?fSR3djIdMNEIxArp6WX8zwykjMiuiF+EM6eGiz7aHzA6coht0phB2hlIF91f?=
 =?us-ascii?Q?P59q2YbbkXTbSmGIGM8D0sjFtP7USsKLWd9mpu2PjAmTu9f3aQC/bSL/e2fT?=
 =?us-ascii?Q?qa0+zIjFeowdx7vb6ZYMgXrQKmu7QdAAWoHo5bqnx6Ijr2GdBPU+rxLW5zv9?=
 =?us-ascii?Q?YLIVkif7F3nDKSS2vCXVDwo4679I6D5r9IfgFrOKFbU5hNa8ACSN7Rpv3DOp?=
 =?us-ascii?Q?GKwHDHIrC9qXwgjKBlO/hRFEsAImm9koObCusmLR/rOH+omZzxxeTzm5hOIw?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6AF4359A0D7BD64EB3D7D31E7D97E019@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Utd9uTD/V48wLV8L30wZtxkHCyJSvkI4w2c/Ef/gp6GybLrIGoGe2DGRCs7Xk0zfa5KWrm6gbY0T1tOeCFpDb3b8XUXtH38VGUCsX+lLeD83FKk83qr4Y4xJSOngccnG0cTnCirvESlu2SzTeZsrUMyhh83J8u/+k+ZMeekk5DBuOQNQwVq3kqFMI7RicSuF9qL8zNBPGIr/EXT/2/dmnJIc8gxp5ItHukCeAczm/ururNumF6kD8tQiqWUzq0PCYjRI0kMsanYcfqIHrZYeIybsuSkCsKHoEIo2LJ5My0mfWGJgHSE7HM09+6fLFCEhZLA8KP20i9TwJXtCpYR4JpLtKV+XWiqP8EufN17GcFvrj/JiLivcbyyY1Vx3BX3AUhkVSq1KQjwjpFxzWm789ALA7EZxTEbyMs8kO4KWC4WjGT4LxMdGiDZk8pOsGiwZPEhR+Up5/+EEkH9PemIZBYBNLJCr7RMFoyN9GxiMI3waKLsDQMIEcGo+1UwqXEXqJwOK/rjhsV5eez12pEr88wMGhnmYaPh/upZzRNTu+ALfFLNlRhp5xiM1O/IK7I2iUqEU1Iw0gpdWGlNRB8BVKL8am6i2CICGFPWtQtS6bJWoaFS7JhEfDe2KexTtm9BguJ2reBzcDMcCwHF1duBvnaQZtzZWl24DBgRIrgexBtT8b8pkAQ4zi/tyo+mhPU4oCicND0jJ6TJ/F+EqV692tDNboDSxFNEHI4PBcfjRjTiidTHhsC6+NJvhnK993tGkWkvj2d1Zb/0S+oM5lKV77zg9rvhkWZkkwhNN8uavbWpzC6D+GOmV4A6nnCHlM+OFK8MsRinU8cU8hs/IOKYG7w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3651358-9428-46dc-97b6-08dbf0394e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 17:41:52.3065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zG0se1DGfbwgM9FKfr7Lh9/ZE6li/Ktdx3WU19BCVGUXA6YrgX/VhzTwQPxHrDxfpntZ+t1Yg1bpY5djyRXT3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8885

On Mon, Nov 20, 2023 at 02:10:13PM +0530, Manivannan Sadhasivam wrote:
> The drivers for platforms requiring reference clock from the PCIe host fo=
r
> initializing their PCIe EP core, make use of the 'core_init_notifier'
> feature exposed by the DWC common code. On these platforms, access to the
> hw registers like DBI before completing the core initialization will resu=
lt
> in a whole system hang. But the current DWC EP driver tries to access DBI
> registers during dw_pcie_ep_init() without waiting for core initializatio=
n
> and it results in system hang on platforms making use of
> 'core_init_notifier' such as Tegra194 and Qcom SM8450.
>=20
> To workaround this issue, users of the above mentioned platforms have to
> maintain the dependency with the PCIe host by booting the PCIe EP after
> host boot. But this won't provide a good user experience, since PCIe EP i=
s
> _one_ of the features of those platforms and it doesn't make sense to
> delay the whole platform booting due to the PCIe dependency.
>=20
> So to fix this issue, let's move all the DBI access during
> dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_complete()
> API that gets called only after core initialization on these platforms.
> This makes sure that the DBI register accesses are skipped during
> dw_pcie_ep_init() and accessed later once the core initialization happens=
.
>=20
> For the rest of the platforms, DBI access happens as usual.
>=20
> Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Hello Mani,

I tried this patch on top of a work in progress EP driver,
which, similar to pcie-qcom-ep.c has a perst gpio as input,
and a .core_init_notifier.

What I noticed is the following every time I reboot the RC, I get:

[  604.735115] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaengin=
e' already present!
[ 1000.713582] debugfs: Directory 'a40000000.pcie_ep' with parent 'dmaengin=
e' already present!
[ 1000.714355] debugfs: File 'mf' in directory '/' already present!
[ 1000.714890] debugfs: File 'wr_ch_cnt' in directory '/' already present!
[ 1000.715476] debugfs: File 'rd_ch_cnt' in directory '/' already present!
[ 1000.716061] debugfs: Directory 'registers' with parent '/' already prese=
nt!


Also:

# ls -al /sys/class/dma/dma*/device | grep pcie
lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma=
3chan0/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma=
3chan1/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma=
3chan2/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma=
3chan3/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma=
4chan0/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma=
4chan1/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma=
4chan2/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:14 /sys/class/dma/dma=
4chan3/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma=
5chan0/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma=
5chan1/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma=
5chan2/device -> ../../../a40000000.pcie_ep
lrwxrwxrwx    1 root     root             0 Jan  1 00:16 /sys/class/dma/dma=
5chan3/device -> ../../../a40000000.pcie_ep

Adds another dmaX entry for each reboot.


I'm quite sure that you will see the same with pcie-qcom-ep.

I think that either the DWC drivers using core_init (only tegra and qcom)
need to deinit the eDMA in their assert_perst() function, or this patch
needs to deinit the eDMA before initializing it.


A problem with the current code, if you do NOT have this patch, which I ass=
ume
is also problem on pcie-qcom-ep, is that since assert_perst() function perf=
orms
a core reset, all the eDMA setting written in the dbi by the eDMA driver wi=
ll be
cleared, so a PERST assert + deassert by the RC will wipe the eDMA settings=
.
Hopefully, this will no longer be a problem after this patch has been merge=
d.


Kind regards,
Niklas=

