Return-Path: <linux-pci+bounces-11385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACB49498B3
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188411F23F4C
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64C154456;
	Tue,  6 Aug 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkC4PtTw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65831150990;
	Tue,  6 Aug 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722974200; cv=fail; b=KnWbUWbGYY5Ic5wn4tBcJcOhgbbb1MKKRZDGezAEKOgQ45yJLel3qY7l0VPFN7fhgkudaKwqnbKtqJColhfGuuAsKnYSOje7/ULPv8QpIR8usvBXa0jN5aUbLwNHYU2hrt0MD6Oh4BxhsJyqc6qq+UjA53KSFAPke+N+BHD9LUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722974200; c=relaxed/simple;
	bh=7gxL4W44xcqIFckzyf7IFKARYDlDDdVGxkJAMgbzupI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WDucEw9LGnYNegNZFnQBgMJj42Tdx3wLP7WZiFMWOlw/hALPoIK6bZzuSGMnDfsK2n6YOSAj/UN9dIocHx1KEenuNPqUaXJZgyC4hwSikuPujjeuBgQMb6BICtW8s6WTfLBAq9fvvNRf27F4ZQ/g+1zv6vDkU/WvYcC3yNGYgOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkC4PtTw; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722974198; x=1754510198;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=7gxL4W44xcqIFckzyf7IFKARYDlDDdVGxkJAMgbzupI=;
  b=ZkC4PtTwj4sp06MvDGES8Eeec/iCWSAEVirkM/93oKe1kpudaeo0HfDu
   3/K6WQ1xnSV2fduUsIty9sNw39U+n9Sbl1PlNRmXEhHQ30GPsBxjiwvS1
   tyAehX3txO0oiJuoy2Me5reOUTZY0iii9lQugZ6tBFW87b1pW/izhrd4C
   G4nUFJsHLx0rCZCG/rhgbsTys1NEOqh4OMhy5EzQt18emgIbZBv/yuz/y
   mHeJCqYZrDAbXjmDlGEvhtcYeML0yDCnq5HSn2aeMf+NXwB+AChxmvMOa
   84m4ANOU8jPANhNbtRCbxbJgwx53cs+U8ce3qafK1ev2DgxjYnYOtb/Bj
   g==;
X-CSE-ConnectionGUID: XtZI3xF7RAKD7ApQ/uMDyQ==
X-CSE-MsgGUID: ycTgHXqvRSOtPnLLCWi6WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38469410"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38469410"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 12:56:37 -0700
X-CSE-ConnectionGUID: i69s0pk1TR6A9fUbcsEtRA==
X-CSE-MsgGUID: rHFX8wr2R+qZDbVTstaXBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="60997445"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 12:56:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 12:56:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 12:56:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 12:56:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 12:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpVhcDovygKa8sOigE2JcarRx93fjtq+dcnwedtkGULOcisGiFH9BhttY6Q63Icl4edwmoXi2aba0SDxjyXOcxexOnRyOS+YvqXa04OEv8t82DLkMeuvwQ9f35PAQadcrfVWOElFTZlFW12Qm4eoLhAwQouoCVNE4QudFpxIQVcur76U3TyZ0t4sgoKiz7v1TEosyTOBlyfD1rsgOH0FdZB+GlAXUjbF3BMfILCz7QG/AZgp9c8Yw1CPoDhSOxVwXNgVAzDlVOtpdCKcjuCeR80kXPou2a5sQoemMuHJT+kVLLFafozNwjBwVmQq38pqkn7AvaaehYtm04euBC3wJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQraViS+rbT6dM8SPHybblyBFak1lLSZsYwxRWcRdV8=;
 b=kE0gXG9UuESf8iTj4Zq8NuAuMX2ox1kVfUad6MkVgAEqzBeXi77elR73yCw2DtgcZ6IsCaATraRc4ULzIDoOdsbn6FFhCK2RAabYBa2dnnqmq6qVs/6sWXX13Osq1B/bLcsqmlN7gCN1iEql5W8fmle2hnJZRQiI4C/yXAdu7O2g/1wGfoJfPJzg56AFQr48da4jsqbIV/K6QIflLHtCRHVeANyBqk0MgUj1ZHpRgGqmKSSPCCLkxK5XkKWeYPm+usqr1bl4V76nUIb0O7bB8u4N86BSSSHHxfW7zMkiB+5uJuOta8Vzsk+zH9gG30bAafvsLtybkbTomJfCRshJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 19:56:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Tue, 6 Aug 2024
 19:56:28 +0000
Date: Tue, 6 Aug 2024 12:56:24 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, "Mahesh J
 Salgaonkar" <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] ACPI: extlog: Trace CPER PCI Express Error Section
Message-ID: <66b27fe8d73fe_c144829438@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240527144356.246220-1-fabio.m.de.francesco@linux.intel.com>
 <20240527144356.246220-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240527144356.246220-3-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 99477e08-4405-4055-5ab9-08dcb651dbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UEiZieCaYZl6Dnz6pbR4RodZHGfk+NNU7/hEPHEDbvOAbZ6PQcoNlPZvBC8W?=
 =?us-ascii?Q?qPSg96KpwJ6YqscPbW9C+Moc9CQTHnFXK9ubZz6t33IqHMq31bk2dTv3izN4?=
 =?us-ascii?Q?PH/ixPJm33pOsS8Gj8dRLZwq1iwEPXeyOjGOOSAfLO6ejjgXCcDMLQFysbJ8?=
 =?us-ascii?Q?t5j+AagvCUU9106r9aTs6K5lN0KRwjGLAMs0cibDnHy6NOdyWhFU0VI1po4C?=
 =?us-ascii?Q?9zNNaz/0st9HZJp0pRUdcSXds53TbdwGOMdn53o5VBsKiqWboR73XEFed39+?=
 =?us-ascii?Q?Xl5axitpmTWCK9zJ1TAF8Or8+F18iprfkMT5W/IzlfFL9c9TR+qL4DXMNj1u?=
 =?us-ascii?Q?+oZ71LLhRBtjs2SBuvGKhaF9/k8aDdKjzIxKRe0Kr0quHDPU1UHthmBztFMD?=
 =?us-ascii?Q?rnz9f4IbRf4Z4z72JmPgj8lSa/u11hCX7uWMd+hjp6MogXUPrJffOXELyRhU?=
 =?us-ascii?Q?ZtWJxduhjtjFJOdoyTOHL/DGf9wgjAmd1mJQXrljSCD1f8H42tAZch8ofjML?=
 =?us-ascii?Q?aQWFqR1KD+KC/dfQiLtuAYw8d5XTQz8FhIexikohMf8BMaYYOUuQColIe+zd?=
 =?us-ascii?Q?pyeUqcnTwEHDNzCYYT/vPpbkYmh0A+3wSBysd/bxQq3jJiJ+fjH2qSxAUiBb?=
 =?us-ascii?Q?g63uhMINVeM5cAtFWjE6MGcwPKgcnNilUEab6nUAygWxkNUMpezdXpcgGCLb?=
 =?us-ascii?Q?ntZfItBeG75sWw9qLkEQrnX+ApRWqkLQsBPoOqtHUmzy6UTOUdqPk6MtNmrx?=
 =?us-ascii?Q?S2OEkkU2w5tDv+PJFE6iLuXlr19arpRf2V7WtGa9d4jtUvvgUfMiEqlpGh3Z?=
 =?us-ascii?Q?M71wFkAgkZA0Y8Eb8FfQyW6dvY3GAzyl0YNfOpMn9anvKQzOxRbXOYSYVBgS?=
 =?us-ascii?Q?nns6kGayHu4OXrIQq5/B7Bo4KXdI/l0cCZ7IZK2DGgBkJ9/Gre1jDdZEl5ux?=
 =?us-ascii?Q?hI2QxnsDXZDhiuNJdWbTjgPbuOxhMV/AXX+B7kI47qnoZaHQSpCWOK8ciw8N?=
 =?us-ascii?Q?0IsND//J1kKKnILeFX/guUDdebomJCsZKzeNJHNUmZQKizsmCyKOvXPgrfga?=
 =?us-ascii?Q?6JsRXkzwh9SIEbU/Bb6uVusiIegVMTnJQevQE8Ta/rt07NAL6eN6mLg3UhkR?=
 =?us-ascii?Q?bzXB7a0KvrWr9+ATKv4NJSK07VJrCEDpI+GcYamlYs//JkFY9FWgVGxJeOpl?=
 =?us-ascii?Q?LeFXIRn5FJTKrp4RDFr5BU0Loxw9ijuFXWNRZKGCTAzOTr6/K9EWRk37P7OW?=
 =?us-ascii?Q?Dv1aAkJKytQpx63MMrMknVm55Eks/J8NKQ5aqA42r21eNNGxFMclu9vKud15?=
 =?us-ascii?Q?uQBnTdPWlD5iiObYN/d2RP+z1c+51nFsvDn6/vcBbIR6RfuSRRXCHq8YrSKq?=
 =?us-ascii?Q?FqsVzL/JOK91RTTVCWaBVR3/jlab?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OuKyX+PQgwXK+HNFHiuIwBKSRYodVhcGellAxsQpXZVZPW/tc5MQwjEzXy7h?=
 =?us-ascii?Q?QfPB776vQ//QQK0V6Q6extBjX3oJ7zNVNWp8Lr4f8Br7yrJynJhS3LNF10cq?=
 =?us-ascii?Q?Lm0q25muQ6C0DjF9D6a+aqdRfl9d1qYcexJMRIhw45VW6QTfNyXKRjFhZlJU?=
 =?us-ascii?Q?Ovo7vZhZHQiDkB4Whksun031p7ubepMyTTl8tS4RDxnxH/d3ja91nG9NWfue?=
 =?us-ascii?Q?WM/XAhgq9+u0E1RMGZ9KPZI/Iija3G+4E7qX1Wd+rDE9q2RxJE+WEEJDYeHW?=
 =?us-ascii?Q?WGe/MfYBDkhPaVj/KakU8qev/UlCNinRqc+ipkRiruziVEjsa/4CSNVY6bKY?=
 =?us-ascii?Q?XpJ5Lx2yUTPpgVe+u3XyqsQ+biPzIPspXx+jtlI3opnFdpuFayA/XO4eodTz?=
 =?us-ascii?Q?Fwvs1l/qguk5HFi82ycz3Y09Tnm1ehlWDeulTQoSnh4I4TO/LpDpifvzbe++?=
 =?us-ascii?Q?2UpL7X4dfUjgax352GPAuInkhXM63f73jyKpzJjeRvxMJ1mzY94LerW7m4Yh?=
 =?us-ascii?Q?4NG4plcZijhyt5XkaUpBZ6Hn9yOtGRDnTN8yMJPHgzyC46ce0oCXSOvmeC80?=
 =?us-ascii?Q?wH8FD0XMkKxgDMVrlSeivhA85Rp3K9+/+UQw2AdB3vrJQWcgX7TOgYkWsV2G?=
 =?us-ascii?Q?1ZROXHwtp5gt8ri47k4YTRAZU8XQaBrIEHrZqhZD8EaGy59kN5/9zuCfc/kE?=
 =?us-ascii?Q?YHlDbQ3fwheMCaZh8V3FUZu3iX3Ml52aJvWLP3xjnacTf7qsq6TM0w/QD/EW?=
 =?us-ascii?Q?kpmqLQ+sAFct4jpPxk1U6Kae6soVosveRFh7ioRF30SGp1D6v4hqLw6iOSuo?=
 =?us-ascii?Q?nYB6uah/xcm2k38OalH9sEMHVLey5HxVXj1pgUdugqPuQuSRHgryQc4IcMxy?=
 =?us-ascii?Q?ZNk9N+nKeOy3/rdAg/Pr40tztOenIkMd5uH1PtpLPtXKr8Y/m6xVFhmYr+8r?=
 =?us-ascii?Q?yEAuX56/0A/Z1dYx57K/QdTYzTvvjzXNeW6CdVKJLIWIMuLTHljiSK0+N/ke?=
 =?us-ascii?Q?R4zZXpdJAJo4Jg/WxcXdggNYW4qnWC1/VPX8M/9ImT/U7iVtUmgHttAxbE6K?=
 =?us-ascii?Q?joRk6ZOSJy4u7Kn/4T+Gj+BJON1SRA5wKhN0vneuyjIu8evSJhwMPpQhvyjn?=
 =?us-ascii?Q?ATcVOLHR9iTDMY+sfn9DNIpYaHZLhKEzF12/8HgRE1/rBAzZ3CjcXVvzXJQm?=
 =?us-ascii?Q?sJFnTZXRGIkcI0D26QeIKtmaSjz/BjKXesJse3WnWw7SD7I6Dcy5zkzkxaPY?=
 =?us-ascii?Q?4XuU6x9cWLzwK7RhjwqEneoxDVL8Kvoq/Ixdm/Ka67oC7k2THpinFd/bKFlb?=
 =?us-ascii?Q?Jcsl6pMPQ+9We/QTVmrXEna3ifN29wTFT156DLLPyqXWuxSqMSaioLkwYuEF?=
 =?us-ascii?Q?J76cy6D8LlMs61SM7f+JIyhvAzrxY8tgX9YLnZ1ZWpyVIEy1H4i5IVV6G3Qz?=
 =?us-ascii?Q?1IvmdUbralFuluJztn2rVXZUT2G3XV0U+DIHosjU8kJrYO4vH+BAIcPvgv9Z?=
 =?us-ascii?Q?Z4eOWJyJvyxveHUL0SVNllx/ixjt5JoIm2lh34JWZ/LkDc/YLKiCELyow9R7?=
 =?us-ascii?Q?b+7oetF4SPSTe23JHwlAWQ6lCI6g+s6dKsdGoWg2d4n9iBtNG1fD6maMFgfE?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99477e08-4405-4055-5ab9-08dcb651dbf8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 19:56:28.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iVf0ei8OmFvs/Lo/+R+wawqQJcS+37wjcpibgiYHzxc8oTqqFf5HlLiYWibFVh2GOv5jFnNboRJWZptxSlxWG6wAzynvCk8EWQv8FqnFapw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8413
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Currently, extlog_print() (ELOG) only reports CPER PCIe section (UEFI
> v2.10, Appendix N.2.7) to the kernel log via print_extlog_rcd().

I think the critical detail is is that print_extlog_rcd() is only
triggered when ras_userspace_consumers() returns true. The observation
is that ras_userspace_consumers() hides information from the trace path
when the intended purpose of it was to hide duplicate emissions to the
kernel log when userspace is watching the tracepoints.

Setting aside whether ras_userspace_consumers() is still a good idea or
not, it is obvious that this patch as is may surprise environments that
start seeing kernel error logs where the kernel was silent before.

I think the path of least surprise would be to make sure that
pci_print_aer() optionally skips emitting to the kernel log when not
needed wanted.

So perhaps first do a lead-in patch to optionally quiet the print
messages in pci_print_aer() and then pass in KERN_DEBUG from the
extlog_print() path. Then we can decide later what to do about
ras_userspace_consumers().


> the similar ghes_do_proc() (GHES) prints to kernel log and calls
> pci_print_aer() to report via the ftrace infrastructure.
> 
> Add support to report the CPER PCIe Error section also via the ftrace
> infrastructure by calling pci_print_aer() to make ELOG act consistently
> with GHES.

You might also want to explain a bit about the motivation for this which
is that I/O Machine Check Arcitecture events may signal failing PCIe
components or links. The AER event contains details on what was
happening on the wire when the error was signaled.

> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 30 ++++++++++++++++++++++++++++++
>  drivers/pci/pcie/aer.c     |  2 +-
>  include/linux/aer.h        | 13 +++++++++++--
>  3 files changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index e025ae390737..007ce96f8672 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -131,6 +131,32 @@ static int print_extlog_rcd(const char *pfx,
>  	return 1;
>  }
>  
> +static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
> +			      int severity)
> +{
> +	struct aer_capability_regs *aer;
> +	struct pci_dev *pdev;
> +	unsigned int devfn;
> +	unsigned int bus;
> +	int aer_severity;
> +	int domain;
> +
> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
> +		aer_severity = cper_severity_to_aer(severity);
> +		aer = (struct aer_capability_regs *)pcie_err->aer_info;
> +		domain = pcie_err->device_id.segment;
> +		bus = pcie_err->device_id.bus;
> +		devfn = PCI_DEVFN(pcie_err->device_id.device,
> +				  pcie_err->device_id.function);
> +		pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
> +		if (!pdev)
> +			return;
> +		pci_print_aer(pdev, aer_severity, aer);

...per above this would become:

    pci_print_aer(KERN_DEBUG, pdev, aer_severity, aer);

[..]

Rest of the changes look good to me.

