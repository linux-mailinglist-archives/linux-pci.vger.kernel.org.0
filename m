Return-Path: <linux-pci+bounces-31617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90EAAFB379
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 14:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288E4179609
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6F928C851;
	Mon,  7 Jul 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW/7AhIX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C982620E7;
	Mon,  7 Jul 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751892260; cv=none; b=iIkCh8E1YNs6yY6izbjz8GsLJ9bH1Y+Zu703pgX+jHPePrcLgqttlCtzl6o/S9d7Hmev9TW/L97EPHPRKvHwVJmOxD92aUJHoMMZiQBVVwX03NbjgMYueQrTwodcJkTQ3GpxNxuk90bPQbj2jkia3hf6qyV7REqfJ764BNREx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751892260; c=relaxed/simple;
	bh=0sUtDu+36rbDvWXIH0/41c5wb6QGzwOMtd+t6wwNdFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gem1GbzGtGryIEVlqCYuZNVYtYNHMGfGt+qUk17tmpSYYCf31NM0iij3+uDamvy2sZsuo9F6raN8S1LsNgA+Xk8feJcq/71aBEQ0YYyLyyob7TTgagWuHW+CHT5Qbgs4hRCj78V+uFclnLwGKTLnYPK7bJHKos9G9aC+YTnL8GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW/7AhIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E632BC4CEE3;
	Mon,  7 Jul 2025 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751892258;
	bh=0sUtDu+36rbDvWXIH0/41c5wb6QGzwOMtd+t6wwNdFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BW/7AhIX9oWdf3zD18AlP4owBIOHt7fJEyhAHKbB4kPIMTksZPB37Qfe2rYLyv5Ng
	 JHqMFx1tGEVRp3TrpQITcYOAb20SD0C7Dd005nglG0s3ksKJ0v57pcv8nmz8ym7CVK
	 Lu7Lxu1M7yM4KITlHh5XkqUnrN+Pr5ANAAy01i6WX5C4Lwm81lTbFZjM3YZRvYS+M/
	 kO+78MXLcvb+TLWzv1PRshHQbb+EmgVzZ53uoBJWi/8c+9SJWxfzqCG3+ws/HOgog7
	 LUk/SZQYFXGgzYODbwNxGL7wU/O+RJaerBWVGBT362AvsgIA42UiM6qyQz3a1h3sLZ
	 FWh73W4Mafncg==
Date: Mon, 7 Jul 2025 14:44:14 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	alex.gaynor@gmail.com, bhelgaas@google.com, kwilczynski@kernel.org,
	ojeda@kernel.org, wt@penguintechs.org
Subject: Re: [PATCH v2] rust: pci: fix documentation related to Device
 instances
Message-ID: <aGvBHtL5Kix6lCkv@pollux>
References: <20250706035944.18442-3-sergeantsagara@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706035944.18442-3-sergeantsagara@protonmail.com>

On Sun, Jul 06, 2025 at 04:00:32AM +0000, Rahul Rameshbabu wrote:
> Device instances in the pci crate represent a valid struct pci_dev, not a
> struct device.
> 
> Fixes: 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

Applied to driver-core-testing, thanks!

