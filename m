Return-Path: <linux-pci+bounces-39355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCAC0BD62
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 06:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE24E248F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 05:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982C52D47ED;
	Mon, 27 Oct 2025 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UY09avsN"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010008.outbound.protection.outlook.com [52.101.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874C198A11;
	Mon, 27 Oct 2025 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543625; cv=fail; b=sZ7XYZ3nya1lgrGheBBip/Qb0RzuQLjQAb8sFtRSL5wS6zQSy9GK72WBmpSGTZyjxwR8U1IaGSsakKzrBCQxMKhLRubsPb6aUXqf04FB20vavfJrxuXL7mjb28y2cfFxlJI8kqM3SOi5jPw3z2FHvzgsi7EKn3l115t+xZFDFRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543625; c=relaxed/simple;
	bh=oGtYbNGPsgZnNTWN1hJjw6TRI+9zzpCdB/tTLpjJi40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HttIi5EwXA4p0SGTGeeXcxSZZ4q+83sCuQkLrX90ZaI6V1M+6kTkuryUFbwIMSGq9w0DGN5k6XI2TT5T4GpaHI2wY1T67qDpmr4q3Ebccc5nrNjZ/G2X4n9CYb7578SYvTTQuLzbm6/M9h0TnXzUAy7VY41OhOG08ZAkjWOF6no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UY09avsN; arc=fail smtp.client-ip=52.101.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I16ieMG8g/Za2KFYoqzIdxAgQ3IV65O+7ywTmqUYaE0ckfbLLwYex+fh57Ib5jy+xRw1C7d+Jjl9Cn8iRq8VsFD8Xmtmum/EG7smi3/NdOas2VdVJGm2qIs7m+IY5HxXwiAtGzYk2CUp8C7relTy6kTup2iK4lyg+dN86VvA3V4+XvLDk02VdreWorwruLl1VRZjsdHeiJT2vKdrkQFpHE/JJb/0zcKwF36UrfO9KIIopiezTLresUkn06joO9tsh2B1ATiT2M3wbb8Zha77iD8JdzFtC31geV8IE2DLPgHbnT+xIbQoRKtnE2DZpgAk6HswwvZyyYGd1hO2SyXFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97+1YxGe/s1Etpuln6KKVS8u9uiNuXi5b/uPA2NNjEw=;
 b=R68b2JbnuZBK6woV7LUEIY2jWMwzlBNoLg739tg0W8vO0jTNg8pZzsQHov7ujiPsGWvtWhi1vcfpfOjW/WjMM3TFxe3mCBRmKjm24W7oXROJ3ijP8FTLAG3Cw7tY16tYHM+1rIsfGuYbd5h87cWPxcL66RYlpqL71QIKT9Btjeq+1qTkNOSFLRHR0QuVORwhWwR2pslLUwmDI1ljZ/6uK86p+ul6MIcBaohcuoJT8FKvz3alZNYairNugdRRZ1P7FWJkB3E/UmrRfsoWho0ZRWSHUP0fCLX56RpxzHDDg0ct8LL3ola3Uoh5/Qq39D/0tex/KMd6gFUy3l2VUDmY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97+1YxGe/s1Etpuln6KKVS8u9uiNuXi5b/uPA2NNjEw=;
 b=UY09avsNfPmbGUwKes9CoQ0a/c9PXS+kSiskjVm1yaDiQDqRgpbsnNwvWlNU6s3870ggTdtVIXaNGM0NIEerkqS11vyPO9HhjxOcASbJG7oBaJi+KULp7u3v85qHVBJK4cLHwAHbztwqTIz/TeyBtuoq47ZtnOF8ioH9yXxmo+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OSZP286MB1485.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 05:40:20 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 05:40:20 +0000
Date: Mon, 27 Oct 2025 14:40:18 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com, 
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH 5/6] NTB: epf: vntb: Stop cmd_andler work in
 epf_ntb_epc_cleanup
Message-ID: <6o774ql54y5upykegvf5mdfb72ce4w3jpl5dls5wf7lafkle3f@mztkffygiyvk>
References: <20251023071757.901181-1-den@valinux.co.jp>
 <20251023071757.901181-6-den@valinux.co.jp>
 <aPvI/WoHwRm33E1/@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPvI/WoHwRm33E1/@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::12) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OSZP286MB1485:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4fce7a-317f-45e7-ebe7-08de151b5101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MfPB3FpLzaN22fV3EPh2zyGkTExv7/nR4SSyIEfsNzOWLursD0dWT1m9k7wf?=
 =?us-ascii?Q?8JjtrS5GhQs1SaCV0Dm5X4u3wbs6kUlYN/213+MNCLLvnPeFMb29Yo+X3UFI?=
 =?us-ascii?Q?kSUzEoCECFje98fSomB2idSh7bPi9hc/FT5GecqoSRwXeX7pdiobavfJkj5d?=
 =?us-ascii?Q?zsLo4BfBgg7JaMNIiuFZmtV57lGfPcgi5hIKAhG3Fi/PdEKu+exoE13DqEKx?=
 =?us-ascii?Q?iZi+6GI1u0W79WQchd2Diiu4OYl+QFdhnup2UpoGfJ/IO3Gh9g39KxpWVsTU?=
 =?us-ascii?Q?4uvtVve9j42A1dX36INer9qJhfKWm1QYjTgqjpeRdeh+YKdAYgZuYZxVoz7l?=
 =?us-ascii?Q?Vwd3PGtLE/E663JeQlGHQ0UGHqvIL0XvX5Pz4E+YtCEFa3sKVny632w2V/Sh?=
 =?us-ascii?Q?eRq/zNOEuzaXdA7+hVaVipjFf3IIyO5Ef29OiJNhWMy5RbK0LefYpOYArqVO?=
 =?us-ascii?Q?67MWx3x9f+HlGcc8uiEJluiW2O5T/YSyPXPjRcmy9a1GVCFe7vhl9LuP3QAF?=
 =?us-ascii?Q?SsGZ+NwZ15B6r9tO7HxGm/sQe+p5OhSIRl7YejWd+uH0MrRsC/Ar52oVN62F?=
 =?us-ascii?Q?ka3mP/maODG5nuh4plK+I7md5gxhdySFNYlCYsdwxJEmjVedz2zoJ18spp6e?=
 =?us-ascii?Q?6/f9FoBT7DoeoPR8NFn2hihh9bmqFcJPhswlg6FZYjf7ypq85W/2QNAlSlpI?=
 =?us-ascii?Q?us1vkhFf6tQweBwKn/GZiMmcu3/6FLQ68AvFpycyJXqlX/ioOMMQjOZ5WCSt?=
 =?us-ascii?Q?H+KNzh3V1ABFFpfeK5Aeyk27DDkCvmlCygT6BufNwxFwgU59ATOVieJcN24u?=
 =?us-ascii?Q?5uPFxaecaSPyWclRGJR/JnvXiq1OcD3fFzEcZuW7PDTSZrIwOOtTM2QgRpgp?=
 =?us-ascii?Q?RHuy5yDdWy2Oq2xX/LxkCU2hiF1h53rH3b2Ei757B+CB69hcYvOlq6RWnB02?=
 =?us-ascii?Q?76tu78773oEKDNBZ+Jxyb/E61n1da5+XFaS4MD1XrfcfhcoCXgZw4uH01eBK?=
 =?us-ascii?Q?ZAtK7noc6L0lDJGLrhHevmenQHVqHiwQcRdisWGMs6lOBo8muoCExqw4jDiI?=
 =?us-ascii?Q?yO+0Deo5XOF1JKwMlYUX+BdfhcmNtA02TXra9xmwXmqeAnt6p5Mm7RJhGARg?=
 =?us-ascii?Q?/wLhth3HAV6IY7BT1B43HZWeKZYEGQtVU7skBGGi4fycWWViHjyU/NU2CUPW?=
 =?us-ascii?Q?f9NDiqIpqkTCTaHhd2Zm73xSnlZ1wObk0NnEuw/1XMM7dM/O6faVWTJcFhr1?=
 =?us-ascii?Q?+6UCQq4EqcyedKw9MbSu/vglX+mYXTp3WpJD9b71eNqj+meIianuc9hu6ODu?=
 =?us-ascii?Q?6vH760BWfzaQBK6rLtAlPWQj5IG4/dIS3SnjAXAgoH7P8nmaktweSdA23wzZ?=
 =?us-ascii?Q?9XNlbwByAVibj+HtPU5fLDYAEFjozQLmtT8hcJDEkP7Ea/2EI49M0Z1O/3MN?=
 =?us-ascii?Q?II61HWwbjWbOEF/TVFWJSbh5hFCieoay?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?04pU9Wruj4LHQ6QvF3GvMTz+WD3PqZ2629qbyzks57X2oePjTOd/g1dx/Ccg?=
 =?us-ascii?Q?hj+9hXWj832A2lce4EHFmrkQP1vPgaYUCfRC3ajtC7kl8KWjzCyMlUDrgYzZ?=
 =?us-ascii?Q?bPG7U6dOyP+QUDDymyqkQmu9H3FZOa1mukNrEx7GsPhpr2G/5ZAKXSId6zhx?=
 =?us-ascii?Q?rW2S6rc5hvagGyyikC6OuKLzYkaFcQ1yShFTPg9D8eOH/yScSTONgQUabx5j?=
 =?us-ascii?Q?Ejttst1ENaYHINWBeReoR4BRpO0R0anOM7qzaXFXJrdRxjxhZ6Ve2vSIzLjw?=
 =?us-ascii?Q?954Pco6S7oxaZDPJzViI3XsBQzw2VPWt7EDdCrkJJIYjsfwdkKCYDKF5LumY?=
 =?us-ascii?Q?5eQOlRFI/ulC0JzBbwx3OrSk2vtxEbGRFemxvpMuv+OArLubwP+ppiSfh3oA?=
 =?us-ascii?Q?UZ+07WZTYbuV27xYUsAs4L1NMi4tsNzRZ5NEiaJ/eSVgBM4YjWQKZ9hiRSvu?=
 =?us-ascii?Q?g4TMHUUAnLL+l6OUKyPtz59IO9ZLvZF3BtFaDx4xIGz/2oRT3si8kZwRZ8xf?=
 =?us-ascii?Q?pdpe7+EJpaN/2VItqiI7GtzVM9+ZNq1VRjR5iRvREFZPiyyWOmSzK9Jjrdm3?=
 =?us-ascii?Q?tHZ4V71pd4NDuBILMfHYiDiYmA5QEGbFgpxNJun8btJ2I58Of5/p+/sjA3+b?=
 =?us-ascii?Q?kyLRy7k3pb029BsjceZ9x4dKJ8++EaPjI9VKAMJM+A2A0iem/iCHj7Va7M35?=
 =?us-ascii?Q?v0DqFPUs6l52EA7SP771cZe1cMa5qwcdIo0DIeNdinzImA3evXf29b9YBqZW?=
 =?us-ascii?Q?OPkMTGFCn6c7IccF4d4ym0D0A+zsqOY6wCIrsrFLEAjW2AJ3GkmvxgkaeAHh?=
 =?us-ascii?Q?jdu/gXWeoUcLUnVFjIFnuamzc2sEEldACz2vHV2aTRqA+d+LuWtyNTyNge9d?=
 =?us-ascii?Q?JgRCziXtI1LvADjKHdLAxH7MfjIN+/0hLJpcDPUp1umNWxFsyFCjNRUVMXot?=
 =?us-ascii?Q?W98UF9lnv2m7OEvral7EaUtCFgC2EGUT3/yZ/Ll3JMqBlYfht8+2m5ucpFao?=
 =?us-ascii?Q?Yjthq/vIjBTWCjETfL/FP3eKlxXS3psAfkxXe4YS00RBjoYvkyhTnvkDsy7p?=
 =?us-ascii?Q?PgsbPwpVhAbLT+XJSabhALdt22uVf7//LMSm8kltzmvJ75F4f6iyDQIS0mI1?=
 =?us-ascii?Q?62lskftgKrAU3jpYYGaXacyDzK3mGPRkwy1ULBS5taa9h7SeLYb0AfZfTnmg?=
 =?us-ascii?Q?te/wuw91KZVv9U0GDzs8omdUKazpmXm8EijjmANrQBaXxH3YBkr7+9QlmcuS?=
 =?us-ascii?Q?grQnRFtGL8jDoY+YyWVyAR8k1N1yBwWI3vdLsSRuLwOi9cZUwR9vkgiv+Vxj?=
 =?us-ascii?Q?Z+kkvRO8fMEx3ZkWiBCrlKUP8o+AIiX7m2QqP2MIiL80JcSB2hv4MGSEysGk?=
 =?us-ascii?Q?RLe4ULbgVXe2MgD7sQ4nfohdiRpQ6cOJKUygyl1OljpkOtI06bOYneSiiH/5?=
 =?us-ascii?Q?GplpAT1bJyJ/TsyDFjzCZPlV3eByaAXbKspqSpFBha8+6itSt+W4+J/3hJBO?=
 =?us-ascii?Q?YjYzouzTTFjAGMVy4H7pUzPWEMI4E2iNOqijplN9vfPwKO9zJ7NaJruvdI9E?=
 =?us-ascii?Q?W0FisDNzY01IbOCi4T+SYq+Q04NOd03duMkQo3rJrD8HRsgRePaPHgNkPsCU?=
 =?us-ascii?Q?mu+L/eAk4D9BUw8vwfvrndU=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4fce7a-317f-45e7-ebe7-08de151b5101
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 05:40:20.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Zuh3zrxnSJo+3uWz6gXHjA67JFD7Pq/8tsx8R79MqAd3Kwxmc4CX7VMuIcoLIyB96+xEOAeJ4y4q7I3VXcy5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1485

On Fri, Oct 24, 2025 at 02:44:13PM -0400, Frank Li wrote:
> On Thu, Oct 23, 2025 at 04:17:56PM +0900, Koichiro Den wrote:
> > Disable the delayed work before clearing BAR mappings and doorbells to
> > avoid running the handler after resources have been torn down.
> >
> >   Unable to handle kernel paging request at virtual address ffff800083f46004
> >   [...]
> >   Internal error: Oops: 0000000096000007 [#1]  SMP
> >   [...]
> >   Call trace:
> >    epf_ntb_cmd_handler+0x54/0x200 [pci_epf_vntb] (P)
> >    process_one_work+0x154/0x3b0
> >    worker_thread+0x2c8/0x400
> >    kthread+0x148/0x210
> >    ret_from_fork+0x10/0x20
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Thanks for the review.

I noticed a typo in the title: s/cmd_andler/cmd_handler/
I'll fix this in v2.

-Koichiro

> 
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 49ce5d4b0ee5..750a246f79c9 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -823,6 +823,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
> >   */
> >  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
> >  {
> > +	disable_delayed_work_sync(&ntb->cmd_handler);
> >  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
> >  	epf_ntb_db_bar_clear(ntb);
> >  	epf_ntb_config_sspad_bar_clear(ntb);
> > --
> > 2.48.1
> >

