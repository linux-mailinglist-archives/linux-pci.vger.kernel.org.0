Return-Path: <linux-pci+bounces-27804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D666EAB888C
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D7F9E7203
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C737A132122;
	Thu, 15 May 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYDk4/IS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25564A98;
	Thu, 15 May 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317250; cv=none; b=W9opQVdH4RNiDBysb3zHaWSvLPeh3TAj3Flm8NlObLHEfGJNSEm0E/OaebT71aUUVdQK5J2fZbn+WSK935iXKGdQrYW70qwhBisKrpro+04gH+khuMAQRvtKwB9nCZ/WV77KTAuy8nI2dWSo3FgLy80cyrOYb+NKiRzNNHHKYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317250; c=relaxed/simple;
	bh=qis/7P2GU5yvhrel43Yv7JcaotjjyWb/SyxisrkM/BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efLLPYEg0apVM1rresIp2mLArv9Sk7hGV85E7YKefaodILeUHBcEGmp8Fm8eltW3eoSN1PFlXOvHpPh4mOi+O3WDyyjT8xPkkCd6QnAhNWEON5gwezaef+q0oYwOOgTBftPp60sdhp7jg9umDY00qGKEhQr04/LbD5rNUMzwaDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYDk4/IS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADD0C4CEE7;
	Thu, 15 May 2025 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747317250;
	bh=qis/7P2GU5yvhrel43Yv7JcaotjjyWb/SyxisrkM/BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYDk4/ISOyzUQs4q4kxCkluBG7Y7HhFWahc+YaoCBC7y/ra5DUMkfXglO5rIGvQNa
	 or06eeabJbC+Vcm2UXnk2F4gQc6nDRyedK+eKlRLdpcxeerQfVszDqbAUhdiQK38hp
	 oevVH6feMF0FxWXo75pZWe2U/LrQv3dZgx5o6RbZW5a4MRnepyo0BXPLqQBee1BFsp
	 a3kFztRYzmmxFEzcCpD9VXIJKih96OiTYj/LJiK6UnPnaEhbuH19r+V23WKiClLzUn
	 Z9Pj17Lr/f0b3wCVOYnKiY0h8GIEB0UM0QYUvMhJxox0SYDLEI5OprHlt+aBa3MQE0
	 XHDSzgC4n1I0Q==
Date: Thu, 15 May 2025 22:54:08 +0900
From: Krzysztof Wilczy??ski <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
Message-ID: <20250515135408.GB3596832@rocinante>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com>
 <174724335628.23991.985637450230528945.b4-ty@kernel.org>
 <aCTyFtJJcgorjzDv@wunner.de>
 <20250515084346.GA51912@rocinante>
 <aCXZdfOA8bme-qra@wunner.de>
 <98fa31e7-db86-35f0-a71c-a1ebf27f93f0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98fa31e7-db86-35f0-a71c-a1ebf27f93f0@linux.intel.com>

Hello,

[...]
> > > Done.  Squashed with the first commit from Ilpo, see:
> 
> Thanks Krzysztof for handling this, I should have put the note about 
> squashing it to the resubmission but I forgot (this time I didn't do 
> the diff against the previous version before sending it which I normally 
> do).

No problem!  I am sorry for missing the ask in the first place.

[...]
> > > Let me know if there is anything else needed.
> > 
> > Actually, two small things:
> > 
> > - That patch on the pci/bwctrl topic branch is still marked "New"
> >   in patchwork, even though it's been applied:
> >   https://patchwork.kernel.org/project/linux-pci/patch/20250422115548.1483-1-ilpo.jarvinen@linux.intel.com/
> > 
> > - Version 1 of the same patch is likewise marked "New", even though
> >   it's been superseded:
> >   https://patchwork.kernel.org/project/linux-pci/patch/20250417124633.11470-1-ilpo.jarvinen@linux.intel.com/
> > 
> > Unfortunately I can't update it myself because I'm not the submitter.
> > (Ilpo could do it if he has a patchwork.kernel.org account.)
> 
> I'm a pdx86 maintainer so I do have an account, yes. I actually had the 
> patchwork page listing my PCI patches already open, but I just hadn't hit 
> "update" button yet.
> 
> I've done those two changes now.

Thank you!

	Krzysztof

