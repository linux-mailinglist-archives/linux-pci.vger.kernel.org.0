Return-Path: <linux-pci+bounces-41077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52931C56F55
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A29A14E6CCA
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 10:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B060A3328F5;
	Thu, 13 Nov 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YWg3ld5s"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010029.outbound.protection.outlook.com [40.93.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE566333756;
	Thu, 13 Nov 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030636; cv=fail; b=NE5y5J0eibljTUP/69uQprx3RU9IJysETTPK655rywBqt7zr90+QfKh4ANtLkgCpKNVDR1oOyxEbXI39UDQOVFNyEAmxizs+zdTgPF4hWInvTD1YaIs2sEfD4HRzm5WkJ2SHuigpvaDautXjKHucvGWPAkWqsmaAuoKOLjBwed8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030636; c=relaxed/simple;
	bh=Q9p86zKuo9hk/+Eq7odHFe3cHlJCrlw9P3A+oNphY3g=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cmA88opeTKBI/YU3G/oaBSg+yUGjAOJjo4N8yGrYSUcWCVGYsBAakTA5ypgKSRB0iRxY7J6Yv5bQ3pgK0GuibNhzsWhf30uP8jduSdwwGZ8yzH7Cu1nyEnr9bx+RojRFR0xM8e/M2IseFt6ftghyKE2viPAA+UquU7ATT9qOfeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YWg3ld5s; arc=fail smtp.client-ip=40.93.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGdE7f0qivK4FX6tOOtsNUaapX/cm5HWFa2qKozqDi0yl9tfDo3+rBvHpWRxcB0rD9TrS8aF6ug6JWI1aPzjUsoAsaTO5/ovt6H7WFWTG3+cpLDVNCp83+dya6WlUfPW+TOD5P4JjBz19ftX/GugH68Fn0ezk74Bgs/JZQ2dgGJV4bjIBdf6OnCXlTZVUAn9Sq9E/YZRmdejcbNU0IUuzrafNTyoj03iAU2afVE0NpgcCTXUsa2mHBPNDVi945H8uSOc9pa8tJVrGUJ5EUtHoBxUKfEOqJ9PDmKoTyGs8Cx/ma7ipyqX/G+QdSmdRUYBPWa2BqVPGzx5DBEcR1jzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAuZVjCBHvhIUWinwGb9MXp3M3P9eU2lgbt9sgbavKs=;
 b=thbdHiyYR2maD/oJHALF3hOoWDGdEW35xGxi4be5sf86gW/3ZAJ1rkQkE0U3D6dnucngpO5DMBTGfrl4SFj0U/0X0363Ec09SCqKOiJsq9q++NCiDoNU1GWkHesuf4yVNdfrdfVmP1eTEGX2BjQJTBzhEDNQ230riiRLGYRji/T1r4IqxGOMz1uwBnjH8FR5av2uJcBc0euTxXoP9pvtNCtWzd6BRmMPndiYVQmPAIMwhTa8HenFKRzzBT4iDuKSYq/LPXdqQk7bU+uDVXlq7OwxoO+gSfDfNpg4EeLnWqtkFax/Y6jSazR+/f4qgXgIUTMpje/Rb/Tg6Guh94Z91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAuZVjCBHvhIUWinwGb9MXp3M3P9eU2lgbt9sgbavKs=;
 b=YWg3ld5sGLD61tbBcvpsynAV95HoYwAVe8lAGLiYBQFtxcLXx/7ZR0KOo9HwHgte/Pq0NTu1GWzNsQo4eeydz1vdJWSeEcYM+6D62E4avhgTEiL2T1ZtrgdS/bJXxXrc6DnwvEPkJpo3JHPDho8x+I6+dS82fBOHtw3RumIQ5sI=
Received: from SA0PR11CA0003.namprd11.prod.outlook.com (2603:10b6:806:d3::8)
 by MW6PR10MB7549.namprd10.prod.outlook.com (2603:10b6:303:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 10:43:51 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::67) by SA0PR11CA0003.outlook.office365.com
 (2603:10b6:806:d3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 10:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:43:50 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:43:48 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:43:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 04:43:47 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ADAhhkA136232;
	Thu, 13 Nov 2025 04:43:44 -0600
Message-ID: <d0516a4c5b9e5b04df25220a32c259cce89f7d1b.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: Kconfig: change PCIE_CADENCE configs from
 tristate to bool
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hans Zhang <hans.zhang@cixtech.com>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <unicorn_wang@outlook.com>, <kishon@kernel.org>
CC: <arnd@arndb.de>, <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Thu, 13 Nov 2025 16:13:59 +0530
In-Reply-To: <da56386a-b6ac-4034-a063-811cd7d71fa5@cixtech.com>
References: <20251113092721.3757387-1-s-vadapalli@ti.com>
	 <da56386a-b6ac-4034-a063-811cd7d71fa5@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MW6PR10MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 96fca892-aba4-4e1d-f1d4-08de22a18869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700017|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTZSL0RsOEpsRmF1WjhOTzZCLzJWN0hWQnUwL1BxUkZWNk9VWkxqQUJMa0h6?=
 =?utf-8?B?MFhubTJ5VzZDSnRlVWFKa3JjS0lKVEVmVHZpWG15cTMxT04rUUdzQmIwb2Mv?=
 =?utf-8?B?aUltd1FYUDZWUEliandLcWYrTCtDQldGcERvUTNZNnJlWWpaY2FhbkFFczQx?=
 =?utf-8?B?UkRZbjR0T3ZtMnh3U1JXTTVKUUQ1TXpiUkNLVUdCbnRwY2tpa0RFZ2toRlNn?=
 =?utf-8?B?NWNSam5WbEZJTDNvMkI0UEpqRGdsaURxQjlOeHZneXlicnl2ZVB6d1hzUCt4?=
 =?utf-8?B?N1V1SnFjNFc4WlZhZDhVSzE5MzJDcnc0RURaS2RwNDQrRU9yTDN1YkRqQUt3?=
 =?utf-8?B?dnc0QWFlZkt6b2RQL3lDcUtxU1ZpTHZyVmZrcW81YkZVdC8vRzlONVpXazZN?=
 =?utf-8?B?VUVGT0RLSkVZMUk5aEgzTWFMK0Rrb1Z5akJJbS9pVHJJbXRnNDZqSHRITzdU?=
 =?utf-8?B?SE44UEkxbWRyQ0Jtd0FDeG9RUGRoVmNSdjNMUU9wSkUySWFNTnBodXc0b0NC?=
 =?utf-8?B?VTJycW5LejJIWGhjRUdsVVVmaWd2eWNZZWZkRlI0QjNORjlNWEJqQXRZbVVp?=
 =?utf-8?B?dEkrNWk3RXY2Yk1Fd3pxM0tGcDRNa2t0REZmNENkTEhCb2k5Y1pOZFJjT3ow?=
 =?utf-8?B?WkJBN3UzT1k1cjJRdXh4MkZwdHlDQnJheEhTZDFPVXBhcTBBN3Y4ZGpKblZa?=
 =?utf-8?B?WnF3cGgrSDhTaEhmRnF4cjBacFFpQ0htVHdhWXRubFIvWU9hM1AvV1dNdDNr?=
 =?utf-8?B?UWdPQXNoRmRrQUdqUExXazlNY2dINU05WVYydGRXV0hRU3J3NmVNdGhFMFBO?=
 =?utf-8?B?OGNLNkZBakhuU25UUm0yNXEzL09paHQ3bnRWb2t5ZjRmQ0tiNUtZODJsYkxv?=
 =?utf-8?B?WFcrNHd4U0RVeklPY0pWNW1VU21qYkN6TFZvbWY5TFhyaXV0NWZGZTVXYk11?=
 =?utf-8?B?ZFBpR2NEVXppWXlwbVd3azdBK1ZZY0N3alk2MkNpTE1EV1VQcWlhVGdvY09E?=
 =?utf-8?B?RW9mejJmQm1DQzhwL1BTTkZDSVhHU3NoQXYyKzgwclNybkQ2dGsvb1JoSDNs?=
 =?utf-8?B?N0YyM0V3dmhmTzR4TnViZlJCeitQM3N4ZXh6UFpOb3c3aTdKd2luVGhDZXB4?=
 =?utf-8?B?UlNiWG05WUhMV00rckxONWt0VUh2R2ZwRTkwK3dIdVhubmJFRGJSaXY4YmVY?=
 =?utf-8?B?dmtBK3VPT0VGcnNqSFdudS9RUTVrdzNKT2RFL1NWaDE5VVF4OXk0Ky9JeWk2?=
 =?utf-8?B?bVhKTStGOElQck5NS203SE96YkdUb2ttck5nUVNFRHhnL05VMklFZHpPOTlm?=
 =?utf-8?B?Q0NQYjNYaUZJbDk5VzQrdmI5K250RUdXVTBJTkp2ajk1cjBHWmJ1QzQ4SlVl?=
 =?utf-8?B?UXozQVBHSlFaRHZORDJtUndubStuSFlhNlg3TVo1Zm9mcjRFelZ1UUw5Y2Ix?=
 =?utf-8?B?ZUNKakU2NmZoNy9PSTdGd29YbTVPMzZGVkp3MnhFVXZRdkFzV21Xbkl0VFdP?=
 =?utf-8?B?V3MrU3lITVIvOEdpczJGb2QzMG5ETU02ZGdua3lLUk9LYVc3d05FYVBjR0dN?=
 =?utf-8?B?S3RHaExNL0svdDhjYUVvNG11MG5odk45cHBVdThRc1V3anJQMnF1djhyS1By?=
 =?utf-8?B?bFB2WmxmSjRMQzN1Q1Jlc013b3VhTG5ZRDA3WFJQS2d1YzlwUXBBRGN6VDZJ?=
 =?utf-8?B?TWlPTXhKa29NbkVXYzlvRjRFaytxQzJiY1ByM3RVeFY4b1MwSDd3Z1REdmFN?=
 =?utf-8?B?aUpHQUVMWGlDcFltQjlLQm9Wc1owTHZrRDFVSkFCK3RLU1JHOFdGbTd1WlZ0?=
 =?utf-8?B?RXBGTm51VWh6NHpBVUdQVmpSVWo2MURUcVI3dzRHWnNGdllmK0hhSGpnOWlo?=
 =?utf-8?B?cTQzZVIxZVZ5Y1kwNko3aUNSWVFOZjlFd0RPQk9RLzQxVi9xU2tSckNJcWV6?=
 =?utf-8?B?Y05DRzlWOERpOTRURG1aTUFQRlBiK09USGl6QlAyTW9yVDVQaEtzWjhiR0pz?=
 =?utf-8?B?UWZiUkY1ZzE1QzV6dERQYUJXQXdWbDg4UEYwb2FSSXVwQTZjcDBqL2RXMzNF?=
 =?utf-8?B?VlkvZ3hudGx2Y0FaMDZLNXg0MldOOEUzTG1MVFdha2E5azhqQXRGTmxRQTF0?=
 =?utf-8?Q?e6Uo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(32650700017)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:43:50.6192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fca892-aba4-4e1d-f1d4-08de22a18869
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7549

On Thu, 2025-11-13 at 18:38 +0800, Hans Zhang wrote:
> Hi Siddharth,
>=20
>=20
> Your patch repeats this part.

I am not sure I understand the "repetition" that you are referring to. The
patch below is updating:
PCIE_CADENCE_PLAT, PCIE_CADENCE_PLAT_HOST and PCIE_CADENCE_PLAT_EP
from 'bool' to 'tristate'.

The current patch is updating:
PCIE_CADENCE, PCIE_CADENCE_HOST and PCIE_CADENCE_EP
[No 'PLAT' in the configs]
from 'tristate' to 'bool'.

>=20
>=20
> https://patchwork.kernel.org/project/linux-pci/patch/20251108140305.11201=
17-2-hans.zhang@cixtech.com/
>=20
> Best regards,
> Hans
>=20
> On 11/13/2025 5:27 PM, Siddharth Vadapalli wrote:
> > EXTERNAL EMAIL
> >=20
> > The drivers associated with the PCIE_CADENCE, PCIE_CADENCE_HOST AND
> > PCIE_CADENCE_EP configs are used by multiple vendor drivers and serve a=
s a
> > library of helpers. Since the vendor drivers could individually be buil=
t
> > as built-in or as loadable modules, it is possible to select a build
> > configuration wherein a vendor driver is built-in while the library is
> > built as a loadable module. This will result in a build error as report=
ed
> > in the 'Closes' link below.
> >=20
> > Address the build error by changing the library configs to be 'bool'
> > instead of 'tristate'.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202511111705.MZ7ls8Hm-lkp=
@intel.com/
> > Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >   drivers/pci/controller/cadence/Kconfig | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/contr=
oller/cadence/Kconfig
> > index 02a639e55fd8..980da64ce730 100644
> > --- a/drivers/pci/controller/cadence/Kconfig
> > +++ b/drivers/pci/controller/cadence/Kconfig
> > @@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
> >          depends on PCI
> >=20
> >   config PCIE_CADENCE
> > -       tristate
> > +       bool
> >=20
> >   config PCIE_CADENCE_HOST
> > -       tristate
> > +       bool
> >          depends on OF
> >          select IRQ_DOMAIN
> >          select PCIE_CADENCE
> >=20
> >   config PCIE_CADENCE_EP
> > -       tristate
> > +       bool
> >          depends on OF
> >          depends on PCI_ENDPOINT
> >          select PCIE_CADENCE
> > --
> > 2.51.1
> >=20
> >=20

Regards,
Siddharth.

