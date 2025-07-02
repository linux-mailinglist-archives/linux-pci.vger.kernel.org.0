Return-Path: <linux-pci+bounces-31295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4957CAF5FDB
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 19:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E64E3BBDD4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8032F50A2;
	Wed,  2 Jul 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Izahd7YJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAB301126
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476994; cv=none; b=c+OS5Uui9Q0PqVQDp0rulVgmaKnr+sd1rOaR8dPfLaX0Mrkg0ksFJ0O/1L7laRtzBC4nvs1Zn2mbuLaqZ0ooXc0PaKF0Y99Cyx6YnShzsvtB9DNbW3BWzs0ncGj0k8yOt020ocmPZVgxFo0sIRNAja0ri2Fcsu6NwiJcuC7Oias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476994; c=relaxed/simple;
	bh=gL7SST8K/mdgik/v+gFevpjjdC4l4ZuDnfHeUyVmmQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brWIjWwZ39gqcx85LFkZfCtS4pJDBNDjjyXjPOmwQZD4FF7Axi1rlbUOVwoW/drMDURndSkx4rLRzsvvwakX/+Zj9C1BYKCQm6wcU14zWU3/alAkNcwm8BM1xBPYIXVd5M5WLMErf8SvN9cgJH7gn2+yz3WPZzl074ncAt/kOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Izahd7YJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751476991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11pe78CaZdqy/tsNep3+p3swsBKo7kc1iN8l8E0ERew=;
	b=Izahd7YJsfkuJCah+KN3iBgkI4SN1RiWBUHvjkcO9ixOIydiyyNCz/cxVPyoUXi7DALryC
	7K78KXKoZL+Bci9YDl5yAMUyBa4z45iJ4E8kuf/eCf97e5chU2rNSgJeaP77wmmOVBxPRH
	DGVIz22qEqtIdATKyi/JQSV4+8qHhYU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-kRK4YxN4Ml-6ilWiUchzwg-1; Wed, 02 Jul 2025 13:23:10 -0400
X-MC-Unique: kRK4YxN4Ml-6ilWiUchzwg-1
X-Mimecast-MFC-AGG-ID: kRK4YxN4Ml-6ilWiUchzwg_1751476989
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4532514dee8so46333275e9.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 10:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476989; x=1752081789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11pe78CaZdqy/tsNep3+p3swsBKo7kc1iN8l8E0ERew=;
        b=VxewAcCwmN1kx5pZ9HWVng01FT0eeCse3lVr42uKge19Oh/WxTUN40qnVGGcYSU9I5
         VA0hcxfPMYpT3mTjWd4pqKtWFXlh1GBuPlajYHUMZGXFK6LTmCaeESNsLeab7+zDbFyz
         heKNVL6mfhiJgk/JJRHtKujp3FbQnPF4qkqc9w79xHrNCUZ3C4gT4ds8rWDp2mvPwKjm
         O7f3HWkYtHVntdnqzWaKFGcbYJuLuhSCtFLouXz5HB7mK+GuXH6CAizh8VTk3WSeKr/q
         VVvmTflsYkgdKKcRv562GvaBgxgvfRHr9jJqLgEb6sEwOjPHzDWAPbxOapdkElfNK6Sm
         E5bA==
X-Forwarded-Encrypted: i=1; AJvYcCULiVPJ/ZPGmj117Jqn+H1d3Wx/2/dwZBJb9M0SYhj4ayKRLRgKYm9u0lWWB8EmMyyxZ+pFaI3C39M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3TMX1aSlDP7n75+1iLk90buXvOoGDMjP59CfsB1qHSzbAPkX
	goOymS+EP/6IpkpFzqZu5opDVFtCYGCAHj6w8oAwPBLr0ELFLd0kMvEWm600gW5uyp0d4TXiDY/
	YNGFcmkBj0sp/u8C5n8p6LsR7YwAHHlvgy0RBjzusFrzUV14Rqw5gDf/RZypsnw==
X-Gm-Gg: ASbGncs8pSJmc/xsoOJqBNLSackIBfz+PpDQq4vdGJrJgR0qYNPYbK3YKzfnz4nc8SP
	AKVMPCYBOG6/xsX7OgV9bT3Yddx6ssC+5Z2kEASPkTT+tGHdNBoOX9E5eGLrbQMlzRGvwrHGv3s
	6U0bHFPTgzH2gsqfLRQxzFmuKoGQe4bklikes3oD9WBEiNyELBL07e8xmYbrQ2RRegW9mQal64U
	PLSJ00F4Bdds9IMRRkleeiHIT+bHW8g0IPgNm8P2RJIcfg7q9IkGDHnIG7qEiNKrO9AHLwIRAXT
	NO/xeQX2SqOm591Y
X-Received: by 2002:a05:600c:3b01:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-454a3732ff3mr51540895e9.30.1751476988458;
        Wed, 02 Jul 2025 10:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXPMZRpw9jEVmWiCcSmC6H1AmgN1xNVj8w+71GoQ2QajqNgkg+w87lm1hr/qtaDXOW0/lV6g==
X-Received: by 2002:a05:600c:3b01:b0:451:df07:f437 with SMTP id 5b1f17b1804b1-454a3732ff3mr51540535e9.30.1751476987872;
        Wed, 02 Jul 2025 10:23:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa8fasm16455680f8f.28.2025.07.02.10.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:23:07 -0700 (PDT)
Date: Wed, 2 Jul 2025 13:23:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v3] pci: report surprise removal event
Message-ID: <20250702132212-mutt-send-email-mst@kernel.org>
References: <1eac13450ade12cc98b15c5864e5bcd57f9e9882.1751440755.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eac13450ade12cc98b15c5864e5bcd57f9e9882.1751440755.git.mst@redhat.com>

On Wed, Jul 02, 2025 at 03:20:52AM -0400, Michael S. Tsirkin wrote:
> At the moment, in case of a surprise removal, the regular remove
> callback is invoked, exclusively.  This works well, because mostly, the
> cleanup would be the same.
> 
> However, there's a race: imagine device removal was initiated by a user
> action, such as driver unbind, and it in turn initiated some cleanup and
> is now waiting for an interrupt from the device. If the device is now
> surprise-removed, that never arrives and the remove callback hangs
> forever.
> 
> For example, this was reported for virtio-blk:
> 
> 	1. the graceful removal is ongoing in the remove() callback, where disk
> 	   deletion del_gendisk() is ongoing, which waits for the requests +to
> 	   complete,
> 
> 	2. Now few requests are yet to complete, and surprise removal started.
> 
> 	At this point, virtio block driver will not get notified by the driver
> 	core layer, because it is likely serializing remove() happening by
> 	+user/driver unload and PCI hotplug driver-initiated device removal.  So
> 	vblk driver doesn't know that device is removed, block layer is waiting
> 	for requests completions to arrive which it never gets.  So
> 	del_gendisk() gets stuck.
> 
> Drivers can artificially add timeouts to handle that, but it can be
> flaky.
> 
> Instead, let's add a way for the driver to be notified about the
> disconnect. It can then do any necessary cleanup, knowing that the
> device is inactive.
> 
> Since cleanups can take a long time, this takes an approach
> of a work struct that the driver initiates and enables
> on probe, and tears down on remove.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> 
> Compile tested only.
> 
> Note: this minimizes core code. I considered a more elaborate API
> that would be easier to use, but decided to be conservative until
> there are multiple users.
> 
> changes from v2
> 	v2 was corrupted, fat fingers :(
> 
> changes from v1:
>         switched to a WQ, with APIs to enable/disable
>         added motivation
> 
> 
>  drivers/pci/pci.h   |  6 ++++++
>  include/linux/pci.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62..208b4cab534b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -549,6 +549,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
>  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
>  	pci_doe_disconnected(dev);
>  
> +	if (READ_ONCE(dev->disconnect_work_enable)) {
> +		/* Make sure work is up to date. */
> +		smp_rmb();
> +		schedule_work(&dev->disconnect_work);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 51e2bd6405cd..b2168c5d0679 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -550,6 +550,10 @@ struct pci_dev {
>  	/* These methods index pci_reset_fn_methods[] */
>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
>  
> +	/* Report disconnect events */
> +	u8 disconnect_work_enable;
> +	struct work_struct disconnect_work;
> +
>  #ifdef CONFIG_PCIE_TPH
>  	u16		tph_cap;	/* TPH capability offset */
>  	u8		tph_mode;	/* TPH mode */
> @@ -2657,6 +2661,29 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
>  	return (pdev->dev_flags & PCI_DEV_FLAGS_ASSIGNED) == PCI_DEV_FLAGS_ASSIGNED;
>  }
>  
> +/*
> + * Caller must initialize @pdev->disconnect_work before invoking this.
> + * Caller also must check pci_device_is_present afterwards, since
> + * if device is already gone when this is called, work will not run.
> + */
> +static inline void pci_set_disconnect_work(struct pci_dev *pdev)
> +{
> +	/* Make sure WQ has been initialized already */
> +	smp_wmb();
> +
> +	WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
> +}
> +
> +static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
> +{
> +	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
> +
> +	/* Make sure to stop using work from now on. */
> +	smp_wmb();
> +
> +	cancel_work_sync(&pdev->disconnect_work);
> +}
> +
>  /**
>   * pci_ari_enabled - query ARI forwarding status
>   * @bus: the PCI bus
> -- 
> MST


