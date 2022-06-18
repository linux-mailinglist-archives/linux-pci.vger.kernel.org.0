Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB9550171
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jun 2022 02:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbiFRAnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 20:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiFRAnt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 20:43:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D2633BA;
        Fri, 17 Jun 2022 17:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655513027; x=1687049027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MoNPO6BpePzWHiGLwthbjzetRaaZmzucGqE0OfbBBu0=;
  b=N9t/bFWzAEZOB8r8c8w6MdTZXQ1ONqNVYVESeWU6klFxRZ7WIJudWl+7
   mATA0S0NtAikAldkI5myZbdDu60Ge6zn8C+mnKBGCInBxG5rIc+a23qaS
   B8/4qrTYdhW8G7wbaWaJArStbGtFcu1+RFvXkXCo2bqzorulfgX2wxNUs
   lkkWcl6IJJHItynF+QzjltfeWqKkYoSTSBjna3HHF+Bi6lh6yJ66rVXkB
   BGdAr2zo17kgIL0FEANWqqTOUaZB6DrOPO6Gp53NiG9MOrHAusDjnWq9o
   yBSb9WW2/eE0Z4RN1o/cMVplzsGawLHcha8+sVOM3kv5RtA8xoKksDbhr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="260045901"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="260045901"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 17:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832248334"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2022 17:43:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 17:43:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 17:43:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 17:43:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS6e+WvPav8KCCw1EPgKuPl6oX1U9MrUqXiasuNlvR7fC1RUuS0IogvY6L88LIZ+qJekHKCbclhkeD8Ye5dQChQ1LEN5EXsND/NfKfjLt/MmalTaQ9eYbXMMW6Onu007+scXDlWLUD7xwP3Tsi79GnbxJc3SZ7Y++U8+Cr4464vpr8VOR6g0cpuZBWo6ZLi75gSKupD++MsLXxnjroTJw621b+H/4U54a5kcr791Kses32VaYoZtXg82W5qn7x5GVTvbPmm7YBIzIhYARYZ9QJQcNhhkMHWISProyYCIbHT5nQYd8FDBUDRiJLELr5HTSPqn3gtbRPo7G2ErbO+mDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFxKVc9iVjGOQp/9u0Ky5fw7X0g/lRSe11Gmx/mNv8U=;
 b=lPPD7e96y3DwI5c8zuHgBKQpNVTrF4jfygCDs9Ko4+oo3FlnklYD1yKcGId45tIbow8DKkzN1oLG4YB7ZcyZX/a2Hd3y0/UeEeFHvavNdvTlIkbdJJ+PYoWDeGb4V/ml3sRDWIisW8CSinapVwF7z5UF76v0FRjXDnvhNZxR9W+6FVvWQu509tC6cOsxnfAPI52ydULbGlJjNbR4odCPzf2OIMqPfGV9gydJCdcIIiQUkWeUiuEamqt62BGqSirHakQ+Mdg/8mrocMQurU+u9ROU1w1IorRCzZ8AbsmdszGunSf97YH0gFOqUZr09HIJR7f484c9OxKvycHt+NFpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MWHPR11MB1296.namprd11.prod.outlook.com
 (2603:10b6:300:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 00:43:43 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Sat, 18 Jun 2022
 00:43:37 +0000
Date:   Fri, 17 Jun 2022 17:43:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V11 5/8] cxl/port: Read CDAT table
Message-ID: <62ad1fb69d742_8920729490@dwillia2-xfh.notmuch>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
 <20220610202259.3544623-6-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220610202259.3544623-6-ira.weiny@intel.com>
X-ClientProxiedBy: MW4PR04CA0340.namprd04.prod.outlook.com
 (2603:10b6:303:8a::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cb448cf-c330-46a4-29f2-08da50c394ea
X-MS-TrafficTypeDiagnostic: MWHPR11MB1296:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1296339C78F95187D39C57C0C6AE9@MWHPR11MB1296.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFzI5POGhEsL92vmI1lP3Z2SXD4PSWH0FDHnVHXC55xEeik1vXiJxZq1ojRUexFMmmIs2Id50Lw6TdIQtDmNS1AReSdSNN8eTUH1G1XMek/xIGGv59DyD1BuNzE8wRNmT24d0KaIyYJYVlRG1C0ChiMciHQx5padJgVbxG5tEQF28CIxSUQ0XjwfXVR/nOsHIGy5UJqtxXiNTD8iEF1RhUwT+dnPUDOGTwWsgQO/3B+TpdlkhCF5wv5jQzxxpbSC6WrLRf40voNR/dC96+Hm/F0y1jLo9BFSV3+97bxtu4k+2L1G0nZS4gptORIoQHeS/qQ3FWYojrJiPLvdEGv4L3a3xRp6tS5o0cHOivK/FZ+JbbRBi6MN89vhSDmIcW/q0h8wqVO+kR0OtJQl87eLq2plybdKug61FTHsqaBKNPStSa/kD5jZQxyRCMOFjdg6HwMQnkjxDptGuliQaeeern0WYJ1Rou/V5njnMUJ3xA0/Tfvdo4E0RRjXmTSVKZ7FqVy4ptAMrwiXheCSc+tLJqQqYoMVusaHB5gX46fGS9zMY7isRgZTrqUG9SQV0i0sIRhM6mOJsTnTc/zejOQ6EdZFYX5OAfOh/aF21YbVjwmcdHKbJ7rsIMtzN0UnXh7NiHdv3CJTz94wEZg7NBg1jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(86362001)(38100700002)(5660300002)(9686003)(26005)(6512007)(54906003)(83380400001)(110136005)(30864003)(498600001)(2906002)(8936002)(6666004)(66556008)(6486002)(186003)(6506007)(8676002)(4326008)(316002)(66946007)(82960400001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PWAQZRICQQLNJIqvGS+VMNP47CA4dUiX+UY/rEj7hwfPOpg9g6wCXAlSwwvD?=
 =?us-ascii?Q?zIHXI/KfgdQeOHXckFWPS8LzVyatvwlqNd46dwgYtGH+4R9v0fsxJlvvnkwK?=
 =?us-ascii?Q?KDsbI4vWRlAmxvWH040ipqbzSbWYWSe3o4oo6L7QPASR6LJpFfNe5I8WXQnT?=
 =?us-ascii?Q?KRiwpvW+7DytZ0uj1uuVejBsOjXqznWGVkILqy2ogIP4LH0iswb23OBpm12R?=
 =?us-ascii?Q?hottAUECf/7HqcH87zuSW1vKUz7DfxmOGtlSV9/31BFmYIq49PdKyik//kjA?=
 =?us-ascii?Q?JNUbW/EloEUydiNs4dU5KQNCse/vBst8LIP+Wi/pDBlRCRpU8l589QE1RUgz?=
 =?us-ascii?Q?EAGkl6cAYoPJuW8adH+8bwyw8P8wG0/PpvamelKvplu8XRkErV4Fjakwq154?=
 =?us-ascii?Q?YBDOcGw0lqRG61uFsX9Tksi7/dbMuxTsBoAz67XM2l8ExJ1oU6q2pQdqsNW/?=
 =?us-ascii?Q?Ju+b36CPqcb9li16Wkg/i/rEpS4FsamGj6bt1Lhzyl9q6FMv+3WMP7NCYR7r?=
 =?us-ascii?Q?hM0ypSZmG4iziWOv1KQ7Vp53RXLVowdnvbX8ql1Wqhhgxf6JRwRxxdKkG9wU?=
 =?us-ascii?Q?KMTOa2O3Y8y2s7QKd5DV7alGGtcEBePYDqBA0MoyGrAiRF9nmqdIQTMbUnz2?=
 =?us-ascii?Q?TfAI+jm1Wpet1WmSBmhFZO2efq+qDtS7iTEgZQAJoC+w2xVCFbuteAMun3sg?=
 =?us-ascii?Q?FjlIZDPFD7Ar5kLRysjXXor3hkxTj/b3iv1kShOIXlu/EpssXSKq2YTHs46Z?=
 =?us-ascii?Q?u6XzwuX6y61qkYLWJRwx6XWGpJNsEAihfHCkLeh1XyguASxTT9M0vlpRCjiZ?=
 =?us-ascii?Q?m5CBMbhSA3ilolgOj5dAXc+XfvDk6vXP03VLYFp9e7Ogc/ty40buwCd8mSMV?=
 =?us-ascii?Q?af2NoEiAroABQpNO3bTPpPnT6ZTnwlGIGDioLNgh+st7CtD5t2+f5TrTSlxS?=
 =?us-ascii?Q?Oh9WCmEPNnHYob34JLUk5fFgmZKOTDEtahFcbuxsvsdKFtC4Syb03tNSq4aI?=
 =?us-ascii?Q?MGi15C4iFqtsLMDWryP62MJjXN1znMUuUtgFNgW3oT+9tA59uqH/3kXx7w2d?=
 =?us-ascii?Q?/fgqF/AmOnb+19ZjbHqii2dtKQQw5Hhssxy+g2zSyVROV+WFsdggZzcNwso7?=
 =?us-ascii?Q?BedSxTWizzXbx8hS6oE1TGzWb5PRaQoNIXHHce7OBzAe4z/2UVThu6qPLts6?=
 =?us-ascii?Q?mFtsMJEOSjgI89rqlYD/8wnB33FIpCLz6LJIQMvg8MJZkNselSAeIIdZZrvq?=
 =?us-ascii?Q?k2LNSD+Mt7l6HY7/kd2MH23jwGhusnjvAbwoqxOWPR28gXQ/T0R2H1aztGwA?=
 =?us-ascii?Q?8Ji7/+aIbRCUxH0k0o6zpm0XMMjhd1iYDErpjun5UcqtI71zxuZIWGMidpw+?=
 =?us-ascii?Q?l4F55QHmGqcSv1Rz3owqLOyKro+cDXosJdT8hTFwINMwlpbiyzhWJ2Q6hy1T?=
 =?us-ascii?Q?wGFz1S3b46G7/IMc3i6exxNSbWY+DohJbABFec/nogV6CqU1JJcQIGN4M5Mf?=
 =?us-ascii?Q?9SvOkSnXnYn8o8oNdqn7zg5uKmd3TvmjaD4ygHAZmKcQr1LzQ0plaLP7Vq1L?=
 =?us-ascii?Q?+FhhyEE3Z1hqu3RpnVt0htl6V0vvZ9JXh3Powmak8E+iiI0KaD0uFxM9OUcL?=
 =?us-ascii?Q?jZRs+WXZVeZgcgYZVdiveL3xTHrxs+62CrWhfhSaAR5+MCF0T4uTabBVfm8E?=
 =?us-ascii?Q?wLRt0beKI/2gHgtzvtmi3zYKPe0L4GYwUWWMoukM3QT1i5Iq5uJpbiIoUQA+?=
 =?us-ascii?Q?FWWwECp6MhnLeo6uRsBzoUhefxSRCt4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb448cf-c330-46a4-29f2-08da50c394ea
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 00:43:37.5127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BomP1k7AH9e+ZDyb3swQLlc/Ya7GXotdK8OW3Oh79ho07u+eh3tviixhXBbgpkBzcon9nbsD8hKtgXiJLJxk97nZPspbbhfSpp96hLxoaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1296
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The OS will need CDAT data from CXL devices to properly set up
> interleave sets.  Currently this is supported through a DOE mailbox
> which supports CDAT.
> 
> Search the DOE mailboxes available, query CDAT data, and cache the data
> for later parsing.
> 
> Provide a sysfs binary attribute to allow dumping of the CDAT.
> 
> Binary dumping is modeled on /sys/firmware/ACPI/tables/
> 
> The ability to dump this table will be very useful for emulation of real
> devices once they become available as QEMU CXL type 3 device emulation will
> be able to load this file in.
> 
> This does not support table updates at runtime. It will always provide
> whatever was there when first cached. Handling of table updates can be
> implemented later.
> 
> Finally create a complete list of CDAT defines within cdat.h for code
> wishing to decode the CDAT table.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V10:
> 	Ben Widawsky
> 		Failure to find CDAT should be a debug message not error
> 		Remove reference to cdat_mb from the port object
> 	Dropped [PATCH V10 5/9] cxl/port: Find a DOE mailbox which supports
> 		CDAT
> 		Iterate the mailboxes for the CDAT one each time.
> 	Define CXL_DOE_TABLE_ACCESS_LAST_ENTRY and add comment about
> 		it's use.
> 
> Changes from V9:
> 	Add debugging output
> 	Jonathan Cameron
> 		Move read_cdat to port probe by using dev_groups for the
> 		sysfs attributes.  This avoids issues with using devm
> 		before the driver is loaded while making sure the CDAT
> 		binary is available.
> 
> Changes from V8:
> 	Fix length print format
> 	Incorporate feedback from Jonathan
> 	Move all this to cxl_port which can help support switches when
> 	the time comes.
> 
> Changes from V6:
> 	Fix issue with devm use
> 		Move cached cdat data to cxl_dev_state
> 	Use new pci_doe_submit_task()
> 	Ensure the aux driver is locked while processing tasks
> 	Rebased on cxl-pending
> 
> Changes from V5:
> 	Add proper guards around cdat.h
> 	Split out finding the CDAT DOE mailbox
> 	Use cxl_cdat to group CDAT data together
> 	Adjust to use auxiliary_find_device() to find the DOE device
> 		which supplies the CDAT protocol.
> 	Rebased to latest
> 	Remove dev_dbg(length)
> 	Remove unneeded DOE Table access defines
> 	Move CXL_DOE_PROTOCOL_TABLE_ACCESS define into this patch where
> 		it is used
> 
> Changes from V4:
> 	Split this into it's own patch
> 	Rearchitect this such that the memdev driver calls into the DOE
> 	driver via the cxl_mem state object.  This allows CDAT data to
> 	come from any type of cxl_mem object not just PCI DOE.
> 	Rebase on new struct cxl_dev_state
> ---
>  drivers/cxl/cdat.h     | 100 ++++++++++++++++++++++++
>  drivers/cxl/core/pci.c | 172 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |   3 +
>  drivers/cxl/cxlpci.h   |   1 +
>  drivers/cxl/port.c     |  51 ++++++++++++
>  5 files changed, 327 insertions(+)
>  create mode 100644 drivers/cxl/cdat.h
> 
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> new file mode 100644
> index 000000000000..c6a48ab326bf
> --- /dev/null
> +++ b/drivers/cxl/cdat.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __CXL_CDAT_H__
> +#define __CXL_CDAT_H__
> +
> +/*
> + * Coherent Device Attribute table (CDAT)
> + *
> + * Specification available from UEFI.org
> + *
> + * Whilst CDAT is defined as a single table, the access via DOE maiboxes is
> + * done one entry at a time, where the first entry is the header.
> + */
> +
> +#define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
> +#define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
> +#define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
> +#define   CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA	0
> +#define CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE	0xffff0000
> +#define CXL_DOE_TABLE_ACCESS_LAST_ENTRY		0xffff
> +
> +/*
> + * CDAT entries are little endian and are read from PCI config space which
> + * is also little endian.
> + * As such, on a big endian system these will have been reversed.
> + * This prevents us from making easy use of packed structures.
> + * Style form pci_regs.h
> + */
> +
> +#define CDAT_HEADER_LENGTH_DW 4
> +#define CDAT_HEADER_LENGTH_BYTES (CDAT_HEADER_LENGTH_DW * sizeof(u32))
> +#define CDAT_HEADER_DW0_LENGTH		0xffffffff
> +#define CDAT_HEADER_DW1_REVISION	0x000000ff
> +#define CDAT_HEADER_DW1_CHECKSUM	0x0000ff00
> +/* CDAT_HEADER_DW2_RESERVED	*/
> +#define CDAT_HEADER_DW3_SEQUENCE	0xffffffff
> +
> +/* All structures have a common first DW */
> +#define CDAT_STRUCTURE_DW0_TYPE		0x000000ff
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSMAS 0
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSLBIS 1
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSMSCIS 2
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSIS 3
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSEMTS 4
> +#define   CDAT_STRUCTURE_DW0_TYPE_SSLBIS 5
> +
> +#define CDAT_STRUCTURE_DW0_LENGTH	0xffff0000
> +
> +/* Device Scoped Memory Affinity Structure */
> +#define CDAT_DSMAS_DW1_DSMAD_HANDLE	0x000000ff
> +#define CDAT_DSMAS_DW1_FLAGS		0x0000ff00
> +#define CDAT_DSMAS_DPA_OFFSET(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSMAS_DPA_LEN(entry) ((u64)((entry)[5]) << 32 | (entry)[4])
> +#define CDAT_DSMAS_NON_VOLATILE(flags)  ((flags & 0x04) >> 2)
> +
> +/* Device Scoped Latency and Bandwidth Information Structure */
> +#define CDAT_DSLBIS_DW1_HANDLE		0x000000ff
> +#define CDAT_DSLBIS_DW1_FLAGS		0x0000ff00
> +#define CDAT_DSLBIS_DW1_DATA_TYPE	0x00ff0000
> +#define CDAT_DSLBIS_BASE_UNIT(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSLBIS_DW4_ENTRY_0		0x0000ffff
> +#define CDAT_DSLBIS_DW4_ENTRY_1		0xffff0000
> +#define CDAT_DSLBIS_DW5_ENTRY_2		0x0000ffff
> +
> +/* Device Scoped Memory Side Cache Information Structure */
> +#define CDAT_DSMSCIS_DW1_HANDLE		0x000000ff
> +#define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
> +	((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
> +
> +/* Device Scoped Initiator Structure */
> +#define CDAT_DSIS_DW1_FLAGS		0x000000ff
> +#define CDAT_DSIS_DW1_HANDLE		0x0000ff00
> +
> +/* Device Scoped EFI Memory Type Structure */
> +#define CDAT_DSEMTS_DW1_HANDLE		0x000000ff
> +#define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR	0x0000ff00
> +#define CDAT_DSEMTS_DPA_OFFSET(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSEMTS_DPA_LENGTH(entry)	((u64)((entry)[5]) << 32 | (entry)[4])
> +
> +/* Switch Scoped Latency and Bandwidth Information Structure */
> +#define CDAT_SSLBIS_DW1_DATA_TYPE	0x000000ff
> +#define CDAT_SSLBIS_BASE_UNIT(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
> +#define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
> +#define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
> +
> +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> +
> +/**
> + * struct cxl_cdat - CXL CDAT data
> + *
> + * @table: cache of CDAT table
> + * @length: length of cached CDAT table
> + */
> +struct cxl_cdat {
> +	void *table;
> +	size_t length;
> +};
> +
> +#endif /* !__CXL_CDAT_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c4c99ff7b55e..84dc82f7dff0 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -4,10 +4,12 @@
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> +#include "cdat.h"
>  
>  /**
>   * DOC: cxl core pci
> @@ -458,3 +460,173 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> +
> +static struct pci_doe_mb *find_cdat_mb(struct device *uport)
> +{
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_dev_state *cxlds;
> +	int i;
> +
> +	if (!is_cxl_memdev(uport))
> +		return NULL;
> +
> +	cxlmd = to_cxl_memdev(uport);
> +	cxlds = cxlmd->cxlds;

This feels stuck between 2 worlds. Either cxl_port_probe() needs to do
the enumeration, or the attribute needs to move to be memdev relative.
Given that CXL switches are going to also have CDAT data, then the
former path needs to happen. Yes, cxl_pci still needs to do the vector
allocation, but it does not need to do the PCI DOE probing.

> +
> +	for (i = 0; i < cxlds->num_mbs; i++) {
> +		struct pci_doe_mb *cur = cxlds->doe_mbs[i];
> +
> +		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> +					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> +			return cur;
> +	}
> +
> +	return NULL;
> +}
> +
> +#define CDAT_DOE_REQ(entry_handle)					\
> +	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
> +		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
> +		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> +
> +static void cxl_doe_task_complete(struct pci_doe_task *task)
> +{
> +	complete(task->private);
> +}
> +
> +static int cxl_cdat_get_length(struct device *dev,
> +			       struct pci_doe_mb *cdat_mb,
> +			       size_t *length)
> +{
> +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> +	u32 cdat_response_pl[32];
> +	DECLARE_COMPLETION_ONSTACK(c);
> +	struct pci_doe_task task = {
> +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +		.request_pl = &cdat_request_pl,
> +		.request_pl_sz = sizeof(cdat_request_pl),
> +		.response_pl = cdat_response_pl,
> +		.response_pl_sz = sizeof(cdat_response_pl),
> +		.complete = cxl_doe_task_complete,
> +		.private = &c,
> +	};
> +	int rc = 0;
> +
> +	rc = pci_doe_submit_task(cdat_mb, &task);
> +	if (rc < 0) {
> +		dev_err(dev, "DOE submit failed: %d", rc);
> +		return rc;
> +	}
> +	wait_for_completion(&c);
> +
> +	if (task.rv < 1)
> +		return -EIO;
> +
> +	*length = cdat_response_pl[1];
> +	dev_dbg(dev, "CDAT length %zu\n", *length);
> +
> +	return rc;
> +}
> +
> +static int cxl_cdat_read_table(struct device *dev,
> +			       struct pci_doe_mb *cdat_mb,
> +			       struct cxl_cdat *cdat)
> +{
> +	size_t length = cdat->length;
> +	u32 *data = cdat->table;
> +	int entry_handle = 0;
> +	int rc = 0;
> +
> +	do {
> +		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
> +		u32 cdat_response_pl[32];
> +		DECLARE_COMPLETION_ONSTACK(c);
> +		struct pci_doe_task task = {
> +			.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> +			.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +			.request_pl = &cdat_request_pl,
> +			.request_pl_sz = sizeof(cdat_request_pl),
> +			.response_pl = cdat_response_pl,
> +			.response_pl_sz = sizeof(cdat_response_pl),
> +			.complete = cxl_doe_task_complete,
> +			.private = &c,
> +		};
> +		size_t entry_dw;
> +		u32 *entry;
> +
> +		rc = pci_doe_submit_task(cdat_mb, &task);
> +		if (rc < 0) {
> +			dev_err(dev, "DOE submit failed: %d", rc);
> +			return rc;
> +		}
> +		wait_for_completion(&c);
> +
> +		/* Get the CXL table access header entry handle */
> +		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> +					 cdat_response_pl[0]);
> +		entry = cdat_response_pl + 1;
> +		entry_dw = task.rv / sizeof(u32);
> +		/* Skip Header */
> +		entry_dw -= 1;
> +		entry_dw = min(length / 4, entry_dw);
> +		memcpy(data, entry, entry_dw * sizeof(u32));
> +		length -= entry_dw * sizeof(u32);
> +		data += entry_dw;
> +
> +	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
> +
> +	return rc;
> +}
> +
> +/**
> + * read_cdat_data - Read the CDAT data on this port
> + * @port: Port to read data from
> + *
> + * This call will sleep waiting for responses from the DOE mailbox.
> + */
> +void read_cdat_data(struct cxl_port *port)
> +{
> +	static struct pci_doe_mb *cdat_mb;
> +	struct device *dev = &port->dev;
> +	struct device *uport = port->uport;
> +	size_t cdat_length;
> +	int ret;
> +
> +	/*
> +	 * Ensure a reference on the underlying uport device which has the
> +	 * mailboxes in it
> +	 */
> +	get_device(uport);

I had written up a long description grumbling about "just in case"
acquistions of device references, but then I lost that draft.

So I'll do the shorter response, but give you more homework in the
process. How / Why is that get_device() needed? What are the guarantees that
ensure you that the last reference has not been dropped just before that
call? Hint: what context is this code running?

> +
> +	cdat_mb = find_cdat_mb(uport);
> +	if (!cdat_mb) {
> +		dev_dbg(dev, "No CDAT mailbox\n");
> +		goto out;
> +	}
> +
> +	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
> +		dev_dbg(dev, "No CDAT length\n");
> +		goto out;
> +	}
> +
> +	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> +	if (!port->cdat.table)
> +		goto out;
> +
> +	port->cdat.length = cdat_length;
> +	ret = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
> +	if (ret) {
> +		/* Don't leave table data allocated on error */
> +		devm_kfree(dev, port->cdat.table);
> +		port->cdat.table = NULL;
> +		port->cdat.length = 0;
> +		dev_err(dev, "CDAT data read error\n");

Rather than a chatty / ephemeral error message I think this wants some
indication in userspace, likely the 0-length CDAT binary attribute, so
that userspace can debug why the kernel is picking sub-optimal QTG ids
for newly provisioned CXL regions.

> +	}
> +
> +out:
> +	put_device(uport);
> +}
> +EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 140dc3278cde..f0f5c24789bc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/io.h>
> +#include "cdat.h"
>  
>  /**
>   * DOC: cxl objects
> @@ -267,6 +268,7 @@ struct cxl_nvdimm {
>   * @component_reg_phys: component register capability base address (optional)
>   * @dead: last ep has been removed, force port re-creation
>   * @depth: How deep this port is relative to the root. depth 0 is the root.
> + * @cdat: Cached CDAT data
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -278,6 +280,7 @@ struct cxl_port {
>  	resource_size_t component_reg_phys;
>  	bool dead;
>  	unsigned int depth;
> +	struct cxl_cdat cdat;
>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index fce1c11729c2..eec597dbe763 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> +void read_cdat_data(struct cxl_port *port);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 3cf308f114c4..7881ce66a5de 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -49,6 +49,9 @@ static int cxl_port_probe(struct device *dev)
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> +	/* Cache the data early to ensure is_visible() works */
> +	read_cdat_data(port);
> +
>  	if (is_cxl_endpoint(port)) {
>  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
>  		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -78,10 +81,58 @@ static int cxl_port_probe(struct device *dev)
>  	return 0;
>  }
>  
> +static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *buf,
> +			 loff_t offset, size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_port *port = to_cxl_port(dev);
> +
> +	if (!port->cdat.table)
> +		return 0;
> +
> +	return memory_read_from_buffer(buf, count, &offset,
> +				       port->cdat.table,
> +				       port->cdat.length);
> +}
> +
> +static BIN_ATTR_RO(cdat, 0);

This should be BIN_ATTR_ADMIN_RO(), see:

3022c6a1b4b7 driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}

> +
> +static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
> +					      struct bin_attribute *attr, int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_port *port = to_cxl_port(dev);
> +
> +	if ((attr == &bin_attr_cdat) && port->cdat.table)
> +		return 0400;

Per above change you only need to manage visibility and not permissions,
also per the comment about the error message in the CDAT table read case
I think it makes sense to show an empty attribute. Only if the device
does not claim to have a CDAT should the attribute not be visible.

> +
> +	return 0;
> +}
> +
> +static struct bin_attribute *cxl_cdat_bin_attributes[] = {
> +	&bin_attr_cdat,
> +	NULL,
> +};
> +
> +static struct attribute_group cxl_cdat_attribute_group = {
> +	.name = "CDAT",
> +	.bin_attrs = cxl_cdat_bin_attributes,
> +	.is_bin_visible = cxl_port_bin_attr_is_visible,
> +};
> +
> +static const struct attribute_group *cxl_port_attribute_groups[] = {
> +	&cxl_cdat_attribute_group,
> +	NULL,
> +};
> +
>  static struct cxl_driver cxl_port_driver = {
>  	.name = "cxl_port",
>  	.probe = cxl_port_probe,
>  	.id = CXL_DEVICE_PORT,
> +	.drv = {
> +		.dev_groups = cxl_port_attribute_groups,
> +	},
>  };
>  
>  module_cxl_driver(cxl_port_driver);
> -- 
> 2.35.1
> 


