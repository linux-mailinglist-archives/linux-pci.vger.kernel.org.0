Return-Path: <linux-pci+bounces-12629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1BA968D94
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEA9B21233
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410D1A3058;
	Mon,  2 Sep 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ywru1nI2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707519CC31
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302259; cv=none; b=WjDjchoupUs5oLA8Z+ajCmbmb64YqMHSkIekQrT8EACZbY8amIebYyrVAMjYC4uQzaWrFQD6k00QU2y7iQPfJAU3JlSMkEd+zu39ibD0ccxOmp9/umuric0DlF+c7GysX5z+ij50tRzaSN+iFMM+A+27buIKYGKi2WIkjv3vMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302259; c=relaxed/simple;
	bh=Dsp38Cct5JZb9A32kTk2lYSZBszkKftdSXzYWR0muKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohvJfozsb8FmB87kLo18OqHszGToLfCfkdMOcbZuxZQGbD6kaQc1vWf5D3TK9YHZhILZVB0FPDVN4+L1lAnpbYAN+HD1yp373GkKTGEjW99qTy8AcZ4bkS0EPujYK558vy8am39xrW/wZ1MVn1fVmkmQzdPykmYLKvZ1cvzQl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ywru1nI2; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f4f505118fso51763001fa.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2024 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725302255; x=1725907055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xKEu2s7Z+1VCI7BapxbaueK4cWY4QKnmPl75pBw1i0=;
        b=Ywru1nI2frm2poyLr3qCv5fvMNCicdwo/lQgLNJ7dx2AscOMQpbYzpyxrEG1/M3wQ7
         4eLCgaBp7/19AG//ntITFDoOkXKf2OUOK8sWBEVrnpFVDUM2gllkmwpfJ+U+OB7bT5NA
         C0oPjNfdyhbj0GPa26zW6CEOgpBJQoLZrWrfhlZEfp/GdU8nrNk1aIjXSym5SRzjlWLK
         5acOLHpulzDAOVq+tG8suHyZfBAWcfZcyF0EkLen9pgKNiWIQ1XfFnOm8swwMBJ7swXo
         NO+8t88rOECZKhpIDCInUMfUmz3Qj8f76tpia7Rt12m+dQ3Id97GDOG9vftlgs/OJszS
         xCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302255; x=1725907055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xKEu2s7Z+1VCI7BapxbaueK4cWY4QKnmPl75pBw1i0=;
        b=VlzWRXVOk1OVkkgtHIrkyYbGznPvIiLFfnFZRuLw2RPEBVth75XkHKojwd5b2VqKiZ
         Tt9UNS6Wfcr1hv9Jpc9JhpHbibAqYqblRjl1e9K5pzMB/1jW2Yox0Sy7yiDYkc7Hhbpm
         MrK+KXuhgo+PC/qN26F8FHiEP2abaPzAcJIn91yF79NQB/j/iaAh1wkDQR5gpG1gm/Yj
         WRwE7rZa1Bm3oJWe6sqrjZbcTKpyjT5wL9gXIq+7BepUGuIc4FdLwkxi89b2pR+srJUh
         E5zafVvtZAemSoHYka1YvvRjwyPHs9AcTTYFFtVbOjQTNXIeh5nDkhOMe1Kmp51F8O/l
         dbKg==
X-Forwarded-Encrypted: i=1; AJvYcCXMJQUYJ8ue5o25dTsXtQv4oR4xziODK1/PBpHfdMC27ZqYwaGLYr5XdssPxJ3RIUcdGUTjsdnXjFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ZjmDAF+FsECPeoAyVFl3QtvkU89OVEafs9voDGpsT4lEzZQm
	awJO6ISRZk8wYxK5/XlwqmwmXy3vyyvQNhvmTCFs1oLdqLfkYCgMQrO25wS3pyI=
X-Google-Smtp-Source: AGHT+IF0GVR8WQmeR/FywLPUVQFKKPZxgl2SZGvXNjKPVZ/5LIp2Fqkzh4Q8z+PwYOgfLfbdADqzyQ==
X-Received: by 2002:a05:6512:3089:b0:52c:8abe:51fb with SMTP id 2adb3069b0e04-53546af36dbmr7817271e87.10.1725302253942;
        Mon, 02 Sep 2024 11:37:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540827aecsm1712832e87.174.2024.09.02.11.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:37:33 -0700 (PDT)
Date: Mon, 2 Sep 2024 21:37:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	cros-qcom-dts-watchers@chromium.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	andersson@kernel.org, quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 8/8] PCI: pwrctl: Add power control driver for qps615
Message-ID: <w547dmmxqqa4atd62jqiqcfzhlnpjc7n64btjmre5pmbsci4br@w45tuny3mcmn>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-8-9560b7c71369@quicinc.com>
 <spaudnuoam3cj7glxmnlw7y3m46d2vsm42s576jqwrcrmywl2n@oyrynorzhddg>
 <872e1c39-4547-7cd3-ba49-bbbe59e52087@quicinc.com>
 <32488500-05B7-4D25-9AAF-06A249CC6B1D@linaro.org>
 <d0c8b466-5df2-853c-608d-ab67af1a9f32@quicinc.com>
 <CAA8EJpo7J9ZXC9uERg=WkjMbDD-fDTOO2VXaRVOCVZXiN18oSw@mail.gmail.com>
 <4d67915a-d57d-0a33-cdef-3bdf05961d16@quicinc.com>
 <CAA8EJppa2Z-h0vH2Cmeem_1Cw8C+53q7pXkJ03mut4Bsn+Vm7A@mail.gmail.com>
 <4c111681-03b8-9b4c-6b5b-ebfa4c5a7377@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c111681-03b8-9b4c-6b5b-ebfa4c5a7377@quicinc.com>

On Mon, Sep 02, 2024 at 04:17:06PM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 9/2/2024 3:42 PM, Dmitry Baryshkov wrote:
> > On Mon, 2 Sept 2024 at 11:32, Krishna Chaitanya Chundru
> > <quic_krichai@quicinc.com> wrote:
> > > 
> > > 
> > > 
> > > On 9/2/2024 12:50 PM, Dmitry Baryshkov wrote:
> > > > On Mon, 2 Sept 2024 at 10:13, Krishna Chaitanya Chundru
> > > > <quic_krichai@quicinc.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 8/8/2024 9:00 AM, Dmitry Baryshkov wrote:
> > > > > > On August 5, 2024 1:14:47 PM GMT+07:00, Krishna Chaitanya Chundru <quic_krichai@quicinc.com> wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 8/3/2024 5:04 PM, Dmitry Baryshkov wrote:
> > > > > > > > On Sat, Aug 03, 2024 at 08:52:54AM GMT, Krishna chaitanya chundru wrote:
> > > > > > > > > QPS615 switch needs to be configured after powering on and before
> > > > > > > > > PCIe link was up.
> > > > > > > > > 
> > > > > > > > > As the PCIe controller driver already enables the PCIe link training
> > > > > > > > > at the host side, stop the link training. Otherwise the moment we turn
> > > > > > > > > on the switch it will participate in the link training and link may come
> > > > > > > > > up before switch is configured through i2c.
> > > > > > > > > 
> > > > > > > > > The device tree properties are parsed per node under pci-pci bridge in the
> > > > > > > > > driver. Each node has unique bdf value in the reg property, driver
> > > > > > > > > uses this bdf to differentiate ports, as there are certain i2c writes to
> > > > > > > > > select particular port.
> > > > > > > > > 
> > > > > > > > > Based up on dt property and port, qps615 is configured through i2c.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > > > ---
> > > > > > > > >      drivers/pci/pwrctl/Kconfig             |   7 +
> > > > > > > > >      drivers/pci/pwrctl/Makefile            |   1 +
> > > > > > > > >      drivers/pci/pwrctl/pci-pwrctl-qps615.c | 638 +++++++++++++++++++++++++++++++++
> > > > > > > > >      3 files changed, 646 insertions(+)
> > > > > > > > > 

> > > > > > > > > +
> > > > > > > > > +  return qps615_pwrctl_i2c_write(ctx->client,
> > > > > > > > > +                                 is_l1 ? QPS615_PORT_L1_DELAY : QPS615_PORT_L0S_DELAY, units);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int qps615_pwrctl_set_tx_amplitude(struct qps615_pwrctl_ctx *ctx,
> > > > > > > > > +                                    enum qps615_pwrctl_ports port, u32 amp)
> > > > > > > > > +{
> > > > > > > > > +  int port_access;
> > > > > > > > > +
> > > > > > > > > +  switch (port) {
> > > > > > > > > +  case QPS615_USP:
> > > > > > > > > +          port_access = 0x1;
> > > > > > > > > +          break;
> > > > > > > > > +  case QPS615_DSP1:
> > > > > > > > > +          port_access = 0x2;
> > > > > > > > > +          break;
> > > > > > > > > +  case QPS615_DSP2:
> > > > > > > > > +          port_access = 0x8;
> > > > > > > > > +          break;
> > > > > > > > > +  default:
> > > > > > > > > +          return -EINVAL;
> > > > > > > > > +  };
> > > > > > > > > +
> > > > > > > > > +  struct qps615_pwrctl_reg_setting tx_amp_seq[] = {
> > > > > > > > > +          {QPS615_PORT_ACCESS_ENABLE, port_access},
> > > > > > > > 
> > > > > > > > Hmm, this looks like another port selection, so most likely it should
> > > > > > > > also be under the same lock.
> > > > > > > > 
> > > > > > > > > +          {QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
> > > > > > > > > +          {QPS615_TX_MARGIN, amp},
> > > > > > > > > +  };
> > > > > > > > > +
> > > > > > > > > +  return qps615_pwrctl_i2c_bulk_write(ctx->client, tx_amp_seq, ARRAY_SIZE(tx_amp_seq));
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int qps615_pwrctl_disable_dfe(struct qps615_pwrctl_ctx *ctx,
> > > > > > > > > +                               enum qps615_pwrctl_ports port)
> > > > > > > > > +{
> > > > > > > > > +  int port_access, lane_access = 0x3;
> > > > > > > > > +  u32 phy_rate = 0x21;
> > > > > > > > > +
> > > > > > > > > +  switch (port) {
> > > > > > > > > +  case QPS615_USP:
> > > > > > > > > +          phy_rate = 0x1;
> > > > > > > > > +          port_access = 0x1;
> > > > > > > > > +          break;
> > > > > > > > > +  case QPS615_DSP1:
> > > > > > > > > +          port_access = 0x2;
> > > > > > > > > +          break;
> > > > > > > > > +  case QPS615_DSP2:
> > > > > > > > > +          port_access = 0x8;
> > > > > > > > > +          lane_access = 0x1;
> > > > > > > > > +          break;
> > > > > > > > > +  default:
> > > > > > > > > +          return -EINVAL;
> > > > > > > > > +  };
> > > > > > > > > +
> > > > > > > > > +  struct qps615_pwrctl_reg_setting disable_dfe_seq[] = {
> > > > > > > > > +          {QPS615_PORT_ACCESS_ENABLE, port_access},
> > > > > > > > > +          {QPS615_PORT_LANE_ACCESS_ENABLE, lane_access},
> > > > > > > > > +          {QPS615_DFE_ENABLE, 0x0},
> > > > > > > > > +          {QPS615_DFE_EQ0_MODE, 0x411},
> > > > > > > > > +          {QPS615_DFE_EQ1_MODE, 0x11},
> > > > > > > > > +          {QPS615_DFE_EQ2_MODE, 0x11},
> > > > > > > > > +          {QPS615_DFE_PD_MASK, 0x7},
> > > > > > > > > +          {QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x10},
> > > > > > > > > +          {QPS615_PHY_RATE_CHANGE, phy_rate},
> > > > > > > > > +          {QPS615_PHY_RATE_CHANGE, 0x0},
> > > > > > > > > +          {QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x0},
> > > > > > > > > +
> > > > > > > > > +  };
> > > > > > > > > +
> > > > > > > > > +  return qps615_pwrctl_i2c_bulk_write(ctx->client,
> > > > > > > > > +                                      disable_dfe_seq, ARRAY_SIZE(disable_dfe_seq));
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int qps615_pwrctl_set_nfts(struct qps615_pwrctl_ctx *ctx,
> > > > > > > > > +                            enum qps615_pwrctl_ports port, u32 nfts)
> > > > > > > > > +{
> > > > > > > > > +  int ret;
> > > > > > > > > +  struct qps615_pwrctl_reg_setting nfts_seq[] = {
> > > > > > > > > +          {QPS615_NFTS_2_5_GT, nfts},
> > > > > > > > > +          {QPS615_NFTS_5_GT, nfts},
> > > > > > > > > +  };
> > > > > > > > > +
> > > > > > > > > +  ret =  qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BIT(port));
> > > > > > > > > +  if (ret)
> > > > > > > > > +          return ret;
> > > > > > > > > +
> > > > > > > > > +  return qps615_pwrctl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZE(nfts_seq));
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int qps615_pwrctl_assert_deassert_reset(struct qps615_pwrctl_ctx *ctx, bool deassert)
> > > > > > > > > +{
> > > > > > > > > +  int ret, val = 0;
> > > > > > > > > +
> > > > > > > > > +  if (deassert)
> > > > > > > > > +          val = 0xc;
> > > > > > > > > +
> > > > > > > > > +  ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_GPIO_CONFIG, 0xfffffff3);
> > > > > > > > 
> > > > > > > > It's a kind of magic
> > > > > > > > 
> > > > > > > I will add a macro in next patch.
> > > > > > > > > +  if (ret)
> > > > > > > > > +          return ret;
> > > > > > > > > +
> > > > > > > > > +  return qps615_pwrctl_i2c_write(ctx->client, QPS615_RESET_GPIO, val);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static int qps615_pwrctl_parse_device_dt(struct qps615_pwrctl_ctx *ctx, struct device_node *node)
> > > > > > > > > +{
> > > > > > > > > +  enum qps615_pwrctl_ports port;
> > > > > > > > > +  struct qps615_pwrctl_cfg *cfg;
> > > > > > > > > +  struct device_node *np;
> > > > > > > > > +  int bdf, fun_no;
> > > > > > > > > +
> > > > > > > > > +  bdf = of_pci_get_bdf(node);
> > > > > > > > > +  if (bdf < 0) {
> > > > > > > > 
> > > > > > > > This is incorrect, it will fail if at any point BDF uses the most
> > > > > > > > significant bit (which is permitted by the spec, if I'm not mistaken).
> > > > > > > > 
> > > > > > > As per the reg property as described in the binding document we are not
> > > > > > > expecting any change here.
> > > > > > > https://elixir.bootlin.com/linux/v6.10.3/source/Documentation/devicetree/bindings/pci/pci.txt#L50.
> > > > > > 
> > > > > > What will this function return if the bus no is 256?
> > > > > > The supported PCI bus number is from 0x0 to 0xff only. so we
> > > > > are not expecting any numbers greater than 0xff.
> > > > > > Also please either move the function to the generic PCI code is change its name to match the rest of the driver. The of_pci_ prefix is reserved for the generic code.
> > > > > > 
> > > > > ack.
> > > > > > 
> > > > > > > > > +          dev_err(ctx->pwrctl.dev, "Getting BDF failed\n");
> > > > > > > > > +          return 0;
> > > > > > > > > +  }
> > > > > > > > > +
> > > > > > > > > +  fun_no = bdf & 0x7;
> > > > > > > > 
> > > > > > > > I assume that ARI is not supported?
> > > > > > > > 
> > > > > > > Yes this doesn't support ARI.
> > > > > > > > > +
> > > > > > > > > +  /* In multi function node, ignore function 1 node */
> > > > > > > > > +  if (of_pci_get_bdf(of_get_parent(node)) == ctx->bdf->dsp3_bdf && !fun_no)
> > > > > > > > > +          port = QPS615_ETHERNET;
> > > > > > > > > +  else if (bdf == ctx->bdf->usp_bdf)
> > > > > > > > > +          port = QPS615_USP;
> > > > > > > > 
> > > > > > > > The function is being called for child device nodes. Thus upstream
> > > > > > > > facing port (I assume that this is what USP means) can not be enumerated
> > > > > > > > in this way.
> > > > > > > Sorry, but I didn't your question.
> > > > > > > 
> > > > > > > These settings will not affect the enumeration sequence these are
> > > > > > > for configuring ports only.
> > > > > > 
> > > > > > You are handling the case of bdf equal to the USP. Is it possible at all?
> > > > > > 
> > > > > at the time of the configuration the PCI link is not enabled yet,
> > > > > once we are done with the configurations only we are resumeing the link
> > > > > training. so when we start this configuration the link is not up yet.
> > > > 
> > > > Is your answer relevant to the question I have asked?
> > > > 
> > > sorry dmitry I might got your question wrong. what I understood is
> > > "you are configuring USP port before the link is up, is that possible?"
> > > I might read your statement wrongly.
> > > 
> > > If the question is "why do we need to configure USP?" I will try to
> > > respond below.
> > > "USP also will have l0s, L1 entry delays, nfts etc which can be
> > > configured".
> > > 
> > > Sorry once again if your question doesn't fall in both can you tell
> > > me your question.
> > 
> > My question was why the function gets executed for the root port. But
> > after reading the qps615_pwrctl_parse_device_dt() I have another
> > question: you are parsing DT nodes recursively. You should stop
> > parsing at the first level, so that grandchildren nodes can not
> > override your data (and so that the time isn't spent on parsing
> > useless data). Also I have the feeling that BDF parsing isn't so
> > correct. Will it work if QPS is sitting behind a PCI-PCI bridge?
> > 
> we are not executing for root port. we are configuring for USP
> since there are some features of USP which can be configured.

What is USP? Upstream side port?

> 
> we are trying to store each configurations in below line.
> cfg = &ctx->cfg[port];
> 
> port will have enum value based upon the bdf. after filling
> the parent node we calling recursive function for child nodes.
> As the BDF is unique value for each node we not expecting to get
> same enum value for child or grand child nodes and there will
> be no overwrite. If the BDF is not matched we are just returning
> instead of looking for the properties.
> 
> QPS615 node is defined as child of the pci-pci bridge only.
> The pwrctl framework is designed to work if the device
> is represented as child node in the pci-pci bridge only.

Of course. Each PCIe device is either a child of the root port or a
child of a pci-pci bridge. So are the BDFs specific to the case of
QPS615 being a child of the root PCIe bridge?

> 
> Hope it clarifies all the queries.

Yes. Please drop recursive parsing and add explicit single
for_each_child_of_node().

> 
> - Krishna chaitanya.
> > > > > > 
> > > > > > > > 
> > > > > > > > > +  else if (bdf == ctx->bdf->dsp1_bdf)
> > > > > > > > > +          port = QPS615_DSP1;
> > > > > > > > > +  else if (bdf == ctx->bdf->dsp2_bdf)
> > > > > > > > > +          port = QPS615_DSP2;
> > > > > > > > > +  else if (bdf == ctx->bdf->dsp3_bdf)
> > > > > > > > > +          port = QPS615_DSP3;
> > > > > > > > > +  else
> > > > > > > > > +          return 0;
> > > > > > > > 
> > > > > > > > -EINVAL >
> > > > > > > There are can be nodes describing endpoints also,
> > > > > > > for those nodes bdf will not match and we are not
> > > > > > > returning since it is expected for endpoint nodes.
> > > > > > 
> > > > > > Which endpoints? Bindings don't describe them.
> > > > > > 
> > > > > The client drivers like ethernet will add them once
> > > > > this series is merged. Their drivers are not present
> > > > > in the linux as of now.
> > > > 
> > > > The bindings describe the hardware, not the drivers. Also the driver
> > > > should work with the bindings that you have submitted, not some
> > > > imaginary to-be-submitted state. Please either update the bindings
> > > > within the patchset or fix the driver to return -EINVAL.
> > > > 
> > > The qps615 bindings describes only the PCIe switch part,
> > > the endpoints binding connected to the switch should be described by the
> > > respective clients like USB hub, NVMe, ethernet etc bindings should
> > > describe their hardware and its properties. And these bindings will
> > > defined in seperate bindinds file not in qps615 bindings.
> > > 
> > > for example:-
> > > 
> > > in the following example pcie@0,0 describes usp and
> > > pcie@1,0 & pcie@2,0 describes dsp's of the switch.
> > > now if we say usb hub is connected to dsp1 i.e to the
> > > node pcie@1,0 there will be a child node to the pcie@1,0
> > > to denote usb hub hardware.
> > > And that node is external to the switch and we are not
> > > configuring it through i2c. As these are pcie devices
> > > representation is generic one we can't say if the client
> > > nodes(in this case usb hub) will be present or not. if the child
> > > node( for example usb hub) is present we can't return -EINVAL
> > > because qps615 will not configure it.
> > > 
> > > &pcieport {
> > >          pcie@0,0 {
> > >                  pcie@1,0 {
> > >                          reg = <0x20800 0x0 0x0 0x0 0x0>;
> > >                          #address-cells = <3>;
> > >                          #size-cells = <2>;
> > > 
> > >                          device_type = "pci";
> > >                          ranges;
> > >                          usb_hub@0,0 {
> > >                                  //describes USB hub
> > >                          };
> > >                  };
> > > 
> > >                  pcie@2,0 {
> > >                          reg = <0x21000 0x0 0x0 0x0 0x0>;
> > >                          #address-cells = <3>;
> > >                          #size-cells = <2>;
> > > 
> > >                          device_type = "pci";
> > >                          ranges;
> > >                  };
> > >          };
> > > };

-- 
With best wishes
Dmitry

