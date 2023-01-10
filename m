Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549BB6643E0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 15:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbjAJO7U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 09:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbjAJO7Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 09:59:16 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3E75AC68;
        Tue, 10 Jan 2023 06:59:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQ+EPyHGzUaw4c+/AsBrrAv6txitmD2z+C/8vy+5yz3aSOs0gLHceCoMArLvbjDlSKcSsICpBpk4T7MWEkOxUE3L9NqkMNDVB0Qyckvj/9tiknuIjS914I66PwRmP1TOUCKYwud44fS24jsKXxxHvfxeyS6+epMQdyJ72lGvp8PZoH08XlP+B3W/HeRq9svuwP9CwTUTUlOyJPJ5Qe6/+RBU5iU1zTdzZ1Tmhoj+2yfI5y/RLBtjXn9FQmM+lrfqm1m2H99eOtEctkSjadTZVBSBUtRJa+GTTz2w970+fbCrH7KZ9cILHaYCeYM+glZtJGqAp0lGe/VWXjktgIK5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXThGQdOtuFxnm8Xv349C0gqGbttfZgXCFQCKkL9R/c=;
 b=frqEPM+0F2GbHATqcziQAj9jscuV4xYhyXqZLO5c3CUeRH8vLMLXOHY2SQPaPl55KGy2RlRzAPlH7WVgvuMADLmZfhBgvD4VYtg2ynxZHB7KVWTBLugey5qkWG3mbHRdzsAGRAZsB4W6kMThJn+xzA00loOoE1aa/ZYQXpL0eX2sP321YWJGr0i/vLVfNxKuAroGdvqI5LKAVQTUt+0WIvRnmGOAZW2RHAZLQ7GAA8ASuser20OFGrXAdHurAE976gt7w2MJjqm6gpS5eG5L1aklI0dhLmtEDMrEYqAh35Q0Ay4dMKyWcy5wSWHCbwE1jdmdBuDho03oM+uyDvSRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXThGQdOtuFxnm8Xv349C0gqGbttfZgXCFQCKkL9R/c=;
 b=clsIXPGKrtlVivSSWYIk39JPhnWYrc4FkLWjyYHpEhiEAxl9VNMEpVSGKeLtV8vTeyjTJzdgI3sc86U1dFCmrIDtS/anoQaWiyrJ58ekl8cY+oVd923G6Jc6EhP7Hn56/4CNAM91420k8K1LFicwsu5Fe5uXlzmsFe3tb/qyAShb0/i6r0rF01W8d5f6tRL6FyZvYrLsSATmCApr2Kzj3/jtW0xPFHh076O7dA4vt9MtxPvt9CYTTRglt5g4fX+nmryi+GvazcDbz88h6RwwZ7W70MYp0GhMftOD1uWgtmKsboRHcvbW9uRjgoZ77t7zwD6RLIVnFO2p7TgKEsC66g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 14:59:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 14:59:06 +0000
Date:   Tue, 10 Jan 2023 10:59:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 13/33] x86/apic/vector: Provide MSI parent domain
Message-ID: <Y719OcFueTg09OUV@nvidia.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232326.034672592@linutronix.de>
 <Y7VyXNbWMdWWAC6d@nvidia.com>
 <87eds2k2nr.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eds2k2nr.ffs@tglx>
X-ClientProxiedBy: BLAPR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:208:32d::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f0b5b2-f86d-4777-833a-08daf31b3890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fsj8eqNjpSUEv6kYvqSww5eBBaa5gdQCxDOo3lYioVE1joI5hIHNkx5PXqmDRd1d5pCoPGGU8EUi/U3TLgfxI6YBmywf/XycZ4zCXvbJ6in0oARniHALMrsUGL3Fk3aQn7j1sdCSwUOnexeRyfAZAzIYyMtOiSjO5mXaD9rdaKI2vmM4d7AJoreECl0TWmW65e+E5FF+lxquA/szjCcANUU87IeHIXeelnDwyN7C+WOW18phayezKGAGi9lE29wKzfhc7f5LfPkV+KbMAdQ0vsstVc/aOzo8kZVEIl9qeS/OWYmxgnFjEPa6BdWtvmcLoZFebzNJhOzrSOhzpEdW1YKS3M5RDM6yN7r+wRabCDLMK69LIrOUeVuNk6i+iaPfCYtbFSEPYVaqPY9Xc3TFpfVlXEI4kIMqMn+gbpDCR2rqNrFVXhkhmQ0TmIA68f06pCxx8O4Fg/RLSGCodp2lSE7d3rBQeLbfObupSQw4kdNOOPRkg6NCOKC75RXQRqx8xtEIxqCp4RrriyuV40JHf+ZmJJBccRyz7oPG4lClyIH6SS0hxe/GFUK9R/CHBcAGvbk/Cmu2YD5HqXmQh6uTSK02v/D1+YLOWsrNT75/vBiL5R6HzK3C3L9oZydHalnDZ3KoufKR56CDjXoc1G8mDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199015)(6916009)(54906003)(41300700001)(478600001)(2906002)(38100700002)(316002)(6486002)(6506007)(4326008)(83380400001)(66476007)(8676002)(66556008)(6512007)(26005)(186003)(86362001)(5660300002)(36756003)(2616005)(8936002)(66946007)(558084003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOJ+eYHc0oukKHh2zR5c3kA61WhmzZdsv4ZxHPa5Z3zE5VGU9hz5luyMqMRs?=
 =?us-ascii?Q?V60Z5Ym1RsmcGVCZd/xM4SYuWGp32LCbyDY40LLuIYkTwTEAQ+zQ9VC0QHeP?=
 =?us-ascii?Q?ip6e9I+iHGFISzBjmI3vQwaYMMnar//kW/NdLgFW3Bd1CttvHIpMbONt/Vte?=
 =?us-ascii?Q?+saJC9viC5jJCzFkEfZHI6dwa706vt7kqmCvx0pyh4bXb9GEfaiiMWfQl1Z8?=
 =?us-ascii?Q?k04KNXaAxZaD4WHTiBg2p5ZKTI2c6xnjZ3/9FI/LosvLZ4iouOHLkBDz+Rim?=
 =?us-ascii?Q?3BWa8PJIhW9vZ37UrW0ychV5A/knJlSFlSQvZi5Rap1FxOiCBxc/ywAnK/p4?=
 =?us-ascii?Q?Za4JC3nVfXW2OkfAlvTZWOF/Ja+0mi1Y6OsizhccEsQq8H91Hlxdlg80yS7L?=
 =?us-ascii?Q?OUpxqZo5tXlDVFsQzHOb14aP5akt8I7qUSH9vm4sq68d5bdwL11SHn1bvIM+?=
 =?us-ascii?Q?JrJn0alzBsBiMAFTPx5QxPqCaAFu8nvN050IQ6dPo6M+1Z9KIO/isKM0ErSc?=
 =?us-ascii?Q?I6qKmPhZB185aUcikt1qwDd0EEGpRNKkass09XFWip5HqTPxzAKJtChUqsFk?=
 =?us-ascii?Q?TXuWYrEJuWTTxn1keaADeereS6APsgP/9GoY0pvXrgo3h56Sv3aG/9F6h9ls?=
 =?us-ascii?Q?atJFN9yKX9bNWKYBkcMUuAW3aZl916YssVgiG6u0Rehozf3sADFdH5vRIrvx?=
 =?us-ascii?Q?vgTXqZ5TjL4tERs7p01ZPJG3CwjPQaInc2I7krpKvMwHGZIFiTwwW4ZEMGWw?=
 =?us-ascii?Q?yk30YjPa9DAlcd9ebNT7SU+Bo/8b633ORMP+sUiGIhxM/HaKyHIbJzYjulEV?=
 =?us-ascii?Q?nbLSLjZQG2OKBT8/fQk0cRFAAt0lxmfBEMhTAhW3d6X7iV0KRAqdf+FEDJCR?=
 =?us-ascii?Q?34kZwmgsr19dm/3bFQdhERnCGYz8A8t2RY86DdG4F1o7FCiUJt/Bq77MeRZR?=
 =?us-ascii?Q?4cpGt9ZhVX6m8XY1/55+dcNnNQpTbf6z+qjMH3Zu6t5G9q0wwSPqSTGBQkef?=
 =?us-ascii?Q?lVby1jTxGylqT4FKKfo5TZAUtS5jU10tQuBFFonuCG4u2ApA3mC0/LUOaoS3?=
 =?us-ascii?Q?0XEm0OEjJlr/9Y/EiPxpIRQiUEEEyPMbZbc9CUn5BUT6iOaEsaaTX8/E4Rkt?=
 =?us-ascii?Q?v7UZEI/KkJOulK9E/t6k06J+OnKMKMo/ogbHxTRW3NTC5aqKm0xZImc3I9Q3?=
 =?us-ascii?Q?oIU1FxzCv/Yox6NVrqYoz6eBG6pLK74GA4TkhFmE7m08/EUDRvB4D6yPuGLV?=
 =?us-ascii?Q?jTK/548qsO5HsZvxxLhKvWChuRacm/CNS8STIX3dZ5XbPJYalT0vDMYt7lMH?=
 =?us-ascii?Q?IUdkcBUIiu8AJtnsWPDcO7G0DU7MHhdr3GayzeNiupU9W29KLdGzd+iw0Eds?=
 =?us-ascii?Q?bHtUdIzEmLy2aHB8v72u9MbmQXVH7e0bPpVTLzJiPnPrPVferxokDkvfc2zI?=
 =?us-ascii?Q?byWZCtCUNCJTTawTrB7Ny8CelrqYrvCNiEMJ03i5wYfaJ3FD5L7BOlbz4S+s?=
 =?us-ascii?Q?k2GfAcFrq2dPDMnS9fU8GHZ4CTfVUAXrz5qQmLO6B3tNtf+UcCrXbVbzp6nE?=
 =?us-ascii?Q?28qYZn3+HRQV73yBdhr8VSBmJfEFuBdG8I6pthtB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f0b5b2-f86d-4777-833a-08daf31b3890
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 14:59:06.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wy4Dl6tYQ/YLJ5KSRh1jbfFZF7NJdpIeD0gA0I97+FzljdvDl2bQ12Qcroc1v7aK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 10, 2023 at 01:14:00PM +0100, Thomas Gleixner wrote:

> Care to send a proper patch with changelog?

Yes, I'll post it in a few days once the test team confirms it

Thanks,
Jason
