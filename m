Return-Path: <linux-pci+bounces-21089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EEEA2F1C6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 16:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567921611A0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC45623BF84;
	Mon, 10 Feb 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXyO3kbX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689623AE8E
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739201525; cv=none; b=QfHI6CYlpcfda4fq5ZlNvOK/cV3Vx4A8ru+Pj07YW3Qmr1wGNDatQ2kFmjgtJv/TjaJfXU8VtT4tPDsJJUn+/eCQpegRScICW6hYgQpVxX0SiIWXlsWyNCDm1LKvFtrxGKBMS9MSFevaRkBBynduNVsakh8ftTpWtZZhKY7FCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739201525; c=relaxed/simple;
	bh=J1txiC+7XGCUcKNAIj9Ckq31hPjHma/hMYcKlWTKvbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY0BCpyh5PVjuxn12vRWLfdGfvilihuhpnfCRRnFAwax1icuBg4qxQMWFwKPxOnkyUTkgO+23h52WFdP2TD1uH310EooMGG2wB9gd4qrgO21s9D8AXzqLMEZeSZIvWqq+iEcIqb/DriIR9LPJtEa/gRrKE0kN3vE1/NW39XPFG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXyO3kbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34175C4CEDF;
	Mon, 10 Feb 2025 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739201525;
	bh=J1txiC+7XGCUcKNAIj9Ckq31hPjHma/hMYcKlWTKvbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXyO3kbXy81dvrQuQPVE1sZ8kXQH6cuoMHFOcU9fefLdVAx1O8Ajf/+eJxHUyBfs9
	 qygkvdCvmRIKjWbMj5f/UoK5G85MfDKlB5+a9aYC0d3Tug/PkqMvTJxqK4WQIZwImc
	 i+Gmp6z/Llx/O30tzXzuBfl1MBxXU28f+YebjB5aGtr+bPPhT7KgCPbhehKzWQaDkH
	 XK11zjMZ/677zcXnQpgTrm9+RoOXGt/sQlaGCBcNqUrT5gIV1rq5XBvJkzjTzG+Mqm
	 zORlqQ6QUGConP/FyIfuySkNfVU48qt6zTUF4SUS8RYaSns+iENJfIgHqku+pF5mba
	 Y4al4U5RJ8m6Q==
Date: Mon, 10 Feb 2025 08:32:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: allow user specifiy a reset wait timeout
Message-ID: <Z6ob8zU52N5IkfHf@kbusch-mbp>
References: <20250207204310.2546091-1-kbusch@meta.com>
 <Z6bifFBdh-jfEiXQ@wunner.de>
 <Z6oUNYyPzAFkDOSR@kbusch-mbp>
 <Z6oYKnX9HHPDoCU2@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6oYKnX9HHPDoCU2@wunner.de>

On Mon, Feb 10, 2025 at 04:15:54PM +0100, Lukas Wunner wrote:
> On Mon, Feb 10, 2025 at 07:59:01AM -0700, Keith Busch wrote:
> > My concern with quirking it is that we'd have to settle on what we think
> > is the worst case timeout, then it becomes compiled into that kernel for
> > that device. The devices I'm dealing with are actively under
> > development, and the time to ready gets bigger or smaller as updates
> > occur, or some new worst case scenario is discovered. Making this a boot
> > time decicion really helps with experimentation here.
> 
> I understand, but honestly this doesn't sound like something which
> needs to be in the upstream kernel.  If it's for experimentation only,
> I'd keep it in the downstream kernel used for experimentation
> and if it turns out that 60 sec is insufficient for the final
> production device, I'd submit a quirk for that.

It's always a pain to carry out of tree patches. These might be devices
having active development, but they are used in production and the
systems they're in follow the standard kernel updates. And before this
generation of devices even settles on an appropriate quirk timeout might
require (if that ever happens), I have the next generations to deal
with, so this need isn't going to go away. Carrying such an out of tree
patch for eternity sounds unpleasant.

