Return-Path: <linux-pci+bounces-14809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6579A288E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5206E1F210F2
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFFA1DEFFD;
	Thu, 17 Oct 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kp3nz0jY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424A5FDA7
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182317; cv=none; b=s70ev6p6yIKvzKPvQLeQ/bfWXnVAdJStAflTE2u2Lhc9V4Q2gt92pekg1z34xy6cK/1OORIZSDHSAdp2D37FhFSz4QeYjqzgJzQMBrIbYhqejt+8RH8iH3RhCIBVKKeaAuH6Mv3cgc5DluC3B1FMmPX6MHtFR8u73f4w01j6NV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182317; c=relaxed/simple;
	bh=/FaY1lFvVjH9QwLETjeGCFR+Fp8VYdm7FtlLJk8rELo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKBSxryNsZ9ghyJioku4CSmZiWiI156SCXU0GOOD1JeHjMqsxQXjTwqKtST4zikq3tV7bOtsikVKpFgTKhDfNfDI5Gl/wB9D4vuOHOu8DQdQ/hawEEvcz2eW/f5xAHWn+lfgq4PeA1yneCQpiLWdhc0349fdOku/dia/Qsh2C9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kp3nz0jY; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e3d97b8274so11376987b3.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729182311; x=1729787111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TZwh7t78Vk465g82TwHaDZNony7B/4eq7p1Xpp2l3tU=;
        b=Kp3nz0jY6FxTuJ8wt9gYObm7JO0H3LFTsSFM1vd3oqCr76ayHWe8qGE+iJAp0c0eD3
         TQIPfPhC+/0xqi7bsnlNfdQKUNM2k0iP90PFeSXfpkqkfDqYpUbIdTCOHtXKshnt1kWY
         mJ3hgPPSyl1iaoxlVTOX0DV8cUGd/x0hIHMjT/ALJrwT07LsJqVcWOi19NDmEIbq1est
         2Mws86yX7fddiuGXk48Bq9gZOtiGdnB/GnWsXI6gZN5pjl8G8QhR//crwzKtCL0GYmrS
         BpY5tA+3hxJU1zt+2Q704KtTQse0wJ7rVvY/4ljMfQyRCKwvZKP3dQgCZq/soIU6kAim
         9Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729182311; x=1729787111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZwh7t78Vk465g82TwHaDZNony7B/4eq7p1Xpp2l3tU=;
        b=ZBL1ioGaREtborzDddXuGzdLiWl1X4bgQCiw8ltp2KmuCNEcqDSY/CCJSXZPjmN+3j
         kxhpXEqsRShPqMwRAlIURqmdnZ21Y4e8k/l7xQkmvYiW7L7e8nK+7ku5Xwg4MIikdsdw
         mMoRy/Vt24KPOknCEiNejRmpnAk0xz45nTcwGPaSF+IGmfqAymz+Fv6m5jTzWIDLv7nQ
         nCvNCKn+4MQhUpd6RAJtHo5md96Hb26Y8Cca/lVhQLKhIRe/zVGcmm4egLNPlLUfMp3l
         15WO7HTzi9zgbRAiT7uf8jCPwXlHCzP+Ysp/eKtONY0e0jAEjoi7qH+nn4I4E9GGtNml
         DTEA==
X-Forwarded-Encrypted: i=1; AJvYcCW7uqsbSAEF3tv0UvibfMfNaTDKD/0cY6vjeeakGeIZ+fhYZ2A1E7MsJAAQ7+V/8N1TtL6ZmuHbjLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVD1Pm3cFrC7Rip5fqVW2W5yvNwhhyDD0hj1hUs/8Y1Svfy0wc
	lnynsO7aI+RHPBB3qTMLkefdb07QEcot5P7I9gLy2pgHJmz2EaivZiPvHvlS76Icz0fj9sjnW5l
	Tdof6P/j34IwvQJ+VVgoyNxjVvyOdIG2irWMoZA==
X-Google-Smtp-Source: AGHT+IG+z7JiwbpvRkeGgL4nIC2w1Qb71J+yKnmH+5Tz5yAXgK5P14q3seBm+iVaUT9iKi72+W6fA607pnAQOICUX/w=
X-Received: by 2002:a05:690c:680c:b0:6e3:dc4a:34b0 with SMTP id
 00721157ae682-6e3dc4ad12dmr67881107b3.22.1729182311276; Thu, 17 Oct 2024
 09:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-8-9560b7c71369@quicinc.com> <spaudnuoam3cj7glxmnlw7y3m46d2vsm42s576jqwrcrmywl2n@oyrynorzhddg>
 <872e1c39-4547-7cd3-ba49-bbbe59e52087@quicinc.com> <32488500-05B7-4D25-9AAF-06A249CC6B1D@linaro.org>
 <d0c8b466-5df2-853c-608d-ab67af1a9f32@quicinc.com> <CAA8EJpo7J9ZXC9uERg=WkjMbDD-fDTOO2VXaRVOCVZXiN18oSw@mail.gmail.com>
 <4d67915a-d57d-0a33-cdef-3bdf05961d16@quicinc.com> <CAA8EJppa2Z-h0vH2Cmeem_1Cw8C+53q7pXkJ03mut4Bsn+Vm7A@mail.gmail.com>
 <4c111681-03b8-9b4c-6b5b-ebfa4c5a7377@quicinc.com> <w547dmmxqqa4atd62jqiqcfzhlnpjc7n64btjmre5pmbsci4br@w45tuny3mcmn>
 <9b2831a4-b2c5-2282-a7bc-497a7a215ffa@quicinc.com>
In-Reply-To: <9b2831a4-b2c5-2282-a7bc-497a7a215ffa@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 19:24:59 +0300
Message-ID: <CAA8EJpqFhpAZtCCwDz9GBcPKwrdOFBmypajL0Sd7wKUwp=seKg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] PCI: pwrctl: Add power control driver for qps615
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, andersson@kernel.org, 
	quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 18:48, Krishna Chaitanya Chundru
<quic_krichai@quicinc.com> wrote:
>
>
>
> On 9/3/2024 12:07 AM, Dmitry Baryshkov wrote:
> > On Mon, Sep 02, 2024 at 04:17:06PM GMT, Krishna Chaitanya Chundru wrote:
> >>
> >>
> >> On 9/2/2024 3:42 PM, Dmitry Baryshkov wrote:
> >>> On Mon, 2 Sept 2024 at 11:32, Krishna Chaitanya Chundru
> >>> <quic_krichai@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 9/2/2024 12:50 PM, Dmitry Baryshkov wrote:
> >>>>> On Mon, 2 Sept 2024 at 10:13, Krishna Chaitanya Chundru
> >>>>> <quic_krichai@quicinc.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 8/8/2024 9:00 AM, Dmitry Baryshkov wrote:
> >>>>>>> On August 5, 2024 1:14:47 PM GMT+07:00, Krishna Chaitanya Chundru <quic_krichai@quicinc.com> wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 8/3/2024 5:04 PM, Dmitry Baryshkov wrote:
> >>>>>>>>> On Sat, Aug 03, 2024 at 08:52:54AM GMT, Krishna chaitanya chundru wrote:
> >>>>>>>>>> QPS615 switch needs to be configured after powering on and before
> >>>>>>>>>> PCIe link was up.
> >>>>>>>>>>
> >>>>>>>>>> As the PCIe controller driver already enables the PCIe link training
> >>>>>>>>>> at the host side, stop the link training. Otherwise the moment we turn
> >>>>>>>>>> on the switch it will participate in the link training and link may come
> >>>>>>>>>> up before switch is configured through i2c.
> >>>>>>>>>>
> >>>>>>>>>> The device tree properties are parsed per node under pci-pci bridge in the
> >>>>>>>>>> driver. Each node has unique bdf value in the reg property, driver
> >>>>>>>>>> uses this bdf to differentiate ports, as there are certain i2c writes to
> >>>>>>>>>> select particular port.
> >>>>>>>>>>
> >>>>>>>>>> Based up on dt property and port, qps615 is configured through i2c.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> >>>>>>>>>> ---
> >>>>>>>>>>       drivers/pci/pwrctl/Kconfig             |   7 +
> >>>>>>>>>>       drivers/pci/pwrctl/Makefile            |   1 +
> >>>>>>>>>>       drivers/pci/pwrctl/pci-pwrctl-qps615.c | 638 +++++++++++++++++++++++++++++++++
> >>>>>>>>>>       3 files changed, 646 insertions(+)
> >>>>>>>>>>
> >
> >>>>>>>>>> +
> >>>>>>>>>> +  return qps615_pwrctl_i2c_write(ctx->client,
> >>>>>>>>>> +                                 is_l1 ? QPS615_PORT_L1_DELAY : QPS615_PORT_L0S_DELAY, units);
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +static int qps615_pwrctl_set_tx_amplitude(struct qps615_pwrctl_ctx *ctx,
> >>>>>>>>>> +                                    enum qps615_pwrctl_ports port, u32 amp)
> >>>>>>>>>> +{
> >>>>>>>>>> +  int port_access;
> >>>>>>>>>> +
> >>>>>>>>>> +  switch (port) {
> >>>>>>>>>> +  case QPS615_USP:
> >>>>>>>>>> +          port_access = 0x1;
> >>>>>>>>>> +          break;
> >>>>>>>>>> +  case QPS615_DSP1:
> >>>>>>>>>> +          port_access = 0x2;
> >>>>>>>>>> +          break;
> >>>>>>>>>> +  case QPS615_DSP2:
> >>>>>>>>>> +          port_access = 0x8;
> >>>>>>>>>> +          break;
> >>>>>>>>>> +  default:
> >>>>>>>>>> +          return -EINVAL;
> >>>>>>>>>> +  };
> >>>>>>>>>> +
> >>>>>>>>>> +  struct qps615_pwrctl_reg_setting tx_amp_seq[] = {
> >>>>>>>>>> +          {QPS615_PORT_ACCESS_ENABLE, port_access},
> >>>>>>>>>
> >>>>>>>>> Hmm, this looks like another port selection, so most likely it should
> >>>>>>>>> also be under the same lock.
> >>>>>>>>>
> >>>>>>>>>> +          {QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
> >>>>>>>>>> +          {QPS615_TX_MARGIN, amp},
> >>>>>>>>>> +  };
> >>>>>>>>>> +
> >>>>>>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client, tx_amp_seq, ARRAY_SIZE(tx_amp_seq));
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +static int qps615_pwrctl_disable_dfe(struct qps615_pwrctl_ctx *ctx,
> >>>>>>>>>> +                               enum qps615_pwrctl_ports port)
> >>>>>>>>>> +{
> >>>>>>>>>> +  int port_access, lane_access = 0x3;
> >>>>>>>>>> +  u32 phy_rate = 0x21;
> >>>>>>>>>> +
> >>>>>>>>>> +  switch (port) {
> >>>>>>>>>> +  case QPS615_USP:
> >>>>>>>>>> +          phy_rate = 0x1;
> >>>>>>>>>> +          port_access = 0x1;
> >>>>>>>>>> +          break;
> >>>>>>>>>> +  case QPS615_DSP1:
> >>>>>>>>>> +          port_access = 0x2;
> >>>>>>>>>> +          break;
> >>>>>>>>>> +  case QPS615_DSP2:
> >>>>>>>>>> +          port_access = 0x8;
> >>>>>>>>>> +          lane_access = 0x1;
> >>>>>>>>>> +          break;
> >>>>>>>>>> +  default:
> >>>>>>>>>> +          return -EINVAL;
> >>>>>>>>>> +  };
> >>>>>>>>>> +
> >>>>>>>>>> +  struct qps615_pwrctl_reg_setting disable_dfe_seq[] = {
> >>>>>>>>>> +          {QPS615_PORT_ACCESS_ENABLE, port_access},
> >>>>>>>>>> +          {QPS615_PORT_LANE_ACCESS_ENABLE, lane_access},
> >>>>>>>>>> +          {QPS615_DFE_ENABLE, 0x0},
> >>>>>>>>>> +          {QPS615_DFE_EQ0_MODE, 0x411},
> >>>>>>>>>> +          {QPS615_DFE_EQ1_MODE, 0x11},
> >>>>>>>>>> +          {QPS615_DFE_EQ2_MODE, 0x11},
> >>>>>>>>>> +          {QPS615_DFE_PD_MASK, 0x7},
> >>>>>>>>>> +          {QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x10},
> >>>>>>>>>> +          {QPS615_PHY_RATE_CHANGE, phy_rate},
> >>>>>>>>>> +          {QPS615_PHY_RATE_CHANGE, 0x0},
> >>>>>>>>>> +          {QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x0},
> >>>>>>>>>> +
> >>>>>>>>>> +  };
> >>>>>>>>>> +
> >>>>>>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client,
> >>>>>>>>>> +                                      disable_dfe_seq, ARRAY_SIZE(disable_dfe_seq));
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +static int qps615_pwrctl_set_nfts(struct qps615_pwrctl_ctx *ctx,
> >>>>>>>>>> +                            enum qps615_pwrctl_ports port, u32 nfts)
> >>>>>>>>>> +{
> >>>>>>>>>> +  int ret;
> >>>>>>>>>> +  struct qps615_pwrctl_reg_setting nfts_seq[] = {
> >>>>>>>>>> +          {QPS615_NFTS_2_5_GT, nfts},
> >>>>>>>>>> +          {QPS615_NFTS_5_GT, nfts},
> >>>>>>>>>> +  };
> >>>>>>>>>> +
> >>>>>>>>>> +  ret =  qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BIT(port));
> >>>>>>>>>> +  if (ret)
> >>>>>>>>>> +          return ret;
> >>>>>>>>>> +
> >>>>>>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZE(nfts_seq));
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +static int qps615_pwrctl_assert_deassert_reset(struct qps615_pwrctl_ctx *ctx, bool deassert)
> >>>>>>>>>> +{
> >>>>>>>>>> +  int ret, val = 0;
> >>>>>>>>>> +
> >>>>>>>>>> +  if (deassert)
> >>>>>>>>>> +          val = 0xc;
> >>>>>>>>>> +
> >>>>>>>>>> +  ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_GPIO_CONFIG, 0xfffffff3);
> >>>>>>>>>
> >>>>>>>>> It's a kind of magic
> >>>>>>>>>
> >>>>>>>> I will add a macro in next patch.
> >>>>>>>>>> +  if (ret)
> >>>>>>>>>> +          return ret;
> >>>>>>>>>> +
> >>>>>>>>>> +  return qps615_pwrctl_i2c_write(ctx->client, QPS615_RESET_GPIO, val);
> >>>>>>>>>> +}
> >>>>>>>>>> +
> >>>>>>>>>> +static int qps615_pwrctl_parse_device_dt(struct qps615_pwrctl_ctx *ctx, struct device_node *node)
> >>>>>>>>>> +{
> >>>>>>>>>> +  enum qps615_pwrctl_ports port;
> >>>>>>>>>> +  struct qps615_pwrctl_cfg *cfg;
> >>>>>>>>>> +  struct device_node *np;
> >>>>>>>>>> +  int bdf, fun_no;
> >>>>>>>>>> +
> >>>>>>>>>> +  bdf = of_pci_get_bdf(node);
> >>>>>>>>>> +  if (bdf < 0) {
> >>>>>>>>>
> >>>>>>>>> This is incorrect, it will fail if at any point BDF uses the most
> >>>>>>>>> significant bit (which is permitted by the spec, if I'm not mistaken).
> >>>>>>>>>
> >>>>>>>> As per the reg property as described in the binding document we are not
> >>>>>>>> expecting any change here.
> >>>>>>>> https://elixir.bootlin.com/linux/v6.10.3/source/Documentation/devicetree/bindings/pci/pci.txt#L50.
> >>>>>>>
> >>>>>>> What will this function return if the bus no is 256?
> >>>>>>> The supported PCI bus number is from 0x0 to 0xff only. so we
> >>>>>> are not expecting any numbers greater than 0xff.
> >>>>>>> Also please either move the function to the generic PCI code is change its name to match the rest of the driver. The of_pci_ prefix is reserved for the generic code.
> >>>>>>>
> >>>>>> ack.
> >>>>>>>
> >>>>>>>>>> +          dev_err(ctx->pwrctl.dev, "Getting BDF failed\n");
> >>>>>>>>>> +          return 0;
> >>>>>>>>>> +  }
> >>>>>>>>>> +
> >>>>>>>>>> +  fun_no = bdf & 0x7;
> >>>>>>>>>
> >>>>>>>>> I assume that ARI is not supported?
> >>>>>>>>>
> >>>>>>>> Yes this doesn't support ARI.
> >>>>>>>>>> +
> >>>>>>>>>> +  /* In multi function node, ignore function 1 node */
> >>>>>>>>>> +  if (of_pci_get_bdf(of_get_parent(node)) == ctx->bdf->dsp3_bdf && !fun_no)
> >>>>>>>>>> +          port = QPS615_ETHERNET;
> >>>>>>>>>> +  else if (bdf == ctx->bdf->usp_bdf)
> >>>>>>>>>> +          port = QPS615_USP;
> >>>>>>>>>
> >>>>>>>>> The function is being called for child device nodes. Thus upstream
> >>>>>>>>> facing port (I assume that this is what USP means) can not be enumerated
> >>>>>>>>> in this way.
> >>>>>>>> Sorry, but I didn't your question.
> >>>>>>>>
> >>>>>>>> These settings will not affect the enumeration sequence these are
> >>>>>>>> for configuring ports only.
> >>>>>>>
> >>>>>>> You are handling the case of bdf equal to the USP. Is it possible at all?
> >>>>>>>
> >>>>>> at the time of the configuration the PCI link is not enabled yet,
> >>>>>> once we are done with the configurations only we are resumeing the link
> >>>>>> training. so when we start this configuration the link is not up yet.
> >>>>>
> >>>>> Is your answer relevant to the question I have asked?
> >>>>>
> >>>> sorry dmitry I might got your question wrong. what I understood is
> >>>> "you are configuring USP port before the link is up, is that possible?"
> >>>> I might read your statement wrongly.
> >>>>
> >>>> If the question is "why do we need to configure USP?" I will try to
> >>>> respond below.
> >>>> "USP also will have l0s, L1 entry delays, nfts etc which can be
> >>>> configured".
> >>>>
> >>>> Sorry once again if your question doesn't fall in both can you tell
> >>>> me your question.
> >>>
> >>> My question was why the function gets executed for the root port. But
> >>> after reading the qps615_pwrctl_parse_device_dt() I have another
> >>> question: you are parsing DT nodes recursively. You should stop
> >>> parsing at the first level, so that grandchildren nodes can not
> >>> override your data (and so that the time isn't spent on parsing
> >>> useless data). Also I have the feeling that BDF parsing isn't so
> >>> correct. Will it work if QPS is sitting behind a PCI-PCI bridge?
> >>>
> >> we are not executing for root port. we are configuring for USP
> >> since there are some features of USP which can be configured.
> >
> > What is USP? Upstream side port?
> >
> >>
> >> we are trying to store each configurations in below line.
> >> cfg = &ctx->cfg[port];
> >>
> >> port will have enum value based upon the bdf. after filling
> >> the parent node we calling recursive function for child nodes.
> >> As the BDF is unique value for each node we not expecting to get
> >> same enum value for child or grand child nodes and there will
> >> be no overwrite. If the BDF is not matched we are just returning
> >> instead of looking for the properties.
> >>
> >> QPS615 node is defined as child of the pci-pci bridge only.
> >> The pwrctl framework is designed to work if the device
> >> is represented as child node in the pci-pci bridge only.
> >
> > Of course. Each PCIe device is either a child of the root port or a
> > child of a pci-pci bridge. So are the BDFs specific to the case of
> > QPS615 being a child of the root PCIe bridge?
> >
> yes these are specific to qps615 being a child of the root PCIe bridge.

Then your approach doesn't scale. Please reimplement it in a way that
doesn't require knowing what is the actual topology of the bus. The
driver must work with no changes if you have another PCI-to-PCI bridge
between RC and QPS615.

> >>
> >> Hope it clarifies all the queries.
> >
> > Yes. Please drop recursive parsing and add explicit single
> > for_each_child_of_node().
> >
> Dimitry, the ethernet nodes which are child of dsp3 need extra
> for_each_child_of_node and also we are going to add support for cascade
> switch once this patch lands, in that cascade switch one more QPS615
> switch will be connected to the one of the downstream port of the first
> switch in that case we might need to do for_each_child_of_node twice
> from  the dsp node where cascade switch is connected.
> So it will good if we have this recursive parsing.

Well, unless I miss something, your child bridge should be handled by
the driver for that bridge, not by the driver for the root bridge. So
recursive parsing should not be necessary.

>
> - Krishna Chaitanya.
> >
> >> - Krishna chaitanya.
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +  else if (bdf == ctx->bdf->dsp1_bdf)
> >>>>>>>>>> +          port = QPS615_DSP1;
> >>>>>>>>>> +  else if (bdf == ctx->bdf->dsp2_bdf)
> >>>>>>>>>> +          port = QPS615_DSP2;
> >>>>>>>>>> +  else if (bdf == ctx->bdf->dsp3_bdf)
> >>>>>>>>>> +          port = QPS615_DSP3;
> >>>>>>>>>> +  else
> >>>>>>>>>> +          return 0;
> >>>>>>>>>
> >>>>>>>>> -EINVAL >
> >>>>>>>> There are can be nodes describing endpoints also,
> >>>>>>>> for those nodes bdf will not match and we are not
> >>>>>>>> returning since it is expected for endpoint nodes.
> >>>>>>>
> >>>>>>> Which endpoints? Bindings don't describe them.
> >>>>>>>
> >>>>>> The client drivers like ethernet will add them once
> >>>>>> this series is merged. Their drivers are not present
> >>>>>> in the linux as of now.
> >>>>>
> >>>>> The bindings describe the hardware, not the drivers. Also the driver
> >>>>> should work with the bindings that you have submitted, not some
> >>>>> imaginary to-be-submitted state. Please either update the bindings
> >>>>> within the patchset or fix the driver to return -EINVAL.
> >>>>>
> >>>> The qps615 bindings describes only the PCIe switch part,
> >>>> the endpoints binding connected to the switch should be described by the
> >>>> respective clients like USB hub, NVMe, ethernet etc bindings should
> >>>> describe their hardware and its properties. And these bindings will
> >>>> defined in seperate bindinds file not in qps615 bindings.
> >>>>
> >>>> for example:-
> >>>>
> >>>> in the following example pcie@0,0 describes usp and
> >>>> pcie@1,0 & pcie@2,0 describes dsp's of the switch.
> >>>> now if we say usb hub is connected to dsp1 i.e to the
> >>>> node pcie@1,0 there will be a child node to the pcie@1,0
> >>>> to denote usb hub hardware.
> >>>> And that node is external to the switch and we are not
> >>>> configuring it through i2c. As these are pcie devices
> >>>> representation is generic one we can't say if the client
> >>>> nodes(in this case usb hub) will be present or not. if the child
> >>>> node( for example usb hub) is present we can't return -EINVAL
> >>>> because qps615 will not configure it.
> >>>>
> >>>> &pcieport {
> >>>>           pcie@0,0 {
> >>>>                   pcie@1,0 {
> >>>>                           reg = <0x20800 0x0 0x0 0x0 0x0>;
> >>>>                           #address-cells = <3>;
> >>>>                           #size-cells = <2>;
> >>>>
> >>>>                           device_type = "pci";
> >>>>                           ranges;
> >>>>                           usb_hub@0,0 {
> >>>>                                   //describes USB hub
> >>>>                           };
> >>>>                   };
> >>>>
> >>>>                   pcie@2,0 {
> >>>>                           reg = <0x21000 0x0 0x0 0x0 0x0>;
> >>>>                           #address-cells = <3>;
> >>>>                           #size-cells = <2>;
> >>>>
> >>>>                           device_type = "pci";
> >>>>                           ranges;
> >>>>                   };
> >>>>           };
> >>>> };
> >



-- 
With best wishes
Dmitry

