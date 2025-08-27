Return-Path: <linux-pci+bounces-34938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C41B38A4F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 21:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA95916E1ED
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61A528313F;
	Wed, 27 Aug 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohngir3D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD661212546;
	Wed, 27 Aug 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323584; cv=none; b=t0jZc8KURsa99R07b9UaU43VZrNF9ZvZSzHmEXSCMVcx6jM1TmIqrhAd9ThT5wZwKgZs/raZ6ONHl16b8YxcK7/QXD2EwPOgrktX8MYFC24jttFeQy4Wxb0nWTiJ3yjnZ1z49iewkIVOxISrrdQdgBMJ8zRcLUKgBIEpgqyDoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323584; c=relaxed/simple;
	bh=1OY8DbuPXkQgc9rC1JKFK3DVQN06e26bJvJhVNq23iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQsTXHFHqWdVsDYnOmn6jvC/pA6lGTww1rK6nDsStO2tpgK4khUdJRLTTKIZuR+klUq7SLqVKlL8X25auDZe0D9SbMMCGc+H1VU+QTva6CWgkv+yhDET+muP/NUx7T4QhjdJAs/M9rtMcS1ZXf3cBGS+XO1pQVOdMIPuA0B5vDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohngir3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9533C4CEEB;
	Wed, 27 Aug 2025 19:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756323584;
	bh=1OY8DbuPXkQgc9rC1JKFK3DVQN06e26bJvJhVNq23iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ohngir3DoDOoekEVoO9Sz34pgu1UJMzQBHakBK6mTlq5wk7hixuxX5hA47rYsLKvX
	 wNvNvSVVU5VVvLJBILX8+9BwDb7+a153rFBgnIEjVTdlHrJwg7Pug7PaHkhLCf1Bzm
	 NB7Yyf6vhwu67xVnS8POfdfYG2UKy1/L9W552JarSVcYaW4PdC6Gm9DZwXxWF9EEHg
	 paYIIXttXyBfBw1rgZgFmk/hq/0PNwdc8mV2s8bI0c6ycgSEgBQUwJJU4wn8xkKgKE
	 BV02IsZV1IeHJy1a8Y6e+KSiNlXpNpJZXwgKq/VMo4HEqZLeDbO3SRzDEvOUL2l5v7
	 t73bFgTzgdAwA==
Date: Wed, 27 Aug 2025 13:39:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <aK9e_Un3fWMWDIzD@kbusch-mbp>
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

Hi Bjorn,

Can we get a ruling on this one? It's pretty straight forward
implementation exposing a useful attribute. This patch has got a good
amount of reviews and tests. Any objections?

