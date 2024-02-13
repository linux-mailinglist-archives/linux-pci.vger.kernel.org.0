Return-Path: <linux-pci+bounces-3403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E7C853573
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1A12886C2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDC5F867;
	Tue, 13 Feb 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yz89K+sH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD4C5F56B;
	Tue, 13 Feb 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839897; cv=fail; b=onFxSbZdnaP8nuWqi5XsAU5bph89PNI7dACu1/tAVSY4QziBxLY2yncdL5D8V+wJRa+cT87xPL8JgCIboR3Jo8YlyyJGNIF2jiOste+87Dng53R9kNkfE9xvpy25FG0LCCg7FyVN6H8lty6W2YM9VxQ8hQtFhDoONhTrihRVnec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839897; c=relaxed/simple;
	bh=AbMADVmXK4RTaonFgOUqIvkIhNytKnVrhlQRB31B1KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=urd9YRyrmJdIIvqlLGjk7DDtFCiFRYgRpmIuegWZNNnj7BJtNsFtdZ5dwO3buWud3aZdvLqnWXukKkmA5gjgPMLoNXGSV0ZPiVusNbWZge1sekN6diKzJiV+mvDs+aKjk2qZEzKCi9LZiglQr0ydyo/Rb96SwQ8Py5LzkdMughI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yz89K+sH; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGwxt1rVJwCr/dYsBZk74xJ6EZr/NnGdbnk0Gu6TfXXkKBH/8Ebi/N/Ep5Yg0TVHe1DRTpBhzII2OubEulxbKiX8JNFmg45I5A3JfGxzsoOQAB//ywwK2Fd7M//tKjQ/SHFm6gzQuumdbvZu9FBeNo7G99/CbBYig4/ssW/mfZkvHP6lhjNABlXT49e8sCT8r9Or4ZMLE9fXWyFUkq14Spi7XxtCB5ywCQ2YYYjeH3HxGg7GBeyOzs1hNIwMpjLk/API4NYVEEbLaX/t8XbF1c+bQ3co2x3gYqokT0vYdl9+0Tx/bH6hOyqN3KNVHaigJq88vh7GPfrf+Ywmu1XRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUq4LsFmjNqUJC6ngB5th4bwfJfAGYxtbcLXWsdvmJM=;
 b=BhxsQe2whNTUOn6Paia616ETpkqu3Bt/EMv4bPVgXBSzcFdwSbhMV0nWecQPNBA1TpMU3cPGzG7NdNWkhDTjPoa4Yd2IgS4saBFg665G4a7kt730PHkkCted5h8FkoxTQN0IIoWB/l/g54VQJ4FuK5ZP6iAjLS1MVk2LcFPtlBcvsu1gVxC0c+rlo+rPdkqVvE+Z+HRqyLjZZzZwW4HKblsZbIg3C9iKDBXbiX6ECTNvmQHJT/C7r4BhD8tk4pRU9vyVv4nxxkJRcbRSJLPl5DZ+PM5VpyEoSOafWXTekfH50lXevctAz4GrkMomWcYuw9ZZKmBxTB0dhBt7COSOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUq4LsFmjNqUJC6ngB5th4bwfJfAGYxtbcLXWsdvmJM=;
 b=Yz89K+sHTaie5sN6/ttiOwt45LZWNqo331Cy8jGsHOBdeIJPMZMrfQ3aRXlE6DmLxVcX0xss46u3n1YpmzRtd4igr2eiIJT4j/G5lKltK1NzszbbahqRlKXMswWMzdW11kilqITqhu/w9LskQURdUht5HpJpXUNRMihmxcuMAYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9678.eurprd04.prod.outlook.com (2603:10a6:102:23c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 15:58:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 15:58:10 +0000
Date: Tue, 13 Feb 2024 10:58:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v10 01/14] PCI: imx6: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <ZcuRiQ0brp2SfmNU@lizhi-Precision-Tower-5810>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
 <20240205173335.1120469-2-Frank.Li@nxp.com>
 <ZcuLSkvPuyMXsQeD@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcuLSkvPuyMXsQeD@lpieralisi>
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 1207ca51-8343-42a5-7f9d-08dc2cac93ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ViANQDlPSq0Gc95hyFF2PozcwnThAh+IORCoXGsuzaX4aQz13ctcZ9AJ+0GAIuisM+NNhhMGAK/8YAd7+Q4GxhZEPNYTmjeTGxuTU+G7zjUJyTwWUoA27iFebkjI8eeOWwWKP2B6yxMKahUb4w3RE36q9tDO5upNYA/oWDJlek0nDv5usR9PyythOvIiD4UUjLiWoQgAFcG/o8/quCNz0Y4/CrYezr135u521g6hFu0HM63oZbog3gLlMkbiVIF+F/DgALus6iM7KFKOFuH16UN/WI9vAdSrda/xtcxlaM/kzZFTw1h9coFzNBjNIZvFNfpCluPvJq3NbFCoZpv2TOnQ9ItUMb48jc9afTK6xrFigq7Q1udOfLfjrjPkoAkHSKJZDY0SoButXJtKdSDx6rvxI/TmhuEnxf++rZiTeiH3oQxIw//zvEI9/f09E2RZDRqu8J3D76wPZ9T35mANFtdxUtLQHQgIDOkT9Ar06qbvKCgoRvK/w0PZFGU+UwG1ZWV/rZPJa/vExkqUXZcaxOlp4gKv49J0Qy0QaQOdFFOkvwPFTAV5yIzPiFKzO3tHHpbgUvqjEoUi83S9Hljg1TflnUEDMtqCoCDps5Duzb0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(26005)(38100700002)(66899024)(4326008)(6916009)(30864003)(7416002)(5660300002)(8676002)(8936002)(66946007)(66556008)(9686003)(2906002)(6486002)(478600001)(6512007)(6506007)(966005)(316002)(41300700001)(52116002)(38350700005)(6666004)(66476007)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WIFdOwTgFl+U5Wqo6l19BcuTh/H1IXpYswy0H78vatIQKoleWH0ND1eXl+Ma?=
 =?us-ascii?Q?bqV9iKtDs0LFK+LuJwvu2HrDvL39s/i7bOsCXEj611s+AyxrnQPQEP2BUlWR?=
 =?us-ascii?Q?jVRAE5d9TVjp/T6JTTRlNoGR0KYpQythecJMMibVohfj0+5kLjdTqOOhjV/+?=
 =?us-ascii?Q?O981B/A/Id+vRK0VuKk+hpzwxSMJwZXfLgx0/DQsGL32iFkMc6N30zvqKPNM?=
 =?us-ascii?Q?2vIpJpZTcNbmsDcKBNbXITwcgsi5+9pW/XNMkkQ1zDTurrfy9OxqElPnU1uu?=
 =?us-ascii?Q?r+JYrnDJzYnJPQbPsTekc6bJz3dnhEJodBh1ShgvdoDcy+ueaaqPz7zA10Jw?=
 =?us-ascii?Q?b0YBKDWLiYMLYBE2vsXYFBbzHG/z7XgOcEfwPIUnzynxru/DQ/VnZ9AxfvdX?=
 =?us-ascii?Q?ienn/kxmQAy3KfebD0ZVVnlvpMDYQq36QyHqu826S3T/9GPTp9XJqReomWPa?=
 =?us-ascii?Q?drKAqffCI0Ca2RY71qMjTPNGcKCz9sldj709dOx5LnFdO4HTjTcQLWZW+okC?=
 =?us-ascii?Q?72qmt5bw1pcut12jgi3H1IBVkElOLDLYAiceHn+Dlrq3PswfCw8AjsEdoG8D?=
 =?us-ascii?Q?hNOWhHa3lCmfPBlPRqzLoty0TSkVR4nFfGduLKeUHEyrZB2LI260gaJ2bHFW?=
 =?us-ascii?Q?xx7lKmA9wiMjZAIjT0X5GmTzVViYQLhzz+RxbX0EudDzq3Hv2W+C2MSSqF1d?=
 =?us-ascii?Q?17fN2nNLZEaRvBm1fjjIdhEIo4nakoEEMQ4F6YKP5dvlFvf1UnfmdhAy6+QS?=
 =?us-ascii?Q?WrYoGpPmB9CNrk5XZT89EGfcYyFd+/EKa4lzRwemJkSoom08MgSaCIE1oHy6?=
 =?us-ascii?Q?M6vnOKl0z9qh1dGar3qOvMiZS0MOuLh4juySyLDhuFqyzUJHXsR9er0b2ysC?=
 =?us-ascii?Q?BqvxLS8s4vIKcQ6v5UQyOyenBga+IKBXaPsshFVCgUIVll8ELXRw8nZ7UpWb?=
 =?us-ascii?Q?Qk1cSSbV2Sk/+3Sitejy+8INAEvE0Dnc16D6j0566rJqz5ALlYhWBgGmkdnU?=
 =?us-ascii?Q?9PTTZxOeY9x67wlEW82Syk326hTlW+NfrYfrgHrA1aPHynQdnzRJRT6xevf9?=
 =?us-ascii?Q?25yVCPCZe4TTPWdpkoef1O2jQ31yC+wAfbW23UBlvPQHpcHJDt1F5cYAh/li?=
 =?us-ascii?Q?Sz84JajJr/7sjb7DbZb2qX2wEJij0+XVScSAaKBwWk/RY2aCWoDlzG5yoXiG?=
 =?us-ascii?Q?FmN17ANXucnWlyY8b39pYvVjpqZJqAKlewcjWGjcyB1VM3bN3kl4w9wNF4B5?=
 =?us-ascii?Q?Z1Gb6inaQQpBve473U3mpHAd+F3YoHktZu9V+mBqfeRof9bi7OIxPCgIn0Sj?=
 =?us-ascii?Q?qWjNdj9xNLHecegpMeZWcjrHH/YkCneqD2goKaHshrr8zjVlTJE+a6FCNMW+?=
 =?us-ascii?Q?ZWrBTUZJP/6d8Kx06ZT2KflHo3JKQRRg0g7ICx70P5iXDjo+uNgSw9gXhtVK?=
 =?us-ascii?Q?Cu5DDcN4dgpb9fReIC0/jLOwOrywWhfqj0Ub0xJnPavNZhrKzAoczWblbJuD?=
 =?us-ascii?Q?YTwYzF9brPGuRj4MMR6XxU5g0MH9mSpiUO4b1Jz0stmtV91dBKdTzj0ywDEq?=
 =?us-ascii?Q?xSM3DPb9TxQppfLGF7w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1207ca51-8343-42a5-7f9d-08dc2cac93ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 15:58:10.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLYytubO726SCr6YqSLdiNrMcG1WpdpL1hfy2Zdm5BghwVIjD2UdzUORUNW+ln0YTYJcDEx1RykM7uaJsMFlRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9678

On Tue, Feb 13, 2024 at 04:31:22PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Feb 05, 2024 at 12:33:22PM -0500, Frank Li wrote:
> > Refector the clock handling logic. Add 'clk_names' define in drvdata. Use
> > clk_bulk*() api simplify the code.
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v9 to v10
> >     - fixed missed delete a case, which need failthrough to next one.
> >     Change from v8 to v9
> >     - change clks names
> >     - Add Manivannan's review tag
> >     
> >     Change from v7 to v8
> >     - update comment message
> >     - using ARRAY_SIZE to count clk_names.
> >     Change from v6 to v7
> >     - none
> >     Change from v4 to v5
> >     - update commit message
> >     - direct using clk name list, instead of macro
> >     - still keep caculate clk list count because sizeof return pre allocated
> >     array size.
> >     
> >     Change from v3 to v4
> >     - using clk_bulk_*() API
> >     Change from v1 to v3
> >     - none
> >     
> >     Change from v4 to v5
> >     - update commit message
> >     - direct using clk name list, instead of macro
> >     - still keep caculate clk list count because sizeof return pre allocated
> >     array size.
> >     
> >     Change from v3 to v4
> >     - using clk_bulk_*() API
> >     Change from v1 to v3
> >     - none
> >     
> >     Change from v8 to v9
> >     - change clks names
> >     - Add Manivannan's review tag
> >     
> >     Change from v7 to v8
> >     - update comment message
> >     - using ARRAY_SIZE to count clk_names.
> >     Change from v6 to v7
> >     - none
> >     Change from v4 to v5
> >     - update commit message
> >     - direct using clk name list, instead of macro
> >     - still keep caculate clk list count because sizeof return pre allocated
> >     array size.
> >     
> >     Change from v3 to v4
> >     - using clk_bulk_*() API
> >     Change from v1 to v3
> >     - none
> >     
> >     Change from v4 to v5
> >     - update commit message
> >     - direct using clk name list, instead of macro
> >     - still keep caculate clk list count because sizeof return pre allocated
> >     array size.
> >     
> >     Change from v3 to v4
> >     - using clk_bulk_*() API
> >     Change from v1 to v3
> >     - none
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 138 ++++++++++----------------
> >  1 file changed, 50 insertions(+), 88 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 74703362aeec7..82854e94c5621 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -61,12 +61,16 @@ enum imx6_pcie_variants {
> >  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
> >  #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
> >  
> > +#define IMX6_PCIE_MAX_CLKS       6
> > +
> >  struct imx6_pcie_drvdata {
> >  	enum imx6_pcie_variants variant;
> >  	enum dw_pcie_device_mode mode;
> >  	u32 flags;
> >  	int dbi_length;
> >  	const char *gpr;
> > +	const char * const *clk_names;
> > +	const u32 clks_cnt;
> >  };
> >  
> >  struct imx6_pcie {
> > @@ -74,11 +78,7 @@ struct imx6_pcie {
> >  	int			reset_gpio;
> >  	bool			gpio_active_high;
> >  	bool			link_is_up;
> > -	struct clk		*pcie_bus;
> > -	struct clk		*pcie_phy;
> > -	struct clk		*pcie_inbound_axi;
> > -	struct clk		*pcie;
> > -	struct clk		*pcie_aux;
> > +	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
> 
> Why can't you allocate this dynamically ?

Engineer choose. clk_bulk_data is small data struct, two pointers (16byte
in 64bit system). clks in imx is 3-4, Over half already used(compared 6).
waste case only wast 48byte.
 
Dynamically allocate can't save much memory, there are some extra manage
meta data for dynamical memory, which may bigger than 48byte.

Frank

> 
> >  	struct regmap		*iomuxc_gpr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> > @@ -407,13 +407,18 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
> >  
> >  static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
> >  {
> > -	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
> > +	unsigned long phy_rate = 0;
> >  	int mult, div;
> >  	u16 val;
> > +	int i;
> >  
> >  	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
> >  		return 0;
> >  
> > +	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
> > +		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
> > +			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
> > +
> >  	switch (phy_rate) {
> >  	case 125000000:
> >  		/*
> > @@ -550,19 +555,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
> >  
> >  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  {
> > -	struct dw_pcie *pci = imx6_pcie->pci;
> > -	struct device *dev = pci->dev;
> >  	unsigned int offset;
> >  	int ret = 0;
> >  
> >  	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX6SX:
> > -		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> > -		if (ret) {
> > -			dev_err(dev, "unable to enable pcie_axi clock\n");
> > -			break;
> > -		}
> > -
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> >  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> >  		break;
> > @@ -589,12 +586,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  	case IMX8MQ_EP:
> >  	case IMX8MP:
> >  	case IMX8MP_EP:
> > -		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
> > -		if (ret) {
> > -			dev_err(dev, "unable to enable pcie_aux clock\n");
> > -			break;
> > -		}
> > -
> >  		offset = imx6_pcie_grp_offset(imx6_pcie);
> >  		/*
> >  		 * Set the over ride low and enabled
> > @@ -615,9 +606,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  {
> >  	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > -		break;
> >  	case IMX6QP:
> >  	case IMX6Q:
> >  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > @@ -631,14 +619,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
> >  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> >  				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> >  		break;
> > -	case IMX8MM:
> > -	case IMX8MM_EP:
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -	case IMX8MP:
> > -	case IMX8MP_EP:
> > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > -		break;
> >  	default:
> >  		break;
> >  	}
> > @@ -650,23 +630,9 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> >  	struct device *dev = pci->dev;
> >  	int ret;
> >  
> > -	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie_phy clock\n");
> > +	ret = clk_bulk_prepare_enable(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
> > +	if (ret)
> >  		return ret;
> > -	}
> > -
> > -	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie_bus clock\n");
> > -		goto err_pcie_bus;
> > -	}
> > -
> > -	ret = clk_prepare_enable(imx6_pcie->pcie);
> > -	if (ret) {
> > -		dev_err(dev, "unable to enable pcie clock\n");
> > -		goto err_pcie;
> > -	}
> >  
> >  	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
> >  	if (ret) {
> > @@ -679,11 +645,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> >  	return 0;
> >  
> >  err_ref_clk:
> > -	clk_disable_unprepare(imx6_pcie->pcie);
> > -err_pcie:
> > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > -err_pcie_bus:
> > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
> >  
> >  	return ret;
> >  }
> > @@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
> >  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
> >  {
> >  	imx6_pcie_disable_ref_clk(imx6_pcie);
> > -	clk_disable_unprepare(imx6_pcie->pcie);
> > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > +	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
> >  }
> >  
> >  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> > @@ -1252,6 +1212,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	struct device_node *node = dev->of_node;
> >  	int ret;
> >  	u16 val;
> > +	int i;
> >  
> >  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
> >  	if (!imx6_pcie)
> > @@ -1305,32 +1266,20 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  		return imx6_pcie->reset_gpio;
> >  	}
> >  
> > -	/* Fetch clocks */
> > -	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
> > -	if (IS_ERR(imx6_pcie->pcie_bus))
> > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
> > -				     "pcie_bus clock source missing or invalid\n");
> > +	if (imx6_pcie->drvdata->clks_cnt >= IMX6_PCIE_MAX_CLKS)
> > +		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
> 
> Same question as above, this should not fail if the clks array is
> dynamically allocated according to imx6_pcie->drvdata->clks_cnt.

Devm_kzalloc also may return NULL. Still need check. This safe check only
meanful when add new platform. imx6_pcie->drvdata->clks_cnt is static data.

It should never failure at running time. But, devm_kzalloc may failure
at run time.

It is not big deal. It's most likely personal tast. For small static data,
I perfer use static memory.

Frank

> 
> Lorenzo
> 
> >  
> > -	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
> > -	if (IS_ERR(imx6_pcie->pcie))
> > -		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
> > -				     "pcie clock source missing or invalid\n");
> > +	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
> > +		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
> > +
> > +	/* Fetch clocks */
> > +	ret = devm_clk_bulk_get(dev, imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
> > +	if (ret)
> > +		return ret;
> >  
> >  	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
> > -							   "pcie_inbound_axi");
> > -		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
> > -					     "pcie_inbound_axi clock missing or invalid\n");
> > -		break;
> >  	case IMX8MQ:
> >  	case IMX8MQ_EP:
> > -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > -		if (IS_ERR(imx6_pcie->pcie_aux))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> > -					     "pcie_aux clock source missing or invalid\n");
> > -		fallthrough;
> >  	case IMX7D:
> >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> >  			imx6_pcie->controller_id = 1;
> > @@ -1353,10 +1302,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	case IMX8MM_EP:
> >  	case IMX8MP:
> >  	case IMX8MP_EP:
> > -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > -		if (IS_ERR(imx6_pcie->pcie_aux))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
> > -					     "pcie_aux clock source missing or invalid\n");
> >  		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> >  									 "apps");
> >  		if (IS_ERR(imx6_pcie->apps_reset))
> > @@ -1372,14 +1317,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  	default:
> >  		break;
> >  	}
> > -	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
> > -	if (imx6_pcie->phy == NULL) {
> > -		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
> > -		if (IS_ERR(imx6_pcie->pcie_phy))
> > -			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
> > -					     "pcie_phy clock source missing or invalid\n");
> > -	}
> > -
> >  
> >  	/* Grab turnoff reset */
> >  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> > @@ -1470,6 +1407,11 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
> >  	imx6_pcie_assert_core_reset(imx6_pcie);
> >  }
> >  
> > +static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
> > +static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
> > +static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
> > +static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
> > +
> >  static const struct imx6_pcie_drvdata drvdata[] = {
> >  	[IMX6Q] = {
> >  		.variant = IMX6Q,
> > @@ -1477,6 +1419,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
> >  		.dbi_length = 0x200,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > +		.clk_names = imx6q_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx6q_clks),
> >  	},
> >  	[IMX6SX] = {
> >  		.variant = IMX6SX,
> > @@ -1484,6 +1428,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
> >  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > +		.clk_names = imx6sx_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
> >  	},
> >  	[IMX6QP] = {
> >  		.variant = IMX6QP,
> > @@ -1492,40 +1438,56 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.dbi_length = 0x200,
> >  		.gpr = "fsl,imx6q-iomuxc-gpr",
> > +		.clk_names = imx6q_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx6q_clks),
> >  	},
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx7d-iomuxc-gpr",
> > +		.clk_names = imx6q_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx6q_clks),
> >  	},
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > +		.clk_names = imx8mq_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > +		.clk_names = imx8mm_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> >  		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > +		.clk_names = imx8mm_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> >  	},
> >  	[IMX8MQ_EP] = {
> >  		.variant = IMX8MQ_EP,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> > +		.clk_names = imx8mq_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> > +		.clk_names = imx8mm_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> > +		.clk_names = imx8mm_clks,
> > +		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
> >  	},
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

