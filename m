Return-Path: <linux-pci+bounces-22181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC799A41964
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B9D1658E2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 09:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE62441AA;
	Mon, 24 Feb 2025 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vfYNav/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC351FC0F4;
	Mon, 24 Feb 2025 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390185; cv=none; b=dR+AYaCPPNU4XF1CChQkl/Td6ZMQ9MQo2Z+xw/yLTpvJl918VfOeBDDa0HeXyN3PQt0nGJKYlmGyuGoxmZBGevBt4aPSaD1Apudj4BsmBQxweau91RqwT/oNS/T9rwJG3ev3iz8/trnc7BzlRjiUIWYDSKI7PT0PEGMFS5XOshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390185; c=relaxed/simple;
	bh=lxqgOF1ZhoYIXuX/0fxFJp07HeycFTqZothiNPwnSTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKbYb2BK8HWhP5m9xHiUWqLikycHSXyEpPYuNBGnNXidZ7OlhRPLrU3cLBHCluBPNY6ScN2h1Kl4o043uvfOYhFxXPgu/ABFHUlRPMh6/mkvXHbQYf+/8nK6uhXuf8iFqwBQd9lYNvpxIMqX19Cs8/bTOi+HtwK5T/vbwbQHWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vfYNav/m; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740390145; x=1740994945; i=markus.elfring@web.de;
	bh=uHBg+ePOHSJB9KHaz4liJoqzPoMxYv+wyDTa26x3YuQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=vfYNav/mq6xNNzn/95DcvY1TpiZGdOwFXNF3g/+0vIu9ptyARKJXOQ5daHSha7Nn
	 j/Ai3oPFBTh9AqLmzyJQYXOqOVsFZzaglIfTSvieFuk+xSa2Guogxo81+2rxw2nTY
	 SNup8DWfSIdvTRkoE9Wvb7qQsHCxFn66hYDvs3/+G2kNiNUZRFXqf1/nq8cp4Jade
	 qjQ9WTw9cQC1aaJlHKKd6djRohoYRm81wJXDZPsdjnkXF9bn9BXjlAB3jrBMM/Z28
	 rtKEsd4w/bipRh08lGhehAfaumlmbW4I4CvGhuUtnz5+vjhqX2iUwUy4LS4tyASnF
	 VyOD/E5wXV4wXrZz/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.37]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBB3s-1tatsE3t5q-00ASD6; Mon, 24
 Feb 2025 10:42:24 +0100
Message-ID: <9e4db8d3-a560-4717-9acb-28380bb4a4ac@web.de>
Date: Mon, 24 Feb 2025 10:42:12 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
To: Feng Tang <feng.tang@linux.alibaba.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Guanghui Feng <guanghuifeng@linux.alibaba.com>,
 Liguang Zhang <zhangliguang@linux.alibaba.com>,
 Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250224034500.23024-3-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OPpdk+sLLrMg6zAlzVKX+Cl4pyarlSzNyi+67QIXgGSbutJYal7
 FRESIc3h7kZX1wsZ6sLM1Xv5G6Uq2ujLfV2GL/ts6P+1SRmU1CNzgANmRKAqV3ZEgEwgBu5
 0V2ShZdPi95EX+kZ9KA7Gs5r+JQPUi39ztZcOg9mbHFbObxY6zKQywHNz1JyU6ITX7V23sz
 yeczhkfPSCqQKQ50p5PJQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F1tVVTmsQ00=;x+SbiSvXmhGsZK8b3UDpipPqKAi
 Mct8jsFB6D6VvvZU1s0Qb+gCI4qVIGxJ/rhxzwSnc+X7dZfvmTg2dlN7WonKYPfD3Am9OPMv1
 r6Ii7XqD6pxlOTTTI7RKwcOvVx3qg7t1hj1WHAMRWvx7OXilusmHTHXVs0xYUyj2ZUSP1Uq6d
 nXw2YqkJIkULfPeSh8Kn/3HEzlpJkHjlUPoyIjwot9IaB2SQrOP8Dt7POQTdvAtuQuPJpg3fY
 Okv6eQ+Nxw4/btuv39PK109eQBMallAheWJKKkranyRS4E36A75keQv6Ij+kSww1ujPCGTBMx
 fiERzIHnO3arkd2qlmPfSApSTDsLBpYFnbuTvFtbdNNXuDSuY2h84rptkwBhfB6QuGPeCN0s3
 w9570Stc5AWPDocA6SPuZWFfbyG1mfQVji8c/ErxknPN8Qie6yTm9ZZStMKMk+0uUgIDu1TsB
 gIhFROthvvzw8QGTMtHepXYi/lWz0mkuMMUrnAw2jmqhAjyfJT7IghGkiuRcnH1r7PWn4PWYz
 I9BuB0T/EEYSBOgF5ija67WhbJn6lcAxWTFxAuCKhyW0W3SQHbfA5L1L8J/zspELon8NhH9We
 fbwzViba+0RdFIpufBpwHGYpm+wSknQ+HwuINBYnSDfmE+S+MjparqTm+sXeDwmFA46m6nMBu
 dwxsoNVB+bGhC4+NUyP54vZmeijsBVAnJBSWjHc7iMOLb8B/457muLYuivlhODnHKMu8vbhw+
 VyI88dWscr/276uf0k5n2y0cFzGwHwdH7u3RDlylTb+xwOtWBTTKsyFSu2zX21QEICZe0y7gx
 hem/Wgjl1aBYOyarEHAXKRP14E2TMwmoOhtSuZYm/MnOK+lESKfdKBGdeyJOfCOYuBUVPmIdf
 s67rwZa89ix+EaxNm4m1pDcwJnebqxkewU3yo5UF+htYsMUXdbEMflpHkDJw7NeSJJciGWhmH
 6iOTtMHzlVulNjRPacN8A8ClzcVbDgWYMDHgP6aGLDUfBnypGQ7+Me7lBtK8NxyYEAmsQFZff
 Qrfc03+du73Rk+M+fsyiO7wDPEu/YxgXQS4m3uBcCVxdWC/c67iD+RDMoQ0n3nGRBaj0js3wm
 wGOLojfI2AHlDq35b/isZZRHJ+yRMhLph8F9S0C4Tw3lRJLtuvcrOIigIs0rb0i/VhzZWYykG
 SE8/A/dAV+8I797kMli0Mts16Bl0x/AiocHkXVzvJYNaWvOon4+RhoU2nP+uV85dTL3sIluUY
 VuEhP5nYyFK3TtYGfm29KahFiGMA7fcK1Rqq6WtE5dOz5q5081tae8kGD1pXOd/PRdgydpgIR
 TmqVHHTpLbLlrCOD3lmEBOZOC85G5m/vPm4eZzUewZ8esZZjBu+fpKK3UfKrmn5Jf2/W3bze/
 qWn9bP+4OFF9BGwXJ2hUK5haFjeZ3HCevHXw4Oon1obOxPXNvvEr/MlOWSWppGkco0tueLA11
 CMorCIA==

=E2=80=A6
> work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
=E2=80=A6

                                   specification?

Regards,
Markus

