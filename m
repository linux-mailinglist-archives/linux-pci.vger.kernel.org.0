Return-Path: <linux-pci+bounces-16156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DE9BF417
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 18:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9771C2366D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C23206946;
	Wed,  6 Nov 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFXjOsN2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2C320651A;
	Wed,  6 Nov 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913179; cv=none; b=nNWgtrjIokWvSdUnbujlVSm0tj9KxBK9gbDTwoBu6Yi3Bp2yK5AGUfflGk+K3zJrG09NbmOlmBQvVAxF/xIqtNpfITmlOBs9nLZCbfPE/gbPpAlqMncCXEw7XRn4YwTrCOEnjflddGaRcE2mOAlaIDLuZ3Lixpr/msBnOv36G0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913179; c=relaxed/simple;
	bh=TJ8k3mCggEOeNdf46pEjfuifIThabvQ7xAOUebYtnhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yl/5kAySkFR4y4ljEJKYv+zyPHDbDM+hAyrOsQtC/7oeorVY7LB0yJuXIIlF8Sbsmuvs3/ykxUilzoM0Jb+LgHmOBqOQOrRNXNNA//koEnqawPbzuzLuAuhHfut2MwMxFON5bYli4lXps7qiRos7K+ELJ6a03u4UXS+8f2AuK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFXjOsN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5F7C4CEC6;
	Wed,  6 Nov 2024 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730913178;
	bh=TJ8k3mCggEOeNdf46pEjfuifIThabvQ7xAOUebYtnhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GFXjOsN2J8icjY3vS2+wkJgieDisOOZ+NKfEGqjNgMoDZ6uKErMucXSzMAdDZIoaH
	 YSVnIJi4oyz90j8KTq3hzpbLMso/IONUBj+qZJ03kq8UHdNNed6i+BaVFQBDECdrM+
	 SDxmmbp3pe84qstIeftQTPKmAnHGVafhyXV5Iv6TpNBnpme04zLibSQCROwUSRDodA
	 gcY/w26YP7tOEar+IkwwIDR9zyKuspBsKwLOJq68nn3SuTHsoe+wPt7ahtWrVjFNiC
	 esJfImPYD4LsU8u3aWHxBcN43PgzIO6+vr8+5H5XPi4bB3ccu6Zhz+UoI0rVu/ZWuJ
	 Znia/LLl84cZg==
Date: Wed, 6 Nov 2024 11:12:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sanman Pradhan <sanman.p211993@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev, jdamato@fastly.com, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241106171257.GA1529850@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106122251.GC5006@unreal>

On Wed, Nov 06, 2024 at 02:22:51PM +0200, Leon Romanovsky wrote:
> On Tue, Nov 05, 2024 at 04:26:25PM -0800, Sanman Pradhan wrote:
> > Add PCIe hardware statistics support to the fbnic driver. These stats
> > provide insight into PCIe transaction performance and error conditions,
> > including, read/write and completion TLP counts and DWORD counts and
> > debug counters for tag, completion credit and NP credit exhaustion
> > 
> > The stats are exposed via ethtool and can be used to monitor PCIe
> > performance and debug PCIe issues.
> 
> And how does PCIe statistics belong to ethtool?
> 
> This PCIe statistics to debug PCIe errors and arguably should be part of
> PCI core and not hidden in netdev tool.

How would this be done in the PCI core?  As far as I can tell, all
these registers are device-specific and live in some device BAR.

Bjorn

