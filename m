Return-Path: <linux-pci+bounces-17437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5399DB940
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D168D282478
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488DF1AF0A3;
	Thu, 28 Nov 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIljuTQy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305341AC428
	for <linux-pci@vger.kernel.org>; Thu, 28 Nov 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732802939; cv=none; b=f7K1kWGliHiWZnwqkKq3MNf4qz0xUJyg3tuKre5d2CHkGTAOJLg3fDcmccVYjVUDcQ4y5yGjG0Jwe+eYfWGV5G4ewxFNKCDLC7df9tbDl43aRTRHiaqrSwHsOQk9tz0fONEpUzl7y/0QjVzh7e0SRUuLXgV3+c/eisR+gCjVsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732802939; c=relaxed/simple;
	bh=0ok8mB09tYX0tSoZPdXmhZOOKBchACeZU+icH4cRTi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNkm2ybG3AUHebBkVSRW7wy9fJI5LFydNzBWgeuKOnnw5qH7511hP5AHqm0CqRYhSIWZ0Cqsyhu+XRlxbzgCPdEVsbcHLlkAwH9gdwxgGVTNtAFahoJyFAfZId4BoHV1MCrDYQ7JgU55e+zEVrb/0SClYXpUUc4uDiCiIkms1kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kIljuTQy; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso990190e87.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Nov 2024 06:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732802935; x=1733407735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zh9F51dD8gEZdCPo/hL/t9nKqjeg/ui1S+RxuDwcDmI=;
        b=kIljuTQy2Ot6PjGU3aQZNxTwfY+nkallUJ/bg9t53r/yD+gaFSeLl+ZjdPy/4s2QrU
         X4Osj4LFPg7qJ6Oi7sq5QxBMvvrzq/TtPUDf/DJsyJm8BikpELCpWtH9F/wplkPW/4WN
         e8P0H5GklokVqcr0HjgKsQdm6L6IZGP54mKoQqw+3UJ4dg1bWuqCn1BdgYZ09XV6vSz8
         MuVrtnv2kcoRcZL0ptiSC6q6JXwdgI+7MC6TQ4dbvuvjiSwVyqB99aT7Rhqsct9xZoso
         vZgVtp3kgZyIrtezMAacVsXpRowTP7ygGCWRt5IJx2bOi4XBr5D7vOzfdnsJHRR6+OHG
         pBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732802935; x=1733407735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh9F51dD8gEZdCPo/hL/t9nKqjeg/ui1S+RxuDwcDmI=;
        b=ucdk3erUfKtR3fR92gbflptbm9bEI16YH7CWK5UpKei9EU8FMlzud13nyVtp29OGCk
         ofOPUz5K6bJUyHJoTqBI2dvgpdi4mNTebLCI3KeYHs/MjQlzGE7sDradLfuijFGHVAFS
         ew2iDXPE21IETfPsc6TCOUgnitN0wjMkj+q8XZu2dp7oPl04lpJIWJ9djbzHsLkSXxHp
         71izYekwGnBfj/NzPome9FO4qfKHGlBtjtxks09Ddvr0aVEm1taOKPi52uKbTGWjGfPx
         Z0ebzeV5zEMYLdp2HZQHv7TkZMkfOmKlmYE4Qgfob7bodGI3y4kDbVr8qYDTg8R4KuRJ
         7m8w==
X-Forwarded-Encrypted: i=1; AJvYcCWF0gBOddJrJt2ooB03Av/Se7qoYQekoiLYdZ7MlNZEq959YeP35yIvB0SWbVi0CFqdPDA6/Ehn/aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMW8LvL7iRtWLectrbFYd9z/3mXvexwY06ZG7rFFRomdxoDeHp
	siaxpQPNN67p6emwk/6JMjNSflwgdR6BbXKgTse1vxFUkD7k9eVBkyzFF81R3LQ=
X-Gm-Gg: ASbGnctZrq6tiJopv1LiAQGyMTlGLj07/IRiS3z+iTXjHvbUYFriWSNjAGjBNn1VSEE
	g9sIgXygVutirSigQ7mq627BnwZ+8BBIGuj97esDv7mujv12dPfce5FS1pcXWvvdX0K+5GfDtUi
	pB3rgkn3P6GjXTb5QUBReuW4Db7I0xTDyaYELzbv20ccMph9lc715ITc81HreVNIReRbbJCgYxW
	Ji+egQLcoMIKR5l+vqJoFd1SrSs4/4RJquiJc5rZ8K8aqeoz6+MTKIERG7zlTqS2HQnSvOwnDU2
	7jaW5nbiRrvYdfvhrf/C/60PZbkCcw==
X-Google-Smtp-Source: AGHT+IH/26if+yOX03OUutYredIEh7TylL/FBWS++pNsdNgznWWW3vF4i3JX3Bycrw39QliL0CzCVQ==
X-Received: by 2002:a19:f51a:0:b0:53d:f983:a57 with SMTP id 2adb3069b0e04-53df9830acdmr265530e87.3.1732802935168;
        Thu, 28 Nov 2024 06:08:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649687csm182457e87.209.2024.11.28.06.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:08:53 -0800 (PST)
Date: Thu, 28 Nov 2024 16:08:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <dtr62oy4lcdqtyvh6ffr3c7rjz65h6bj4fkknf3rmgm65zhnpo@caqdpy7xi4ue>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <poruhxgxnkhvqij5q7z4toxzcsk2gvkyj6ewicsfxj6xl3i3un@msgyeeyb6hsf>
 <42425b92-6e0d-a77b-8733-e50614bcb3a8@quicinc.com>
 <b203d90d-91bc-437b-9b91-1085034ed716@kernel.org>
 <cce7507f-a2c4-6f96-f993-b9a7e9217ffa@quicinc.com>
 <c81b89ff-6eb5-4a01-af84-636aa2a02a34@kernel.org>
 <20241128132432.fxvmjeluagignbph@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241128132432.fxvmjeluagignbph@thinkpad>

On Thu, Nov 28, 2024 at 06:54:32PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Nov 26, 2024 at 07:58:16AM +0100, Krzysztof Kozlowski wrote:
> > On 26/11/2024 07:50, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 11/25/2024 1:10 PM, Krzysztof Kozlowski wrote:
> > >> On 24/11/2024 02:41, Krishna Chaitanya Chundru wrote:
> > >>>> ...
> > >>>>
> > >>>>> +  qps615,axi-clk-freq-hz:
> > >>>>
> > >>>> That's a downstream code you send us.
> > >>>>
> > >>>> Anyway, why assigned clock rates do not work for you? You are 
> > >>>> re-implementing legacy property now under different name :/
> > >>>>
> > >>>> The assigned clock rates comes in to the picture when we are 
> > >>>> using clock
> > >>> framework to control the clocks. For this switch there are no 
> > >>> clocks needs to be control, the moment we power on the switch 
> > >>> clocks are enabled by default. This switch provides a mechanism to 
> > >>> control the frequency using i2c. And switch supports only two 
> > >>> frequencies i.e
> > >>
> > >>
> > >> frequency of what, since there are no clocks?
> > >>
> > > The axi clock frequency internal to the switch, host can't control
> > > the enablement of the clocks it can control only the frequency.
> > > 
> > > we already had a discussion on this on v2[1], and we taught you agreed
> > > on this property.
> > > 
> > > [1] 
> > > https://lore.kernel.org/netdev/d1af1eac-f9bd-7a8e-586b-5c2a76445145@codeaurora.org/T/#m3d5864c758f2e05fa15ba522aad6a37e3417bd9f
> > > 
> > 
> > This points something else. I diged v2 and found many unanswered
> > questions and unfinished discussion:
> > 
> 
> The conversation is here:
> https://lore.kernel.org/linux-arm-msm/20240823094028.7xul4eoiexey5xjm@thinkpad/
> 
> But there was no explicit agreement on the usage of 'qps615,axi-clk-freq-hz'.
> 
> If describing the PCI device's internal clock frequency is not applicable, then
> I'd recommend to change the clock rate in the driver itself based on the number
> of DSPs enabled (or based on other configuration).

Sounds like the best approach. Otherwise it's not obvious, what is the
criteria for selecting this or that clock value.

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
With best wishes
Dmitry

