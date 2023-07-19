Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3414759E53
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjGSTRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSTRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 15:17:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112B3199A;
        Wed, 19 Jul 2023 12:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFxtSYeb7btDv9B7DRNq85v0Jd37Z4sr0+BwRWjXBGnzJJw8HsfJm5Hk7RDdXJe5QssBBhn/1aj5h01g/TUIb2GR8mwJ9jVdRtzkAQ/fD76UCX8lgAB6o7NgJ46TmTnRtqg6AywghZssf+VnlJM7Yrg6mM0PdA2qGonF9a0T0q9D0NVJJxZRFkkDFcljgCvNLIV5mrrO/lttesBoFCZkPjoAU1wlhkZDQZY0LXvb23A9II18VsVOKjso4YjqrqhjDvKgQ7O8+Dsz7tKma2xQtR34kLjNEHFwuX7cTJFbdnxNX6jGy46dkmWnYuGKsnqmb/uo3bCZgm+hITHjxodO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khHFdkzW9UTe3iHk0O8XwS9ncBw86ErI+26X8Wi9UKs=;
 b=Oe/IRQYE4lIvGZ5gwweqA8KkEKugPS43EP61YfdVhMscjr27O+NloybfMUJ6V9pAGexTOrMy6U4oPZyQiK059zCNUux5ZzdM4AQqPrm/oo+lWl5KVnHlxSh8FKyH1432yFNFJmdYYGff+KnZ6J6z+/2UIGbikUf4J1x5UM/iYvj7lfL4o4kBGASTl+WVm4oEveN6YHsHhSbZjh4V86hSG0TK2PSyCAdbFKrG3mWYGnwOhfJasfQzDwaBYgdvZva7ZdPcDgs4h9PzeRrJZkI4r1TNH083iJ1b6cusg89e1ks1lZxvY26JSDlc2kbC2FdnFJeUZ3w7at0L9CakkMJ9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khHFdkzW9UTe3iHk0O8XwS9ncBw86ErI+26X8Wi9UKs=;
 b=rsLEGVmjtFcBIEFvUfZ+IGLEqLqiYQFA/x+SvzyG2tkVtIXG2Ul0QtGBKW2gqo0x89MkOvVr1192+Bk27LkyBC+od4I+ZZ5TmYWDG/ETGwAraM0bgo6kFjud0sisJLwdSZIT3M7oGlckA/WsttTRbyIaUW8pBYEapybWopnDCuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6796.eurprd04.prod.outlook.com (2603:10a6:10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 19:16:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::d0d5:3604:98da:20b1%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 19:16:59 +0000
Date:   Wed, 19 Jul 2023 15:16:48 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        helgaas@kernel.org, imx@lists.linux.dev, bhelgaas@google.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        kw@linux.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <ZLg2oObBfmhSzTFg@lizhi-Precision-Tower-5810>
References: <20230419164118.596300-1-Frank.Li@nxp.com>
 <20230717164526.GC35455@thinkpad>
 <ZLWKI1lRqxejfUgK@lizhi-Precision-Tower-5810>
 <20230718100400.GB4771@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718100400.GB4771@thinkpad>
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 2568a258-7247-4277-555b-08db888cb949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0ByUz8cbJsjsM6cyuTmqWChqmQzOpmTuPpsJMzsWbXBDAPasuU4NFKxgkDOwqymNECN2MJ+hbIfjG9EZARMu1nXJpSFk+CyutWtMlPA5nnGatB6Z6vBwdGN8tfJ8XN9X9csdDBLmoXxzMG75kwzpWhWQujEI7SNoQS/m92hpcH8jzdwZyhFojZRR+RR8R3zBw7gHohHoqsypnzsnz7clxEg9dh6n1LvCV1gSoE8Rsx+twXO3cJDYsUZcYWeU5F9dPVO8nmwQk3CdubpaYvjNGvBlx8nfuBaUTw/3U9u9ONrXcEQ4wiq7eNijm8NQFyddIoaWh7G9NfB2QoCFNDft+QroZsX9nkaiO2fvqaPxmJIvi9AhnmFp1xFob1ekeRYizxMkcBzp770qz33IgniYYzyzoIBj14HFlPdEeQBV7BEP9aETDyEoqm7COYQLrQ34dsb5ESN+bnx/XTXZxOl28K/AqRwcB5aeVHIcshDpBBQjb47sdgmBDfchnAFpkyhiCKdPjcd6z93NX9VfaUcP+cIZ3uLN2r3bdwPavC5Dq+j5yeQVkJ+AbJc33msFnO6qHjF1rrXmNvWRFZ6fjNLvVcwmZ4wkd71vwkTDgz9n/OvUU48leuIVbYbjE0ttmfl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(478600001)(6666004)(9686003)(6512007)(6486002)(52116002)(186003)(26005)(6506007)(86362001)(41300700001)(6916009)(4326008)(316002)(66946007)(66556008)(66476007)(8936002)(8676002)(7416002)(38100700002)(38350700002)(33716001)(5660300002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hSWfezw0jRyN3gjvONhBNuoYi2aEpWLrRJ1b78xzw8ojAEK//F0/6FLfLY9L?=
 =?us-ascii?Q?iyLtFh2GMvW/gy9O9AiXdYOnFUtTuifzAaiUqPxwlqUOlCrv/FBHaJ8KhWpS?=
 =?us-ascii?Q?ag/945i+Z2VTIcMCMA6bY3TuUn4WrOX2yQQ51rz68btiVUCffS2yxtPsAUR1?=
 =?us-ascii?Q?CFKmxvGn+W8lnJwtAlYFolZqLVxnavZIvZRnC1HuoGyqA7cm/IiaIhZKdsY3?=
 =?us-ascii?Q?nMdMrqePYDCi2y1xgOD1Aj/a5Y+BCAGy2BXWZr3o8y2/XzLN9KZiB26IqW0G?=
 =?us-ascii?Q?hUa2mgP9/fluyJ+fwaHblEcu95BAAhTAxPTkoE77M3YxRhSnwv+LRbNIazMs?=
 =?us-ascii?Q?qZtYUXbUNuIMGRa7zgAMRmNd0hlAvgrfmojHF1+uurwyrvkWBMlfhqMElZ2U?=
 =?us-ascii?Q?geLguYZlR3iGlYXmhK2LJ6vQigRt2at4I8TEbC13/baxjdyHyrw6DNhmVjjR?=
 =?us-ascii?Q?OGnjX9ZuZDF9mwaFMRGYYmqutUjt0WZKyt0L/6KTbNy8P0rcfD8Ig/ISrZMC?=
 =?us-ascii?Q?vmEu3jihmAoBX10zKipU891UC1/cb+llpIyTdi7xJ9bM6Z/g6mMctvS2KNZq?=
 =?us-ascii?Q?zbXZjqzcVrWHHtiwG0J+14R+6RIA1ChZaiCY4HXAqM+5vXMnPc+6iIUvox/a?=
 =?us-ascii?Q?7gW/GmrVazBuPkJAj/ycxJgm3c94vHnXpS+tgCzl4HSGcOEJpnSJxDVQacD4?=
 =?us-ascii?Q?iX8XyVbkS4g6svDtFoFd1ZTKXhbn9c8BWQhgQ+2UUwSw0vAjQh4ZPo0CKsPf?=
 =?us-ascii?Q?PAaS6fhENH1iJdmN2z7cwxLCFgISlFZLGA2SV1d1zyzDO3LHVnxJPgXckDIl?=
 =?us-ascii?Q?aGvjiPYus8zDdIWyCBZlwjzW390cQIBk050Y/RAjjBwOM2grDxcmSgy7H7fX?=
 =?us-ascii?Q?v+ddLKLvaGtAU5504NTdFGCAR2XD+zcDHgteDt3LmHmXSVp9vCePvdITISkJ?=
 =?us-ascii?Q?zI7fCbQ3V1H1+GumbkQag5UvNAYTDGdV7K5pia9nya2HYY7w5P5U53Owq0rA?=
 =?us-ascii?Q?ZWAhhKiRf7KcOmBG353Xt0iGn2ZK0OLPc9D1UyXwO2zy023HrBpZisAYRYZ6?=
 =?us-ascii?Q?HnmondclYLkt5uU1/3tCzUSErVp9otgxHDVIojy/YQocv/2unsXtis0RIzzF?=
 =?us-ascii?Q?lt9BYdlpdPq9niQDdKvczJVPgjT9FjEFkpvEnu3WeV2NmgAacF3zBPOAR/th?=
 =?us-ascii?Q?jQkd0zsvBTXvZPqbwyCEAL/KtHeAk/Nbkdkq0QaQK8nBQTiJQM4SVDQuBrVA?=
 =?us-ascii?Q?6WCMf9gqXAzB9Xd107F/f2FyWGOhR4xpbJOKHvPTppTE8sVCZrK4Q3Qr83K+?=
 =?us-ascii?Q?h1bXXBlWRwPAZwfhckWmDW4wLpBQPMPdyAHjKupeXqFbAuaW5e3BxXCEE2JS?=
 =?us-ascii?Q?W4uht3RupPNKlIkLMg8CBkFGKcBsBbhvqpFRgP8i+F9bnqxZc2wGAaV96CL0?=
 =?us-ascii?Q?p/aZGlCK6O5kSA5U/4jdixC2XvVevr8ciWEKwLv9E7bptW2SG0XyrU7lACFP?=
 =?us-ascii?Q?bKfSCHva464laAzj+osG+NepGuBFFZzEbyy5o09f3UJHpGJxmUEIFq+BebNO?=
 =?us-ascii?Q?OZyyd5kOio4EM/lYCEsl0FUGQ/4fpBxj6KQVVjZD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2568a258-7247-4277-555b-08db888cb949
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:16:58.9562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leXtUWt9XFWtTDwjBwVVQsU193P1aiT+9EsjKHpa/Ayh5W01hxR9psFdfzenF7Jg6+GIdALQqXbl4cFIAWUxNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 03:34:00PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jul 17, 2023 at 02:36:19PM -0400, Frank Li wrote:
> 
> Fine then. But can we check for PM_LINKST_IN_L2 SII System Information Interface
> (SII) instead of LTSSM state?
>
where define PM_LINKST_IN_L2? I just find one at

drivers/pci/controller/dwc/pcie-qcom.c:#define PARF_DEBUG_CNT_PM_LINKST_IN_L2           0xc04

Frank
 
