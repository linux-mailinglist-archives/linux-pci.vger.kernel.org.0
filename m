Return-Path: <linux-pci+bounces-14669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EEF9A101D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A051C20B16
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02301DA26;
	Wed, 16 Oct 2024 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NZ6odxnY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A275187344;
	Wed, 16 Oct 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097660; cv=fail; b=qPW8HWKaq6swvFtm3sF3gWFuiTWen0mD/6IikAKASJSJHHFotFeb4f72toUrOoTR+B+ZiCac+rHNZP3VTIUt+s/kVA2NCms2VrhISeTNVjX/K3sCPH++x2Zvo+SQtZSTUbv7naTyuzCtwR4zXYSeFuQaiEli5ObtDMdJpovzI4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097660; c=relaxed/simple;
	bh=dfbSaNPdBrIxz7PmlxOadv6RbebSFEP1WJpgL9StJCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rPvk0Duw7fkGI5ei3/JdZzkJhg1WANSwnlhRbtvPt0kjD7vEXSsgllYB5e+4BrLlzFgqsJG7QGXtjFu0bsuyr3NnwXkxqsXQcIck5+Yi+oEvJZm/54OgBE/vpwf7Ap8G/pvvd/cetrDat9pjg6+Z77MS7ntVWyvWspMsIYVa0z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NZ6odxnY; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT59ZV3P22V5yAwHj/3YziTM2XRMeW5WwJGN83m8dlR9NLd5WjQ+jyHvphtS6JmUwW9v/AvZJsh+5lxDQwCDLHOYufYT1BIbl5tburoRNNiMnYFvL+BEJHs0XWLL+yOtBqaP5wMLgGt/Fn2fW8uLxCz34kCbo5edNUV2OUnnqiqGTtSCmPdWhs4p/THiKJrJ6PvI2qrtQOqYw6I6rfuFiUW3ZuhBKGHQR1jIednNYN/Mr1tiGNqCNBtMaVGJdK/RKZnWaG9mvj2y0hItfzt5EmXkfl1lmYqE70hRtV1bQGc7hIFTi5uR9KMwhOQIj5BnrJre38mcnbSyWPLKZjP8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=budkkrLsTk28a+V07QiO6ZeI7sdKGoofnMTQqGJagxw=;
 b=asstE1rz3JVfnnyyvRXFApzPx2X7LHZF48E2NVqV7NI4HB7KUl6jxI5jWH5OuTfGA6FY9qjFd7/gC6gdVrGWghXNWmoeJVZxbIi/zAsEu0tNUQkrnsK121ab1NLrEXxeVN4gLSlk+4z4NeFI+AHeGSxKpo9miVUejaJ7zpplyL6eUxlLKuaGT4fu9YXTjsiGq/w7MHFw44KBzVeq+1Ow/QfoUVf0ERnJzvVRrsxORDUu0dPuodTNTbntRF1Jt0J6E4GjoHQgoe+yJWxjx/d2pqPKJ8QQ7+CWK293Gcy5CxYv5014pOVk54FZhJZETrHHGSlhfRwCMdi6JD8meLSDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=budkkrLsTk28a+V07QiO6ZeI7sdKGoofnMTQqGJagxw=;
 b=NZ6odxnYfln6UoGkTWm37m7nHuiN5PjGDuF5mJUe+XJQ7tEvhOPbgPRdz0JIhrr3glkP41j0m4cJqZsE6G9Gj2gML7Rzw8APuWa3oIALJH0VXLXErUpshX05Yz6oStxr2t9to6JjDyqoUirHeLwlNkt+qK0J02O+AH8MwiK+zoOEt0qP2SqNuRY64O6kXclCx0Redzky79C6gju7VERr/1X72vyLk3hWet8su3Y34+FqRpSYN7+u0yGeeqd8dB3NEhQzMfmK42p85JmfKpPbacTobI2hy5KJ3SCQHLstKWfFgrILV0R8rP2YNiJBeXsq/5VlAC/dhk8/bX+DqftiwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6974.eurprd04.prod.outlook.com (2603:10a6:803:133::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 16:54:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 16:54:13 +0000
Date: Wed, 16 Oct 2024 12:54:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, jdmason@kudzu.us
Subject: Re: [PATCH v3 3/6] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Message-ID: <Zw/vq4EweR+yTphB@lizhi-Precision-Tower-5810>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-3-cedc89a16c1a@nxp.com>
 <87bjzkau33.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjzkau33.ffs@tglx>
X-ClientProxiedBy: BY5PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ec0502-8666-4287-9b10-08dcee0329ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NA0rJw2946m2dCGQW1YFp0Ym/ek+uJUtG9ugBHGz/ALx8z08gl3yH2/YKnQ2?=
 =?us-ascii?Q?zIuKGgIHBvbgESQuf4MCHTWODlixQp1AwggMIMIS3ZEDrbn1NZDSuoJ9ak1q?=
 =?us-ascii?Q?OsMs0LjAihQyvt/1Xs0JKjJZm2lXULYleo1pGwLg56XmJo/ZaSGB+JMpvoRr?=
 =?us-ascii?Q?hHwOxj4+jy1qDrwYIeB3WiUTJAeVsgXhPpX2l/zte/IpEOiQycSkOubz3ub+?=
 =?us-ascii?Q?Si70AOeV6qG6A6do+p7MC2KtwGwpdB5obfWQZu3NBPHfIv9VCo8I3Bwr84FA?=
 =?us-ascii?Q?pijVSxw8Rwb+5mf9PZW+eLAm/nKC6ffnBQlDC7I2WOlHb79ZPdHf1eFTpMpj?=
 =?us-ascii?Q?9OWHkMcTEM+6drC0N/TDEm9I4wEPxvjPbGaYGZvofO7r3NNrXTOtjjlHFLVv?=
 =?us-ascii?Q?AH0Je7CXnEyCNinu3XUxGEYf6ycccsX2XowmzQQuyMQ6wolSV54NKcUVtooe?=
 =?us-ascii?Q?fjMhikvsg8Av3FeQpMfpcskiaIZQ9XOc01gkA7wEDnpPa8qZUTLV+qBSG0Z8?=
 =?us-ascii?Q?YiM9viwRTbq/dOkiDDW7utxzIYIfgz2uy1GXspXqc+scjIOsesmmC6AxFjic?=
 =?us-ascii?Q?fk2U5L5BYTcWGKaG9qNvkXGncdYP7TdU+eD80X7Ro96fGBW/sqz6jyVYYTYv?=
 =?us-ascii?Q?70mOOfk7IxlTzrrO2ro0E7LXINFt6c4jbb7EnVP+OVZBWVvw1eHuFHJzD3Rg?=
 =?us-ascii?Q?D4uXOrLruuA0UVyNgwsP90EeMTAJw/WKd30H05jEjagJ3J3k0xJlTkqlhFFS?=
 =?us-ascii?Q?Z8WzdhqfE3lv/bp9m0TQQ6G5oGHbGQdwOvY8pxNsaYJDD0ktuBJIJ30AqpZe?=
 =?us-ascii?Q?l0T1duBstmPeEJ3Oe+DAXAAG3/WhmJ0gfvZpOgP063eYY8jQRujNj2ZHCxAK?=
 =?us-ascii?Q?MwqBO8z2/dGqlTT4Re2sBxYkRLiRVC7e6Vryk2h3A0kW8OZelYVRXnmIDG+h?=
 =?us-ascii?Q?F629afBlCtX9WlIoTI1GqCbQ9sgYvYUcbxW9J8yDUvT4f5GI5Xr9l9n7WZI4?=
 =?us-ascii?Q?axHknR5nljPIEVvBVUjdZbKRbR/GsrsADS+2pda41z6brzXhriaLD8bec/um?=
 =?us-ascii?Q?OqnLOfrDmn4JLWB5v8UThvua+acNoH1eGHdoQegojJHrm6ZCHf0lW3/Bgc3k?=
 =?us-ascii?Q?Pm2aPlIUPg8pxJuDVc6d8OdHObJilO8er2RiRkXhiEZ3bOoiJizxcrI3+aS1?=
 =?us-ascii?Q?RLBbD5qxDx4Z2Ybqo/I5dN88zvuhy6p+m37CdPbiiCU8SdOpJD0frKwOlI1f?=
 =?us-ascii?Q?w4wFnvKlteCUkICojds1zq0p61YlZkFFoEAVs4ms5VHFzPnf1vPzC721fVou?=
 =?us-ascii?Q?EHIaSQu/nHmADQK7MGcVXQRhWDBLnsRz6D6W0HDI2pAQPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mi7pH1lwWZQW9/ihkV1WglZ3fMYX6ikbh2nHDs6RNOe07ImafcC+V4q2EKg5?=
 =?us-ascii?Q?/hddRxi5oIWrLQqbvQhD3dVwBdVUn/EShIPjPtjR/ehP7fowHLrEqq5fAZCC?=
 =?us-ascii?Q?E0RxetykxBdhVvJovVbuFVjO+COgBKxvs789Q62Qb3hFTDC5Tu+xGQ/iJvFY?=
 =?us-ascii?Q?7zc6eY7zVkqMYQIXeVNoK5xH+cnXMsnIZWby6K+RD60HCzkGVKUKysWzWOF+?=
 =?us-ascii?Q?llBnO1b6Wt0XQGfExmmucV1z9AdYmeAQ9BQcBQxTv2ol82U45037r6aSt7Nq?=
 =?us-ascii?Q?eJ6UfgAABr5mOULAoU3YQTQlPuQU6QXAqN2Nt4utWvKK7vz1lh9M/LAKhUSl?=
 =?us-ascii?Q?3HqW+XUaXxHvQliqUl7T/fKYIjPgtifrSlIRd7tnbdvWVzRnlOWIiJ0OYiWV?=
 =?us-ascii?Q?kh74iJg4MxJcyjyUZHzOfihf59PoI10HhTSk419Yo+E4xmaaLD/ggS6xhxRP?=
 =?us-ascii?Q?Jx7LHtl3Kof0RlL228goNhKYflfY/z5pHw07w4N1rSTPYwZKPyQ5VNRWzWCB?=
 =?us-ascii?Q?5bkoaAoLk4/HCjWbnjzuYpYTwODQn9A/DIKMZTNvl0U5MSYSZ6GMTBoL/URu?=
 =?us-ascii?Q?fG/uCumjIvEZs89rvms4lc7gEQvioCH1FhZL5YvooTUANBcu42K9h6MR/rLa?=
 =?us-ascii?Q?igfndmISLNtunb09VU10hVa5hL0PNj+e1pPcoUeu0xTqNWvKY+6nqKvQNBbo?=
 =?us-ascii?Q?V+nuNggwLdgQZzB8c2VJ6PpZA+T8GuDBNRDP9YOdCRU5VX94+d19GodhE3j9?=
 =?us-ascii?Q?KLFBbViHPMXAsNb0rsYEb/6KsGZ+eN5aTsEOBCsWmFSskB6FHswPWrIRshtZ?=
 =?us-ascii?Q?rafSe6jRG+prhUnO9LZ4/7hYbjfrnfbtHbG4q9GSk+hiMVUw41xFN8toEqCM?=
 =?us-ascii?Q?9pM5itHnrlvqLRjZUKQJWoeqlvNy7KZVgC55+Fp9zVMnIwjK8tFp4Z2VTQ5+?=
 =?us-ascii?Q?h/u23zx+mp91Q6/Ji+8taBXsX9/VEP0BtOB/Nhul7DtsKCoLscslNxJO3FjP?=
 =?us-ascii?Q?D8Rl1e3x+EdYsLxu+TS81TzyOezyb3fAF06IzQ3Tq+cKT/gUPp16ULP85Qkp?=
 =?us-ascii?Q?3g/Bl6iyX6SXC3xlIhWgukocqtJ2VLGeKS6rctSpZkEdt0cJgme4cCYUBA2X?=
 =?us-ascii?Q?81MZIdV7ltutRH/opmanPS7IFCNTiHcuuBgiyb7ODcZ3LXiGPokqvaJ58jcR?=
 =?us-ascii?Q?5qJPQBiOf7IfoMylxS+PrmNgcnf2KNhr4zC7SNBucnCweBbIueWOkNPZx1Ek?=
 =?us-ascii?Q?x5EXqpxM9PoYE1cN4/EJiqlAYBjoDk80HPijKb2NXWLkJMaz8OmyHPUF0seC?=
 =?us-ascii?Q?lvJm83rITc4afVmQCp4DXuxgXgPMYS6w4bwDTPPp8L3rbLtBCKgFYaAW64Bh?=
 =?us-ascii?Q?NtjJcUMHbq1idnxdrsQlPsnAyXZYuNP8MrQ8dOZeSPv5QOa++LLsAyz0kcPZ?=
 =?us-ascii?Q?HhvSP0u1R3XulfxwGx0eL+qVz0EYoaGj/rtzDhLJp8bCcjMkuIbt2fCiS8JJ?=
 =?us-ascii?Q?/mIkQwDjU+3hqJBABimuMrscwepxIzt60daCXhZJoVbCS5iZGh2a5zi/ViZO?=
 =?us-ascii?Q?huqXXTh02rEl41IbGsk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ec0502-8666-4287-9b10-08dcee0329ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 16:54:13.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZm8wniK1pc/Hk750slkgGDUOTBOU+ySkglIeaAquBXCsbBObe9A0EaujWBJbgxwqTpVb+/MRob+2cwdMKQ5HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6974

On Wed, Oct 16, 2024 at 06:30:40PM +0200, Thomas Gleixner wrote:
> On Tue, Oct 15 2024 at 18:07, Frank Li wrote:
> > +static int pci_epc_alloc_doorbell(struct pci_epc *epc, u8 func_no, u8 vfunc_no, int num_db)
> > +{
> > +	struct msi_desc *desc, *failed_desc;
> > +	struct pci_epf *epf;
> > +	struct device *dev;
> > +	int i = 0;
> > +	int ret;
> > +
> > +	if (IS_ERR_OR_NULL(epc))
> > +		return -EINVAL;
> > +
> > +	/* Currently only support one func and one vfunc for doorbell */
> > +	if (func_no || vfunc_no)
> > +		return -EINVAL;
> > +
> > +	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
> > +	if (!epf)
> > +		return -EINVAL;
> > +
> > +	dev = epc->dev.parent;
> > +	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to allocate MSI\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	scoped_guard(msi_descs, dev)
> > +		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
>
> That's just wrong. Nothing in this code has to fiddle with MSI
> descriptors or the descriptor lock.
>
>         for (i = 0; i < num_db; i++) {
>             virq = msi_get_virq(dev, i);

Thanks, Change to msi_for_each_desc() is based on comments on
https://lore.kernel.org/imx/20231017183722.GB137137@thinkpad/

So my original implement is correct.

>
> > +			ret = request_irq(desc->irq, pci_epf_doorbell_handler, 0,
> > +					  kasprintf(GFP_KERNEL, "pci-epc-doorbell%d", i++), epf);
> > +			if (ret) {
> > +				dev_err(dev, "Failed to request doorbell\n");
> > +				failed_desc = desc;
> > +				goto err_request_irq;
> > +			}
> > +		}
> > +
> > +	return 0;
> > +
> > +err_request_irq:
> > +	scoped_guard(msi_descs, dev)
> > +		msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> > +			if (desc == failed_desc)
> > +				break;
> > +			kfree(free_irq(desc->irq, epf));
>
> All instances of interrupts get 'epf' as device id. So if the third
> instance failed to be requested, you free 'epf' when freeing the first
> interrupt and then again when freeing the second one.

Thanks, I actually want to free kasprintf() at request_irq(). I miss
understand the return value of free_irq().

Frank
>
> Thanks,
>
>         tglx

