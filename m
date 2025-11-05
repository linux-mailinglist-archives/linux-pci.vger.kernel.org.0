Return-Path: <linux-pci+bounces-40348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45CC36157
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 15:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237711A21A01
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83432D0E7;
	Wed,  5 Nov 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tody+5MU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F3156C40
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353297; cv=fail; b=Qynvbb0s56XG/6nKanrKzMOHQdcBFMRePpb+Uyky0pA3+jV466o45bJAPYoOrTe+rlP40trG+K/wIJfmgXq8xAPbX1W2ezBnEHVqgezvEjgtlCBbiX/0H/uyeiaX3FmTkd71/c9vWzcnCvR1ZFAigxenk6BlsKbmq0AKagoOLRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353297; c=relaxed/simple;
	bh=1vvnBI/C18QXa+3be6jgGr6opwyCp196SxCnrJ/yf4A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LZGKd0bbGqbHMzCMEKgwx72mGEFZ2ExP+hNIpxd2wcPzANoNaNOkKVNfDpLljKDN0ouOwujORMVcdClQnSCxW0L4V6DjutF7j4SKfi3uRYuZEI2Ql92GG9nSUbXK/o5ljeMG20CPfEqOCB3IaJJZHTYxUrQFog4iV7yvboLL9jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tody+5MU; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762353296; x=1793889296;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1vvnBI/C18QXa+3be6jgGr6opwyCp196SxCnrJ/yf4A=;
  b=Tody+5MUfvJ2lSDyaI9ngr+MJmqA/5htqQzCsFRXOD3peRm0607Xq9EU
   4PDhzHQThJ2upfgyIkl9i6Ud7pD6yZFgcDOA8IsJjuBCP6DhwH4R0moJW
   6ZMLt5Ho5vQ6/91rzxbWwaY4w9uHqMAvVYIsWEitNNFRQ/Kc5YHRc2SbF
   rIsKk1iKTZWGyQBUz0Dhz+N/69HgvRBFrUE5OvTpSrsD01iRB9a36SD6N
   F0UeXMbD0jdqv1/qu/uCOITFDWE8TGaunZOL2T6GdzkXXvsarZdvx6Op0
   ak7BceTIYIgdBhivSp9zbuaWUYYoEl0NgSLFef5P8q8bKC98EpaPLACP+
   A==;
X-CSE-ConnectionGUID: 0fxi7H1WTfSeZShky2pg8g==
X-CSE-MsgGUID: hpVikMjFS4OSrNCNnNpvVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="64499740"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64499740"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:34:09 -0800
X-CSE-ConnectionGUID: Pyr4yzLVQIaCZgYrewME7g==
X-CSE-MsgGUID: fGkm2HXWTMKw3XU3xm//jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187315250"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 06:34:08 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 06:34:07 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 06:34:07 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.40)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 06:34:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fP/DOYOJo29CYG8t8vWoqCrRdXKZLIbHm/WzNSJPYWtSQEcVZOHlWNoktYV5W7sdRd/iHS4eCtIgUdEcKb9YZRue1ocOUqHKuchKvbP8UKfHHPqeYcBrKa1WNi3WV1hN+mxvw7JwA2o1MOOwdbP4AIZPOZ9zPbi96hT6rZNE3Z5ek/Jzm0nalZE0PzOZRdnnMb7OqdZTF036Ju3fYHxTaXvhv+mgFi0veZEOxDonSjKX9mHn4/FJ8xCaS88CPRm136x6H/E6eqQ+rGpODAXhitP0F0yh6zgrpt8qFKxRsB4mU/j4xkhIIO1YWQSl6mZdwxfZzd0yZNasl7bQhmVnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxjAuuRPPpEeNEtzpn8kFvxHg9qiciqB9RlFD9+XcRA=;
 b=d5xBHQP+TSD5dqyifYjfP9419lH5f/bo2d30SVt7olu+9jFBcYJITDB39tNgDxeWHBK9j6fj8bY2PwHmP2/+2hxqgqE0GEMoqrfKJhbbJgxG3mfUk9z5XjqQ7Q9/6Q7/Ktw9HeeIKL4MmrhhxA1AnVnALaiC/1uD1xVyfC06GrIJhG5+DoMU5+DZ6chmSnsP7UWeMOF3EDSW6/lU4QC9L04TRcHbc7xMrbydvtEYAPV+dSY3ymZ+40Fz7yn9GIci40xgqfMEh90r5u6jgHxXFHF6A9xsUimHr3diwQ1dJq1Xh9FeFlJVqzSCEMesNzKAzHU5Lr+DCb6g5UBNYBiycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 14:33:55 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::22af:c9c9:3681:5201%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 14:33:54 +0000
Date: Wed, 5 Nov 2025 14:33:43 +0000
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, "Tauro, Riana" <riana.tauro@intel.com>, "Dardis, Sean C"
	<sean.c.dardis@intel.com>, Farhan Ali <alifm@linux.ibm.com>, Benjamin Block
	<bblock@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, "Du, Alek"
	<alek.du@intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver
 OHalloran" <oohall@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, qat-linux <qat-linux@intel.com>, "Jiang, Dave"
	<dave.jiang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby" <jirislaby@kernel.org>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 2/2] treewide: Drop pci_save_state() after
 pci_restore_state()
Message-ID: <aQtgRy+zSVrvkZg+@gcabiddu-mobl.ger.corp.intel.com>
References: <cover.1760274044.git.lukas@wunner.de>
 <c2b28cc4defa1b743cf1dedee23c455be98b397a.1760274044.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c2b28cc4defa1b743cf1dedee23c455be98b397a.1760274044.git.lukas@wunner.de>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU7PR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::7) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SJ0PR11MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 152f2341-a183-440d-566e-08de1c7857c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A0KyJzm6larUET+oL9fFu5jdwCU9kU/Ws2Q11HZSvb361k4Gs2skpgVroADw?=
 =?us-ascii?Q?f9aPvVAWyBIXf2ZraqXkdr24247oCgM1iMy91t/j/n9X+N+daHG4+oKQH1LZ?=
 =?us-ascii?Q?RyikMXM4P3JK+dUgdRecf01V234Cuh+us7Kic+iT5lT4zajT0cdyE6SJjmyf?=
 =?us-ascii?Q?ejJsktPfne9Be62y/vt2/8wFn+/lau0FOgL7/gfLA3CrbKsmWEQGdTlhBo5F?=
 =?us-ascii?Q?ZDhtLsGZNHbDD82BDOz6AMDvQltsoa30YQCXx6X0IdCq6YAKWW6+Rh8oAT3J?=
 =?us-ascii?Q?UtRWqBm/5U9j2RoGoDrzpoBlhn3MTljtB8URCGvsBKseSaae9RVgwF7B+qXE?=
 =?us-ascii?Q?TZPu7f4Dqn4Cctp19308dIh8Z4teh97vnTV/1rFP7sYg2gcsFM1Hu9S/C5z1?=
 =?us-ascii?Q?10dpKHC3n+tFQVM7PJoKoLtXNZmMUHZW+Zb27e1j5p1v34xTg/1fjP4v8TbG?=
 =?us-ascii?Q?TQhSm5d9K/hakcPIIKlqMfJzYN9UTh9oIreAFiw1j25AD9JBwRb4n/+eMSlr?=
 =?us-ascii?Q?cgKozIfEMpjupdiTgrAd13HVHKkLaKiMZo2qeNQbkesXRax1jP3Oo+N8crco?=
 =?us-ascii?Q?K+z/SOZfnc8yPX9NqJIgOV36V7qPwUyNTI3CaEBWMyKQ025TGpuoFQwMb7L3?=
 =?us-ascii?Q?W8XOgiFaVPug8CUbr0k1s8D3Ax88kH3XNt4ilJIJt+sHPUdnvSEDN3p3yTTC?=
 =?us-ascii?Q?oK/ahfNNanYkYRnnSlqxDNw4Ag0hyz+UKZjBInSKjk0eie0PtM0AQ1vNMjdI?=
 =?us-ascii?Q?ELI/jWtGmUhy2YrWQMsL89jVowBmZoCu+C/KHPfBwqahLgbSdxMUxsspWceO?=
 =?us-ascii?Q?hyOH3G8lOh9E9U4pkzqxFYveJntouKgxHMEhSQ1iSM7kwLSAz0/LFrmlvH+k?=
 =?us-ascii?Q?MXQgEtJOQXS3ovxD0l1yuYJrwLnGvkcFUiDB60GGza+KHLYp8ZvApDK1Z4sj?=
 =?us-ascii?Q?SD5Tv7WAtQKindPuUlVF5vMrKra794FTszoX0kp9rORzVm++q4scQMfvy8ld?=
 =?us-ascii?Q?OPmTLeYMgLw3RnPNBtiRTrig5nDccGEbp73ambYP78jFXmrqDM+v6WVDqfso?=
 =?us-ascii?Q?nizCEYttbCcPBVvH8IRWBtnpLdzTKf7b4SUsIOlJ+nIzDutwhK7qGHL7nEXN?=
 =?us-ascii?Q?FV7PClonUhfDHVPr1uANNY3WZnLv1Q04inyYsnA5iw8RpxFuxIvFZTuSjE1B?=
 =?us-ascii?Q?035RXWnmPd5bVLESn2F8BQMam4DXt0TLwF4JB6sB48RiQyN7TsmE53A2cM97?=
 =?us-ascii?Q?u/anH4lV4Koqa9DCqKiIMVvsVXfjmC5W9WAFIRTMm+IAeCYcdX15XUfm5Wfo?=
 =?us-ascii?Q?TmTGqb775qtzIZDlCRoiiC63FODV49VpsF+Mk5sEtt0zxQvwQEkuUZftbJCN?=
 =?us-ascii?Q?yxEuHWQjU23cofdq+xMBzr46vRI9au3AoCFNYyz7Rqkr6yIZcTbK7bKSHjXG?=
 =?us-ascii?Q?CcF0Zll6y8aZMyb1/8EVifrpgXrSNlxw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qqXb2eYNY4HuPn5swkaKBzdnrsazp6nGAVx+5vnh49gsm/6saXCDWxc5XU+J?=
 =?us-ascii?Q?ZqrfWwbq+g6bbGAmnnw9ScBEicLaad0G6g6xdMPOoBIMF6/q7tKfdeenFuGz?=
 =?us-ascii?Q?E59YlnsxpOh1f4HfJd0ivxZTX0xQ/kILyI5EpCea4L9xHmcCO1wGKbOxOWlo?=
 =?us-ascii?Q?NAGuFGeQTVPTZrQsQYgJ7ayCFjqDQmc+3ZlaTubH/HL6nXBdCS9hWDxr9hSv?=
 =?us-ascii?Q?zBwbxN9hPrR7HcIUtzvR0S4ia+WL46b8PDzS0ZbybW2r0BQEPNFifuQEeXZm?=
 =?us-ascii?Q?6cv5/fwGwo9SwKqXsyhrMmYZVBtaRKcd9ZxIpvUXQkN5BofRKizL/adzkKP3?=
 =?us-ascii?Q?xyG4XOMEYXXm68f6I1aBILPoR5/ip4PPvbIWYoewgCrcUbjLPvufrMD9PwfK?=
 =?us-ascii?Q?2NkfX7BwZN67tpNsl1xluYbB0mhL5eAOcg7Or/TkyUf9DMqcVj/Fd11ofYXm?=
 =?us-ascii?Q?PXDQR3pU8qdZqwsqKbydm4LmY8UHWaZ0GvCBBZ7YZY8el0O+c1oWnSAcTVdf?=
 =?us-ascii?Q?RPzBktoYWZDXFEQLLwQBuOTefypJNrB+UdLx+B2NFqNp6wv4H3JMOSD6hc/s?=
 =?us-ascii?Q?kYlh4/0b9cwMgZwCYO0kJg69X4Emuso0MXdsCjhi/Nl5wQM4rD7SPixgoDeQ?=
 =?us-ascii?Q?Oem+6Ng8A3zL+MnFE2urZFId7L/MGMhaV/prv83DcnpwIGYjBpWB0G11ZUBB?=
 =?us-ascii?Q?G7LNRO2PRFAD+BX51ICaik7NtgfLa4s3v6ewFPep59+ezcpp6dePtQDVGChu?=
 =?us-ascii?Q?q+KkIh1xfiLbrWZVkVTNiClWwtayEqtaf5PUYAfs73uuiGXQSYj7z9DS/QF1?=
 =?us-ascii?Q?8FsqJijZsLUqEE30C70e6kqwzNUWwvo8+r5eNyjU//XK4FtBSQvxqvnfvvr/?=
 =?us-ascii?Q?Rh5omxDyxF/+bhxLbeY6YSFgMWSbiT30wetN7UUgFfVRr4RbA61Eldbft3O1?=
 =?us-ascii?Q?0mBCh0nADS/pd/Va/scMFdN9G7tccqjJFoi6sNmZUAEOLqRpu6ZnnNYSEm+m?=
 =?us-ascii?Q?tBpdFVlh+JT1wgNjLcJmno1UMbvF86kLWLkef9w7KfTvorZWQ4x1gu+MSD3a?=
 =?us-ascii?Q?fpxveZOM6hpRJiZCM+KKDxguRCXnWKp2EBdPh3p3bPhUXzzNexC8sW38sG76?=
 =?us-ascii?Q?HodeXe7lgI3NNZrxdgOAm3/qtc87N0ldMiHs7YKRS0EXx9QPs16kt3MZsZ0h?=
 =?us-ascii?Q?gq63OPjQANJ28jDcUsPI7cpbcdyGYGYcoiZbtRqWIK7ne/sZGSawe9kX4l+f?=
 =?us-ascii?Q?JB0KYHDIR8XyAag4DMJKnpjncarlXfGoppa3foyWM7JE9tlio4jQLF4w0hwO?=
 =?us-ascii?Q?9JYx8UM+m4QQkc/vAOQXlt6+jJN9njYI8W5lQvFGyoiE0YjZ5w52+IcWugUw?=
 =?us-ascii?Q?hLsOWi/G/pap0Ajfrr9CE9e3bs53sp2QfR6xHef0YpNSoK8nJBSm4ovM/0Dz?=
 =?us-ascii?Q?OaUIA6fTw1ffZQxl6JoTC7DkTBlEEm9VV82KmfSYXV/5usvdSVVxBQr38qqk?=
 =?us-ascii?Q?/MS0PrQyAjU6KAnSLJUX041ZswFdVrBhVPnZxa4a9gmw0jq2lNqdBwSa+HeJ?=
 =?us-ascii?Q?sKZF7/aSpBCd1qfnrTJHqhw2MlVVMMwMJx6KHM3d8dPOvq8qRjIL9Bs42uSR?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 152f2341-a183-440d-566e-08de1c7857c3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 14:33:54.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjRxWf2D8yQw81/27AIUmPGbiQu4E7gab0g1Rn5kJclKqlJf8urgMmTMtVzVmfTOYmfH/Ab7S5F7oMidMZgHgvf3khadtr7/sBvXoUGg73k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
X-OriginatorOrg: intel.com

On Sun, Oct 12, 2025 at 02:25:02PM +0100, Lukas Wunner wrote:
> In 2009, commit c82f63e411f1 ("PCI: check saved state before restore")
> changed the behavior of pci_restore_state() such that it became necessary
> to call pci_save_state() afterwards, lest recovery from subsequent PCI
> errors fails.
> 
> The commit has just been reverted and so all the pci_save_state() after
> pci_restore_state() calls that have accumulated in the tree are now
> superfluous.  Drop them.
> 
> Two drivers chose a different approach to achieve the same result:
> drivers/scsi/ipr.c and drivers/net/ethernet/intel/e1000e/netdev.c set the
> pci_dev's "state_saved" flag to true before calling pci_restore_state().
> Drop this as well.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

For the changes in the QAT driver:
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com> [qat]

Regards,

-- 
Giovanni

