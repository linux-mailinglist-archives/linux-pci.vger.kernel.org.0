Return-Path: <linux-pci+bounces-12306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D469617AA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8CD1C23165
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830281D1F62;
	Tue, 27 Aug 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doJMjLuw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE96770F1;
	Tue, 27 Aug 2024 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785547; cv=none; b=iObQOHPNyjk7o8jJGPZpLaNoLeXZqx0LVfFL7hiXhXTlDa+Zi1Vvji/nUxjFPk8yGJoaUAHBQKA7bvSj9Uvj+gtK2n7gQuec2B6K6JO1VQgYpkLUTg6RZISmjLyv/vJ/wcc1PnEqz0lQp/S2xBkt2QKc0/ndaLalOAs1vuuMjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785547; c=relaxed/simple;
	bh=2/HpgshCK19xkX85wh1aiPA9KDp9vPJdMLlDAGfD1ls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGAu9Wtni98If+piFRKmd+jFK4KFWK2eC1bcuDGklXXAphk5VD6G0lLVXA0Z7dOHue+7vj5aJWWtoXtOsaO2+o8F6t5NeOt+o2gxaFBWJRl4n30SlXkjzGYi8C4ntPp/bDzL5TzZVi6c6CMhsbPxtQqT04VJv5sRp3OOsdY+UGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doJMjLuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C83C4AF1B;
	Tue, 27 Aug 2024 19:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724785546;
	bh=2/HpgshCK19xkX85wh1aiPA9KDp9vPJdMLlDAGfD1ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=doJMjLuwdHqPWCcV3WE6NSq7XUTWA2rkIlB8ZpgXVXjVC8xXmbqmjBGzbhDZQQLIT
	 oIVBimeSLJ11Sa932CabKaAQUoaOYl3pS7cJ0WC3PbbRJ0f54QNzYYz8xHOVtnlJeU
	 U8Ml6FDCn4OnF71bsjwM/mphrV3GXKuR7DcddxS4tb4y+4PmxxYnTfPwIVv5pAzGSG
	 5xEdjMCv7uGOFx1RfdeaS0+8mhcP7c/HXzQP7jd81yFMCtsmIuqL0No0sef0D7zXhQ
	 lK9hmCC2vol5DX8foaw6iA1nYlFwb9MVxdE7CzbmETs1afbKxAD2mWUDYrwn2lC27a
	 yrkW2JAMtfISg==
Date: Tue, 27 Aug 2024 12:05:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, Jonathan.Cameron@huawei.com, helgaas@kernel.org,
 corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, alex.williamson@redhat.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
 vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
 bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
 jing2.liu@intel.com
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20240827120544.383a1eef@kernel.org>
In-Reply-To: <Zs3ny988Yk1LJeEY@C02YVCJELVCG>
References: <20240822204120.3634-1-wei.huang2@amd.com>
	<20240822204120.3634-12-wei.huang2@amd.com>
	<20240826132213.4c8039c0@kernel.org>
	<ZszsBNC8HhCfFnhL@C02YVCJELVCG>
	<20240826154912.6a85e654@kernel.org>
	<Zs3ny988Yk1LJeEY@C02YVCJELVCG>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 10:50:51 -0400 Andy Gospodarek wrote:
> > The merge window is in 3 weeks or so, so this can wait.  
> 
> Are you asking for the patch for this feature to include the queue
> stop/start instead of this? 

Yes, indeed.

> I just checked linux-pci and it does have bnxt_queue_stop/bnxt_queue_start.
>
> > I'm worried we'll find out later that the current queue reset
> > implementation in bnxt turns out to be insufficient. And we'll
> > be stuck with yet another close/open in this driver.  
> 
> The queue reset _has_ to work.  We will ensure that it does and fix any
> problems found.  Note that these have been under test already internally
> and fixes are/will be posted to the list as they are made.  Holding this
> patch because an API that it uses might not work seems odd.

Not holding because API may not work, holding because (I thought) 
API isn't in place at all. If bnxt_queue_stop/bnxt_queue_start are in
linux-pci please rewrite the patch to use those and then all clear 
from my PoV.

