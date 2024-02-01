Return-Path: <linux-pci+bounces-2920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AC68456AF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 12:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B704F1C23874
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916915D5B4;
	Thu,  1 Feb 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+uMA5M4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87784D9FF
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788751; cv=none; b=qayEBkAz5OfCf0V4l9r8KjhnKOGGt93ZbM2vcH/SIljpFxkOIQaQhw8yXMXtHosBXMukhtMVEFzE31JVNHHwrdQWPQwU9GQ90CXIXf05DMkE5yb3/EaeJiHuPHNRiYjERJDsaVIqhnxCMs1ztNFOJuQSD9cyK/q/JTCU0QLtWPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788751; c=relaxed/simple;
	bh=OZsGrszBeKUHNZmz0F4X8KtWFi79ZQpewOFt5i7n+i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxY97tph8pbX60rXesucqf8Tgf5CCAKEirZjfYk0+nJTVyLseWXrjde6t9CeyMMXdSfCpnMc+OOCYGJQqAoShHykZo+skwQ1+6gCkFgrYAWphhYkNmT1CgJrEYcE8FWVRejdI3btYuz3mMe3KNsdgok9TaJxPVwiVkbFcQ6g9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+uMA5M4; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-604123a7499so8760427b3.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Feb 2024 03:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706788749; x=1707393549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uKEpVLIoUGjy+WrPCxIEJ9ucHcFp2SdWWm/C9ZhEGXw=;
        b=P+uMA5M4o3L2jNoiqwhsOFlWKv3GoAstWZOqlqCaQU9iheeRNY98iEF3Fg6IQfRnmb
         QFJgbRqLj8JKpIPUzmk3xEbJYAe9m9/38tX8ekNqtmP+j1/EdfkgckwCLhsAk7Bpwmn/
         HpFOaTMSFprI3OdmbQHyiCTkGFvPi201Amhwbxa7ihMSTBLAq1toOofAm8jTuoM7Xjtf
         tWnrF8/S/wP8xrV/rNswadlcr39A01Z+P2pOXXf4LyeExix0FNfLLVhcRKhh2B5Acows
         645pL29Cjib3AQsGEoh6eD99G2GyjgmBcDnXQsOpsVz6hkjcmQMZBThDm2K1xeQqxxbV
         5HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706788749; x=1707393549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKEpVLIoUGjy+WrPCxIEJ9ucHcFp2SdWWm/C9ZhEGXw=;
        b=HuohXElI1hjlnuMoUg6Qcenk20+6Cv5NfmlnZ/0UShOk7aVo5y3FTtIdViaEXVHmjv
         ctKYkg4U/O6CFO3SttwlYJBM4wQCId4dbekEMhyRHV+bn7ns+J5hjUExzajtiWSld7rq
         AZm/dqLDzFkZqI+HN82wqJGUKRy1hddifM1h+/W49mY2ggi3RyI5Dn+3L29XtV253VWv
         lKHAJwKE+TylECyPsU3kGy9PtT/JQF87RFDM/OIyO2M+c11Eul/5IDRN+IoDq+iKMG29
         OQF+3qq60910gzbLCTr7JOnOfS6ai655Kb3dQsxgcyNEVMChs3ZM6LYYSzEUF6ZG7T7X
         eNpA==
X-Gm-Message-State: AOJu0YwLbTMojWbzBtA9TorNYeYO2HQ0ba7KZSU/ibZPATX1VHOcV20l
	umPRFQQgfcyyYXRwVZHR6YNWNMafhqVYedgbN2idr7DZ1biKUXXRlxtlZIFQDoJ24mswc3XHQAI
	C9uer85OhjFqy1McEGQuAJ/HlGZeZje3u2Wyuzg==
X-Google-Smtp-Source: AGHT+IG3BqsBlMIK+5jbWKOuxuJsDpvCPL0V2HadliqqQz05cdkoXtQw9qjR7RA5e7+YCNT2G6NA6p9yeYIqtzHeO/8=
X-Received: by 2002:a0d:db8a:0:b0:602:ab27:3752 with SMTP id
 d132-20020a0ddb8a000000b00602ab273752mr4465559ywe.33.1706788748906; Thu, 01
 Feb 2024 03:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-6-77bbf7d0cc37@quicinc.com> <CAA8EJpqwOfeS-QpLVvYGf0jmTVxiT02POwK+9tkN03Cr4DgL+g@mail.gmail.com>
 <da1945ce-7e34-6ad5-7b9b-478fcbd4a2c6@quicinc.com> <CAA8EJpoZakDcBXYE57bRPMFvGEXh1o82r7Znv8mwCK6mRf5xog@mail.gmail.com>
 <20240201115415.GA2934@thinkpad>
In-Reply-To: <20240201115415.GA2934@thinkpad>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 1 Feb 2024 13:58:58 +0200
Message-ID: <CAA8EJppAL44ZLL5SnmX7SSwzvRUm2PffFUL6=gQRjq4neaLtRA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org, vireshk@kernel.org, 
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com, 
	quic_nitegupt@quicinc.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 13:54, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Tue, Jan 16, 2024 at 11:55:17AM +0200, Dmitry Baryshkov wrote:
> > On Tue, 16 Jan 2024 at 07:17, Krishna Chaitanya Chundru
> > <quic_krichai@quicinc.com> wrote:
> > >
> > >
> > >
> > > On 1/12/2024 9:03 PM, Dmitry Baryshkov wrote:
> > > > On Fri, 12 Jan 2024 at 16:25, Krishna chaitanya chundru
> > > > <quic_krichai@quicinc.com> wrote:
> > > >>
> > > >> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> > > >> maintains hardware state of a regulator by performing max aggregation of
> > > >> the requests made by all of the processors.
> > > >>
> > > >> PCIe controller can operate on different RPMh performance state of power
> > > >> domain based up on the speed of the link. And this performance state varies
> > > >> from target to target.
> > > >>
> > > >> It is manadate to scale the performance state based up on the PCIe speed
> > > >> link operates so that SoC can run under optimum power conditions.
> > > >>
> > > >> Add Operating Performance Points(OPP) support to vote for RPMh state based
> > > >> upon GEN speed link is operating.
> > > >>
> > > >> OPP can handle ICC bw voting also, so move icc bw voting through opp
> > > >> framework if opp entries are present.
> > > >>
> > > >> In PCIe certain gen speeds like GEN1x2 & GEN2X1 or GEN3x2 & GEN4x1 use
> > > >> same icc bw and has frequency, so use frequency based search to reduce
> > > >> number of entries in the opp table.
> > > >>
> > > >> Don't initialize icc if opp is supported.
> > > >>
> > > >> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > >> ---
> > > >>   drivers/pci/controller/dwc/pcie-qcom.c | 83 ++++++++++++++++++++++++++++------
> > > >>   1 file changed, 70 insertions(+), 13 deletions(-)
> > > >>
> > > >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > >> index 035953f0b6d8..31512dc9d6ff 100644
> > > >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>
> [...]
>
> > > >>   static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
> > > >> @@ -1471,8 +1502,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
> > > >>   static int qcom_pcie_probe(struct platform_device *pdev)
> > > >>   {
> > > >>          const struct qcom_pcie_cfg *pcie_cfg;
> > > >> +       unsigned long max_freq = INT_MAX;
> > > >>          struct device *dev = &pdev->dev;
> > > >>          struct qcom_pcie *pcie;
> > > >> +       struct dev_pm_opp *opp;
> > > >>          struct dw_pcie_rp *pp;
> > > >>          struct resource *res;
> > > >>          struct dw_pcie *pci;
> > > >> @@ -1539,9 +1572,33 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > > >>                  goto err_pm_runtime_put;
> > > >>          }
> > > >>
> > > >> -       ret = qcom_pcie_icc_init(pcie);
> > > >> -       if (ret)
> > > >> +        /* OPP table is optional */
> > > >> +       ret = devm_pm_opp_of_add_table(dev);
> > > >> +       if (ret && ret != -ENODEV) {
> > > >> +               dev_err_probe(dev, ret, "Failed to add OPP table\n");
> > > >>                  goto err_pm_runtime_put;
> > > >> +       }
> > > >
> > > > Can we initialise the table from the driver if it is not found? This
> > > > will help us by having the common code later on.
> > > >
> > > we already icc voting if there is no opp table present in the dts.
> >
> > Yes. So later we have two different code paths: one for the OPP table
> > being present and another one for the absent OPP table. My suggestion
> > is to initialise minimal OPP table by hand and then have a common code
> > path in qcom_pcie_icc_update().
> >
>
> Are you suggesting to duplicate DT in the driver?

As a fallback for the cases when there is no OPP table in the driver
it might make sense. See
Otherwise the DT is still somewhat duplicated in the form of calling
icc functions directly.

-- 
With best wishes
Dmitry

