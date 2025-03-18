Return-Path: <linux-pci+bounces-24000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B530DA665AD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 02:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0212C7A97DB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 01:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CDE13EFE3;
	Tue, 18 Mar 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="nsyV/XdH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0B290F;
	Tue, 18 Mar 2025 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262591; cv=fail; b=FVM+YipBtbfLwj14e6qHPBK2vTMS11SYnqmr7LT926pldn3nvgzv/0LVJLL7ZgDJa1Bps9UPAz5ltk6zKSMbS4DOIoXKOjatuT4gc1mXGjfmJsyvP8ODJNqWsqGgwMrtv08gv+uI66DhzTUcmoQhmuv8L19AgKBg0ZPp6BUZgIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262591; c=relaxed/simple;
	bh=KwxtM2pJXBDJX2HdfY5QzLXNx4Y4A0/F9fpd3s5c3ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TFbjIZiDzznZexRtyWMaeMOv6OIpVmhaIwM++kidOCKNoGvjV6BGGJCtkffbTCdKmD4Is1ymx/PTxWRC2L4oRE6KTtOoVuj8xI+c0aI6xohNjCbV06QzC/IbRX+ODAmGkdBFHt8j+ogw5Ximr8hw+AfImR5j5TroZJy6Oh666MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=nsyV/XdH; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws+Lga607yteIds2g585tpXTZ1hZ46mKHchAAIYNgE5xLJkx14eSUUmaUNm9FVz6yKwUvNfxhEQ8fdNGgFKhc7bezsQ7fogE4VBmHOC3v2VHoejamJbi3n5d9wIDCD0TpDzCvhSdQ7tOAft772e/mByczx2JlIHcHbQkXrcvqNmLl3HZYhhMCDECLABgdB3i70raNK71Z3TJ8W3m0FkVaxk1L50DQOSXDthriVBlV9CwSVYzL/bKZ3jKdscyB92T74oICzFKuKSw7bBLxH00tuBT1xrrX2V/l2qS3dSSRnIXjiCPb/64JudNKx4vkEuGWicsQ2gBh4M94tsHbogYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb9y5xptxoTw+5DwMFI1z1W4GRQwP1vQbI34CwWnJf4=;
 b=FEfakmzALiy2NyJasvzqdYG/v+wnWXDKwkDh1lR3WQ7FnVdItQFLm3OctTUVZRgyNRrJwZ4sfgRvjK/TZcnUDVFSrKfpk+KypZPck5hBVVEbSBZgQRm9HlDesCZAsipUP66CmnPJg65m7yyy/DkzOh0ekOgfyI8YMlS+3Q+Wq/sJfXh+NeoRYuoInB2hRI2hB3txs4EUuBfSoPu31CXE3nV8biQLzUsvcsf7Zla1kGuYQNIj7XRYG0hTBxQ4CRS7bRgQK7pabPb94aPDAEtb16FKnfFqK+SXzZ9YHwlLaj5j5NwtiOdz+uqPnFz/cq3W3g6V7GZz//Nnp3OhqEvWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb9y5xptxoTw+5DwMFI1z1W4GRQwP1vQbI34CwWnJf4=;
 b=nsyV/XdHwiKnItGWNfqp+FT3ABRtnlzdsJUz7a/1aOMvPpdRVvqgtV04cGhpUJt4WablLBKL4IpLRmpBqMHHCdYKNjvRR6KgfS/gHLXg9q9LASV9HW6+IDVQoyXoORqH5LecMncq39re/Zkxm48canAxb3Gx7U/xgIzxAne1NdI=
Received: from BY3PR19MB5076.namprd19.prod.outlook.com (2603:10b6:a03:36f::11)
 by SN7PR19MB4752.namprd19.prod.outlook.com (2603:10b6:806:108::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 01:49:47 +0000
Received: from BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::2e7e:d389:dd5f:adf4]) by BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::2e7e:d389:dd5f:adf4%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 01:49:46 +0000
From: Lei Chuan Hua <lchuanhua@maxlinear.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <Frank.Li@nxp.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use use_parent_dt_ranges
 and clean up intel_pcie_cpu_addr_fixup()
Thread-Topic: [PATCH RFC NOT TESTED] PCI: intel-gw: Use use_parent_dt_ranges
 and clean up intel_pcie_cpu_addr_fixup()
Thread-Index: AQHbjfEyD/mpI4A5j0GKiUa0Y1kJFLN3sKUAgACC+Ew=
Date: Tue, 18 Mar 2025 01:49:46 +0000
Message-ID:
 <BY3PR19MB5076A8D664FAA83E7C168300BDDE2@BY3PR19MB5076.namprd19.prod.outlook.com>
References: <20250305-intel-v1-1-40db3a685490@nxp.com>
 <20250317175902.GA934093@bhelgaas>
In-Reply-To: <20250317175902.GA934093@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR19MB5076:EE_|SN7PR19MB4752:EE_
x-ms-office365-filtering-correlation-id: cf3486cc-d447-483a-1f91-08dd65bf2982
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?hJEdcLIK14hM01eTZA4mEoTWEaI3PN7QGyW8ghI6Pz0FszZ2x5UIUkW3ZQ?=
 =?iso-8859-2?Q?24kXPImiLnYuUWHUMCJDIE+erdYzcSUvJnw0QqThqJt8ucSv7ES/wf550E?=
 =?iso-8859-2?Q?jCcvFixlcinkHlrYBg5U9ZPe57OTvVTi3vSoenrIvpljsifakSdZYPfdDy?=
 =?iso-8859-2?Q?ai8FjnFlkEywFXFEwbAjTBshCDJB8I0+vvw4AbsBpeSN03T/yEoLSmBHiJ?=
 =?iso-8859-2?Q?s/xBqziUYzJ6RM15o7PBnyL01tSv/3K4rbpKMjm8XbKDkAf3BXuGW6rJu5?=
 =?iso-8859-2?Q?4tdZsS2JUxOhgTcvVWDhKzqKPXQzXmDSmN3L/pRtTPPIkaWDg6La0YjUnh?=
 =?iso-8859-2?Q?q4phY2HZd/cjFNxfp39DP6zpMZlGVEYL4IMi7nfbHG6AMs+o4sKE/U25Ej?=
 =?iso-8859-2?Q?05CxiDLN/HmiJw1Zpgfp4sL8Pd4N+MimEdO/YbqSaxStioyijJJaeTiyXO?=
 =?iso-8859-2?Q?jtGnFLOAmEC8yD3HSbvkZhLckHSn8KxmJb4s9drN1SJnSbz6OjZ66tII0b?=
 =?iso-8859-2?Q?XAreA5XK3XOtd+YKFLnPIGKyS+BVbWV1RJz5HAJ2aadi+DzgPEgIpfN8k8?=
 =?iso-8859-2?Q?zPXzftQUG/5t6cAqUPgrhmqXKdAIPh3AJlQakZhpmxrmeWPuAaEWnebZt3?=
 =?iso-8859-2?Q?tefgR4Y6jcsjo+WxJzk3MzpjfP62ck06Cn5wlqDJO5TG4D0cS3ZsOAeDyh?=
 =?iso-8859-2?Q?NIJNVg2ll//ai9kLrnpU4QMLPtjIhCeDEsJglfUuYjqsCNgm6YKShDgsoI?=
 =?iso-8859-2?Q?+yjJSse65pSjo/bqNvk7saDzwTY4XwSLD9bdGsUrZSfT4ZyS3yqrZU5aov?=
 =?iso-8859-2?Q?YgROyuohzymVBg1AATrsXrD8Wm2EwES9k8k3e05wT0CPluBMmzZk3dbtrZ?=
 =?iso-8859-2?Q?B7QAVW36hCd+R0wDs4F8qSkCtJdiMijQJPrzoJzCYJ5FiMW7PObyaOpy4g?=
 =?iso-8859-2?Q?XRnCyb4BIXHnRQzUW27iBJjXBdVP4inVk4t27CP0lOtytuo6KEe2J/jfkP?=
 =?iso-8859-2?Q?D1Aa9eFSzgMVuEXniDkNVTk0yVvXHPmgkz4z+2LIzW/FHaum7QwXf2pgEu?=
 =?iso-8859-2?Q?gHHCRqEzWaCsIglLpX6R6SXdHiIDiJ5xi5wWJXolKddxIu/4cmDcC2tNxj?=
 =?iso-8859-2?Q?a5m+f4xH8owRIYgxOb1B+/pLxFOqfdwToAUA3kZVKaNqhTa2cnuN5e9OIr?=
 =?iso-8859-2?Q?d1x2/yMborfySP7UAqZMZGMYo+A74AFaqhSek6xv/j86B3LiVA7Na/T3pT?=
 =?iso-8859-2?Q?WAnRMqqxD5uqJ4QhVcUmLObb7kDC6qE7/K0oH+bmSh2Lk2KnHXyoA5bnTw?=
 =?iso-8859-2?Q?jftf3yhZ30hYGPUpSl1w8l866FdMYlaBZ6Rjm5DfsQReIgKE5vqkeZzjtw?=
 =?iso-8859-2?Q?Bt2rDyRdwsJJPAAiMj1ygAnsvEx0ZisxekDBMPeILQ/J/MHI+58q69ao8U?=
 =?iso-8859-2?Q?krjFoAR3B3j3e5g1hzkusfPMTFwHaxs0qA3nfeVMJZYKNvg/tBBZrakJ8X?=
 =?iso-8859-2?Q?lshR82MGBkuTnuFzbB3DPS8gk2aP0nqA+UdE/T9JYi2g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR19MB5076.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?yWZZEdw5MYoKP7mmD+XmUGt2YggPC2pNLuLbpW4Z4j9nCgkqoRnamsGCaq?=
 =?iso-8859-2?Q?dHOdlvxW4ldY9+gNa57mRzUGL2d3KAz6x0e3q3bEvL0nWaLN/k3Wae2kqL?=
 =?iso-8859-2?Q?1JEc9v9K0fnu8jfF2UT//o6UVEuOEmaajC241Cw6oqsMmKVVZlnAA6l2wh?=
 =?iso-8859-2?Q?zjavPbWBw43aGRVEEWzJzmQj+cOk/UtfQDeIktSG5ER7dOyuaT/9I9bWme?=
 =?iso-8859-2?Q?wCy60JTbIuKLFuVSi3dEJbRgxg9XUOdw0E2danQUzOI8m+ln9XHKJ3xfO6?=
 =?iso-8859-2?Q?GGcMmkkXRKfMiMqk0wNe40VNLYkATk9U78aOV/IpinY1z7W40v4uMiUJae?=
 =?iso-8859-2?Q?u2wPTtIwuCc7raLCwup2+/cqqKw8Gug10I+DlASv165rD3YNl/iHehMSp2?=
 =?iso-8859-2?Q?GMiKQvjrVapjywnxdSmGy8lHhkYikjKspj83bzGjDL7KW8ANdnKbJLBuRi?=
 =?iso-8859-2?Q?D+u+oRnUvX4jgHP74ashkRXd6QGL5QahR7EpFhY/VhTB7H20Apx3k3lnN0?=
 =?iso-8859-2?Q?IdSTNs/69Kr9mt7uiWscaD5Ge5UvgIOFfSEN/KycraNj8l2uPZpOgl/5sb?=
 =?iso-8859-2?Q?q6Zkqs5A8KYrVziMmDg4riDXnGrPD49F3xVe0hDncP2g1dAQqOaStioeIg?=
 =?iso-8859-2?Q?deUMsjUVO8waDS57G/u7iScryI7yybg4mywELy4rDjuEVxQCbEyQwYZFAL?=
 =?iso-8859-2?Q?FfrAIjQB9ErZNz8y+l5P5W8EFryymeP69FhSz9c3ZrMEbQ37hFw9z0c6g9?=
 =?iso-8859-2?Q?w9cpoaYm20mTgbjuxKmiUT9dGkbWttgqSsq/yqS99utDDbAzUhRTU+HhBg?=
 =?iso-8859-2?Q?6C6D6vSpB9ZijBIbKzSpJ9e0og2Yiuft4ExnxRbTJUy1h2KFCm0N/SsoOr?=
 =?iso-8859-2?Q?BcfiBRvVCGuwhDid+nuo4v0qMT7oGyMZ9HJiKUsFkAl3LbG+sGZQx36y7W?=
 =?iso-8859-2?Q?4xJ6XgQ2MP3V/fIh4c1HW23BjSRwWwGJ0+D8EZBpzGGnDIzXBypyx+Q4Fi?=
 =?iso-8859-2?Q?h1fALNb+DZH/KcWU5J1iPfh6A2e0FcG1kRNKm+tFzIpkufKWoVshBH3cL9?=
 =?iso-8859-2?Q?8duGGCOQlfCMTJ4QUt0vG36csJE3GyeGQitW+udy4vLVDTFUEqLhFhGrsd?=
 =?iso-8859-2?Q?qdQuXBdAcgqwkxrptz9O7rM0nqK4IOY1ygaNOLQfczs1tRNQfAoDR+P/pg?=
 =?iso-8859-2?Q?g0p3txtKZkUZvo3YQNDj/3/bt9RqrHYDTx3KBaoIoGF1StIA6DPOyRHMZ0?=
 =?iso-8859-2?Q?CAI3hTwUmix72PoK10wwkvpVi1J5cCCBLt6ylUgTIOnNaUbUdryam1tUt+?=
 =?iso-8859-2?Q?MRwLBBpsnyU+//Ytvko3+UM/nL6mpF/eaLK6SmXoQ5Z/P4j6QVnf51KQrD?=
 =?iso-8859-2?Q?2I0NZ5EhqOgpEvPpQR9TUtPpvtyMBBoIWRfxntSNkr6K99AAn63ByVr/lH?=
 =?iso-8859-2?Q?wSqXBErRQq2LG2rg50dCGSXGcX3XNIgY2YhS0G/mR/nixhekOAa5VBiG9P?=
 =?iso-8859-2?Q?pAkzlgst0+KBBVfxxqXf6MN/KucESGTQ2sDTg4vrwaCVHZG8cfVf5K0ehc?=
 =?iso-8859-2?Q?3jmDNd/ft78YXlSXqjqd9W+oSDCj8uBwvRxF3fcEHdLQhYBtRs7L0yhdl6?=
 =?iso-8859-2?Q?D8NuRZtDvGmKAYkOTGgnrBnqmYpEnGim0z?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR19MB5076.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3486cc-d447-483a-1f91-08dd65bf2982
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 01:49:46.5962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SabOORBex/9ASBeeeyOROxFK/R8sNC9V3VubCCqZQnwYePdTkpsgJbqg/b2sugOTLsxoaAznZoUNBsJrs54+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB4752

Hi Bjorn,

I did a quick test with necessary change in dts. It worked, please move on.

Regards,
Chuanhua

________________________________________
From: Bjorn Helgaas <helgaas@kernel.org>
Sent: Tuesday, March 18, 2025 1:59 AM
To: Frank Li <Frank.Li@nxp.com>
Cc: Lei Chuan Hua <lchuanhua@maxlinear.com>; Lorenzo Pieralisi <lpieralisi@=
kernel.org>; Krzysztof Wilczy=F1ski <kw@linux.com>; Manivannan Sadhasivam <=
manivannan.sadhasivam@linaro.org>; Rob Herring <robh@kernel.org>; Bjorn Hel=
gaas <bhelgaas@google.com>; linux-pci@vger.kernel.org <linux-pci@vger.kerne=
l.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC NOT TESTED] PCI: intel-gw: Use use_parent_dt_ranges=
 and clean up intel_pcie_cpu_addr_fixup()



On Wed, Mar 05, 2025 at 12:07:54PM -0500, Frank Li wrote:
> Remove intel_pcie_cpu_addr_fixup() as the DT bus fabric should provide co=
rrect
> address translation. Set use_parent_dt_ranges to allow the DWC core drive=
r to
> fetch address translation from the device tree.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Any update on this, Chuanhua?

I plan to merge v12 of Frank's series [1] for v6.15.  We need to know
ASAP if that would break intel-gw.

If we knew that it was safe to also apply this patch to remove
intel_pcie_cpu_addr(), that would be even better.

I will plan to apply the patch below on top of Frank's series [1] for
v6.15 unless I hear that it would break something.

Bjorn

[1] https://lore.kernel.org/r/20250315201548.858189-1-helgaas@kernel.org

> ---
> This patches basic on
> https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp=
.com/
>
> I have not hardware to test and there are not intel,lgm-pcie in kernel
> tree.
>
> Your dts should correct reflect hardware behavor, ref:
> https://lore.kernel.org/linux-pci/Z8huvkENIBxyPKJv@axis.com/T/#mb7ae78c3a=
22324b37567d24ecc1c810c1b3f55c5
>
> According to your intel_pcie_cpu_addr_fixup()
>
> Basically, config space/io/mem space need minus SZ_256. parent bus range
> convert it to original value.
>
> Look for driver owner, who help test this and start move forward to remov=
e
> cpu_addr_fixup() work.
> ---
> Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
> index 9b53b8f6f268e..c21906eced618 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -57,7 +57,6 @@
>       PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \
>       PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)
>
> -#define BUS_IATU_OFFSET                      SZ_256M
>  #define RESET_INTERVAL_MS            100
>
>  struct intel_pcie {
> @@ -381,13 +380,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp *pp)
>       return intel_pcie_host_setup(pcie);
>  }
>
> -static u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
> -{
> -     return cpu_addr + BUS_IATU_OFFSET;
> -}
> -
>  static const struct dw_pcie_ops intel_pcie_ops =3D {
> -     .cpu_addr_fixup =3D intel_pcie_cpu_addr,
>  };
>
>  static const struct dw_pcie_host_ops intel_pcie_dw_ops =3D {
> @@ -409,6 +402,7 @@ static int intel_pcie_probe(struct platform_device *p=
dev)
>       platform_set_drvdata(pdev, pcie);
>       pci =3D &pcie->pci;
>       pci->dev =3D dev;
> +     pci->use_parent_dt_ranges =3D true;
>       pp =3D &pci->pp;
>
>       ret =3D intel_pcie_get_resources(pdev);
>
> ---
> base-commit: 1552be4855dacca5ea39b15b1ef0b96c91dbea0d
> change-id: 20250305-intel-7c25bfb498b1
>
> Best regards,
>

