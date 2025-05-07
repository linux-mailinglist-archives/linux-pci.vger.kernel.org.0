Return-Path: <linux-pci+bounces-27372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F42AAE1D3
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 16:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B049C395A
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64CF28C858;
	Wed,  7 May 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9VoRhhq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016F28C5CA;
	Wed,  7 May 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626016; cv=fail; b=VvfkXX1AD7ozr8A2t+75akKt9+msA7iMS2cDZP5EtH5J4d/m3CEin+f6M2K/39zm94k5Zq2tp0C0Z+ZcZJxTFln4Y1dZxHQY2MzPwcHrYkAcjPny4i2ql8s9ilp/+djFDK9vJ4lTP2yPXV8/At5fFfDX3vdwexMBN5MezKuC+ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626016; c=relaxed/simple;
	bh=xIA5H4ciSEDZSLudmltfFZLDiGytE0vNugkB3pXOmg8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WT3sO1AUatl4aLhtx/JkG+rmfIZ6qau6alPGnP3W4e+90VsgPlnch2XIz9qjwuD0CEqnTHELoW9zN2A5TTp+PbOvEnQDB50YTMs2haFdkd2jf0KivOOxRqdih5VMrtDaluQeBv023SJBdao5T2hqdWV80Gflhh+DSDbLAOSKtYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9VoRhhq; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746626014; x=1778162014;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xIA5H4ciSEDZSLudmltfFZLDiGytE0vNugkB3pXOmg8=;
  b=H9VoRhhqkjeOR9i8yjlCj/LJBHDkD48vaHJhSxpHMgsAT2QcXxzFf01k
   zuwzGhw1+nV3A/+IWOYP1gB3sNFsZvtWiTAGkWiyuYuKCa8AXRE1/npfW
   mzO4UqZOqdFGjkWHmYUEMDgluORGPY9gxjd53GGwf3inxRpQJV+e06o/W
   V7uE3/oIPAFv+1avntJUAnvLqLqGxTrJg8iGsgwEb+E2iRfI/IOuOirTk
   NeaL9JK4MFzA6eHPmwOv1LN/M0K2GFIxy7ywpfDs9sIsl7RA6kvJ2uC7G
   ixwJV5cUSMi3Xv1uiUssJzlP4uesH6cV3L2A/sqSDQDeSla3JVLAhEzg5
   A==;
X-CSE-ConnectionGUID: DIvQejPVRuy7c1T8WkCWpA==
X-CSE-MsgGUID: ZOOSoDsLST6YgKdteEX1RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="52171431"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="52171431"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:53:33 -0700
X-CSE-ConnectionGUID: 4iT2p3kXTt6Oy/TzUhY6eA==
X-CSE-MsgGUID: Xs20HPAHSD+6wBX7lZWJNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135986177"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 06:53:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 06:53:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 06:53:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 06:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHh5tK8dCIwG78h6/HS9T1CflHrz9inG6rSUjPxXazHOYE68N4teWbh01R4g7Qsa3HQn4tUW47TahIVcC0dzR69hLRgH50FHzBn7J+SU52L5X0SmL7QJrO3Z2N59vvSXN/32Xb71nlARrK/eFFtxipB6d1sUCqiy7PxHXy/fsRyA2RVRp7/os9QYRub0oIAjHFHSSv6dL/p79dG0jnwPKXhXR4OgwFR9o57+f9JBhz+Cc0rgEFRJ9YSHgFyWWGFGvuQPVTeIcs4TrxuOQ3Ue/BuD5afHvjuX+IEZgSU5Vb2hvKOw9tb94tEjfJ/80FttvOSVAhL8JFdZ1+1REI2ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fwJh9Drg2Zf1aw4mOyXhlDyNFLmiUAL6gNsxZefEpk=;
 b=rmgItdtuCleocizPnyaeh1J/A4fUfFhumDT22x2OJJmfkV6q9FNPPGjl5IdPycEim6Gl+YlKc9iu2iCrFpYjCCf4h4gxvf4SYV5061LFb/IaTXTaeorm61KGcxDo6HvBr71x0r/Bc0XI+Iwq9E+ev52zVpFwz+gQZhgXbVcfVyhLKBNXChHwYsMsZUvQBuH3t+OsL6LcMjFY1TQy+bpHBZZO/OO6spgJ7QcxTkLdGZaw1a+wgQNA+SeW3P0EJg43ExC3zUSZ1s2NWr9hWFjd4eJGmZY1jNHRstqNx03II+VSH3Gt0sIyORvBeMziIcoKphvLZoJ4PuvMW3EF2EhYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 7 May
 2025 13:53:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 13:53:27 +0000
Message-ID: <a8d9e9ca-4944-40ae-acd8-d576447742d3@intel.com>
Date: Wed, 7 May 2025 21:59:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 rc] iommu: Skip PASID validation for devices without
 PASID capability
Content-Language: en-US
To: Tushar Dave <tdave@nvidia.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <kevin.tian@intel.com>, <jgg@nvidia.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250505211524.1001511-1-tdave@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250505211524.1001511-1-tdave@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e3dff0-4896-48e3-abf5-08dd8d6e8ace
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTU3V3JwVXVHRkk2QlVML3B2UXVxYk1OR0JvQVZvbzFCd2dVZVlFWFVPbkhL?=
 =?utf-8?B?RG9YVmNxQk4xcVNEb3Z3NmlZbjV6cEJLUWVnNU9FUlFnbG5QbTZWS0xoRTVa?=
 =?utf-8?B?YmV0aDdsZ1VpQTcxb0hmbG05V1k2WXRWbURQTkdlcTVQclhTMTFmR0EzZDlG?=
 =?utf-8?B?R2FHc0NtMGE5cHRpM2VMWUo5eS9kUnVjOUUvRllOczU2OEcydFM1dW9SZGZk?=
 =?utf-8?B?TXFoTlh1am02Vk1NTmJKYzBCeXd3SFZWdzJpRlFrZ1ppQnduaGFyczcwb3pL?=
 =?utf-8?B?ZFZreUtncnFtSmxxSXF4Q3EybHFvRDRVeWJZdTROZkJwRzNkT3c5dlpFY0JQ?=
 =?utf-8?B?ZzJwSVpPbUxBUzQ2by9kRlU2YnJpMlR2Nmd5RUwxQzJPSm1vV3l5c0t5aUt5?=
 =?utf-8?B?eUhLbGNqK2NwUm1uMCtkUi80VW50cTQ2RENMRkQyWXk3U2dEdkdONVgwblE1?=
 =?utf-8?B?N2lLKzd4eVR5OTlWWXlteFVrMUova1puMllRMFFGMncvMndxN2MwSTVPMVVr?=
 =?utf-8?B?aWp0STVaZXI3bjJWRUU0RnMwYTRCRTBtTXAvcmd0VGdIQm96aC9oNDdMVFdZ?=
 =?utf-8?B?SGVSVzFtbHhrSi9kMmVvR0FTdFZnNXNzT2dFR0pGNVEzbDNHbnNqVXRiN3p5?=
 =?utf-8?B?MUs2U05PNkxlNlZDRW9mU1lmVkFGTHhQZkxkRWxqWTlEWDBDcHNRbmNobFUw?=
 =?utf-8?B?RElrU3kweUI5dU1PWTBkODFqNysrL2tQVWEzRkJHZ2pZNVovdFpndG56NVda?=
 =?utf-8?B?N2lkSmdrODVZalpINElUL2hRcDJJbjROa0k5OUxjVzZhd2FYKzFNRGRkWnlR?=
 =?utf-8?B?U0IreDRTaUhxV1hkeFNGeTZiUEhMc01ySlN4UXN0dkdaV2hsQkNNbzJZUloy?=
 =?utf-8?B?Zkh5cjQ4NEpXUjJ6VG4yUEpVU1BzaGFRWGtlZk14V0d1dWVTK0VFSE1MVjdx?=
 =?utf-8?B?ZDQ4cHRrS3l2eWhFRGtpTHdOcktWK1pqNVhSK1hzZFVyTkN6OU1MYnIwQlJ3?=
 =?utf-8?B?N3psOG9UYnlkdUVlWnQ5UFNEblRaU2JUZVZROWpDVFhWYzB6S3loTWoydFVV?=
 =?utf-8?B?akZGMklvbkhaV2daWHE4T29TeU91MGhnSzJrVVBqcHA1Nnp1b0Q5cHVaTzhI?=
 =?utf-8?B?bXBRK3BCVllFRmM0QzJ0cDA3aXRYOFZNQW9xNnFaWlIyaUlld0NYMG9rd3dt?=
 =?utf-8?B?MUhXRnAzYk5vR3B5RHNINzFaUFlFaFMrUEoxSWM3VURPcFZ2eUdaZnhwU2Ja?=
 =?utf-8?B?WGRIMktJTjM2MzdQem9ranF5VktOR0U2QXI2T29hTmR1UUx0N3ora040dml4?=
 =?utf-8?B?WDg5TlBPaEo5aGhtMDR4aVVnN3N4eFdwejVSbElMWElzMHIrdE0yRCtoSUc1?=
 =?utf-8?B?ZnhKUkZVcU04U3ZXcXA0OXlsc1hkNUIrNHFqekVYS2s5bG9YNGFJWHZheER2?=
 =?utf-8?B?YW5lTDk2T0dMVFNNOWZ4dDRtQ2pLREp0L241ak9seEhzLzkxclZSanRYV3NM?=
 =?utf-8?B?em1TQVNWeFJjcW5IbkpqNnMrT2oxUHpzUVptMFFSODNHZit1ZDRQWkp2aXpC?=
 =?utf-8?B?TWV0SUNwWDljdmxTalYzMEVXN2h6V0UvYUFnYkZjVzlRSC9aaXlyMmFoUFl5?=
 =?utf-8?B?OTdaSXVxUDE4dHFtOS84ZkJDUU84cHRvTHRDVmRoUTN3NFpjako3WWk4cVZT?=
 =?utf-8?B?S0hPQ3piKzNYL05LeXF6Sjcvem5oREZhUVBCL0dpdDNNSWVsb0tORDE5RTVX?=
 =?utf-8?B?dlpNZWtDT21HVHBXNjdKcnpWUUZ1YnE1dFZxaTMvSDdoem00V2hTM1E2d3lP?=
 =?utf-8?B?TDB1TDZRQkN3UXh6cGlkYkJBNlpDSDRIZ0RjWXI0QjNlQ1UwamNLcWZkTVVF?=
 =?utf-8?B?aExKNjJYK2RFZkFuRmYwTzNUcHpjQTBJbG5pMldQb09ma01iL3V1ZndzQlB4?=
 =?utf-8?Q?VqwlBkXzgqE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhWc2taQjVlTE9VWVZRYzZwbmVUTmFuc1l1QnIrb0s5TWE1R1JFN04rZVp3?=
 =?utf-8?B?cGdVNVYzaDFJQVhLZnRBTG9iL2IvRE1kVXBMS2VVclhXeFRiOWw5MVFhUnJW?=
 =?utf-8?B?NWcvM0FVQ3pxVE96Y1psdjBvRnlnK2IwdXFUTjlkOGgrNkdsamFDSGlNamZ4?=
 =?utf-8?B?Zy9idXVmbThvaFZ2RFRDdFJ6YUNjSW4wZFZsQ0s0a0RhL1J1ZmxtVnZiRFlV?=
 =?utf-8?B?c1hock9ML2lUY08xRHArMU1pQ2ExYW00VDFaY1VCdHVFbVpKK3Q5RU5XVWpj?=
 =?utf-8?B?cnd2WThJWEhjMkpvcFhZcFZlOWN0TDRQOTFqUTFoK3NRbkJEdksxTkFESjYr?=
 =?utf-8?B?VnRiTFpkR0wyeG5CaUtqT0NJNmJSTjRuNFZncTJIMEFrb21BdGR5eGFNendQ?=
 =?utf-8?B?aCs1RCswSnpBMjlTTXJ6Rm9uR3JLbTR4V2FBdVMyOFJrME1JU0hmNExyNUpQ?=
 =?utf-8?B?bHVLdnBFMEpjUGt2aXVLYzRVN3h3MGZ1VUZnZ2t6OEpUYmlvenYrNVhSQjcv?=
 =?utf-8?B?amVLVlhmK0NveFZIQkhyd0xyeFpBK2RyWEI5dzhZR3BBbFJldU16cmZCM1hJ?=
 =?utf-8?B?K0tnQ0lHV2NxUzBYSnJ0UmZDWFRweVRocTFxZklUYVBDck4vRklvVlBmZmIr?=
 =?utf-8?B?ZHB3WGFUM0NpYlkycVMvbWFhTFd2TkNUbmFISlgxcXJPeCtqNzRMUldIeVda?=
 =?utf-8?B?Q2NMUVlxb3BVS1FFcjczU21obUp1ck9JdEYxR25QNTNaaklUUmhoaklBejNE?=
 =?utf-8?B?OGZlWlRydGljdVFCVTUrV0RGZ1NBOUJGZnVTSzdoVVN6SEVFK3FVelZCOTRu?=
 =?utf-8?B?Umg3QWUzOWlzRHV1LzVlYzkwbXpNVkNJY002S08vbERoUnNNVXJiOEpMc2to?=
 =?utf-8?B?TW9yNFE3aWhCTTRpNXZocEpTaVNzdGk0Q2lzMFNHVHdhUVFEWEdWY21IOHpC?=
 =?utf-8?B?aEZtUldDU1d1WjBXZE1id1NMbnlaVHZRbHlTZ3d2SWVTTy9JaVRtY015amFM?=
 =?utf-8?B?K0J2S2VxSUViRDVtdHhiajkwaTJvYWU2NW1mcGQ5WmhPUWVGWnYvMy9EYzdF?=
 =?utf-8?B?OUVxZUhrUE9IUFJ0SzJhaDhNUVRnZG16eFJUY2xNaU8xN21NVTQ4Y29VVDl5?=
 =?utf-8?B?Nnc0TkVSbnR2bytlc2ZUWHhFWXljbHVyV2FQNHIxbGNCa3MwMU5Mblh0Mi9k?=
 =?utf-8?B?WEFJNGVZOFVsZDRwZktseDN5Ni9sR0IvYklDVnYydE5sMEVEeHdIcFdITHMv?=
 =?utf-8?B?SUFVZDRIQVVEM0I2M0UzaW4wcUJSSFduYzJjUDN3ODI2OXFZRTkvZmIzeTVE?=
 =?utf-8?B?WTgzTFhpU0krdkxPM1lkdjFXNlQ0QlEySE1XUjU1ZXN2TEhQMEpwRk11eTFn?=
 =?utf-8?B?SWFZbjdaRDZkYkhxUVdjOHVrU280TUlzSTBNUkhQbDMwdXdjQlpESDdnZzd2?=
 =?utf-8?B?VWFnMkdjdzVIdWkvRU4wSThBMHpsbFZZbzYrT2h0UkF3cW9OL0dvRUU0ZnNi?=
 =?utf-8?B?T055MDczYXhjU3J1N3h3TnJ5SHRrd21YS0RMSkdmT2Vya2dkcnZlMFZkSEdH?=
 =?utf-8?B?VndXeGxoQk9hNE95KzJFM01sdSt1WXhEQlMrSW81d2hLU2g2YlY2VjVTZjJv?=
 =?utf-8?B?bWtFb0c1WWExRGNpenhOTlZpS3ZlN2ZVbGJCS3hqK2ZqOXdzQXhBdEhSRytJ?=
 =?utf-8?B?T0YrUlEzRksvdTNPQ2tOZ3pFUjIvU2pmNzFwSWRoaWhRcllNUFdOeGR2ZXp4?=
 =?utf-8?B?eFd3L1Z5OGtKM1pBb3RXNmRKemJ4cEtmSFBvWkJVVDkyM0RpVi9tZVdyQnVF?=
 =?utf-8?B?SlpTRlZ1MENUZHBRWDg3QVEvT1NwNEEzT2NYUW9MdHVIRzUxWUk2Uzl4SEh2?=
 =?utf-8?B?ODZJY1BoaVVDcGo5NlV2V1NYbVZQSVdSNEhOcHdmUnNYelVGM0puZ2ppMGkr?=
 =?utf-8?B?NUlYcXVBc2hicXcxMllKcUs4K0p2YVQxZVhZUGQ3NWlTTVk0Nld6RVFBQTM1?=
 =?utf-8?B?Um0vY0FMUUd1WkQrUXlHKzRtVnFzTTVpc0RkSVQ4VzVLbVU0SVE3aG5oRTla?=
 =?utf-8?B?Qy9NYnE0RlRqcHlSRE5tYy9ueGNkWDZWeXdKdzh4ZmwxQTI5SFpQd09MNXVq?=
 =?utf-8?Q?X/oiAROwgLxEgJ5SLsln/sy4f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e3dff0-4896-48e3-abf5-08dd8d6e8ace
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 13:53:27.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhrDayP6fvGf/LYepkhgmeB0685d3Y9ataI5+oVA6OvjTmqYrvdti9PntPNLsOZzCL66q5qwkRWrWXA+XUIanQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com


On 2025/5/6 05:15, Tushar Dave wrote:
> Generally PASID support requires ACS settings that usually create
> single device groups, but there are some niche cases where we can get
> multi-device groups and still have working PASID support. The primary
> issue is that PCI switches are not required to treat PASID tagged TLPs
> specially so appropriate ACS settings are required to route all TLPs to
> the host bridge if PASID is going to work properly.
> 
> pci_enable_pasid() does check that each device that will use PASID has
> the proper ACS settings to achieve this routing.
> 
> However, no-PASID devices can be combined with PASID capable devices
> within the same topology using non-uniform ACS settings. In this case
> the no-PASID devices may not have strict route to host ACS flags and
> end up being grouped with the PASID devices.
> 
> This configuration fails to allow use of the PASID within the iommu
> core code which wrongly checks if the no-PASID device supports PASID.
> 
> Fix this by ignoring no-PASID devices during the PASID validation. They
> will never issue a PASID TLP anyhow so they can be ignored.
> 
> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
> 
> changes in v3:
> - addressed review comment from Vasant.
> 
>   drivers/iommu/iommu.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 60aed01e54f2..636fc68a8ec0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3329,10 +3329,12 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>   	int ret;
>   
>   	for_each_group_device(group, device) {
> -		ret = domain->ops->set_dev_pasid(domain, device->dev,
> -						 pasid, NULL);
> -		if (ret)
> -			goto err_revert;
> +		if (device->dev->iommu->max_pasids > 0) {
> +			ret = domain->ops->set_dev_pasid(domain, device->dev,
> +							 pasid, NULL);
> +			if (ret)
> +				goto err_revert;
> +		}
>   	}
>   
>   	return 0;
> @@ -3342,7 +3344,8 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>   	for_each_group_device(group, device) {
>   		if (device == last_gdev)
>   			break;
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +		if (device->dev->iommu->max_pasids > 0)
> +			iommu_remove_dev_pasid(device->dev, pasid, domain);

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

with a nit. would it save some loc by adding the max_pasids check in
iommu_remove_dev_pasid()?


>   	}
>   	return ret;
>   }
> @@ -3353,8 +3356,10 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>   {
>   	struct group_device *device;
>   
> -	for_each_group_device(group, device)
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +	for_each_group_device(group, device) {
> +		if (device->dev->iommu->max_pasids > 0)
> +			iommu_remove_dev_pasid(device->dev, pasid, domain);
> +	}
>   }
>   
>   /*
> @@ -3391,7 +3396,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>   
>   	mutex_lock(&group->mutex);
>   	for_each_group_device(group, device) {
> -		if (pasid >= device->dev->iommu->max_pasids) {
> +		/*
> +		 * Skip PASID validation for devices without PASID support
> +		 * (max_pasids = 0). These devices cannot issue transactions
> +		 * with PASID, so they don't affect group's PASID usage.
> +		 */
> +		if ((device->dev->iommu->max_pasids > 0) &&
> +		    (pasid >= device->dev->iommu->max_pasids)) {
>   			ret = -EINVAL;
>   			goto out_unlock;
>   		}

-- 
Regards,
Yi Liu

