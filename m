Return-Path: <linux-pci+bounces-3402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F918534D2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 16:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1421F2A1A0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B95FEFF;
	Tue, 13 Feb 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gWqOaw/T"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2E5FEF0;
	Tue, 13 Feb 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838568; cv=fail; b=Mq2ct3hqf/9PdNm27C4amOwxhq3KPgAYAfN3Lmtu+ML+rb3WGvEVoLdRdtD28u7twW7gVRhRL9G1g2PyDXvZU+6E8qnq05bQHVk/xW6MW0XtyTyIm9cyusJzwVoYS9EIShXQ/VWRQDlB0/MI/q9N1o04Ws+7N4+9DAd5XqB1N14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838568; c=relaxed/simple;
	bh=6gny98f7Wz5/s3AQuRIL5T4KEi66ePdJSubrZi8w71c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lYfa3hdMg5OHdfWRvvmbbjjo4usoGtnoZTF209EB7eLzEc9DFyFupPw7Effj+kbqG30QRSxZUvZQp9+/FMwl5j8nQvOct2Lg9EixnqxnsJfCt726N9fcn9tu+MRWceHNRGKxZ3ekdkcWWlhco+MMrvwrhYLPEjcExt7FWxVtFpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gWqOaw/T; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QthSRBtmTSrxRN3v+sokUBWfaH1KvYg3QjzpthaxAZEMsXOB5f0uLr2Fhcxu7tAP+Nc3uiWfQYqK5CLNq44CZ0mEWg62pwm5nAy8C0OE35xu2CMIo698NCDW/jUVkPt1cefJNfCUK0hLxQY2JikNP/7kmiMCbBq1fMFB7HhFPIn7Mjcj+xhXWOcgErBkTcHD2gR8LprEuR45YWmD+iVrqSy0nyUQRQmDho1KN0kFL5DEepInYLth2ugn34e3++w2zBJbF1BavQ7PLsQeW/f4oP5KuyNxeQ5Urb83Qlss3NQfWWzCUl99e3lAtFUqY+ElZhtKbdRRHYXycWP1hxB0DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaZ1+hj7oqQ9obntIbpdXoKxbhjUHV5mWtc16PdSdSg=;
 b=Ov+JdxiLp7h6yBuZD8Z2kN3RPwBe1iQFWSTt9HosyraO9fDFCelRdJ7Nt1F1naDd0PMCjRzJ9m4B7IM9CDfufXn1jI6TRfqzZQp82ppFb6wajYUltmUY75c/QmPvUiCHTv2ER3zAKPOvhiYycJyydwuXqR7tYw27PaML1oo7UjUgfajjZL/Rg6Euw7ql6IkPQhkxV054BdEgs3ZTDyWUELhKDLIAlpvstCrwGomqSWBMZZw1qN75lroYB0GFxNui0gQH+oQshB/yPmExZrx8NhYoVo+nbP0DoDVq4/FzDa6rkRG4ABP63Z0f+Uasl5xlK/PVYR1fXUasX8lKnjDXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaZ1+hj7oqQ9obntIbpdXoKxbhjUHV5mWtc16PdSdSg=;
 b=gWqOaw/T4aa9G4GujhBfAUA99kdL5NOvltoX6ogYM21HbsMjfGsjdDz1MJy1iobHpJ8/0/WeKq1vJAkG/pwIhrjSw70L2fhnPMMck8nEk7dUxJBtE2WWjHbxw72ptCVHXx/cUVJ2I+AaWYAe2yWUUq+sBO2qrBGv80MPdtgzCsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10024.eurprd04.prod.outlook.com (2603:10a6:150:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Tue, 13 Feb
 2024 15:35:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 15:35:58 +0000
Date: Tue, 13 Feb 2024 10:35:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org, hch@lst.de
Subject: Re: [PATCH v9 16/16] PCI: imx6: Add iMX95 Endpoint (EP) support
Message-ID: <ZcuMVv931r97iWm/@lizhi-Precision-Tower-5810>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
 <20240119171122.3057511-17-Frank.Li@nxp.com>
 <ZctGs2d9ccnmYysL@lpieralisi>
 <f1b8c49b-0d13-4a3e-9696-75a370ac0e59@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1b8c49b-0d13-4a3e-9696-75a370ac0e59@arm.com>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10024:EE_
X-MS-Office365-Filtering-Correlation-Id: b810f487-d8e6-4fa6-ca79-08dc2ca979cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BqqT8zcAWaw23qqLZC4i98b6HHQyCq0Eh/CO1Nv2Fvu4MqRpnnbxEcjAB9Gf06SE+9pU3Q1jsRMgoXA9uiWLTdpKNFSYEIf01H1jX/LAnZ5cIi05M0efQHvkxSWv15BGq02fnBmJzxcVKMp5qnvkiTJlLXJVyzHz+0uwu4hMUrWIQhGtfQx17Jmgue0ZD16aOxdhQYpVDKv02k5GRKdyyoRdLN9dCt4CPZkCVDEY2LLsAAmWOJNNQyLd7BCPZSlrpBNDoskFBAkBn8Z7wN3GAHXcb3LsfElTgsivVBchYjHORPqc2yJUtIPTeXmVCl3LNtGAbmDNWcq5BFILIxN05JJC6Tr/NtirRZUtPHfCF4RXEv6MXeOoxvlwJcKu7mgRplX4u4dv2drzqc2v7onF5ozj/nrM1BntLLi6UiAn3YsiVviAHsiAm/y3PchEE9H9OvN6kQjP4Z0/Sc28UAr8trx8WMUnpAAEdrdwHDkXP2dKZ0Mkk0mehniSidZ8kCghYw7y7Ifuxv5gG6ONLkyImJTxffy7Ngn6++RpmyUucQk6LmqUvvySmOCEsEihtOCfWu5VsxVWhJVaG3or9g3RyaIIX8qGnvR6TAG9F0bjygEG2PbUbPAykRiARcVrGwqw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66476007)(66556008)(8676002)(7416002)(8936002)(5660300002)(6916009)(66946007)(66899024)(4326008)(2906002)(38100700002)(86362001)(38350700005)(478600001)(83380400001)(6506007)(6666004)(9686003)(6512007)(6486002)(52116002)(53546011)(316002)(41300700001)(26005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i8t9z6V3QttskNMYOBtievuD5uY3s8dDZm8UMygnzYzOcfCOcIMe2z4LVQPi?=
 =?us-ascii?Q?YSQNfPkguy/7vSf0jLod03YSUgdBXeg6AvHh9JlGBJV/dOt01RsFyPhGfSTX?=
 =?us-ascii?Q?Z50Nh1ez1jT0ZPC0IlHifGHjYzll+5L5qURTxf+JWdar/D7I13/t00CrQqgx?=
 =?us-ascii?Q?kFXGZYbFUwUep7syb09u8jgCYk26MoiGRtUoI828+gMQqi6IRBft3Gj2YY52?=
 =?us-ascii?Q?NFkxOz0GGu4P7JK28USW848PIB3k46Jzl1PpX74rWjAAbdKTNYK5qJOUOJp+?=
 =?us-ascii?Q?NaSLNJ4JhB/2HUhsVKf7rbauo61X3tHcwZ9rgQP5Va3UIQ1n+O6CN9gUwu3W?=
 =?us-ascii?Q?4DrzoQsMIT5pfWmhUQnthuTzOMH0INsLI3ywFhbtCX1DEN51RKURiTMhPi2Z?=
 =?us-ascii?Q?nPh0G1W67X5Tr3duZT4BmIA5Jttpl6oIgS/+2N/dGompQ1QsDX4sKnaLHKAe?=
 =?us-ascii?Q?kzewP4DY/I/KVWARlhilboDlwpWDrrkCKRy28lllraw1DBP6ik781CJNMBez?=
 =?us-ascii?Q?6TcAPdbLpfkFWgbojMG4eHZG9tqlmgmTTscGu1DwKQgUHJYTbEqeLZPxgJzz?=
 =?us-ascii?Q?VQlhzdM5JDrm+ilsaU2kEVBbQrKDDBp3kY2Aff2LPhiKWzx64F4gjPaCJ4tG?=
 =?us-ascii?Q?G/BFyivSrZ5CWsAvHqs6TQdrjqBDCwefryAuXahO6E95PSLOUGTvT7u2Vcga?=
 =?us-ascii?Q?QZaDhrEr3EQyYKzr6op2icH2A5KOrH6ZGeZsaT7QrWzpM0uLnd+V/JqiQ8b3?=
 =?us-ascii?Q?8xZo86rNUEhMclmj863AjIwbbA8jLU1tgHnvwHRw2ILerf41BHH+MCRmtwuE?=
 =?us-ascii?Q?nDiqyuD45WZ7tskOKoRq3z6b44R3a0to7R+QsbnnpDj+uPVUu+ohrJQOOaB9?=
 =?us-ascii?Q?JRmeZqvedYh/zdTGLkUz/+REYtGXqyVdvXRWKgmWDNgGWlAnRawV5E/w7KS+?=
 =?us-ascii?Q?rb9rLHvTz2JcilGSoswda4Cy2M4nSC78mufrc3g6i6i56B3qGt9D2sCeCXcE?=
 =?us-ascii?Q?P9FlHF4+pSJzztgjVqYmsj89nrX50zEO1h4reXVZftvkug+ZO6nxHyGvDJX1?=
 =?us-ascii?Q?SzRagpQ1Q84hfsE0ipHGyHLYTSxfTQOBjPz7TbugqJNPNhXj3Dt3cPsYuStu?=
 =?us-ascii?Q?jXJd2DT00B48Yx7S/6xpd499BW6vTwqMQnux7cm0QSVnQ5Dt1EwqHH9K4kVD?=
 =?us-ascii?Q?dApoVB4sDAQWrg10r5m0tA+9GcdhJwFDILcrNqejR3KMo1g8O/x6OK4NjvFW?=
 =?us-ascii?Q?Od5ABaKeLV1/P/K1LxUjtgazxuCYYO5OuMgqD8r70Bll52IwAZdJvrcRPVUh?=
 =?us-ascii?Q?kq4YA+2PM8Fete6+qckKdyOBlckw4RX0hdPCNhkef8DDRaW4iyaqRve/Ye8M?=
 =?us-ascii?Q?QAFX8r/Wb11IBkp5InvTG3s2aSMl0oa2fwooJgGpcrXoUVB80GxG8n+Ob5YS?=
 =?us-ascii?Q?CouckmUxXJ8yBXQFU7lu/yPsTbIJTHX+N9bo9OOHSZVsCIAgC9mWgPYVWFYt?=
 =?us-ascii?Q?OLDM6PaiOSckj/xM74fKWb4zjWzbegoX7CNTAyuSYAefKl4be5/hamiSDldm?=
 =?us-ascii?Q?6Wb6gO0OxEUeE+ua/qKUZ2pK2bY3OasooNQ3AgUa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b810f487-d8e6-4fa6-ca79-08dc2ca979cb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 15:35:58.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 152D351Z7U3OFTFIrd6RFa5ORqCRzdiMocaDDUdYXFxAoHtYggDrdpDybPeUy/yEo5ar42z5OQgpIa9oDTgY8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10024

On Tue, Feb 13, 2024 at 01:23:45PM +0000, Robin Murphy wrote:
> On 13/02/2024 10:38 am, Lorenzo Pieralisi wrote:
> > [+Christoph, Robin - just checking with you if the DMA mask handling is
> > what you expect from drivers, don't want to merge code that breaks your
> > expectations]
> 
> I don't really understand how all the endpoint stuff fits together, but my
> hunch would be that setting the DMA masks in imx6_add_pcie_ep() might be
> more sensible, unless perhaps there's an implied intent to account for eDMA

pci_epc_mem_alloc_addr() ioremap PCIe EP side outbound memory. Without it
it will be mapped to lower 4G space / SWIOTLB. Generally, outbound is quite
big in some chips, such imx95, (4GB). So it need set dmamask to make sure
it can be mapped to > 4G space.

> channels in root complex mode as well (and so assuming that eDMA and
> endpoint mode play nicely together sharing the same platform device) - as

There are eDMA in host side, but still not find a usecase yet. So it is not
enabled yet. I just need add flags IMX6_PCIE_FLAG_SUPPORT_64BIT in imx95
host if needs.

Anyways, if you like, I can move it into imx6_add_pcie_ep() at next
version.

Frank

> we've discussed before across various threads, setting DMA masks for a host
> bridge itself doesn't really make sense (and hence it leaves the gap where
> we can get away with co-opting them for the MSI address hack); it's any
> additional DMA-initiating functionality within a root complex which should
> own that responsibility.
> 
> FWIW it looks like the equivalent change for Layerscape *is* specific to
> endpoint mode, but I don't know how relevant that is to i.MX given that
> they're unrelated hardware configurations.

Previous i.MX PCI outbound space < 4G space. And only have 32bit address
access in system bus. So needn't set DMA mask. i.MX95 change it and PCIe
part is inheriate from layerscape.

Frank
> 
> Thanks,
> Robin.
> 
> > On Fri, Jan 19, 2024 at 12:11:22PM -0500, Frank Li wrote:
> > > Add iMX95 EP support and add 64bit address support. Internal bus bridge for
> > > PCI support 64bit dma address in iMX95. Hence, call
> > > dma_set_mask_and_coherent() to set 64 bit DMA mask.
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > 
> > > Notes:
> > >      Change from v8 to v9
> > >      - update fixme comments
> > >      - update BAR1 comments
> > >      - Add mani's review tag
> > >      Change from v7 to v8
> > >      - Update commit message
> > >      - Using Fixme
> > >      - Update clks_cnts by ARRAY_SIZE
> > >      Change from v4 to v7
> > >      - none
> > >      Change from v3 to v4
> > >      - change align to 4k for imx95
> > >      Change from v1 to v3
> > >      - new patches at v3
> > > 
> > >   drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
> > >   1 file changed, 47 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index bbaa45c08323b..7889318f6555a 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -75,6 +75,7 @@ enum imx6_pcie_variants {
> > >   	IMX8MQ_EP,
> > >   	IMX8MM_EP,
> > >   	IMX8MP_EP,
> > > +	IMX95_EP,
> > >   };
> > >   #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
> > > @@ -84,6 +85,7 @@ enum imx6_pcie_variants {
> > >   #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> > >   #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
> > >   #define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
> > > +#define IMX6_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> > >   #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
> > > @@ -616,6 +618,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> > >   		break;
> > >   	case IMX7D:
> > >   	case IMX95:
> > > +	case IMX95_EP:
> > >   		break;
> > >   	case IMX8MM:
> > >   	case IMX8MM_EP:
> > > @@ -1050,6 +1053,23 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
> > >   	.align = SZ_64K,
> > >   };
> > > +/*
> > > + * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
> > > + * ================================================================================================
> > > + * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
> > > + * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
> > > + *        BAR1 should be disabled if BAR0 is 64bit.
> > > + * BAR2	| Enable		| 32-bit		| 1 MB			| Programmable Size
> > > + * BAR3	| Enable		| 32-bit		| 64 KB			| Programmable Size
> > > + * BAR4	| Enable		| 32-bit		| 1M			| Programmable Size
> > > + * BAR5	| Enable		| 32-bit		| 64 KB			| Programmable Size
> > > + */
> > > +static const struct pci_epc_features imx95_pcie_epc_features = {
> > > +	.msi_capable = true,
> > > +	.bar_fixed_size[1] = SZ_64K,
> > > +	.align = SZ_4K,
> > > +};
> > > +
> > >   static const struct pci_epc_features*
> > >   imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
> > >   {
> > > @@ -1092,6 +1112,15 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> > >   	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
> > > +	/*
> > > +	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
> > > +	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
> > > +	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
> > > +	 * above "dbi_base2" setting should be removed.
> > > +	 */
> > > +	if (imx6_pcie->drvdata->variant == IMX95_EP)
> > > +		pci->dbi_base2 = NULL;
> > > +
> > >   	ret = dw_pcie_ep_init(ep);
> > >   	if (ret) {
> > >   		dev_err(dev, "failed to initialize endpoint\n");
> > > @@ -1345,6 +1374,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >   					     "unable to find iomuxc registers\n");
> > >   	}
> > > +	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
> > > +		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > +
> > >   	/* Grab PCIe PHY Tx Settings */
> > >   	if (of_property_read_u32(node, "fsl,tx-deemph-gen1",
> > >   				 &imx6_pcie->tx_deemph_gen1))
> > > @@ -1563,6 +1595,20 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> > >   		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > >   		.epc_features = &imx8m_pcie_epc_features,
> > >   	},
> > > +	[IMX95_EP] = {
> > > +		.variant = IMX95_EP,
> > > +		.flags = IMX6_PCIE_FLAG_HAS_SERDES |
> > > +			 IMX6_PCIE_FLAG_SUPPORT_64BIT,
> > > +		.clk_names = imx8mq_clks,
> > > +		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> > > +		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> > > +		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> > > +		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
> > > +		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
> > > +		.init_phy = imx95_pcie_init_phy,
> > > +		.epc_features = &imx95_pcie_epc_features,
> > > +		.mode = DW_PCIE_EP_TYPE,
> > > +	},
> > >   };
> > >   static const struct of_device_id imx6_pcie_of_match[] = {
> > > @@ -1577,6 +1623,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
> > >   	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
> > >   	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
> > >   	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
> > > +	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
> > >   	{},
> > >   };
> > > -- 
> > > 2.34.1
> > > 

