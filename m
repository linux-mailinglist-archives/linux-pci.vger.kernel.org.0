Return-Path: <linux-pci+bounces-5019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1088740A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 20:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4FE1C213AE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A27F486;
	Fri, 22 Mar 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjEscHMZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ABD7F46B;
	Fri, 22 Mar 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711137375; cv=none; b=O170sPOJCu+r7bcDc/ZkYQzqxlNkyBe9B/H/CPg+O07IRYssR3OBGoBspQ58R7nVcEJ9VEbkrshL4nlW5ZDKRzBwC/qS3yLOgS91alA+LUJUxKPBVZmoApAv4zkCA4upAa9Md7/vOZ9CWkWogaMvOqjq6z3xUugCJjMHWWaS4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711137375; c=relaxed/simple;
	bh=aJpcLvTHfsXX8ar5QTyJ9XLwXZCvmzpClHR69xGufx4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bHTAOo4QwLByIDWA7rUIUhUsJ45AAHQYQcmi2PtnTnhKibaZGR5ySXznEGUOhHfiVuDP9ep4xpQPpMWpvKfIX7NqyoGkk+g+AMWcod8cpHuL+jhc6UxZH/zUir2w9v6T+g0AHm+05iLJKftlGvoGS0hsn3b3h86HRwZhCHxXkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjEscHMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D7AC433C7;
	Fri, 22 Mar 2024 19:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711137374;
	bh=aJpcLvTHfsXX8ar5QTyJ9XLwXZCvmzpClHR69xGufx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XjEscHMZnQCObYxovuq/iwu7Jk0iYji0tcGL9kdl+++c+Ptcen2iCQ2OtYHlBCW/1
	 bD+9YHrMgqUYIYxol4ZltczzavtxLW7a3QTPJ4n6HXr78zD0r7PLLhYrp4uxt9UCo0
	 k8TpCc3P9zrFbyip6kAH+1GOlDOKcJt2m9mVbSq5Ab+iSWXsJoLxWAkqmbnXMrbS69
	 t9Gyb4OZsg8N2YenSJQhrpeluNbr6e55kb6i+JgkV/IIgLwcGB23mVvvk/OdiJnvZb
	 PFqXVFXPpeADGRwc/6qZfEBPC8G5VeV1510qOI6MSwBmdDaMqfCl7rUU5Bcnqr/7Yw
	 /r8lPrTipI4+w==
Date: Fri, 22 Mar 2024 14:56:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
	linux-leds@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240322195612.GA1372991@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312100816.000071ec@linux.intel.com>

On Tue, Mar 12, 2024 at 10:08:16AM +0100, Mariusz Tkaczyk wrote:
> On Mon, 11 Mar 2024 17:30:06 -0500
> Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> 
> > > > No, Linux doesn't support _DSM. It was proposed in previous
> > > > iterations by Stuart but I dropped it. We decided that it need to be
> > > > strongly rebuild because "pci/pcie" is not right place for ACPI code
> > > > so we cannot register _DSM driver instead of NPEM as it was proposed
> > > > and I don't have _DSM capable hardware to test it.  
> > 
> > I'm not sure I understand why pci/pcie isn't the right place for ACPI code--
> > there are other _DSMs used in PCI code already, and this _DSM is defined
> > in a PCI ECN.
> 
> I looked into internal review history and I found out that I dropped it after
> discussion with Dan Williams:
> 
> > After review and discussion with Dan _DSM extension is dropped.
> 
> Unfortunately, I don't remember what exactly he suggested, I just remembered
> conclusion that it needs to be reworked and I decided to drop it.
> Maybe, I didn't understand him correctly.
> 
> Dan, could you take a look? Do you remember something?

Straw man proposal:

  - Update this patch so we use NPEM if the device advertises it.

  - If/when Linux support for the _DSM is added, we use the _DSM when
    present.  If a device advertises NPEM but no _DSM applies to it,
    we use native NPEM for it.

Bjorn

