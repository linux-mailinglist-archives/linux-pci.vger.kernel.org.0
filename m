Return-Path: <linux-pci+bounces-34859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F3B378E3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 05:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86E87C31A6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 03:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2520330DD3C;
	Wed, 27 Aug 2025 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VS1LXQLv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5838D30DD15
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266792; cv=fail; b=kerf0dKWCg1P4mDAJONG6Nc+BSDkeVcj0+ualedwF58ltordsWPyypO26zBgHxvIkXpZvxRusuCuzVzNSamUaj6BXRfVaXxrZfFLkE87t4rZlDcej/1lc2zPObAGTw2urK17ddjTJ4Ac8aFIN5r4LlDUCG2bOVmhnBSIYA1BOKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266792; c=relaxed/simple;
	bh=TxP+TACKpduja3WRtzeVrEpCeg1uwoBnoZZ0+o0XODc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pBOOvH1V8aqUxYikXE4ZM22y3nptdVAD9A3e79WGWAXWZp7x+11dNSMPW9TUyYnLjGOzx0WxZEzzsos/VFCen0/sJnzJm8AZHKdqBtBdssZO3N8cyisiXnkWATDL8CQTYcgrXEnUaH/0izPwJl/jVrU5fJfIppRB3BElV2uI2go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VS1LXQLv; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756266790; x=1787802790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TxP+TACKpduja3WRtzeVrEpCeg1uwoBnoZZ0+o0XODc=;
  b=VS1LXQLvmyuEg56uqXKV+qE67b2B2ZfqE1cJpJU/s1ZqkYQRRIvLocai
   GYoxZlfA16Ux+hvgTjMaOrz9cRxEsQrzTXuHqVGiJ0UaFV0Q6TAzWNUN+
   +L1rqIPJXE3HtClPf250eDUoKJE7GodnbV1T8tZB2BVDu5Cspr+trch1o
   XmnV+hhd7RLRM9pzXIo+MCnkwPD7TapZyFpaopavumRx/9FCztPsAdPUe
   Duu5ckozh8ite8iNE9RA5wCSroUglLTq7hN43XCMYbT6fKzdVXr6tmCud
   yzXvdMUudxtLEV3EsUZetAY5Aub9pKVKTMqB/jyFpDiHyece8dEVVfrqU
   w==;
X-CSE-ConnectionGUID: EEz5Z3FaT9Cwc8enwFMAQg==
X-CSE-MsgGUID: tpXWQQ0eQWeTNVV6uhKf0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69106503"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="69106503"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:09 -0700
X-CSE-ConnectionGUID: GxtdD2roQbqXtnVNNOrBNQ==
X-CSE-MsgGUID: 3Gl1SRoZSg6Z4cyNN2t2pw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 20:53:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 20:53:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.55)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 20:53:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwQ2DCtmT9/vzkVVnf1jKIbREIqA3FWInhXWhpUZ81DTBDbG4oXRY0uHoB48ikvL2j/kqimsGuU+CurvhNm7UovytxeGQy1z5Gcs4vrT5BfbjMkZwuFuZw0+5q2CiDYoqFGyhUnl+c8YikgIt2AVAn9Iy7VlBIselINVpUdP+qRoTDH5NHDotqVhRpdKY/lgAvdjuJC0RSQGn8Yibw0lBkGBRkqwwPfetl+JxBhJCv6wUNEGwhf1fbrs3Cb55Inw/iJXBTex+HngbaozXwicxpGtdZonz0885p9S28XZZa25QPl4n+02JtDrXr7zb7Yhs2YcCFY+6ETskEKBI8tUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kg0wRwZpLiC+m/7DK04WiWsY6fGCbwYsnBoPhcD380Y=;
 b=CIdocx9Gzqj/RPaPgHNaB9CGgRacuEWcL59ol4SJwyFFcRaUDOyi1eP1ZA6LRba9C1VnOkgcQ1h6LgWbsvI79NwukOO1jDGpEWzX1qYWAtuFf0eCe7RPvRXtfHATww5rEdFQU+UBbfC+m9vvIfTFZ7bjOGZqbczMvEVKb4s6H2HKtC6JlgNHWOdlse4Mrm2mvFECKwXhvgIRTunnOtJxnxvVMmXdBhVJr6CTIAsc/6costyxxPcwlZaxp55PLA3XxQ9gv+oIJBhGb7j7Q001jon2Md3Xe7dfUZb0E7JxKF6ff769h2WYbZIXNDK3pfTSkqdin+zuDk8SUFQm/zDE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 03:53:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 03:53:05 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <bhelgaas@google.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <aik@amd.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 4/7] x86/ioremap, resource: Introduce IORES_DESC_ENCRYPTED for encrypted PCI MMIO
Date: Tue, 26 Aug 2025 20:52:56 -0700
Message-ID: <20250827035259.1356758-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827035259.1356758-1-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:303:8d::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b58688-0cfe-461a-dc56-08dde51d3a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hIkzRYq0GPQrxWmtFrg4wcZt7M/4REcXcm5hVVe/zf1xQCwrlDUk9IV5bw/9?=
 =?us-ascii?Q?efc/xlwhsKDXCoCVLxoys1YlpHQxThQ8E6dZuNR57qi8WnyKX4tpNw5FCMa1?=
 =?us-ascii?Q?AjWm8oRHbbxDm3lixqBGgZqVoI/cMQL37CP1LtKDWNC9VMWJ+LItG+ZW2pef?=
 =?us-ascii?Q?AOAbs91DkX/7un2CfjC6xSfIhfildI1JOrzJ7v+igtxBNJJmwPVvJnLbfPHC?=
 =?us-ascii?Q?FVrddemAKDsoMm9GXOBrsoe/nqmb2MOYKgd91AFiIYQkuLOXdAxM0x2Dalru?=
 =?us-ascii?Q?u9ArmucJAuyG6HXlOidTymtoO6RpAC/5X1ldJM5eljZG9Ws2JYd9n409G0eF?=
 =?us-ascii?Q?hKxSewP5TkCUc2N0nxJDwtH2bw7EK28l0t5pVWTSY+3JlcrwrzjGZTnDg2di?=
 =?us-ascii?Q?zWYjeU1Yho/HWgx3oT2C5JPQLozKnCGz8FcVpXxmi5TCLM2UdTfo7tCPSMvP?=
 =?us-ascii?Q?K/PTvdyBMSh6RSWTJLw/8JS5GImDaFPitez3SYWrqbiiiyzYS2ZnTwtZPT+p?=
 =?us-ascii?Q?O6AKP+kAAB6o+PJkBFEhHJT2+5TsO3b4cAfrtjoNEinaFXmncFUCLvjs+dFh?=
 =?us-ascii?Q?Jtpr9N0642orKDAmr6/QEuTgx/YZdd9i1TOohr8AxSkh+z5ZGadETrP2OTJc?=
 =?us-ascii?Q?0CAQgsI13edLvxCRyGZc6P4k7ldWRJ29hqpfPt9E0h8MpD/Vrin6p43oSc90?=
 =?us-ascii?Q?lk3unQBsv4zmUSv1X8BBuZNimMbke0ENT/+Au+cZGP/6C4Yn9IDPxiWtVtIe?=
 =?us-ascii?Q?y5Gl0KRsUWxTun8EZ3koYqhUpOhT+nOIcugBsrZhqF9YPg/3APgwafWbXOA9?=
 =?us-ascii?Q?IUwARa83MQ7Nbc5QZMdu0nUqw+ttcLv5PAXImRTUHouPh6OL/1E6nhwCQ2GX?=
 =?us-ascii?Q?Z30UgLbiZACX616dLhKPnY070XPHy7ykkC/NkEeeuDWHi0cWYzjYmJ5M0pPT?=
 =?us-ascii?Q?cy5m4Nz1Y6ASgC+CbHkiA9VyKm+wZcyRB0k07+ZKT0b38PRiweJ8C6kJgSMC?=
 =?us-ascii?Q?2FTK/G9gkgC7O4qZo3lXCNWTc9co2p3MXoeYfavjVWWzeJKwkEUT3Y+4nyDx?=
 =?us-ascii?Q?fzEvS7bY/WA4X0RMiJsxegM6e+fL8w/U72MUaXx7Im54qziVIfg6DhFo6WqZ?=
 =?us-ascii?Q?6S+xNfTrhNzUjE2XYa4njJ+CN23AkDNjY4GjOwJ/yUdrTJ9KeFfYHuffBs9j?=
 =?us-ascii?Q?auwL9QwZxAATpoyg++tYjcbz40M+JYN1NS1kkoek5OkMwhiFmqOP/ny89Syx?=
 =?us-ascii?Q?GqNClF/PuWA/3Kfy+P8C6dHG5XCFOAE3SA1mJdGeRTIDOI8UuI3o7l4wC/ZZ?=
 =?us-ascii?Q?qjs9tr5pt6P8dpK9FcYS2vEnL1Qgt3sl8sarrT5zytbZR7BnorlhNzVktw76?=
 =?us-ascii?Q?4+5fUTs8dtuveS1PoYbsUfcfjNCd5rBTB9Fqsss8mZrc8CRfbYf6o11vHxJJ?=
 =?us-ascii?Q?ePr3w770+FU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TCRfKvX875//Oe//5CRP5ZXhHRWFfMbB7sgl1L6xY6pmWVFn+eW3p+NOM2oh?=
 =?us-ascii?Q?EgEM41mO8dUSyQufDQ9gW6bWC9Czb0oYsSk0UB9CK+iwX3gTQloPZxKYQr12?=
 =?us-ascii?Q?nxs1Uxsgsk9mM5bswXiDNFMK0CTTq6qAUAEPSqShjh+erim6XcZNd8f/zv5D?=
 =?us-ascii?Q?Uy1kEmjd9I4a7YDBtwKSIpPopWa0VshuvMNCMay5t39pOAfx6Ec2NnP9ky99?=
 =?us-ascii?Q?IlXOpi8XhqzolHxaeOBTiL8DTfy21j4fwyWIxfpPa6KpeYXuWsn3AVeUawWO?=
 =?us-ascii?Q?X0SWsL5fzjKFsUw47vLBgiRrjeJBNCVtMZjIY+FZDb5RXXSItKKJahJ24s+b?=
 =?us-ascii?Q?u9j4uQ5qdczjQbwQKkueG+ov//fJAXP7TjiGdv9veq3Gy/1Xd0VGDE2PVQOj?=
 =?us-ascii?Q?piWrzRcrcosB6FiMG6y46D0bHV3AajhpS1efMCWRpfeY2EixOFuJ5GYUfnvx?=
 =?us-ascii?Q?hFbOK2YYw659LKTgTyXGfmcejwLogjdXDD3yOJKKYl6xy0xo2qQTitBGlg1v?=
 =?us-ascii?Q?exj3OZtXSQXnWdTLwGoU56e//RBYpZiqpF6DjBPSmiHqsLdTtJK8vpu73joB?=
 =?us-ascii?Q?gXYe6bZvJWxC/953T8ZJSZXHaKIOKSLgJ7GxQDOn2cglRqNKUKGMl595htvC?=
 =?us-ascii?Q?ADjTN08+jxicITs51YROpgemyBb0TsYW485IVP13tSk6Il2TnFZ9zZ9h9TPv?=
 =?us-ascii?Q?jpuW08Z7vFbFKQDO2hLVp/SjvCADBj9K8o4NcsQ7wqNGyW7btrxK9aNfYJHK?=
 =?us-ascii?Q?lWFNXB6BovsUdqTKA9WoHoujtl65Vt7u+2b3LWN+NVK85jFHHrtDrm+12ORl?=
 =?us-ascii?Q?mgs5a9NF7ZVY+gYjD6qBTtP7EvNdrbKPb5hVwucPb23tmN6eWiEylGwh6R0t?=
 =?us-ascii?Q?iDChrSL5PqNHTUp7rsXhyvE1c1j8zJ/XXmFDOt+lWe1OtPWtZqAO4nGnJzwh?=
 =?us-ascii?Q?n1vDUwmAfqD05WOyWcysCmI4YQTCFdGZ5LaMGKt+ztuLmNI21Ho0dy72Dpoy?=
 =?us-ascii?Q?XvCoPA2O1qGt6CZAO5DkhooqRpHIt2IQUnKjUL4OoC7a7OcT90K7kdhQ8hVa?=
 =?us-ascii?Q?hs1K24YW2ydCh//sZ56xERklLX6hue/AVbXQAwpCBVAZS7SvDd0Jx6iLxzct?=
 =?us-ascii?Q?yAb2hZ9TQcf2QDBLbPowybbcwq3P0AMYPK5wJvOcuRxU+0OKxBYHys9ZI2G+?=
 =?us-ascii?Q?ldhxBDV+F/VvVmso/+JRWlEtARRMkdEMXOxbZATBV14laXuEv6NY8F5MNbVy?=
 =?us-ascii?Q?io6Uwfs15OvNF47V3Gha8ZiUcX3Xmjshvw6LnJQ8k5rUB79jbUuVlWGxEoTw?=
 =?us-ascii?Q?F/MZ13wpCJ1LLoqEACSVelPWUWYkZb0nQqbNjjkGFjU3vRchb6kcPyqXrvQA?=
 =?us-ascii?Q?Omm/YzNo244/AJR6k4QLL+X601yw4Xr5yuxD6529utzkSJV/D/JoFHI82Pvu?=
 =?us-ascii?Q?vVvCX0f39mjqdS0CYSfikd8h37gU5wLZabTJYS+oJwRyoKchwRL9ORC8Tqts?=
 =?us-ascii?Q?eMtrspc8TD6Z8UiIf79OnkNaFXkWDDYTlqYuLwNwk6jtD81IRUKdOiTJ6Rs0?=
 =?us-ascii?Q?KgD9WXVhMkSsOy/sfx19ZF+w+xhdm0urS9012vM0AzvU3txuYIyAQIOjBcpM?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b58688-0cfe-461a-dc56-08dde51d3a66
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 03:53:05.4260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CEs/3DN2L4/HgnOWDMbSO9odd/gNySIcy8daSq7rSA/YZqTzjRFXxDeGNQc79spjBPhLj5qen0CW8P3ve4YiP3m5DJ4m3vAS3UobyFCltU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6170
X-OriginatorOrg: intel.com

PCIe Trusted Execution Environment Device Interface Security Protocol
(TDISP) arranges for a PCI device to support encrypted MMIO. In support of
that capability, ioremap() needs a mechanism to detect when a PCI device
has been dynamically transitioned into this secure state and enforce
encrypted MMIO mappings.

Teach ioremap() about a new IORES_DESC_ENCRYPTED type that supplements the
existing PCI Memory Space (MMIO) BAR resources. The proposal is that a
resource, "PCI MMIO Encrypted", with this description type is injected by
the PCI/TSM core for each PCI device BAR that is to be protected.

Unlike the existing encryption determination which is "implied with a silent
fallback to an unencrypted mapping", this indication is "explicit with an
expectation that the request fails instead of fallback". IORES_MUST_ENCRYPT
is added to manage this expectation.

Given that "PCI MMIO Encrypted" is an additional resource in the tree, the
IORESOURCE_BUSY flag will only be set on a descendant/child of that
resource. Adjust the resource tree walk to use walk_iomem_res_desc() and
check all intersecting resources for the IORES_MUST_ENCRYPT determination.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/ioremap.c  | 32 +++++++++++++++++++++-----------
 include/linux/ioport.h |  2 ++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 12c8180ca1ba..78b677dadfdc 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -93,18 +93,24 @@ static unsigned int __ioremap_check_ram(struct resource *res)
  */
 static unsigned int __ioremap_check_encrypted(struct resource *res)
 {
+	u32 flags = 0;
+
+	if (res->desc == IORES_DESC_ENCRYPTED)
+		flags |= IORES_MUST_ENCRYPT;
+
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		return 0;
+		return flags;
 
 	switch (res->desc) {
 	case IORES_DESC_NONE:
 	case IORES_DESC_RESERVED:
 		break;
+	case IORES_DESC_ENCRYPTED:
 	default:
-		return IORES_MAP_ENCRYPTED;
+		flags |= IORES_MAP_ENCRYPTED;
 	}
 
-	return 0;
+	return flags;
 }
 
 /*
@@ -134,14 +140,10 @@ static int __ioremap_collect_map_flags(struct resource *res, void *arg)
 {
 	struct ioremap_desc *desc = arg;
 
-	if (!(desc->flags & IORES_MAP_SYSTEM_RAM))
-		desc->flags |= __ioremap_check_ram(res);
-
-	if (!(desc->flags & IORES_MAP_ENCRYPTED))
-		desc->flags |= __ioremap_check_encrypted(res);
+	desc->flags |= __ioremap_check_ram(res);
+	desc->flags |= __ioremap_check_encrypted(res);
 
-	return ((desc->flags & (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED)) ==
-			       (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED));
+	return 0;
 }
 
 /*
@@ -161,7 +163,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 	end = start + size - 1;
 	memset(desc, 0, sizeof(struct ioremap_desc));
 
-	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
+	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_MEM, start, end, desc,
+			    __ioremap_collect_map_flags);
 
 	__ioremap_check_other(addr, desc);
 }
@@ -209,6 +212,13 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 
 	__ioremap_check_mem(phys_addr, size, &io_desc);
 
+	if ((io_desc.flags & IORES_MUST_ENCRYPT) &&
+	    !(io_desc.flags & IORES_MAP_ENCRYPTED)) {
+		pr_err("ioremap: encrypted mapping unavailable for %pa - %pa\n",
+		       &phys_addr, &last_addr);
+		return NULL;
+	}
+
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..b46e42bcafe3 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -143,6 +143,7 @@ enum {
 	IORES_DESC_RESERVED			= 7,
 	IORES_DESC_SOFT_RESERVED		= 8,
 	IORES_DESC_CXL				= 9,
+	IORES_DESC_ENCRYPTED			= 10,
 };
 
 /*
@@ -151,6 +152,7 @@ enum {
 enum {
 	IORES_MAP_SYSTEM_RAM		= BIT(0),
 	IORES_MAP_ENCRYPTED		= BIT(1),
+	IORES_MUST_ENCRYPT		= BIT(2), /* disable transparent fallback */
 };
 
 /* helpers to define resources */
-- 
2.50.1


