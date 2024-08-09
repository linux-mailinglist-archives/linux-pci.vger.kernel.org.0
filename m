Return-Path: <linux-pci+bounces-11554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF5694D628
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4124F1C21B96
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3022146A9B;
	Fri,  9 Aug 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpPpxy8X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C2886AFA;
	Fri,  9 Aug 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723227277; cv=none; b=Ufcr/5kfGZvV0QJVEon83B4P5T12W3DAMZhbC6IXeNDMepkyMRc88be8v60fG0Hr5H0em07TxnAHyT6Dp+00pWwBQJEf0nLqlOZ7C79MlQBh/VV2lIMNU9w2ImC/bbq9VmWwZFA8BzvpfwYPtOLZsS/6yf3ZBC0/yPs+u/Td5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723227277; c=relaxed/simple;
	bh=U6g/vI4//hCrkCURSAufYPR1MuKFsSgnLwhKCTg1kbs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TKyTCpqqdJTkn/wbySlMjUt2ZDH0ZvrPwt0wnOkg80dOsjj76CouPH1snstpDqhbSzsbOx6cyEMo9oRgYSDvAZHfcBCk+qYbFHi4sOfcXltoyPPrjvdB3ZtRoOL0ltor4/EkXvE2NAYnwDZqvHHo5pDJMOsjP0HkzmmdjYMZJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpPpxy8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AECC32782;
	Fri,  9 Aug 2024 18:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723227277;
	bh=U6g/vI4//hCrkCURSAufYPR1MuKFsSgnLwhKCTg1kbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WpPpxy8Xv82wqliivg1FSjLFdVAv4VzGN0GQu+u/q+J3vdHTaRLjvY4AcThdrXnSb
	 86YV7o++oLjkH5TyHXQssoGfxULPdbn/O8S7SwWjgt3gaRraGAglOpSKUaZ6KlVTYq
	 xtGBigI4UME/b/d5ZjvlNSj/mjs429TL+6zeYvvDRxwroLPZlnrWuCwIcsdSpgBVwe
	 xoK9I5ZD6tojOfa/lG1FCwPO9AwQ5/FcnViv/PsH9UwARY45AXhpfr3s214t7NqAgk
	 7aUYhjtzGciFeWvPUgILQKf/shTb7gTCGX2YaXVBW1zzLDfLSYi6oNQF9LgjUJaliW
	 WSHyqMdGZ31MQ==
Date: Fri, 9 Aug 2024 13:14:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guilherme =?utf-8?Q?Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: remove type return
Message-ID: <20240809181434.GA204249@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_RzfYZLVTNgvML3OuBDoupcz4BxWHY3R1mUmVaskD5648x1A@mail.gmail.com>

On Thu, Aug 08, 2024 at 06:05:54PM -0300, Guilherme Giácomo Simões wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> >
> > On Tue, Aug 06, 2024 at 05:54:15PM -0300, Guilherme Giácomo Simões wrote:
> > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > > On Sat, 3 Aug 2024, Guilherme Giacomo Simoes wrote:
> > > >
> > > > > I can see that the function pci_hp_add_brigde have a int return
> > > > > propagation.
> > > ...
> >
> > > > The lack of return value checking seems to be on the list in
> > > > pci_hp_add_bridge(). So perhaps the right course of action would be to
> > > > handle return values correctly.
> > >
> > > Ok, so if the right course is for the driver to handle return value,
> > > then this is a
> > > task for the driver developers, because only they know what to do when
> > > pci_hp_add_bridge() doesn't work correctly, right?
> >
> > pci_hp_add_bridge() is only for hotplug drivers, so the list of
> > callers is short and completely under our control.  There's plenty of
> > opportunity for improving this.  Beyond just the return value, all the
> > callers of pci_hp_add_bridge() should be doing much of the same work
> > that could potentially be factored out.
> 
> Okay, then what the action that the drivers must be do when the add
> bridge is failed?

pci_hp_add_bridge() fails when there's no bus number available to
assign to new hot-added devices.  When that happens, there's really
nothing the hotplug drivers can do to improve the situation.
pci_hp_add_bridge() already logs a message for one of the failure
cases.  It may be that it should also log a message for the other
failure case.  The end result is that we can't use the hot-added
devices because there's no space for them in the PCI bus number space,
so we can't address them.

Bjorn

