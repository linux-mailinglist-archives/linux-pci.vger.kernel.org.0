Return-Path: <linux-pci+bounces-5757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1908789939B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 05:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB011C20FAF
	for <lists+linux-pci@lfdr.de>; Fri,  5 Apr 2024 03:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF1179AE;
	Fri,  5 Apr 2024 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiHLdHWc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBFA125C9;
	Fri,  5 Apr 2024 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286526; cv=none; b=ucArPAodDHmHg2II4egm35NMlwLW4sqAVgxtqcAKshnEnDE9+w8hLslvM0Bt6q+qpLZA8KacGfahbiepMYuR2f4jD4HExFx0Ykp4GBR21L8fFgWvoE/l6+6GD6lID/B+1ge9zurBUJtjeJmteNAaCEC/uc2/QiIT0GyfsPinrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286526; c=relaxed/simple;
	bh=o1wyfEzbR+zZEUSiRrlMgpl7GtYOT0TQLB+xlY10fGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aazyNJXBeipyXtiibn8clAewaGkj1UYUFKxROCQ64LEOEb4k97PusI58zhWMJCF/JeUNfV5z62fBXOrJxc4Y6VYSWKbWprg2fqzKEnzntE/ReAlIxvijKSpFYecbfn2KEuVLnyXcvk1hYEsuL+yf5flXAZlRvRlXqYu7ljpsnDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiHLdHWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB16DC433C7;
	Fri,  5 Apr 2024 03:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712286525;
	bh=o1wyfEzbR+zZEUSiRrlMgpl7GtYOT0TQLB+xlY10fGk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WiHLdHWcgLi4oZg5ZPDWkA1Lm1SjYiHTbrpYXj45KyEbgrIbBfBFVUB62C2rplcyv
	 W2LiVXPxACcPHeyZ6Eilw6jTHVuG1L3CjKCqletLjA0vE7kspJ7KXbPdqeIOmJol2S
	 rv6MCDcY0vjbrdC1B8BPlhC2s5kg3gl4peUd2wVGZqhw4sISzUKAmsk6ws+1JQi28/
	 GLfSRD98n7XsnU9bQIOrfOMKvCUP9wOyB2HorE9xfPVgik5H0+vjpaIRWWdnkaNg2t
	 7J8J/dMXralbOLFeLKsXqDyknAW3EaYddH1SgYbvUeaKSGJTZDSPIumretRZ037tNF
	 pzjB4WcaxxdLw==
Message-ID: <a1e5ccd3-1a9b-4d78-8216-2274e1222bb8@kernel.org>
Date: Thu, 4 Apr 2024 21:08:43 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 davem@davemloft.net, pabeni@redhat.com
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <d0bd66c7-13d2-40a3-8d7d-055ac0234271@lunn.ch>
 <20240404083752.5c81d369@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240404083752.5c81d369@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/24 9:37 AM, Jakub Kicinski wrote:
> On Thu, 4 Apr 2024 17:24:03 +0200 Andrew Lunn wrote:
>> Given the discussion going on in the thread "mlx5 ConnectX control
>> misc driver", you also plan to show you don't need such a misc driver?
> 
> To the extent to which it is possible to prove an in-existence
> of something :) Since my argument that Meta can use _vendor_ devices
> without resorting to "misc drivers" doesn't convince them, I doubt
> this data point would help.
> 

When this device gets widely deployed and you have the inevitable
production problems (inevitable in this sense this is designed,
implemented and deployed by humans who make mistakes and then S/W has to
compensate for the quirks), you can see whether it is easy to
completely, sanely and efficiently debug those problems solely with
extensions to open source tools.

But, I am guessing that is still 1+ years away before you will know.

