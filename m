Return-Path: <linux-pci+bounces-16015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B63B9BC19C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBF41C21E56
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 23:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFFD1FE0FE;
	Mon,  4 Nov 2024 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6VGRzY4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCF1FE0FB
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764019; cv=none; b=UCRqiuUwXEWuI2JQyRXhEy/Xra5i5QSXG3iQOOcYm1cupZAUJhAX2CX5gLvkSjGullAJ+SDUaEQ7zDcy46h3J3DZ3kj9bqUgJZfHenQ+RvVd1rSC2jSLw8mxVtnKsJWevXmkLSUV7UlkWD8Rv+3ydpBc4wxpu0oqiqWM20oTQmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764019; c=relaxed/simple;
	bh=OasV7vfEmDR83oCGc861xE25ithKx90OSsVqEi5mln4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iIKH+k2NgfAr7KvH+BKUaMR6aT+Zm1HZPRRs/s6Fel5/BdoMlHVXTh8/4cFP1rR2oZuy4GHiVYGryiQzrDuF6Q9r1f/e5elFzwX8ddqND9YbUW1k6HJZ7ljTahiGD21/8B2AXu0BxD3BZo7vmgJntNyIGj8UaFSH60VqJGufoug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6VGRzY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20077C4CECE;
	Mon,  4 Nov 2024 23:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730764019;
	bh=OasV7vfEmDR83oCGc861xE25ithKx90OSsVqEi5mln4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j6VGRzY4A4GEnUrgnjo3r42gMMKMiYEwBbbTeghrcb8I63QQIN98JAULtTNF6pS0L
	 EHXr05wXu4MLP49W9Y1LKyx7/322BEbjPde4y6BidbGErVFENHlYaLWavprZ/zZN3d
	 ElyPaMh6MoU/q8mtj0AszUmlRzGUUm1f1lTGnP+woW0J6vIpnTsTcatwkt/eSTelp+
	 31osXG+Y7uGYQWXjquvTH7yaJIfS8ERYiGUDY+xp8+fVAx6v4MHhVcmbQAA41yB3N2
	 bmlyhiorjpeYU0FrtMOIiPKS9lZWlY5B3+U96P6hMfCLaRVlWHd4s1SrpSKg/K9Z7Q
	 CLfKumRrZn3Mg==
Date: Mon, 4 Nov 2024 17:46:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: 2564278112@qq.com, manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	dlemoal@kernel.org, jiangwang@kylinos.cn, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci:endpoint Remove redundant returns
Message-ID: <20241104234657.GA1446698@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104133500.GD2504924@rocinante>

On Mon, Nov 04, 2024 at 10:35:00PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [+Cc linux-pci mailing list]

Where did this patch come from?  I don't see it on the mailing list,
so there's no signed-off-by chain for it, and the Link in the commit
doesn't go to the patch posting.

Please post all PCI-related patches to linux-pci@vger.kernel.org.

> > In fact, void function return statements are not generally useful.
> 
> ... unless used within the code for control flow. :)
> 
> >  	dma_release_channel(epf_test->dma_chan_rx);
> >  	epf_test->dma_chan_rx = NULL;
> > -
> > -	return;
> 
> Makes sense.
> 
> For reference, this surplus return statement was added in the commit
> 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA
> capabilities").
> 
> 	Krzysztof

