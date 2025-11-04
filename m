Return-Path: <linux-pci+bounces-40258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC36C324FF
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C45F18897BB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250A226CE17;
	Tue,  4 Nov 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxW0ysot"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECEE1A9FB6;
	Tue,  4 Nov 2025 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276682; cv=none; b=n5e8NFPpe2XOPVylmUQ3g3GNQR/8OHHu/vEkUSuUeeoovHd3nu+iCY13f0mfXW52+a8xPW3vFHETFRn7i/IQA4NiF02LNca2fQaCBjqysT/FvXzbD9JBCWNWskLdCh7KPJRCGH98aNHOQ/6blAHUc31u+Ffd8WAPOB3kDRRwSxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276682; c=relaxed/simple;
	bh=TxxfLgNl0FPJeswrTvpsrQzjREOxZ088DQIYrzxnypI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7glesbsb+UqI8dwH5n0r0sgqo5Z+G3H8sKWNj7+sST4YlvZdlDPOnD3P5kVUE4SEyq44fyWUeGnNJn+S80m5WN6rSmNRESrZZyWXnNDi1zWQZH4f0Ho7L3nz3Z8HfFxlCtFSmRC8SzVzd1LbBjgMfspQJk/LCzx0BzUpKh0r6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxW0ysot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1155C4CEF7;
	Tue,  4 Nov 2025 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762276681;
	bh=TxxfLgNl0FPJeswrTvpsrQzjREOxZ088DQIYrzxnypI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxW0ysotaGh8nygHONMuKqbu0HDWzP8lAJp4ewtvAr2PoKsmMV5/6M6+0TYsTdWyo
	 G4VX+cEnZyYTBL6SkDZ+jL7MaYQoKFdw2cXMDL7wlz4ft+N7cWoAByqNDqqvMnJLza
	 Euw8Z5LVL77LnQgm51K01dDrhItCo3b4X+iS9Q/w6H1SZILs7soNnyryReWPIwkrUW
	 ekdlZ4DW3w7glJIIKElqCmh5aKlnzeHCxD5lXFyelNfxJngvIDhmYGvDlOu8By6KG1
	 IfGdrePwWVVWwDnGQ8/31wwAa2GjWV04k2gny5LiNId8wGLBxZ3M3yAiCWhWWK4N5q
	 Grr5eBnNGeuJg==
Date: Tue, 4 Nov 2025 17:17:56 +0000
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	aleksander.lobakin@intel.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Marek Landowski <marek.landowski@intel.com>
Subject: Re: [PATCH net-next] idpf: add support for IDPF PCI programming
 interface
Message-ID: <aQo1RHrDkSxcQm9s@horms.kernel.org>
References: <20251103224631.595527-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103224631.595527-1-anthony.l.nguyen@intel.com>

On Mon, Nov 03, 2025 at 02:46:30PM -0800, Tony Nguyen wrote:
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> 
> At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
> on our current generation hardware. Future hardware exposes a new set of
> device IDs for each generation. To avoid adding a new device ID for each
> generation and to make the driver forward and backward compatible,
> make use of the IDPF PCI programming interface to load the driver.
> 
> Write and read the VF_ARQBAL mailbox register to find if the current
> device is a PF or a VF.
> 
> PCI SIG allocated a new programming interface for the IDPF compliant
> ethernet network controller devices. It can be found at:
> https://members.pcisig.com/wg/PCI-SIG/document/20113
> with the document titled as 'PCI Code and ID Assignment Revision 1.16'
> or any latest revisions.
> 
> Tested this patch by doing a simple driver load/unload on Intel IPU E2000
> hardware which supports 0x1452 and 0x145C device IDs and new hardware
> which supports the IDPF PCI programming interface.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Tested-by: Marek Landowski <marek.landowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> IWL: https://lore.kernel.org/intel-wired-lan/20250926184533.1872683-1-madhu.chittim@intel.com/

Reviewed-by: Simon Horman <horms@kernel.org>


