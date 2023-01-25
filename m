Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18667B551
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 16:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjAYPBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 10:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjAYPBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 10:01:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54FA1E285;
        Wed, 25 Jan 2023 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674658891; x=1706194891;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tb6CSNK+aTXpYFTIELqq9hWEsbK1veEaB6sHOtIEnr4=;
  b=C3VKRMIKbDRrvMnVO1xZI03f3Fs/y1bBVOxPuUaFDljRNxSIj1kozy+2
   NRjNai+GGmKSc9H/HUwG5Mvrcmyo8rNQeFSS4fbsUrhds+k01Fug+0Hhn
   qK0f/xGqe0cqmgZZY5DoWzSLEcRte2vH8+h0cESANP+6GjpkW/Xo02pMK
   1ywU6EuwokJkOPxO/oggHDSe4uO3Ryz5aK+IQDyLryoM6uaWCVkMi4xKC
   J4CqdTLunXqqSfoQxhznO0v4GWg+Ws6vgMMM8ytDSlaStj2DmYzNv0DJu
   /cyrWAMdjjK+uAQCHxNeKHx71cHm+QaFa+jSqqzD/6fh+2ywEfH60brY8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="327826490"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="327826490"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 07:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="907904245"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="907904245"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jan 2023 07:01:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 07:01:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 07:01:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 07:01:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 07:01:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xmwc8ElNArnrXh/CHwf21v7UBwqYEeY8QM3fuvX1cTDNo+cmvmocz0MWeBlkUWSUm4IrhgiXTjOzblFiLmZc58ed+EOXdMV/fwmf5mHSiPO68z21DpUFCkeqZfNHAO6EhgxPFPp8rVMHN9lg+pcWGuF3EMwYQU2ySKYJZUVxoD/hVS7iKYV5VEBNmVkmsbTZOEd/MtbJLwHiGW5K3mu9fRiIpFwjfTddOzc0urOF7OTdWSBpknpraxhVtgVPt761glSPjugYZvrQ/oc8DlyxxTwGrok0+YT59RC91Hu3wes6XcCBRx3KhwZfWlaU04Z6+iWic9sEHIYyGy1TxdOshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0BRxA5h9rnBpmFEo8zEmFpQ5FoSpFZ+LjTHWaDEJcg=;
 b=WENmJFLBzNUHYn/KNyGJuFF1p/WeoZcmBRQXrYQ1Ytkp6bU1co27BD6wCm0UGVOMQ/ZpFDmf+C1TJ+suNAW0vYABa/vUF7hfR/c47dM7ArjKGY01ObQM+ha4bHywSu3fl83SR+aJYiWtKDHxkXAHVdh4ktXU5Ev4ezPxGxVC6XKLKXQtVxENIOP7MIxvT99zoIqb/VnJTeSDdYxs6Ek9rScp/pKZB+fwqd5dV0vVlO9qXx1rqqRVaIl7820JTjYUMMrhuwMoBUxRXZpLdX3OCMp/+MzUkUpulStRvMXwszEehDE8W4xuE5asgJKdZ+txbztMKZ492hzFtsrKxw3b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 15:01:22 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3%4]) with mapi id 15.20.6002.026; Wed, 25 Jan 2023
 15:01:22 +0000
Message-ID: <5be13f9b-fc19-28ee-3ed5-8b85f85ca7e8@intel.com>
Date:   Wed, 25 Jan 2023 16:01:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1] PCI/ASPM: Update saved buffers with latest ASPM
 configuration
To:     Vidya Sagar <vidyas@nvidia.com>, <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kai.heng.feng@canonical.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20230125133830.20620-1-vidyas@nvidia.com>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230125133830.20620-1-vidyas@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::20)
 To MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3205d0d1-ca16-47a3-cf5f-08dafee505ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQQzsdEvKesNeYZPoqJwhVREy410zMKh3+wxSHzbJBe14Y8pwJkGh7TVyS+9lcTNrM2vbH8OLaE1zE1HzoyZnNT5Oez14OvHzAjzz6Y/fRwAVFt8PHGpRBt/+NSa+duSLe0laPz6dMqFctfVRxg7obdPRyHjW8T+ycFVYmJIz5mBbOFLTdUoIzoP7/nP0wEvFu91PgypZ0jqbitr/cgkFkZ/QTNJYH5GNjf99PNx6JQMmsyd2ssW59KFX/sUnaQVlAJlzleTkPwy+KxbYpw8vHEVEzSKLtSztHfhsaPfOS9TXHwKbaNa6/CPUGUtjp2+AVwqi1N1Ez0JnuwwoAbSQfSM29ai1npiLHyy9HqI87ZgiuYU8ib6vmxLONtbtYiH5cyzN2RTgWsZQVtWqFPWuMhpo7hnGLMXNfLZnzwolm29Cyup0YowOwIEqFqjMiqFkDGekPdm1FrvwKzzLzLQXDrGftwgs8W5e3zlWU8EAC5yxby6S6eplmSp+69M6zxC5jush4uOOWsG/+8mUzMeZKyU0yC8S5Y3l4yViDzjaBCq61wDK+QMhGXxtiutXPtwA6JPvJo7vRoJr3bW4SpI0vW0tAYr2hy5Zm3FxYCexI/dgG+S7rnpFWUFk4J1XNArEwrWWADMXSTd8TzaKj4tWoe43QQqtw9gD9hW5T7zjaHQPP/s5f6S0sRNs+w1AGplMjogzo7E7wFh+RSbh22xHuFjMTyADJGW7lazdxtBpYpzQxmkp4dWValCfVb/1iAmyrVM3P8XBJ6htMBboE8N0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199018)(83380400001)(31696002)(4326008)(66946007)(66556008)(26005)(6506007)(186003)(31686004)(478600001)(6486002)(36756003)(2616005)(7416002)(5660300002)(316002)(41300700001)(2906002)(38100700002)(86362001)(82960400001)(15650500001)(8936002)(6666004)(66476007)(53546011)(6512007)(8676002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGswT09MTmZzdkxaeko0MFpxa3Bnc0tiT2x4L1lDVUdibmc0SERvMW5kTDMr?=
 =?utf-8?B?U01mY0ZmbGM4QXlaelY3MFlPN0RGSjNKemFzTjAxbklJYjExQ00xY05JaDdk?=
 =?utf-8?B?OFdPWnlMYjcvSENaeGdDYXI3aHEwMi9HWm5EbUJSbGdibWh3NWhhekNTSkZw?=
 =?utf-8?B?NjFNVWw2K2Y4WUFGYlh1TmZKRjk4c09lZmlzZGx6UW8rNUsvQXdVS0pRZ2ty?=
 =?utf-8?B?K2pWMHJlNEQxdVV6bTRXQXc4WG1UK0JSd1JrSCtnZXRSbVJoR213STRzZWIx?=
 =?utf-8?B?SVNqK1RSVVk2dWZaNWhhcC9zNElhWnVFNzhxTi9yMGU1Z3NzMmpYQjBVREoy?=
 =?utf-8?B?SjN5WXkyR0JhYlhpcTg4QkRZMk51dk0zZVoxRFNMNkNVWVpwSjFzTmZXSGtL?=
 =?utf-8?B?V2ZSZFVGL1MwZndLNGRmdDdWTU1wczZOOFpUeDFpWU50ZU51eHlFNllHV29q?=
 =?utf-8?B?Wk9ZN3JGN2tjc0dtSzF2eXZXSFVGYkJKTUFxTFlXMW92WGsvV1B3djJQZTBu?=
 =?utf-8?B?MlFuZG14QUNxdHF6dm01eUlyQVNleGhPaUpsYVROLzVDQzQ4d2xkVjZhZlpi?=
 =?utf-8?B?T0NaSmJKWlZCSGR2ZTNaa1hPMVM0MzIxM2NaZHkySnFlbHM2SzBNV1VoNWRt?=
 =?utf-8?B?K0l2S2FOZVhIbmNqMHlmQjBoRStoZWJGZDF0NWc0RnpadnlWTGxPL2V1NnNU?=
 =?utf-8?B?U3VnQmt5ZDU4SkRkd2ZJbDBmM1pJamRDVU03andaQnBHT2F1aVNjWTQ1RWJM?=
 =?utf-8?B?RlpjdEZ2R1pFaisvWnN1NTZxUXZZUWk4NVN1azJHK2xUZ2drQmdhL3YxVGdK?=
 =?utf-8?B?YkE4SDFaSDduTjVjN0swK2xaYTVwTEk0MHIzVW1nNHppT0hVSjhmOWhOc2xB?=
 =?utf-8?B?ZUtJd2JSUStmVkNoajd4M0xUbkxQUkJHWmY0U2hwZk9Ld05SWGQrZlpNV09R?=
 =?utf-8?B?ZWJVeUhLTGtjR3VHRHl6MTNwcGNhS3k2Sndydjd1Yi93cGxQUFEyS2RFR3BQ?=
 =?utf-8?B?TmlaUXBtbFVnRGxabFovSEc1T05qKzJhbFl4Ukxhb1o0S2lMcHBuZFJIRW9i?=
 =?utf-8?B?eXljTXRhMU8rQS9tbTc3UjVlVktYVk94WUsvS0FSR25uY3pscDlkZFl3eTRL?=
 =?utf-8?B?TTlRb3EvNGRIZWtXRStiMXUvWG9xeEd2QzVSTTNQTlZjTjBtUEE1cUR6bkx2?=
 =?utf-8?B?bDJPVlphZEZKNGdQUDZmNUEycFQ1UnRRZEUvTWNoRXh1OHhVTmx6dlBZM2pj?=
 =?utf-8?B?M0J3TGJmbXkwdWZGbDRmaDdkakZzQngydlhlbHY0a3gwS1NZMDRlZXJIcDV4?=
 =?utf-8?B?TW5UbVIwOGlCd0dvVXdtWENCRk4rQVp1bFU3NlFtcG9vMFEySVpla1lhbndv?=
 =?utf-8?B?NjlPTmJqUjFjaUoyOS9NcWpKQW5QNUtCTDFSYkNycTZHZytydWk0bGpleTBs?=
 =?utf-8?B?VEVEakJGbHN6MnkwMTE1NlRLalFoaHQwSVgzQ1NWcWpaUWVKQndja0c2OS9D?=
 =?utf-8?B?aVVPaUx4YmJHQjJ6ZmFacUZhMjhiZldJRXNoMmpnSTRmdHZ2anJDSzFWNVpx?=
 =?utf-8?B?VWRXNStKMWdpc0xXWTVBS3doQnFWdDJxWTdKQkVzdXNNbDFLTzFlcTVwelkr?=
 =?utf-8?B?ZitIeWZHVWxuTjZkcE1ELzBzZXpkTXovVUNETmNUc3RrV3pkNDRBZ29RQ0pZ?=
 =?utf-8?B?U2pkK2RyZkN3d2Y0aytoK0xUS2FiZzRxTDg1YnB3RkdBTlNLTGxQQ3daZXJQ?=
 =?utf-8?B?aWNpUWtsU3RwZnVNUW1jWngwZUgvQi9DYi9tcy9RbEdiMjJoNks2ckVqSlhO?=
 =?utf-8?B?cSswN1U0K3NCQlFxVzc4SUkyMmVvaVBac3UvVUxQZ3A1MVdJS25XbkE0aDZk?=
 =?utf-8?B?NzJzWW1QUit1WHFqRURpY2M5VEE3b3d1SEVWRTdPRlN4dkhZRzNBd3E3bVNW?=
 =?utf-8?B?UWdpSXVISlpoVEJVV0hiSFNISWtITEYxYlIwckF1eHcwMnJUNFlYNEszU3Rj?=
 =?utf-8?B?LzFnUkV4ekh4aitiNFM4SE5GeXVUWVpqYmpLSHQ1VmI1U2FWRndtWjh4SCt4?=
 =?utf-8?B?L2xmUkdQK2VESDliQ0FBcEYxZzVJalpuT1owT2M5ckdiZUhWZFIxLytSM2dk?=
 =?utf-8?B?aVZabkl6dVpFblY1ZUJaRDdTZ1lqczhGSlJvb1JFd0tKN1ZCdzVoVGdmb1dB?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3205d0d1-ca16-47a3-cf5f-08dafee505ba
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 15:01:22.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMdZudzCus7U80xT+ninYB9fl1et4HQ67+wwZFZOk0Mxu0p6+sq+R+Dxul0p9gjmWk6ov0DE+rKMStK2Grtw8/7uQ9tum+gigmFZGg29tqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/25/2023 2:38 PM, Vidya Sagar wrote:
> Many PCIe device drivers save the configuration state of their respective
> devices during probe and restore the same when their 'slot_reset' hook
> is called through PCIe Error Recovery System.
> If the system has a change in ASPM policy after the driver's probe is
> called and before error event occurred, 'slot_reset' hook restores the
> PCIe configuration state to what it was at the time of probe but not with
> what it was just before the occurrence of the error event.
> This effectively leads to a mismatch in the ASPM configuration between
> the device and its upstream parent device.
> This patch addresses that issue by updating the saved configuration state
> of the device with the latest info whenever there is a change w.r.t ASPM
> policy.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

If it is a bug fix (which I think it is), a Fixes tag should be present 
here.

If the reporter's names are known, Reported-by tags should be present 
here too.

If anyone except for you has tested this patch, a Tested-by tag should 
be present here.

> ---
>   drivers/pci/pci.h       |  4 ++++
>   drivers/pci/pcie/aspm.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9ed3b5550043..f4a91d4fe96d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -566,12 +566,16 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>   void pcie_aspm_init_link_state(struct pci_dev *pdev);
>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pci_save_aspm_state(struct pci_dev *dev);
> +void pci_restore_aspm_state(struct pci_dev *dev);
>   void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>   void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>   #else
>   static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>   static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>   static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pci_save_aspm_state(struct pci_dev *dev) { }
> +static inline void pci_restore_aspm_state(struct pci_dev *dev) { }
>   static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>   static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>   #endif
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 53a1fa306e1e..f25e0440d36b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -151,6 +151,7 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>   						   PCI_EXP_LNKCTL_CLKREQ_EN,
>   						   val);
>   	link->clkpm_enabled = !!enable;
> +	pci_save_aspm_state(child);
>   }
>   
>   static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> @@ -757,6 +758,39 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>   				PCI_L1SS_CTL1_L1SS_MASK, val);
>   }
>   
> +void pci_save_aspm_state(struct pci_dev *dev)
> +{
> +	int i = 0;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	i++;
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[i++]);
> +}
> +
> +void pci_restore_aspm_state(struct pci_dev *dev)
> +{
> +	int i = 0;
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	i++;
> +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
> +}
> +
>   void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>   {
>   	struct pci_cap_saved_state *save_state;
> @@ -849,6 +883,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>   		pcie_config_aspm_dev(parent, upstream);
>   
>   	link->aspm_enabled = state;
> +
> +	/* Update latest ASPM configuration in saved context */
> +	pci_save_aspm_state(link->downstream);
> +	pci_save_aspm_l1ss_state(link->downstream);
> +	pci_save_aspm_state(parent);
> +	pci_save_aspm_l1ss_state(parent);
>   }
>   
>   static void pcie_config_aspm_path(struct pcie_link_state *link)
