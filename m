Return-Path: <linux-pci+bounces-12628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75926968D81
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBBD1F23FA4
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 18:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09E71C62B3;
	Mon,  2 Sep 2024 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4IeYJjb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91019CC04
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301966; cv=none; b=hKP7+0bs1yzZq1yT/cgQaOw8fsielbk6Au7aHQ1J6iy7Q5mMxOZ2K41mnvWFy3miJFvtvdUz3UBfqljsTKvZngImoZfs/XhTlwOpgCRbcaQoLwYKnuly5OwqNTU/IPRiBdDGoM/UsvuUEKZAdIRn9rbgvbfAS0SkFhO4ula/ct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301966; c=relaxed/simple;
	bh=2bhsdKcMRpmC7lcu20iYO4nQImhTbdGjiKkJUnNLMrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bb+jtVMKdKp7gaHD0/doRfk//Ce0O8zPrWl2rLMuox4CbqrAyXSRCNK14fQeSztdGnGIJqbqS3Upi8yhK/SkGm+5LrSlU0JRyp9HM9FO9WGGuipVpqPaySPDNhVruPa5x8wwIQMJIeEHyMf576S2x+pNIUtqAkwBrGdrBADx6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y4IeYJjb; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so50740621fa.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2024 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725301963; x=1725906763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAmaK13K/WB/CMiEFbhMPPJZl/VZU34ltwhJvlIpIAU=;
        b=Y4IeYJjbuHeMQ0FEBlIO/oYqGuMOqtbwhg7qHZs/Mhu4bp+JDajDk1qrWRFHd+d8Xk
         5wz3+WKB7Rkn9i0dpkwbihzx7NZjG2kOYmwU3TnyqvxHZBQAiIpy9okCT/KEV1BuButP
         dRXBnboakEp5AcQhT+O/VAK2fARmpSW4VchUfRlmsNeAXhtt/jTOP6t/EJ80CN3ilfrP
         rjaUVz+gm6dTguoFc8kuZCu5HpoJV8rBhczJaMwD5K+oLQLlWD1ETLQaSua6xVPbJdNO
         LSQ4VZ+jr/cAYj1eqc2QcJV4AKals+RCoK0E1v17JIIQfh57NvYD0CFKNcSUjbuIlqpj
         o8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725301963; x=1725906763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAmaK13K/WB/CMiEFbhMPPJZl/VZU34ltwhJvlIpIAU=;
        b=fVSI4IL5P6Lt0SnwtxKFmAB3wCiXl09Kd1k4lLQOG2KpBel4Zkx4SaPfS4bn58mnG2
         BtxZ/UBcyv9MAR0/QE7qGiyArQM4waFpz+TEDVMoPpkncp5RduMg2nr1pmYlBQmYHWgc
         S23zJMEEJi85JPn3haPOtdKuIz8FllS/unhyzaZZdTz09P30IsiArJy9Cw/tOO3j4aH/
         MXAX1z5flP6MiwNTqc5zf+CbHVPnzW7wrZU8C6gD+vXeut56U/WV85/5UTjS2634KBsU
         kOJZ9wYVLTkNropxkC22DwjPC+JNFsUwLZe1SGqgOyzJzjlbxN9UFBVq/Dy13JA781ys
         CtUw==
X-Forwarded-Encrypted: i=1; AJvYcCVXgKm5rH3dAMjg3fRSrxaIRH1feyXKlpobrgAMulB/bKUtfXP9lyJlGFFEPb9DASvjPl7g1Pmo03g=@vger.kernel.org
X-Gm-Message-State: AOJu0YydNy/wOEUWIMw+JpinoElJkySM3C7VTxznDLG79GVOoXVQjIbx
	NHePrmso93SZIVWGlDPQ3Bgm92GH7sKu8XpekI3z8cEL498FC01Qtg/F3QtQKAE=
X-Google-Smtp-Source: AGHT+IFoxXqWCv/ngb9lgpMsTD9vhJJKzXGkPrdhSMLDmCQIQH9tyjM0XY+PSycHN7Ixop/BuNjPWw==
X-Received: by 2002:a05:651c:1548:b0:2ef:2d3a:e70a with SMTP id 38308e7fff4ca-2f636a1372amr28845121fa.18.1725301962343;
        Mon, 02 Sep 2024 11:32:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f3396esm19546081fa.54.2024.09.02.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:32:41 -0700 (PDT)
Date: Mon, 2 Sep 2024 21:32:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, andersson@kernel.org, quic_vbadigan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 7/8] PCI: qcom: Add support for host_stop_link() &
 host_start_link()
Message-ID: <ar63lbc5nl6jujeadd4srfd2dacsjk7la5kzma24bi2cqb7awj@vfawrbnr7an4>
References: <20240806191203.GA73014@bhelgaas>
 <9c37c36d-1091-5d5e-58d4-4a20bda65244@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c37c36d-1091-5d5e-58d4-4a20bda65244@quicinc.com>

On Mon, Sep 02, 2024 at 12:21:22PM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 8/7/2024 12:42 AM, Bjorn Helgaas wrote:
> > On Sat, Aug 03, 2024 at 08:52:53AM +0530, Krishna chaitanya chundru wrote:
> > > For the switches like QPS615 which needs to configure it before
> > > the PCIe link is established.
> > > 
> > > if the link is not up assert the PERST# and disable LTSSM bit so
> > > that PCIe controller will not participate in the link training
> > > as part of host_stop_link().
> > > 
> > > De-assert the PERST# and enable LTSSM bit back in host_start_link().
> > > 
> > > Introduce ltssm_disable function op to stop the link training.
> > 
> > pcie-qcom.c is a driver for a PCIe host controller.  Apparently QPS615
> > is a switch in a hierarchy that could be below any PCIe host
> > controller, so I'm missing the connection with pcie-qcom.c.
> > 
> > Does this fix a problem that only occurs with pcie-qcom.c?  What
> > happens if you put a QPS615 below some other controller?
> > 
> Hi Bjorn,
> 
> The qps615 is the qualcomm in-house PCIe switch it is not available to
> others. so we are trying to add for qualcomm soc's only.

Any guarantee that the status quo will stay so in future? Or that it
won't appear on Qualcomm platform with the virtualized PCIe controller?

-- 
With best wishes
Dmitry

