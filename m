Return-Path: <linux-pci+bounces-8871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4AA90B1B8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499A1285719
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2024 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F99919AA57;
	Mon, 17 Jun 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rO7XoE+r"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2011.outbound.protection.outlook.com [40.92.98.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B9F19A2B2;
	Mon, 17 Jun 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631326; cv=fail; b=NZX4wcmAaFijjJyAYEAKLeXKRj6TPgir+xih4xnrHPmd7oeCwPE/HJPi2nCVYD/a/5GHtTL950TwzJiHy/l5Lb7eyNbQRUjODh2FlUB5yT0ljATXajRLivioPB7z8K5EN6N4cpt20VA2tHZQKAia8l4VIQlHCJxPzFOgSk0sz/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631326; c=relaxed/simple;
	bh=rkY+kycCt5vLHgNj3R00RsDg6Wk4nMA86/ceXrnYifg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQmUMPSfGHkyz6FZhgVZB4QhonqpR6reZ91UWS92sdwIrQsjCecxNND6gbFSO9qzTtDZMCNmMfjrewkQglT78FUJjW6wLYV6U7Mx82aZIt3TpqHIFbbgZn0ov3EMjmKrOwTipDjJ/R9ONMwPJjgHjs6zurN7oBxJRmjW9W8XqU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rO7XoE+r; arc=fail smtp.client-ip=40.92.98.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIBOwuw8HY43bTGXbxwIQ9HqPBu/FtUeFh7bHpAPhW1E/iOFj8Yv03Tj0R/YTtlnlwY/fPg/dggofPNHnKBgjF8j0TiZpWvPIZaFRC08igzl3b37AEBkKg5EQIZHwlJVlL5maIIS1r78S8Yh0WskopMe8lhmQC5G5/HnqGEfWCXL2CSHNQO6m5cgK/ShSucup9nrLPpop+mgv4ZY9sJEL0lXwmhKJzrx3qmEk1/kF2ysC+Cs+T4l7k8DcEsvLj1vAqrVLoUv/uCM/xrUqqpuGzNCWk4ji4nS3eXMF083915fGewnDG9YQuWfDtTYRyU8eS5f3kRzWomDQPyaNCQh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jun4NponcZtNhYbkqhxBGPVAQQAhT88zHoteLjDN08=;
 b=PKX5q2r9tYzYy/lpgSF9n7+iqwAEz1T2eRRDibKZYvMNi0J07jhu/fbLIJ50O4Doorz5ykxoEpLOOM/bYIHkPEvRiCgzJ6sFI1iVqAJ7dJRUwhMWuWZPaKyaVOX9AGQ6BLkpfLcxK111MFBaKqtSxZ68JIFD/FCXzOW0jFaVW1dF6s6VMMkLUFwzfsppAjkPZ+c8KyC5jJum6Anasxv28GP4/F0T9GJ+QDmGe99/GXoWL7/mGi+F/5kNOI5msBhwksJSYUVM+zRWAMp3vEMGCpCdU3rnYGZ6f5giFE271cJVWm3X/793Zxz5ETkmb7rKry48BmPRXG9SBAtcW9Thpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jun4NponcZtNhYbkqhxBGPVAQQAhT88zHoteLjDN08=;
 b=rO7XoE+rfJOyZwH8DIeFeg2FX8dg8GgXGiuuaCDpawESRL/noodTm2EesGyYeCMXchNsmwfk8l75wSeRFNdgjLeMhNRcJi8KPQA/xabN6xsGTEy4VR0Q0QcaRkmHeGtzc75S8SBZ/vkabZpvtwcFg460u8v5PYv+Q0Jce9khcTdmrnb0IEbjsWSn67UV/sSa3JfDgz5XUUBp0jWsHsZLAJpTZytKERICpTMozCucLnesh9OWhUbTZCophlUpY/sBhvHypBgaWWNPdmtpmyB1A1IpVN8G7yNYshgrHDO5gj/JwZQ9HEfJCHeNFGMPwWNq+iORRWtX35JUylzqYO21Hw==
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:256::8)
 by OSOP286MB4001.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 13:35:22 +0000
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899]) by TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:35:22 +0000
From: Songyang Li <leesongyang@outlook.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	leesongyang@outlook.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Cancel compilation restrictions on function pcie_clear_device_status
Date: Mon, 17 Jun 2024 21:35:20 +0800
Message-ID:
 <TY3P286MB2754F489000B7FA6F9CF19D8B4CD2@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240615212603.GA1157372@bhelgaas>
References: <20240615212603.GA1157372@bhelgaas>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [2nef6F6a5KUuqYB3EYVbFVCiymH645im]
X-ClientProxiedBy: OS3P301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21e::16) To TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:256::8)
X-Microsoft-Original-Message-ID:
 <20240617133520.10450-1-leesongyang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2754:EE_|OSOP286MB4001:EE_
X-MS-Office365-Filtering-Correlation-Id: 2035cf15-ad52-46c6-2d5f-08dc8ed2560d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|440099025|3412199022|1710799023;
X-Microsoft-Antispam-Message-Info:
	SEW2lyPlVMx04GOQJwu1pA9VnpvH/JC+XVhIAF+47DTYvf4ImmAHXViLEG0iFRJai2oK97bSz3Km30qb2iB0K3WfoFHy3miCv7upYzMDVpfUeUqPFw1mZ7cIcas56/erEmkKUyAUYDKmEdic3yH52gWVhhKv9UsZe0DBm/B4g3O8v/cDdwpjqP8OJ1XDGZf1uaUbF3ctV7mE1VtYgmGrqpFoka9zf5GMExQZaH3/v+DyY1IoRbjFFzRF5D1gO8XR+rqUR2+BE+o5cphmWZHk3uj5AZnSmoPc8F8s1VJwA/Xx/NN83wV1WuhGHXK6bQVnx/OXMIkwQEJoGldn4xodmTvT1bLeSItbQvcTi0L16noj9cx0Hdd7CTzjlg1nov1FOo8mpqBs33IhB5BUeREB3wu/fuMNYqLDh/ERaMwibnX4uWXiQTtoFkwb1QDWvdcEimhWJOGz+UgLDOJquzPADud6ekqTDkC/6Di7G9843FVDVIPUp2AwlRx0Gj5Sc1FUA8u3enP1ES5zvlZAd4x3USjrQTiy8U5nWMWsKO7eCZoCqYWPfFVFY9qz2Jb1Lyq+ue33ya6rd0hF+doxjooQx8ajSbK52F0RBWOQjd6+l1fCAdvWW4vHwyzin++ByFKy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B9AwaeoUz830kkAHTg5wO+N+PczDbv/mDK2Lk3GW9gRua7Ik8sUibhhNcvlM?=
 =?us-ascii?Q?M4YhxqfVQmzC3GcnQZuOHofZO8E/U6O+vxoHMM6QQ43EQ3MWPzCTK70ZuO8i?=
 =?us-ascii?Q?p3ZHr1m3poo7Gy33gaoDztTCPAdTFYXP3hiCwBF4zxLxnN4DAMnZt/AwYBBs?=
 =?us-ascii?Q?N3HCNTOYzlXVdbZFfMMkhw7BGt7ltb1Ock+goa3ApYZzNFOqHndJzTj1VRFp?=
 =?us-ascii?Q?mkJY/YN1eKKv9CYUyoSSkkEwhJoYekJ0EUhtp+IU3xosRTSIT0wbelvhaOiw?=
 =?us-ascii?Q?UnY6j+KKC8g+afRAiArrwG+v1N5WsdmSwq0NDYvEnzPfyG64Y4S2vsMgDOAQ?=
 =?us-ascii?Q?cw9+LNZQX537/J+FlRhSL/q0CvXiXnR3stPgjEgZ6W2NVQUr6kuS4HVMljbI?=
 =?us-ascii?Q?oU5o0t86Rzd+cGP7/AayQJdatei3FQ90FalIZ768TvMjkQdcwiJItzHbGhhD?=
 =?us-ascii?Q?oPL0mqILuI+T5k4zTMkkmX3bSuKb9cfc3X2/O+7xoP9KMseNm62rCwXMrB42?=
 =?us-ascii?Q?Vxo/FpFw+osGvGBx8yJpYu+qApyCPtvbwMMz9aU5iwpVsqTN772unZah8aRG?=
 =?us-ascii?Q?emv5so1mmsR9hvz7kt7Femeenz9N81aLipHBz7iYvvl0KsOAMJ/NoLHF94ab?=
 =?us-ascii?Q?E7+OUVl2HxiJhTF5RF2waeacxEjTwRyGlGxvfY7R8j7xhNFB5DWDyAcR9toN?=
 =?us-ascii?Q?NH9L2ItdFRX5mcC9W2KQ9xRS+9aQAwEWVZSkyIK/frZWPqwJs6afbykM012W?=
 =?us-ascii?Q?4QfZ+GIDPC8FgV6/huadvOINFru+JpK7MJ+nkwlYnLDXy8gNQyXvhS7gL5zH?=
 =?us-ascii?Q?1tXcgS1p87rrnJGmFlYT2fYKtAR4hdX+lhnZ6ksW7sT/t/kmbpcG4LjIHW1L?=
 =?us-ascii?Q?BVZQ1FkjedBmfriFSJQcUpSAu7hoQIjir0TD8rba0i1CTHDDF1jp9lP/NEvG?=
 =?us-ascii?Q?OvL7+aQNrSsQIcWlwNQIxxec9YzlL+nTaq8dYIIizOHwt7WqzQxTPw3vUqeE?=
 =?us-ascii?Q?CCi8m057bO9k9Ckq8Cp56RQNtFMDkE/4dHZXvlrhf2NHm1IS851cNqTmrM7u?=
 =?us-ascii?Q?MtSIbXDwQmm6MIEKb1oG7DMiGnoAZ5N7FY5RLd79CH+UeL+1q41es0o1g8di?=
 =?us-ascii?Q?5bhVvUYSCMk66YjvqDzYpZmbTIHPEdqfMVlfayHm5h688vymb8SR07HqjyS8?=
 =?us-ascii?Q?44/HhTQZah0s6O2EUoiKleQSiwBNP6RnhMRqdbRlPjm4JgOqC0bx5Wpm7Rgd?=
 =?us-ascii?Q?OiMXKtwKeB8LXmEnwHof?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2035cf15-ad52-46c6-2d5f-08dc8ed2560d
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:35:21.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4001

On Sat, 15 Jun 2024 16:26:03 -0500, Bjorn Helgaas wrote:
> > On Wed, 12 Jun 2024 15:14:32 -0500, Bjorn Helgaas wrote:
> > > I think all current any callers of pcie_clear_device_status() are also
> > > under CONFIG_PCIEAER, so I don't think this fixes a current problem.
> > > 
> > > As you point out, it might make sense to use
> > > pcie_clear_device_status() even without AER, but I think we should
> > > include this change at the time when we add such a use.
> > > 
> > > If I'm missing a use with the current kernel, let me know.
> > 
> > As far as I know, some PCIe device drivers, for example,
> > [net/ethernet/broadcom/tg3.c],[net/ethernet/atheros/atl1c/atl1c_main.c],
> > which use the following code to clear the device status register,
> > pcie_capability_write_word(tp->pdev, PCI_EXP_DEVSTA,
> >                 PCI_EXP_DEVSTA_CED |
> >                 PCI_EXP_DEVSTA_NFED |
> >                 PCI_EXP_DEVSTA_FED |
> >                 PCI_EXP_DEVSTA_URD);
> > I think it may be more suitable to export the pcie_clear_device_status()
> > for use in the driver code.
> 
> If we want to use this from drivers, it would make sense to do
> something like this patch, and this patch could be part of a series to
> call it from the drivers.
> 
> But at the same time, we should ask whether drivers should be clearing
> this status themselves, or whether it should be done by the PCI core.

After careful consideration, I agree with your point of view.
I hold a viewpoint that it should be done by the PCI core,
rather than pcie drivers. I give up this patch, and then I have
gained a profound understanding of PCIe Core from this communication.
Thanks,

Songyang Li


