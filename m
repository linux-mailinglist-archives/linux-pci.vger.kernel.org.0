Return-Path: <linux-pci+bounces-23374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8100BA5A4E6
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72D8174FB7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C701DE899;
	Mon, 10 Mar 2025 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xH+OswmP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C071DA0E1
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638339; cv=none; b=q9yjH8uIaVbLGVVoKPFv0zW86Q2SPASU/8eFqy7E+1psfTlY7DadO6MCAi9YeQgTCM0bL39p5Dcz9R+dBIStBO5QNe8NIAQpy+pHcDhe2LRH5kn7XqdamYNvcPqIRUvtIz/lhMbcOBJBVWWtYK1thL1wthz3L4x6cLJI8rZs960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638339; c=relaxed/simple;
	bh=L9+uLSJLlnFoF8qnj42PdQx3Q5RYzcJ6a/f47QtrPHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVBnvx0xdWXK4Cl8q3ihzE2f8Qa01ZDc4kxvmSCkK1pYuUVzAYIxrm6L/qmgDu4gHqB23FRf5v6tOd3lDXmSFSKOxe+rQPvz2Ra3ZYaUOoGej4jljQ6JF9i6bX14DQMlkPrv6lb4QindvobpPIjAFiAi0iLxq+920ZJOxVBJkb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xH+OswmP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54298ec925bso6197018e87.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741638335; x=1742243135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYNmRZYB/IDO1RurR4i6iqDD/1mktBUeW4kgdxDpZIw=;
        b=xH+OswmP/CcgSiKX7NC5EIZKpFzqTMBvQKOua8bj2RCt/4KmiTK1Kj9rW64FBMSob6
         RS382yhw5sZlzayoKWCCuOXdNJa4Gz8HJWPX1U3Pu6xDDmOAR8pp5nYOpZb2/YbZAnVs
         crPuzbjdQRFMQ0eYUBe6G9YrnF18gMUtEOg1ex7ZoEGb8FK9lNWCiz4/dLijIU4UZr4/
         xwQO7Yj/ldfq3hxzF5TiSuhtAePwdWzvWo1WnBK6RB81VbCohnmN7E7ntYZ/QZrt5nfH
         hi7v4JHreheuI/szkNYb3NlbDXa1p0pXqM1GkzEmliccRQCsl05n5PyPQDXlgIkGzHjc
         doYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638335; x=1742243135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYNmRZYB/IDO1RurR4i6iqDD/1mktBUeW4kgdxDpZIw=;
        b=xHDWVbiEpb6zg++/yR2wbsEGHSRuQkROC39/AriZRyszzMiiNZPYB69Gi12kjP1ghW
         pKOCtWwzjkOlAXI8EKQ9xPaDwVphW4uzURnv/Nd4TWaM/+O7O71JUCoK1eK/rnakRPZZ
         2WQ3rU6uOjGU/qQ8y4qCq23oJZgZ6aDOS8ff6uzpC3//tdcax26+MNfu987lQCg2QqPQ
         ugsyR4VrQvwtQz3PrYLX8sQfHw8wSz6av18MSQ8VT+MYNSA1hybrFKAeIBKGiojrqEp8
         atDCUjnu3NqLhdSsLdLA/vxcf0egsWQAi3oJEWsrcfO3wwTW/c0tJhT9FOCd4uezj5Ki
         dZnA==
X-Forwarded-Encrypted: i=1; AJvYcCWHmLYkdhCfYKbGIiazaPP/hgeMHbL8/4WqoM6If+sSVsFs8+FVWFu8++eahoxAKKaAfEzVxltsAtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdry3Rvgg0AX2iw0KtfGUTDAbqDO/NKdYq2v0TDSP+mixnqtU+
	clBUivq2kfwlqLN6lRm+H7c55GSviAvhL2IFtiFiyi1pu96yzu7i8wwSC3DVM1Y=
X-Gm-Gg: ASbGncutW3nNUOmGh7f79QzAIuGW6M+EcawxX0u5ObzpqZo3ceX3/pD6PTwDBOp0agw
	Bo9zS1iNfK4/CLzws1+Klh/qbzeB6A0tnbjUUltFHrZ7ej4XJ1TQ86gE7BZZo7tnYtJtmTgNqfb
	U3QpqCRPnwarcz3b+hJc/8wFNGru+vxIrQflv3Q6cdP+7/Ew5Pb8gLhpVHQphTQb4vTcNNMZqR6
	LbwFmbhBpBCAzPnE4BTpPQi3JIqQ0SQkkQHzdNS8bT5RhE+ZTO9LHlB/DwetqJbY/UbvskpzWox
	i5lixj9G+wIYvl6xCAuqbYWR0F0S4huip5v5cAQ6NBP6szmRiusbTdZMjptVYc8xjUMm2Q51EaM
	dJQV+cdpqOih/XESZ0MJFKtxr
X-Google-Smtp-Source: AGHT+IEPVrqhzKdG85UY4VL7q1PeHiNjtgCxYCgNnkHHR37Br6Hv/tkjnMqe/JrlEqz3SvLMcEnR1A==
X-Received: by 2002:a05:6512:b84:b0:545:f1d:6f2c with SMTP id 2adb3069b0e04-54990e5d4c2mr4659162e87.18.1741638335156;
        Mon, 10 Mar 2025 13:25:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bcf77sm1556084e87.107.2025.03.10.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:25:33 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:25:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, quic_qianyu@quicinc.com, 
	quic_krichai@quicinc.com, johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] arm64: dts: qcom: qcs8300: enable pcie0 interface
Message-ID: <mxqrssteqfzp2llhp7exj7yoduv3h26qrxnsb7tobxkk7lxyeh@ywers6elgmwy>
References: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
 <20250310063103.3924525-7-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310063103.3924525-7-quic_ziyuzhan@quicinc.com>

On Mon, Mar 10, 2025 at 02:31:01PM +0800, Ziyue Zhang wrote:
> Add configurations in devicetree for PCIe0, board related gpios,
> PMIC regulators, etc.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 40 +++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

NIT: patch subject mentions qcs8300 (SoC), while the patch enables PCIe
on qcs8300-ride (board).

-- 
With best wishes
Dmitry

