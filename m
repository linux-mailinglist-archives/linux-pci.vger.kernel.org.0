Return-Path: <linux-pci+bounces-16452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2C9C42FE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 17:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A62FB2BE9E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A201A08C6;
	Mon, 11 Nov 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sN5xcHC1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E0219ED;
	Mon, 11 Nov 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343659; cv=none; b=B3bROarbcS+lsDP6KNW+5zvgCTcif5/d13DFJT3ueKMgJPfaLbBCUlZ0SSmQ3QWrDGDo7d02IeVdGSXt0txnQ8zu4D9pSWAAKj8cUU5MAAJ+ZToCcGUzLslqs05a+LwcJrQIYkJCQGmq/fdtBAkJgrwhZxVROKV9JaXGQYtLnXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343659; c=relaxed/simple;
	bh=idA+filDyPw3rtGNLeHXCP5Utn3MX6yIIZNPSx5A+u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abj4goq4osx5eKDBxkuuXND8pZRG83uZ3ryFV0WPljeX+pmfAmx+ojsYvcq6i6/wxzRCqfCKDSE0FNrtgEosp44MtlleAYS8f0Jku7O+A1LEBJkcI1orZpiow3kWq0Soh8b1Vj5Okwqx/KRvWT3jdIM3nrc0N9K5ftCyk01x1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sN5xcHC1; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731343601; x=1731948401; i=markus.elfring@web.de;
	bh=cR3QyJUDLLs7/h5/e6FjiBeq7j2PY8VaCAT/k4+iCdM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sN5xcHC1p9U2jTSsVdQHZFMR+gdNUwrKFVJMHQkCiahxzmRx/zpa53jw/g8MzM6z
	 VfwPed5XJxOcCG9hg9tuJbi3bj/iDk4hPTDYyS1s9U5HCbCcrYMSFclsAn7dN6JRC
	 ID8S4qWHfL9HDVwnxoHLMWhRXrgbbO1SpBUSqYIzybP+yT4FM1Zh26lM7p0JvqAKT
	 WGC3RwCUvOqrrx9EgUIQsFZyA6qVHYS8ES3H9O+xiIumJKGs8PZ2QurP9sfkMEveX
	 qmlmuY55dPB5wwFFZGnOtmiSFR4uFTLu2D2vI40YYAGWF5PhY2X2z9qi2GGMj7HRS
	 8mWbW/Zkjqev0QAmSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBSB9-1t4jra374p-007lpA; Mon, 11
 Nov 2024 17:46:41 +0100
Message-ID: <4de3c1d4-2488-40bf-8089-9e2246dbf28c@web.de>
Date: Mon, 11 Nov 2024 17:46:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Kevin Xie <kevin.xie@starfivetech.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mayank Rana <quic_mrana@quicinc.com>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
 <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XXNAiQrUrh6//MXhU3j4k3pKsMLGkFEvqty0RCywRPATEOyTvqo
 ET1k0UvALQijmwqey6UybFbvck+riq6miQ1MJ4M+8I1qbnlq8tVfL++OP6Z4RawqKqDT009
 d8pLZUP4pvBh4CYtn61FnQOeUtiIwQis8LaHepOQzEOYndKr7f2+fbu08YxqUvKlLuyUbSA
 IvQ0WJorO5V3AIlhrMX4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oiGROT6BuaM=;G66i91LWLcSs5d57EmCBu0dTi67
 p/EQHJI0kcV9pLPqXDEZADzeyRV/MoGCkz6U7CBsZHTP454ZJa62qchSw7F3nALtds9eQXwbF
 E8lcEGFeZ+7kKGExx0rqitm8Ba+tq/jZ4FT372eLsMtF7UXOxUOOwfeauVi/+XpvOUZtcdfr0
 icdaS+FIxnCwG9WO4wAwdO04nAzJ34D6mEUNs5cBYmeJ2K9ZRKIlTn86DpHVgVm0uMCkRbKRc
 LnrGosSa8+lzCC2J0aoprjRk1zH6RVFlGx+dXeRj1ZsCgNufuPQruUvCGIeAx573n6utgAzuk
 TpFHsXbJmdfMxcjzZ+BEZtsBOolZCLRhvcKqGEKnNVP/s7E7kB79m2xs3ZylIBZZCmW24ccy7
 L01te47jEnFzpfvOGfdZp9+PtKlaySCieGrenQNKBOt4ZROpQ9hC7ErlFx+XKiOnQGQzIIjbi
 RPBVPswktXSx6fgvCTCXlZ91RJPDbxcJqEBOYLp9roE7KmdvpudX9rsqAEkpGFnaWRVeQ1CS9
 d5yHhzTV/82iuLiq6ojK5IPIznVqXIfJm5nvZnsS3DLiX6/ZL286MRA4x1lU42mAmfIayYi0h
 q015roYrypuwAJzNJIkITrOVgpvfNpuu9ykNl7ev5IfIutzLMJbarfhSfkgJhgkugAYDIyz/l
 xz2ZMaeqhK3Igd9f14LYL7VSqQICrTFSD+AmQpAQRSYa7tcNLKPfAajC+vnoW4+0czUhbu3zb
 c7ZZd2snFsq6vd78BZtjazSUuxzbkgQ3pjh0T6fiNCcSzw9ki/fGcGu6EPcClOHvUMGTLxVPy
 kTAnpcndze6EbnjranBAmeB2K9heTG7Sr/7JrRxHPRa3qX/E+/HAqarl+cAM+WueUYmlxD+vI
 8REQfYVFEFNKSE3+7dwJrBfdrPtTOR5uJRypEvYR+a5Y2vmxqegnk+wVY

=E2=80=A6
> PM framework expectes parent runtime pm enabled before enabling runtime

               expects?                PM?


> pm of the child. =E2=80=A6

  PM?


> drivers, before calling pci_host_probe() as pm frameworks expects if the

                                              PM framework?


> parent device supports runtime pm then it needs to enabled before child

                                 PM?


> runtime pm.

          PM?


Can any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=9CCc=E2=80=9D) becom=
e helpful for the proposed change?

Regards,
Markus

