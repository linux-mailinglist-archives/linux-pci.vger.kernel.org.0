Return-Path: <linux-pci+bounces-15655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951229B6E72
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 22:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598772825FB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 21:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8360213EE0;
	Wed, 30 Oct 2024 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkEQfGIc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772A14F90;
	Wed, 30 Oct 2024 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322663; cv=none; b=btWfmSMr/y/PexnDcYKHsXtpXNtvOoMcmH7dgHgxrKly+fMraUK6qrpxsWQ313DbTQMV5OALmVP0x83nwoalXy3KJjQjwLfy4/HuLM/nNpLdOq9np4X3wU7q0UG+A6Vvs9Vp9kxEpKadfk2HM7DfXIQI6kp0bVMugfl3HGZ/uxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322663; c=relaxed/simple;
	bh=49YpfPgybjyunYRlnfXehdPEI1xELY9QE5/uJT2eRPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OKdXsIS+svbrCFi7nUIkBnbKoaGi7E13i1aa1umAF0RR/uqCBe5bCk9ZqMOqoyWQecBz7Nm09ymc5GW6juw/Q3fF9w2GsLeWihun5XJXkr/vDMJs2cyJHpRCr/q2cFSqQOhS3rpF3Ev6t+VTd0xSju95xYR+tas00Vn9LY+dPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkEQfGIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB149C4CECE;
	Wed, 30 Oct 2024 21:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730322663;
	bh=49YpfPgybjyunYRlnfXehdPEI1xELY9QE5/uJT2eRPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pkEQfGIccHm/wjiCrCCWe/fH7mfNqtwdKRguI2XyD+0KsDUZwN+Z3GEyLkB72KLSy
	 ulaBG27WfSdkBPsSCq9Yjp/3JTK5hLojfRSklS9RUiQPlAcnN7CviYKk/XyzFK0ByX
	 Ip+k/evjUE7lioJxM7T4DzxFai1kidYxX7YiT7IXRP34r0U25bFA99l8ZHQOmfqDpU
	 1YHV4iYYti/4gl4juv7KbZgDYPOhzdN4tgMBXwvF191SrIvWNuZizINVQBdIJ1KUlB
	 zAB3Bq3cuJ15LzgOUrz0K+qEuKnNH6URIYvoC6qQ0lGtlTrzqYvfrsPzuyf4NmCutU
	 +Q30d8ivn5xlA==
Date: Wed, 30 Oct 2024 16:11:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Michal Witwicki <michal.witwicki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, qat-linux@intel.com,
	linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v6 00/10] Remove pcim_iomap_regions_request_all()
Message-ID: <20241030211100.GA1220400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030112743.104395-1-pstanner@redhat.com>

On Wed, Oct 30, 2024 at 12:27:33PM +0100, Philipp Stanner wrote:
> Changes in v6:
>   - Add Ilpo's RB to patch #1
>   - Rephrase error log messages in patch #6. (Ilpo)
> 
> Changes in v5:
>   - Add Acked-by's from Alexander and Bharat (the latter sent off-list,
>     because of some issue with receiving the previous patch sets).
> 
> Changes in v4:
>   - Add Acked-by's from Giovanni and Kalle.
> 
> Changes in v3:
>   - Add missing full stops to commit messages (Andy).
> 
> Changes in v2:
>   - Fix a bug in patch №4 ("crypto: marvell ...") where an error code
>     was not set before printing it. (Me)
>   - Apply Damien's Reviewed- / Acked-by to patches 1, 2 and 10. (Damien)
>   - Apply Serge's Acked-by to patch №7. (Serge)
>   - Apply Jiri's Reviewed-by to patch №8. (Jiri)
>   - Apply Takashi Iwai's Reviewed-by to patch №9. (Takashi)
> 
> 
> Hi all,
> 
> the PCI subsystem is currently working on cleaning up its devres API. To
> do so, a few functions will be replaced with better alternatives.
> 
> This series removes pcim_iomap_regions_request_all(), which has been
> deprecated already, and accordingly replaces the calls to
> pcim_iomap_table() (which were only necessary because of
> pcim_iomap_regions_request_all() in the first place) with calls to
> pcim_iomap().
> 
> Would be great if you can take a look whether this behaves as you
> intended for your respective component.
> 
> Cheers,
> Philipp
> 
> Philipp Stanner (10):
>   PCI: Make pcim_request_all_regions() a public function
>   ata: ahci: Replace deprecated PCI functions
>   crypto: qat - replace deprecated PCI functions
>   crypto: marvell - replace deprecated PCI functions
>   intel_th: pci: Replace deprecated PCI functions
>   wifi: iwlwifi: replace deprecated PCI functions
>   ntb: idt: Replace deprecated PCI functions
>   serial: rp2: Replace deprecated PCI functions
>   ALSA: korg1212: Replace deprecated PCI functions
>   PCI: Remove pcim_iomap_regions_request_all()
> 
>  .../driver-api/driver-model/devres.rst        |  1 -
>  drivers/ata/acard-ahci.c                      |  6 +-
>  drivers/ata/ahci.c                            |  6 +-
>  drivers/crypto/intel/qat/qat_420xx/adf_drv.c  | 11 +++-
>  drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   | 11 +++-
>  .../marvell/octeontx2/otx2_cptpf_main.c       | 14 +++--
>  .../marvell/octeontx2/otx2_cptvf_main.c       | 13 ++--
>  drivers/hwtracing/intel_th/pci.c              |  9 ++-
>  .../net/wireless/intel/iwlwifi/pcie/trans.c   | 16 ++---
>  drivers/ntb/hw/idt/ntb_hw_idt.c               | 13 ++--
>  drivers/pci/devres.c                          | 59 +------------------
>  drivers/tty/serial/rp2.c                      | 12 ++--
>  include/linux/pci.h                           |  3 +-
>  sound/pci/korg1212/korg1212.c                 |  6 +-
>  14 files changed, 76 insertions(+), 104 deletions(-)

Applied to pci/devm for v6.13, thanks!

