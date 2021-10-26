Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C8B43BD5C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 00:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhJZWo7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 18:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhJZWo5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 18:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635288153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vW6qRmUkaWK4h81DeTaFQgDoiFlX7pUpcif9sgyaWrw=;
        b=Q1WdHaMRFKcRvYFM1PsHv+J/FU1eqRElZry/DS0UKKupm69tvKoHnkkGpEHnYbYFx6rHxR
        OdoSbyqxBpbdC/ZGjApDqwRdj8YxZ6sLsC2RDjLuR2muWy8IUtr9gdzWNIRDD+puLsQAfW
        xs3n/hccvRW1EB/DTJmVRo+9k9FELtI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-GjWnBq15OF2NxF-NCyHMtA-1; Tue, 26 Oct 2021 18:42:31 -0400
X-MC-Unique: GjWnBq15OF2NxF-NCyHMtA-1
Received: by mail-oi1-f199.google.com with SMTP id e188-20020aca37c5000000b00299a78c3b90so262332oia.11
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 15:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vW6qRmUkaWK4h81DeTaFQgDoiFlX7pUpcif9sgyaWrw=;
        b=7miR6jCUnhG+eAvzTLh9zI8N1uibSWbk9YS9JUqxVtlakxcJ124IquD2Cg24esNcmP
         YQvZ2LKVs80Vb5ACZD5otpAvfrMNSr0onAebzf/41Xg8SOwvd1mZsF0AAtjUJiHAM4EK
         HF+Cols86A+I5ZRKZpAQ5ZwH9MPS9ez3RarDlpBtRCPCWTcJj47DJZl5BNl+IR/oHCTy
         rqCgb+vUZLSwLMIJpZEHg7zlF4NA+LeRnIRTq7TFT/l7L7s3QAV6y3+ZnujBNAEM8rTn
         Pu5mpPY2aXlFbj1LQBpUUS5LOkU7wXq8eUGRuXTv5oxOhpsxzwDDriIsX8OrDHV/0QxS
         LHgQ==
X-Gm-Message-State: AOAM532CvmMbla54wOQSW/aeydW7Qm0VW356s0V0Hb7ErVn2SfdHbHX8
        1DriM27IAwsdaNozLF7lojkD9NZTg6DOO+2LlZ68AI5v45GeVcGD5AfsV7zfhwvlO77ZOhR9D/1
        xK9+MwiEoCD2IhQ6Nu4ZG
X-Received: by 2002:a05:6808:1894:: with SMTP id bi20mr769917oib.136.1635288151159;
        Tue, 26 Oct 2021 15:42:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTJ8pUKHZ04zyJABGkvIBECvvHJ/yxeIB99sqoaN32sZxKt7cKcZiY+N0ugdRR1v5laGpqxg==
X-Received: by 2002:a05:6808:1894:: with SMTP id bi20mr769900oib.136.1635288150903;
        Tue, 26 Oct 2021 15:42:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s127sm1733539oif.56.2021.10.26.15.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:42:30 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:42:28 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     <bhelgaas@google.com>, <jgg@nvidia.com>, <saeedm@nvidia.com>,
        <linux-pci@vger.kernel.org>, <kvm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <kuba@kernel.org>, <leonro@nvidia.com>,
        <kwankhede@nvidia.com>, <mgurtovoy@nvidia.com>, <maorg@nvidia.com>
Subject: Re: [PATCH V4 mlx5-next 11/13] vfio/mlx5: Implement vfio_pci driver
 for mlx5 devices
Message-ID: <20211026164228.084a7524.alex.williamson@redhat.com>
In-Reply-To: <20211026090605.91646-12-yishaih@nvidia.com>
References: <20211026090605.91646-1-yishaih@nvidia.com>
        <20211026090605.91646-12-yishaih@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 Oct 2021 12:06:03 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:
> +static int mlx5vf_pci_set_device_state(struct mlx5vf_pci_core_device *mvdev,
> +				       u32 state)
> +{
> +	struct mlx5vf_pci_migration_info *vmig = &mvdev->vmig;
> +	u32 old_state = vmig->vfio_dev_state;
> +	u32 flipped_bits = old_state ^ state;
> +	int ret = 0;
> +
> +	if (old_state == VFIO_DEVICE_STATE_ERROR ||
> +	    !VFIO_DEVICE_STATE_VALID(state) ||
> +	    (state & ~MLX5VF_SUPPORTED_DEVICE_STATES))
> +		return -EINVAL;
> +
> +	/* Running switches off */
> +	if ((flipped_bits & VFIO_DEVICE_STATE_RUNNING) &&
> +	    !(state & VFIO_DEVICE_STATE_RUNNING)) {
> +		ret = mlx5vf_pci_quiesce_device(mvdev);
> +		if (ret)
> +			return ret;
> +		ret = mlx5vf_pci_freeze_device(mvdev);
> +		if (ret) {
> +			vmig->vfio_dev_state = VFIO_DEVICE_STATE_ERROR;
> +			return ret;

Is it not possible for this to unwind, only entering the error state if
unquiesce also fails?

> +		}
> +	}
> +
> +	/* Saving switches on and not running */
> +	if ((flipped_bits &
> +	     (VFIO_DEVICE_STATE_RUNNING | VFIO_DEVICE_STATE_SAVING)) &&
> +	    ((state & (VFIO_DEVICE_STATE_RUNNING |
> +	      VFIO_DEVICE_STATE_SAVING)) == VFIO_DEVICE_STATE_SAVING)) {

Can't this be reduced to:

 if ((flipped_bits & ~VFIO_DEVICE_STATE_RESUMING) &&
     (state == VFIO_DEVICE_STATE_SAVING)) {

Maybe there's an argument for the original to be more invariant of TBD
device_state bits?  Thanks,

Alex

> +		ret = mlx5vf_pci_save_device_data(mvdev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Resuming switches on */
> +	if ((flipped_bits & VFIO_DEVICE_STATE_RESUMING) &&
> +	    (state & VFIO_DEVICE_STATE_RESUMING)) {
> +		mlx5vf_reset_mig_state(mvdev);
> +		ret = mlx5vf_pci_new_write_window(mvdev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Resuming switches off */
> +	if ((flipped_bits & VFIO_DEVICE_STATE_RESUMING) &&
> +	    !(state & VFIO_DEVICE_STATE_RESUMING)) {
> +		/* deserialize state into the device */
> +		ret = mlx5vf_load_state(mvdev);
> +		if (ret) {
> +			vmig->vfio_dev_state = VFIO_DEVICE_STATE_ERROR;
> +			return ret;
> +		}
> +	}
> +
> +	/* Running switches on */
> +	if ((flipped_bits & VFIO_DEVICE_STATE_RUNNING) &&
> +	    (state & VFIO_DEVICE_STATE_RUNNING)) {
> +		ret = mlx5vf_pci_unfreeze_device(mvdev);
> +		if (ret)
> +			return ret;
> +		ret = mlx5vf_pci_unquiesce_device(mvdev);
> +		if (ret) {
> +			vmig->vfio_dev_state = VFIO_DEVICE_STATE_ERROR;
> +			return ret;
> +		}
> +	}
> +
> +	vmig->vfio_dev_state = state;
> +	return 0;
> +}

