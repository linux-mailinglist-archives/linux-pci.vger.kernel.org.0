Return-Path: <linux-pci+bounces-42453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD7C9A6AB
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 08:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8B0D345FBB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 07:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8C2FD668;
	Tue,  2 Dec 2025 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Tj9TLPOC"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838612FD1A5;
	Tue,  2 Dec 2025 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764660236; cv=fail; b=bGRSrWmRPjSlHYBITG3JMVGp52tsPzk4QoZ1UAvxf+YbGaiX0rDQhLoo4wzK8yhVJhW5fOrfSExmb6mjcobKzjwUiQ2m3fGBfA1zh03e9J202HT8ppIXlZkBYxUpt5JPJLlVMbQkyXZtrIllLABye4ZSRhyVL8MJNjwFWWKnI7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764660236; c=relaxed/simple;
	bh=mG/eMuCAKdGT870ART+Fcq2u2vrML/K6M1wYxTQqr0A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uQW06SGj28/ejlbYRAgOF9Q+UdCMHz20NSkWqK9UBIi8muBHBD2JRYOk4yQbpCoJ8hNx+JTdcHsrmwQq1+zAa7UkzaXHUh/AAZcqmgWXTUSPQu/57Nc6KN/cIQ3iHROe/BbkvdgBLSaa18a0P+nI1zSniDe1yIeFjTBZwM4vXPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Tj9TLPOC; arc=fail smtp.client-ip=52.101.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2c9GgQUwiH5o+vcdoIeVxurCMYxfhrdsNMaME55BipLZeTwWMYzUZtACJHVhnKVCi9S9+qytBH4LUB/NXUseJZpJYkjNJwNxqACg7DQoeIYMsEBRUNKl8OCT4KgLJTMN/Zl+gweAJLo0rvbLVMW/LHh18LYuzGluXF/eT9XDobLWkh0nfJb2ifQZCeFJBrhn88+VEkZs1UTy+idj7zy/nMcrnE2xZ9DrZdwT+qssBJ8fWhOidGZxsDHuoMwWQx6gWZrJ1gsY9XWH/Zj2Gq7ejyV5FoaAzNfrc3uC2JrbqGmoPiQL4rDcfAPXzmkZSTpsgsd5VRMOG59/HmrrhdQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMLsRuDeMgDUMMT+HA0E6iwyrjGmOrCAChV5Ivpwt6A=;
 b=MStXQCnS7Co9iZpnWGGdfetvveZcFPw2ZCW6W/n/E5lwiV8iR2IPaH167DSFormTrHAwWKC6RtIU8Xj0sSEWtc5sC7BjpRPnmt3SdRyFnjSNOVLaIj9+N8wwV5yF7Phmuk6DKunXIhn/a4AHfiOvbktjLPZ6NesfvxrGsN+fhIdRw+adJfoGkoFbctpBqqyl66SlFXFqbXQJXBXLk9l4jnxSB4JvNXyFh+E60Br255vaeRytXBpnZgESaoni9U35w4Mh7fw7rWngu2IxwUsVAbMQINNGONT+30rVDq2qRvBZuQOLKDzzvOTKQtS6Hq3xejH0rcxaoqOKGBAP27fAzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMLsRuDeMgDUMMT+HA0E6iwyrjGmOrCAChV5Ivpwt6A=;
 b=Tj9TLPOCGJUUvoJfh7W6zNsFZCEE9r8Q/O2P8rOI6ZxYts5KIKapieLckLDMRjaw8yEL6NRVUZphzn3p4NGKnsun4KSL8HPuZiL+BHABWL079dxNrdnTjjOT3EKt2mzTrE/4f8lIDtdqvuehHXllvQi3z/+GtMRhB1A3zYKmngo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS7P286MB7356.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:23:50 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:23:50 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	jbrunet@baylibre.com,
	lpieralisi@kernel.org,
	yebin10@huawei.com,
	geert+renesas@glider.be,
	arnd@arndb.de
Subject: [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
Date: Tue,  2 Dec 2025 16:23:41 +0900
Message-ID: <20251202072348.2752371-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS7P286MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 424e3dc6-0cc8-41b2-351e-08de3173bd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbXxuDiOPLsEQD8Kd2S8TuAX/QmODpwga/I3KhBVPYj3n18UT3EANzrgPxjH?=
 =?us-ascii?Q?rtZQTGI2M9G9GFPw7ep9mAr9Ekhsvdv2eXbkVRDN5Pu19hDe729ZUHRGNEfU?=
 =?us-ascii?Q?w5ceHyDU+kl47bR9Bas4VmBButuwKJR4kyywvRKpwwZLSXtEx/Hkw7FVE0hy?=
 =?us-ascii?Q?1qGx7IdqHQHi3F4r/khiDbuTvyemGEe2VseJzCSvyAAU3UCaZQ7jfmD7US3W?=
 =?us-ascii?Q?fGH/eofByxPznbTHckZmO/A2ymMzRisxqMo3QFblZCBxgf3cPA36543XcFKo?=
 =?us-ascii?Q?h66INi8rvS6RePJ53RYjKKHyl9t4q+tpgxLwCuY7qpqyep502EjguaEZMCEV?=
 =?us-ascii?Q?lnmszMDD69Lo/Cpbzxu2koYAYaqzCbbtRZR4ajPMkDLyvgGnz/BOj1nLid5R?=
 =?us-ascii?Q?453t/SxPh/mOV1wZiuuL4xo75G1AkC56Fx+Sy+rMIPw43X46b1JfHH8hkhV2?=
 =?us-ascii?Q?APXXjSpntBjSVVH7Kgbaaa0N5McRZnQUFgYwhEcYJOfL2vP1WoTvQmXVdAjC?=
 =?us-ascii?Q?hb2dxxxly7OnbyYwVY8dgk/hD9R13f3OsqTH5js1Pkh8XZKK1vpqw7Ogp0sY?=
 =?us-ascii?Q?XWxUp9a/NhpPuSNAxAnZcaCUoCR95B6dSmQiLx5/9nsuu51Jcdwfcydaaomm?=
 =?us-ascii?Q?mnJ4M86bTWBA0UKlzBRc6nf6DXYAhQPb5Sf7i5IOoS0/1WXxM7CI808okdpe?=
 =?us-ascii?Q?zg7xvqeBSrbuSRlU4wUb7pCd71vWkObKrk0KZkUDPcC5q3sh119nK74kPaH2?=
 =?us-ascii?Q?cMxVGfgNOILlme7wVuiWr9V0JCqmE9z8OMtiQg7wxMXAlClJf/8ETWGtLyn2?=
 =?us-ascii?Q?8F3TtJ7LJ0VMTCe5NxwFJyfWesP3RnvGyKDQuyVx8ZxZbDvNRLaLvw4bt3rD?=
 =?us-ascii?Q?6rxL67EN8hwaZ2tkL2lYM0Bm2uv3HfDcz7cOhndyVf3jqbNCVc9s72/js+SS?=
 =?us-ascii?Q?jw2S5lvhl/gw1nqZst/zEqAtIYF8R+KYFHcbxdLji4a5AbsNkPl61Qd4Ctra?=
 =?us-ascii?Q?RfehiFc6hSS4x3MWKZ8YEU0iaZg2fPGsI908t3GHFDKs3zcZS/r9kT7nALDs?=
 =?us-ascii?Q?Ox+IKbbLnN4aFUUQLUjx2UT7jYObfyciq7izwZExUmnmw/nC/CF5kmzhJetQ?=
 =?us-ascii?Q?AIITdoE7U8i20QyGC+GVPnZKd0Ndj/Rr2Dm87Gn4Uw4weoMn0b167sCayfmm?=
 =?us-ascii?Q?VfOHlatoGSUS61w1oebtoECTSTDY4CLhcCMhu9yJ9JoJdbHk4aLlgn4af6up?=
 =?us-ascii?Q?wusgu0Z8tzfYGMMtxAgb6SftZDTsWTACm7tnO/nC3246Zp2xWoMvmCjCwBra?=
 =?us-ascii?Q?+or0NMJNOZY3TgbJSPBisHWZL8vaucsgFUuuNl1OtCa04L8gsUASEiL4RstC?=
 =?us-ascii?Q?+HaqobE9EVmUe7kki5Ik1t6UKPxFyycXYaQxEpANDnTFHyXhli9oNGfnTBEV?=
 =?us-ascii?Q?HXdqTZq+ldtmFSzjnUA9vjAxum9VULgx8Yj7IcBJD+RHsdB4R+EevQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yVVBZOGgBdGgz8ZVSCAaYkBy2rWnXcf9frq5voOS/f5lSNLIwYYmX4qlfeW+?=
 =?us-ascii?Q?4k98oMyqikQ7YoSFYcflLY3Qpq4noJKemkonzNBZvih3ymLC6NxlB77DxMaC?=
 =?us-ascii?Q?+0GxPqbH9Bu4JZaMExwfQ8s3A63s7vU+i8jnq/QarTk2SPehwy04Lcz4JPmV?=
 =?us-ascii?Q?6hFaW/Dd/C4yxDMTnJY0e3GiTNhRO+6A00HU9DbshmXLY3VPywyPMhyUQugT?=
 =?us-ascii?Q?uHaUpOYEnw7nDx+VIZXgAcl3OHBDovAqeJlcacrNEoo1kqMzWCsvuRxdZSHP?=
 =?us-ascii?Q?ivygcWCsNoJcxC2FPO0smMMWsxqHU1wzM1NDj2EKfvcVJVCHHDR1IfzVf6/x?=
 =?us-ascii?Q?XIno1lriEcK8LGp3SIHbNdBhH4NDusVdkOJTaGkjnQI1vOJf/4NYCBN7G+kI?=
 =?us-ascii?Q?p33mzXittGvZ59s6NezuTOsnI02giKCOOF9h3xfAWc/WInlEWT9pOyNO6M5h?=
 =?us-ascii?Q?VJUe/qtnrpfK06kZ28KNgWpsaS9vId3Vx6VLhBp4HO5xDMt1dEN3PAxKgR8k?=
 =?us-ascii?Q?i+CPDhuwF0JVsQsNRD2xnG17t9bJtwk8MpQc61S8E3GTCLtx4759bVTtwQKQ?=
 =?us-ascii?Q?JVMQzUDlif3tg2na68oF6etVrAMy9efmyNAFuftGK8Q1Qc2u3MM1C8/aac37?=
 =?us-ascii?Q?r88CdyXZZykrbzUaOn1Hlw8u3uTzmWe3RM7Gr4U5jXWYood2oTA8vt4+oreC?=
 =?us-ascii?Q?pM9/qosSQlz7pCcUEOx0GP0z7M4M2vIoM3ZzfwjlQCeDFbZ5Pr8W3yjg6fay?=
 =?us-ascii?Q?qgWiuSCKU17XH5ui/P7nQiv+amx3MwsjoV8C9/8/L80xkfLhUlMv7OOwfNhA?=
 =?us-ascii?Q?vau6r9HnLWjTjRZYVufnkTi4ZqqLTtciPe5PIVT3iMjoNP8AUEB1CsgsAEmH?=
 =?us-ascii?Q?QU9ldt2kWrOnKPv13Whf6V7q9s5ysNq9HX+FzRnm/a6QXy1e6SoqD0Ikt1Wb?=
 =?us-ascii?Q?lWc1TjiQZEqHI6KPJDkXpvBfDNSmBtIS6ApUZq9slWgSFMG98BuJgFsUDIRE?=
 =?us-ascii?Q?uiSgM5+B75EJ6oev/Li6O063zCkcmEFN47ITgb6MLj9c8WTyE96IkO1iikp1?=
 =?us-ascii?Q?rhzIBj7qEg1Yph2sZtBrMQyIgFtmPrYpNQP6QZCG3btlG+84W/nDvxEmp4y+?=
 =?us-ascii?Q?B1YmognS/5R8uSSbd0aQCtxdTA/5AkEBHo4hwv0Nfw0FEzpQVKfeamN9IPUR?=
 =?us-ascii?Q?lOwiab2oH9AsJtwKju9xh9E7XwRBDM1WsJFibZ8dZGq8xy+L7b9JT8Z4gllv?=
 =?us-ascii?Q?c0/VzMeLmznR58H1cQltUVL+el0z1UYFZ/p898f9yibxKVFuBxymSA/VDLOI?=
 =?us-ascii?Q?p00MvMQB7HPgQttiTKeVHJwwGMrWZG9OCXHV/LAyFSnrpE+MXPdIIVQ/x4mY?=
 =?us-ascii?Q?jDKq+9eWbl0xtvNwo5e7MjvExI5q98f7rEN3GxuggYQ7piLYPhdtzWxvcQHN?=
 =?us-ascii?Q?YC8CaUVe4Mnd+nM9moJgk12dhSj4jvxUxgCZVAPIiWt+nvRYpzFEI6XDlmnu?=
 =?us-ascii?Q?UAz0pe/ydH4Hc7poMGD1ButFzfiuujc8IDNlpfaL4rBlhfYJldSKGKonBjAy?=
 =?us-ascii?Q?/lKtJUu4lSR78aFRzQrAKRHAgL1AM0N17xZx2tlIkCLCSk0WQVTCGz4BQfoV?=
 =?us-ascii?Q?M42/Izn4NPHAE4Cn5SCurRI=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 424e3dc6-0cc8-41b2-351e-08de3173bd95
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:23:50.6382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/2gnaC9s7gE6NRhP6QuCzOJFtaFZa9osLutQ7EJb4GpDAIs5TPhIJ0mviJqGgy6JVmGztKCVbgSOAE+HShELw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7356

The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
through configfs (link/unlink functions, start/stop the controller, update
parameters). In practice, several pitfalls present: double-unmapping when two
windows share a BAR, wrong parameter order in .drop_link leading to wrong
object lookups, duplicate EPC teardown that leads to oopses, a work item
running after resources were torn down, and inability to re-link/restart
fundamentally because ntb_dev was embedded and the vPCI bus teardown was
incomplete.

This series addresses those issues and hardens resource management across NTB
EPF and PCI EP core:

- Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
- Fix configfs .drop_link parameter order so the correct groups are used during
  unlink.
- Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
  avoiding crashes on .allow_link failures and during .drop_link.
- Stop the delayed cmd_handler work before clearing BARs/doorbells.
- Manage ntb_dev as a devm-managed allocation and implement .remove() in the
  vNTB PCI driver. Switch to pci_scan_root_bus().

With these changes, the controller can now be stopped, a function unlinked,
configfs settings updated, and the controller re-linked and restarted
without rebooting the endpoint, as long as the underlying pci_epc_ops
.stop() is non-destructive and .start() restores normal operation.

Patches 1-5 carry Fixes tags and are candidates for stable.
Patch 6 is a preparatory one for Patch 7.
Patch 7 is a behavioral improvement that completes lifetime management for
relink/restart scenarios.


v3->v4 changes:
  - Added Reviewed-by tag for [PATCH v3 6/6].
  - Corrected patch split by moving the blank-line cleanup,
    based on the feedback from Frank.
  (No code changes overall.)
v2->v3 changes:
  - Added Reviewed-by tag for [PATCH v2 4/6].
  - Split [PATCH v2 6/6] into two, based on the feedback from Frank.
  (No code changes overall.)
v1->v2 changes:
  - Incorporated feedback from Frank.
  - Added Reviewed-by tags (except for patches #4 and #6).
  - Fixed a typo in patch #5 title.
  (No code changes overall.)

v3: https://lore.kernel.org/all/20251130151100.2591822-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20251029080321.807943-1-den@valinux.co.jp/
v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/


Koichiro Den (7):
  NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG
    share BAR
  PCI: endpoint: Fix parameter order for .drop_link
  PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
  PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
  NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
  PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use
    pci_scan_root_bus()
  PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus
    teardown

 drivers/ntb/hw/epf/ntb_hw_epf.c               |  3 +-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 86 ++++++++++++-------
 drivers/pci/endpoint/pci-ep-cfs.c             |  8 +-
 4 files changed, 62 insertions(+), 91 deletions(-)

-- 
2.48.1


