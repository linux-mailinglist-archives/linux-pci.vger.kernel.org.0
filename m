Return-Path: <linux-pci+bounces-41991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EE1C828EE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A86E334AA5B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C232E6BE;
	Mon, 24 Nov 2025 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvcEsMJG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB12F6925
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020556; cv=none; b=tENm5pxOrtpREVShLIs5TmGnZI7w1Wo+dozLM/HzVKBqoeid8GBm6wTCCf1/YJqIylBKyuT4c/jhjkec32h6KekG1HMKSB3TvHxYwniGzmgUopMLt9EJ+4/1I5dhIYcYNWeygmhpBW/24oXpmXVKvy3E1V5ozyFDsd4SjAgSM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020556; c=relaxed/simple;
	bh=Z4FVhZiRSrBA5Yo87CzhF3CXulyhBzdo2pQX0MRLyeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EIDiRWhvwhmPgCx0CRbCZxChCjLvI8QmYLl7Tj3LOe6+1mayoFbddOt5h+FnRlIRCgOw4rMlT6m5V+coTVfFiBkX+r7W7Ux40Va0UT8P5kD4hI0OM/zld/HhlhslSlFyq2oGQHUnrL+52efEakGy1ocA38Mt6hPAMicBGt33DxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvcEsMJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810E4C4CEF1;
	Mon, 24 Nov 2025 21:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764020555;
	bh=Z4FVhZiRSrBA5Yo87CzhF3CXulyhBzdo2pQX0MRLyeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QvcEsMJG4dGjfo4/0yXTt/w+4J2C3kC+GruTI+Kbu/+ALQHwNlLOYx8yvrz6WEYaq
	 mcukbC9DSK+Gwje1sWrFyhJdguvjM3XoZnXPojaQ2ignlLe2vBdTnAp4mRV3QYHqUl
	 AJWU+whPv90hIPy+QZJM/jfNVfMGyiAzsOm/iFE6iyMrLe0k1yx4YyF1FAUEoYHlqg
	 fbGgwWNmNr2f7oD5RjAMBL9Ni8CJCl477rtRr2kXR9zlSkxcshSvhry6h08FxZ3xNL
	 cm2aE97T+eOOUJoSYGHrgleynw+7eyFLqp9ZYgs3flSrfOKSSdaScb00UL6o3Xy/bj
	 xUeushJfcIQ+A==
Date: Mon, 24 Nov 2025 15:42:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com
Subject: Re: [PATCH 0/2] PCI: Universal error recoverability of devices
Message-ID: <20251124214234.GA2716753@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR2NUbTQtD5nx1If@wunner.de>

On Wed, Nov 19, 2025 at 10:26:41AM +0100, Lukas Wunner wrote:
> [trim recipients]
> 
> On Fri, Nov 14, 2025 at 05:45:43PM -0600, Bjorn Helgaas wrote:
> > On Sun, Oct 12, 2025 at 03:25:00PM +0200, Lukas Wunner wrote:
> > > Lukas Wunner (2):
> > >   PCI: Ensure error recoverability at all times
> > >   treewide: Drop pci_save_state() after pci_restore_state()
> > 
> > Applied to pci/err, maybe for v6.19?
> 
> Thank you!  Please note that the second patch (the treewide one)
> was ack'ed by Giovanni Cabiddu:
> 
> https://lore.kernel.org/all/aQtgRy+zSVrvkZg+@gcabiddu-mobl.ger.corp.intel.com/
> 
> ... so you might want to add that tag to commit 73f1f9b0a2c9
> ("treewide: Drop pci_save_state() after pci_restore_state()")
> on the pci/err topic branch.

Done, sorry I missed that!

