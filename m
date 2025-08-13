Return-Path: <linux-pci+bounces-33950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A357B24D5F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 17:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9151B60655
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C564E23B63C;
	Wed, 13 Aug 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LumCyFXF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2923B636;
	Wed, 13 Aug 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098796; cv=none; b=ROdRyGcTUIvyqpEKRJ3+hclFiY3uGl8ky8CWU2lMyxqb0hlt2hFdviQWmO0bOeNa652i637tcS23dyDPP+2B/cGcyMPE12R2Ey9VET3Y21MDETaGkBndxXq4peFJZcGqeQ9cUBIuWbI+139wgkcgntFk67LbcTxDjjatbl6wbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098796; c=relaxed/simple;
	bh=r4yT008gulIsZaIB1+4+La/4aOXP2WFeEeTPwlUCmRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNJd6kqlBHd8PtTvKUiYtZUWERykqhXdHdL7JwF+zJRBUjQW4Gd4etE37qMdY1Qo2QM2Etrwavk48sFkPL+nr2ECbNDu7GOqz1AHBt6PuhqWh0Ty/yMHE1nh3LMPS9Vu3C4M85m+1ZE2eJncq5xeyGZ/qZu612z4bLJAOK+nAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LumCyFXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF15C4CEEB;
	Wed, 13 Aug 2025 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755098795;
	bh=r4yT008gulIsZaIB1+4+La/4aOXP2WFeEeTPwlUCmRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LumCyFXF25pdCtl3r5ZNUtIynR5FWAE1U81Corkq5Vxv8e8o5ny54H1BWTY0gUN7U
	 +jwtMtGBBD5N6kATFgqSa44INfkCZ3d2PLD+6gnuUHTbQn5t1pw0HP3BpDQto07XMA
	 fFeOPoqzivDGhZGxiDpVNweI5MqOBp7H0OSEoRm8=
Date: Wed, 13 Aug 2025 17:26:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <superm1@kernel.org>,
	"Rangoju, Raju" <raju.rangoju@amd.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	westeri@kernel.org, YehezkelShB@gmail.com, bhelgaas@google.com,
	Sanath.S@amd.com
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
Message-ID: <2025081320-payroll-skydiver-51e5@gregkh>
References: <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
 <2025080758-supervise-craftily-9b7f@gregkh>
 <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>
 <20250808044538.GK476609@black.igk.intel.com>
 <2025080822-cardboard-aloha-3c5d@gregkh>
 <20250808091313.GN476609@black.igk.intel.com>
 <2025080832-poker-rectal-0895@gregkh>
 <20250811045307.GP476609@black.igk.intel.com>
 <20250811052555.GQ476609@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811052555.GQ476609@black.igk.intel.com>

On Mon, Aug 11, 2025 at 07:25:55AM +0200, Mika Westerberg wrote:
> On Mon, Aug 11, 2025 at 06:53:07AM +0200, Mika Westerberg wrote:
> > On Fri, Aug 08, 2025 at 04:13:28PM +0100, Greg KH wrote:
> > > > 0004 USB4
> > > > 
> > > > sounds good to me. In USB4 there is no "root hub". It's called host router
> > > > (but we do have device routers that are called USB4 hubs for added
> > > > confusion ;-).
> > > > 
> > > > But I'm fine with other numbers too, does not matter if you want to save it
> > > > for some future USB variant.
> > > 
> > > Ok, use 0004 for this.  But what should I use for the text string here
> > > in the usb.ids file?
> > 
> > Thanks! I'll cook up a patch changing these.
> > 
> > I don't think it should be in usb.ids because it is not visible anywhere
> > except over USB4 link (between hosts). You don't see this through USB 2.x
> > or 3.x.
> 
> Of course for documentation purposes it could be:
> 
>     0004 Linux USB4 Connection Manager
> 

Now updated, thanks!

greg k-h

