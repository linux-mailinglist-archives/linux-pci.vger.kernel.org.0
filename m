Return-Path: <linux-pci+bounces-1927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA682864D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 13:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635E21F249A0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9D381D1;
	Tue,  9 Jan 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iEeRYgKH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rLMumdkx"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBAF381CF
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704804757; x=1736340757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yo58s9uRaOvYYmadbXeXBj7gp3orj8jA3ofKh1qSFvk=;
  b=iEeRYgKHoBucJawda14lz/YEPqIw4wijUrn2foohOE3sY8o4vZP+Hjzd
   +qK/kqWSonmBxxCBy1uoscKp5qgjZ5MzHZxsqnQ4V7k2LqKHBZd0F3He9
   Zc6++NzKVxqPDtDgh6UGT/vK0OWsGb0MidKDYPSHFb4FXvLQw3Pys3G8E
   +jQ4cX7JCHvrdm1WEMxRbbZP3+Jj5Hq4apsOMwLyTYwkYWIlMB4QSE4Uw
   vR8k8Z/Qfgk7WtouOPXBXvL+8zuBne8TKKm5jzrhmb3BukhQdhXFaA+ci
   8zmt/b6Afff3zLDBHre8lppiWJw+71RvBEjYE1EUcE4bZSqWERQWqXX6x
   g==;
X-CSE-ConnectionGUID: CorWiRfOQH+4/6keOFyT6Q==
X-CSE-MsgGUID: u2MgbT2oT2am4s5vCl4YiQ==
X-IronPort-AV: E=Sophos;i="6.04,182,1695657600"; 
   d="scan'208";a="6697069"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2024 20:52:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB3fPsCN/Wq7VqZMHoJqZUGvT4CwDhPryT7/6XWnhaEKi2E9arzFEF4/EU15Jvo01qZWt9esxk7escQ18yprj6DxSGafcwVv7cybBFrbhpe5rKMU+JEeZVOgnIEhHsVQkhgYFEC19G/QFYM4M7C/5ykYiOnwYXswDISbcWMx2ryOtJxiBjGR7zY/7mP/SonXJhZlmep124doZ1dUT/H9ZDYIM4Y5yWYZ65RDEZ66OzEJ3Ce6bcOHO+hsDm1DHANPHbzaLkRWCismHw9IUWdF/lh3pZFaEHECq+MGpAXigyJN0EjaaVbEwLRN28btHhg8JI3yytjIr5qZy1uWSwSAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3gYY0pq6RXJ3qDwnhu7nzrmq/+RkyNITRIygRfre+k=;
 b=Es6iu3oZA90Nzf0wY8eyfZJDua3ZLgMr4A6rwrHFX4lRz/L3a0JbEvqXNpvNPK/tG8FdGVyqbFnatG4847G8VY6fZ2S6spi59sEKHEhhZ2pxIKJSkCY7lvGsN4T+TlrLj7i2S7sqKDXuizqw7LXIzapZyobi5EUd7c0t03SDL05Wo0E1faaVuM5xLK2S6ci+sXtSlaJYMbr3LGJY9f4gwqvo0rSTQlnQ/K0OPwC+6bOXg6QHT01NI97sAgQGf8T54jnpOC2itvC6YrDfH9qmUOZVJ0K9o8dY+8HHKoB/qDb5LXIcdIVfLcpSxZ62VkN+Q4csAZlZKlVRKvk+dxGuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3gYY0pq6RXJ3qDwnhu7nzrmq/+RkyNITRIygRfre+k=;
 b=rLMumdkxKANTB7iQ9z7TKDAgCMDJ7K7RqLuPkqsOO3yokXWqA92FVqrGkpVeiHgj14f/RkKDW2K039D/L0IX2GK9qUkzCHWW6/YW7adFqOOKwN/A1IDX9c5Rb87GPz+FH2rIi7wFRWFc7IXa0GSj2UkJ0XwR9K8a71aIaQB3RBo=
Received: from BL0PR04MB4850.namprd04.prod.outlook.com (2603:10b6:208:5f::14)
 by BN8PR04MB6273.namprd04.prod.outlook.com (2603:10b6:408:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Tue, 9 Jan
 2024 12:52:25 +0000
Received: from BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa]) by BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 12:52:25 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Kishon Vijay Abraham I <kvijayab@amd.com>
CC: Niklas Cassel <nks@flawful.org>, Bjorn Helgaas <helgaas@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Kishon Vijay Abraham
 I <kishon@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Thread-Topic: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Thread-Index: AQHaIf4kudBIhbseTk2Bjk5ALRJekbC8TpIAgADlL4CACp1ugIAJ4DWA
Date: Tue, 9 Jan 2024 12:52:24 +0000
Message-ID: <ZZ1Bh4pnxTVcVGly@x1-carbon>
References: <20231128132231.2221614-1-nks@flawful.org>
 <20231226221714.GA1468266@bhelgaas> <ZYwRK2Vh5PLRcrQo@x1-carbon>
 <9b6360d7-8880-f522-b368-3ca3b1694cd3@amd.com>
In-Reply-To: <9b6360d7-8880-f522-b368-3ca3b1694cd3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB4850:EE_|BN8PR04MB6273:EE_
x-ms-office365-filtering-correlation-id: 6d2d810d-cec4-4de3-9e3d-08dc1111d41f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NB2W8FYu031dRNFfkuiO/2creQOzlgy07j9Hq3HV3KQBPVyw09NmTf7psYFMr1LUEpvIgBVxQxAR3Z8ef47lnP5TUnJhZZYJjdn5hzrYbfXxP7YOZD/h4aMX4ng2JhxtK+2Hrzg4IlPuTUnxN5jN2AjYnj75rdpCDLUoqLvS9v2FLK6sPrSS3YOqp47akmX8Ma6zJB9h9le689R2Ol9XzQv2Q+udCQRJtQwboXO+8TQeufDqTxjQ+aOND7kDxy0n9uwlew1l1obBM30PmPi03xscGyuh3ygZMint2AJyldLKtO7HyocTCulrKDFpdCkaRGphwqUqQb8dCHpMtpPUY3CFfz0aGRW5aY2zO6WbcOI2913uetQM3ixv9YFOXP2xH2sSmso3jQedAfBST+TYt/bxE8wFA3sVSr/T15jILNX6n/bT04piDRPvY7W292SeNYmxC+SoveFg6ci+bzKIZ2wvnAJ4MffwDaP1pcqkrLcSkMm4YxZIqiiPNWadg5hSsKaS8MOFwAfbNEfrx4Yc4i51HGKaIHXKuDHRBsTGlkVjGugEq/i7RrPo/kd9FNU44DHNqRr4JtwHV4RvxHQ8mC81hb6eOKTCuKUdQ4PqeFo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB4850.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2906002)(478600001)(966005)(5660300002)(7416002)(4326008)(38070700009)(82960400001)(91956017)(41300700001)(66556008)(66946007)(76116006)(66476007)(66446008)(6916009)(64756008)(54906003)(316002)(8936002)(6486002)(71200400001)(6512007)(6506007)(9686003)(8676002)(33716001)(86362001)(26005)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?785DRjsX3bTEOl/TqXo9z4oBOjHT32MalcwzbTThIAOgwB1tG9SI7uRWq+?=
 =?iso-8859-2?Q?J+8JP4VuRC2p1xB4JRVa1OQJAddDl9I5sSg4O5kbRjXgrYTjHG0qxibh9r?=
 =?iso-8859-2?Q?J2WdSPQfWVEaP3bB6Anxgva1FcZp3yWeCcYIppOuHv1qSRyIxuHqQcweBI?=
 =?iso-8859-2?Q?dkpX919Se3C13/X9AzorzqtU4EwdctJIPAL2X3A1eqY3ULuF2XIVIEnQJ1?=
 =?iso-8859-2?Q?JptBFEJ2xEzQSbX0+lJTTvJcGp1BT/ihN5+PqMFD5y7T7KOXwsnYZqPiuD?=
 =?iso-8859-2?Q?1y1X10dQlLnMGpwwW2kSycAtxpckV5X3mlHBo5iOm491DaW8d0W/NIXbOe?=
 =?iso-8859-2?Q?KcSTwUX88V4cpm/zWRnbP2ACAJdEpTP/MHcvujcybgI4i0Z1YewmwNUsq9?=
 =?iso-8859-2?Q?TgkjIlkrsGEP8/Y+jho8FJ8X2fXpWDKGC3ZIvxuZJStwLOueurXc1GORBp?=
 =?iso-8859-2?Q?sB5YAiCkcKnEKISUxyF9O1KYLxdAQRRQ3/5r6NNP+cuxDBjjY8IRmC60x6?=
 =?iso-8859-2?Q?6G1I/pb/whKfYd/FfeGNOqblEu+9ibVJ6smPAmVCL3GdK265fURkHSrJvm?=
 =?iso-8859-2?Q?V4lLlcgBgF8nJNcGYVLoISYXepnxCRmgoy0CzUKnAGiiSbiQPmW01EJyN8?=
 =?iso-8859-2?Q?p8EoKDN7MqfJ5ItAKUjV8BdPj3JCNAChUDRZhr/i7MXKfNMpgGoIpoHk9c?=
 =?iso-8859-2?Q?4yKuYXpG+t6HmqowvyO/B5vAtr4vLf+KERh4uKYBw7GZBaGNeK5D2AvUDW?=
 =?iso-8859-2?Q?5ebanX0rN6XL1o9Pu+kQaRAwiFDAT7qLGPvpw5oy9Fht5r6IcesLALR0WC?=
 =?iso-8859-2?Q?46MXOIM74xGBDmGZsIhEmqBZN4BA0K6DF4AKn7R9dAFz1CFnrdz/Bi5iyE?=
 =?iso-8859-2?Q?Irovrh4GtauFWTooAmJ1jHHARUd1L7SbEVfhDSjqsXDwPF+HqG5ts63449?=
 =?iso-8859-2?Q?S89AmNblArwE9iTSGlVHuxSUONUak6i7Otaa2dgxowz/YAOhHb0oUcWS/j?=
 =?iso-8859-2?Q?gThZLOJOZbgX2GGTIAqOa08OTW8ll7GQoBiWfxlNXLabin0622kPavVkd0?=
 =?iso-8859-2?Q?Qv1C5GJK/823PBmvKbC+XKTmoty6Jkx1+3L4L1h9hoOWNxR76q0z+As8o5?=
 =?iso-8859-2?Q?bCHnAUQsfcycL9RfywbgjUVKkO03CMD1TRNYx2KK4SB+V04yDGq2H4UtNc?=
 =?iso-8859-2?Q?eGeLIw67OGtmSq++JnOWY5lVE+CjzZyhfUsefNcg5yyjxrWTbcqiIJS8g4?=
 =?iso-8859-2?Q?1GitiW9+5Jb90dPeB8dBoEv0G0qfLgGRj4tXgKOjVoHmqro+fwDpLYvdzz?=
 =?iso-8859-2?Q?8K+p95B4uKjQurRi5vBP7DUjeCOdDMrPDdfQxKMSV60BLeIBTrJkOyxguf?=
 =?iso-8859-2?Q?NElLFmZgSuf6V3ySpsSfVz5nAkfsoGDUjVoWxVR1B6ezARzOEqaL8hmoR/?=
 =?iso-8859-2?Q?NSUQJ7g8co4YFlIz8MzJxX5DsbOTE3a2RtpmehDgE+asM389S2Kj8+LZYL?=
 =?iso-8859-2?Q?2VE/Esta9S49t5Ei9mQIrkgiRUUpEfyM59dL76BQbJTdBWO7kk11+/+NXk?=
 =?iso-8859-2?Q?9gUDzLcsBkjs3+10YCURvflz5d5cQrJWPs3a8fl+J83RK1TTbMvCaFXCjL?=
 =?iso-8859-2?Q?pA5XdW60f6hcMJGzfvQYAos35PU1y9onmu?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <E45607874119F145ACBD26E2AEB4AF63@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1g1guO2912YVjo47BiS8tCjV/OTtGicow3j+wf6GGxG381HaMy6GZSDflaL+4lkTavd5vu4J8batafExM4OcwNGxw/8n4AiHWXjDOonokZ4s4g95EEkbKhFjfFAy8PYMH5SqkPXflxT22TheVSiVHPQR3gK3N5+NjKjlwNMdR7DrxLHs7xlycph2cCt9bQyyc31gwtJuG4HXOBnF9V6fFp303WZGenNLN+MgmL+TAw/aK8bnPga1/6HfHGVWcqXx0nBdgJFYOQt0GqFwUPvfnIflaVEG5nuwmHBYhu1sx2rZPGLGZRH0fp11KyGy8C52dcvJNstqMj+zgLqXMG23/9hEMpTM3FfNmdFTgc/REfIs5c/4r6VZpFaBDsqXVG2HYBZaA0IRF103ol3KmIpE7eHMFmw5OzBYmW7yQqt845vG/AiYVLvVqufEoVaVBqeG4hxaC5CiIMvqumvdNz46O7xJxYJ5/QjJCrEKr6k03Ot8jJlWieuy3u0MhFpV5XH9MRKE4ldiblpSSQsuH5R43KwaZg0kxptCwj42Q/FPzEQakIPVCr3Lu+e60VY9w7Rx3C28TUNxlQbmAC0vbchRNauN7oVCzb8qOQxqfg9F7qtbe5MRHmMHjFbEOwfEvlpP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB4850.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2d810d-cec4-4de3-9e3d-08dc1111d41f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 12:52:25.0168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGB7WYj0RVPY3pGV5RJodknIm8MghGFt0d1+j/Pno5E0zQAPl92PsUHqivcT++bPt6utyT4H+6KVX9Xa3MDfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6273

On Wed, Jan 03, 2024 at 11:33:35AM +0530, Kishon Vijay Abraham I wrote:
> Hi Niklas,

Hello Kishon!


> > > I assume dw_pcie_ep_map_addr(), writel(), dw_pcie_ep_unmap_addr() hav=
e
> > > to happen atomically so nobody else uses that piece of the ATU while
> > > we're doing this?  There's no mutex here, so I guess we must know thi=
s
> > > is atomic already because of something else?
> >=20
> > Most devices have multiple iATUs (so multiple iATU indexes).
> >=20
> > pcie-designware-ep.c:dw_pcie_ep_outbound_atu()
> > uses find_first_zero_bit() to make sure that a specific iATU (index)
> > is not reused for something else:
> > https://github.com/torvalds/linux/blob/v6.7-rc7/drivers/pci/controller/=
dwc/pcie-designware-ep.c#L208
> >=20
> > A specific iATU (index) is then freed by dw_pcie_ep_unmap_addr(),
> > which does a clear_bit() for that iATU (index).
> >=20
> > It is a bit scary that there is no mutex or anything, since
> > find_first_zero_bit() is _not_ atomic, so if we have concurrent calls
> > to dw_pcie_ep_map_addr(), things might break, but that is a separate
> > issue.
>=20
> There cannot be concurrent calls to dw_pcie_ep_map_addr() in the current
> code path as pci_epc_raise_irq(), pci_epc_map_addr() and
> pci_epc_unmap_addr() which invokes dw_pcie_ep_map_addr() takes EPC lock i=
n
> pci-epc-core.

I must have overlooked the mutex in pci-epc-core.
Thank you for clearing that up.


Kind regards,
Niklas=

