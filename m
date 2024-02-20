Return-Path: <linux-pci+bounces-3748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442385B465
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 09:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369DA1C210A0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 08:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1635A4FE;
	Tue, 20 Feb 2024 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHloj4LF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285CE53819;
	Tue, 20 Feb 2024 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708416257; cv=none; b=EsKjLshu8uv3OIZGxXkuNtj/DfKjoVd5suiDoFhiRtPPepvYvdrUnX57eSA1YFzt5Ze9cshW/np87vkWTBkjPHBAfmWXVdAen6Lc3X6b98hn70N1AfhZw17uyTv7jU4lnQShwH01vw+yaGWix8KhZRi4oLD5YAIv/tSHEShKjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708416257; c=relaxed/simple;
	bh=zrBddA7IojfauGvNgwHpxvHnUfdjo+jRvid1hD9gGpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAjpBxlBeEX4UhdEsaR/r4vpi5MZ5govu3Fn2kk4ChoLQdTMUr/QaBQb3D1EqGyPeP66jObh3NRNmmdd5ahMKhp8WMuKY8JvdFJWEVIy/REt3rMGTN8XHRIDMjF6SPbVClDCHEFWtLgCijOFf+7//ilgZ4nSejlYhjNoNw/OgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHloj4LF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832BEC433F1;
	Tue, 20 Feb 2024 08:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708416254;
	bh=zrBddA7IojfauGvNgwHpxvHnUfdjo+jRvid1hD9gGpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EHloj4LF0KIWHY4xjsYee9UCplulDsgbKzfhnsAPdygyqbGOR3ewMyIpQ6ih0Azhi
	 efnvK+uC/CgkKUWPQY/5Bug7NT3XmLc7Bgr7JYPf04hb2WnQNUQSbwdcJwFnJRGmDS
	 KxxXgTdwSD5wp2zd7l+Yai+/D6IALFAxxLG00uw3Z/+5KcNkqIrhToNnqtNMGT4OFL
	 o9sEcU/8c3obdjwXF+mdZ0UqjdBjxPB+Y210vHydpbL72W9WJRvD0GsdIt3jC4bhiC
	 i2JGBaPe5CVWsQdXHn9DLWed7hvbQ0WsggrmBzXCCj+jzfMf6eEm5wJoWj2nue+26r
	 BT8A8gg7Y8v/A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rcL6r-000000002Nj-2FJj;
	Tue, 20 Feb 2024 09:04:13 +0100
Date: Tue, 20 Feb 2024 09:04:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI/AER: Fix rootport attribute paths in ABI docs
Message-ID: <ZdRc_RkaaSMxz8HW@hovoldconsulting.com>
References: <20240202131635.11405-1-johan+linaro@kernel.org>
 <20240202232435.GA738414@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202232435.GA738414@bhelgaas>

Hi Bjorn,

On Fri, Feb 02, 2024 at 05:24:35PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 02, 2024 at 02:16:33PM +0100, Johan Hovold wrote:

> > Johan Hovold (2):
> >   PCI/AER: Fix rootport attribute paths in ABI docs
> >   PCI/AER: Clean up version indentation in ABI docs

> Applied to pci/aer for v6.9, thanks!

I noticed that these have not shown up in linux-next yet. Did you forget
to push the branch?

Johan

