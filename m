Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB9C679E68
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 17:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjAXQSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 11:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjAXQSd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 11:18:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C472F7BD;
        Tue, 24 Jan 2023 08:18:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLlsl27+LjtJkzJ6fYeo5SQkeJXmtUAaNHd0v2RYhG/TSo2W6lTIwl61W7YvPEiCZFo0c6/UI/dATKSdCwYpEU1OPyAlV4qG7KKRHkl1xCxRMf+8y7S4vF9VCFGzV6Gj4rZSjokrVGzGg72eWfRPD6xMt35AKj2KFEPAqLDGo23DNsxMqudGkd+0euZA0dZ1dOOv1JK+QK1QbeuHj2znJYgDyC3ZwW6+rnsdCzytzfGUW1q4z9jlrgES+WgMID/HX1QK3Eo1QopeL7cOBLsDZ1vEjJ3FgiWIIGvQCNMJBRdGx1QwWiTSfjSfJTfD9DUID5QAMM2WVvc4UnEgvGASjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ2cBXaW224piCeW+p7NPSgvojY4Ftw/XuLM+/MN7V0=;
 b=l1YVnHLyHtjX7IjcbVcPh1zRFNZ0dB/eenP4Kw7ainkqZ8LiN/dcISn+5pHJzfjmTpRu5PW7ulmpvG4GDQSmiiVp6/SwQHDPZjslzDTDLMdUMhnanw4UiaqRW6yGikz6UgScRV6m+Az66JIy6G7ioik8PCPNy0rzJCL0XyPiTj3lQDzhrEeuCl2EPP68mU5S1ZCykXIZKBMGAIXAWpouhAh30+jVW+Dp3arfwyf3iYcv67mW7cEFXFEJOGHS2RGMQWYuvHHxFnSo8WNLDx8XoyoCmrGrRF52TZaaoGTwet7yw9txK2HSZjc/qfSFPkkx9B3zvxYzaYNp0j+mbvlqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ2cBXaW224piCeW+p7NPSgvojY4Ftw/XuLM+/MN7V0=;
 b=Lyd+jo1+CYFg685oIXMa7PhuncJA2lhWxk6b7fMiWSaVG2YBH2S/+uiKdkgmaQYfmMtkP3JaSoXmhCNmRBQjQL/WQ9Zc9kp8jyBj/DxFWxtm8hAxriPib2CT5sOtFnU5h4+jOJ0lN+/ynB5fssEaduZCubedqiaii7x3FvuWEGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from BN6PR17MB3121.namprd17.prod.outlook.com (2603:10b6:405:7c::19)
 by MN2PR17MB3999.namprd17.prod.outlook.com (2603:10b6:208:202::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:18:28 +0000
Received: from BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660]) by BN6PR17MB3121.namprd17.prod.outlook.com
 ([fe80::d253:1eb3:9347:c660%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:18:28 +0000
Date:   Tue, 24 Jan 2023 11:18:21 -0500
From:   Gregory Price <gregory.price@memverge.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 01/10] PCI/DOE: Silence WARN splat with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <Y9AEzVrTB4Sobufr@memverge.com>
References: <cover.1674468099.git.lukas@wunner.de>
 <cc4b61809e2520d835cf3d4f62e7d5ed00a9d031.1674468099.git.lukas@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc4b61809e2520d835cf3d4f62e7d5ed00a9d031.1674468099.git.lukas@wunner.de>
X-ClientProxiedBy: SJ0PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::30) To BN6PR17MB3121.namprd17.prod.outlook.com
 (2603:10b6:405:7c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR17MB3121:EE_|MN2PR17MB3999:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a2d3fe-cb25-40c1-bdf7-08dafe26a068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sncl7c1EHPH0vSM5msFBTfA+OB90dEp37Dxs91L20z0L+zdK9RDoNkxkvHUPK+UALVH8Kn5eGtXnFPpmUIfq9eHnoVUmbBTZyxnAeZLwhTTndjaA7InnaUYg1SpWNA6LFpO0PuQs+qN8dmMZbg5x/m5wXhez9nGRbcTeFNpdykC31KewgGNkBtJJu8gn2FF/WypGD5a7StS+zkZbXfrescrq//2oLBmfgnrCoIF4DtyUtBw6/WM+yOkwjhkScUHcf66KnqRenBd23BoiYMKnxcY0sC3C8oBnINfYj192rh3MJXgdv0E9AowCivU7HqxJwB3g3Jux3dFA+42u/09L6Yt1zEDOpSg438cqfJi8erPaW4WM4JkRfHxlxz5L3E0AH3vl2WxdcsdZZ0UloLQ3g3QxfDblSdayx+QCc4uxqhFq/mMAGKg3dxZaAoJQYshQQQ4pEtP8LpYNNJGExw/GOGApM0KQRErT6RQkgO5dJlZGTF05ddQyybYjG+SEcE+hxPFkH1dcpUZ5J4fTj14U3T5bM2wLorffBDmWERBeP6XljW6OuH7J/36Ulxc9JYsgZ58MNGsUxqAKy3EZlQOw5HXug0ZOXQ9AETJKQn/8/BS6q9gM/CtN+FQ5CV6q+Kxo9Er6CqTUZKi1b3RMTZ2igg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR17MB3121.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(39840400004)(396003)(451199015)(36756003)(41300700001)(86362001)(7416002)(8936002)(5660300002)(4326008)(44832011)(4744005)(2906002)(38100700002)(478600001)(6486002)(66946007)(6512007)(6916009)(26005)(6506007)(8676002)(186003)(316002)(6666004)(54906003)(2616005)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qz/dUOwSxltSQvSnlxzM2OU2VMpQ8BTxaHN8Lf2pLOJk3oQojzAIuhB2FugL?=
 =?us-ascii?Q?SjMNkvQpOfZDfTW2wfuqugyOXmi+8Qmfs8Ao1gI3ABOuYvN9KWokGLmpqgQk?=
 =?us-ascii?Q?M0O5IHmTnWmesX2FmUqzzoJXrFt2gDhRIa0yLJKp0W6QOUz8yCSZeNr1Gge8?=
 =?us-ascii?Q?fvblAOMuzRQBhF7VvNt9DrhY2XtVLc4fCP5x+M7Z9FMzlrAbE/u+BzaCSu8Z?=
 =?us-ascii?Q?nggGY5xx86Jtjk2rw2ovn8ZF71SOIkTCikaMWmu3DUflcxE0unRxXBQLKscM?=
 =?us-ascii?Q?hLmBSNA9Vc8RgUvMZdrOXsMEEOh6gHr4seP8oDHZ/6GqwTwcpMfPhxcSmnh3?=
 =?us-ascii?Q?BCQnTn4aujPhNRWQ+NeqmlErxnMg4NQeWHANJfcP0oCf6HKHzM3uJC3KV36T?=
 =?us-ascii?Q?s5oM+1QWhQWi/KA2EOfcUW6m0Kx0aGYUUxiPPJPmV5WUsZYXhMYgunxlHbvB?=
 =?us-ascii?Q?yF68POE5St3CuOj/pTh88+FxIU8QbyWXxCDl5V7eKm+1ow74GmsSWP7rKdda?=
 =?us-ascii?Q?8XeerH6bpK+OPpYR1o31SH0A7avjPpK+R4gWY2euTG068qe2RPIACxErLR8/?=
 =?us-ascii?Q?GYcxmsMhXHCYOs5AguGCmCe6+Fx3Wy8jew1SUNY+C/q+N5fnBIi2+SOkgg1l?=
 =?us-ascii?Q?uTjwn3fIx4Vd5H48G5I2xja0w69MxPfsm4iaO8CFqUnWpNGvpqa9jcBaX3Io?=
 =?us-ascii?Q?KfXhPZ6DnUT4Woo9L9hmvxi4FY1dYDYEiQ9fDp0Xw1mhbkAPeGNb3tLgsWqd?=
 =?us-ascii?Q?AYYxKikAT2yZOmkrCJAEaaikCBZbupSsktpZb7FhrW6zciT1avfkrFmwDMNv?=
 =?us-ascii?Q?xYwJM5hrxhHhCAyCWZHaqklKv5Jymwjs+7ZV+BwnAhrY6RoPq5vrAkTIa5sv?=
 =?us-ascii?Q?oRltdov5R+PA0LBw1dQl/+ZAihYEVQB1sYadENRY2+T3+NuGBh7QUo9gYt0n?=
 =?us-ascii?Q?tNlw3FHE0zN3sxPjwRzAvJp+IOF0j9QD2tZYNd1D8elY4NrJ9VV1LhsiYqeF?=
 =?us-ascii?Q?NxeCBujswQIGnHYf1itdEkhGxdZdbsxlxUWu8e2QyMQiNoMRrmk0MZA9q6W3?=
 =?us-ascii?Q?dSYyuY6pOkY3AiId04J9yj8zcQ+UBiRsRpoBauNA+yGLWNZaxQ/7DrUPK7Nl?=
 =?us-ascii?Q?dHFNfd8q2feDFtvWOsNQHW4YwmD/Vw913u+clGU3MmbZ3tUJhLqxS0HybcQG?=
 =?us-ascii?Q?qpGodv/luYxGNOTO4CP5LEsLRB8AztCjwUmhruXyDCHvSWZeqyRs3NimRKTT?=
 =?us-ascii?Q?EShJVvIZFoDrTuvYO+67v6LnOklc58aDFhd05+TlTTZ4AIqkaYyCL4uY5iNl?=
 =?us-ascii?Q?+6zVL8N5rVuOKzw9tdjra7onjHh2LFM97FjJfx/XcQsgscbAXK9dohvQhAOa?=
 =?us-ascii?Q?95CBvsUEAPsFqvOXhj1Epbyw6UbUd24XW2ZE90BjxsVkQm4F8BuUVwsn8O+7?=
 =?us-ascii?Q?nR8Mht72fRagMDx1Hso3l101mLtl77TnCMwnuHz5PwUTwStTIYimszA8SE0c?=
 =?us-ascii?Q?hzQ0n/329stuWzfL8IXRmjJHHne3ullXBz+oyLRPa9s4svD182PFR98My+Kg?=
 =?us-ascii?Q?9n9vpgd1zEPpYkAhy3aEZzmauQOYpvWlTbWjO2DnqlzatC6VecFfTL59L3/t?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a2d3fe-cb25-40c1-bdf7-08dafe26a068
X-MS-Exchange-CrossTenant-AuthSource: BN6PR17MB3121.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:18:28.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXdPMFWnmJ0YcMq/91q+ukVsAqjhO57IU5+2JMUS3BRgeiB1NpjULkdvdeLjmzxZLabDFBEoI5hRuckiKhG0gH+R8Ew96ZOqiWs6IlrSw5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3999
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 11:11:00AM +0100, Lukas Wunner wrote:
> Gregory Price reports a WARN splat with CONFIG_DEBUG_OBJECTS=y upon CXL
> probing because pci_doe_submit_task() invokes INIT_WORK() instead of
> INIT_WORK_ONSTACK() for a work_struct that was allocated on the stack.
> 
> All callers of pci_doe_submit_task() allocate the work_struct on the
> stack, so replace INIT_WORK() with INIT_WORK_ONSTACK() as a backportable
> short-term fix.
>
> ... snip ...
> Reported-by: Gregory Price <gregory.price@memverge.com>

Tested-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
