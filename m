Return-Path: <linux-pci+bounces-64-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A87F3641
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 19:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597EDB2144D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE55394;
	Tue, 21 Nov 2023 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrdgv90s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9149D194
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 10:40:35 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5c9ea2ec8deso28665657b3.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 10:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700592034; x=1701196834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJi+hwHIFMEK75b+gn7N3ATHUD4KW+X7YkfL5jpJno0=;
        b=hrdgv90scQ4yUIzJlsUMbmA1tgnuWnWqJ3sYXRRFDGbKkXTFir4Y0zukJEBb/+tIBP
         iakgS1Y48/wLMYv96yupuakHMN3TG3ATE3QhdhgE9/MCB09bBXDQRo2ykZIUIFLVdK8g
         D4P0sOk+sby4avP9UBgxkHrAVELIT+U2cspg9Hpadtafk/h/IdZd7kh+R1Jd2/iQK618
         EhO3zYhtYQi3fF8n3gg3VyNKa6QZ14JSdG9+5Ig8OuAtfp89foyKHi7oAWDjiyiXdkWS
         fCV6oyEx1trE4s9I6qi2e2eZiO5WVMJ8pmeRA3L5Jh+HtDzK1GUpGGLb4v6VpQ3rOeQK
         87Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700592034; x=1701196834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJi+hwHIFMEK75b+gn7N3ATHUD4KW+X7YkfL5jpJno0=;
        b=kXqYHu/JuI0AKrzxKS6VC9PeJnP4wmLfjOI/0gQOS3oFLQp28Il9DtXZLlx24dO0sm
         ivFXKeA9QLr8yUpM/qbGJEJFwvkN//KJ4N1hpYRIBm+l+h7lkYEsdQ7gc5wut6B6+0Wh
         lgKBRWKQh8dXeKBq4PbzFkb7iSlqAdq4ISNNCm/uEJtMWIYCoB+2rqaBtAF+teKDebjU
         31wV8mPH+RtpQ5W67VNzvUnwb0zDCgRrmk2mnMFJvCJHyDP5oYQeh0NLtmRXDiWO3U2Z
         08JotKBzPmgT9r17iVNeO7ZoeYcfzBB3ZxHBThhsbKMvoAI86s5llzZyFNnzW6eZx52U
         JNWQ==
X-Gm-Message-State: AOJu0Yxc047TrObZHkMQiwKw3kTGpOF1MPLb8wuXJoORLEtwsCJWVeiH
	UeW/mBWdFrdIJNW6wuQhzY0PaM16Uc2IOUAfhwd5Hg==
X-Google-Smtp-Source: AGHT+IGo9pi90+0YW1WgYDu2cpBw4ag/fwWszyzluW/acVk/pI4XfP2FVzn6cSZRSsVDe7lfiSGR4LwIsnI7Xd5IyxA=
X-Received: by 2002:a0d:dc43:0:b0:59b:ec85:54ee with SMTP id
 f64-20020a0ddc43000000b0059bec8554eemr13643015ywe.39.1700592034763; Tue, 21
 Nov 2023 10:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com> <1700577493-18538-2-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1700577493-18538-2-git-send-email-quic_msarkar@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 Nov 2023 20:40:23 +0200
Message-ID: <CAA8EJprOwxFUk_=uE+5788+N5bSKTMa1=t77nRWVu9M7xnjJ3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org, 
	robh+dt@kernel.org, quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com, robh@kernel.org, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, quic_parass@quicinc.com, 
	quic_schintav@quicinc.com, quic_shijjose@quicinc.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Nov 2023 at 16:38, Mrinmay Sarkar <quic_msarkar@quicinc.com> wro=
te:
>
> In a multiprocessor system cache snooping maintains the consistency
> of caches. Snooping logic is disabled from HW on this platform.
> Cache coherency doesn=E2=80=99t work without enabling this logic.
>
> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> platform. Assign no_snoop_override flag into struct qcom_pcie_cfg and
> set it true in cfg_1_34_0 and enable cache snooping if this particular
> flag is true.

Thank you!

>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



--=20
With best wishes
Dmitry

