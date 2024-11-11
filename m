Return-Path: <linux-pci+bounces-16448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C229C40FF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 15:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED19C1F2373D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ECF41C79;
	Mon, 11 Nov 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTPvGWyz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1701E481;
	Mon, 11 Nov 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335635; cv=none; b=AWphpsiINQdJLB0yEreJrFfzC6JIS9FSQf3ihLtzH6HDncHrn4sidQbk17wBajT0by+Xoh2ROeGzPBZWTDt0cKXRHVEcm0oECYYVW0GdyBwkmSzvzrEArtPX5GUd8IKSV88v0dW4MIwqrbcrVlYKJu43smcZicP50vnjPGSqlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335635; c=relaxed/simple;
	bh=SewJZP7f9NlP+i+/QC/OUav9taQ94h0x+CLNzfWNZl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7JAwKrpks8bF5OwS4tcvxAtXaRU2zEDvLT/psqEQYnwexq3sRK+u1utB5tT8DmMKxhsjxevlW1IPPEE+jwMC78b21BrJoh/hQHwwW8EUf/f0LnOUs1LuxdrNQVdYYwOu7ADNtEriaBuO82qP7jIfA6pM4m+pSiQtpd2ScfKqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTPvGWyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C42C4CECF;
	Mon, 11 Nov 2024 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731335634;
	bh=SewJZP7f9NlP+i+/QC/OUav9taQ94h0x+CLNzfWNZl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTPvGWyztEaKSUfQSM+9QDWSlt0SZ92xNiyjQhjbSDa39BsYDIgBmlpsDrvOHyYXG
	 JV9VEVP1vqx0YPAFrKq6JljE1czZ/+U+dBdS0HNHEiUe4sNQaI89RX5AnD/F5frs1X
	 qq3cTe/vkPyHk9rr9y+/4FPJgNQ0Alh0KwzZvHljM0JlOo8pPO6BgyQEZfGAlhpKWV
	 nN4IgzkcDZpcRmt7akZEFOR03rJxbTg8tIbPQdL7jF29mPRiofk1srzu4VdYb9E4pY
	 0JkDJRP0J7erGIkTj8Ecqwjlc4QvhIF3cMm+qLAXrcT+shVDJKp3nU5GCcu8E0c7kM
	 TAR1vi1+F3bjQ==
Date: Mon, 11 Nov 2024 15:33:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v5 0/5] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Message-ID: <ZzIVzfkZe-hkAb4G@ryzen>
References: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>

On Fri, Nov 08, 2024 at 02:43:27PM -0500, Frank Li wrote:

(snip)

> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Krzysztof Wilczyński <kw@linux.com>
> To: Kishon Vijay Abraham I <kishon@kernel.org>
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Arnd Bergmann <arnd@arndb.de>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: imx@lists.linux.dev
> Cc: Niklas Cassel <cassel@kernel.org>
> Cc: cassel@kernel.org
> Cc: dlemoal@kernel.org
> Cc: maz@kernel.org
> Cc: tglx@linutronix.de
> Cc: jdmason@kudzu.us
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

On rk3588:
Tested-by: Niklas Cassel <cassel@kernel.org>


Note that the series does not apply cleanly on latest pci/endpoint branch.


Kind regards,
Niklas

