Return-Path: <linux-pci+bounces-37251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F467BACD96
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 14:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781A53C4DE9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D92FB0B7;
	Tue, 30 Sep 2025 12:33:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131A2FB97B;
	Tue, 30 Sep 2025 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235598; cv=none; b=DPtvYwNduLBO7oD9BwDgWsZTLjJhv1tkME8tEuedxKnzjrwikS75g3SjkhbgY3Ci6OYTF8Vo2CN48D+FQupyt0c3LSJH96rvG+gDBKuoX7WrCofLeEmYKYLxwtgYMOddqMzAGdEJbMJNik5jwTUFHlb4M2JqZANmWV1Yzu8RdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235598; c=relaxed/simple;
	bh=o5WgECBb3XEdUTamZl7EY74JCh4ZAHhDYaBuiP0jtpY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYK21S3GmeKj0H4p0x7LDN9zMg6YQqUYBpmDlk2DADpI6oiMgHjKOE2KMPNtlJtTBldvkj76LfPaSt+PrwLKlMm0SxvsjCb+t47gv2Bo4zBLD5WmXrxxZsPw4nrpgRhz68xPbezDDanECwI0HQSWBUBfizZqcpEuW6pLELjNovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 58UC8wsW090414;
	Tue, 30 Sep 2025 20:08:58 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58UC5hY5088638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 20:05:43 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Sep 2025 20:05:43 +0800
Date: Tue, 30 Sep 2025 20:05:37 +0800
From: Randolph Lin <randolph@andestech.com>
To: Rob Herring <robh@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <ben717@andestech.com>,
        <inochiama@gmail.com>, <thippeswamy.havalige@amd.com>,
        <namcao@linutronix.de>, <shradha.t@samsung.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>
Subject: Re: [PATCH v3 1/5] PCI: dwc: Skip failed outbound iATU and continue
Message-ID: <aNvHkUwKW-vD-hwV@swlinux02>
References: <aNPq42O1Ml3ppF2M@swlinux02>
 <20250926211023.GA2128495@bhelgaas>
 <CAL_Jsq+HDgghAQps5M0jV7ELxR=M7pRCuEKwgSMcJQfS3Ecsrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+HDgghAQps5M0jV7ELxR=M7pRCuEKwgSMcJQfS3Ecsrg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 58UC8wsW090414

Hi Rob,

On Mon, Sep 29, 2025 at 09:03:59AM -0500, Rob Herring wrote:
> [EXTERNAL MAIL]
> 
> On Fri, Sep 26, 2025 at 4:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Sep 24, 2025 at 08:58:11PM +0800, Randolph Lin wrote:
> > > On Tue, Sep 23, 2025 at 09:42:23AM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Sep 23, 2025 at 07:36:43PM +0800, Randolph Lin wrote:
> > > > > Previously, outbound iATU programming included range checks
> > > > > based on hardware limitations. If a configuration did not meet
> > > > > these constraints, the loop would stop immediately.
> > > > >
> > > > > This patch updates the behavior to enhance flexibility. Instead
> > > > > of stopping at the first issue, it now logs a warning with
> > > > > details of the affected window and proceeds to program the
> > > > > remaining iATU entries.
> > > > >
> > > > > This enables partial configuration to complete in cases where
> > > > > some iATU windows may not meet requirements, improving overall
> > > > > compatibility.
> > > >
> > > > It's not really clear why this is needed.  I assume it's related
> > > > to dropping qilai_pcie_outbound_atu_addr_valid().
> > >
> > > Yes, I want to drop the previous atu_addr_valid function.
> > >
> > > > I guess dw_pcie_prog_outbound_atu() must return an error for one
> > > > of the QiLai ranges?  Which one, and what exactly is the problem?
> > > > I still suspect something wrong in the devicetree description.
> > >
> > > The main issue is not the returned error; just need to avoid
> > > terminating the process when the configuration exceeds the
> > > hardware’s expected limits.
> > >
> > > There are two methods to fix the issue on the Qilai SoC:
> > >
> > > 1. Simply skip the entries that do not match the designware hardware
> > > iATU limitations.  An error will be returned, but it can be ignored.
> > > On the Qilai SoC, the iATU limitation is the 4GB boundary. Qilai SoC
> > > only need to configure iATU support to translate addresses below the
> > > "32-bits" address range. Although 64-bits addresses do not match the
> > > designware hardware iATU limitations, there is no need to configure
> > > 64-bits addresses, since the connection is hard-wired.
> > >
> > > 2. Set the devicetree only 2 viewport for iATU and force using
> > > devicetree value.  This is a workaround in the devicetree, but the
> > > fix logic is not easy to document.  Instead, we should enforce the
> > > use of the viewport defined in the devicetree and modify the
> > > designware generic code accordingly — using the viewport values from
> > > the devicetree instead of reading them from the designware
> > > registers.  Since only two viewports are available for iATU, we
> > > should reserve one for the configuration registers and the other for
> > > 32-bit address access.  Therefore, reverse logic still needs to be
> > > added to the designware generic code.
> > >
> > > Method 2 adds excessive complexity to the designware generic code.
> > > Instead, directly configuring the iATU and reporting an error when
> > > the configuration exceeds the hardware iATU limitations is a simpler
> > > and more effective approach to applying the fix.
> >
> > I don't know the DesignWare iATU design very well, so I don't know if
> > this issue is something unique to Qilai or if it's something that
> > could be handled via devicetree.
> 
> I believe it should probably be handled in the DT. The iATU is
> programmed based on the bridge window resources which are in turn
> based on DT ranges and dma-ranges. If there's a failure, then
> ranges/dma-ranges is wrong. Or the driver could adjust the bridge
> window resources before programming the iATU.
> 

Thank you very much. That’s a great hint for me.

My driver can handle most of the logic within the .init callback of the
dw_pcie_host_ops structure. This includes parsing the Device Tree data
and performing the required pre-initialization steps, such as counting
how many bridge window resources comply with the iATU limitations and
verifying the 32-bit address mappings within those bridge window
resources.

The following additional logic is still required to ensure
pci->num_ob_windows correctly reflects the driver’s pre-initialization
value, with the current approach remaining more generic and purposeful.

--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -907,8 +907,10 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
                max = 0;
        }

-       pci->num_ob_windows = ob;
-       pci->num_ib_windows = ib;
+       if (!pci->num_ob_windows)
+               pci->num_ob_windows = ob;
+       if (!pci->num_ib_windows)
+               pci->num_ib_windows = ib;
        pci->region_align = 1 << fls(min);
        pci->region_limit = (max << 32) | (SZ_4G - 1);

> Please provide what the DT looks like (for ranges/dma-ranges) and
> where problem entry is.
> 

bus@80000000 {
	compatible = "simple-bus";
	#address-cells = <2>;
	#size-cells = <2>;
	dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
	ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x20000000>,
		 <0x00 0x04000000 0x00 0x04000000 0x00 0x00001000>,
		 <0x00 0x00000000 0x20 0x00000000 0x20 0x00000000>;

	pci@80000000 {
		compatible = "andestech,qilai-pcie";
		device_type = "pci";
		reg = <0x00 0x80000000 0x00 0x20000000>, /* DBI registers */
		      <0x00 0x04000000 0x00 0x00001000>, /* APB registers */
		      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
		reg-names = "dbi", "apb", "config";

		linux,pci-domain = <0>;
		bus-range = <0x0 0xff>;
		num-viewport = <4>;
		#address-cells = <3>;
		#size-cells = <2>;
		ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x00 0xf0000000>,
			 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x1f 0x00000000>;

Just look at the last "ranges" property — the first line is the only one
we want to program into the iATU, as its size is below SZ_4G
(the iATU region limitation for this SoC).

The next line exceeds the iATU region limitation; therefore, we do not
want to program it into the iATU. It is natively wire-connected by
design and does not need to pass through the iATU.

> Rob

Sincerely,
Randolph

