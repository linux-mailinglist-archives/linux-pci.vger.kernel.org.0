Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F58692C2E
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 01:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBKAk2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 19:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKAk1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 19:40:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F19D2;
        Fri, 10 Feb 2023 16:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676076024; x=1707612024;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0+cYvhW+snKD7eqJkBwuNCon9Q1ic/I3WRGawmdf/FM=;
  b=JnKWw3CczTVr9ns/qoiQEgDYXaOKkLEe9ROE4nEdwohV28zmls0NtIT5
   y2iE5RU5BKW+7asJxP25vSwkT2gcytkyS1jHvHFkoWGOkdMMMCltZ1M2V
   ytztQrYJ/xJmaHBTpnFTMIkdbjuEfdKhbloldtrwCXuGDv7Ns0jpc5A+u
   i9Hg+Q5i+a1XODlS3AVTE8Zb+SiKxiMBV8JrpxvLa1JNPLtvuRRC3i/WF
   dq46eak4VhVmJ5PwgF2eYlVcFWRlau4AqfIeDYfPEKSRlAc52HqjIC1Ig
   Nuq7l/nFW0BwTJhWhoFukE7/H0fuNMZLlDQ7nY4o11ajvoVP6n1DhW8TQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="318583948"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="318583948"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 16:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="842194125"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="842194125"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2023 16:40:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:40:23 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 16:40:23 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 16:40:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvTcOjWVLFbV4KVd38s2QV53hkTqBNCRGa6lFN/iTWnxI3wqbav0am5rvjG8iMZuvyXQpmluVbVgXfA9zPCmt20B5O+hxHQRghV5PpufaJIxOnpcLdx7M9wNuds6EoVn7SwXRSTJ6cviGyQbNrB2DOu+/D5cpLWkN2YhXxUdIjGGB0Vhmd01sgXnouy4zlzlVsnwe4ub/8yNZ19XWq6cP3GhouaF2z5dR6c7qtqeinlgBh302izsROpbQjOoacAnyhSjXFPXLZ25pyrWL6+Kyed5BQDV2mSSotIIWQvffSZouJKHuG+fz5RkpWWquQwknBeMRrhZiC3DJ8QzjRc0zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01oGiJjOMsHZCAmGAixNkhiWqfIBLQMj+9HBA068kE0=;
 b=c+9HJZQmObKtZH/wDAFe4aDpLG2JctcVgV1cVi1BCXKl9Vz25m8J9inPuF6QQTk9Zhi9B0OI23UUvYgdiN2am2dnAAvm8LW54SeJXz6PMupKwom6LIKh6ZUc4maaK3DnpGWXH+3vSd5E1ehyxAE3L9u8G7LW3HOYuL2l56uG1fPhsasUB0QkZs32ielt85PWaG0ztdI1SUwkRxbrfAcvIMZN2WqUKQ3RyeuPChD5fHk8jWAElwnrPOclTrPWg02MTZLRWf+iRVhm+3RbGRukP8rHIGIeEeRdl1aSWOEpKkUUSeOKdSqBpOjAVnVhwJLG9U7dYmSJfsmU15+byEQTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7817.namprd11.prod.outlook.com (2603:10b6:610:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sat, 11 Feb
 2023 00:40:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6086.020; Sat, 11 Feb 2023
 00:40:18 +0000
Date:   Fri, 10 Feb 2023 16:40:15 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v3 02/16] cxl/pci: Handle truncated CDAT header
Message-ID: <63e6e3ef4d84e_1e4943294e6@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1676043318.git.lukas@wunner.de>
 <7f7030bb14ad7c8e0e051319cf473ab3197da5be.1676043318.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f7030bb14ad7c8e0e051319cf473ab3197da5be.1676043318.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc6c5e5-2c78-4395-6ee8-08db0bc88c73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pFPVyqtG8KLcwceGYMSx28ncXxxxB4NYpax3vwKiRwkENW5s7sUwDHdlOp+wfwYLI0HSdcig1tiJN7qriiBvaRSYLo48llb8SvVbyX0CEJpHdpPwf6aZVePwgMza6SUWhiG0xj4cTzvP+zRpn4t+a3uW5yb8hOZwyQ2ztXKX8I19qni9500eZnRYrXG+Y9E+yJZZQ2Uyl6Ats7dwA8r3SpPXG9HhH6Znc8AtlNKxpv2XUNmIydZ0fTkFNH60nKMuxwcciVGKNx6C0laVKkcaAR8u659vq3JsLmRKQTqkOXqT6ODJ4QRdvSbnP7BJRi7CsNFHVVtiLkeBYd2C2lzwXXyfwMfIZSvst9kQaDb9FtoO6I7NJHh6eTycoH3S2gfHSSSY37cVn9QG29xcqmVNJOeUkOlvcSy0ExmKM7c56kF/1hgRohMsBMZ7X5RXukdVi/SU0Osii455hAMnLlOuAIXSfCk4Blsiqj6xZfOTrt57wqoaxPQZ0wJAbeTKeSPIV15DroA9bOiWpG6qs08l9lwKE8NQmTe94lRuEvu2GpqyjgYVMg3APl+X0zgDax0BmGZY+A7m3yf/I0lHLfzw4224hkDuWy+MgfyG1zSf5FHEZqxhhIDP6oz1sgnEo6bZBnVjAgZeaU1rY9rst+n9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199018)(86362001)(186003)(9686003)(6512007)(82960400001)(38100700002)(83380400001)(26005)(6506007)(6666004)(478600001)(6486002)(66946007)(66476007)(66556008)(41300700001)(8936002)(316002)(5660300002)(2906002)(54906003)(8676002)(110136005)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AZetiHmran6e7EmJ5J/9gyu3nB7BSAnxqYj5nVDZ781jcdZsO64GDWt4sCW8?=
 =?us-ascii?Q?0w+JZJQUjNG5uyE0dw7p4Q4hQaj3TqWaJFO9X9VCz90Dp/PHI/Ol/QsC9KlB?=
 =?us-ascii?Q?bLiWWZWZzdeJ6F6uTxzY6zWgrb+0VMTGK8HtBDrZawztfQnv7U2hVmjYZFNO?=
 =?us-ascii?Q?KKL4O8qYFtASz9q22Sppi5RRBRGZHJFwfg+TGtt0gLiyhLFbQFfGqsVaQJuc?=
 =?us-ascii?Q?Uz+zinPz/mOFJUeAnnuo+k5+UUrenW6E2xknjr14n7G/EoQopX3dCCkpWnBg?=
 =?us-ascii?Q?esGivF4XB3yT1+WR4ZRIKRLl6Y+pfCBpeZ6ATLqi+z/3XtWOer8x5045N1GG?=
 =?us-ascii?Q?Kj6IuoMLBtlqnVmmNQuCp/Rwdp36o998n1sswYY2gUXfqAG4QsaX3qfR0P7N?=
 =?us-ascii?Q?NstXvpy2gZoq3NF8dQwTAMi3wcWf86rrzu9UT8GqZQmlvnNQU+Ej41Mwavfw?=
 =?us-ascii?Q?g6FKcpp6svkrryNrmWhCD3cEU936p9ElizCIopIqdSFeCi12j80KuFPI10e5?=
 =?us-ascii?Q?aKBoXIzB4jDMoH/s3xNKYqnXK6Lbu/C5Kb6wSOYK/pW20jAXLFbfFionIj46?=
 =?us-ascii?Q?A5PSeSPl88nVSt1Wrq+5X1ngEWyMVlvecZ3DGT/90RItwIi6hpW+LHAJiVml?=
 =?us-ascii?Q?6RocW9bKYkYcn5jkEYwQjRfuC0EzncDT4QharGlqE75jN6j6C2B60tFu2zWG?=
 =?us-ascii?Q?GF1HV0r2L3pKkjZEiAXXTWnfu4Z85sNm5JaRzebeIQAKvr4jA2iA7dPcPlFf?=
 =?us-ascii?Q?QkBxaNHLsBugZ9LocGeN6fJBFyOlWvAURC1qvBFIMoWaLDK5PVS1KXn1xOns?=
 =?us-ascii?Q?PlRGb6hXvJjh3GvTIaL210+sSMsZIRRY4a7AEjDbQj4zg6TRcXd06uqIWKg4?=
 =?us-ascii?Q?FSakCj02bnGFatYB2xu6UguTpU1qQf/YHokNjvv9waGDLHN7vZBfCkLPc1dF?=
 =?us-ascii?Q?m/4aJoZnbwT3KK/0vLtJurYuf8g8h4PlTRky3uH569euZNhdJS9BjZfpES9M?=
 =?us-ascii?Q?KpvKn0eLfSlkbCCjORe7qo5sRXzZ11LLoC9W5TimWi29A/Ka3Ia5GwcUj0t4?=
 =?us-ascii?Q?IAFvlEkF/sbOAZsEP2C8aZmK3TK/veiqyMQiqEpppAP44q7Kz8YQ6kk78HOM?=
 =?us-ascii?Q?16XxVGZgl65sSM09mT1CzRzcl6ae2n2o+dyBC4BkSRU2XIL1uLCbyAbeLzTU?=
 =?us-ascii?Q?9hWUWaI6jzLLSz7bA9248JADWZ4fhM2hYod5/aI0DlGBJNPLcusHIbFMrSfu?=
 =?us-ascii?Q?lduoFh0u9l72S5KRGVQ1L/ka0Xzf91fIoON7IRGCcgKEQfdHkzuHDy/T4DrL?=
 =?us-ascii?Q?FKAEuWjBXHmOM1vciCP/PbtNqEGXbtpMenrIbODvw3Iv0/V7m53cBXBP6ZmM?=
 =?us-ascii?Q?6shsrXCXurJux711xdGcGdVHXWKUZhd0LFX99divawpAPRH4gJNJGiFql2xE?=
 =?us-ascii?Q?QinlEMer/HU0j0YvjpxwenZDdmy99KkfeBag4JLf0/K2ImAQhfF4suYySe6P?=
 =?us-ascii?Q?G3cgomCcNlc3FCq+q/UzKViZDbYTw0bvfT6QzesgqaHvxG1KGr+c8iwQpfsd?=
 =?us-ascii?Q?ASEdIisXd8B8TZyg8IwqEsTEhL9KUb2I1zkDcQ/YPZQuiPUYl4tqU1/jTtmu?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc6c5e5-2c78-4395-6ee8-08db0bc88c73
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 00:40:18.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHinKdIlyMzLwpCUubDFfxzy3MtakvPiBiwuX4My5SsYyNot0So2IH94+3VL0oTlmVkywwnKSLLAxPFaXdoPNXfIYDArRASQ6sjGjEfMQXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> cxl_cdat_get_length() only checks whether the DOE response size is
> sufficient for the Table Access response header (1 dword), but not the
> succeeding CDAT header (1 dword length plus other fields).
> 
> It thus returns whatever uninitialized memory happens to be on the stack
> if a truncated DOE response with only 1 dword was received.  Fix it.
> 
> Fixes: c97006046c79 ("cxl/port: Read CDAT table")
> Reported-by: Ming Li <ming4.li@intel.com>
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> ---
>  Changes v2 -> v3:
>  * Newly added patch in v3
> 
>  drivers/cxl/core/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d3cf1d9d67d4..11a85b3a9a0b 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -528,7 +528,7 @@ static int cxl_cdat_get_length(struct device *dev,
>  		return rc;
>  	}
>  	wait_for_completion(&t.c);
> -	if (t.task.rv < sizeof(u32))
> +	if (t.task.rv < 2 * sizeof(u32))
>  		return -EIO;

Looks good, I wonder since this is standard for all data objects whether
the check should be pushed into the core?

For now this is easier to backport, but a follow-on could push it down a
level.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
