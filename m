Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4A558D6F
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 04:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiFXCrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiFXCrK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 22:47:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22356F8C;
        Thu, 23 Jun 2022 19:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656038829; x=1687574829;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j8Jqg6GjtO4oyOLK+avUMz0EwIR0SoGPj9+PpgnsmgM=;
  b=RGh/73iVN5tlSkM0tFYhoFdLuDUrmt5ow5oICpHmJZO/j98/AAJphF+C
   LuALqULZpjVFYROdBLKexksMhDrLkJjjyRi5V8m07SiZ4rwsII1+IaaJ9
   rIn35BO1fneJhazFixninqNdc/yHFzXmIg88cbpOWd2Vh6tHVMSxjdOF9
   Dr7POPmY6b0oBC3i52eIgtFhymLwp+/5oktKQRUu63PjaT8/cdG7NA0vI
   ujCvuzrVEGbPud5FRN8cWBopcQvvoSpHniOwTG6KzV4RHjHOsYhtDwXXq
   MkHG/sIoahTXiv5nqjTRB6/yUCEuTq6bh7T43MPzVHjAA+Md0WYi6mL3A
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="344898466"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="344898466"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 19:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="834933943"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2022 19:47:08 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 23 Jun 2022 19:47:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 23 Jun 2022 19:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJsplBNCTyu7lPG9hbUF0YU5fdzUzAKj93MLDkkEW5ME4n/1qlj3AAOxL09x6Em751SGTVFJEbwnC+AiYXvufv16FI9snOQB4hKxYfS9SXah+kgUcaybnQ3j4Ug9f5VNS/FRviUsFaVZ50pN/kYSlec9mxKw0QeF47I1VOxkZreNH1iH8i7v9/bmWNACSeVkVI5lHv/nRCvXoCtNNTcRkxXEDx9TDhhiJNBUI3ZpuQSvCIQe+g6BA2mieOmLvSZVuBk1QO26/7c1owAw+CR/uGQUWOM385M+oR149F0U9qimjfYl1fICB7FNHC1huXdGC76G7HX5EFcNbrvO2dxOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltLtuWAepkVbs+YARMmGIhmlgZHwq/j+hzV5HABNb6U=;
 b=OGEC/0PpFMbqyxLaVcd/3DOV8qSj/RomFTdRac7f1l8ZKfDx/TzSU6VBln2t2he9utMj6H3yL0vJqJkCr/cqGS+MUwmTHdjxdYFl1MR8ZIuc3aXAQ2d5e2Ewc9WRXy+bqfZEDBCIvIfIhPcI+o7ApwD2tevRkkxxztafTK5SjXYFrrdW307xWpvYckQS9JsHbrYkwHujK3dl0SRxMQZ0Eqd4qz/9DqAe/QKwSa2dtqBEUIoTNe5+GinbCIY++BkHUuF/7THirmuxuL4AG+eLa8L13Fr0r0avegG2cMh1DDy6ZsQOMy1MWdFzyohS7IQF8d+0qUAV9WlDF5GUt4pQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Fri, 24 Jun
 2022 02:47:06 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 02:47:06 +0000
Date:   Thu, 23 Jun 2022 19:46:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>, <hch@infradead.org>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: [PATCH 15/46] cxl/Documentation: List attribute permissions
Message-ID: <165603881198.551046.12893348287451903699.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
X-ClientProxiedBy: MWHPR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:300:103::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54fb4d80-616a-40fd-fb09-08da558bcc09
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuOeaAyERcspGDgoQ82ElP1o63KC6Ijh9wff4v/zC5wEJCQLFTSjzgYWbICkA13DYzXqzMQI1vRmbYIv2hsC2aZqtpnbgSKIMfEYVdDKurmoxmUB4GCmlZBKmMDGVcgXbm4rNOHBLssPhjiZsOZmzuj9VmOyvgaamuteoM+Yn7F2QXUvIUTKZFoHza5mAC1X9/cB9mcuQqv/S4mqUkFBQJv47IQTqwABSxXBJ7PwptHBZp8m+XbR2e1dytQZd6eysfUSIl8bEeHXn0bzbiRXq0sc1FiM6g95UxDvoGOlAtXx2btmoQIRdbeiYlXRSttERjcZMa3C4rVwf5oZxGQQkMhXNp1BqWSQaU2txuudu5L2MKpXa+7qzD/UhjrJHeHKQSCwH+HBgBKkS5kJImI/sR+U4Ua/R+esTTr8JnJBySFilaqw5RcVLHnUaNnhiA0b0swG0zmcJ1mDmmlCh31vMD3QxL19C9z9iEx8EdTJ2iTKtZzMPMXUFQZuLk+zMQbLs0DcBBPH4+7IvTv5oFt/9nVZaKRQmne942u9cjhvfoAZ4WINLzdAGgedVy4nn9yqwzi1lO2pxkiJbtKDXFfg52lCyRDFem/OdnP6XlZg2sqRkvOf8a/JNx9NK4Dlef/p8VDUrVOXwQdwLQGIjSK9YlpSM6VyWKNZ3kGsOTdHcXvkZF03c/+GdgN11euYBH3zlsUbxTD2xbzxxiEL+0TOezlMxzgKxQSRYq1Nc0+kl7wk1iKvyKJlLJHxPR/huX3y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(6506007)(66476007)(66556008)(6666004)(9686003)(82960400001)(33716001)(4326008)(38100700002)(6512007)(66946007)(41300700001)(478600001)(316002)(83380400001)(8936002)(86362001)(103116003)(186003)(2906002)(6916009)(6486002)(26005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EiDz7bUNoYuS3qUzNJ6PAkvC+DF+nvRG8NarTwRAFU7haA+tRGQUOhyB6T5t?=
 =?us-ascii?Q?jFv/MSa3HFR+S8tw6KPEGNDKHPDRI+xhU7+ynDGQWu1VobMp1IPT5ERidr8v?=
 =?us-ascii?Q?Se97HJIgi7JExzu4Mxmq88z/BFBrSIGhTp1LECTfJDRVecABAAoAAMeL27r2?=
 =?us-ascii?Q?9WvNgm+eA+VrXt5RJoUXem8hdE6Fcu9E6tLzqvJRdxEcrPPPHWRjRuAC2dRy?=
 =?us-ascii?Q?8MO6sfLxud+wONBJNpfse6EVA20Lmi9ptxP3uCxHETi1mHowpHchniwem9tE?=
 =?us-ascii?Q?P+mBg2q62gmp/ccnat9hmtodfcKnnD/R1i4a4hMZuiiiAYaMe9CqUKhgZJSl?=
 =?us-ascii?Q?oKlQ2F/LeYqbFlpWZBFXyWDSS03qPon4WT/AOJQ0MpHFliXiv4WMAFsklz2G?=
 =?us-ascii?Q?uWmJM6gpGG4x/txRNvxdAnfgNzQcU/kqz8y5D7FQ4TF5qkKKD85dT3gZJrje?=
 =?us-ascii?Q?DXXuhIto4Df2FcA4B6Yv4DjW6PEjRh8dZRoqAWcmku6odw3jVMUx8bQrmQ4P?=
 =?us-ascii?Q?YWSqWGwBM45b6/gUp3BXaf9LehYZw1QM2zmAbaky8MBT0mvZkQoNRto3WdMh?=
 =?us-ascii?Q?L+T/Ord+V63bdfg6U4c/ayfS2DMO2UxE/OYf+iIDfQiZ6yub/RRETjZzbMSJ?=
 =?us-ascii?Q?Ekdx69rBr2Ag0jSyvLDEeS6+yJRUvnmFXskSTo0vSXW3cvLiDXOLjtdip/Jg?=
 =?us-ascii?Q?y2aE5L8n5Zce2tqyOmbWmra60Q9FUCMHGh+g3OQDDKUZI9ZCCGKI+OmYC5vA?=
 =?us-ascii?Q?gwiDYmbfigCaypOpbpR0NGg2+BzJwB19qE9zOqA1QKuQQ0Q5LVQlly8/+Hne?=
 =?us-ascii?Q?0YB6L59feVsFwomSb+PyotwaKE+GNImDR8cA2I9kFuB/zia0PsGqD8xGlEge?=
 =?us-ascii?Q?qaqILKXlqr3YOjvbqJ8LyQhGCTyQRiPlosj5TQT8J3zI9yfUCyV13C+oGhA4?=
 =?us-ascii?Q?rzCnBS6Ah34/fUTRSt//xwCCFO9bMfTCPPJM809cyauWbFfog7p5p9s6X3/B?=
 =?us-ascii?Q?4LsVEqhgOkf0Y6YeXmBe9gndxUDJo3+hSzTOBih2OwX8NGISZ1bYgHpIyIUc?=
 =?us-ascii?Q?aDzQc7XxOagvrcYtlaOygxocIU716mAddekd5FKaiI1FK0IRhSK79rotYZO1?=
 =?us-ascii?Q?QPl8zLGQ1TiD0k1u9GuEFz74YeseW1rTqr79RCE3JK53iMB3Vq9+tUICS+8i?=
 =?us-ascii?Q?Oc6auRuiYzfug8IpKsDsxokaKFyFghqMBCoNvO3BS+WthzdXY9H1F0WzZo6E?=
 =?us-ascii?Q?D2y3G3F8hWKHLadilVf/if7QpDVg3OSA6sDZTrKrRVnEPQMmN90Yo8g7Js2y?=
 =?us-ascii?Q?nN2rDsO2nDzxXjJC8wyrZXF4Jww52X9jieLD1i0fWVB/gr/ds9m5EJufNkPj?=
 =?us-ascii?Q?XoeJuuat3opalED2hnp0kyJU071l62vEkbR83Y9H4QMZQmWOnm6svXKBUdkO?=
 =?us-ascii?Q?RrjOa9Nmk/DKihC/GrgbaA9qKwHUSlMzy3nYmaWypOt66ZiBxyWzLKQL8KJP?=
 =?us-ascii?Q?6rr+yHHQi57Tu8a+zg8stQURT6pR8lgmyF0cfW1d1B7HWORPZh6hr8n/LB12?=
 =?us-ascii?Q?HCMcNyNAIuqo7k7YhLlWzJphqnUU5clr6d1b5IEbKXYAhXhCZzIwjrw8k3Ol?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fb4d80-616a-40fd-fb09-08da558bcc09
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:46:53.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp9DMtNJdb4WKoXdIVHxvigpOL/5tFl0x+qLKn3azzH7FOy3NZ9IVeTzDOwky2rpX8hG8e2mIgeWcA+fHvZVyOU1tEkHWr//D1HHpZCseDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2789
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

Clarify the access permission of CXL sysfs attributes in the
documentation to help development of userspace tooling.

Reported-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   81 ++++++++++++++++---------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7c2b846521f3..1fd5984b6158 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -57,28 +57,28 @@ Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		CXL device objects export the devtype attribute which mirrors
-		the same value communicated in the DEVTYPE environment variable
-		for uevents for devices on the "cxl" bus.
+		(RO) CXL device objects export the devtype attribute which
+		mirrors the same value communicated in the DEVTYPE environment
+		variable for uevents for devices on the "cxl" bus.
 
 What:		/sys/bus/cxl/devices/*/modalias
 Date:		December, 2021
 KernelVersion:	v5.18
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		CXL device objects export the modalias attribute which mirrors
-		the same value communicated in the MODALIAS environment variable
-		for uevents for devices on the "cxl" bus.
+		(RO) CXL device objects export the modalias attribute which
+		mirrors the same value communicated in the MODALIAS environment
+		variable for uevents for devices on the "cxl" bus.
 
 What:		/sys/bus/cxl/devices/portX/uport
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		CXL port objects are enumerated from either a platform firmware
-		device (ACPI0017 and ACPI0016) or PCIe switch upstream port with
-		CXL component registers. The 'uport' symlink connects the CXL
-		portX object to the device that published the CXL port
+		(RO) CXL port objects are enumerated from either a platform
+		firmware device (ACPI0017 and ACPI0016) or PCIe switch upstream
+		port with CXL component registers. The 'uport' symlink connects
+		the CXL portX object to the device that published the CXL port
 		capability.
 
 What:		/sys/bus/cxl/devices/portX/dportY
@@ -86,20 +86,20 @@ Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		CXL port objects are enumerated from either a platform firmware
-		device (ACPI0017 and ACPI0016) or PCIe switch upstream port with
-		CXL component registers. The 'dportY' symlink identifies one or
-		more downstream ports that the upstream port may target in its
-		decode of CXL memory resources.  The 'Y' integer reflects the
-		hardware port unique-id used in the hardware decoder target
-		list.
+		(RO) CXL port objects are enumerated from either a platform
+		firmware device (ACPI0017 and ACPI0016) or PCIe switch upstream
+		port with CXL component registers. The 'dportY' symlink
+		identifies one or more downstream ports that the upstream port
+		may target in its decode of CXL memory resources.  The 'Y'
+		integer reflects the hardware port unique-id used in the
+		hardware decoder target list.
 
 What:		/sys/bus/cxl/devices/decoderX.Y
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		CXL decoder objects are enumerated from either a platform
+		(RO) CXL decoder objects are enumerated from either a platform
 		firmware description, or a CXL HDM decoder register set in a
 		PCIe device (see CXL 2.0 section 8.2.5.12 CXL HDM Decoder
 		Capability Structure). The 'X' in decoderX.Y represents the
@@ -111,42 +111,43 @@ Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		The 'start' and 'size' attributes together convey the physical
-		address base and number of bytes mapped in the decoder's decode
-		window. For decoders of devtype "cxl_decoder_root" the address
-		range is fixed. For decoders of devtype "cxl_decoder_switch" the
-		address is bounded by the decode range of the cxl_port ancestor
-		of the decoder's cxl_port, and dynamically updates based on the
-		active memory regions in that address space.
+		(RO) The 'start' and 'size' attributes together convey the
+		physical address base and number of bytes mapped in the
+		decoder's decode window. For decoders of devtype
+		"cxl_decoder_root" the address range is fixed. For decoders of
+		devtype "cxl_decoder_switch" the address is bounded by the
+		decode range of the cxl_port ancestor of the decoder's cxl_port,
+		and dynamically updates based on the active memory regions in
+		that address space.
 
 What:		/sys/bus/cxl/devices/decoderX.Y/locked
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		CXL HDM decoders have the capability to lock the configuration
-		until the next device reset. For decoders of devtype
-		"cxl_decoder_root" there is no standard facility to unlock them.
-		For decoders of devtype "cxl_decoder_switch" a secondary bus
-		reset, of the PCIe bridge that provides the bus for this
-		decoders uport, unlocks / resets the decoder.
+		(RO) CXL HDM decoders have the capability to lock the
+		configuration until the next device reset. For decoders of
+		devtype "cxl_decoder_root" there is no standard facility to
+		unlock them.  For decoders of devtype "cxl_decoder_switch" a
+		secondary bus reset, of the PCIe bridge that provides the bus
+		for this decoders uport, unlocks / resets the decoder.
 
 What:		/sys/bus/cxl/devices/decoderX.Y/target_list
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		Display a comma separated list of the current decoder target
-		configuration. The list is ordered by the current configured
-		interleave order of the decoder's dport instances. Each entry in
-		the list is a dport id.
+		(RO) Display a comma separated list of the current decoder
+		target configuration. The list is ordered by the current
+		configured interleave order of the decoder's dport instances.
+		Each entry in the list is a dport id.
 
 What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		When a CXL decoder is of devtype "cxl_decoder_root", it
+		(RO) When a CXL decoder is of devtype "cxl_decoder_root", it
 		represents a fixed memory window identified by platform
 		firmware. A fixed window may only support a subset of memory
 		types. The 'cap_*' attributes indicate whether persistent
@@ -158,8 +159,8 @@ Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
 Description:
-		When a CXL decoder is of devtype "cxl_decoder_switch", it can
-		optionally decode either accelerator memory (type-2) or expander
-		memory (type-3). The 'target_type' attribute indicates the
-		current setting which may dynamically change based on what
+		(RO) When a CXL decoder is of devtype "cxl_decoder_switch", it
+		can optionally decode either accelerator memory (type-2) or
+		expander memory (type-3). The 'target_type' attribute indicates
+		the current setting which may dynamically change based on what
 		memory regions are activated in this decode hierarchy.

