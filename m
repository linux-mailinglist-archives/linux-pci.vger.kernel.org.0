Return-Path: <linux-pci+bounces-10050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8029D92CBA1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 09:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24121C224FB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3875081AB6;
	Wed, 10 Jul 2024 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOdD3+kn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE480C0C
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595360; cv=none; b=sdQ29eLLLREW+MUfiTv1CNwps2V9nLHnhcBL9VlhSulb7ElZKmGZhlHXeGFglA99KxPjRw8VSTQq8/QipPad6GuRtQt/7/V0CTvl89RumLHPYBaszwOGUWj1J9wJvQ3CinhL8DTlSgkpSikgcpFmdQtrROyENCN9hh7QhfBKPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595360; c=relaxed/simple;
	bh=OT979Mbwccrux7nyb412mjccw6Y//DJLzT48HaqYqoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7DMjQvYIimq+vzPa+lsqYDtksJheFu6Z2abCu7eslBD4tznGb9V6nJn00s+zd2DUr1AU2LAFEN/mgw3Fv0HoWSSwEfH0RHVM+Uw1KEv5tCvTpmoSjiuEdoVK7Qb/rXk6HCZH93OxZ47NZ9pMpInAupGNq8e4HMDNar2bStRYfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tOdD3+kn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so331389b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720595357; x=1721200157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o0bu6VssHFvmAMt5F5xmH4HU5/r8C8lHI0vg8R3gXXQ=;
        b=tOdD3+knzVO8gSqtPkxiEZSpqSGPvLLh9ZqZMguUHeDFtV6zGVHfmPuCtObx5j1CPO
         UDqAhx+aBfkF4BiaPT7sKOCUxi4pAEU6eEFPR8ccyyr3ERugGCND5Wg80VWDzzYSZIfi
         inATMRL7tnWc8a3Ku2v5B50CfcaaY66ASbq8SMuRb00vn43GZeSvRCD8K49SKmC6XI4B
         wd/4yEgz+QNXjDrFVQXP/1JqqJDJw08H5w+O9r/YVkn27NHqk76KEpRUGG86d9mVoKbP
         vE0NBJHoxT25UkhdTfcC4mDc59m2BvI7QVvCYf6TAOc0FF4BtMZ07jhl/VtVklLiCeO6
         Rgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720595357; x=1721200157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bu6VssHFvmAMt5F5xmH4HU5/r8C8lHI0vg8R3gXXQ=;
        b=uI4y0xR2eKvNC+9/bhXLu6dAI4IasAHk+aYkHLCvfUya74QhWGmcY+qsdaoWtB5RQI
         gvmVAJWHF4QF9JHWD/7uKojGRWSaGcI0rKlWtopuDIw3rQYzq7y+FncSe5qxlsZsBD6N
         7uFdm/JQv/zY7Bg0F9jNeC6AzI9dYyt+uaD0NANrv1YEMi1MqHL1gz4ueDC1YLDbCWPO
         cvnFisJEIK5VvkMTmCz7gt5gC8Xz5Rqgyr3/xPl7S/pUbb+yb/KPiegwRRr33cd0zooQ
         uGAWqxItLFsMzUlxUvdaX4LkqMitAJDO0JYhJ2JCxGMW40rF9sYhk4HZm1olw0iB8xy2
         fanQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzP1lrcYfjDNbIg8jzfcmHjj71wX54YqL71yYakUnrJ4MwXvhyLhAHAZJu9kDvRRacNlbpvajHGPd1clNgUl9nKbu1NHGwpvGD
X-Gm-Message-State: AOJu0YwkRQPlInIlY/ecP3YTFE2GIdhh21JuR0IqNUEl+tg5Ab09IYto
	Mt3TBuD9Q7ZLhdDLbaDu0gbPSaXXfisLoFJVdbRasS8isPQJ/q1ORbZbLZQTHA==
X-Google-Smtp-Source: AGHT+IG/rAnEukBAzI2bnWUEZo3nkrCfOIU03sX3YeQH2JHev4ZrCkeAgEfzwqzVu3fW34UT14c7uA==
X-Received: by 2002:aa7:8c45:0:b0:70a:faf2:1764 with SMTP id d2e1a72fcca58-70b44d3a3demr6367450b3a.3.1720595357318;
        Wed, 10 Jul 2024 00:09:17 -0700 (PDT)
Received: from thinkpad ([117.193.213.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b54ebce29sm499353b3a.45.2024.07.10.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 00:09:16 -0700 (PDT)
Date: Wed, 10 Jul 2024 12:39:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Tengfei Fan <quic_tengfan@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: qcom: Add QCS9100 PCIe compatible
Message-ID: <20240710070908.GA3731@thinkpad>
References: <20240709-add_qcs9100_pcie_compatible-v2-0-04f1e85c8a48@quicinc.com>
 <20240709175823.GB44420@thinkpad>
 <1fafb584-fc49-45be-a8a4-4027739eba32@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fafb584-fc49-45be-a8a4-4027739eba32@quicinc.com>

On Wed, Jul 10, 2024 at 09:47:47AM +0800, Aiqun Yu (Maria) wrote:
> 
> 
> On 7/10/2024 1:58 AM, Manivannan Sadhasivam wrote:
> > On Tue, Jul 09, 2024 at 10:59:28PM +0800, Tengfei Fan wrote:
> >> Introduce support for the QCS9100 SoC device tree (DTSI) and the
> >> QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
> >> While the QCS9100 platform is still in the early design stage, the
> >> QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
> >> mounts the QCS9100 SoC instead of the SA8775p SoC.
> >>
> >> The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
> >> all the compatible strings will be updated from "SA8775p" to "QCS9100".
> >> The QCS9100 device tree patches will be pushed after all the device tree
> >> bindings and device driver patches are reviewed.
> >>
> > 
> > Are you going to remove SA8775p compatible from all drivers as well?
> 
> SA8775p compatible and corresponding scmi solutions for the driver will
> be taken care from auto team, currently IOT team is adding QCS9100
> support only. Auto team have a dependency on the current QCS9100(IOT
> non-scmi solution) and SA8775p(AUTO SCMI solution) device tree splitting
> effort.
> 
> More background and information can be referenced from [1].
> [1] v1:
> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/

I'm aware of the background, but what I don't understand is, why do you want to
keep the sa8775p compatible in both the driver and binding? Once you rename the
DT, these compatibles become meaningless.

Waiting for Auto team to remove the compatible is not ideal. They may anyway
modify it based on SCMI design.

- Mani

> > 
> > - Mani
> > 
> >> The final dtsi will like:
> >> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/
> >>
> >> The detailed cover letter reference:
> >> https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> >>
> >> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >> ---
> >> Changes in v2:
> >>   - Split huge patch series into different patch series according to
> >>     subsytems
> >>   - Update patch commit message
> >>
> >> prevous disscussion here:
> >> [1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
> >>
> >> ---
> >> Tengfei Fan (2):
> >>       dt-bindings: PCI: Document compatible for QCS9100
> >>       PCI: qcom: Add support for QCS9100 SoC
> >>
> >>  Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 5 ++++-
> >>  drivers/pci/controller/dwc/pcie-qcom.c                       | 1 +
> >>  2 files changed, 5 insertions(+), 1 deletion(-)
> >> ---
> >> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> >> change-id: 20240709-add_qcs9100_pcie_compatible-ceec013a335d
> >>
> >> Best regards,
> >> -- 
> >> Tengfei Fan <quic_tengfan@quicinc.com>
> >>
> > 
> 
> -- 
> Thx and BRs,
> Aiqun(Maria) Yu

-- 
மணிவண்ணன் சதாசிவம்

