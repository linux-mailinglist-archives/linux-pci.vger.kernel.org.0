Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B416F9DCB
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 04:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjEHClj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 May 2023 22:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHCli (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 May 2023 22:41:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145C73A87;
        Sun,  7 May 2023 19:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683513697; x=1715049697;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AIMFKiveuZFASO/Il+k5d1oXB0kCPuNo29EYiWI12pk=;
  b=frjafN6h5i4VoaLIJ6uLEYp7H1Sr2tP7Dvpa4oQH+8I9KUeoWUx5Gckl
   ZBzePLt4o79KYZpKt91+/Gc0I0KlILI1nDDuTAXVj8v7dkwJnOQ7Gn73E
   6FeffVbxNPxsDuVEKcS1GqDhP/27CJvK5iWr7FQfW28v7pQZdCW3Jo5zi
   pFg4vDAqY438yMQKM0LwnEmX9YpKtehZWEU2BK29pMDh6mM+jS+3q4ku3
   eLcg0CRO9TdsZv35AKZb+u2HRbckD1gG8GrMg9l2KheIFRRxJAqqsuNe1
   h3Lulg/KaUYTgLwCfZO/ivr6ePJyti5zyUX0oArDOdwyRfQE0LqNnTRR/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="415096986"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="415096986"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2023 19:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767899356"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767899356"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2023 19:41:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 7 May 2023 19:41:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 7 May 2023 19:41:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 7 May 2023 19:41:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 7 May 2023 19:41:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwBSs2ZG6z8shYGUMhHxcl8cqRFuYufxudiaa1+LC9o1syTm0zBclHiJ8YEhb1Y3TteuWUVtwf13P+AotGf9dxefKt8JIXXBCPv0TrfH9LfagbExrW+5J2P6L1+Qbxvfug5RkNZXZEpYla/UgoeNYdSJM8gAIstTN1JInz5LCJL26etbxs4r0iVaCVIMDj/Md5pnEENQyeEQDSaVxVxWvxAyp41mY5jEDWAtr/mFishP85NaGRHOAFXeCqa9CGRhHH45mHk1QTkFnGOs4U65zNFBpo1FzL7KotbGqxwbIcGsKI9tjjghl+NxX9pdmpsy+MjGBniwDVLlzMd28u9Z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oPPX9uILWkhIngAjt9kt48o959MfqT37hqW2T3IIms=;
 b=XtnDm0uYzrwAux25KfnxE+n+rRssgeXYEgRu26LyVLgrvwJ/3Tvnjj70FWG1Du7Ae7Ah8jT9X38MBJz+6zFhfqZU2L/OC7KMZDE3mADRiGPlomts89B5EHVw1DgMyOxEvciOilqW6IzMNQ8uluxTsnG7bio4brMVzOsjPI3tfXxhjfACg0j0k95ybG+XtLozaKIQ5SPHvpdiNEsuEBBMSyDe7oB0S9F0ur2c3YkGwuDvp0mEy21AHBc2cZoQepkhE903g9wz9N8DtGx4PdlRkSFdLHUyqa9MzkEAyVaPrBO8AZuFQDiNekqgMEu2wu1gWrVic60vYsJtoGuH91dj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6113.namprd11.prod.outlook.com (2603:10b6:930:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 02:41:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 02:41:33 +0000
Date:   Sun, 7 May 2023 19:41:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Huai-Cheng <hchkuo@avery-design.com.tw>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v7 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <645861555f7a8_4513a29424@iweiny-mobl.notmuch>
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
 <20221216-cxl-ev-log-v7-1-2316a5c8f7d8@intel.com>
 <CA+2kVq_L0_OGLR5VXL1sHDeGa+RPTt-Kj9Ajnc8j82jsi2XM7Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+2kVq_L0_OGLR5VXL1sHDeGa+RPTt-Kj9Ajnc8j82jsi2XM7Q@mail.gmail.com>
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edb2d6a-6b6b-484e-9651-08db4f6dbbef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHFzr4o71cFt3IIIDU9CXzQLDEAbHABN+td8lJ++0o/0YIqXQoeLYEISaMDNbBBznIo26ULKZmyyrmp1/OXjmvkns3a0oKetSvtRiXwmhBKw1PVYo7GJkWWmG0L0U42ui7t61VNg+O5Qa4Ciglo0CWg9n/XXGNp1yjvg0P0p6bAq6xZLuVtw+LUYbXxrhpL3Kw1b2SDme9Dqq50FycuzfjxN5zw1v8Ptz8vkw/6viUDkUy7djsk5U2eyhV6DlijcqGjNEaUzjsvYXTKeCSFX6q6j8jAp6kNRwVxX40Qyn+rPH7HaVfEqu6qrtH15g336OAqw2X2FxKq6OCo6AZ2p6CbXhcTJ7+Nt36UlvN9vF670B7hDYFZhuOKXYJOddYciSXJbQTqhKy9/oi7naqLXZaL3mSnaWKHJEj4kT5ddSfcvXEqdJio6Q5ETJ/I1qd39aLo8jTwMPhtJ/tigXzJZNPfW5Qw/2FFBlyByMcECh8G7wAw7Rtsa12j6ypItJrJ5MEACOa2d+s9F0il51nAvchBuexJdVU3S0j9Glq56vNi1WEU+zvF3uSVGFCI3ewyf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(66946007)(66556008)(66476007)(4326008)(478600001)(6486002)(316002)(110136005)(54906003)(86362001)(83380400001)(53546011)(9686003)(6512007)(6506007)(6666004)(186003)(8676002)(8936002)(5660300002)(7416002)(44832011)(41300700001)(2906002)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU9TN29xaU9DQWtWSldwTjZYNW9iUDdPYVJEcDdOUkhyQmE4ZWo4VGdZeEo5?=
 =?utf-8?B?aGU2OU0za2hUU3R2ek5kWTdXcmNXcnk1OTRjM3Y1R3lBSGF4UmlsaVVSOHlC?=
 =?utf-8?B?dTUxdk81bEsybnh6NkZXbFZwa2Nrc1lOK0h0aVlINnZKR2VvOEdRcDVwUk84?=
 =?utf-8?B?WnZiYnZuZkpEUkxUTTRadkliOFBsUWoxOS9UaHpuaWtoM2VXbm9LbEM1aGRs?=
 =?utf-8?B?ekx6RHFRRXpQNjhMYVVYREcrc29VRzQvZ1UwMEhrYjMydXdOQlg0bFdhQ3Va?=
 =?utf-8?B?bC9FUVQ5WGVxQkpPUTZEbXVtdXVDT0UxcVorSXJVMmdBZnB0SW9jTTkyeW55?=
 =?utf-8?B?V2NmZlM1Zkwxb2FzVmVPSUFhWWVZMTI5MEkza1B0WWM2UFFNbVJwc1hHejV6?=
 =?utf-8?B?MHBRZW1uUHhZelBUa0ptZ0w3NlNscTBzS3crQmZPMWtLRHRYVklXTXEyZlBR?=
 =?utf-8?B?cE44TVhrbFB3RlhLd0J1ZjZLZ0pjWnBMeTV5K3ZYejdWSGdnZCtBa1g2akxM?=
 =?utf-8?B?eStwTnRXeEZFbWZna01acVVWOTlFZ2EyNFB0VVB4RXBtaDZIanlRK1JDNHVG?=
 =?utf-8?B?ejE4c2Y1b3BLV3NhYldKVXFOem10ZGxIZk5TblZPSk5JTS93bUFHTExhVkNY?=
 =?utf-8?B?UkNxSUJ4S0ZldklFdWVYdWV6K0g0TjdFejdXVFBnQkkyTm5hTytHcVJVQVhS?=
 =?utf-8?B?VVllZGhzenZOS0x5UDVGb1YrbUZCWFliVWhocm1TVVB6WXl6WUFCTFFTR1lU?=
 =?utf-8?B?V2x0R3FtYTZPNmYySWVyZXZTZE8ycjJGSlM3TjFyK3lPdVhiZ1UxRjRMOW9l?=
 =?utf-8?B?SmdiU1NhYUlFVk1wUlNOSTFEVnkrMTdWczFZU25rQnhkUEZGL1NSV3pvWjdl?=
 =?utf-8?B?MGYyc0ZvSkFyZkxHZzVDYW5VMFdGUVhTc1NEb2VCRUl1WllMMyszZG8xcTBs?=
 =?utf-8?B?SDU3bVpHbytXZ01kaDhMSVFKajFyNkNtUmVPZFVoOHcwSmZpQmNhSUxtcEJp?=
 =?utf-8?B?STdtM0pDZ05nTEU2cTlTTTZlSmNxZStHMEYvS2xhTTVxZDRoSExkbVQrL1or?=
 =?utf-8?B?V295eVI0R21YWjlNaHliMkZ0MTFZaysvNXJtdEJOcGZGbzEwTitUaXdsYnZI?=
 =?utf-8?B?MlJoSTI4dEJzdi9EOUpkbm9PVW85WEEyd2xqd0J4ZlJRM3M1ZnRISFZTOXRI?=
 =?utf-8?B?aHdaeWh2VkxwdkdrUnY3U3lJVEZCVERGM3g1M3cxc1VMSEFDUDZmOVhwd3lv?=
 =?utf-8?B?Q1pvMjNUdit4NXdkRmxDYVNNWUlmYk56L0tUU3pDZ1NLZThQZ051cTlSZzZW?=
 =?utf-8?B?RHhQTUF1QnVHQ1RDbzlPQXNaMTJIdGo1OWEvRXhQMG5yK1JFRWk3VDJiaHo0?=
 =?utf-8?B?TU15aTlySVVrUGdvOVBPRnNqTWJmSHl3QkxoTS9lYS8rakxHRlRyU3VWNWRR?=
 =?utf-8?B?ZnBZOS9WZGdIVWkrb0FVTTZJRW5ScWQyRVhKYytQK3Q3Z09IVGFMOHR5eG83?=
 =?utf-8?B?VVRneEJyNEZNTGs2MThGODh0cFBkOWtWd3JhNUZ5ayt6NmpUTmV2ZGQweU5T?=
 =?utf-8?B?dWZubVNOQmpVWXBmQUFQdXBwYzFpcUpub2NJY3luUXYrK292S3Y3WFVuRDlG?=
 =?utf-8?B?NmxDdHJYNUNUTnpoUi9LS2U1K1B5OWlsNFJZY3lxM2RRaEEwYnNTNjdaNEgv?=
 =?utf-8?B?YnhMajhLRG96TTlKd2hoR2FsQkZzZ3VxaVlzZXNPWlcxdFdqNjc3a0M3UE5V?=
 =?utf-8?B?L1crcFpjdmYzZ0lxL0JWdWptWDNVZ0Y5Tnc2dkEvWFV3eU9FTGYxRkd6a2Mz?=
 =?utf-8?B?ZlV4MHlzaGZ1Smh5VmszQkNlbEllaXd0Qk1uWmxKTzMwSHRUcTM2TmhEaHBS?=
 =?utf-8?B?M05ZbFAvNXMrOVdudS9Tb201cFlPVjdkSExiNHE4MVdJT0NCandXT3VPQmlL?=
 =?utf-8?B?OS8ycGxwOUw4V1MxUDluSkJETEFPdFhIMW11eVVQWTk1akQ5WGNYMEdtUzVU?=
 =?utf-8?B?bStXOGJieTU3TGlrZHg1aFYzMitVLzZLT0VldEJuSGhLTDNzRlI4dndUYzlX?=
 =?utf-8?B?T2hkR1lzNXlUS0JONytXbFRGVmhobkw2eUpEOEJleHpINWJVcTcxSjJqcVh6?=
 =?utf-8?B?WmR0SjJRWTdiWmFXSkhKTVkzVDVNeVl2SEdQeDkyTHorc0RjWldWYjArUVFr?=
 =?utf-8?Q?L+zIS0U/1/quosEeuSAvuQua2RQn7i8Q3dHdHvuXwrcy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edb2d6a-6b6b-484e-9651-08db4f6dbbef
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 02:41:33.1018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDTX86lPkdjjbjM82h6lqjEV4vSJTS+GJNaJkSxvmXwweFrgBzG6Iqdri8tx2iYDzJGpKxiBYgBOJFAMdsmEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6113
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Huai-Cheng wrote:
> On Wed, Jan 18, 2023 at 1:53 PM Ira Weiny <ira.weiny@intel.com> wrote:

[snip]

> > +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > +                                   enum cxl_event_log_type type)
> > +{
> > +       struct cxl_get_event_payload *payload;
> > +       struct cxl_mbox_cmd mbox_cmd;
> > +       u8 log_type = type;
> > +       u16 nr_rec;
> > +
> > +       mutex_lock(&cxlds->event.log_lock);
> > +       payload = cxlds->event.buf;
> > +
> > +       mbox_cmd = (struct cxl_mbox_cmd) {
> > +               .opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> > +               .payload_in = &log_type,
> > +               .size_in = sizeof(log_type),
> > +               .payload_out = payload,
> > +               .size_out = cxlds->payload_size,
> > +               .min_out = struct_size(payload, records, 0),
> > +       };
> > +
> > +       do {
> > +               int rc, i;
> > +
> > +               rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +               if (rc) {
> > +                       dev_err_ratelimited(cxlds->dev,
> > +                               "Event log '%d': Failed to query event records : %d",
> > +                               type, rc);
> > +                       break;
> > +               }
> > +
> > +               nr_rec = le16_to_cpu(payload->record_count);
> > +               if (!nr_rec)
> > +                       break;
> > +
> > +               for (i = 0; i < nr_rec; i++)
> > +                       trace_cxl_generic_event(cxlds->dev, type,
> > +                                               &payload->records[i]);
> > +
> > +               if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > +                       trace_cxl_overflow(cxlds->dev, type, payload);
> > +
> > +               rc = cxl_clear_event_record(cxlds, type, payload);
> > +               if (rc) {
> > +                       dev_err_ratelimited(cxlds->dev,
> > +                               "Event log '%d': Failed to clear events : %d",
> > +                               type, rc);
> > +                       break;
> > +               }
> > +       } while (nr_rec);
> Should the (payload->flags & CXL_GET_EVENT_FLAG_MORE_RECORDS) be used
> instead of (nr_rec) in this while condition? According to the spec,
> this bit is used to see if there
> are more event records.

It is not an error to query for events with no events being present.
Because we want to read all the events we keep reading if there 'may' be
more and don't care about the overhead of an extra read if there is not.

Ira
