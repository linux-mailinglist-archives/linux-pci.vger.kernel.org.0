Return-Path: <linux-pci+bounces-18220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AD29EE0D1
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03DD168256
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83AA20CCCF;
	Thu, 12 Dec 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5mbfodt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405E20C009
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990580; cv=none; b=G8yw88wCccGUePKntnZdda9NiMQ5om4q4l3Wk8k5kPOTBh/tVz3MVE7LudBKBCCs3riDXm8yWh0BAeDCkJOrqvkXf5K6hT9i8ag3KHggh312+wODUXSiWKZVuN4w5iZ3vyYwXxJC5roRwn7be1Hsoyqh0DAGt4yjafZByvZR3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990580; c=relaxed/simple;
	bh=VMZRSeGlRr2Bp6cR3PjduqI7R8aIRM9v9j/wompB/nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me+3rZb80H9g99hCYKLgjQxJVcNDHVnD9PP0Qfzt/gwSvSE5HSg2Wb5eVnwSxXdXssBbQ5oqEUCdQGibPk9uZOHDiu87JTCIs7JHU9OBBOUzPFvKy1riQq3uz2JjYsspHSnKA+/mc0SFRSir/r0XAjjLhRxq0ayfbIGFLhyF5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5mbfodt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D767C4CED1;
	Thu, 12 Dec 2024 08:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733990580;
	bh=VMZRSeGlRr2Bp6cR3PjduqI7R8aIRM9v9j/wompB/nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5mbfodtcqhIBhVm40vYHrsx6ZbnEsJtZMF4DY91ftHkNfW50uFs6qvuvuWjXzj7e
	 jRksztc0XyRe3d52AF0p8yGscg8oA5jgwrdaH5+taqN7qI1pTbDQ9RtWGHWBeoSmLR
	 s2eRr/Xh7Xrrb4hWO+KMLe1mZSIYoTnIYCPYOhIG5NkbkFQaUYJMwG5NirRZ6jn7+h
	 sbbYBQS4YZtKrIOskIBp1aJBCxLyPtTjhIoxShyX8bSyIVWDL19qMRuowPHzW7J5/C
	 Zv7UC16JIqWBzX4iyg3tRF/am54MnkqA7EcqLIFzriWA5Mka/H0RuJg2E47Yq3ATn2
	 UFqUsZPcMCAlg==
Date: Thu, 12 Dec 2024 09:02:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Add consecutive BAR test
Message-ID: <Z1qYr7GRgmXfHdt9@ryzen>
References: <20241116032045.2574168-2-cassel@kernel.org>
 <20241124023922.dpdjublabfnfxrd4@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124023922.dpdjublabfnfxrd4@thinkpad>

On Sun, Nov 24, 2024 at 08:09:22AM +0530, Manivannan Sadhasivam wrote:
> On Sat, Nov 16, 2024 at 04:20:45AM +0100, Niklas Cassel wrote:
> > Add a more advanced BAR test that writes all BARs in one go, and then reads
> > them back and verifies that the value matches the BAR number bitwise OR:ed
> > with offset, this allows us to verify:
> > -The BAR number was what we intended to read.
> > -The offset was what we intended to read.
> > 
> > This allows us to detect potential address translation issues on the EP.
> > 
> > Reading back the BAR directly after writing will not allow us to detect the
> > case where inbound address translation on the endpoint incorrectly causes
> > multiple BARs to be redirected to the same memory region (within the EP).
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks for the review!

Could this patch please be picked up?


Kind regards,
Niklas

