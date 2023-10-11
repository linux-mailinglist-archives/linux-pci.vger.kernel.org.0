Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757427C45E5
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 02:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbjJKANg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 20:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344314AbjJKANd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 20:13:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2122.outbound.protection.outlook.com [40.107.223.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A69B;
        Tue, 10 Oct 2023 17:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca6HLp7UXeoEA6LIiQ2cJivD+dp1AIyZfFo1viE6HZKXHxCsJtuTiQqRq5MyGHglePRbej8O7E+/Cor8AIntv6v8/fvmOWlpv+3XAR+w9RoDvGbxJSqDSUV4RO5wOM3dguNsIWbmiDNawmeO/Jte3Co+7uJDoev7ndKxjx+H0ZYRo9sYxjL4+0v1C2g1DJIIvXyAi0EhAE4BcjCY3PwMqdjtFFVbEY25+Hoqjikq6z5dxQIZVGqeCkKCeYVauUw+hNM1wWpUwXByeVzgYi9KdQiowAZvvATex44yV6Kib+L2CikXv3ovzH3l4+4nEIjdqUjDAh9mnVkel1lR15D0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIGL3ACGT0Bbq1MqdpHVFnn6EfhY+0iztlBqC14lqso=;
 b=E1Q+w7y49SQCwl4ubZ/KInVETi1enisUO/gTmiH2nF8SZvFyBcECDT62o+uVWKbwdnrb/bslDqxYnqGt/26fRXbfzNttC9f3/FU+TTJNHPCba+Oqf/Gwi8RDsU+CaVauIJmLCqZmfjPxmiQm5oBNG/0j8VIY6vYfOxcKve/3LIuFgLicoZn1RlDBq9SgGMMQg4M9w8mc5Fd/A2h4jsd6Q/YFz0tckuDvlby+qUH9tTwWUVqml1D8cOrU23hefQbXZ6L3+KzTrB/0vatdeDH02UfdUOuJ9GzQUmyxhXtkrutkcwcdo7Q9vZ0dOsxz6rQw9A3zvmoUqjEvmIE7Tc1X0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIGL3ACGT0Bbq1MqdpHVFnn6EfhY+0iztlBqC14lqso=;
 b=O16VK04lLVwlEJbuEYjs19KfAkYnfhc+gRsINeldflVIy7xipO0Uhzuc+tPaqyZ8stRYJdHK1EFIVNrUTHAgo3yqP9tOdquKrxgdZ+vXNzJTb6LoA86e2LnQUQpHQHjeNzLDiNTc9lnDB8YAstu4ddIBhRrNKme275YWA6Ysi+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 LV2PR01MB7766.prod.exchangelabs.com (2603:10b6:408:171::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 00:13:27 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b04:8319:9c23:c3]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::b04:8319:9c23:c3%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 00:13:27 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: Re: [PATCH v2 1/2] PCI: acpiphp: Allow built-in attention drivers
In-Reply-To: <20230930002036.6491-1-scott@os.amperecomputing.com>
References: <20230930002036.6491-1-scott@os.amperecomputing.com>
Date:   Tue, 10 Oct 2023 17:13:22 -0700
Message-ID: <861qe2qan1.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH5P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::21) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|LV2PR01MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 2808d902-1887-49a7-592d-08dbc9eee43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wyYm2N4UMXBqabBcYsJ3a/StMCbqb9gC4lSYixtYZCOSceuhqoXM3aGfwFfHUH/BaHv9kmxLWONgIDgv1O4u2uZ/fU69R38vg1fhO50FqS8TjRkkL/JKbTGtugMjVyVoqfmLfcq8pLyJ8plErX5KXshyENmwM9HYMRMe313SToy2tHacfX9muTah1xBiv+ymTzwl9xmQ5MM56lYke6s9sI/dhTA48hg7gobu6vOYasDYYjvpLbghSYDvDqW14Dswcl/HZHgFWjhZPQc1Rh7sXPdEWh2tHObZOEplmbv+ohe9EO5BkKeo+F9iA5+clXkponyFkkF3abf/rPw6RIQoLqkOP5n9s9ogF13lChVe3ERcswYq/f90Pis1jIGkUPoR9roRSon7j4QCSfazen3wlx1mVMUJLoswJLgkbC1L8uk4Mu/Bxm2GHpLlxRN0nlQcUP4PzSWNQT8H3klcmcFiIs2qwcLwsplxhmk6oRKwx69GXcDTaQYfigdvFd6Ot2TicdIz3CjRSw5x2aFv4hMIimdzMGtIeXpbjh3qqihWRgXPLTBRSS6jHcuTFyBTypBYgoakUh+02vPMz/M6ubh1Mrj709r+tZ6v4DZSARRwDL7gswv1bVgfj/ZHjAU7nlF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39850400004)(346002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(86362001)(2906002)(4326008)(8676002)(5660300002)(41300700001)(8936002)(110136005)(38350700002)(66946007)(66556008)(54906003)(52116002)(6506007)(38100700002)(316002)(66476007)(83380400001)(6666004)(478600001)(26005)(107886003)(6512007)(9686003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6DfKBEXf1kPl6TiHBWCGWuCYNhpI83sBcPQ9OUGQ1LE796HJoq9Fv8V607vT?=
 =?us-ascii?Q?8RVOlEq66pprS9PjmUjxMqOk+Dqd91bnggcYoGmahT8lsyJ+u3pYOZ202isH?=
 =?us-ascii?Q?MRBNPizqnIFtELTWYTlmGMrN3BSTu6UTG4zymsnFVIBk5U9OmMblx3I/GGqq?=
 =?us-ascii?Q?95fruyMmeis0E90e1Hzhw0chj3to9IwnfE+i/BnvVmeJ4Tex921SsS1IlYQD?=
 =?us-ascii?Q?XrlSBVaZwukQ48UklY+gHinPWuQCy5K+WN7RyPi5EQmWIK57pK82d+td/K57?=
 =?us-ascii?Q?FDCdU7E5n3vTSJ2uaT4mUyXYeQcF3xnaW0+EpzUtZou/RGIT3Hy6DUc2s6ar?=
 =?us-ascii?Q?TNK5wXeOFa1KasHqQc319/PCbsfggkj/mR4loRjGO5w/BmuFDgalbA/upDar?=
 =?us-ascii?Q?5XOcb44IfmgYIwhBa1c1vP7DTTprmixPeVadtGpJa3K7EikENURddr5dMouw?=
 =?us-ascii?Q?ANpltQDbmJ4wgrmK7q/YAjCzfTGzZ+bKV0GWwo7ZQyJL0MtnHVcRlLGKNzCk?=
 =?us-ascii?Q?BuuCD4p+kOhLIWLL1aFfL6aIBLZQJYHujdN0w/LaPj9H6TUreBl0sp28UbIt?=
 =?us-ascii?Q?yCn5IhNxCnsXAzYGRKm/YP3oV1qmXMumvn9tJ9kkSzLDErSYSIRvTeW1o4Lw?=
 =?us-ascii?Q?FHMlg/MBrHQzM0vliDSISgTFrBrQT94peTIr4CUzEUai+ClXMlyZjvmAhAz4?=
 =?us-ascii?Q?s3v3BqpAsvAnloCGSoDXhiVKbXdZOOV2COAHABT47sAp9GIpiE5g1n4l91jQ?=
 =?us-ascii?Q?kZtbDz6PBSsHa7kQ0lvbaJjU9QvvaDNVnRzAMpf3jCKKtvftpxT/6BB29Ur1?=
 =?us-ascii?Q?YfvZ97UGSmL+YwVeSMytEcRmlPVX1SI1JTqzzrw7VcSHLqNI0szeGDicBBkq?=
 =?us-ascii?Q?A5V/pZLFz789uarqnMKbO3Qv9ucrF+/xyNw3hlNTOxHeTdfNy9Bce7pdq104?=
 =?us-ascii?Q?z2ae8esZcdzNndQ6SCyyrgnrwG5Ui3Fk+E92g/1qb5aMw4ThoQG4AJT0It35?=
 =?us-ascii?Q?Nv2DRDGzWXO4XshaYNLlsFiY5xQAudB9jQ5Ya8jrhiVBPtGcpaqWh/nTuhdd?=
 =?us-ascii?Q?EhF8whNQ6AwKGxZ4MYWdCHYOc77rHuXrZ/d+acpt6cdzqOdrLl2bhlQfskb5?=
 =?us-ascii?Q?t02Vf3B5oN8kdf8TlfiAZNoVVICk9yU4TtPwZsqp6i4/brexzGVXqu0l/2nK?=
 =?us-ascii?Q?MRHHIRb6hoka19GojRC31vFI5kXS8EYtcpvchfl2INGP9COTYGlxKr8UoaCR?=
 =?us-ascii?Q?tobwOBWOd4z9B1H98kKazG8y8I73UayruAfcveqzITAdgdpZ7bAXQNOCavQ5?=
 =?us-ascii?Q?H5UgqmN/2VUib3zowDMPOgxGRn81s/r10YnLgkUm7g89Q3BRg+bdvWa+Pitn?=
 =?us-ascii?Q?d1wOhQK3RzED0xIKnKResinsiPYIlGk1IWOoMo5aSg4ZiqLV4K0VeWmAN2uE?=
 =?us-ascii?Q?0BOifyCkNrAI+4yUXzcrmnz2Pu+icr2SLbc2gnhjJhVnkBfTRahBuhK/yzPK?=
 =?us-ascii?Q?/IPoYoLu5d1UeoAsmwRrvjqtuvPvs+NTGhT2DlCxIvqJqW4pQFrG3wEhtZI+?=
 =?us-ascii?Q?xs1LXrhU8tIls2O05qh9qkOVaoS7r8zNECKZd2iT9lu+Jr8NvVL5tYsGx4OV?=
 =?us-ascii?Q?vcWVpZa0Fc4w0A5KioMfpME=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2808d902-1887-49a7-592d-08dbc9eee43e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 00:13:27.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXmIkJPpoy7ntzWn4AlXDC1L11enFkXQyG1RgQ8Lf2UL3eBufouOxplSTUPYoupSbv8aRYMTmhh8RwTX8NZvMe7m6DAJV5rb6QltduB/h5pTD5+4DOgBybEUz7ZKR19V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7766
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

D Scott Phillips <scott@os.amperecomputing.com> writes:

> Starting from the introduction of the attention callback in acpiphp, a
> non-zero struct module *owner field has been required in
> acpiphp_register_attention(). Then intent seemed to be that the core code
> could then hold a refcount on the module while invoking a callback.
>
> This check accidentally precludes the possiblity of attention callbacks to
> drivers which are built-in.
>
> Remove the check on `struct module *owner` in acpiphp_register_attention()
> so that attention callbacks can also be registered from built-in drivers.

Hi Bjorn, ping on these, thanks

Scott

>
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> ---
> Changes since v1:
> - new patch in the series
>
>  drivers/pci/hotplug/acpiphp_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_core.c b/drivers/pci/hotplug/acpiphp_core.c
> index c02257f4b61c4..9dad14e80bcf2 100644
> --- a/drivers/pci/hotplug/acpiphp_core.c
> +++ b/drivers/pci/hotplug/acpiphp_core.c
> @@ -78,8 +78,7 @@ int acpiphp_register_attention(struct acpiphp_attention_info *info)
>  {
>  	int retval = -EINVAL;
>  
> -	if (info && info->owner && info->set_attn &&
> -			info->get_attn && !attention_info) {
> +	if (info && info->set_attn && info->get_attn && !attention_info) {
>  		retval = 0;
>  		attention_info = info;
>  	}
> -- 
> 2.41.0
