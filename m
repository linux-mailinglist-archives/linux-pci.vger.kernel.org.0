Return-Path: <linux-pci+bounces-5278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D756988EE06
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CCA2A29CF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7629131BAD;
	Wed, 27 Mar 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaEgEDzX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4E150983;
	Wed, 27 Mar 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563293; cv=none; b=jh9xjMshWBmWcMvgI1VT5T9Jg12NcmxSx028Vd/V9N/50aJnOezwxjZBADeWD1+4U/YektjCIH6HSAJh2BDfhJgOEuweaDUx7J1JYe8J9iVfjZhco6JrulCVugVgEeM6cPmuFJW6C4qT2kbPlimHz2V0+ffGOwrTUDxPSLhgqSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563293; c=relaxed/simple;
	bh=KLbPJmLCts0Ne68/m/5wl8vQWpwEDw1br77DIn3g5Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uL/LBk0NHYm7VwUQ6kmgNPoCxMJTuRNdUzZkh7JPFMjSGDJQzmhlZdQ1BwAPFNuZraT8dL7jQFQutt418Du1sxnNhp7clUdVtzv2bJR0+YEUa0uk4Fhl416O7zpHT7+rzbFtrTEYjGPXrGQyrTVPTPvFBpWZA1099gQO8a+eUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaEgEDzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA168C433F1;
	Wed, 27 Mar 2024 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711563293;
	bh=KLbPJmLCts0Ne68/m/5wl8vQWpwEDw1br77DIn3g5Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JaEgEDzXQQD16OJcGASfUkhWovV2ugdotj5Dp5bdXmZyhQINj1tJmigtTkW7c/0JI
	 TcH/PR0UdNMVmZDcc4hmZ8m9LlyFmYv5rrmxjHgWLgciI/Z+xkHh8aV5Efxvs59iVP
	 AZC34kXxChmB/gAqKc2mAi8+hB3g5q+ig5MrH7iEeVfqw2iNadzng6rEZyJAZs2KIf
	 dbLlE6GT4a0TIQ7hNf10shKE8ToEgr6EVQaQri9GHp1Su7QmTiRrDEjCyHB8yEHjwn
	 XFxR6SdkWvV6iA1b+76bXGqLmZTNlNn3M4rJVEM3JIr0G/Obk29QXo9RB+YD4sLeGj
	 dmnB1d/fWSP5w==
Date: Wed, 27 Mar 2024 13:14:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] PCI: dwc: rcar-gen4: Add support for other R-Car
 Gen4 PCIe controller
Message-ID: <20240327181451.GA1531625@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB110402EB3E15B3471C7F526C7D8342@TYCPR01MB11040.jpnprd01.prod.outlook.com>

On Wed, Mar 27, 2024 at 05:32:57AM +0000, Yoshihiro Shimoda wrote:
> > From: Bjorn Helgaas, Sent: Wednesday, March 27, 2024 5:49 AM

> > >  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
> > >  {
> > > +	rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
> > > +	if (IS_ERR(rcar->phy_base))
> > > +		return PTR_ERR(rcar->base);
> > 
> > I don't get it.  This imposes a new requirement (presence of "phy"
> > resource) on the existing SoCs.  That doesn't sound right.
> 
> According to the dt-binding doc, the existing SoCs are also required
> for the "phy".  That's why I didn't add any condition to simplify
> the code.

Is there anything that enforces that?  Is it possible that DTs exist
in the field without it?  We don't want to break any existing setup.

