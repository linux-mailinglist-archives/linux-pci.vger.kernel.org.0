Return-Path: <linux-pci+bounces-16884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBD89CE0F0
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 15:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEFBD1F29728
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FBE1CEAD3;
	Fri, 15 Nov 2024 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ye+Hb/5G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268191CDA18
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679727; cv=none; b=cClslsKaJ5NXE7IGFri4y9+j/dn0SUyLcXKYJYqDiE6C/mXDqi6w7k2hIVdcOuwJlFJ+2lM7W3XBgXsdQUwQJenad8fnqxwSfd5XtDnaH8kha+hA7TeK/oE8Ww8K+eLZMJKiSosRNNzMr9E8PoJGXvy1yCH3mVAsrbPnw8aY4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679727; c=relaxed/simple;
	bh=xKws5Q0o4CUmb4V5oZwIdg4rnXrBMpqWmbqe1P0JpKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkrM+391pZMFgAJ9q3pMJgrQycAWhPiDMoJCk7SmgQxr/E9YeHwBni0LDKulwYYc8j5E8IfNLWsiJzzH5KKO+wRSoxd8/EfnsLjEehJpAWJ+T1JmyZUDPfs89dCY1wYXHXsqk8HFVUOGDX7q9R4jgC4IDXb8tYJhESZsIDFXLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ye+Hb/5G; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdb889222so7749605ad.3
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 06:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731679725; x=1732284525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YoKAbJCqo7qQrbAphdCyAKp6bujOtKlKbGWGDDJbWRA=;
        b=ye+Hb/5GHWLIhggbv59nQUe8sDEJFpqDS/poSYKi3afXi9F/zx22IkXyMpgmgB5DkT
         JZoa8tCQIbua/teceod3kr2zCBrINCTR09Am8s+grDCfc1dH5cRV4hzxs+sfVEx8kfqu
         v+FWPy1711MtySS3WPRI0Gf46meHTNsfPOJoE7lNG3UoQWaLBPvWuM2HBMCYXBJbmNlj
         pMstWp0vfV7NOf4nSPf+ZxYpUKxBQ6vGD4uhzZAOHkwszExurnCBHpqDOZQFx9aH1ef8
         J9QwfyfDetQIwV9UgGKSSc/b3hO/437qnC8+/caOPCtG0isBQrwkDpG89qNVv42w3O1v
         460w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679725; x=1732284525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YoKAbJCqo7qQrbAphdCyAKp6bujOtKlKbGWGDDJbWRA=;
        b=Ji7DYLo7qJpVg3U8NSFWSWSGpCJF6w8o7U1QhPT6aYoc7sNfkRs4uNE6mALB2vfYpT
         YnMzYUI5YfhSekkUdMdn7juGmq7Sowjz/H9MhJYog8DTEuCBj/1E+ZmHUuGKVuMTDuyf
         Y4Ero/YECykLyTCmLuWXOB7pIh4xYJpu0BYnG2JdSyMQgvJelP4B9zzeOd3p0Ro0efxr
         cT9/bt1k7ZO7LVnMG1B78iZgqCtJo6p/BzUonWsLMA1rr70YYI8YOI488YHsXbgR9mG6
         r4BSuIwKKl3ATGmo19J9x4Ixbz3OdUd//ydfOT590BWytwQz1arFyGWIfz8HgAjQg/5M
         4jOA==
X-Forwarded-Encrypted: i=1; AJvYcCX0jUxX1WDDiushtX1+1CoaETYKbVk1iMGGtEia6d3B27n3VMLsU4P0V6ltDw15Eft5hEJNxBLqLXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAB1nyakbSSxW3kw28yKCXWzqcBrR+PkLmwsaf12jfl4FByEi
	d2v+kSEJgQArF9vIjPDuovIJ7li2j7YAAA6oRyT1LzKv8DysBxYX8h8W8hWxOw==
X-Google-Smtp-Source: AGHT+IEqBDQQkEI9Z4A5hSXt4LEIhHr4FdA2+i1zXQxXIjMye1x3OLoASktaOIHTJpstuWkhM6cEBw==
X-Received: by 2002:a17:902:eccf:b0:20c:bda8:3a10 with SMTP id d9443c01a7336-211d0ecb145mr37222735ad.37.1731679725382;
        Fri, 15 Nov 2024 06:08:45 -0800 (PST)
Received: from thinkpad ([117.193.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc5c94sm12679055ad.17.2024.11.15.06.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:08:45 -0800 (PST)
Date: Fri, 15 Nov 2024 19:38:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
	andersson@kernel.org
Subject: Re: [PATCH v4 3/3] PCI: qcom: Update ICC and OPP values during link
 up event
Message-ID: <20241115140836.3wjfnlslozexd2ic@thinkpad>
References: <20241115-remove_wait1-v4-0-7e3412756e3d@quicinc.com>
 <20241115-remove_wait1-v4-3-7e3412756e3d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115-remove_wait1-v4-3-7e3412756e3d@quicinc.com>

On Fri, Nov 15, 2024 at 04:00:23PM +0530, Krishna chaitanya chundru wrote:
> As the wait for linkup is removed if there is a global IRQ support,
> there is no guarantee that the correct icc and opp votes are updated
> as part of probe.
> 
> And also global IRQ is being used as hotplug event in case link hasn't
> come up as part probe, link up IRQ is the correct place to update the
> ICC and OPP votes.
> 
> So, as part of the PCIe link up event, update ICC and OPP values.
> 

How about,

"The commit added the Link up based enumeration support failed to update the
ICC/OPP vote once link is up. Earlier, the update happens during probe and the
endpoints may or may not be enumerated at that time. So the ICC/OPP vote was not
guaranteed to be accurate. Now with the Link up based enumeration support, the
driver can request the accurate vote based on the PCIe link.

So call qcom_pcie_icc_opp_update() in qcom_pcie_global_irq_thread() after
enumerating the endpoints."

> Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

With above,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c39d1c55b50e..39f5c782e2c3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1558,6 +1558,8 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
>  		pci_lock_rescan_remove();
>  		pci_rescan_bus(pp->bridge->bus);
>  		pci_unlock_rescan_remove();
> +
> +		qcom_pcie_icc_opp_update(pcie);
>  	} else {
>  		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
>  			      status);
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

