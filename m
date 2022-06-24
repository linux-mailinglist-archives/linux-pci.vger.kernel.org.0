Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADF655A4BF
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jun 2022 01:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiFXXVh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 19:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiFXXVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 19:21:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764F189D02;
        Fri, 24 Jun 2022 16:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656112895; x=1687648895;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JdJvLwpuIha8FOp2fPKHZHx26GHZ9v39xg0FJK2ZqzA=;
  b=eeOaW9v2dV2CXFhl90DWXYbgUYjLOsYiEs/DTVYohQr3xZGpSSBAPecr
   6ulWJIFudX/rrKZ1QPCQ09Om902qUwk+4wzfqwkstI2VnpVYhgW8yobwQ
   MiF8ee+oKj/5g1bdElQKL6/6zepZqfPCxC69eJwcPt4hPgfx9KIDUhDcl
   uu5En25I9aReVdpeKCFXt0W0OCA6O8nLw6sn/nUcY3lfQSLPx2jOBCHvr
   wdIR1DBHmBcbfrYSvl9YjqC/jSbt6BhVymJEJeoNLFyv9vkuTfR7ugAZC
   5cI558q76P+EN+DW1GJ2IdkbraMSous+8rAIGTYWFfhxhDY9SPLY7wXvC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="282204668"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="282204668"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 16:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="593431105"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jun 2022 16:21:34 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 16:21:34 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 24 Jun 2022 16:21:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 24 Jun 2022 16:21:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 24 Jun 2022 16:21:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hg+WKOULfnVlH+O8GVCUI3qEl4675dwfdXWW3B//moDdNrd0PrRhMJq0OpEGke/AM1rZPZ2lA7/t1AB8V27va+dRkNWQ4oPJpf8qZUQcHBJZFjPyy88KzoXGa3RfnJaYFmRrbNFRMXz9K4cgAiPX8LRxoaSBL3RxcX+FH+Ylql147VJB1C9izsBlEefVB25SalaPbthqoBj36tIwEzApQP71xnWcB+qdl9q4nqRUpdoGBMsbAJNGVG6+eFwZZeFRs2sIU8PZyx0hSkS2UNVQPSRUKud4Qf27eWJxgV8LiwN/aPvA5Eo6jWqaZJqKiIKBPOU0ikty7bvl6R4Rynj/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXd/MvGjcPCmOEFqsgiU4gFShe8vrZ18MfZx4gbY2tU=;
 b=TrvWDFWrNMqR/tGMhagwjoeoLUOD8kj65N6ldNWuWxz/dUeIZROMkgvdH3Kb0Kd8fOKTPauFlzuW1SIwi+CVpwxnIUYSip1q4b7WiUsoCHOIheWwqXKaVd5wi2khQBjMAdJQEKfVpGPnyoSkrw7jg+FLN0pZXZxZCtBfmMnqFTh2zQRK3rrDbQOAcfBS8BAXe7ovCZBRfJ5ktVzy5ZS3YsMUrZQqPNkmArxM6sw+SwDx/pROmB+QvYp+vzQlM36HmwKiwaN5Quit7wrrf9KYc6eS6MsL2MSM3CtseJmLJYD1Pi5g8/c46+imAbstvnoaAQPcd9C6Jw3fmHv74ZqxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5213.namprd11.prod.outlook.com
 (2603:10b6:a03:2da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 23:21:27 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5353.024; Fri, 24 Jun 2022
 23:21:27 +0000
Date:   Fri, 24 Jun 2022 16:21:25 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 40/46] cxl/region: Attach endpoint decoders
Message-ID: <62b646f52c6b9_d78d6294ce@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-15-dan.j.williams@intel.com>
 <20220624192501.00003b53@huawei.com>
 <62b623d02bf59_d78d629487@dwillia2-xfh.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62b623d02bf59_d78d629487@dwillia2-xfh.notmuch>
X-ClientProxiedBy: MW4PR04CA0323.namprd04.prod.outlook.com
 (2603:10b6:303:82::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89303716-3225-4e89-8b95-08da563842fe
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5213:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7ITrw5YHUn0WxgPOxaXdYkM7mVvG7Ix50Go/znE/ArXA6MEPDVOwCF62oL6/RT3WNnxG4r9EVQhTF9JqJSGGfMJMT8OT2p6Rz7KpiTYK/FQj7RNtQHFaZxnMSH0TDkc9qcFrMgtPhrm5ih/DW/vY44h0OcUBS/puEK9rKq0C8/ZFZPnubZLmADvd9O7K5mQehVvneWpBKeJACSG/kkZ96TWJA2+BoOPSbiITuxkOpNGAzOXeh1gn/X22HfCAZ6ceRhW4uLAi66YcmQUk0fhUiJiStNOpunBH77KAZW6rgZSbRYcoM/CVSY3kicl7PjtxivmN//Bw9ic+Qze+WsSofEk9QzrqGQDoio1FtIPoQtKcrVZ/e/UfKyT8zi7dWD78IkL5bAxK1I3ObV0KAzqok0LA7xPnJQoTrjY8I3P+8FGtTRNZ+7lfb+vAMQBOL6zdH+9kyeQKSngo7EfWDszUsh94vgz+LI9EuIEwLYEgRufbjISLZS07jlvCuaeWpPHJF5fcuIy82pMc0CMQnb672sxN8wZF71GpZICDAFN29qmkinbLERP547XjxDO8voxv/7f3PguK7xpANF5IbJSa+KXnDVmlv3yyja9z1uEmmWhVmugx/ZiHMOImd6i+9ednXTOFtCcIKQKX7aPvpRGYHufrxetiX+ejU6zSC64vAvx3JED2ItYrAh/jaT249xbwo7jHmWD7ULOQCGS7L/eDMqJzmBrrz6PhhDx17VkarhpWpSg938ZnCBhMewd/Ji4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(396003)(136003)(376002)(8936002)(478600001)(4326008)(5660300002)(82960400001)(2906002)(86362001)(66946007)(8676002)(66476007)(110136005)(6486002)(66556008)(316002)(6506007)(83380400001)(186003)(6512007)(26005)(9686003)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdtI+AWQhmSXRJ0xECg3xypMDiwZ+WeB9XrE2vMUMd2Oo71gvFOY5JOD3sdy?=
 =?us-ascii?Q?wNDbl94HEelAEdjvrMCqPreBfXW3rIPTB2UgotJlDoesVDEKnNdNaN4vdZ4A?=
 =?us-ascii?Q?w74S+j1g1AmUhiDkCab7uIW/eqIQKyrLY6qDx2njBdHJ9pDIwXzH25F+ck2f?=
 =?us-ascii?Q?0rSFWae2W34COVVFYpGBdpBe7+JqaVm82X8Cv0s16LMKYNW1ogqxL8lNcyF8?=
 =?us-ascii?Q?NkX2KN0E0qeuKUkBYBuiFWQtqV2XPDK2xpHM+OR8Bfmj3Odsvz1Ymlzq7xAd?=
 =?us-ascii?Q?SksGiGQblPpikcuHkTEJA3YbMncrkUpFfsuyq8aSYg042O5P/C4cjii7Ok0T?=
 =?us-ascii?Q?HB5s+oxqLWPxQwymsPia6LzXVbDYqOjE47CF7PVL0Gzk+R8K6MpmOJbGc69V?=
 =?us-ascii?Q?0mmIHcYy0kVhlK4GLZ/WSMSRxYrnVzRTe6CX6xiUMgdrLUwvQFgXiKZC1BhP?=
 =?us-ascii?Q?7fEBoasaQVAocsfOJ/1891o33V2hXs9ofjapRWjaPeppCbsyqtdSc/J4BS4o?=
 =?us-ascii?Q?t6imX0MS0uOM5HAwQ9TS8zc09eEaI1JV7K0B1HDLC3GTTEYhpWjUg77knIDb?=
 =?us-ascii?Q?E2IamGoVrN0S+S548uw3dgySgnlPhgPMyDLFociXEl4C/ZYUgThLHUwv5N9h?=
 =?us-ascii?Q?I1v8DEnHEJm3Xmdc4aSetLkZGlOaLh1ikAIcKNXEdNcVyAAGz/Vvi0AF5wyR?=
 =?us-ascii?Q?luBj7p8bJSigIgukRQs5q0EQmAlgiVOpE2Soj1W8IldVhPs0ne+R3+5LjvJ3?=
 =?us-ascii?Q?0XEOMlGkQVAMM1EBJZAJNQjxcLEgWXioJrMwcDn7mERB7qqJNN4mQ8lbsvsO?=
 =?us-ascii?Q?I3vnCub3Z3phauElo4XTSZ7/0XL8tbKhVIAxHMnaAofEr1KF/ArgoHWtyzF8?=
 =?us-ascii?Q?vr1Elp46/DC4lipYWaGKv4OwZN8s0O+s9Qbm8P8ED4/lBHz6NLRduZb2tPwt?=
 =?us-ascii?Q?CLVzIY0VRZm2K1wUOHcVcy/nHYyyhlrP5LTx1Za36uGq/moj8IjPC1CulnZu?=
 =?us-ascii?Q?tciHU1wkA6cSNhq5wdqUY4GZyN/noIuaNDtpTOCXRStmohuhrYN0djbNWxjg?=
 =?us-ascii?Q?RUxcWcs47YF2/nJvCBc6lWcrj2ffNnZte7i5B82fFLi6jA1GbSilma85hnie?=
 =?us-ascii?Q?eGLJAZNEkxmvvAzJwsJF0CnROOmER3l/VprvCY2ytXuNk6JzS++1sdlr1POr?=
 =?us-ascii?Q?xM5UtfuDQspYDq7sriw75V28ByLpjIH1RpKIdgjlzxPnLvWW4hE2zQdp8awa?=
 =?us-ascii?Q?HN7vFLl/Bl8GzSyK4xDf8BBFBQI8gDcHBy45lOGuY+b6VF739qck0iam0Avp?=
 =?us-ascii?Q?E07Wxnp6kKZEnKIXAdCCEcKGzOIjlf4gIjyAAfsm2AaDhFsQhNvJllrbqAfv?=
 =?us-ascii?Q?nCt5H+gKmIBDO17BN0nNR4M9kdbaXyuIJsEFWg2+LAnl9yLt63vHk0lPlAus?=
 =?us-ascii?Q?D1QCPlNi65kwKrgHQt5eaagp6bHtD0XnT+VQH4BUuw7hPo0TdoKwi1d8num4?=
 =?us-ascii?Q?PHkcl4hvXrn2LO0k8CZZn88UegQijft4cx5SMj2vNYVLFqk+w40lsravwnRV?=
 =?us-ascii?Q?Qtf6pZ+1uMMy0HItIptlMWzioCtCBOClN6yDFvZqslvK0dsO7DwGKn/i+fhJ?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89303716-3225-4e89-8b95-08da563842fe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 23:21:27.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju1YJui86Kc+ip97qHEQEHuR5m17LF23QALeU3zB3uye8tQK35OwgKio9rxRZhFAm5tAJs9ySQd9YzGzY9W2q2zrvUNSplY8Gz8kVUPIBX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5213
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

Dan Williams wrote:
> Jonathan Cameron wrote:
> > On Thu, 23 Jun 2022 21:19:44 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > CXL regions (interleave sets) are made up of a set of memory devices
> > > where each device maps a portion of the interleave with one of its
> > > decoders (see CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure).
> > > As endpoint decoders are identified by a provisioning tool they can be
> > > added to a region provided the region interleave properties are set
> > > (way, granularity, HPA) and DPA has been assigned to the decoder.
> > > 
> > > The attach event triggers several validation checks, for example:
> > > - is the DPA sized appropriately for the region
> > > - is the decoder reachable via the host-bridges identified by the
> > >   region's root decoder
> > > - is the device already active in a different region position slot
> > > - are there already regions with a higher HPA active on a given port
> > >   (per CXL 2.0 8.2.5.12.20 Committing Decoder Programming)
> > > 
> > > ...and the attach event affords an opportunity to collect data and
> > > resources relevant to later programming the target lists in switch
> > > decoders, for example:
> > > - allocate a decoder at each cxl_port in the decode chain
> > > - for a given switch port, how many the region's endpoints are hosted
> > >   through the port
> > > - how many unique targets (next hops) does a port need to map to reach
> > >   those endpoints
> > > 
> > > The act of reconciling this information and deploying it to the decoder
> > > configuration is saved for a follow-on patch.
> > Hi Dam,
> > n
> > Only managed to grab a few mins today to debug that crash.. So I know
> > the immediate cause but not yet why we got to that state.
> > 
> > Test case (happened to be one I had open) is 2x HB, 2x RP on each,
> > direct connected type 3s on all ports.
> > 
> > Manual test script is:
> > 
> > insmod modules/5.19.0-rc3+/kernel/drivers/cxl/core/cxl_core.ko
> > insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_acpi.ko
> > insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_port.ko
> > insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_pci.ko
> > insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_mem.ko
> > insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_pmem.ko
> > 
> > cd /sys/bus/cxl/devices/decoder0.0/
> > cat create_pmem_region
> > echo region0 > create_pmem_region
> > 
> > cd region0/
> > echo 4 > interleave_ways
> > echo $((256 << 22)) > size
> > echo 6a6b9b22-e0d4-11ec-9d64-0242ac120002 > uuid
> > ls -lh /sys/bus/cxl/devices/endpoint?/upo*
> > 
> > # Then figure out the order hopefully write the correct targets 
> > echo decoder5.0 > target0
> 
> Oh, something simple in the end. Just need to check that DPA is assigned
> before region attach. I folded the following into patch 40:

BTW, as I'm finding these things I'm force pushing the preview branch
with the updates, so this one is fixed as of current HEAD at:

1985cf588505 cxl/region: Introduce cxl_pmem_region objects
