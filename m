Return-Path: <linux-pci+bounces-24029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AEDA67023
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3B3170FC5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662201E1E13;
	Tue, 18 Mar 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rABMo/Lm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7531422AB
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291123; cv=none; b=gMoLTOi3JTka4vkjsO2GxHG9KruCTvwMMvkmHBqCgFq8c++HR1yhojYRFU9wLrmv+QhfIAfAOSStqmGzRgFCD/lyIKtkQ+CYRcl0c3SHq3AiTkqgJtIFNBY7BxaVy6lBw3g+LwLDbcG9GHSuZMEcKBGN2KK3wmaIE+vM+06fss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291123; c=relaxed/simple;
	bh=1fw8U8SZ/DqBFc4GVCClJD4OaUI7V4yrp8Jqe7ixCHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0h1lZPVH1bGkfKW1gg3Zbr89b27rYmYenA0j4jY3wueftBWidkPVk//zaLWudRUkH6aL/1A6pcyU5Thx+DgJ1ehgA/ey24TPIvEJQ2mMpbO5gUfK9FQtra/X0bQkI/z8E6VydAwGO9Q6BV1tU1tkw4rXdsZ4oYaG6PDUqZeyUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rABMo/Lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE30C4CEE9;
	Tue, 18 Mar 2025 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742291122;
	bh=1fw8U8SZ/DqBFc4GVCClJD4OaUI7V4yrp8Jqe7ixCHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rABMo/LmC/OrTHFd33YA7Kt7pbqJLE64mTgvguLfaOqAvRb2IsdGcmtMuRHXiVu8Q
	 2kEoDudo/rnSXfT5wUg92Rx4QwFaIjB791rQzHsFcSUeE0C9Zmg6cnjfbDMU9Zml/q
	 yK+uGiKAqKd9dUD1rFI+1qsEGOAMIjY3SMDOBORgBPw9JyQff/mDctq9VI7Nc+U6k+
	 YlTgflOGEsluTYev2lNKlwKhQK3tbHZhmsZ9TbM8nNdm68BjOrxiaOVManTuufGtjx
	 af/Sk7YWhQ2hX0SIw2kMGCJ6o8oC58pKF+K8LdMB0TccW5iVuqfWi9rlzl6cmsyKbo
	 n7KpZVFeWsKmw==
Date: Tue, 18 Mar 2025 10:45:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 7/7] misc: pci_endpoint_test: Add support for
 PCITEST_IRQ_TYPE_AUTO
Message-ID: <Z9lArl5AUA7vbKVA@ryzen>
References: <20250310111016.859445-9-cassel@kernel.org>
 <20250310111016.859445-16-cassel@kernel.org>
 <20250314124548.inffbk3c4kw22rwb@thinkpad>
 <Z9Rmoh_vtrXzFG0X@ryzen>
 <20250318085656.q4aohbdvidhzn6af@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318085656.q4aohbdvidhzn6af@thinkpad>

On Tue, Mar 18, 2025 at 02:26:56PM +0530, Manivannan Sadhasivam wrote:
> > 
> > I guess one option would be to remove the
> > "pci_ep_ioctl(PCITEST_SET_IRQTYPE, 1);" calls from the test cases that you
> > added, and then let the test cases themselves set the proper irq_type in
> > the BAR register. But, wouldn't that be an API change? READ/WRITE/COPY
> > test ioctls have always respected the (a successful) PCITEST_SET_IRQTYPE,
> > now all of a sudden, they shouldn't?
> > 
> 
> This makes no difference IMO. The previous behavior which you explained above,
> ignored the result of 'pcitest -i 1'. And it was not user configurable. I think
> the original intention was to use MSI for tests if available, else use whatever
> the platform supports.
> 
> If you want to restore the original behavior, you should remove the ASSERT_EQ()
> from READ/WRITE/COPY tests first. Then to ensure that the tests make use of the
> supported IRQ type, you can have the logic in the READ/WRITE/COPY tests itself.
> If test->irq_type != PCITEST_IRQ_TYPE_UNDEFINED, then just use whatever the
> test->irq_type is. Otherwise, use whatever the platform supports.

I can submit a patch series that modifies PCITEST_{READ,WRITE,COPY} to always
figure out the IRQ type to use by themselves.

But you can't have the cake and eat it too.

Either PCITEST_{READ,WRITE,COPY} always ignores PCITEST_SET_IRQTYPE or
they don't always ignore PCITEST_SET_IRQTYPE.

Only ignoring it "if test->irq_type != PCITEST_IRQ_TYPE_UNDEFINED"
makes no sense IMO.


Kind regards,
Niklas

