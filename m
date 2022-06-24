Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE7F55A307
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 22:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiFXUvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXUvj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 16:51:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B502E51330;
        Fri, 24 Jun 2022 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656103898; x=1687639898;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Sgjv2y6y9BSm5VsHk/3kXF3LV6j+KiqMXg3QRopCjJA=;
  b=evWh0eJYFSEO3ZVGjqBU5HybJoAOmRPjvgfeBkO79WdkdvynKOfoRxxN
   0G+32A2S+ppye+d7RWnl73O2l5EK7rg+qbU7ZwZIq8lhCQaF91wkHMoY9
   or6oOX9+QiRY9vJnKtIxk10YWIwb8FP3kPl6myC+Wx6DXmfWKRE2U3hvZ
   8Ajiu/oTVxTIXk4yEeI3Ei0UEwvusYoNhAZNUlRmKKJGneLpQl/UD2F+v
   amB0NZf9XODB3xJ4rv/j8yXFGcAVKFV2k0NKncyyR/cGgIoPHz497d7pK
   d/5Iqdweutrt14wuzaUoHu66AUch3GYCgP3Lspm9Ilbs7Soz0PEfgqbTB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="345088831"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="345088831"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="645441169"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2022 13:51:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 13:51:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 13:51:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 24 Jun 2022 13:51:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 24 Jun 2022 13:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UR0F5m6iGbeG+fdirUrL1r4gW1bhGqBm9oBzqEgh0jbpJFPTv3m8fTlupZ6tzoI4S9FoJpBPJaQqvO5zUv29Xa4RXQPijwdOTuxV/Pd+kNT5fUQJtuCZFvoQWToIA/zjgPDDaQiSXN3Ct2wKDLhhuBB1zUYGuvB+ZGFmww7P/Tz/Szx7JJ4jnvk9jUnhMfNWkGfE6NvJeoC/lDNYen92YaI6niH8jG8K5k9pPOAYWoCd6dUaQSXzQ6v6CkE/s0XuZZ7MDqy2OXU/+sy+WXdP1NRFp5egvZxX21p8/kB9A61byMnTOkW3pc5wWPYqabEs9SaB7QBnRMor5h1d6OJsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LNGF/f/HK1wx92YK6Ldf2tJhth4U5DP0JA6ETcpQ3w=;
 b=dRLtb0NZElKuu9AibzboWCJGonWLEJplapGE8BL803ufsdmfF9pu3EruxWxT5+qIFeZW1igy36mdNM+fG+eo+m90jGVb7BMfVyHYSt3w5lr/+kbPjA9qJLkXu/CRLHqxVymLy+H2c9VD1NhKYTWzc6j6Dq+EZV/Mtya4cddnNCOvMpzg6wBSHtmnJ9SMosUkbqeG1EKFZavL4NfXJ1eEgplnm2vzq7+Hlsi7bH/MQyPWl4lk2JMhgnJutK18wm0dABzP0znEkjnTHm8i19RNJcfs1Z1xbZNtg1Urz6VN6hlBjZFftmuIgVu7kKTXf9JvAPxEoiE7FZRNpZ0qPjyX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN6PR11MB1764.namprd11.prod.outlook.com
 (2603:10b6:404:101::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 20:51:29 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.024; Fri, 24 Jun 2022
 20:51:29 +0000
Date:   Fri, 24 Jun 2022 13:51:28 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 40/46] cxl/region: Attach endpoint decoders
Message-ID: <62b623d02bf59_d78d629487@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-15-dan.j.williams@intel.com>
 <20220624192501.00003b53@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220624192501.00003b53@huawei.com>
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e04a1ed-328c-464f-9898-08da5623503e
X-MS-TrafficTypeDiagnostic: BN6PR11MB1764:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +i0eynu8UYfD7FfSmVDREF8Y97ld+VH1YxHKV1MWL5BOXDrKPvnCJ8SsMaqe3K7bEeMQDRpuKYpaXRwHi83roN9xA8UmNk639yvpjHxqDyThlUIHIohIYqXnbyYPzxTbyrYd97bG2/aC1U9ZHVQPQm9u09+dFDzHzCuHHKUPtFIfa7oDggwO9xoukWS+H7PNndoZFVBHLQSHhvl40MmmHFB9YNdAVO5FWSX0IqSOHMdzOA6f11puY6kQjqLHekblQkgOorNiFokz+XWkk0+PLVzxfn7dnrQEc2ZKj29Yy50B+Wo0stEFlLZoVin9oHhM9P/BdZeAsGywfecEN9/J19narZ5711Gly3cGL10OzGS3Vg7D1oSeUpNcdvFecMU/CiMHoqCvqvLaFEJlPOy9PCZyiEQjlzQD/HGSMT2+NfvmetWKd6pi+E1TamyAk8O8UdAVR22Oq2Xnv1vCQlTQX3Ex+r8xGJd5b0KZyEAB9FVtcAUAJAUnqYjG3C8WbuwtlZwEtIN7u6e6ur5DDtdqEL7xZIRJzwx99vnfFxlci5bbItqYU1b5DVPeuIFNNldAqU69TLtMjlFyaBaOwY4qjwKGgIaIr5VnnrLmQzco4EgMoK0n7EgpTwqvL3GnZ9dqwfPaD05oYgUk+t/Kl7FNmEmVoGi4b7pCsCBQ+BHypwTjJ2U96WaUgf3AxIPYSfP6uStiO44SJP0lLIXie1XYe/p2r+Q3VG1zf9Tye7//hq6QgWFwwvZJ2I2XdrwoIUmO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(136003)(346002)(376002)(186003)(82960400001)(41300700001)(86362001)(4326008)(26005)(66556008)(6512007)(9686003)(83380400001)(38100700002)(6506007)(5660300002)(2906002)(8936002)(478600001)(110136005)(316002)(6486002)(66476007)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5BvQlrbvd3AE8KKIdOxWChQtB3M+hoEVGqcBhiYqTXsxoveUQ6lfq0jCA96d?=
 =?us-ascii?Q?Sl0CieHTBpAvbiTxIBmy+IcNaDwJpD5Av/G4lA1QX7WYxxxQWsyasYAGOq0Q?=
 =?us-ascii?Q?e9xNauYwPcwpdiIdIzJzsx7gA9/Xr8/4SGZ0Nu6nyXuEfkit8NQk4XlMArT3?=
 =?us-ascii?Q?EgFQgFdpaBJBx9aS414I0KSXRbml2uwNh18EKVLUiNtASpxQZkv9+XkeEi4A?=
 =?us-ascii?Q?rnWKJ1aKrHaENB9h+REIK5oqRhnLTxGYZY29ShuvMcEgqmq5M34yTzWZkjkk?=
 =?us-ascii?Q?/v60vCNGZR+BOZ3XvR/OSfKtT7KXPt3kENunCUGWREVeXZppOoXUOK3soKrZ?=
 =?us-ascii?Q?OpAz7NfRVD7mfhkaZn2gIZPLH8BR5AQcXIhDPz9sWMXT0xCk2zw0wKbp4kF7?=
 =?us-ascii?Q?7wgocZ1af8HyzfTOwtHZCe7CXINK8lrvhxM/yCRpRqDm58Fle5vF12lM9aUe?=
 =?us-ascii?Q?v8+EvlZAWYnP5/0JhADFq73Ku67xCgIzlHmokRZ4eGyG3MvulY0rUdi0MYpD?=
 =?us-ascii?Q?DXzuTeviZvCa/Dem53mXnSvrhDl59bTLfLUjV2c/t61lOqQITdKkr2go0rUP?=
 =?us-ascii?Q?4p+sCf0ir5F3i2qGpmo18tmkFCAn0FOAk3nZqAiBNK131ME3SQ7mjbK2iN7y?=
 =?us-ascii?Q?/QL8YE0ZyXaJihLY8aRJaowp85NpGLb4UHRwpJU+AKL73PoI6KLYwKzhbdmI?=
 =?us-ascii?Q?liCmdNIOkm9RkRcZVyA+Zr2pAHgX12wYZFjAWsRwOQn61hRRL8GqLpbRA97T?=
 =?us-ascii?Q?kUIG95xM8ZO8V8K918185/+dKIplkQbwrpoKXgNve12fC1yWFgpiY3YOpUng?=
 =?us-ascii?Q?LDLSMFl9q7n/pzXe0MWVCSx9Z4TBi7Hmt7Ta1iOoJM+ZIYwpiB0ewGGsQEt9?=
 =?us-ascii?Q?WdJwJ8xCbalmt7HjjrqDJonDlnd82MLSBWeTkrtblRwX9qy1uD8D/LII8EfV?=
 =?us-ascii?Q?vfwCrnvmhAwxYzDo60IhJLQsuVMePbrHr690iNgjFlHZQlGZX9FHj2zCY43o?=
 =?us-ascii?Q?3ss3IgNqI2g3Zl8oPJgY+i5NbVR4oWpeWQme3H5rB8ylApRwdNwGLkdu8rj0?=
 =?us-ascii?Q?F7CzlwwDCBAr2H1cVrtRc6BV3wn4EvxxUxzBSCPoLr1xwtnM5Ek7jIuDHcko?=
 =?us-ascii?Q?2Cb6FuhC7mOxTIcTmuowTdoMDJEWA9M/zVK6vFW2at8r24hP0jbU7xYGBeQQ?=
 =?us-ascii?Q?fbKzME52Cxn1Y6CO/I6/nfVtSDIUFaysUB2oiVl6V9P5g4ROs+M3kMkYrdPs?=
 =?us-ascii?Q?tM+fLTL7nOyeDhpfBtWz1FIJJtxA4YeywfoI8d3dOtAFvuM4ChilndJfgo+/?=
 =?us-ascii?Q?SbC/hiq6PC6P+qYIS+EEmUG96J3MMysv1Mp++VG3oJVrGfLFYzSk2Z1imjKi?=
 =?us-ascii?Q?IDTQVzqDTxIJwqzPAT/wRvs5RShOebjHAJPPw3TO6QSjpN8nMscB7vnvoscW?=
 =?us-ascii?Q?t8XpG/pN+XnKqb5lgiOinvLC4nzePEtbCodpLhbWb6+bWQuy6WjuXBTnBJa8?=
 =?us-ascii?Q?vdkAyQaB5EoiqfgVnePt2+xt+im16rr8ON+4BmZYp17lSpQz0GGJ13QaMHDH?=
 =?us-ascii?Q?23RpODjYt6+GXOOk/dD3IDrNyk4YmLVtLNMkUKt9yIOM/sCLXDVxR1cE1ZKp?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e04a1ed-328c-464f-9898-08da5623503e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 20:51:29.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /orhxML/jv+z2SquF/5zhbc3eJYlsjjdfRUele3GwwJrR/NN8/ttYdwSOm5e2G/BoARCOKCwEFis+NwpD4pHsphNW34lFsdA9yEjffdCsX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1764
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
> On Thu, 23 Jun 2022 21:19:44 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > CXL regions (interleave sets) are made up of a set of memory devices
> > where each device maps a portion of the interleave with one of its
> > decoders (see CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure).
> > As endpoint decoders are identified by a provisioning tool they can be
> > added to a region provided the region interleave properties are set
> > (way, granularity, HPA) and DPA has been assigned to the decoder.
> > 
> > The attach event triggers several validation checks, for example:
> > - is the DPA sized appropriately for the region
> > - is the decoder reachable via the host-bridges identified by the
> >   region's root decoder
> > - is the device already active in a different region position slot
> > - are there already regions with a higher HPA active on a given port
> >   (per CXL 2.0 8.2.5.12.20 Committing Decoder Programming)
> > 
> > ...and the attach event affords an opportunity to collect data and
> > resources relevant to later programming the target lists in switch
> > decoders, for example:
> > - allocate a decoder at each cxl_port in the decode chain
> > - for a given switch port, how many the region's endpoints are hosted
> >   through the port
> > - how many unique targets (next hops) does a port need to map to reach
> >   those endpoints
> > 
> > The act of reconciling this information and deploying it to the decoder
> > configuration is saved for a follow-on patch.
> Hi Dam,
> n
> Only managed to grab a few mins today to debug that crash.. So I know
> the immediate cause but not yet why we got to that state.
> 
> Test case (happened to be one I had open) is 2x HB, 2x RP on each,
> direct connected type 3s on all ports.
> 
> Manual test script is:
> 
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/core/cxl_core.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_acpi.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_port.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_pci.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_mem.ko
> insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_pmem.ko
> 
> cd /sys/bus/cxl/devices/decoder0.0/
> cat create_pmem_region
> echo region0 > create_pmem_region
> 
> cd region0/
> echo 4 > interleave_ways
> echo $((256 << 22)) > size
> echo 6a6b9b22-e0d4-11ec-9d64-0242ac120002 > uuid
> ls -lh /sys/bus/cxl/devices/endpoint?/upo*
> 
> # Then figure out the order hopefully write the correct targets 
> echo decoder5.0 > target0

Oh, something simple in the end. Just need to check that DPA is assigned
before region attach. I folded the following into patch 40:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0b5acabcc541..d52c97e941fe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -765,10 +765,17 @@ static int cxl_region_attach(struct cxl_region *cxlr,
                return -ENXIO;
        }
 
+       if (!cxled->dpa_res) {
+               dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
+                       dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+               return -ENXIO;
+       }
+
        if (resource_size(cxled->dpa_res) * p->interleave_ways !=
            resource_size(p->res)) {
                dev_dbg(&cxlr->dev,
-                       "decoder-size-%#llx * ways-%d != region-size-%#llx\n",
+                       "%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
+                       dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
                        (u64)resource_size(cxled->dpa_res), p->interleave_ways,
                        (u64)resource_size(p->res));
                return -EINVAL;
