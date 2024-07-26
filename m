Return-Path: <linux-pci+bounces-10853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E539393D8D5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B25E1F22049
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 18:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F03D3B8;
	Fri, 26 Jul 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlhuHbJp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C733997;
	Fri, 26 Jul 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020355; cv=none; b=hFay+Bfzc7mlgRGGmQ4NCobtGZ9bEh1s+quv4zYyhJBZt+dYGO977XpGmOej955ePBGF6KrPqv0QijOWqbSjq3SOALyr7ZLjP28ZP+zmiYH62X7fJoGrMjB2dgHU+bK51MvNG1J1HD+XGubfYkDIOV+egU9brBmLI/mgeJvkxB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020355; c=relaxed/simple;
	bh=2dkdImlh/JpVOe68G8vtxHaeKgwWwR0FDWz2vHxHxlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EzbfujoySU4bKWaneWoSgYUErryFa5AUCxytPnLmWp+4tY/VN5W2Gdz31ncLJfTFDGHfkyutGGGhKbuovCCMauJx971d7C/s1iHkAAFdWYerLFUwGpJIyTxHMGaqhw8sHO6B5beJLSTE+p5Ia7Q26qxmAL27YgcW2GF76rvJn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlhuHbJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD51C32782;
	Fri, 26 Jul 2024 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722020355;
	bh=2dkdImlh/JpVOe68G8vtxHaeKgwWwR0FDWz2vHxHxlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LlhuHbJpAWzRVQpFYKPKd1dSlkvGygGRn3Y5C+9ejuQVjbRe9yzp2hbh6QU5Eqoqh
	 /EC+SjiZqGNSIA5A+WxCm49Ikew6jnVFAruZpNc035WkB9qYQlCfl9hwrAeaB75NWF
	 gxvq1AbLehqrSN6fEZgJLkurer94yld7zS/SQxm4f4+C4BkDGAZ1pYmdiK5K2WmSN3
	 AqeidechjUVDflEfTYspb99VIVndHSq+hHcgn4tPF1E/7+CKl39Ty+FHWCYVYxf0AR
	 2cWbMkHJPn/zZ3zCmAIjwzdoQP+0S7j7g1NzHBDArJ8FTGP5HUXvXEgUkcAWf39THZ
	 G9W8eyu3238BA==
Date: Fri, 26 Jul 2024 13:59:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: pstanner@redhat.com
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
Message-ID: <20240726185913.GA916353@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com>

On Fri, Jul 26, 2024 at 08:43:12PM +0200, pstanner@redhat.com wrote:
> On Fri, 2024-07-26 at 09:19 +0900, Damien Le Moal wrote:

> > Tested-by: Damien Le Moal <dlemoal@kernel.org>
> 
> You might wanna ping Bjorn about that in case he didn't see.

I amended the commit to add this, thanks Damien!

