Return-Path: <linux-pci+bounces-8855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB99095D0
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 05:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D95E1C21957
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2024 03:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E93D60;
	Sat, 15 Jun 2024 03:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i4uZNcIs"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2030.outbound.protection.outlook.com [40.92.99.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469A6FD0;
	Sat, 15 Jun 2024 03:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718421195; cv=fail; b=uXz0CMtnAepHh8YhZJ+MwONmzZHweKFniJ1QdU1VT7mJl9XFeCDwijr1XciRJpNO9k/lJ4Be5OsQcuUBYfU/7y37eJz6n5wGlds/fwZKaqX9/FdEixSdkVF1nNFgtfulCpLYga3PHB+BC7291cRn7Ik7tiTEDt+MS0FTkyyZfZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718421195; c=relaxed/simple;
	bh=dPXx9v5aYHfjuRE7IYHZfnpZSIYLJHkJxbn4uuy6OTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BH7w7agnrQj+0Hawr351igZlJZiaHmi3MDNX1Uf6gOCRg5EIxoql2hyuNA2NR52vm36kykefZtcUOF8zXgzRas153OiWYSnp9hdaDLQEjoM9/k9LU3QT/+F1bTIiHb7NnmX9a4sjo5XRg9ZOPJYMRWYWWxMG/WoFSZh7/XOLzZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i4uZNcIs; arc=fail smtp.client-ip=40.92.99.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4EOaJHQXo2d6QtMl7qX6qbCcsuuc1sVhJ9Pf8uGUkrCxsGMPv74C7A54IoQQ9rCoOgGnG8s7xC6t8YiZM26FeRwMBkt4XlV+cFrKbWY4866ivohL2LjMkqKQ4Z5t3neqf+lwX6b2vqjW67gpFWXBjbLdPPQ30GtTpSttgFVjwrxCBAel9dMt6cV8rMn/DZhZLNn0eo+MSqhgKh9Lo1MsSl4m22FGbpJfOSy2r8Bu4vSVmPL5QNqiG2CU/rvNaGd9elwvzU+kqYFLA16zOk1enHpEjUsMu9HYBKjHSc2DdrKqjlWrQYuJPcbptC6qwcztvlQ2J3gQC6kJJ1/g/cspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUihXdBwNp+ktrTnCV0KFthO5/HbpupPFA8Wiy8tHSQ=;
 b=VY/U4N2VLF5wdxzYF0nZ9kZQ5hGc3yLK+d0xxzfiFfvIg0d6KvSmuOZt/C5Bu3NlHLXEN+XvlX+fFyVgRafCUf1mwWV5K39l02S8YGn+TDUVhnsye3REx1g65x6vCNYC+u6dzomxbrxCgV+RqSRY3C3B9mK6f0QlKA4I1BEY7DrMo9N12GUXpUzMdRFauUrmQmu2iuTBPtrLsDK/2GaQnnEypbGRvz15L/poEC7zGWy3Zw4gS47zmM5qrBSlcY9v3tEpv47bzmyt3hfmKJgmjQe9TidflS0B0Y3PKp/6Tamog0v+HXjwt8JVlnurTb+C3nOEpuBVSHCAmzjjuH/rHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUihXdBwNp+ktrTnCV0KFthO5/HbpupPFA8Wiy8tHSQ=;
 b=i4uZNcIssxcoyCER826exvBatQKZbY1qJHtmoptBZVlCruhG6Vf7qqOw1jFM6LeZwwRJdPNmyx+ZfHXbMefoTAQeM73Qg8IS+qKbmIRpr4A1fnTKfl6oqFWbLjOF9pN7G9cWUmREphz0fFmxCxng5KWUj4eFgAx31d7uCCTqGmuPfAR+HYpRu+bvEabKa/Nzygq6poSsJg+nUpTPuJBAo/ed/yq9o4mcNZ9OSSsbVa/L3Q7HIcAqIkoYdVJVFj1RIoJMPhuI1GOGmMJWinGIh6vDlYTFzo66pK/4Q8K+Mh74oPt3xZul6JmeLkXcaYUKB4855uKYf4Wxr+618GYx9g==
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:256::8)
 by OS9P286MB4462.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.27; Sat, 15 Jun
 2024 03:13:10 +0000
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899]) by TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899%4]) with mapi id 15.20.7677.027; Sat, 15 Jun 2024
 03:13:10 +0000
From: Songyang Li <leesongyang@outlook.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	leesongyang@outlook.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Cancel compilation restrictions on function pcie_clear_device_status
Date: Sat, 15 Jun 2024 11:13:07 +0800
Message-ID:
 <TY3P286MB2754862E7F9F4DE1B25BF357B4C32@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612201432.GA1035119@bhelgaas>
References: <20240612201432.GA1035119@bhelgaas>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ghXvNqOFAWTYymXLKRZCzvVHOn0ssogF]
X-ClientProxiedBy: OS0PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:604:98::23) To TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:256::8)
X-Microsoft-Original-Message-ID:
 <20240615031307.25441-1-leesongyang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2754:EE_|OS9P286MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 879f642c-ed1f-41f2-fcda-08dc8ce915c8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|440099025|3412199022|1710799023;
X-Microsoft-Antispam-Message-Info:
	Zd9DsCvYqLdiUcQAK2UA30M7cULXXSz43o/wlHuJMuxLdgJgHbiRuyuEIEV2ib4JcY3ovSL5qfwftQBOiRTWWJ6KSFux9PDFeyoPwDay9aw5q4Ki7yMuFm19h+JevhTYYFfWEtLEdZLWLz5UXP02iuLLjJ2fOyBz2ipH/1Sm4UaYW8LmgOfTjeFHLbuykfaq/elYlSRz1DXCb+IzMdBfJZWKPQEU0xm6mChgB8g6NDolxiO+AHMYzQCFxKaLsM6lWLGAkDP/fp1NvJJ5INysn0OEvOHZU8w/Z0CGx9PU/JnJ8I4U8zg/dQ2rxgibtGzvcAHVfYqG9gA3EMEFZ1xa9rJ5BdsOdTBalcjffIQSaB+0oOSd9ce3y5FspK0XDDTLL7CROMshnzfrGbJWEpk5Ar2TzKlfucOSgJ9wD/q1Azi3ibMXRN8pDTJkrxgK7OSquRl3aGTxZqkGpswNUYuAzqRyP70mz0J+aGe9K34kDleJBgir+/pz1e733mKrUDJ3SVaYJvwUECjSRjDbMOF3ms1yP6boANIUGx5AYD+hIQDSEqGSLkE/0JD8tD0hGDoOqZiQWk6AvWk0dZs07PuALDQDaGtoU/scP0qUQVP4wTYbpZTdhZs9hevcsLQ0WDbJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8SAf7ipvy00NiELX2Dg7LFHbnrgG0MtbfcoBCiACAMytcidfORNjoaYGKKMX?=
 =?us-ascii?Q?CRY3NonF3uKLTQsVMC2dUFR9enH81KYPkrYbcBoUkDn3Bmsa7w0SvprtZJbm?=
 =?us-ascii?Q?jCojFSXjlcpQnm6d54GTz+UTHgPU9Ee9q6+6d+ZbY4caYlngzlnj7xhMW+qu?=
 =?us-ascii?Q?LRPz4aVkVoQUwzFOUOmOgXyXsPb9ml93v0hANQp/VSbwhJEBgVU8psmBhz6M?=
 =?us-ascii?Q?I4gVIGnqcyDenuAUfae+CH8pxItda2dCm0FCC1fIqB7iXpyGz+6L+E3YZDV9?=
 =?us-ascii?Q?dZlZsLDFAY3ymJ8Lb7YNWxnyfhLGTdKV4VxBkx7ma7ICYwBlgefCg0a4sGfD?=
 =?us-ascii?Q?uwbF4rBZK5UADLc3gmJg+QdFAD4PBYtLo/d5JKBekVmidAhdK6OMs2725124?=
 =?us-ascii?Q?uR+OrJUfeTW8/OvHOlkYdR4g/w73O9raZnLKIfSZNgs0R//beP/UTxPQvWy8?=
 =?us-ascii?Q?ISaoJ9+u09Ps6r8ks5DFJ9WHqMEYAldWAB8+8wI7IqXcfQQWZOioEhQMbQ9L?=
 =?us-ascii?Q?EyXZZDXeuSp/TbuRaYkpt14937AX1ZAFe2bO10wPSWZDRx3SS98VZVIJtT42?=
 =?us-ascii?Q?BMMwn1BlwJ/bXXg3eIhbDe0NPAG4qd/kAbi60KIX0+uZlhHcglUpEu4gnnew?=
 =?us-ascii?Q?Dc5sRM8qSZEcziipEu6vyTOpv20aNgQnnZTvvEJq7nvl8ZIG/wzLq3Vl79m8?=
 =?us-ascii?Q?kvslqzK4pZI7qubDrHTKMA94dkL1sAvk50TI4Ej+njxKMycoQ1aGFSccNLC2?=
 =?us-ascii?Q?q5o0sXnzF/s78GYUzOIz5fAquFSHSAFBxg8xuJR6hg64NXGeOS+KWduwfgL0?=
 =?us-ascii?Q?p2BMc9DzhV9+/uNCn43vj1yCViCVJRjr0jGcUMME3M3GncYY6uxfblQaRIun?=
 =?us-ascii?Q?28RgPtPE9tpKvzd0koEbUdU6S+Kjkcq+20W1FMP6CnjzRgRg1svAbqGBV6yE?=
 =?us-ascii?Q?pgCrxhJClWVmumu+dOc+a+r16oHn75nhpZyG6CvZ8sVCxk7ejwy+aByPP0Gj?=
 =?us-ascii?Q?gIrH4Jh3il6Sx1hiTgxSeDA9qpna8XUsLgRvUWTkbVWdwPYPEhiBEeBk9k9M?=
 =?us-ascii?Q?FbzrRdr4BSt99F8dChNRIoqNI3lfDqzeykQG6MS1dcvKXmLKvPeBQRlULUVy?=
 =?us-ascii?Q?K2E3Qe7bOa8vuZo0SC7DYjo4yCRUsvCFxFT3mK3e/H1jvuIWp61bq0S1f/Ek?=
 =?us-ascii?Q?JF4P0/+R8097PPeyxile5AmUKlPNUd7M+MEP8ypo+zOgFprokqConb/t7NE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879f642c-ed1f-41f2-fcda-08dc8ce915c8
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 03:13:10.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4462

On Wed, 12 Jun 2024 15:14:32 -0500, Bjorn Helgaas wrote:
> I think all current any callers of pcie_clear_device_status() are also
> under CONFIG_PCIEAER, so I don't think this fixes a current problem.
> 
> As you point out, it might make sense to use
> pcie_clear_device_status() even without AER, but I think we should
> include this change at the time when we add such a use.
> 
> If I'm missing a use with the current kernel, let me know.


As far as I know, some PCIe device drivers, for example,
[net/ethernet/broadcom/tg3.c],[net/ethernet/atheros/atl1c/atl1c_main.c],
which use the following code to clear the device status register,
pcie_capability_write_word(tp->pdev, PCI_EXP_DEVSTA,
                PCI_EXP_DEVSTA_CED |
                PCI_EXP_DEVSTA_NFED |
                PCI_EXP_DEVSTA_FED |
                PCI_EXP_DEVSTA_URD);
I think it may be more suitable to export the pcie_clear_device_status()
for use in the driver code.
Thanks,

Songyang Li


