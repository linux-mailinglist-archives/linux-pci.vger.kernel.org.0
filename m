Return-Path: <linux-pci+bounces-12218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93F195FA8A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 22:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1828F1C21C0C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 20:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC45199EA6;
	Mon, 26 Aug 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrMjrflJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11599199259;
	Mon, 26 Aug 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703736; cv=none; b=m0CYkCBrvLNotM6FPd1TUtMiQnNmhvkpleOrzQ6ZZFCX1LtYM8GACwuARE3SC9y6oa6S3rkEXON0Ns0rmkTKEpF67TJ64zp+v/S06GVPiPVKP8pAp/QKmqCX/zXVdeAJvzxeDQE8eCnR7+9wf0ojOI0i2DFICpNYuWC0JPOnTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703736; c=relaxed/simple;
	bh=k/K+est2gLt59r1F7QQa9fKYTBoffp3iB4W+yigUf/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qT65QaWPOvgBxr5cSR5JYX05rJnTSxOmWF3+E/RRN9+n4NA7+dti8EI7PTtrWcsfK4xLP7s+RL7bZjwDC4t8or+Ig8CmKNgiXtOrIUEqjcvAS53fpOTFNcpwtQDmt99iF19j1j/DFh9OJmBNAf5J3/rEFBKCVKogIPP4Gn8N8Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrMjrflJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCF5C8B7B6;
	Mon, 26 Aug 2024 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724703735;
	bh=k/K+est2gLt59r1F7QQa9fKYTBoffp3iB4W+yigUf/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GrMjrflJD7UU7HYTtdBrWdERsKqlOrFBnBrCZg/RTGJajYk4E5uWcrtStIj96Y4jg
	 MEgPs9IZPVSTyOap2xZatTCrNfdZVDz9+kJHoV9HNF1zKSYQENEBCjRHMtaApLactf
	 5ZBweF+7gUZIiZL8u0OpfIcAiWcZk6KTNzuzHNAIz1itbVMTjz3wyWhvu+bY3StRJw
	 v51OlGwmxEIFRDheOVJAPaIL6UoGoE/l2CcTH+t1JWHfks86vKWsqv3Gf36Qi2eg9e
	 X+iKGHnvkC5WIlZn4wqiCnz9g5Cz2xokd6vmvUzi3mGZTOd3M+YIh7d3ArCs59l800
	 O1rAyAfFeSUeg==
Date: Mon, 26 Aug 2024 13:22:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>,
 <Jonathan.Cameron@Huawei.com>, <helgaas@kernel.org>, <corbet@lwn.net>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <alex.williamson@redhat.com>, <gospo@broadcom.com>,
 <michael.chan@broadcom.com>, <ajit.khaparde@broadcom.com>,
 <somnath.kotur@broadcom.com>, <andrew.gospodarek@broadcom.com>,
 <manoj.panicker2@amd.com>, <Eric.VanTassell@amd.com>,
 <vadim.fedorenko@linux.dev>, <horms@kernel.org>, <bagasdotme@gmail.com>,
 <bhelgaas@google.com>, <lukas@wunner.de>, <paul.e.luse@intel.com>,
 <jing2.liu@intel.com>
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20240826132213.4c8039c0@kernel.org>
In-Reply-To: <20240822204120.3634-12-wei.huang2@amd.com>
References: <20240822204120.3634-1-wei.huang2@amd.com>
	<20240822204120.3634-12-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 15:41:19 -0500 Wei Huang wrote:
> +		rtnl_lock();
> +		bnxt_close_nic(irq->bp, false, false);
> +		bnxt_open_nic(irq->bp, false, false);
> +		rtnl_unlock();

This code means that under memory pressure changing CPU affinity
can take the machine offline. The entire machine, even if container
orchestration is trying to just move a few IRQs in place for a new
container.

We can't let you do this, it will set a bad precedent. I can't think
of any modern driver with reconfiguration safety as bad as bnxt.
Technical debt coming due.

