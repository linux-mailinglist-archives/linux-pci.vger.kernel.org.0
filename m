Return-Path: <linux-pci+bounces-26600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB69A99746
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF60189DCAD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55AF28CF6F;
	Wed, 23 Apr 2025 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxMP1xYF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB00264A89
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745431035; cv=none; b=AaCJhZLcsrnDfPkUKw5TVo8wC+CtZndJk8VqUlbvagVIFm2HqF6RTqUyJTKRGuKm1DbrM8Y46pw8+46Isj42HOUEuWa1LfGUTnLDjB7OLWv+ovj8sAjJPpkqJ+CkxyS6kBu6cFVZyLQ0tmZC6/NS9KXAp6zzOcqneN2FQVc1U3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745431035; c=relaxed/simple;
	bh=bjdltNmlFLEI8HZPhOlOSEjUjufZxqhoWRX8J02eMg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbBcw7I6QDHe/2XkMdXcQB8nGAWh6q1sT3z6243HMdRrdSruDpMXJhOeJGkk5x7XzZvJ2YssNqxhCiX74XqYMfWm7fRO73YrMNiC+vXmZInWJZLT1whYpCCcyBkZxj2+2pkUjC80CvrznyRUcQw5/u0Kt/Dnnn584do/q3QwXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TxMP1xYF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73712952e1cso72179b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745431033; x=1746035833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1BdEQv1vdl7T9oYKU0EylrvVFVYx8fAUdWQcXrcTcI=;
        b=TxMP1xYFHEkzBby/hYtGGkWVhT7XIyyFBzYsA540A6jshEg77D1juicw89gQ5cm9W6
         QOZCPTCCCbGrmLkMpZSP39FT6dCrXYdEHDptoqgYhXuzXpfpMmwN7Fcj+X8/KQI0pq7N
         orp3apvL6KZLWumUAHISfeJzMH+gLoodwlj6b55lMUJnM53w0Xelhi5+bpwrhixtjf7t
         t874pxd7qEMfm5nFbgICqffcWLlr/FwWcl6hEcWOj+xQ7frOyVGBzVZAU4HclN1hDsp0
         Q1SQ8mBRi4X+9qyNUbKVTMa2GA+ACGXIPnNZj0wmnE+NLQUTIvxgTQqNkuT+prGsK0wt
         qN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431033; x=1746035833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1BdEQv1vdl7T9oYKU0EylrvVFVYx8fAUdWQcXrcTcI=;
        b=w21+7zCtWrTwTgWjdWOGS3qXUnY9AXlTPOCtl3uF50uj3uTGnjFAQbEtqdv5r6Cwap
         N/DbRRr+QqxOGjeXgSuIxRt2Wra6neeSEkufN/QdeR3N+yOWa5MpPtIfcVNdBZL3EA9j
         Qo+aDebtQy5kLde1mRnVmRKG1hrtizhY0K2nyOZO8+MVsYPcRNkT32kWF+uFlN0nJNio
         tF3PpHRs1vNZ+x3c9K53zoi2RjmG7jKtGf/CtD4HER8fE5W0P+vZ2szbKrZK/U/qsMxp
         Yh4sDo4WHpIigVmKJ2rQ2CgAU44t4HrSuz3or9Je0DiuasrVASTmzbSJROr551UZnPAi
         13eA==
X-Forwarded-Encrypted: i=1; AJvYcCXei739TXC8w5MOxOcOw7UJT+VNO+++atoumb3m8CJhqIafMer2MxSsfQTGxL7ZOSgck330wqnoxuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEjHUDNonZaecvTqgRqv0PlXVwN+mQmwYCw9u9MGDQz4PcnBD5
	3vAJVRGT1tCbZTr5KEFxmUvF8jtdJDyxnHYk0/GkJwm41xFATaDu4Sipb65maQ==
X-Gm-Gg: ASbGncs+hNbBSuSpMmshMrgKYUAuOoRM5R9oIOnnFfjt8TFIsYDjsKGfLNEAdUIvN0A
	rrxgUU3vLv9MI4Jc+eDbQywHhjRdp5kccfbSNqSHZ/AZSwxLICMTTTyL1lApQDszEgoRMc9zwrK
	EphRDlE/VrZHtaxHMhm77TFwwZJ6k6jgWvFTSJ3EW8RQMula5iRITKODnCb4rvhCnaMciPz/4at
	7p7aD8Zd8KBza3rgP1nAzObJ/u7yRmvcMmnTuql5i7rGdSJx0/8kWBjdtcAZej7hN2paQsgA9uK
	7cf79wEZZKyvZHJwrlsVCOQF9AijEugi6poBoAVC0Q2q83lCCBA=
X-Google-Smtp-Source: AGHT+IGrh2Cgm+iBVSRE2C97fqzoIaOwZNhd46QOiq5ZCKspweWWHR9ruYah5noD7/eE9vCwrtWuzg==
X-Received: by 2002:a05:6a00:1410:b0:736:5f75:4a44 with SMTP id d2e1a72fcca58-73dc1616619mr22287454b3a.22.1745431032859;
        Wed, 23 Apr 2025 10:57:12 -0700 (PDT)
Received: from thinkpad ([120.60.139.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaab922sm11178588b3a.133.2025.04.23.10.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:57:12 -0700 (PDT)
Date: Wed, 23 Apr 2025 23:27:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Brian Norris <briannorris@google.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] PCI/pwrctrl: Cancel outstanding rescan work when
 unregistering
Message-ID: <lvod2nhpzanaiz6o3ysmsgt66gxcdi5p4yxxbm7uknaif2l334@jmo43oc4ps77>
References: <20250409115313.1.Ia319526ed4ef06bec3180378c9a008340cec9658@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250409115313.1.Ia319526ed4ef06bec3180378c9a008340cec9658@changeid>

On Wed, Apr 09, 2025 at 11:53:13AM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> It's possible to trigger use-after-free here by:
> (a) forcing rescan_work_func() to take a long time and
> (b) utilizing a pwrctrl driver that may be unloaded for some reason.
> 
> I'm unlucky to trigger both of these in development. It's likely much
> more difficult to hit this in practice.
> 

I never envisioned this situation :) But yeah, better be safe than sorry.

> Anyway, we should ensure our work is finished before we allow our data
> structures to be cleaned up.
> 
> Fixes: 8f62819aaace ("PCI/pwrctl: Rescan bus on a separate thread")
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
>  drivers/pci/pwrctrl/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 9cc7e2b7f2b5..6bdbfed584d6 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -101,6 +101,8 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
>   */
>  void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
>  {
> +	cancel_work_sync(&pwrctrl->work);
> +
>  	/*
>  	 * We don't have to delete the link here. Typically, this function
>  	 * is only called when the power control device is being detached. If
> -- 
> 2.49.0.604.gff1f9ca942-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

