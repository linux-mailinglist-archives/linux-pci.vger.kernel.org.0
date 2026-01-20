Return-Path: <linux-pci+bounces-45285-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMxiL7Kyb2nHMAAAu9opvQ
	(envelope-from <linux-pci+bounces-45285-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:52:02 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4CA47FC3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCB6696B50A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97DA44D03C;
	Tue, 20 Jan 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYRpQwvq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A644D033;
	Tue, 20 Jan 2026 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925360; cv=none; b=LlGKV7XnU0Xeucdt5q0Sjzb85krtRAd/Wtkn12bDyIeX1VfWNL7AnoAI4rLPLrWgWh9S0LyRpAhBwsykvEK4pIRpkbTvwVYwfzY8/0Vb48bj6e+NodxkqXzHASMZ1u3YkvfBaz3VmR/KCEgK0gUL5LViscaC+IXZivL7bZzrZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925360; c=relaxed/simple;
	bh=3h7U8OB8+wXTJLw06HOWz9QDzZOujMBQUm50YpEFJaw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DdMtWqVC8XRuXraP8IlU6jM4tPLlQ+NwZU6BFC0TlyhbPOuxBQBpQzzPMNiy/+zvOFLKg0uRmMZ68+Y5sZUHoTQlN6nO82DtSsDtJPVzQq65vDpj50NU0HJvyB7MknIkXJToUWJTYVbgvsgfg14XI+dG9Qxwg0RgQQddeFaozoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYRpQwvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280BAC19422;
	Tue, 20 Jan 2026 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768925360;
	bh=3h7U8OB8+wXTJLw06HOWz9QDzZOujMBQUm50YpEFJaw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=RYRpQwvqzJ9t4pyRKYwXWk9JDiVMKfQG6OA/n9BF9o+M4uka3uKKJJKuc8mxIq+0o
	 7PXmibTcnLpAw8WEI9UvOC5MhnD/aKR92o2mppDPo758yReopL/GEIJWGyN0aO8syx
	 Kob87V1RfhyfQvlOql34qqcB6QMl2c0TvOS8HE3yATefdE3nuQLVXMpZ85WayooJHP
	 Us7no1HFp5AnVHhxigUfZKOR+eEUIIg1TScXw+YGDdY8MHHruQMvnmZrDJrThbDnQl
	 Lu0bdj+sho5Z3CUZN5PwkzKFTC0K6sVn5yRU/maQUW4n6slmSMIjp3sJpn+ZPZXotv
	 8L2D36MXP2OmA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 17:09:13 +0100
Message-Id: <DFTJPCU9NQQ5.1J4RRDVZH3SX@kernel.org>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-3-zhiw@nvidia.com> <aW83HV4lVR5MQlDd@google.com>
 <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
 <DFTJI4PTLDWM.1F7X1KN1Q264S@garyguo.net>
In-Reply-To: <DFTJI4PTLDWM.1F7X1KN1Q264S@garyguo.net>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45285-lists,linux-pci=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,nvidia.com,vger.kernel.org,kernel.org,gmail.com,protonmail.com,umich.edu,posteo.de,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pci@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pci];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 3F4CA47FC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Jan 20, 2026 at 4:59 PM CET, Gary Guo wrote:
> I think whether there's a runtime bound checking and whether a IO size is
> supported are two orthogonal things, I would rather we have a single seri=
es of
> `IoCapable<T>` to just indiate the latter and still keep the `IoKnownSize=
`.

I like this idea, it seems like a very reasonable compromise to me.

