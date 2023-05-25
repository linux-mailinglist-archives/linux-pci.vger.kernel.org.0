Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B88711926
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 23:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjEYVa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 17:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjEYVa6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 17:30:58 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7947910D4;
        Thu, 25 May 2023 14:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnTSF197/88nJhCaqAQ8FqnBcjhGbWAS576b9ZIJRz5q5lTYXFvIrOwxfTx3CqQhuHnpgZO2Kyi13KE0R4CPjVf3EEnpSYD+kLx2723CB/cpGFN5rvqRBjmjAcSWrIMvotHbjCk9PiAUVESLpAjcMw8bCe4iaW8j0MxoY7EGon99/uQJm+oYK5c9/xa9tXDWCKNC8LUjHAITfuMuS8bnEVzNmAFJPDt918LiiotjwbIkbtrrhhC1pC4TTXVMW+c3Gl+mZkhEHXmrccz/dfhap8UQhtFgY6a27nq3B17AWKnS5QkpOEm0gEZT2sQPYUeiMQYC2fq1umgMjxmZ+ZeYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKJVvBViEtv2jCJtXEYtnAVqcqy3BtsqXbbQc1kSpZA=;
 b=ACwQAbD7Hj82l/tcIgi678SZwlY0s/VfD5KzE1wLxs76RcPiYtbRKIDZ9umT7Sg7l9+/GBsCqvjHQ3AEkDbgO+qaOa8bzdnJiUyegm3ATgozkRaLxZQ6PFiE2L4BmY/9HF2bcgx4rYBTRqo0vxupnC1Mu55P0fOmltFxRbBrQo9vuTLEc+IHUvvU8Jdx4ZGKMwlAjYJ6uLXTrWuajQ7qRdn+AxybMTJAyEqeqDKGNQFYcW230KdUe2xaaugDAhyN6h04DjNdetOq+HLZMnBQRF94X8FfgBTcIq0kDtz/sBhE/u/TREZGyBzsdq2vFZKdG5RtlZOUaH/rGnFEYX7DtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKJVvBViEtv2jCJtXEYtnAVqcqy3BtsqXbbQc1kSpZA=;
 b=koobykvAyVSUs/F06PI5KNj/5XBmf3QxFj/5v6zLdm9m3NrrSCOXMoVOdPZ9W8B4npJJsTBmjUNCBHzPQB+zofJMNkUL+WMzMhh59NkfWGZBh2/b3iujsJJGpI3m8ZTFJST1NRcf3r1Bvy9EzG2ICo52BuZR3aBPS3VfhdFBGH8=
Received: from DM5PR08CA0027.namprd08.prod.outlook.com (2603:10b6:4:60::16) by
 IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 21:30:05 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::19) by DM5PR08CA0027.outlook.office365.com
 (2603:10b6:4:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Thu, 25 May 2023 21:30:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Thu, 25 May 2023 21:30:05 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 16:30:01 -0500
Date:   Thu, 25 May 2023 23:29:58 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, <bhelgaas@google.com>,
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 22/23] PCI/AER: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
Message-ID: <ZG/TKOgMTSljryHN@rric.localdomain>
References: <20230523232214.55282-23-terry.bowman@amd.com>
 <ZG6Cc6uqYqTPel8P@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZG6Cc6uqYqTPel8P@bhelgaas>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: e82f9910-8518-419b-bc2a-08db5d6734bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zulfk3/A3YyDTpDFSetIzQKhVv5k0PvDLN/hnImusk8jmej/eJoPXs5yqinipy4Wr+AicNE+jaMeAoMCFU30RZqnmGx1W86Vd6qtzCl3ZLpF6LlZSPItg4TvQRgAy1Pi/jENAYPdMDEMEkDGY5CZXJTGAYoQhPNK+J8iiQcSVZDzcvfbKrwjEU+lUAzplAJLSocGN6gw9Ct7JX4LGa3AS6quJn/1d6Wxm5HRjYRU48osQxMyAUGt+xyoJirgwEKif6+L6CijdqBtBlpayEFRWCPQfBJ7bx9R+HqmnCwGubWQg82mmPxJa8gbpGgEqW/Tc8v6KssE4onjqisklgoYc3end3+PKM7bbpReQFlyVpu+sXIdCBC4EyaKthCpfj+EpCEkV/+pVEkOmBqx3NkiRyGqN7UMmKYJip2emPmRA53t545L2CPC32vG/gjbNxT7/M8D2YbOE52VUOLWWhWlq1O3t298xYqu+kn5G+3Ik/G9fRIGPHcopagIWRcgJmiH4VELBLRMNTRAnIddt6Cjaudx5aDr3cZTX0+JbybPu/ikp+SxX9NWZHy3vt/+S2sWy9GajGUZ5U0rrJAwucL2IIdW9Yhhjq4gtJUS0NZaQY8lc8TQjQdmOLdHQ0+Wsz3vbT8uoXoqe/K8fSRS3Y8XmK/siVRcMr6TxdIkeJeCaRuklAvEM3HU+W4y3gAmQrLny8purUBJSRdn4BJgTlF8TNkTi+S/yfpZnxgtk2nFG+q6q86MRUjBN1wiiSUtkcVeCDbwAHcDmRXlVzxAnOCCRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(5660300002)(40460700003)(8676002)(7416002)(8936002)(186003)(16526019)(30864003)(47076005)(36860700001)(2906002)(426003)(336012)(83380400001)(356005)(82310400005)(9686003)(81166007)(40480700001)(82740400003)(26005)(55016003)(966005)(6916009)(316002)(4326008)(70586007)(70206006)(6666004)(54906003)(478600001)(7696005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 21:30:05.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82f9910-8518-419b-bc2a-08db5d6734bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

eOn 24.05.23 16:32:35, Bjorn Helgaas wrote:
> On Tue, May 23, 2023 at 06:22:13PM -0500, Terry Bowman wrote:
> > From: Robert Richter <rrichter@amd.com>
> > 
> > In Restricted CXL Device (RCD) mode a CXL device is exposed as an
> > RCiEP, but CXL downstream and upstream ports are not enumerated and
> > not visible in the PCIe hierarchy. Protocol and link errors are sent
> > to an RCEC.
> >
> > Restricted CXL host (RCH) downstream port-detected errors are signaled
> > as internal AER errors, either Uncorrectable Internal Error (UIE) or
> > Corrected Internal Errors (CIE). 
> 
> From the parallelism with RCD above, I first thought that RCH devices
> were non-RCD mode and *were* enumerated as part of the PCIe hierarchy,
> but actually I suspect it's more like the following?
> 
>   ... but CXL downstream and upstream ports are not enumerated and not
>   visible in the PCIe hierarchy.
> 
>   Protocol and link errors from these non-enumerated ports are
>   signaled as internal AER errors ... via a CXL RCEC.

Exactly, except the RCEC is standard PCIe and also must not
necessarily on the same PCI bus as the CXL RCiEPs are.

> 
> > The error source is the id of the RCEC.
> 
> This seems odd; I assume this refers to the RCEC's AER Error Source
> Identification register, and the ERR_COR or ERR_FATAL/NONFATAL Source
> Identification would ordinarily be the Requester ID of the RCiEP that
> "sent" the Error Message.  But you're saying it's actually the ID of
> the *RCEC*, not the RCiEP?

Right, the downstream port has it's own AER ext capability in
non-config (io mapped) RCRB regsister range. Errors originating from
there are signaled as internal AER errors via the RCEC *with* the
RCEC's Requester ID. Code walks through all associated CXL endpoints,
determines the dport and checks its AER.

There is also an RDPAS structure defined in CXL but that is only a
different way to provide the RCEC to dport association instead of
using the RCEC's Endpoint Association Extended Capability. In the end
we get all associated RCHs and check the AER of all their dports.

The upstream port is signaled using the RCiEP's AER. CXL spec is
strict here: "Upstream Port RCRB shall not implement the AER Extended
Capability." The RCiEP's requestor ID is used then and it's config
space the AER is in.

CXL.cachemem errors are reported with the RCiEP as requester
too. Status is in the CXL RAS cap and the UIE or CIE is set
respectively in the AER status of the RCiEP.

> 
> We're going to call pci_aer_handle_error() as well, to handle the
> non-internal errors, and I'm pretty sure that path expects the RCiEP
> ID there.
> 
> Whatever the answer, I'm not sure this sentence is actually relevant
> to this patch, since this patch doesn't read PCI_ERR_ROOT_ERR_SRC or
> look at struct aer_err_source.id.

The source id is used in aer_process_err_devices() which finally calls
handle_error_source() for the device with the requestor id. This is
the place where cxl_rch_handle_error() checks if it is an RCEC that
recieved an internal error and has cxl devices connected to it. Then,
the request is forwarded to the cxl_mem handler which also needs to
check the dport now. That is, pcie_walk_rcec() in
cxl_rch_handle_error() is called with the RCEC's pci handle,
cxl_rch_handle_error_iter() with the RCiEP's pci handle..

> 
> > A CXL handler must then inspect the error status in various CXL
> > registers residing in the dport's component register space (CXL RAS
> > capability) or the dport's RCRB (PCIe AER extended capability). [1]
> > 
> > Errors showing up in the RCEC's error handler must be handled and
> > connected to the CXL subsystem. Implement this by forwarding the error
> > to all CXL devices below the RCEC. Since the entire CXL device is
> > controlled only using PCIe Configuration Space of device 0, function
> > 0, only pass it there [2]. The error handling is limited to currently
> > supported devices with the Memory Device class code set
> > (PCI_CLASS_MEMORY_CXL, 502h), where the handler can be implemented in
> > the existing cxl_pci driver. Support of CXL devices (e.g. a CXL.cache
> > device) can be enabled later.
> 
> I assume the Memory Devices are CXL devices, so maybe "Error handling
> for *other* CXL devices ... can be enabled later"?  
> 
> IIUC, this happens via cxl_rch_handle_error_iter() calling
> pci_error_handlers for CXL RCiEPs.  Maybe the is_cxl_mem_dev() check
> belongs inside those handlers, since that driver claimed the RCiEP and
> should know its functionality?  Maybe is_internal_error() and
> cxl_error_is_native(), too?

The check is outside the handlers on purpose. A corresponding handler
is needed, it is cxl_pci_driver, see the class code in
cxl_mem_pci_tbl. As the handler must handle other device's sources,
only aware drivers may be called here. Otherwise a device's error
handler could be called for errors there the source is the RCEC.

> 
> > In addition to errors directed to the CXL endpoint device, a handler
> > must also inspect the CXL RAS and PCIe AER capabilities of the CXL
> > downstream port that is connected to the device.
> > 
> > Since CXL downstream port errors are signaled using internal errors,
> > the handler requires those errors to be unmasked. This is subject of a
> > follow-on patch.
> > 
> > The reason for choosing this implementation is that a CXL RCEC device
> > is bound to the AER port driver,
> 
>   ... is that the AER service driver claims the CXL RCEC device, but
>   does not allow registration of a CXL sub-service driver ...
> 
> > but the driver does not allow it to
> > register a custom specific handler to support CXL. Connecting the RCEC
> > hard-wired with a CXL handler does not work, as the CXL subsystem
> > might not be present all the time. The alternative to add an
> > implementation to the portdrv to allow the registration of a custom
> > RCEC error handler isn't worth doing it as CXL would be its only user.
> > Instead, just check for an CXL RCEC and pass it down to the connected
> > CXL device's error handler. With this approach the code can entirely
> > be implemented in the PCIe AER driver and is independent of the CXL
> > subsystem. The CXL driver only provides the handler.
> > 
> > [1] CXL 3.0 spec, 12.2.1.1 RCH Downstream Port-detected Errors
> > [2] CXL 3.0 spec, 8.1.3 PCIe DVSEC for CXL Devices
> > 
> > Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Cc: "Oliver O'Halloran" <oohall@gmail.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-pci@vger.kernel.org
> 
> Given the questions are minor:

Will update description according to you comment.

> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for review and the ACK.

-Robert

> 
> > ---
> >  drivers/pci/pcie/Kconfig |  12 +++++
> >  drivers/pci/pcie/aer.c   | 100 ++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 110 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> > index 228652a59f27..4f0e70fafe2d 100644
> > --- a/drivers/pci/pcie/Kconfig
> > +++ b/drivers/pci/pcie/Kconfig
> > @@ -49,6 +49,18 @@ config PCIEAER_INJECT
> >  	  gotten from:
> >  	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> >  
> > +config PCIEAER_CXL
> > +	bool "PCI Express CXL RAS support for Restricted Hosts (RCH)"
> > +	default y
> > +	depends on PCIEAER && CXL_PCI
> > +	help
> > +	  Enables error handling of downstream ports of a CXL host
> > +	  that is operating in RCD mode (Restricted CXL Host, RCH).
> > +	  The downstream port reports AER errors to a given RCEC.
> > +	  Errors are handled by the CXL memory device driver.
> > +
> > +	  If unsure, say Y.
> > +
> >  #
> >  # PCI Express ECRC
> >  #
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index d3344fcf1f79..2e3f00b6a5bd 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -946,14 +946,104 @@ static bool find_source_device(struct pci_dev *parent,
> >  	return true;
> >  }
> >  
> > +#ifdef CONFIG_PCIEAER_CXL
> > +
> > +static bool is_cxl_mem_dev(struct pci_dev *dev)
> > +{
> > +	/*
> > +	 * The capability, status, and control fields in Device 0,
> > +	 * Function 0 DVSEC control the CXL functionality of the
> > +	 * entire device (CXL 3.0, 8.1.3).
> > +	 */
> > +	if (dev->devfn != PCI_DEVFN(0, 0))
> > +		return false;
> > +
> > +	/*
> > +	 * CXL Memory Devices must have the 502h class code set (CXL
> > +	 * 3.0, 8.1.12.1).
> > +	 */
> > +	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +static bool cxl_error_is_native(struct pci_dev *dev)
> > +{
> > +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > +
> > +	if (pcie_ports_native)
> > +		return true;
> > +
> > +	return host->native_aer && host->native_cxl_error;
> > +}
> > +
> > +static bool is_internal_error(struct aer_err_info *info)
> > +{
> > +	if (info->severity == AER_CORRECTABLE)
> > +		return info->status & PCI_ERR_COR_INTERNAL;
> > +
> > +	return info->status & PCI_ERR_UNC_INTN;
> > +}
> > +
> > +static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> > +{
> > +	struct aer_err_info *info = (struct aer_err_info *)data;
> > +	const struct pci_error_handlers *err_handler;
> > +
> > +	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> > +		return 0;
> > +
> > +	/* protect dev->driver */
> > +	device_lock(&dev->dev);
> > +
> > +	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> > +	if (!err_handler)
> > +		goto out;
> > +
> > +	if (info->severity == AER_CORRECTABLE) {
> > +		if (err_handler->cor_error_detected)
> > +			err_handler->cor_error_detected(dev);
> > +	} else if (err_handler->error_detected) {
> > +		if (info->severity == AER_NONFATAL)
> > +			err_handler->error_detected(dev, pci_channel_io_normal);
> > +		else if (info->severity == AER_FATAL)
> > +			err_handler->error_detected(dev, pci_channel_io_frozen);
> > +	}
> > +out:
> > +	device_unlock(&dev->dev);
> > +	return 0;
> > +}
> > +
> > +static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> > +{
> > +	/*
> > +	 * CXL downstream ports of a CXL host that is operating in RCD
> > +	 * mode (RCH) signal errors as RCEC internal errors. Forward
> > +	 * them to all CXL devices below the RCEC.
> > +	 *
> > +	 * See CXL 3.0:
> > +	 *   9.11.8 CXL Devices Attached to an RCH
> > +	 *   12.2.1.1 RCH Downstream Port-detected Errors
> > +	 */
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> > +	    is_internal_error(info))
> > +		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> > +}
> > +
> > +#else
> > +static inline void cxl_rch_handle_error(struct pci_dev *dev,
> > +					struct aer_err_info *info) { }
> > +#endif
> > +
> >  /**
> > - * handle_error_source - handle logging error into an event log
> > + * pci_aer_handle_error - handle logging error into an event log
> >   * @dev: pointer to pci_dev data structure of error source device
> >   * @info: comprehensive error information
> >   *
> >   * Invoked when an error being detected by Root Port.
> >   */
> > -static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> > +static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> >  {
> >  	int aer = dev->aer_cap;
> >  
> > @@ -977,6 +1067,12 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> >  		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
> >  	else if (info->severity == AER_FATAL)
> >  		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
> > +}
> > +
> > +static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> > +{
> > +	cxl_rch_handle_error(dev, info);
> > +	pci_aer_handle_error(dev, info);
> >  	pci_dev_put(dev);
> >  }
> >  
> > -- 
> > 2.34.1
> > 
