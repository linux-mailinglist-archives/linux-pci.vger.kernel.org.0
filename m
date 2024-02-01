Return-Path: <linux-pci+bounces-2926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 071BE845AC6
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78CC2847AB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865F5F483;
	Thu,  1 Feb 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHGASKvr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E705CDF8;
	Thu,  1 Feb 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799708; cv=none; b=MEbRDr/As2W+1HYFG3081YMHC+sM4vKxqt/r7C3mWVPCOOX0jxfaM6Tn54gajuYigz6F/mgw1QYlZ+9yU8Q+GX/TZwavK8bORMJxFppEBmc5RIGRYyqxWQ4mzN9wcbxrDXHYnG96tj74AatLDyU2JBpCNN8KCXjReIeI7gtrcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799708; c=relaxed/simple;
	bh=fyS4E6dCzTmikshMEzUqt7RbzPw9XaUCcGp0oaYwbvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7vCTNJq7iEYlfPiZasjZHjMHQVlkofHn7HChYvF5B1LDAu+z/ySSltQo7jVsRr6Dlll9LJx0T1xTVbErHnDiM5mCn/HtSFpIcDn+ft9efhChWvQe3Hm++fhAwzA6KWDVqN30sZfyQdrLty6Dg5Mr4PmW2HLS3InkoaymNnFY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHGASKvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B71C433F1;
	Thu,  1 Feb 2024 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706799708;
	bh=fyS4E6dCzTmikshMEzUqt7RbzPw9XaUCcGp0oaYwbvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHGASKvrmM3ACF7dACXxR5LVFZ309w8Y+Oe5Tmi/uyIgXkFWB2WJ+IJUWadUG1PG2
	 LpA1eYx1KtOryTb6fp4Q8TirguIZvuH/CQr9cCP4MRfd99cFJaGI/5EUufDgqzzaAI
	 jnm9fqq6sdesM/lXyi2JA/k1ZQ/ypEgExbP/4znbW4sBWm1zSaB+9dDCz3pX0jUaY2
	 ghSNPgK1cc+Pcuf6hn6HSlZy6HyPGIVaKrTcDdMmOrmYp4ovah40D60RWwF5w9rvFJ
	 8e5oYEoiLmkH1oSPU3IIeJCrGybRSCOM6en2MPR7adJ1IqNMly64fLp0oJtTh6HYeI
	 IrleBlpjTbPuA==
Date: Thu, 1 Feb 2024 16:01:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Daniel Drake <drake@endlessos.org>,
	Vitalii Solomonov <solomonov.v@gmail.com>
Cc: Jian-Hong Pan <jhp@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-ide@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@endlessos.org
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS
 B1400CEAE
Message-ID: <ZbuyVbMEBWKi729y@x1-carbon>
References: <20240130095933.14158-1-jhp@endlessos.org>
 <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com>
 <Zbonprq/1SircQon@x1-carbon>
 <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
 <ZbrNLxHL03R66PxQ@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbrNLxHL03R66PxQ@x1-carbon>

On Wed, Jan 31, 2024 at 11:43:59PM +0100, Niklas Cassel wrote:
> On Wed, Jan 31, 2024 at 07:08:12AM -0400, Daniel Drake wrote:

(snip)

> In libata we perform a reset of the port at boot, see:
> libata-sata.c:sata_link_hardreset()
> after writing to SControl, we call
> libata-core.c:ata_wait_ready() that will poll for the port being ready
> by calling the check_ready callback.
> For AHCI, this callback funcion is set to:
> libahci.c:ahci_check_ready().
> 
> A reset should take the device out of deep power state and should be
> sufficient to establish a connection (and that also seems to be the
> case when not using Intel VMD).
> 
> However, if you want to debug, I would start by adding prints to
> libata-sata.c:sata_link_hardreset()
> libata-core.c:ata_wait_ready()
> libahci.c:ahci_check_ready().

FWIW, this will dump SStatus.DET every time the check_ready callback function
(ahci_check_ready()) is called:


diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1a63200ea437..0467e150601e 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1533,6 +1533,12 @@ int ahci_check_ready(struct ata_link *link)
 {
        void __iomem *port_mmio = ahci_port_base(link->ap);
        u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+       u32 cur = 0;
+
+       sata_scr_read(link, SCR_STATUS, &cur);
+
+       ata_link_info(link, "BUSY ? %d (status: %#x) SStatus.DET: %#x\n",
+                     status & ATA_BUSY, status, cur & 0xf);
 
        return ata_check_ready(status);
 }

