Return-Path: <linux-pci+bounces-36854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E971BB99F2E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D70A3284AB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A705B303C85;
	Wed, 24 Sep 2025 12:58:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90736302CAA
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718711; cv=none; b=EASvN2ChIvHwgRZIwFPQGCCS9MRork4ycDLtD/oGokmBXjGmOzQBVTilJcy3FVAMF3CiOz+8G2PuOTOgZ+09H0O/OPzhwY4M7M1XQ+3E3Kt4tNhMmdFr3FZRh3sFTt2bhb9/lErglN/4qI4EV12u4jdSUWRDo+oT+XHvt6WuXqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718711; c=relaxed/simple;
	bh=tcrGELuphN2j2IYPyqGBbzuDcws8nzHybciZp6hIHpI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty0iMKqOv1ZYG1NeIp+BDWCTuvs91QwnaxQ6tmB66/v+4lR33HFh0zNmmy7e54YN1b0qsZ56J6uWC2hFZgjP1MNVzOY03/E9VdbPb0GNZXoiwhMiIPCEOnf9hx75cnYKnFrae+I1PjgAxZqnWz/vuNqkDrSxPWH3U0ewLn6Zzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58OCwIeM007328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 20:58:18 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Wed, 24 Sep 2025 20:58:18 +0800
Date: Wed, 24 Sep 2025 20:58:11 +0800
From: Randolph Lin <randolph@andestech.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alex@ghiti.fr>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <ben717@andestech.com>,
        <inochiama@gmail.com>, <thippeswamy.havalige@amd.com>,
        <namcao@linutronix.de>, <shradha.t@samsung.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>
Subject: Re: [PATCH v3 1/5] PCI: dwc: Skip failed outbound iATU and continue
Message-ID: <aNPq42O1Ml3ppF2M@swlinux02>
References: <20250923113647.895686-2-randolph@andestech.com>
 <20250923144223.GA2032427@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923144223.GA2032427@bhelgaas>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 58OCwIeM007328

Hi Bjorn,

Sorry, I forgot to reply to the email before sending the patch.
I missed the email.

On Tue, Sep 23, 2025 at 09:42:23AM -0500, Bjorn Helgaas wrote:
> [EXTERNAL MAIL]
> 
> On Tue, Sep 23, 2025 at 07:36:43PM +0800, Randolph Lin wrote:
> > Previously, outbound iATU programming included range checks based
> > on hardware limitations. If a configuration did not meet these
> > constraints, the loop would stop immediately.
> >
> > This patch updates the behavior to enhance flexibility. Instead of
> > stopping at the first issue, it now logs a warning with details of
> > the affected window and proceeds to program the remaining iATU
> > entries.
> >
> > This enables partial configuration to complete in cases where some
> > iATU windows may not meet requirements, improving overall
> > compatibility.
> 
> It's not really clear why this is needed.  I assume it's related to
> dropping qilai_pcie_outbound_atu_addr_valid().
> 

Yes, I want to drop the previous atu_addr_valid function.

> I guess dw_pcie_prog_outbound_atu() must return an error for one of
> the QiLai ranges?  Which one, and what exactly is the problem?  I
> still suspect something wrong in the devicetree description.
> 

The main issue is not the returned error; just need to avoid terminating
the process when the configuration exceeds the hardware’s expected limits.

There are two methods to fix the issue on the Qilai SoC:

1. Simply skip the entries that do not match the designware hardware iATU limitations.
An error will be returned, but it can be ignored. On the Qilai SoC, the iATU
limitation is the 4GB boundary. Qilai SoC only need to configure iATU support
to translate addresses below the "32-bits" address range. Although 64-bits
addresses do not match the designware hardware iATU limitations, there is no
need to configure 64-bits addresses, since the connection is hard-wired.

2. Set the devicetree only 2 viewport for iATU and force using devicetree value.
This is a workaround in the devicetree, but the fix logic is not easy to document.
Instead, we should enforce the use of the viewport defined in the devicetree and
modify the designware generic code accordingly — using the viewport values
from the devicetree instead of reading them from the designware registers.
Since only two viewports are available for iATU, we should reserve one for
the configuration registers and the other for 32-bit address access.
Therefore, reverse logic still needs to be added to the designware generic code.

Method 2 adds excessive complexity to the designware generic code. Instead,
directly configuring the iATU and reporting an error when the configuration
exceeds the hardware iATU limitations is a simpler and more effective
approach to applying the fix.

Conclusion:
1. The iATU needs to be configured for 32-bits address space.
   In compliance with hardware limitations.
2. The iATU needs to be configured for config space.
   In compliance with hardware limitations.
3. The iATU needs to be configured for 64-bit address space.
   This does not comply with hardware limitations and will print an error.
   As long as it does not return an error value that terminates subsequent
   operations, it is acceptable.
   Simply skipping this entry when configuring the iATU is acceptable.

> > Signed-off-by: Randolph Lin <randolph@andestech.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 952f8594b501..91ee6b903934 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -756,7 +756,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >               if (resource_type(entry->res) != IORESOURCE_MEM)
> >                       continue;
> >
> > -             if (pci->num_ob_windows <= ++i)
> > +             if (pci->num_ob_windows <= i)
> >                       break;
> >
> >               atu.index = i;
> > @@ -773,9 +773,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >
> >               ret = dw_pcie_prog_outbound_atu(pci, &atu);
> >               if (ret) {
> > -                     dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > -                             entry->res);
> > -                     return ret;
> > +                     dev_warn(pci->dev, "Failed to set MEM range %pr\n",
> > +                              entry->res);
> > +             } else {
> > +                     i++;
> >               }
> >       }
> >
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Sincerely,
Randolph

