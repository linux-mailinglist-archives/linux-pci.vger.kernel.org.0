Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C336E260E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDNOrU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 10:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDNOrT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 10:47:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7BED;
        Fri, 14 Apr 2023 07:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQL/PCb9VPs+RcCDp5eDSAWPlHwujoPi9up6xLYPdyuI8Dnay2cQwvOdzJvSODH/DL/2kc/elOsOJ5YewHysC/m7B4oFgGXj6swuCG2lLq9dVAg8OJ+EIh2Weu07hgFxaWZrJgnfWQyfxQivKk5bHVHjY8U41zZm8TL8B6O2XYWKth5fp7Bb66TpOnV5ptClhzh34j5p20Xfzjmqzln7CoQ+gbHhATuMTzAoZpm2rikGGMCMmeWQiTvnT/yl0VuXfl1EjYMqNFygHM7V5FWwp8/6m23SuYKV84ZaTSdTn5QDBQhho5SUNgKU0E8/HxtSyvXNByeVj6pWctmx5yQKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZQUG2MY/nXg0fcUgEjVcUWg9wp3JkH05T1ByXAkllo=;
 b=YlBsTVRveJQtcN2TMYtnO0DHOitL4wu7/7Wg1pMkKiCmMOKt7Obqldq7gnwpDRNR/rAyXFp7AFXotMD+M8DbtBJ8hXeuBpTH/PbQK/Vu5XrixVR7UFVbYZ47yccfl5LWyvzcWO9BUP9ckyHYzd/ASchSMNOIhzDYARBTd547B14K6VEbyALkbpWo8GyXNOJyy6J8XcGuuXyEgOgLW6fBcn5xQN65IvUBnY2AES9SUigD1Mb9tgqVwyt9yzyF0gjf+gsUj8UgYnfr+bkxooi8OWvC8OP6cKWlg/gNhpDzjEBBuQE4HGSnv6DAbcux2jscN2bWIe6Tpey1Olfb+zBw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZQUG2MY/nXg0fcUgEjVcUWg9wp3JkH05T1ByXAkllo=;
 b=LSk2lXfJLhw9pFY1gDhqrFxFmsG7xiMkdEwAgrgwn/6clOZoQHAe0Xzg/1439S9XSja55ZHBEH2sS1uGBoAtEof5hsLTmIijiIjfTlOYPoPuw++PiXTpHHmvsQ4iDQ/gsZK/y9PolKB2EFCV28HM+up1EJXLJkIR7tccqwluPL8=
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 14:47:15 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::bb) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.6 via Frontend
 Transport; Fri, 14 Apr 2023 14:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.31 via Frontend Transport; Fri, 14 Apr 2023 14:47:14 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 09:47:10 -0500
Date:   Fri, 14 Apr 2023 16:47:08 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Terry Bowman" <terry.bowman@amd.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <ZDlnbCYuUTjS28K9@rric.localdomain>
References: <20230411180302.2678736-7-terry.bowman@amd.com>
 <20230412212901.GA81099@bhelgaas>
 <20230413180122.00007471@Huawei.com>
 <643887b44b2d4_3a1882949d@iweiny-mobl.notmuch>
 <ZDk3QeWZDOP8sr4s@rric.localdomain>
 <20230414125543.000021f6@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230414125543.000021f6@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SJ0PR12MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ec6d4e-a442-467f-96f8-08db3cf72300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ydxbj1U7XQhqU+UK9gHk5L1WI+WvyJnjM1SrWv//fMXyiZNJASpQiOAb4PYASpJm+a1luIObqmI8Nqp0ysjMzBV4ZtzYfpN10KDHmFkTlRn8O0MK7SJqhUd4/iUi25J6DIuiHchfYWAY7VmUOSsyfZW8W0+KHNYy/4RKFHrfk2WH+ftIkgKc9yKrr+PSjyiukRlxtFqaZx5Ywj9bRLpc0ucaWyrOvpUy4rGR4LIFTmXkJ7SKxgRC9goEJkFvRFXoB1eiOMyw8h9MLTosBL7WwXmAvFrWOOoQguGsOVDj501usb81dHRlxxT8H1ZPyiveJkQrFQ1Rv7lX5t7EUfgN7GCyam1JmpCf2prXGCuJ+1PiS4aiNdP9CCTg/z6crIasdv7DoJ0jDQlS6OKgRgctTZEt0mPIHz7+uvqYfMlMeYmNrhsPAdiAz4QAJNy4EBqsdtOw+JBlm1nup06YLbZ1UZYcI91oMGi7DBQqpVOaM7MoSMaIHoeKzx+8clhPzVki8+OaiTLeX4iVpmCHUvqNXKndQZKmB9iDoaeAAvnA80WVxmZT8X49VX949mY7J8hx8x5OVlSh42sgdVJhhPOx1FzupBsRw7gybe/xZTnRozRynhSwm2plM2y+AiANFgZf70/NeIPzXdLrf6HQHRBfur6PgQCZ1K0Hbnmz3Ateu8oNBZrZPuV/JhFQxG2wW5SEiDckTkqzyiFYlf9Jqm9cGDcBYVlFryMSQdWW56AhN+U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(7696005)(40460700003)(5660300002)(4744005)(6916009)(4326008)(70586007)(70206006)(2906002)(7416002)(81166007)(41300700001)(82740400003)(82310400005)(8676002)(356005)(8936002)(316002)(478600001)(55016003)(40480700001)(54906003)(53546011)(9686003)(26005)(336012)(426003)(36860700001)(16526019)(186003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 14:47:14.3324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ec6d4e-a442-467f-96f8-08db3cf72300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14.04.23 12:55:43, Jonathan Cameron wrote:
> On Fri, 14 Apr 2023 13:21:37 +0200
> Robert Richter <rrichter@amd.com> wrote:

> > The version I have ready after addressing Bjorn's comments is pretty
> > much the same, apart from error checking of the read/writes.
> > 
> > From your patch proposed you will need it in aer.c too and we do not
> > need to export it.
> 
> I think for the other components we'll want to call it from cxl_pci_ras_unmask()
> so an export needed.
> 
> I also wonder if a more generic function would be better as seems likely
> similar code will be needed for errors other than this pair.

There are only a few masked by default, but not only internals. Will
consider that and also make it easy to export later once needed.

Thanks,

-Robert
