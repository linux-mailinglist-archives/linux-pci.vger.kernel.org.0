Return-Path: <linux-pci+bounces-30521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC220AE6B8A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C26A17A5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926B3074A6;
	Tue, 24 Jun 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpBF33O5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AF307480;
	Tue, 24 Jun 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779660; cv=none; b=QAvXLa6qgEOVx5OdFxou6GXgtVjz4CKuUCAwzSdyOcamP97v2TUQZqhke0ernH1rIFLf2FoI0oXAHLFDbP71nuEt1if3W6CwW7oO3rJiIgQzIopoT+VE8mdk/kfUqHOMcmkHBjbAhSYXt4vqZyHL43y09kwPWEL/0kZZkWucX5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779660; c=relaxed/simple;
	bh=V4cFT1hqRldsR5zu8HOg3Q2LTneYk9DIMbOYJXD5/V0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MwKWmF7fKgq/MOHyZpCsMkz3xwYVdFWh9LKNkmCyRLaF49jPa3eCAnqerfdAUvgB1CLb+k3q6XUugkBy/lOZTDuhs5kBV42PTJVUm24gkb0HGsoxOfzC4w+0qKqJrfLY0H89D2MVUpieEi0gJSOJrolmII3rGJYYbZgFaKvlsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpBF33O5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D022AC4CEE3;
	Tue, 24 Jun 2025 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750779660;
	bh=V4cFT1hqRldsR5zu8HOg3Q2LTneYk9DIMbOYJXD5/V0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SpBF33O5DmWK2ju99YB+4lma9jKXpW06Qy7WaO72fUGRR1bwapxUreARlC7ACWT6K
	 d7vv4X3sGIn9LGbgcTNo3m5HJIra8v37CKiK8VkCbUNooIqlcYyh8VByADcphLjB9W
	 hYlSLlPFnIJKGwnFPitY38ytqBnIwNYFchiWpKgQFsRDQMDIhi5yhHtaKUrJqUIfhI
	 M+utXRuCz03/g3TIw4+WeJGu3yf5PFgqTBHYBduyJ+DgVZQ5TroV2E01VPGEMlzJrk
	 LU61+IsoQyxe1V5snMuI1Aeg04lidkunp9VMazrO8DDzUHZSLfluTSyWQAZA4nsWG6
	 Cps8jR3ACfGjQ==
Date: Tue, 24 Jun 2025 10:40:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"elbadrym@google.com" <elbadrym@google.com>,
	"romlem@google.com" <romlem@google.com>,
	"anhphan@google.com" <anhphan@google.com>,
	"wak@google.com" <wak@google.com>,
	"yuxiaozhang@google.com" <yuxiaozhang@google.com>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH 7/7] pci: aspeed: Add ASPEED PCIe host controller driver
Message-ID: <20250624154058.GA1478094@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEYPR06MB5134973F678EB5B163DD50809D79A@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Mon, Jun 23, 2025 at 05:41:13AM +0000, Jacky Chou wrote:

[Apparently you trimmed out some of the lines that show who said what;
there should be more lines here like:

  > On Fri, Jun 13, 2025 at 03:03:55PM +0300, Ilpo Järvinen wrote:
  > > On Fri, 13 Jun 2025, Jacky Chou wrote:
]

> > > +#include <linux/irqchip/chained_irq.h> #include <linux/irqdomain.h>

> > > +/* TLP configuration type 0 and type 1 */
> > > +#define CRG_READ_FMTTYPE(type)		(0x04000000 | (type << 24))
> > > +#define CRG_WRITE_FMTTYPE(type)		(0x44000000 | (type << 24))
> > 
> > These are straight from PCIe spec, right?
> > 
> > I think those should come from defines inside
> > include/uapi/linux/pci_regs.h, there might not be one already, so
> > you might have to add them.
> > 
> > I also think you should actually use the type as boolean, and
> > return one of the two defines based on it. A helper to do that
> > might be generic PCI header material as well.
> > 
> 
> Agreed.  This definition is used on TLP header.  Maybe I will try to
> add some definitions to pci_regs.h or pci.h

This values might come from the PCIe spec, but unless they are needed
outside drivers/pci, any #defines should probably go in
drivers/pci/pci.h.

