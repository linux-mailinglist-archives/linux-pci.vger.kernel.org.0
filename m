Return-Path: <linux-pci+bounces-44136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9BECFBECA
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 05:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F11C30060F9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 04:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BFF221FC6;
	Wed,  7 Jan 2026 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YovLKOky"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021080.outbound.protection.outlook.com [52.101.125.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDEC1940A1;
	Wed,  7 Jan 2026 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767759251; cv=fail; b=cWIWTHZIOGhG2gJsR+AJlDm4oZOtCsYWYi9KZsVx2vaZwOSvZ50BNGp79RQysNd9Pp5rhAkY3EEqY/NiEeMsy+VSJAqv4srDN5lH53IOA0hsPTFkJ9SEJ8dztebxdpu7OKttkMT+c57rq2tiTL/ttMIwCqPb7HtPK8VhwHGkgF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767759251; c=relaxed/simple;
	bh=A2g1DCw3f1VzFyCZK5tXdX17zNR5WKRx8Zs0e1ADYlA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PcWSfhOjpkUiywHUuAtIIf4mYs6e9HSDhNWVbE+bgXccK5vGc/oFgIW88DU0xtNHlIApyXdtkopBxBNu2vGKeQgI+NpI9fLwwjDXVSqhvdCaP2WU20GBmUa9E99Z6O7hMiNP2d6+ZcoDKewsYIwZP+YpLNMx4C7tiLq6uAc4Mkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YovLKOky; arc=fail smtp.client-ip=52.101.125.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iF5sdW//aV7+5Rg4DHpeOzVM+NTviDZAIPPipVTBz96uRXRGegdkx5BMi4thqMwdvIGrmGLV7WUZ367OO+nvJgkuQmRN08w2A+NtDR4E1L/o2WX7ukYCh7Jk/l9HvtUUAyZitkaU56dnyy3br/RAnvQIC7Gd7MNOEBrvtQthlFZc1tAl8hCtkLmkNBTP8jk7z/Pq5iesfNmSGyTCQoEGoPd0zW6A0L2S7vcljHCH15azST0NE9oYxnJSoJuQC1/sOFCLRD9EQUGd3BqagqzEXoRJHNnGEX0qKNi0r0r5ilVTayct4ZHVdu487yrTkLgBVLDgN3Ib2qJnltx2/1u//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sL6XNioOANRJUfgJ0ee8Jj52D61ck6Ao8nXD70ZYFUc=;
 b=kPhgX0qJqV0r2Ahps1i7tXw5J51jo+H73/vW9i+X3n+IOwWRS8pgRoDv/UbQFmAyGD7+rIcMTmTbx85W3VwiyQmLrhXGFninkpjh4HRBCYe7nMW/EsycqiloS8NkVAtzDCh4w7aU6AwZqXIjKW8EnZASPQOHWQklG9M8u/yD/0DA1c5vXEwVTj3FL6u/qDWwDU0Jj4GtCzTJosKg5z3ZkQxcb41hF1ViqQJTjELCXVvDLDqG757CnoH/xfpd7jp7gSLnnJ72fKwK0KsSYy1Y+Ttu+JjV9Dql8L+QPO5NdWufAlxjlcJg9q5DI+d2zlrj+G/mCqip/dwE094YS6OrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL6XNioOANRJUfgJ0ee8Jj52D61ck6Ao8nXD70ZYFUc=;
 b=YovLKOky/nXakXRSbQqwvmdGCZxpzSTPuyZsNjg03Q+WeDMONRh6LP2FZZLOjhOAW57aSNvoG6Z/oczcUcRf4PkJNL8E8qrIauUjz8bXwV+kO83xaOiT0gKZgXj811MJU9ic8gXuArENO4VIxSccn8tg7GicBPZhwqLr0Oo3J6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5904.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 04:14:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 04:14:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org
Cc: Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] PCI: endpoint: BAR subrange mapping support
Date: Wed,  7 Jan 2026 13:13:56 +0900
Message-ID: <20260107041358.1986701-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: cb061a79-4cf7-4476-3183-08de4da32fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8SnFnXRkSka2nSnGPPwn55vAKrWOzTYSYGEQK1cIcTvYskdGm3j0fcUsZwSu?=
 =?us-ascii?Q?mMgnxJrolAN5zpx21bZNMN9Mp5wI0syVKwC6dIkSWSoqcJz04wX6gFeLZxxi?=
 =?us-ascii?Q?difVEhuGl00v4UYSEhBQKwt9Jhi/u4WcfbXRvHDmOGeP9o+0PW0Ao1aA9rMj?=
 =?us-ascii?Q?gT7ey+T4GDIjpxMD88+Wc4TzYMDbW4Q6gT+Ey95zMMAoonljGCnezk6HmyiR?=
 =?us-ascii?Q?eC0SYmS3mo8GSyLvbjBZM17eurcBsmNDpc9eQzBEamdrCO7BlHh3MqJ5RCQn?=
 =?us-ascii?Q?xHafuc5EJP5Pe2kkZZkp9EqJzoGBkJpiwb24x+Lx9tlLYslz7K79DTIfH2YH?=
 =?us-ascii?Q?ep0rkfRIbc6yIpXSwrG14oOHN2HhtG/cVgz+9fR6GXshLiWoTTPLNALJUBhW?=
 =?us-ascii?Q?1eX46BexUlWyjrSAEC0uTWwjRQ4OC6310FYrSv6kUrBvg6vvW6jxt2ve9trJ?=
 =?us-ascii?Q?WMxPgi96tIj7LgRa9Ne/WFdR8YZs9NW3wuHOmbSq2EVUZA8D6cwen5sIZDD9?=
 =?us-ascii?Q?yEgWZlgxnKLDLFlMXgBlbaHPd7x9bAJLc5GuML0VpImtEGqLzPjHHoolTF37?=
 =?us-ascii?Q?qBsGbvOQ1qRV9DJrYWQtnxXLCBdtr3WcEcdM+xw/uyK+DFPXJ5Z5t+pvRt8D?=
 =?us-ascii?Q?udEJGGvEZ9+aT43q3rEvLd6dyHeQgog1DVEjp6BKlLsCnmS0Lp4XGUPr3YLX?=
 =?us-ascii?Q?88E4TG1tPPoq4seLY30D0RULxwcbXadJX9JvfgnqRgHzRFz6vdvJC8N98Ovl?=
 =?us-ascii?Q?jAwZaotI3NFieLxPcFhuNFy8k/b1Ovi/K4T1p3g2EOzk4ZPAL5wUfzNVV41p?=
 =?us-ascii?Q?24Co/RmRw/Mr3t/x6G/WHNZ42brDP6nxPCIwWlNFce0RHd4yQYvzjI6mn2qv?=
 =?us-ascii?Q?PnfJl90xrLpd8ZpTxo4nQN+ESGrvco+yschgYHAeLw7BDKSe/Wpj1liwBZu+?=
 =?us-ascii?Q?J+IFspFjKlCt7YuZ0fKIeWxeLgmscvKJTUr04XiKH57JmlxzZf8KnNqjUKOb?=
 =?us-ascii?Q?y0WCeC6uhqLwKyk6j51gLGszfryvrTzcFy+2bRevUM0f80msJUvBHXP18Q0d?=
 =?us-ascii?Q?2HGxOdETOenVXUZBo8ySdnm94gLL0DCdO1KCvAjGOrxOS73PDkbtsZc38yYC?=
 =?us-ascii?Q?LF9O+cEH/JjF832DWvJyyKRRo0ofxXUx7L6TZb7IpVC825sSm7dDnRUgJHJI?=
 =?us-ascii?Q?AiaVSpltfto923/x2HQS3DwAMHtXceXw6liHwyztdgsY3JNl6WWqTN8Kzstl?=
 =?us-ascii?Q?79k8ftww0QJHjIv9n1tIfGPyP2aHBXA0jbalBtGhFaPN+kCkOQALXawSdnWq?=
 =?us-ascii?Q?1bABx1yrG9rQ8+BOmvJgVAA6fT+MV3z4wLx8aFaFohDKnDZMClbIphTaz+Jl?=
 =?us-ascii?Q?QpTCDqHR5DbNsFQ7TXLw7VlBuU1ZChcahlK11E//nt1etkmkmOI0hcH5EhQu?=
 =?us-ascii?Q?/JzGXrFIbSKZleqmjbAxRMnZl5jJ2stmcOAniMoYx/OprT1GMgaExA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WUU89TozPOb12IiDpC8gK5+O6aWLyYQSIGkJvGD6wzs8oJ6kkwycwKBjjsOi?=
 =?us-ascii?Q?Frgno4qKzAxSALMu2j2pMkCPyyf0S1CqdrH/On65fwdXxpqRpOT1usRI4FsB?=
 =?us-ascii?Q?Rwx2mA+w58TTmFhnLpdMT4UxScdQIYS4ktM6crGOUpksDhfN5c3ti45BXKPH?=
 =?us-ascii?Q?90LI6rsV38+o9lIvYiH7vpaQzzWUGzFtGvn2VyNEzUlsM2O5g3CveYUUodMU?=
 =?us-ascii?Q?7urVKuNo53JthGv6V3LhIq+Gaf/X+cKqv/MlN321sEkp2k8Pc/eclhEv40Ey?=
 =?us-ascii?Q?GXkHCgqg+YqhA+G7nXOwMXJ4GxVXKSmlhqZ1tK18wWx303E1BXdDJMQIb7jm?=
 =?us-ascii?Q?vBD56CUEleNPFJ4/rxW72GLMu+KJEy9k/6h4rswGXtUI7v4ve0VCekCibTgY?=
 =?us-ascii?Q?lWd87i0ogegFphc16XYYYpYF28ZpblXuHUq/pgM3m2+aC7Ik8IutPGqIH+AV?=
 =?us-ascii?Q?YvXQ0P2v5kzLnhAwTgjfG6/XpRNsqtsfobiQiCJ+kL2QgXhZUgETuVArL9rv?=
 =?us-ascii?Q?/t4McY8Jz7i8gP9LGI/66cioGAfd0olmGLGFvpcePoiitfp9sKRNHFGZ4t8Z?=
 =?us-ascii?Q?qAB9HL8qgZkMUmICJDhbLhT0qB1p+YQgrHgRdHM8pmMfaKv6v3Xt+ItAfRan?=
 =?us-ascii?Q?gXB/oSPlUhp23GmEhEp7sKXYYqTcM7qL3RLlyMeqa+0QQHMUzsDN5SyTd55P?=
 =?us-ascii?Q?w7b6xn5O4QdRjN9BY3E+N9XKlEJTRhRl6/5L6D/2bAs0akWMXCIofM/CGmJF?=
 =?us-ascii?Q?narlc5TItQO89Q5zVa9zWAaaDpBL+6m2bzpHpejuqLLhG9WUi6VbXfal6lis?=
 =?us-ascii?Q?/8Rt55EwefmHf2xgcp13P2vAGIL2FAzmmy0ucPmSS+gri/tlwuuOAP9G0gqk?=
 =?us-ascii?Q?dodl1rujbYM1vQU37hvHikk2HXKBAsvimz2WiklRvwhkrBTAM4Q+crrRMyUd?=
 =?us-ascii?Q?1Q+/okFsW3I6XTA8k9akE19vaei7sahMpZXhTUuaNeimq2DLdQRWd1+2ugad?=
 =?us-ascii?Q?odjMwdzfYuJfeSHJRakUQPLZZBJP8fdWvhwj50apNmVCYTXWRBoTBg5aMEXo?=
 =?us-ascii?Q?gNbPxf/nzHJH6KLIewEA+mhmNfp+YqDf21ALcwlHnAStVQfPuVZ0VaIi05vR?=
 =?us-ascii?Q?kIYR4jgzNZTIoCY720yIZj0xvMxit1SNYKGCYVM7L6qj3ncVrfPgJaEUn7Vr?=
 =?us-ascii?Q?xw6Zpfz9PGZoGptTTn0IDUHTxPWvK/114Kr5pDXBVfwDDFJ6IsM4B1OWc0NT?=
 =?us-ascii?Q?vZe4H6xkUuTmS1TEv5sO5WVLUhRAeCPKDpsTFTlLo27lHbV2b0kqkdCCTqNc?=
 =?us-ascii?Q?O//w4cx6zh20yyoAXWhxksiGPFTzWqTqT2NQ70+GLqywYUxl0l2n7bYjo5pi?=
 =?us-ascii?Q?bZ+a+89ETVnlZnsKRMyU9+oRFNjWVlV2qRi4Yi1furaS3vR34ATQuL48i1CJ?=
 =?us-ascii?Q?2pMKMjCTTd2znZA/dFD7xnBxBhFtxHE7Fn2KzsDn0bMVsNslLDo6yd40Wfkq?=
 =?us-ascii?Q?o1xmJeU3BIiio4jCHt70x0P91lzNql74XZ/nRq9MPAUz3yXkqnR9p6cVdHEh?=
 =?us-ascii?Q?e1Wmgjj842F3rVAjpKeJIjVCgvDn64TiHKWQC6D7Jegfb01S8iBJulYvThc5?=
 =?us-ascii?Q?qm/VLRYuo1etcZZXOHgD3THpKL4y4TQAnL1HYRLL+7kNhKoPU1jCm5ZFxk+B?=
 =?us-ascii?Q?cQWUK+yPKMhCG956iM3pqkjjb6G9Y88EaiYpGvcNBR/pIwXC0SYBbXLnKH4S?=
 =?us-ascii?Q?GT5EJsrRwvh5GiQsaywAviTOvz3qWXY+OzJCDGCwP1QLFOD0BPeT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cb061a79-4cf7-4476-3183-08de4da32fe7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 04:14:01.2852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXeSo/XD/xoML7Ts/Co12rrPmGKANZ4hKswgbWy++803WVpTHHByR5pWHqq5Z4FniiRFFnKO2YQa1hYi5vIsjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5904

This series proposes support for mapping subranges within a PCIe endpoint
BAR and enables controllers to program inbound address translation for
those subranges.

The first patch introduces generic BAR subrange mapping support in the
PCI endpoint core. The second patch adds an implementation for the
DesignWare PCIe endpoint controller using Address Match Mode IB iATU.

This series is a spin-off from a larger RFC series posted earlier:
https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
The first user will likely be Remote eDMA-backed NTB transport,
demonstrated in that RFC series.


Kernel base:
  - repo: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
  - branch: controller/dwc
  - commit: 68ac85fb42cf ("PCI: dwc: Use cfg0_base as iMSI-RX target address
                           to support 32-bit MSI devices")

Changes in v2:
  - Introduced stricter submap validation: no holes/overlaps and the
    subranges must exactly cover the whole BAR. Added
    dw_pcie_ep_validate_submap() to enforce alignment and full-coverage
    constraints.
  - Enforced one-shot (all-or-nothing) submap programming to avoid leaving
    half-programmed BAR state:
    * Dropped incremental/overwrite logic that is no longer needed with the
      one-shot design.
    * Added dw_pcie_ep_clear_ib_maps() and used it from multiple places to
      tear down BAR match / address match inbound mappings without code
      duplication.
  - Updated kernel source code comments and commit messages, including a
    small refinement made along the way.
  - Changed num_submap type to unsigned int.


Thank you for reviewing,


Koichiro Den (2):
  PCI: endpoint: Add BAR subrange mapping support
  PCI: dwc: ep: Support BAR subrange inbound mapping via address-match
    iATU

 .../pci/controller/dwc/pcie-designware-ep.c   | 255 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 include/linux/pci-epf.h                       |  26 ++
 3 files changed, 272 insertions(+), 11 deletions(-)

-- 
2.51.0


