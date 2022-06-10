Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A875546AA8
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 18:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiFJQiJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 12:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349691AbiFJQiH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 12:38:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02896580C0;
        Fri, 10 Jun 2022 09:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NITkyl+nuvXK/PJXdSxJR/kyLWbdND+BWxDV+1bLCm2QOBCSHITRL/SZo4Y1/yFvPv/LFCl7TV7iJPoJ1JzC0d5oWbV0F4XYgvI6LpJWbRemTBwR+WpoJMB+dHH5ew+iiuMLTh/1E7DFG4LExce4api6FBTqpP9GH+24rTWICZXMS/PUtw1xR5Uu6aIRzHdDJxcr1aZtMJyYyLcibOfrYG1p0lztchW/oIgOxSErJG2G7LU/EDRNpgJT6//wCwMVJ2M5pf53X0LhfH3H1qHpRbc6YgM0Sxl9DqoL/G9J4eHByS/dXlD/T4MlvdEL5fE0DmB4ZT1fONtEI2WPxMUICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKfC3Z/w1xL5fNutnbcL9Llj7lKZMFsWcEmOFJi+nQY=;
 b=a6TKCEkzcPSAXgN8OBv1sEEoFvXsWWo8uD4Oq2eB6gdeLqeLNqQcObea6Owo8EjzjZl40hBzP0DUnqLC/Aj5og9vT7mnkJYnK5zPXNGpevPNBU/W+QgNhyas9xlC8hKzzCe1A7n7miJL1gzUwoRWTXEwf57+Z8YQcqn/3WLukJvwS106M9sXj+1sxEHmRpS1Ee5x/VZgTQBDCkNC8zuj16XS+Y4u1zPVKNcXj8NSYGugpsI/3c2s9osDPZWGKbf2J/HAgQhOW6mP9rNimYJh0O4OxhCtU9RtUYtJW1wv1qDxZ5SC7QFpZhVxCFVtqZknkhzxrfBWrzcJIkTIKRVloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKfC3Z/w1xL5fNutnbcL9Llj7lKZMFsWcEmOFJi+nQY=;
 b=l2Q/ObOZGwPSNVg3KMRx9UlRiD9z+xSAMAkl5jbtBsmpfjupSUD20w/2pyoU8Xe+6Kme1a6dy/RfuPMWh4lqZGWeZmqXi3UptVyWTCL74IGBnnS+K69U+rcyWc/eu3F3RJKobXGi3Ei/rom9EOQN3C3vJRhBd0s2szeGhf05fGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1572.namprd12.prod.outlook.com (2603:10b6:405:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 16:38:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9dfa:d871:2068:662f%7]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 16:38:02 +0000
Date:   Fri, 10 Jun 2022 16:37:57 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, babu.moger@amd.com
Subject: Re: [PATCH v2 1/6] x86/amd_nb: Add AMD Family 17h A0-AF IDs
Message-ID: <YqNzZThbFwDv0+30@yaz-fattaah>
References: <20220602201137.1415-1-mario.limonciello@amd.com>
 <20220602201137.1415-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602201137.1415-2-mario.limonciello@amd.com>
X-ClientProxiedBy: CH0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:32::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49e72692-f973-468d-c023-08da4aff9625
X-MS-TrafficTypeDiagnostic: BN6PR12MB1572:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1572702ABBEB6D4D18F39BABF8A69@BN6PR12MB1572.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVyDbmHkTgQDFR337IWtu9we6uT7OasaCQuu7VEz8CFOdTghvaxfnADdKo0+3HcNlurs46cWjtVNz4pebZfPJRlcOufJll32r6mk0pCtmWmZHOJh3r8VccK9K2cywl8hMG0ofUouxrw3dwEACjh7tYKhnV/ad8Y3xKIdWqDqMElxiNtRVwdsqS/ZQJwc2Qx0/a6LoOPsst4ouf/obtdQqJw0oG/U7VhD3mvfAC841nPughaMiJQRelR50ABODqC0qpys2oIb3iKrLLV+vf6fOEtfgBPHw4JNLCcwWJHlcu3GIhE8tXIS/hXvC3eKOdSkbNw1uRwf02tj8FZbHte+lb9Nz6wxQPD+sB7Cro/J55AyRByY+YlxkSJQXeoYLf3HvYqFOFl4iIBzaXcqrPwK4hfEsmp7Jb5JFX45qWop2HUqQvrt6HufCYzEIZxjHZe9hHoIu0OLDLD6QQhvZFrF6Bn1VV6S3R96crUWrCxxNK0SIBm0XrGKHBZwbsEaF/U+tg8u8Xm/SpvDoP8+HB1AFhphq1nBUTm9rBAn+8pb5vSKrIAkH4Z2g1FSUq9xrWssicVNihXySOTMlZ2EGfVACT0rNlCV4HjLaDXmkdp0qzNZymfT+qs11EcaVESBDwldJ5SxaaO+3ekidqpIVmTyWuNM2eOk2kOGcztnDF5BKfxeadiaWMjhy9dCykgkcXDb2z1tr4/DND9H0znW+FgYbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(5660300002)(4326008)(66946007)(6862004)(2906002)(186003)(38100700002)(316002)(6636002)(66476007)(6506007)(66556008)(6666004)(508600001)(6486002)(8936002)(26005)(6512007)(44832011)(86362001)(8676002)(33716001)(54906003)(558084003)(9686003)(7416002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a5JY4jSh4dPEpFhsbcjQjU42P9JzXavFPsOnhcOnh1FetaMHz1LRpg7I0EnX?=
 =?us-ascii?Q?CWkDRmwtPxfRe/4mEYDgyPIsQYZsppTXg6UWYetQScSoQqPevrXHjAD8Kqt1?=
 =?us-ascii?Q?YlFToLoYrjdb/1I6bEqlXafhbxobqWU7D+gg+SaB3p5yQB1ahKDWQI7OATM+?=
 =?us-ascii?Q?Pm78fG/3GtaTbV4TwT3FnBG2DE4Tde1Amj3AOBJNqGX1CVZ8bLkUXKNX1uo1?=
 =?us-ascii?Q?iId3eIhE63dYqGmnfW9NS86ab6lHIePQsLBhERr9K+7ChPMp0/PfWeXlX78Q?=
 =?us-ascii?Q?oF+0dxzUUsC5Xd2a8iU0Ntva+kd7muf03xQU9/EkdUuf/2gwQ/cvgt9xpm2y?=
 =?us-ascii?Q?HU2pVNQ3IJL4iMcD2cJT6jOj4pr9GsA+gdOFvytHBBNY8RPt0Db7aRZ6AHg3?=
 =?us-ascii?Q?yd5K7spbWSGTMB0pg0UYZYQ2N5zKU81ofgTombKyKSOAK6ikHL4CzNQpUnAq?=
 =?us-ascii?Q?1lrPXfB2THpD1ZzSNcjfEHDDeU58PX2nBXZSlRBIu676sqho0sWXJ+ddRUg7?=
 =?us-ascii?Q?JFYXbUHREG/FEKCkw3o3fYTeVxKufZ2UxfaCYazYiMEm3236uWmGZCG0CWdZ?=
 =?us-ascii?Q?8fuv7jC1OhMpXxsNrthSAyP6VO9pcDqq7DDkzzdKZT9B2XeT6y5ztn200JTL?=
 =?us-ascii?Q?b3EQHAy8Li4/8O1a+GIY2f6a2MjGBhI4ont1G2mggczzJzbLNKMlsZgTEMZU?=
 =?us-ascii?Q?cNceZNDqSrHdyY9MbS5OgpkQgKSzuFCnmm3uurdvwGSh4lVLP5Kip+b0sOzZ?=
 =?us-ascii?Q?pGsldZR8r29OtTG5hJ6nvJNm3elSCdrzeeO7QENTR9Y85pjZyhIN3H4RHoS4?=
 =?us-ascii?Q?1wbMTgMqekMXKGZX+PtORV1VOJUbI0eH7vdSCuo5ipvXu2uXD/pVvjtYQ3F3?=
 =?us-ascii?Q?+UAb1ZBqxfalMHvSkIt3V2O2rSBdPrpQqqAVPF7x6I5kDGDdXoX3o0UHR5TW?=
 =?us-ascii?Q?RvkIPql+A8z16O5J3/mj8Hmq7OoHyVJohOmLlu4SITRN9VjocX74ntGlXNZP?=
 =?us-ascii?Q?348YXbM/5GTX2T97Lt2evoDeenYOyALclUs986OBCPRBRxAYTaANgwIbkB1T?=
 =?us-ascii?Q?7buw0PbDUhUHtGexZFb7l/1bd1r6xwJqUkWV1qB3VDC8BxwDhgkbxeGPRF0K?=
 =?us-ascii?Q?5A0pensYX5MpojDo3t3v5/Zh9pGlrrNEuWv+S6oya0tmAbs3O20rmCVEIhX8?=
 =?us-ascii?Q?4pADJGGfttDaCy1Bn/BWuZ7orcTyOcsfmrt66YWD2u9ZeALO7NvEgKd3ap6t?=
 =?us-ascii?Q?Eok8aoxMvFWp9dgsOHyoD2nEQCZs/2tgTzot9WjqlVQogGYgmbnOckjJ8jcg?=
 =?us-ascii?Q?rsRZ9DMa4s2K9vp+qfnnQzzT1GD4sZJSYAobuueXizhO/yIimRcHP7me4YEz?=
 =?us-ascii?Q?iroxnIUN7WTTyBXqK8oRxS9J8uT99U7jqVYKeyIiU8ILPO9+D1AcgYKw4eoy?=
 =?us-ascii?Q?FQ5hDXTT/DVqEYtVooSot+BVEnjRRChB11iBRTOzHy1BB8japF5qJ/GSGaTv?=
 =?us-ascii?Q?xXPCQWX5LJA/r3gn5Mm/0QzNiQTv/jqoKYr5EjeIMVpLTX6p5JZ6p2wjmByL?=
 =?us-ascii?Q?GipjvoLIR23EUckB0bMGl712x9wR2DTZbOnONvlQWLZ50PDSyKieWP532ioe?=
 =?us-ascii?Q?Bx9ZYDW8lYLf1r+UF2gxjZTvzfOSrqu++n17Lac7oS/AAcE+Rh9oTV70/Ioe?=
 =?us-ascii?Q?C1mqhbZXGpESv9SeDsAPm4iowom47otYOo5CONP9t/K9VnYjSBpkI8boqeaK?=
 =?us-ascii?Q?Ou+H2IADoA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e72692-f973-468d-c023-08da4aff9625
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 16:38:02.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1ybOGPnLmzXXUCic9P30p5UP0S1VvnORsNYM2CAPvqMNJDR5yB/qG+G+0z52RewXedgzS+t6XPFVy9ODJLUSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1572
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 03:11:32PM -0500, Mario Limonciello wrote:
> Add support for SMN communication on Family 17h Model A0h.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
