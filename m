Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3075E3F6
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jul 2023 19:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGWRFt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjGWRFs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 13:05:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45413E6B;
        Sun, 23 Jul 2023 10:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnLiHY1z+GBCs1EaEpaYJ2qGEWZ6xxL3whY36wTawTn4lOocjmSITnNHQNpgdXqgH9cQqCx1zBBdY2rp83xgnlIzdKLNK+wanbuJDJ9B5FyJBYjQcyMp5oufy+4nHhe9hD5lozDevGG0xhknBQ3ksRS7zgw96rQ7ttEb3IkHR25TiQAOlsGDxU0YpQc/nk/nMfekdKgt82fpZDv8hHWMQY9j5RaHHhCl5JH5u2ktZJec9FKiXnwg8P85hykClc5JS9G20non0W0c5zeymNFkaoqhliYJg2Y527pWD0Yx/DQgF+C0pM9ETpRObWZ3lGC8Cax3tehNom/XDCcvPzn/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31DKp+UB8WVoLa2MiPtj77IVdnyyHU9gC/T5iF/HcUs=;
 b=nlHN88bjlYxzNq7dkoSAVZG2o3B9TdF5oRzvBI3upgiipVFO9VXDkvPs3yZfQ7TSutAlmUs0XmAgqMLUtrg1WCVhovofwl0Ng+D5qovr1DKin+Dy/XSyQrT3UVNFWPxyalkAdFUfYTOU3Gq7qPuwbZRZBuT6PoZiwPUHCLpzAdIG+KXmecBwMiljEorDzm+QQLA3+oYk+ym9vtsWKqBjbezzGinS+ydrz3RjT88XXbQO7FdC931CAlITWG3pLqv+I5uoL5fpm0OjuULiKT0X/XW+ovtLyMAJ4CIf7OxLiV6f+eNwvk5jQQyzXMWOY7ueFqZcz5G9HtHcu2wBKAidug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31DKp+UB8WVoLa2MiPtj77IVdnyyHU9gC/T5iF/HcUs=;
 b=OfiRBYx4kv2VIO4v9sH1UM8+1l6oMgriOnW7hOqq0e4YzXE7/PFJbS+hYJUTIgfA06TunSG78WD4H56TNroaDYGQ2uahpculIuTcAyG99rObf45GHkFDq7XVBtHW3ljgi8TNbD/l/XwH2noTf1J7bVByuVNd87/g3AhibQcrkH+r/c01G4Gf972VcocO3hyhRdT1reTsJVDGZA5vHT7uZMLN4x5hEwmISmvEhTH/IsVCKp4T9hZ2aT7LOZhvMXmceum/Tbf0OeimGC/iu8HzjWP2xToeSnvWQ5N25VnX1DVTzw/k6RHf0JbEEHug6NI9rHXidyBsf0vLf/NipTan4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by PA4PR04MB7664.eurprd04.prod.outlook.com (2603:10a6:102:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 17:05:43 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::7ef4:97ef:66d5:f5b3%2]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 17:05:43 +0000
Message-ID: <b6e48f28-c832-7a05-d05f-e35514bec7b8@suse.com>
Date:   Sun, 23 Jul 2023 19:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Nomenclature for USB-connected WiFi devices
To:     Alan Stern <stern@rowland.harvard.edu>,
        Wireless mailing list <linux-wireless@vger.kernel.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        PCI mailing list <linux-pci@vger.kernel.org>
References: <8ce5288f-9ed2-4df9-a0a2-bb46941089fb@rowland.harvard.edu>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <8ce5288f-9ed2-4df9-a0a2-bb46941089fb@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|PA4PR04MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9d12f4-44d3-46b9-3d21-08db8b9f0c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNXCHxiNIMoJFpRsTBbYbn7w8okVFewegcdWeVE+cVBichCaUSeRyYgHHj2F6WQ+TIdX6m7/a+t9lRakm+bdeIdoa5XS3CQfNElo6ZW4120aZ2htldiVj4FIrXICFGI4MJonB5Q8uoCrNRLnretXkaJsA4Wdx6R9Wji+Mu700Nu0RIqav+TZ0joc/218uyHhLOP8p8GxcHeOMkHgNOYiQlfkDdTcUpnuQCfuPCguWRLd7Vee02fq63e8qH24Z/S7+u0YyHqIyb8lG44rJny+RhJbdUx3IgQkDo1OnROhjcdVnSSIWPmwoE/QMx1NypPtYtxm6DVj/bwFvJTARqEnNLF6GjkA0pbqXgAGnTenYQvMsqqWILEG/UmLN4xcCUg+7V4SP8j46weGPSFi828HhhouIVRfsvxJXrjIbWfiXvudCExDAJ6WQw8wHUM61eqzawZXBdM13UaPsCyx03/wU5ydUCPsKLRBUpqDDavXJ1QJZ5BdxJUF2KXvoLIhEtnitEbBpnvcZcLsvmEGtx5fdSiBOFhT4fizSM40VysSr7daxDS27qxpMGzu9x+bzM+aqG1DD+/XCztOBXdgNpe6kdjsRr/7L80W7YvgMe7i9gCIIMRC5YrRw7fh41TG/YGPMdLRW6fxq2faHFzowX7/xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(376002)(136003)(366004)(39850400004)(346002)(396003)(451199021)(2906002)(38100700002)(478600001)(8676002)(6512007)(186003)(6506007)(2616005)(53546011)(5660300002)(86362001)(31696002)(8936002)(4744005)(36756003)(6486002)(66476007)(66556008)(66946007)(316002)(110136005)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THNPWUdpeW56V1duamhTMHZHeGlJbm5PTTM0QlE4OHlYRkY4YkM1RnRITXZT?=
 =?utf-8?B?RTdjYTJ4ZkRNdmJEeFBlTkl4RGRPb3d0NUJkUm9UM21laXYvM0FtQmliUkNt?=
 =?utf-8?B?SGZCejgrUUtKSXdiTENqeXpwNlRHampkOVlKTUIzdDdzRFhrYWJVRDk0ZndM?=
 =?utf-8?B?RFJQb3V3ZjBjVElRUm53NHljVzN4OGMrek1hc1U5RmFkV2podGpmTHV6L3ZB?=
 =?utf-8?B?TjlEemVZNnZoV3N1WXhnaTJrazRLWlpvK05rWnlwTkk5d2c1UHk4WjBEUUgz?=
 =?utf-8?B?WEZpcjFmYmcrd2pkNlAwdHMvcEZRRjdPdW16SjExTE1haitmSnBneE5JUzRk?=
 =?utf-8?B?VlNsSUk3ajRENFN5TTdYS0ZIeUJKaWdPY0g3aVlVZmFsZC9lT1FST3JaQklH?=
 =?utf-8?B?eWdvRDNodzdHdCsvbGtlbllOSS9XZ0kvMys1bTR6aG94bUphall0bytVTldv?=
 =?utf-8?B?bEgzeDBFeEJKSWMvR3k2YlBqSS9US0ZhZlpOUnRhNSs1WWRSOXNHZktEREE4?=
 =?utf-8?B?ZkJybU4rengrNzJHbU9aTHo2TW1McGkwd0tpYk5sTjNJQzR2bCtZNkVHOGNu?=
 =?utf-8?B?S0hFblJzSUFTOGpNYy8zaitXMW4rRlVJMGhuRkE4Vjk5ZU1zVVlMRTB5YWcz?=
 =?utf-8?B?N0FCeWdNT2dMVTFnbEVsT1FMUGV1amJuM1duOFBMdS9vWCtaQmMzdWszaDE5?=
 =?utf-8?B?Wkx3MlVSK2ZXanhTYVdwM2thbnFBdjJ2N1BxUFo4Nmx6aUw4TzRrMm84Zm9m?=
 =?utf-8?B?RG92WDdPV1U1KzhOMXpOQ1RtN3BXcVJER1F6V0RlZUl1VTdySmNlNmVVTmlN?=
 =?utf-8?B?S3lnMmNuRDh2SmMwNmRjWnE2dXFJRzFzZU04cUJ1ZllGOEJIRThqZDhucnJ0?=
 =?utf-8?B?YnRMdGU5YVVRVE9UaUhYQUlHZkZPMXlMQUFHOXNJRm5UMHJESEsrQjJKaTYx?=
 =?utf-8?B?ZitjZVpON0g0M294R0F3b1JwNWcvSzFzc2lsNnVHT2pWRFN3aHVQcktBVmZE?=
 =?utf-8?B?RjNFNjFxT2ZqdDE0dWZib3lQWDYwQVBIVFN1WEdzNllvdTdXMHIzZkU2RUJT?=
 =?utf-8?B?cnpzOUMvWk94c1hEaS9UMStBc01hd0xpWWs0RmtJYXdyTkYzWXRaY1dmQmVX?=
 =?utf-8?B?dmVYM0gyNHk1SVRVNlIvRHUyS2FLYnNzZ3hQTDByd0V6YjRVd1FRZzNNNkpT?=
 =?utf-8?B?czdPOFdlcGFGNEFQMmZEaFF3RFg2WHA2WEZaYTF0N0pkeFd4dXozd0Zabm81?=
 =?utf-8?B?R0xsdGdOck9lbkJoZkRNdmYzWlFzU3lha3h6SHVoYmk4RmsrNGlyR3Vqakdn?=
 =?utf-8?B?cUFOSjl4b3FoZXpDMFltRWdxU1lzaWVRNUpNOU81eW5aVzhoVGlWbXR3bTlW?=
 =?utf-8?B?L1FaWm5oZmE3VWlBNjNCL28vTVNwY2E4TmFWRUJMWlVua3RpdjE3aE53eEM1?=
 =?utf-8?B?SVV6VXFYdStFSzB2VFlHVXBHSFZhczltWnVrK3Y5UXQ3M3dhYklJR1NvNXRO?=
 =?utf-8?B?Vmxqcnpka29NOGhsand4T3R5WlI3NWZuVWhyRnhBZGtzNEJtSXFiSkVVbllR?=
 =?utf-8?B?ZFpwaXp3dVoxdld5QnBkenI5ZXk4R3AwR0JieXk1WG9NWFcxaUkrRUl2bmZF?=
 =?utf-8?B?MXhzcHoyVHRxbDRBLzh3QWUrY2doY3JFZlBPeVB5MXN0N3lGY1ZSNU1ZSjdZ?=
 =?utf-8?B?YnlVOVVBTFR4cHVHNVZVeFlkT1NFV0lTOForTzNyNEhCYzk1ZjdJUjQyY2ZP?=
 =?utf-8?B?b1dFcDlxTWN3VDRna2pZN3FQOWh4U0U5d2F0TWIyZ1dNd3lGd0tpNGdSb0Nu?=
 =?utf-8?B?dnN0b1h4TDJ3bnM1RFhpMEhJRURDUC90ck5zSVJpM2NMZDJWemVLaHZ2RjVC?=
 =?utf-8?B?VG1kRzRNUTdsSFg5NklCVno3YkhqcjYyb0l2UXF6Sjhsd2NlWnlJQmF1WmZY?=
 =?utf-8?B?b1kwbUFSTFdsZmZYcytrUGpla0IvM2xsbXo5dy92YW1HMXJQNUxoYmVyWlJl?=
 =?utf-8?B?b213U2duYzZCU0didlFuNlIvNzh4cURKckF3Q2NuTXBqYlR4RXQ5WS8vTXZF?=
 =?utf-8?B?WUszNjNETmFpZFMxQ0gvd2NPZWdvSUxyWnVKODVYOHB5MmJKVlkyekovK0kz?=
 =?utf-8?B?OXc1NzRreHVpd0JkZVJBSy9iR1k1N0Q5Y1ladW5ZL2gxTlliYUVJakU2czNq?=
 =?utf-8?Q?+uEogKDZCcyK8AMsp1i1Y74=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9d12f4-44d3-46b9-3d21-08db8b9f0c4b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 17:05:42.8301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4IV6wE2gB7uNJ23Dr4mgeP6kVhKkgmBtX2Gq9BvzgeF/gld48BTwlfvW06fA/4KmCWZR/0hfj2C1/yS5X8MLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7664
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 23.07.23 18:04, Alan Stern wrote:
> If you've got a WiFi device that connects to the host computer via USB,
> do you refer to it as a "wireless USB device" or as a "USB wireless
> device"?
> 
> The second would seem to be more logical, by analogy with things like a
> USB mouse or a USB thumbdrive -- we don't say "mouse USB device" or
> "thumbdrive USB device"!

If you are doing this, why not go to USB WiFi? We want to know what
kind of wireless device it is.

	Regards
		Oliver

