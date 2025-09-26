Return-Path: <linux-pci+bounces-37136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45BBA52A4
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0FE3880D3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F3285C9E;
	Fri, 26 Sep 2025 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhcAYVQ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE36242D69;
	Fri, 26 Sep 2025 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921025; cv=none; b=pfaymNl80G50DCg1HU8RP+oQ2AaV1YUNvvxmuauGPCu/Vnh+fgkvCsojSmiFuJzuzbhksXs6cLUI+wmPm1p0euls4M0tr6/K4rDFTs+bGJMv5lWFgURW6+FY9sVEsjEUbTn6en4YZ7o5aonUhqlW+TpyRA+5pFaNhL0vvPdUGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921025; c=relaxed/simple;
	bh=/1ElN3uhG06OJ2qKUXgLudpPHVrywtGPulcS4+9P0tU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p/MmgySJYeQd94Nv0RdlBTx0LxRwQO8XvGUaxr3BAmA8EAwX0mo5WefBKPD8u+Zm+HSK73aC0UXh4tyIiXLDK6On3YvQ/+wvOtVBLsTOgfSGgsIYRannZyw48AGUeNhs02EYKvSbg63EwJtTciKY5fbH06Xtzp1FXKxRhG8Y55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhcAYVQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3445C4CEF4;
	Fri, 26 Sep 2025 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758921024;
	bh=/1ElN3uhG06OJ2qKUXgLudpPHVrywtGPulcS4+9P0tU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mhcAYVQ58DVBObBw74hQf07QzZ/ihSB0Z5sfR7lMU69jxt5bJmgEQuljnYL3KW5I7
	 0mg5ehePi7OyHF25w/YkphKl6mFNj7i7j60YXjKHrciJggfyFObj7UhQ5qGMjyRty7
	 vDwE15607DBwKxXRKZXSevpZ/6u3j+73gyIANt/endOiXJrzzM/B0GI3X/KZUy2DZt
	 polCzEpXbZ0ciqu++0mO8vHQamJcnhVecmVnk258EeXgf2OS6VQYUikLG2am/ZPHbZ
	 /qr8UbfcYz8yVWzZgnFqQlyINA1GSDsdX5f8+F2jfLUBKguZUtltixot9UQ7/1pIxi
	 iHXZI2WdQeYOw==
Date: Fri, 26 Sep 2025 16:10:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, randolph.sklin@gmail.com,
	tim609@andestech.com
Subject: Re: [PATCH v3 1/5] PCI: dwc: Skip failed outbound iATU and continue
Message-ID: <20250926211023.GA2128495@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNPq42O1Ml3ppF2M@swlinux02>

On Wed, Sep 24, 2025 at 08:58:11PM +0800, Randolph Lin wrote:
> On Tue, Sep 23, 2025 at 09:42:23AM -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 23, 2025 at 07:36:43PM +0800, Randolph Lin wrote:
> > > Previously, outbound iATU programming included range checks
> > > based on hardware limitations. If a configuration did not meet
> > > these constraints, the loop would stop immediately.
> > >
> > > This patch updates the behavior to enhance flexibility. Instead
> > > of stopping at the first issue, it now logs a warning with
> > > details of the affected window and proceeds to program the
> > > remaining iATU entries.
> > >
> > > This enables partial configuration to complete in cases where
> > > some iATU windows may not meet requirements, improving overall
> > > compatibility.
> > 
> > It's not really clear why this is needed.  I assume it's related
> > to dropping qilai_pcie_outbound_atu_addr_valid().
> 
> Yes, I want to drop the previous atu_addr_valid function.
> 
> > I guess dw_pcie_prog_outbound_atu() must return an error for one
> > of the QiLai ranges?  Which one, and what exactly is the problem?
> > I still suspect something wrong in the devicetree description.
> 
> The main issue is not the returned error; just need to avoid
> terminating the process when the configuration exceeds the
> hardware’s expected limits.
> 
> There are two methods to fix the issue on the Qilai SoC:
> 
> 1. Simply skip the entries that do not match the designware hardware
> iATU limitations.  An error will be returned, but it can be ignored.
> On the Qilai SoC, the iATU limitation is the 4GB boundary. Qilai SoC
> only need to configure iATU support to translate addresses below the
> "32-bits" address range. Although 64-bits addresses do not match the
> designware hardware iATU limitations, there is no need to configure
> 64-bits addresses, since the connection is hard-wired.
> 
> 2. Set the devicetree only 2 viewport for iATU and force using
> devicetree value.  This is a workaround in the devicetree, but the
> fix logic is not easy to document.  Instead, we should enforce the
> use of the viewport defined in the devicetree and modify the
> designware generic code accordingly — using the viewport values from
> the devicetree instead of reading them from the designware
> registers.  Since only two viewports are available for iATU, we
> should reserve one for the configuration registers and the other for
> 32-bit address access.  Therefore, reverse logic still needs to be
> added to the designware generic code.
> 
> Method 2 adds excessive complexity to the designware generic code.
> Instead, directly configuring the iATU and reporting an error when
> the configuration exceeds the hardware iATU limitations is a simpler
> and more effective approach to applying the fix.

I don't know the DesignWare iATU design very well, so I don't know if
this issue is something unique to Qilai or if it's something that
could be handled via devicetree.

Will look for input/acks from DesignWare maintainers (Jingoo, Mani).

> Conclusion:
> 1. The iATU needs to be configured for 32-bits address space.
>    In compliance with hardware limitations.
> 2. The iATU needs to be configured for config space.
>    In compliance with hardware limitations.
> 3. The iATU needs to be configured for 64-bit address space.
>    This does not comply with hardware limitations and will print an error.
>    As long as it does not return an error value that terminates subsequent
>    operations, it is acceptable.
>    Simply skipping this entry when configuring the iATU is acceptable.
> 
> > > Signed-off-by: Randolph Lin <randolph@andestech.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 952f8594b501..91ee6b903934 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -756,7 +756,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >               if (resource_type(entry->res) != IORESOURCE_MEM)
> > >                       continue;
> > >
> > > -             if (pci->num_ob_windows <= ++i)
> > > +             if (pci->num_ob_windows <= i)
> > >                       break;
> > >
> > >               atu.index = i;
> > > @@ -773,9 +773,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > >
> > >               ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > >               if (ret) {
> > > -                     dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > > -                             entry->res);
> > > -                     return ret;
> > > +                     dev_warn(pci->dev, "Failed to set MEM range %pr\n",
> > > +                              entry->res);
> > > +             } else {
> > > +                     i++;
> > >               }
> > >       }
> > >
> > > --
> > > 2.34.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> Sincerely,
> Randolph

