Return-Path: <linux-pci+bounces-29368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B0FAD442A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 22:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425BC1883881
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA3266565;
	Tue, 10 Jun 2025 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHE3y/4z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1623909F;
	Tue, 10 Jun 2025 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749588820; cv=none; b=MRzXcxTZn2flZHDm5wgyECf5+mVafu8nE9njhuj3JOo3ee6v4RHHDVh2m+z6mSzJaqXaU0pjfcnR3K/5aJV7hpssDPOqW3GDZ/gXEsjHQTWY0GaDXv4A0xa1FKU7/Hm1rSprowkVrbk5y/KCftg+d8WvHkNCRe//eY7xzAx0LFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749588820; c=relaxed/simple;
	bh=RKWuGDfX4E3Q3uUyJMJocYT3YIwBdIukNjPvCwWxg24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkCvR7doVEeS5sA6xXKagm1nkXbHKrMX8W50B8zu58qC23B1rSbfQbF+QtSpIf0rY18JwWQgjmNzLelWQvvHMG0jxXt0ZFgbuRCAV1HhIhZbMnMRSX7C8nzLfoLAlF/WuIFQXulYxvIZs0oKzGDo8gwDGJO+iBjXoloiKKXq3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHE3y/4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75952C4CEED;
	Tue, 10 Jun 2025 20:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749588819;
	bh=RKWuGDfX4E3Q3uUyJMJocYT3YIwBdIukNjPvCwWxg24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FHE3y/4znjCbBfGdstu3qEWxhQNEf2Kra+hsB1NXAd4Rd12qslFmfoT5AgqD8X/D/
	 dcZw5Oc98aIxqDn1Ha5UAnM2Pd4CYlcaUg1wDzO7bVz6XvnXK1BOQdumRVsE7Ifkc3
	 0l4wcMpcNY1NSP9Hj2BGupN81h3zSza2AOff/wYRLx9dxTJkaXqILlQ9iaCd396Bfr
	 2OemZfes1kU2PFDnILgYGr2RdPirwtPCh8ve6QVCwybCZCULcCMi3VrZ+Mllsjaj1x
	 sm8Tq9v+fCzf0cZujy5J0TcPgOBF50xn8HA3T3kuW73GHwOLzQBMyjp9YmOdB482fU
	 /FVpPnU52t80Q==
Date: Tue, 10 Jun 2025 13:53:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cxgb3: Replace PCI related literals with defines &
 correct variable
Message-ID: <20250610135338.580aa25b@kernel.org>
In-Reply-To: <20250610103205.6750-1-ilpo.jarvinen@linux.intel.com>
References: <20250610103205.6750-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jun 2025 13:32:03 +0300 Ilpo J=C3=A4rvinen wrote:
> Replace literals 0, 2, 0x1425 with PCI_VENDOR_ID, PCI_DEVICE_ID,
> PCI_VENDOR_ID_CHELSIO, respectively. Rename devid variable to vendor_id
> to remove confusion.

This series is missing a cover letter. An explanation of why you're
touching this very very old driver is in order, and please comment
on whether you can test this on real HW, because we don't like
refactoring of very old code:

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
 =20
  Netdev discourages patches which perform simple clean-ups, which are not =
in
  the context of other work. For example:
 =20
  * Addressing ``checkpatch.pl`` warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
 =20
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
 =20
  Conversely, spelling and grammar fixes are not discouraged.
 =20
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#cl=
ean-up-patches
--=20
pw-bot: cr

