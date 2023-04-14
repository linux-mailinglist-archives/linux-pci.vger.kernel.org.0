Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1780A6E21F0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 13:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDNLWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 07:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDNLV7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 07:21:59 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5AFCF;
        Fri, 14 Apr 2023 04:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgYt4OpC7HS+nE5XqZN1XLvp3CX1ZYXdqodsG92+eDfxjSHiZn9X/CtOKAjp5AKQ4UmKaLdAXOJM3C08imLWyCnxIfyHkxKWeyYIJ4yhHs3g+ytwpxvs6SFASMX/M8pYv+o7I/P2gqBAipoJppv4VpIaP5UiXwnZrwjftw+FNbT061ELqUynLVWOFXwm8IH7Y+Wg9no8R/7w4En/KPDTL+uV811u1hKr54ApiqWxDgJqZ0lKa5+2jrjlkKnUCFTfAtIV3USVXUH3qgmpEreGcHmvDebNXD2Spb85Bd5UGXw1gheRInP4Ohulz8TH9OYpchLXUooYPj243j8peUfWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6c/zq0fGbrK8b51V+19DhwcLK/5pilgWfZ/i8zJ69E=;
 b=ETxb0/a9sQ90mMSA5GsMugPx5E92c2e1QJKx8apzu+Zsmu3TLVcgAx42fslcECXrzLqVQB7kUEGoPlxM1EzD1Yno8qwacXVk2TX/F14h8HFkk6QTJMFcudfiSII/I+tbnKjtjK9YBsiHWmFC9v9HfPHuFtjEFBXjBzQ5CiBIwgFQBuiHU5fDuK5HCVdc0P4k7ibEn075tq9pc32CJm2k647NIXr/g/9VY/VcuyPM3kkBlUm0P5RfCqKH9eYtMx6kBlqNAzyjjupSxS4dgazd+s9LPGaRQEMi8VwRZBIOYz30QSW3/7luZvVDIXRr6leLjOXHyXLUQzTMERP1oXwrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6c/zq0fGbrK8b51V+19DhwcLK/5pilgWfZ/i8zJ69E=;
 b=A3whwXozY1CoQaGrJYCmIUwa9fY1JQiH1xnXOJJU1UzALQs/PYbYzpp1spaCUT5XyCdg+SGUJkQMFHcbmwYJDICe1uql1qPPPIXF79GSv/SGp63imMs1b+ImUKbs/CtnVVVB1PEdXqFdEx4JLlnZ6hrKc+Nb+FTK7mZA0cnc+8k=
Received: from BN1PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:e1::9)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 11:21:54 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::cb) by BN1PR12CA0004.outlook.office365.com
 (2603:10b6:408:e1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 11:21:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 11:21:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 06:21:48 -0500
Date:   Fri, 14 Apr 2023 13:21:37 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] PCI/AER: Unmask RCEC internal errors to enable
 RCH downstream port error handling
Message-ID: <ZDk3QeWZDOP8sr4s@rric.localdomain>
References: <20230411180302.2678736-7-terry.bowman@amd.com>
 <20230412212901.GA81099@bhelgaas>
 <20230413180122.00007471@Huawei.com>
 <643887b44b2d4_3a1882949d@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <643887b44b2d4_3a1882949d@iweiny-mobl.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|CH0PR12MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a70abd-3998-4231-22f8-08db3cda7392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzix4prmwlCEJND1FM0/GYC/b4UGfBoFnPdI+KfHYKTXGbz/Uls+75M2ejuswKu3iDXN1YBLIb7sKENkJMQbrAhyHbkuNTjFYcVkoEZQ8ka3GTnOub2YjEq4UFSgd+6Hchjq5OKkIqly2FYgd39E8m10NJi5vz8gEXKn0LW8/HaztFAgqlDKpobc2GyzFys6qs9dgeWf4MS+OcSaXKyooyrNjYEjSociQHx6zjaRFnh6EQgVswZmW1yr+9qmdLIWskjHQuzmLnUtbNh7I/I/PhdqlCzSqErkgQJWwqlhkIS38pk/P3/J9m3d5OB/KXyzrBNr7eiDlrme86g63qm8pa/ulbL/9VGiuupiPzW3M2iTAUlnpxi7Uh3fiz4JlR6D4evyD50EP9Af6zomnmDey7fN/JZMOvjpCi7JTxtpUxDqikiokcG8ejihwXBY3+IgPQbpXCib7mWHHWigWG3Uyd+Xy5d969cWzwNSoQFkxbaG3swsBRo/oP/fms9FLgi5F+Jm6T6A1IwLRQBMYAErpbL8pFVuLwrDDjxJRwVukDGEem38jq0yRBujSfz+I5p6bB4PsIYlm1CW75NyXZNSCGqw0hULifTC0rpOm7l+SASzXOIJ8L3GaCBBhLlZOln9MsBQCtBkXjF9NSWFCe1ZpNPxH8Fw2INGYqM4V+jYr9VLmimQomjuufb7Dl0nHtl8h7A1zqbwAQH85aKVxCtwZeJKW8PY6zIiYRCbvKqgxCcOwzhH0MhCQzxUis2XvRR8urapQdN8D7Bl2I1UL6GV0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(66899021)(36860700001)(336012)(70586007)(5660300002)(2906002)(7416002)(316002)(8676002)(40480700001)(55016003)(8936002)(41300700001)(81166007)(356005)(82310400005)(40460700003)(6916009)(82740400003)(4326008)(966005)(426003)(70206006)(47076005)(54906003)(186003)(26005)(478600001)(9686003)(53546011)(7696005)(6666004)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 11:21:54.2082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a70abd-3998-4231-22f8-08db3cda7392
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 13.04.23 15:52:36, Ira Weiny wrote:
> Jonathan Cameron wrote:
> > On Wed, 12 Apr 2023 16:29:01 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > On Tue, Apr 11, 2023 at 01:03:02PM -0500, Terry Bowman wrote:
> > > > From: Robert Richter <rrichter@amd.com>
> > > > 

> > > > +static int __cxl_unmask_internal_errors(struct pci_dev *rcec)
> > > > +{
> > > > +	int aer, rc;
> > > > +	u32 mask;
> > > > +
> > > > +	/*
> > > > +	 * Internal errors are masked by default, unmask RCEC's here
> > > > +	 * PCI6.0 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h)
> > > > +	 * PCI6.0 7.8.4.6 Correctable Error Mask Register (Offset 14h)
> > > > +	 */  
> > > 
> > > Unmasking internal errors doesn't have anything specific to do with
> > > CXL, so I don't think it should have "cxl" in the function name.
> > > Maybe something like "pci_aer_unmask_internal_errors()".
> > 
> > This reminds me.  Not sure we resolved earlier discussion on changing
> > the system wide policy to turn these on 
> > https://lore.kernel.org/linux-cxl/20221229172731.GA611562@bhelgaas/
> > which needs pretty much the same thing.
> > 
> > Ira, I think you were picking this one up?
> > https://lore.kernel.org/linux-cxl/63e5fb533f304_13244829412@iweiny-mobl.notmuch/
> 
> After this discussion I posted an RFC to enable those errors.
> 
> https://lore.kernel.org/all/20230209-cxl-pci-aer-v1-1-f9a817fa4016@intel.com/
> 
> Unfortunately the prevailing opinion was that this was unsafe.  And no one
> piped up with a reason to pursue the alternative of a pci core call to enable
> them as needed.
> 
> So I abandoned the work.
> 
> I think the direction things where headed was to have a call like:
> 
> int pci_enable_pci_internal_errors(struct pci_dev *dev)
> {
> 	int pos_cap_err;
> 	u32 reg;
> 
> 	if (!pcie_aer_is_native(dev))
> 		return -EIO;
> 
> 	pos_cap_err = dev->aer_cap;
> 
> 	/* Unmask correctable and uncorrectable (non-fatal) internal errors */
> 	pci_read_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK, &reg);
> 	reg &= ~PCI_ERR_COR_INTERNAL;
> 	pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK, reg);
> 	
> 	pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, &reg);
> 	reg &= ~PCI_ERR_UNC_INTN;
> 	pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, reg);
> 	
> 	pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK, &reg);
> 	reg &= ~PCI_ERR_UNC_INTN;
> 	pci_write_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_MASK, reg);
> 
> 	return 0;
> }
> 
> ... and call this from the cxl code where it is needed.

The version I have ready after addressing Bjorn's comments is pretty
much the same, apart from error checking of the read/writes.

From your patch proposed you will need it in aer.c too and we do not
need to export it.

This patch only enables it for (CXL) RCECs. You might want to extend
this for CXL endpoints (and ports?) then.

> 
> Is this an acceptable direction?  Terry is welcome to steal the above from my
> patch and throw it into the PCI core.
> 
> Looking at the current state of things I think cxl_pci_ras_unmask() may
> actually be broken now without calling something like the above.  For that I
> dropped the ball.

Thanks,

-Robert

> 
> Ira
