Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981E572B885
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 09:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjFLHTT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFLHTS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 03:19:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CFF19B1;
        Mon, 12 Jun 2023 00:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qiu5Px8O3H2dc5kUt6GlGZXqafFbqbD1mhg8ZenH/IUhXXAuid/CtXQStMNUr4WN+r98cZMpb6e3hyQwm9nXp5evhb9Xqjy1SoS2VmZlujYFuuE0GWtQwYuOD6T7ITborp+M41oQ7vEMRnvmttdDMxe6/E3AcfVEUnOHHVWepDIdozOr8c7+NVduUQlbREEGbyMm/SXhgJOQcZonYMXt+Y7HuDa4DOFrzw9TrI01gMxR/TLkmQVGxJfqtRTJg0FwvEhTtt3O80pe6zJ6Psm1ox/mtoQYKn1z2nZXz7vaKb/oxIWRzlu3zCPke5MorTWjTh2sVboUs3UmX0iEE6sKXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbcwqmDv3skodkRl+W5jHLBina4Ut+FhTKwGR+RVfYo=;
 b=PeZb95BIhB38C+cIylPxtIN1trqBP/llfFKqp1sXCob9o7+HPbVZuhdTrlmBLyD6/juMBamn+8IVzDF7rj9gwtM2H6dm0j8Sd82m+1vambkt3V/VmbgWJooywyL/WZ0RpPY3Q8j11syqt5TcSfMHjzUFFlFThmwNT8PBojVrZ/OG6Yq3Coa7cTS0MmP6vd6LUtQOBybRdLnGFblX/8LV68EExgGCVBZbr0nHKo3DR71Pp8lVO2VNlIYZT6crQRL183lNf1sxm3Fi0V7lSfW4OOr3jJkFz0Q4kVvhVTQHvenKj4/GxddO495kIX9KxLn3BYKNosxDmVByNjBRy72JRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbcwqmDv3skodkRl+W5jHLBina4Ut+FhTKwGR+RVfYo=;
 b=KqSGRIlXWGZmtDSR43EtwRaGgqAEEbl2vl6UU2ongW746yEuH1EkxbxBmont1ylqv0S4s2Nzw5JkopRqHcMjIs1RsscUzQYFFDPv0BsLjCfXCWQ1Pm2/HfESbZSKuN5BagPi5JMvmpIjFiZLof0u0eNGry58p2SeEdu38o1UHYY=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 06:56:53 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::1909:e379:a444:39ec]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::1909:e379:a444:39ec%3]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 06:56:52 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
Subject: RE: [PATCH v4 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH v4 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZk5tePph5nYWpdUq6vG3IWaiZ1K90nt0AgA1V0QA=
Date:   Mon, 12 Jun 2023 06:56:52 +0000
Message-ID: <SN7PR12MB7201F3C89AFB711A871BDA198B54A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230531083825.985584-4-thippeswamy.havalige@amd.com>
 <ZHd/7AaLaGyr1jNA@bhelgaas>
In-Reply-To: <ZHd/7AaLaGyr1jNA@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM4PR12MB7525:EE_
x-ms-office365-filtering-correlation-id: f6c05135-9e07-4c3b-6c13-08db6b1233e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FgQ3gaScCKkalmz8DNjzDySlQqveP8HHp9osSQRCWg66cGgvn/VrudwzPUJKevJgLtEjd0tyVR+KNx1uajaIPLeMvjehrTe3TJy968Cu40dSCkglLw6tALr01KnC6YaxlveCz6rE8kxBCo14Gz6ZDfyKFcGZpk2QngBQJCyh/6b7AevMYIM89J2hKGO0vp+YVJZHQdiNagw9TF8dfSs9fzgTMSVl4UeDcRwtJZKySkmGecJpL8ZEk89Sw1qx76E9PI5L2VWWhEx/Pvu8zsU37UMiK2+mvcUI+XwWCkIca3OAv/lQHpeuUL8ZRvCgHml6Dl4bNYZDgneHhwuywbFZMmitenCzOxIJX1yuYeUhNGWRblDH882sAHH5PGk6vXDPkcXLjaqqt6NeJqSr0a3svtfy1vMpmGf3BueR4Xly+pzBZFVzkBJ3ZAu1qi/dVotz4q6BKGLJFkaM4iaz67QufKuuNKzwQmNyeDWfbDcFK+LEo2fv8huPRuZ4UQK5M1UElZCBn/sE1J45cEvvFIAiiW+V2XmC3n4TgIG41dxJFlkTvpa+TeViDKB/u/yyvSIPcKV/3WZhJc8FzRV6BXP7LbpnWhywWwOT5e1H6soxpafKsEYXzs8f1MTs9urFkvE+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(66556008)(66476007)(66446008)(66946007)(316002)(71200400001)(64756008)(76116006)(6916009)(478600001)(4326008)(54906003)(38070700005)(33656002)(86362001)(9686003)(6506007)(26005)(186003)(83380400001)(41300700001)(5660300002)(8936002)(8676002)(2906002)(52536014)(7696005)(55016003)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i2qYfsySmOIsm9+emHKIRM8A7d40SE60Uh8uKsI8S7e6SEnm19oHzCKMc350?=
 =?us-ascii?Q?yOvqm/vRt+ugC9EkqzSeV3XnzAZ+aLFq/ir+OrxjmBmGJyfZ28+EhfdMilqd?=
 =?us-ascii?Q?GI0UG7P3BKsnVxHAIb2Kigbfwl/bCxhlyq9Nty1A0llmt+PGl5PwFwxAdtaL?=
 =?us-ascii?Q?wA6/KwAUQ4nJ/aa6sk4zg9MjSjb6KIhcdZ3efRTCtxTDqMHepqQ8B+OltMTu?=
 =?us-ascii?Q?hpcj0lBOCUE2OMnDhrpvjz7Esdk0b/JxPw9m2EVb5irU9gyE+gdUr2uLPecL?=
 =?us-ascii?Q?Y7PoVwqGFUgIfJf82wuBHA1c0HUku4r0ZEHFhcvxszEvC4o2SF60GmeJXkvF?=
 =?us-ascii?Q?QG3sTLEuQviOzfTdcdrzjroyaHOzSfel7z85RLsF7yohl3GK4ZsXtBr6cInk?=
 =?us-ascii?Q?3JP7iSBrdjIEwn90TJD29HocjiLiREy7IJD6DfkSCAvm7+OL7enzglQbnodf?=
 =?us-ascii?Q?eZ3fBqxdCNm13NzzskPbLXOmj4bGAgFxRB2E3g0yoC9W6/2ATDLXROtvV+Aa?=
 =?us-ascii?Q?iYOmz7GluDeGOFetfXEEkOD97m7kaH5KmfBMm2AXaaXtb2nRMxGzcFSNJSSB?=
 =?us-ascii?Q?iKOBrIUu1QWa5R6xffmmO/p15WUiVtmq1cyrMMGw65qpx4K1z5H2tfFS3WR9?=
 =?us-ascii?Q?Ber81zVHqjoAhPYbltyam+VPzVwQhcfMr7619taXq/ZJl6eTR05l3siodqP3?=
 =?us-ascii?Q?H14VOoQSLVFFEIbr/SsNk+9CWiqWHQVbeESFAo1uPHMKOfV7Ar85AghYRbcm?=
 =?us-ascii?Q?KJ9AgljmS/izb9Zlc3dxe2po5VoN8Ld1VIU/iLdZfSortoKwKl3JEDC+CoDd?=
 =?us-ascii?Q?sbgM59QwOzerGXhP0/J3ajRjxqpaCz3Ksf9OlmN9x0WzfBJTJFCdNoMWYS/s?=
 =?us-ascii?Q?iuSApd+x8+vgs0nG+ovSMroU8BXuQ3Prp8SNihd3UlqsJuyxWZ3Q9inFgp6k?=
 =?us-ascii?Q?jCt3iqtIBbtYc7f+0eNG0c52liBL1fXT1W5opfNnAj2RvOnspRD1MDurhBNf?=
 =?us-ascii?Q?NiUqrU6MaudYbXGHcoRq2rwPVimzy5Q/hw7ZUWdO4HC94n0sHjJ/5F7sopqo?=
 =?us-ascii?Q?Vai4UcfAlF81WJUYjwqKxWII/6+j7CpVd6c7jXM2xz9Bddat5OBhBaOtqvkS?=
 =?us-ascii?Q?hYyWuM/60ADaEmpNZ8+MnixO6lbJCk7v0Zyp6uDNIFw/mcDetENkXbzxBfyv?=
 =?us-ascii?Q?ySyVYmsGpjaisdZyVLr3VPWnMhmeyUGugMBaZDFsON33lw1orghe3Q0dLnAi?=
 =?us-ascii?Q?F4Pz+T99fgUvQ79tGcsrU9lDB+KOA3UrrDL9D86XgPx4bHYT5JxmOSqAWTq5?=
 =?us-ascii?Q?s4/QevSDYYoolSpeeocj191fU3t6lk9EsvFAcltvnHjyhrx/HryE5QbYbdT5?=
 =?us-ascii?Q?pY4J+gfKK0AH/QapnW9KJI07Kak6VWnlIVym6cueDlxITEqPgQz8wSoCXTrQ?=
 =?us-ascii?Q?lyl28BpKJ4QvYijAMGMmIRruhrz+6+Mtn+H03f8FWLBoIg7uhewQbvnlYF2f?=
 =?us-ascii?Q?ngt79ApD0Hk897oJHgNIqITWw4CgMZG83zx/N4Dc+YIPLhxY50Sl3jxAsILK?=
 =?us-ascii?Q?x0Zb66zQIpJS2kdA1e4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c05135-9e07-4c3b-6c13-08db6b1233e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 06:56:52.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYCE3B+j73ixJ7rUUnQyAM0igfcJicn1kCK56RNM4PN7Rs5YXNDpZuhr0mBOyD57SZJrYvogCRFpM6BZiWAsMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> > +	  bridge DMA as soft IP say Y; if you are not sure, say N.
>=20
> s/is an soft/is soft/
> s/xilinx/Xilinx/
- Agreed, Will fix it in next patch.=20
> > +#define XILINX_PCIE_DMA_REG_IMR			0x0000013c
> > +#define XILINX_PCIE_DMA_REG_MSIBASE1		0x0000014c
> > +#define XILINX_PCIE_DMA_REG_MSI_HI_MASK		0x0000017c
> > ...
> > +#define XILINX_PCIE_DMA_IMR_ALL_MASK	0x0FF30FE9
> > +#define XILINX_PCIE_DMA_IDR_ALL_MASK	0xFFFFFFFF
>=20
> Pick upper-case hex or lower-case hex and use it consistently.
- Agreed, will fix it in next patch.
> > +static inline bool xilinx_pl_dma_pcie_linkup(struct pl_dma_pcie
> > +*port)
>=20
> Name this *_pcie_link_up() (not *_pcie_linkup()) to match other drivers.
- Agreed, Will fix it in next patch.
> > +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus,
> > +unsigned int devfn) {
> > +	struct pl_dma_pcie *port =3D bus->sysdata;
> > +
> > +	/* Check if link is up when trying to access downstream ports */
> > +	if (!pci_is_root_bus(bus)) {
> > +		if (!xilinx_pl_dma_pcie_linkup(port))
> > +			return false;
> > +	} else if (devfn > 0)
> > +		/* Only one device down on each root port */
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
> > +						unsigned int devfn, int where)
> > +{
> > +	struct pl_dma_pcie *port =3D bus->sysdata;
> > +
> > +	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
> > +		return NULL;
>=20
> Checking whether the link is up is racy because the link may be up, so
> xilinx_pl_dma_pcie_valid_device() returns true, then the link may go down
> before the read below.
>=20
> What happens then?  If it's an error that you can recover from, it would
> better to skip the link up check and just handle the error.
- When link is down CPU stalls after RC Enumeration where it tries to send =
PIO requests to EP and waits for its acknowledgement. Hence we need link up=
 check atleast boot successfully and show RootPort device in lspci. We will=
 add comments in the above function describe the race condition.

> > +	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn,
> where);
> > +}
>=20
> > +	/*set the Bridge enable bit */
>=20
>   /* Set ... */ (add space before "Set" and capitalize it)
>=20
> Bjorn

Regards,
Thippeswamy H=20
