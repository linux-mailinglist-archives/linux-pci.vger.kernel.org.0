Return-Path: <linux-pci+bounces-41462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D46C66684
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 23:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 36B0D296C3
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF49320CCD;
	Mon, 17 Nov 2025 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwOKcyjJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA62303C94;
	Mon, 17 Nov 2025 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417249; cv=none; b=sTAqX2GxGvBZix89yj26OemJrXPv8VdNI7x6GcaPmgS9+wEfQECoFwBwsRLusCeAck98v0wH9LFByXhT4Wgz1Xw6W3dvoTt7zFNFrlRQYqbYFKNfATgRS6GVTx1v6A4QqnF7awmPvqu+VGL2PV6RTZJWPcnA0lpexwiPxFQScqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417249; c=relaxed/simple;
	bh=G5kP84evxJ/rHjY7X0g6Ked+OOEAmAcqeB7BBk32zYA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fuOS+m9PoEh0R86BFJPbQZHYhkPf+Bf/RbFuoCBFSm6gXXzIU89JPSZZhwl9TMAIhWiCJWFu3mXhq8zivwAr0L9XMGlLnN01NL+tXICBcFYxyaXUcxg5DyAP2ZEAZ8KcD4Fmmii9h4bUoJV06GDsGiGKN7OF11T7VqS7E0V8WkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwOKcyjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F50C4CEF1;
	Mon, 17 Nov 2025 22:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763417248;
	bh=G5kP84evxJ/rHjY7X0g6Ked+OOEAmAcqeB7BBk32zYA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=OwOKcyjJTcxujuWF3/3Yx56EEAvpX/ZDrNYDGO7+UGqC+Mzt2dmylhXEQTFlYIDB6
	 lbqsWJy73Aj8X+tyyvgvtUXRNDXBXNrgjv3cDGOXwKgBoAsSaCm5uHs3PJ2d30/EK+
	 CVV7bWIwqjad3N54Mo8kjf0af2PkVwvE/nRZr+AndBt9E4haJBxRCA4TdqnhJAV+Ky
	 ErS12PsZ07UmkZv52gbA82b0XcCD4wFsWfhAEVOO+rBceQ4rp3Tzya+CLkVH/dOLtc
	 AzJ/UrFoidjR3pT0v29NiufNrhUxm7Y+XrmSgwPj0pzddbRSfTj4iOXHbsfj0wE0lE
	 tw2I5mroKaLTg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Nov 2025 11:07:18 +1300
Message-Id: <DEBB8NVXCG2G.26NWTAPEE8N1X@kernel.org>
Subject: Re: [PATCH v6 RESEND 6/7] rust: pci: add config space read/write
 support
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251110204119.18351-1-zhiw@nvidia.com>
 <20251110204119.18351-7-zhiw@nvidia.com>
 <20251114002005.GA2384907@joelbox2>
In-Reply-To: <20251114002005.GA2384907@joelbox2>

On Fri Nov 14, 2025 at 1:20 PM NZDT, Joel Fernandes wrote:
> Also we should have a comment on why its safe for _ret to be ignored.
> Basically what guarantees that the call is really infallible? Anything we=
 can
> do to ensure errors are not silently ignored? Let me know if I missed
> something.

Please also see [1].

[1] https://lore.kernel.org/all/DE8PBRC48D14.IX6FUPOLLVHR@kernel.org/

