Return-Path: <linux-pci+bounces-43982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13420CF24C4
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 09:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DA853002A7E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 08:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397AF70808;
	Mon,  5 Jan 2026 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="oa9aejbv"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021121.outbound.protection.outlook.com [40.107.74.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F871C28E;
	Mon,  5 Jan 2026 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600181; cv=fail; b=lJdl2hXJ/0pmi9MefCSbDQUXunT50R+HSQDN+vwzmLN4Cn1t9PuyVrVZ6V02KeJG0pb5dJWwpjn6d/WlZHxN2Yt1DIjHKuyzYBzkgFM/IGxBknIKrCygvIc2++N54qaAEgIJc7DcY8z9nnoBGLjmZ+X1i1lhbN5P0V41vA1UYP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600181; c=relaxed/simple;
	bh=iqZ8oehl3/fMWb7AkL1mBVDZV8Xs7WY5Mx7M44RaFcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uSIa8JaNW5AdlPWSuWVt4/LUUjI01oK+kGOfyZ2Yp2cx5xVhk8wtajJeJDZg97QrOfFeOmpQfU8VBPWtfAA1sNbzkhGs845E7AsMxlx0S+zStZxv/4bDDhVYk+ESzCVfDaf8svi6PVZZlrOajGcijHnZ/StlfjQCCJKWJEa2mgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=oa9aejbv; arc=fail smtp.client-ip=40.107.74.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmVEQkH26GHaCoEmJW7h/PbJANbKGrHD6gamLSxQiruUVlSM1H5+q2DbO77K1GBy1MVFMoAVGc+iXrcKb1VWGdFgqnqMz4j5SyUHbwsjOPU4sngB4z1tRSuwTk7zGySLs+epOREC+eafYYNDABGcwGQJnVgjehsQ7o1g73kfmoEwNFM+ZsQMY4UVoy9oNMk8C0F60pckWoGOjhYDAfWyXDFGgyImhrCBobtyUrmvxZP5Hyyb3VFFDQxeiNZltB68fR1CSPz7d0wcgMm3WWRqLpHqdSaeTmo4fzzuPq24HE7SWEblEfhHgKKmlLOti0eJS99VayQ5oelYCzLoNYRagA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDPu+MUdWCtpSfB4Tp/npTtgDKzf0tdbxYTNagzWfnk=;
 b=FGEQki1j1ElqXX9fsiYbA76kEhi1uZkLukwb94ojB58+hGRrtdPnnwA/d3a7Fd6uTnI64aKG3xZ6r0TuyfX28BIyP3qYO7UUT6xEFMbfVzgJ33GinnPDHHdghhzoWg/oZ4KEyemTXA1Jno242AIt9KsXBXWWveRkkhzHISeGcSgYjZMVi8HACRcOhoPIw67MpCDwXwbNzwcJm9PHv5PaE9h2VcUzUkwDAGhpCn6057Gm8PK4ecrO+1aM0TZb5StQzcgpRuEgKpUJQ/W6xCF+fTEX4XAM2XrTsVOfSywSS54cWbqj4SYL20gwHX7QX+yevX/bJApwDbx/VIMZUALUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDPu+MUdWCtpSfB4Tp/npTtgDKzf0tdbxYTNagzWfnk=;
 b=oa9aejbvG3eeyQ/Svt4quJHUWMCn3oiz9/qSuGiVCAheovicO0VqsrURqUA0k8ypz1x4igIAzZkODGkK++2XMSL+ZDzyJaacAlSJSKeCLBcluiUUhqasTEhRAtZA6o7mzBXkrwtavMJrGCtVJdYmCoIWWFwpha/QFg84lyLHPAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1826.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:02:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:02:56 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: endpoint: Add BAR subrange mapping support
Date: Mon,  5 Jan 2026 17:02:13 +0900
Message-ID: <20260105080214.1254325-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105080214.1254325-1-den@valinux.co.jp>
References: <20260105080214.1254325-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0337.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1826:EE_
X-MS-Office365-Filtering-Correlation-Id: 146a360e-6368-46c6-8dc6-08de4c30d62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ODXvfOX2A58n6lAExGXws5MW3qDTeKLAnZBOvXxxs9U5bj3/vMHMtyuwr11S?=
 =?us-ascii?Q?eyhIa9hd21ucHjHKA0WhPvWoFq/N1yWPcgsOhPjiFAQ7VpvJU2mMcz3y1q8z?=
 =?us-ascii?Q?SPVgvkfCaW2z6HjCriGrdJ60qk/1CHqi7ecf1T5YQU3FJLzqLVnS+uycT8H+?=
 =?us-ascii?Q?ur596ljO71TtEShV/PlNQTp25rR7fxonlUQkQBo9fBr5nkRqlq4DqAfp7kit?=
 =?us-ascii?Q?sNA6TGakImGkHOwloLUnlD+bYFre/inwfbZVm8Cuui4+v80GfcFna52Jlpqy?=
 =?us-ascii?Q?Q07zjkSmjERxLa4q0R6Wpz3KbRtN+IvZm+ukb0WwQDwNrDH9lbUuJkrTrJA4?=
 =?us-ascii?Q?CYet8Orf/m9yVlpKprURRjfL6gEblVeC7/gV4Vqo8gw+3zguId9djNRxF9ib?=
 =?us-ascii?Q?Rl5oQjBErx90CCLK3YJTOg96kamY1saCM8e+Z/1rxm7/4y3kDwN/Sj2xA+LG?=
 =?us-ascii?Q?TYXGmENTeWWd1fzif+QSu5ebdNzI+aLi87Ne4olsGbOwLyWgue0s/GR+LQXS?=
 =?us-ascii?Q?M6VXFLbzYEq5xAk1q44mXtrbQcMEkXg+LuAcH2wFEDknMkhm3VuRxqwuOaBr?=
 =?us-ascii?Q?mHWSRLQu+MJVIz2PFiVUTLqq5iwyOT8WqVX1N9xiS82cI0JiRy/RW150h1Oh?=
 =?us-ascii?Q?2+SwG0KCgabZXnnkfZhVGP9qJLqAWap/GZ61rSeCF91phOZ1t8U7uAhBchCA?=
 =?us-ascii?Q?de4LOCLGl+u+JDzB3uSa67igto28c0U40ue8cIUHb1ewapQG0QyMNPl+EItt?=
 =?us-ascii?Q?EcPsLl8IMz2WskE9QKMTB880bWzfeUj+bjGKTu4Qmmgt9ZIIKVyNgsT2+9Py?=
 =?us-ascii?Q?Ov35p7zghR6ZQ0vpdPwK6fX8gbsEQGc++LAL8wAf0/pDD94CiBQL1DQn/Y0L?=
 =?us-ascii?Q?iA3IyOrmpiKPtmyzrUEidta54C0UqOVLm8Iw8m/CJPqqVRfH5XIm0QmcRwGv?=
 =?us-ascii?Q?feSOvFylBluxQEWIbPrD8dFNvLOXEtIhKZ0mhaszO0/m0AXAC+MqQMZ3EAO1?=
 =?us-ascii?Q?2vP5EIi+vPxaOpJZri2M6AoBPQjYmwjc3MejTP73MB24rpxxmJkqLjcBjfzE?=
 =?us-ascii?Q?wEzZtGd6JuctXg8H13PiwUAjSX0PGaYBNnE6GtikKtkivFTWgiAG4s1XOclz?=
 =?us-ascii?Q?80b9PmGU66ZvBsKLlYUTD5ltNoL2m7Xzl1kZKeAtJeNlu092fCXNEDi9jEzA?=
 =?us-ascii?Q?IJk3TAvKkcsI0TpHHhBu/vRqYXJFbnNZ50619RXvU8x3JPANLJY6DKs4PfiT?=
 =?us-ascii?Q?EK6Q16PxxzVhUauXWTLpf07NbZQL7FMesBbdmoomz0heHfSTy320gWIasEps?=
 =?us-ascii?Q?p2V+hyWJdXurPs4ifDPwSX360H+xQj0jEDNFIvNU8vSScVE8Xe4TRCnxJEbQ?=
 =?us-ascii?Q?aQ4RNNyf5N9PbFo/6hKjZrtACpAlI8rXrWQlVnhEp8Bha/6BGALwpiPZnsOH?=
 =?us-ascii?Q?17YGjytw2TlorExqn50n7eA4yjwDjKWK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bcOXQf0rBPc8O93ye9yzLH9cAW7fjPDsc+qohctbxKre/1S06fZwn87w7+0i?=
 =?us-ascii?Q?1enjspR0bbqCXhl9in24HWQ6vNnr6Ck0ECDweWxfTUjmNOJsZbCmnRDGVxEL?=
 =?us-ascii?Q?fzc7276zkmyUf+aEGzSgjiHJf+xsvFjLhGLlDBq9dA/za/xH9VT+91cxho/r?=
 =?us-ascii?Q?veOjs/erIUnOyOqaPNs8oIMDC01KHWmldLNGTcOz/6NxkX5Yr3QVMQY3w/Q9?=
 =?us-ascii?Q?T4UsQ8N4hrgvdgLOVYaO7O3jQAEZiMSuA12rz1cuhUo0fME++70hRgvT5x8T?=
 =?us-ascii?Q?WhWO1kRJbvIxetPNXlCihZY486R4X0ew+X3ASKduYaLZR47iE/xqcCzohjEe?=
 =?us-ascii?Q?5c4ZZQYfPyFWz0+sfcSugg7ESzLtEMyIlcdcqFEA39/LDHxE/2++XDMITQCD?=
 =?us-ascii?Q?kdE6wSILmunD+BFhV66Yhc4hAuu2PWNUjGZgZRF6u4C9rBcrbGuqDs4mQTC4?=
 =?us-ascii?Q?iNuRAaujAk0Z171+eir0dYV5HC8y4JX9oFXNJRgpZ+Z37mdLImfLncXYez1Z?=
 =?us-ascii?Q?r+SY5uKCMi8wVr/O0YyZFOkpQuLHLopX8KW0XCrqHOvkCHoUWv4FzTchKWcP?=
 =?us-ascii?Q?Ed7zYi9RFxSR75gGi3R3r3Bkgk4Bys8oHCtEG6aUJLWl1wUrhya5g4ZV0KQG?=
 =?us-ascii?Q?D6yHChZi4dKaRWp2SwznzcrKAyQd/+i66lDJhDr65eYh1TUHwlooioO/kl5q?=
 =?us-ascii?Q?cZEwTWl+w3K+dLDFuuGi1ndOFcFxvvV7cc9p1967CJctka9SjDCnEWKheBYK?=
 =?us-ascii?Q?Sk0nZig85zOCLQL0D76WRfO9jCo4nK4wDozUEelbwY6jZurHfKDsSYtd91ie?=
 =?us-ascii?Q?HM6QJGV8ePTtQ4+fUDlrR1EjfbVCAF4oBbISwXNISAPfq3LRIQ8hNzZ4AyaO?=
 =?us-ascii?Q?xyIpQlPw7IU8/tns4anSPwnQPuQzIzGFxo2TFRq+m14fO0XaTAAFCHxRG7MO?=
 =?us-ascii?Q?q1eIpDShpiZ4ipu3RDKR0C9piLgQeftNo53BRn+JA0n8zm7+8riUrf0Gdw2m?=
 =?us-ascii?Q?pRDJy/JzVympmuCqMAfrxLioqA2jhb/DX8eNxFQqWnghbQIuN4MhqrhgaRES?=
 =?us-ascii?Q?HeMtZail36ZRAiUbJzd/LpekGrLj6z2PqdQvwM8IHVYnZjXUmm8PnnSU9Z5Z?=
 =?us-ascii?Q?r/YZWpv6Iq9ODBDhNALQ7Y7CDjX5uXXJRreVJq7xzfWzMWWeYddGTH5G39Q4?=
 =?us-ascii?Q?OwcpishK9tWu1K/IbP99MRn3UAGoYv1paSAl8KTLjrxyVddflsJwTXJxPpU5?=
 =?us-ascii?Q?LjTXwg3RDBvAyjWAW9coaKeWwi2PBOBZ4fPd5+ydE5hCpN6iJXxLxXPJfrtj?=
 =?us-ascii?Q?XYa6zcfZiIYooptDhId0Mr4sYYP/cc08gjg6O9BIcTp+kDW8TGF1rW4Bh9Bx?=
 =?us-ascii?Q?g/9hD4W7IANAQgqRW5x3n9zekQ2EkaiPstJWP+hBy7c7+Kt6o9Gnal2FvjBB?=
 =?us-ascii?Q?riynqsGZxloyjs61zaHLCoeKL4q5dWHMDXN8K5NHGn1uSULPoQ2m2n6in2Wp?=
 =?us-ascii?Q?JAuFHoJ1q5ECzoNiSnZaMPEsfyBJSVIdGU71+EEt+Zrz9BL5gS0MjYlPTvPy?=
 =?us-ascii?Q?bdyTvMmTo0w4TlFtbT+vwgvRZ9rPZn859DspstNQ2IMpSIP3JcrRRyw1l4hm?=
 =?us-ascii?Q?4xgCghlurAR5+3o60S/+ngBvQjHWLRhOnPoE2n+BDeG6SQnI7zO8mhCyRyDG?=
 =?us-ascii?Q?1TscPaiDtLUA0ijY7kCfb5BGzXXHi8PVze4EW/XPOAyxMd83uhI8Ae0Q8ueE?=
 =?us-ascii?Q?ZUe0FwJlBp7hcbR0k0xfnBU4tH2VRyuaQxYlrL4qNKxUTeW19PZg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 146a360e-6368-46c6-8dc6-08de4c30d62c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:02:56.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GU0UtsCN75T5tKamMUW8iw5wvU2M4u2FqPTAXiF5gPnNpXns5uK56gsrpL/LUht0RXSp9dSP3E2s/0HxVmDaIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1826

Extend the PCI endpoint core to support mapping subranges within a BAR.
Introduce a new 'submap' field and a 'use_submap' flag in struct
pci_epf_bar so an endpoint function driver can request inbound mappings
that cover only a portion of a BAR.

This provides the generic infrastructure needed to map multiple logical
regions into a single BAR at different offsets, without assuming a
controller-specific inbound address translation mechanism.

No controller-specific implementation is added in this commit.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/pci-epf.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 48f68c4dcfa5..164768db85f6 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -110,6 +110,24 @@ struct pci_epf_driver {
 
 #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
 
+/**
+ * struct pci_epf_bar_submap - represents a BAR subrange for inbound mapping
+ * @phys_addr: physical address that should be mapped to the BAR subrange
+ * @size: the size of the subrange to be mapped
+ * @offset: The byte offset from the BAR base
+ *
+ * When pci_epf_bar.use_submap is set, an EPF driver may describe multiple
+ * independent mappings within a single BAR. An EPC driver can use these
+ * descriptors to set up the required address translation (e.g. multiple
+ * inbound iATU regions) without requiring the whole BAR to be mapped at
+ * once.
+ */
+struct pci_epf_bar_submap {
+	dma_addr_t	phys_addr;
+	size_t		size;
+	size_t		offset;
+};
+
 /**
  * struct pci_epf_bar - represents the BAR of EPF device
  * @phys_addr: physical address that should be mapped to the BAR
@@ -119,6 +137,9 @@ struct pci_epf_driver {
  *            requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
+ * @use_submap: set true to request subrange mappings within this BAR
+ * @num_submap: number of entries in @submap
+ * @submap: array of subrange descriptors allocated by the caller
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
@@ -127,6 +148,11 @@ struct pci_epf_bar {
 	size_t		mem_size;
 	enum pci_barno	barno;
 	int		flags;
+
+	/* Optional sub-range mapping */
+	bool		use_submap;
+	int		num_submap;
+	struct pci_epf_bar_submap	*submap;
 };
 
 /**
-- 
2.51.0


