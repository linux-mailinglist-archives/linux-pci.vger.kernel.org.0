Return-Path: <linux-pci+bounces-26686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79880A9AF94
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89211B67C72
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C721531E8;
	Thu, 24 Apr 2025 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5nXXnbK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6314D2B7;
	Thu, 24 Apr 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502266; cv=none; b=Lj17wZlOgklJRo4KynlZHKxPP9mW3oT1wX0LyvpRTxGmLO9iw9o5WuVwBOtHufrazSkinDSQtWqX95yEmUeXnDXatqCEaPHKTzUSLIV8NZ/wTWPbba3Wtt2P//MGv0ZRMDB+atqEQI7uu92QGf1nr1xnVitLN/90RfC4kVOwucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502266; c=relaxed/simple;
	bh=q0TSxRX3UMopris3F0HpSFXFqH3oGXNTS3do0t++xh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqIOgkGLLg9HK1Rh7ghfpksQNP9ZqliBlJwniFTymTlP+v3wS/RbW84ngWK+Sx0L7Mk4vyo09jrBZNVo2xgI+/sX0I3MqFy7Mc/znLJE7eDFb0ywojv1WE+qWx8g0PjT1yi7DV0eguxQcpa4LzXmiIUwmUvyUQ9d6QpwTO7zKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5nXXnbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858B2C4CEE3;
	Thu, 24 Apr 2025 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745502265;
	bh=q0TSxRX3UMopris3F0HpSFXFqH3oGXNTS3do0t++xh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5nXXnbKzQaxLvSCe3nK34cqVz5tq7fprMxeNkE0prhASxOFf8wbY2TO2jRptsURK
	 0xsfvV9+NgA6NAsEvyWzkCTLHqJRzX2u7cgr6KHykBBaCNwVbfSgObqmG9jJ8nMRcL
	 SslyH77UBNQYo4FBK6Piit5OxosvUD9pMqYEXud/xNllS7G978DPiOLJCOk2NfLPts
	 Mz2FcgqHUirfOxtQgvYckzxljI6+hBKU8XJeHExiQwnqarvbRLVNT8Q7gh/7LeVwZC
	 WEQh5TW/g7DX0rMg319337LImFfGQANO1Mle/6LdGs4O2ng1Dm3/38m58wDN+iaZDu
	 0ndQf62F8Rufw==
Date: Thu, 24 Apr 2025 15:44:20 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org, kw@linux.com, robh@kernel.org,
	thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Use FIELD_GET()
Message-ID: <aApANPRB7f1mOWDa@ryzen>
References: <20250421114548.171803-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421114548.171803-1-18255117159@163.com>

On Mon, Apr 21, 2025 at 07:45:48PM +0800, Hans Zhang wrote:
> Use FIELD_GET() and FIELD_PREP() to remove dependences on the field
> position, i.e., the shift value. No functional change intended.

Nit: It is a little bit misleading to write "Use ... FIELD_PREP()"
since this patch actually never uses FIELD_PREP().

Reviewed-by: Niklas Cassel <cassel@kernel.org>

