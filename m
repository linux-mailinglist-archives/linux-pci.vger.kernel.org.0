Return-Path: <linux-pci+bounces-22264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B4A42DCD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB97A6D24
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51724169A;
	Mon, 24 Feb 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFRWbI47"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525A323A98E
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428994; cv=fail; b=mXnutUvS555BxuQrGUvHRtN9NcDxcf8HsiploASJyXlkn9B8GSOUq8LbrbjUjP1kObc24lEXMujAm2X8BtCtoAoYRCZ6JJpCjJ3ivPVgy+wF0NUbm0hpIA2vDVzgKYg7NlZPbTIgRdtwyz/6oYC7YDpKcCTDxQ5JIWtwjXKdOMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428994; c=relaxed/simple;
	bh=rN7OkIUs2eZII/HyGomV68rGeaFLAIaJ1gKURUHjgFo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=omWEQ+QUD0XaqwzYRzSrMq+AWNmJemnWS6FKIz4HeS2v2gJ+QQW3+bP50nL87Hh/UL255ykFg8Lua4+fq0PG1EUiQfR1BGLFgf6or0mWfckfcOW0gGnWiWxvh1qaJqFn4WOPHlgeicPDuYGcDtxTA1wZJgBpTn9HbU2Qfpv8b0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFRWbI47; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740428992; x=1771964992;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rN7OkIUs2eZII/HyGomV68rGeaFLAIaJ1gKURUHjgFo=;
  b=MFRWbI47RRyYiWsoynZ6VUESyfLFiShi5l7SlRTjhh6HJ1W/xajjhafE
   Ach8CUulddmEkoPouC6Vkc1se26nYoVR67DXa1nDstFDzeZVBz+CohfMs
   SCT3Rq37MpJEdG+ZVRRUf6dsiaaaeevP2GWnPYDYN7nDutzLd+hTdLyMu
   bTGW1GNgDrMheaYWhsLAVqU3VAK1CAdCXKLxa3JQH3BT3mBS90U2mAooY
   gRwLQn3jfzU9dJ0tSPC47HlCDfGW3tqdMfNX+a1X5j45aB3JmtDdMuC/Y
   NFLDhNrRE4gpOxnK3V+bB8R/IvIrRYe6IQvVUAThG0mjaYENRJH/+9XyR
   A==;
X-CSE-ConnectionGUID: PdH6uCrlQt+UYDMO9EzeWQ==
X-CSE-MsgGUID: PdgWA9pkS865RgTFTlAdVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40911837"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40911837"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 12:29:51 -0800
X-CSE-ConnectionGUID: WQgVAF1YRQKiHw4NuTLRZw==
X-CSE-MsgGUID: X1N+0n3tQRyfj1QZ2gCOXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153374443"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 12:29:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 12:29:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 12:29:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 12:29:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW4stnrn5COTbb8ftx9LvMFKZ8o+rVtf4dcU4a/jAAZu+N8BxzMo+t+5y0fUpUWhtQQHiB1tUMrLmMqaxKmYN109xOPyHxXXh0VoD06G+s3ba1alYd3yYHr85Ak0dDK+eaDVyr2y2oa5hdmXLw8gWBZeV4dH1Z6hCRhEhGJzV/kLMn4huBPCLrL7AX0P7MdOZ4r4Vs+IQXoUo5Wlf4M8ozTut+dj4xIyaYJOPis7ZItusmQ4UrQdR+oY+jImeDc9hZ38/mRVaKsiGjOzbatdxyXV4LIXs9bGjxdk95D4f8xC5iz5F9we4lfR15Yt0y+RAT/TIhxUDAikki9IuENgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwOFWBeI/tugKiIj1THL46C4+JBp1uQ7Zv6F/tCnjNM=;
 b=M/CLe8CwxJ1B/v4LmvZKTG2c9kbJjx+FUxujvA55U6GheGZ6pYmMKuT5KHQGnQPIk7yjs9FrEbhiP1qAy5V+xLBVyJVuEiq7MSr5p72zJaVv90vB3oVPqIwA14AUB+9GNt4tJjg+4vw9a8EwzZJDc7sZQ8Gv2OnZtUITX8LT6CMhNT2SkzagZ5sLAq0vtUJY/maAlG1WrDMaI7MZAxBUpNDziX56skhLSfXZZp9Wy9qTBYjWKvqExUqsGGSvu/XOFZ3yUwU+47y3kSYAeFXOOoVQnUJqPE3PWR0V/xnYsN+HWUCxv4h7fa753VQ61YsW1Y25FIkl8fmY8WAy7wY8uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 20:29:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:29:02 +0000
Date: Mon, 24 Feb 2025 12:28:59 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67bcd68bae71f_1c530f294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
 <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d50f215-93c4-49a5-9ee2-f9775b740f92@amd.com>
X-ClientProxiedBy: MW3PR06CA0006.namprd06.prod.outlook.com
 (2603:10b6:303:2a::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb7ddc8-aada-4705-271a-08dd5511e022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?f9rAscZ8//wfO7x/WnEhWY4m43MPWttTSyzxdGsg5ZEJhfHz08fgGUwS9c?=
 =?iso-8859-1?Q?7/gThpkmrGhMx0UM0KbGD1Z26Ky1HNe7LQ6ETNJxgL7dXzO0For07TOrFC?=
 =?iso-8859-1?Q?o0DxcieR/pZHHXCHnCfqKiFAmZywMJTs+C9LBOZOqzM4J6OLwcj3pfTQGK?=
 =?iso-8859-1?Q?VtkUNC1z3RH3hajd+Z8+86fdSSAGFseF3h34fvZ32S6QOqq6VB0m0mRCzZ?=
 =?iso-8859-1?Q?eNOuDbfPADST5/045o7lC1dH8AhzTqPGspD/8KB+o5OJjywKMykd1ryObz?=
 =?iso-8859-1?Q?XBKJRN6UDOU/bSIbc3lB5tWofdM+E10muPod+uqu89YxCKz9aGTOnqISZQ?=
 =?iso-8859-1?Q?zZQ7FA0X7t9BdFtniFgnYwrG6pzC4WKmF47Cu5IZ1fgl+6tsAJa4pJsJG3?=
 =?iso-8859-1?Q?3qjMN76FW2NANe4mYyQt9ElkN4f3HPg1/BiP746Z95Lt2+Jx99R1iWIB1R?=
 =?iso-8859-1?Q?2g/6wlOHThcU6t1U7vMcd2he0GYcW5adauOhBilFqyo95hnQN0G8vo5mvF?=
 =?iso-8859-1?Q?z/FC9HMxjAALhsBVCoqPk0lEl3809Hte3GbZkfB3zwsoZuG3LD77JynpQf?=
 =?iso-8859-1?Q?HtD8eX/yqIOqDaRwLwA5Us8WCGXDNTdSbJfHmvgcEc8veT28TAPDmLCGWN?=
 =?iso-8859-1?Q?c+jIq3aWi2UWxnEmH4hC7VEtIyo0BkdycGU+qFMrEEws2+jZ5nrxfSdrm8?=
 =?iso-8859-1?Q?zuhOjjMOjztSXPKR+wVC+wAiSubaL9dBQFGfasttnYQfPkYVz55fVk/72G?=
 =?iso-8859-1?Q?rHvOqfngqUBRGYZbBDmERI6LMawpWTPpNsZYmA0Foa9uBW/N7By4mpplwn?=
 =?iso-8859-1?Q?5oUfplEhnJVkPgTNHTk+oPo9+LrsRdV3XMlFLEdzISDYzIda12nA1OCI8x?=
 =?iso-8859-1?Q?e51Hr+Fig0QKGfx3EOmQdOWcxGrqgkKiTIKiBxJ+Dl8og+BB1WQajE/x8a?=
 =?iso-8859-1?Q?26fYa8v2oT+vO8fllM9bTRyMMM7KHOGEZYl9s9ODHqHz0lIF08vJzVXq/6?=
 =?iso-8859-1?Q?xCuYpHoCeiemRh+fWsxJZ8IQrx6PZY+Alu6BJF/WewPJQIejr+QFsQ/zxC?=
 =?iso-8859-1?Q?Tgh/BoW9axkvDnhxUZXPil/fXy9cZQzl6uBI3KKNEOh4UZKuezNjcTnNuJ?=
 =?iso-8859-1?Q?9c+4Vg2bbjN4o4V7oHAUjPowRZ0Wanqu55ypZOozBGZg7Q0Q5Iv0L2bvZo?=
 =?iso-8859-1?Q?nonj24RAAq+qD3gbQOGTeO5AfTnVF35aaOBAQLimYhr/wm3jjxz30KtvJd?=
 =?iso-8859-1?Q?LDdBOllLUTxhEzGt67AsX+LtCsii4oSgS6U63mikbi9ihPzgu9F8R46xKw?=
 =?iso-8859-1?Q?36AuslvXJjRlDu4jEsuBLTkZHe+RFi8I2wMMwto5/TKtuYy5WnE3SVlsLm?=
 =?iso-8859-1?Q?Z2hWVz54irJ1i9ANOmrMjISHShTLiZqyvbksO8zH9EJqA/y7NMonvyxdoQ?=
 =?iso-8859-1?Q?qAzJSxbuth8Bb2X+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8CHqDROxa1LqF2LVTnyjdOdoue/z0oROTHhEYTI7U9CLRqB+qQ5jJJBbBf?=
 =?iso-8859-1?Q?YIc4NXkoQW2X8Q4/CIXPWYSvpS9NI7f351y5/tJBvnlYTl9jxGwJvjTEow?=
 =?iso-8859-1?Q?2DvrHhlGrSNl8AGDOG0bUca87CAVD7+iAhwr51CPxVvj9H6/3HpXdybXaS?=
 =?iso-8859-1?Q?yFZXH8RcOlcAfgS54uN58eC1qLfqNksyAtMkngP93hJg8goGRRouG6uzhy?=
 =?iso-8859-1?Q?vbY53MULQn+kPrByYq86j0N+XIikNZRod6D4dgBujtieVyvGA7uuJOn1Ac?=
 =?iso-8859-1?Q?AcJHwZh+Ca+fgk4TxQQtblsYKmFZHqHMCcR9WShN5ChWlTAML0iIIjkCnG?=
 =?iso-8859-1?Q?vKbkT2T0k0qGLdFqGLSxo2P2ttTBUDmlcu04bV6e7Y70lVxh57dQ9tO1XU?=
 =?iso-8859-1?Q?gwPk7AOvgyjsyKuP3FRWD7mXLDQC+Pz9QDYoycoybymiHvYxvM2bRTcJv4?=
 =?iso-8859-1?Q?8+py+2zlKD6XMeAOASmWWl4m4qOpp/Ljc9zYaiA0onN3vbzvhbFinNQ7bx?=
 =?iso-8859-1?Q?3/BVDWDxwjkmmU8Kfb5tmDUmkXccL+TZtMwROfBk/4b8e8cta/h0gTlMKv?=
 =?iso-8859-1?Q?Y4VXWjvtUiseZRJA0xOQXb12dff6ZysAZNaeX4Bb8xojm/+MJniX/qJ7iB?=
 =?iso-8859-1?Q?ZfBj/O+xvodbIgECUppp9tc2ovxAbFJDiqF0AnLebfcUgq+SZsvWgx9niu?=
 =?iso-8859-1?Q?R/UOO+0zazPVHipjua5jYznKe03U3wHpCVHyZgtrlovqW2wwatQw86gt20?=
 =?iso-8859-1?Q?feaDsXDPerucLktNzMQLRteaiuqj2ZW4Sycpe66rcyTM5DY8FmPnpwWCD7?=
 =?iso-8859-1?Q?Air2w1AQWhby516mlunZlLQY274mPDXa1CyBacjZqF4Bp9H2yltfll7O8h?=
 =?iso-8859-1?Q?X5bCcRfp6+wcGCqrPM1YFXpI0+lyEO8yf9s0LNp+GBkvrN2VQ0QLSCwTTE?=
 =?iso-8859-1?Q?zyXTOmgEsgBPg08yHR5iY/PIbZOZXRTEJhpT7B4N64iR8U89v/X9cQcPi+?=
 =?iso-8859-1?Q?NCjAakiqLWM2eCnfZLERMJvpRw7TLtIRGCd0r56jPSuxQNAYCzCIJQyZmC?=
 =?iso-8859-1?Q?C4u8eSxkEVgLsWTT3DgIgt7oP4JuqA01hsV1LQU8bTXL/BwULnKEQN2AHc?=
 =?iso-8859-1?Q?qtlR2xXbeHw8gqPDO0UUJEUHGKmnNC2BJPrHtr3SqNAJQOVT+jR5D6L3pI?=
 =?iso-8859-1?Q?n4cpiZNHHaOY4TTpmliz9MPF9QsBFnQNqclcZgQqZlUzEHkAPAdssYp5/H?=
 =?iso-8859-1?Q?T9TgkW23I/6vT2q1Q+IHKIJK8UwEeCixjgYaPLXvQGvfC4/hr+B6D5kkRm?=
 =?iso-8859-1?Q?/oAk6dd7N03i18GScZiSNCnm3vhMko51xetCTR2Tt1nTsTJQOuJZiTkf9c?=
 =?iso-8859-1?Q?2pm9w9V8G9wwHVZz3WMhOwLN8DCHxbEXa9Gz0C0sa0TuMJJJCEwJ9W9YUg?=
 =?iso-8859-1?Q?4AXSVQZD2B7uqti+0vkd0mR2iNzb4dDqKzGjZdMQqaiOTt6nw8Yz7zwdK4?=
 =?iso-8859-1?Q?u6bg9TJf/yZ/qmqNgZ4kJ/tHo3T48cBz/iatHWajLhrRmwKVFuhI8bhqER?=
 =?iso-8859-1?Q?RB30DAmBKM0PZuXJou7jFQ6uVL58st4PZ6r3enlNaoaqHRgY/OKheXMqiq?=
 =?iso-8859-1?Q?wqgSN/Ge8vjuiXhn4DEf2+hl9WMzcY+qKtzdYGbAPSE7R5DKAxUjlZAQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb7ddc8-aada-4705-271a-08dd5511e022
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:29:02.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +703Dzel5gjjifuxmcGk5W0mUmpwDbN2ekzCoHMNUrI2s8T/kG/Tth7MgnwdfGA3IUE1O2ATnnXME3Nui6vi8/eGzugvmRahc997CvCklJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 19/12/24 18:25, Alexey Kardashevskiy wrote:
> > 
> > 
> > On 6/12/24 09:24, Dan Williams wrote:
> >> There are two components to establishing an encrypted link, provisioning
> >> the stream in config-space, and programming the keys into the link layer
> >> via the IDE_KM (key management) protocol. These helpers enable the
> >> former, and are in support of TSM coordinated IDE_KM. When / if native
> >> IDE establishment arrives it will share this same config-space
> >> provisioning flow, but for now IDE_KM, in any form, is saved for a
> >> follow-on change.
> >>
> >> With the TSM implementations of SEV-TIO and TDX Connect in mind this
> >> abstracts small differences in those implementations. For example, TDX
> >> Connect handles Root Port registers updates while SEV-TIO expects System
> >> Software to update the Root Port registers. This is the rationale for
> >> the PCI_IDE_SETUP_ROOT_PORT flag.
> >>
> >> The other design detail for TSM-coordinated IDE establishment is that
> >> the TSM manages allocation of stream-ids, this is why the stream_id is
> >> passed in to pci_ide_stream_setup().
> >>
> >> The flow is:
> >>
> >> pci_ide_stream_probe()
> >>    Gather stream settings (devid and address filters)
> >> pci_ide_stream_setup()
> >>    Program the stream settings into the endpoint, and optionally Root 
> >> Port)
> >> pci_ide_enable_stream()
> >>    Run the stream after IDE_KM
> >>
> >> In support of system administrators auditing where platform IDE stream
> >> resources are being spent, the allocated stream is reflected as a
> >> symlink from the host-bridge to the endpoint.
> >>
> >> Thanks to Wu Hao for a draft implementation of this infrastructure.
> >>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Lukas Wunner <lukas@wunner.de>
> >> Cc: Samuel Ortiz <sameo@rivosinc.com>
> >> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> >> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> >> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> >> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >> ---
> >>   .../ABI/testing/sysfs-devices-pci-host-bridge      |   28 +++
> >>   drivers/pci/ide.c                                  |  192 
> >> ++++++++++++++++++++
> >>   drivers/pci/pci.h                                  |    4
> >>   drivers/pci/probe.c                                |    1
> >>   include/linux/pci-ide.h                            |   33 +++
> >>   include/linux/pci.h                                |    4
> >>   6 files changed, 262 insertions(+)
> >>   create mode 100644 
> >> Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> >>   create mode 100644 include/linux/pci-ide.h
> >>
[..]
> >> +    __pci_ide_stream_setup(pdev, ide);
> >> +    if (flags & PCI_IDE_SETUP_ROOT_PORT)
> >> +        __pci_ide_stream_setup(rp, ide);
> 
> Oh, when we do this, the root port gets the same devid_start/end as the 
> device which is not correct, what should be there, the rootport bdfn? 
> Need to dig that but PCI_IDE_SETUP_ROOT_PORT should detect that it is a 
> root port. Thanks,

Why would the values be different? The Stream is associated with a set
of RIDs, I expect the PF and the Root Port to agree on that set?

Regardless, the PCI_IDE_SETUP_ROOT_PORT concept is dead so this could
support distinct settings per Root Port vs endpoint, but I am missing
where / why those would diverge.

