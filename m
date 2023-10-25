Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DEE7D7285
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 19:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjJYRl6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 13:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjJYRl4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 13:41:56 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2113.outbound.protection.outlook.com [40.107.212.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B2F186;
        Wed, 25 Oct 2023 10:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXDoeN4n7pkMuTxT1kKlDM2Y1cTsRNOYeYJ+QxAMjIzVZRU8DUgv2OYUr3uKzQCoOIwQp9Ve4Z7QGPOqYr8Ben4gwIQh+maj1EdOqCbBeDaq9818/V20IGFVXXrKNH++8W0Ucvsp/sJ067WmwCwNpuI+Y4UxHtqv2hJSHV81rrpti2US9Eh5OFK5aSyLhS8eU1iPqsSH2/8L5SPIy4sjqqVnlZKyi1uBH1WyGxMXrsmS3cXntpLXM7sCKXK8zrMUwIENyMb6xM7XdBilF0k0nIhFAe2IXtokndy1oVr4T0jeDjHeTFrTrDRYO+DedVnJimR6hZXeARMdb4pzE+Z5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+ZyeqVLVnVSGBccMcimpbQkmh6Sqz/f5y4eRFiv/qE=;
 b=MAdARKvbX6qCV/ygfnEXzrEGsoZL9pyet0dIlIehhWz+hVHvgtrtVOkE0Iy/lXPcc5sScEwvhxai9/UxNtH8U2j8w7FVYnw/Yt8o5N/ZW/1lv5yXzXXYHOXlkq179F2B0OM9z2usTv1L0HvA8/UbDjxVf1hjOn03og+IGALFnwSo3XSXBRypUn6/qFXLC0WCAo1OVzdf3lVWGFYjHwLqu3Dbqvfko7DYg2vL1e+QRh1/1Ibo3NrjSDRvUpFB2h47cqc0C5uYSwWsDaqeLfK3wpByqYXOGzQ3+RQVT+/gstLPEAUh9vr5WXfGmE8qKQgdvP4hI3XhMIyzpwP975/GKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+ZyeqVLVnVSGBccMcimpbQkmh6Sqz/f5y4eRFiv/qE=;
 b=gEDGARADve7YEbU/LB1KKlPqYDdLxelCZ7Sxs9mWnY+F+wU2ht0S15zJPpfkIrlENR3AOydJ+VN7WszqaBH8Csv+NuD8AXxiS5GdxUxASVLeGU9juER+GDG/yiHn2w4CPG12PtmyKH8CDY226+cFYizNdK8AqiJZbufCCWW5kTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 PH0PR01MB6280.prod.exchangelabs.com (2603:10b6:510:18::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 25 Oct 2023 17:41:48 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::d4ec:6220:2d1d:7030]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::d4ec:6220:2d1d:7030%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 17:41:48 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: Re: [PATCH v2 2/2] PCI: hotplug: Add extension driver for Ampere
 Altra hotplug LED control
In-Reply-To: <20231025172237.GA1754650@bhelgaas>
References: <20231025172237.GA1754650@bhelgaas>
Date:   Wed, 25 Oct 2023 10:41:46 -0700
Message-ID: <86ttqe4n1h.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:610:56::33) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|PH0PR01MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: e396ec66-e606-4139-0669-08dbd581a9d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baiiIFJIc3BjWJH1df/AiSZNyYf0ivFrtnZrasI+jt2tgvTECgTtGzLvo7SzWrBGkBDtPkKfVx9EejJp8qp1ih6V51+jvajDjmNPHO8h2E29gZJGyvkD/31mrOZbkV3qw9eB/FF8y4vZwTTI2sqGUZ9SpH/MzygRGjTPiAisIO+Pt7aulp+Uh+uRZyOQSAktXBvPRwp7J0uC13HD1EVJ8MDv+54IhNYZe+6RX4mVzUsKxMMHo5/NII4kLz3lXVuxplWzOao9UQCt96B+z/+ZtgZMhkbYoxstpL0X0TGuBLBmk0wBqK5qETXQe1Rn7ijXw3U8/SBu4ptV8SNvPH47cR/4pAhud61sXir62/TYl9l0SgC7jBgfY7iiIDf9aQlD8RocVIj5dgz81uSnab4wFgN7Bqc/qfjHTrxeFmWQ/NhFpgJMtUm9A5p4L3AbET7iEjW7vnJmhTBBfp7aOfcHePmIIJJn5jTbni9PN0dS2Je/c1XmPBla6qCcNFuBubF6jk42snUNBCCQmgbczDTVTyAWIyAJ5CqVwymV2IP+sBv8+Wvv0GfGh7QvmCWsq+C+fDRehqopTNC/kjf0Gb3Xaup188kqVs+kUMqiRF0UBPKr5HTyYbNBEHj+J4bumtpg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39850400004)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(41300700001)(107886003)(4744005)(86362001)(38100700002)(38350700005)(26005)(83380400001)(5660300002)(52116002)(6506007)(6512007)(9686003)(54906003)(478600001)(66476007)(66556008)(316002)(66946007)(6916009)(6486002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sxsyKT4MzSrLTKUNgyziOBhuO4wpgg754SgJ2KOFsH3yllGdbwkr8p/97j08?=
 =?us-ascii?Q?icQU3+W1xt1x7FUEs5arsm2btGJP2JqTc7geXNCldWFrjP/zkY/boF0PpU50?=
 =?us-ascii?Q?PViWi5dmomB2L4n1zt2GL10Bv1CjTLSldXAWKvEaXYMYrHWicag4IrNuuyK9?=
 =?us-ascii?Q?9cM2O/zP1FPMghJRBmukrFumbS8kHkse/Ni77HCK4BgIyXvfFdBu2jceu5AM?=
 =?us-ascii?Q?gTGzCmd14gaHmvEazwD/dCYpkn5fv9O1cz7n62HSGmAvMCtBsDouF0nQWY1D?=
 =?us-ascii?Q?rb9syp6zrse5QwqsI3WHyEtXLLN1AfWHi6w0OIzOEusFQLHNT+j+EVgQq87p?=
 =?us-ascii?Q?Qmup4aOmmwFKq1OwQ2kiCcFXHHkY5yf/YBEgh+aaJUeloEljMLPQVDUnUQzt?=
 =?us-ascii?Q?dIqn4YoAm8RWd8izR85oIQE9LS3XiHdDq1XdybMAv6qvg39J/tq+NFKOVd+W?=
 =?us-ascii?Q?xHKq3GdQaDOTxrvTesMI4ULfpTnEUPfVMJ7crc/4eRh+9DcPKnR0G5PqbL8Q?=
 =?us-ascii?Q?vXIIzI2iCuZG1kMy1nAAP7GlflxhONvxHDjL4L0TVIBkfC9YuRDQNxO3bGbE?=
 =?us-ascii?Q?wX+N37qEJjdWX4jj7rWKECCUpbFhOk7DTeKIl+WDTk2u5EOVnVJ7rN3IYhFH?=
 =?us-ascii?Q?KvtFAVl6R0FGbVvoxRo6JSF3vQzepBQze2LD9OCeQfi+aCRK+QYn5nmyfrZB?=
 =?us-ascii?Q?qMWyMX/4sloivw9Usm2qum/KRmu3/S9PnQU3oc2sRmpq4TYkdxuRY0zPIwLJ?=
 =?us-ascii?Q?c3y4CtADV0zzqYmqw+Nt5gV0n+u4zmCyORoOZahX1m4D2NJ28k1dGPGY5K7m?=
 =?us-ascii?Q?hGxwBbWmvyfWZWJ3QVoZ1NtV2/2b0m6VDPvhwAi/FLivxSeMDybWjZH0AYC1?=
 =?us-ascii?Q?6gpTs72UTAElzMQsDgWvLyfTdHiGStvOJOfRto6zgVAN/P6xyV7+I4eBFVhW?=
 =?us-ascii?Q?Wi6n/emj2rS7uFaByMe2LMKtTE3z8ncedgk4pY3jIEpw+LyTH0KfCQsYa2G8?=
 =?us-ascii?Q?yTce3WEkHkaUywfAgxdtWQCLbRWy+cPJV4FWs/IeG4tEnC9YqFX/qgkqrgBC?=
 =?us-ascii?Q?lGmDxBqyh/0SQea9raMh+u9+62C3huQrLDX7K3Ks44fz2w3ncpo5pVe7FbUt?=
 =?us-ascii?Q?mOUdphLqFhkBQliPj0oVBOl3MwcsEnS4L7OcmxHnf2+Yp3QYze++l5ixKdNY?=
 =?us-ascii?Q?Cp+nyO/8aXGUFT28RcUzUCp8E25dVJ2u3DeWX8KD8rUWLZ7jCZ+S7hdFJXw2?=
 =?us-ascii?Q?pkFaNG3J5keuBsACsxKGuqCWxsVc89KyW8p1NljtfitkjeJdWuuDXrB64G62?=
 =?us-ascii?Q?AIeL6rq+ieIS+77gZLVt2Kjf2x7uwnJvxvHst3WfzLH4UHHDNg29KE+F4p1D?=
 =?us-ascii?Q?qEso2qEVapwrX39w0qSviW1Su33j2Ch78Qwuj3tMizfL0W79O1xj5/x5AQog?=
 =?us-ascii?Q?P1kCxLjHjPE4Rotqvevgxb69i0EAuuvcYd429YQIiDHGRpsnXiFTqkMJPCnZ?=
 =?us-ascii?Q?krk/71xR7VSRcSRGQP+7GcjHwkMPKQTRHaI6hILJo1GZn7a1zez+xJnWJs0K?=
 =?us-ascii?Q?w3974stHuOWgwtkbniczbifR1LQiGujcOOKUpUgLz8LlI1NTcXz6B5RA9ZBC?=
 =?us-ascii?Q?xQMmwkWmiTcO4ujjnTNCMus=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e396ec66-e606-4139-0669-08dbd581a9d5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:41:48.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5IxGWYTrBKUT+BSJfbG9M4qgku1E3phyz9L21fZBKCh3ijSdjU9/TFOWfLgSfFdAJLnQkJb3SemhBbfCPxvQXbMGEGowZvuYJcGlpefArHPKY+Ww/epgOn4oyPJ0ARY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6280
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Sep 29, 2023 at 05:20:36PM -0700, D Scott Phillips wrote:
>> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
>> also present to request system firmware control of attention LEDs. Add an
>> ACPI PCI Hotplug companion driver to support attention LED control.
>> ...
>
>> +	arm_smccc_smc(REQUEST, LED_CMD, led_status(status), LED_ATTENTION,
>> +		      pci_domain_nr(bus) | (PCI_SLOT(root_port->devfn) << 4), 0, 0,
>
> pci_domain_nr() returns "int" (normally 32 bits), but since this is an
> ACPI system, the domain comes from _SEG, which is defined to be 16
> bits (ACPI r6.5, sec 6.5.6).
>
> So it looks like ORing in the "slot << 4" clobbers the upper 12 bits
> of _SEG.
>
> Is this code doing the right thing?

Hi Bjorn,

on these Altra platforms _SEG is limited within 0-11. I can add an `&
0xf` to pci_domain_nr() to make it clear that the segment number is
encoded down into 4 bits in the smc request.
