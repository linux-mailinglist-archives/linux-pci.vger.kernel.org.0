Return-Path: <linux-pci+bounces-44090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 665B3CF78E8
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 10:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAE78311B337
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DD02D94B5;
	Tue,  6 Jan 2026 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isLOMPDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB282D0C79;
	Tue,  6 Jan 2026 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691846; cv=none; b=oIbSUgFZf1Gkv5sR2dRZbGPrQMCD1uZmtjcg7wyA3YH1aEmMCh3zEdtJwgzCcGMM3U2Dd4NZusI2qE0Wk6Ib9xyD5t/3VEZa34e2xDP7Vc7Vw3DdFiRsCfZyPyc08bqAlpw0DYupmbc79s5w/2XUxtvOu6t10Smt9sRyuvR1zf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691846; c=relaxed/simple;
	bh=Q/sXaIxQezX6aDvPY1t5vzmz2Ro0UNgsBgZo+wocFzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNYuAq1rezJzyhTn8QVMBBsukKoemK19ZiPX3V1PdKTVv+e9tu8ak+JTHUPMiX45dogjCuoYi4WcEp4XM+O+AIKfxlcqWYFClEzaUpqCpw0nPkyOyAe4hDmzPqZqUWQKtKDGjVVgcYBke3rMuftuw+NlZig99urWQkb/ejt4C0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isLOMPDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779F1C116C6;
	Tue,  6 Jan 2026 09:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767691845;
	bh=Q/sXaIxQezX6aDvPY1t5vzmz2Ro0UNgsBgZo+wocFzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isLOMPDWnHNTiI7M5quGfxee9AfWbuFUbchF6dwJmwKhHMBqScMt2ubo3YgmCl3Sy
	 ptxF+/ze2kbKoJS/njy0ponYa6igMZYNNKp9vBaW75oOWEYuM1VWhakfP77FUUTIs3
	 kRYVRsTyVu53mlj4uXxZsX6p2DQ8kKgmOScBEVmxcF14rB9c8Qoz+p6ykpjd6H+e7N
	 VLhVMYBGRJM6zwNNHGbef39UiyWrAlfoKIYCCKMhmAl5r7VcpkHJQx0+ppJgf2f7pN
	 aI/yLYTpq5iCS+G5fTTWVUa3gz+Wq2GWQCFYag30jhkPeHKNt7G2CSPST9YK5OhKyw
	 ZBcWv6IDperSA==
Date: Tue, 6 Jan 2026 10:30:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: endpoint: BAR subrange mapping support
Message-ID: <aVzWQIOgdtyjom3Y@fedora>
References: <20260105080214.1254325-1-den@valinux.co.jp>
 <aVvtAkEcg6Qg7K3C@ryzen>
 <gb3mr7onokhufasxaeoxiqft22incwxxlf43m6jcrhrem3477j@63oi3ztvbqku>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gb3mr7onokhufasxaeoxiqft22incwxxlf43m6jcrhrem3477j@63oi3ztvbqku>

On Tue, Jan 06, 2026 at 10:52:54AM +0900, Koichiro Den wrote:
> On Mon, Jan 05, 2026 at 05:55:30PM +0100, Niklas Cassel wrote:
> > 
> > You should also verify that the sum of all the sizes in the pci_epf_bar_submap
> > array adds up to exactly pci_epf_bar->size.
> 
> I didn't think this was a requirement. I experimented with it just now, and
> seems to me that no harm is caused even if the sum of the submap sizes is
> less than the BAR size. Could you point me to any description of this
> requirement in the databook if available?

3.10.7 Inbound Features
"Without address translation, your application address is passed from the
TLPs directly through the application interface."


Thus, when there is not an explicit translation, the DWC controller passes
through a transaction untranslated.

Sure, if there is no physical memory or IO registers at the physical address
corresponding to the PCI address trying to be accessed, no harm done.

But because of the potential security implications, I think it is good to
ensure that the whole PCI address range of the BAR has a physical mapping.


Kind regards,
Niklas

