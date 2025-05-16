Return-Path: <linux-pci+bounces-27836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8450AB96D7
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69693501C16
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65622A1D1;
	Fri, 16 May 2025 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZPXCOq5Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE6229B17;
	Fri, 16 May 2025 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381763; cv=none; b=dk6tcrKZOrE269HetXp2H80sbS8FPA/HKWO3z7DYsBTaJ0Whz4n0gL58uF3fD3JQ9MmBua3P48sZ9f5LlKcRe+JgBqMaJPiZryK8fdArcEgg4H4Fj5QtjlTqzecBFcJBYgp2mHfpEWPtX4w73PWKntbcyjkseyOSfxR8ltUAVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381763; c=relaxed/simple;
	bh=MqdaDGZxcvLlum+3L1xyXGwPkyyMshMqKiPVFcYpwIQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AfmHXyx+wQg0tpeJ03tBFUtZi/trS/zSK+jkQdt3SpYGRkF+rIN1QOgtMt3Yv3PoGGx8pGodmHK2T10EPrTVhcaUlIpsYZZYBZgl/3xmZcDwd8W28YdiLNF1s/BCg2eP4sBb1st6GUFhULVsIwP3iBWVsPxZhSgWA68uAbsy+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZPXCOq5Z; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZzK3D6LPMz9t6Z;
	Fri, 16 May 2025 09:49:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747381752; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqdaDGZxcvLlum+3L1xyXGwPkyyMshMqKiPVFcYpwIQ=;
	b=ZPXCOq5ZliHAIyDm5VtJ5XChTH1G2FaZKR95uFb6baCezY9Js61ouGpslPH0W3PqQJxfsd
	lFAMNIkT/lUBTedma0sDzqGENRMwBcRZnVfwccYAVz9wRc1BmcNVk2N99cBltvm0zGJQaw
	CLNNFrNyAXVdZ3KQuGr8UvP4Pzd6HIEIoKalSkG+8Vb1r3WjwyTO/1b4jtxLbb983WmZDM
	C2wkSetYb7rJdFBRkJ8BHgxjtw3ellW9WE9MB9vCp/nvlnKy9v9F9bbwrDiZJwhlK7V+7i
	ZKtG3B4kN3PeAZd3ZlFR8pPgyghPOuEjbMODmxYteNtcWan8UdM1npMxkQG/yQ==
Message-ID: <e44d880e842440d51c14f38df1d20176694e0d57.camel@mailbox.org>
Subject: Re: [PATCH 2/7] Docu: PCI: Update pcim_enable_device()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Stanner
	 <phasta@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, 
 Mark Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>,  Yang Yingliang
 <yangyingliang@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Fri, 16 May 2025 09:49:10 +0200
In-Reply-To: <aCXk2eDUJF2UbQ47@smile.fi.intel.com>
References: <20250515124604.184313-2-phasta@kernel.org>
	 <20250515124604.184313-4-phasta@kernel.org>
	 <aCXk2eDUJF2UbQ47@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 4p3oakt9z4ahr9mzbcc6q9t5ctqsyqds
X-MBO-RS-ID: ab476883432287d305d

On Thu, 2025-05-15 at 15:58 +0300, Andy Shevchenko wrote:
> On Thu, May 15, 2025 at 02:46:00PM +0200, Philipp Stanner wrote:
> > pcim_enable_device() is not related anymore to switching the mode
> > of
> > operation of any functions. It merely sets up a devres callback for
> > automatically disabling the PCI device on driver detach.
> >=20
> > Adjust the function's documentation.
>=20
> Is the "Docu" prefix in thew Subject aligned with the git history of
> this file?
>=20

Seems its "Documentation: ". Can fix.

P.

