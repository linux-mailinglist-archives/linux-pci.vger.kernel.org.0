Return-Path: <linux-pci+bounces-4176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033B886ABAB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 10:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7166B285C16
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 09:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB98E33998;
	Wed, 28 Feb 2024 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Dl4Z8xAQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2077.outbound.protection.outlook.com [40.107.14.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B532C6C
	for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113957; cv=fail; b=KekbglU50IVDTWlxk5IYtDPSBibmpvPyl6MZ6NUSEIU83n3QTMbdvvYy5iCxEQb2PmWDemRMLOvcj0DA+pO4crub9sfNBn/XfquIg14wxlqpizmFYfL3ujPmkuFY0xbYM94359ryRzCTFD6U78ENA+gflwudj/3dC9FxKuyv5a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113957; c=relaxed/simple;
	bh=Z95CK+Kmmf1rXFU5YwJ7yaxkv2jHcoiMABEt9w3JRx4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbWsBj8qfYKw03n4cScJo5qQOgmyIayH5e1vVJbDDb3lVutNxwtgtwHL3iin/cwQbiYijt02ZthNNDBW/cbUntuKk1StTCR+fNtGwxbW9HGUAS01KtOYdfNWl+uj+u6c7lBGQLMKxNROd3VOXGQ+Kj19vmCSBk6Y7q4dWX6yLaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=fail (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Dl4Z8xAQ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.14.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxjV44/SVmUYdivgI429ItsNf6EMb95G6PLRM66sms6qVHPgsXeoWhYjE8G4UBnMtgfoKZVpRbv8zQGjau4/QvkBqWqk/VaPJnfo4YhBspGjoPgJu50Xv4NfaFKmITWUwqc7vj51kNYca0YYrKkqdGmR/zBhlrNKWscQPnG8PjGN1SZcIilwR0tcYQqdfbwO2pB5ld44BPuovFk05HKUWLEj6UklCYCXwhaAkjpYMXFud2QWYfnoMm8UbDWiZCIO20y7nAxfEGkzjsSr2BFLPZkuvXh1xF/aGkLKhcSDqeFjiH/xiRgf6N8++4Zbyl8WL2NpwXWY3QPr6mrbvn5cHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9u7vJW6fq/K3JQkqcX2yex/+pBIJ0gT6VykRuVsk3as=;
 b=lnVR9o0EX5vw4D90jsKIJWexrHtYL1YjvNi13Q1yOSlzIR+g4HHuUv7491JBl9keNAbKe7Hcq7PmIAAzLj89Ua/XG0EmrLurz00jfWiidNEKOTO+rzD/z84h2cGpwn4Mbx7N5sr+Sp/vG/F1Yk26NDMtWx6kHKErVb2hwIr4EKYEhJ3B+XZ3TgVyWAtRciZARbor3+LklV1E/HdIang9oKiL8aziKmR1NBI2dv/mUYXIXBL84bk5fhowSR8O6eAEAeZwIbHk6NdueI1FXAoY7+aRo/CzEy1oashMt06HGdrO1geiROSjlRQKvK1L9IwzkhCYjNtmVu/E1NVBIErw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=debian.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9u7vJW6fq/K3JQkqcX2yex/+pBIJ0gT6VykRuVsk3as=;
 b=Dl4Z8xAQeRGUvQG92BS7LzrgrYHHz9LDo4GeySVSd5ER0D8RbxUYY0BL2CBeHePXjSsNNJYp5V5wz46jBann/dm3M40s/jDVdTvma9RBLm+4MSEjK9feqkTuYNpSqmhYioP2S76tuprIlgFiIM7uSRpryWWTmXyUY2f58jBhs0o=
Received: from AS9PR05CA0056.eurprd05.prod.outlook.com (2603:10a6:20b:489::19)
 by DU0PR02MB8315.eurprd02.prod.outlook.com (2603:10a6:10:3bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Wed, 28 Feb
 2024 09:52:29 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:489:cafe::f2) by AS9PR05CA0056.outlook.office365.com
 (2603:10a6:20b:489::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Wed, 28 Feb 2024 09:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 09:52:28 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 28 Feb
 2024 10:52:28 +0100
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 28 Feb
 2024 10:52:28 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 28 Feb 2024 10:52:28 +0100
Received: from pc36611-1939.se.axis.com (pc36611-1939.se.axis.com [10.88.125.175])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 4B947153FF;
	Wed, 28 Feb 2024 10:52:28 +0100 (CET)
Received: by pc36611-1939.se.axis.com (Postfix, from userid 363)
	id 45EEA626E7; Wed, 28 Feb 2024 10:52:28 +0100 (CET)
Date: Wed, 28 Feb 2024 10:52:28 +0100
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@debian.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Lei Chuanhua
	<lchuanhua@maxlinear.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Jesper Nilsson <jesper.nilsson@axis.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, Serge Semin <fancer.lancer@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add error messages in .probe()s
 error paths
Message-ID: <20240228095228.GF30969@axis.com>
References: <20240227141256.413055-2-ukleinek@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227141256.413055-2-ukleinek@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|DU0PR02MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d088da-c204-43f4-55a5-08dc3842f9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y9MqdAs/q6F6wfgXHINWT4dkvzL/DZPWaGzXECYw6uovr/wtbhlq6N/Kbi9Dv7NGVJ2tzrF9A0f5YlGYVqU/cr7U7k6eYfP5JJQxTa0hK2uClhI0C1TgKPaTxpFifGBdWkDl6MWAcBlWz5B9MbRa/kAv7DuF92RR93vO5untXFTH3vWzuge/7zLbPef+AVND6k2nwirICXy1pkEolpeNSDCnhDvLAIOXABlDkfo3GNxL+Hm8I7FX1rHatCRZwiBTrrxUcXBOni0A5Yaouqwf2fFq1tIZJO9A565rJKOciRd95SNSfedzpfjQdl3QW6+d8MXotPdvfxLiVY4liB/zcASMrxKv9vRyO49E72nMesAjd/tO5LZa7BGrLKPdZQXcvN1fL3kV/EJdCyaG9v5bg+7rpK0WuwIFkMDEBKxK0XT4H37cZ+PJyUq4+6Vf36UMUEylxR4I1wHHEnmkFwgXCFr21H445VJeZG1uJ0EElmeOKQ3IKsNwTIcGIMWIVZl+9SmV+DX9uGLXdkPKP9cpCGSUrCDsDRZTAPO1HuFFVxtV4KbXCqXrX49gQYamTUG1j6B0WB6RUnh1OMVzK6jVFlLgp73UVTBLGHI17lpVYdVcGjTdHWuY4heLcS6VPukC/btWzjal+cAS31gX7UVqJAHY62kuvKZXRT4jWAeOpU664o2PqPTOf7rsY7K1K1tdcpXaHbKzRWWZqJLvMz6Ab9g+MzOb3W0hwbH6ept478nt9KHq6h/YBIpahTH9LRMT
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 09:52:28.8296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d088da-c204-43f4-55a5-08dc3842f9be
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8315

On Tue, Feb 27, 2024 at 03:12:54PM +0100, Uwe Kleine-König wrote:
> Drivers that silently fail to probe provide a bad user experience and
> make it unnecessarily hard to debug such a failure. Fix it by using
> dev_err_probe() instead of a plain return.
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>

Reviewed-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

