Return-Path: <linux-pci+bounces-6401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC928A9443
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 09:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5841CB21948
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D88C6F060;
	Thu, 18 Apr 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifd/1TqP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C6F495CB;
	Thu, 18 Apr 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426057; cv=none; b=jcFTQxKTJUUSZbfeeiBi075gB48acJ7+0TMQemjVa7TlGXU3SXsBNu+eqLeJDcX6fTeJMPPiEkRa3dTA7KNYBW+c1nVYbYaMamAytXPg6AjKTHQPYcqiTn9Q3yq4aA5P8PRfIlmd1tLUDNGbaU06t3vVXdl245sMh0mHpxEOU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426057; c=relaxed/simple;
	bh=/9Nl/8RuILo1MY3dqqjIERbCWo3nCrR9a0GLPOG4+IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZp68M7DUcS3n4D6Yh2RwzSjok0VXz53tJHErtJo/PtoVTFOdo5tMcWVGfdjwyZake3wpqcYyejAsQ37Ek47/eSLBs6fhVUu62lvepWrBMMjBZ2ZFW1CJUDe26wjkXc/5bAbPMRVCoMQToBlsNFFQwptNOTH+ysFGXNQZCUOyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifd/1TqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E81BC113CE;
	Thu, 18 Apr 2024 07:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713426056;
	bh=/9Nl/8RuILo1MY3dqqjIERbCWo3nCrR9a0GLPOG4+IM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ifd/1TqPGQVCAMTVWhocs3n6jbCgfh1wYezSH4McXtIpi7cVmp89tdI0HcsxcPj85
	 uia4lin9OSY0ZrCs+wkITwN+vjY3cYqtQ9DxCK9d0R+FxVQeq48bu6LySR8/5xJoNY
	 XqE0TOdVahgXFtRFxV7K2c8yC3dLI/NS0Cmff4exfUAtMcVxiD6+H8vtZoNTUkGbBC
	 AIQxle/9r5kTT79aWSx2Mx81bYyF2uxUcsvH4rVlO3F2mN/0Os7+yiNkBC3xFK8Kqu
	 UNtMYtea0BTQ7zbbJmm2jX4h4Jp2ZJaiJdFrGYnOOj8jBSVxPhUBZXPQtSF1isCAvb
	 BReQW/lwo72Tg==
Date: Thu, 18 Apr 2024 09:40:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Make use of cached
 'epc_features' in pci_epf_test_core_init()
Message-ID: <ZiDOgr46TpJmC96e@x1-carbon>
References: <20240417-pci-epf-test-fix-v1-1-653c911d1faa@linaro.org>
 <ZiALuYlshLmwLhvu@ryzen>
 <20240418054319.GB2861@thinkpad>
 <ZiDB18w4bnUCSH7D@ryzen>
 <20240418065308.GG2861@thinkpad>
 <ZiDITzuUXsTZ7U4T@ryzen>
 <20240418073023.GA4331@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418073023.GA4331@thinkpad>

On Thu, Apr 18, 2024 at 01:00:23PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 18, 2024 at 09:14:23AM +0200, Niklas Cassel wrote:
> > On Thu, Apr 18, 2024 at 12:23:08PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Apr 18, 2024 at 08:46:47AM +0200, Niklas Cassel wrote:
> > > > On Thu, Apr 18, 2024 at 11:13:19AM +0530, Manivannan Sadhasivam wrote:
> > > > > On Wed, Apr 17, 2024 at 07:49:45PM +0200, Niklas Cassel wrote:
> > > > > > On Wed, Apr 17, 2024 at 10:47:25PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > Instead of getting the epc_features from pci_epc_get_features() API, use
> > > > > > > the cached pci_epf_test::epc_features value to avoid the NULL check. Since
> > > > > > > the NULL check is already performed in pci_epf_test_bind(), having one more
> > > > > > > check in pci_epf_test_core_init() is redundant and it is not possible to
> > > > > > > hit the NULL pointer dereference. This also leads to the following smatch
> > > > > > > warning:
> > > > > > > 
> > > > > > > drivers/pci/endpoint/functions/pci-epf-test.c:784 pci_epf_test_core_init()
> > > > > > > error: we previously assumed 'epc_features' could be null (see line 747)
> > > > > > > 
> > > > > > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > > > > Closes: https://lore.kernel.org/linux-pci/024b5826-7180-4076-ae08-57d2584cca3f@moroto.mountain/
> > > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > 
> > > > > > I think you forgot:
> > > > > > Fixes: a01e7214bef9 ("PCI: endpoint: Remove "core_init_notifier" flag")
> > > > > > 
> > > > > 
> > > > > No, that's not the correct fixes tag I suppose. This redudant check is
> > > > > introduced by commit, 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer
> > > > > core initialization") and this commit removes the redundant check (fixing smatch
> > > > > warning is a side effect). So if the fixes tag needs to be added, then this
> > > > > commit should be referenced.
> > > > 
> > > > Well, you have a Closes: tag that links to a bug report about a smatch
> > > > warning that was introduced with 5e50ee27d4a5 ("PCI: pci-epf-test: Add
> > > > support to defer core initialization").
> > > > 
> > > > So if you want to reference another commit, then you should probably
> > > > drop the Closes: tag.
> > > > 
> > > 
> > > Then checkpatch will complain... But I think I can keep the two tags? One is for
> > > fixing the redudant check and another is for the smatch warning reported.
> > 
> > Yes, I think so too.
> > 
> > You can have Fixes: to the commit that introduced the redundant check,
> 
> That is 5e50ee27d4a5.

Yes :)


> 
> > since this was obviously not the correct thing to do, and then perhaps
> > just mention commit 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to
> > defer core initialization") somewhere in the commit log.
> 
> You mean a01e7214bef9 here?

Yes :)
(I copied the wrong SHA1 here...)


Kind regards,
Niklas

