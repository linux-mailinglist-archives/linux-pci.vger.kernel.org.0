Return-Path: <linux-pci+bounces-28035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E0ABCAB7
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 00:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C698C0FF3
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 22:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490B21C176;
	Mon, 19 May 2025 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prGrfoK6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1321ADBA;
	Mon, 19 May 2025 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747692479; cv=none; b=m1XSE3lOWcJA0cuJCK0h6JL9fEoY9eE1Km+JHO5zJ50AcBue9Q4sWtnYzHBRYozuz4FoNRQpcPg01hQYvTPXIIKj8KpJyKkC8msyPewnb+9QFU8QgNonG8G4FZkCIYn6TySzKqbMuDvkhbs5h2ZX7NvLTuTCJDCpqU5xYzix/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747692479; c=relaxed/simple;
	bh=WHmlIJg+vI/V593rkUaVPulP6IYmAqtrqjZ3QQaV38Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qgUKeP6R80iqDyUjR2bbCQDdun9xslu7AMJLPfCK6fSq6xLf/LTdM4ZfC2xGfSh/3IlAH+rlib+XiAdAO1qQ5iGHiXCUGG0llfleg6DrLGBDhwXIi5QweEjb+c6HY1cwezE+O92uBV7NA9sKYOKSpewvOREEFvG4Jb7S2OtxBek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prGrfoK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D43CC4CEE4;
	Mon, 19 May 2025 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747692478;
	bh=WHmlIJg+vI/V593rkUaVPulP6IYmAqtrqjZ3QQaV38Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=prGrfoK6OemAyxIYbcixnhd3mdsWSjGank7zpQI0lBQIm1oOp/4Oh0Asc1q8+KodG
	 axj7XXIDHrrGB0OLdXwUZyxwg/PweQywOvAo+UXi1N6qNQmpxvyvttyHaAyRdJGiNH
	 WRCFqvc1G4yJj81376ZP12cqBf7G9GdKT0/1QkGw39eUMjItEj3HmRusmnhRjiSapF
	 mf7pwmy9/wLo7xOvUtqgyJsuA5q/R0hcXoczax01NoUTaqqVGrJpD0eR+t489oTh8E
	 Mq3UkDW1cbPxHcqeiSLnFpecYhjF62873j8YJgW3NY+SAwZvOz7RTJ+ruBAfak3PDK
	 t98zkSCtMItbw==
Date: Mon, 19 May 2025 17:07:56 -0500
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
Subject: Re: [PATCH v3 6/6] PCI: Remove hybrid-devres hazzard warnings from
 doc
Message-ID: <20250519220756.GA1259384@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519112959.25487-8-phasta@kernel.org>

s/hazzard/hazard/ (in subject)

On Mon, May 19, 2025 at 01:30:00PM +0200, Philipp Stanner wrote:
> pci/iomap.c still contains warnings about those functions not behaving
> in a managed manner if pcim_enable_device() was called. Since all hybrid
> behavior that users could know about has been removed by now, those
> explicit warnings are no longer necessary.
> 
> Remove the hybrid-devres warnings from the docstrings.

