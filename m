Return-Path: <linux-pci+bounces-2360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC770832A81
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 14:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B90C1F23E3E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7FA54654;
	Fri, 19 Jan 2024 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fB4wcuiH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4754657
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670830; cv=none; b=MOxKc4mZDxSOOG3nVNzlxmzTlVNxQKx1GSwe0Qw+rqIuvnhQ6z3vy/IxpnATMl3RsAnNpikg+P2ZoaDzNiGDld91tBr+uSlYDEK8K39XgFwg5QSofFUcSVAIrPwtDCdFTp8Y3kAiwZK20eRTyT6X05PdJqCMtruGMPdrHn1kIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670830; c=relaxed/simple;
	bh=tkNP5hdtLMLmdRU6kGCnnq1HZvK5vqTcSU7Mp+tbZQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8crBc7+U+R4kDdTStecWqmieWhGk+UWqkbHo++QHsmXRBO5I+LRh6zKAsAhrxIydO3mTyFj3jCFXw35IDImk/2ElsUFsybrSkMFRj+QOlAY3J4V5ITEOFiwbqq5dbiyUtz6T/Zw6H86HL+amdRdA7CggHM7qE53FnLkiTrymb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fB4wcuiH; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc22ae44595so805891276.1
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705670827; x=1706275627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=42jWvBuWK7I9LjSS4bPIwTmo8OJpE10eZpVzP5bii30=;
        b=fB4wcuiH7Epb9QP7/JxhvLWtjh4BnKG0d9lSuS2SuzmdrHq8EdhUtOiACwFldx/wkL
         sgdYMnSCDb6nK5din5kMrMloFFhf3M2P0kao1LPszPtGnb7JQYITE6s1ClX0yeCxkoO8
         rX0sXoyL8Ob55mahZIfsEghci39GEXOu7dHAnzqkTDxlbJASGcxXZoocWZJfQIhbOKcS
         teOciIwYXLwJYDpKAeJms/Wq0viDV+zASrJQpyTJ9oE5FUaxB29chXiuwFiID2NHjENK
         GOlN8QSGtASuQ/igNrTURDBEG1ReCaGWqDi5i1AQEmPh+3G/3G8ZWfIGRG2om1Jg3pYA
         2pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705670827; x=1706275627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42jWvBuWK7I9LjSS4bPIwTmo8OJpE10eZpVzP5bii30=;
        b=Cfc/IbAMfdiiHGgXfrxE/tzrJn0wvSyiciS4gT9E1Jn5G9wasG1bwGBCSARfDFdkwV
         CzCjK5PFcfmIYLlu9P3DNOT/VqeaPgiw1ZjNLdQ36IShIFWBkup20qQLRVnh2A7ksjAC
         f665Lha4ZNdH5GN3XZ+mgR8oOtc1zZMglWpvvbvyhRazCwHeGCxIG2Q3oUrT2I/vqreq
         1ctzByd2X+2lpBKttYuKqiG5WBHvB/HwbreyZXN2KQDhWKedFF/deuuUp+DuvDBcKMGF
         DhCYJRCjikVnZ+rMCAD1yImD08aM5o2Og9NbCqzVP2ScA58s7r1r8IK6mi/s3ED2+3rS
         Iyyg==
X-Gm-Message-State: AOJu0Yz8YVYaP/kx61x0HtW22HyvLhuek8yUTIqcPi4tp4KCi+VXH8WR
	wDo8D3gaz0aNAvVbnA4XBk4BTEbxOWfQf13ZcTHiGTZO7lFPa59biET6GjeVHMODKKrQ/flRGIe
	k744LYqD/52YXsyHdLes/bgi+H/0oK6x/HwOtrw==
X-Google-Smtp-Source: AGHT+IHcNZ3z0a6KFk4Azj3BQtD3k/0SlfNc1gxTnmWDbYZDfxsy/+8Zo5qiZ4T2sE8zVUc9JU70wOEc2pwAJXP0ECs=
X-Received: by 2002:a25:c583:0:b0:dc2:46d7:d8d5 with SMTP id
 v125-20020a25c583000000b00dc246d7d8d5mr1960765ybe.65.1705670827062; Fri, 19
 Jan 2024 05:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com> <1705669223-5655-3-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1705669223-5655-3-git-send-email-quic_msarkar@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 19 Jan 2024 15:26:56 +0200
Message-ID: <CAA8EJprWHiShFpZdb+pWsCoxNvNEoP+3By2x4u8rq+ek37hJXw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] dmaengine: dw-edma: Introduce helpers for getting
 the eDMA/HDMA max channel count
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: vkoul@kernel.org, jingoohan1@gmail.com, conor+dt@kernel.org, 
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, 
	robh+dt@kernel.org, quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com, quic_krichai@quicinc.com, 
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com, quic_schintav@quicinc.com, 
	quic_shijjose@quicinc.com, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 15:00, Mrinmay Sarkar <quic_msarkar@quicinc.com> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Add common helpers for getting the eDMA/HDMA max channel count.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c           | 18 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.c |  6 +++---
>  include/linux/dma/edma.h                     | 14 ++++++++++++++
>  3 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 7fe1c19..2bd6e43 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -902,6 +902,24 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>         return err;
>  }
>
> +static u32 dw_edma_get_max_ch(enum dw_edma_map_format mf, enum dw_edma_dir dir)
> +{
> +       if (mf == EDMA_MF_HDMA_NATIVE)
> +               return HDMA_MAX_NR_CH;

This will break unless patch 5 is applied. Please move the
corresponding definition to this path.

> +
> +       return dir == EDMA_DIR_WRITE ? EDMA_MAX_WR_CH : EDMA_MAX_RD_CH;
> +}
> +
> +u32 dw_edma_get_max_rd_ch(enum dw_edma_map_format mf)
> +{
> +       return dw_edma_get_max_ch(mf, EDMA_DIR_READ);
> +}
> +
> +u32 dw_edma_get_max_wr_ch(enum dw_edma_map_format mf)
> +{
> +       return dw_edma_get_max_ch(mf, EDMA_DIR_WRITE);
> +}
> +
>  int dw_edma_probe(struct dw_edma_chip *chip)
>  {
>         struct device *dev;


-- 
With best wishes
Dmitry

