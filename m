Return-Path: <linux-pci+bounces-5277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E0588EDFF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A652D1C330A7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9EF14D70B;
	Wed, 27 Mar 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYLKE40g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B7131BB8;
	Wed, 27 Mar 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563135; cv=none; b=iB+jjiTRbXuOI0WtdONTrKPSfxw99jeLttv7crklA+XxgHW9j5ARKRgF1hqZMM71uVugSgM9L8lulkCxGJ2Rq0NytgAWBkmvjCbyjUXU+ymxNZLCSYqJ37tC86vo7IcJgy+hJECLxBJXOqyM0b7Y1VWEDSy+UZLeFPEhKdmLYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563135; c=relaxed/simple;
	bh=0HBq8F9K6LnjpSqk+7zBZTXcdceoLu9fTOnW0z7k21I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bTS8yhjJd07nLIddqni/ojPkCk0+Wdda4KFpA7AAC9qpZHi2X6wfswJwGMHz0tzFZXBYhQh3vHzHcdLd99kLMhHAMIxDOfjDZtiMlZBZ+qJOYhDr0+7A/KoE1pR80VsHS4XVosZ+gJJ5gTR2aZbAo5lw6zIe87rKTg6qhlR/X58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYLKE40g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D2EC433C7;
	Wed, 27 Mar 2024 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711563135;
	bh=0HBq8F9K6LnjpSqk+7zBZTXcdceoLu9fTOnW0z7k21I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EYLKE40g3iKdlE2CQqB+tjPKqpcZhq5/SBvcBnXaqp97Qo9GVj+d5GDNsVlqsjPRl
	 9lc+s9WSq+GkuFPvs0tZwQN5gIzynKjrTE15FWxn02SaCJDBa+LSdLBgoFHzZ913yI
	 +LLZoednW2Nb68P4xNkgWApoInz/+Yx9eGTCp8OHInTEu4K2Anr64u/UYfkTbqSEPg
	 aJ4bvpUyUjVu0JOqTao7dPb5G1E9TQCm2vu25gCKTdfhWtURD5YBmyIM9zyOi53lgh
	 LrwBYL85dmjKLW/4StfxyPeeMggTJQMKJAz6ukLOGD2njjX3YM1gntjqTOafWy9cPY
	 IeGtYrVJ5Z8Gg==
Date: Wed, 27 Mar 2024 13:12:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Update pci_find_capability() stub return values
Message-ID: <20240327181213.GA1531575@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327180234.1529164-1-helgaas@kernel.org>

On Wed, Mar 27, 2024 at 01:02:34PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> f646c2a0a668 ("PCI: Return u8 from pci_find_capability() and similar") and
> ee8b1c478a9f ("PCI: Return u16 from pci_find_ext_capability() and similar")
> updated the return type of the extern declarations, but neglected to update
> the type of the stubs used CONFIG_PCI is not enabled.
> 
> Update them to match the extern declarations.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Provisionally applied to pci/enumeration for v6.10, let me know if you
see any issues.

> ---
>  include/linux/pci.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b19992a5dfaf..6a09bd9636d5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2011,10 +2011,9 @@ static inline int pci_register_driver(struct pci_driver *drv)
>  static inline void pci_unregister_driver(struct pci_driver *drv) { }
>  static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
>  { return 0; }
> -static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
> -					   int cap)
> +static inline u8 pci_find_next_capability(struct pci_dev *dev, u8 post, int cap)
>  { return 0; }
> -static inline int pci_find_ext_capability(struct pci_dev *dev, int cap)
> +static inline u16 pci_find_ext_capability(struct pci_dev *dev, int cap)
>  { return 0; }
>  
>  static inline u64 pci_get_dsn(struct pci_dev *dev)
> -- 
> 2.34.1
> 

