Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69C356D085
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiGJRdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Jul 2022 13:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJRdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 10 Jul 2022 13:33:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0348B491;
        Sun, 10 Jul 2022 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657474420; x=1689010420;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WxQ40lgJ4Ui/VE+yK3ONfkevo75mkcMq1DlWZiLvdzw=;
  b=Hl6plxW+3O/7bcmmtojFZq4xYvVQkc/4g/4CTCoj0qhSDznQ6uNkstjw
   /mpmV2ify/VDClRdTgv7WIOTvJTlUrIr9A3pFF+30+QyHP8t30703w4un
   ysNRmgaQBE28Y4zoKntbBzlEjztfv714E6BFgmWqVbObPNHQItS3aE4ay
   KGKjlRob8TVPYuJ+7VhbQHNz9oOIHnV5CSCvUWQjntmrWhROeaZeylrPD
   BZihDqImj2B2NxqFSE0v1ZVlTBCwyU4Qbm22NwgIn6OJiy9eP5ubLLJIM
   RTYgIOV0hkuBHwMu4aOp3Y5su4tj9o8xlELackJ41/juMSaw2YpYbMj6E
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="346214500"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="346214500"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 10:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="569511995"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2022 10:33:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 10:33:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 10 Jul 2022 10:33:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 10 Jul 2022 10:33:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 10 Jul 2022 10:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlQLeCjB8ZWew6GSlElBsGqj7H8Lytf07Q6jtr68iWrLiDa74Xnow2EflClhC0YBOi6/sHHPqjTOBoALh/WsB07pYL3zM/qVc/GGcEZm9Gg26uv2dqettP0UXnXntW2NqiF/ry0Zs5CQvSIQ07Lej0pXrws4LfZJtzT02yh15PsZvYkKX6IeE4gs76OTmrIE3sd55x9N56njTTeo6Ocgge/jsUhYmK39LxA8ZY11aqWIFSdjUyqCu1WSR6VQY2hbr2vPal+4NE5oLuORh0o9Q8Tab3Ligls+vss1KfPk8aAB5CHFqXCcuRR7dzv/yKzK7syNhEwdMchlxr4bF+U+sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cErPpZFbJXhjAc+XPzg9DwL3dlb1jrRLMtfHweUuRsM=;
 b=eC2qNFmNG5N3ZUqi2Uenrc/VcVKxIIAZbYcUajY0DD5L+zjJWkYKGsktqabvt1uA3rpj9cwHyakQV8gbab9Hkxqfn2N3bPMyPdRjkLwVVqy13Ub0b6orJ7P2CvcT+o3bhBBXL6R+qzROSfFEVDOXOSi26iqwSFq0fs0V+tqGRiGGyTYsGLmHxD0WsmkIRz+Y1GEpndOXits+e7g2XN1P+Cpq+2ECAnnu6J/QRpHynfgQ3hTyX8sSued6Y4xXL8Hyi2DgQrqpV0rmyllD/kKo2bE8tBbJp7hagzVU+CP6K/Z3EIswe0sBwnNRVa9J4w7N/5CGqwyA8f/i4+i9AVAEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR11MB1815.namprd11.prod.outlook.com
 (2603:10b6:903:125::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sun, 10 Jul
 2022 17:33:37 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.026; Sun, 10 Jul
 2022 17:33:36 +0000
Date:   Sun, 10 Jul 2022 10:33:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 24/46] tools/testing/cxl: Fix decoder default state
Message-ID: <62cb0d6e3f45f_3177ca294f@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <165603888091.551046.6312322707378021172.stgit@dwillia2-xfh>
 <20220629172239.00002671@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220629172239.00002671@Huawei.com>
X-ClientProxiedBy: CO2PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:104:4::29) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78904a20-57a0-4198-a4c9-08da629a51b7
X-MS-TrafficTypeDiagnostic: CY4PR11MB1815:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkjubqsGL4ZsP+BNqlI02OHWWzqfMkFiyuwh9xIxM4DAvoJw6AqFxsOy24INYJJYiq5xJ/X9Sagpi8yXBh0h6BCyu3LFcszUTa5Zngi+K7S/INLojZtYTBJCsCqsNVMjJ8SSBQpiymHiBWvZpghVMN/zjJ9VmdB6L7yeaMdoIytjvrZTrjyelsmtfkimQuablzLpjf0STl3ywbwYnva/o32j6kU+ziFJVZckB5zr4kYH3YLsFxUsrwsUy9MlfgMr0M+fV09qSpj+17d3JO6FS/JdUB32jK9kKsXJ0akyZqSTQsAM3YN9ezdUwTpU31SrUYh34qeNij9WuzEV/MKzMofnNvQJeeCduOlGIi/cmXwKjzNlM+pN7kPJsVg8TvqLtln/glyX3wnqbEMR3jYOSYYMGtCJkInUTpNs+2j3Bw3cohvrfuMC0pOXuFBhTdolFd6eClOQAGRcVHHaxVVgAKmpGiajhJcjcDpUcZh4TI0Foy3rM/DjnKiSivb7WXu79wJoYmf/mcj5mTNdzixqP63/eu9O0JjL6Sa/ZU8vPKjg/9Vd2TwinrbZ7QLz/WdlG0gjf8DwflJfC414oJtmex4QS4YtB+9aJGrNrJCz7/51nyITs+eX/p8QoEyHY0sU1i/JBb7XAewAeZTXdIZULyaF9sc8ZSogH1dNa5fi3R2EhQ4k0prmfbDpKQHayFPAszGEKtxMYlT+vke5OfTyl92b8TB1ZvI+XPejfVvf1erQ2PeVRVJv8Rh5Kfk0c0vXxb6+drSibd0STn7zjCRWTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(39860400002)(396003)(376002)(2906002)(6506007)(316002)(6486002)(4744005)(26005)(478600001)(6512007)(9686003)(110136005)(41300700001)(5660300002)(4326008)(8676002)(66476007)(66946007)(66556008)(38100700002)(86362001)(8936002)(82960400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3gGAQTEJIVHh+8DEy48sIdhHV23enqDkRujwPVEhlqRg6qmgtvlQ/Va3Ulv3?=
 =?us-ascii?Q?a0IuZZkGfY81Tv46lmHDI468l9sc6ZvehSVWiqecvm8SrujjH1/aazKDh8Ch?=
 =?us-ascii?Q?hdfzyI1GMev6dB5PP7Wz7xjrmC/vvYNjBWFZwCiaIk3C9at0d7ZAQQB6pQHx?=
 =?us-ascii?Q?DjnZ66diarZDaZxfcPmYFpmEtC8imfNVBpigmWqQHQcQ61wJAmZ85lRnX0Pd?=
 =?us-ascii?Q?Q1u4SmnVG13jNXUy+PDaNhry8v3G20MiXk5ZC2U4mmHqpZ10TshPj/JAH9T+?=
 =?us-ascii?Q?Vks9PPVEA5BIg8uAPfPXnTmAcmEYbt1N3MVM/gnF5ujCmyq4XqTEoj7GiLdm?=
 =?us-ascii?Q?Tsu/GrJ8lFbIrXLMh5Vpi6P9BP5U2K3blK76dzLOqrd5P+2mxLnbX6/eCkPF?=
 =?us-ascii?Q?1cHMEeB0gSqeSxINzzJuDonbJYseBRmkz4mJ+fzRITbCW/yE+NXsl6RdKhqt?=
 =?us-ascii?Q?x67IoepNUbD2yB5Svm0wf4Z2qK7PEG/TwDla83un6ZYdgVWL9orYPmabEfGb?=
 =?us-ascii?Q?S6vcCwovi0uV+PWc0HwaBZ/mltHY/WE7rte9Cu4mn5FloEWp4NuIO2mMKQ0n?=
 =?us-ascii?Q?6X6VnN7n8nOgj+JUHA8C3L/PqSEe0P9lfhoL92UAYU0GbB1j1dl1UxbWl+9F?=
 =?us-ascii?Q?pQi1K+jJFtsJtT+ObxKgPduG5yPgqTP6E8ZFYFrPo13iHWDP4CQxrOsWuV3t?=
 =?us-ascii?Q?YbqSY3Y/2L8ApO13bzJ3LYJNsD+6JH45wgBy4vJ/9rUIX/zvhBuSBycLdkMs?=
 =?us-ascii?Q?p233J0tSEoMlQOu72OZ3iqTeEX9/zeM18Fly+93ZsYQ9eAPbPjymG0KnOU4z?=
 =?us-ascii?Q?+SIz1M9Xb9pJDxF9Y0OTK1gD7fIzXYCxE690kfeJjM4cW6QrJIOP9WAtInU1?=
 =?us-ascii?Q?W0/pkwnXaX6HKNLdBK/QNuTDziv8loIun6rhi26QTY5EqI4nqnX+PLWtYdbQ?=
 =?us-ascii?Q?Oab9KSFQiCMLV62ZTOwVvAvHPuaqUOmWiPt6sZHhPz0bJM0zqUSf0ltqUfvC?=
 =?us-ascii?Q?ya4Lleypa5os0771YACdRKcS9wwSpVOolB0E4xnAwDgY1e1U1wucmFxR4dtC?=
 =?us-ascii?Q?eEGnboR/u9P4I+BGVCe97/Y0WxpabL7s6xpfvv1ggkWBasjK0YQQgW3ss/Ih?=
 =?us-ascii?Q?5b5xcA8wNs3bj0FPToahdPxr+AAAekKGnoRcbVjyGCc/M1fEt4yw2Lz/Ub7d?=
 =?us-ascii?Q?ft+G7s/GusAjFAJReBhkYsYtFPFi9rPhthvh0bRQbn+apllf+c5uAoqTb9QT?=
 =?us-ascii?Q?gxwjiFYnE/KoTrTP/XYowivkr7CAvHLWNomSU62QKzXk9P5BGgNs7Sa+uI2D?=
 =?us-ascii?Q?s+FOxh7wEoKKe38JOSY5wWId0UdQ6rMFh5tn9Ns2smgzDbkiIe+EzhAmY3AS?=
 =?us-ascii?Q?FJnwa7lDJH1KACxWHHA8GqBff79m+1xl/XRvRBxonBRMKnD4foULnGyul40t?=
 =?us-ascii?Q?Yy5nk/Ur74a/CDVnMEhmL6jERQ5EuztInE98WBFOYM5pAIanlwNCY7Jna10f?=
 =?us-ascii?Q?Bf5uvmGvB8f6LQuiWh8f4//Tr9hKNcGqTjisGPcsT7Jt66fQulfr3d4+ownc?=
 =?us-ascii?Q?/L0RxEKEF/yg+oDemjUXeMWZvDzwHbB4kHS9pcB5nbQh79pQUQFLFnolm92H?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78904a20-57a0-4198-a4c9-08da629a51b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2022 17:33:36.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M63hHiHIHy+FO8D17rPkYPHgY3TzHdGBhp3hTrDiYeI7n0n0oPzoLWY2zhu4zmjwLd7J1sskhg/sB5kT/ot4oyrPBPrUnSHwTnPDTZzKxmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1815
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

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 19:48:01 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > The 'enabled' state is reserved for committed decoders. By default,
> > cxl_test decoders are uncommitted at init time.
> > 
> > Fixes: 7c7d68db0254 ("tools/testing/cxl: Enumerate mock decoders")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Whilst sanity checking this I notcie we have
> CXL_DECODER_F_MASK but never use it. Might be worth dropping...

Yes, that definition look useless.
