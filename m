Return-Path: <linux-pci+bounces-13742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ACC98E7C5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 02:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E52B1C21130
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4F14C8E;
	Thu,  3 Oct 2024 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nvWRorHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC38BFC
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915587; cv=pass; b=b51hsmJFhVpmocjYbd58+p5MKKKdWYl5JdLjM+ayqhWPyO+ixknQ1ftw/8hXRVWeqa3MARTIEEIZWp2CBiJNm8Bs10LRC1cU68lNCXm00SzWUGCXBaSSiU8wH8qTs2wjYtiEuZzkM6VuAG/eEBmJ7nyXvMrCVIPsFTkPbMwUpoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915587; c=relaxed/simple;
	bh=bukB2Tz4JXCIjky993DAquDVLTNcWdGPULvuUi4oXx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drXPZ4QEWsIeQFKYZ7ZPcMSz8AT8yVpVRIC1J1GTQHrr8PKEJcfjK+O42t7Z/pAVVnzPPXqKEsn/b2RnOBrslszeMUe8iUM6Mo20el7Tf57FfDI7peK2CHzvz+g6guFqCeE/U86eFynUr9k1mt31roxfGfF63cTjeqn0WUpB3zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nvWRorHs; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 983E3844448;
	Thu,  3 Oct 2024 00:32:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-7.trex.outbound.svc.cluster.local [100.99.96.202])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 25DC684442E;
	Thu,  3 Oct 2024 00:32:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727915578; a=rsa-sha256;
	cv=none;
	b=yGs60A/FDDR5aY48xU0JMD1YYvvxpu14aTfb10ktt0nOL0ZrXL7CQi2k1BxLtJC546nyx8
	AyE5c/dK2uUvZ3k8qIiNVqAspdJtyj8QtogXU60nHX2vW+5M/aqHogwVDunVngHAdN6VEp
	NdHPRBpghpv2LVd/+Ni5EB4rXCcfZOtO4se7CN7dnuB5RtPsE7bh01e5OEERuAmqp9GhpK
	eBmpuUKCp7QEOSKRe+hErq1Ry8ymFa0ImuQUvtsR1CSRbMX5DbnK7FoLL4BuSVgewHlDkl
	xhaSGT+Rbf0RxkDlSMn7IRM9ZkYwAsoQWPWa8f4Os/TvspH8uOcBiR7ehFe2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727915578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bukB2Tz4JXCIjky993DAquDVLTNcWdGPULvuUi4oXx0=;
	b=7iuP6lVo/xTrkjTJqV15UY1yu0NiZ9e6mFV0FD71t36WGuAmrWJ/mcPdo3Ccl/HjAa/RHT
	by3lKSGdoh3WxKkTkBKAk5qKjsc6izrsIj66PR7VXVPQ786cf57LGd9dxRS8Z3v7h9kgek
	tNDA2TMC6dDjExmGe3dCnMwgpeHNf/QlYZH9bb5B6j08tQVgwhJwfXAoB+8SAs0E7G5RP3
	c7NwxAWw0OrbfqhiHIOPJZfI+xHuCHJPtwxoZd3S3TU9HrHkTf/UbqZk5NXOgAmYxJuAHh
	/WKVGdkDVa2Bk5OlTUl6Q2thZxE9A4TKVTMKw00KzGhRrjot9d32fsnmOg5z6Q==
ARC-Authentication-Results: i=1;
	rspamd-784544597-8c24n;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Whistle: 0092fae76fccb79e_1727915578408_3264024077
X-MC-Loop-Signature: 1727915578408:2994298954
X-MC-Ingress-Time: 1727915578407
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.96.202 (trex/7.0.2);
	Thu, 03 Oct 2024 00:32:58 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4XJt1j51byz6Z;
	Wed,  2 Oct 2024 17:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727915578;
	bh=bukB2Tz4JXCIjky993DAquDVLTNcWdGPULvuUi4oXx0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=nvWRorHssGLVE2vEsrw8BD8FnXCpiJXipcKmMoyYoXqZ0jfpdb35w5sdpHypqF2EG
	 8q6zbBCqLnxDNEXOpJ0jnlzjKbsCGufZtzmnJ0G2ZCVPJEUzSEP/MJv+LJgsdvwayv
	 zCsf4wkGDzqfM1keR9oPX9TCH06CHINSx/cSbjfB4XxL2gkiCWcq6yq4/VIjqTaSBi
	 1gqOkUVjcdmASZXyAJVC4PrgHpHGFo6tqmf5OMVvbG9WcH13In1D5guKW49n58AoXU
	 Vm3hYu27migvDQ5IhXluTlqTuMy8aNbk7nbyFqbgN/1kLIYDihjuKHn0NYBoKlzg3n
	 YGXksFItMzCtA==
Date: Wed, 2 Oct 2024 17:32:54 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 3/5] pci: move the walk bus lock to where its needed
Message-ID: <20241003003254.cu2qthzl4znajcbh@offworld>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240827192826.710031-4-kbusch@meta.com>
User-Agent: NeoMutt/20220429

On Tue, 27 Aug 2024, Keith Busch wrote:

>From: Keith Busch <kbusch@kernel.org>
>
>Simplify the common function by removing an unnecessary parameter that
>can be more easily handled in the only caller that wants it.
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Keith Busch <kbusch@kernel.org>

Nice cleanup.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

