Return-Path: <linux-pci+bounces-2724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 375178408A7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 15:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA181F21F8F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827331534E5;
	Mon, 29 Jan 2024 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGak3gxO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742F152E17
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706538995; cv=none; b=BTyqo5DUfYQL5fq4wRx0nm4PbJfuUjrTCpKO2Mdrs/ouw9d9C2bF6qXrxvtXtD6hh237DuRk8WjfvaiL2IgHDcsj1HDV5JH3ZxsajarSkzVhJ8rmPWx0Oa2AODtYOuvfAOf5zq0uxP27awBHW9JEjeVnmZT4lS2wTSt8wFRHh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706538995; c=relaxed/simple;
	bh=mQz79aQlYRR6nrY8Z1ZbdTEyN+L9YfuNpdQ1leoB84U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCjFee9RgyqUUdj/F3pfzb9vY9Q0rkMJCGtwqadBK3tb6vAAtV0ChQvj9sHYgLAWrf3aNoLya5Rdu24+bRb91N1FrDdhY6LDXJ2CdPXq9Z7l9EvajGQgxPfTkDujaoNmbFhkKnnLaToIbURzlW9PEloG0FRtJefgMzeSsTnAsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGak3gxO; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so313501766b.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706538991; x=1707143791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dybJHVElyPmYmx4bcLz0bdWXp1ScZmWQPVLksWb3RYs=;
        b=EGak3gxO3UYw4xCexNMpngBtEgh1f/MVVcOdHPJ6XDtQmEPaY/rbZZ/hf9j3Cfw2WZ
         JP8dGx2O7WRgO9mY+e+3qtyFzb5RWhUVOl0S1u42fUCe2ziXgkvFKbhG4LBKnZJ0OzG/
         PFOF6tVOX2AEmkcdT3rYZqyWd0zSY//+Wv/Y3OAPfSGhaK4QljY39meJYIpx5PQawaHp
         7dBRhfun4guhC5q0sd86BRcGFbinHxY3OM1qYiHBENETNN2xzTtT6F+9ElH9z/xYaz+E
         jca34h1EKVNacvJ3s5Zg/haLPVuCDEgw85MAEZiCQlEPTkfIJ+hlPYqybBTDtCv1BCky
         HORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706538991; x=1707143791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dybJHVElyPmYmx4bcLz0bdWXp1ScZmWQPVLksWb3RYs=;
        b=Mn/TIdAFPzVuNpsvfxvCabC/FbG1jUiN9WVpxTnvwJa6l2iZlC+FP6cmGsU/+aiUsh
         9G7ETW+92uMzw/pk5MrP7y/3KCG9xz1OmzutIfM8OgMRMExIn15uRZ1tEuEPb+uR8QI/
         p3FvGT8t9Nb4Btqh/MEYBXI2T5/0iSJugas7IF3mj7MQ5g5Ah6hX6DRB8aYzArggFaLU
         TGev/+htQLzXVcgbtmbTxIUa/JgcAeFgYviKZ3vdz/SkIQJJMpe/K+PgvCiWOzAuAXLi
         lfLN4bGnYkT8WLJ4qZbnuy5743hJjXOdFRNnuvBWfSyyY/pETAbehYaVUISyuJWgB+LE
         R3KQ==
X-Gm-Message-State: AOJu0YxvmRRhsAAnrmEsC8SsFMf2dA/J1I05o1yfkPaUP3uZaJliRe3E
	7HpKRSwLzhvCWWLB4Mfz4hWeGryEzpIhTJrl2pshT/g0ndSqgWP8qP6bvl6pO7s=
X-Google-Smtp-Source: AGHT+IG06zxGFooOARP8WyUROQtl40mgpcuuSrve+Nx55DSoyQP/qoT2UYg2hAS6K5e2DP0BfjW90g==
X-Received: by 2002:a17:906:b805:b0:a35:e525:b265 with SMTP id dv5-20020a170906b80500b00a35e525b265mr1091147ejb.41.1706538991382;
        Mon, 29 Jan 2024 06:36:31 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id vb5-20020a170907d04500b00a351d62309esm3325380ejc.39.2024.01.29.06.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 06:36:30 -0800 (PST)
Date: Mon, 29 Jan 2024 16:36:29 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: Document the X1E80100
 PCIe Controller
Message-ID: <Zbe37Rr8LRNxEurs@linaro.org>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
 <20240129-x1e80100-pci-v2-1-a466d10685b6@linaro.org>
 <3aa071cc-32f2-4228-bd32-6dc2375a4c2c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa071cc-32f2-4228-bd32-6dc2375a4c2c@kernel.org>

On 24-01-29 15:19:46, Krzysztof Kozlowski wrote:
> On 29/01/2024 12:10, Abel Vesa wrote:
> > Document the PCIe Controllers on the X1E80100 platform. They are similar
> > to the ones found on SM8550, but they don't have SF QTB clock.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts_getmaintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, use mainline), work on fork of kernel (don't, use
> mainline) or you ignore some maintainers (really don't). Just use b4 and
> all the problems go away.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.

Oups, forgot to run "b4 prep --auto-to-cc" after I added the bindings
patch.

Sorry about that. Will resend v2.

> 
> Please kindly resend and include all necessary To/Cc entries.
> 
> 
> Best regards,
> Krzysztof
> 

