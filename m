Return-Path: <linux-pci+bounces-2888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907C984433B
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 16:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4C62927B9
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB6912A14E;
	Wed, 31 Jan 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC8LMuwL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9112A14C;
	Wed, 31 Jan 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715677; cv=none; b=Xjv3KDg12W7I4bE6n9075Ma92mjaf9jaR/yN66uKc3uofLCww/PIjUfIx+ECgQvTvDtHX8ZJWAukM7BxhCDrO3rvXiWdQXqF1TDc4pqe/SmuLxQKgIxr57IKIrLXUw9caG9x5KLbpBYVVi+/8eEbz7rXqo4dRdTn3Zmj4w9ZiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715677; c=relaxed/simple;
	bh=xBevo8mgTcKneYq4Bd2WfRYMb/BeHd84UNbx55O+OPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oKtKxTBr/fpBaDt2ZOBHQFUjHNdrJHCo1Y3V7Sz1ja2CqXStQtYwCO1PNwehLEAO7OCNwAHG0ganXfxaIG/hdgVoakwPfwFae8SxKPQzKSZFMdERmdDX6domNmxP6bjgBiMctiU5LMzRANDQ7DcvZOsIa5v2Ou8F04Bic/m6MSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC8LMuwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC4DC43394;
	Wed, 31 Jan 2024 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706715676;
	bh=xBevo8mgTcKneYq4Bd2WfRYMb/BeHd84UNbx55O+OPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bC8LMuwLQcG3kBf7jr+fzDJveqKSXqqszKUZXkDsPTDoeatLr8itGi7U6joJxN7W5
	 aCE/V1bAQVb1PH+MJCe29yr2GiyEIehWERR9I6F62BNqSTKzbdrQK7nqcsS9kcqOAC
	 J5oLHWSlr2QmEPnVJG4m9Vk+nNnHpi+laCcstq+oIHHYMOoEzCu74pQmBhIcaxaGSz
	 06fxD2N3XX9A3ntG3gGqpMcoPjRIRBdvyiavNbUiIDP/7elaGmlDr9aaurTpYJx0Bf
	 1msuPCPLcSMHXMo4UDjSxCQMjnCORw7OPO/xkxszV/m7x1fxuoEkZK7S/6HX80gTcQ
	 wTXHNvjj7QQSw==
Date: Wed, 31 Jan 2024 09:41:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 2/6] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <20240131154115.GA587326@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130-pme_msg-v1-2-d52b0add5c7c@nxp.com>

Nit: could the subject line be more specific than "change arguments"?
E.g., something about collecting dw_pcie_prog_outbound_atu() arguments
in a struct?  If you know that's the fundamental change, it's a lot
easier to read the commit log and the patch because you know the goal.

On Tue, Jan 30, 2024 at 07:45:27PM -0500, Frank Li wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> This is a preparation before adding the Msg-type outbound iATU
> mapping. The respective update will require two more arguments added
> to __dw_pcie_prog_outbound_atu(). That will make the already
> complicated function prototype even more hard to comprehend accepting
> _eight_ arguments. In order to prevent that and keep the code
> more-or-less readable all the outbound iATU-related arguments are
> moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
> to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
> is supposed to be locally defined and populated with the outbound iATU
> settings implied by the caller context.
> 
> As a result of the denoted change there is no longer need in having
> the two distinctive methods for the Host and End-point outbound iATU
> setups since the corresponding code can directly call the
> dw_pcie_prog_outbound_atu() method with the config-structure
> populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ...

