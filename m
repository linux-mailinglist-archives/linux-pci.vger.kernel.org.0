Return-Path: <linux-pci+bounces-37903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EBABD3C9C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DB218A09C3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9F325487B;
	Mon, 13 Oct 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="nJwGHJDK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3207B21930A
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367071; cv=pass; b=sf8p3q9fZkH2lq7ytrQ5oQoKtcXu7MmtWqgsPIkMVHmyppFDyyNg8f96SFJqQ17bAkGnUpdBPu4/MB+/fnRxUIWCo9hC3GxkeApcklFDZO78JfRXB5O8czw5Rqr6c4WQnrs5dIDG+9bPDPxkJpn9/x4t1J+h4Yhe8RaJ73ZM5xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367071; c=relaxed/simple;
	bh=8KIsJP9mxbiICkiBtPit2FbzNbebVbwS4VRxvXDFcTQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mf4Y39w05ccWKusVsd7iXb+q+tVUppIBHqjabTPRgD7NCbauYO3OCM3awzWSlTqoYKS5WaWVW2Mwk4jOzaAO/ZvXPCCYoyHQFXMP9KPmiTcg6DB1OfEGD4EM9bmj2H4YKzccHqD0ecJUqsSqwDZETAPka8Ohf43ORlXlF88s6iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=nJwGHJDK; arc=pass smtp.client-ip=81.169.146.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1760367034; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=quL2bNz82NHMBcEMb3CAyFMhSLOo6WKJnqAt9pYPhNfiQfBho026+YCzafA9Za6b8J
    ytV8rq97ahBomBTHu/u46LE89Cws3qHqpP0IDX1VnEG9HaDtXrmuVS5Uer+QyQ7YZqfj
    fvaVdEXf/5ozgIlobZ/vaGfOMArHGNdxh7Bpoqc+LJHluu7KHWA9zqONDHxTv8MHL4We
    yswqjUx4mWHF/+r2x7+5Kv7QQfWYLMP2hJgC1ADJavEM7G963DoDTveUKQZ+fNAd7h/H
    XzRzs7cGnsEq9MW5H59GMuuWqxaC4s2xTgFpc795r2zdsHbvk5FZPCjhmCrACZFxfoz6
    FI/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760367034;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XZNOQWLvzBZ1kzkSz/b7ufcRpOTiV3AKvaULngWCBdY=;
    b=k6vKgcib9N1QX+4jM24U5FIr4hJFPHMQz8SUUUrKFeQiWyodOWNd8j4tKg4Yy3NqTx
    VrcppEMbc5fRGbOnRMvHwGICRRLuRDTi2ZfG9HrKXvit3WOtL2XeLZC6qNZBgqHhB9aF
    tQvaPt6dovs1+zEVhtSZrHbznroq0a9wy0TgfWWulcz04cQIfNtuZ4Lh0ZOdACx4cnW5
    lkpPQe2qtO1oz2bIMttYAZnemVkG4bxAIK8Ky43mVNKyepu+xAQWiTilfJwSixydnHMs
    hbItX64Q0oC255qvb4kKMptwX/8lmjITJxQ40+p6tWkuWu8QCRrdZ6xBmOZpJAsGBFVn
    doFg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760367034;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=XZNOQWLvzBZ1kzkSz/b7ufcRpOTiV3AKvaULngWCBdY=;
    b=nJwGHJDKgr8OVZA1QIatz+VRfVv8R+1aif97R29lLIbJkFHnyxW7ILclsqqDsYUgDe
    DPsuDrL4GSsaoITgznutois2ryXE8/FaUdn8AmOsrBLlSklqSDEUbgi3wbtIGw+eAH46
    B+Scclm9sGZuyD/cIYIbnOislgmGpriNFp5RkU4H8Z0oCIRexAMYp3p+iKW24DzaSYSu
    sl4KkDuxJ2eO+IZEgFxAPaKfiY3Xo6Lm35/V0ctDG8BtMmC23cTvxcgL073MNl6YYjN9
    Gi8EXsOYQAkATomMWWbe6192v/Vr/S8wqHavsbSku9laqlyr8LiW4CVQG4fgHR4vZsyu
    Wl3g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIS+m7hvg"
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e2886619DEoVPNv
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 13 Oct 2025 16:50:31 +0200 (CEST)
Message-ID: <3fba6283-c8e8-48aa-9f84-0217c4835fb8@xenosoft.de>
Date: Mon, 13 Oct 2025 16:50:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <info@xenosoft.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
 Darren Stevens <darren@stevens-zone.net>, debian-powerpc@lists.debian.org
References: <2E40B1CD-5EDA-4208-8914-D1FC02FE8185@xenosoft.de>
 <7FB0AB81-AD0F-420D-B2CB-F81C5E47ADF3@xenosoft.de>
Content-Language: de-DE
In-Reply-To: <7FB0AB81-AD0F-420D-B2CB-F81C5E47ADF3@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13 October 2025 at 07:23 am, Christian Zigotzky wrote:
> Better for testing (All AMD graphics cards):
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..e006b0560b39 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> */
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>
> +
> +static void quirk_disable_aspm_all(struct pci_dev *dev)
> +{
> +       pci_info(dev, "Disabling ASPM\n");
> +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID, quirk_disable_aspm_all);
> +
> /*
> * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> * Link bit cleared after starting the link retrain process to allow this
This patch has solved the boot issue but I get the following error 
messages again and again:

[  186.765644] pcieport 0001:00:00.0: AER: Correctable error message 
received from 0001:00:00.0 (no details found
[  187.789034] pcieport 0001:00:00.0: AER: Correctable error message 
received from 0001:00:00.0
[  187.789052] pcieport 0001:00:00.0: PCIe Bus Error: 
severity=Correctable, type=Data Link Layer, (Transmitter ID)
[  187.789058] pcieport 0001:00:00.0:   device [1957:0451] error 
status/mask=00001000/00002000
[  187.789066] pcieport 0001:00:00.0:    [12] Timeout
[  187.789120] pcieport 0001:00:00.0: AER: Correctable error message 
received from 0001:00:00.0 (no details found
[  187.789169] pcieport 0001:00:00.0: AER: Correctable error message 
received from 0001:00:00.0 (no details found
[  187.789218] pcieport 0001:00:00.0: AER: Correctable error message 
received from 0001:00:00.0 (no details found
[  188.812514] pcieport 0001:00:00.0: AER: Correctable error message 
received from 0001:00:00.0

I don't get these messages with the revert patch. [1]

-- Christian

[1] https://github.com/chzigotzky/kernels/blob/main/patches/e5500/pci.patch



