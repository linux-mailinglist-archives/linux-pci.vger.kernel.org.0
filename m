Return-Path: <linux-pci+bounces-28036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D350ABCABB
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 00:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5D37A46EE
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 22:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C4D14F9FB;
	Mon, 19 May 2025 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxppZeg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687C21B9E7;
	Mon, 19 May 2025 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747692709; cv=none; b=gkziFAfZT9G4yI3RSNpNelQ4L1zO6hZv/uD4494n33RcfsUK2f+DzeMnJsOWb6h0seiujFo01+fbGKN93iOIAXaPuvkshX2CbxYWyezQL3eqciO6O9MxaKwGrStuWBz2ZxWnhiBinx4R7cYcNNBwfI+0xHndiPNMHkbH2m/D6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747692709; c=relaxed/simple;
	bh=i+LF4xGFTaA5fgdjsQHgYQhWUchRfQ27AxjB+kEnSZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XMWb03qJlcQr25YJMnRf55vBBFF5YVRejFW0nb4PrbP4xn+OBGEUalQCYbG0Z1EWGidEup9OsIJuY/Yc5hdLzHfM0maMkybqQStQHBbLLHrRJjgs6KSUgnIcVPO7003+mrRUBxAMMpk0uHT01kcp928hfp5Ih2+gCLSlB3unTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxppZeg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E350FC4CEE4;
	Mon, 19 May 2025 22:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747692709;
	bh=i+LF4xGFTaA5fgdjsQHgYQhWUchRfQ27AxjB+kEnSZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CxppZeg5dQZTDJJ3TUc88BW3vVYAOOpVlfib25M4ZO/dj+HZ6bl9DJCt+2Rn0VgGy
	 YiqRS2/N99sqGmcbVsYpQisLc0QgeNRuqVlgfuiKqJW7LS4fgLzmqyQdmepM6zj24W
	 7GAQhclrehe5hTGEQrQJxYUziwoQfjmazCqnroE+mQxjJptxeZGWBPn6YxvAisK5hP
	 Sm76dcuBOYVnSXwC3I11Q/Cspug8nzqcNZpSoNTA8NhXWfY4VpMhJiVwIXPNF2luCQ
	 qdHrcigHEVgxb8SYpV9/QT7qVvUkbxiUSs1U1ztFkuZN+2hsJg6bBZNf6Y/OXC4LyL
	 DqPvvyyy0PVSA==
Date: Mon, 19 May 2025 17:11:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: Remove request_flags relict from devres
Message-ID: <20250519221147.GA1259487@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519112959.25487-6-phasta@kernel.org>

s/relict/relic/ ? (in subject)

Would be nice to have a hint in the subject that this is related to
exclusive region requests, since "request_flags" doesn't include much
context.

On Mon, May 19, 2025 at 01:29:58PM +0200, Philipp Stanner wrote:
> pcim_request_region_exclusive(), the only user in PCI devres that needed
> exclusive region requests, has been removed.
> 
> All features related to exclusive requests can, therefore, be removed,
> too. Remove them.

