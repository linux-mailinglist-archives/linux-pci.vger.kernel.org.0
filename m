Return-Path: <linux-pci+bounces-19704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91DA0FD61
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 01:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058D83A042F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8133E1;
	Tue, 14 Jan 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCEHKYVC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7F625;
	Tue, 14 Jan 2025 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736814749; cv=none; b=CVvPFL2C5SlQcfhtxaFzEsr/y574bHTslkLqISxyEXxh4uRhzPdgbDUtntF2GYjp+8WHHk8qnawXaHVrZ2nCYyyaL6hON2KFGJ5MeWzHgqW22YL3fdHRWo+q9XTf0iFb3wWbTMsmLvzN4ainva/kBeKCCfOlIfHibs5CDXyz8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736814749; c=relaxed/simple;
	bh=MuJPG1xWeEcJ/5zpWjCrB5ai+wzkKpDxFeCaGDasul0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoEUA6PvuEfMwgCxRqqZWMCJ/2XHUhwnZ3W7mzRFOCg2tO8k3k7y6XwS1jO7Js9AEWsdgqym2hlD4B+cOm+K/+1pu5pPngSfoIbWsT3rsxYnGCtrAycu6SZjriIzXhj7pdOSHHfOTe3PH18rrh18kL5vnlw0qs7Mix3MyiweDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCEHKYVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB96C4CED6;
	Tue, 14 Jan 2025 00:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736814748;
	bh=MuJPG1xWeEcJ/5zpWjCrB5ai+wzkKpDxFeCaGDasul0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCEHKYVCkQ/8zdGzQbGL2hKlJGiaezYeDSIOWDXewa7qVbBM270JZtpMnkPmj87VX
	 1SQULLGQsfCUVeBUrZYXU3bJzsjPV9lViVOi3AE9JQs8jvSkAwqJfU0RR7PU21jPZO
	 umCgN78PxFFQxLUIgepucT5AWMNXLoeh/XhfDm8zyPhitKx+6giVNdRSQPyM52AFpb
	 XQS7lcpu37cwilKzoy0l7zyxFN/UxpPnAt6i9xw4oBr+u6Egq8Wf25O2nM9GNa8GZ0
	 DFZplcfi/PSVx8qWew2ya1LWDLzOE9UKAcfc5j1axZYnpc6aX2ezjSuZMVbIjBAzjA
	 uOHi2ARCos9nQ==
Date: Tue, 14 Jan 2025 09:32:26 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Tushar Dave <tdave@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH] Documentation: Fix config_acs= example
Message-ID: <20250114003226.GA1810889@rocinante>
References: <20240915-acs-v1-1-b9ee536ee9bd@daynix.com>
 <20250113174035.GA408797@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113174035.GA408797@bhelgaas>

Hello,

[...]
> Thanks for the patch.  Krzysztof added a bit to the commit log at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=57722057d762
> 
> but I think we should also include the flags template:
> 
>   config_acs =
>                 Format:
>                 <ACS flags>@<pci_dev>[; ...]
> 
> so the commit log includes a hint about what "flag specification"
> means.

I amended the commit log.  Should now include the above for reference.

	Krzysztof

