Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412AC475A6F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 15:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbhLOORJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 09:17:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:61506 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243270AbhLOORD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Dec 2021 09:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639577823; x=1671113823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=WbKGQwzNFtHUjDhP3/EZTCvTtjBwzUn8wYIkln3iTjs=;
  b=OUwUCRGRokEaQqc2D3Mj3M6QOseSGiKc1ZlIL9EZY5IJ64j4Uu9POBjc
   2Ky2AmG0iPvYFJWhEIFUInUQstVp2nFwgfcMK0oCuOFB/K8bCB0mgn9ji
   UaTc2tp7jPAhsQ2H+hOmBcBy1RgYwUHNCPEFjcAlGjchgtqGz2nlSEXCU
   s9fLlusoGeZEjWK1DP2U74TM9ThEca2QGTKK5415HdIxImmVf1LCA76Vl
   /ROLL430QJMXnlBVNprK55WHtwjKjf/nnwXP34LAZ72ntuEJ8ISXu+Ccz
   FGfRyQYqhx/HgyJcaMh37jK/5BzCg0fsouqmAuS2Agr3pqGsfmX6UPRuu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="263385685"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="263385685"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 06:17:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="755378755"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 15 Dec 2021 06:17:03 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 06:17:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 15 Dec 2021 06:17:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 15 Dec 2021 06:17:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw9nf5f0hUYKGcLW1hagJJdJX2jZAJ/LLJZfjvE0w0et5cxIAczvbTP2wVdJ8B//LkJbJubpEBgtT4EJWkQhO8qwgERKvPCYXnZjoVg0n+7LTE1G2NrLiAzKevlwiPOPUdp71nexlv6XIHjGX9GYi1fK6gXP0mN72ZMG0hbmePgF6P4HHn0YRaarb231gNwNPMKRLyY9ulq5yGUg55GNGaM80utzZn8citFVjAivReivzeP0psVq3jmWCRqE9Zmt8onBKdgptRn4tLsqFZC9KLC6Jz/m3qzAh002Gnuy506tY0yyH0yvrZUED6Y2tj3XhdvGvpeAt6pA5I55pSPDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVlrTDWM4h97SXpRYcoAm1AWlO/yIzV1Qu2W4wzILsk=;
 b=TSym8PcqPiNLvfLFNsKHlQLrvwYuDgrmYmgusXxf+Sj7fxFmcPv7MnwZzM4YhBmc5DZy69+GK2+2iRhQ3jEQsFiioZS3g3qDtuYklaJty6kb08EAzXH2ohtq6oWs8DTPhqNaTOceFOodwO6XfTtiMxTYDApxnlrBiAfKygWHRxUQVutFcyltEUYTFE5vMSwk2L7daK0ZDOPat2LUQoqSB0NrwKrG8zifJdIa4G8/VKtOO6wG4JMLvd9suT/QHNbh3Mo5dxqdJhzghRM6eGLm0VM5WUA4WHsygqiKFSIQp/UGLs8Zk0MhyU87h3kGLqgPx4f7c5+H5ll+UOMiJpNIsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.15; Wed, 15 Dec 2021 14:17:01 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658%4]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 14:17:01 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH 2/2] PCI: Don't fail BAR resize if nothing is reassigned
Date:   Wed, 15 Dec 2021 15:16:26 +0100
Message-ID: <20211215141626.3090807-3-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211215141626.3090807-1-michal.winiarski@intel.com>
References: <20211215141626.3090807-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0257.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::11) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec133b13-6eea-4dbe-0a76-08d9bfd58fda
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB47407A519C75AC980DA6452898769@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgPRr5FZ+J8fmdUhUzeRW6Q88jm33nFpw4gDBbwpPwQlO4TSETwme4xUJOnhLxT1SC6ATdzIHHi95OV39LUePM8G48ySLaRUU1ilkJIeh6CnyubI14HgfZi/kUSzgMA1pT5gaXrzHUzm6hIMzLAdsZw+dnZ4gQDgkaW6SWsz/stzkG4OTozxmTnhFVfbEdEQDhKP0nyZF7GqX00D+aq10lr1BTHNNem0FFCQL9oQFIa3+21trBCP48aT17AcoeGMi4Gmyf8TRfDnuGi8+usd3GsbF0H/0p5ty8pGPralm08JD7Px2aHY2Z6jj4SjLH6vYy2XYX8yetBjJSun+maD1xJKseiKx7bKOq8+I6aV1Fx5Ok60WHm1S95elxVuVg68SSPK0GfRFoI9YhUnoul/pEWNuR6Xs0BTIIFlVnlpY9MjLhBFrLQSzXGrhfeQ1f4q/m3lUdOjnysmmBApAh/ykvGZPlRV1dU/jcYRqo5rOkqMO8oHfz8fCx80iVTnyiqxpazCwOekiAh3bhr8isXmOBLt7sVLJYcaMfdXjUT+t+sOT9qhIx8PalOMOlJ8MZRCXf2FJtGDSlX/huII/s+lkxloTv5quKgE8Dvcx57h2dStfvm9UVibYV26ClqssLNhXunFtwA/DqVGSETve92l6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(508600001)(6666004)(83380400001)(107886003)(54906003)(2906002)(8936002)(4326008)(5660300002)(6512007)(26005)(66476007)(82960400001)(6506007)(316002)(6486002)(6916009)(36756003)(66556008)(86362001)(66946007)(4744005)(8676002)(1076003)(186003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZoNmE0VGVDTXpIVi9ZSittTjNiTHM2czQ1UWYyTnYwR0I4TDJXSnJkdVNY?=
 =?utf-8?B?K1ZXcnZ5OUVjYUowRG1iSVcwNUdDOEhISTRPQXNBT01waW1INmRzNDVzck1r?=
 =?utf-8?B?akh6UmF2QVRMKzZYSjRhdWR5NFNnR3F2OHE4LzBpUGJIKzRGdHRTSG92OGx5?=
 =?utf-8?B?WWhwU25MdENIR085eTBDTXBMOGtBYUVyeXFlcjI3bmcvazJVeWxhcHZFS0RJ?=
 =?utf-8?B?N0NoTXliNmg5MlNVVDVlaWhMWi8wRVRpR2lXMDIxY3VmTGpQNVZsMGtrTFh1?=
 =?utf-8?B?YTNLR0xrVTh3R2NFTWJMY0lqTktBNWpkMm9GcVJQSnBMZWt0eUwxd1c2d1Jr?=
 =?utf-8?B?cnhVWGlyd0oxNHNvODZtamdrMHlYUXZyaDdzMXY3dnBja0FDMTJxL2xtb1VW?=
 =?utf-8?B?cEk5eUgyZ3VwYk9XR2xkR2wyK2F3QmxGQVZiai92a0JFTlFZby9UK3FaMVV4?=
 =?utf-8?B?RFJNTDBmaG1GVCtFVFpvN2lpTG12ejF6TXBHSnAxamJpdTF1bWF5TVRxZFdy?=
 =?utf-8?B?QUE2aUdKdkltUE5nM3dOUzBHbTBtZFh0di9pblI0ekpoZkVrZTJKRGlJL2ln?=
 =?utf-8?B?NXUxd3NWbHdpSllRYVRkcmdoSTl4eUxlam1sRDBwSHM3dTdkaE1aN2hrbTBi?=
 =?utf-8?B?eEs5V1pjT0lPZC9kRWdSVjcrQTdTRjBEZTZVOUdhQW1XUTFEVjFxY2hkVkpw?=
 =?utf-8?B?VVJZK0hkYkJkK0dtN29SaVFHM05Pbmpuc1gwWENMcGdvRlNyWEl4UzZPMjZs?=
 =?utf-8?B?dk9uNWI1Z3hYT0dvNVo1Qm9JcXVQeXU2M2RxbkZVRkRIemdZaEUyQWhwVzZW?=
 =?utf-8?B?VmJhdGdqWDJEZXJOdVZFQnlDdFFIZXYyMEc5bWhFWDRVdit2a0xrN0o0Ukdm?=
 =?utf-8?B?OHFqVVlpbldoU25uWG5weDR0NjZlbmVqbndIdE5mbGNQN09Gdk5kVWdlRmR3?=
 =?utf-8?B?aSs0QWRRSVMzQjRZME9HTnRzeXpqOVgrR3liSmZZWlZYN2Jka3BtK1IwZlVN?=
 =?utf-8?B?NDRicGN0UktPQ0JweW11Qzc1YmhXT0F3SkN6ZHpaRlZlYUlWMWlFaWZBOGhT?=
 =?utf-8?B?UFR4TjdqL085MDdyNmExTmJGeXYrVVVuRlpucjBPMFBGVUZDdkVFVVIyNUZt?=
 =?utf-8?B?cnhmR1RJRHdERm56UGRNeTBRSXdQQ0pXR3dUb0lDTXh5b2ptcWkzZk1na3FP?=
 =?utf-8?B?b0tLdXdtd3NyRkhWZWl1dFN5V3hHSWZzMDJ1OXJteTQvZDY0NGhFWExxTTdk?=
 =?utf-8?B?TTlITS93V3RWVHFnUGNqeUNYTUo4QTFDS1BPQ1FQRkpBaENUWGI2eGk2V0Mz?=
 =?utf-8?B?UU5RYTVuN1R2R3BxTW1wUVNybDN4RHFpV1hxZjhHMlB2TjFEcDM5bHhraUQ1?=
 =?utf-8?B?TFJQcmR0TlhySy9ZNllvcGc5NnlneExyYThmSDEzdFVyNHZIeHcwU3p1WTY1?=
 =?utf-8?B?c08rdjFtd0x6b2ZwdnB5dkx4Q3NjVFZOZ3pqS1pvRGNJS3ZSK0NyZ3Nhekwx?=
 =?utf-8?B?NDVsdURQYmx3aW1PUEdxajBlTEU0QnM1VTZ5ZTdmZ3lNZFduZDREQXJqNGVZ?=
 =?utf-8?B?NHp4bk9rR3lvZDZoTk84VUhTK29DQVZiMGlpait2bDFBMksxZ2FHTUJyREQ3?=
 =?utf-8?B?T0ZLMktBREdLbThwU3lGVXZOQ0k4bEFXa09WUVdhQ2RDT2RiZTZGa1JucFdL?=
 =?utf-8?B?Y1F2Y3lYWkFkSjNjcy9TN2lYWm1EWm5YMVJIdzhvU0ViUnk4eUQvTmRBWGx3?=
 =?utf-8?B?QWZuNmMxbEo4cjFVY2NsTy8wSjBHcWQ1YXZSQU4vMHFZNVNrQVB5NlFOVHdw?=
 =?utf-8?B?VmJkeURpRm9UcEVsekkyY0dsc1R3SHR1SXdrODFjbGNpaFVxQnhvQ01SNnl2?=
 =?utf-8?B?elJBR0lkbEZoUlNZRDhwUmZ3RGRqZW1FaTZOVWo4RkVJTlBwVDNGc3A2bW9q?=
 =?utf-8?B?dHNWYkhISkpZc0xBdjRZK2pUcjBJT1h0Yk4xZ29UMXJsbGx2b0JNU0RQaXds?=
 =?utf-8?B?UzhjaFkvSDgyeE9GdkNTa0RrU2syRHU2ZzBPeHRhVXVCS0JWRlVtbHhqc0xB?=
 =?utf-8?B?a3dpbXgxbUg5bVVCaXNGOExnR2wvZTJFbm5nemNPRkVIcUN1RHZUS2hqY0tV?=
 =?utf-8?B?MkJxMGdEcnNkdVVvVWhGUDJmckJNMmVscmRNQmluZ1ZaTEtBbUcwano4THkv?=
 =?utf-8?B?OVo2dmdvSk1haFAweWgwOXRvUE9JTmpxK2F1c0N0Ny9lTEtGMm4yRW12YlZs?=
 =?utf-8?B?L1BRVVc5T1JlK3N2QjZ0d0lDUCt3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec133b13-6eea-4dbe-0a76-08d9bfd58fda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 14:17:01.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InFRK2bTR8lGCkfDtZFX9YzgFnI/v/CfyqzmAtqDmGvqKlGKairqK9I2+p8rqfOcgW1dbFONQrfSkG7Pv7VFNRDoM8nWUy8HAwhAd7dy0sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When pci_reassign_bridge_resources returns -ENOENT, it means that no
resources needed to be "moved". This can happen when the resource was
resized to be smaller, and it's completely fine - there's no need to treat
this as an error and go back to the original BAR size.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/pci/setup-res.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 1946e52e7678a..5de5129055e0a 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -484,7 +484,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	/* Check if the new config works by trying to assign everything. */
 	if (dev->bus->self) {
 		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
-		if (ret)
+		if (ret && ret != -ENOENT)
 			goto error_resize;
 	}
 	return 0;
-- 
2.34.0

