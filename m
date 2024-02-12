Return-Path: <linux-pci+bounces-3371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63F685215C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 23:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E187283876
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 22:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55024D9F1;
	Mon, 12 Feb 2024 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mA58dxvi"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2041.outbound.protection.outlook.com [40.107.247.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315E4D9F8;
	Mon, 12 Feb 2024 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776656; cv=fail; b=c8EDhO8JqZ18Nywcz8ZPUU4ojvDfgQrXt2ch6DlHmQ/Hkuo7tQB2lfx0tq1aPSDdkhwbIMqt1XMlr5f4kMHjkOv8OcA0TrKNj+4v5IEpuvjBHf3fqdmF0tpp5sfZOPhHAC7dJzPGjaF8iq/AItAa3ZmhyHCBhkdS15VpMsYn474=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776656; c=relaxed/simple;
	bh=R9xVhoPTKU33DSK/oUtGdsFjUhtbG6vt/0cVRwYCMAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TytS7ftmJoGaG37X3Lo4qEwXSvw04MYzVdHo3V5is3Za0qKXF1uH1A43JOjouq56rZofMkDocIWXguLcFZ7QG6mnxL+r91SOExRCPZl2/6mpgKZWdBTcv0pEwExRljP+9JRfany5wdc4LBi/ezg1QRdhV6KTdPlGZO6dIQ1TgtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mA58dxvi; arc=fail smtp.client-ip=40.107.247.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJsmLUPpRxvi5mderBajXdL5Dlf1ZZdBjWYImPmYF4ab4+e48Ff0CmNHeYUqda0FDSDl4RVskz/+dCXT6++GnJBqzNZZmFSvL9YHuL7UIGtcDGumNjB0BQxxFznLd0v2CVJhlhWbZ9m8BNKWgr8tcCJU/ZJx36LS8RttsSvgMBHNWDhV6QRt6/amRlTdlJzL7KLmB5BkJ8aEE8odYxjGCvRZUl+eX6eD8CXpFh3ifp7LrBPb9a4FA6l2k/us/Bfabzn3eT/Bb1b4Ag3qAFwpwWa8xufc0hD5mLweflBOzAe0Y+Auv3lFQUaecZlP/2/vT+NDKeJwZvicPWP9wWSPuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Snrz/qtrp9Tc6g33xVn6aeiRgd3kdSjFXdTjlZP43G0=;
 b=enthLFMa0DgPu6wuLlTx4uNG4OWdw7SEFooepHucQzMTqZtLfAkzWz8bYumVwwEk6by4MY4ngrsEQNOKHoZc7Lm4mA3e6x2oyc4pQbYEvHQ6aKoLSaR2ls9wwepJJhlFd4wu+oc3TFhX7rm3lRtuTffzCrIf3UqIxOedPSzHDJsORVnpsVnnDoa9fHgPlfXpaPWMLpdG3H6TxUJ8eazkuW1jzF8C/dQpc20D+5t/o7RwaNO8rfC6c2eEW0//pqj37JG2aUYPBH7hk6KC3k/ItnSx3OzeUTT3hD+Z3raD/ay7VDCN7nNx0mFfcGW+ipKjULUZK+jk+8MGNoj4Kd89Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Snrz/qtrp9Tc6g33xVn6aeiRgd3kdSjFXdTjlZP43G0=;
 b=mA58dxvidTMh1WukPoIp+iU1lBYkWPtljNcmPAC/obTNoZW6RgtaT3vci42xoiAe9f3zmDoyTtk2wbqdPPi1RTURm3C3EeBlWZ6WHum+26iUiJZ0/HbdYYkq1qSVDlNAcEzHo2oWU0+YcRbbmS9whOMQ6jnUcnv5qL618GqFK5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9246.eurprd04.prod.outlook.com (2603:10a6:102:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.28; Mon, 12 Feb
 2024 22:24:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 22:24:10 +0000
Date: Mon, 12 Feb 2024 17:24:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: dwc: Add 'msg' register region
Message-ID: <ZcqagbUnSfRgv5Hd@lizhi-Precision-Tower-5810>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
 <20240202-pme_msg-v3-5-ff2af57a02ad@nxp.com>
 <eg7wrjp5ebz43g37fvebr44nwkoh4rptbtyu76nalbmgbbnqke@4zugpgwesyqd>
 <20240205183048.GA3818249-robh@kernel.org>
 <ZcEzYdZKotBJlR5i@lizhi-Precision-Tower-5810>
 <ZcK2/tmLG9O7CBEH@lizhi-Precision-Tower-5810>
 <luk5hswq4wnk5p7axml73qih35hio3y3pfnklctbn6rwres62s@mumnvygjh5ch>
 <ZcOpehO3rzCfAwXf@lizhi-Precision-Tower-5810>
 <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gl7zmzkezr6k4txrrgqyikspfah3vmgwwz2e3j5kwb2iarpkxv@3ofwrhtxl2sz>
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: 0518ec84-c522-4d06-e378-08dc2c195594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	myG61Fy32jykr13E1PTnop1pz0A8mVHBiF6/abFRsfrGfK19gryI6MLciz+Dw/x/XGGTEJDqs4/R0YUHVkB6H1WGAxvCPlixmjkdl123dVaLIgucqNZoybyWQcH+YSTmwbaK24/CX5XHq0n4egxXsLx1okwRuWGXBSRaEENhIaqArms3PQxzsPv04Qel3hiMcqUKjEPQo6CoxXm/qWJc7ZimaL3kXnq4/qPgmecSY/LEVXAW0azww1P+yCROkqF7V+BUKEizmejEGCab/PyIHeam5k03XjrHAySgK66DOaMQ7dFeFMvwG6zqV2vr3Nbrfm/joJBr7upRQ/FCAZj83pNkl+vXPYxt8uT3UurHQBfHhlvns+2oQq7QO/F7O0IqR/fShnMw3BiYU+WZdJ6uBhxLKsWmYpsRZnEY4rvI4HETCq3zD5opmiwpG+1usULwKkyRKbT4sx33H8VHmvSkh/9y5DeqQDO+btwY6BGobhqz0y/f29WTPnOyFd//RXk/ovMxKPOQf645ofAqHL+mgmVss+0OR8LDlPeRB0EaiwDJjETnkszBl5KN2l//Cg+aYnmByLUk4HBVAQ9HmkRoD77BuW2BFnOblwk3n/VTfyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6916009)(8936002)(2906002)(7416002)(5660300002)(66556008)(66476007)(66946007)(4326008)(66899024)(86362001)(38100700002)(478600001)(6486002)(966005)(54906003)(83380400001)(38350700005)(6666004)(52116002)(6512007)(6506007)(9686003)(316002)(41300700001)(26005)(8676002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZqA3UGDUddHgHTUk82y12gOpN6RlwbpcKjrDNOF8GyEe1xeGT+N2slkMDNgu?=
 =?us-ascii?Q?EJ0TYPVgy8c9izPFrzfzE01kp+kUauom9qN3wyVsX+SVaOcxWHnbsaPS+I5d?=
 =?us-ascii?Q?k09BTWUN/v5JxgRQQF2kYfnY5h7zk/coZ5s+knuoHXAyDJHjYFekQ3/FqDUr?=
 =?us-ascii?Q?m0cyDwS2yCc5IphGcKbNi2RWCGrYMcj058DO1iI6jEQJ29NWQM94kVStlX/3?=
 =?us-ascii?Q?GgwejSfIxg+BKw5sq/XdbUEIAq6Oehh56BsxIytZQOB+6VBw5J3AOUBwKiX1?=
 =?us-ascii?Q?2LccTHkCC5zYgu+fwGzgRTkA4AuSR2cjl7YY2fJkpWDucBvZDQRr0z2lAcsA?=
 =?us-ascii?Q?xd8w5tC1kyGdAo0pf3aUGG6QM02DZfk52OKjrAMYaCVsp0A6NIHX4QGBO01X?=
 =?us-ascii?Q?1RBbA/Xz9MKbnOZZi/EE6hZF9igRLv/vFRM4VmZSEy64TY6CEa3sOX2lXygL?=
 =?us-ascii?Q?8SeDKr7tuTG77KSkbm74q2ssuj6QmAOyV8VRFAck/fSwF5dBHAdztkGLk9zh?=
 =?us-ascii?Q?IJS+g2j5DFE+f72yZapubWLvDTtuTSgkdNa5JVg23ikyzfGisVRVHfFQYwAu?=
 =?us-ascii?Q?e30+xDfQGS1Bv5FkKQ2f5v1Y43LK50RpriMK5L2VMPNXLhzUVzCY1tWFNCZj?=
 =?us-ascii?Q?Qjh/lGzU6tscGsBZFSbd8aqH2GbEnZpfbzyrEaTaWdCLVrDOV51G0CcaOpej?=
 =?us-ascii?Q?bJaWyrl12EUrR/OZgfkDD7uaSBSNLEJ3alicpeqniU/8i1VV4zXrGNrMECXP?=
 =?us-ascii?Q?5AfTS4dGqqgsT8NIDEj6t0IWObpMLz06t6HDzNJYlxqKfZS779fUEGQueZK7?=
 =?us-ascii?Q?E5STzv1lNNi2iiByRhUUT5FWrf0XxelgV1WvEz6u1NLjBOvM0gp3DZGbFx7E?=
 =?us-ascii?Q?fEGyafkRChVPdkA6Hxmpg+D0D6sjbFfDIzOy8ttFpbC4ETS3WWJ9Gp7s7HYQ?=
 =?us-ascii?Q?/8LWLzHyOnMuRzaG0HG73MMPpw4tDskpz7EyQDNpp47IZBAmYDKYNUEm/6Tb?=
 =?us-ascii?Q?CTcwlcs5XMeVjPJSnx/nI2LLr7azr5fNIA3lbeGYbKqYlHI5wQTL5sAlEzdo?=
 =?us-ascii?Q?sanSyHo1WcgIwf8an2llJ/UsbaQZ/dFpeE7sHcPqjZWQOVd9PWLilT1bAP4x?=
 =?us-ascii?Q?nrBPYlgT6Vpp/RPx9S7lILBfriagW9uoF6+rorgnc6WQo6bhEI26LhDhZhNe?=
 =?us-ascii?Q?K7iZ9q5rWtKOLL8ieYTAzN6xps5drsTEwnQkQ0uxq8CV+h/MS/4HwZj+mTBB?=
 =?us-ascii?Q?YbG5+y5suyxSo5B3LeIHYmjnmCtjloQ7aBOkxP1F6HSnbCFfllFzR+1v276A?=
 =?us-ascii?Q?yitqohbz1gcZde+Ig05wyTDpz9QMc0AT6o56Q2AJ4Rzrf+g2+Hw3iL5vowTK?=
 =?us-ascii?Q?GA2N7DQBXY7MLpdJWmIYztDcLZH0nHaiJzYMetr6C1wP3XCXNKOFAXnKJT+J?=
 =?us-ascii?Q?ri8LYn0Nsp1b+jNMnjZPJ8hpsde/6Qn5i43QZ0RYLJw7wDNHJTYHy5tsPy8a?=
 =?us-ascii?Q?b3b3aUIrLFeqqwivs7/EHN3m6zR2gqxYy7DvTvJa8uoOnR4yGpDTgsfLBrZy?=
 =?us-ascii?Q?tNkggwx49/7UOOwjL7Hd0pZ39O8TJWkbBxVXpG+w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0518ec84-c522-4d06-e378-08dc2c195594
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 22:24:10.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgTN/GbT0xONc2VC8ReoIhSbFldEBRgxuY5qXQRxFgkQLmZa0hj/ioKKZlqMWnRGyrj18UbWWns8ffc51I9/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9246

On Fri, Feb 09, 2024 at 12:52:52PM +0300, Serge Semin wrote:
> On Wed, Feb 07, 2024 at 11:02:02AM -0500, Frank Li wrote:
> > On Wed, Feb 07, 2024 at 03:37:30PM +0300, Serge Semin wrote:
> > > On Tue, Feb 06, 2024 at 05:47:26PM -0500, Frank Li wrote:
> > > > On Mon, Feb 05, 2024 at 02:13:37PM -0500, Frank Li wrote:
> > > > > On Mon, Feb 05, 2024 at 06:30:48PM +0000, Rob Herring wrote:
> > > > > > On Sat, Feb 03, 2024 at 01:44:31AM +0300, Serge Semin wrote:
> > > > > > > On Fri, Feb 02, 2024 at 10:11:27AM -0500, Frank Li wrote:
> > > > > > > > Add an outbound iATU-capable memory-region which will be used to send PCIe
> > > > > > > > message (such as PME_Turn_Off) to peripheral. So all platforms can use
> > > > > > > > common method to send out PME_Turn_Off message by using one outbound iATU.
> > > > > > > > 
> > > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > > ---
> > > > > > > >  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
> > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > index 022055edbf9e6..25a5420a9ce1e 100644
> > > > > > > > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > @@ -101,6 +101,10 @@ properties:
> > > > > > > 
> > > > > > > >              Outbound iATU-capable memory-region which will be used to access
> > > > > > > >              the peripheral PCIe devices configuration space.
> > > > > > > >            const: config
> > > > > > > > +        - description:
> > > > > > > > +            Outbound iATU-capable memory-region which will be used to send
> > > > > > > > +            PCIe message (such as PME_Turn_Off) to peripheral.
> > > > > > > > +          const: msg
> > > > > > > 
> > > > > > > Note there is a good chance Rob won't like this change. AFAIR he
> > > > > > > already expressed a concern regarding having the "config" reg-name
> > > > > > > describing a memory space within the outbound iATU memory which is
> > > > > > > normally defined by the "ranges" property. Adding a new reg-entry with
> > > > > > > similar semantics I guess won't receive warm welcome.
> > > > > > 
> > > > > > I do think it is a bit questionable. Ideally, the driver could 
> > > > > > just configure this on its own. However, since we don't describe all of 
> > > > > > the CPU address space (that's input to the iATU) already, that's not 
> > > > > > going to be possible. I suppose we could fix that, but then config space 
> > > > > > would have to be handled differently too.
> > > > > 
> > > > > Sorry, I have not understand what your means. Do you means, you want
> > > > > a "cpu-space", for example, 0x8000000 - 0x9000000 for all ATU. 
> > > > > 
> > > > > Then allocated some space to 'config', 'io', 'memory' and this 'msg'.
> > > > 
> > > > @rob:
> > > > 
> > > >     So far, I think "msg" is feasilbe solution. Or give me some little
> > > > detail direction?
> > > 
> > > Found the Rob' note about the iATU-space chunks utilized in the reg
> > > property:
> > > https://lore.kernel.org/linux-pci/CAL_JsqLp7QVgxrAZkW=z38iB7SV5VeWH1O6s+DVCm9p338Czdw@mail.gmail.com/
> > > 
> > > So basically Rob meant back then that
> > > either originally we should have defined a new reg-name like "atu-out"
> > > with the entire outbound iATU CPU-space specified and unpin the
> > > regions like "config"/"ecam"/"msg"/etc from there in the driver
> > > or, well, stick to the chunking further. The later path was chosen
> > > after the patch with the "ecam" reg-name was accepted (see the link
> > > above).
> > > 
> > > Really ECAM/config space access, custom TLP messages, legacy interrupt
> > > TLPs, etc are all application-specific features. Each of them is
> > > implemented based on a bit specific but basically the same outbound
> > > iATU engine setup. Thus from the "DT is a hardware description" point
> > > of view it would have been enough to describe the entire outbound iATU
> > > CPU address space and then let the software do the space
> > > reconfiguration in runtime based on it' application needs.
> > 
> > There are "addr_space" in EP mode, which useful map out outbound iatu
> > region. We can reuse this name.
> > 
> > To keep compatiblity, cut hole from 'config' and 'ranges'. If there are
> > not 'config', we can alloc a 1M(default) from top for 'config', then, 4K
> > (default) for msg, 64K( for IO if not IO region in 'ranges'), left is
> > mem region. We can config each region size by module parameter or drvdata.
> > 
> > So we can deprecate 'config', even 'ranges'
> 
> Not sure I fully understand what you mean. In anyway the "config" reg
> name is highly utilized by the DW PCIe IP-core instances. We can't
> deprecate it that easily. At least the backwards compatibility must be
> preserved. Moreover "addr_space" is also just a single value reg which
> won't solve a problem with the disjoint DW PCIe outbound iATU memory
> regions.
> 
> The "ranges" property is a part of the DT specification.  The
> PCI-specific way of the property-based mapping is de-facto a standard
> too. So this can't be deprecated.
> 
> > 
> > > 
> > > * Rob, correct me if am wrong.
> > > 
> > > On the other hand it's possible to have more than one disjoint CPU
> > > address region handled by the outbound iATU (especially if there is no
> > > AXI-bridge enabled, see XALI - application transmit client interfaces
> > > in HW manual). Thus having a single reg-property might get to be
> > > inapplicable in some cases. Thinking about that got me to an idea.
> > > What about just extending the PCIe "ranges" property flags
> > > (IORESOURCE_TYPE_BITS) with the new ones in this case indicating the
> > > TLP Msg mapping? Thus we can avoid creating app-specific reg-names and
> > > use the flag to define a custom memory range for the TLP messages
> > > generation. At some point it can be also utilized for the config-space
> > > mapping. What do you think?
> > 
> 
> > IORESOURCE_TYPE_BITS is 1f, Only 5bit. If extend IORESOURCE_TYPE_BITS, 
> > all IORESOURCE_* bit need move. And it is actual MEMORY regain. 
> 
> No. The lowest four bits aren't flags but the actual value. They are
> retrieved from the PCI-specific memory ranges mapping:
> https://elinux.org/Device_Tree_Usage#PCI_Address_Translation
> https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_64.c#L141
> https://elixir.bootlin.com/linux/latest/source/arch/sparc/kernel/of_device_32.c#L78

In dt: phys.hi cell: npt000ss bbbbbbbb dddddfff rrrrrrrr

of_bus_pci_get_flags() will parser (phys.hi) to resource flags. Even there
are "000" in dt, we can use, but it need convert IORESOURCE_*, which have
not reserve bit can be used for TLP.

we may call reserve_region_with_split() to split 4k region in mmio windows
in dw_pcie_host_init(). 

So needn't change any dts file. 

Frank

> Currently only first four out of _sixteen_ values have been defined so
> far. So we can freely use some of the free values for custom TLPs,
> etc. Note the config-space is already defined by the ranges property
> having the 0x0 space code (see the first link above), but it isn't
> currently supported by the PCI subsystem. So at least that option can
> be considered as a ready-to-implement replacement for the "config"
> reg-name.
> 
> > 
> > Or we can use IORESOURCE_BITS (0xff)
> > 
> > /* PCI ROM control bits (IORESOURCE_BITS) */
> > #define IORESOURCE_ROM_ENABLE		(1<<0)	/* ROM is enabled, same as PCI_ROM_ADDRESS_ENABLE */
> > #define IORESOURCE_ROM_SHADOW		(1<<1)	/* Use RAM image, not ROM BAR */
> > 
> > /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
> > #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
> > #define IORESOURCE_PCI_EA_BEI		(1<<5)	/* BAR Equivalent Indicator */
> > 
> > we can add
> > 
> > IORESOURCE_PRIV_WINDOWS			(1<<6)
> > 
> > I think previous method was more extendable. How do you think?
> 
> IMO extending the PCIe "ranges" property semantics looks more
> promising, more flexible and more portable across various PCIe
> controllers. But the most importantly is what Rob and Bjorn think
> about that, not me.
> 
> -Serge(y)
> 
> > 
> > > 
> > > -Serge(y)
> > > 
> > > > 
> > > > Frank
> > > > 
> > > > > 
> > > > > Frank
> > > > > 
> > > > > > 
> > > > > > Rob

