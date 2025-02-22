Return-Path: <linux-pci+bounces-22114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DAEA40A8A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 18:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D591119C1E97
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853F7209F5E;
	Sat, 22 Feb 2025 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTgofo65"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053A1B2186
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740244223; cv=none; b=QqSIw44QRuVmTpTqwzGGQUQ4cZ9tIEoqsDM0oqR9jeMY5kS/AtYS6jAj9WwhFTs1Suu8kr2GCgM06EeJ/0x9zKWsYDHBpTfaxfJfVOiKlTFvc3tt1BZaK3t+xml3qBd9jlQWHsxm/K2Ui9glCIJHMBu4F3bsd277EdpDwoBHbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740244223; c=relaxed/simple;
	bh=cWYW0ZpGX/Nbffsw00KoYvYC6aJgH9Bw7+2lPXGU5zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxx9PZLX5q/8LzKzSoxa3CzGaZPtijDa5fBrpleSnUSgKwVue6S4LNfdTwgW3kJ0wSQxDfumAMcZu0UNU3M4mLAFIiYM0W9/t5fJwOrI7bhN2VeHXrTsV1wOih/YjaeGarVapkoOyrki8YLe095YGgTgub2U/6vZ71JFV22j+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bTgofo65; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220e6028214so68377765ad.0
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740244220; x=1740849020; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1g31xthEV+nGuhmo7YRAmVf5tNUriPCcKNo3msvWFH0=;
        b=bTgofo65YZ3qsltH1D7Gl+NHlK39Yos3ZPxZUw21omu+xUxZEyQdhCP1T/yx4uQYmV
         tsaprCJWrnCyptyz5h0MhGcs76a7mGlTkTp9ED29+Vu1+HbPruiFuQI3hK7E3baCFB8O
         Aba0JxAn7KLr4nWbjl1lRb2Uym16INxsA773oFd+YRQs1Tq6BWJ24Fw3wrQbq1Qyl5nG
         sIErZ6Thw6Z5PrR4651KuCW0jXSJtNB//byLuypoR5s+jHl2kMENy6SB5u/anPznz2pK
         8TaL0d01isvDVITaDVupNF/hJDHQbykY5useuk9Oanq25MzT9l2QMt6XmIWSGsmAi/33
         w/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740244220; x=1740849020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1g31xthEV+nGuhmo7YRAmVf5tNUriPCcKNo3msvWFH0=;
        b=AS8btfYfbrZyrZa5BonhangIbOr8XPmBaAG1HZoAcIXR9R3BUtj/SWOf6ptNNbZlPL
         kIAbHDk/n1iCqTHJ3ugHhhGL2cvzXKaWiiabM8cHQ+tstImH2ykK+uOTHFJle11iMDs7
         x9tc0387/HhZ7AKDdNp1CDfWwhxfdEjxah4H3UL4qMfYJsQb6qcM0sLmxfCq0rODkDMi
         tW/6P0EDjYFfkhFU9XUyQczZtCHFRRsWuYiWwKHjP6TsCUS+N5XTiZm5IRUjRUYW1KJ+
         E6K35GCAN0HQInq/6rC02pLXIZVzh+cTDrzhRlvgkL+HcwKS3u68+tGshF9k4xJgISCT
         XCjg==
X-Forwarded-Encrypted: i=1; AJvYcCXoM7z6GtOWV3w/3TBGCU7DaLNrlcSVfQvE+7R3T1dIDhL5WEdka+VDJVrJtqIITVAh13MHyKSpiig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUjfSFL71XZlOiAT51LSjXYrgFRiC55XsZYIJbVPuDUw75nK8j
	9Ed9Cm6D6n8y2NzSkDJyLzLRxBLiOMAQOsaUCb3TyVsXmD+NxuPs3O4LaKVTpg==
X-Gm-Gg: ASbGncv1DR+H5xJLjQLt8LFi1cqg1bqmE8Psho4rx7k92uiIZZKNug2U0/sGXI/EIyX
	41IkLDdHbv9CH6hXzoqKve1wy/xz8Xg02yMTjmqLW8wUgnF+X2HICTIUKvbDuaSPqobJbd9d1Qf
	LJSb8URwh8vLO2/ulEhAPDtusEHE0cj079GwBT+h55e9DBD9PJRYaXfUHKpkkTh+99BCLdjv5RJ
	esFgIhp7Znfpv3X6/E2EHC+g0GRHuX3zkBTBPvbHAsTyZoucOSdQ+e3SVvBVbSHxhmqiWUo/z/b
	cFUOWoRgSKKht9nCvTgpeYBhSUS3qiIS7pW9Sw==
X-Google-Smtp-Source: AGHT+IEaXUZ1YRv+QL5q+ndVg4ELkmtp0X4k5jVb8KUorHW8Co41xm1E+DRKm5Og3hEjzkjBQnx5FA==
X-Received: by 2002:a05:6a20:12c5:b0:1ee:e439:1929 with SMTP id adf61e73a8af0-1eef3d5a9d4mr14781431637.30.1740244220041;
        Sat, 22 Feb 2025 09:10:20 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325b1afd0esm15297089b3a.137.2025.02.22.09.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 09:10:19 -0800 (PST)
Date: Sat, 22 Feb 2025 22:40:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Slark Xiao <slark_xiao@163.com>, Qiang Yu <quic_qianyu@quicinc.com>,
	Mank Wang <mank.wang@netprisma.us>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] bus: mhi: host: pci_generic: Add supoprt for
 SA8775P target
Message-ID: <20250222171012.2zjqs2fbgiesek63@thinkpad>
References: <20241205065422.2515086-1-quic_msarkar@quicinc.com>
 <20241205065422.2515086-2-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205065422.2515086-2-quic_msarkar@quicinc.com>

On Thu, Dec 05, 2024 at 12:24:19PM +0530, Mrinmay Sarkar wrote:
> Add generic info for SA8775P target. SA8775P supports IP_SW
> usecase only. Hence use separate configuration to enable IP_SW
> channel.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 34 ++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 56ba4192c89c..b62a05e854e9 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -245,6 +245,19 @@ struct mhi_pci_dev_info {
>  		.channel = ch_num,		\
>  	}
>  
> +static const struct mhi_channel_config modem_qcom_v2_mhi_channels[] = {
> +	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 2048, 1),
> +	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 2048, 2),
> +};
> +
> +static struct mhi_event_config modem_qcom_v2_mhi_events[] = {
> +	/* first ring is control+data ring */
> +	MHI_EVENT_CONFIG_CTRL(0, 64),
> +	/* Software channels dedicated event ring */
> +	MHI_EVENT_CONFIG_SW_DATA(1, 64),
> +	MHI_EVENT_CONFIG_SW_DATA(2, 64),
> +};
> +
>  static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
>  	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
>  	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
> @@ -275,6 +288,15 @@ static struct mhi_event_config modem_qcom_v1_mhi_events[] = {
>  	MHI_EVENT_CONFIG_HW_DATA(5, 2048, 101)
>  };
>  
> +static const struct mhi_controller_config modem_qcom_v3_mhiv_config = {
> +	.max_channels = 128,
> +	.timeout_ms = 8000,
> +	.num_channels = ARRAY_SIZE(modem_qcom_v2_mhi_channels),
> +	.ch_cfg = modem_qcom_v2_mhi_channels,
> +	.num_events = ARRAY_SIZE(modem_qcom_v2_mhi_events),
> +	.event_cfg = modem_qcom_v2_mhi_events,
> +};
> +
>  static const struct mhi_controller_config modem_qcom_v2_mhiv_config = {
>  	.max_channels = 128,
>  	.timeout_ms = 8000,
> @@ -294,6 +316,16 @@ static const struct mhi_controller_config modem_qcom_v1_mhiv_config = {
>  	.event_cfg = modem_qcom_v1_mhi_events,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_qcom_sa8775p_info = {
> +	.name = "qcom-sa8775p",
> +	.edl_trigger = false,
> +	.config = &modem_qcom_v3_mhiv_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = false,
> +};
> +
>  static const struct mhi_pci_dev_info mhi_qcom_sdx75_info = {
>  	.name = "qcom-sdx75m",
>  	.fw = "qcom/sdx75m/xbl.elf",
> @@ -720,6 +752,8 @@ static const struct mhi_pci_dev_info mhi_netprisma_fcun69_info = {
>  
>  /* Keep the list sorted based on the PID. New VID should be added as the last entry */
>  static const struct pci_device_id mhi_pci_id_table[] = {
> +	{PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0116),
> +		.driver_data = (kernel_ulong_t) &mhi_qcom_sa8775p_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_QCOM, 0x010c),
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

