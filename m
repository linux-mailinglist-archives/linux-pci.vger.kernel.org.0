Return-Path: <linux-pci+bounces-33973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3A4B252EE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 20:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3F35A7740
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152B62C17AD;
	Wed, 13 Aug 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0tXGjri"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1421295531;
	Wed, 13 Aug 2025 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109304; cv=none; b=HrH2Ub5Q0iSYv0SOdrPBJ8e+02mcGMKQcn0Kf3JB3NRjL6H6WUNv5ps5TWUgU2wFlgE72PolNkTdT9OSxLGAsBXqQWCOURe7Dj3u3hVRuZSdzsfxYHd0iC+AzGneLTqmmp2Eobu7X75eHW7NW5+2Vlh7vbnoomKTnSHcxG6C0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109304; c=relaxed/simple;
	bh=m2dHhOh71l27TfOyul2QFpCLU8gr00gihOmNiH3cfok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oha+6O5Gx43HmgfwYK/6Dh7LzZkAqJaUQRB4Sy5X/GW9Fqh9MTYhLBChAbsMwT50qt5ZzMrNZ6nYB0UUydDBwzGNkV1Fa1Ga+Qn1HUQGw3qcx2G5yiD+i1DKA79+lDJz9VPnN3eGMcDYg7sV8nAmucwECaS1ZDa0iF5rO2fsgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0tXGjri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265E1C4CEEB;
	Wed, 13 Aug 2025 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755109303;
	bh=m2dHhOh71l27TfOyul2QFpCLU8gr00gihOmNiH3cfok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d0tXGjriRbT/lDQu8XoR2xw6GFLRQrG33FOX7ZW7/c0eVqzUV6GE3rkjcjDNxj5fi
	 FOFFe9Kp0KSQh6IS5tRaIwR+R5ELW2ddlfXH4ZIgrr9GHrC2pqp/EU5rryS7pRfofJ
	 nqlEFhaq84ZufKrJiLVDw/VbIbyiK45nkULmgvElXiqhWjlpUXOG6NHN+KC1TDOVqb
	 4yFSRDEGra3Ng+m39pU9ZOnEaCQQFO1Lfc7i9DbZik/PHeFbagg2H3N7BdBURiZY9O
	 k8MpR6uzftJ3Ty6jvObrUpAtVQPjjFRVmLIo9/P0n0xtfkg78JW0hpr8Rp2t3XoXET
	 SVygpQqXQAEiA==
Date: Wed, 13 Aug 2025 13:21:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Riana Tauro <riana.tauro@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Edward Cree <ecree.xilinx@gmail.com>, linux-net-drivers@amd.com,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vg.smtp.subspace.kernel.org,
	er.kernel.org@lists.ozlabs.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/5] PCI: Reduce AER / EEH deviations
Message-ID: <20250813182141.GA284875@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755008151.git.lukas@wunner.de>

On Wed, Aug 13, 2025 at 07:11:00AM +0200, Lukas Wunner wrote:
> The kernel supports three different PCI error recovery mechanisms:
> 
> * AER per PCIe r7.0 sec 6.2 (drivers/pci/pcie/aer.c + err.c)
> * EEH on PowerPC (arch/powerpc/kernel/eeh_driver.c)
> * zPCI on s390 (arch/s390/pci/pci_event.c)
> 
> In theory, they should all follow Documentation/PCI/pci-error-recovery.rst
> to afford uniform behavior to drivers across platforms.
> 
> In practice, there are deviations which this series seeks to reduce.
> 
> One particular pain point is AER not allowing drivers to opt in to a
> Bus Reset on Non-Fatal Errors (patch [1/5]).  EEH allows this and the
> "xe" graphics driver would like to take advantage of it on AER-capable
> platforms.  Patches [2/5] to [4/5] address various other deviations,
> while patch [5/5] cleans up old gunk in code comments.
> 
> I've gone through all drivers implementing pci_error_handlers to ascertain
> that no regressions are introduced by these changes.  Nevertheless further
> reviewing and testing would be appreciated to raise the confidence.
> Thanks!
> 
> Lukas Wunner (5):
>   PCI/AER: Allow drivers to opt in to Bus Reset on Non-Fatal Errors
>   PCI/ERR: Fix uevent on failure to recover
>   PCI/ERR: Notify drivers on failure to recover
>   PCI/ERR: Update device error_state already after reset
>   PCI/ERR: Remove remnants of .link_reset() callback
> 
>  .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |  1 -
>  .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  2 -
>  drivers/net/ethernet/sfc/efx_common.c         |  3 --
>  drivers/net/ethernet/sfc/falcon/efx.c         |  3 --
>  drivers/net/ethernet/sfc/siena/efx_common.c   |  3 --
>  drivers/pci/pcie/err.c                        | 40 ++++++++++++++-----
>  drivers/scsi/lpfc/lpfc_init.c                 |  2 +-
>  drivers/scsi/qla2xxx/qla_os.c                 |  5 ---
>  8 files changed, 32 insertions(+), 27 deletions(-)

Applied to pci/aer for v6.18, thanks, Lukas!

