Return-Path: <linux-pci+bounces-34498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E8B30A04
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 02:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A988B1D05668
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 00:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE76639;
	Fri, 22 Aug 2025 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FufC/fWb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C111373;
	Fri, 22 Aug 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821048; cv=none; b=eQnCWsaH69F7G3OexIYG14jTJlc9s6oWUqVGcE7zD9sTG95wMx8OjKeGIGNkUXWXfZ9/7t4WO3rpycugo9/xrtJRk4TV5DG0knGVcUp+R2Q1G22mfWnR/zIbk2VR67tX2AYb6Cr5SIQJAkmrZq/XlSq861Th9vDvo9nv9qMtNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821048; c=relaxed/simple;
	bh=pJDxfmEvrLatKoQIO1F3BeLhAEfZPFG31TFiqZtyEoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNfhBpM5keLYk+H3jGXKrDNbCbRb1lGjYOOvMsFmePiBKLYG7bdwYy79+w4iJSEK1+UxYN9Cb6pl9m3wwAs0xDArXqny3xLglvZGHU3a2pz9MGTvfv87cUnqtdVbIBY3MoIHircrJBV/9ZOdfeJMyqBHNjN3f9zYOktmDK/rwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FufC/fWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099D5C4CEEB;
	Fri, 22 Aug 2025 00:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755821048;
	bh=pJDxfmEvrLatKoQIO1F3BeLhAEfZPFG31TFiqZtyEoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FufC/fWbECysfkMHBIODlkl6zs9gaUYBuyVSbL7EyHcmj1Mp9OzaEh91CeaxbV2ai
	 CUdGM4O1k+BK6Xj2sCEI8m9z1Ysr8FsDJl6iAzUSgBTJX+/YZ28rQeRtnIcemwRsPE
	 TWHLYmQIWptfoUHjkN+WnBHFp+9hY8Odcd01/gXffiUYhFG0eYkQL/+4qvJUxvEIEw
	 VlRYqGIg8Rhg9+ISVB+oJhgOJXw6pugK3NHzpAEEN7m2kNl5QcuG+/45+aFGiLTHP+
	 PYqgb+EXI0ISxD2K7MdfWRYSpW5LJJaINUoI/6bXdXJITbRlqmkCL7dhJSzck5/nFv
	 B5XFiixkGFeHA==
Date: Thu, 21 Aug 2025 18:04:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <aKez9gckldMhmhzS@kbusch-mbp>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
 <20250821232239.599523-2-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821232239.599523-2-thepacketgeek@gmail.com>

On Thu, Aug 21, 2025 at 04:22:38PM -0700, Matthew Wood wrote:
> Add a single sysfs read-only interface for reading PCIe device serial
> numbers from userspace in a programmatic way. This device attribute
> uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> capability output. If a device doesn't support the serial number
> capability, the serial_number sysfs attribute will not be visible.

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

