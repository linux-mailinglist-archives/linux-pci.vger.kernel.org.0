Return-Path: <linux-pci+bounces-3085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 375008498E8
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 12:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873DC281AEE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F3A18EAD;
	Mon,  5 Feb 2024 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpXloMUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C118E28;
	Mon,  5 Feb 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132822; cv=none; b=BhrwbQC3lUudXvs4vTaM4xtRlhe+rCNsiDpAV7khM0opgW696bZYKk9muhFniihI+DxIwj5tLUHRCG8Rl1iDtJZKoXiEyjzXzbYdiY81qSIJK7JEQi+zYYrdMN1crK2s+x4YxqelLPkWcI4ELjY7zWKuhFTW8MqNcCVl494W5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132822; c=relaxed/simple;
	bh=1MwSAUc78W5tJXQDmXiVVWL6LW0tWArwoySoZ/FGdlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mah912x7cgX6ozTZ+cpAyiPJixHVA/0LjUhfxVTo5rCpNnQpTtWkjrxCmfbI8QMMZtVXqOhDybNfpoFW235/V71c/fwHMdnx814Zu0d8JF4IA2gwVYQDjlY+VGfqHIwjEgnaA8OGXZBGSpFevPG3TCWDbkJB5SfuScPJUHa5Juk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpXloMUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F10C433C7;
	Mon,  5 Feb 2024 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707132821;
	bh=1MwSAUc78W5tJXQDmXiVVWL6LW0tWArwoySoZ/FGdlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpXloMUHVvgOT++sJP7NBERncauAvbB6ry4KrcJTiSaciNWRV+DSyRYS+aG8Sioma
	 t6iLwz1RM85qLT6G9Ca/U6FC+XoRgFdiD4kLjovPNM+SVaRqBiJH5791i6WyWYiQos
	 FmttZ3GJk4+4F6djl9PeTMvUq0PonAfvWXtfDYi5SZQba0/Zg+PlqptTC/pfIMtZGL
	 bjEboxt4JN/Q/9y6zfZ4fkdwI3X1oDizR4dA1v8QcPZ6tQnKT0rHmkt4yTc1baR/fj
	 g2SBCEbI/D+HFbVapiKdMQE0fstZtVWBdvgD/IqHZNQ3hz1K3AL0tkeSdbg4VKKgW0
	 6j1xiFneU7IEw==
Date: Mon, 5 Feb 2024 12:33:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Daniel Drake <drake@endlessos.org>,
	Vitalii Solomonov <solomonov.v@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS
 B1400CEAE
Message-ID: <ZcDHjsYJNlJ/9nNT@x1-carbon>
References: <20240130095933.14158-1-jhp@endlessos.org>
 <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
 <Zbonprq/1SircQon@x1-carbon>
 <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
 <ZbrNLxHL03R66PxQ@x1-carbon>
 <ZbuyVbMEBWKi729y@x1-carbon>
 <CAPpJ_efmzy_FU0urdHDmO5htOBCPaX-T5W+Er7AmWYhqUTwnyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpJ_efmzy_FU0urdHDmO5htOBCPaX-T5W+Er7AmWYhqUTwnyA@mail.gmail.com>

On Fri, Feb 02, 2024 at 04:49:00PM +0800, Jian-Hong Pan wrote:
> Niklas Cassel <cassel@kernel.org> 於 2024年2月1日 週四 下午11:01寫道：
> >
> > On Wed, Jan 31, 2024 at 11:43:59PM +0100, Niklas Cassel wrote:
> > > On Wed, Jan 31, 2024 at 07:08:12AM -0400, Daniel Drake wrote:
> >
> > (snip)
> >
> > > In libata we perform a reset of the port at boot, see:
> > > libata-sata.c:sata_link_hardreset()
> > > after writing to SControl, we call
> > > libata-core.c:ata_wait_ready() that will poll for the port being ready
> > > by calling the check_ready callback.
> > > For AHCI, this callback funcion is set to:
> > > libahci.c:ahci_check_ready().
> > >
> > > A reset should take the device out of deep power state and should be
> > > sufficient to establish a connection (and that also seems to be the
> > > case when not using Intel VMD).
> > >
> > > However, if you want to debug, I would start by adding prints to
> > > libata-sata.c:sata_link_hardreset()
> > > libata-core.c:ata_wait_ready()
> > > libahci.c:ahci_check_ready().
> >
> > FWIW, this will dump SStatus.DET every time the check_ready callback function
> > (ahci_check_ready()) is called:
> >
> >
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 1a63200ea437..0467e150601e 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -1533,6 +1533,12 @@ int ahci_check_ready(struct ata_link *link)
> >  {
> >         void __iomem *port_mmio = ahci_port_base(link->ap);
> >         u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
> > +       u32 cur = 0;
> > +
> > +       sata_scr_read(link, SCR_STATUS, &cur);
> > +
> > +       ata_link_info(link, "BUSY ? %d (status: %#x) SStatus.DET: %#x\n",
> > +                     status & ATA_BUSY, status, cur & 0xf);
> >
> >         return ata_check_ready(status);
> >  }
> 
> I think I can join the test based on kernel v6.8-rc2, too.
> 
> The original ASUS B1400CEAE has only one NVMe SSD.  I prepare the
> patch ("ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE") to
> fix the power consumption issue for s2idle with enabled VMD.
> 
> The patch is a quirk limiting ASUS B1400CEAE only, not generic for the
> SATA controller [8086:a0d3].  Then, I install another SATA HDD into
> ASUS B1400CEAE for test.  The SATA HDD shows up and works.
> 
> $ dmesg | grep SATA
> [    0.785120] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
> Gbps 0x1 impl SATA mode
> [    0.785269] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
> 0x76102100 irq 144 lpm-pol 3
> [    1.096684] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 
> However, if I simply revert the commit 6210038aeaf4 ("ata: ahci:
> Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI controller"") (fix the
> conflict, of course), then the SATA HDD disappears!!?  Both
> CONFIG_SATA_MOBILE_LPM_POLICY=3 and 0 can reproduce the issue.
> 
> $ dmesg | grep SATA
> [    0.783211] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6
> Gbps 0x1 impl SATA mode
> [    0.783399] ata1: SATA max UDMA/133 abar m2048@0x76102000 port
> 0x76102100 irq 144 lpm-pol 3
> [    1.096685] ata1: SATA link down (SStatus 4 SControl 300)
> 
> Here is the dmesg of reverting ("ata: ahci: Revert "ata: ahci: Add
> Tiger Lake UP{3,4} AHCI controller"")
> https://bugzilla.kernel.org/show_bug.cgi?id=217114#c27
> The code already includes the debug message in ahci_check_ready() from
> Niklas.  However, the dmesg does not show the "BUSY ? ..." from
> ahci_check_ready().
> 
> From these scenarios mentioned above, they all apply LPM policy to the
> SATA controller [8086:a0d3].  But, they apply LPM policy at different
> time:
> * The patch ("ata: ahci: Add force LPM policy quirk for ASUS
> B1400CEAE") applies LPM policy in early ahci_init_one(), which is the
> probe callback.
> * Reverting 6210038aeaf4 ("ata: ahci: Revert "ata: ahci: Add Tiger
> Lake UP{3,4} AHCI controller"") applies LPM policy via "ahci_pci_tbl"
> table.

I don't see why it should matter if we set the AHCI_HFLAG_USE_LPM_POLICY
flag using ahci_pci_tbl, or by your suggested quirk in ahci_init_one(),
as in both cases the flag will be set before ahci_init_one() calls
ahci_update_initial_lpm_policy().


Could it perhaps be that in order for libata to be able to detect your
drive, when VMD is enabled, we also need your patch
"PCI: vmd: enable PCI PM's L1 substates of remapped PCIe port and NVMe" ?


If that is not the case, and there actually is a difference between using
ahci_pci_tbl and your suggested quirk, then my next suggestion would be to
add prints to libata-sata.c:sata_link_scr_lpm(). That way you can dump the
exact SCR writes that are being done for the working case vs. the
non-working case. (Since I assume that there must be some difference.)


Kind regards,
Niklas

