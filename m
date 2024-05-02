Return-Path: <linux-pci+bounces-7023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA268BA0F2
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 21:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544C9282E36
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF5C179967;
	Thu,  2 May 2024 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y41VGSyf"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9AC16D9C8;
	Thu,  2 May 2024 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677485; cv=fail; b=Tyjtn8VeTGcxWgQeAmMi1KE6o6LZnDE3tX9Di0A/AyBzGQKWvIMjXat+e9ILjCGijTDETNyvTrqMaEXyxqb8zYtY6I91dpKVH5c0rapnRCCODhUkBvGWfDLgP9Lu9DSXefNH5IJ9afBmYQjFpkszUv8YL2z0fQVGcnqvbVBjnX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677485; c=relaxed/simple;
	bh=bTmMJnyLljgx3qQHzPwilSwyr+zE0UFqQYb570TE3qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o4xPQO8YyBlItU2dYOxUXm8sqxCWI/yU/fQpGf8HU7eWNrx6ze5ZpeDyocBP+26FdTeN/+8lnomSxU11Oo68kFi0j6cqsnqy28ohNK3kMI3e5QHNAv86rkVLCe46J49C1Q6UuI7Cb7JAFG0EXKlwC3AWu6y2Z15VlNsafpZmSXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y41VGSyf; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giwrYpfcvmAcD8oxQQxTXGCTItaur7/L4s3bdsqKsTiFHEDHYm97eslHwDr1zVJQackrqvpYEu0zTSkskbDETLeWHrbPYLW76gxq282T8TDOLviurnQUrutQJkUSjXGEXn0seDTslCd7mFWn6LnoZqNlVUxEALtdVvxmW+EbT97OypwJer/MXzv+QMG0ojK8OmRsUtJWGytSLJbUayjf+Fv/O2GxmXQSp+ppp5x+aPYNeHTSPB8cDkpR+tnIeJVApHY5gobqLBm3IM2iWiH5MWLSwideDTgFkg5R0O+EPmrqcZd9nm/KeX00/ZRmhxMtltpffzw+3dapwYpQRvuEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRswEMBdS+SlpM0F6Hzo1PAAdIlG57L5nWY14JJRDHs=;
 b=azmr7jguYtSp1DVO6GuKWwLp/j2uVnIMl+op2s9lhB8/sS7spTp561hcYAV5f3SJ1Tc9/JnPN1QNLyEgYAhfBfpLimsnB/aUz+XgbFVUp9/WpIGB4DT4RAP087u3RqB7xqMEVtH+qkkV4iianN6rsYC0kEzEeXZtNNCljt+tVzncLPl4cNN79jOwwu+yCIv2sl6LQN83dbSV1iCoJJ4PlCL9ETIeMZl+WbP8LODVz4DTSmvjUPbFuySRm6RQBAnl1KA+HUdycUgVScuLbMeWVxEu+Qghb9QQ3BTZREyf7ve5e5l9lP3vsRLFS2+ljAnnkPquzTgT5lfnbVvoEZg0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRswEMBdS+SlpM0F6Hzo1PAAdIlG57L5nWY14JJRDHs=;
 b=Y41VGSyfc3+p56vZNngBHM/LO3fIIVacrLC8UHBlTeMxpFbMsLSbW/Era0JkQLFr3X+2u4/qHRIIDl4mScQwOJOs8FSLje9eNLQTYkC2v27UMVo9/q5PW2k6pXUjWWStZz4uTzbHxXkTuM28moFc4/e7ce0kzQqsTFkhf+Fjtpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 19:17:59 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 19:17:59 +0000
Date: Thu, 2 May 2024 15:17:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v8 0/5] PCI: dwc: Add common pme_turn_off message by
 using outbound iATU
Message-ID: <ZjPm3oSQQW6B8vm1@lizhi-Precision-Tower-5810>
References: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5d3846-ba4f-4d50-9722-08dc6adc945e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|376005|52116005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zlzgwf5bv5Kw/Vl+j0Ih/AaoFFpwWTFrsnxiFxJSETZUR2l+0EsemCmy3nNf?=
 =?us-ascii?Q?ZgrvJncE0xVE2sCNuEmZBIlojKhaGykXHLlEayVvQrEMZSFFNCV9c8/07+Gb?=
 =?us-ascii?Q?2ljAXLBnycQ6oWhoUheHVPOreGsBt9LwjeeaYTCwaBl9WyNuSiTN7JvFNbrO?=
 =?us-ascii?Q?ke3v9liJwFYFkVxzUQ0ygP3iykdSgkFkO/oOu01BrvK0zM9mUorTRkzHIFX/?=
 =?us-ascii?Q?RrB4TGwm3thEsgfV7Twc9Us/STTXxcOSM+m1qP03wp6CX5g0fwQp6fQZGdEB?=
 =?us-ascii?Q?Q8gE4aL4xaGnjndzJ8YxJYG60GH2H34ojVP23z1BLMDXDlgjc2TCV//1JKIv?=
 =?us-ascii?Q?Z0RFOxLTIiLaY1trmXrt7TfVwePn22qTxYxJeNlXVq7c7CR/jKDdSJASAZSu?=
 =?us-ascii?Q?VpD9vt9xXcxg3sGpw+fRQ3Nr4nDM4jw4XD60o3yxeZnxvRrC5ZI9lrT96bnx?=
 =?us-ascii?Q?B7W8DP6U2Il/pJcdHLUuKj2+zIr4tThI2J2sb4wAWWIZtoNB3dybC59K2FNO?=
 =?us-ascii?Q?h1HP4X4BHkQ+wtxe2e4PWNZ258pzPLdAvSb2I+24lOxn7i1YcwTx+LlMgvif?=
 =?us-ascii?Q?HodmMFDd6u2j/YWSDey4HYOECJw4wxzaRmHgXoGi6srAC/JOmuoxrV8Mhrsh?=
 =?us-ascii?Q?p0JL03WweIHL3wsgrM+OEwrT5kkY20Baj8+fKn3IlgUvYpnmr/tnRdflud4w?=
 =?us-ascii?Q?5gQF3qgb4VWu9KXwnJfPqQDEzZOhpnWAayG2rpmv/W3qrZ/4F9kcy/pSuV/3?=
 =?us-ascii?Q?78vRSA1ZrP7LJWqFfMkvfI6uGezcKnMO0LZPOtkffCrOzHBST1WGdu19FrCF?=
 =?us-ascii?Q?6+s18BqX3CjtZdZwIIjPogORlIfMt8fnLYqHcFEtJXL48LT3wmfvtrSENTfS?=
 =?us-ascii?Q?6woL/n7gfEbWTb79Smx/EWseZ/3JLtZzS04pJdLPVFl6nJJNchBgQV1az/2W?=
 =?us-ascii?Q?n/shjYMZZzsw/isui0DJjI1586Pl/yPVs/2t2LItWVUqWk/bM5GDqs20h3gA?=
 =?us-ascii?Q?IHDpKBVt2cVcCSkL7k3uK67iKh56mgk+WjfpBrE5ixnE4taecuyfkauk1GHC?=
 =?us-ascii?Q?TVhQd0B81UICp6W13eweBo3at60WRd7shux3fzMwWXDcdYuZiupEEGYUb7mo?=
 =?us-ascii?Q?oHFxPmGvafEexquFUvcG9UhPSYG6upTv82Hn/BTbz0h2QcYFUv/zm4H6Rrcp?=
 =?us-ascii?Q?wrtIhNvZp3UJmgo6aWrVYkz2LDxnmeuS6cSJSe8KwmIEwIiBi77vY5muyd3D?=
 =?us-ascii?Q?S2XjAa98H1eNJPx/WOl/q57NoC+zq/smdYt8v7K1B2BrZuaXqAhdshb34Q8I?=
 =?us-ascii?Q?2Z13ARAFeMIXdxtsizQoQxTf/stxsJJ74HrpzMYOGyrhMGohw8FmfBTKl1WD?=
 =?us-ascii?Q?mTjNp/E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sNHKWL7UyohbT8OsS7xQTVazFmpfYPt8H9ycGhMyQA4MjGfa+O1RFqOwpbqd?=
 =?us-ascii?Q?L8sq/a4MntAN4//oLUv9Nz7QjZrHpq+SEyrnR7TKN6vmtVIXYvMJsatoyFz1?=
 =?us-ascii?Q?3mZlOLsUVACn7OLkeQ8tSb1ajI4PneC2ddyUm78W3Tnzwfqf9rHZLFfSfEi+?=
 =?us-ascii?Q?NoC3wYzKAWVg50f0sKm5qEu2qpkCfy/QXj2g8r/ypPGoKyFi3ys+0LF7B9uJ?=
 =?us-ascii?Q?WpBoQzikLJ7fExwCr8GQ/hIFQ25HV0wr0PKNxSMWJwWeNi9E5pKMgAOav3My?=
 =?us-ascii?Q?HZKXJq1HYjAq/H+2yfrle5S+VyfxsArU2g4j0k2cN0lwDM75JmZfu2DMGp0t?=
 =?us-ascii?Q?PCiC20PBwRj24/SPwA7fQliVtxK8eT69MGthi5vqaPKgYDXnVtrbTNN2F9ec?=
 =?us-ascii?Q?PS6UnTuMpLETtVqqWlRiBptzpftmkt9b8/B8wj2kdEELhHwAwRGsEwPHwrK9?=
 =?us-ascii?Q?GgUDLXwrgdOVN4MKIv1/gl7tzZjjoGyasBE5m2gQ+txagIhZ/DYpM/IkO8wb?=
 =?us-ascii?Q?cXWR45EVUIBT063vqq2nlfvBQ3uQETGc86/uX0F7qnDjCHd5oXKNnjCfoiif?=
 =?us-ascii?Q?WCDf5Iv8SPfUrNW3s+Yk0Wlp28vFMb8IKFc3wvQOlw+1xmiD5VQsZMdF5pgO?=
 =?us-ascii?Q?12fgpAZcBr6qDo4lBjXB1VTa8uY2j/4uQeEa5TbcFikP2OjLTmphvE26lP2V?=
 =?us-ascii?Q?8tDkA9h7kbj9ozGsusRHx9JbVNCktG5rO5EnvrokOpuR6pqkud4Stf/ukXpe?=
 =?us-ascii?Q?sbvg2ATZh6h9sMuD+ri4daJW22vS8dSlgxgZTmapNZG77gARIJERb5M8U2s7?=
 =?us-ascii?Q?K9+KYRPvlxWzeeCPPH7C9+NqB85U8jcoqqL/XbYM9CXzVhR6rIiMcrPbTbob?=
 =?us-ascii?Q?Cz8uT1wCVt/f+eU+q3HTnjYD5lIuD4Dhoe6S2Lso7dvCOyiPfKbSY3hcwFWg?=
 =?us-ascii?Q?Y+6LHnV1EhC4yf/Iw8X9IhWIuNZ7FBT49BJZZLpSwkCtvOkAthGQY5LBLZbc?=
 =?us-ascii?Q?nC7MkE7sjOuocxUqvsucTArjrN5vbjxRWUJXyoO0K5YCRP1cA18axUvq1Us9?=
 =?us-ascii?Q?/1R41spHCSEn0pvCWd/xtju/ofXDE1X1kbKxn/JoHS1ze42b3ZYxSWFLrb0e?=
 =?us-ascii?Q?zZ+q/ArxutUOLaR879KznWZy++cSLsZqQvUj185V2ZwN7I6MamFTepwhXE2g?=
 =?us-ascii?Q?mXVTW+eQOqG0EN6xf8sr94Up/NJTO6obWqiQItsBvZUmi0jLd5gZUfdcFX0G?=
 =?us-ascii?Q?StkArmrkX1BRhIcQ2UbmS4BrtQV92B8mIK29nB5QVwB59c7IeFCOTpQoHun2?=
 =?us-ascii?Q?hz75pgqVigN+RjyBCUKPi/kAOKr83dS0CxShnXtNJeGbEZjBU4vnNYeBDvgf?=
 =?us-ascii?Q?XtUpiGNVjXvPbIA2NTWAueLKce6A+P12QspcAOgbKPlepNnSZygpbi5vA33K?=
 =?us-ascii?Q?PC5oXrh4HOJ6Fzob9Y6st/T9aNs/0ylfkL9OpSQWlL+MPjKcltKi8Xxbg9Iu?=
 =?us-ascii?Q?JPrHkJLbTOBYhHmKmkuCK6u5IRUzQf0JZggIm08xzPlOuLQpKq/ZcMLwwTa+?=
 =?us-ascii?Q?pMYY9pTJiUWtX8yxB80=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5d3846-ba4f-4d50-9722-08dc6adc945e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 19:17:59.5448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYQXcAilcV8lwc/mhcb0yvrHpfsk3whW9FLfl2Ab7VyKWUMBHAnyB3MGh4xKMxLAbbbx6eELuv7RE0e2y7El8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229

On Thu, Apr 18, 2024 at 12:04:23PM -0400, Frank Li wrote:
> Involve an new and common mathod to send pme_turn_off() message. Previously
> pme_turn_off() implement by platform related special register to trigge    
> it.                                                                        
>                                                                            
> But Yoshihiro give good idea by using iATU to send out message. Previously 
> Yoshihiro provide patches to raise INTx message by dummy write to outbound 
> iATU.                                                                      
>                                                                            
> Use similar mathod to send out pme_turn_off message.                       
>                                                                            
> Previous two patches is picked from Yoshihiro' big patch serialise.        
>  PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()                 
>  PCI: Add INTx Mechanism Messages macros                                   
>                                                                            
> PCI: Add PME_TURN_OFF message macro                                        
> dt-bindings: PCI: dwc: Add 'msg" register region, Add "msg" region to use  
> to map PCI msg.                                                            
>                                                                            
> PCI: dwc: Add common pme_turn_off message method                           
> Using common pme_turn_off() message if platform have not define their.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Lorenzo:

	Could you please pick up these patches? All have been reviewed and
acked by Bjorn/Mani? If you have more comments, let me know.

Frank

> ---
> Changes in v8:
> - Total use devm_ manage msg_res. after read devres.c code to better
> understand release sequence. It use reverse order to release resource. So
> it is safe for msg_res.
> - Add Reviewed tag of Manivannan Sadhasivam in patch 4/5
> - Link to v7: https://lore.kernel.org/r/20240417-pme_msg-v7-0-9c6208cda90f@nxp.com
> 
> Changes in v7:
>   patch 4/5 add
>   /* Power Management Messages; PCIe r6.0, sec 2.2.8.2 */
>   patch 1/5 change comment to
>   /* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
>   /* INTx Mechanism Messages; PCIe r6.0, sec 2.2.8.1 */
> 
>   order according to value.
>   Add Acked-by: Bjorn Helgaas <bhelgaas@google.com> in patch 4/5
> 
>   patch 5/5
>   Apply all mani's comments.
> 
> - Link to v6: https://lore.kernel.org/r/20240415-pme_msg-v6-0-56dad968ad3a@nxp.com
> 
> Changes in v6:
> - Move PCIE_MSG_CODE_PME_TURN_OFF ahead before INTx to keep the codes
> sorted.
> - Added reason why not alloc_resesource in commit messag.
> - Change title PCI: dwc: Add generic MSG TLP support for sending
> PME_Turn_Off when system suspend.
> - Rework commit message
>   "Instead of relying on the vendor specific implementations to send the
> PME_Turn_Off message, let's introduce a generic way of sending the message using
> the MSG TLP.
> 
> This is achieved by reserving a region for MSG TLP of size 'pci->region_align',
> at the end of the first IORESOURCE_MEM window of the host bridge. And then
> sending the PME_Turn_Off message during system suspend with the help of iATU.
> 
> It should be noted that this generic implementation is optional for the glue
> drivers and can be overridden by a custom 'pme_turn_off' callback.
> 
> - using devm_request_resource()
> - using mani's suggest comments
> 
> 	/*
> 	 * Allocate the resource for MSG TLP before programming the iATU
> 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> 	 * on the value of 'region_align', this has to be done after
> 	 * dw_pcie_iatu_detect().
> 	 */
> 
> - Add comments, about use_atu_msg, need glue driver set it.
> 
> - m -> mem in dw_pcie_pme_turn_off()
> 
> - remove redundant check() if (!atu.size) in dw_pcie_pme_turn_off().
> 
> - The reason can't adjust windows->end
> This windows already reported to pci system before this function. It is
> not good to modify window-res-end. It just add child resource like below.
> 
> windows is root resource, which will create may child when call
> request_resource.
>           bridge -> windows
> 		child1 -> msg
> 		child2 -> pci ep1
> 		child3 -> pci_ep2.
> 		...
> 
> Although you see whole bridge window, 'msg' already used and put under root
> resource,  new pci devices will never use 'msg' resource. 
> 
> If change windows->res->end here, I worry about it may broken resource
> tree.
> 
> Detail below thread:
> 
> - Link to v5: https://lore.kernel.org/r/20240319-pme_msg-v5-0-af9ffe57f432@nxp.com
> 
> Changes in v5:
> - Default disable allocate TLP message memory windows. If driver need use
> this feature, need set use_atu_msg = true before call dw_host_init().
> 
> - Link to v4: https://lore.kernel.org/r/20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com
> 
> Changes in v4:
> - Remove dt-binding patch. Needn't change any dts file and binding doc.
>   Reserve a region at end of first IORESOURCE_MEM window by call
>   request_resource(). So PCIe stack will not use this reserve region to any
> PCIe devices.
>   I tested it by reserve at begin of IORESOURCE_MEM window. PCIe stack
> will skip it as expection.
> 
>   Fixed a issue, forget set iATU index when sent PME_turn_off.
> 
> - Link to v3: https://lore.kernel.org/r/20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com
> 
> Changes in v3:
> - fix 'MSG"
> - Add pcie spec ref in head file
> - using function name dw_pci_pme_turn_off()
> - Using PCIE_ prefix macro
> - Link to v2: https://lore.kernel.org/r/20240201-pme_msg-v2-0-6767052fe6a4@nxp.com
> 
> Changes in v2:
>   - Add my sign off at PCI: dwc: Add outbound MSG TLPs support
>   - Add Bjorn review tag at  Add INTx Mechanism Messages macros
>   - using PME_Turn_Off match PCIe spec
>   - ref to pcie spec v6.1
>   - using section number.
> 
> - Link to v1: https://lore.kernel.org/r/20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com
> 
> ---
> Frank Li (2):
>       PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
>       PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend
> 
> Yoshihiro Shimoda (3):
>       PCI: Add INTx Mechanism Messages macros
>       PCI: dwc: Consolidate args of dw_pcie_prog_outbound_atu() into a structure
>       PCI: dwc: Add outbound MSG TLPs support
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  21 ++--
>  drivers/pci/controller/dwc/pcie-designware-host.c | 145 +++++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c      |  54 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h      |  22 +++-
>  drivers/pci/pci.h                                 |  21 ++++
>  5 files changed, 199 insertions(+), 64 deletions(-)
> ---
> base-commit: ef6a734484e939cf67bc41c45bc936a78ea210f0
> change-id: 20240130-pme_msg-dd2d81ee9886
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

