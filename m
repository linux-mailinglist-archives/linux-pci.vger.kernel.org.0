Return-Path: <linux-pci+bounces-19216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0778A007D5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 11:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC67A1BB7
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA151F893A;
	Fri,  3 Jan 2025 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XAUlK8Xy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B0917BA3;
	Fri,  3 Jan 2025 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735900164; cv=none; b=XzJl5wLV62xL0pr6cvKTObpyO59afoz3R4SOogXmpnOk2Hbmhf3jDIb17V8dA0VzX7czgMhzjWf2foqs/SSGkXm3i0EO4oZnU8QUtxIDk09DwthUldfk+pm8FHq9WQIZfU4vECzuu4gv2iAFcVO5+cPZZp5YX5cdHuQwxRSKdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735900164; c=relaxed/simple;
	bh=ak0q7tuOzVhCNT9bkU7Ws5dKTtwuPeO1RENfqpnaySM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Q4/tfObDCmRnJHu8vfaYPIfD4RtzYBflKJm9fxeZFDd/D/TkK+9fhKZJIbxdS+W9/LQFCj/RWnGq43ALQuy0ZZTSKgimEa0fvoW6QJPI+ou+0TJqrmKJQ6ST9L1TT9QCNbTvKQbYmeepGRrmqoF2Qk5L5C6NkOMWwp/ZbnQVE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XAUlK8Xy; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735900125; x=1736504925; i=markus.elfring@web.de;
	bh=ak0q7tuOzVhCNT9bkU7Ws5dKTtwuPeO1RENfqpnaySM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XAUlK8Xyplrey4QUFb59VfiyhLMCH0ZH48L2DgjhUuYYgziL45GZyFE8Z7LV37vM
	 3xlCzTaqy8NeDv5ft0WPWnuenGGGLJCJI02YO056elomf161u31xdRvRwZFYR3UMR
	 UStbyB75Zt2WwYKgn5CMaXry3+z7kr0cPf87qu00XfLbjDCYv7t1DxBNdN2cxy/cz
	 1es2MH2Tre1p3ApoTXvKeT+Et1CCAq3pVCR7ZCjZMK3N/GZCxJv6CDfgsQfIK+ArK
	 xApZG64v6s91yJkXVdkpmRN1JV13rv+W0wZNduFfSzvdpOdk5z5gJzgj66zsz9u6I
	 VkfofQkctZfRLcvg6Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.37]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCmT-1tpjf80rGB-00j96o; Fri, 03
 Jan 2025 11:28:45 +0100
Message-ID: <bc5eeafc-b6e1-4e71-8f7a-0f63c6130239@web.de>
Date: Fri, 3 Jan 2025 11:28:33 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make_ruc2021@163.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <jpinto@synopsys.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20250102093058.177866-1-make_ruc2021@163.com>
Subject: Re: [PATCH] PCI: endpoint: Fix a double free in __pci_epc_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250102093058.177866-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ADqmyXZzrqoEI69yTnPRSHrApyc0qke0ibuLbIWq0hNQ68DlGv/
 EuQpXR79OpUeBypPXOM6SNNHwYtSUY0RZ7MqRhVpl5wiC4fWmcSJWoTshZDD/mT85C8Z4xU
 P6J6ukICqA4hHxa/CQvTx0y6BsprUvWycJvxMMHPo9xJHMNVqCjj+UhAqX6ys1ZJgF6uetg
 +mWb8ZfgERn2gimURMbsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zLLNTpqj8JA=;hng/oeBi/xacoXIhsjVfeL5ujbI
 4StCbrpEuG8il0YXx/SekicBMOEyxUii93RBAkhK7/GSjGtczgTLFvOsf8dNt85/JyQS7srqn
 1NBWkEwFjXsPvPipkc3CUBFm+UmTr1Of9Bxo0U/rbG3m4OB1PRblUrs+5mytsxVwl2sWLBK5R
 uKpjEBMVO1QPHJ5Wy62OCL6BNXvjqjRrp5B/QZQKvdm4tsbqyHS/TUcARXSoABbpAC4GwT/3U
 /Y1GMkaPz3zTswmHUFkgcs5YU+mxQYElkk/YL4RiNsPgcVb9SgYbrAa1jQVxoLMIaXf1gwogq
 nzMJWxVK1Tuy5iVmgBHSsGEms0RgkoYP3vUzTirqaFaQOnKD17kXbh+8FhDJpHXUUsqxRo0we
 IH7HAQdpE+uFpOSSmSAn7kx7bZcB4EJ/5pOP1Ws5TuSiOBw3RUKz8lL2s/PJuDKRQIj0MlfKE
 w/lW/Sog1CiPm8LmbEqhWeuJxBNOadaCSm5KcpL6lN251uBe98BcJiz+PNW4wkokcNYs6GcIx
 bCOEOaIENQPf0rXLXyjKhx6aOtcJ3cBMDCglzcI4RmiBX04cuGtPvZq1ojkJOOjD4mu4/J8EV
 y3Mm+XkteJBBBqVkhRPQSduDW9Y/iVxY8Epq1Tld9qtUMYuffQQ+T1fQfIX49xKsdUWWaFP1K
 VFTrHbpw/Ym3SUF3c1xuNyvbtPdmnCGyoLzSnxgYPGYT0q0LI0jVG17YdWtd61P49r2zji5uc
 hRFmf6bFshAB1TlPuuj1av+J/5b0mfOIGWObPhJiyfV2bShpkBFQkzg2I3zF6zik8vEs4ybjv
 2HBMnfzTqw8FIYqG+X7ge2Yid6SlC3tp1ghFYric3xnUeegyVIP+QkGg3psfAtxlpWsFjG9oD
 kEdtstytf135q44NmPx10+3bH9cRLMMfSUQMZwtjWeeFqLTlog5glW8x319zakMEMBwnqwu+Q
 ESR6jADWyouJIkaORXqBMRwM+MtgZUUoXc8HaJ0RscYnPdXLi5FG1FVj0nRHvDWfvVagxOaoX
 L0jvPXtnQHHPK30VJIAsq/EWjJhFBTw2dlAjwBBB9e4N4b3od9drM0dpSq7zK8g7IKVHjDI3G
 vdujHxSPo=

> The put_device(&epc->dev) call will trigger pci_epc_release() which
> frees "epc" so the kfree(epc) on the next line is a double free.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.13-rc5#n94


> Found by code review.

Would you become interested to check how many similar control flows
can still be detected by the means of automated advanced source code analyses?

Regards,
Markus

