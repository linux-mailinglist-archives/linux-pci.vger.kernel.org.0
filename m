Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF56276C16D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 02:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjHBATu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 20:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHBATs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 20:19:48 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501AF26B5;
        Tue,  1 Aug 2023 17:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690935584; x=1722471584;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K/gEktcs9Zf5EqyoG1QBErVngPTygi88mBJsbzdsv/U=;
  b=FC22jCaHC7+CHAoTwOGHhH23IAW9AFZjhwat1gSUt8W6hLkQfIK5UyAx
   V18hLniU/BwItn2RxA3Y6W868Y74ddYu/tR5SPvvOQfTnq/RkFDmffa4v
   rpf6zy8d9K0Y2PPUiuWQx2tJEiz6uj1oHcpa/vzDE0QfGohddzhqAkXSf
   6tM4GdDam4ExLg5ZkeRsLRRS0GCmamMob9JKhdZfjq4bT17DFwg/tC8qI
   1p1A5oMtjBeEu2zT4gtTHcN3d7RTpnztOyYWjJJV5KSUJNFYKn71PFEiE
   F+MmDpU9f8mzssbvPxmEo31suZLeG+RM4RJ0ylgCrWXQIUAEuKUIFJGYs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="373086968"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="373086968"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 17:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794380435"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="794380435"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2023 17:19:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 17:19:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 17:19:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 17:19:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 17:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq9jXy8mZ2yqn+JIvQ3IwSrCN16XbvQTVRYnZSmJMIt3vIY/0SUtTHBfTyZ+bDxuDcnDA5a9OTb41C1zZDkSyE6AawHI4fTwH/GuyjkamPUgLdm9oVTAGXIN7DwPECYPJdRIbQepAR25zPlvdv92JZ9QX76MTMbsXp80SEPT8M3CsNQg5P4npnXezibJnZ42W9AUP4+471UetniIeRaes+TfS7/4/ILWn1JR3VRoospMB6T5ub7V13qCM+05BHsZIxoeisLMni7UbOrlpZqy912xEx05r7qGq7IB0h2R0OjNfYmFpqKLxCd7/j5+jeWegi+eKNELvVKOdWLVO2fZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRZP8JXs4J3f8Ag3Gt89A1fJB8HahCEYhSmSfLHxEXQ=;
 b=AQ2FPsCThlPn2NW2R9iGCqNf8YhlHHiCP1fUSxaMXmHQ11vPRwt0RVdKlCSxQ6fXwM+N7X8VTgv1syXtegrEMEKdSyGTS52eB++OIIljMXuiT3JvW1O0HQAV7Ld51N5Aw+XPJMWlbi2+AQbBj4F5j5gnq9agMbef2SyF9ilfVOB+GZFUGSmzgCz1MZBjRwKGkvLCk/2l8rT0ebrKnuZPlza7jvwFItXQLUIbvcpervwP/fQksvshtrEBVNWkOZGspmYNMmoOCeqUwIlq7QtiggNav+HEY+ku/kTW7vodPlJ8KPs1/9YdJDqVe1WEzRC+P40WjL0pVB0+1xMtUd7f6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7107.namprd11.prod.outlook.com (2603:10b6:930:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 00:19:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6631.026; Wed, 2 Aug 2023
 00:19:38 +0000
Date:   Tue, 1 Aug 2023 17:19:34 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Vidya Sagar <vidyas@nvidia.com>
CC:     <bhelgaas@google.com>, <alex.williamson@redhat.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vsethi@nvidia.com>, <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <sagar.tv@gmail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Message-ID: <64c9a116e75f3_5ea6e2945f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230111190533.29979-1-vidyas@nvidia.com>
 <20230730191519.3124390-1-vidyas@nvidia.com>
 <20230730194026.GA19962@wunner.de>
 <7880aa6e-9fc5-c026-138f-42bef3c48b69@nvidia.com>
 <20230731195930.GA13000@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731195930.GA13000@wunner.de>
X-ClientProxiedBy: MW4PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:303:87::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 36dca965-fe90-4eb2-c0e6-08db92ee284a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reERp5bDM4aIXz+P/2kyqGSSqArtkkfvugd6NGwKpcBAxC2K58CMjLQoGoATqAV+uz0XRHiIsjomLrewQDrsTHOsVYdONh/xE13K726FpIRjCerLRKtMuAZ7KWgw+ovSjwFs+hiIzaGiV3qHELQ5NpQvOxwQ9fJ0xRW+/Suz++AinIJRRw7iqtidT+OSq/0cxmEn1V1SrZy9UjBgkgkRouSyfRlBf+YS9POKBmnGfPpI93I3m7gYtRxF+hzR5IIWpCV/DVD1AqS4aOWwwfG5eIw95PiEHG6QfJ+VqHLa/83D6nj3Q9ySTjgaRBgNUz2X+7c/koYPiGuK1VZ2nTrFJU8l2f9AkIlo1HqDbQ1OOtMu9L53rPYq4JcfjOkoa0GCWJCbTwzWS0RyzFMW1D5znJ7Ki/8ekzHvdD6nsqzJpQTr4uq9bcRuIh2mmHYW7UXGKNvBAE1wt6e4HZX5zEfVIVV4kp1kIH8k2R31tGMGZFOIzVAzZgvFB3ucQcdFs33DXrZ5fjA+uzZXJKwa+o8IMVLtYvYXrUw4lZoWmY946/gex44/IeX+rcpghhSnwB0M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(86362001)(66946007)(66556008)(66476007)(53546011)(6506007)(6486002)(6512007)(6666004)(9686003)(110136005)(186003)(26005)(38100700002)(478600001)(82960400001)(41300700001)(2906002)(8676002)(8936002)(7416002)(5660300002)(83380400001)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D4V6Wga8RKvRZ64eLQ/VCpq2q7a5ZVmBXBVIUjka6GNbqXbS5FbcmbsSsBTP?=
 =?us-ascii?Q?fJQOwcbuegHILwvMn8k5iwEYBxfuPY2Fu25YtEIaHQAdx5cjPbQtFQ25vsr6?=
 =?us-ascii?Q?Bnq43hSyy7/fI/3kt3JZ7mJ8Oqui7Yxo9F0Ssi+V+9fDVgFqSn+mQIYhR84U?=
 =?us-ascii?Q?/nAeKQ18+ElJOnuSgpicEq2Wev7oNGfOADHs3JiiY/CIwLqgHGr+R+2OFX1F?=
 =?us-ascii?Q?w0kiBTeXii9qy66YR//fnnhuW0Sx+9EDxVam0NEheJN1cEBazfdhfYhZC9XJ?=
 =?us-ascii?Q?gTLwMAyhOFMf3YbN2epKoY5n3X7nAGWWR63lbFXvnzrOOSkbst+xp5jwWwg+?=
 =?us-ascii?Q?JlvVIM+MGRszRsb78+vK4hB6TC12s2XlUXhQU8gJs7EUei3O86x3YvECxp+r?=
 =?us-ascii?Q?fwkNsNZTWI6+U+L0sEcS2/ONblBZh7XgP3gBrNrVi7tnu//9DnTGdMaqlVTq?=
 =?us-ascii?Q?foLW1fybFTf+RPQkrSW5EsWUo+N58e0lp5V8pmMx0nB9WI75ofqGvFhXbsJR?=
 =?us-ascii?Q?tj1KPRMR3DSsQIQRDVUWH9XiRsU+k4ifmplJTiE6keH6I5q++8qVU+hw1LY/?=
 =?us-ascii?Q?DzWFih8qhTdsSvMZgJUI1mPv8Laz9lqwAtNNMVHvo27lo1wAu6sVsforLhWU?=
 =?us-ascii?Q?ShX04zTduE4oGTHxTFl7y/qI2k+bH/71za2nG05kpVk83DG+21Gycx6rmcDq?=
 =?us-ascii?Q?mFkh3yZZE/uWHktwySX3k2yhXHBf1/pck6Gxh9/aAyz0FywkLkcXG5+3kTku?=
 =?us-ascii?Q?slJsZvIz9qlAASwJJ/6ULpSGZGFVkfUFvSJ9v5ZJWNoqEz/peD0XMwzfyLmX?=
 =?us-ascii?Q?MsSzmPxNP80PtpNSMv/VEw+P5R/DyyiSeZFI1qYelfLGw+YBnVYZV0QsbfoL?=
 =?us-ascii?Q?G9IoY+a9XEvccNwhIBSWcJJi+1JzZyXgL6BIavQw05KJYU4nPLPaivRWCiS4?=
 =?us-ascii?Q?0CstDlkiYsRLkMGGenn8BGYaDJb6rjWtbo4M7/HaTi/OfCQEu79zTTIXNf0i?=
 =?us-ascii?Q?rkWKyIVcuMMgHWbGR43Kx22y6wIfSYHxG3Iby4cYg2W/p79xG9so2zTi1fWK?=
 =?us-ascii?Q?sgrd9I+0yWkECQ0/vIYwwduiQ8+6vSYrzIPUu9+Rv/FD2U1kciX4qH/cmSWT?=
 =?us-ascii?Q?uJpTkIcUm1uLHEWSylgLV1GPxAEbheuSLV9fG0PSC5/wwvjhjd2mss3mZ7/7?=
 =?us-ascii?Q?JVZN8rLK6Y1MyKo9VKvPCtLkdNXBAo8Dq+LAVtdOutrjm8GY6P4uC5FFPA6z?=
 =?us-ascii?Q?qHxmqSbBxJEmmHwA0B3WkTw2AjfYfvbSp3DSJVO+hSTimNJVvu6NDPcJcJGY?=
 =?us-ascii?Q?T+210ZlvodGw36Zp/XIBf/bu+IfcVi05ghzQ999WwvLU7H9rT2PuoUiNnPw6?=
 =?us-ascii?Q?Op4iudyxvO2SAAPD2CAb3n+mwrjktHv1rmKlNd0sBGjtHYEDt38zaL/hWCnE?=
 =?us-ascii?Q?V5oW4qiyl1MeOx3pe5WYzsm+pXpDYqa8HEGpVEFCDzWjvdbl+xVX3Aw3pbKr?=
 =?us-ascii?Q?D0lpQWd1eIJQU0Ol7+MevHHmcLvdiIocGlt1I4/Pq6DhoZ4JJo1lxI7jPjNF?=
 =?us-ascii?Q?xGL0J7SKyRANI1xLye4Lucqfk7oZMZMwN4FcBGD9tUg7HZxGEIM7Bk6U5iwX?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dca965-fe90-4eb2-c0e6-08db92ee284a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 00:19:38.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZt9x7jFpSCQulJ6sZIoK5NrYqolfpFbRxflEdyob1YjgNPzullR3B78v6boj+87PxVdAFuAcyKqNcvhMj+uHUjJHbqPzaldTeE/S6tK5iI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7107
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ add linux-cxl ]

Hi Vidya, Lukas highlighted this thread to me as we, in linux-cxl land,
are also seeing conflicts between ACS source validation and flows like
CXL PM.

Lukas Wunner wrote:
> On Mon, Jul 31, 2023 at 01:32:27AM +0530, Vidya Sagar wrote:
> > On 7/31/2023 1:10 AM, Lukas Wunner wrote:
> > > On Mon, Jul 31, 2023 at 12:45:19AM +0530, Vidya Sagar wrote:
> > > > PCIe 6.0, 6.12.1.1 specifies that downstream devices are permitted to
> > > > send upstream messages before they have been assigned a bus number and
> > > > such messages have a Requester ID with Bus number set to 00h.
> > > > If the Downstream port has ACS Source Validation enabled, these messages
> > > > will be detected as ACS violation error.
> > > > 
> > > > Hence, disable ACS Source Validation in the bridge device during
> > > > hot-remove operation and re-enable it after enumeration of the
> > > > downstream hierarchy but before binding the respective device drivers.
> > > 
> > > What are these messages that are sent before assignment of a bus number?
> > 
> > One example is the DRS (Device Readiness Status) message.
> 
> Please mention that in the commit message.
> 
> 
> > > What's the user-visible issue that occurs when they're blocked?
> > 
> > I'm not sure about the issue one can observe when they are blocked, but, we
> > have seen one issue when they are not blocked. When an endpoint sends a DRS
> > message and an ACS violation is raised for it, the system can trigger DPC
> > (Downstream Port Containment) if it is configured to do so for ACS
> > violations. Once the DPC is released after handling it, system would go for
> > link-up again, which results in root port receiving DRS once again from the
> > endpoint and the cycle continues.
> 
> As an alternative to disabling ACS, have you explored masking ACS
> Violations (PCI_ERR_UNC_ACSV) upon de-enumeration of a device and
> unmasking them after assignment of a bus number?

The problem is that still prevents things like CXL PM negotiation from
completing.

The conflict for CXL PM can hopefully be fixed in the spec and future
devices, but that is at least a full generation of CXL devices that will
fail to handle hotplug and secondary-bus resets.

One proposal I had for this was to enforce that the Downstream Port
disables bus-master-enable and enforces P2P to redirect upstream when
source validation is turned off. Then, when the device re-establishes
the link and is re-enabled source-validation can be turned back on
before downstream-port bus-master enable is set so that there is no
window to launch memory-cycle attacks while source-validation is turned
off.

Is that something you would be willing to investigate for the next round
of this patch Vidya?
