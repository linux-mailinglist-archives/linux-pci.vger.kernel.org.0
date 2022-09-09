Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398625B350D
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIIKU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiIIKU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 06:20:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA7795E72;
        Fri,  9 Sep 2022 03:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbH0h7ztAGpdzzNXQD7PYbxUgGpHmp1BD2RihDQ2+39XoJKof7v199xMAbd9O+8fAiUU+4ENf9Z/8/O+Lu7xmYfHVQvO9hKZB+ngaX0JcqXhh2KVEOyniByAbI6J8HWSWA6l5sVuTLooOqsqEC+caUJ/4hDbD63keq89WZnm3HkaJnu23azGXxcod73KhlZ2MWCIGXgWeHbCo9jYkzboBs8XyTr6HhYp7g9UbOLaRrFN8rej2jkx0x/BTjoOoPlNcRpFmBS6Ew/GUsJymvbc4Z8Xh9GO1yZ9Gxpkx6ZJdCBa9QlZH5JZbAgVYr6evXGBD23Xt3IsNvrTZKAx6+Z6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnygmnmB6udOuEgYFLO9QEgwIAZUTJvVdYbFOfIh1EQ=;
 b=KbTubCUTvjAFlxtmGdOuj6R2KHuy1cgfgryHDH2fQvmPpxyJ4RMSnJwX46xvz0Ck1KA3xR91MIN4oJCt2oVKXCXq+K3BAmBLL+iw/KVCOGFIeC24yxgCKvCPuf73V7BrPzn8dd6Bz+BduD7BRnrF9tq3Er5/Scf29QBK3CVpUGh3SIZYmaTwKNnwuRWPYerps6mUfuDzNxMg+/ZyG8OaMIl3NIf3Km6NfjElN6skLM8AL4sUqtA33wszcZRez6OktUHeGvrJl+idaIFb0hnCwFtamvkkl9kccZP7CMJ2nXTatq00I9mcsB3hB76gZtFmwRQl66JOI1BR9pSl/5Y4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnygmnmB6udOuEgYFLO9QEgwIAZUTJvVdYbFOfIh1EQ=;
 b=nqWEIPv6RHJD40L7SjCWtz6DLQe8+71/cdjoxlPrH5lXqAiLvlDgkuJyAH1PIwvmkYG0ww/hpfnS/tCSxXA0MRZ8H+aZEeu6QOkK8kdDHH1MCX+37cBjDnCzfX2c4auQeg+ZSFZaLlVFHrWfr0kEfyHwWoaCjmVzWSQJib/VfDY=
Received: from DS7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:5:3b8::19)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Fri, 9 Sep 2022 10:20:50 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::4c) by DS7PR03CA0014.outlook.office365.com
 (2603:10b6:5:3b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 10:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 10:20:50 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 05:20:47 -0500
Date:   Fri, 9 Sep 2022 12:20:45 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-cxl@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
Message-ID: <YxsTfVdOgc9sOOVm@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-7-rrichter@amd.com>
 <63198617c7854_5801629450@dwillia2-xfh.jf.intel.com.notmuch>
 <CAJZ5v0iQNSNzO+mw7zqkvpniiYdipprTYnkzx-M7Jxq4_Cs8VQ@mail.gmail.com>
 <631a464c166cc_166f294d5@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <631a464c166cc_166f294d5@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|DM4PR12MB5963:EE_
X-MS-Office365-Filtering-Correlation-Id: d768d5e5-6fa5-4acc-ccb2-08da924cf845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZJQWwB+px6N5cgZLiUW33DU7igtpDoWgFlfZ1Upq1V3xc2gwv83VzQswoMCtMlTJRZpYUvCdxb6dmWbcdbMMlCOMC7zcBkShStDpIJOww0ky0ofJlKzWP8/3lQA/iecih3hKJYvYs/l2kgBzUN7FTSp82VobdXVt3OCzZHW+RYc3AKxBLPsNsvWlWiRZYl1VplfTjoSvwBqlUzDpxjmuxqBv+CmnEECyAOVEy2vR+Q1gLye65tcfgobHd8j65elrgTJPZOXklfMODBkxJhII2RWQ4mBYoCtz9F19EM8qRUi6NK3VfIE0Lfg4+PHKrwlo6rDNHYuqHLTAxI0qT9cCK2ES2R6Yn7dGv8h0Zc0ZTQgwEq9UvPyKxdsKCqksMO+rpvlFpK5sirr0LsIlW1gawCaR3PkqWhsalsUMRIYV9r6n0wGCBWkblwT13saNgcmk1ACZUSbVt9uMXsjMXUYv3igpYlxmVkAYaIKzEQT4R0+7xKDbTTFQkB+wk+A/6A5Ab7bO/mgMKZoHH08DiO+mLXnhj4VK3DMJBMmNVtLyuNU2hkltbBJ0Q/nthI/I9Etw/bSjFz7wSqIaCmbfLduZ1TYsTJDvLxV2GgTJSJBAby/g3H7+p2LXpn4QyaArxWKomPhHEOYBYg6tGrNa83tu/yyhdEKRIcteSSCoA07albn4BQz4jDZbKyylxVvzh99B1euo9gZgneSra8hZaiFVoZLYXX4OTUGJgAYOO1r4qPVaWccBMMJVpvN/8BIpeqmbJlkhJPwB34PsDZQAO1SLMaAvPFGF4mxbzdd3BfuiZs+2TXzmBtBA1ZeN/NSl1S4+
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(40460700003)(2906002)(5660300002)(8936002)(40480700001)(55016003)(53546011)(26005)(9686003)(7416002)(7696005)(47076005)(70206006)(70586007)(41300700001)(4326008)(8676002)(36860700001)(6916009)(82310400005)(316002)(54906003)(16526019)(478600001)(82740400003)(186003)(81166007)(336012)(426003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 10:20:50.5746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d768d5e5-6fa5-4acc-ccb2-08da924cf845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 08.09.22 12:45:16, Dan Williams wrote:
> Rafael J. Wysocki wrote:
> > On Thu, Sep 8, 2022 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > Robert Richter wrote:
> > > > A lookup of a host bridge's corresponding acpi device (struct
> > > > acpi_device) is not possible, for example:
> > > >
> > > >       adev = ACPI_COMPANION(&host_bridge->dev);
> > > >
> > > > This could be useful to find a host bridge's fwnode handle and to
> > > > determine and call additional host bridge ACPI parameters and methods
> > > > such as HID/CID or _UID.
> > >
> > > When is this explicitly needed. "Could be useful" is interesting, but it
> > > needs to have a practical need.
> > 
> > It is needed and it is present on x86 AFAICS (see my last reply in this thread).
> > 
> > This seems to be addressing an ARM64-specific issue.
> > 
> 
> Ah, ok, thanks for pointing that out.

No, it is x86. And true, it is set. So this series is actually working
without this patch. It can be dropped.

Now, I just checked my logs. The reason I was adding this is that
during code development I modified the code to have bridge->dev.parent
set. Then, the fwnode is not linked. I later dropped that change but
kept this patch.

Thanks for catching this.

-Robert
