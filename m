Return-Path: <linux-pci+bounces-692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD7880A9DA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670E51F2101C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7ED37151;
	Fri,  8 Dec 2023 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKbjRSiL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B91F94D
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 16:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9764C433C7;
	Fri,  8 Dec 2023 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702054450;
	bh=rP/BoOBw5Wi94QQViNnTX6vvAn+7yt+JtMx5Ri2ncHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gKbjRSiLzKZGNfUhMQYIhifZWczNaZ9Eq9Y/tEFab9uHQVOGKz6HA/NHsmKfb4+F0
	 ziNTw7QEuFW3K1TVs+9ymfmioHfwlGaVZyDlztuDUlQkwOIqD8xt9R6GK+EOu/hedI
	 ClP8X+Mn4Hd8nHmb2plwGYUzPBX1w3eEUBWE5PoZ2Ct4LJT1mvPAZzxmR6omMexi+E
	 j4gojDtzEboOoouSbEhJR7yc53+v7J3Sw08YnRlXOQBURkjDHHNDs/VBLZP4dhEb1U
	 lKlhHNJT1rGCTRI3HPGWVnHEu/ov/1ssZpmNGReWp8NGD9cHvl7T5aPoKtxFpPxbd9
	 kRujdfw9HwrBA==
Date: Fri, 8 Dec 2023 10:54:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/3] PCI/AER: Clean up logging
Message-ID: <20231208165408.GA796794@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206224231.732765-1-helgaas@kernel.org>

[+cc Jonathan]

On Wed, Dec 06, 2023 at 04:42:28PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Clean up some minor AER logging issues:
> 
>   - Log as "Correctable errors", not "Corrected errors"
> 
>   - Decode the Requester ID when we couldn't find detail error info
> 
> Bjorn Helgaas (3):
>   PCI/AER: Use 'Correctable' and 'Uncorrectable' spec terms for errors
>   PCI/AER: Decode Requester ID when no error info found
>   PCI/AER: Use explicit register sizes for struct members
> 
>  drivers/pci/pcie/aer.c | 19 ++++++++++++-------
>  include/linux/aer.h    |  8 ++++----
>  2 files changed, 16 insertions(+), 11 deletions(-)

Applied to pci/aer for v6.8.  Thanks, Jonathan, for your time in
taking a look.

