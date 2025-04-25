Return-Path: <linux-pci+bounces-26768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0623A9CDC7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 18:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10564A0C6D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912FA148830;
	Fri, 25 Apr 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yx33lm1a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAD14F9EB
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597255; cv=none; b=udr/BKgm9EdHNMeXKTZuXDgT3X40PzYniPLrT+KoO7pdh1VotQhmRqZPsAp1WL2v21NVURgPmDLO1vMTpLTjlrOPJUzXGKlsFmvCpqwBBnZbJsAKP1k9nuZQyAwArFLcvBlROZjGJF1islBK5KXuQQcPMFcyF/1DQMpBs15DihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597255; c=relaxed/simple;
	bh=WZaOdc1wZPK/4EneNSUdAaK7q9TWH49BP3VyKo6ZwAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhFP0MmN/Pp21x1anb6GpjLRl0v29Id6MkYvd14UxLXLUKhsQ/oST5kaueCPkwU4GOA7JPS7QQN9LoHDLE7oEMiCjm3nUTY2VLLzgTZIJnIh7Y4EW73h8o2+78iHamBjTgkFaZuYTPYxRf98321HJuvFShyRaJ9BLTI6APwWHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yx33lm1a; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-227c7e57da2so21687485ad.0
        for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 09:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745597253; x=1746202053; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ma+iGpUn/AKMVwLZapT0W95tZe34aNE+r6szCxKHl2g=;
        b=Yx33lm1aI5IbDKpBUpJeIh+x2DnQoN7pah6x4C+Hfr/k4pS9xBgOl8MknKaVbziTVU
         qgXKSRMUijIeiGxw53ncGtJqZgox53RYArm1SATtoygYroRhcP2ZA3AyJ9JZBL1yw9w9
         TLIZvausDBtEDhro8l44ZXqSSH21mq0dG/0ojz/uUPpeo8q+MYCy37HPQz97afBZOvXs
         MtqQUju7JIlctQbrOqVw9pf7RzWBjw4LSLxD2JoILT8AOFcsmSgefMq4HanQeoE47gqb
         YRDVT7FktzR4k/ViinwQJKK4YZ+EHF/G/Hd8RKz6b3NQDLp623QFJzyRL8Tu1RDsAVu+
         3Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745597253; x=1746202053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ma+iGpUn/AKMVwLZapT0W95tZe34aNE+r6szCxKHl2g=;
        b=ebX8OWWXM634dKRn2rEO2yJxgOba6ewL+H5rxCyE8YYO1ifKqieV6lFtcv1OA3KP63
         Ixe2VU96AR3KwCE27Y6BQQWvaxarH8UkwuQa8U+qqaFmBi20gvYakVQazx4faGvIrGAP
         1yh9P4C3PomCoHuJhl/CqEbE0RNpR26kX/bIUpdcp7wN9a2hdeCDhqVLeEAgsiScSTB9
         gfRzw/jTsK5IU+eGvTHlsHjZEH2MQnmjSSpZ+YUbgFhwav1ormtaVlPXD/jL/ObKBghv
         yVpLezefzljiHZJCGjQxtbTk01iZQa3LQS5tuFDmHzhqvDcG4NNncqNNtt68X3IZIMJI
         WY1w==
X-Forwarded-Encrypted: i=1; AJvYcCVrCcJeCbIBN23LbrIih6ibNHJp26qqEPXFWuDRJda8VMsBsWB0ZMsdhIHZIMD5tb+qKyCMS2BevbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywnyAYjo+gn4AYQLYttgewaKMW3crbdY7rGvUjbi+wUEyc66hY
	oSyyb14z25JKMz1Y+w2YQw7AhucY858B3lil0AhGNP2FDJXYSpPBZ6ih77UNVQ==
X-Gm-Gg: ASbGnctgmF/cC4e0Ys2om3niogg4ODwg3ifMkn2g4UJ+z2YNct1P9XWXpPlbJkuZdyf
	+9MbfmR3uSgKJSmHzqf9+PwGObnzQaUDWnUPMJ1ixXHiheplauOMLmZJ9hl4N0U2vdC5YcyFwwX
	2Jqh8seN7ei5xUZMSfYnzYciYdkeztjLGPrpl0rC87aAfoUfbOKieya35YbuaxIe7H7EeHMWFNz
	k8OIFX7Qew0GWoHvk/bFoCXmZeyvowe0IHR7HXNwC8FI1hZ9kvK1N3++r2QfL/ZZ4N/BoBMm/cM
	7hTpc6+12aRCEFuDQXBBZA2NrUhs/IJfHWiqtj3jSoWDMfMmQstz
X-Google-Smtp-Source: AGHT+IGHuaRxdPoXNwRTHc78Guuv44yqP3/H83BEy2uFRv1C3A22TKg1MCU7FGgOqFZzBgCQSRzorg==
X-Received: by 2002:a17:902:d2ce:b0:229:1717:882a with SMTP id d9443c01a7336-22dc69efaeemr2288965ad.4.1745597253205;
        Fri, 25 Apr 2025 09:07:33 -0700 (PDT)
Received: from thinkpad ([120.56.201.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15faee2091sm3098381a12.75.2025.04.25.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:07:32 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:37:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v2 05/10] PCI: qcom: Add support for PCIe bus bw scaling
Message-ID: <ammo5uyd65xyr2gexp6kgkyout2hezrlqqb7l77dix52wbtehl@ezw2ntaabjug>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
 <20250313-mhi_bw_up-v2-5-869ca32170bf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-mhi_bw_up-v2-5-869ca32170bf@oss.qualcomm.com>

On Thu, Mar 13, 2025 at 05:10:12PM +0530, Krishna Chaitanya Chundru wrote:
> QCOM PCIe controllers need to disable ASPM before initiating link
> re-train. So as part of pre_bw_scale() disable ASPM and as part of
> post_scale_bus_bw() enable ASPM back.
> 
> Update ICC & OPP votes based on the requested speed so that RPMh votes
> get updated based on the speed.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b66c413f1e2b..a68e62422ff7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1328,10 +1328,59 @@ static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
>  	return ret;
>  }
>  
> +static int qcom_pcie_scale_bw(struct dw_pcie_rp *pp, int speed)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u32 offset, status, width;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	return qcom_pcie_set_icc_opp(pcie, speed, width);
> +}
> +
> +static int qcom_pcie_enable_disable_aspm(struct pci_dev *pdev, void *userdata)

qcom_pcie_enable_aspm() since the opaque argument is serving as a boolean.

> +{
> +	bool *enable = userdata;
> +
> +	/*
> +	 * QCOM controllers doesn't support link re-train with ASPM enabled.
> +	 * Disable ASPM as part of pre_bus_bw() and enable them back as
> +	 * part of post_bus_bw().
> +	 */
> +	if (*enable)
> +		pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> +	else
> +		pci_disable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_host_post_scale_bus_bw(struct dw_pcie_rp *pp, int current_speed)
> +{
> +	bool enable = true;
> +
> +	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_disable_aspm, &enable);

We do not enable ASPM on all platforms. So this is going to affect all platforms
whose client drivers initiate link retrain.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

