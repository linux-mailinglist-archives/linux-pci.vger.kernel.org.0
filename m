Return-Path: <linux-pci+bounces-8740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5085907768
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 17:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D04F28964C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9814A4DE;
	Thu, 13 Jun 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LNJUEzSR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455912DDA5;
	Thu, 13 Jun 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293406; cv=none; b=I1kun8vfRtM1dN54STzywkmqJVTLBDXqr5fwL22p+lPYAfD6Nn6BcGkRQNE48FjLkoMSO+NufQ85Gl/M/r+C/cY0mzCWvBu3+LSP3GGR35E/8/U7JiZJhu6koXjPbkA0R77FKCNS2i++C6+3ir+BkPL5XYnr/P94Mvf/v5A76iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293406; c=relaxed/simple;
	bh=wuuRkupuSyLIHDwx1qrL9wK/w/CgUGVdFcSsUcJNGkQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Lpet4EW6gdfIFQDk7vDydkS6wG6HfoviHnNEII1htcWrJsMVgytC1+E6eMN78Ha/6a90qglw6ReppMKV70iWRIYcsrxk7w1hKPKyng4ufP+vmYS+tdoi45/aeGhf4jHMlWI63dm4bZ5cC6+Q9VeOp6e4yizfko1yXNpFZ9zWmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LNJUEzSR; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718293354; x=1718898154; i=markus.elfring@web.de;
	bh=7fcDu+jAjKTUeYUTcm6nT/VKOpL7/vLs7dIgrQeJffo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LNJUEzSRtJ4s9iQHbH54cTGy1ouN6On874yZ2npBiEOFY80pZZFA5tks18EqHG01
	 wpyeWVebam83eYtPIbbhzsqU4M0oxyPeFJgk3wHCrlejS+gA5I4d2Y1i7sfV5o10V
	 XlYRG4zqLm9rdcnQK9P2axqomSmoMu+D/zj3o0yfGLp8ILJ+ZbAOdzdwK4C9ZGuL2
	 AtqncLRaSFxzliD9iTwV3tyZw+nwz6jOO07W//sYkqmT45mSJ+ZMQMIo6a8u5zfrX
	 GdMOYSuWxiB7YGYH1AFdkvXoTVJwk1dZFNHi3fpgV5CwxEf+O0E1Nvpz/00sChr6y
	 KvUj8oSD0htlRKLcfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlbHE-1shnjs0jC6-00gPUD; Thu, 13
 Jun 2024 17:42:34 +0200
Message-ID: <531fdbbb-486d-4207-b9a9-3db23935d583@web.de>
Date: Thu, 13 Jun 2024 17:42:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, mhi@lists.linux.dev, Bjorn Helgaas
 <bhelgaas@google.com>, Fabio Estevam <festevam@gmail.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>, Jingoo Han <jingoohan1@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Minghuan Lian
 <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Niklas Cassel <cassel@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
 Rob Herring <robh@kernel.org>, Roy Zang <roy.zang@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Srikanth Thokala <srikanth.thokala@intel.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
References: <20240606-pci-deinit-v1-2-4395534520dc@linaro.org>
Subject: Re: [PATCH 2/5] PCI: endpoint: Introduce 'epc_deinit' event and
 notify the EPF drivers
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240606-pci-deinit-v1-2-4395534520dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jXSJJJkAI8hN72kU1CJg3ufojWOHI1sFKaf7Q+GXWoK5SHvixA/
 yrxpcO7iG26yVIJ6a+gDgi7IQ7X4UOlJm7doH6z6KQ09CoTZ4UXvjGVgP4qYQDw1TnsDnm+
 QVgctN2V24QtpAjdxg0dM1CAxHvdlatDjFFXPjenuaogsqXyOG9yQTvPPKq9AalAtAN4qQW
 hD6x4vYrIAaZEEVGxiS5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PH53anvoYOY=;1/zV0cxQ7tZhIjrtlZ44ElZLM8Q
 i/dBiizYx2JrGEKiG8sYkKHnGA384j5aU9TmG7r2D/cFkSPs/yZ0hmPDsuuelZSGCyHWZiRN/
 oNO+wiyJAPxbMYILm8U3DhPAYJNZL7tChzi/zsp8B0Ib4ehYO2iwpmrdONugRbU5TIwAWBAtt
 O9Cd1boR1HzXoKsuicQTXIRq42M0q+eeFrw4gHvF7+yVAWOODfM1RkDrMF04xo8/hIKWasMLk
 GLOKEfJgm5NxvmR+h5J9rmAG2o7PdDilFFAtM4F5qG6niMNgdlmc8tMSNXWrTs5X7cNbolLND
 GdfeoqXQhgszfzzgCYEC62hZsCKBPBLGFLk9gcEhQVWbhP/v2X6XcVwAwDTXagzQG1eRcaHvn
 XWChBhxQIPWZJTDfcqUXc/ReGClUJqfuh9a3fj2HR3cYwKXHsMAM/0++GKDTGB3YK076k1DP0
 016ihg2akVY+zAqRjQdKi3POQKULjiiULpUCYLnenqi1xkm9viAf2ME6hMmoNZdCrIW2eUD/L
 rEUUeKzuOB8gGXnQRywfc80Ounpdk42bjy4Spto3HpGg4b7ifudicAAzYTyfh+SXJQCUvKj2t
 a7wk5vPHw5S0wj9yOnCqxHesNBoirF69BTsUr66isiVPFDNjClzWomn1oCL303/nqyRZNFdnv
 UgbgIsRlXrUrB/UeMXpqN7c5K00XBixFRFBL5uLnpnFMlrZhtjCrFqooazZL0Of9zEvxbrkj3
 vDLGyltl4po3ybGUSKAFLDQ4jpbUG/r51SqZRAar3YCVovQArVWZ6ze02zV+bOiJXSkPd5VUW
 WMUlYtj68L5PQjuICaBMLKaGnwzPX9n/SgmiEdAohcyH0=

=E2=80=A6
> +++ b/drivers/pci/endpoint/pci-epc-core.c
=E2=80=A6
> +void pci_epc_deinit_notify(struct pci_epc *epc)
> +{
=E2=80=A6
> +	mutex_lock(&epc->list_lock);
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		mutex_lock(&epf->lock);
> +		if (epf->event_ops && epf->event_ops->epc_deinit)
> +			epf->event_ops->epc_deinit(epf);
> +		mutex_unlock(&epf->lock);
> +	}
> +	epc->init_complete =3D false;
> +	mutex_unlock(&epc->list_lock);
> +}
=E2=80=A6

Would you become interested to apply lock guards?
https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/mutex.h#L1=
96

Regards,
Markus

