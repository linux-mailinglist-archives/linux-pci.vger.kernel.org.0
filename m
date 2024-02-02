Return-Path: <linux-pci+bounces-3054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA04847D21
	for <lists+linux-pci@lfdr.de>; Sat,  3 Feb 2024 00:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7D91C23FDB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 23:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E1126F33;
	Fri,  2 Feb 2024 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpaDqooq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC1126F29;
	Fri,  2 Feb 2024 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706916277; cv=none; b=lyy/eF66XWAq1gOj2vC3Fp1tI/C6Vm/JlbfM8PvDNdCX7F1zxgf6IvpRcpis1kA74/X9Z0S1LMq2f8uCH4xGi2ImJZeWc2HJ9YMf6sfEy5xoEr5VNlQYvJHk7vs9eQoy0pwRyI/7nAM6aJYV68pd/9y19mzt2g1aRDKCF9wPT4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706916277; c=relaxed/simple;
	bh=dacEwO/pC1bF+47WPZh/13JT4EIYagYs0r0c7uCimBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=msyYLQHLl1NYkQnumqkDX42d3QzpzqQ+lH1qP7dJ+P9MV4nxbfx6w0ga4MpQW6lJWUF6xYsUQvGVzFrEq0MTx54k8C/HLuA1GOlUcktc403sx5eGkqLpkmyMwbifR52M3PfUNTYvcLYaHXw/Y1vi1x25HKIjc/feyYYbU7oP21A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpaDqooq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134BAC433C7;
	Fri,  2 Feb 2024 23:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706916277;
	bh=dacEwO/pC1bF+47WPZh/13JT4EIYagYs0r0c7uCimBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GpaDqooqYj1GXyPOeoNY2DG1KCCYU56ORLMldCC/qjVS3wQC6XnW+rizghHBmai3b
	 DgnLxuiaIfU/2y5ZYv9wDaUrrjFGWsGtEsxf7ppHnmTclf3lgMN1HEf8LcbKZQJGY9
	 2wekSUI3+k07oW6UB9kMU7Wh1i5ZGJi4amTZBEKIObHhRAl1uzj3I9lAPb10/IhtMJ
	 MzIfjAmo9EJN+84rEy0BAyq2BkoOPH3aul2Gt2WSYW7u0xdeJBfFLTxFFLv/qPN7ND
	 M9EjjXAuQlZ/qpJvm+OtOmla8XDr5dttsjQUemKMdETyfqA3tQR86+/AcTZAgXMoSY
	 Tov8oVgzl/B0A==
Date: Fri, 2 Feb 2024 17:24:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI/AER: Fix rootport attribute paths in ABI docs
Message-ID: <20240202232435.GA738414@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202131635.11405-1-johan+linaro@kernel.org>

On Fri, Feb 02, 2024 at 02:16:33PM +0100, Johan Hovold wrote:
> Some AER attribute paths were changed in the final revision of the
> series adding them but the ABI documentation was never updated to match.
> 
> Included is also a related white space cleanup after a commit fixing the
> 'KernelVersion' field name.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   PCI/AER: Fix rootport attribute paths in ABI docs
>   PCI/AER: Clean up version indentation in ABI docs
> 
>  .../testing/sysfs-bus-pci-devices-aer_stats    | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Applied to pci/aer for v6.9, thanks!

