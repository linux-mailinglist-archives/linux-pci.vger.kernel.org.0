Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAECB475A6A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 15:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243248AbhLOOQx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 09:16:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:25794 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243257AbhLOOQw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Dec 2021 09:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639577812; x=1671113812;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=7P08SDgAUC8vnr+ywcoDxL9jz8+qYJarvsS+T8NGUCE=;
  b=k2TVoSmVSO5hZ/Dp1ugrAz/uggnT0UiaOZz1wa4og2l8rITuNjJASRjN
   UqVIHgICAgx4h8Wnq00xogYjYX5K90B3ILwFaQFmiDof3RIlBaGprUJlg
   BrkpkYu/DGP1Dutzzw5LZV/VheD/snYV0II4Bz0jgXmx/JTOxDgNU40dg
   h+JqWRVGwcUk1tBwCCh8HnW3rdTQgbDpBPkorclq5sNZ+US7VvFBjmYgJ
   eYwBsx+La9XecrAT5Wx2b4UctrSpAN9cEcx8FUvPQYzXC6jUaQorgTD/5
   Rdo45hRbm8sw+b2UtWhLRZULNH7xxaRQXz1jj9KskO8ACJiMaqqOECzKn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="219918510"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="219918510"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 06:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="584215572"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2021 06:16:52 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 06:16:52 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 06:16:51 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 15 Dec 2021 06:16:51 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 15 Dec 2021 06:16:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGo12S5YGismt/BYi16WFCHdeL7sOweJ4U5CNcZq2ShOmqQN20a0ktg+BixTtqiGmszppYf2NvuhZ+j00JyDs+h5WeJBb3duaD/zFpcFkVwAWqZ5+qkN8mavQH2ACX76wehtcTFfjHxPDDofV++simykkqcwqLXb7BxHJK0d/jfzRyoDihPpq0zYHQGnzUX8a9c7oKcz9HPA4XR47531N4B+F6mqjYkbLm0XTihsFtqbCXtt3rT9eCPFlyhhanAf3n+8RUlsCFECoN1xwreRSdARCmKP0p5F5BtKDulE/X7fYwHoCdXuvX+FT4rG5IYudBY5ggAXydAcb0PqHB/rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxRF5GkEOw5eqN5jLZy2Lp3RlE7R9GLAzzey6XLB2qs=;
 b=jV0YZMgpWgqjhu+BTE1uI9wkBJRHn4di94fCToSAsVcTrpo+fpr/Fkp8EDyzebvDp/ydxpXQg9K2W6WHGq9uyuxsuD5YaW6BdCshGuaXuAU6q8aWn5BCNvwwWqlFQmgs1emun1U402vCX01wdq/IblqzkU6Ap7rQ5TSsD/LT4eyakbJ1YZcZ8lE2V/y9ipfdbs5SYB0AEn9e/b0nxqluuJMlu/L26gKB1cMLW8e8BLSchNSYXqMMZjAgAz/ApaLXe4ZI5jdrLwwWK1PRTYTVb/wZOw7x9FZyEz8KX8Ek0VVevD5z7mzKNPPsvH9ipdznEPgCiLzvVXw7hdqNStohqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM5PR11MB2011.namprd11.prod.outlook.com (2603:10b6:3:f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Wed, 15 Dec 2021 14:16:50 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658%4]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 14:16:49 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH 0/2] PCI: VF resizable BAR
Date:   Wed, 15 Dec 2021 15:16:24 +0100
Message-ID: <20211215141626.3090807-1-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::14) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f086514-478c-4317-d2bc-08d9bfd58904
X-MS-TrafficTypeDiagnostic: DM5PR11MB2011:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB201162066E1BBBEA87520C9698769@DM5PR11MB2011.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: km9nXyk2XKMAFtzO4fG4g+BP/ophs4ewdQsXbrQFxm6W4IJ8It32rXYFw+jkCdAa0X/+8TMoL0XdlV9jnpe016rYOOVno5SCUu/y4YmsYcio9xJuo+eMVpIUpeLB58L3xUae9bmz7GfQN0fCz06a4sD0TLU2BN7Ibe0pnxtlYxTu6rZZGG9jWpu6gGACFid9jkmPa4v7AKGCbYmLs+eM115b2y97zNFNinrahvDlEnrs2/D2KW2o2J33QVOy9Tk7z7nC41OFaqtwwcjvL8XEUiOiRkwwqDt4bzPFtsz2M89ApPOXEVDiu0Dqed7F9tyz4RzBgszV+5JHbK23nOhdHJ5RpWIFLwJMv48uKfZoyCL2WlfJXd14IIb+kkAmsSrzCo5gknasZWn2lov8UkZIkiwpych3IZMMarFU5DQsG5CWXtCwoKonZi+fiNtsVRqT5VzCy282iEfXkTYcj0n6TSf/nsDca2PmuEpdLHRzfPtor5OQEnA9ljX9Hky7axnVwgXe21Gp3NCBTbz8Degs6zMzjXDFP7dAS6Gr2rB4Ogb9qHjlRiam/v9ykm2shnPHUM5xKKNQ1GrRVf/u6WBU0O5gBL3zBdoSi3Cty7TXaIHmnagt7mUl8XlZKUnc0KjTAdqH9uINK+EnLKjff+bFtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(4326008)(1076003)(107886003)(6666004)(86362001)(83380400001)(66476007)(4744005)(66946007)(66556008)(508600001)(8676002)(6486002)(5660300002)(26005)(186003)(6512007)(36756003)(8936002)(82960400001)(38100700002)(316002)(54906003)(6506007)(2906002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFpqQnpHZTJaWU9VK3ZvZ3FQS2hLN0R5MTZBYlpUcFdvR2xjZlZJelFsQVEw?=
 =?utf-8?B?dzkzM0hKZGZkNXRNUzZ0d0R1M0pQaGV1Znl0UkxmakdmblNYc3oyWVNZeDJG?=
 =?utf-8?B?MVZYTmd5UURFKzdGMElyQUhnQis4bzhSMWxQUHJDZDRqSDRpb3cyaVpmQVpN?=
 =?utf-8?B?ckp5N0E5RzFaamNiUUQ5OHBlYzUrQzhSTHRoZEp1NytMaDNxSkpybXhhakRp?=
 =?utf-8?B?ZHlQZ0d4TTNKTE5JNEpDU2Nra2VvZXdVTXhKL0dESmJFREFDVDNONHRJTHRx?=
 =?utf-8?B?MmpRR3dqVVV0dkNQMDhSRGNLdzBtNFFQb3BTTlQ0Mm4zOWVqQktzUmNVbTVr?=
 =?utf-8?B?Y3E2aWluL3J6Z2VLQkp2aVFpTHNNdHlubThnZTNUWE55OCt6TlI3WnNWN0Zk?=
 =?utf-8?B?S0ZFRm5uKzFEL3NrTEljbXNiNjY3VFp5bFIyWUdTTjJTUmZKajFGNzAzUTVU?=
 =?utf-8?B?amVYSmd4Y2hLMERRK2VSaHF1K3JFS1RLd2JCL2RTb24vQ09nUGVUOVo1aEFB?=
 =?utf-8?B?Vi96OUs0VHVocnlOZFhKVlRlaTdsVm9TOGpiMkM5TnA4VDJMbVVFS283dFFi?=
 =?utf-8?B?ZGwyQStIVFNINWF3REpUbEd6dUZzeEUxUDFwL0R4OC9jcXZVZWdiclQxb0xZ?=
 =?utf-8?B?VXJIZHJpRkplUmhUV3RseS82c2gxZXNLZHpJU1NSSDV5eEZaVW51SnhwekNM?=
 =?utf-8?B?N3VFNHlwcWU1TVZSL3lzdHp0cnd4aDJ5REdOWlVaV2d0U29VUG1NcFhGYXRX?=
 =?utf-8?B?TmhIRTU2TGJpb3NZNW1uaklsWDZOLzRlZjZtYVNZQTlEWUVPdmp1QVJ6Tnlt?=
 =?utf-8?B?WTExbUtkRjhXSjNXcExvZ1B3S3YyS2NEUllhQkJYMGRLeEIxUVBzdjMxcGRk?=
 =?utf-8?B?WUJDMXR6VFRMN01XaFc2eWZybGlqdUFoZ2FHZTdXWk5XNVZwM2NSRTllaVQ1?=
 =?utf-8?B?RUdBbmhOSk9pSTIvQTNUb0p1WUNUNUsyT21UL2Vpd0hha2JjbFYrSkVERmRU?=
 =?utf-8?B?Sm1qRUJ3UTh2dW51T2h0QUVwRGcyNDN2VVJDZUhKM3Nva3lQblA5Nk5CVUFX?=
 =?utf-8?B?Wk9xaFhEMUdnblFkeHh2bHZBdWtEb3NUR0loOERlRC9zLytXc2JpZVAvMmZT?=
 =?utf-8?B?eUlFRkZEeE9JangyUDVkYjlnbTNDVFZ3a0t5aXhuWDhseE5MdEorb0FPLzVS?=
 =?utf-8?B?Y3c4ZDZCeFcwNUdsb2tZamIwWHNxajBPeUttdlhtSFQySmpGN2F1VmplYmVm?=
 =?utf-8?B?REtuR2tvaG4rbHBNc1F5dnhlazg1dmUrNGpBS1lQcmk4L1pJWkNlOENsdFBo?=
 =?utf-8?B?QkR3WGlBTyszMSs1bXJxR3pZWnNSdjA5RGRCTmNvMWFFei9NU0JvdUU2OWp3?=
 =?utf-8?B?bjB2cXlaNUx5bjBGYW5ncUhzWXZFSURsc0NsSUJhMlllTlRGMnpSbExzbjht?=
 =?utf-8?B?UXZ4QmF4YXluc2JGeUx4cG9mUVFlTjZGTTYrRCtTbkVKVlN4TDVJNmpVYkJi?=
 =?utf-8?B?alIwOWdQWEFPSmMvcW1BR2ZoMkJqSDRobFl6MUxyNFUwTTY5Yldnb2J3TU5p?=
 =?utf-8?B?UFNYU21LamNTOTZiMmlrUzdJM0JIbFpkNVJMUzdTeW05WlBkZGNzR3hqcjBQ?=
 =?utf-8?B?d1VNRU1mNnEwcjE0NmRmdnlyVW5GYXVla3lSNTZSSGpzWjdzdkEyNlVMYkE1?=
 =?utf-8?B?SDJXV2RlVEpXeHEwUEljcUdIS1dsSE9XbnpMOWhVQjdxYU4xVUNLV0lzZFB4?=
 =?utf-8?B?YTcyS1lwWUdKeVVaQ2NqWG1lYkNNbXVlQUNGa3cvK3lCUXplTHhiMHh5Mi8z?=
 =?utf-8?B?d21hVVVGdUpyTGJrRDlxSWpoSHV5dDJLTXNwVkdzd2tRQU95QUxVaW9GZlVK?=
 =?utf-8?B?cTQ2M3hrc3RoWll5dXl6YXdUL3dvYkZVS1ZBYldvT01VV0NDTlV6N1Uva3Zt?=
 =?utf-8?B?QzFPZFk5cEJCSE5Lb3FaMFB6NlJyRVVQYzBiN0M4N1NodjRsVm9XL2hBVzJN?=
 =?utf-8?B?aXZCcTA2WU5qODdhOWtDZFgrdGZ5UDJ1V0FFT2FLZExiL0FhL3hUdmgzemFH?=
 =?utf-8?B?NVhlcFc4VDV6c3BOZDdWN0ZuUk91SWtrT2ttZVhjVGNzN0M5R0hGMkNyZS8w?=
 =?utf-8?B?bjlLM0lqWU52bjlERDkvWUZkWElBcGMxU05xclFkNTZQV3E0NEtITUtCNDZY?=
 =?utf-8?B?SmJDUElVbDRUYWhRU1BZSm5INzcxdHRLQUltWTF3MEtqV3I5L3RmTHNGc2E2?=
 =?utf-8?B?cFYrOWY5VkxWc1owZmN1NkF0cC9nPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f086514-478c-4317-d2bc-08d9bfd58904
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 14:16:49.8775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPxShPIuTQrSztBbFlTxLKZEalpvHhE+kpxg01e1A+jQ4fGhqhwDO8W4a1HeYBBm1wwKOq4xtz1AjDa5EgTRUCNqFkTnhWuCBmW7GocCO+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2011
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For regular BAR, drivers can use pci_resize_resource to resize it to the desired
size provided that it is supported by the hardware, which the driver can query
using pci_rebar_get_possible_sizes.
This series expands the API to work with IOV BAR as well.

Thanks!
-Michał

Michał Winiarski (2):
  PCI: Add support for VF Resizable Bar extended cap
  PCI: Don't fail BAR resize if nothing is reassigned

 drivers/pci/pci.c             | 25 ++++++++++++++--
 drivers/pci/setup-res.c       | 55 +++++++++++++++++++++++++++++++----
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 73 insertions(+), 8 deletions(-)

-- 
2.34.0

