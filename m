Return-Path: <linux-pci+bounces-17087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343E39D2D05
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1185EB2FF9A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67C1D1F71;
	Tue, 19 Nov 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCdnclNQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C931D1F44;
	Tue, 19 Nov 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038573; cv=none; b=hyJjPrJ9L19c+wFyjLUOlLMcRuwdc72LuMyMyVhxPAJ3oQrbu5iQ9l+ClLnq5xWqbhqosxdWRc3szXi0vqXZQcUchemUgdlYuQRERD13XWwL3+PNzJ69/AONTco0f5SOlbgdrQFsFVetB8ejkda+3eYIXJCo531xPLGJPpJaCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038573; c=relaxed/simple;
	bh=Zwb06hTnOtFrHP7uC9zV5bZQcN0CA4khs24iBIrl7+I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lfoxDPWpIJ0163fWX9a6XC44tC0mLjgGOkEAWovqj5oxbBhkdeiTXDH1hSRTHGlrDBgPQl0mB6olypHp/DJIftQEBy4mscLxeRgghvRLsBpED4mzddTLsvkT/0okbfFuuZLTBrHAIpXVa2jPdHejlTlEt+mdOvBLziWiuIWavkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCdnclNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4C4C4CECF;
	Tue, 19 Nov 2024 17:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732038573;
	bh=Zwb06hTnOtFrHP7uC9zV5bZQcN0CA4khs24iBIrl7+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JCdnclNQlZXxVToquWNgU1QlEZt47JOaYSV2UA2ypZ04fzpSqN5brOnWcWT69lKjE
	 lB8kUeTCoZi81CNNjdMfzbPMrAsfjP/aUNURVo7kCrRdWF053YIXoji9UiGIZZz+fO
	 Iv3/r/qbDC3jgZFZhzfDC+wdDG3ufIPlzh1FRGEjADIslzI/ecq8i+yL0vCKNIUOWT
	 B5NZSYuIRoEe0J+4OM9Aaq4zYf90IKVOauUUsiTQS6F1Q+BqRk+GIIHP4PPW4nvCD5
	 L65IW39bNU85JM/O1D7uR4iL+oSHrMbR+WMFNEkheFY2Mf7omE0LYD8hPaIDiUVgjb
	 Qt8Ik+W7FW3TA==
Date: Tue, 19 Nov 2024 11:49:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	"open list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR GENERIC OF HOSTS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] PCI: check bridge->bus in pci_host_common_remove
Message-ID: <20241119174931.GA2270058@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028084644.3778081-1-peng.fan@oss.nxp.com>

On Mon, Oct 28, 2024 at 04:46:43PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When PCI node was created using an overlay and the overlay is
> reverted/destroyed, the "linux,pci-domain" property no longer exists,
> so of_get_pci_domain_nr will return failure. Then
> of_pci_bus_release_domain_nr will actually use the dynamic IDA, even
> if the IDA was allocated in static IDA. So the flow is as below:
> A: of_changeset_revert
>     pci_host_common_remove
>      pci_bus_release_domain_nr
>        of_pci_bus_release_domain_nr
>          of_get_pci_domain_nr      # fails because overlay is gone
>          ida_free(&pci_domain_nr_dynamic_ida)
> 
> With driver calls pci_host_common_remove explicity, the flow becomes:
> B pci_host_common_remove
>    pci_bus_release_domain_nr
>     of_pci_bus_release_domain_nr
>      of_get_pci_domain_nr      # succeeds in this order
>       ida_free(&pci_domain_nr_static_ida)
> A of_changeset_revert
>    pci_host_common_remove
> 
> With updated flow, the pci_host_common_remove will be called twice,
> so need to check 'bridge->bus' to avoid accessing invalid pointer.

If/when you post a v2 of this, please:

  - Update the subject to say *why* this change is desirable.

  - Follow the capitalization convention (use "git log --oneline" to
    discover it).

  - Add "()" after function names in the text (no need in the call
    tree because that's obviously all functions).

  - Mention the user-visible problem this fixes, e.g., do you see an
    oops because of a NULL pointer dereference?

