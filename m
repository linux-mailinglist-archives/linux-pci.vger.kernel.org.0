Return-Path: <linux-pci+bounces-24423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5A6A6C60C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 23:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDAC4685F0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C522FF5E;
	Fri, 21 Mar 2025 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsS6qF5X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66A22AE5D
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742596952; cv=none; b=CptOHOtxLzZ+vmVVc0V2ZpIv7zNP/b6U292+iHHmnHIo+SpphdCpBBBo5AR7TcxOuIvFzi6qQWcHOuBRuqvNsIs+mHFoiq9mxRgUi29gh4OzPSO7xiFa3yeVTuBqSgbTSqsh0UuK6STuu9zvKelr1Y40+vuZyGCkaPJmPEhBi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742596952; c=relaxed/simple;
	bh=fzXeW+0VpOiDJqPviuoRYzKlHFpuvmV8mVg4V7PWy5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=umdYRH12JRfZs0zKmD/Qe8ZwQcQlBIAkZ61qwQlotSZGKdiAaMdyVbWtOfGyoFfOt8EPKtScCyIP4KWckmT61Fe+Uw9sw8EBNzyC+U3I9fLQ4m+nGo/IOQz/wfjX6DTM7BDpN2UPNSNxysp53ECK1xt08fIqZYeRvjLC4wsEv8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsS6qF5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ABDC4CEE3;
	Fri, 21 Mar 2025 22:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742596951;
	bh=fzXeW+0VpOiDJqPviuoRYzKlHFpuvmV8mVg4V7PWy5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tsS6qF5XxLO/Cy+yp9DdlWMF/CRqvGe1HfR8wB7BxmmyMfnPRtjwI8vPcsmSNcjRp
	 ZIvw7QTxDnrV6twSIVNmq/jTOaB/z03vaOt6o4U0mpvb6gDDVsWlUUJWmaezXUAcMl
	 8ApKwllfQLWkGwZtdsGEyDYDy3a/btSEyK8h5VcpsYAX68W/ejlWbn0mKAxNxlKzmy
	 gd6Q+wXAYOxH+Fr3D5y2x0eS1FFZP8/eNZ/fhERWmBzPX1//hdqFp843K3drDk9NoS
	 8LCYxh8spE51UEPKdf6DxXtGOHdDEN5DzfsAnCQ4nmk67f78mfC96nvRBpf6nc0sSf
	 XiwtPxbgsOFqg==
Date: Fri, 21 Mar 2025 17:42:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, manivannan.sadhasivam@linaro.org,
	linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 4/7] PCI: endpoint: Add intx_capable to epc_features
Message-ID: <20250321224230.GA1172324@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0B197218-4163-4344-8D99-0A90EA6B3CD0@kernel.org>

On Fri, Mar 21, 2025 at 10:55:22PM +0100, Niklas Cassel wrote:
> On 21 March 2025 22:50:34 CET, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >On Mon, Mar 10, 2025 at 12:10:21PM +0100, Niklas Cassel wrote:
> >> In struct pci_epc_features, an EPC driver can already specify if they
> >> support MSI (by setting msi_capable) and MSI-X (by setting msix_capable).
> >> 
> >> Thus, for consistency, allow an EPC driver to specify if it supports
> >> INTx interrupts as well (by setting intx_capable).
> >> 
> >> Since this struct is zero initialized, EPC drivers that want to claim
> >> INTx support will need to set intx_capable to true.

> >> @@ -232,6 +232,7 @@ struct pci_epc_features {
> >>  	unsigned int	linkup_notifier : 1;
> >>  	unsigned int	msi_capable : 1;
> >>  	unsigned int	msix_capable : 1;
> >> +	unsigned int	intx_capable : 1;
> >
> >Kernel-doc warning:
> >
> >  $ find include -name \*pci\* | xargs scripts/kernel-doc -none
> >  include/linux/pci-epc.h:239: warning: Function parameter or struct member 'intx_capable' not described in 'pci_epc_features'
> 
> I will send a fix.

Thanks will watch for it.

> >I'm actually not sure why we merged this, since there's nothing in the
> >tree that sets intx_capable to anything other than false.  Maybe
> >there's something coming?
> 
> See
> https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint-test&id=5ce641b3ddb8aec9be4bea72e0cd97d2c0ff54a4

Yeah, I saw that, but there's no actual benefit since there's no
driver that sets "intx_capable = true".

