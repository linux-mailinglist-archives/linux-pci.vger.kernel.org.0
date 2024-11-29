Return-Path: <linux-pci+bounces-17461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF009DEB2B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 17:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8A3B21761
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634614A0A4;
	Fri, 29 Nov 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUBzcXIO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B49213D8B4
	for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898289; cv=none; b=IIWQUqvSkRVnZ3K6wdVJuon7074k+pfOB5IlZFAkxkmaaPAZG2KVqsbnrZrZEuXowvqJfUkPKybmVCcu0LvQDZpSGdW0JZ/GeS2SeyoljSY7+QZy2fnOOogKsDIgfwLgen1lUWu7Qj76ZuEZAzOZl6q5Y0gFcBeBG8QnPpz4gWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898289; c=relaxed/simple;
	bh=7WjikKFNZ+HEfrOK2PPdKEBf13sxhyHfG6cbbVBGcx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV19zX4rsHPvUzX22iYj5QUxbua/EDoxA/fbrG1y+Wl/DpvIDB/90yKt9hdO2R9DjmRt5qcjT30ANFjNqXuvuvEFKKMK5f4cTJ8eSuiDLdrSca7WG0x8nzYQ9HlJY40pEPaLmsQ2qwNP1eHRj3Lv+jwpgQ6vCUdVmXNlDxLEsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xUBzcXIO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21288ce11d7so19025915ad.2
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732898287; x=1733503087; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNj/qfb7oRR2PWaMb8I3iLUkmdoRJW2FZIUwVWDq9j8=;
        b=xUBzcXIOkZyTCSykVrAcEh42lpJYmP+jTYcVwwB2pCEcIoDCWw7BEA3yYDxIrO/K45
         qGSRIN4zTtsHqt9ApxOlsiDTB61OW6GIGb4nPnB/1EHVD/oqx8ieEhZxGUnzXGQmt8gD
         yPkyTpOKpFxYWytMVA8KAUHCD5WZEGKy7g03KV9/DyYRN7kZzAJFGLviQvAfXk5sUCgI
         EoIRQGKKI5hqKk2A3LGW0OOLdetWT8Kv1Vv0UlVvJu9piCH8b58RPSqbDtHX2TeB02ct
         gjk3DwxCjS5LPKL/2kKJYYw3lS0TSARlAcnMo1zHUexxH7YHatLuWcWun9QKU/ExJiWV
         WgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732898287; x=1733503087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNj/qfb7oRR2PWaMb8I3iLUkmdoRJW2FZIUwVWDq9j8=;
        b=Xxz1OTn4c8hpz6/N/xhJtUH5bRalHz7pPhGG3m+/Q7KlgB+ycQzjMmJHQYX/tb4vhA
         FBkopabKRCNq4Kjt/i20Kl+LQpmy0JSgJtn7OYjWyHkfmjvM0G5SnBikh26bzzSKatLi
         uuA6uhlfppt0JvwEugqITcVlBPbS3FjRzKEjy9V23Xnx1jkzr8rzN1DGPK/EIYMzs21O
         lW/YAhGZAua5ODEdQTmaGo2edxewojPx370sXIw0UMh2WMm57ydzUOZaJtLiEsupbRYI
         ztZpQNJjxkHNR0UQPUHn7tTMoPQ6ccEzB6Vzy46x0ApZO8vioTczIr8Rw1A9iRGCLrvT
         kaDw==
X-Forwarded-Encrypted: i=1; AJvYcCURi9qKZMC422eb8xtMDN6sPP0TiYqUMPC6rhdQuZ5eyaIibNPkMM33l1IjWHAap9PTk2uZ03dJo38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJtoJTi1yGkxWPxn0CVuVHEtXtrO9lTl19qEWo3SE4KYpiILAI
	lt/ZbfFZ234GE6ga6CqjvSXeuTn/tpdKf/+DBq+1bfkd01HoiKxQqcem7iQ4Qw==
X-Gm-Gg: ASbGnctXz/4tr4jlJ81DCd0UP0AzZVEFzgnSgeUNr7wgFfLvivGgL6ZwqV9vDasarZs
	CA9LoGb5CIax+3wleMwa+7yFx00ka3/7AbJ8yKoCZqB/8kKMvMlI8JmF8rn8MDqUjfLoQugiFYw
	Er+xcek5Qhsn3qEgT+c2krqAYF5VaNXah1MW7lxw7rbWH8JfLtim0Zc12mr9B84zxcmrzfPexxO
	y6JgT9yxdASbn1XPtOxIYf07BmL0nR578iy2u44Rbu3WjRPA0stu2ZFgPJ1
X-Google-Smtp-Source: AGHT+IEgR6eq5WPd71wOgh5UzKE552haFJB18tPtmtwFe0e0t2hbHfrj7ESMfTuQV+Cku7fnAEDKAA==
X-Received: by 2002:a17:902:e549:b0:215:4dad:727f with SMTP id d9443c01a7336-2154dad73c3mr23798135ad.50.1732898287401;
        Fri, 29 Nov 2024 08:38:07 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152199d5c0sm32447185ad.218.2024.11.29.08.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:38:06 -0800 (PST)
Date: Fri, 29 Nov 2024 22:08:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: bhelgaas@google.com, kwilczynski@kernel.org,
	bartosz.golaszewski@linaro.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH] PCI/pwrctrl: Check the device node exist before device
 removal
Message-ID: <20241129163803.osh6yrub42hqb5yf@thinkpad>
References: <1732890621-19656-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1732890621-19656-1-git-send-email-ssengar@linux.microsoft.com>

On Fri, Nov 29, 2024 at 06:30:21AM -0800, Saurabh Sengar wrote:
> There can be scenarios where device node is NULL, in such cases
> of_node_clear_flag accessing the _flags object will cause a NULL
> pointer dereference.
> 
> Add a check for NULL device node to fix this.
> 
> [  226.227601] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000c0
> [  226.330031] pc : pci_stop_bus_device+0xe4/0x178
> [  226.333117] lr : pci_stop_bus_device+0xd4/0x178
> [  226.389703] Call trace:
> [  226.391463]  pci_stop_bus_device+0xe4/0x178 (P)
> [  226.394579]  pci_stop_bus_device+0xd4/0x178 (L)
> [  226.397691]  pci_stop_and_remove_bus_device_locked+0x2c/0x58
> [  226.401717]  remove_store+0xac/0xc8
> [  226.404359]  dev_attr_store+0x24/0x48
> [  226.406929]  sysfs_kf_write+0x50/0x70
> [  226.409553]  kernfs_fop_write_iter+0x144/0x1e0
> [  226.412682]  vfs_write+0x250/0x3c0
> [  226.415003]  ksys_write+0x7c/0x120
> [  226.417827]  __arm64_sys_write+0x28/0x40
> [  226.420828]  invoke_syscall+0x74/0x108
> [  226.423681]  el0_svc_common.constprop.0+0x4c/0x100
> [  226.427205]  do_el0_svc+0x28/0x40
> [  226.429748]  el0_svc+0x40/0x148
> [  226.432295]  el0t_64_sync_handler+0x114/0x140
> [  226.435528]  el0t_64_sync+0x1b8/0x1c0
> 
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Fixes: 681725afb6b9 ("PCI/pwrctl: Remove pwrctl device without iterating over all children of pwrctl parent")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Thanks for the fix! There was already a patch submitted to fix the same issue:
https://lore.kernel.org/linux-pci/20241126210443.4052876-1-briannorris@chromium.org/

- Mani

> ---
>  drivers/pci/remove.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 963b8d2855c1..474ec2453e4b 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -21,6 +21,9 @@ static void pci_pwrctrl_unregister(struct device *dev)
>  {
>  	struct platform_device *pdev;
>  
> +	if (!dev_of_node(dev))
> +		return;
> +
>  	pdev = of_find_device_by_node(dev_of_node(dev));
>  	if (!pdev)
>  		return;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

