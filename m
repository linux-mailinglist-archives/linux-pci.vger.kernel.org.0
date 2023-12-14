Return-Path: <linux-pci+bounces-1020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8B5813CC6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 22:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8991C21D08
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66BF20FD;
	Thu, 14 Dec 2023 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L62w8hwZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ik2/VCrJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196346DD12
	for <linux-pci@vger.kernel.org>; Thu, 14 Dec 2023 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702590027; x=1734126027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OPQh88ZoaUZfYgdW8De9Q0ub432NnAB1pVClNy1aa+E=;
  b=L62w8hwZ0CALfKAi/sVkHZSDR52LCaZzFoa5cf6l7eNMXJc2c+8gIf32
   QcnYrs5nv0H6y4wKlo2wAD3xMZG4Z0XH1kPgiF2EDAu2DivCI/wmaXiaQ
   z29AFW+rNGLl8GuN9vmrL3FrB8ZlQIRaCAjCDTYaFsiZ1rOrdMNceU6K2
   0+pb9safRB4VmtiDcY4Y0PcsPXd77m1uvzTO9jeggZCT16k+OHM2RCn4C
   kesMxrm94Yq4Wl4i3SSPiJaa3Re/tNt2JBsrTZcOTpuURZzKdw8YJ8VQ1
   7vdSlSDyhpy0jxKvVvCNs/S/+ACd3GmXUqicLt1UmN97F/c5yKkbDYV6m
   g==;
X-CSE-ConnectionGUID: 4OXNOvLiSoaht1XdBC1xtw==
X-CSE-MsgGUID: 6kZ8U1uPQB2u7itPVKIaZQ==
X-IronPort-AV: E=Sophos;i="6.04,276,1695657600"; 
   d="scan'208";a="5182515"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2023 05:39:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTxTuc76Ymjt8ZbaimsPjWptqvzitXxJ32UIXPnD5nWZTLYh5Zf79ONBsgpEiThY9dhDQnHcVbgPD6ukGoBAVWb4QSWV4G9qauSD0ueuMpdm+QsaxqpItvj4aB/SfeizVmkJeBdn9S7Xwmnw7pbS4WXHZQJk+JzuHa1ph4qA1oLwYfIy94PIUJMc7MbKZqpf5EFjJzaUZ1Z4HRg8X1u5nDkBLSspuzfAnnOntGun5Agln0vC5yQ90m73YvP9BSypBfB15p8mKwxvAE6+b/h/YZ0iEPgq2APw5OY8g4Kr8X1n17/PoAQcMtcITmASKkIrAyDNcn4YbHUXSoZbsGN7MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rikghlTjTMhca4JJcc+r89UpbDeGx0T5sl6cwI5mkXU=;
 b=Q12737ufcmstDlu1lxRTtTPeh8+mtKffoYYkqhD4v5Y5rp9pAijDIIcnth3b/Me6+AUPZAAsm/hrcdSSQ2wiwFQfJpFSg72VpBj29ys30oVvOtz+nbNQlELmvhTmpDUKNf2zENMYq8bMc0+DVLS/7Kuyxhm1pQGrkCddOzVsGr2N/0gNnm1nLODnOyT9ZGDuDtGTAWygNGejLhnN4pExG9MCieK4u2Dr7gb9ug2ku9PsNzDtpZ85hMFxgf0bsn7Ogfyv4/5PdU+/1J1IxG+aRdHISlMh7CW1eahHERzwEY+kDhnN3Z5MpEyyfaR+CIM3OdoTJY6MHn8uytB3rfYiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rikghlTjTMhca4JJcc+r89UpbDeGx0T5sl6cwI5mkXU=;
 b=ik2/VCrJff7gQNiDB08g0AQu5aZcf95rDHc9kryuC9OBj0jR2nHCp2YRSaJeMXzmO112BVoHC4m18RqzAEgo21IQiBQzMr2uy2C/cC3YlU7DL+gWXsOIV0FswtGhFt96EtAO5g5c8MSBhhI/scO4+35rBPCwNTYWQswBZ1wk8vA=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DM6PR04MB6473.namprd04.prod.outlook.com (2603:10b6:5:1ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 21:39:15 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 21:39:15 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Frank Li <Frank.li@nxp.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Vidya Sagar
	<vidyas@nvidia.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
	"kishon@ti.com" <kishon@ti.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "kw@linux.com" <kw@linux.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"lznuaa@gmail.com" <lznuaa@gmail.com>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com"
	<allenbh@gmail.com>, "linux-ntb@googlegroups.com"
	<linux-ntb@googlegroups.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar() update
 inbound map address
Thread-Topic: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar()
 update inbound map address
Thread-Index: AQHaLpoq6KpaLC8u+Emi7PiHDdomg7Co5ImAgABU+gCAAAhAgIAADQCA
Date: Thu, 14 Dec 2023 21:39:15 +0000
Message-ID: <ZXt2A+Fusfz3luQV@x1-carbon>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com> <ZXsRp+Lzg3x/nhk3@x1-carbon>
 <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810> <ZXtkMC1ZjsgHMRvT@x1-carbon>
 <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
In-Reply-To: <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DM6PR04MB6473:EE_
x-ms-office365-filtering-correlation-id: 3f605947-5bab-44da-d3c1-08dbfced1ee1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lccMPt5Luw7h5DkxLqiweMB0RWb/gtmoNItQLF9YAqe+9HKW707vGkxyQR/2uxxh9NxYVwDtYJWoMK+4690QPZ4en9PsW/ZRXzJGfkpvCx0ajcRO9o6Ez8VR3SgW+jg749yo7ygJ8gzOtpbLbOboXLEnFGve5T/QFMk1tSw20lqiELaFMg+EmLCWpYXah902N3Q2JH1gU9ziI5hE6Rv7e+k+MMnofk6jZei9BrxjPgFmDhDBlKpVrDrPR/1zqtTCwvLoHfGU/ZcafRu/7dNbjxqCQGpxWnUOuyiKNp3byzOyH/i3z2RuYGGR0WI/mmiBMyOB0K7whqwPdWKAKethcPiWwsa6sSof8pQSDj7Irb2svTqSIM22Se/w4THM/RqJrWrphyOcJLwn1wOp/pZ2yxTNxuJx/VmHf64NmmzMC7XEMvcOus/oYOOKarrRW2PCAvjwU3+ZskenUncXqRL8pcXFddmlKDx6jo0EXMn+CAX9wtCY8z6hQzvHNF+v6vEyfydnZBW/KxuD+9BVmUZlB4w0rBrBAiPZbvyaWquzi6PQKA5Vr2kw8QIlwNX/vT5FkyXV0R6hqNOL8UYL3TuwbXpOcZ36XjhIvLVQitxVT9RsFePjpQ2f/zEr/WCHWMGqf5p0v9awTEOLgu8mro+rRQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(83380400001)(6506007)(71200400001)(6512007)(5660300002)(9686003)(7416002)(15650500001)(6486002)(2906002)(41300700001)(33716001)(478600001)(316002)(8676002)(8936002)(91956017)(4326008)(76116006)(6916009)(64756008)(66946007)(66446008)(66556008)(54906003)(66476007)(82960400001)(86362001)(38100700002)(122000001)(38070700009)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aUsIepPQdkH/iNIkfgduns0jfpxhmkjwSjVPHHsmoUGESTNs+9axFOQa3/bI?=
 =?us-ascii?Q?fCcWRPCQ0bVplzQoVUy+cXAS3OfyuxoGWfDI3uruABNzaOBxKPe8S37Bjg2C?=
 =?us-ascii?Q?dUCBime+flIbU3fpQfZuFdXYjJtaxvSBLNUG3RyHqeW82sM8de5vIUt4JQTG?=
 =?us-ascii?Q?2zAMO3+pVDc6ZLHU4RuzpymUcv+ccbM4RnxQrXpWwRLUNmeOC3Jdx38iFTCk?=
 =?us-ascii?Q?CEMPOtwGdjAmExlLHih7mgS94ctlS0d63INpQMpkMZ6WUFwa/TouP90/3N4J?=
 =?us-ascii?Q?/yrilaxx1xg5gDkM5wH75fVA1TDqhziIEl1mBuOa3Rm79rzK+CGjOAtbS5EW?=
 =?us-ascii?Q?j7ym/VR9jQtMA7EMNJ8B1yrZOkdxqvomr3zvDTKV2eJrbGNP08QCyMkKFJQe?=
 =?us-ascii?Q?3+gcnJsBoWdhsDdugItxF2ohkvQE+sH0aGZvE86CiPz1+ZtRdB9Vx0jK/lHK?=
 =?us-ascii?Q?hFy58FxMb+wbyKFewJtjG4+XwoaCXQYNpXA5LmpYjZBsYV0UJh/tglNKbF1Z?=
 =?us-ascii?Q?gIxbJGyqEnagFec7SJi+oaLXPzDPzWLnRfDs815xcjkJWWye0hn7SWJdghsU?=
 =?us-ascii?Q?7Dh9nWmrs2BG9BEYAi2DKVK6AvYaoBtjxPPFeJLzyGG5NJfDHJUat83A8aOk?=
 =?us-ascii?Q?tK1hctINbfakSxnIQerHEg3cK+8yt7xBNXeqdNpk7AovsVzwulN93fRBZBri?=
 =?us-ascii?Q?e8X6iGThnkHdRYFQcWw4CZQV12YR9K+Yitt518JkByWY8rpeD9guxqon/HcY?=
 =?us-ascii?Q?tBX+qMenT4ISCCJ8tNz/wnDAeVurfi3e8SWQ3S9MlsjKkMgLABniC+Z+Dgqo?=
 =?us-ascii?Q?MuUo7XdaQkHvYc2fYmONjXhif3Y3CJ87D5hk6TIl2xfTsQoUfSixNJoROH9w?=
 =?us-ascii?Q?bcTRKWchrDdCUlfYsgrEbRz+XdSaWxm0uhBE66lzKSov4KmClV+O9GliGwaK?=
 =?us-ascii?Q?zJdRj4Ew+5Dtn4DAoZLql8EM6ZISf9ApTMpA12MCMTnUqLirg9Sq6iSZUkRX?=
 =?us-ascii?Q?RnbIkdr0YFfNxMuN0EMgeCZDMC1LGxh+HrVOf8ho4GgrUdHBlpUai6uwnBc0?=
 =?us-ascii?Q?Sw3+wiVWe/PPJdEicRIgDeqczxHwjXHw657MrhlPrimASB4VmSwPfQkofHrp?=
 =?us-ascii?Q?p2vWd+/zy1Cbm4CaVMi7NbuNAmVrFtz3uN6b0MC+tsBtUejvdng3+ysjtD0K?=
 =?us-ascii?Q?CnUNJT6HnZUEzDPMBh2RXCAZ9OliqF42Q5GuFDIOQMa5/+qpvYFBXZnzA4AM?=
 =?us-ascii?Q?AFsecVOoOUI9V9jodc0lr1PYq+mYQDfApATbaIXZf0bWMzT2TPvL4RvTjUxC?=
 =?us-ascii?Q?ICnbsEE9Dp4FN474wt7l3StyinhtraxyclGacT3/8N1zbhduD28p6N4ufUS4?=
 =?us-ascii?Q?1sR2ZV1Swcz18S9gSj0I+QxlCJv8ESNLdyb/+dKu867SOEO1+dUMwJMLqtVw?=
 =?us-ascii?Q?+haDNoz25Pdu7KtLalGKbcJ3eO8vj3OoBQEW9unIwLb8L0oDasSpcLvt6VHU?=
 =?us-ascii?Q?VsEyQ7AVw8q32vYeF2di3TAZMiaMPtueR4/+TG4GOFDvaSaRiWg9Isw1XCQ4?=
 =?us-ascii?Q?mtC8Qx/T3vLzHri1Q4Gph+M45z14a0JhAYJ4kgTV272Hkm4qquv4yulVsCSe?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2E6E0D1C7364C741988F0C3EFE174C6F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AdDZ6xELUuc3UMfqvDKb6VrbK6TcKnoOMXeNnZoHpfQSxhy/JAuAmxlJ5NO5ooCZbJcO3xzY0eWfNUfrmxeY8Jt8cIuSr78BOj7NB0L+pwRp0KU3VX2TJDPSngKWozB9UkQswEPdu5W+2vdvgV4SPYL75NApMpXZLhTF4YTqN1Ke4ABOEMnhmaudG28N7whngRb6549GRk6n8z6Axxc50Ya+O5Ok8NzSzx7Krut7A8ySM++7RizwBgbCtytKpzm7F2o4EPHCKHOuCjemLtF56T0F6jRqYOpshhsW7C+DEjDcOQjqiH3oBbk3VPlVWm+lMQrxvgBnLB+SFgkINmX5R3w0wzpge7h0Wf6VUsJqG+MXTB5KJjwBP+ee3Fehdr+g0AcpyfMPyNPoNYzLH6v5tKyIzMAJlfb12KHDzo3xrlI3S0mZ/HbPqvJLG4jH18NL/gJ+CMORiWxSn8QV5cP1A3b9zk/iC0j517ig+nSfuL6E9nntyp9659g6Cio1oGyAfsOqxMpa7iKIyoQ20PoyDHPmK1wgA0yPiq8MCdSSF4TktlbvdCVfGvAU2+qCthlr0ASjCwH0WbQAh2UFQqplKq2bqkwWZBc/PmTbE9IxRfGudt25RdXLMEMDIoavn61d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f605947-5bab-44da-d3c1-08dbfced1ee1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 21:39:15.8308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCbio9vBOZ4OUR9ao2y2xC/1eHjOFxa3iR38faAHjTb/Wu69rKXHspL1A7unWyr7cDYb5aeYFGGa0EbncfDmpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6473

On Thu, Dec 14, 2023 at 03:52:43PM -0500, Frank Li wrote:
> On Thu, Dec 14, 2023 at 08:23:14PM +0000, Niklas Cassel wrote:
> > On Thu, Dec 14, 2023 at 10:19:03AM -0500, Frank Li wrote:
> > > On Thu, Dec 14, 2023 at 02:31:04PM +0000, Niklas Cassel wrote:
> > > > Hello Frank,
> > > >=20
> > > > On Tue, Feb 22, 2022 at 10:23:52AM -0600, Frank Li wrote:
> > > > > ntb_mw_set_trans() will set memory map window after endpoint func=
tion
> > > > > driver bind. The inbound map address need be updated dynamically =
when
> > > > > using NTB by PCIe Root Port and PCIe Endpoint connection.
> > > > >=20
> > > > > Checking if iatu already assigned to the BAR, if yes, using assig=
ned iatu
> > > > > number to update inbound address map and skip set BAR's register.
> > > > >=20
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >=20
> > > > > Change from V1:
> > > > >  - improve commit message
> > > > >=20
> > > > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++++++-
> > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/dr=
ivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > index 998b698f40858..cad5d9ea7cc6c 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > > @@ -161,7 +161,11 @@ static int dw_pcie_ep_inbound_atu(struct dw_=
pcie_ep *ep, u8 func_no,
> > > > >  	u32 free_win;
> > > > >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > > > =20
> > > > > -	free_win =3D find_first_zero_bit(ep->ib_window_map, pci->num_ib=
_windows);
> > > >=20
> > > > find_first_zero_bit() can return 0, representing bit 0,
> > > > which is a perfectly valid return value.
> > > >=20
> > > > > +	if (!ep->bar_to_atu[bar])
> > > >=20
> > > > so this check is not correct.
> > > >=20
> > >=20
> > > Please sent out your fixed patch. If want to me fix it, please tell m=
e
> > > reproduce steps.
> >=20
> > Reproduce steps are simple:
> > 1) Add debug messages to dw_pcie_ep_inbound_atu() to see the iATU index=
 for
> > each BAR.
> > 2) Boot an EP platform with a core_init_notifier.
> > 3) Boot the RC.
> > 4) Reboot the RC, which will assert + deassert PERST, and will call
> >    pci_epc_init_notify(), which will call .core_init (pci_epf_test_core=
_init())
> >    which will set the BARs.
> >=20
> >=20
> > In step 3) BAR0 will use iATU0.
> >=20
> > In step 4) BAR0 will use iATU6 instead of iATU0.
> > There is no reason for this, as it should really reuse the same
> > iATU index as before, just like all the other BARs do.
> > (This is because of find_first_zero_bit() misusage.)
> >=20
> >=20
> > I could send out my patch, but from inspecting the code, it looks like:
> >=20
> > > > > + if (ep->epf_bar[bar])
> > > > > +         return 0;
>=20
> I checked current code.=20
>=20
> dw_pcie_ep_inbound_atu()
> {
>  	if (!ep->bar_to_atu[bar])                                              =
                    =20
>                 free_win =3D find_first_zero_bit(ep->ib_window_map, pci->=
num_ib_windows);            =20
>         else                                                             =
                          =20
>                 free_win =3D ep->bar_to_atu[bar];=20
> }
>=20
> I missed conside '0' is validate windows number. I think we should init
> bar_to_atu to -1.=20
>=20
> 	if (ep->bar_to_atu[bar] < 0)
>=20
>=20
> Origial change want dw_pcie_ep_inbound_atu() can be call twice to update
> bar map address. vntb use "bar3" as memory map windows, so have not trigg=
er
> this problem.

Feel free to send out a patch, I just wanted to inform people about the
problem.


I can understand that the point of the patch in $subject was to re-use the
exact same iATU for a specific BAR, however, does the change:

if (ep->epf_bar[bar])
	return 0;

to dw_pcie_ep_set_bar(), really provide any value?

I guess it will avoid clearing the BAR_REG, if the RC has assigned an
PCI address to that BAR, which I guess was important for vntb?

If so, I don't see any alternative but to let DWC drivers with a
core_init_notifier to call dw_pcie_ep_clear_bar() when asserting perst,
or to modify dw_pcie_ep_init_notify() to call dw_pcie_ep_clear_bar().


Kind regards,
Niklas=

