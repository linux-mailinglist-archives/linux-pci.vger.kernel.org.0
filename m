Return-Path: <linux-pci+bounces-31564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DF6AF9FC9
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 13:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2567AA2B7
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jul 2025 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A9231855;
	Sat,  5 Jul 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSdebeHg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731C6192580;
	Sat,  5 Jul 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751714063; cv=none; b=IvcoizEsHx4veUPz3qHFGZavJJH8WKWpX/cQ0jNy9GAJT9G/vdnTrM/NuTCJP3H1y1X3rOfUdw2XI8IparkDu0m1FuPTPntSVRY5oP3YFIODzUidW+Ur3OAOJC0+e22vrDL9Zdzn9CAHkwQCwfegwCtQcXpahoTQLs+M5uwGVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751714063; c=relaxed/simple;
	bh=9V86eIY0F45syblBKf/TB25qAl9HuvfmbHU0szc8BBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRaWhujpVqLrDgEqBNhQgwB+ZgULNV3FacvP3tCygAXetpPVA1Tw8MhEx1DrEwfgMVIKaxrpWOVXB2B4+H11Ng/jzD89whvPmZ8fupJ92TD6uR9n3TG80K58W+4e3u3GTKkH3I4un8ItlHV4+Ym/hPTCh6ir47FvunuvDeuDoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSdebeHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7D5C4CEE7;
	Sat,  5 Jul 2025 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751714062;
	bh=9V86eIY0F45syblBKf/TB25qAl9HuvfmbHU0szc8BBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSdebeHgpLzc5ot8OcShTcbvBd8KVyQPGv9UYffMkXBN8QpxCxs2tQsjrWmYVn564
	 EVYyy+0lcLTKZI5Fbq5A2qD3cfdor16Fp4pR6bq3EBreJTjLOQNmCb+s0pakP74pgF
	 fLxhcU7V7WgaYKgFHnv5WXwPEY7Ep3EdrtHyTFnTDTc1H1vYHeI7mRj7ZMvfu5fByu
	 Tp02iXbEf6cmTmUvrAb+ozpiJTU6fqQE+ycGkx7CZPa/gpIjsd67bInFHN9LPj8oXJ
	 YXZ2KFC914XkLHKqRaN6zDL9Xmp/V4M9NoG+x2pUbk6wjufH7HUBFgJsUx41fFPwvj
	 iXSSEtnWtbd3Q==
Date: Sat, 5 Jul 2025 13:14:18 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Subject: Re: [PATCH] rust: pci: fix documentation related to Device instances
Message-ID: <aGkJCix2VPaawyP-@pollux>
References: <20250629055729.94204-2-sergeantsagara@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629055729.94204-2-sergeantsagara@protonmail.com>

On Sun, Jun 29, 2025 at 05:57:56AM +0000, Rahul Rameshbabu wrote:
> Device instances in the pci crate represent a valid struct pci_dev, not a struct
> device.
> 
> Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>

This commit has two checkpatch warnings, can you please fix them, add a 'Fixes:'
tag and send a v2?

