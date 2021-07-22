Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB53D1C25
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 04:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhGVCSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 22:18:45 -0400
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:54481
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230093AbhGVCSo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 22:18:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=od1uuUL3Jt28KvGrJzf2E+F5yrCowqRzvc/aWhEQZvxWDNmmJrteu2PyOfFaY4300wrv9rWcvv4R8NltEER8lh1Z9YWQYRWQ9ensNdaQe66ynUwZqOOcAVj7+Qs4bjHg1ykfM1BVgIE1my0c7VE/JJ6Y2HzdtaevGG5W0qzSKsHiKIeqtwlW0kQ3aNd2hfJZ45bNSK47vzf9KpKLlgZHA7vZ8jw4TM8e6z9aXXjtYHsLkfsR4qL8GaVNU83sAcCviAEgAHN90PbQGWhx7yZtcv0kFg0Fj36Xlb/FylfDyg3DKPTejLrHbSaVSiNxu1Jz54vKChy0d3nhFGz05X56Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2GVBPzqojmxOUmgrz0GBFLre1kWa6IyIlJLKcqHsVM=;
 b=Jsr0E3vRdQfKuFitQ6dQU+bqAfFA/rAChJWwsNektW/AG1zXspUgc7NHZodfAbV8ePDVQfYrtueCrmJ9LF7cvXtuEoxqx4PcoRGcrcIpRN3aoo63PcpST+p3+dEAI6nXIW7qrq8MqqtOu2tZ4HJJGbnWUFA7xuqaJeJC20FFe0t20ZgzzZQU3p/RYYhewlr9yuYKe4+LwNr+swQheNNTrOYWIdvIIaI/aP7vWxyrcJkpIhSgardJLYSrqHYoPBvWMJtneo7YWwkZdLJbAC8MYqO/1PgWHP86vBoUG4R9ZW5w1G6j5j16ep1jWzKQVA1TrYv/cH55vrAvFEc77jPKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2GVBPzqojmxOUmgrz0GBFLre1kWa6IyIlJLKcqHsVM=;
 b=tqlOX0/sZGg6rKlYCYv6yclSoEbR8YAdZdAx/jnpAajnBp9S3Z9VqFzyTZmv2i65Et8/iuJQjFL1kft5mm0eowsZ0afQhdJEqyPPs59iEpz32hcmja6OPm8ac8Qo9mG0967uOLhJaJviq14OIdGk9OSkLOzpblnqMk7gQmNvGXs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Thu, 22 Jul
 2021 02:59:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 02:59:19 +0000
From:   Alex Deucher <alexander.deucher@amd.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     Marcin Bachry <hegel666@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        mario.limonciello@amd.com, prike.liang@amd.com,
        shyam-sundar.s-k@amd.com
Subject: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
Date:   Wed, 21 Jul 2021 22:58:58 -0400
Message-Id: <20210722025858.220064-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0383.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::28) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by BL1PR13CA0383.namprd13.prod.outlook.com (2603:10b6:208:2c0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend Transport; Thu, 22 Jul 2021 02:59:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bd516e-2c8f-44cf-4442-08d94cbcb312
X-MS-TrafficTypeDiagnostic: BL1PR12MB5096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB50960EB4D320817B1621607CF7E49@BL1PR12MB5096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IEHmvEBDnsG4Crqq49TjWZ9rukjh/qVw5Xz/iWcXoouI88OGJFo6lhunTSba4coozIY4V5ZDKtoxgoY4bEmIwiSAUqdpdSfEU+v/cN0bGgUeGHfP9eD6Zzl3lCC1ZxbGJ/ev2RU8rUG4KAdzM2P9AUn4lg9AZpdB+4jySVtNC2v5ISodGTVMG1aghQBxQX+KX6MN+sfjxG37ZWX5pGr9siv5Y3pABy7WSjh5WaX9CKQnrGhdR7Ak2Mr9jdKHSBJE3Brdh03u/2Kq3jnGYgTezfACsqWiQn0fOJ8sOedGewJTJgwkvjfBnr1DiGw8X0xwWaaXLIkijEAmDgPJmbCTLxQ0oNmtITV2n9g8S6/10Q++WiF6bjJE9wRgiMMmooCh7jpSMxyFW5+EH1zvvIBZVzhIPNqJiEjbWcjaFEuMJ5uhBAdbBCF4pLuNphLRpnbK49sRGUXT0/de9lju4LJ7fwCecwGhIArAeqMH4+LS/9l+2qfY+mCePwY0M/E6Hj5Zf+uIpXHmYUqLdgaC2leJBp0CzpcQR2CLXdeR0YGos4zcWAyElZxMNiG8JstRlwwgy3JFkiwIi+kjV2D7BdVcFIY6iaO2DA35g6qv6p5NOOK37j8D7bhtviAKVmJ1FhsALgguaw3/LhFhzw7aRn77djdyH6/Nweueqq418EQOdOgXr0LXZrEFvt0EKR2b+KHVcpPUJjs4FriIR1d9evGFtX4lY9Idalsv6rTkK4Ujz+2dm2b+BqWkflOg8ZSY5iAc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(2616005)(8676002)(6486002)(5660300002)(52116002)(54906003)(478600001)(8936002)(316002)(956004)(66556008)(36756003)(186003)(4326008)(38350700002)(6666004)(66476007)(38100700002)(66946007)(26005)(2906002)(86362001)(1076003)(6512007)(6506007)(83380400001)(42413003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dc/Nzh+34TrSyUPpVB26BQmpxuSn7mBBMyVWqHjJy3HRLF8zxMVf0sv8obly?=
 =?us-ascii?Q?FLIU36uo6IxiLYRGRefiKUShCZkPud/t+TsV/BeEpBZVTP12cYYKqQCLTROi?=
 =?us-ascii?Q?8Xtnem6/iEYES86rLd4MO8KXDDY+ThETe5OgbVWQ5++9D+v4coA+3uy3eV6T?=
 =?us-ascii?Q?40j0LS7aJuiHblXNEaj7Gy3UIJ1qzvwh87qAp96Tg0dMhf60J/qzqnJPWOo0?=
 =?us-ascii?Q?BYCkLMNqW+8wWU3cNYWocmk5P6xqEm0uqXcT+HCwgKw3TPPhT4rvpXJZUYsA?=
 =?us-ascii?Q?lNjpERNK/CZgkuDziBskhNH7J+57ky5dAwnXUMGXX+VIeaZ5bBAjyssRqemM?=
 =?us-ascii?Q?+dg3Cug8zVMR1GY6hyy4YG8EIEHadFrmS5GwKs8ORtN4ICJ/P1DB/GLGE247?=
 =?us-ascii?Q?aacnOFuc2HC7siQiozUWI+h1ALKrxInazB+t6id7+vs6WWTanTk9dLD2/Rz4?=
 =?us-ascii?Q?/18qKKrQ3yE0CnaOZOtCTidVtFSAIhPpPaQPTkGRfKqynSy2gbiDrtNVHNJA?=
 =?us-ascii?Q?c3pK6yk7u9G7hW2i7bs3g84yS2HXkqBWpW8KsixwaaitPoIQCUqOJPR4OVv4?=
 =?us-ascii?Q?PTfwE7MaqqVpTePQVOjxb+InEP9P8HfxqmtZB9jXWe0v9zvXp5/U1GXyCiAF?=
 =?us-ascii?Q?1v/9rNh8CR3XtBOZfrhbQQ/2SQZc4mrRlAopM4tBF9QxDHpbozc4xEqvFu36?=
 =?us-ascii?Q?kEzssDWIf3PnQ0o0h10H9vvilk77BS+WMPIIniCu0N5b4i/9ajAvDn4zWMnL?=
 =?us-ascii?Q?pYeCrYxEGHwg3HXuX1cp0NiUn9qCvxTed5yrIVVoox9Y/2SYctGWBCtOcFZ8?=
 =?us-ascii?Q?2JRBDzQSeYoec9yM04l7Wwnt6Rs3zxBAp/V0RJzTx0PXqlsZsVeDtBkWoHYK?=
 =?us-ascii?Q?GpZcr21Qn1YqU6ewR8rokE5TOkf5kMKvsRNgTxx1+uEjrpAiFLgzpHm5WNbB?=
 =?us-ascii?Q?muZXfyfSYqb4uE7a5QIzn3nJ5D4TYJFltU2gCANqfcVn4hO8JneH041S9ygk?=
 =?us-ascii?Q?ZWc5i+REdmzYan/3hGSlYiOUQBZg9oXAimk7a6zH8Naj8iCnfrx0u6OrXrqx?=
 =?us-ascii?Q?Sm0+gwS8FNe0POyNHdocSuBJb1BJ3zGJxUHTws5ahp/Yuphu1+J0ozWNEvUq?=
 =?us-ascii?Q?QexuMvhIqTNQ4mTo5QN+Y/jlTtKFdblqOzGWPU5a0RNcHxMwplMRIMhsLjHv?=
 =?us-ascii?Q?XEgjJtLu1dilqNhzv3up859p+k+UjY0Q9co5YCN5R6c8caTEyvxJEt3MHzfB?=
 =?us-ascii?Q?XJfLe6mAxJzzKz/tnzfE282eXaMqyFQn5R155osPvo/xyO2rGP7qPjbZ4JJa?=
 =?us-ascii?Q?K7z+sp37PWEM36Y54mHgwa/P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bd516e-2c8f-44cf-4442-08d94cbcb312
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 02:59:19.3309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1G8ka3hl6wFwMnCGLHE+hGn91MC2SXcpDoViScnTrYmciV18T+VUJ1WZKgWVigaiWwY9QZIivkW0/87EKEZHTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marcin Bachry <hegel666@gmail.com>

Renoir needs a similar delay.

[Alex: I talked to the AMD USB hardware team and the
 AMD windows team and they are not aware of any HW
 errata or specific issues.  The HW works fine in
 windows.  I was told windows uses a rather generous
 default delay of 100ms for PCI state transitions.]

Signed-off-by: Marcin Bachry <hegel666@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: mario.limonciello@amd.com
Cc: prike.liang@amd.com
Cc: shyam-sundar.s-k@amd.com
---

Bjorn,

With the above comment in mind, would you consider this patch
or would you prefer to increase the default timeout on Linux?
100ms seems a bit long and most devices seems to work within
that limit.  Additionally, this patch doesn't seem to be
required on all AMD platforms with the affected USB controller,
so I suspect the current timeout on Linux is probably about
right.  Increasing it seems to fix some of the marginal cases.

Alex

 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 22b2bb1109c9..dea10d62d5b9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1899,6 +1899,7 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
 
 #ifdef CONFIG_X86_IO_APIC
 static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
-- 
2.31.1

