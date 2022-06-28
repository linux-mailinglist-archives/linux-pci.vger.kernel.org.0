Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD5055EA44
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiF1QqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF1QpJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 12:45:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7481C8;
        Tue, 28 Jun 2022 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656434583; x=1687970583;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NhKjfewExfPtIEFNW16jO4WbBDb9PuMf4kR1mDNu4Nc=;
  b=BHc1q2pNsmVJrOPI7izShhHp8W5qpWKLxd3Kj9jnPK/mt0YPsh+rwDWg
   0lEz/5jiZ/yOkIp2drCOv09Dv2a8y/+gvULXA59GtbP0YDcBAqljlRNbi
   4BtDDaicHdGBfiL1RtQ5pweGW8bn6F26C6OIVKNdyRpHT/0rC71ElPJuY
   RxclVH//VIRUunoH6i2+i6LBTghlo3Cb8cvVzBwem3CNlUC4lM7F0akT3
   Ag4nZxM/2Luq5rYBulSbXlE75AZ1oKy8o4nov7E14rujaE6/GOt5HTuOn
   ejLgss8Gi8WYqAjBkUuEQYNny6VlwVX+3AoKhgBcK7DIvYm7JpcMJealQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282884870"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="282884870"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 09:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="732824424"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2022 09:43:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 09:43:02 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 09:43:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 09:43:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 09:43:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLrGZu/cVnUcjXLpFNvdnK9iLl+s4aXPFo2nqG6SSC5N4C3ynMLNHxcuUxd8DpnX7iQ0SY409JE1pOcxNhqXNkQY2nfdpH7C0lz/qbBAwfvTt+eCu41KxTLqkWyye8xOpdm+GJjTS6rmxBtyxDu/7eGm/4HpMIyidBPzKvcBC35FJGUVU1ZoA/2DtRJpkBGd2bE85IA9s+IVUcgEc64jX68JjVzPaTDc3oKDhbHiMSYMVTFE3HEnec3NjlTdkgF86IjGSSlNf3Kb/i5UfpQ4eXRyC4TXQStUadN+M80fIR+yWg419mABSYW1ulNpp9C9VoEYspA+m06YmoGMqcmE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zigG1cuGNyHSd88AQ/Mcs7ezmuQbxIjSnBfulmrWErs=;
 b=hzE9jxiG59/cdKDbqPWipZkhXwF1Nym1KjXNI2MAHXvDLa8894hGwH5/1XRMOsz1ePHA6cAtykYAUkd5y1mjVVQzrtV9vxJHuX/ib//IgHw5W/nkxffosjyFF3sLeQ0J5uzPYNQU+lTzl/3k27MwzzLBLxX8tYvrtOKBqLdz8j08jYWh0I4WKv9oe4KveQIbHnYiA3hxPO+JTO0bKD8CYnkx0fanMktcdfoDLRCG20I35vxW0BsgkxqR3mpkusSQNP20oCZfvJ96wue0i47QLQxz+MeCpnzqcKZYP5GWW8YJQtG+XSUE3Bbw420H75a/BAiVGKq2g8Fv6MSLLkMSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SN6PR11MB3248.namprd11.prod.outlook.com (2603:10b6:805:c4::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Tue, 28 Jun 2022 16:42:59 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 16:42:59 +0000
Date:   Tue, 28 Jun 2022 09:42:50 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 5/9] driver-core: Introduce BIN_ATTR_ADMIN_{RO,RW}
Message-ID: <Yrsvilq7/JILlGLA@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-6-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628041527.742333-6-ira.weiny@intel.com>
X-ClientProxiedBy: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 523c7070-38ee-4a57-be9b-08da5925429c
X-MS-TrafficTypeDiagnostic: SN6PR11MB3248:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2Rp7tuHdOIx0LQZAdKdO+dhvYSH4S/VEo+gmiBkocv63H68GBjtdNJDGUs0h3bgPXIYYASuIwHzNUmh5iwNu/rl6rFpaGo+bdU7J1LXu6lZu9l1bHc6BuC95KsesBGe4Z6mgLsy3a5JwQnOnFLPY3d/xOQ7r3RsVSNKg2G+9UQGNmX4d+ZHX+ea6/5fNo4Uqr4xTVJ1esSTUaG69aBLEvQorzE07OTY076NVHL6z0rPsRB9/9Af+9d7GkxnycigGPYmUIEY9RyNSFsqZgXhXEhc+HBuylDeBvYgxlW7QH1IlbU5dspVguo9hl0eoahxDMc0DPkUxloUMHECiqvSe4/zcj/QuAI7pczDRDN6NBl8ol8eUY3dkRAIfJHJFY6JoTjaob3QPnoHJ99Z9LdWrmtkn+eOTqTkV2lh5AilReGVkx07pYsnFWqMn59H7xuZWJDcy0Qi3DdBcTBLo0M9QPdonr9AO+9b9IEbmiRA07ftDHku/yV3n5qbbMdJkWOCrApBbn7W7vPNC7G98dhTgm6bCZQ327pYIa+R9w+ukzmjkfghFwkc/PTLexpiKeX5lLFHwGUXZM3qzbeJTR5KkUclAlq6EaOAlTrV1dK2nHLcnePVtPQOknXBaDdLFLjg+juPnSEZYRGRHSOD2B2JrI5HzElaPPR1dPBVDn2mxkzSbGrjUpO785AHKqKYtaKWURa28B1Fy64G+havyC445Qwbl6YLWwj2hTjuyJ98FbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(346002)(376002)(136003)(396003)(44832011)(66946007)(6486002)(4326008)(8676002)(66556008)(66476007)(5660300002)(6506007)(316002)(110136005)(54906003)(6512007)(186003)(9686003)(8936002)(41300700001)(478600001)(82960400001)(83380400001)(86362001)(6666004)(2906002)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KMKosWEtmjIaaonFfK+KVuFErbGI4ADQ0sCN+Dl7yWcJ5DbgH7tOdT8eD4yf?=
 =?us-ascii?Q?S7LWr1BD4o8SEG9CWaOJq//s8Z1rIMO2CPqmgmObLLZoJ53vSBiTA6UKqxh7?=
 =?us-ascii?Q?WEaM1Ox23u/Rcf81I6IOzK90P5oQHze9JQoIuoGMFhUg6Wj//mfrU4UObQuL?=
 =?us-ascii?Q?i6eoVMDCOwFiO6b3X5fNtrWNNqTOJuynTUfBGBsk69kHcFDPPgISSSKgBisj?=
 =?us-ascii?Q?cUI+usCMAfsjvmUkBd5ZTBrZQ4A3ZkyIxI2QUTczM1CWf8tXjrgk0r1VYf2g?=
 =?us-ascii?Q?Iy0y6Xey/erTlnrX9gviwpRycX8NydB5poC84Mbk83KSQ7sEDLKWqLTHFmdg?=
 =?us-ascii?Q?Z3+1TTBsHVZvnOSSwauA0kJephJUxJ7NSpEFIUPLIyqFZSeOkFE4VWH6M7Cq?=
 =?us-ascii?Q?Eh7pVvBDf7setJpgJNIco5jqiGShKX6POdvznF/k32KFpT4lTvEruP9uQd6D?=
 =?us-ascii?Q?XUK+1IqGyBDTX9px3wXmL7JOeO3nMlp7IPf7oo1mmj9LFS0gsatj36DmDqet?=
 =?us-ascii?Q?VF/TE2m611hJPDTtaWZqOkVffgUJhohbGABUo8Xjs9A/b3w5t6pacVytT9lH?=
 =?us-ascii?Q?f72B7KXslfrX/HjAsUNWNjpHaAyCtmdfr76u9tYdqn6lJDviPdX1ipR2B0yM?=
 =?us-ascii?Q?SztnFS/TWxNJC11w5W7riXSUsfH0m7NcxpllR8MLftdtSPFDOpSF6spmdhSl?=
 =?us-ascii?Q?g4aDd2WacflOOSimC0QNDs4DcTsTXb2pPeZgIyFxjPWeMiUko7DUlSRLPkMb?=
 =?us-ascii?Q?sgJULEVcfHtR/Mce+acUBQ4CDplR5MHLve6eXWNprXQtuuNWw8djrdWo5IMw?=
 =?us-ascii?Q?GxGf1Gq5vqS2Klx33hT4K3xc+ScB7Wf/DAMKdEuqHZk+WtiBCuLIzGeKMUrv?=
 =?us-ascii?Q?2b6QNoTkv7E75nifxfL5KN8U2RaDg43OKmmoMeORD8N85TjUBDvNX3tsU2QN?=
 =?us-ascii?Q?36fBlv6xqwxFJNFO/AaZg5uAYtDu9ktf1YkRS3dKWBwlAJmk3bVK91nLkRGl?=
 =?us-ascii?Q?dcetd2gy9Mfa54HAv/2e5Ys6Fe3EYhv4ybKFtbGucE5vPjtBWzn+dNKN3zBx?=
 =?us-ascii?Q?eCt/TwFMs+IsheQ4qWmERs4u3sGutU9yPoVsQJEW/rg747SzZ+VbRKjU7ELM?=
 =?us-ascii?Q?9wzNRoWCHNrLfm+sMiOtz47LGm1zKmplSfBeY8Xe47vS9ieOLJmG6ngv/bJo?=
 =?us-ascii?Q?GOc1hjai0OcEuPKousroEpJWUQRKzVgx4dLFYVxLRSmSt6nQ9v/f8j94bSnH?=
 =?us-ascii?Q?13OSPB1bAISiKU7VqFjlaKiFghwwAyyZhy7aeU3wRotfTVA7soj3JhGEQlNf?=
 =?us-ascii?Q?Dv/VLUOt8utWaxOR7RRRCsSCm/OWtaAZmnBAG5PBufo1+wKXnfpMuer8JRBQ?=
 =?us-ascii?Q?HQHNJH0jeerJum4IlxAjfmm+q3pKs/x1tLKMvlOSRCV3AjNEBX5ACygUPry+?=
 =?us-ascii?Q?ta/Wf/zRhdy+rfgeeBuiYscE1ftyuuem7RkNkV9PObFAqJqJfWklb7P6H1NJ?=
 =?us-ascii?Q?RxUB1A7JpoGR03QHAgaBe9Xy6uprPf2KYAVnTOzQw9SbrfzYEJ9wPB8fB7UR?=
 =?us-ascii?Q?+aPGk1cuin+b5+07eDMeFw8CrYHAzk6sBW5Tm0W6DoWYz/GXKMXSslngVhxV?=
 =?us-ascii?Q?MfjhPmerkbGzvr9FpURnujICk45SrNOnQW9tBQuzJIUA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 523c7070-38ee-4a57-be9b-08da5925429c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 16:42:59.3514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZj7Rz4wnIDz9vF4S/6lZjNroyrIhhU24ZDe1Nn4m5AxnHPWeDf8g+x2YpwSDHpTq3FLEsOemx578VK9DlB4/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3248
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 09:15:23PM -0700, Ira wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Many binary attributes need to limit access to CAP_SYS_ADMIN only; ie
> many binary attributes specify is_visible with 0400 or 0600.
> 
> Make setting the permissions of such attributes more explicit by
> defining BIN_ATTR_ADMIN_{RO,RW}.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

This should have had a suggested by tag on it.  I'm hoping that Lore will pick
it up with this email.

Suggested-by: Dan Williams <dan.j.williams@intel.com>

My apologies to Dan.
Ira

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V11:
> 	New Patch
> ---
>  include/linux/sysfs.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index e3f1e8ac1f85..fd3fe5c8c17f 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -235,6 +235,22 @@ struct bin_attribute bin_attr_##_name = __BIN_ATTR_WO(_name, _size)
>  #define BIN_ATTR_RW(_name, _size)					\
>  struct bin_attribute bin_attr_##_name = __BIN_ATTR_RW(_name, _size)
>  
> +
> +#define __BIN_ATTR_ADMIN_RO(_name, _size) {					\
> +	.attr	= { .name = __stringify(_name), .mode = 0400 },		\
> +	.read	= _name##_read,						\
> +	.size	= _size,						\
> +}
> +
> +#define __BIN_ATTR_ADMIN_RW(_name, _size)					\
> +	__BIN_ATTR(_name, 0600, _name##_read, _name##_write, _size)
> +
> +#define BIN_ATTR_ADMIN_RO(_name, _size)					\
> +struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RO(_name, _size)
> +
> +#define BIN_ATTR_ADMIN_RW(_name, _size)					\
> +struct bin_attribute bin_attr_##_name = __BIN_ATTR_ADMIN_RW(_name, _size)
> +
>  struct sysfs_ops {
>  	ssize_t	(*show)(struct kobject *, struct attribute *, char *);
>  	ssize_t	(*store)(struct kobject *, struct attribute *, const char *, size_t);
> -- 
> 2.35.3
> 
