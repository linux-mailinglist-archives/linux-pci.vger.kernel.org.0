Return-Path: <linux-pci+bounces-9116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451FE9133C9
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 14:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55A11F22400
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8479A155A4E;
	Sat, 22 Jun 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6rJu8eT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63D14D282;
	Sat, 22 Jun 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058210; cv=none; b=q1k806/IpO9Wf5hcNmQaDfoW9GAookVGFsHaNrOnDvozjKWzYvrTvRpep+j7bOrUA6NQsm5R9SqcaR/j7Psl44ZUiTkBZOC9Y7YorRxHPTDs5B57nZWYYU3vWLv2QjiEpgAxW2UB/x2Fy0wRXwzECQ85pgrNCu6PLeKN6Gm5joE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058210; c=relaxed/simple;
	bh=9pGtoUuCwodrZfU6N9Ddfo5lBiKVtSDI4XnqlMUinMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuvtXIlLYvBM6k+Prig8NdOP1pF6KkN4Fyo/y/qfRySE8JCPo+8VnxDY5zsiO3h8ZQz+q3tqnvE/BirwVF7kSfoMqQS32V1k6/HvqpJd8ipgLkF6KY9TzTtBNA6gxEXDCu68CB6meMSyhaWltfF1w82y7yU4st4THDNm5ZPenVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6rJu8eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42790C3277B;
	Sat, 22 Jun 2024 12:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719058209;
	bh=9pGtoUuCwodrZfU6N9Ddfo5lBiKVtSDI4XnqlMUinMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6rJu8eT0se2RZjFQzKU40BXpOZAhCvngfS9n7eBMLmxEaO1D/gEhYSqgnDUci5/4
	 Lp3WMYSriBWYJfNIAyZx5Z0AX2JvX7N+TsrVZASKSgJK8C3ughjpFdGphI1gC2QuHH
	 5lo4KLkMjH+vmL5fVAmodFKNlJIKyH89J5YzA7ZjxlI06eFq+0qoKXVv7L87p10SpP
	 4UwtKTu7sFnMXXUk7TApHhFln0lWtT3bOw7vYGTyIYvOR6KXL1amppLz+XnBintu3J
	 B9HBbjf1QhMeO/9pRqh0+ty5vr2nOYMn3d4o82PhaFnmb61PwEhYcSwGxVOJTL8xaM
	 +oh+rPOXe1KEg==
Date: Sat, 22 Jun 2024 14:10:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 00/13] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <Zna_G-z8GRZ9OyDG@ryzen.lan>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
 <Zm_tGknJe5Ttj9mC@ryzen.lan>
 <20240621193937.GB3008482@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621193937.GB3008482@rocinante>

Krzysztof,
thank you very much for applying!

Heiko,
now when the DT-binding and driver has been queued for 6.11,
is there any chance of getting patches 12/13 and 13/13 applied
to the linux-rockchip tree?


Kind regards,
Niklas

