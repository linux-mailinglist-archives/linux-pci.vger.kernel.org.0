Return-Path: <linux-pci+bounces-2359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A5832A47
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 14:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268FF1F237D2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F5E52F89;
	Fri, 19 Jan 2024 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yzvr7X+g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0710524D6
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670630; cv=none; b=QGN5QRnHfsX3MYRzevw4klKiZ77JVhVvrm48G0fSFx725zKuvd83OcVZNiiZLgfBFdaFtofQsTUsLZhSngiYHM0HiimnJdFhOK9KM8iSp8LUm8w2xErRsU1LJ5d111W5/Cr9T9Xo2okVJDjSWk8gliI3d2WFMcMI9kuzlbu1Rg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670630; c=relaxed/simple;
	bh=jT1o+1fCLAVLwXFrrOA+eYd/Esf8c1zGpOV8XzCPnlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1goJUsAuVKadKYxiJ3xpDT1d/IHjGMUAVtXQhwLVedkxIuQRZFgqdD6loRtpqSMaRZLex6dJdn9RzxxXSSouhEc2LE6/QQox4EkacFhJY4wqsXHSNT/Y4Dbgw3YTkymubIqE2OQzkqFLOouRNznDbxfvDgdnO3kTD0vMM0z5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yzvr7X+g; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ed10316e22so6990487b3.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 05:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705670628; x=1706275428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wYjGRonmxWAwRkUotTTDya9Rp8c+PP7p+UBBXWqIeDY=;
        b=Yzvr7X+gzsaQt9WOshGLunenjwLi1VQ2s/1CkR2RBXeVqZXp6H5sdL+3uDxLWRfj2i
         pUt/pbuUd2DuYnb77zQgPK/SVSgSXvmIXVa94dUthGBSvbfn8jRpPTWc9AdTjtuE7nU5
         14UaDJ72vhi3DtbNIz+nEoP6UmUGWxkU/xZjf9scqSvm5BYLOcNDsfn5hRR42/DXjuYs
         aWTxSD9LLMijZeguOQS/uxdI0sBcrblgvTjKMRyTSSJnnz1SB7k/6xPxWgArXe6RCxIw
         lIrStHwNH9aISdRT88bVnt87zYD605qrPwkNAg+ruKExWvp1u7nFAPWYE+en/FZRk6NL
         jf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705670628; x=1706275428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYjGRonmxWAwRkUotTTDya9Rp8c+PP7p+UBBXWqIeDY=;
        b=UFzP2u9fVXKgLMZiJRqEgnQ3Bi3Pszl2NvkuZcGqN2AJ1it7OEwPkUlwP/Eklazi+C
         qO4dPlpAmrAlipxDmfC2NfSHD/9LdFOM6TGj7lJjqo2Id+0fGEOV2dhFMCF+96pXiUQ3
         gW0dv/QGIxeOnk+aYjR/HnXe8z8VIrT1Am89ooVa1T4nTzVScb8HQiq7//BsoBenhBoT
         ofw5wxYchheTHe49GpzGl9pnvOEzbC44L6BDR3Z8dZlznilJWCRaq4iMzSyCS4ucdhTu
         clZiAJ9khqPRaG73bv0nwzDMn4nGq0hHagcKV+NKFLK+SyaluL6/cTpQ+FLmCws8CUaP
         Gfpg==
X-Gm-Message-State: AOJu0Ywq5vdFP3RRPkoghjbjy6E6RqNIpT9HFecN7dzANEsPelIrekIe
	D0riR4VOxxxuHOM6yFWVdYV0EUCx6NMwM3sCymffEHjbmgSZZPd7w1h1ZXPEnj+0nWPJX9+4qgV
	PgPyT+wGsiGJxhNrPEeBH8CloL4RPOa5G1l4f8w==
X-Google-Smtp-Source: AGHT+IE24O4oHX+Znek8EKmxAo69mROS6r2o4oW+offeuwEJNv5nK9E27XqRcTnwBG8RF9BP82f09XLq4Sz7Hw8ZCgs=
X-Received: by 2002:a81:6d10:0:b0:5ee:66b0:5960 with SMTP id
 i16-20020a816d10000000b005ee66b05960mr2136607ywc.10.1705670627269; Fri, 19
 Jan 2024 05:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com> <1705669223-5655-2-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1705669223-5655-2-git-send-email-quic_msarkar@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 19 Jan 2024 15:23:36 +0200
Message-ID: <CAA8EJprFo+ujC2VqEtxbrEn_Dn23qfQAcc6WtMm4JWquth=Xgw@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] dmaengine: dw-edma: Pass 'struct dw_edma_chip' to irq_vector()
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
> eDMA client drivers defining the irq_vector() callback need to access the
> members of dw_edma_chip structure. So let's pass that pointer instead.

Nit: 'will need'. They do not need to do that at this point, but will
need it at the next commit. I'd rephrase it to something like 'In
preparation to ...'

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c           | 11 +++++------
>  drivers/dma/dw-edma/dw-edma-pcie.c           |  4 ++--
>  drivers/pci/controller/dwc/pcie-designware.c |  4 ++--
>  include/linux/dma/edma.h                     |  3 ++-
>  4 files changed, 11 insertions(+), 11 deletions(-)

-- 
With best wishes
Dmitry

