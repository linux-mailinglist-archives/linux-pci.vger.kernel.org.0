Return-Path: <linux-pci+bounces-37873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CABD22FD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 11:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB5A3AF0C6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935B2FB967;
	Mon, 13 Oct 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEPfmbhk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B52FB098;
	Mon, 13 Oct 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346080; cv=none; b=kpBG/uXz+Ovot2p2mBrwmpsL/IBR6xJzdNaA+MaEchZi40tCgqGfWruS2CBQKLbGRqpnyIPBFlzUxQbOQ+OIIZZ631P98n4A3FF8YcmqYnqPoIsrag3VcFMLkxId9q3IeAlP/G4SYk/A7T3DIWdOixuVAYDGeHhiLGMas0W97Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346080; c=relaxed/simple;
	bh=3yfCTkEF2K27TRpkTh8vXfseBxxmeQwlUPMMM0DwyN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksbUcx3X9aaLcWCeZyQfhMNNSVVnmHtfgk9IH7sVhhHWgBoIhXAp5kLQBgNmdh5rxxChKe3NVfcvxsItlYEZxKs5k+MVKO4zixpxniAZO7hccI/xo7RiIG0ztKhkqulhWzyDLZeVTnqBqkhjwVnNTZs2LduYkq9wpLQWDADYKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEPfmbhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE36C4CEFE;
	Mon, 13 Oct 2025 09:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760346079;
	bh=3yfCTkEF2K27TRpkTh8vXfseBxxmeQwlUPMMM0DwyN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEPfmbhk1vbe2dRsycUI8cBPNCBaXo5BpLwpsbcN2rkrx0+Okk6XUAz0I+6XFiH8I
	 lt4xeXAcGTZSn0mWTxYvtH5tDTZ0d+itePReAJkDVV5YNwQG0myIiJr+NJ8DIUyCn+
	 JVzhMBVrz+lz6hpVbmJ5VFJXceb6CAumdo2Fkxt0OW09CwYQ0e8L+cvDlfiNRuwQmW
	 yqLQPDxKpp3D7WM8ZU7flmUJtQ0VF2cCbwOET+YIHSDiXU/wvqd7CGQu9JvXxAYpgr
	 SqucBiGva3uzG/ZgR0U+s5FFba8ZqY/jb2Z5/NjgUWOn7y4UgO2aTwRaewC3FFiR1G
	 Rm00uk4LNslgA==
Date: Mon, 13 Oct 2025 11:01:14 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v5 1/4] PCI: endpoint: Rename aligned_size to mem_size
Message-ID: <aOy_2l5tsOOwiv93@ryzen>
References: <20251009-vntb_msi_doorbell-v5-0-4cfb7b6c4be1@nxp.com>
 <20251009-vntb_msi_doorbell-v5-1-4cfb7b6c4be1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-vntb_msi_doorbell-v5-1-4cfb7b6c4be1@nxp.com>

On Thu, Oct 09, 2025 at 04:54:35PM -0400, Frank Li wrote:
> Rename the variable aligned_size to mem_size to better reflect its purpose.
> 'aligned_size' was misleading, as it actually represents the backing memory
> size allocated for the BAR rather than an alignment value.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Niklas Cassel <cassel@kernel.org>

