Return-Path: <linux-pci+bounces-15229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B319AEF1D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47792282002
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DEE1FBF50;
	Thu, 24 Oct 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi4qEvv2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDEC1F666B
	for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792916; cv=none; b=TtNZ8WsSLIElEqa55rj1Jtr2BGGm9j3e3fW4lKKk0opAbuuKvGruMY5gx2+Jcl0ByQu8wcJZwL9pY9XdbJ0CokYLa0T8x9Lnv971tvSuM82fSRJ+FEY/J8Jox+oV6lIHsQZ1fIeXrlxC/leimvx5Xh8XcTC8fhZpXKoR74Eh7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792916; c=relaxed/simple;
	bh=65K4O56rVHThA5ysojnEJMgb3ZoD2iESEOa/k2ZO2Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hompmO20d2nk3Q0FYiC2rgW0sKBoQ4EsELFceSPIIitbb+lqvRHBVLfStDu3cF1a/gmkkQHpO2+J3438u73DekgjmIX/V6Nqfc/bS2OzNPvnZCq9H98JTeXAGCJNs94St3z7JqmjOKcHl8P0rZtM1/xwUS5ew0lPoEx5dizFBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi4qEvv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20400C4CEC7;
	Thu, 24 Oct 2024 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729792916;
	bh=65K4O56rVHThA5ysojnEJMgb3ZoD2iESEOa/k2ZO2Ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hi4qEvv2e7AIR4rf2U6sIfySU+vUxJDOiGarKWTZtrG3qGBTHRfDslWUo2R9QDdov
	 u6t7PbDVc/WNuwvo41Fv/2rDDRvZAhmdQc4tqZVvSTRngjJ4nFqgYr/A7uNORzBznk
	 AOREP14kh/uM1DGz7ana6FC1EcHyqkyhMAeBF0LWmrRFAgxGRAgTBVGv7PUMIbEq2Z
	 X3Sm0eFad4Bcavp9UL+IxdUaR/zmAGK8SQfQZnEE/bIR+Jc57/QUK+SNjiZFbhhTRN
	 dv6O4NI1uDhTE367NAawqhdSQzkdgNUun1Wn0INemXseDmU1bb7hYOxidlEgZqHRWO
	 HM5l2Oo5VbpLw==
Date: Thu, 24 Oct 2024 13:01:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
Message-ID: <20241024180154.GA965482@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8eec04-c73c-410d-a844-716a68c6dac2@deltatee.com>

On Thu, Oct 24, 2024 at 10:21:17AM -0600, Logan Gunthorpe wrote:
> On 2024-10-23 23:50, Kasireddy, Vivek wrote:
> >> I'd echo many of Bjorn's concerns. In addition, I think the name of the
> >> pci_devs_are_p2pdma_compatible() isn't quite right. Specifically this is
> >> dealing with PCI functions within a single device that are known to
> >> allow P2P traffic. So I think the name should probably reflect that.
> >
> > Would pci_devfns_support_p2pdma() be a more appropriate name?
> 
> That sounds better to me, thanks.

This sounds similar to what's done in pci_dev_specific_acs_enabled().
Could this problem be solved by adding more device-specific quirks
there?

Bjorn

