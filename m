Return-Path: <linux-pci+bounces-16760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F819C8C6B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 15:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BEF1F21E87
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239641799B;
	Thu, 14 Nov 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="drMuJ9tJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB2171C9
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593113; cv=fail; b=DJX/KJYCzpglaHEtuap8mLFKMpJmWVZhPe/WWX4Q3uI/z7li9it4BnFe9mlMgrRitlrUmS/inl40jhXM/X4G9+Ihq/rsm2gnPfVBI9jvUTe/liL+I8nxI6t0WZAOLqboSIYRpam+J7znTCQIkKs6ZUdrZcVS4+f05S89rCceFL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593113; c=relaxed/simple;
	bh=dMES9XlAMIKvsP5JcBaDIO7CcWuYf0rXHiS0jvuGK5E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AngslhGst+U05km2NDLBrJtUgO3YkaAzeNsRJ2Dox+qWoo159E10w/eephnOAbuz8UtT9P9hNDc8ZdHzu7/pmytpdyRCCck4K8QeVUoDdGYoq0+AXrkqXKe3o3/dANXaPDEwTKm+H8sAyySEemfgJZ/730t9uzy1r4tpksoUI0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=drMuJ9tJ; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfBoezkSaajXDQ6SwF9dMszlrTdiYak2Kpae16aVVDLUwBL29Xq+t0hDT6x925nfBQjmpkd80ZjMWNoosUeCbpEwGGjbnWEjm9cybAdO91haf5JxJv8mZKYchlSKAdUSpMGOuvAafpbmXAGU78aJ+YiEiw65IOxpM0hYfAaXOQd98rZJlSGnm0v+k6ksbXxNYiXiydTuDwGQE3HlYjHqVoHBGbetPUD7FZ1fw0/C8W2ggNWIH4UIqInpWZDKqLtarCWQfFEl5S7SScgywsdDRIwnVF1Ux4wuD/D/7yrbqC/oyBwqAIvrkkKrdM8sbdvuPoNOZJgTlF01UbgvpaNG5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIRnTW5Hx6gcP4DXr9Cbz/n34W7+424J0P17CGvBRjs=;
 b=w8sedupZH8g8P5kMTzLyAQ/eGoibihWsseRiYux2gxKrUI7IBVtTwsmiV/3LJgiwTHgerkVxOungWyQQdkJ7MhufDembM9OZghXeGoHog/+tiWMlpTWNHBT88GgM9L4DVfA0X4ZaiKMXARgMSoOmvIrxPsF9BR/UzYNhSsc8CBe18e38KnaZqCmT4/TBKPZN5lppFaMBZKOisS1/msTRWCVEJEAewxm9ldf5Q+cNPMgWjxPcMoe4ZVJBG7SY9Uj+0osuZPhKvdCNn2ldpA/7YUaIJc+Aj0/5oXsu4FkjMR8ZmUTE5GBrXzHxsi4HSoZb2KVmvdRs/bU0uWA2HSfxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIRnTW5Hx6gcP4DXr9Cbz/n34W7+424J0P17CGvBRjs=;
 b=drMuJ9tJawmpxn5SYsjYsaHJfREOkNaml+FRPdS8O9l8yQ9WqiMTTD/+56ciNLDxOv+2/hPXMldFcURxT2m3ALTNOcp/0aIg8ntcLz0+ZTB4XimvRc/8OsuIUFwccGu3lpb18b1wPuLWekZwPzFQeIpmYrQ3BtiN4rnsIgdrR1bAwZSOShFVQED3iPurB0C+g/qFtFkL1q+kKcYyZx0WSRnCsyVh9tY5d20X5ri2lBmBKK8XWBBHSOEn8fusbLjBZDRFUnSY5FBdgETyYDEufzJk7e1NZCbJstzA3fc2dDpIfVZ67aCCbG4bXmrwmvfykXdZ3xW3mqaRx+Pb8w2rvw==
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com (2603:10a6:102:267::14)
 by DBBPR07MB7497.eurprd07.prod.outlook.com (2603:10a6:10:1ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Thu, 14 Nov
 2024 14:05:08 +0000
Received: from PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3]) by PA4PR07MB8838.eurprd07.prod.outlook.com
 ([fe80::f9bd:132e:f310:90e3%2]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 14:05:08 +0000
From: "Wannes Bouwen (Nokia)" <wannes.bouwen@nokia.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Thread-Topic: Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB
 non-prefetchable
Thread-Index: Ads2njIfwP+JWslVRxGz+DAgijI5nQ==
Date: Thu, 14 Nov 2024 14:05:08 +0000
Message-ID:
 <PA4PR07MB883875A86213C568BC2E08E2FD5B2@PA4PR07MB8838.eurprd07.prod.outlook.com>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8838:EE_|DBBPR07MB7497:EE_
x-ms-office365-filtering-correlation-id: 75a1ca2e-8268-4abe-2a8a-08dd04b558b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AEhZCLUm93MFKf4Ri5G+3sb9bMCnz0iS7Je/2Z3VIwaLhzFsgFtGSn0GEIiW?=
 =?us-ascii?Q?kxwYvs7VmMGZuR8FwpsLL2+Lq5tkGRM52/EGnQui/mVB5Yav76EfdVhewCMT?=
 =?us-ascii?Q?JrdJTVUAdH0VMg9XOX2Cb007wYsn4parRzl+hdqEHR1Fuvq1r36Q9+Db/MD2?=
 =?us-ascii?Q?xprjoOozXrzA6z/q2lLqvltryzAyEpFQ7Gv9ZJB4UPURjX9fqaEEK9L5R3tn?=
 =?us-ascii?Q?cBv9FX8iWTOTC7+z2HfQE6YyQPoicPlmI3fZ/SLKRY6bLT5HNsfSgso47JfA?=
 =?us-ascii?Q?WHj+oSAZ7V9lRo4zegXBgAH/QVs3b/O8/PuEhevK+YPt1yqOw0vaKoirckAQ?=
 =?us-ascii?Q?iGrIkrnss+bBJzfgvoYXC2z+ZGVyrVQFcii8SB6pfU9YJ9uonFpJwMTRf8Fq?=
 =?us-ascii?Q?q6w+BtSZkiI69FOf+bHlpPloAHCan4r+o7CZXJt84IryJoWIm+AG8Thf5kTc?=
 =?us-ascii?Q?xSQnNih+uaUMfpCbh3w7CKuA1hj47LSTedaVNslZEk0BjecoSaO9Nr7y5Z41?=
 =?us-ascii?Q?aQ5foFURRdcxCGWvVM4fjPPlgZQ5OeGmhUy7t8AqBKcg++j0/7M5KCx+uO2e?=
 =?us-ascii?Q?IlO4VGZxm9iqk5Exv0mOiZrNnurq6pTjOF0JilqfcZgC+D2aPfn7RYkHPA5O?=
 =?us-ascii?Q?64Dw+sGPRsAF0xMXnlYHHOwCkgR5sMD2eyJYH8g1bONuOM2ayGfk8IHLTHIR?=
 =?us-ascii?Q?Zr2XcUPm7JfPlW6v/GEcyhOy0DCgr/W16LMmjdb2N8EtqpW8UkX2Oip/0F18?=
 =?us-ascii?Q?J2QYAsid0sQ3FTN1IpCZD8cL+4y1RtBqcEixwurL2s7vC18SinnTfvSPELsd?=
 =?us-ascii?Q?DBir0S4rcT7CJrxw0Pqe6ep4Cw6yUDyOqff562oqh1gF5uNQww/UvWiD0wZb?=
 =?us-ascii?Q?qmk7udc0Tkod1QWKIlTTqKMEKXK52qIO6GT+ZPxifczUcbpGOwP/tvylFf45?=
 =?us-ascii?Q?LxKkpqTGf+QrxWPjpZfnr/To+QxSuRW84LeGAjF/UWlEB2RUex5GHwhYnuQz?=
 =?us-ascii?Q?y2SF9EQDZnC/pdZGfExp+cGuYl+ip/+0OxaptE5K/BPPq5jsoCMd7iV7ISp7?=
 =?us-ascii?Q?T1VDH7iQPbprjJVZPa20lr/W3DpZ+G+GUEIo6Yi8I8zgSOC40i1nStML2F8S?=
 =?us-ascii?Q?d71vkijCEh+eUfj/GuwOcDWqVB/ns8AJF96hhUvre16Cg9eSryBpAYypZV6N?=
 =?us-ascii?Q?rwIJj1NZe78HIaU3bxGln78C2zaUd0aQlKGGdJiummIZq8i2gIQ+MqCSES2u?=
 =?us-ascii?Q?xKUF8JrnakqIPPDkTghL3zl+SPqq+xITZb03yEk6bHocbVGj8jwtgJcQI15N?=
 =?us-ascii?Q?n2Iw8sOzktF3OwQpUGr38ia/afE4TAK8LlYUqDPYYgkTlDFIlbz1liiZfOoq?=
 =?us-ascii?Q?V6qfRfQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB8838.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7hNMkO85EL7/tF9N6yqNLVyNBSpP49mTooviX2Zw8dZXT5M/6kQYpfqFUmzq?=
 =?us-ascii?Q?RqVZksxe25UHo6hJbOCq9MdWxD7Xv3gRDdHZRyJ3CUxPifabRHrXs3vC50u3?=
 =?us-ascii?Q?V49x2CXeMKmSnyzGpkNU/JBLu+uYNEB3b4GQ1+FXxyL5jsT0hhj5yJZPL0au?=
 =?us-ascii?Q?P9xHaDYaahdjEYLqIQKDSAEJb8j7BTuiCOsY+NL7DKJnLBmGY2/+8pBpwpI5?=
 =?us-ascii?Q?dTsVsdKCgAWHQFIgi2FLL7/da+nvRxUuoHcE4uuz4Rp+TzllaLfOZdTNmXHp?=
 =?us-ascii?Q?ZropsjjfcuwfJympDvolbHCCL7jaM16FVpSdNJnMgjdnbnWWDFearc9n4is7?=
 =?us-ascii?Q?SZ8fk7sTqh2LXyvN5VAoOr3nap3cKweYzj+ebY3r0OtBtVPCXk593ZRWNFKm?=
 =?us-ascii?Q?Wp5v4fPXx0mYmVe0LtBkFQNDqVU84WpQccVWTR/4g5bxs9KmQL2pDdr2Osds?=
 =?us-ascii?Q?6znqknzx930agblohGejyUAqPYvAGZ2Jek9th/kXCHLNuVzx3CObaRJMkIkL?=
 =?us-ascii?Q?2Ll9H5A0loa8DDhYDcIy6N7uoYUp6+k1za01ZVmWuCFOf7D0BKlOsOFzIoJa?=
 =?us-ascii?Q?IgamsR3NtP9PARcw2ozxLLzWAE0cIYbuObGoeaSIk3xNhEaPcqtuuvp6KHvE?=
 =?us-ascii?Q?DD8WlIEKYpGs2t3zPgpNfDqxzk5OmrKtMn+hq7T3zwhdLxwfcI9pYk6UB9vk?=
 =?us-ascii?Q?WeV2mz13sppAUVmjacUIuv4ikgIpR+jI2ruX2EaVfn56tpq/gPbySW30k9Ts?=
 =?us-ascii?Q?7N0m1Ek+v2JoP9Nuah2t9bAZlVnJWMZRH6JNJFdhkbWZiW+q4+wi3RAEs9hB?=
 =?us-ascii?Q?1VuIrabHZezgOjbzSZRgmU0KoD0Ftnu7sKYm7L7KxgRE5hX5wXGskfEUzlRQ?=
 =?us-ascii?Q?jofXUXmnIZRrM2yskbdK80Mmy/MtArgyltmVxJonGvB28KSSh4afh2aeKeHs?=
 =?us-ascii?Q?OTHxvnWeOqGujIOZxlIVqa3MJJJ+nf5waiBkmoMGYUTFtkSNABagsACAkA6t?=
 =?us-ascii?Q?r9/vT/qCsV6MBCQc8+QJ2mCDMon9Rj8N2EXNTNC7lxgxDu9P6EL0M/1CIUd/?=
 =?us-ascii?Q?IwOv5CTyEgKUBuy0hgI77bChGEj9zLan79jU79nhoLkFICJWdGwPv4Kb2esx?=
 =?us-ascii?Q?oHQGOBImqVAn7bxRtkoDSu1KnUjPFvnYGZHladFSM4AnHNH1DLsYYr+Cxju1?=
 =?us-ascii?Q?d0jZlC5PEn04ToGoC2HTPPZfqR9VbhwHpqufGd6WTwnmKEqoGpzeX7jnw3Y5?=
 =?us-ascii?Q?4wrIYzhhPryle0eTf9FZ0G5+Y75MMkWo1oBc7H8CsTRk9uDm6Rk26cSYPZrL?=
 =?us-ascii?Q?BZP5I7l9t2taS4fJA4zym34PlXRDAuRfcMtFjyviZjB2ItpiCTVZDuktHDqi?=
 =?us-ascii?Q?/KMiu9COG29EzIAo2CL7TzQotU9hdU4NxqCKDsx5Iu0KLo9A1RoDINYnR4Ks?=
 =?us-ascii?Q?MwOGWQS1thaqq6D8FMTSs5h3XF4+glk96Cjwf/vT3m8+6TbYmvSmG9GrXKbs?=
 =?us-ascii?Q?1qUGJ/1sxPTjrtFjdtMtiS/x83agToOJN5bRY0+6N6/VQt+JdoR1fNlGF2Vx?=
 =?us-ascii?Q?QPzSJ+SwQc+u5U4M4aw7eutEBGJqJpD9oOh2o08b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB8838.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a1ca2e-8268-4abe-2a8a-08dd04b558b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 14:05:08.0323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PCP7jkG+t4oyDdSdI/kN/AoCp+lMRWcM7KsLj6FyO29bPIg57Ya/4DS4J/f3K5YeZsM+yh3dy69Z1LKN8bjQSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7497

Subject: [PATCH 1/1] PCI: of: avoid warning for 4 GiB non-prefetchable
windows.

According to the PCIe spec, non-prefetchable memory supports only 32-bit
BAR registers and are hence limited to 4 GiB. In the kernel there is a
check that prints a warning if a non-prefetchable resource exceeds the
32-bit limit.

This check however prints a warning when a 4 GiB window on the host
bridge is used. This is perfectly possible according to the PCIe spec,
so in my opinion the warning is a bit too strict. This changeset
subtracts 1 from the resource_size to avoid printing a warning in the
case of a 4 GiB non-prefetchable window.

Signed-off-by: Wannes Bouwen <wannes.bouwen@nokia.com>
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index dacea3fc5128..ccbb1f1c2212 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -622,7 +622,7 @@ static int pci_parse_request_of_pci_ranges(struct devic=
e *dev,
            res_valid |=3D !(res->flags & IORESOURCE_PREFETCH);

            if (!(res->flags & IORESOURCE_PREFETCH))
-               if (upper_32_bits(resource_size(res)))
+               if (upper_32_bits(resource_size(res) - 1))
                    dev_warn(dev, "Memory resource size exceeds max for 32 =
bits\n");

            break;
--
2.39.3

