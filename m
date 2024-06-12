Return-Path: <linux-pci+bounces-8688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B580B905C49
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 21:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F291C2136E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D038F83;
	Wed, 12 Jun 2024 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBz2Lywz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAF381C4
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221717; cv=none; b=hPf7TeLXEh0/Td71+znTdkxTPUH92sQcatDtioTyu8Z9QtqmnXKdMggO6k5+cS1RWWuv5cQLNUzXSqQBjGbs9t3p6p5WvNlLSFND0c6bRLzkzijfqtyBInL2Lh78NQ6m3OgjIkXKz+NLPMqUjc1PXKwIMrRXcBTgZjII7awfwy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221717; c=relaxed/simple;
	bh=w9Rt34g1NAf/lnKTJg1QsLQtDqnhENK4/kBjulfr7rY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OBtxShrLvDGDbK8jzb6nM+xEpOFzIUIKqk+A3O/Fjl7QrPsAodpHbckKiMWryoOIFDGXjxr5S1QQu6OyDHKNebzrfr3+ucnZ4EB3nh+hq2hsZnTZeoJddxff1U6mEWNhRL5jLG/eaXIswuCGUzRzd7tlUiUwCNvb41GHxJHar4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBz2Lywz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2CBC116B1;
	Wed, 12 Jun 2024 19:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718221717;
	bh=w9Rt34g1NAf/lnKTJg1QsLQtDqnhENK4/kBjulfr7rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UBz2LywzLFDOZ7FwxFb/8JQqDuxFgpSB2MSF8QkfdmYyzSk/kBHZcZcUU0kMc/hsI
	 KwhQnhPUH1TirCyo2cWZdbv6aqXM12U/6I6bz5iPY16pD4U4dm61Q+aPgDdxG7adsQ
	 ZYJaLYXQnZX6aN1EsKzBXq9Ua+6UF6tcGTDlVA3Z8H+nIHx3BiP1eQiuqMRt4i0/b6
	 HErYT7A0SUYyN0LkUqgEYJrB2q71YKPKYzR9L/nu5Rul4oItu5eeC350qwMBJAh6y1
	 hlzyZb97ABGU8sUwcboQASjG8vyZ7wEYqfebX+DQE1aH6fXZQN2qUPyAa7v4RxJ9yz
	 XQ1cPLLoBonTg==
Date: Wed, 12 Jun 2024 14:48:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/3] PCI: pci_ids: add INTEL_HDA_PTL
Message-ID: <20240612194834.GA1034127@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612064709.51141-2-pierre-louis.bossart@linux.intel.com>

On Wed, Jun 12, 2024 at 08:47:07AM +0200, Pierre-Louis Bossart wrote:
> More PCI ids for Intel audio.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>

Change subject to match history:

  PCI: Add INTEL_HDA_PTL to pci_ids.h

It's helpful mention the places where this will be used in the commit
log because we only add things here when they're used in more than one
place.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 942a587bb97e..0168c6a60148 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3112,6 +3112,7 @@
>  #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
>  #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
>  #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
> +#define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
>  #define PCI_DEVICE_ID_INTEL_HDA_CML_R	0xf0c8
>  #define PCI_DEVICE_ID_INTEL_HDA_RKL_S	0xf1c8
>  
> -- 
> 2.43.0
> 

