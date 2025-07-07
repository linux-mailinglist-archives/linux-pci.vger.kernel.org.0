Return-Path: <linux-pci+bounces-31614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4E0AFB2B7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 13:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAA9188E77C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD028934F;
	Mon,  7 Jul 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEddp6zb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B30288CA1
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889408; cv=none; b=AbqEB/V9HO/quSE6vAcri5hop8CDDvv6L4pjMbW4WHJ4Tk+9WydsHsQFdTAcX+rwpqg4V3sYD0Nzd760VrYXM7Jn7QmecsEoXYlYxvAWVaFhH7jwkQWlVT5sJaLzwXR0VQuGhhl6IvplxztjNkxgYzY0yXNMRDxinuZwCQvhT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889408; c=relaxed/simple;
	bh=LtE0oBkBhD5V0IbagEYp8uPvRq5vFIhpi3XKGa1qOyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2vQQLu1GlPdH/Lz6z/Wwy9X+1ZqOxJnO2u4wX1/ES2nrW4cUop6LIATkT4uWHiWRRUDL30WO3QnMiIksUHZ6Oz9OYc2pUgtZCaeVZxjyuoMMcpKDjmwFOpQbwIkpFPR8em9vtFrp4D5Tkn385dT5Pd3O4yEPlO3R46MMfoHco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEddp6zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A961AC4CEE3;
	Mon,  7 Jul 2025 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751889408;
	bh=LtE0oBkBhD5V0IbagEYp8uPvRq5vFIhpi3XKGa1qOyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEddp6zbXz14s9cM7FpKTGPwi0ofzii8XDUESb/728vXhfZ3tGMkDDZimxS3v0Rxu
	 CsUu5glUVeqr6F6deZ2kbcy1rk/x3/c4d4xFW1qL6DuBsKNyS8ovcE7juUc+8wg03X
	 KWVyR890mcInkEvLgnFcAjy9NSmX0lf2hyuVhgYFzxuP47xMdg/XtUe0AqIKjstsMZ
	 9r2YBIVdEKqDXomqbMgAq1egryKGgyNLqc3NGmjjoVFQbCsbZF9XzLaCGkd0LkTmVq
	 P1gV+5Ys9fh8euL2ThstDs3sN3xT6uk9vzpHXQl+7wTQlOmWgjW5VY7K5LSi2aT31z
	 fIjDSsBhTjOww==
Date: Mon, 7 Jul 2025 13:56:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <aGu1--DfiBI6DnEK@ryzen>
References: <hcjcvo4sokncindwqhhmsx5g25ovj5n5zghemeujw7f4kqiaia@hbefzblsrhqx>
 <20250701163844.GA1836602@bhelgaas>
 <aGT_L_hglVBP6yzB@ryzen>
 <hhyxhxvohmeqzjdu3amabcpf3e4ufi4ps5xd2uia4ea6i2u5oj@sxyjavqyqc7m>
 <aGVbpTZZmYyKIffk@ryzen>
 <2ahvqexaof3cx6fjk3aesav5ptzqwnyicyq6w2gcaqlqaucmg5@6iovzdssfp2r>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ahvqexaof3cx6fjk3aesav5ptzqwnyicyq6w2gcaqlqaucmg5@6iovzdssfp2r>

Hello Mani,

On Mon, Jul 07, 2025 at 01:18:49PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 02, 2025 at 06:17:41PM GMT, Niklas Cassel wrote:
> 
> Sounds fair! I've now dropped 470f10f18b48 from controller/linkup-fix branch.
> 
> Do you have cycles for consolidating PERST# handling?

While I think that consolidating PERST# handling is a great idea, I already
have 3-4 things with higher priority on my TODO list (and some things have
been there for quite a while).

So unless something has rather high priority, I currently don't know when
I will have some spare cycles.

I really hope that someone will have some spare cycles to work on this,
because the PERST# handling in the controller drivers really is a mess.


Kind regards,
Niklas

