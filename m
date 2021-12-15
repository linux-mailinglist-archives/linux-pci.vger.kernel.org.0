Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99B475A6D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 15:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243238AbhLOORA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 09:17:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:37982 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243259AbhLOOQ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Dec 2021 09:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639577819; x=1671113819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KMvhkk6usIByMbzw+cv/apgyMjiq4ru49hJ3EjEocQw=;
  b=jaOUHOem/FKXWqIkQmhpOXNVPWgPohRWwrPC/hbtPBSqc4P93JmA7/vE
   aEyHOQzsBFXbsWzfjQ7j4gjCUuz+3CMJMs/p6Pi6X1WQ6Gek4/UtJ5Tj4
   qSz9+x0EBz/NF/Qq0+2p2RBy1m+vBPO9Ipm9NbmyciuBnsAzXzk5SqP/3
   zfD0y7QqEutJ/zX7EflrEnDwcG1aQ4klX9SYRB511N/0I9brj1r4dIKrw
   PBepbO/95r95+wQqnKTh9CKXfm54+UlOvztrjoI968h2HHNSDtVbweyav
   izPM2KYHNMaWuW2r7LldY8SZQDGHyIrcbFHY6dMAwn6j4IQS8rkvF1bDE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="226516564"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226516564"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 06:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="567937522"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2021 06:16:58 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 06:16:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 15 Dec 2021 06:16:57 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 15 Dec 2021 06:16:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNIPcgArHJNgN5ZkDdHv4W3py0uD0RsuaR8xsH7DOwIFJDAg11L3iIyW0TOXxBI5hHcbTGkFmYQS5u3jprKrLDYlzhrsiwqAFZm06To4MHhxK1dfpqn7dVfEw+tK6G0MOFMATkiAlD4oxkqpbsGTiaRDypkZbk6OzI1XF0L3Qg8HvwuTwU6sfOEVYw4ci0tDhZbH+KGL6t3fMwU7I/Wmc5b1HzNI6XtX4RoWKAffa7y1GHvmf9zlYbrPgYltq0lSDug75rHcfNHtoeFOjlZk3mxrXh1kAg97NnqqXHNbvhvF63v4LpAtEXeVuTLYuM5PexsTtGBvLs8v++mbJCEz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XR1iu2fghQXq8zY3CEx5tgP6YcAnzyzBG13HDzqaN8=;
 b=YRGo0kXCk+bHhZaAOZxvOboN6aJZAOcqXtTdkHPEV79aDrbVeReAIiKmREUe3K2/EnZFi49YNP0rDKYunzdM6rUP/wh70hbQPpK42A7wnOUxaJCQ5gtNsmsk+uhJFd3oz5ghfNhJXuptIbZZjW/Mvww3OTeoDPg1xv4fbO6cZ/bpFSgrbT04TNYc1pZZRURNEADHWUTg8RB4gw7nxuMmXAX/qy0OzrXJgjusiZWerlNuFFkN0jrieyPqyJQEm7wwcyaG2smbkAMXnwlgnykaOUV8ctxfJ3rfQVO5lN9fLcmzkpTWuevAX330+zivMckLF1RjXFWQ6uHbPcZ2NKDYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.15; Wed, 15 Dec 2021 14:16:55 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::54fb:8c9f:670:3658%4]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 14:16:55 +0000
From:   =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH 1/2] PCI: Add support for VF Resizable Bar extended cap
Date:   Wed, 15 Dec 2021 15:16:25 +0100
Message-ID: <20211215141626.3090807-2-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211215141626.3090807-1-michal.winiarski@intel.com>
References: <20211215141626.3090807-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0030.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::18)
 To DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8261a6ff-9f20-4331-eec6-08d9bfd58c6e
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4740174C2640B6CDC570DF3998769@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OT8SY43X20PcDdsU90NOkCGx3CKuNs7wKUovucbDK8s22HnC1QHN5rKb3TSQ4ZyCPIYvnYKODoukKKc4IvKhPIjkBiVA4oFKsaus05/6VY6DnKfTye5EqryfiTzyk/CS6Nc6H/OBTOU2ilT4Kh8RP/Uack1vBYFrswEjYEzXJINuV/oYJBRWb7FGwE5nk2izd+U3f2gzCkISJojXRZbdidRxd83QLfnELQ9G/yhM4Dz4erPueKwBgJ0WMTy3H0/J9hveuDt/omhq7aJ4a/iIKcUGfAIJ6koP5JtKof7pCX5NsYnQGPSG9RMKI1HvXOBD2wuZbUU4aA6cQztOA6JQtG9HHojH4wm7h0zHqRJQSMEIyKHWyO0DrNRssETOOPie+kMI3oCVDDHx8IsVZb/mgAtHilU0wruqZPNYpqAtzoGrtu3edZdGrYS9aw9xqyj4dXT//3qpWNlcjbzsT8nVoiW51B+is14SpaAwyyB+zwUVPQMDQhPKuzAJ27pffqfq+g3e9uyMbMBU5Cdlvo00l+eWUfNuYxSyc6DIyHQzFIHSAdx4WBKMQDjEajopiR6ZCmJxIDhhvQDVAkBwe6yahaaIeLWs+WYnmFLRmPu/7SKI0fSFRfKLuZIF58ntcuqeVetHhi4J/Cy/Za7095fWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(508600001)(6666004)(83380400001)(107886003)(54906003)(2906002)(8936002)(4326008)(5660300002)(6512007)(26005)(66476007)(82960400001)(6506007)(316002)(6486002)(6916009)(36756003)(66556008)(86362001)(66946007)(8676002)(1076003)(186003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVI2OUN0TENnSTRaTkFhbERnV0FpMUtZSEsxdmJYb2dvWGUxTjhCRlJIbVNp?=
 =?utf-8?B?LytRVkFLNUR2cjhna0Y3NVJ3ZjdBWTBxRmNMKy9LZ2tyczdobEFkVlNJVzB4?=
 =?utf-8?B?cngydHZVOTdTcFN5cFIyTXJpR3JlY1RsdnYzSExxYk4yamIwTE5GMnhhQnJz?=
 =?utf-8?B?ejk5Wm5ac3J1eWM0Yys5RG9zZG1JT3RvNTVkeENCc3NPSk5HTy80QUhzNW93?=
 =?utf-8?B?UXA2Qm5rZjAxUkUyam1UYmRkN2hGdGNScjRmRnRJWklrckprL0xBT2IrV3cx?=
 =?utf-8?B?eUZTeW43SFBsZ1VzaXAzYWhOdEJuYkNkUSt1UW5YT1Faa3RmTzlsYWZiNFcx?=
 =?utf-8?B?WUU2emh4RWk4dUdIY2ZmWDNTOGJ5WXVReVBNZDQrcEZ1bUd3dGtySlFPM0R2?=
 =?utf-8?B?LzI4M1cvWDk2YTRSZiswQmx1d2NSemliQ0sybUd5RnFwSFhSRzNDUWFwSUZZ?=
 =?utf-8?B?SUk0cTJsMW1adFd0anl0dFlLTXpkT2dqaGJuRWF2b0h0a2N4ZjFUZk1nTEh3?=
 =?utf-8?B?a0dUNk5Pdm5zRVRLNkFWT1AvejdoNmFFR2o2T1NVb1RwM00rci9peDJYR2RE?=
 =?utf-8?B?NCtDbnIxME8rOEVpVGFUM3ppZXd0aWJDbll2ckc5cXdTNVFUMEpRbzhtSGxF?=
 =?utf-8?B?azZFQ2Q5Q2ZJMUVCNEJ4VE5JWWNscWJCOG9LQjI3YXNDUlNlWUJmOE9hcy9h?=
 =?utf-8?B?cUF5N3Q3RUM4Z0R4UnNQd3p5WUh4TkU2aW1LZ1pPaC83eEpBY3hMWm10elZm?=
 =?utf-8?B?MEVvQ3RKeEhNRE93ZWd1ekxOeklXMk9McFc1UTgyYzBqOEIzVTFYTkJyTkEz?=
 =?utf-8?B?ZExBbkE3ellFUk56NGUzekErN25wSEJDSWpsUHZ4NTRoR0l1dk5jTU1zSHpX?=
 =?utf-8?B?cURac3JSNUpGcnlvTi9vVlVLOXpmaHNudDlOVi9jb1JWMkVYbG53YXVsYUZ5?=
 =?utf-8?B?eERWaHY4TWF5SXJ1UDV4SjV0akxpS0tzQ2dnWDJLUE8yVG1lMWhDUnplUlVl?=
 =?utf-8?B?UVdJc0RjaUM5NUM1SWhTYXJUQnhweVoyVnowTTh6dnFWdXZES2JhclNBaTNO?=
 =?utf-8?B?bUUxWTZWY25YZC9Ra0VhOUVZNjNianBIUjBsaUVKdERDeFJJeW9SK1lQRlcy?=
 =?utf-8?B?M0pKMmRHMitsY05iTDFkbTZBeEVHSTZYRVJXVmp4aytpbWJDd05WK1ZBd2tZ?=
 =?utf-8?B?aWxxaGpHaGcxY1piMzVVQnk5eXBrQVdOaXpsOUxubHYwWTFBdFJLRmlFWTBm?=
 =?utf-8?B?MFpiOU5tUitROENkTmdRT0hvWXpmQWFDK08zaWVDRFlVTkdKZ1U3eHV2YlVu?=
 =?utf-8?B?WnpRZ1JrZGVSL0lrL0RBTE5ab0J2QzkwZHBVV3EwRXQrZndlSXFNdlJLOFUw?=
 =?utf-8?B?OU9ib2hRd2VZZk1STCtReFpUckhxUDd5emFNTVpEOC9VWHdUemZYZisyYXlY?=
 =?utf-8?B?S1FYT1c5SXdmbVByand2QnVVdWVNZEh0RlJldjRndDdUa1M2M2FEczhRalJx?=
 =?utf-8?B?aVdhTDh1VHRNa0Y3d01wMkRJZ3YyVmhLRVlpMWduaWlmSDZtZm9mU1RqNExr?=
 =?utf-8?B?cDc1aWVZd2duUVk1L0dMVExpYnRCV2MwcGRBYVRuWlRETkFZdkErdHc5VXRw?=
 =?utf-8?B?TENsV0dXL0lSZVZlemhFa0RBV014VVIrajBuaXV2Q2M0OGU2ZURZTGgyUHVx?=
 =?utf-8?B?ejA0WjdEU0dXcTFGRzd1dUlGTjVIcG45eVpPZitITmZMRzdEKzdMb1VVVjBs?=
 =?utf-8?B?aU5ha0wyTFNJZTcwQTk1Mnd4TnB4QnFEemp6dHgxVlN4ZVlqUEhHVGpXYWNS?=
 =?utf-8?B?WkxHaVBrYXdTZE53c0RDTFVvbjRGQTB2V2JxVXBpdkdDdEhESm5HZCt0SHYr?=
 =?utf-8?B?Zi9ITW1Qd1FVWngwdG5tQUdpVmtLOCtJRzR5NGFGZUVwWHk3aXphTHN6cHdQ?=
 =?utf-8?B?d0F2UEMvWkhxaXhUVVBsaVVtVldGcW14UzFYa3Y2b3p4RFJUazVyeUo0RU1W?=
 =?utf-8?B?WnJ4UGNsNFFnejRFbm1seTZERjZyWExvb3ljSXI3bXlla1MzUDZBS2VCNHV5?=
 =?utf-8?B?Ti9ldHJHb2pOcHVjbUMzY1hacjE0eWkvdlEzaEk5dGx2OU9zSlRETi81cXk0?=
 =?utf-8?B?ZCtjL0M3eUV3Q3NkT3RiL1IzVnJ2VUdOM01qczBja1hzbGdnc1FSYUhrd2V4?=
 =?utf-8?B?eVV2K3BUTE9HZ0JIZlU5VUJQM0VpRnBENUhhSWtzNlVjSFZ4S2s5YjQrY0cx?=
 =?utf-8?B?SXRRTjM1MWd1L3VwR1NVYjVLRDB3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8261a6ff-9f20-4331-eec6-08d9bfd58c6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 14:16:55.6061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Usw4MKCsCAYE9y/I8PCWxXVDVky1DwWw6SJYRRL/e/lxmQi2J/18DTrHe+Mi5tAPR9/P4FNDye70jLb65ab5G/ySDyNS7hvfOS13sfn1q2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to regular resizable BAR, VF BAR can also be resized.
The structures are very similar, which means we can reuse most of the
implementation. See PCIe r4.0, sec 9.3.7.4.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/pci/pci.c             | 25 +++++++++++++++--
 drivers/pci/setup-res.c       | 53 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d2fb394986a4..89448c5104e46 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1682,12 +1682,15 @@ static void pci_restore_config_space(struct pci_dev *pdev)
 	}
 }
 
-static void pci_restore_rebar_state(struct pci_dev *pdev)
+static void __pci_restore_rebar_state(struct pci_dev *pdev, int cap)
 {
 	unsigned int pos, nbars, i;
 	u32 ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (WARN_ON(cap != PCI_EXT_CAP_ID_REBAR && cap != PCI_EXT_CAP_ID_VF_REBAR))
+		return;
+
+	pos = pci_find_ext_capability(pdev, cap);
 	if (!pos)
 		return;
 
@@ -1709,6 +1712,14 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
 	}
 }
 
+static void pci_restore_rebar_state(struct pci_dev *pdev)
+{
+	__pci_restore_rebar_state(pdev, PCI_EXT_CAP_ID_REBAR);
+#ifdef CONFIG_PCI_IOV
+	__pci_restore_rebar_state(pdev, PCI_EXT_CAP_ID_VF_REBAR);
+#endif
+}
+
 /**
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: PCI device that we're dealing with
@@ -3639,10 +3650,18 @@ void pci_acs_init(struct pci_dev *dev)
  */
 static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 {
+	int cap = PCI_EXT_CAP_ID_REBAR;
 	unsigned int pos, nbars, i;
 	u32 ctrl;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+#ifdef CONFIG_PCI_IOV
+	if (bar >= PCI_IOV_RESOURCES) {
+		cap = PCI_EXT_CAP_ID_VF_REBAR;
+		bar -= PCI_IOV_RESOURCES;
+	}
+#endif
+
+	pos = pci_find_ext_capability(pdev, cap);
 	if (!pos)
 		return -ENOTSUPP;
 
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 7f1acb3918d0c..1946e52e7678a 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -407,13 +407,36 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_release_resource);
 
+static int pci_memory_decoding(struct pci_dev *dev)
+{
+	u16 cmd;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	if (cmd & PCI_COMMAND_MEMORY)
+		return -EBUSY;
+
+	return 0;
+}
+
+#ifdef CONFIG_PCI_IOV
+static int pci_vf_memory_decoding(struct pci_dev *dev)
+{
+	u16 cmd;
+
+	pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
+	if (cmd & PCI_SRIOV_CTRL_MSE)
+		return -EBUSY;
+
+	return 0;
+}
+#endif
+
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 {
 	struct resource *res = dev->resource + resno;
 	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;
-	u16 cmd;
 
 	/* Check if we must preserve the firmware's resource assignment */
 	host = pci_find_host_bridge(dev->bus);
@@ -424,9 +447,14 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (!(res->flags & IORESOURCE_UNSET))
 		return -EBUSY;
 
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (cmd & PCI_COMMAND_MEMORY)
-		return -EBUSY;
+#ifdef CONFIG_PCI_IOV
+	if (resno >= PCI_IOV_RESOURCES)
+		ret = pci_vf_memory_decoding(dev);
+	else
+#endif
+	ret = pci_memory_decoding(dev);
+	if (ret)
+		return ret;
 
 	sizes = pci_rebar_get_possible_sizes(dev, resno);
 	if (!sizes)
@@ -445,6 +473,14 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 
 	res->end = res->start + pci_rebar_size_to_bytes(size) - 1;
 
+#ifdef CONFIG_PCI_IOV
+	if (resno >= PCI_IOV_RESOURCES) {
+		dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(size);
+		res->end = res->start +
+			resource_size(res) * pci_sriov_get_totalvfs(dev) - 1;
+	}
+#endif
+
 	/* Check if the new config works by trying to assign everything. */
 	if (dev->bus->self) {
 		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
@@ -456,6 +492,15 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 error_resize:
 	pci_rebar_set_size(dev, resno, old);
 	res->end = res->start + pci_rebar_size_to_bytes(old) - 1;
+
+#ifdef CONFIG_PCI_IOV
+	if (resno >= PCI_IOV_RESOURCES) {
+		dev->sriov->barsz[resno - PCI_IOV_RESOURCES] = pci_rebar_size_to_bytes(old);
+		res->end = res->start +
+			pci_rebar_size_to_bytes(old) * pci_sriov_get_totalvfs(dev) - 1;
+	}
+#endif
+
 	return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index ff6ccbc6efe96..7f5726d23b038 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -734,6 +734,7 @@
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
+#define PCI_EXT_CAP_ID_VF_REBAR	0x24	/* VF Resizable BAR */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
-- 
2.34.0

