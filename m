Return-Path: <linux-pci+bounces-29974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA1ADDCDA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 22:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB42B7A2782
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 20:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A939FD9;
	Tue, 17 Jun 2025 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqQcH2uQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1ACA4B
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190571; cv=none; b=Kj5PGmRDAoyt5OCrl5IEQYfUCXzkV3I8XRxMXuaQ/VoZjTVk4DWG6dGTa84cGhOBdvT+a+3l1zrcXWXC+V5UfO04wXkqPWF9AlAvY725NI8etfKtQ6xgBSnOVAhcpiplLtpGNJ7jYjlG69rsj6lB5k54JJaTolofjODgCQT5Z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190571; c=relaxed/simple;
	bh=GLxXCB6GIekCOciNXeiNF8VSqjsyBIvo0ESrfPNuXOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D151KoKQLx3EUVOpvB2623nS0UrXbN5rLGM5HJfBNWEBmeECLyG9lDoIodv4kyOSpTHo1BA54DK5iZvZ3TiLT4n9ieXU1oyfqUAD1j3GyMavDDnvE0bRQFhokWDq69i+sA02pQvDSnDb844Sr9LbxWI7YiCrATBNR1HU/NnDAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqQcH2uQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9680FC4CEE3;
	Tue, 17 Jun 2025 20:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750190570;
	bh=GLxXCB6GIekCOciNXeiNF8VSqjsyBIvo0ESrfPNuXOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qqQcH2uQKGlVuEF07jLQeY5oId499XA6K/UEXF4e4ZcGOcV/XcwBQgrIs1xLVNxUK
	 eMpP5wn0ID46acXqG1wb63WkAj+A1eJBfrzW3Qcs8fWd6MmmZ1Q012qAiyYHDe3W/+
	 iHhw4/2QUOLbgjHJAUcmVXd9MrvFHj1fiurjScXLwmfNLe+mIfHE8K4g5TKTlh3TOP
	 /Fff4GvHeZmf+VVf+kr3Mvb8ISt+cTGT64dhyEwDzt7Twry225e8qwEo7QhTUECqtS
	 T+Wy+cfzrST8/nq7uw1krVL1pfGpeocVoCFw5WAlOhutMm58J3KBZEZ7nEsIxeg+yN
	 lcafqihU0Hw6w==
Date: Tue, 17 Jun 2025 15:02:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linux-pci <linux-pci@vger.kernel.org>, mahesh <mahesh@linux.ibm.com>,
	Oliver <oohall@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
Message-ID: <20250617200249.GA1150249@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129057878.1309277.1750187955867.JavaMail.zimbra@raptorengineeringinc.com>

On Tue, Jun 17, 2025 at 02:19:15PM -0500, Timothy Pearson wrote:
> ----- Original Message -----
> > From: "Bjorn Helgaas" <helgaas@kernel.org>
> > To: "Timothy Pearson" <tpearson@raptorengineering.com>
> > Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>, "Oliver" <oohall@gmail.com>, "Madhavan
> > Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Lukas Wunner" <lukas@wunner.de>
> > Sent: Tuesday, June 17, 2025 1:59:38 PM
> > Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
> 
> > On Tue, Jun 17, 2025 at 11:10:50AM -0500, Timothy Pearson wrote:
> >> ----- Original Message -----
> >> > From: "Bjorn Helgaas" <helgaas@kernel.org>
> >> > To: "Timothy Pearson" <tpearson@raptorengineering.com>
> >> > Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>,
> >> > "Oliver" <oohall@gmail.com>, "Madhavan
> >> > Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
> >> > "Lukas Wunner" <lukas@wunner.de>
> >> > Sent: Tuesday, June 17, 2025 11:04:28 AM
> >> > Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
> >> 
> >> > On Tue, Jun 17, 2025 at 10:41:58AM -0500, Timothy Pearson wrote:
> >> >> Add pcie_link_is_active() function to check if the physical PCIe link is
> >> >> active, replacing duplicate code in multiple locations.
> > 
> >> Will do in the future.  There is some urgency on this overall
> >> patchset as we have had hotplug support broken for many years now,
> >> and it's causing continued problems on customer deployed machines.
> >> While we can continue to point customers at the patchset and have
> >> them compile their own kernels, patience from our customer side is
> >> wearing a bit thin for that.  I will continue to try to push this
> >> forward (along with the associated ppc patch set) at a more
> >> reasonable pace.
> > 
> > Apparently this got pulled out of a series where the urgency might
> > have been obvious.  As a standalone patch, AFAICT it's a cleanup that
> > doesn't actually fix any problems.
> 
> Correct -- my apologies for not making that clear.  The original
> patch set for ppc (PowerNV) hotplug fixes was blocked on this
> pending patch by the ppc maintainers -- logicially it makes some
> sense, but I can't really submit a series that requires both groups
> of maintainers to approve.

Two paths:

  - Best choice: since this is a cleanup that doesn't fix anything,
    pull it out of the ppc series, fix the problem, and add the
    cleanup to your TODO list for resolution in the future.  AFAICT
    this patch, at least v10, doesn't touch anything remotely
    ppc-related, so I don't see the connection with PowerNV.

  - Alternatively: send the patch to both sets of maintainers (ppc and
    pci), and maintainer less affected can ack it and the other can
    appy it.

