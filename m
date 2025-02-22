Return-Path: <linux-pci+bounces-22116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F1A40AE3
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737281896B94
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C2E1CB31D;
	Sat, 22 Feb 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGhLuHTR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C699E17C2
	for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740247572; cv=none; b=Oo2i41UGx9AElFw+JiDONqQXlTl+ss2SDEMXJ2GQzqhgn6ObYTSyCRTDsmD4V3pLQ26DnRLt4lAf2oMHfP8chUcDpNCxiTXVyc9wq88WfsT+2fjg3fykWwhSXgWOpDr9icFytpOBygywMfIBGOP6Xb3ku/w0SccnhSdzIoG5wow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740247572; c=relaxed/simple;
	bh=FQF0zy8qlXGv9Mqx2ywcQ8BxUIsSVaBiY1xMdAlqrVk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TWYO5yur5bXChFO4W08cq6OTxCEKIzbFF2Q5DO0QAgQAW6ef7jFnBAVDE2GcJS3+zX5VqjNqUwDlImrWn0eG9o+h1X+maCQlyx1ag8n6nqlr4APQvvVoVZtpGzspR25hFn9ln+AFs+VXiYJuuz0UGmJN1KJbbQS9+Qj4oW2e3fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGhLuHTR; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so30707131fa.1
        for <linux-pci@vger.kernel.org>; Sat, 22 Feb 2025 10:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740247569; x=1740852369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+ptCXSrS2rc5c3pcWEE42wXEHibivbsgwYUANT2TIHY=;
        b=EGhLuHTRikjLO76eAMphHOls4VAL1/db1XDJq0Twj/Er9GH8UtZhC9bp06ID4WQHvS
         kl3+00ETZ/pxKP/p/SuC0kh5ecCp1UmrsUwV5k7xK21TjwAPfpKxRhvU3MWn0TpUxva4
         QuoLtCZdOtG6VaHMSYWIUe/AXbWMsF7INEXFLoqiL019sJyAaiL3GfknImwkDSM4EksE
         ED3xY7mGsW5xqLVtmtN04cFOjRwodLcvdxveBUw0J+7Fr2/xZCDa8vcWFy/N3qDRQyNP
         bhGBbPke0CN9+DD9QDV/70XMcwuOyq2uovlYxGHie+EbiLcifx52pZqXH8uFzYvseEHf
         Vkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740247569; x=1740852369;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ptCXSrS2rc5c3pcWEE42wXEHibivbsgwYUANT2TIHY=;
        b=TCYePwhpX1nK2LxJ+Sau6SZG7HaVHY1L2YDRY+KJHTOOnVDuMypYOs4AroIDCy39HH
         q+kqpJFuLUj0nS+fQHYirZkGE6Ld+kACj2dkpIIvzBV+BHvIhdz4zH8JFsuCxcf2yqBl
         f8+m0d589vxj3ygL9C2CspLzJomnGkd1DxXlHQSpv2MiJkWjPhqmIInwb2iaegVs18J7
         sysxpyee5ZTdzPO+CuQS3wXkO+5YI/hyTIDahsEdFLOpGkHMb9m88WD0pk4QdYha9TJW
         NHc0X3rjcXHASNab0KeHkdIJErLKbPkURqndz/9eLg8VcMe2kSwVZMu9HZyiXkW6DGog
         JfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIeDVLX0I+UOSk+A4lXYlSwlM/R7FwA28sBlZ3rWiKLhX5jQI2frbcBADwkJ6XGr67wH4zBhxjkWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFnkEh6wKPrdYq9goSk+LiNBbZqT+Udq6RoGWTZ6NEocRTqh1
	q3HpnpTw4gw+ynu6BYmisyWqGC5hkwvD1SRmvV+Sz2Sb9gi9Juj1a2GrViQ7Cjg=
X-Gm-Gg: ASbGncvvTt5CJ1rQiQRsMglJAQGG2TdlFrXSLC+lJFNEXEM3ejFPj3sJdAFg5yzMtUr
	6gd1ws9FhINpB2Ibo48MD3SRqiq5zKj6fbKaEDo4YaxUAMQcMdbQtgDc/NbZU1Vnh3D7V3ko2Vx
	xDaaEPs8/yuUwQqlwKch2GllxOdIPJAbIveTjAaMDsA5nW5H4fDUyH1751VBLztFaaYCwfz/dOy
	8DvFb3mpbxeOwj+i1xH8QUriKDmwLMyboHmC2DC9KoUIB2uGUKeHXN2rIvuib1kLE+9ocX65VOM
	OzS2KfnKTlehIFSWdcTNsIQv0K3rl6WF/bnEE5A/hFqVaDpQocRKLcqXdAPORxn3PwA=
X-Google-Smtp-Source: AGHT+IFuHH4t7YWCgSyBLUYJzsjGo7d47zMgRWheMIJmhTrPGXmALd9CB6gZDWdst3jZ7D9AiVh6bg==
X-Received: by 2002:a2e:7d16:0:b0:302:2620:ec84 with SMTP id 38308e7fff4ca-30a5985e0b5mr23185791fa.7.1740247568863;
        Sat, 22 Feb 2025 10:06:08 -0800 (PST)
Received: from [127.0.0.1] (85-76-164-67-nat.elisa-mobile.fi. [85.76.164.67])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a25e60982sm23015091fa.83.2025.02.22.10.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 10:06:07 -0800 (PST)
Date: Sat, 22 Feb 2025 20:06:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Mrinmay Sarkar <quic_msarkar@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_6/8=5D_PCI=3A_dwc=3A_pcie-qc?=
 =?US-ASCII?Q?om-ep=3A_enable_EP_support_for_SAR2130P?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250222165038.eyausqiccrivkv5t@thinkpad>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org> <20250221-sar2130p-pci-v3-6-61a0fdfb75b4@linaro.org> <20250222165038.eyausqiccrivkv5t@thinkpad>
Message-ID: <48B09581-F4AA-4196-8445-1E02041915AF@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22 February 2025 18:50:38 EET, Manivannan Sadhasivam <manivannan=2Esadha=
sivam@linaro=2Eorg> wrote:
>On Fri, Feb 21, 2025 at 05:52:04PM +0200, Dmitry Baryshkov wrote:
>> Enable PCIe endpoint support for the Qualcomm SAR2130P platform=2E It i=
s
>> impossible to use fallback compatible to any other platform since
>> SAR2130P uses slightly different set of clocks=2E
>>=20
>
>Still, why do you want the compatible to be added to the driver? It shall=
 be
>defined in the binding with the respective clock difference=2E Driver sho=
uld just
>work with the fallback compatible=2E

Well, per my understanding (or according  to my feeling) different set of =
clocks means that they are not completely compatible=2E An Ack from DT main=
tainers supports this=2E

Moreover, if we were to declare fallback, which one would you prefer?


>
>- Mani
>


