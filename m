Return-Path: <linux-pci+bounces-23153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE9CA573FC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 22:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60581899E27
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AF21FBEBD;
	Fri,  7 Mar 2025 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvEw3cBI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5B1A23B0;
	Fri,  7 Mar 2025 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384212; cv=fail; b=b1k3opDwhnJ6SgjT98ND72piO7MrqHXhkbf6Ua9WrrgEZmBNinzXVZ69DpaBJeECA8Y6592uA8HTP55PNt3F1CKdlXmcCp8y3Wx+wnDytZmPKNixv8iiAqrCQEnQHXdPg1q1oDYzyJMDfL11YWERw/MgabAtSKWVy1SBdYMLT9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384212; c=relaxed/simple;
	bh=dT1H/jyryhZOcS3c9sn7mQR0HVGf19qr0X78aXZogTw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QSPSfOBdJebEvILdGzylk4ZCV57oYY3IRbO9aa5TvvlIY3DFlI/YFywn15Gl3P68Ls/sby5SlFKvJGTIHXKkBc9IIMxAzcHvdQHKQbo+7YUHuN0z56VX777b6eRxJpqThEFq+p4TJnHfq+YE30hSlCo72AndxzIY9sinjGL5JFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvEw3cBI; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741384211; x=1772920211;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dT1H/jyryhZOcS3c9sn7mQR0HVGf19qr0X78aXZogTw=;
  b=gvEw3cBI/ZCRnW8rC2XcC7Kbi55Fcl+aH9xw2v9MwEX51IWzuwLXwza7
   WgEsUSQxQ63AVPjeQm1OEPnqRKxiELQG1E1iFuc1mW07EkhWYNZ7ACIKx
   mgxsFkZlBYmVdY4OdxBgipuk3szdjLFs6VRM09C/fwiCIpYl8dn8rcwJ4
   +xse4saMgD3qyqc18D+rXMzCM41VItwrNDijoa/mY3XZ2G+OYPncDa1dK
   qQR38YjhPXQj4dh6Td7vwbZ0MeEos2UpwPZH1P5TVJzikt0jmRXvz7RWm
   7kSKhZSGqxNXR1sXntJuGo03aA3JL1iIhiGaBJ45nv+2kbi3FJL8ZUHE+
   g==;
X-CSE-ConnectionGUID: ISItz3rVTp28jgXPixX6og==
X-CSE-MsgGUID: dk5hPAwIStepk/qzUNnahg==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42572259"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42572259"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 13:50:10 -0800
X-CSE-ConnectionGUID: +iXnvWWQRmqavpwWSd74Tg==
X-CSE-MsgGUID: 0EtP+LTBRc2k6WwcUC1G4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119181909"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 13:50:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 13:50:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 13:50:09 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 13:50:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYDkl+MKHbTByEsyhsjV23xnNrYv3R4SsUC2rB43OJjzgR7Q0208FwudJriQ7TKl0YkV0zu+/yyIrrlhJGW3tzvvgQskbSaFiM0xMmjaX5gGzgxDWMoLMWyFWXui5E3dm/kPIqo65FV67xJbMDamdeTyhBg8iuKEj79FYKc7vJXDgOtvgk2lby/fKXuQuvvsY/Ff7ULWXl2AwemQOtJUeRs6D+L38EXCLV5JCcQHANL4PlDEnoZ3oXGQLjZ8FOi25aBML8xw2m/jRY17/k6yJoOUz87bPVVOaukPw8toPnD3pykPfTj0H9PZilUGPaVFgTUIwGJo0+6QLKv2ZzjxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg4RfszSCd5Ongyv8ctE13vjb0CSKAfBC9frC9v9CBo=;
 b=eLun0Hx+gcuW+ZTrDQxjuHbAOm/YX0wHoGhhVh6H4HJSwQJ/VFd+qyk+zZLnYhgw4uTIQ9V41QZ8ZfcJjiRmn+rR8ztGBd1FE6RIIhVdQh7UnvIpzamNnYBZvS3l8eztQO72Ge+YjmEKpKzPwFOYaBHsvJIFxQd7aLSiWWhxzZLgT/vDR6+ytg/Hioo8J+4QXDqyiCWzrGnpKuB66W/9kzCuVkOKVX6rdLjYH0ZmBga8X4lI1txCC3GUlLCduWUCnGD9kdN4Z99DtRqYWvVvm3/DTuqSe6Kf5guov33ZdCaFTHtF67s0/629jdM0NvOzn2ToUxRjwv1nD6/keD/Vug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by PH7PR11MB6748.namprd11.prod.outlook.com (2603:10b6:510:1b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 21:50:07 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 21:50:07 +0000
Date: Fri, 7 Mar 2025 16:50:02 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Anshuman Gupta <anshuman.gupta@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <badal.nilawar@intel.com>, <kam.nasim@intel.com>
Subject: Re: [RFC 2/6] drm/xe/vrsr: Detect vrsr capability
Message-ID: <Z8tqCvocaCp68XyI@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
 <20250224164849.3746751-3-anshuman.gupta@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250224164849.3746751-3-anshuman.gupta@intel.com>
X-ClientProxiedBy: MW4PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:303:16d::7) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|PH7PR11MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: c7202241-f4d2-4839-edc0-08dd5dc20667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/LE7oIEo+LraeYU+WJbQMIS0qawor5dsWRTJqbz2w0lFJokZ88mCU0fiOfgZ?=
 =?us-ascii?Q?Sd3MzRDnwlIxtCMnM2wffypUMM7QXSD7U0Znj46P5q5gZnkmP0r5+OBSbwer?=
 =?us-ascii?Q?mnLzjPjK9zECclqfKVGiAbgySZ4syVqlIRI/yVtggcIMVALuZAu2YTZiuVWF?=
 =?us-ascii?Q?N3fBBSPgnRPOY9gfOIwu69GoJI6kp2pYvGBESAUJ4c1+QZSUcfO7bYGoWdhq?=
 =?us-ascii?Q?ccctLoheRa9xyO7QfJpgiYpwWFI1kgyCcl5qi0qkLrw3Wdv/e40X3utinAft?=
 =?us-ascii?Q?ckS58QoXsg3IdVV6rTX2wjc88HdA/56ku3l391/jfgS9DHCPsmzF/lE3rK4w?=
 =?us-ascii?Q?5d8yz2xyny4lyDYPKueY7Iuae0u61lN2xqEiWUqrCJWDbVA+Br7HrGEqL6gk?=
 =?us-ascii?Q?3LMjXo6bbuk1aH54rCb3SQraI+CMZK9uc6o+iK5Cl32DDJKBvmLVdZSoZisc?=
 =?us-ascii?Q?qoOyZal1i73YErEKOUDb3oryosXXVCMdOn89HtQIsIqU5oqc65l94irfypx8?=
 =?us-ascii?Q?FW1Jk8nMhwZzCUQvmjw0wby6DweHe1RVp78Uq3mTlHLvJU+GMPjngLXUcZvT?=
 =?us-ascii?Q?HT9GhdOCMl9J0yPnyvlCCbBgvIvmqrFGQ0ZedtAKS+H/Bq5QWVBwB/Ii+eiM?=
 =?us-ascii?Q?tlfM9dcs7JtoM2rkCq/kOb+wRTYb9WDy8cssGGMlmjE3Qgnt8VMyqwBuph1V?=
 =?us-ascii?Q?TiggmvBTvpEBlp1VLCi2C4RExvBiwLlYi2TWE7dBw7UyWAC8lol1xOwM1rGp?=
 =?us-ascii?Q?mIuLpyPVIUG0lLz8JbM6PrSB1CtfQaqmtyU+YA9N6nrPy7eb1vvLZdV6gmuu?=
 =?us-ascii?Q?linJx7dSdh87wjVtoUhbVIrUCjAWIfV+eJca+1e4PMuTdAlQpZpJ/F6p4htR?=
 =?us-ascii?Q?mB/BvAVUbZk8L3VuyEnU0bRmSywbYWJ1PXyCtCot52Y37DrjnXquCEzF5C5H?=
 =?us-ascii?Q?/TLeyTt9nZQ6/IFSc5nVXaZcmO08C22ewDqCNAa6oEqUyY90/ZOIdiuY51dy?=
 =?us-ascii?Q?NA1GpovMw8jn4qjFcYn7yZj2ChomkWrZGCN4cEV7X1mX93k/c4F2OmAj8xMS?=
 =?us-ascii?Q?TOIQ3gJuyXyBzJRhiRzAZWoFmD6odIDROY9urwqB8bm8g//mpaL6frw/F6OH?=
 =?us-ascii?Q?IZcgzMLF+fvSr+VM+zteCBBYEHeJblg91h25yGHz/V/GU3uEF7bHAVO3594Q?=
 =?us-ascii?Q?bSiXz5BRr1DOTB2RhlVEdyIA0hfu8wPOziP04LvWQJZSigt/PwmR7mor3MYx?=
 =?us-ascii?Q?+uzfngPXNMBcaSMkiMMH6t18E6m0KJjHA+ujP+k+x2qeSbFX92imy2xDYqh+?=
 =?us-ascii?Q?UO7Js9wZKbAw3JNKBkM88ktj6y4LPnI5HeniUOb2HFIE8oYRcVSDa7+qJNIX?=
 =?us-ascii?Q?De0IeciCSAiHlwqyEUCprecYzTas?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M1+6ymfatvzBcC7CqjCy1n6WjoVYin8PpsYoxrnkBpHUaWO9turiOLWnQipS?=
 =?us-ascii?Q?VU8Lo+n4pNdB5NuJ81pvg4tU3Urp8+Rs9j9cNcHIk+BM+7lhpNmJojdoIUpw?=
 =?us-ascii?Q?oSn6eIDyqxvc0NHuHhnZumOji08yvYy0MZCAJtOeQ6N2QV76bULBrvxgbL8n?=
 =?us-ascii?Q?Egk1I+eROZcuNOJ1osboGo4oLkIUqAJWDc9T3J2ud3+S/LoUC1svT1QjmZPq?=
 =?us-ascii?Q?y9jw94EP4YvAkDs8X+Wfod5WnknQqP+4RpBdks3IAGMC0NZJzIa6Vwt1oY/D?=
 =?us-ascii?Q?8ECmGKcL8B9jfCCxBUuWdXcIryc9oFpszp5MfXmQxH98q4i+VWy0IE7Fghzb?=
 =?us-ascii?Q?E5eWNd+BnKmg143bZmLZAP19No9wkcQNZ8m0jjVmyqzleTXSUj98QhY2hkA1?=
 =?us-ascii?Q?PCHvYJupXBQEyGoJfnBrZqGNg866JBZ0Bt/SgwjMo6Z1AUftl4D2VJe/I6WK?=
 =?us-ascii?Q?gjGiQ+9OgZ6uJmRmz3XRe6KaS61czbVE6M9N89EL6sDaECzG9kyAr+uIsUl/?=
 =?us-ascii?Q?AU3ncZJxvw+72H1n5vuA4nYRSMsvH1Wz+K8KYc/qUA9ZHOCwZFr2rtuhgOrX?=
 =?us-ascii?Q?wprwt1TAc+zLpeb91WMW6LemEI6/x/QQCJ3g4yZ1Z99hfzZbuq1W7yG+m+db?=
 =?us-ascii?Q?5H75f9CtBdWMeNpqM7emCrlw5Q47bjZNMk7GyZI+N/xdToAhxOqrVdscBKYk?=
 =?us-ascii?Q?Sd4ZFrGGBVABxDTCuD0MY6ww+eBE6+JX7q1MQ0dJc/X8m6Q1tfOuUiTnwgh/?=
 =?us-ascii?Q?JEQI27eEcBemxLmk6BIrRx7Jnhd5W2hrMn0E/uUqEiSQlGdFyBCPmC/plapx?=
 =?us-ascii?Q?qUj4Y7DGxvUiScDPIYfgrNNosCymI7Hz1EgAP5TbGNUPsVhdGZtAKa1sYfoB?=
 =?us-ascii?Q?FKyy4rVMhmysyORqCKPYCcxmq7fjB/PIyvv4z9OyOLyO1VAWJIQtQHo2ALm2?=
 =?us-ascii?Q?AfpSn0lpbq+fPJsIAmvVwnmVC97pwF8ir9M8jvSH43eAvnlCpS9Q3sqEmROJ?=
 =?us-ascii?Q?laRkAqjd9l7llBYuwO5eEupTUyrvpyglDLbxw0Rq3wutk3nENNiboCmrSuCF?=
 =?us-ascii?Q?vnLHPIVCQKodUK0nVtA6jDj1zjl8KKz4DKRRFm8CP+YHHvXQoIGaDiRiT+fw?=
 =?us-ascii?Q?Z7wIO75ViB4KMEvNpgdVxyvQ8BZPGNo4iEcV8UMGfd2wg+UrwfQ6vJ/hByVU?=
 =?us-ascii?Q?WUjkKbGA1ErgOkPhPN0hzO/sfxq6jyARdjC76PcGgGU9D/9udKjzueG7MjzG?=
 =?us-ascii?Q?bTqyuw9dZpjC65ZRewQk25GL/H++RIpgIOFdUOyk3xQ6tohRprCS3rZjoi9B?=
 =?us-ascii?Q?QLd9E8R2yrTKn2+Oirb0yBRzqasgn+mQLGKDRBWN22RSy41lxNR8blZDHY+r?=
 =?us-ascii?Q?AGqMSWwyWl/ZEscxTEQEer3FyVdEB7AH5lXL+ShfS4REebx5m7eDMrhoth8f?=
 =?us-ascii?Q?Wr0gFEWgN9Stj4kiYFNGTt8hEQZc+3I4fH2lEY8OCcMqCeWGSQXWBGf6riNx?=
 =?us-ascii?Q?8nTHVl9aa3NApXBxi3T1K0FtwU4FtNbAiALDxDCq77KZ0vlak/sdkfx5fDub?=
 =?us-ascii?Q?2zFXmizgvF0JS5qhYJtvr6MOeoggOYYfk42opLm2VHMQ5wtgG9eHGLlf8gCc?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7202241-f4d2-4839-edc0-08dd5dc20667
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:50:07.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vinlN1o49YKNEDo7IFiSb6C1wqR2PSFflH1mW588mrB/fkN44v6khqVwazH/GgXBGf1pUmfymHVQgXMhvCOwxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6748
X-OriginatorOrg: intel.com

On Mon, Feb 24, 2025 at 10:18:45PM +0530, Anshuman Gupta wrote:
> Detect VRAM Self Refresh(vrsr) Capability.
> 
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>  drivers/gpu/drm/xe/regs/xe_regs.h    |  3 +++
>  drivers/gpu/drm/xe/xe_device_types.h |  4 ++++
>  drivers/gpu/drm/xe/xe_pm.c           | 27 +++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/regs/xe_regs.h b/drivers/gpu/drm/xe/regs/xe_regs.h
> index 6cf282618836..21563e9d958b 100644
> --- a/drivers/gpu/drm/xe/regs/xe_regs.h
> +++ b/drivers/gpu/drm/xe/regs/xe_regs.h
> @@ -57,6 +57,9 @@
>  #define MTL_MPE_FREQUENCY			XE_REG(0x13802c)
>  #define   MTL_RPE_MASK				REG_GENMASK(8, 0)
>  
> +#define VRAM_CAPABILITY                         XE_REG(0x138144)
> +#define   VRAM_SUPPORTED                        REG_BIT(0)

I'm missing a 'SR' mention here.

I know the register name is VRAM_CAPABILITY what looks horrible, but let's live with
it, but we could then use same or similar terminology from BSPec:

VRAM_SR_CAP

or VRAM_SR_CAP_SUPPORTED

or VRAM_SR_SUPPORTED at least?

with some mention to SR here:

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> +
>  #define VF_CAP_REG				XE_REG(0x1901f8, XE_REG_OPTION_VF)
>  #define   VF_CAP				REG_BIT(0)
>  
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 4656305dd45a..c2ab2c91c968 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -490,6 +490,9 @@ struct xe_device {
>  		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
>  		bool allowed;
>  
> +		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
> +		bool vrsr_capable;
> +
>  		/**
>  		 * @d3cold.vram_threshold:
>  		 *
> @@ -500,6 +503,7 @@ struct xe_device {
>  		 * Default threshold value is 300mb.
>  		 */
>  		u32 vram_threshold;
> +
>  		/** @d3cold.lock: protect vram_threshold */
>  		struct mutex lock;
>  	} d3cold;
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 12200be7b43d..dead236355d8 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -17,12 +17,15 @@
>  #include "xe_bo_evict.h"
>  #include "xe_device.h"
>  #include "xe_device_sysfs.h"
> +#include "xe_force_wake.h"
>  #include "xe_ggtt.h"
>  #include "xe_gt.h"
>  #include "xe_guc.h"
>  #include "xe_irq.h"
> +#include "xe_mmio.h"
>  #include "xe_pcode.h"
>  #include "xe_pxp.h"
> +#include "regs/xe_regs.h"
>  #include "xe_trace.h"
>  #include "xe_wa.h"
>  
> @@ -236,6 +239,28 @@ static bool xe_pm_pci_d3cold_capable(struct xe_device *xe)
>  	return true;
>  }
>  
> +static bool xe_pm_vrsr_capable(struct xe_device *xe)
> +{
> +	struct xe_mmio *mmio = xe_root_tile_mmio(xe);
> +	unsigned int fw_ref;
> +	struct xe_gt *gt;
> +	u32 val;
> +
> +	gt = xe_root_mmio_gt(xe);
> +
> +	if (!xe->info.probe_display)
> +		return false;
> +
> +	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
> +	if (!fw_ref)
> +		return false;
> +
> +	val = xe_mmio_read32(mmio, VRAM_CAPABILITY);
> +	xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
> +
> +	return val & VRAM_SUPPORTED;
> +}
> +
>  static void xe_pm_runtime_init(struct xe_device *xe)
>  {
>  	struct device *dev = xe->drm.dev;
> @@ -303,6 +328,8 @@ int xe_pm_init(struct xe_device *xe)
>  		err = xe_pm_set_vram_threshold(xe, DEFAULT_VRAM_THRESHOLD);
>  		if (err)
>  			return err;
> +
> +		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
>  	}
>  
>  	xe_pm_runtime_init(xe);
> -- 
> 2.34.1
> 

